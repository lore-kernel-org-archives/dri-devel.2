Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A30C531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C52A10F353;
	Fri, 24 Jul 2026 09:32:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="aJN4iIE1";
	dkim-atps=neutral
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011023.outbound.protection.outlook.com [52.101.125.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD7CB10E010
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 09:32:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYzK81/QBCtYBlYVgR2pqXsK3h964h89QQRPIh/YQAMhte5zM7rj18vYnRzEU2gvWWisbF4e/MrhbI+/QGEfrdnBcC2ApIwiuh0vpySKIMWjTtIf4JaVFaG+ewgQMMVUWSVJF2Nlb8nLbpSwb94PJHpDczXk4dxi6auq8aeSY5t5DAn+T02uRLQ531zwa6nAxQ9O9HXAIrbCsolllRyP7HZEqMEdN2tOgldibsEI/91jpENdy4nBTpv0fxIL3IYVJ4d80xntFxNiIGKkhq9RZ1rxX9hgE8EG+WBQzz5ekI1gMjJH+iE5HphoMWhwzJQUk4x/G9Rs8KqL6p5Wff44Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PdjH0FBP478PKPKn/xjSgX9FUVwFtKb5hxFo1aBqaE=;
 b=us43aaeHz1pPZLeMtZlbLF9kmN0I0sFdm2pXCLfFS/eUPipGpsaOQW+fuQpAhHyuQe+Cl7AidgU5+RqAKjdtsFIbq4esyK1vqjToRL5QEPd+eovs073SI4jnM4g3LXSevgUkmR2t40D7OoZMIvMf3wQxmyo6ucEo3Hz0oexP6biS5pWih8yv5qZ/6UV2nQafNHLMq1ChoCmAOrmm/GDLfZi/TCelYKRQT968O2zIp9tueY29cSPWwLWotxtJUI7clJnmf45IcWcYg01zomz5G21Iag+Q7kC6CrYn192myL4MTg3hH6YgMsszrhbCaT+d+CA6qdhUhRa4Emdmtc03eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PdjH0FBP478PKPKn/xjSgX9FUVwFtKb5hxFo1aBqaE=;
 b=aJN4iIE1KxZMxlXbKB9LyjwLbw4AWYkUp7w5K/2BPpHx/YZ6qWkWxbQnpxXAMVLywPljQGda9pX8UwGY2QW3A5OuNzwpaN3k3vLSpphq1n75LTT2w57RIJArHu3VBMhbaqh/OI2HLb1QKS3BrQrBPcf8N2okpYVIuMqljN/wFyM=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB9523.jpnprd01.prod.outlook.com (2603:1096:400:193::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 09:32:43 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 09:32:31 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
CC: biju.das.au <biju.das.au@gmail.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, Robert
 Foss <rfoss@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>,
 laurent.pinchart <laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
 <linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 01/16] dt-bindings: display: bridge: renesas, dsi: Document
 RZ/G3L
Thread-Topic: [PATCH 01/16] dt-bindings: display: bridge: renesas,dsi:
 Document RZ/G3L
Thread-Index: AQHdC5hXT7Bl3w0M30ul9DikKlntD7ZjUJkAgAAKgnCABrLEgIASalQA
Date: Fri, 24 Jul 2026 09:32:31 +0000
Message-ID: <TY3PR01MB11346D4E610DD535786C9B92F86CF2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260704093433.273672-1-biju.das.jz@bp.renesas.com>
 <20260704093433.273672-2-biju.das.jz@bp.renesas.com>
 <20260708-hopping-exotic-baboon-6c5a46@quoll>
 <TY3PR01MB11346CB08784610C00EBC870A86FF2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20260712-jumping-whimsical-alligator-8fa8ec@quoll>
In-Reply-To: <20260712-jumping-whimsical-alligator-8fa8ec@quoll>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB9523:EE_
x-ms-office365-filtering-correlation-id: 6a644809-803a-428a-3ecc-08dee9667c62
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|11063799006|56012099006|38070700021|10067099003|4143699003|3023799007|22082099003|18002099003;
x-microsoft-antispam-message-info: 93JLoj5q4i64gLMeUPMrpV41X1zBr7J32RXk0jV4zL7c2SJjFEAbWtR61WE1+TivANKspeZFh9p7mLGVQhtoPkuLIKXMv6R9Jwr+cpGK9h/mpGNPdjhiJVEM7q/cfiu1a624Vsx7SMzTgilRl4NdJNG/KCjDzBiNUmdG9Ofgb/0BOkHejliPKUXC7/1iq6ZsdsfF2rqNqwrOzBZFXILRwhgyHTE/ZmUDmnYOi0Y4S9B59kH7OkmpK/WMDJk5xCMKhCVOiT7ZH8ZWVohyKDoT/f6NkVMzR2Ztu28qYOZPQW6LXp6pDRSD/cht/hdBaKsAx3ZVwd+c8pkAaysWui4EI4rGrFiy2Z/mNv8X8UEQaKDP+GkY8fBAkwvs1C1lWiZWCq17U/9Zg4BEt9HdjEYVheb/yNqPVZjT87w0mWUrEf0etRzeum6KcKtbQpAFZKXbWcFzN4cb7r/cOvotsekrsi6uKkfzZ5mC+vHRDuL+HnRGbuXpZ1xa6/6qdzH34Llb/LrbIfvyt5Q/d3v/JH8xXy3wQGpCxYBhCyHzvVALP0solbfmCUYrYDUv41sRIMGxhAE21fwHfbq+KLznwiXDQCEnqGFXp6Q2rF4Uv+WJ8uZfnA+3MYp5kY84CChAA1+ILqgIfs777FsQW1kc1XTXUyGtfiaDv7XybQiup2xUn4c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(11063799006)(56012099006)(38070700021)(10067099003)(4143699003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTQ5a3o5cjJRVUFZQ0tid0RTZ3JNUDd0Ym9uUEhpdFJCN1JmbTFrRkx5bEta?=
 =?utf-8?B?SFBaRVNGckVRQS9vcmw4U0xPbUxWeXpDVlJpUjRRTHRGNjFYRDJwdEpLL0dS?=
 =?utf-8?B?M2lnMUM1YXV2Vlo1NXA3a3pxQWhlTDZoUUdPc0hORk9XWU5lSVprcVFUUnFY?=
 =?utf-8?B?cEMzUUpkRlNYaG94RDl1R1ZGTlRhUDg2WW0rVlBGeGRhN2x1RWQ2dUZ2OU9J?=
 =?utf-8?B?TERJYTQ2U0ViTzJsMmRXRnB6bTFRb1crT2R0WXRkdlZnSTcva29FcER2WGhS?=
 =?utf-8?B?c213bkd6cmhYOVhNdWc0SjUzdWQxeWRzejVFMnQ0Z0wxcytHTklRWDliVmJ3?=
 =?utf-8?B?UVREQUt4YjZka3kvUkZuKzh1MmJSYkFIOXJ2TjZOSDA4djJZS2hIR2VIcFo5?=
 =?utf-8?B?WGdRVm9QRGphMTE5SlcxenFpLzFSU01xUVRFa0VYZmIyQjJsVm1Mc0VZVlVx?=
 =?utf-8?B?Rk9Ic3lKWXNVUFZsN3dpWmlnZzdMSDhEbzJ0NWFDcFpQNDhaMXVqcXFFWUlu?=
 =?utf-8?B?TkloYTN1TTVvVEp3c3VNQ2gwUkRqLzV4ZFhFWTdFS243WXhvRjhvVHRzUEZK?=
 =?utf-8?B?ME5SVm5qMDhWcCtZaDhvbS94NlFwbmhKS2pwaExVTnlhSEJwVXM2NE04VzU1?=
 =?utf-8?B?VkhWMVU5UmxDdU9Cdy9YMmhyd0FjaklEZ1FkcFN2aHpSRXM0ZmtNTDFtS1B1?=
 =?utf-8?B?dWR0QnozakQyRHBQTmh3cW1abEZkRUg5SXVnL0M4d3IrRUQ5aG9VMlQxaXln?=
 =?utf-8?B?UzVGeDl5ZXl1YVl5Q0JaWXJpekczV1JPMEJpRm1EUFRQUGZHK1ZXLzVwZXpD?=
 =?utf-8?B?Y2tpVXZkWDhwMERTKyt1TzYxakVyRUZ5eFRWUURPeDZiZEtnOFJsREZVZTN2?=
 =?utf-8?B?VDRkM2gvbXg4dFNHUklIZmR3eTRia25sd0Zaa0VzR095NyttTUowVkFHcGlZ?=
 =?utf-8?B?OUdodHg3dHFqSkZ3dnUyUlRYM2xKQlM5T3VrMkVQV1lWdUx4TjRYU0tPSFo0?=
 =?utf-8?B?djZZSWRTWFo5QWtwaDMwTlJRTXgvRlFMdkY5bmw1VGY4M3IzZmgzWlc3Um81?=
 =?utf-8?B?eU1JUVJqeGRlalpXQ1ZYY1RhS1FDL3JyalhYeHN4WXNoOThiOUJvKzcvZDV1?=
 =?utf-8?B?eE93TGtNKzRIeXVvUTIxaTA4YU5lQkFLaDkwZFg0ZldVVk1IR3NFa0xWNkR6?=
 =?utf-8?B?TnpYRXFhWEpJMUZqYXJSUkl3VWxIc0NDWGhxZ0RmTDNCVVN3SXhlRHZKVnR2?=
 =?utf-8?B?QndKRFVER2tTV3p4N09CVVZTcVFYaGdiVllNcjViZ3VhcW9jMGs4ZDJHSFdx?=
 =?utf-8?B?elVDdGhLbXhucWZUam1UejlaNlN6SDFkTzVhSDk4eEhQM0dQaTZkaEdhODBN?=
 =?utf-8?B?K0U0T1ZMdDJaNktNdmpXR1IrREhCY2t1cjZhRUI1enNtaURjRXFKdzFrTGRo?=
 =?utf-8?B?OVpZSC9zZVJPcVE4bDZFSWNoL1R1aDg0YlNzdFFPZFJabzlUKzZxa3ByQ0Fk?=
 =?utf-8?B?QWdjcnp2YUZkOU5EV2JIdEJJckNDSGt5OUVJT2NyMGYzSnRsS3F3NWRDdWdi?=
 =?utf-8?B?bGUreUU5NytWYkFnWXd0MnE1S1dhUmpxdlRNenZpWjZKTGZ2VTRhTlZMVE8x?=
 =?utf-8?B?WUhPZzQrUU10ZkM4NVRDbVFtR2Z6eTh6MlVIekxlSTZUOW4vMDZVVCtNSnpO?=
 =?utf-8?B?aEZMNUdIY3Y1SEszNzY5YjZxUVRSbncvK1BYdmw5dXpmTHpVcStzV3BoQ1FP?=
 =?utf-8?B?Z1Jrb0hMMU1GUFZlMGhIQUZFQjNpb3h4VXBvWFFkOVQzQVJVYmlrRHBPOFM5?=
 =?utf-8?B?YVNCa3FaZWxoa3hiT2lQL21BM3hVd1BDQTl5US9LaDFBTVRPSUdFRHNtRW9p?=
 =?utf-8?B?QkVOaHd4QVY4UUVnVXBKemlwK3IxcFBKVytlcUlZZGlSUW85WXRKbTNGUWNr?=
 =?utf-8?B?dHliR1Jhbnh5M2Z4UFo5azlhUGM4OVpwejBRMTQyZk9laEozSmpWLy9RSGdP?=
 =?utf-8?B?ak5EUkQwN3RieThTY0xLSm9kZXVNZGxCTWlSQ2JtRW5QUkZnWnBEeklRN2tj?=
 =?utf-8?B?Uk0xajhBOWZGUGNhWjdTd1hWS0J6RXRLT2x6bWRkdjdLVVIxNU5vTGFGMTMx?=
 =?utf-8?B?N0dzKzd2bC9SZThDbnZqOUx2QjNGcFZKU21acllxQ2wwanRHaUtHZ1hzSk5k?=
 =?utf-8?B?MCs3RUoxUXF1cXdzSTNWTmpCaW1ZVng3Y20reC9oU1dVOUE1TzUwdzNPa1JF?=
 =?utf-8?B?cDl4ZTVUV2MxcWRyWnpjTlZUVTJZTGdKeHlPeEFIODlUVnZWMW5yZkhULzBY?=
 =?utf-8?B?Q0pyZDZtRXY1RnVFN0NjNWVlOFBGa1lJRW1PQXYrRWo5YlFWNnBvQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a644809-803a-428a-3ecc-08dee9667c62
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 09:32:31.5561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3KDJlocDMeGV24lHPGga7HrUcSQdmdaRd3Bw0ZF6JsN6FAs6zegG0edu2sEa19wXLDIab1W4IrCIvSTnnq4DrfZZVe0Jm++9ND99ppZppWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9523
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

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDEy
IEp1bHkgMjAyNiAxNjoyNA0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAxLzE2XSBkdC1iaW5kaW5n
czogZGlzcGxheTogYnJpZGdlOiByZW5lc2FzLGRzaTogRG9jdW1lbnQgUlovRzNMDQo+IA0KPiBP
biBXZWQsIEp1bCAwOCwgMjAyNiBhdCAwOTozOTowMUFNICswMDAwLCBCaWp1IERhcyB3cm90ZToN
Cj4gPiBIaSBLcnp5c3p0b2YgS296bG93c2tpLA0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgZmVl
ZGJhY2suDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9t
OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+ID4gPiBTZW50OiAwOCBK
dWx5IDIwMjYgMDk6MzANCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDEvMTZdIGR0LWJpbmRp
bmdzOiBkaXNwbGF5OiBicmlkZ2U6DQo+ID4gPiByZW5lc2FzLGRzaTogRG9jdW1lbnQgUlovRzNM
DQo+ID4gPg0KPiA+ID4gT24gU2F0LCBKdWwgMDQsIDIwMjYgYXQgMTA6MzQ6MTFBTSArMDEwMCwg
QmlqdSB3cm90ZToNCj4gPiA+ID4gRnJvbTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVz
YXMuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgUlovRzNMIERTSSBJUCBpcyBzaW1pbGFyIHRv
IHRoZSBSWi9HMkwgYnV0IGhhcyBkaWZmZXJlbnQNCj4gPiA+ID4gZ2xvYmFsIFBIWSB0aW1pbmdz
IGFuZCBhbHNvIHRoZSBQTExDTEsgaXMgdW5nYXRlYmxlIGNsb2NrLiBBZGQgdGhlDQo+ID4gPiA+
IGNvbXBhdGlibGUgc3RyaW5nICJyZW5lc2FzLHI5YTA4ZzA0Ni1taXBpLWRzaSIgdG8gaGFuZGxl
IHRoZXNlDQo+ID4gPiA+IGRpZmZlcmVuY2UgZm9yIHRoZSBSZW5lc2FzIFJaL0czTCBTb0MuIFRo
ZSBwb3dlciB0byBEU0kgcmVnaW9uIGlzIGNvbnRyb2xsZWQgYnkgU1lTQyBibG9jay4NCj4gPiA+
ID4gRG9jdW1lbnQgcmVuZXNhcyxzeXNjLXB3cnJkeSBwcm9wZXJ0eSB0byBoYW5kbGUgdGhlIHBv
d2VyIGNvbnRyb2wuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxi
aWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICAuLi4vYmlu
ZGluZ3MvZGlzcGxheS9icmlkZ2UvcmVuZXNhcyxkc2kueWFtbCAgICAgIHwgMTUgKysrKysrKysr
KysrKysrDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQ0KPiA+ID4g
Pg0KPiA+ID4gPiBkaWZmIC0tZ2l0DQo+ID4gPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2Rpc3BsYXkvYnJpZGdlL3JlbmVzYXMsZHNpLnlhbQ0KPiA+ID4gPiBsDQo+ID4g
PiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvYnJpZGdlL3Jl
bmVzYXMsZHNpLnlhbQ0KPiA+ID4gPiBsIGluZGV4IGMyMDYyNWI4NDI1ZS4uYjExNGFjM2IxMTFh
IDEwMDY0NA0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvZGlzcGxheS9icmlkZ2UvcmVuZXNhcyxkc2kueWFtDQo+ID4gPiA+IGwNCj4gPiA+
ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvYnJpZGdl
L3JlbmVzYXMsZHNpDQo+ID4gPiA+ICsrKyAueWFtDQo+ID4gPiA+ICsrKyBsDQo+ID4gPiA+IEBA
IC0yOCw2ICsyOCw3IEBAIHByb3BlcnRpZXM6DQo+ID4gPiA+ICAgICAgICAgICAgLSBjb25zdDog
cmVuZXNhcyxyOWEwOWcwNTctbWlwaS1kc2kNCj4gPiA+ID4NCj4gPiA+ID4gICAgICAgIC0gZW51
bToNCj4gPiA+ID4gKyAgICAgICAgICAtIHJlbmVzYXMscjlhMDhnMDQ2LW1pcGktZHNpICMgUlov
RzNMDQo+ID4gPiA+ICAgICAgICAgICAgLSByZW5lc2FzLHI5YTA5ZzA1Ny1taXBpLWRzaSAjIFJa
L1YySChQKQ0KPiA+ID4gPg0KPiA+ID4gPiAgICByZWc6DQo+ID4gPiA+IEBAIC0xMDgsNiArMTA5
LDIwIEBAIHByb3BlcnRpZXM6DQo+ID4gPiA+ICAgIHBvd2VyLWRvbWFpbnM6DQo+ID4gPiA+ICAg
ICAgbWF4SXRlbXM6IDENCj4gPiA+ID4NCj4gPiA+ID4gKyAgcmVuZXNhcyxzeXNjLXB3cnJkeToN
Cj4gPiA+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiA+ID4gKyAgICAgIFRoZSBzeXN0ZW0gY29u
dHJvbGxlciBQV1JSRFkgaW5kaWNhdGVzIHRvIHRoZSBEU0kgcmVnaW9uLCBpZiB0aGUgcG93ZXIN
Cj4gPiA+ID4gKyAgICAgIHN1cHBseSBpcyByZWFkeS4gUFdSUkRZIG5lZWRzIHRvIGJlIHNldCBk
dXJpbmcgcG93ZXItb24gYmVmb3JlIGFwcGx5aW5nDQo+ID4gPiA+ICsgICAgICBhbnkgb3RoZXIg
c2V0dGluZ3MuIEl0IGFsc28gbmVlZHMgdG8gYmUgc2V0IGJlZm9yZSBwb3dlcmluZyBvZmYgdGhl
IERTSS4NCj4gPiA+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9u
cy9waGFuZGxlLWFycmF5DQo+ID4gPg0KPiA+ID4gVGhpcyBmZWVscyBhIGxvdCBsaWtlIGEgcG93
ZXIgZG9tYWluLiBQbGVhc2UgZWxhYm9yYXRlIHdoYXQgaXMNCj4gPiA+IFBXUlJEWSBhbmQgd2h5
IHBvd2VyLW9uL29mZiBhbmQgcG93ZXIgc3RhdHVzIHdpdGhpbiBTb0MgKGltcG9ydGFudCEpIGlz
IG5vdCBlbmNvZGVkIGFzIHBvd2VyIGRvbWFpbi4NCj4gPg0KPiA+IFdlIGFscmVhZHkgdHJpZWQg
bW9kZWxsaW5nIHNpZ25hbCBhcyBwb3dlciBkb21haW4gaW4gUlovRzNTIGFuZA0KPiA+IGZpbmFs
bHkgVWxmIGFncmVlZCB0aGF0IGl0IGNhbm5vdCBiZSBwb3dlci1kb21haW5bMV0NCj4gPg0KPiA+
ICIgU1lTQyBzaWduYWwgc2VlbXMgYmVzdCB0byBiZSBtb2RlbGxlZCBhcyBhIHJlc2V0Lg0KPiA+
IEFsdGhvdWdoLCBpdCBsb29rcyBsaWtlIHRoZSBVU0IgUE0gZG9tYWluIHByb3ZpZGVyIHNob3Vs
ZCByYXRoZXIgYmUNCj4gPiB0aGUgY29uc3VtZXIgb2YgdGhhdCByZXNldCwgaW5zdGVhZCBvZiBo
YXZpbmcgdGhlIHJlc2V0IGJlaW5nIGNvbnN1bWVkDQo+ID4gYnkgdGhlIGNvbnN1bWVycyBvZiB0
aGUgVVNCIFBNIGRvbWFpbi4iDQo+ID4NCj4gPiBUaGVuIFBoaWxsaXAgcHJvcG9zZWQgcG93ZXIg
c2VxdWVuY2luZyBkcml2ZXJbMl0gYW5kIGZpbmFsbHkgaGUgYW5kDQo+ID4gUm9iIG9rIGZvciB0
aGUgc29sdXRpb24gWzNdDQo+IA0KPiBUaGUgcHJvYmxlbSBpcyB0aGF0IHlvdSBkaWQgbm90IGlt
cGxlbWVudCBvciByZWZlcmVuY2UgaGVyZSBwb3dlciBzZXF1ZW5jaW5nLiBZb3UgY3JlYXRlZCBw
aGFuZGxlIHdpdGhvdXQNCj4gY29ycmVzcG9uZGluZyBhbnkgaGFyZHdhcmUgc2lnbmFsIGFuZCB1
c2VkICJkcml2ZXIiIGFzIGFuIGFyZ3VtZW50Lg0KPiANCj4gcG93ZXIgc2VxdWVuY2luZyBkb2Vz
IG5vdCBtZWFuIHlvdSBjYW4gc3R1ZmYgcmFuZG9tIHBoYW5kbGVzIGhlcmUgYW5kIHRoZXJlLg0K
DQpDYW4geW91IHBsZWFzZSBwcm92aWRlIHNvbWUgcG9pbnRlcnMgZm9yIHRoZSBiaW5kaW5nIGFu
ZCBvdGhlciBzdHVmZiB0byBtb2RlbCB0aGlzIGFzDQpwb3dlciBzZXF1ZW5jZSBkcml2ZXI/DQoN
ClNZU0MgZHJpdmVyIGhhcyBQV1JSRFkgcmVnaXN0ZXIgKGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQvdHJlZS9kcml2ZXJz
L3NvYy9yZW5lc2FzL3I5YTA4ZzA0Ni1zeXNjLmM/aD1uZXh0LTIwMjYwNzIzI24yOCkNCg0KSXQg
Q29udHJvbHMgUFdSUkRZIHRlcm1pbmFsIG9mIFVTQiwgRFNJIGFuZCBDU0kNCjA6IFBXUlJEWQ0K
MTogUFdSUkRZIGRvd24NCg0KWW91IG1lYW4gUG93ZXIgc2VxdWVuY2UgaGFzIGEgaGFuZGxlIHRv
IHN5c2MgSVAuIFBsZWFzZSBsZXQgbWUga25vdy4NCg0KVGhlcmUgaXMgbm8gb3RoZXIgcmVzb3Vy
Y2UgYXBhcnQgZnJvbSBwaGFuZGxlIHRvIFNZU0MuDQoNCiAgICBzeXMtcG93ZXItcmVhZHkgew0K
ICAgICAgICBjb21wYXRpYmxlID0gInJlbmVzYXMsIHI5YTA4ZzA0Ni1zeXM9cHdycmR5IjsNCgkg
IHJlbmVzYXMsc3lzYy1wd3JyZHkgPSA8JnN5c2MgMHhkNzA+Ow0KICAgIH07DQoNCiAgIHBoeXJz
dDogdXNicGh5LWN0cmxAMTFlMDAwMDAgew0KCQkJY29tcGF0aWJsZSA9ICJyZW5lc2FzLHI5YTA4
ZzA0Ni11c2JwaHktY3RybCI7DQoJCQlyZWcgPSA8MCAweDExZTAwMDAwIDAgMHgxMDAwMD47DQoN
CgkJCXBoeXJzdC1wb3dlci1zZXF1ZW5jZSA9IDwmc3lzLXBvd2VyLXJlYWR5IDE+Ow0KICAgfQ0K
DQogICAgZHNpOiBkc2lAMTA4NTAwMDAgew0KCQkJY29tcGF0aWJsZSA9ICJyZW5lc2FzLHI5YTA4
ZzA0Ni1taXBpLWRzaSI7DQoJCQlyZWcgPSA8MCAweDEwODUwMDAwIDAgMHgyMDAwMD47DQoNCgkJ
CWRzaS1wb3dlci1zZXF1ZW5jZSA9IDwmc3lzLXBvd2VyLXJlYWR5IDI+Ow0KICAgfQ0KDQpDdXJy
ZW50bHkgaXQgaXMgbW9kZWxsZWQgYXMsDQoNCiAgIHBoeXJzdDogdXNicGh5LWN0cmxAMTFlMDAw
MDAgew0KCQkJY29tcGF0aWJsZSA9ICJyZW5lc2FzLHI5YTA4ZzA0Ni11c2JwaHktY3RybCI7DQoJ
CQlyZWcgPSA8MCAweDExZTAwMDAwIDAgMHgxMDAwMD47DQoNCgkJCXJlbmVzYXMsc3lzYy1wd3Jy
ZHkgPSA8JnN5c2MgMHhkNzAgMT47DQogICB9DQoNCiAgIGRzaTogZHNpQDEwODUwMDAwIHsNCgkJ
CWNvbXBhdGlibGUgPSAicmVuZXNhcyxyOWEwOGcwNDYtbWlwaS1kc2kiOw0KCQkJcmVnID0gPDAg
MHgxMDg1MDAwMCAwIDB4MjAwMDA+Ow0KDQoJCQlyZW5lc2FzLHN5c2MtcHdycmR5ID0gPCZzeXNj
IDB4ZDcwIDI+Ow0KICAgfQ0KDQpDaGVlcnMsDQpCaWp1DQoNCg0K
