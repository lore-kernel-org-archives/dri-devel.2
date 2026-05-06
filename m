Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8612BCD3424
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 07:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC96910E176;
	Wed,  6 May 2026 07:47:22 +0000 (UTC)
X-Greylist: delayed 566 seconds by postgrey-1.36 at gabe;
 Wed, 06 May 2026 01:08:21 UTC
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.64.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 672AB10E203
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 01:08:21 +0000 (UTC)
X-QQ-mid: zesmtpsz2t1778029043t502262f0
X-QQ-Originating-IP: Q6gong4HjCyBcK7hvROYB58OxkIPCPCQS3s+sWVtfa4=
Received: from qs-qiuxiaojin ( [120.196.70.39])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 06 May 2026 08:57:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4261445703974912000
EX-QQ-RecipientCnt: 11
Date: Wed, 6 May 2026 08:57:22 +0800
From: =?GB2312?B?x/HP/r3w?= <qiuxiaojin@qs-tech.com>
To: hjc <hjc@rock-chips.com>, heiko <heiko@sntech.de>, 
 andy.yan <andy.yan@rock-chips.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, airlied <airlied@gmail.com>, 
 simona <simona@ffwll.ch>, 
 maarten.lankhorst <maarten.lankhorst@linux.intel.com>, 
 mripard <mripard@kernel.org>, tzimmermann <tzimmermann@suse.de>, 
 linux-rockchip <linux-rockchip@lists.infradead.org>, 
 =?GB2312?B?x/HP/r3w?= <qiuxiaojin@cvte.com>
Subject: [PATCH] drm/rockchip: gem: check drm_gem_object_init() return value
X-Priority: 3
X-GUID: D5763B4C-DD4D-4827-A73C-137FD996B5C6
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.528[cn]
Mime-Version: 1.0
Message-ID: <A381993FF0E67CFE+202605060857210496809@qs-tech.com>
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: base64
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:qs-tech.com:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: MNbA5mkmBXEJSnPgV6Z4yDVfVnqiE2O3KxIsC+eVvZND4/UYMCMq54LZ
 NY/lQMfvLO2yCpD1TrJxeeCi0sMiYPOjXz3C2YynRbhV2kRCgw90na0P1EGJ2Z/StHJK6T5
 MfdxdCOzhoMKEMXvZcNHXVzYskXwqolr0ePiCkm4v6LoeZ2K/HdeorK9W/bhoYJqAQOOFQt
 sSUTQs2fNAKj6+RHkdC5Kkl/SSlbjZhuKvJCcNUbDlhNvg0RTQL37inzuutxb9uUD98S3lZ
 PWkVsGvE4P4R1GW597BWELVPbnBwyNUOm80KWByJz/fNiemaFzF59/UNRIQzFCk13ORyiVT
 pA3Rqtu9784XrNXCzmlgxIpuqLdj8nGLDeVIfMu2x0b3xOECvUoo1ySAtM2mNfhfQR5XpyN
 t4eTxfbtN7Xg1ciNFKCBqeSqja1WnE10GICTooFrU6cNM82l0rPT74/qDdEmSXKn98yu0MR
 G1jwJXwab5QK9A0zFVj/eBMhGnDdzNFHqJiXXI7SH+lVhtX00lej6IkjYhgBJcRN6WrLijD
 uEaIDanZw04UDJhKk9E4DKJia0cczTcdhBwAq1j6Y6cB1QRpNCMhe8UwqqVPmd7Po2puGAg
 WFqOs5toxaoAQ7jCiLgzjqdgRUDvPIUCJ5FwamVqjfr/LmmjsiQGVaePUJ1kHtg+uDHv7cU
 wIQaz2L63PG6EuqUiUx3+9IAnX9GwiaGhFGWS8gh5Fd2h7LOR/dJDBeF5iUBKRtjOJnorOu
 omiQny2OuVw4Tv53Arg+utV95o2L7oQiLvp5wtn6fiDhvi6fh6tajX4SohlMcK0uXJ4/8WT
 z4n8sLoVtlv0G2sx4BGRPXuqt+29x6HoKIrs3NqEkqoLdHchTIBH+ta001arRw9sXi6bSDN
 Ij1FYQgfCUIGRfHUwHln0Mfdukk9EJcuCWTkJdDkWNg6Sx6bL5k6fEz1E06H5E2+dbogx8Z
 UqLnioyFD0+TGN9gEcu8X1CP1AOz9ib9xQi/FhFhqN5wUTUy6Wy2rsK3G1zwLe2lsUwg=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Wed, 06 May 2026 07:47:21 +0000
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

