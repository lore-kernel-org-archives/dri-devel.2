Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE05E7E345
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D375910F381;
	Fri,  3 Apr 2026 08:59:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="HRnQS8kt";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010071.outbound.protection.outlook.com [52.101.69.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0350210EE90
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 18:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fs6UdFsMcmmHB13e19c2hsoeDC64BQuuN0RUa8UuMOU1DtswAL3OboPn835D/5/AJyLIwy70jDDaIITd53g7Dnezw65ejuDa7hDMGghMveVdvT10r/Z7a2+FNEX5tUlU75LXRJ1tiacpHpEUN3j3haKK/OlcAw8+87QCvLTc813nbo0OzEuukNI89S+w7ZPQR4CXL1DHIB5Jojb8xuB2qbmJT3vVpfpanSSiCDond1b7YFVixpE5gDET1AXgrgtwuqMTzIDfN0Du84+RQXxpWNDi7L31eCyDKDo0wR6RCiT6li13CwB/7OsF0lY8PW4+8sez1/TQNOMU/RqSGU9wzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9GDSi5mKvmlhIAWkEfloXLT+wz5WC2VIqOhvLdpp7E=;
 b=RVfQ81nTT9Cy8lBlVb+S+3KiPYOUqXvSZvaDoXEpUIg2ovUFylHU/QUpqHmQQRW1IukKAm07lVfz8RIvhI7uceBU3v6MCT5/PXcf2ZLS3Meu5/4dHC7H3bjxunTCSNKZIEtA0aRqhQmvlJhSR/ws9p+mk649XtAwJxB1Aqx/wdcOLtp/nxAssLJMq+ZpIG9SGgcYGpQ+NgLyNbO49vk1spzuf7xDQup8PWwKe7oB/y0SCI4lmNYdGPJC6eevoksr6zb8fGvl/iHxu6rh8us82AEDMRCFh/jwkOLCbXMMZmW/YAkrvWERvrYMHWP0LOuWlYFjzFP5GSQUbtokSdfetw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9GDSi5mKvmlhIAWkEfloXLT+wz5WC2VIqOhvLdpp7E=;
 b=HRnQS8ktM+BCFTmNecapY9KhJ6JumcXmbHK0GIc/gKsnIn7FXD/lV6N3Qu58LNXKGk1QeU3XVN1ImUA9vXrDRT3jEOirS7rMQPEoGSuQoEtZkXQsoHiq3o6kUnZelx4f78q0AFsNAHSTksqtmwSwCIy8H9jwoI8L2DGf51Rr2ggxhbvDOI8OBUUgpAK8mcrNqzfzgjzsHXSgGXGtFJ2l6wHhMzZQSxH/OjLt1empL9y98hp2UlFY3YOsk/xPUp7SmHR1rdhfzjHpfCEpCbAK/iy2CYMk9lMdeKr/j+uHQQWi2nTe5JQ/0R/tag5RrXGVP3adS79HIJPj5F2tsfyrUQ==
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com (2603:10a6:208:c0::29)
 by GV2PR04MB11636.eurprd04.prod.outlook.com (2603:10a6:150:2b0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 18:03:28 +0000
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f]) by AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f%5]) with mapi id 15.20.9632.017; Wed, 1 Apr 2026
 18:03:28 +0000
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
Subject: RE: Re: Re: Re: Re: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf:
 Document i.MX952 support
Thread-Topic: Re: Re: Re: Re: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf:
 Document i.MX952 support
Thread-Index: AQHcwgHX0ZfeKxPr00Wsq/HLBheKeQ==
Date: Wed, 1 Apr 2026 18:03:28 +0000
Message-ID: <AM0PR04MB470716BD5A538CFBB6685C87F350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
References: <20260331-master-v1-0-65c8e318d462@nxp.com>
 <20260331-master-v1-1-65c8e318d462@nxp.com> <acva1Xt8V4k9-uG8@e142607>
 <AM0PR04MB47073E9E8B5C704BCF5D9F72F350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
 <99a1da55-d6e5-4d11-abaa-8c85283ab5f2@oss.nxp.com>
 <AM0PR04MB4707B3E37DFE7AEE587DBA2AF350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
 <aczv0R0aQRmHKdvt@e142607>
 <AM0PR04MB4707335CC7035232D44E6ED9F350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
 <ac05OpEMjKMd8CXy@e142607>
 <AM0PR04MB4707604AF2C445971C7474EFF350A@AM0PR04MB4707.eurprd04.prod.outlook.com>
 <ac1T282yvpdAp_TP@e142607>
