rm(list=ls())
library(httr)
library(tuneR)
setWavPlayer("/Applications/VLC.app/Contents/MacOS/VLC")

token_url = paste0('https://api.cognitive.microsoft.com/',
	'sts/v1.0/issueToken')
get_key = function(x) {
	x = Sys.getenv(x)
	if (is.null(x)) {
		return(x)
	}
	if (x == "") {
		return(NULL)
	}
	return(x)
}
api_key = NULL
keys = c("MS_TTS_API_KEY",
	"MS_TTS_API_KEY1", "MS_TTS_API_KEY2")
for (ikey in keys) {
	if (is.null(api_key)) {
		api_key = get_key(ikey)
	}
}
if (is.null(api_key)) {
	stop("NO API KEY")
}

hdr = add_headers('Ocp-Apim-Subscription-Key' =
	api_key)
res = POST(token_url,
	hdr, content_type("text/plain"))
stop_for_status(res)
cr = content(res)
base64_token = rawToChar(cr)


auth_hdr = add_headers(
	"Authorization" = base64_token)
fmt_hdr = add_headers(
	"X-Microsoft-OutputFormat" =
	"raw-16khz-16bit-mono-pcm")
fmt_hdr = add_headers(
	"X-Microsoft-OutputFormat" =
	"audio-16khz-128kbitrate-mono-mp3")
# fmt_hdr = add_headers(
# 	"X-Microsoft-OutputFormat" =
# 	"ssml-16khz-16bit-mono-tts")
ctype = content_type("application/ssml+xml")

# script = "My Name is John"
script = readLines("script_zh.txt")

synth_url = paste0(
	'https://speech.platform.bing.com/',
	'synthesize')

gender = "Female"
language = "zh-CN"


locales = jsonlite::fromJSON(
  '{
  "ar-eg": {"Female": "Microsoft Server Speech Text to Speech Voice (ar-EG, Hoda)"},
  "de-DE": {"Female": "Microsoft Server Speech Text to Speech Voice (de-DE, Hedda)",
  "Male": "Microsoft Server Speech Text to Speech Voice (de-DE, Stefan, Apollo)"},
  "en-AU": {"Female": "Microsoft Server Speech Text to Speech Voice (en-AU, Catherine)"},
  "en-CA": {"Female": "Microsoft Server Speech Text to Speech Voice (en-CA, Linda)"},
  "en-GB": {"Female": "Microsoft Server Speech Text to Speech Voice (en-GB, Susan, Apollo)",
  "Male": "Microsoft Server Speech Text to Speech Voice (en-GB, George, Apollo)"},
  "en-IN": {"Male": "Microsoft Server Speech Text to Speech Voice (en-IN, Ravi, Apollo)"},
  "en-US": {"Female": "Microsoft Server Speech Text to Speech Voice (en-US, ZiraRUS)",
  "Male": "Microsoft Server Speech Text to Speech Voice (en-US, BenjaminRUS)"},
  "es-ES": {"Female": "Microsoft Server Speech Text to Speech Voice (es-ES, Laura, Apollo)",
  "Male": "Microsoft Server Speech Text to Speech Voice (es-ES, Pablo, Apollo)"},
  "es-MX": {"Male": "Microsoft Server Speech Text to Speech Voice (es-MX, Raul, Apollo)"},
  "fr-CA": {"Female": "Microsoft Server Speech Text to Speech Voice (fr-CA, Caroline)"},
  "fr-FR": {"Female": "Microsoft Server Speech Text to Speech Voice (fr-FR, Julie, Apollo)",
  "Male": "Microsoft Server Speech Text to Speech Voice (fr-FR, Paul, Apollo)"},
  "it-IT": {"Male": "Microsoft Server Speech Text to Speech Voice (it-IT, Cosimo, Apollo)"},
  "ja-JP": {"Female": "Microsoft Server Speech Text to Speech Voice (ja-JP, Ayumi, Apollo)",
  "Male": "Microsoft Server Speech Text to Speech Voice (ja-JP, Ichiro, Apollo)"},
  "pt-BR": {"Male": "Microsoft Server Speech Text to Speech Voice (pt-BR, Daniel, Apollo)"},
  "ru-RU": {"Female": "Microsoft Server Speech Text to Speech Voice (pt-BR, Daniel, Apollo)",
  "Male": "Microsoft Server Speech Text to Speech Voice (ru-RU, Pavel, Apollo)"},
  "zh-CN": {"Female": "Microsoft Server Speech Text to Speech Voice (zh-CN, HuihuiRUS)",
  "Female2": "Microsoft Server Speech Text to Speech Voice (zh-CN, Yaoyao, Apollo)",
  "Male": "Microsoft Server Speech Text to Speech Voice (zh-CN, Kangkang, Apollo)"},
  "zh-HK": {"Female": "Microsoft Server Speech Text to Speech Voice (zh-HK, Tracy, Apollo)",
  "Male": "Microsoft Server Speech Text to Speech Voice (zh-HK, Danny, Apollo)"},
  "zh-TW": {"Female": "Microsoft Server Speech Text to Speech Voice (zh-TW, Yating, Apollo)",
  "Male": "Microsoft Server Speech Text to Speech Voice (zh-TW, Zhiwei, Apollo)"}
  }')
#
# if (grepl("^en", language)) {
#   locales = "ZiraRUS"
# }
# if (grepl("^zh", language)) {
#   locales = "HuihuiRUS"
# }
xname = locales[[language]][[gender]]
# xname = paste0("Microsoft Server Speech Text to Speech Voice (",
# language,
# ", ", locales, ")")

ssml = c(paste0(
	"<speak version='1.0' ", "xml:lang='",
	language, "'>"),
	paste0("<voice xml:lang='", language ,"'",
	" xml:gender='", gender, "'"),
	paste0(" name='", xname, "'"),
	">",
	script, "</voice>",
	"</speak>")
ssml = paste(ssml, collapse = "")

if (nchar(ssml) > 1024) {
  stop("Need smaller script!")
}
res = POST(synth_url,
	body = ssml,
	auth_hdr, fmt_hdr, ctype, auth_hdr)
stop_for_status(res)
out = content(res)
tmp <- tempfile()
writeBin(out, con = tmp)
mp3 = tuneR::readMP3(tmp)

setWavPlayer("/Applications/VLC.app/Contents/MacOS/VLC")
play(mp3)

