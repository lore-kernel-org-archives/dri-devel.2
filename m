Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C02AE7E345
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F8710F42F;
	Fri,  3 Apr 2026 08:59:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="MGOwLVCJ";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011044.outbound.protection.outlook.com
 [40.107.130.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C0210F063
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 09:43:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4ZniGqYdrO8cUEX38M65pvwdUKw/rAploibS649kZFWobz1xd2OqmenroFfQDzPYBxtsLZrNPJNrSYIKQ3ocRv8WP8diYW0ZK31MnuoC+aBPZt/MOb6mhHcHN2J32syXXjX8DlbHSSC9tSsRYnAwd8wR9EK321Jb1T7kzYwz8EPYW9bapBZ+7ekKaU4MzFpA8DV+701mrS72MbZKaLC4pD7kp5QAUWgek2sSRvJt2J/YzMNh2d+cpiGq7aVVIjm/GAP/BfTnrxagejDU9+iDXt67RFJpQDCaZX6Ea43r0/JA7uJzmAIYaUJuugC9dCz8bN4feHPyjQSCg2OIKAHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwxZOzLbG8Z9VQnWZqG5iy4TUr8xtsmyS/DqJd9IjXY=;
 b=yyOnk0+2sGf81NSRn0t7xIzBxoty46Q2Zx2JkQCyLparkVSVpqn0RuiA52aYKEptwjxuA3GGDwGmaz7xNk1oWMGl40kxipXTUzFIgi/dI47Gb9VbYbJmWo2NE/CM1by5fs10OS8Kgjab0YzClRGf2CU8Bgf6Mlo4IsCszdU/7xZUE6+TUSU1UxGTp03UjjroQ3DKwFLJyseGLhvTtcBLfIfPInkoxTZlk0+6Af/erJ33vcwyeBvbLJD2VPDk5In3J+r78u1mQrd+7EUjjPR4Kmnlr+0SDhVCJiMyyhBzt+qzlrXq6OsYauBNc8QePB1Am2qtsLdKru6St6WG/+9uQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwxZOzLbG8Z9VQnWZqG5iy4TUr8xtsmyS/DqJd9IjXY=;
 b=MGOwLVCJgSCNWLNKR0aRi4riebOzdiEd6d/MPKY3tC7eTJ+ZTrxO8EF7z6LRnpXIyihYF0oFRgZMPIgILS7f1RPDz0U4m5cWDg5tRrN/vII0B00OBDzFANefNbmWwZsdUt30ZUmnxLmOGUrUriX44FKnQOu3NluRZHqU6pGkLkorbS7Vs0Jl/CURfF7oebvO1hC3v4/xxgQsdEbcLE2uaXLBUldrVPwXiBxKdGYVcaLuraOpWCPVoj/7/tVrkvxv1QPJfQumdm6uf5dTWJAT9JLKYqd0bnRrvTTQsnzHsHzrEJ7kpi/+rXcrSAl5LO1GnBwsV/fc9Dy7TWGekFe5PQ==
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com (2603:10a6:208:c0::29)
 by AM9PR04MB8322.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 09:43:13 +0000
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f]) by AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f%5]) with mapi id 15.20.9632.017; Wed, 1 Apr 2026
 09:43:12 +0000
From: Guangliu Ding <guangliu.ding@nxp.com>
To: "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>, Liviu Dudau
 <liviu.dudau@arm.com>
CC: Daniel Almeida <daniel.almeida@collabora.com>, Alice Ryhl
 <aliceryhl@google.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Frank Li <frank.li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Jiyu Yang <jiyu.yang@nxp.com>
Subject: RE: Re: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf: Document
 i.MX952 support
Thread-Topic: Re: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf: Document
 i.MX952 support
Thread-Index: AQHcwbv0ZywTVM9NA0GloPWCDGJS0A==
Date: Wed, 1 Apr 2026 09:43:12 +0000
Message-ID: <AM0PR04MB4707B3E37DFE7AEE587DBA2AF350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
References: <20260331-master-v1-0-65c8e318d462@nxp.com>
 <20260331-master-v1-1-65c8e318d462@nxp.com> <acva1Xt8V4k9-uG8@e142607>
 <AM0PR04MB47073E9E8B5C704BCF5D9F72F350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
 <99a1da55-d6e5-4d11-abaa-8c85283ab5f2@oss.nxp.com>