In-Reply-To: <ac1T282yvpdAp_TP@e142607>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4707:EE_|GV2PR04MB11636:EE_
x-ms-office365-filtering-correlation-id: b1e5ad15-3e5a-48d0-fa48-08de9018fa68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|19092799006|1800799024|366016|376014|7416014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 9NwrrTIf1hfYz29bV2Qki3oa+v27FxBlT4WGe06RsgfOmG/ihwne9PZvrnjtWMLhM5EALGQWw5/h9DXOtaMARj2sZvCTlmCQ0u+u1LOXTpSB7KFmHXv57c8QxjC5yakXOvZWXk3qAPR5QX5/svxr1+M5P8834Ljn5Agaod9+4oKVNd2m37n1/4U2b+QcsJFVKEpSbRu1dChrOb4/HFvHFqo+7Iu1PqY1ndjLnkStSas68NRyTzbjqsUJVANCDKMecAX4m6D2p5NlQ+cWsHFAsfflXTgg5NMJEorttCFrq7HYYuzVC05iobnXNMz2mEc85B5Hs9nkcDONubh+B9ffFtq5UeH7eFOO79K7Zm/1LkBODWPvfhBmlviHX2+5dOo9+tDPiihFs6pqAAOqPaez7oK2iv3ObRGHrzs6WS/7ImBD3NiAGOTqqmoxxdjadt6lvOCnv77WQh9C5NXbKVrOi7xsUM0HZlwTtNYln4ZCQAJDLRFICmdrBNmyzgkuI23qpIbQNuJgj8NZ2LAv1G7FhTjdooXo0aUDrkbTlq2Gs3txsU/6QGM9bkyikKJSKXdjktwuHtv/ILMwt/dlBVW/VSwamQCxX6VH25KaeeTft3I7f2rO40/M5/Eo4lUvPJx5vv78r+zaRLkiwPRB4g2hqpK8fDwiNaWJQDdp5o0bd0rr2QU2jXT0PMjWymkfgJQX7wxB7VV6fnjSXvo0qH+4R2T68mkQlW9E9zNSxBhP9nNeLwKSR+UsTH1B5Km+qrSlwZKh5aK/A+pmZsjiN9aNGooEmiXQYWXnwZQJdrZ73/E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4707.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(19092799006)(1800799024)(366016)(376014)(7416014)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUFwQzBUNnlrNDZUVXlnUG9Yb2hPNEg3ZTBFa0Y4TlEzMytFQU52N1F4ckk2?=
 =?utf-8?B?TktXNjMvT1YzY1ZjbVdGR1ZRdzlXMzJjM0dLOFZLUnhLTzh4NHArYTE0NlBn?=
 =?utf-8?B?Sk5IdzBkWlV5eEYzYjNkb3l5VjlPT2M4dms4UFZEaXhkQUgzNVlYVlZYcmpQ?=
 =?utf-8?B?ZWsyZW9aWEFZK2NxdTlsUEI0a0xpZ010NkprT09lSHBOclBBZHNIVk5HNE1Y?=
 =?utf-8?B?azZoZmlkYVBDOXV3UVJrdVM3dndhYjRKOGEzaHRtSkhMeFJ6bGQwb3pzcyt0?=
 =?utf-8?B?R0lUOVNSVHRhN1RuTFFMMkJTVXRjK2N4c1NzbS9iSjJLUTFmNTVFZlQ2NFkw?=
 =?utf-8?B?TGJPWmdPSk1QQTNaRCtBTkVVZHNmODhpYmFyQTdjaTVRTzZBbFZmQWlUczBr?=
 =?utf-8?B?eHlSWXVoakoxWWcyRkhVUHBacGQvYUtBNHFPL3hBOUluN0JJbXlCSlhOTHpK?=
 =?utf-8?B?cURDa1gxcng1VStwWUgvS0Z3akVQY2VvWlNJbXU4YkZ0eDBsZThVYUJIcFZT?=
 =?utf-8?B?WTdBNlRFK05QMWVpdHpWem1oWG5kQkc2Y21VQXNURG1veXhtbllVQXl1NWFp?=
 =?utf-8?B?TklUSUJoL1JTUUdiSDRnMUljT1dJSFgyRzRxQkVqVm01NUFhRFlORnhqcWJq?=
 =?utf-8?B?VE41RlFURURVek85Nm1rSjVCcUdOQTM0NkN2YVpsZ09rclN5NklKZWhiWFhx?=
 =?utf-8?B?QjlFakZKaVBQZUgxdHQvUGdjMHQvTVhuZmFyWWEwa0FOdVZNd085WXgxYlNE?=
 =?utf-8?B?T3pzSktkOXdvY093RFlVQXVoZ0JLeHNybXhlQ05VakgvK3dseXk2TGd5OTJn?=
 =?utf-8?B?KzltcGdSbnBnZ2psQ3dUZExOdWh0dENYUUJXa2ZtUnBJZ2xVd0pWZE0xT21P?=
 =?utf-8?B?KzFtbVBMNEhlSzFoeXduWmZCc1VZVEpIbmFqVjdMcG5BZTNYTFJjYTA3M2hM?=
 =?utf-8?B?RUliWmlZc0F2bUpXV0xuWldIdVB5Sm96c0NIK3ZRMDlRYkJHblJqdDZWQUhD?=
 =?utf-8?B?Z2hzNEExR2lhUTg0R2JCbkRIMWFNSnBFeVV1TEI3Q0o1T3VjYjVBdEttbUw4?=
 =?utf-8?B?VCtoRGg0RnQ0aE1sd3FIQ2QwNFN5MUNaVEhuMGMyWmljOUgxWGc4TXlyQ3B1?=
 =?utf-8?B?VVc3TlZOa1R4cWdralBrQmpYNTdyZXIrK2kzWEpIbXVaQzZFRVNlVjFNMita?=
 =?utf-8?B?NURsN29EUXhZaS9SNUZFMFNjc0hCalY2RHpuYnBxQTRmbW9ZeDRjalJyYXU1?=
 =?utf-8?B?cHE4eENsb295Z2JKN0tqNXI3ZDBvazhWV3hJeEFBTHEwSlBKRnliOWpuZGxm?=
 =?utf-8?B?LzJKTXlyTXVJSGtTRUNNWlVPZkFIUjJZSllPWkpGdUlUSFVGNHdXbVZtRTNs?=
 =?utf-8?B?VTFodFNRWXB4Q2tnUXBTTUNmQVVyUTdkWC9PdnNhazV1bytRRG91b0h4UEZt?=
 =?utf-8?B?ZGtBUUpJQUJjNUVYd1U3SkN1a1dwTHVyTlZDWDNIK2xqUjlYdmZHU1BNbVZ6?=
 =?utf-8?B?aEo4eisvNy9tS3RWdG1hVmFpSUh1VGoxRTFKUU1RaERhUE1UdE5ZanNWYlFo?=
 =?utf-8?B?MGtyRzBpVTlLVEIwZm0wK3k0blVLeDNFWnM3UWI3aEhPZFkrWEVJR2I0NXZj?=
 =?utf-8?B?Qy9BY1dqSHJYdFVqcTdPT1NmcGRuZnFwQkxOWXhjQWQ2djUvcVZzZDlMSUFI?=
 =?utf-8?B?ZmRrbnJwR1Z6N1dhSjlHOEE0ZjMxc3VCNHM0V2lENDFDRXh3TnRpRWt5d2I1?=
 =?utf-8?B?ZkFxTmtmT1FuOU0zelJ4bUh5UjJodGNsOGpJN1FUbSt2dFVERzlleGVFYTB1?=
 =?utf-8?B?ZTN6V2ZBUERPZXp0QmFJTVBiaGlyQVZFNkJrSjdCMVR6b0dDM21uM0lDSnVu?=
 =?utf-8?B?ZG12c3c1MWVGcVpJdHJUckRvM0F0cGZ6MW5ZdnFQWW1kd0FudkVabE1yR1BI?=
 =?utf-8?B?ZHU4TGhHVDJpVlZOaExmU2lmcmI1Qys3by9nU0NZQVFUMEVKazYwK1A5RHU2?=
 =?utf-8?B?b0lSSk8wK25Na2ZYRlBuczlRUXNFRHBWbEtVaC94N1ZnN2NiMTVwR0xjc2dX?=
 =?utf-8?B?VUhxZXRMZ25jZUZiQm1WL09VcDF6S045N2VQclRxdUpHTkJUQVNpckJQbWxo?=
 =?utf-8?B?c1NoQUl3amtMbVd3aU85L0VhYkRhNjQvdExrWEVPYS9SdlpQK0JmdGpobWgv?=
 =?utf-8?B?RFZTZWs4L2JyTS9SSWtudnp1OGhoWXFEck10KzRqS1FMZjZ5ZGVpSEtxV2lQ?=
 =?utf-8?B?bXAveTI4MVZuUUlLcHJsQjI4ODUxeG1DWU1CVTNWUWFOSy9VekVOaHdHZitw?=
 =?utf-8?B?dUZQTDlXcDZjdTUyNXdPZ05qTWNaQnJtQmU3OEJxaDVJSHlKS04xNXBhWkxB?=
 =?utf-8?Q?oUPOPDPISx0qlWFk31LDO8n2YHr6d73Ue1+KkJduuHqTg?=
