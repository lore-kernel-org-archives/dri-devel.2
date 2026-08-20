Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614B7C5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A998010F00B;
	Thu, 20 Aug 2026 12:03:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="ktKMGYOH";
	dkim-atps=neutral
Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2C2610F00B
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 12:03:00 +0000 (UTC)
Content-Language: ru-RU
Content-Type: text/plain; charset="utf-8"
Content-ID: <C47499EF25B4534AA4B45A92D5F49C6C@prosoftsystems.ru>
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
 c=relaxed/relaxed; t=1787227377; h=from:to:date:message-id:subject;
 bh=K+OFDeNONFk68+UsZa4ZqYjKg9Y/e9AzlLz11Xc1dik=;
 b=ktKMGYOHNoyR8FkZRU4r4PiLXDrF3VQpwHMKYUYq2ely9OnbhK3bxwVk2CPIqowMg8ZWKf3NWbx
 om8uvo1qJ8GTJp6X/1cLc1rU+h2vysT4/BnzF5FAuSui13sHmHGuWTtOy6diOjhjS6gKaZ064O909
 NLxMGV5XeGE9UUusax98wVfQQAa6R0QRbQ/P1Mvu+YDDeXUJNdcredQn9TMLqqzvArhzCR8pvarRe
 CVnijqwW36POLere//G+h+LE92w0nHB8YfLJwAYtg/sciD+q+pgXFoKPE24T1efI1Km3IqA9PFbZu
 s7M4BGiBV1Y7qWVp4ZxARhuv0hwRm5kosC5A==
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30;
 Thu, 20 Aug 2026 17:02:57 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 echo-2.prosoft.ural.ru (172.21.245.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 20 Aug 2026 17:02:57 +0500
Received: from echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed]) by
 echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed%17]) with mapi id
 15.02.1748.039; Thu, 20 Aug 2026 17:02:57 +0500
From: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
 =?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
To: "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>
CC: "rfoss@kernel.org" <rfoss@kernel.org>, "Laurent.pinchart@ideasonboard.com"
 <Laurent.pinchart@ideasonboard.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
 "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "luca.ceresoli@bootlin.com"
 <luca.ceresoli@bootlin.com>, "jonas@kwiboo.se" <jonas@kwiboo.se>,
 "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>, "airlied@gmail.com"
 <airlied@gmail.com>, "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, 
 "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>
Subject: [PATCH] drm/bridge: tc358767: check regmap_write() return values
Thread-Topic: [PATCH] drm/bridge: tc358767: check regmap_write() return values
Thread-Index: AQHdMJvWCHWQCzrAakOY6ZnTySZXuQ==
Date: Thu, 20 Aug 2026 12:02:57 +0000
Message-ID: <f2e14b6c77872ee268b8dcaed1ca87006f7ad578.camel@prosoftsystems.ru>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.1.89]
MIME-Version: 1.0
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

