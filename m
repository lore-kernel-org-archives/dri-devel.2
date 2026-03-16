Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAEDD58B0D
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 04:03:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1549B10E2AF;
	Mon, 16 Mar 2026 04:03:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ite.com.tw header.i=@ite.com.tw header.b="Hg2HgKZI";
	dkim-atps=neutral
Received: from ironport.ite.com.tw (219-87-157-213.static.tfn.net.tw
 [219.87.157.213])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9452110E2AF
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 04:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ite.com.tw; s=dkim;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vOuZ5YEbCZZDLW9CYiHZv/UOnprW0pRVMy0ioFpd5+w=;
 b=Hg2HgKZIsnhzYD4rxNnbSz/pn5uNCc+EbRpkfEgESz+CW5AFmvhQfkI1
 Irc9DudOCWCEFOdChZpHBWp31ZA9c4dcwaNzxPa/ExzQGqUoz8uU+nVSs
 0rIeBvBHmhO1arCJ/tQYcQ8m50LreGDcj5gNk4Gt1wyTYO+BZuKoMnXbM
 Crf2Mfjnym8Q4OlCYEN3z/Obeh2+TSfC6Q0aaYH1FqYROt3iklKklQgI0
 KFTaNv6qz0+24u7DzJwRA8s7LkPM+ODGwwBS3+RbEUN6lwncIXt7yo+Rn
 v+thamELQ86Qc4DdyZe/OzZXLQNIGP5KJ2HvbDU2pQu2EyOWDAIUZECwN g==;
X-CSE-ConnectionGUID: glXo0tQQSM+koOMHCLHpgQ==
X-CSE-MsgGUID: WySOr+I6Ste0QNNQnjw3AA==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
 by ironport.ite.com.tw with ESMTP; 16 Mar 2026 11:50:24 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw
 [192.168.65.58]) by mse.ite.com.tw with ESMTP id 62G3thf6054905;
 Mon, 16 Mar 2026 11:55:43 +0800 (+08)
 (envelope-from Pet.Weng@ite.com.tw)
Received: from CSBMAIL2.internal.ite.com.tw (192.168.65.41) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 11:55:41 +0800
Received: from CSBMAIL2.internal.ite.com.tw ([fe80::9446:9aa0:fea6:7e92]) by
 CSBMAIL2.internal.ite.com.tw ([fe80::9446:9aa0:fea6:7e92%15]) with mapi id
 15.02.2562.035; Mon, 16 Mar 2026 11:55:41 +0800
From: <Pet.Weng@ite.com.tw>
To: <krzk@kernel.org>, <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, 
 <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>,
 <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <Hermes.Wu@ite.com.tw>,
 <Kenneth.Hung@ite.com.tw>, <Jau-Chih.Tseng@ite.com.tw>,
 <treapking@google.com>, <krzysztof.kozlowski@oss.qualcomm.com>
Subject: RE: [PATCH v7 1/2] dt-binding: display: Add ITE IT61620 MIPI DSI to
 HDMI bridge
Thread-Topic: [PATCH v7 1/2] dt-binding: display: Add ITE IT61620 MIPI DSI to
 HDMI bridge
Thread-Index: AQHcs5VEhw2PGpehd0Ola7L0HsAAuLWwiB/g
Date: Mon, 16 Mar 2026 03:55:41 +0000
Message-ID: <15aa9069d5f341eb82815f4b9da54fa0@ite.com.tw>
References: <20260313-it61620-0714-v7-0-36a16dc036d6@ite.com.tw>
 <20260313-it61620-0714-v7-1-36a16dc036d6@ite.com.tw>
 <21cc3b90-0cd7-421c-914d-30e718558224@kernel.org>
In-Reply-To: <21cc3b90-0cd7-421c-914d-30e718558224@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.70.1]
x-tm-snts-smtp: 1306098BDF4E2B5173E91D3163A79F321913FC930EAFDE001D8EF815AC2FECB42002:8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: mse.ite.com.tw 62G3thf6054905
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

SGkgS3J6eXN6dG9mLA0KPiANCj4gT24gMTMvMDMvMjAyNiAwNzo0OCwgUGV0IFdlbmcgd3JvdGU6
DQo+ID4gVGhpcyBjaGlwIHJlY2VpdmVzIE1JUEkgRFNJIGlucHV0IGFuZCBvdXRwdXRzIEhETUks
IGFuZCBpcyBjb21tb25seQ0KPiA+IGNvbm5lY3RlZCB0byBTb0NzIHZpYSBJMkMgYW5kIERTSS4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBldCBXZW5nIDxwZXQud2VuZ0BpdGUuY29tLnR3Pg0K
PiA+IFJldmlld2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tp
QG9zcy5xdWFsY29tbS5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9kaXNwbGF5L2Jy
aWRnZS9pdGUsaXQ2MTYyMC55YW1sICAgICAgIHwgMTQyICsrKysrKysrKysrKysrKysrKysrKw0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQyIGluc2VydGlvbnMoKykNCj4gDQo+IA0KPiBUaGlzIGlz
IGFsbW9zdCB0aGUgc2FtZSBhcyBpdGUsaXQ2MTYyLiBBbG1vc3QgdGhlIHNhbWUgYmluZGluZywg
c2FtZQ0KPiBkZXNjcmlwdGlvbi4gQWxzbyBnb29nbGUgZmluZHMgbm90aGluZyBmb3IgaXRlLGl0
NjE2MjAuDQo+IA0KPiBMb29rcyBsaWtlIHNvbWUgZHVwbGljYXRlIGFuZCB5b3VyIGNvdmVyIGxl
dHRlciBkb2VzIG5vdCBleHBsYWluIGhlcmUNCj4gYW55dGhpbmcuDQo+IA0KDQpJVDYxNjIwIGlz
IGEgdmFyaWFudCBvZiBJVDYxNjIuDQpUaGUgbWFpbiBkaWZmZXJlbmNlcyBhcmU6DQotIElUNjE2
MjAgc3VwcG9ydHMgb25seSBhIHNpbmdsZSBNSVBJIERTSSBpbnB1dCBwb3J0LCB3aGlsZSBJVDYx
NjINCiAgc3VwcG9ydHMgZHVhbCBNSVBJIERTSSBwb3J0cy4NCi0gSVQ2MTYyMCBkb2VzIG5vdCBp
bmNsdWRlIHRoZSBpbnRlcm5hbCBNQ1UgcHJlc2VudCBpbiBJVDYxNjIuDQoNCkJlY2F1c2Ugb2Yg
dGhlc2UgYXJjaGl0ZWN0dXJhbCBkaWZmZXJlbmNlcywgSVQ2MTYyMCB1c2VzIGEgc2VwYXJhdGUN
CmNvbXBhdGlibGUgc3RyaW5nIGV2ZW4gdGhvdWdoIHRoZSBleHRlcm5hbCBpbnRlcmZhY2VzIGFu
ZCBiaW5kaW5ncw0KYXJlIGxhcmdlbHkgc2ltaWxhci4NCg0KSSB3aWxsIHVwZGF0ZSB0aGUgYmlu
ZGluZyBkZXNjcmlwdGlvbiBhbmQgY292ZXIgbGV0dGVyIHRvIGNsYXJpZnkNCnRoZXNlIGRpZmZl
cmVuY2VzDQoNCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KQmVzdCByZWdhcmRzLA0K
UGV0IFdlbmcNCg==
