Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61672CDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 11:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0A3110EAD2;
	Tue, 23 Jun 2026 11:59:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="qJewmbsu";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010057.outbound.protection.outlook.com [52.101.69.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8588E10EAD2
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 11:59:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpOjdjZjF+poUHAtshRgcQjvBguc/lsER0UFaR3VmhTNkKl3WxHV67y2a/w0h2vAoEPYBAR+8ALYOsYXECgfaMOI6qCVKfx0RTFtS33Iks2JLs6FaIAmebPDBJb16t78BmqCnDnFelri1S0fC9aN/HIagJFQrYittQ2DfqQK11pBzCg+0B/W56hQVRL6ITyDhtvIuZR0D05RijB0xLqcUtcuXfC0hHRWHjRlYkj4ZEH7HFb0gEaTEPMn+AjQfE3Yew0cYijcQwATsVPRNYOEI68s0+dUAd2StNcyDV8hIB2pEYQun9nxRWQM8ZYPcFHvjNmZRy+2W7d12MdhgHG3kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrYhsIY23Yie/WvkXjk5C82fUsbYLkkSGakHz4o30js=;
 b=OjLIHzGIq+DBBYUoZqahIXpIQ2iPBq1B59TAKqX6a8vsYKww+eMtyvTaIA8p+xxIylQ5pEwNdxSreqT8+bNqO+zmMuhbuwiMoqy7e6eDYAbnBPgk2PUw1kmxiVu/UiczZ23k/AYIM/4zf6LlnTam8Ta9P8s9dEGqb/pC3Pj++D97zZDB9gc2phBBEeTJa5YC31thiTYoXEaIFXmQzSkFcN9DBb3bT5/VDyILGzuK3EapXOKH7wnP4yt4czrr/oZPOHWAQ75zIwYGyYgTzOoIvDGLMxIVrWBC+unkFTqAVZ7hwDM+caeJ5WmQ/TN0PM1kQ4meyB/KkTQhZGHSHdZMDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrYhsIY23Yie/WvkXjk5C82fUsbYLkkSGakHz4o30js=;
 b=qJewmbsuxIuGh98LUPZPrRem+G7u1ooG5R1BKd/naufFIO6jGpN2KjWDZglH7z6rT9jnSuwKL5bfzpP/tAtAXw7ORa7ITPHmmsjnIQVHLS5SpSiCvudnuFlT+69X7lkSC6aEB0dC3zSobnn9LKA7I24DSt9uy1oe9rTF+1b0VglHrG0tLRRc1GBeMWPP4tHurCQMOkMz+x+yZgEF6XykMDZoKClCNygSDgMEtmGVJb0+6ePGNVEvuIG4xf4XAa8FubzD14J4uWy2T0simNYhrIwdSROfEoi/XGV1cbRA1GyhCZWvUqjmAqdvm64CaqtokJ2COkJhp2v0Ny1gkrh9bA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PA1PR10MB9457.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4f8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 11:59:17 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 11:59:17 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "daniel@riscstar.com" <daniel@riscstar.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "danielt@kernel.org" <danielt@kernel.org>, "linux-leds@vger.kernel.org"
 <linux-leds@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-fbdev@vger.kernel.org"
 <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] backlight: lp8864: Convert from LED to backlight
 class driver
Thread-Topic: [PATCH 3/3] backlight: lp8864: Convert from LED to backlight
 class driver
Thread-Index: AQHc/L9Bd4MT7UWYqkaHc9ldpDCobLZABz2AgAC/nQCAC0oHgIAABQ4A
Date: Tue, 23 Jun 2026 11:59:16 +0000
Message-ID: <aa34231591d2e5f848bdd74524abb4fe85123444.camel@siemens.com>
References: <20260615120353.3409035-1-alexander.sverdlin@siemens.com>
 <20260615120353.3409035-4-alexander.sverdlin@siemens.com>
 <0b39450b-559b-43d4-a1e9-bb6684691cb5@ti.com>
 <acb13aca040ab72b9e53abee3a5c8733ebc5b8dd.camel@siemens.com>
 <ajpw1w150SXm8Gbi@aspen.lan>
