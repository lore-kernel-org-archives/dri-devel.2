Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B88CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07FEE10E2ED;
	Thu,  1 Oct 2026 08:15:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Os8R4/rE";
	dkim-atps=neutral
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011062.outbound.protection.outlook.com [40.107.74.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6573510E2ED
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 08:15:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlBsidokKaakUlx/7KPsiKj66ao3scVBC4Y65I1bhYER9KdNBVsr/+wI1uqT03feUjXHvenbC4QeZSlK2QBgko1fwJ3sZl00n1lgt5C0usnmcOfaTxBgES67OvjLJlieAjuve7Dg8xXrEQnEgy+Bap+tqwVKQtuFyS59BHDZ6w8wTnr8coQTG3vqB8KW2xOYuSC89CSBQqTDMHR2m2X5hfrDDSEySwY5pM6+5vnl6LhyI8KCcbR1beenGNg9I03mU+ktjFV0qCY49W9y/nZ6jN6FNgpx8DHcmT3G+8BlLaq7rM3oKL2lAcNJfvUgn4CfNzKUk7XpEUL+U8EYy+z0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTw/d9cQZN/Doj+vic5qw+h9E3JEJ6Kz0n7HFTCfqek=;
 b=kO4VawwUfiLGRRygffkvjGSgc8SIIhdl9x2BRVYV8kjuMOoyxeMo3l3ILTQNYj4CP5cKJPlf/Noaak2CAYGjCs7Phn7qLubBEgKa1kXoeuGbtmtRJG98iS1TvL95WIrwYSnTVNm8JHscu++yFmdCOVYHG1HD/fXVcvSb/mMhUdMbnWM0HKs+xLsQuw9i5qCg6zg1ntXe7YZeJ8vuzeSDIIf1YX9Wdx0WAcsMcN5FK9xgehqE3Fj3mWSfwrf8xi/bFhaZigrkmTO8pHvSyCIoYw4zjjz0OfkZPTTNB6b3rJWijrMfuFsE5g3OX04OWP/Mloe+zn67XtFVVuYG0BeDZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTw/d9cQZN/Doj+vic5qw+h9E3JEJ6Kz0n7HFTCfqek=;
 b=Os8R4/rExANnhVHczZ9oqPB4AYKX7HZRt6AAALXnpIuLeIDwcE2kiYYzKysjGDp/6No+DANFRG9roDIzAhQuVih/4M6wHmR7GXtGHxLGu4iT3xC+NFuzsxShM9RIqfz7bgDztBzHkzLS3FfCWcBK/1gYFnITmkFejrrd+8n0V6E=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB17081.jpnprd01.prod.outlook.com (2603:1096:405:339::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 08:15:40 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 08:15:40 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, "biju.das.au"
 <biju.das.au@gmail.com>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Geert Uytterhoeven
 <geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v4 4/9] drm: renesas: rzg2l_mipi_dsi: Add support for DSI
 PWRRDY
Thread-Topic: [PATCH v4 4/9] drm: renesas: rzg2l_mipi_dsi: Add support for DSI
 PWRRDY
Thread-Index: AQHdUOA9xL6s4N461USjKbYIuIFzErboVgiAgAABTwA=
Date: Thu, 1 Oct 2026 08:15:40 +0000
Message-ID: <TY3PR01MB1134680E91884A191791DEC4D868A2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260930133257.23210-1-biju.das.jz@bp.renesas.com>
 <20260930133257.23210-5-biju.das.jz@bp.renesas.com>
 <CA+V-a8tQZONUkeZYFBTvO+L+FTnrq6AE_aJQsm7MFX9CBnA-8w@mail.gmail.com>
In-Reply-To: <CA+V-a8tQZONUkeZYFBTvO+L+FTnrq6AE_aJQsm7MFX9CBnA-8w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB17081:EE_
x-ms-office365-filtering-correlation-id: ffa044e6-efeb-4408-07e9-08df1f942e35
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|18002099003|22082099003|38070700021|4143699003|10067099003|11063799006|56012099006;
x-microsoft-antispam-message-info: fhKYqYT4OcXNnRqO4yifYikHHSBtojf+4rFu6nw42M3t6AcjEBc8hZHmlSrDz8gfBsfT18RyIgCwo0ujexAlpNmWEOyqg7eD4QVTjCaNKNoOVF0e4bIQQC//f7r04J2S+4Ddkomh9ejMKi+ku1bXtMGXPdl702G9+OyVTngxi6oBa2YCaZhe6KvKR4BMpve9tJR5KfUWer5Vfryqf6LLVlXzUsdepmuQwHnhnKKXcNfF+aa0+flTB1sfn480ReqvlT0XPQRDLlFrQxjfuyq0+nEaFbwY4hRDPGjhmeA9GCveIHESCK8WYRKcOcsunZPdfC7Y6xsuuv6FwDhygfSJyK+2PpW7KUj7sZ7J+Urg4gyDzbzUUK2wNTXnhJM9V+FMpKckf755TgY5t3fPm6jwPni4peJgaQvDEkHbuQghfUaa0F05GfhQ7g9GDUQhOGpuXGnAgMn10k2KZWnIVmFGOqjgrSgnSQHyXJRFeYqOI960Fr21NBFXAEQMVCx1v7hqJqlMTD7Dqt+dfSDZ1OD1n9xeROQwdT76x+JUnWF4Hh0NyqiIvOsJANmv+SgIeWACoovQHMRVDzoCPP7YvpkHtDsLFJeo1hSOuBMRAJXxe0SF0Mfg5XE+2o4/s6YUHmoqsfmw8rc6G7OJUvdtc5SKmgJxF1KQqc0A0aF3ObuQDA2yeb91QtgtXoR4fY/wgto98A9ybPalsqityh6JZcl5lA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(18002099003)(22082099003)(38070700021)(4143699003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkFoOXlkc1h6T0NsMUZQaE1IY2JyVlBDZ29meGlobk56T28xNHJYYzBvdmtO?=
 =?utf-8?B?L0ZUTStDWGJYWEVKSmJXai9RdUdNMUVKcWN6MjFVaVFPTWFuNjN6YzJlL29P?=
 =?utf-8?B?eFpEMXhoWTJSRHI1SFcyN3BoalVadXdZb2krekRhbm9ISVRKVDVCdHhWc21t?=
 =?utf-8?B?bmdwejAyS1NCTHE5U1B6TEpMNGQwT0ZWbzNydHNtM09NaWh1bGtZUWdJTHpr?=
 =?utf-8?B?bktUM0ZsYjJrTysyOXIxSVY3SGNRUUN0RjlRSGM2a1QwVkZHdDNUbUxqOXpn?=
 =?utf-8?B?ZXg0UHM0UENDeDBpcFhxb01JaXgvZVY4dWZoSEd6K3Q2NkVKWHBLcitBa0E3?=
 =?utf-8?B?ZXVaVkllMlY3alNNZEVmT1BiZk4vbU8wL0hFMmpYT0NCSFdJWTV4Z2VBaEVY?=
 =?utf-8?B?ck5zVVdaM0llckx3RU5nMHNhaTJPSG9BRlRPTm9QQ0cwalhPRjVhMmlTZUhQ?=
 =?utf-8?B?R1dtdGJBdFdIeDRnd0ZOazd1N0tOVVZxeW1DRitWVVVSVS9LUG5yanhkSUxj?=
 =?utf-8?B?Q0V6am4vZG9uSjd2bm5LYUxSMG8rOUVxam0zQjFXYW9oQm53QlVtSHJyaXFY?=
 =?utf-8?B?WTVqWEdjbEpVTCtuWkVVajYyLzIvVEV4Nk9jMEhOYWwxa0poWkNFcGFHRnRl?=
 =?utf-8?B?QnZtSmowVTJhcTdBRXZ2Z2VTbEFVUGMxNmJweUhROVFSOXh2Qzlja3VYR29u?=
 =?utf-8?B?OEVxblM3akFtL3V6MlF5VkJhSndoQWROVWJRRUVJRWMxalBna3djME1mRWUz?=
 =?utf-8?B?b2tDTUpUSWJ3NXN0SVYrNFR5WnJxSEcwU01sNUtGZExRRTZkZ2JqKzEwQS9y?=
 =?utf-8?B?cmRYbklEb1RYNFZ2OU1LQXg2UzVydEpQcDVBZWtzdmExTkJ3ZloxVWw0bU1p?=
 =?utf-8?B?VXp3MXlPT3NTRlZzbXZ0eHBqYWg2VjZuTzFBZHVmNHNyaXBSeWtNdzJOa0x2?=
 =?utf-8?B?dWRKVzlaSTF3UE9qMTc3bEhzWXdwdkxhNUtLcldvZnVMUVY4RTBaVUFpbFBZ?=
 =?utf-8?B?ZkRBOFltaUlKdWxiVENXMUh4bkVhNkJ3UVRDazFyNW1wbzhTRWUwWDVEZWxS?=
 =?utf-8?B?M3FKMDRVc1psUWNpcUQxM0piV1cyZkdiWVlBWGNVenJ3MXV6aXh3MjlTanND?=
 =?utf-8?B?VGxoVjZqM1owazV1UXN5MnF6aUU4eXo3YnF4SWhCY1VNbXpMdlNtSk1BQWpH?=
 =?utf-8?B?dTcyZGJDL281MDVMUE5WcGRlMCs0TTVnSURWcGdmN1hoTHo1WjhYY1VPbmVP?=
 =?utf-8?B?NVI0ZjlOd0pCVk5IQTYxQ2RtUWdPNmhBMHZtWWNNeFg2azM0WDJEWGJVMHFI?=
 =?utf-8?B?RmJ4Zm4vMjRhaWxaU0FZYUxxL2hLMzA2WE54L2dBQ1NMRjRUWk5GcnZrdHFq?=
 =?utf-8?B?TUkrbDl0Y1dJL1RuOUkyazhjMGRvYWJiUGtXbnF6dzFKVmtVRjZCcWUxdTBs?=
 =?utf-8?B?cllBdnFXL2p5VkVnbktLSm1CR0dEU0oyZE5kUnEvWUFwNXJZSkRhSXhGWmhI?=
 =?utf-8?B?azFxQ2NFVW9YY1ZSeS9QVWV5Sy95TzdWOGtCa2U1Zll5L0Z5TFlEK0I1ZHha?=
 =?utf-8?B?SE9pa1FwK21vOE9kMm9WUlhkSitYQVhZdjFnaTRvTG5uUWRuWDJmUDljL25Z?=
 =?utf-8?B?cmg1ZlhwV201SHBvYjY1K3FjQm1lS0tsUkNzL1p0b2JycEoxQjNreEYwUWJC?=
 =?utf-8?B?NW0xSXlSNTZLaHg5NHNZc3pkeXNLZGR0dHI2bTJ3dWVYeEVCMGZzOHh4Z1BW?=
 =?utf-8?B?UG5oSnJFZ3dja2RQL05SbXV5RUptaHZZY05zL096KzBuaExxeDVsUCtrSzFO?=
 =?utf-8?B?THlsblpRbG1nOU0yZ3N4M2l6cjhIbkJicFhEcThaUmhzTFArc2Y1SHEyeVZH?=
 =?utf-8?B?T011NndsZkRQWElNSzBxSUxLZUxJdmVBajdkemp5dDI5ZjNzeDYxMjdtMS9Z?=
 =?utf-8?B?QlU1R0FldU9jcHN5K1p1MktJNUNhdW1ld1RvT2JxblhST3FzczhDTXAxNGFZ?=
 =?utf-8?B?MXZsOG5ma01KTkp5bW9tazhMSEJURnRXcjlJVHUxbStvdW03QTFoQUpUSjRW?=
 =?utf-8?B?VVE0UDIrb3laYXNvcTg4bzQ2dW10ZTV4Nnd3SXZjNnBYOFFySzFBSjdwSFpD?=
 =?utf-8?B?VFJtb1pSUDFnajVhZm1LamI2VjlXc0NlZ0ZlOXY2Vk9Zejl0OWwwRk5uVGEz?=
 =?utf-8?B?d2pXRnNZY0dXOXcybUhITWdyc0xEKzVzbHR5K0lkZTdRK1RueGZJMzBUTUlS?=
 =?utf-8?B?Smw4REJjTkhTSDgzRmZGZUVCcElHUTBoVzA2RzdhWFphaTUxVkgxQ2tmMGtG?=
 =?utf-8?B?WERVTW91cTNhZEJyakcrS2N2MlBmeHVzVml5bURnUEU3dnU3U09xZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa044e6-efeb-4408-07e9-08df1f942e35
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 08:15:40.0286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0YT0rC++gX6AgdqQ4cQ9HxNG5A9evBh1jjWZQOC38IFB+QdTopK4RPKSdkyy2Yyi8FWP04pbRFtQG7VFw6TqghQyOl8N0VbAhODebrK1sa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17081
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

SGkgUHJhYmhha2FyLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYWQsIFByYWJoYWthciA8cHJhYmhha2FyLmNzZW5n
Z0BnbWFpbC5jb20+DQo+IFNlbnQ6IDAxIE9jdG9iZXIgMjAyNiAwOTowNw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHY0IDQvOV0gZHJtOiByZW5lc2FzOiByemcybF9taXBpX2RzaTogQWRkIHN1cHBv
cnQgZm9yIERTSSBQV1JSRFkNCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRo
ZSBwYXRjaC4NCj4gDQo+IE9uIFdlZCwgU2VwIDMwLCAyMDI2IGF0IDM6NDfigK9QTSBCaWp1IDxi
aWp1LmRhcy5hdUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogQmlqdSBEYXMgPGJp
anUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+DQo+ID4gVGhlIHJlZ2lzdGVyIGZvciBjb250
cm9sbGluZyBwb3dlciB0byB0aGUgRFNJIHJlZ2lvbiBpcyBpbiB0aGUgU1lTQw0KPiA+IChTeXN0
ZW0gQ29udHJvbGxlcikgYmxvY2suIEFkZCBzdXBwb3J0IGZvciBjb250cm9sbGluZyB0aGUgRFNJ
IFBXUlJEWQ0KPiA+IHNpZ25hbCBzbyB0aGUgZHJpdmVyIGNhbiBlZmZpY2llbnRseSBtYW5hZ2Ug
cG93ZXIgdG8gdGhlIERTSSByZWdpb24uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERh
cyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gdjMtPnY0Og0KPiA+
ICAqIERyb3BwZWQgcHdycmR5IHZhcmlhYmxlIGZyb20gc3RydWN0IHJ6ZzJsX21pcGlfZHNpX2h3
X2luZm8gYW5kIGluc3RlYWQNCj4gPiAgICB1c2luZyBmZWF0dXJlIGZsYWcgUlpfTUlQSV9EU0lf
RkVBVFVSRV9QV1JSRFkNCj4gPiAgKiBEcm9wcGVkIHJ6ZzJsX21pcGlfZHNpX3B3cnJkeV9vZmYo
KSBhcyBpdCBpcyB0YWtlbiBjYXJlIGJ5DQo+ID4gICAgZGV2bV9wd3JzZXFfZ2V0KCkuDQo+ID4g
djItPnYzOg0KPiA+ICAqIFVwZGF0ZWQgcG93ZXJzZXEgQVBJIG5hbWVzLg0KPiA+IHYxLT52MjoN
Cj4gPiAgKiBTd2l0Y2hlZCB0byBwb3dlciBzZXF1ZW5jZSBmb3IgaGFuZGxpbmcgcHdycmR5IHNp
Z25hbC4NCj4gPiAgKiBEcm9wcGVkIGhlYWRlciBmaWxlIHJlZ21hcC5oIGFuZCBtZmQvc3lzY29u
LmgNCj4gPiAgKiBBZGRlZCBoZWFkZXIgZmlsZSBwd3JzZXEvY29uc3VtZXIuaA0KPiA+IC0tLQ0K
PiA+ICAuLi4vZ3B1L2RybS9yZW5lc2FzL3J6LWR1L3J6ZzJsX21pcGlfZHNpLmMgICAgfCAyNyAr
KysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCsp
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JlbmVzYXMvcnotZHUvcnpn
MmxfbWlwaV9kc2kuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL3JlbmVzYXMvcnotZHUvcnpnMmxf
bWlwaV9kc2kuYw0KPiA+IGluZGV4IGQ2N2UxMjMwYjcwYy4uNTI2M2IyYjhmMWNhIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yZW5lc2FzL3J6LWR1L3J6ZzJsX21pcGlfZHNpLmMN
Cj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmVuZXNhcy9yei1kdS9yemcybF9taXBpX2RzaS5j
DQo+ID4gQEAgLTE4LDYgKzE4LDcgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L29mX2dyYXBoLmg+
DQo+ID4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPiAgI2luY2x1ZGUg
PGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3B3cnNlcS9jb25zdW1l
ci5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4
L3NsYWIuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3VuaXRzLmg+DQo+ID4gQEAgLTM4LDYgKzM5
LDcgQEAgTU9EVUxFX0lNUE9SVF9OUygiUlpWMkhfQ1BHIik7DQo+ID4gICNkZWZpbmUgUlpHMkxf
RENTX0JVRl9TSVpFICAgICAxMjggLyogTWF4aW11bSBEQ1MgYnVmZmVyIHNpemUgaW4gZXh0ZXJu
YWwgbWVtb3J5LiAqLw0KPiA+DQo+ID4gICNkZWZpbmUgUlpfTUlQSV9EU0lfRkVBVFVSRV8xNkJQ
UCAgICAgIEJJVCgwKQ0KPiA+ICsjZGVmaW5lIFJaX01JUElfRFNJX0ZFQVRVUkVfUFdSUkRZICAg
ICBCSVQoMSkNCj4gPg0KPiA+ICBzdHJ1Y3QgcnpnMmxfbWlwaV9kc2k7DQo+ID4NCj4gPiBAQCAt
ODcsNiArODksOCBAQCBzdHJ1Y3QgcnpnMmxfbWlwaV9kc2kgew0KPiA+ICAgICAgICAgc3RydWN0
IGNsayAqdmNsazsNCj4gPiAgICAgICAgIHN0cnVjdCBjbGsgKmxwY2xrOw0KPiA+DQo+ID4gKyAg
ICAgICBzdHJ1Y3QgcHdyc2VxX2Rlc2MgKnB3cnNlcTsNCj4gPiArDQo+ID4gICAgICAgICBlbnVt
IG1pcGlfZHNpX3BpeGVsX2Zvcm1hdCBmb3JtYXQ7DQo+ID4gICAgICAgICB1bnNpZ25lZCBpbnQg
bnVtX2RhdGFfbGFuZXM7DQo+ID4gICAgICAgICB1bnNpZ25lZCBpbnQgbGFuZXM7DQo+ID4gQEAg
LTEzOTYsNiArMTQwMCwyNSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgcnpnMmxf
bWlwaV9wbV9vcHMgPSB7DQo+ID4gICAqIFByb2JlICYgUmVtb3ZlDQo+ID4gICAqLw0KPiA+DQo+
ID4gK3N0YXRpYyBpbnQgcnpnMmxfbWlwaV9kc2lfcHdycmR5X2luaXQoc3RydWN0IHJ6ZzJsX21p
cGlfZHNpICpkc2kpIHsNCj4gPiArICAgICAgIGlmICghKGRzaS0+aW5mby0+ZmVhdHVyZXMgJiBS
Wl9NSVBJX0RTSV9GRUFUVVJFX1BXUlJEWSkpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAw
Ow0KPiA+ICsNCj4gPiArICAgICAgIGRzaS0+cHdyc2VxID0gZGV2bV9wd3JzZXFfZ2V0KGRzaS0+
ZGV2LCAiZHNpLXB3cnJkeSIpOw0KPiA+ICsgICAgICAgaWYgKElTX0VSUihkc2ktPnB3cnNlcSkp
IHsNCj4gPiArICAgICAgICAgICAgICAgLyoNCj4gPiArICAgICAgICAgICAgICAgICogVGhpcyBw
bGF0Zm9ybSByZXF1aXJlcyBhIHNlcXVlbmNlci4gSWYgd2UgY2FuJ3QgZ2V0IGl0LCB3ZQ0KPiA+
ICsgICAgICAgICAgICAgICAgKiBtdXN0IHJldHVybiB0aGUgZXJyb3IgKGluY2x1ZGluZyAtRVBS
T0JFX0RFRkVSIHRvIHdhaXQgZm9yDQo+ID4gKyAgICAgICAgICAgICAgICAqIHRoZSBwcm92aWRl
ciB0byBhcHBlYXIpDQo+ID4gKyAgICAgICAgICAgICAgICAqLw0KPiA+ICsgICAgICAgICAgICAg
ICByZXR1cm4gZGV2X2Vycl9wcm9iZShkc2ktPmRldiwgUFRSX0VSUihkc2ktPnB3cnNlcSksDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJGYWlsZWQgdG8gZ2V0IHJl
cXVpcmVkIHBvd2VyIHNlcXVlbmNlclxuIik7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsg
ICAgICAgcmV0dXJuIHB3cnNlcV9lbmFibGUoZHNpLT5wd3JzZXEpOw0KPiBEbyB3ZSB3YW50IHRv
IGFkZCBhIGRldm0gYWN0aW9uIHRvIGRpc2FibGUgdGhlIHB3cnNlcSB3aGVuIHRoZSBEU0kgZHJp
dmVyIGlzIHJlbW92ZWQ/DQoNCkl0IGlzIHRha2VuIGNhcmUgYnkgZGV2bV9wd3JzZXFfcHV0KCkg
dGhlIHJlbGVhc2UgaGFuZGxlcg0KdGhhdCBjYWxscyBwd3JzZXFfZGlzYWJsZSgpLg0KDQoJaWYg
KGRlc2MtPnBvd2VyZWRfb24pDQoJCXB3cnNlcV9kaXNhYmxlKGRlc2MpOw0KDQpDaGVlcnMsDQpC
aWp1DQoNCj4gDQo+IFJlc3QgTEdUTS4NCj4gDQo+IENoZWVycywNCj4gUHJhYmhha2FyDQo+IA0K
PiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgaW50IHJ6ZzJsX21pcGlfZHNpX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpICB7DQo+ID4gICAgICAgICB1bnNpZ25lZCBpbnQgbnVt
X2RhdGFfbGFuZXM7DQo+ID4gQEAgLTE0NTQsNiArMTQ3NywxMCBAQCBzdGF0aWMgaW50IHJ6ZzJs
X21pcGlfZHNpX3Byb2JlKHN0cnVjdA0KPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPg0K
PiA+ICAgICAgICAgcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgZHNpKTsNCj4gPg0KPiA+ICsg
ICAgICAgcmV0ID0gcnpnMmxfbWlwaV9kc2lfcHdycmR5X2luaXQoZHNpKTsNCj4gPiArICAgICAg
IGlmIChyZXQpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICAg
ICAgICAgcG1fcnVudGltZV9lbmFibGUoZHNpLT5kZXYpOw0KPiA+DQo+ID4gICAgICAgICByZXQg
PSBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KGRzaS0+ZGV2KTsNCj4gPiAtLQ0KPiA+IDIuNDMu
MA0KPiA+DQo+ID4NCg==
