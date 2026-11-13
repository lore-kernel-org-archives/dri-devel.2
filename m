Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B68606A334
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 12:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6945910EC1C;
	Fri, 13 Nov 2026 12:00:36 +0000 (UTC)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11022116.outbound.protection.outlook.com [40.107.75.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B03410EC1C
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:00:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6SIjutsfH88SMuGnIWQlKLaaMaAVrtkL83AkKomP2tJ2D+cI3hDSA2FVMO81zNFl8hzUZRnHRLwHzel2kuyON2Oh2+L22D7g2uxFnxhMHxQrftmxceMalQu16EfForuxs302CxxPmOSfAN2vqIpm0In3zfr78UuErAGuRrsXcyifkzGUYYQskLFtY1kZcQt4bsidDbANxdAO5ZxC0g9BnlJgV/diIJPHyQenKoBjagZP8IxWQut36js7x4DQZnKRwO5qhsbwSz8xn1zlD2mskbRQRg+LgL7ObVj7Hq46MPhKjuo1F7dJmJ0FzZJFwmMrkrAawQfRIN37du/9Dq6cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WJLlOJHpjN4u9QF1saixxsNANl8T+HE4IKyJVrsLUs=;
 b=TSw6PpzClMWfNH3w4tRhGVhmMd5IUG8eSuXql0ylm1Ymc3c2FVvQicZGIfCT4bEw6d44aMTedNoBVlt3ssW6TGrihCVj3BsTWyUPR/r3v+30yKkFdf5x7MBpjTHSoj+FnsSOjf6xJ6KEkNJKLCfSqDBN2+fisSEGGEZb6p2+ZfQoB/EKpoeKItPZQ9G5+wLkVM9MBtXU/H/Osw0lAhJjmS8+uortvunbQBJkxOQcgwpgwkjTkFFtmWSEe7SrXdEXgxh01paOwuGc4THVLspcge3RRtq/P9Y1ICdbKMyvL2LW6CuF/KrVEcjiiR9V1/sBSHdTt7vOPwP4rCx+HSw1aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from JH0SPRMB0074.apcprd06.prod.outlook.com (2603:1096:990:63::5) by
 SG2PR06MB5429.apcprd06.prod.outlook.com (2603:1096:4:1b9::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0; Fri, 13 Nov 2026 11:55:31 +0000
Received: from JH0SPRMB0074.apcprd06.prod.outlook.com
 ([fe80::d5a:16db:d97c:df7a]) by JH0SPRMB0074.apcprd06.prod.outlook.com
 ([fe80::d5a:16db:d97c:df7a%5]) with mapi id 15.21.0592.009; Fri, 13 Nov 2026
 11:55:30 +0000
From: Luo Liu <Luo.Liu@cixtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, =?utf-8?B?V3V5aSBTaGVuICjmsojmrabkuYkp?=
 <wuyi.shen@cixtech.com>, cix-kernel-upstream
 <cix-kernel-upstream@cixtech.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggMi8yXSBkcm0vY2l4OiBhZGQgU2t5MSBEaXNwbGF5?=
 =?utf-8?Q?Port_transmitter_driver?=
Thread-Topic: [PATCH 2/2] drm/cix: add Sky1 DisplayPort transmitter driver
Thread-Index: AQHdcDVP3hEhEjt9xUafKupZnuuWULcr1ecAgAAShKA=
Date: Fri, 13 Nov 2026 11:55:30 +0000
Message-ID: <JH0SPRMB0074EF94AB07A11832EA512BF57F2@JH0SPRMB0074.apcprd06.prod.outlook.com>
References: <20261109103010.110911-1-Luo.Liu@cixtech.com>
 <20261109103010.110911-3-Luo.Liu@cixtech.com>
 <20261113-industrious-squid-of-tempering-e428b7@quoll>
In-Reply-To: <20261113-industrious-squid-of-tempering-e428b7@quoll>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0SPRMB0074:EE_|SG2PR06MB5429:EE_
x-ms-office365-filtering-correlation-id: a67aa9e2-c529-482f-b274-08df417d043b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|42112799006|261028144727099003|38070700021|10067099003|261026121527099003|4143699003|261022105027099003|261021121427099003|261026140227099003|261009223027099003|261102123227099003|56012099006|261022075727099003|18002099003|22082099003;
x-microsoft-antispam-message-info: EU8Fkxt1RBLsHV7m0RuZt5aD/ZZYx56eFN3RyMQAW9B7oQpokMELtE7bhW++TzOCfkcSdZtwf7vIllNWAw8/fPWfhmPv2HiFcf7jgqL4QK90X6s0lkgLTTS/KXv0oPV+WaSoXSjDRDNp31kk+JOn1Tr8VZzlJwF2lpjaQzEIg5sT3gIxgtbzjhI2qgq9X+p7zuiro1AGZi5KClUd4GzUZIjwXlgmlYpcBiYteVjOpKoyJ5JbEoVy+ODgRUR/J6kwdNSKpyTezP6gvPeY06t7gfVHt3R5y14dMYtzfKb1/aUaaJODByKfiQ77YP89hDl2Csh/UQIp1n6iuBqM6nZ/bzE9ydCFO8rRQpIcIPRiQrv0M180qkuwkkyOyksutth3fFNLlhZg08rUWX8fsK6ev+n427T/QaB2WbMkBvdDc71qXmCXhTt0U9/tYtDwD8HUDoLIcyjoMKJWjfvL0b9VUOntN9RetPpdOAdQZLM94GnVn72bSmL2+RIBjYUfuwlexZ3x3cLChLZE4zz0Ch2jl5TH9Dwsdk6XAJdGXNLYmxvf9qYcA2fP4rQB32ravuWJtYEy1s2VGwbF8qgtLqZcmTRofhcJFlQ6dSty6KSjjppIz9Mf1mMaxjMNJl3axdeWgvkHIEdHlMoF2WnZtVVIuL88dBc61P44OLyH4fr27Uu/YrqT6+thzx6edwZ5DW2mgAFR/hzQRd0VcSbrF3NYYUSj0zJrTcbc6xH8CJiZNa0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:JH0SPRMB0074.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(42112799006)(261028144727099003)(38070700021)(10067099003)(261026121527099003)(4143699003)(261022105027099003)(261021121427099003)(261026140227099003)(261009223027099003)(261102123227099003)(56012099006)(261022075727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVlldUJSM0h3Vy81Ymh0UEhSVjFEdi9sYVhqSjVZaWlQVlMvTzBiV3UzSTY3?=
 =?utf-8?B?WWMxN3Nzc2syeDdoU3lPdzdYQmZqTzRKbjN1RWt6VG5qTmJhdGM3SUFLV2dD?=
 =?utf-8?B?dVFTeTJMN09oYWp6K2FOKyt1NG54TlI0OW1mVktMOFJJc21SNHdyZVdicjNp?=
 =?utf-8?B?NE4rV2hRMXhIeTUzcEhac3l3NmYwTTNiUjl3ek1qclVwd1dzbHZzeWM1NkV5?=
 =?utf-8?B?RlVVTDVIdlBkOWZSWmlpQUQ4L0xYei9SVEs3TVlMQlltQmxKZkZxRjJwMzFX?=
 =?utf-8?B?TjNPVmtMd2pGOTVWVjUvVjlmZ0FHRG9sQkZjaUdzUHBHeGlRVDNEbmNMZ2Yr?=
 =?utf-8?B?Q210U2I3clM3Y0JGc1ZJTDYzMUpSYUNaUDNhZGpyQW9VWkhWZVM5bnYzUU12?=
 =?utf-8?B?TWtkYlFEaUtHNDZRdFpFYWd1Tk9sSWpmYTExTnVzZnU4MmhpRWM4ZUlXWFBv?=
 =?utf-8?B?eHFPWjMzNkxVNUVZSGpaREZGMnZPTmxRYVFobjdwK0UrdXlGQmJaejkvRGdX?=
 =?utf-8?B?UWgzekNOZWtTTWk2bHh4c2hKSTc0V0tKNXpjVkd4MFp3d2lFT3ZBS3VIcWE1?=
 =?utf-8?B?RFlkWjFFZU1xZzZNaGJZUmRxTk5STnVTQjdUU0hBdWZJV0RiQzVVT2NDcEpo?=
 =?utf-8?B?UXhGUitQYkl3VkxyTGJONk1ObFY4V1R2NmVNL1A3WVBST3hHNTR6OTVnVDFn?=
 =?utf-8?B?b1AzWlRCbXhkM3Y3dU0wbEpJRmlINkJMSFhhT09NMi9DWmp2b3JPQnV5Qzll?=
 =?utf-8?B?T3hyRDdXemVzUWtGck9MblR1US9Td3htT0t3dzU2Uy9ORjFyL0hlRHNWSnZu?=
 =?utf-8?B?bU91STVBMVRTQWdIS3dYb2I5R3F2eUxsUjdkcDd0dXBqajZTaGN3SDN5NU12?=
 =?utf-8?B?UlNqbE5iV2piQTJGRFRkNHBiYklBSmZ6RVZ5NnkxM1kyMDJCQ1R1T2VHVHV5?=
 =?utf-8?B?RUxhVk1HU3NhZ0JEYjliR2dnTHdpOTRFYS9PcnA3b1E1UFQzVGhSbEJlU3Rl?=
 =?utf-8?B?b0tFZHBtM0pjSWhyV3JsWUR1Z2p5cVpZUThqc2MycHg2TnplV0V5a2pURHdW?=
 =?utf-8?B?TVdMb0xOT1Q0VUtzWWx2QUlQeUFRZzZtMmp4TUZtNGZub2ZHZStoSk1VMlk3?=
 =?utf-8?B?eWVMVlNjNlo2akdKVnVHeUFMZ2o3eXR4N1ZML0xsOWM4VTNhbUU3UWFWTG5I?=
 =?utf-8?B?WE04czhJMWc1ZHhwQ1l6a1JpTExvZW5sUTlWMEErTTFoZFNmR2RwT2gvWW1o?=
 =?utf-8?B?bURSNWRGOFhncjF6SHlDUUNON2s5VHBxdGo0WE1URXNkMkF5UmI1bmtHMjI5?=
 =?utf-8?B?Qy8xSUxicEcxdWM4R0lmdHF6Q1FwT2Q0V1dOQ05xL05WY3NFMkgxMVpJaS9C?=
 =?utf-8?B?WXUrYnYzK2pzZXhKYStEdWhGRGE2QVlKZEh1VTZCaWUrdnE3QUdvVFpPRFhp?=
 =?utf-8?B?dEMzZHo2ejRyZ2dYelpZWU4wK05XSExsUkVtLzluTE8rNXV6K014ZEFDWWRk?=
 =?utf-8?B?cjNSeWpUaWh5ZTdjbCtVMzd5VUFwSkFvK21GVnk3ZWtLS1M2Tm10M3BINE5l?=
 =?utf-8?B?bGJBL3F0WU95VndiVTQ5czF2QVBLMitkVEdtSlNiU0pNM1VZVktsK09aR3pa?=
 =?utf-8?B?b0haVXZuYy9rWFNZTmtjRzFLb3JvM1FNUmI4WCsyT3NDaXVDTjZ4YWwxZ3E0?=
 =?utf-8?B?cHowYkRnNXpoK0YrbnA5YzU0S05ueXNKNHdzZDB2ZlN2N2ZqTEJmampmejZG?=
 =?utf-8?B?K3ZPVUx2bVAvd2Y0UEVBZUdXT1A2MlZ6NTluREp0anJzdDJjdkI1WG5QMi9o?=
 =?utf-8?B?WERiOUdKV25DbUI3WTgwb2ZuWEdkQStWdlRDTUZJVHllNzNoS2FKeDg5UjZG?=
 =?utf-8?B?QzhETExjVGdUaHFwQVJWRjVzSklPOTlvbk9rMVlvdUNjMjlPaTNSQzkyR2JN?=
 =?utf-8?B?RUZobEh2OXVmTjNLanBWeDlhYkhUVUNBamZPaEpNMEVDSmQ0dHJXMkxyYlBL?=
 =?utf-8?B?Z2lzZU95dm8yTG9KL1ZFbUJJaEVLZHkrR3IvWmFJMmZka1FFbnh3OTZ6eHY3?=
 =?utf-8?B?Rmw2eVhTQVMwWXVLVkovNjl5REhTTkVYT29DOFMyNkRrYUU2Y3ozUXNBSkZG?=
 =?utf-8?B?eWl0a3dtL1V1cTFqMTJNS3JvL0NhT2h2NEZwbWhTK2ZQOWNtNHRFSkJ1TW9L?=
 =?utf-8?B?eUhqZi9kclpwcklWcUpsc2hoTWltVVFWYWcxdSs2cEhZZk1wUkJMUFdrMGxC?=
 =?utf-8?B?TGFzclBmYjFMSFUwZHRjdzF6UU1ZbVZ0QlVab2U5MlpOWlNwWWpWWFAzaHNM?=
 =?utf-8?Q?k4ZPATWW5ybksPtrYt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0SPRMB0074.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a67aa9e2-c529-482f-b274-08df417d043b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 11:55:30.6620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: suEWD82hlSagCm/ZwVQAd1j3xUk2vddoOtQDSKA2KT8q0QClZxFe/sLyE1w/lB5hIgkE8QI9NMUf3/KcGJGlrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5429
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEtyenlzenRvZiBLb3ps
b3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI25bm0MTHmnIgxM+aX
pSAxODozOQ0KPiDmlLbku7bkuro6IEx1byBMaXUgPEx1by5MaXVAY2l4dGVjaC5jb20+DQo+IOaK
hOmAgTogbWFhcnRlbi5sYW5raG9yc3RAbGludXguaW50ZWwuY29tOyBtcmlwYXJkQGtlcm5lbC5v
cmc7DQo+IHR6aW1tZXJtYW5uQHN1c2UuZGU7IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJu
ZWwub3JnOw0KPiBjb25vcitkdEBrZXJuZWwub3JnOyBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgV3V5aSBTaGVuICjmsojmrabk
uYkpIDx3dXlpLnNoZW5AY2l4dGVjaC5jb20+Ow0KPiBjaXgta2VybmVsLXVwc3RyZWFtIDxjaXgt
a2VybmVsLXVwc3RyZWFtQGNpeHRlY2guY29tPg0KPiDkuLvpopg6IFJlOiBbUEFUQ0ggMi8yXSBk
cm0vY2l4OiBhZGQgU2t5MSBEaXNwbGF5UG9ydCB0cmFuc21pdHRlciBkcml2ZXINCj4NCj4gRVhU
RVJOQUwgRU1BSUwNCj4NCj4gT24gTW9uLCBOb3YgMDksIDIwMjYgYXQgMDY6MzA6MTBQTSArMDgw
MCwgTHVvIExpdSB3cm90ZToNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2NpeC9k
cHR4L0tjb25maWcNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9jaXgvZHB0eC9LY29uZmlnDQo+ID4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjBiMDk5ZjdkMmVk
NQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vY2l4L2RwdHgv
S2NvbmZpZw0KPiA+IEBAIC0wLDAgKzEsMTYgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMC1vbmx5DQo+ID4gKw0KPiA+ICtjb25maWcgRFJNX0NJWF9EUA0KPiA+ICsg
ICAgIHRyaXN0YXRlICJDaXggRGlzcGxheVBvcnQgQ29udHJvbGxlciBEcml2ZXIiDQo+DQo+IE1p
c3NpbmcgQVJDSCBkZXBlbmRlbmN5LCBsb29rIGF0IG90aGVyIGV4YW1wbGVzLg0KDQpJIHdpbGwg
YWRkIGRlcGVuZHMgb24gQVJDSF9DSVggfHwgQ09NUElMRV9URVNUIGF0IG5leHQgdmVyc2lvbg0K
DQo+DQo+ID4gKyAgICAgZGVwZW5kcyBvbiBDT01NT05fQ0xLICYmIERSTSAmJiBPRg0KPiA+ICsg
ICAgIGRlcGVuZHMgb24gR0VORVJJQ19QSFkNCj4gPiArICAgICBzZWxlY3QgRFJNX0tNU19IRUxQ
RVINCj4gPiArICAgICBzZWxlY3QgRFJNX0RJU1BMQVlfSEVMUEVSDQo+ID4gKyAgICAgc2VsZWN0
IERSTV9ESVNQTEFZX0RQX0hFTFBFUg0KPiA+ICsgICAgIGhlbHANCj4gPiArICAgICAgIERSTS9L
TVMgZHJpdmVyIGZvciB0aGUgQ2l4IERpc3BsYXlQb3J0IGNvbnRyb2xsZXIuIEl0IGltcGxlbWVu
dHMNCj4gPiArICAgICAgIHRoZSBzdGFuZGFyZCBEUk0gYnJpZGdlIGludGVyZmFjZSBhbmQgZHJp
dmVzIGFuIGV4dGVybmFsDQo+ID4gKyAgICAgICBEaXNwbGF5UG9ydCBQSFkgdGhyb3VnaCB0aGUg
Z2VuZXJpYyBQSFkgZnJhbWV3b3JrLg0KPiA+ICsNCj4gPiArICAgICAgIFRvIGNvbXBpbGUgdGhp
cyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmU6IHRoZSBtb2R1bGUgd2lsbA0KPiA+
ICsgICAgICAgYmUgY2FsbGVkIGNpeC1kcHR4Lg0KPg0KPiAuLi4NCj4NCj4gPiArc3RhdGljIHN0
cnVjdCBwbGF0Zm9ybV9kcml2ZXIgY2l4X2RwX2RyaXZlciA9IHsNCj4gPiArICAgICAucHJvYmUg
ID0gY2l4X2RwdHhfcHJvYmUsDQo+ID4gKyAgICAgLnJlbW92ZSA9IGNpeF9kcHR4X3JlbW92ZSwN
Cj4gPiArICAgICAuc2h1dGRvd24gPSBjaXhfZHB0eF9zaHV0ZG93biwNCj4gPiArICAgICAuZHJp
dmVyID0gew0KPiA+ICsgICAgICAgICAgICAgLm5hbWUgPSAiY2l4LWRwdHgiLA0KPiA+ICsgICAg
ICAgICAgICAgLm9mX21hdGNoX3RhYmxlID0gY2l4X2RwdHhfZHRfaWRzLA0KPiA+ICsgICAgICAg
ICAgICAgLnBtID0gcG1fc2xlZXBfcHRyKCZjaXhfZHB0eF9wbV9vcHMpLA0KPiA+ICsgICAgIH0s
DQo+ID4gK307DQo+ID4gKw0KPiA+ICttb2R1bGVfcGxhdGZvcm1fZHJpdmVyKGNpeF9kcF9kcml2
ZXIpOw0KPiA+ICsNCj4gPiArTU9EVUxFX0FVVEhPUigiTHVvIExpdSA8THVvLkxpdUBjaXh0ZWNo
LmNvbT4iKTsNCj4gTU9EVUxFX0FVVEhPUigiV3V5aQ0KPiA+ICtTaGVuIDx3dXlpLnNoZW5AY2l4
dGVjaC5jb20+Iik7IE1PRFVMRV9ERVNDUklQVElPTigiQ2l4IERpc3BsYXlQb3J0DQo+ID4gK0Nv
bnRyb2xsZXIgRHJpdmVyIik7IE1PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCj4gPiArTU9EVUxFX0FM
SUFTKCJwbGF0Zm9ybTpjaXgtZHB0eCIpOw0KPg0KPiBEcm9wIGFsaWFzLCBpdCdzIG5vdCBhIHN1
YnN0aXR1dGUgZm9yIGluY29tcGxldGUgSUQgdGFibGVzLg0KDQpPSyAsIEkgd2lsbCByZW1vdmUg
aXQgYXQgbmV4dCB2ZXJzaW9uDQoNClRoYW5rIHlvdSB2ZXJ5IG11Y2ggYWdhaW4NCg0KQmVzdCBy
ZWdhcmRzLA0KDQpMdW8NCg0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQoNCg0K
5pys6YKu5Lu25Y+K5YW26ZmE5Lu25YyF5ZCrQ0lY5YWs5Y+455qE5L+d5a+G5L+h5oGv77yM5Y+X
5rOV5b6L5L+d5oqk77yM5LuF5L6b5pys6YKu5Lu25oyH5a6a55qE5pS25Lu25Lq65p+l6ZiF44CC
5Lil56aB5Lu75L2V5pyq57uP5o6I5p2D55qE5L2/55So44CB5Lyg5pKt44CB5YiG5Y+R5oiW5aSN
5Yi25pys6YKu5Lu25Y+K5YW25Lu75L2V5YaF5a6544CC5q2k6ZmQ5Yi26YCC55So5LqO5oyH5a6a
5pS25Lu25Lq65Lul5aSW55qE5omA5pyJ5Lq65ZGY77yM5YyF5ous5pyq57uP5piO56Gu5o6I5p2D
5aSE55CG5q2k57G75L+h5oGv55qEQ0lY5YWs5Y+45ZGY5bel5oiW5Luj55CG5Lq644CC6Iul5oKo
6K+v5pS25pys6YKu5Lu277yM6K+356uL5Y2z6YCa55+l5Y+R5Lu25Lq677yM5bm25rC45LmF5Yig
6Zmk6YKu5Lu25Y+K5omA5pyJ6ZmE5Lu244CC5LqS6IGU572R5Lyg6L6T5peg5rOV5L+d6K+B5Y+K
5pe25oCn44CB5a6J5YWo5oCn44CB5a6M5pW05oCn5ZKM5peg55eF5q+S5oCn77yMQ0lY5YWs5Y+4
5a+55Lu75L2V5Lyg6L6T6ZSZ6K+v5oiW6YGX5ryP5qaC5LiN5om/5ouF6LSj5Lu744CCDQo=
