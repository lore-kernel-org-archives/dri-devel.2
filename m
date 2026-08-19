Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D70C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 08:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C3C910ED55;
	Wed, 19 Aug 2026 08:15:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=analogixsemi.com header.i=@analogixsemi.com header.b="HMwNZdcr";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11020116.outbound.protection.outlook.com [52.101.56.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5A9110ED54
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 08:15:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ch2Ihzu39ZOnEMrttBxvzDjjMA9kcLaf9X2Ep8d9cqJJ6yA16tDKoX1iejCq9xTu4zV5kQIhgwPjDVMFFKpddt0E+MZKhJDN9iMOGYb8xCZ7wXUTY4mY5PgzyDkmc5PKiRvzrPkqSFeNEk7coV4x+6o+SaQ6xDqgKLpHcPVQdL2/UYmPKENWf/BHwDPLzuzg+xdeJF+ENmIX4YFfZCSnsaClEWfcivRQ6N4fmQ4X6Tw0xoW9fZ3mfSN+ksEmUVrrhvdNm7PhPVNLXllouRFeBJFYkDsOhWc6RYRgyC6pLKL9NCkP3YaLUfVL8T5z41Q8/V2GZhh7A5Nij/FtVSKctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8Iyo3Nw9DonTIcZD5W4hRUALNIX8ombRDPVrqQNk7M=;
 b=JEK+ap4aGEiuaCTZQ/s5euP8rH32QCpZasWEDvKejsHKcjiHyD47DIr1WRrs+WD9g5K/rUsxeL7wmiAQjS8ysghJE8w5u0IK8b358IZSxWb3eVlhWGKbYAwlPizTB0dCLXcdVp1z8JYs8afSV3Mp1BtUX/4UfvLb+zZmT2IQso7tJdWciv4bPyZvUiGlBSr8ZfPSbf5jhJywoNM+plMSNpESZWp1phc1i9qTcZGYslHcPw73eogs9HZmVU9hrkUqSFDj5K/M1WlmxIafgDL0CpCgCSkR/mhZRA7pcdj2VmImyhN2HdL4SnDfbfSl82SYbxEgC237AHPXmN0bCXCphA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analogixsemi.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8Iyo3Nw9DonTIcZD5W4hRUALNIX8ombRDPVrqQNk7M=;
 b=HMwNZdcrmeFq3btByLzLtTDJ9sTq527fmLR3CkGzIvVH/Eo2ttjaEp5xZ2gsrExiL3VO63RAGm7vRbopxZUp2Rc9thADnGmyhXCmopaOqTqV/dGEodoaUAQpdUFVxPnSCZPCYwJxm0FbMCIceV+dUu1vGJX0q1j4Hg4sRFXkVT4=
Received: from DM6PR04MB6970.namprd04.prod.outlook.com (2603:10b6:5:244::15)
 by SA6PR04MB9543.namprd04.prod.outlook.com (2603:10b6:806:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 08:15:23 +0000
Received: from DM6PR04MB6970.namprd04.prod.outlook.com
 ([fe80::c85b:1156:a070:b01c]) by DM6PR04MB6970.namprd04.prod.outlook.com
 ([fe80::c85b:1156:a070:b01c%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 08:15:23 +0000
From: Xin Ji <xji@analogixsemi.com>
To: Chen-Yu Tsai <wenst@chromium.org>
CC: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "r.mereu@arduino.cc"
 <r.mereu@arduino.cc>, Bernie Liang <bliang@analogixsemi.com>, Jason Huang
 <jhuang@analogixsemi.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: drm/bridge: anx7625: Add right justify
 property
Thread-Topic: [PATCH 1/2] dt-bindings: drm/bridge: anx7625: Add right justify
 property
Thread-Index: AQHdLrYssVSLx0E5+U6dyVM75xkZp7ajen+AgAGNfSA=
Date: Wed, 19 Aug 2026 08:15:23 +0000
Message-ID: <DM6PR04MB6970A5548A0AD0653A2B2875C7A52@DM6PR04MB6970.namprd04.prod.outlook.com>
References: <20260818020559.961335-1-xji@analogixsemi.com>
 <CAGXv+5HYKJtC-3Rj9u-9AucAYQiSB4DjR=Z1vv_fRuHobY8Cpg@mail.gmail.com>
In-Reply-To: <CAGXv+5HYKJtC-3Rj9u-9AucAYQiSB4DjR=Z1vv_fRuHobY8Cpg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6970:EE_|SA6PR04MB9543:EE_
x-ms-office365-filtering-correlation-id: 7210b744-b8ac-4bd0-145c-08defdca0455
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|10067099003|3023799007|22082099003|18002099003|4143699003|38070700021;
x-microsoft-antispam-message-info: elG14fJ9mXpTgfpV67MIS2anBJbKLdvKIZqsxP6zewPHRGDASsBcL4KoPyrt4tUorLrShdNWIG3X4Rd4fYr99k2aUqRRNqXATPYmYpLuiCCx3Wx6uJD+5sY2Va2yfPrR0QImfS1DcKwLEuOtbJ1AdosrGxSOM36FbSw9/o5QLH6jhno9cTbJnBpHwM/grfeuh+4o0EQnl6IL0oqxUVdzLaWsF0sKQ28pWGmLmVwyj3iHjlt59xGklP19nu8Y15Ih0vtZgmI5SBIVGkMjjvXqKjuJoCacu1j3eHeyZG140GY+uD4uYyPQCA3M5cfLOcoJ5JLrX59yTdj41DwGqF7it1jPgiQSav59NOgzacljnNfLo6OQsNt9Ydh9Fu+o0q36cVg8W+f6qwdybC+6u0q83Jq5gI5j7YCXwpG0U8nDzQVAESONTYpvM8Xm7pdJp4TXhLf/foUFFJfcU1ufOqMjXyS/zP6+qDKqm/VY0nGRByJ5JlSFhM8CQ7q1YafRug2B3ynepkq9WeAm47RSpTqD1uzPoUA92uTdJB7ZaXS6K9JP2FD8IgYQdmZ5ZU1kxE7lCKhDnam40p50JE4ji7MIXIG6FbuiD8Um5Y174evoZDZxMnO3wYYFDP+5jchyU/NTFBOkggX+OSVvx83BS09Yi2JnrjvldPLC5Oula9wf2L4Y89XJML7X/tiOCpJMUngJvCFTPDIUN1s8maj5h/QJCNrmAjgIUIOXsGMPB9rC1iU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:DM6PR04MB6970.namprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VklyeFAxQjA4MDRFSW9Qb0xUWEs2ZDBiNlR3LzhOam5sN1NxWVI3QjI4VTFW?=
 =?utf-8?B?NXRNME1JbjJSWnY0R0FoWVdzU2xoMG93cVUyckFZcmpTWllPbGtUbFUrTWN3?=
 =?utf-8?B?Nzljb2hjYW13dEtkYk5YRndjTkpqMnovWW9WT09CaVN2dWtRZEMvTms2b2cr?=
 =?utf-8?B?Y2YwbkdLQ1BUTmI0UTFaZWgyYjJoSFptQUR2a1FSRzBacXZpODJxR0pTcTcy?=
 =?utf-8?B?N1htR0hicHBBNXM4ZkdWNTlwU05Rdm9abnRhb0tmUjFNTmRoa2YvSEJza0JW?=
 =?utf-8?B?R3FBWFgrQWpUbDBoN0syTm1LdXBVcTBpZTJYWHFTWFhHZHdBMHNFa0NEQk1x?=
 =?utf-8?B?ZURtSUJEVUtJZGpVRVV5QnVxTTVBUnMrYWVYbVdSYkpVUUErdktIZldxTjE4?=
 =?utf-8?B?NDdhRVBoWVVKVlAxMzI2amxyd2VCY0l4RG9XYmU0bWRmSS8zZUFUUUJ6bzlL?=
 =?utf-8?B?WE5sQkRwR010b21vVGtiOFZYV2hVdlp2YVNpSFRRdnQ2aGF4MW8wLzcwZ2dj?=
 =?utf-8?B?elk0QzBzQ3ZhVTRSLzc0eHhsbGY2L3lOZWluUGFvY3BnK2lKRWV5Mm44ZzYw?=
 =?utf-8?B?eWNRcmNNWkJ3QWtzTnBuL0JiV1pOK3c2aFhpLzhzNlJPTFVGMS80MnVGc0JW?=
 =?utf-8?B?ZEFnT3MzNG5xdU5uM1FEeHc4c1FyNW5zN29RaWg1TjgyZlh3eXcxVVlkNE5n?=
 =?utf-8?B?SjhDMktvWkhKVXE1UzZPYk5mUFR1MFNIM28yZzY5UUhsWmVlOFdPT0RCTTd0?=
 =?utf-8?B?Y0RGSHphaldoc3JucWNRaW1hTkpWRndxNW9rVG1rYm5VdytkVFM4WURuOWxN?=
 =?utf-8?B?dWVTZFN2d2U0cjVXRmNXa3R2M0QxRmdoWkxsTENxQWNJNTh2R3dJSjdlWVVw?=
 =?utf-8?B?N1hhVFk1OHlZQjQrQkhEWlp2SGY5SldDUlFtdUt5R3pKNEZzNDVTMVlUUWZh?=
 =?utf-8?B?MmFTOGQ1UEFEQmw0bW9MNlBiRkdheXgrUEpzb0V3YmpDcWxWNmZEWTJOWnVL?=
 =?utf-8?B?TmYxWFR2ay9UOTNUbTNyR1pmSktYUCttVVR2WFpSMk1BSE5VbmszQ3NPa2hN?=
 =?utf-8?B?UDYwWVk4MFEzbnhNbVliUzVEdldTdHZRNGNpbFR5Y1ppV3RsZU81bHZQYU12?=
 =?utf-8?B?MmdjV3dDSk5ydFlJTmxqOW52c24yYkpRS01tTTljY2tnKzM1dFV3T2NWRTNi?=
 =?utf-8?B?eWM3RXRaTFcyWmd6cGwyai9Lajd0ODU4VUZJVlFacUh3WTNOcmNxRmpsOEFJ?=
 =?utf-8?B?SlZQSFJUSS8wUGdRemNwMjBHWmZ6Y2ZseTRhbEx3bVpmRVJ6aEQ4dmZNeUYy?=
 =?utf-8?B?NHMrZWI4aUtZZUl1N081UDV4Mk1iNjRIUjBPV3FhSXd4RnJjTWNMQ21nVnB2?=
 =?utf-8?B?RlNBUjRoS1J2aVRUOU81RjhEdURXdFNLMXg2YnZZanBZNzRaRnJQbjF5QUpo?=
 =?utf-8?B?WFdsV1JGb1p5RHE5WGZ5SlpRQlNwMWZId0NEUkFhQVBrYktaMUs2TU9neVhX?=
 =?utf-8?B?WWJ4cWY4NlFaRWJmclJiaitMMVFCeGJSa3dZSjZmUEQ4Qk91SlFHcm9Bbjg3?=
 =?utf-8?B?ei9nb2dVbTNNUDI1SFhBdFhYNFNzTnU1eUFIei9lZVNrYzFtU2UwOHpabENM?=
 =?utf-8?B?b3htMFJQVkNUNjVKdGdkU2xWZXQrTG0zT00zRjl2K0ZGOWtaR2l0eUpsN01w?=
 =?utf-8?B?YVlyMTdhYUVvYUMzTWtVVngwRWxOUzZKMk1nQkwwVmtacUNTYi9mYVNpbjY2?=
 =?utf-8?B?OWZyc1c0bm02cWU1WGJDNW1NNDJVTkdvTEhqRTM2TXVFNG1ObkVBM0VROC9h?=
 =?utf-8?B?VXF4UmliM29GanNDNzZZU2FEVnNoNWhaVUs0S3ZLUWxoNEtZd2E5YXM4UHBP?=
 =?utf-8?B?ekNuaFVGSjBqU2VWR2U5VFRQKzdvNnBWVHNrRmJZWWVwU3FRMUYvMllYTHRV?=
 =?utf-8?B?QzBBMHExMzF3V255bGFDd2dTVFN0VUZIUEc1ek9VeDJydFRxVHVTWVdoOE9o?=
 =?utf-8?B?dmY2dDdrSVRsY2hRVm1jbzF2TzA5ZTFDZ2lKbVlOWFVjR2VvK1NwYU80S0hL?=
 =?utf-8?B?TlRXYnBjUFRXRkdmRVIvYmdNQjRCcmxkQWJ5RnpKb2w0TkhaNGdpRExhYUhj?=
 =?utf-8?B?OFN0QWJNbGRBWGpMMmw0QldvQkcrQThUYUlyUVlzZ2c5SGVUWW0veWpCMWtX?=
 =?utf-8?B?NXNiN0FSQkh4UXMydGNjSGQ4bzB0L0VtWjZjRFdSYmh5MjUrMkJHWHdFa014?=
 =?utf-8?B?M2ZOZ2FveGM2eXVYNG9jOFptU2Y2aWNRdnpwQ1l6T0xEekhqSFlLSjZVWmdX?=
 =?utf-8?B?eUxzMEZTN281bXFpZDhKbXl5UUk3SXlTKy9Ld2tYRXMrRnA2eXo1Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6970.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7210b744-b8ac-4bd0-145c-08defdca0455
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 08:15:23.0945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QhAMhJgbmpXcNylufhzHmanL05fzWgttrPSdbVmKbLlnvYdzEdgoBK+aK9GrOhBEy6XjNqWZpk1YY5TE+F42PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9543
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

PiA+DQo+ID4gQWRkIHByb3BlcnR5ICJhbmFsb2dpeCxhdWRpby1yaWdodC1qdXN0aWZ5LWVuYWJs
ZSIgdG8gY29udHJvbA0KPiA+IGFueDc2MjUgdG8gZW5hYmxlIHJpZ2h0IGp1c3RpZnkuDQo+IA0K
PiBOby4gVGhlIHN0YW5kYXJkIERBSSBsaW5rIGZvcm1hdCBwcm9wZXJ0aWVzICgiZGFpLWZvcm1h
dCIgdW5kZXIgYSAiZGFpLWxpbmsiDQo+IG5vZGUpIHNob3VsZCBiZSB1c2VkLg0KPiANCj4gDQo+
IENoZW5ZdQ0KDQpIaSBDaGVuWXUsIHRoYW5rcyBmb3IgdGhlIHJldmlldywgSSdsbCB0cnkgdG8g
dXNlIGRhaS1mb3JtYXQgSERNSV9SSUdIVF9KLiBUaGFua3MhDQoNCj4gDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBYaW4gSmkgPHhqaUBhbmFsb2dpeHNlbWkuY29tPg0KPiA+IC0tLQ0KPiA+ICAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L2JyaWRnZS9hbmFsb2dpeCxhbng3NjI1Lnlh
bWwgIHwgNA0KPiA+ICsrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2Rpc3BsYXkvYnJpZGdlL2FuYWxvZ2l4LGFueDc2MjUueWENCj4gPiBtbA0KPiA+IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvYnJpZGdlL2FuYWxvZ2l4LGFu
eDc2MjUueWENCj4gPiBtbCBpbmRleCA2YWQ0NjY5NTJjMDIuLmYxYjA4YzZiNDg3NyAxMDA2NDQN
Cj4gPiAtLS0NCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5
L2JyaWRnZS9hbmFsb2dpeCxhbng3NjI1LnlhDQo+ID4gbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9icmlkZ2UvYW5hbG9naXgsYW54NzYyDQo+
ID4gKysrIDUueWFtbA0KPiA+IEBAIC04Miw2ICs4MiwxMCBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAg
ICAgdHlwZTogYm9vbGVhbg0KPiA+ICAgICAgZGVzY3JpcHRpb246IGxldCB0aGUgZHJpdmVyIGVu
YWJsZSBhdWRpbyBIRE1JIGNvZGVjIGZ1bmN0aW9uIG9yIG5vdC4NCj4gPg0KPiA+ICsgIGFuYWxv
Z2l4LGF1ZGlvLXJpZ2h0LWp1c3RpZnktZW5hYmxlOg0KPiA+ICsgICAgdHlwZTogYm9vbGVhbg0K
PiA+ICsgICAgZGVzY3JpcHRpb246IGVuYWJsZSBhdWRpbyBkYXRhIHN0cmVhbSByaWdodCBqdXN0
aWZ5Lg0KPiA+ICsNCj4gPiAgICBhdXgtYnVzOg0KPiA+ICAgICAgJHJlZjogL3NjaGVtYXMvZGlz
cGxheS9kcC1hdXgtYnVzLnlhbWwjDQo+ID4NCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo=
