{
module Main where
import Control.Monad
}

%wrapper "basic"

$ctl = [\x00-\x1F \x7F]
$alpha = [a-zA-Z]
$digit = [0-9]
$xdigit = [0-9a-fA-F]
$any = [\x00-\xFF]
$safe = [\$ \- \_ \.]
$semi_safe = [\x22 \< \>]
$unsafe = [$ctl \x20 \# \% $semi_safe]
$extra = [\! \* \' \( \) \,]
$reserved = [\; \/ \? \: \@ \& \= \+]
$national = ~$reserved
$unreserved = [$alpha $digit $safe $extra $national $unsafe]
$tspecials = [\( \) \< \> \@ \, \; \: \\ \x22 \/ \[ \] \? \= \{ \} \x20 \t]

@crlf       = \r\n
@escape     = \% $xdigit $xdigit
@uchar      = $unreserved | @escape | $semi_safe
@pchar      = @uchar | \: | \@ | \& | \= | \+

tokens :-
	$semi_safe {\x -> putStr x}
	$unreserved+ {\x -> putStr x }

{
{-
data Request = Request
	{ requestMethod :: Method
	, httpVersion :: HttpVersion
	, rawPathInfo :: ByteString
	, rawQueryString :: ByteString
	}
-}
main = do
	s <- getLine
	sequence_ $ alexScanTokens s
}
