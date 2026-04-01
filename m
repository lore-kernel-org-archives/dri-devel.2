Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A18E7E350
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0D7910F428;
	Fri,  3 Apr 2026 08:59:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="hg+2F5pQ";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011030.outbound.protection.outlook.com [52.101.65.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C003A10EC8B
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 10:31:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKfne/DbwHYArybL0b/Cqe/ZIpO2uRN5f+dLPZxl88zSg2xjr4gPLpruTgopJvosnbxc/brtOaQq1gLL7/zPSmrGaHslkI6+ytUJ9kShRj7RvkxgZEphB1CxQJp81yrCmnnSwMysQyTEDAp/2XLtX9eKvOYLqjyb6zIYi4Iz0X8Wwrmeliq7n1h54Lzutd6rIVTVCLFbvHsU8I92Fk3xhLaF6+UJA4IqW4h6AXWo4RLzoA5tMPiNxFs7TGIhRMmyWvxngleXe68C7aPJ+MIjaBN0FRrJhTbW1bK7rhw7Y8yAzSEKEZ+48u/jSTXDH2mS+7RE62xsFPihJDfCixcBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNs7f/3wzXEBdPsAPYOP/UVNPFwIcvusa75mz5NVOUE=;
 b=lOEbBzD7IIkUEOa5IOu50nqd/48KyzBvASa+S/+AmCjqY7yCA+wj2EiLZ+J4ZPFmFWA8a5Jx6AAgpicSIqXN+n8J1LSUrp6mV6vWRydy2uGhdAIP4hCLiXQ3sNnunJ5xQNGWlcMuuMSLA6Sjrz5gpOKES0vT77DoFPQ08VXOkqPLPHoJEWYTa0Qr79lFeUfoIh1gPrfxX4GRXlP1VQtFxf4KHJYVZL50kDMDO2tKhu0R/DcFEnY0EJGWkwBoersvOA4ch1qhMaytyhGRtBfdk2P9xQlG2EQIVljpXUMRL9F55bkG2LQdfTvUASX508UhGmuWVtv1s/b5NUKX599Mqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNs7f/3wzXEBdPsAPYOP/UVNPFwIcvusa75mz5NVOUE=;
 b=hg+2F5pQ7hMVCOh2zEaFWxLUwYplT/q4lHugxXcETdXM7YpBqurZMNSDjqNsW7Gf4tCAEjdC5S6EUhq2/cmK5hHJspux95nFFRmyjO35OjRK1nzjKhixKtED+9UApKS437MlYTHcyfAR6k4cBd7OLYWHtEiM5J+ou1dXUJevQZZp4aCPTciJARF004fjxw35fcT0reEdvainyNlzP6EA6y2GZVe5c9II20UWecVtCP34E59x6Em88PBrsROOv+Mi6kEqlI/Yg5I++3pEPGOBY2K8JO1tyvK46UG2rPSJV8IXpDnb6nYsdffnhzxgiA3qTknF726ZA1vHDPcXZxM5bA==
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com (2603:10a6:208:c0::29)
 by DU2PR04MB9066.eurprd04.prod.outlook.com (2603:10a6:10:2f1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 10:31:01 +0000
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f]) by AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f%5]) with mapi id 15.20.9632.017; Wed, 1 Apr 2026
 10:31:01 +0000
From: Guangliu Ding <guangliu.ding@nxp.com>
To: Liviu Dudau <liviu.dudau@arm.com>
CC: "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>, Boris
 Brezillon <boris.brezillon@collabora.com>, Steven Price
 <steven.price@arm.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Jiyu Yang <jiyu.yang@nxp.com>
Subject: RE: Re: Re: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf: Document
 i.MX952 support
Thread-Topic: Re: Re: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf: Document
 i.MX952 support
