Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DDBCD4F25
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 06:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B77C10E0D0;
	Sun, 17 May 2026 06:50:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="BsbFysEG";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE98A10E0D0
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 06:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=YT/st0rUowrjnsorx4dHbqeYHh+zgtVAaRZRt9PAT6Y=; b=B
 sbFysEG51l1evYLA0stepubTyFLuZsfT8a0Yk1HWW5DQc9ZjXm3pzCMsbFj5NQhj
 XNRewX5MCxflpyrytTqFX3mqHPl842ScyhUMdR7tjiQaS/HVGZjQVryfNFPV9Ard
 mEFQfTutMzYzzTGJTpLiHGzwFbeYbzfL1SF89sgJ9k=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-125 (Coremail) ; Sun, 17 May 2026 14:37:22 +0800
 (CST)
X-Originating-IP: [58.22.7.114]
Date: Sun, 17 May 2026 14:37:22 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Bob ynn" <yanlonglong@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org, andy.yan@rock-chips.com,
 dmitry.baryshkov@linaro.org
Subject: Re:[PATCH] drm/bridge: synopsys: dw-dp: fix bool function returning
 negative error code
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260511063941.2070-1-yanlonglong@kylinos.cn>
References: <20260511063941.2070-1-yanlonglong@kylinos.cn>
X-CM-CTRLMSGS: pJoUnXBsdXM9MTc3ODk5OTg0MTk5M19iZGFlOTcxNjNjNGVlMTdiY2Y0YjBmY
 jhjYTRjNDRmZA==
X-NTES-SC: AL_Qu2cCvWStkAv5CeRYOkfmUgWjuw/WsG1v/Ul1YBSP556jAzp9gwwfH56PFTL2cSiLi6LrRuQdCVL+M9jQ5RxTrMBAlkf+6ZjxGbVkCdqYcn8Lw==
Content-Type: multipart/alternative; 
 boundary="----=_Part_14756_2141940665.1778999842808"
MIME-Version: 1.0
Message-ID: <4b0919d.e23.19e34a757f9.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: fSgvCgDnz0wiYglq_bekAA--.1066W
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