In-Reply-To: <99a1da55-d6e5-4d11-abaa-8c85283ab5f2@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4707:EE_|AM9PR04MB8322:EE_
x-ms-office365-filtering-correlation-id: 612aee14-7ace-4b71-500a-08de8fd31765
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|19092799006|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 62FIXqKBMvvXce66wO4PKFUHQYlaSPx0GfA0axJE8nTO0kihRZwA2aUSbxSmRuyzZebhHaTquoriUt48AdsHl/bidZ2BKaeuiFkRJ+I+GV9qeWGx4Vnsir8cMxZVMJCkD5CPlBbhUa9Z1ElmWD6fSoPfQOwpyzdl3QxlYm5XBpvQWMLDSNH5pvE4AgXadSeIMgLduCYg7p9u5EbNHEHchv20gbuM6Cj3nmYowyQzBngODjLr2FTBvlAqEk1aMfLdmwKqKz4ihb8hjPSQeAQbikKWFaU5ED19HbaO8xJJpkEJc6DuFtMc01fmKS/uYGj84xOF15KTivCmWJ8tkT+VW1tlZDV0zpR0aB0fC+ghc0FmozUvu5rx/b2QxCBFNPUt54GKV3J8yHGZc8zzsNdzVnymX4Y3/uG5fraLPEaZZ2zdgqs6wycgAdkEUWXq8r4pFOq6yRrwKJpaxZ00oRP1MPmu1vUpSemLWK/3MUddLaB03aAv5OVyN8nrZHCSqCNIfx36+c96WVwEssBadEQgb6+nm4Y22GtzODQH6ZIoSJ+3OkQhj1DvRLU4h3iQEaOfYwzwg1KvKXbOt6YjMqrB0qKh5jtXHyIA5hj/RDobGRyrLT4Sk+sYxC/4VyDmDiqoI7R08PMdNkU/rQJKl08NfFbBhf3gMjKNSLjzv4c8wDsWucGbl5AqxufGxzlpAhmoGz7APYdJGrtlf8h2+p2HX0AALTMc24r8hwua+OkT1mq6TgAdtNw/k1l9bx8S9kD/kQem9b5r95A6p8uDhmlVe7pKwI/bBmIZYdctF3a3MbM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4707.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(19092799006)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUJ5Z1h5b28wSzU2dmpNVXFVMTJ4aVRSaHVWemEzbXcxRHdCcnFvQlUwc0dC?=
 =?utf-8?B?OVZmV2ZaYkZ4MGRtR3hIWkxDYUdKeEpCODdlNGswbVF1THZrZi9YZ25ZU3JI?=
 =?utf-8?B?cnhYQ2FaKzBhL2pNU05FS1BWamd3bXRDTGVUYVhleEgvbXpHem1RbVZ2SElK?=
 =?utf-8?B?UWVtR3VTdEJ2WnhMNXRwclJXcnZ5V0s1aDd0OEJhWnlBd1doM1RySGNDN29l?=
 =?utf-8?B?M0NRVCtiSDVPTnowbU16aURKLzZVZFgya1hia3VaVWpLek1zdU1yQnBnL1hO?=
 =?utf-8?B?dWRqV3VTQUJLa2RXbkFNWmk5N3l6SlFOdjVPNkYvMnhua3VjTDNPbHEyQWhV?=
 =?utf-8?B?YTlxREFPM1lacjRIcDdxRjUvUVlBK2kwb1E5MWJzYysyMlBPT1h5M2t4YmxN?=
 =?utf-8?B?MFBMRXBDbXVTelBVWjdRLy9La2s1aElXWC9RdzM0a0wvTURNK0ZkSTN1b3VX?=
 =?utf-8?B?LzNxTlhYcmNsZnEwZDFQR280VlByWGMwaTBLL01xcXU2eTlReFhBZ0hHV05l?=
 =?utf-8?B?WDlCakJXOVYwblB3Wm5QT0pLcnJZQzkzSElqYWpMQTNUYm9melV0cWRWZHFs?=
 =?utf-8?B?MXJvTXpjTVo4MVpZMnByZ2Q2d05hVGhYYURseml0d3k4cGpzZmRzUm1lZ3Iv?=
 =?utf-8?B?U0VkOEg0Vk9tWU12MjlvaEhBblN1RDExYjB5ZGFwMWF6UklLM2lrYVJkeWhF?=
 =?utf-8?B?YXgvbGhEZmFxWDZRakwwN1dSb0podmFmdzlmKzg0cFZneDVhTW5YRUVQeVlZ?=
 =?utf-8?B?Z0x4azBYalVQbjZWeHZFZWx0MDJFSTNoNEQrcTZFQll4bDcwNlBlbSt5ejhX?=
 =?utf-8?B?SDRjVHluQXNpRyt3QkpWeFVoa3krTFE1b3FoOEpBbVhDT3pTbnNkdi84dzg4?=
 =?utf-8?B?eXd1VTE1OEhuVnphYTI0amNZazlhcFI3Y21DOVQ1S091cEtZV0ZaOHoxYzdZ?=
 =?utf-8?B?MWJ1OHhnVEhpVmhMRTVsV0hveUd0SFBpWUhkazhBalhqTi9IVUlsSlVKcURO?=
 =?utf-8?B?Q09ISU5FWEptRSs4dlhKLzNYZVBXekRXZGlkZWpNSCtkNUdRZ2VDdUJDZ3dl?=
 =?utf-8?B?enZiaUw2RVJGZGVzR2ZvV1pPU0dXdkhTY0hyQndKQVNGSDBKd095QmluUW1Q?=
 =?utf-8?B?L0lWaHVjbVBWSjBCSDJpUXh2WExNSHRhWTNnRWZvbnlGRjJ3ZE9OK29zdjli?=
 =?utf-8?B?WUE0QjNKWk5JRXBiVTFVRm5mR29BbnlyMWNaa3ZFMEMwQURQdGFDaTBaMWtD?=
 =?utf-8?B?bEFxWGhiOURpMUw3c0dnYXhRVGtUWU8va2NmVkcxWjJoSno1c2hPR1Q5K2RY?=
 =?utf-8?B?bG5wdWVTeHpyNGlHNnNMQUtvbzhyUFh5czFYSDRHWWIrbFIvUUt6WnBXQUNN?=
 =?utf-8?B?WnNmN05ueThEQ0RHOWVwTnpmQ0M4S0pIZXhDcm1VTEx5aEZiUlhHVlhYSEJ1?=
 =?utf-8?B?TUd3Z1dyL1kzbnJIZ29jVlR6M3k5TmNlYVptbjZFemVIZDVDR3Q0U0NwQnhN?=
 =?utf-8?B?QThPdDJncXJ4SmFxZ1pIdjlrbEp4dUhISnhSZitKMmxoa0tJZ0JBZWUyTDZJ?=
 =?utf-8?B?RGI2MEhHaTZHay8xYm5ZNkRxblhEcllzNllCaUNHSXhrN3dJUVVMM2JJemdD?=
 =?utf-8?B?UGk0NGJlMm5IRW9JRFFIajJUbEtqRm5LWEVhbkJQMGZCRVNEMmo3TmdqMTFZ?=
 =?utf-8?B?Um5JOXNVZjZCZVEvQVJIa2ZxdGhkbjRLTVorL1EvRldHVWRLbkpINDZIa2hz?=
 =?utf-8?B?UUtwVzNBV2Rwa3pPUG5TOWRCYjdsWG0rT1Evdk5NRWs0V1IrcmdzUHdhNU5k?=
 =?utf-8?B?TDFGQytIYWNNSTNJYzd6bDhzOTByYnA2d3o4c1Y3VUV0TTl0S3YweDdOWUgy?=
 =?utf-8?B?MFJpL2lSWFRHUXBlbU5CTDNDaUVHaHhTYkViZFh3UHFBYjQwSkRNSStYTjA3?=
 =?utf-8?B?RVppcXFYbnR4NjNCd1ZlQkRzOVdzNk9ORWJySTQ2VEZERUxHcWpndWVVSzhN?=
 =?utf-8?B?NEV6SnRJZVUxeUxsb1lMQzN3R0VKK2lYZ1FyMzY2bEVub2g3KzFPVjMwOUNM?=
 =?utf-8?B?QWhXYmZSREhKd3JvSUE5K1FleDB4OVhyTHNZWEhCY0QrakdTaEhsRENqZjJ3?=
 =?utf-8?B?R1lXenpvUnVzc2tnRWljazZtcldzWHhTdGxCQTY1UFZxSkZIYmkwRDVIZjVF?=
 =?utf-8?B?MXBPbzR4dE5pb3F3cXNFaStaQ0dmd2RwUEdrTDQ0aEJLaWRUWEw3cUJMNjdS?=
 =?utf-8?B?UDI5Y1laZDlBR0ZRems5bVJONUlIZEZ4TTN1clhYS2tZTS9FL1l2eHEwU3Fo?=
 =?utf-8?Q?DFpubTzGA9+4hnAByO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4707.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 612aee14-7ace-4b71-500a-08de8fd31765
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 09:43:12.5945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uelsM+44L0IDww+2vNt31cMIwckefradnP32lxVbqYbdVCjuvO/SiO2+LZv023VqZkKziBDMAbproZ8w8TKWNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8322
X-Mailman-Approved-At: Fri, 03 Apr 2026 08:59:17 +0000
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