Thread-Index: AQHcwcKijfE/YRX30UWutgJspDBxgw==
Date: Wed, 1 Apr 2026 10:31:01 +0000
Message-ID: <AM0PR04MB4707335CC7035232D44E6ED9F350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
References: <20260331-master-v1-0-65c8e318d462@nxp.com>
 <20260331-master-v1-1-65c8e318d462@nxp.com> <acva1Xt8V4k9-uG8@e142607>
 <AM0PR04MB47073E9E8B5C704BCF5D9F72F350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
 <99a1da55-d6e5-4d11-abaa-8c85283ab5f2@oss.nxp.com>
 <AM0PR04MB4707B3E37DFE7AEE587DBA2AF350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
 <aczv0R0aQRmHKdvt@e142607>
In-Reply-To: <aczv0R0aQRmHKdvt@e142607>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4707:EE_|DU2PR04MB9066:EE_
x-ms-office365-filtering-correlation-id: 4f4fa9e3-cc56-40b9-47c0-08de8fd9c52c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: n405dbdbaFu0hqyuOWLpjGGk4rYofENRUZiJPEViDEpV9AlXUD7AdTX7kSjXdQkPwo0p33zer9AVocmFwkop2vN6f9P/Qfu/DPTinCgnG7n3Nh4ZsywwmjOrHWgnuoyiJghnae9deIL0aRH2XF+2hNbH1H2rtv7eXuNrIyPdNKqvB93Sl5a66zw61STlEu5dil06ITpNUpY6LXj0TLmAUQ+iu2CdKsrh3oSswRae9uVVmC73u8af1PYptziRTlWzlM+kJ8nbJbk7TqjYcUUKUymiUFV21gFigluZQSdfIikmG4Ks8R4xrh4AGc2caQhk/Tu2Qg68iJ4gsiGXw6JfglhCKUPOoWd8T1g6lpn6Z+MuqkJY0XunuA6SDc9Ydpq9peFAAeEuYiIHKJiuBRes+vR/UuCSEwmBpZg2lW9v+up8dTEz0RXtR0JwAGUVkIFJzyv4qOCGapEoakqYpkfS+L5+EJziTxsUacWibJPaCeTY689nww0Q9lruCpZ064RJnmrFijzcPYH8MzkYnWyDLXqrPr9XHW6PqK3nc+0X6ThHh62y9xbsoERjCsmNI9aarJSIKQdfN2I8YS95Xt1jm5HrmR7SLEuRi/fHiUJ4mVCmxzR+MRl2iDaxMKzbOXi4ZTM0+O5Ub+LdZE6Q1JsoK/B8fMIGoe2QhpsKkOHrwC6Mq40zw8bHTElAKa8xbv8leFY1Igk3xvKibRy5VoT/N85ihRiPZqcFaEgscHZnYGuNtjLWSbnEXWGteLtP+G0LOYPFN9Hlz6Hx9v8VFBidTqHuG/KBCh9WgPyDsZmfZQU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4707.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGtjU21HaGFTSjNDeWhsZ3IvamwyTEJIRTBIN2ZxME9lYW9NT2RSbEZMQStq?=
 =?utf-8?B?ZTEvNjdNc2tNclVFajN5bFhtOE93Y0dLUWpxaG1kQmh2dlM0WDEyZGFjRTR3?=
 =?utf-8?B?S25veTllMytlRkVRbEhWdlRFZHRiY21zN1pUK1VDN1B1UENrdmVLcnExdTVE?=
 =?utf-8?B?bnhwb3ZzeTdyMWRrMkc5cWs1cERwQ29kK1ExSlBoeW9NN2RHQzdkd0p2QTFG?=
 =?utf-8?B?TlBlSURLQ3hvWUcyM2JvbTdqTlZKS2psdjQyRXJ0enJOZDJOQ2l2OS83UldS?=
 =?utf-8?B?M0FUYjdqbVJaa0o0dytuY3B6T0x6NHdheFBhays3dWNhVTlrY0FQSUxlbzdj?=
 =?utf-8?B?WXZKb09KWTdFWmJMWis3MS9ZY1FqeGMxQTFIT1RUMWVzM01hYVROMm53NjdW?=
 =?utf-8?B?bC96Y1BCZHdPU0RweVJQK09NVHcrTVFVNjJ1Nm56K0QvTkFVdTlBZ3ROR2hp?=
 =?utf-8?B?dUNMcWhuZFpYY1gwL1pGTC83Ky9idEYxR2JNT0NEYWJoclM0ZDBqbXZBT3Bx?=
 =?utf-8?B?NjJXM2pqTDdMcm96R00wMVpZU0VPZ0lCb2UxT2VhamgxVWRjdFM4MW1OQS9y?=
 =?utf-8?B?YnkvTDV4RXpBUXpzTE5CVHZ4M1NuSWJjQkh6dnJoYWJBWHRLb244bFhhcjJp?=
 =?utf-8?B?OHppUDRRM3VnNEN4bDczUm1qampmVkpkd3ptSTE3Qkc3OGZkNUhqdWNNNEdO?=
 =?utf-8?B?ZWRhSmR5Z3BLV2xHaTlXeHFkZUZQTXZjSUpzVVNiT0s0QnpJRHNGK0Y4ZmhK?=
 =?utf-8?B?bTBGL1hzS2F3R1pTdXJMdDNBOG0yRUpEMkN5Nk1mL2RYU0NvRFAyOVNSRUFG?=
 =?utf-8?B?R3Q4bVV4ejVDKytvdFlRR1Z3QlRQaS9kaldoVXVjeW5kTzdMTzRPL0w1d1pM?=
 =?utf-8?B?b3ZzVU5nK1czVjBNSkQ0ei9xMWkxVXN3d3pac1VDV2puK3pad1Z6WkdDR0JI?=
 =?utf-8?B?OS9KUUR5dEZoNXBXVDIrckdoaW5FUUhST0ZRSHRNbWJDK0FyMTZVZW90cC9q?=
 =?utf-8?B?YnlYRE9BeWdCSU5EemY0UUdxRFgrZlpXZGdocTlncTU2NUhhY2VOZUR0YUF3?=
 =?utf-8?B?MG9ORHY2aGV2cWdVNFE2ZzVxOHNYWVBOQ1ZicXZkUVIxRWs1RGZmdzFML2Q4?=
 =?utf-8?B?SDliK1JRdDU3cVY0K3lrRlRvb3ZNeWxmb2xNV2hrUkRvM3c2Uld2cjdhRG9u?=
 =?utf-8?B?N0lYbkNjOENlL2ltVXZYbHdWNDhSeVJleDlDUjZORjVWVGY2RHVEMGtUYUxi?=
 =?utf-8?B?TGpEWWZlNXFHbHdoUzgzOXhmMnRaaFA3YkMySUJ2Wm91dFU1MFcvcTlYMHVR?=
 =?utf-8?B?Wks3Y2xlNjA3OVF3eFdIeE1zNDVCa1hHbE9pbmJCVFB4dDBoeE1SQlNub1lI?=
 =?utf-8?B?cXE0OUdnZGh6U3UxWWhKd3gzTTVoNVBOMUxmT0xIQWlYRkZDRGVNdS9FZ25H?=
 =?utf-8?B?c1NxdFRhNTFEV0xjYVBsUUdac29nanlyZUpVTG1nYnFubWJJZkduZE5VVXYx?=
 =?utf-8?B?dHIwRi9pclZtelRIZ1REY3dRbXNpdjV0cnZSSHJqZ3M0bzlyUjVYMjlLUWxJ?=
 =?utf-8?B?WVMzcXVkWGo3QmltUDRpUWJ1MW1ESzdwb0lRNFFQZlFyZ1RJRFpwR0I1R3Zm?=
 =?utf-8?B?TE9iTlUwZmlZNCt3Y2xtTmR1UHN6bFNha1lTdlBZbjQ0V015alkvOE01Qzhp?=
 =?utf-8?B?R3YxRkFyUWYvSlBYTFZ4d1ZJc1BHcjBXRFRzVnFtZjhmTlFpYi9MZHlaWEsy?=
 =?utf-8?B?enlEKzRobGJuOGZrZVRXQkVDZ29XM1FLc1NjYUt6S2VxM3ZJOXMxbHJRaU9o?=
 =?utf-8?B?Uk5wbjNVUWJCQ0syeDRsU29BdlNWUENYTVdjQ251dUxwOXU4QndmN2dIL3R2?=
 =?utf-8?B?ZHJVbUI2SEtSNW1KbVZRZ3VtYmlNYmFCVm56U0hoUGtkZmk5RmhJWW5rZnhH?=
 =?utf-8?B?b2NvUXVQbzlLM2dINFdzTklrRGRCNTNQOGsyK3g4Mi9vbEVqMUZuYWJLNGl0?=
 =?utf-8?B?cTZxckhEcXpOZGVlam9LRUVoamdSZzhJYlJhOEVFV3dYeS9qSFdma3FkdjI1?=
 =?utf-8?B?OS9HM2NITVpUYU00Z2EwS1NOcFFiU1J4MnYvV2p5YXNDWUlSQTZERytCMHFj?=
 =?utf-8?B?VDMvcjZaeFdRK0NoamVPekEzNGc0UXkveDY3dkdCMlFGMXRZR3FSOTFrQXh6?=
 =?utf-8?B?eWc0cmJlM01LVXlsMitaMHhnNmdvYkdEY3Q4QSswc3lCRGdCRWRGVUttNXdL?=
 =?utf-8?B?aGF1UDBhZmFKK0RaTXplTkMyZVpTN1pVdHBCZUNINmVTZmwxS0dGcGZBbTBS?=
 =?utf-8?Q?i2zf0eA00OZ5VLqCVs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4707.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4fa9e3-cc56-40b9-47c0-08de8fd9c52c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 10:31:01.1386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KGrVlKecQUxYHTceLKHT/Wefcz1WcbZKEHxgjrixMRMiMKPM0R9JnR7qoAf2kPywKR/ld/fBcZwoPkSSmdCwxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9066
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