In-Reply-To: <ajpw1w150SXm8Gbi@aspen.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PA1PR10MB9457:EE_
x-ms-office365-filtering-correlation-id: 8412accd-6944-4b56-bb92-08ded11eda00
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|4143699003|56012099006|55112099003|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: Zm61tJ/qP2oN4dQQGqGlIpoFn1YBKja9Mq8iXtnn9ImcreYVnKTeFMqQAUARBHKJlETJLJJGp99mshYuv6EO3RLsdAydw9+Mo0fAm++z7zKDZTd+5F21bCeil015qFDCK5mQkieb7dUg/RZgcpisP/nTGWh3a+BWYgk4+ZXiwcc4xPgbcIUr8mDnWwFA7+mg0hdFLUhU1BfsMEURiuhzQdqRWHiLfbIcOEadqGm/erZqxV5uLUqmg5apvJLm6E9AhbpQ6rcHGUh+BbV/bAlQHj8sL3Jx/Jk0Jut4sIYJ94ZMJeH9fvz9EYmaWiNGQGYeJiPpm11A0kXKmdj8gy4woO7VMTo+DriJskJHFaTtBTa07iPsKMBWcfzuUAt3LvOyskiIk838QOj9UIPR1W9lpSEnzQOLnd+WbrJMSemqnD9jYEg/VhGnLP5q2hpTFZo9D2Yqwgai96wBe/NwVVb7Sqbd/HgKmug77f+3x7G+rUtCl2qVe0oga1lPRr9PlcmjnpQlJ2no91CSollEHkZMre2qM0o23JcOAaIzF6EBRkxqBvw42NPtGqfrG2YbKSYgBnJhFVWEl8ZumE37YBp27pERGMP5q9yIVOwqOha7/U9En30k2k0XWEknN25mexnio2lGV+lpmO6LTgXgu3zB59GKD1Rfov+jWk7ykYWGwkk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(4143699003)(56012099006)(55112099003)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHBmaUkvS1JVOVhLT1hjdXQ5TkJhUEFpSklTVmJ3RHZld1FScDA5QWZSNjNo?=
 =?utf-8?B?NkNaeEtQRlhoMGZoejFYWDZxUXREMk9OYnowMXM4MCtDV09vdDB5WFZhNjl0?=
 =?utf-8?B?TnIySENEUHM4YlVrTWxLbUlTWEgvVnptNENLS1V4SWhLaVJFOUhCaUN4T3Nk?=
 =?utf-8?B?MU92T3ZYVXFZY3VHUGFaeGhXWmZiclVCa3JwV2s1dWNYaW1yYTBDSWplRkdI?=
 =?utf-8?B?MytMeWJrcHNCc2lyWXd5MEhNeE5MNCtza1JuN1J3YUZKZFJOTk5mTE1YZ3Bn?=
 =?utf-8?B?dlAwbmJSQXNGcEs1VFZsck03Rnoybi9RNHNkdVNIL0VQRDFLSEF2cnlyT3ph?=
 =?utf-8?B?YTdYK3QxQVpkTXJIRnFyMjM0Tks4RFBBU09ueGVyNEtsdDFBMG1Uc0FHaXVu?=
 =?utf-8?B?QmVadUFkeUxXVUk2S09TcGJxVkk3cmprVlRjV25tS1hsL045cjkxYlE1dE45?=
 =?utf-8?B?OU9naVppa3Judzh2UlJpN2hJQmVDeEd1TjhuSmdpMlIzZWpPRWpHbXZucjhx?=
 =?utf-8?B?ZXJHbE9sQnZsbXBDUWtXbDFhT3VvQTdLUzdRbjJUYlV2bTBSWFpKMUQ5bHZn?=
 =?utf-8?B?bDc0eHAvTUtwNVV4MEJPK0NPenNwc1QvbXk3WVJFN042SHpaZDBwZmU1ZHFK?=
 =?utf-8?B?aHlSL29OcHFpQ2c3TkFpYTZLU1BOcmF2SkFqQzBrTktzc2hoRSs2V3Vqc081?=
 =?utf-8?B?VlRiR0xxeThkTTVOYWZrUytiV0hYeTBIL2hsbzl4YTAzNXFVcXVjTnBGb3FN?=
 =?utf-8?B?Q2cweTQzT0UxMjlFOElOcVF4R2xPQTdYZGh1KzdOSk9FZ0dyY3VBY3N1blNJ?=
 =?utf-8?B?dTRLbFhid05RMXVNVlVQY05ubTBMRVR0L0pBZi9nWFpJdEN4N3h4ZldJdVha?=
 =?utf-8?B?K1NwVGVCVUx2OUNqVW9UenJDMzFQdXdxU3hZMjJzYmhzODFmQUUrOUQ5QWJr?=
 =?utf-8?B?bU1MbDd1eWVRanB3bUxTTXgrYUNWMTJubnVQTkszQzYzbEJGOFhmRjZ2SStO?=
 =?utf-8?B?TjZ0TnRqTE9oZGZlQU1OZllpZzUybCtXU2RFN3dVcWg3QWxyZXBUTC96K3NS?=
 =?utf-8?B?WThZMnFTeW5XMEo2Nk1LMHhDbitjbFhJTzBoZytRRUlDcTIrNEVEZ0FTUU5V?=
 =?utf-8?B?eCs3NkUreGpBTjQyQnZaV3dlSFJrYmQzUUlRTk16RGVFZjAzVTdqTTNWaW1s?=
 =?utf-8?B?K2ZITHV6NHV0OGYzQmpieUR2T1ZXVHdCbGkzazdhTTFLcW82WWQxT1JFbVNn?=
 =?utf-8?B?aEd3a04xNS82cTBoSDQ5bVRlbm1tN0RicFFZWitqWHFmTGczRjcyT2dJQ1Qv?=
 =?utf-8?B?QnVvWHFzcFhDV0luMDYrWWNNTEVzQkQwMGg5c0tOK3gvTTNqc2N2UHVxZ1BV?=
 =?utf-8?B?emlnRjdKa0JIWmE2T0crTitWNy82S1lUZXpWR2hCc2dxYlRaRGl3VXdjdUh3?=
 =?utf-8?B?ak1mY2ZsWmhrNVUrcU0zczZJNTNIZ0xadlZ1a3BIdVFqTnVwTFlZVTExaWFr?=
 =?utf-8?B?VmhTdnNNMWRtbTFoSXlvYld2SmxibkE2UWRWZ3dIQXNqVmFxVkZVUzhWODNU?=
 =?utf-8?B?TW9XUnVZbHNJQWdORUZ5Uy8vclk0bmFFZU9JQXhlRkdkQ2tpaDRLRDYrNG4v?=
 =?utf-8?B?VEc5NDFCZ2oxY0lDeEM3MWxNTG9ackZrNkg2U0RPdWxQQXlwakQ3UCtLRkR4?=
 =?utf-8?B?WjkwU0szelJnQU0zMWp4MjZYZmkzSXFHTVlkQ1FLUExEbGtkTWIxcUVXMkxN?=
 =?utf-8?B?V1FvdklpRk9KS205OWpPRVpWajRhVnNMNVFKaGFqanJQNEJ0T3dQOXh6YS9i?=
 =?utf-8?B?TWxYcnZTdVg1V3pUR3RuSGhzSzUvbmhTRU4zMHlVY1I1enFaTU5TSVhsWWV6?=
 =?utf-8?B?aEwzMUYrQXVXKzluNkFjR05mVFpkdmdlbjk1Um5CWnEvZEN3NTd6cGt2Z2sv?=
 =?utf-8?B?cWJ5WFk4OXFUTW1oNmJSSGxXQXlycUQ4YUxUTWFLelE3Z0pRLzdDc09Vbkky?=
 =?utf-8?B?VDBITTdvM09GaDVJTXVZL2FweFBYR2hZdG1TODRpdk5tODBROUJ0ZGdOcUY0?=
 =?utf-8?B?R0d4V0JnSW12MjZnQ0lmVlg1clRZdnZpVll6TXU2emlzYzYybkRYNTVCRXUy?=
 =?utf-8?B?UENJODBwU2JORzRpU28yV1BaSXYyTVdjMmpjOVRhNXE2SjRCd3hxQVI3MlhL?=
 =?utf-8?B?d2JlUDI1UnNJY2xUak9zREZDTkVOZUhZUXhFQXFoaFhjeDk4YmZhakhEQis0?=
 =?utf-8?B?SzN5ZEdCemluYTBxYk9ldUdtUlhYdFM1dC9memU3Nk1Mc3RvcEVBWFkwTXUx?=
 =?utf-8?B?cC9IYTdUVEJ4VnRMdEsrMTZmME9MbHVxNGswcjFsTDdpL3BlY3ZZUjdtRWlh?=
 =?utf-8?Q?BUdkKs7dyd5cDGR4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76372C38485CCC4A9581FCB9F9736319@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8412accd-6944-4b56-bb92-08ded11eda00
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 11:59:16.9596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uc2KiAjbuKiNj3vWfvZqGTqGPXQQR++z+Yu44OVceuUtV9a/UWE1xzaghT2gv/vcihlNotikfGJh44GuDzGzX8n1+PeF9yV6zDgRFR/sO00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9457
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