------=_Part_14756_2141940665.1778999842808
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGVsbG8gQm9iLApBdCAyMDI2LTA1LTEzIDE1OjU0OjM1LCAiQm9iIHlubiIgPHlhbmxvbmdsb25n
QGt5bGlub3MuY24+IHdyb3RlOgo+RnJvbTogeWFubG9uZ2xvbmcgPHlhbmxvbmdsb25nQGt5bGlu
b3MuY24+Cj4KPlRoZSBmdW5jdGlvbiBkd19kcF92aWRlb19uZWVkX3ZzY19zZHAoKSBpcyBkZWNs
YXJlZCB0byByZXR1cm4gYm9vbCwgYnV0Cj5pdCByZXR1cm5zIC1FSU5WQUwgd2hlbiBkd19kcF9n
ZXRfYnJpZGdlX3N0YXRlKCkgZmFpbHMuIFNpbmNlIC1FSU5WQUwgaXMKPmEgbm9uLXplcm8gdmFs
dWUgKC0yMiksIGl0IGlzIGltcGxpY2l0bHkgY29udmVydGVkIHRvIHRydWUsIHdoaWNoIGlzIHRo
ZQo+b3Bwb3NpdGUgb2YgdGhlIGludGVuZGVkIGJlaGF2aW9yCj4KPkZpeGVzOiA4NmVlY2MzYTlj
MmUoImRybS9icmlkZ2U6IHN5bm9wc3lzOiBBZGQgRFcgRFBUWCBDb250cm9sbGVyIHN1cHBvcnQg
bGlicmFyeSIpCgo+U2lnbmVkLW9mZi1ieTogeWFubG9uZ2xvbmcgPHlhbmxvbmdsb25nQGt5bGlu
b3MuY24+CgoKUmV2aWV3ZWQtYnk6IEFuZHkgWWFuIDxhbmR5c2hya0AxNjMuY29tPgoKClRoYW5r
cwoKCj4tLS0KPiBkcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lzL2R3LWRwLmMgfCAyICst
Cj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lzL2R3LWRwLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lzL2R3LWRwLmMKPmluZGV4IDIxNTQxYmUwOTRjNC4uN2I5
OWQ5MWIzNDU2IDEwMDY0NAo+LS0tIGEvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9zeW5vcHN5cy9k
dy1kcC5jCj4rKysgYi9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lzL2R3LWRwLmMKPkBA
IC0xMTQzLDcgKzExNDMsNyBAQCBzdGF0aWMgYm9vbCBkd19kcF92aWRlb19uZWVkX3ZzY19zZHAo
c3RydWN0IGR3X2RwICpkcCkKPiAKPiAJc3RhdGUgPSBkd19kcF9nZXRfYnJpZGdlX3N0YXRlKGRw
KTsKPiAJaWYgKCFzdGF0ZSkKPi0JCXJldHVybiAtRUlOVkFMOwo+KwkJcmV0dXJuIGZhbHNlOwo+
IAo+IAlpZiAoIWxpbmstPnZzY19zZHBfc3VwcG9ydGVkKQo+IAkJcmV0dXJuIGZhbHNlOwo+LS0g
Cj4yLjQzLjAK
------=_Part_14756_2141940665.1778999842808
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkYXRhLW50ZXM9Im50ZXNfbWFpbF9ib2R5X3Jvb3QiIHN0eWxlPSJsaW5lLWhlaWdodDox
Ljc7Y29sb3I6IzAwMDAwMDtmb250LXNpemU6MTRweDtmb250LWZhbWlseTpBcmlhbCI+PGRpdiBp
ZD0ic3BuRWRpdG9yQ29udGVudCI+PGRpdiBzdHlsZT0ibWFyZ2luOiAwOyI+SGVsbG8gQm9iLDwv
ZGl2PjwvZGl2PjxwcmU+QXQgMjAyNi0wNS0xMyAxNTo1NDozNSwgIkJvYiB5bm4iICZsdDt5YW5s
b25nbG9uZ0BreWxpbm9zLmNuJmd0OyB3cm90ZToKJmd0O0Zyb206IHlhbmxvbmdsb25nICZsdDt5
YW5sb25nbG9uZ0BreWxpbm9zLmNuJmd0OwomZ3Q7CiZndDtUaGUgZnVuY3Rpb24gZHdfZHBfdmlk
ZW9fbmVlZF92c2Nfc2RwKCkgaXMgZGVjbGFyZWQgdG8gcmV0dXJuIGJvb2wsIGJ1dAomZ3Q7aXQg
cmV0dXJucyAtRUlOVkFMIHdoZW4gZHdfZHBfZ2V0X2JyaWRnZV9zdGF0ZSgpIGZhaWxzLiBTaW5j
ZSAtRUlOVkFMIGlzCiZndDthIG5vbi16ZXJvIHZhbHVlICgtMjIpLCBpdCBpcyBpbXBsaWNpdGx5
IGNvbnZlcnRlZCB0byB0cnVlLCB3aGljaCBpcyB0aGUKJmd0O29wcG9zaXRlIG9mIHRoZSBpbnRl
bmRlZCBiZWhhdmlvcgomZ3Q7CiZndDtGaXhlczogODZlZWNjM2E5YzJlKCJkcm0vYnJpZGdlOiBz
eW5vcHN5czogQWRkIERXIERQVFggQ29udHJvbGxlciBzdXBwb3J0IGxpYnJhcnkiKQo8ZGl2PiZn
dDtTaWduZWQtb2ZmLWJ5OiB5YW5sb25nbG9uZyAmbHQ7eWFubG9uZ2xvbmdAa3lsaW5vcy5jbiZn
dDs8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlJldmlld2VkLWJ5OiBBbmR5IFlhbiAmbHQ7YW5k
eXNocmtAMTYzLmNvbSZndDs8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYW5rczwvZGl2Pjxk
aXY+PGJyPjwvZGl2PiZndDstLS0KJmd0OyBkcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lz
L2R3LWRwLmMgfCAyICstCiZndDsgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCiZndDsKJmd0O2RpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3N5
bm9wc3lzL2R3LWRwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lzL2R3LWRwLmMK
Jmd0O2luZGV4IDIxNTQxYmUwOTRjNC4uN2I5OWQ5MWIzNDU2IDEwMDY0NAomZ3Q7LS0tIGEvZHJp
dmVycy9ncHUvZHJtL2JyaWRnZS9zeW5vcHN5cy9kdy1kcC5jCiZndDsrKysgYi9kcml2ZXJzL2dw
dS9kcm0vYnJpZGdlL3N5bm9wc3lzL2R3LWRwLmMKJmd0O0BAIC0xMTQzLDcgKzExNDMsNyBAQCBz
dGF0aWMgYm9vbCBkd19kcF92aWRlb19uZWVkX3ZzY19zZHAoc3RydWN0IGR3X2RwICpkcCkKJmd0
OyAKJmd0OyAJc3RhdGUgPSBkd19kcF9nZXRfYnJpZGdlX3N0YXRlKGRwKTsKJmd0OyAJaWYgKCFz
dGF0ZSkKJmd0Oy0JCXJldHVybiAtRUlOVkFMOwomZ3Q7KwkJcmV0dXJuIGZhbHNlOwomZ3Q7IAom
Z3Q7IAlpZiAoIWxpbmstJmd0O3ZzY19zZHBfc3VwcG9ydGVkKQomZ3Q7IAkJcmV0dXJuIGZhbHNl
OwomZ3Q7LS0gCiZndDsyLjQzLjAKPC9wcmU+PC9kaXY+
------=_Part_14756_2141940665.1778999842808--

