Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276CCCDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53FAD10E545;
	Mon, 22 Jun 2026 09:01:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="ed1Q9uf1";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011052.outbound.protection.outlook.com [52.101.57.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA81510E545
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 09:00:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QigMKRS7cm3RzVPt9a7G/6JlniFBfa+IWgPSpYVNA0cDyfgzz8UwPpsJ9lp2wUWnBaOt1A5Xu0hzw6CYGR/zNjjd5QjswmNCKsYskc6XLZzxJNuTIqzylWDWjceLUsATNFws/T2+Id3DqPOsOcNu/5HpNE9nZ07NFrNrluwjh7nkDoGxyzkR8kVuOl7kp+SKYFnVxMoI6VYmyZqZf4CoXnL6XcWdRChUmF/Zq0QlJCv7fCaRekWd1Sb6CR8Ksht97j7ciV0Bqz15TpeNHlUBCdBmkTXDyQ2XjheGnWaqJ1IQwH7R7x4j0n04Al8K3sRKXhINopQT/vBj/CZmnMuJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fv7C/88W4inU6+30HUkncIvvcmxeyuyfMHEtWdAFIA4=;
 b=yY1WTqxCI2usFFD1R3g5uxLLZ88sWTs+U47Vf1Zoe42N8+lbbjvGFr/A5O3VA3W7+501Q/vWabAAEWyJ/0RW1iRN5dDOkdqwbtGDgsAjp9LZk0zoiwZnquRPBV3vWhSYfzGZ3HUGGDPYevk82e+hfZSuGj7CVk4BMydJwHAZ23dwD0ziBLkFWrXJNb54DSOdoYob9SIjZhL6kwHMREUV2RVrY9dG4Cu+j6LRZNgy/2UOZ3DECDE+JlepazV453ypWq3YKapVnpHHRhe/HOe/OQr2s0W9KLEgSpTOUFGYeCHAwe7BJT0MuVgMT+2dG/kmTV4ObLZ/MCqMeBerC7lCkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fv7C/88W4inU6+30HUkncIvvcmxeyuyfMHEtWdAFIA4=;
 b=ed1Q9uf1aArST0Fxd1D73dH5hWBdjI7r3RcjaKtSEmgoXdI64JdfZtNq6HnCPTXHbU34wvcW0CW+WYZf25tMAla2HvFEFkGyVt7tvK+fSNuRH6rrmDNlMJHK93Db32qgTkqJfapQBCR8ectYNj2EAW0rUQyY+OeYI3qeHJOCK4XCH9gm8Dldxf0chaGoxsP8bxQZ01Ge/xxKMsURsQgZ6W8p4VBr3c/gA/WKIVpvpj7fvlH+ZXyHaxh6lgf4JYUhngSxfjUkrkhjtU6xsABtB1B0t1yGKI5t3cu4XxNvvJvaIgrwDvlERVGlz2w9WEGhslM6EezqZajvmEvJ8oHxOA==
Received: from DM3PPF9623118BD.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f3a) by PH9PR11MB126636.namprd11.prod.outlook.com
 (2603:10b6:510:3e9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 22 Jun
 2026 09:00:55 +0000
Received: from DM3PPF9623118BD.namprd11.prod.outlook.com
 ([fe80::ad98:5674:dd4c:875d]) by DM3PPF9623118BD.namprd11.prod.outlook.com
 ([fe80::ad98:5674:dd4c:875d%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 09:00:55 +0000
From: <Manikandan.M@microchip.com>
To: <mripard@kernel.org>, <andrzej.hajda@intel.com>,
 <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
 <airlied@gmail.com>, <simona@ffwll.ch>
CC: <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <luca.ceresoli@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <dharma.b@microchip.com>
Subject: Re: [PATCH 13/37] drm/bridge: microchip-lvds: Switch to atomic bridge
 callbacks
Thread-Topic: [PATCH 13/37] drm/bridge: microchip-lvds: Switch to atomic
 bridge callbacks
Thread-Index: AQHc/kI6drRo0ZwzNU6lOfiqaUVgLLZKTsCA
Date: Mon, 22 Jun 2026 09:00:55 +0000
Message-ID: <20669827-fc0b-4003-ad22-1da223c26627@microchip.com>
References: <20260617-drm-all-atomic-bridges-v1-0-b63e6316166b@kernel.org>
 <20260617-drm-all-atomic-bridges-v1-13-b63e6316166b@kernel.org>
In-Reply-To: <20260617-drm-all-atomic-bridges-v1-13-b63e6316166b@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF9623118BD:EE_|PH9PR11MB126636:EE_
x-ms-office365-filtering-correlation-id: 8e35cc2f-f0ed-4f41-c3ed-08ded03cc519
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|38070700021|18002099003|56012099006|11063799006|4143699003|22082099003;
x-microsoft-antispam-message-info: Rl25YBb9xz6DSA5QW6SBkEd8i+uKod+Ygs/gbKDHxHr0DhzHn6rLlVmwRtpUbXd5lQ/AKMbFpXhOJYkNaRGCwnz21H19kKwAT5x+zADjIpORw7zkLxuGLc/5CA0U6Dnk2qOM4gcuKwT5tt7Cs6GK9vZErcnNDuQ+u/YIr0BmMILxl+IMswVwm9XxYzyl9kyWIKGKENR+Ki2XwmiAhLF+IpSemLe1pW+aa6ESs5V25/y66TWjiYg3RJpa1VpXKWigVOjJb1hHyuLmVoBP6I9dH7YWdBCBvxhcpDfA5ybtiJgL5dQ6chFUNUWz0soZKcls8SSkNdAK+r1wv6RCEZTjqDpY1jh/sqa58cDqlwrfNbRMgTkiujzd2YXrokXyUc8K8LOAsEMrJg2yrFK4H2gYBxVLt6Uhc5uUAl4I8oH5TZQYLuFuxHBunBDP378aJNDWFQ2Z2ABT+zi3UpidnCNun+tlcGiMslvpp76jQx3pNfCilmFLMO0Ap2mUXq8gr5wbg6ZTQ5rkOYrp3JYUyxxonEdoS+rAUbFHqhUoioTQ9CXfxpsSdU5pxJAeD4XKooH4ISOrynJc0QnQfIsvDZP8ZBQOoxH42J8NB9Kn+ETysd5BDMNtN1dlBrqatGv+igxEn1kX4IUWM8W4wOfRZd5cjto+PXj//UZHdNGeJBc6JwPO27HI8t+M307tdnYj+khRp6oimQNwET2fLuoClu6PYgxZ9lb+LbveVnpvN8eNbzs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF9623118BD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(38070700021)(18002099003)(56012099006)(11063799006)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkhxVnllbjRRR3puUVdWcThCcGg2V2N3NzAxbkxxdmoyTGU4NzFkOUFzRUJp?=
 =?utf-8?B?bFZuSDRTbWg2cklTNVErd0wyRGE3aXc5dnh4SmtZQTlZWjh4NS9nM2hDQUxv?=
 =?utf-8?B?ckFhRnkzdy90R0hkaGg0a0FIdGRnQ2Q0WlRJSjM3QW9FU2EwZjQ3QTU3dEZu?=
 =?utf-8?B?UDhyVWF6UW5BeHRoQmNXQjJNLzVGMmpSQ1VKaXpaK1FkMDNqUHFneXlJUUZ4?=
 =?utf-8?B?L2RxcGVCbk1UOTloRW5hZDlLcEZidVRLakF3anN6VFd3Zk10eVMxbC9idHk3?=
 =?utf-8?B?T1NYQnRRTnZFa1hNWnorYlE3ZlExTEttem9WSHE5YVFySmlodWpRWEFMTjVD?=
 =?utf-8?B?ODQyUE13a2h4aUM5RHk4eEtTQWxNNklXMWZzRFl4VTZKYjJRU3hrM2pRSXY0?=
 =?utf-8?B?TUNyYVVxditTdUxnTzNnTHgrM1NPTGtWMjJ5dzdveVJIcFpCdlJueWZoZEpK?=
 =?utf-8?B?bjRibVRZb0x2MFhJNHYzbnk5Wm5ic21KNDIzUTdiSkVoOWo4V0svajFFekh2?=
 =?utf-8?B?YmovbjYrWk1pWlg0ei8xM2lzWGFNYWtCS1lnSnptU0VDNEUvbWRyMzZ2K3Ar?=
 =?utf-8?B?bThQOUJldzNhRlhIWjJhcnZQcUM5SEIwSVVIa0EzNjZtSGQ3RXM3THhNam1T?=
 =?utf-8?B?TnM3czgwSHlqRHVrSUlUUWxmOU1WelYrcEFSNk5MNllLcGxBaExWdUZZOCtl?=
 =?utf-8?B?dHpGVTdYMGMwSytYMUNNZjE2MWsyZFVPU2VaUVlPSVdUTFRZVkxvUTlRa0sw?=
 =?utf-8?B?Vkkwd2FQcTlyem5NV3U0ZFI3TUFOQWwzOVp6UFlQaDVVM1VMRFFUMG5najNE?=
 =?utf-8?B?S0Uza3FXaGRsYnN4eFF5T2t1dHpUSFFCeFBmSVJoSi90YTZtblJjdXp2b2tx?=
 =?utf-8?B?NFNWaTlJMjJ0Yk5iWTUxWndRc2s1bnArb0I2ZUVMUVhHUGxreUJRbkxoOG5o?=
 =?utf-8?B?TWNaZEtmMXV1MFQzZ0lSVWZscXlXcStZNEJqVzFzM1VDbjRjUmM5L1M0ZmRX?=
 =?utf-8?B?QlJZdGl4MlVNdUZNa0k4Ukd5eVFQMWlGakc2dWVsQkhWcnZsUzFmSk5wN2x5?=
 =?utf-8?B?N0ZsMVl4QXQrSThya09Ib2k0KzRSOWtVU1hQZkhwRGphSHJRaVZRZThBN1By?=
 =?utf-8?B?NFVKTXU2M0ZNWHdVL2F3VHRML1BQK3plcFA1SWJ2dzVVc1pWc1V2WnhwZUN0?=
 =?utf-8?B?UkVrRlNPbTQ2Z2FDNkQxZHQ5ZmFCc204MHJUbkZOZnBidzJtaW52bCtLa3VB?=
 =?utf-8?B?OGRnZjdyMSt1TTFWazZvRkpZU1VMNFB4d2ZRNEpPOTdvVENCREdNNFFwNXNV?=
 =?utf-8?B?WWZraC9mWVFucEN2cGZnZHZRVzlSUWdqNHlVOGhXb05TSXcraFZBT0MvbFlC?=
 =?utf-8?B?UzE0RUZEbDR1c3JMODRxMGdSdnBKR0dEb05vWlFkVUZ2VmhJbVJkM3Y0eXpO?=
 =?utf-8?B?VlNsZVNPWUtBUmNmNHhiQTNmK2RUWCtDb3czcXpNOSt0Z3BZOFhzOGUybkRp?=
 =?utf-8?B?Q21tMW0wY01nZjZnckpIREgxNjJhczZJWHJ2ZHZFMTZaOVdCZTZuYnEwTTRQ?=
 =?utf-8?B?MVFHYVlsTVpmTkdSbWRhTjdLY2NTN3licFNjU2NNRm5haUVPN29Td0E0S0J6?=
 =?utf-8?B?dStleDJ3c1BHNGd0NEtpaUM4U25YVi9vRFFJMk9LOVpqcGhkNWxJaU81Q0U5?=
 =?utf-8?B?eThCMmpocUhaekVIbFV5OTRJNTlEbnA3OWp6eWxvaTJsT284aVdld3NxNWpH?=
 =?utf-8?B?d1NEdUt0blZSZElMdU9jVWpDYllRaTRkOHNIQSsybFZBQkxTdURiTGxaWUc2?=
 =?utf-8?B?RFpHOVRPTGhDcTFvQmZZM2F0aTBXd04zS25sTTBnU3NWUzgxeXZGSXhzbW1w?=
 =?utf-8?B?cHdWUTBXVjlVZ1FjSkRDT3dsQ2I1bEcwVnFUeTJadHFaek85eGxhMlFSSTdK?=
 =?utf-8?B?WE9wQzMyeVU1bDBSUFlTejZHKzFseGRNa3duSnJxTDF6b1Q0ejI2eE1nYzY3?=
 =?utf-8?B?TENGbVp2V3lXMXU5Q2xoeG1pTTBCR2ZIbnM1VzBWaHhqKzhGUmh0MlZmNmta?=
 =?utf-8?B?b2FTUXZ1Si9wMVc0YnlpVnVsdTV3aWw1c3dvZzR4MzU1ZEFJeUVraUllRkli?=
 =?utf-8?B?Rit1WTRnT2tSaUZiczNNVTZ0SE1wODBzcEZqaExtYVByMkVtVk9tRHVVZVBr?=
 =?utf-8?B?LzVvdGowNnQ0S1AveElDcXpGQkRCcU0wdlcyakwxSmFmdDJuNVUwckVGNFRM?=
 =?utf-8?B?cG9oNStQaEZMVFlXcmxHMnJWOW9zeG9aSUI1QXRETGpYdWxid1VLTUFhbytv?=
 =?utf-8?B?ZGRqNFd4K2hrWElIckpoNXRieGJFc2hGNHBnSHNWN3p3eVkzaGljdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F891F4ADDBEDD42B52DEAC185935242@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF9623118BD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e35cc2f-f0ed-4f41-c3ed-08ded03cc519
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 09:00:55.6428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WO3JKSb5W7tL3CCnc0C/W+mkJ3p0xEd81iyPZIcLxndl2hoNwCFRIqkDik/oBlN3Q3pywNVyVE/79LavX7/1liaUEFV302SaEODBcdLX3+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR11MB126636
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

T24gNi8xNy8yNiAzOjQ0IFBNLCBNYXhpbWUgUmlwYXJkIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoZSBtaWNyb2NoaXAtbHZkcyBicmlkZ2Ugc3Rp
bGwgdXNlcyB0aGUgZGVwcmVjYXRlZCBub24tYXRvbWljIGJyaWRnZQ0KPiBjYWxsYmFja3MuDQo+
IA0KPiBTd2l0Y2ggdG8gdGhlaXIgYXRvbWljIGNvdW50ZXJwYXJ0cywgYWRkaW5nIHRoZSBicmlk
Z2Ugc3RhdGUNCj4gaGFuZGxlcnMgaWYgbm90IGFscmVhZHkgcHJlc2VudC4NCj4gDQo+IEdlbmVy
YXRlZCBieSB0aGUgZm9sbG93aW5nIENvY2NpbmVsbGUgc2NyaXB0Og0KPiANCj4gQCBpc19icmlk
Z2UgQA0KPiBpZGVudGlmaWVyIGZ1bmNzOw0KPiBAQA0KPiANCj4gICBzdHJ1Y3QgZHJtX2JyaWRn
ZV9mdW5jcyBmdW5jcyA9IHsNCj4gICAgICAgICAgLi4uLA0KPiAgIH07DQo+IA0KPiBAIGhhc19j
cmVhdGVfc3RhdGUgZGVwZW5kcyBvbiBpc19icmlkZ2UgQA0KPiBpZGVudGlmaWVyIGZ1bmNzLCBm
Ow0KPiBAQA0KPiANCj4gc3RydWN0IGRybV9icmlkZ2VfZnVuY3MgZnVuY3MgPSB7DQo+ICAgIC4u
LiwNCj4gICAgLmF0b21pY19jcmVhdGVfc3RhdGUgPSBmLA0KPiAgICAuLi4sDQo+IH07DQo+IA0K
PiBAIHVwZGF0ZV9zdHJ1Y3QgZGVwZW5kcyBvbiAoaXNfYnJpZGdlICYmICFoYXNfY3JlYXRlX3N0
YXRlKSBADQo+IGlkZW50aWZpZXIgaXNfYnJpZGdlLmZ1bmNzOw0KPiBpZGVudGlmaWVyIGY7DQo+
IEBADQo+IA0KPiAgIHN0cnVjdCBkcm1fYnJpZGdlX2Z1bmNzIGZ1bmNzID0gew0KPiArICAgICAg
IC5hdG9taWNfY3JlYXRlX3N0YXRlID0gZHJtX2F0b21pY19oZWxwZXJfYnJpZGdlX2NyZWF0ZV9z
dGF0ZSwNCj4gKyAgICAgICAuYXRvbWljX2Rlc3Ryb3lfc3RhdGUgPSBkcm1fYXRvbWljX2hlbHBl
cl9icmlkZ2VfZGVzdHJveV9zdGF0ZSwNCj4gKyAgICAgICAuYXRvbWljX2R1cGxpY2F0ZV9zdGF0
ZSA9IGRybV9hdG9taWNfaGVscGVyX2JyaWRnZV9kdXBsaWNhdGVfc3RhdGUsDQo+ICAgICAgICAg
IC4uLiwNCj4gICB9Ow0KPiANCj4gQCB1cGRhdGVfcHJlX2VuYWJsZV9zdHJ1Y3QgZGVwZW5kcyBv
biAoaXNfYnJpZGdlICYmICFoYXNfY3JlYXRlX3N0YXRlKSBADQo+IGlkZW50aWZpZXIgaXNfYnJp
ZGdlLmZ1bmNzOw0KPiBpZGVudGlmaWVyIGY7DQo+IEBADQo+IA0KPiAgIHN0cnVjdCBkcm1fYnJp
ZGdlX2Z1bmNzIGZ1bmNzID0gew0KPiAgICAgICAgICAuLi4sDQo+IC0gICAgICAgLnByZV9lbmFi
bGUgPSBmLA0KPiArICAgICAgIC5hdG9taWNfcHJlX2VuYWJsZSA9IGYsDQo+ICAgICAgICAgIC4u
LiwNCj4gICB9Ow0KPiANCj4gQCB1cGRhdGVfcHJlX2VuYWJsZV9pbXBsIGRlcGVuZHMgb24gdXBk
YXRlX3ByZV9lbmFibGVfc3RydWN0IEANCj4gaWRlbnRpZmllciB1cGRhdGVfcHJlX2VuYWJsZV9z
dHJ1Y3QuZjsNCj4gaWRlbnRpZmllciBiOw0KPiBAQA0KPiANCj4gLXZvaWQgZihzdHJ1Y3QgZHJt
X2JyaWRnZSAqYikNCj4gK3ZvaWQgZihzdHJ1Y3QgZHJtX2JyaWRnZSAqYiwgc3RydWN0IGRybV9h
dG9taWNfY29tbWl0ICpjb21taXQpDQo+ICAgew0KPiAgICAgICAgICAuLi4NCj4gICB9DQo+IA0K
PiBAIHVwZGF0ZV9lbmFibGVfc3RydWN0IGRlcGVuZHMgb24gKGlzX2JyaWRnZSAmJiAhaGFzX2Ny
ZWF0ZV9zdGF0ZSkgQA0KPiBpZGVudGlmaWVyIGlzX2JyaWRnZS5mdW5jczsNCj4gaWRlbnRpZmll
ciBmOw0KPiBAQA0KPiANCj4gICBzdHJ1Y3QgZHJtX2JyaWRnZV9mdW5jcyBmdW5jcyA9IHsNCj4g
ICAgICAgICAgLi4uLA0KPiAtICAgICAgIC5lbmFibGUgPSBmLA0KPiArICAgICAgIC5hdG9taWNf
ZW5hYmxlID0gZiwNCj4gICAgICAgICAgLi4uLA0KPiAgIH07DQo+IA0KPiBAIHVwZGF0ZV9lbmFi
bGVfaW1wbCBkZXBlbmRzIG9uIHVwZGF0ZV9lbmFibGVfc3RydWN0IEANCj4gaWRlbnRpZmllciB1
cGRhdGVfZW5hYmxlX3N0cnVjdC5mOw0KPiBpZGVudGlmaWVyIGI7DQo+IEBADQo+IA0KPiAtdm9p
ZCBmKHN0cnVjdCBkcm1fYnJpZGdlICpiKQ0KPiArdm9pZCBmKHN0cnVjdCBkcm1fYnJpZGdlICpi
LCBzdHJ1Y3QgZHJtX2F0b21pY19jb21taXQgKmNvbW1pdCkNCj4gICB7DQo+ICAgICAgICAgIC4u
Lg0KPiAgIH0NCj4gDQo+IEAgdXBkYXRlX2Rpc2FibGVfc3RydWN0IGRlcGVuZHMgb24gKGlzX2Jy
aWRnZSAmJiAhaGFzX2NyZWF0ZV9zdGF0ZSkgQA0KPiBpZGVudGlmaWVyIGlzX2JyaWRnZS5mdW5j
czsNCj4gaWRlbnRpZmllciBmOw0KPiBAQA0KPiANCj4gICBzdHJ1Y3QgZHJtX2JyaWRnZV9mdW5j
cyBmdW5jcyA9IHsNCj4gICAgICAgICAgLi4uLA0KPiAtICAgICAgIC5kaXNhYmxlID0gZiwNCj4g
KyAgICAgICAuYXRvbWljX2Rpc2FibGUgPSBmLA0KPiAgICAgICAgICAuLi4sDQo+ICAgfTsNCj4g
DQo+IEAgdXBkYXRlX2Rpc2FibGVfaW1wbCBkZXBlbmRzIG9uIHVwZGF0ZV9kaXNhYmxlX3N0cnVj
dCBADQo+IGlkZW50aWZpZXIgdXBkYXRlX2Rpc2FibGVfc3RydWN0LmY7DQo+IGlkZW50aWZpZXIg
YjsNCj4gQEANCj4gDQo+IC12b2lkIGYoc3RydWN0IGRybV9icmlkZ2UgKmIpDQo+ICt2b2lkIGYo
c3RydWN0IGRybV9icmlkZ2UgKmIsIHN0cnVjdCBkcm1fYXRvbWljX2NvbW1pdCAqY29tbWl0KQ0K
PiAgIHsNCj4gICAgICAgICAgLi4uDQo+ICAgfQ0KPiANCj4gQCB1cGRhdGVfcG9zdF9kaXNhYmxl
X3N0cnVjdCBkZXBlbmRzIG9uIChpc19icmlkZ2UgJiYgIWhhc19jcmVhdGVfc3RhdGUpIEANCj4g
aWRlbnRpZmllciBpc19icmlkZ2UuZnVuY3M7DQo+IGlkZW50aWZpZXIgZjsNCj4gQEANCj4gDQo+
ICAgc3RydWN0IGRybV9icmlkZ2VfZnVuY3MgZnVuY3MgPSB7DQo+ICAgICAgICAgIC4uLiwNCj4g
LSAgICAgICAucG9zdF9kaXNhYmxlID0gZiwNCj4gKyAgICAgICAuYXRvbWljX3Bvc3RfZGlzYWJs
ZSA9IGYsDQo+ICAgICAgICAgIC4uLiwNCj4gICB9Ow0KPiANCj4gQCB1cGRhdGVfcG9zdF9kaXNh
YmxlX2ltcGwgZGVwZW5kcyBvbiB1cGRhdGVfcG9zdF9kaXNhYmxlX3N0cnVjdCBADQo+IGlkZW50
aWZpZXIgdXBkYXRlX3Bvc3RfZGlzYWJsZV9zdHJ1Y3QuZjsNCj4gaWRlbnRpZmllciBiOw0KPiBA
QA0KPiANCj4gLXZvaWQgZihzdHJ1Y3QgZHJtX2JyaWRnZSAqYikNCj4gK3ZvaWQgZihzdHJ1Y3Qg
ZHJtX2JyaWRnZSAqYiwgc3RydWN0IGRybV9hdG9taWNfY29tbWl0ICpjb21taXQpDQo+ICAgew0K
PiAgICAgICAgICAuLi4NCj4gICB9DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXhpbWUgUmlwYXJk
IDxtcmlwYXJkQGtlcm5lbC5vcmc+DQo+IA0KUmV2aWV3ZWQtYnk6IE1hbmlrYW5kYW4gTXVyYWxp
ZGhhcmFuIDxtYW5pa2FuZGFuLm1AbWljcm9jaGlwLmNvbT4NCg0KVGhhbmsgeW91Lg0KPiAtLS0N
Cj4gVG86IE1hbmlrYW5kYW4gTXVyYWxpZGhhcmFuIDxtYW5pa2FuZGFuLm1AbWljcm9jaGlwLmNv
bT4NCj4gVG86IERoYXJtYSBCYWxhc3ViaXJhbWFuaSA8ZGhhcm1hLmJAbWljcm9jaGlwLmNvbT4N
Cj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9taWNyb2NoaXAtbHZkcy5jIHwgMyAr
KysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9taWNyb2NoaXAtbHZkcy5jIGIvZHJpdmVycy9ncHUv
ZHJtL2JyaWRnZS9taWNyb2NoaXAtbHZkcy5jDQo+IGluZGV4IDVmYjg2MzNmNDNjNS4uZGQ0ZmZj
OWY0ZGYzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL21pY3JvY2hpcC1s
dmRzLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9taWNyb2NoaXAtbHZkcy5jDQo+
IEBAIC0xNjUsMTAgKzE2NSwxMyBAQCBzdGF0aWMgdm9pZCBtY2hwX2x2ZHNfYXRvbWljX2Rpc2Fi
bGUoc3RydWN0IGRybV9icmlkZ2UgKmJyaWRnZSwNCj4gICAgICAgICAgcG1fcnVudGltZV9wdXQo
bHZkcy0+ZGV2KTsNCj4gICAgICAgICAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGx2ZHMtPnBjbGsp
Ow0KPiAgIH0NCj4gDQo+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBkcm1fYnJpZGdlX2Z1bmNzIG1j
aHBfbHZkc19icmlkZ2VfZnVuY3MgPSB7DQo+ICsgICAgICAgLmF0b21pY19jcmVhdGVfc3RhdGUg
PSBkcm1fYXRvbWljX2hlbHBlcl9icmlkZ2VfY3JlYXRlX3N0YXRlLA0KPiArICAgICAgIC5hdG9t
aWNfZGVzdHJveV9zdGF0ZSA9IGRybV9hdG9taWNfaGVscGVyX2JyaWRnZV9kZXN0cm95X3N0YXRl
LA0KPiArICAgICAgIC5hdG9taWNfZHVwbGljYXRlX3N0YXRlID0gZHJtX2F0b21pY19oZWxwZXJf
YnJpZGdlX2R1cGxpY2F0ZV9zdGF0ZSwNCj4gICAgICAgICAgLmF0dGFjaCA9IG1jaHBfbHZkc19h
dHRhY2gsDQo+ICAgICAgICAgIC5hdG9taWNfZW5hYmxlID0gbWNocF9sdmRzX2F0b21pY19lbmFi
bGUsDQo+ICAgICAgICAgIC5hdG9taWNfZGlzYWJsZSA9IG1jaHBfbHZkc19hdG9taWNfZGlzYWJs
ZSwNCj4gICB9Ow0KPiANCj4gDQo+IC0tDQo+IDIuNTQuMA0KPiANCg0KDQotLSANClRoYW5rcyBh
bmQgUmVnYXJkcywNCk1hbmlrYW5kYW4gTS4NCg==