RnJvbSBhYjhiMTU5MjIwOTQzOGEwNGM2MzVkNGM2YzQwYzM5ODIzMGMxYmE3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBRaXUgWGlhb2ppbiA8cWl1eGlhb2ppbkBxcy10ZWNoLmNvbT4K
RGF0ZTogV2VkLCA2IE1heSAyMDI2IDA4OjUyOjQ1ICswODAwClN1YmplY3Q6IFtQQVRDSF0gZHJt
L3JvY2tjaGlwOiBnZW06IGNoZWNrIGRybV9nZW1fb2JqZWN0X2luaXQoKSByZXR1cm4gdmFsdWUK
CnJvY2tjaGlwX2dlbV9hbGxvY19vYmplY3QoKSBjdXJyZW50bHkgaWdub3JlcyB0aGUgcmV0dXJu
IHZhbHVlIG9mCgpkcm1fZ2VtX29iamVjdF9pbml0KCkuIElmIGluaXRpYWxpemF0aW9uIGZhaWxz
LCB0aGUgZnVuY3Rpb24gY2FuCnJldHVybiBhbiBpbmNvbXBsZXRlbHkgaW5pdGlhbGl6ZWQgR0VN
IG9iamVjdC4KCkhhbmRsZSB0aGUgZmFpbHVyZSBieSBmcmVlaW5nIHRoZSBhbGxvY2F0ZWQgb2Jq
ZWN0IGFuZCByZXR1cm5pbmcKRVJSX1BUUihyZXQpLgoKRml4ZXM6IDM4Zjk5M2I3YzU5ZSAoImRy
bS9yb2NrY2hpcDogRG8gbm90IHVzZSBETUEgbWFwcGluZyBBUEkgaWYgYXR0YWNoZWQgdG8gSU9N
TVUgZG9tYWluIikKU2lnbmVkLW9mZi1ieTogUWl1IFhpYW9qaW4gPHFpdXhpYW9qaW5AcXMtdGVj
aC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL3JvY2tjaGlwX2RybV9nZW0uYyB8
IDcgKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9yb2NrY2hpcF9kcm1fZ2Vt
LmMgYi9kcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX2dlbS5jCmluZGV4IDA5
ZDE0YTA3MmQyNy4uZWYxNmIxZmFiZWMzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcm9j
a2NoaXAvcm9ja2NoaXBfZHJtX2dlbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9y
b2NrY2hpcF9kcm1fZ2VtLmMKQEAgLTI4Niw2ICsyODYsNyBAQCBzdGF0aWMgc3RydWN0IHJvY2tj
aGlwX2dlbV9vYmplY3QgKgogewogCXN0cnVjdCByb2NrY2hpcF9nZW1fb2JqZWN0ICpya19vYmo7
CiAJc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmo7CisJaW50IHJldDsKIAogCXNpemUgPSByb3Vu
ZF91cChzaXplLCBQQUdFX1NJWkUpOwogCkBAIC0yOTcsNyArMjk4LDExIEBAIHN0YXRpYyBzdHJ1
Y3Qgcm9ja2NoaXBfZ2VtX29iamVjdCAqCiAKIAlvYmotPmZ1bmNzID0gJnJvY2tjaGlwX2dlbV9v
YmplY3RfZnVuY3M7CiAKLQlkcm1fZ2VtX29iamVjdF9pbml0KGRybSwgb2JqLCBzaXplKTsKKwly
ZXQgPSBkcm1fZ2VtX29iamVjdF9pbml0KGRybSwgb2JqLCBzaXplKTsKKwlpZiAocmV0KSB7CisJ
CWtmcmVlKHJrX29iaik7CisJCXJldHVybiBFUlJfUFRSKHJldCk7CisJfQogCiAJcmV0dXJuIHJr
X29iajsKIH0KLS0gCjIuMzQuMQoKCgoKCgoKCi0tLS0tLS0tLS0tLS0tCgoKClFpdSBYaWFvamlu
CgoK