SGkgTGl2aXUNCg0KPiBPbiBXZWQsIEFwciAwMSwgMjAyNiBhdCAwOTo0MzoxMkFNICswMDAwLCBH
dWFuZ2xpdSBEaW5nIHdyb3RlOg0KPiA+IEhpIERhbmllbA0KPiA+DQo+ID4gPiBPbiA0LzEvMjYg
MTE6NDgsIEd1YW5nbGl1IERpbmcgd3JvdGU6DQo+ID4gPiA+IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0
IGVtYWlsIGZyb20gZ3VhbmdsaXUuZGluZ0BueHAuY29tLiBMZWFybiB3aHkNCj4gPiA+ID4gdGhp
cyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZp
Y2F0aW9uDQo+ID4gPiA+IF0NCj4gPiA+ID4NCj4gPiA+ID4gSGkgTGl2aXUNCj4gPiA+ID4NCj4g
PiA+ID4gVGhhbmtzIGZvciB5b3VyIHJldmlldy4gUGxlYXNlIHJlZmVyIHRvIG15IGNvbW1lbnRz
IGJlbG93Og0KPiA+ID4gPg0KPiA+ID4gPj4gT24gVHVlLCBNYXIgMzEsIDIwMjYgYXQgMDY6MTI6
MzhQTSArMDgwMCwgR3VhbmdsaXUgRGluZyB3cm90ZToNCj4gPiA+ID4+PiBBZGQgY29tcGF0aWJs
ZSBzdHJpbmcgb2YgTWFsaSBHMzEwIEdQVSBvbiBpLk1YOTUyIGJvYXJkLg0KPiA+ID4gPj4+DQo+
ID4gPiA+Pj4gU2lnbmVkLW9mZi1ieTogR3VhbmdsaXUgRGluZyA8Z3VhbmdsaXUuZGluZ0BueHAu
Y29tPg0KPiA+ID4gPj4+IFJldmlld2VkLWJ5OiBKaXl1IFlhbmcgPGppeXUueWFuZ0BueHAuY29t
Pg0KPiA+ID4gPj4+IC0tLQ0KPiA+ID4gPj4+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvZ3B1L2FybSxtYWxpLXZhbGhhbGwtY3NmLnlhbWwNCj4gPiA+ID4+PiB8IDENCj4gPiA+
ID4+PiArDQo+ID4gPiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+ID4g
Pj4+DQo+ID4gPiA+Pj4gZGlmZiAtLWdpdA0KPiA+ID4gPj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2dwdS9hcm0sbWFsaS12YWxoYWxsLWNzZi55YW0NCj4gPiA+ID4+PiBs
DQo+ID4gPiA+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvYXJtLG1h
bGktdmFsaGFsbC1jc2YueWFtbA0KPiA+ID4gPj4+IGluZGV4IDhlY2NkNDMzOGEyYi4uNmExMDg0
M2EyNmUyIDEwMDY0NA0KPiA+ID4gPj4+IC0tLQ0KPiA+ID4gPj4+IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2dwdS9hcm0sbWFsaS12YWxoYWxsLWNzZi55YW0NCj4gPiA+ID4+
PiBsDQo+ID4gPiA+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dw
dS9hcm0sbWFsaS12YWxoYWxsLWNzZg0KPiA+ID4gPj4+ICsrKyAueWFtDQo+ID4gPiA+Pj4gKysr
IGwNCj4gPiA+ID4+PiBAQCAtMjAsNiArMjAsNyBAQCBwcm9wZXJ0aWVzOg0KPiA+ID4gPj4+ICAg
ICAgICAgICAgLSBlbnVtOg0KPiA+ID4gPj4+ICAgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4
MTk2LW1hbGkNCj4gPiA+ID4+PiAgICAgICAgICAgICAgICAtIG54cCxpbXg5NS1tYWxpICAgICAg
ICAgICAgIyBHMzEwDQo+ID4gPiA+Pj4gKyAgICAgICAgICAgICAgLSBueHAsaW14OTUyLW1hbGkg
ICAgICAgICAgICMgRzMxMA0KPiA+ID4gPj4gQ2FuIHlvdSBleHBsYWluIHdoeSB0aGlzIGlzIG5l
ZWRlZD8gQ2FuIGl0IG5vdCBiZSBjb3ZlcmVkIGJ5IHRoZQ0KPiA+ID4gPj4gZXhpc3RpbmcgY29t
cGF0aWJsZT8NCj4gPiA+ID4gVGhlcmUgYXJlIGZ1bmN0aW9uYWwgZGlmZmVyZW5jZXMgaW4gR1BV
IG1vZHVsZSAoR1BVTUlYKSBiZXR3ZWVuDQo+ID4gPiA+IGkuTVg5NSBhbmQgaS5NWDk1Mi4gU28g
dGhleSBjYW5ub3QgYmUgZnVsbHkgY292ZXJlZCBieSBhIHNpbmdsZSBleGlzdGluZw0KPiBjb21w
YXRpYmxlLg0KPiA+ID4gPiBPbiBpLk1YOTUyLCBUaGUgR1BVIGNsb2NrIGlzIGNvbnRyb2xsZWQg
YnkgaGFyZHdhcmUgR1BVIGF1dG8NCj4gPiA+ID4gY2xvY2stZ2F0aW5nIG1lY2hhbmlzbSwgd2hp
bGUgdGhlIEdQVSBjbG9jayBpcyBtYW5hZ2VkIGV4cGxpY2l0bHkNCj4gPiA+ID4gYnkgdGhlDQo+
ID4gPiBkcml2ZXIgb24gaS5NWDk1Lg0KPiA+ID4gPiBCZWNhdXNlIG9mIHRoZXNlIGJlaGF2aW9y
YWwgZGlmZmVyZW5jZXMsIHNlcGFyYXRlIGNvbXBhdGlibGUNCj4gPiA+ID4gc3RyaW5ncyAibnhw
LGlteDk1LW1hbGkiIGFuZCAibnhwLGlteDk1Mi1tYWxpIiBhcmUgbmVlZGVkIHRvIGFsbG93DQo+
ID4gPiA+IHRoZSBkcml2ZXIgdG8gaGFuZGxlIHRoZSB0d28gdmFyaWFudHMgaW5kZXBlbmRlbnRs
eSBhbmQgdG8ga2VlcA0KPiA+ID4gPiByb29tIGZvciBmdXR1cmUNCj4gPiA+IGRpdmVyZ2VuY2Uu
DQo+ID4gPg0KPiA+ID4NCj4gPiA+IFRoaXMgaW5mb3JtYXRpb24gc2hvdWxkIGJlIGFkZGVkIGlu
IHRoZSBjb21taXQgbWVzc2FnZSBleHBsYWluaW5nDQo+ID4gPiB3aHkNCj4gPiA+DQo+ID4gPiB0
aGUgY2hhbmdlIGlzIG5lZWRlZC4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gQnV0IHRoZW4gd2hlcmUg
aXMgdGhlIGRyaXZlciBjb2RlIHRha2luZyBjYXJlIG9mIHRoZXNlIGRpZmVyZW5jZXM/DQo+ID4g
Pg0KPiA+DQo+ID4gWWVzLiBDdXJyZW50bHkgdGhlIGRyaXZlciBkb2VzIG5vdCByZXF1aXJlICJu
eHAsaW14OTUyLW1hbGkiIHN0cmluZy4NCj4gPiBIb3dldmVyLCB3aGVuIEdQVSBpcGFfY291bnRl
cnMgYXJlIGVuYWJsZWQgdG8gY2FsY3VsYXRlIHRoZSBHUFUNCj4gPiBidXN5X3RpbWUvaWRsZV90
aW1lIGZvciBHUFUgRFZGUyBmZWF0dXJlLCB0aGV5IHdpbGwgY29uZmxpY3Qgd2l0aCB0aGUNCj4g
PiBoYXJkd2FyZSBHUFUgYXV0byBjbG9ja+KAkWdhdGluZyBtZWNoYW5pc20sIGNhdXNpbmcgR1BV
IGNsb2NrIHRvIHJlbWFpbg0KPiBhbHdheXMgb24uDQo+ID4gSW4gc3VjaCBjYXNlcywgaXBhX2Nv
dW50ZXJzIG5lZWQgdG8gYmUgZGlzYWJsZWQgc28gdGhhdCB0aGUgR1BVIGF1dG8NCj4gPiBjbG9j
a+KAkWdhdGluZyBtZWNoYW5pc20gY2FuIG9wZXJhdGUgbm9ybWFsbHksIHVzaW5nICJueHAsaW14
OTUyLW1hbGkiDQo+IHN0cmluZy4NCj4gDQo+IE9LLCBJIHVuZGVyc3RhbmQgdGhhdCB5b3UncmUg
Zm9sbG93aW5nIGd1aWRhbmNlIGZyb20gc29tZSBvdGhlciBzZW5pb3INCj4gcGVvcGxlIG9uIGhv
dyB0byB1cHN0cmVhbSBwYXRjaGVzIHNvIHlvdSd2ZSB0cmllZCB0byBjcmVhdGUgdGhlIHNtYWxs
ZXN0DQo+IHBhdGNoc2V0IHRvIGVuc3VyZSB0aGF0IGl0IGdldHMgcmV2aWV3ZWQgYW5kIGFjY2Vw
dGVkLCBidXQgaW4gdGhpcyBjYXNlIHdlIG5lZWQNCj4gdG8gc2VlIHRoZSBvdGhlciBwYXRjaGVz
IGFzIHdlbGwgdG8gZGVjaWRlIGlmIHlvdXIgYXBwcm9hY2ggaXMgdGhlIHJpZ2h0IG9uZSBhbmQN
Cj4gd2UgZG8gbmVlZCBhIHNlcGFyYXRlIGNvbXBhdGlibGUgc3RyaW5nLg0KPiANCj4gSWYgZW5h
YmxpbmcgR1BVIGlwYV9jb3VudGVycyBjYXVzZXMgdGhlIGNsb2NrcyB0byBnZXQgc3R1Y2sgYWN0
aXZlLCB0aGF0IGZlZWxzDQo+IGxpa2UgYSBoYXJkd2FyZSBidWcsIHNvIGZpZ3VyaW5nIG91dCBo
b3cgdG8gaGFuZGxlIHRoYXQgaXMgbW9yZSBpbXBvcnRhbnQgdGhhbg0KPiBhZGRpbmcgYSBjb21w
YXRpYmxlIHN0cmluZy4NCj4gDQo+IEVpdGhlciBhZGQgdGhlIHBhdGNoKGVzKSB0aGF0IHVzZSB0
aGUgY29tcGF0aWJsZSB0byB0aGlzIHNlcmllcyBpbiB2Miwgb3IgcHV0IGENCj4gY29tbWVudCBp
biB0aGUgY29tbWl0IG1lc3NhZ2Ugb24gd2hlcmUgd2UgY2FuIHNlZSB0aGUgZHJpdmVyIGNoYW5n
ZXMuDQo+IA0KDQpBY2NvcmRpbmcgdG8gZGlzY3Vzc2lvbnMgd2l0aCB0aGUgR1BVIHZlbmRvciwg
dGhpcyBpcyBhIGhhcmR3YXJlIGxpbWl0YXRpb24gDQpvZiBNYWxpLUczMTAgcmF0aGVyIHRoYW4g
YSBoYXJkd2FyZSBidWcsIGFuZCBpdCBoYXMgYmVlbiBhZGRyZXNzZWQgaW4gbmV3ZXINCk1hbGkg
R1BVIGZhbWlsaWVzLg0KDQpJbiBhZGRpdGlvbiwgaXBhX2NvdW50ZXJzIGFyZSBub3QgZW5hYmxl
ZCBpbiB0aGUgY3VycmVudCBQYW50aG9yIGRyaXZlci4gV2Ugb2JzZXJ2ZWQNCnRoaXMgaXNzdWUg
d2l0aCB0aGUgcHJpdmF0ZSBNYWxpIERESyB3aGVyZSBpcGFfY291bnRlcnMgd2VyZSBlbmFibGVk
Lg0KVGhlcmVmb3JlLCBrZWVwaW5nIHRoZSBjb21wYXRpYmxlIHN0cmluZyBpcyBuZWNlc3Nhcnkg
dG8gYWxsb3cgZm9yIGZ1dHVyZSBkaXZlcmdlbmNlLg0KDQo+IEJlc3QgcmVnYXJkcywNCj4gTGl2
aXUNCj4gDQo+IC0tDQo+ID09PT09PT09PT09PT09PT09PT09DQo+IHwgSSB3b3VsZCBsaWtlIHRv
IHwNCj4gfCBmaXggdGhlIHdvcmxkLCAgfA0KPiB8IGJ1dCB0aGV5J3JlIG5vdCB8DQo+IHwgZ2l2
aW5nIG1lIHRoZSAgIHwNCj4gIFwgc291cmNlIGNvZGUhICAvDQo+ICAgLS0tLS0tLS0tLS0tLS0t
DQo+ICAgICDCr1xfKOODhClfL8KvDQo=