Y29tbWl0IDZkMGMzODMxNTkxNSAoImRybS9icmlkZ2U6IHRjMzU4NzY3OiBEcm9wIGN1c3RvbQ0K
dGNfd3JpdGUoKS90Y19yZWFkKCkgYWNjZXNzb3JzIikgcmVwbGFjZWQgdGhlIHRjX3dyaXRlKCkg
bWFjcm8sDQp3aGljaCBiYWlsZWQgb3V0IG9uIGZhaWx1cmUsIHdpdGggZGlyZWN0IHJlZ21hcF93
cml0ZSgpIGNhbGxzLg0KQXQgdGhyZWUgc2l0ZXMgdGhlIGVycm9yIGNoZWNrIHdhcyBub3QgY2Fy
cmllZCBvdmVyLA0Kc28gdGhlIHJldHVybiB2YWx1ZSBpcyBvdmVyd3JpdHRlbiBiZWZvcmUgaXQg
aXMgZXZlciBleGFtaW5lZDoNCg0KVGhlIERQMF9WSURTWU5DREVMQVkgd3JpdGUgaW4gdGNfc2V0
X2VkcF92aWRlb19tb2RlKCksIGFuZA0KYm90aCBEUF9QSFlfQ1RSTCB3cml0ZXMgaW4gdGhlIG1h
aW4gbGluayBQSFkgcmVzZXQgc2VxdWVuY2UgaW4NCnRjX21haW5fbGlua19lbmFibGUoKSwgd2hv
c2UgZXJyb3IgaXMgY2xvYmJlcmVkIGJ5IHRoZSBmb2xsb3dpbmcNClBIWV9SRFkgcG9sbC4NCg0K
QXMgYSByZXN1bHQsIGZhaWxlZCBJMkMgdHJhbnNhY3Rpb25zIHRvIHRoZSBicmlkZ2UgYXJlIHNp
bGVudGx5DQppZ25vcmVkLiBBIGZhaWxlZCBEUDBfVklEU1lOQ0RFTEFZIHdyaXRlIGNhbiBsZWF2
ZSB0aGUgc3RyZWFtIHJ1bm5pbmcNCndpdGggc3RhbGUgVEhSRVNIX0RMWSBhbmQgVklEX1NZTkNf
RExZIHZhbHVlcywgY2F1c2luZyBkaXNwbGF5DQpjb3JydXB0aW9uIHdpdGhvdXQgYW55IGVycm9y
IGJlaW5nIHJlcG9ydGVkLiBBIGZhaWxlZCBQSFkgcmVzZXQNCnNlcXVlbmNlIGNhbiBsZWF2ZSB0
aGUgbWFpbiBsaW5rIFBIWSBpbiByZXNldDsgdGhlIFBIWV9SRFkgcG9sbCBtYXkNCnN0aWxsIHN1
Y2NlZWQgYmVjYXVzZSB0aGUgYml0IHdhcyBzZXQgZHVyaW5nIHRoZSBpbml0aWFsIEFVWCBsaW5r
DQpzZXR1cCwgc28gbGluayB0cmFpbmluZyBwcm9jZWVkcyBvbiBhIGJhZCBQSFksIG9yIHRoZSBy
ZWFsIEkyQyBlcnJvcg0KaXMgbWFza2VkIGJ5IGEgbWlzbGVhZGluZyAidGltZW91dCB3YWl0aW5n
IGZvciBwaHkgYmVjb21lIHJlYWR5Ii4NCg0KUHJvcGFnYXRlIHRoZSBlcnJvcnMgaW5zdGVhZC4N
Cg0KRm91bmQgYnkgTGludXggVmVyaWZpY2F0aW9uIENlbnRlciAobGludXh0ZXN0aW5nLm9yZykg
d2l0aCBTVkFDRS4NCg0KRml4ZXM6IDZkMGMzODMxNTkxNSAoImRybS9icmlkZ2U6IHRjMzU4NzY3
OiBEcm9wIGN1c3RvbQ0KdGNfd3JpdGUoKS90Y19yZWFkKCkgYWNjZXNzb3JzIikNCkNjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnDQpTaWduZWQtb2ZmLWJ5OiBSYWRpeSBaaGFtYmFraWV2IDxyLnpo
YW1iYWtpZXZAcHJvc29mdHN5c3RlbXMucnU+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYnJpZGdl
L3RjMzU4NzY3LmMgfCA3ICsrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3RjMzU4NzY3LmMNCmIvZHJp
dmVycy9ncHUvZHJtL2JyaWRnZS90YzM1ODc2Ny5jDQppbmRleCA3MTg4OTM1ZmRiODIuLmQ2YjYy
NTQ2ZmVkMCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2UvdGMzNTg3NjcuYw0K
KysrIGIvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS90YzM1ODc2Ny5jDQpAQCAtMTAxNCw2ICsxMDE0
LDggQEAgc3RhdGljIGludCB0Y19zZXRfZWRwX3ZpZGVvX21vZGUoc3RydWN0IHRjX2RhdGENCip0
YywNCiAJcmV0ID0gcmVnbWFwX3dyaXRlKHRjLT5yZWdtYXAsIERQMF9WSURTWU5DREVMQVksDQog
CQkgRklFTERfUFJFUChUSFJFU0hfRExZLCBtYXhfdHVfc3ltYm9sKSB8DQogCQkgRklFTERfUFJF
UChWSURfU1lOQ19ETFksIHZpZF9zeW5jX2RseSkpOw0KKwlpZiAocmV0KQ0KKwkJcmV0dXJuIHJl
dDsNCiANCiAJcmV0ID0gcmVnbWFwX3dyaXRlKHRjLT5yZWdtYXAsIERQMF9UT1RBTFZBTCwNCiAJ
CQkgICBGSUVMRF9QUkVQKEhfVE9UQUwsIG1vZGUtPmh0b3RhbCkgfA0KQEAgLTExNDQsOSArMTE0
NiwxNCBAQCBzdGF0aWMgaW50IHRjX21haW5fbGlua19lbmFibGUoc3RydWN0IHRjX2RhdGENCip0
YykNCiAJLyogUmVzZXQvRW5hYmxlIE1haW4gTGlua3MgKi8NCiAJZHBfcGh5X2N0cmwgfD0gRFBf
UEhZX1JTVCB8IFBIWV9NMV9SU1QgfCBQSFlfTTBfUlNUOw0KIAlyZXQgPSByZWdtYXBfd3JpdGUo
dGMtPnJlZ21hcCwgRFBfUEhZX0NUUkwsIGRwX3BoeV9jdHJsKTsNCisJaWYgKHJldCkNCisJCXJl
dHVybiByZXQ7DQorDQogCXVzbGVlcF9yYW5nZSgxMDAsIDIwMCk7DQogCWRwX3BoeV9jdHJsICY9
IH4oRFBfUEhZX1JTVCB8IFBIWV9NMV9SU1QgfCBQSFlfTTBfUlNUKTsNCiAJcmV0ID0gcmVnbWFw
X3dyaXRlKHRjLT5yZWdtYXAsIERQX1BIWV9DVFJMLCBkcF9waHlfY3RybCk7DQorCWlmIChyZXQp
DQorCQlyZXR1cm4gcmV0Ow0KIA0KIAlyZXQgPSB0Y19wb2xsX3RpbWVvdXQodGMsIERQX1BIWV9D
VFJMLCBQSFlfUkRZLCBQSFlfUkRZLCA1MDAsDQoxMDAwMDApOw0KIAlpZiAocmV0KSB7DQotLSAN
CjIuNTMuMA0KDQoNCg==
