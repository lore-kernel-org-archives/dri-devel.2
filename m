Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A445BD58CD1
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 04:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027A810E3C5;
	Mon, 23 Mar 2026 04:56:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ite.com.tw header.i=@ite.com.tw header.b="ru3PCh0T";
	dkim-atps=neutral
X-Greylist: delayed 430 seconds by postgrey-1.36 at gabe;
 Mon, 23 Mar 2026 04:56:55 UTC
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net
 [60.251.196.230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E1FE10E3C5
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ite.com.tw; s=dkim;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mp+LjzpMuZG850lrYXU8iwy1SSLp2XvPgwtRt5xiQJY=;
 b=ru3PCh0TM2OO9QfHgu+udY78VhedFXOLW1VvKHNtAg2dCWDUj/5k0L8c
 WLNJCcOk8mFtGYFn63gyV5kHzC03VGvT47IJjw3nLMO74Bbq3XpHLMMdr
 9OQniHfzrsF/ZLi+DBesqEptgKGczpLgCkq7jlO1m+3A+aqr4B3HIuMJ5
 MTUsIyxq8DC+Cw3GoNbfonJPWb140Wmvjgk/0xIO1jWgJkkKR6XK5RKTX
 YDD7hic8Blg+rh5HKq5UnEweRMK+jnqv9chfi4YWNiN769hlOT2HYGPC3
 PV7f8P/iJhyLmxngrfga9D8uJWRzHqlVSMXqHwezycvyTNFj+uaPbM5Rk w==;
X-CSE-ConnectionGUID: kb46sQxkQ5+xxebp8RhGxw==
X-CSE-MsgGUID: Wzjc6qxTS0uIwYWA5nG/lA==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
 by ironport.ite.com.tw with ESMTP; 23 Mar 2026 12:43:52 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw
 [192.168.65.58]) by mse.ite.com.tw with ESMTP id 62N4neax025559;
 Mon, 23 Mar 2026 12:49:40 +0800 (+08)
 (envelope-from Hermes.Wu@ite.com.tw)
Received: from CSBMAIL1.internal.ite.com.tw (192.168.65.58) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 12:49:38 +0800
Received: from CSBMAIL1.internal.ite.com.tw ([fe80::d8ab:6241:9e8f:18bf]) by
 CSBMAIL1.internal.ite.com.tw ([fe80::d8ab:6241:9e8f:18bf%16]) with mapi id
 15.02.2562.037; Mon, 23 Mar 2026 12:49:38 +0800
From: <Hermes.Wu@ite.com.tw>
To: <krzk@kernel.org>
CC: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <Pet.Weng@ite.com.tw>,
 <Kenneth.Hung@ite.com.tw>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/2] dt-bindings: display: bridge: Add ITE IT6162 MIPI
 DSI to HDMI bridge
Thread-Topic: [PATCH v4 1/2] dt-bindings: display: bridge: Add ITE IT6162 MIPI
 DSI to HDMI bridge
Thread-Index: AQHct35ADNu8wpErNEW03Aq6VbBCCLW7kYNQ
Date: Mon, 23 Mar 2026 04:49:38 +0000
Message-ID: <fc373843fd524c2ab567dcf09110c33b@ite.com.tw>
References: <20260319-upstream-6162-v4-0-7268483ef03d@ite.com.tw>
 <20260319-upstream-6162-v4-1-7268483ef03d@ite.com.tw>
 <20260319-conscious-grumpy-wren-2b05ee@quoll>
In-Reply-To: <20260319-conscious-grumpy-wren-2b05ee@quoll>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.80.57]
x-tm-snts-smtp: BAC67AFC2EA0CFD98A1126B6AAF5DEFF21CB5DA1B631A9E178D9814D8C1C98412002:8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: mse.ite.com.tw 62N4neax025559
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

SGkNCg0KPk9uIFRodSwgTWFyIDE5LCAyMDI2IGF0IDAyOjM3OjExUE0gKzA4MDAsIEhlcm1lcyBX
dSB3cm90ZToNCj4+IEFkZCBkZXZpY2UgdHJlZSBiaW5kaW5nIGRvY3VtZW50YXRpb24gZm9yIHRo
ZSBJVEUgSVQ2MTYyIE1JUEkgRFNJIHRvIA0KPj4gSERNSSAyLjAgYnJpZGdlIGNoaXAuIFRoZSBJ
VDYxNjIgaXMgYW4gSTJDLWNvbnRyb2xsZWQgYnJpZGdlIHRoYXQgDQo+PiBzdXBwb3J0cyB0aGUg
Zm9sbG93aW5nIGNvbmZpZ3VyYXRpb25zOg0KPj4gDQo+PiAgIC0gU2luZ2xlIE1JUEkgRFNJIGlu
cHV0OiB1cCB0byA0SyBAIDMwSHoNCj4+ICAgLSBEdWFsIE1JUEkgRFNJIGlucHV0IChjb21iaW5l
ZCk6IHVwIHRvIDRLIEAgNjBIeg0KPj4gDQo+PiBUaGUgY2hpcCBhbHNvIHN1cHBvcnRzIHVwIHRv
IDgtY2hhbm5lbCBhdWRpbyBvdXRwdXQgdmlhIDQgSTJTIGRhdGEgDQo+PiBjaGFubmVscy4NCj4+
IA0KPj4gU2lnbmVkLW9mZi1ieTogSGVybWVzIFd1IDxIZXJtZXMud3VAaXRlLmNvbS50dz4NCj4+
IC0tLQ0KPj4gQ2hhbmdlcyBpbiB2NDoNCj4+ICAgLSBEcm9wIGl0ZSxzdXBwb3J0LWhkY3ANCj4+
ICAgLSBEcm9wIGVuZHBvaW50IHByb3BlcnRpZXMgYWxyZWFkeSBpbiB2aWRlby1pbnRlcmZhY2Vz
LnlhbWwNCj4+ICAgLSBGaXggZGF0YS1sYW5lcyBpbiBleGFtcGxlIHdpdGggPDAgMSAyIDM+DQo+
PiAgIC0gQWRkIGJsYW5raW5nIGxpbmUgaW4gZXhhbXBsZSBiZWZvcmUgZW5kcG9pbnQgc3Vibm9k
ZSBzdGFydHMNCj4+ICAgLSBBZGQgcmVzZXQtZ3BpbyBhbmQgcG93ZXIgY29udHJvbHMgdG8gcmVx
dWlyZWQNCj4NCj5SZXZpZXdlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtv
emxvd3NraUBvc3MucXVhbGNvbW0uY29tPg0KPg0KDQpUaGFuayB5b3UgZm9yIHJldmlld2luZw0K
DQo+QmVzdCByZWdhcmRzLA0KPktyenlzenRvZg0KPg0KPg0KDQpCUiwNCkhlcm1lcw0KDQo=