x-ms-exchange-antispam-messagedata-1: ElICEBf6axFrmw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4707.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e5ad15-3e5a-48d0-fa48-08de9018fa68
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 18:03:28.7470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XvzSPt/8+eYSMCKGYz/ymWJ8YkYeGdqmgmNGeYJIK0dcJk+RinqrUmHByqcOjqfXww3FrcjH1qX/Ay/OAaqn8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11636
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

SGkgTGl2aXUNCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIHNoYXJpbmcuDQoNCj4gT24gV2VkLCBB
cHIgMDEsIDIwMjYgYXQgMDM6NTk6MjNQTSArMDAwMCwgR3VhbmdsaXUgRGluZyB3cm90ZToNCj4g
PiBIaSBMaXZpdQ0KPiA+DQo+ID4gPiBPbiBXZWQsIEFwciAwMSwgMjAyNiBhdCAxMDozMTowMUFN
ICswMDAwLCBHdWFuZ2xpdSBEaW5nIHdyb3RlOg0KPiA+ID4gPiBIaSBMaXZpdQ0KPiA+ID4gPg0K
PiA+ID4gPiA+IE9uIFdlZCwgQXByIDAxLCAyMDI2IGF0IDA5OjQzOjEyQU0gKzAwMDAsIEd1YW5n
bGl1IERpbmcgd3JvdGU6DQo+ID4gPiA+ID4gPiBIaSBEYW5pZWwNCj4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiA+IE9uIDQvMS8yNiAxMTo0OCwgR3VhbmdsaXUgRGluZyB3cm90ZToNCj4gPiA+ID4g
PiA+ID4gPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGd1YW5nbGl1LmRpbmdAbnhw
LmNvbS4NCj4gPiA+ID4gPiA+ID4gPiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQNCj4g
PiA+ID4gPiA+ID4gPiBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRp
b24NCj4gPiA+ID4gPiA+ID4gPiBdDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBI
aSBMaXZpdQ0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gVGhhbmtzIGZvciB5b3Vy
IHJldmlldy4gUGxlYXNlIHJlZmVyIHRvIG15IGNvbW1lbnRzIGJlbG93Og0KPiA+ID4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiA+ID4+IE9uIFR1ZSwgTWFyIDMxLCAyMDI2IGF0IDA2OjEyOjM4UE0g
KzA4MDAsIEd1YW5nbGl1IERpbmcNCj4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4+PiBBZGQgY29t
cGF0aWJsZSBzdHJpbmcgb2YgTWFsaSBHMzEwIEdQVSBvbiBpLk1YOTUyIGJvYXJkLg0KPiA+ID4g
PiA+ID4gPiA+Pj4NCj4gPiA+ID4gPiA+ID4gPj4+IFNpZ25lZC1vZmYtYnk6IEd1YW5nbGl1IERp
bmcgPGd1YW5nbGl1LmRpbmdAbnhwLmNvbT4NCj4gPiA+ID4gPiA+ID4gPj4+IFJldmlld2VkLWJ5
OiBKaXl1IFlhbmcgPGppeXUueWFuZ0BueHAuY29tPg0KPiA+ID4gPiA+ID4gPiA+Pj4gLS0tDQo+
ID4gPiA+ID4gPiA+ID4+Pg0KPiA+ID4gPiA+ID4gPiA+Pj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2dwdS9hcm0sbWFsaS12YWxoYWxsLWMNCj4gPiA+ID4gPiA+ID4gPj4+IHNm
LnkNCj4gPiA+ID4gPiA+ID4gPj4+IGFtbA0KPiA+ID4gPiA+ID4gPiA+Pj4gfCAxDQo+ID4gPiA+
ID4gPiA+ID4+PiArDQo+ID4gPiA+ID4gPiA+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspDQo+ID4gPiA+ID4gPiA+ID4+Pg0KPiA+ID4gPiA+ID4gPiA+Pj4gZGlmZiAtLWdpdA0K
PiA+ID4gPiA+ID4gPiA+Pj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3B1
L2FybSxtYWxpLXZhbGhhbGwNCj4gPiA+ID4gPiA+ID4gPj4+IC1jc2YNCj4gPiA+ID4gPiA+ID4g
Pj4+IC55YW0NCj4gPiA+ID4gPiA+ID4gPj4+IGwNCj4gPiA+ID4gPiA+ID4gPj4gYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3B1L2FybSxtYWxpLXZhbGhhbGwtY3NmLg0KPiA+
ID4gPiA+ID4gPiA+PiB5YW1sDQo+ID4gPiA+ID4gPiA+ID4+PiBpbmRleCA4ZWNjZDQzMzhhMmIu
LjZhMTA4NDNhMjZlMiAxMDA2NDQNCj4gPiA+ID4gPiA+ID4gPj4+IC0tLQ0KPiA+ID4gPiA+ID4g
PiA+Pj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3B1L2FybSxtYWxpLXZh
bGhhbGwNCj4gPiA+ID4gPiA+ID4gPj4+IC1jc2YNCj4gPiA+ID4gPiA+ID4gPj4+IC55YW0NCj4g
PiA+ID4gPiA+ID4gPj4+IGwNCj4gPiA+ID4gPiA+ID4gPj4+ICsrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvYXJtLG1hbGktdmFsDQo+ID4gPiA+ID4gPiA+ID4+PiAr
KysgaGFsbA0KPiA+ID4gPiA+ID4gPiA+Pj4gKysrIC1jc2YNCj4gPiA+ID4gPiA+ID4gPj4+ICsr
KyAueWFtDQo+ID4gPiA+ID4gPiA+ID4+PiArKysgbA0KPiA+ID4gPiA+ID4gPiA+Pj4gQEAgLTIw
LDYgKzIwLDcgQEAgcHJvcGVydGllczoNCj4gPiA+ID4gPiA+ID4gPj4+ICAgICAgICAgICAgLSBl
bnVtOg0KPiA+ID4gPiA+ID4gPiA+Pj4gICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTYt
bWFsaQ0KPiA+ID4gPiA+ID4gPiA+Pj4gICAgICAgICAgICAgICAgLSBueHAsaW14OTUtbWFsaSAg
ICAgICAgICAgICMgRzMxMA0KPiA+ID4gPiA+ID4gPiA+Pj4gKyAgICAgICAgICAgICAgLSBueHAs
aW14OTUyLW1hbGkgICAgICAgICAgICMgRzMxMA0KPiA+ID4gPiA+ID4gPiA+PiBDYW4geW91IGV4
cGxhaW4gd2h5IHRoaXMgaXMgbmVlZGVkPyBDYW4gaXQgbm90IGJlIGNvdmVyZWQNCj4gPiA+ID4g
PiA+ID4gPj4gYnkgdGhlIGV4aXN0aW5nIGNvbXBhdGlibGU/DQo+ID4gPiA+ID4gPiA+ID4gVGhl
cmUgYXJlIGZ1bmN0aW9uYWwgZGlmZmVyZW5jZXMgaW4gR1BVIG1vZHVsZSAoR1BVTUlYKQ0KPiA+
ID4gPiA+ID4gPiA+IGJldHdlZW4NCj4gPiA+ID4gPiA+ID4gPiBpLk1YOTUgYW5kIGkuTVg5NTIu
IFNvIHRoZXkgY2Fubm90IGJlIGZ1bGx5IGNvdmVyZWQgYnkgYQ0KPiA+ID4gPiA+ID4gPiA+IHNp
bmdsZSBleGlzdGluZw0KPiA+ID4gPiA+IGNvbXBhdGlibGUuDQo+ID4gPiA+ID4gPiA+ID4gT24g
aS5NWDk1MiwgVGhlIEdQVSBjbG9jayBpcyBjb250cm9sbGVkIGJ5IGhhcmR3YXJlIEdQVQ0KPiA+
ID4gPiA+ID4gPiA+IGF1dG8gY2xvY2stZ2F0aW5nIG1lY2hhbmlzbSwgd2hpbGUgdGhlIEdQVSBj
bG9jayBpcw0KPiA+ID4gPiA+ID4gPiA+IG1hbmFnZWQgZXhwbGljaXRseSBieSB0aGUNCj4gPiA+
ID4gPiA+ID4gZHJpdmVyIG9uIGkuTVg5NS4NCj4gPiA+ID4gPiA+ID4gPiBCZWNhdXNlIG9mIHRo
ZXNlIGJlaGF2aW9yYWwgZGlmZmVyZW5jZXMsIHNlcGFyYXRlDQo+ID4gPiA+ID4gPiA+ID4gY29t
cGF0aWJsZSBzdHJpbmdzICJueHAsaW14OTUtbWFsaSIgYW5kICJueHAsaW14OTUyLW1hbGkiDQo+
ID4gPiA+ID4gPiA+ID4gYXJlIG5lZWRlZCB0byBhbGxvdyB0aGUgZHJpdmVyIHRvIGhhbmRsZSB0
aGUgdHdvIHZhcmlhbnRzDQo+ID4gPiA+ID4gPiA+ID4gaW5kZXBlbmRlbnRseSBhbmQgdG8ga2Vl
cCByb29tIGZvciBmdXR1cmUNCj4gPiA+ID4gPiA+ID4gZGl2ZXJnZW5jZS4NCj4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gVGhpcyBpbmZvcm1hdGlvbiBzaG91bGQg
YmUgYWRkZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlDQo+ID4gPiA+ID4gPiA+IGV4cGxhaW5pbmcg
d2h5DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IHRoZSBjaGFuZ2UgaXMgbmVlZGVkLg0K
PiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBCdXQgdGhlbiB3aGVy
ZSBpcyB0aGUgZHJpdmVyIGNvZGUgdGFraW5nIGNhcmUgb2YgdGhlc2UgZGlmZXJlbmNlcz8NCj4g
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBZZXMuIEN1cnJlbnRseSB0aGUg
ZHJpdmVyIGRvZXMgbm90IHJlcXVpcmUgIm54cCxpbXg5NTItbWFsaSIgc3RyaW5nLg0KPiA+ID4g
PiA+ID4gSG93ZXZlciwgd2hlbiBHUFUgaXBhX2NvdW50ZXJzIGFyZSBlbmFibGVkIHRvIGNhbGN1
bGF0ZSB0aGUNCj4gPiA+ID4gPiA+IEdQVSBidXN5X3RpbWUvaWRsZV90aW1lIGZvciBHUFUgRFZG
UyBmZWF0dXJlLCB0aGV5IHdpbGwNCj4gPiA+ID4gPiA+IGNvbmZsaWN0IHdpdGggdGhlIGhhcmR3
YXJlIEdQVSBhdXRvIGNsb2Nr4oCRZ2F0aW5nIG1lY2hhbmlzbSwNCj4gPiA+ID4gPiA+IGNhdXNp
bmcgR1BVIGNsb2NrIHRvIHJlbWFpbg0KPiA+ID4gPiA+IGFsd2F5cyBvbi4NCj4gPiA+ID4gPiA+
IEluIHN1Y2ggY2FzZXMsIGlwYV9jb3VudGVycyBuZWVkIHRvIGJlIGRpc2FibGVkIHNvIHRoYXQg
dGhlDQo+ID4gPiA+ID4gPiBHUFUgYXV0byBjbG9ja+KAkWdhdGluZyBtZWNoYW5pc20gY2FuIG9w
ZXJhdGUgbm9ybWFsbHksIHVzaW5nDQo+ID4gPiAibnhwLGlteDk1Mi1tYWxpIg0KPiA+ID4gPiA+
IHN0cmluZy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE9LLCBJIHVuZGVyc3RhbmQgdGhhdCB5b3Un
cmUgZm9sbG93aW5nIGd1aWRhbmNlIGZyb20gc29tZSBvdGhlcg0KPiA+ID4gPiA+IHNlbmlvciBw
ZW9wbGUgb24gaG93IHRvIHVwc3RyZWFtIHBhdGNoZXMgc28geW91J3ZlIHRyaWVkIHRvDQo+ID4g
PiA+ID4gY3JlYXRlIHRoZSBzbWFsbGVzdCBwYXRjaHNldCB0byBlbnN1cmUgdGhhdCBpdCBnZXRz
IHJldmlld2VkIGFuZA0KPiA+ID4gPiA+IGFjY2VwdGVkLCBidXQgaW4gdGhpcyBjYXNlIHdlIG5l
ZWQgdG8gc2VlIHRoZSBvdGhlciBwYXRjaGVzIGFzDQo+ID4gPiA+ID4gd2VsbCB0byBkZWNpZGUg
aWYgeW91ciBhcHByb2FjaCBpcyB0aGUgcmlnaHQgb25lIGFuZCB3ZSBkbyBuZWVkDQo+ID4gPiA+
ID4gYSBzZXBhcmF0ZSBjb21wYXRpYmxlDQo+ID4gPiBzdHJpbmcuDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBJZiBlbmFibGluZyBHUFUgaXBhX2NvdW50ZXJzIGNhdXNlcyB0aGUgY2xvY2tzIHRvIGdl
dCBzdHVjaw0KPiA+ID4gPiA+IGFjdGl2ZSwgdGhhdCBmZWVscyBsaWtlIGEgaGFyZHdhcmUgYnVn
LCBzbyBmaWd1cmluZyBvdXQgaG93IHRvDQo+ID4gPiA+ID4gaGFuZGxlIHRoYXQgaXMgbW9yZSBp
bXBvcnRhbnQgdGhhbiBhZGRpbmcgYSBjb21wYXRpYmxlIHN0cmluZy4NCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IEVpdGhlciBhZGQgdGhlIHBhdGNoKGVzKSB0aGF0IHVzZSB0aGUgY29tcGF0aWJsZSB0
byB0aGlzIHNlcmllcw0KPiA+ID4gPiA+IGluIHYyLCBvciBwdXQgYSBjb21tZW50IGluIHRoZSBj
b21taXQgbWVzc2FnZSBvbiB3aGVyZSB3ZSBjYW4NCj4gPiA+ID4gPiBzZWUgdGhlDQo+ID4gPiBk
cml2ZXIgY2hhbmdlcy4NCj4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBBY2NvcmRpbmcgdG8g
ZGlzY3Vzc2lvbnMgd2l0aCB0aGUgR1BVIHZlbmRvciwgdGhpcyBpcyBhIGhhcmR3YXJlDQo+ID4g
PiA+IGxpbWl0YXRpb24gb2YgTWFsaS1HMzEwIHJhdGhlciB0aGFuIGEgaGFyZHdhcmUgYnVnLCBh
bmQgaXQgaGFzDQo+ID4gPiA+IGJlZW4gYWRkcmVzc2VkIGluIG5ld2VyIE1hbGkgR1BVIGZhbWls
aWVzLg0KPiA+ID4NCj4gPiA+IEkgcmVwcmVzZW50IHRoZSBzYWlkIEdQVSB2ZW5kb3IgYW5kIEkg
dGhpbmsgSSBrbm93IHdoYXQgeW91J3JlDQo+ID4gPiB0YWxraW5nIGFib3V0LCBidXQgeW91J3Jl
IHRha2luZyB0aGUgd3JvbmcgYXBwcm9hY2guIEFsbCBHMzEwcyBoYXZlDQo+ID4gPiBhIHByb2Js
ZW0gd2hlcmUgaW4gb3JkZXIgdG8gZW5hYmxlIGFjY2VzcyB0byB0aGUgaXBhX2NvdW50ZXJzIHRo
ZQ0KPiA+ID4gYXV0b21hdGljIGNsb2NrIGdhdGluZyBnZXRzIGRpc2FibGVkLiBTbyB0aGUgc29s
dXRpb24gdGhhdCBuZWVkcyB0bw0KPiA+ID4gYmUgaW1wbGVtZW50ZWQgd2hlbiB3ZSBhZGQgc3Vw
cG9ydCBmb3IgSVBBX0NPVU5URVJzIHdpbGwgYXBwbHkgdG8gYWxsDQo+IEdQVXMsIG5vdCBqdXN0
IE1YOTUyLg0KPiA+DQo+ID4gWWVzLiBXZSBoYXZlIGJyaW5nLXVwIEczMTAgKFYyKSBHUFUgb24g
Ym90aCBpLk1YOTUgYW5kIGkuTVg5NTIuIEFuZA0KPiA+IGF1dG8gY2xvY2sgZ2F0aW5nIG1lY2hh
bmlzbSBpcyBmaXJzdGx5IGludHJvZHVjZWQgaW4gaS5NWDk1MiAobm90IHN1cHBvcnRlZA0KPiBv
biBpLk1YOTUpLg0KPiA+IEFjY29yZGluZyB0byB5b3VyIHVwZGF0ZSwgc29sdXRpb24gbmVlZHMg
dG8gYmUgaW1wbGVtZW50ZWQgdG8gYWxsIEdQVXMNCj4gPiB3aGljaCBzdXBwb3J0IGF1dG8gY2xv
Y2sgZ2F0aW5nIG1lY2hhbmlzbSBhZnRlciBJUEFfQ09VTlRFUnMgYXJlDQo+IHN1cHBvcnRlZCBp
biB0aGUgZHJpdmVyLCByaWdodD8NCj4gDQo+IEEgc29sdXRpb24gaXMgbmVlZGVkLCB5ZXMuDQo+
IA0KPiA+IFdoYXQncyB5b3VyIHN1Z2dlc3Rpb25zIGZvciA5NTIgZ3B1IGR0YiBub2RlPw0KPiAN
Cj4gVGhlcmUgaXMgbm8gSVBBX0NPVU5URVIgdXNlIGluIFBhbnRob3IgYXQgdGhlIG1vbWVudC4g
VW5sZXNzIHlvdXIgRFZGUw0KPiBjb250cm9sbGVyIHVzZXMgdGhhdCwgSSB3b3VsZCBzdWdnZXN0
IHRoYXQgd2UgZG9uJ3QgaW50cm9kdWNlIGEgY29tcGF0aWJsZSBmb3INCj4gOTUyIHVudGlsIHRo
ZSB0aW1lIHdlIGFkZCBzdXBwb3J0IGZvciByZWFkaW5nIHRoZSBjb3VudGVycy4NCj4gDQo+IEl0
IGhlbHBzIGlmIHlvdSB0aGluayBpbiB0ZXJtcyBvZiB3aGF0IGlzIGFscmVhZHkgaW4gdXBzdHJl
YW0sIHJhdGhlciB0aGFuIG1peGluZw0KPiB3aXRoIHRoZSB0ZXN0cyB0aGF0IHVzZXMga2Jhc2Ug
Y29kZS4gRG9lcyB5b3VyIGhhcmR3YXJlIG5lZWQgZXh0cmEgY29kZSBpbg0KPiB1cHN0cmVhbSBp
biBvcmRlciB0byBmdW5jdGlvbj8gSWYgc28sIHdoZXJlIGlzIHRoYXQgY29kZT8gSWYgbm90LCB0
aGVuIGxldCdzIG5vdA0KPiBpbnRyb2R1Y2UgdGhlIGNvbXBhdGlibGUgdW50aWwgd2UgYXJlIGFi
c29sdXRlbHkgc3VyZSB3ZSBuZWVkIGl0IGJlY2F1c2Ugd2UNCj4gaGF2ZSBjb2RlIHNwZWNpZmlj
IHRvIHRoYXQgU29DLiBGb3IgZXZlcnl0aGluZyBlbHNlIHdlIHdpbGwgaW1wbGVtZW50IGFuDQo+
IGFyY2hpdGVjdHVyZSBmaXggaWYgbmVlZGVkLg0KPiANCg0KR290IGl0LiBUaGUgZm9sbG93aW5n
IGNvbXBhdGlibGUgc3RyaW5nIGlzIHRoZSBjb3JyZWN0IGNob2ljZSBzaW5jZSB0aGUgR1BVIG9u
DQppLk1YOTUyIGlzIGZ1bGx5IGNvbXBhdGlibGUgd2l0aCB0aGUgR1BVIG9uIGkuTVg5NSBub3cu
DQpjb21wYXRpYmxlID0gIm54cCxpbXg5NS1tYWxpIiwgImFybSxtYWxpLXZhbGhhbGwtY3NmIjsN
Cg0KSSB3aWxsIG5vdCBtaXggdGVzdHMgd2l0aCBrYmFzZSBjb2RlIGluIHRoZSBmb2xsb3dpbmcg
dXBzdHJlYW0gcGF0Y2hlcyBmb3IgcGFudGhvciBkcml2ZXIuDQoNCj4gQmVzdCByZWdhcmRzLA0K
PiBMaXZpdQ0KPiANCj4gLS0NCj4gPT09PT09PT09PT09PT09PT09PT0NCj4gfCBJIHdvdWxkIGxp
a2UgdG8gfA0KPiB8IGZpeCB0aGUgd29ybGQsICB8DQo+IHwgYnV0IHRoZXkncmUgbm90IHwNCj4g
fCBnaXZpbmcgbWUgdGhlICAgfA0KPiAgXCBzb3VyY2UgY29kZSEgIC8NCj4gICAtLS0tLS0tLS0t
LS0tLS0NCj4gICAgIMKvXF8o44OEKV8vwq8NCg==