SGkgRGFuaWVsLA0KDQpPbiBUdWUsIDIwMjYtMDYtMjMgYXQgMTI6NDEgKzAxMDAsIERhbmllbCBU
aG9tcHNvbiB3cm90ZToNCj4gPiBUaGUgbWVjaGFuaXNtIHdlIGhhdmUgcmVnYXJkaW5nIGhvdCBw
bHVnZ2luZyBjdXJyZW50bHkgaXMganVzdCBJMkMgYnJpZGdlLA0KPiA+IHdoaWNoIGRlLXJlZ2lz
dGVycyBhbmQgcmVnaXN0ZXJzIHRoZSBicmlkZ2VkIGJ1cy4gU28gbm8gYWRkaXRpb25hbCBkcml2
ZXJzDQo+ID4gYXJlIHJlcXVpcmVkLCBhcyBsb25nIGFzIEkyQyBkZXZpY2VzIGFyZSBzZWxmLWNv
bnRhaW5lZCBhbmQgbm90IGdsdWVkIHdpdGgNCj4gPiBwbGF0Zm9ybSBkZXZpY2VzLg0KPiA+IA0K
PiA+IFNvIGJvdHRvbSBsaW5lIGlzLCBJJ2QgcHJlZmVyIHRvIGp1c3QgYWRkIHRoZSBiYWNrbGln
aHQgaW50ZXJmYWNlIHRvIHRoZQ0KPiA+IGV4aXN0aW5nIGRyaXZlciwgbm8gbWF0dGVyIHdoZXJl
IGl0IHdvdWxkIGxpdmUgaW4gdGhlIGZ1dHVyZS4NCj4gDQo+IElzIHRoZXJlIGFueSByZWFzaW9u
IHRoYXQgTFA4ODY0L0xQODg2NiBpcyB1bmlxdWUgaW4gYXBwZWFyaW5nIG9uIGEgDQo+IGhvdHBs
dWdnZWQgSTJDIGJ1cz8gSW4gb3RoZXIgd29yZHMgaWYgc3VwcG9ydCBmb3IgZHluYW1pc20gaXMg
YWRkZWQNCj4gc3BlY2lmaWNhbGx5IHRvIGxlZHMtbHA4ODY0LmMgcmF0aGVyIHRoYW4gaW4gbGVk
X2JsLmMgdGhlbiB3aGF0IHdpbGwgc3RvcA0KPiB0aGUgc2FtZSBkeW5hbWljIHRyaWNrcyBmcm9t
IGJlaW5nIGFkZGUgdG8gb3RoZXIgTEVEIGRyaXZlcnM/DQoNCkxQODg2NCBpcyBub3Qgc3BlY2lh
bCBpbiB0aGlzIHJlZ2FyZCwgbm90IGRpZmZlcmVudCBmcm9tIGFkcDg4NjBfYmwuYywNCmFkcDg4
NzBfYmwuYyBvciBsbTM2MzlfYmwuYywgd2hpY2ggd291bGQgd29yayBpbiBteSBhcHBsaWNhdGlv
bi4NCg0KU28gSSBqdXN0IHdhbnRlZCB0byBhZGQgY3VycmVudGx5IG1pc3NpbmcgYmFja2xpZ2h0
X2RldmljZV9yZWdpc3RlcigpIHRvDQpMUDg4NjQsIGJ1dCB0aGVyZSB3ZXJlIG5vIHN1Y2ggZHVh
bC1BUEkgZHJpdmVycyB1bmRlciBkcml2ZXJzL2xlZHMvIHRoYXQncw0Kd2h0IEkgc3RhcnRlZCB3
aXRoIG1vdmluZyBMUDg4NjQgZHJpdmVyIGludG8gZHJpdmVycy92aWRlby9iYWNrbGlnaHQvLg0K
DQpsZWRfYmwuYyBob3dldmVyIGNvdWxkIG9ubHkgYmUgaG90LXBsdWdnYWJsZSBlaXRoZXIgaWYg
b25lIGFjdGl2ZWx5DQpjcmVhdGVzL2Rlc3Ryb3lzIHBsYXRmb3JtIGRldmljZSBzb21ld2hlcmUg
aW4gdGhlIGNvZGUgcHJvZ3JhbW1hdGljYWxseQ0Kb3IgdXNlcyBEVCBvdmVybGF5cy4NCg0KSnVz
dCBhZGRpbmcgYmFja2xpZ2h0IEFQSSB0byBMUDg4NjQgd291bGQgYmUgbXVjaCBtb3JlIGlkaW9t
YXRpYywgSSdkDQpzYXkuDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3
d3cuc2llbWVucy5jb20NCg==
