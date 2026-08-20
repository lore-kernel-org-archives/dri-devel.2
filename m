Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8E5C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7044610EFB1;
	Thu, 20 Aug 2026 10:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="QkGfeS9N";
	dkim-atps=neutral
X-Greylist: delayed 904 seconds by postgrey-1.36 at gabe;
 Thu, 20 Aug 2026 08:02:07 UTC
Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5300910E159
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 08:02:07 +0000 (UTC)
Content-Language: ru-RU
Content-Type: text/plain; charset="utf-8"
Content-ID: <1870AAF59BA5C440A9C0A5FEDF60F83A@prosoftsystems.ru>
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
 c=relaxed/relaxed; t=1787212020; h=from:to:date:message-id:subject;
 bh=b+nl3wNpyL9zfo55O6yDTvES23BqPJVNGCcTN1kET+M=;
 b=QkGfeS9NM9KN1hAdjL3Veb8ehw+QQC5OteUHv4HFiKjfTNJwGhb/FICh/HtFvtn0YOCmScjcYvu
 Aq2jSFiI9nHtMVvEn6RiO2uGRVJvETueIDPOKZp/aQ/13J+6Z/9623I2jPP004QIMVEs5M+qnUGPK
 27GM4VFmId91NI7h3ETMBi/fiBqrlo/eugb+11juZL/It7xVsXsTDWIz1zT1LRzEP1OePH3i8Mmx6
 fqwef0qabDXwgdHOupO2NN7y/kCBZsId7jww+qLe5PqVZaksAfNI1lp7TA/ybso6CEI7pn9ecX4oJ
 kz8Dli8s1TUP67vyFAH1VIJw2F45qcCmMqvg==
Received: from ECHO-3.prosoft.ural.ru (172.25.100.229) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30;
 Thu, 20 Aug 2026 12:47:00 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 ECHO-3.prosoft.ural.ru (172.25.100.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 20 Aug 2026 12:46:59 +0500
Received: from echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed]) by
 echo-2.prosoft.ural.ru ([fe80::8f12:4f85:56d8:13ed%17]) with mapi id
 15.02.1748.039; Thu, 20 Aug 2026 12:46:59 +0500
From: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
 =?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
To: "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>
CC: "rfoss@kernel.org" <rfoss@kernel.org>, "Laurent.pinchart@ideasonboard.com"
 <Laurent.pinchart@ideasonboard.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "j-choudhary@ti.com" <j-choudhary@ti.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "h-shenoy@ti.com" <h-shenoy@ti.com>,
 "xiqi2@huawei.com" <xiqi2@huawei.com>, "luca.ceresoli@bootlin.com"
 <luca.ceresoli@bootlin.com>, "lvc-project@linuxtesting.org"
 <lvc-project@linuxtesting.org>, "jonas@kwiboo.se" <jonas@kwiboo.se>,
 "tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "dmitry.baryshkov@oss.qualcomm.com"
 <dmitry.baryshkov@oss.qualcomm.com>, "neil.armstrong@linaro.org"
 <neil.armstrong@linaro.org>, "jernej.skrabec@gmail.com"
 <jernej.skrabec@gmail.com>
Subject: [PATCH] drm: bridge: cdns-mhdp8546: drop redundant NULL check
Thread-Topic: [PATCH] drm: bridge: cdns-mhdp8546: drop redundant NULL check
Thread-Index: AQHdMHgUvr7X1CFvP02i3G0d9x/1EA==
Date: Thu, 20 Aug 2026 07:46:59 +0000
Message-ID: <52b64660617c2f1303b1f590f831baa8f39bed98.camel@prosoftsystems.ru>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.1.89]
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 20 Aug 2026 10:07:27 +0000
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

dG9fY2Ruc19taGRwX2JyaWRnZV9zdGF0ZSgpIGlzIGEgY29udGFpbmVyX29mKCkgb24gdGhlIGZp
cnN0IG1lbWJlcg0Kb2Ygc3RydWN0IGNkbnNfbWhkcF9icmlkZ2Vfc3RhdGUsIHNvIGl0IGNhbm5v
dCByZXR1cm4gTlVMTCBhcyBsb25nDQphcyBpdHMgaW5wdXQgaXMgbm9uLU5VTEwuIFRoZSBicmlk
Z2Ugc3RhdGUgaXMgYWxyZWFkeSBOVUxMLWNoZWNrZWQNCnJpZ2h0IGJlZm9yZSB0aGUgY29udmVy
c2lvbiwgbWFraW5nIHRoZSBjaGVjayBvbiB0aGUgY29udmVydGVkDQpwb2ludGVyIGRlYWQgY29k
ZS4NCg0KUmVtb3ZlIGl0Lg0KDQpGb3VuZCBieSBMaW51eCBWZXJpZmljYXRpb24gQ2VudGVyIChs
aW51eHRlc3Rpbmcub3JnKSB3aXRoIFNWQUNFLg0KDQpTaWduZWQtb2ZmLWJ5OiBSYWRpeSBaaGFt
YmFraWV2IDxyLnpoYW1iYWtpZXZAcHJvc29mdHN5c3RlbXMucnU+DQotLS0NCiBkcml2ZXJzL2dw
dS9kcm0vYnJpZGdlL2NhZGVuY2UvY2Rucy1taGRwODU0Ni1jb3JlLmMgfCA1IC0tLS0tDQogMSBm
aWxlIGNoYW5nZWQsIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYnJpZGdlL2NhZGVuY2UvY2Rucy1taGRwODU0Ni1jb3JlLmMNCmIvZHJpdmVycy9ncHUvZHJt
L2JyaWRnZS9jYWRlbmNlL2NkbnMtbWhkcDg1NDYtY29yZS5jDQppbmRleCAzNmMwN2I3MWZlMDQu
LjQyNDE4M2RiNmY3NiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2UvY2FkZW5j
ZS9jZG5zLW1oZHA4NTQ2LWNvcmUuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9jYWRl
bmNlL2NkbnMtbWhkcDg1NDYtY29yZS5jDQpAQCAtMjE0NSwxMSArMjE0NSw2IEBAIHN0YXRpYyBp
bnQgY2Ruc19taGRwX3VwZGF0ZV9saW5rX3N0YXR1cyhzdHJ1Y3QNCmNkbnNfbWhkcF9kZXZpY2Ug
Km1oZHApDQogCQl9DQogDQogCQljZG5zX2JyaWRnZV9zdGF0ZSA9IHRvX2NkbnNfbWhkcF9icmlk
Z2Vfc3RhdGUoc3RhdGUpOw0KLQkJaWYgKCFjZG5zX2JyaWRnZV9zdGF0ZSkgew0KLQkJCXJldCA9
IC1FSU5WQUw7DQotCQkJZ290byBvdXQ7DQotCQl9DQotDQogCQljdXJyZW50X21vZGUgPSBjZG5z
X2JyaWRnZV9zdGF0ZS0+Y3VycmVudF9tb2RlOw0KIAkJaWYgKCFjdXJyZW50X21vZGUpIHsNCiAJ
CQlyZXQgPSAtRUlOVkFMOw0KLS0gDQoyLjUzLjANCg==
