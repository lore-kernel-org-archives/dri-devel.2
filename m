Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76999FEA816
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 07:17:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8FC910E7B6;
	Wed, 25 Mar 2026 07:17:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ite.com.tw header.i=@ite.com.tw header.b="BPpQfoXr";
	dkim-atps=neutral
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net
 [60.251.196.230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AC9110E7B6
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 07:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ite.com.tw; s=dkim;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bdavyyoUTNKItAHqdOBXRhd77HAxpq2KJ3lt8jJEtj4=;
 b=BPpQfoXrhgc2EOcDfMVtVrC+KRzWl/XiIICbdPkcOj4DSunA9R4yJ0VJ
 pZkTzbzZx/EZ6upJwWiQsw4fX5eWR67sTZViZqYMv+/GcCo9CIiMg7cwn
 S/IDKffvfxverpyAr/oDWx24O/Adz8ls7Kq4SLkp1X18f90SYhKJCwonJ
 Cyq90DE4tb3E1ML/d7MFtR0ZOxz2HM/xA/ZkwL+FSFWSYx/aDeQtTGStw
 ZcdV9tAfUfaXCOA9rOKPvcn9mkV65QZwEu+PbtE59h8i814u6SCCWL9/2
 UgSyDOO350VrCgBp/jT/V2cO/kJR8/ma0RgWJdXsIZHKK5b5W84p7/Zh3 w==;
X-CSE-ConnectionGUID: MFHJV8G9S5Oe7tF9bNs+Nw==
X-CSE-MsgGUID: x5F5Dj5KSXyUWhb2mFvDCg==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
 by ironport.ite.com.tw with ESMTP; 25 Mar 2026 15:11:26 +0800
Received: from hscmail1.internal.ite.com.tw (HSCMAIL2.internal.ite.com.tw
 [192.168.35.41]) by mse.ite.com.tw with ESMTP id 62P7HJQB064344;
 Wed, 25 Mar 2026 15:17:19 +0800 (+08)
 (envelope-from Pet.Weng@ite.com.tw)
Received: from HSCMAIL2.internal.ite.com.tw (192.168.35.41) by
 HSCMAIL2.internal.ite.com.tw (192.168.35.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 15:17:17 +0800
Received: from HSCMAIL2.internal.ite.com.tw ([fe80::b248:38e6:120d:a86f]) by
 HSCMAIL2.internal.ite.com.tw ([fe80::b248:38e6:120d:a86f%15]) with mapi id
 15.02.2562.037; Wed, 25 Mar 2026 15:17:17 +0800
From: <Pet.Weng@ite.com.tw>
To: <krzk@kernel.org>
CC: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <Hermes.Wu@ite.com.tw>, <Kenneth.Hung@ite.com.tw>,
 <Jau-Chih.Tseng@ite.com.tw>, <treapking@google.com>,
 <dmitry.baryshkov@oss.qualcomm.com>
Subject: RE: [PATCH v8 0/2] Add ITE IT61620 MIPI DSI to HDMI bridge driver
Thread-Topic: [PATCH v8 0/2] Add ITE IT61620 MIPI DSI to HDMI bridge driver
Thread-Index: AQHcuD4b8pZ312tun0GZYK1eIkb+LbW4PtIAgAadBnA=
Date: Wed, 25 Mar 2026 07:17:17 +0000
Message-ID: <1a631cd80f4648a79e3024b947d089d8@ite.com.tw>
References: <20260320-it61620-0714-v8-0-0e70271cf5a9@ite.com.tw>
 <20260321-albatross-of-terrific-prestige-95cdbc@quoll>
In-Reply-To: <20260321-albatross-of-terrific-prestige-95cdbc@quoll>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.70.1]
x-tm-snts-smtp: DD5D23E65372F106C74697949AA6642957769EE7C0DEA5D1BBB7EAB109B403002002:8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: mse.ite.com.tw 62P7HJQB064344
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

SGkgS3J6eXN6dG9mLCANCj4gDQo+IE9uIEZyaSwgTWFyIDIwLCAyMDI2IGF0IDAzOjUwOjQwUE0g
KzA4MDAsIFBldCBXZW5nIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMgc3VwcG9y
dCBmb3IgdGhlIElURSBJVDYxNjIwIE1JUEkgRFNJIHRvIEhETUkNCj4gPiBicmlkZ2UgY2hpcC4N
Cj4gPg0KPiA+IFRoZSBJVDYxNjIwIGlzIGFuIEkyQy1jb250cm9sbGVkIGJyaWRnZSB0aGF0IHJl
Y2VpdmVzIE1JUEkgRFNJIGlucHV0DQo+ID4gYW5kIG91dHB1dHMgSERNSSBzaWduYWxzLiBBIHNp
bmdsZS1wb3J0IE1JUEkgRFNJIGlucHV0IGlzIGNvbnZlcnRlZCB0bw0KPiA+IGFuIEhETUkgMS40
IG91dHB1dC4gVGhpcyBzZXJpZXMgaW50cm9kdWNlczoNCj4gPiAtIEEgZGV2aWNlIHRyZWUgYmlu
ZGluZyBZQU1MIGZpbGUgZGVzY3JpYmluZyB0aGUgaGFyZHdhcmUNCj4gPiAtIEEgbmV3IERSTSBi
cmlkZ2UgZHJpdmVyIGltcGxlbWVudGluZyB0aGUgYmFzaWMgZnVuY3Rpb25hbGl0eQ0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogUGV0IFdlbmcgPHBldC53ZW5nQGl0ZS5jb20udHc+DQo+ID4gLS0t
DQo+ID4gQ2hhbmdlcyBpbiB2ODoNCj4gPiAtIGR0LWJpbmRpbmc6DQo+ID4gIDEuIENsYXJpZnkg
dGhlIGhhcmR3YXJlIGRpZmZlcmVuY2VzIGJldHdlZW4gSVQ2MTYyIGFuZCBJVDYxNjIwIGluIHRo
ZQ0KPiA+ICAgICBkZXNjcmlwdGlvbiAoSVQ2MTYyMCBpcyBzaW5nbGUtcG9ydCBhbmQgbGFja3Mg
YW4gaW50ZXJuYWwgTUNVKS4gCVtLcnp5c3p0b2ZdDQo+ID4gIDIuIERyb3BwZWQgUmV2aWV3ZWQt
YnkgZnJvbSBLcnp5c3p0b2YgZHVlIHRvIGRlc2NyaXB0aW9uIGNoYW5nZXMuDQo+IA0KPiBEZXNj
cmlwdGlvbj8gTGlrZSB0ZXh0PyBUaGF0IGlzIHRoZSByZWFzb24gdG8gZHJvcCBzb21lb25lJ3Mg
cmV2aWV3Pw0KPiANCj4gWW91IGFzayB1cyB0byBwZXJmb3JtIHRoZSB3b3JrIHR3aWNlLCBqdXN0
IGJlY2F1c2UgaXJyZWxldmFudCB0aGluZw0KPiBjaGFuZ2VkLiBSZWFkIGNhcmVmdWx5bCB0aGUg
ZG9jcy4NCj4gDQo+IFBsZWFzZSByZWFkOg0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9s
aW51eC92Ni4xMi1yYzMvc291cmNlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBh
dGNoZXMucnN0I0w1NzcNCj4gDQo+IElmIGEgdGFnIHdhcyBub3QgYWRkZWQgb24gcHVycG9zZSwg
cGxlYXNlIHN0YXRlIHdoeSBhbmQgd2hhdCBjaGFuZ2VkLg0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiBLcnp5c3p0b2YNCg0KVGhhbmtzIGZvciB0aGUgY2xhcmlmaWNhdGlvbi4NCg0KVGhlIHVwZGF0
ZSBvbmx5IHJlZmluZXMgdGhlIGRlc2NyaXB0aW9uIHRvIGNsYXJpZnkgdGhlIGhhcmR3YXJlDQpk
aWZmZXJlbmNlcyBhbmQgZG9lcyBub3QgY2hhbmdlIHRoZSBiaW5kaW5nIGl0c2VsZi4NCg0KSSB3
aWxsIGtlZXAgdGhlIFJldmlld2VkLWJ5IHRhZyBpbiB0aGUgbmV4dCB2ZXJzaW9uIHVubGVzcyB0
aGVyZSBhcmUNCm9iamVjdGlvbnMuDQoNCkJlc3QgcmVnYXJkcywNClBldA0K