SGkgRGFuaWVsDQoNCj4gT24gNC8xLzI2IDExOjQ4LCBHdWFuZ2xpdSBEaW5nIHdyb3RlOg0KPiA+
IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gZ3VhbmdsaXUuZGluZ0BueHAuY29tLiBM
ZWFybiB3aHkgdGhpcw0KPiA+IGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFi
b3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPiA+DQo+ID4gSGkgTGl2aXUNCj4gPg0KPiA+IFRo
YW5rcyBmb3IgeW91ciByZXZpZXcuIFBsZWFzZSByZWZlciB0byBteSBjb21tZW50cyBiZWxvdzoN
Cj4gPg0KPiA+PiBPbiBUdWUsIE1hciAzMSwgMjAyNiBhdCAwNjoxMjozOFBNICswODAwLCBHdWFu
Z2xpdSBEaW5nIHdyb3RlOg0KPiA+Pj4gQWRkIGNvbXBhdGlibGUgc3RyaW5nIG9mIE1hbGkgRzMx
MCBHUFUgb24gaS5NWDk1MiBib2FyZC4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBHdWFu
Z2xpdSBEaW5nIDxndWFuZ2xpdS5kaW5nQG54cC5jb20+DQo+ID4+PiBSZXZpZXdlZC1ieTogSml5
dSBZYW5nIDxqaXl1LnlhbmdAbnhwLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gIERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvYXJtLG1hbGktdmFsaGFsbC1jc2YueWFtbCB8IDEN
Cj4gPj4+ICsNCj4gPj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPj4+DQo+
ID4+PiBkaWZmIC0tZ2l0DQo+ID4+PiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9ncHUvYXJtLG1hbGktdmFsaGFsbC1jc2YueWFtbA0KPiA+PiBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9ncHUvYXJtLG1hbGktdmFsaGFsbC1jc2YueWFtbA0KPiA+Pj4gaW5k
ZXggOGVjY2Q0MzM4YTJiLi42YTEwODQzYTI2ZTIgMTAwNjQ0DQo+ID4+PiAtLS0NCj4gPj4+IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwdS9hcm0sbWFsaS12YWxoYWxsLWNz
Zi55YW1sDQo+ID4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3B1
L2FybSxtYWxpLXZhbGhhbGwtY3NmLnlhbQ0KPiA+Pj4gKysrIGwNCj4gPj4+IEBAIC0yMCw2ICsy
MCw3IEBAIHByb3BlcnRpZXM6DQo+ID4+PiAgICAgICAgICAgIC0gZW51bToNCj4gPj4+ICAgICAg
ICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTk2LW1hbGkNCj4gPj4+ICAgICAgICAgICAgICAgIC0g
bnhwLGlteDk1LW1hbGkgICAgICAgICAgICAjIEczMTANCj4gPj4+ICsgICAgICAgICAgICAgIC0g
bnhwLGlteDk1Mi1tYWxpICAgICAgICAgICAjIEczMTANCj4gPj4gQ2FuIHlvdSBleHBsYWluIHdo
eSB0aGlzIGlzIG5lZWRlZD8gQ2FuIGl0IG5vdCBiZSBjb3ZlcmVkIGJ5IHRoZQ0KPiA+PiBleGlz
dGluZyBjb21wYXRpYmxlPw0KPiA+IFRoZXJlIGFyZSBmdW5jdGlvbmFsIGRpZmZlcmVuY2VzIGlu
IEdQVSBtb2R1bGUgKEdQVU1JWCkgYmV0d2VlbiBpLk1YOTUNCj4gPiBhbmQgaS5NWDk1Mi4gU28g
dGhleSBjYW5ub3QgYmUgZnVsbHkgY292ZXJlZCBieSBhIHNpbmdsZSBleGlzdGluZyBjb21wYXRp
YmxlLg0KPiA+IE9uIGkuTVg5NTIsIFRoZSBHUFUgY2xvY2sgaXMgY29udHJvbGxlZCBieSBoYXJk
d2FyZSBHUFUgYXV0bw0KPiA+IGNsb2NrLWdhdGluZyBtZWNoYW5pc20sIHdoaWxlIHRoZSBHUFUg
Y2xvY2sgaXMgbWFuYWdlZCBleHBsaWNpdGx5IGJ5IHRoZQ0KPiBkcml2ZXIgb24gaS5NWDk1Lg0K
PiA+IEJlY2F1c2Ugb2YgdGhlc2UgYmVoYXZpb3JhbCBkaWZmZXJlbmNlcywgc2VwYXJhdGUgY29t
cGF0aWJsZSBzdHJpbmdzDQo+ID4gIm54cCxpbXg5NS1tYWxpIiBhbmQgIm54cCxpbXg5NTItbWFs
aSIgYXJlIG5lZWRlZCB0byBhbGxvdyB0aGUgZHJpdmVyDQo+ID4gdG8gaGFuZGxlIHRoZSB0d28g
dmFyaWFudHMgaW5kZXBlbmRlbnRseSBhbmQgdG8ga2VlcCByb29tIGZvciBmdXR1cmUNCj4gZGl2
ZXJnZW5jZS4NCj4gDQo+IA0KPiBUaGlzIGluZm9ybWF0aW9uIHNob3VsZCBiZSBhZGRlZCBpbiB0
aGUgY29tbWl0IG1lc3NhZ2UgZXhwbGFpbmluZyB3aHkNCj4gDQo+IHRoZSBjaGFuZ2UgaXMgbmVl
ZGVkLg0KPiANCj4gDQo+IEJ1dCB0aGVuIHdoZXJlIGlzIHRoZSBkcml2ZXIgY29kZSB0YWtpbmcg
Y2FyZSBvZiB0aGVzZSBkaWZlcmVuY2VzPw0KPiANCg0KWWVzLiBDdXJyZW50bHkgdGhlIGRyaXZl
ciBkb2VzIG5vdCByZXF1aXJlICJueHAsaW14OTUyLW1hbGkiIHN0cmluZy4NCkhvd2V2ZXIsIHdo
ZW4gR1BVIGlwYV9jb3VudGVycyBhcmUgZW5hYmxlZCB0byBjYWxjdWxhdGUgdGhlIEdQVSBidXN5
X3RpbWUvaWRsZV90aW1lIGZvciANCkdQVSBEVkZTIGZlYXR1cmUsIHRoZXkgd2lsbCBjb25mbGlj
dCB3aXRoIHRoZSBoYXJkd2FyZSBHUFUgYXV0byBjbG9ja+KAkWdhdGluZyBtZWNoYW5pc20sIA0K
Y2F1c2luZyBHUFUgY2xvY2sgdG8gcmVtYWluIGFsd2F5cyBvbi4NCkluIHN1Y2ggY2FzZXMsIGlw
YV9jb3VudGVycyBuZWVkIHRvIGJlIGRpc2FibGVkIHNvIHRoYXQgdGhlIEdQVSBhdXRvIGNsb2Nr
4oCRZ2F0aW5nIA0KbWVjaGFuaXNtIGNhbiBvcGVyYXRlIG5vcm1hbGx5LCB1c2luZyAibnhwLGlt
eDk1Mi1tYWxpIiBzdHJpbmcuDQo=
