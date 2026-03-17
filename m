Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5133AFB5EA4
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 02:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DED310E564;
	Tue, 17 Mar 2026 02:44:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Y6oHv8sO";
	dkim-atps=neutral
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023117.outbound.protection.outlook.com [52.101.127.117])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E933C10E337
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 02:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bi9iDog+VmpVV52VatpLHxIvNnaeoJMvSH6HKSb5Y+OLkbIiT7l2QHEVEnbLmZPcrFySOpcrG5nVf6KYS/hkiSotyrWxoUjNPngL7P1nsX9JVC0xLt62f6b+OkZ/DJ9Ma++aTq4tX7ZHU1sPKoUEYFci5sBo7oztcldE3ct+OOQ29L294U7UqQMB81EeUhJdbJ/OaD3w9NuLE+2dZKUKeUrwUnbK8URiJhMUUkdtYQ39Ko29/2iluq07fmyzfkaaAondjqtdD2vlrZRpXOH2gaJCAlV4X6wb0IoAOtcHb1DypixkSYDglvz1IW1qAwh+lrY1sVxNowGhSZ9MnKXGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ax9TNyf/l0kJQ3yPjcs+arqzrWlzQItmRbWzEsF13Dc=;
 b=O3R1yQI0Y4QFXpTVs1EcqVy88T7NuLz7ZLQOWnR6wSKySMR+r4icZpfCqQwmp9NWBog8g8LL1cAryW6yUYEMP9ltLPiGk9f0NDc51f0hsgD9cpdw1C/e1H+2uq/6gViXDowyUMYSeAQF1cdnoCcqLsbwP4/oBxhM9+jQAl54d3O3YRuIqKUqpzrcJu4rd4mJKPj1KNI8LtrY7dDAlNw2jK5+u0Lbv9LyL6bK9/ykYtjNFgqq4GQkKzG2BqpUA3Ij09Q5mvGvSUx8hwcT6ywjDbE0jrnLRsya4KKq25tTCdjEkUlDgaSZcPTZR9IjVs/J8SfRXrc7LGekGV4fLK/OxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ax9TNyf/l0kJQ3yPjcs+arqzrWlzQItmRbWzEsF13Dc=;
 b=Y6oHv8sOGSg2SvnAKh2jVgTvXaqaLkAhRY3FFyHjujYAOLxfKFLfHkjEVN+gBkPsSM9UfRY48hWVbHb7Q/AMHXF1ZPT5Y+BWehf9eeiChbCc5zhxqjgE4YVjPA4GHiAMyiTRF1EAilADQXxv/IIl1EbEvGL+Y7+A19B0XWuIj59gI/X7rTjH9u+VmvrPq5Y75/wPyti1yNmXzcNCLDKohBR/plLSA2HwylcbiQIrj1IT9uoEWdKjLY4YoBu/HwGvUtxygp6czof+cnWaQ368/iKCIlnlApFVskUI7YOh8NZDnR3tmTISwgyI+8lyakUntkl6X57fLEY2e1qG8VA7nw==
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com (2603:1096:400:45f::6)
 by SI6PR06MB7168.apcprd06.prod.outlook.com (2603:1096:4:250::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 02:44:10 +0000
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::b803:eff4:ebd4:9393]) by TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::b803:eff4:ebd4:9393%4]) with mapi id 15.20.9700.021; Tue, 17 Mar 2026
 02:44:10 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Jani Nikula
 <jani.nikula@linux.intel.com>, Dave Airlie <airlied@redhat.com>, Jocelyn
 Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm/ast: DisplayPort edid supports 256 bytes
Thread-Topic: [PATCH] drm/ast: DisplayPort edid supports 256 bytes
Thread-Index: AQHcstDXF8FmAY83zE6GJfzElLYkP7Ww8tKAgAAaVQCAAAf1gIAA7nQg
Date: Tue, 17 Mar 2026 02:44:10 +0000
Message-ID: <TYZPR06MB65687DEA759C0FC58ED8C118F141A@TYZPR06MB6568.apcprd06.prod.outlook.com>
References: <20260313-upstream_ast_dp_edid-v1-1-2a75b7c091b2@aspeedtech.com>
 <b0b1f644-ea5c-4636-99a0-28b040ed2fe0@suse.de>
 <ad40e82fc2e6501f1b6e1073c70a6f1c308c89a8@intel.com>
 <ee764699-d2d7-4da6-bf54-db3bd5d12a85@suse.de>
In-Reply-To: <ee764699-d2d7-4da6-bf54-db3bd5d12a85@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6568:EE_|SI6PR06MB7168:EE_
x-ms-office365-filtering-correlation-id: c21eb840-6cb1-4adc-4a4e-08de83cf111f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: e1oo4laK8hYOBrnRse7rpQDV2pMRufL0p2cdar5L7ve3W1EBEZ73VhO7nXPqAgWFD9qgCKjg5sCtBriULAVCTBSKnon8eCiNdhnWVgU46h7RnyuyZZiGdlxl+DW5zeYcS0tfrRhtq+UvH4JXIJybp5ArnR4SqsaVkaTicyiqyfg3leAmL7c8svgJWq9SjpJ0VI3dsOZlT9cvmJpRl/UgO1P4JJOD7ipxVCKhG1uYEK7Vf5Tahj4fERISUVRtXJPO5TySeihU2tsT+uwUnigc9IxWZB25Iuw8pSWWe/kLKETqo0No2JYztmTLxsZ+OmmmeGatJ6P+HI7OgfLS/PHf4sqKyxaei3IaYTsSwZbeS07BBUzILaiMbbkr8C+Nwxo6TV/CTOYGx7heN9Oo6yWxXAwPLOW5FgmtDXK3hq80l8Jnu/AztT7JNUGAaloldyUiMI1gZKs3qafarg00zT5oiF23wunOfzIsamiJ9jDXEb3Zz8tCGWu+jVFTKe439D21EO7zhad53hdgcGRZC69KQdRFqKDM6LMofSJEL9v3ClLa8yV7jVJjxRaKBRYHf5kR5ZoVviXYUK3/TGim8blVOMROdkz3szTfBW8PVG9VXz7cBB3k72N0KidHTWeMOavVm6XlK90T5qacCYPgmv3IIznTanNTHYn6RDd7XjcvYnua4f8Bk1F3ztjBBU6yYUV6lzzI10MC0GDrElz1qehhz2nHB6UABt5m7Sz0/BVllco=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB6568.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0tXbmZBdld5QUptV2xFcnJqK0ptMWtYRmdkenZoYWh1SkwxdXdjbVFDUm5Q?=
 =?utf-8?B?bjU3bjN3ekd5R2U5SWtnQ3lPbDNmak54N2ZPSGdtci9oT3ZZb2tmdHF0ZjVQ?=
 =?utf-8?B?NnQ1dzI4Q1pMUjBnMFdLZWM5WWsvQXJ1RlpOVkRyK1loRTkzaVhleUhtMVJO?=
 =?utf-8?B?Wi9EKzIyL1VvdldGbTBYdUdaNE9KWUgwZmhya05iTUl5VG9yWndDbTdYbC96?=
 =?utf-8?B?TDc3OW9Yb0lLNldQdDNhRGd2MHc0VHp3MUt1OVdRZmxKVUdKUW54U21sdkh6?=
 =?utf-8?B?MzlCV0FqWEUxTHgxSkVVRDhabnYxcnJEVVdGdXo1Z2EvTy9wVUFWamdhWGJV?=
 =?utf-8?B?MVhOYzFGVndXRHdBN3RrdFFwVXpLdUJVdFRPRUpCR3hPaW93YjBreXI2WjBR?=
 =?utf-8?B?TEJuL0dkZ2VsTGNaUUs3KzZ4V3QvOWsrSUpzMDk3QWhCMTdTVmp3Rkc4cThQ?=
 =?utf-8?B?aFMwelpyMzF1bFRQYkx1SUg5bys0TjU5Zm9CN1FKZTN4QWZ0QlIrMzJTdzdk?=
 =?utf-8?B?dmRkNUdEeENMSXVYemV6RGRzekxvaDhYQ3pkODlxQzN1VExwR3NiSkl1SDJa?=
 =?utf-8?B?bUkwelpDSE8wNXRTaW5sYXd3UkIySFJmT3NUUFB2Z0tLeWhWZEJJcHpPU21T?=
 =?utf-8?B?RStFNzNURnBDSmZmZ0lRenU0TzdpcXdvM0hERkZpUDdBRmFEZi82ZFBESlVj?=
 =?utf-8?B?ZWpPR2RoOTN0ZTdqMGVjTDJwRHB4cGVLR2N1RHFJNXhVVWxSS0p6YlB2Z20v?=
 =?utf-8?B?ZWo1YWl4UWlhcDBZb0pFRmlIMUFUUGJWNlBHN3Q2c1krVVc0V0pnQVlMUjF5?=
 =?utf-8?B?clJNWks3SjVJY0Z2ZmcwZXNDRG4wQVhrbnB0T0IyaFJGdEcrSnV3ckV3MXMr?=
 =?utf-8?B?N3hqNUxXS2hjckk2VXlkRk5SZlgxTzh6MFhqZzVHMGtxa3l6M0hVNmZuZVhJ?=
 =?utf-8?B?N2JuVU0zQVZ5UElqWmFySFFJQmRsRVBvK2g3a25CYnR4Q293azlJUVQrYUd6?=
 =?utf-8?B?Y1lwV1RyNnk4R0E3SjNjVEJaQ3dFdmFGeVByZVhsUjNqbGJyYi9wdzkzRWpw?=
 =?utf-8?B?aWltSHlPVGN1SWNxU3g0OElvZyswaXNlUExjdkc4MG5OZHlzRmxpcWljeVM2?=
 =?utf-8?B?SGF0b280SWdaOStGQTNqbU10RVJLSEMyblRuSE16TVZPVFFqT080Mm1aZDl1?=
 =?utf-8?B?cy9QOWxHZ3p6UFV5dnVYTkJ4cS84Mzd3UDFPdFlyTUpMK3g1NWEzeWt2TVQx?=
 =?utf-8?B?QWliM0xhcnRYTHNUS3lSSTBDMmhIN3RnTnZWZkU5TUdrLzIyRlVnZSt0aFc0?=
 =?utf-8?B?QjhTcG9MZ2hBR1Z4Z3ZLM0V3QjkwMWwrdzU2WWlodlNvNnl0cFhKWHB2TG5Y?=
 =?utf-8?B?VC80UzdLU3VQY29ZbkxtN1Y3L1NIRjlvMkpmNFBqREx4TEd3aFRIcnp3V0Fu?=
 =?utf-8?B?NVMwM2s1aVNkMkp4dElWVUNNdEIzVFpvZmUxR2FMaXRycGZRTi9yei8wSmlj?=
 =?utf-8?B?SG0rNXhKZWtPYzM4b0ZnV2ZzMlhhQU1DZ3FyZTBqNzIxNzh4WWpYY2NJK21s?=
 =?utf-8?B?NGl6ekFvbDZCVm9LN09sZVR0RlJLWktVZkwwb3hzV1c4SVFnTWF3bXdrVk03?=
 =?utf-8?B?OEZVYTh5SUloUStiNllYWElBOHRNNkt4TXUvbVV5YnVFU3lJZHlnWjVBVWVQ?=
 =?utf-8?B?Qkt0c0xnKzlTVGZZckdCL0NkcjNoaDVNSFV4azR1aE9NeU5qbjEyeFNWelNm?=
 =?utf-8?B?Y2t5ZjZCUnpuSkpISE5tcW1wV0lFRm96ZXVSWmE1VlZZYVIrTEdCZVFQNmlR?=
 =?utf-8?B?VHp0a0JkMG9yZ2FzeUhsUXdZMW1kNEJ0ZDFudk5CckJqUUxYak42N1BPenBh?=
 =?utf-8?B?TEhVMmNXMHcxTGY2V21OOUgwWVBkS1oyOUhaWk5sc2xqV0JoZGlNcHpYQlNM?=
 =?utf-8?B?MUg4YlhGMHl3Z0hUWGlPc0hSM0tGZGhiNWVWRHFtd1BFeStjRGFJWFZ1Rjl2?=
 =?utf-8?B?eHB4TXk1SjFyZnIvZEhqbkt5TnZrSnByMFF5ZVBZVUUzRWc2M3JldGNMOWw1?=
 =?utf-8?B?SWNMcXcyZDN6ZnNTalJUaDFYNEcva1loemZEN0hkR0hyZ0RwVVYwek1BZzBk?=
 =?utf-8?B?bzBnL3RpU21BdmlqT2M0dFFiYkp0NmRKZ0tkMjhrOGJwU0FZQ1R1cVJpNHly?=
 =?utf-8?B?V0MyNnIyZ0N1UGx5L1dBaWk0TjVuN1RnNjZaSUI2WnAwYWxUa2NSMGxZd0VL?=
 =?utf-8?B?RVAybUlnbWtETmJ3UzVYOEtuYjNXN1NBWEszUHowdllKQ0U0dmYvd1Urd0tr?=
 =?utf-8?B?Zm1EZ1duYW9WNkx4TkRNSkh1SCtNZnlwODdlRGt0ZkJUTWw3dHhRdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MhRHl8K+ewgyif7FjAmyKm3AVjoDyOwHmvjAneudIWlhm3ccQHFTeaXmVmrQKe1MQ+HVRRjHCungiGWKdTQ7e9ggpfHT6MLyK2mwmD6O3/EpPa648blP2mS5d3S2JGy9vLgeL3saB7s8qA/qvMuj+EYFyun1v60BGt5JpS60NDHhpaN7ljC/47KCDaf+PCMgXBEBUA7q1ckaDR5QOc3R3f48v+TtYmknNEKZexIWJrKNiTy8LZxqKQAVVVLuStzBqYqn0kXE65L/wmb2t0ajcwkZqP76LnB90BuDl5H2d0JK99TXGChFLbz8QIWPoPTBFHogRa4V0/zAUAKShAd8qw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6568.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21eb840-6cb1-4adc-4a4e-08de83cf111f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 02:44:10.1672 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rSgr1UaH2GEqNngfUtRnG/Dwl5nCJGVVsm1Z6hs6UnsdWc8Fzn2E7UnEt7GZSlFBcwTh7pm0JEAUOoCcWEbWZdIxRLjpa/56M8QxSyJ9Mq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7168
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

SGkgVGhvbWFzLA0KDQpUaGFua3MgZm9yIHRoZSBjb21tZW50cy4gSSBmb3VuZCB0aGUgY29kZSBh
dCBbMV0gaXMgbm93IG5vdCB3b3JraW5nLg0KQmVjYXVzZSBpKz00IGluIHRoZSBsb29wIGl0ZXJh
dGlvbi4gDQoNCkZvciB0aGUgYmxvY2sgbWFwLCB3ZSBzaG91bGQgaGFuZGxlIGl0IGRlcGVuZGlu
ZyBvbiB0aGUgbnVtYmVyIG9mIGJsb2NrczoNCjEuIDAgb3IgMSwgbm8gZWRpZCBtb2RpZmljYXRp
b24gcmVxdWlyZWQuDQoyLiA+PSAyLCBjaGVjayBibG9jazEgb2Zmc2V0IDB4MDAgdG8gc2VlIGlm
IGl0IGlzIDB4RjAgd2hpY2ggbWVhbnMgYmxvY2sgbWFwLg0KIFNldCBudW1iZXIgb2YgZXh0ZW5z
aW9ucyB0byAwIGlmIGJsb2NrMSBpcyBibG9jayBtYXA7IE90aGVyd2lzZSwgc2V0IG51bWJlcg0K
IG9mIGV4dGVuc2lvbnMgdG8gMS4NCg0KQlINCkphbW15DQoNCj4gDQo+IEhpDQo+IA0KPiBBbSAx
Ni4wMy4yNiB1bSAxMjozOCBzY2hyaWViIEphbmkgTmlrdWxhOg0KPiA+IE9uIE1vbiwgMTYgTWFy
IDIwMjYsIFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPg0KPiB3cm90ZToN
Cj4gPj4gSGkgSmFtbXkNCj4gPj4NCj4gPj4gQW0gMTMuMDMuMjYgdW0gMTE6MDQgc2NocmllYiBK
YW1teSBIdWFuZzoNCj4gPj4+IERpc3BsYXlQb3J0IHN1cHBvcnRzIGVkaWQgYXQgbW9zdCAyNTYg
Ynl0ZXMuIFRodXMsIGFsbG93IGl0IHRvIGZldGNoDQo+ID4+PiBlZGlkIGJsb2NrIDAgYW5kIDEu
DQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogSmFtbXkgSHVhbmcgPGphbW15X2h1YW5nQGFz
cGVlZHRlY2guY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiBBU1BFRUQgRGlzcGxheVBvcnQncyBFRElE
IHNpemUgY2FuIGJlIDI1NiBieXRlcyBhdCBtb3N0LiBUaHVzLCBFRElEDQo+ID4+PiBibG9ja3Mg
ZmV0Y2hlZCBjYW4gYmUgMCBhbmQgMS4NCj4gPj4+IC0tLQ0KPiA+Pj4gICAgZHJpdmVycy9ncHUv
ZHJtL2FzdC9hc3RfZHAuYyB8IDIgKy0NCj4gPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYXN0L2FzdF9kcC5jDQo+ID4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hc3QvYXN0X2Rw
LmMgaW5kZXggOWQwN2RhZDM1OGMuLmM5MzhlMWQ2YjFkIDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FzdC9hc3RfZHAuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Fz
dC9hc3RfZHAuYw0KPiA+Pj4gQEAgLTg4LDcgKzg4LDcgQEAgc3RhdGljIGludCBhc3RfYXN0ZHBf
cmVhZF9lZGlkX2Jsb2NrKHZvaWQgKmRhdGEsIHU4DQo+ICpidWYsIHVuc2lnbmVkIGludCBibG9j
aywgc2kNCj4gPj4+ICAgIAlpbnQgcmV0ID0gMDsNCj4gPj4+ICAgIAl1bnNpZ25lZCBpbnQgaTsN
Cj4gPj4+DQo+ID4+PiAtCWlmIChibG9jayA+IDApDQo+ID4+PiArCWlmIChibG9jayA+IDEpDQo+
ID4+PiAgICAJCXJldHVybiAtRUlPOyAvKiBleHRlbnNpb24gaGVhZGVycyBub3Qgc3VwcG9ydGVk
ICovDQo+ID4+IEJ1dCBzZWUgdGhlIGNvZGUgYXQgWzFdLiBJdCBjbGVhcnMgdGhlIG51bWJlciBv
ZiBleHRlbnNpb25zIHRvIHplcm8NCj4gPj4gYW5kIHVwZGF0ZXMgdGhlIGNoZWNrc3VtIGFjY29y
ZGluZ2x5LiBUaGlzIGlzIHJlcXVpcmVkIHRvIG1ha2UgdGhlDQo+ID4+IHNob3J0ZW5lZCBFRElE
IHdvcmsgd2l0aCBEUk0uIElmIHlvdSBsZWF2ZSB0aGlzIGFzLWlzLCBpdCB3aWxsIHN0aWxsDQo+
ID4+IGNsZWFyIHN1cHBvcnQgZm9yIGFueSBleHRlbnNpb24gaW4gYmxvY2sgMS4NCj4gPj4NCj4g
Pj4gU2VlIHRoZSB0YWJsZSAyLjQgaW4gdGhlIFZFU0EgRURJRCAxLjQgc3RhbmRhcmQgZm9yIHRo
ZSBzZW1hbnRpY3MuDQo+ID4+IEZvciAxLjMsIGlmIHRoZSBudW1iZXIgb2YgYmxvY2tzIGlzID4y
LCB0aGUgZmlyc3QgZXh0ZW5zaW9ucyBpcyBhDQo+ID4+ICdibG9jayBtYXAgb2YgdGhlIGV4dGVu
c2lvbnMnLiBUaGlzIGlzIHVzZWxlc3MsIGFzIGl0J3Mgbm90IGEgZGF0YQ0KPiA+PiBleHRlbnNp
b24gaW4gaXRzZWxmLsKgIEluIDEuNCwgdGhlIGJsb2NrIG1hcCBpcyBvcHRpb25hbC4gVGhhdCBj
b2RlDQo+ID4+IHNob3VsZCBjbGVhciB0aGUgRURJRCdzIG51bWJlciBvZiBleHRlbnNpb25zIHRv
IDAgb3IgMSwgZGVwZW5kaW5nIG9uDQo+ID4+IHdoZXRoZXIgdGhlcmUgaXMgYSBibG9jayBtYXAg
dG8gYmUgZXhwZWN0ZWQuDQo+ID4gSSB0aGluayBsb25nLXRlcm0gdGhlIGdvYWwgc2hvdWxkIGJl
IGZvciB0aGUga2VybmVsIHRvIG5vdCBtb2RpZnkgdGhlDQo+ID4gRURJRCwgYXQgYWxsLg0KPiAN
Cj4gV2Ugb25seSBmaXggdXAgdGhlIGNoZWNrc3VtIHRvIGFkZHJlc3MgdGhlIGZhY3QgdGhhdCB3
ZSBjYW5ub3QgcmVhZCB0aGUNCj4gZXh0ZW5zaW9ucy4NCj4gDQo+IEkgZ3Vlc3MgdGhlIGtlcm5l
bCBjb3VsZCBiZSBmaXhlZCB0byB3b3JrIGNvcnJlY3RseSB3aXRoIHRoZSBleHRlbnNpb25zIG1p
c3NpbmcsDQo+IGJ1dCB3aGF0IGFib3V0IHVzZXIgc3BhY2U/IEV4cG9ydGluZyBhbiBFRElEIHdp
dGhvdXQgdGhlIGV4dGVuc2lvbnMgYmxvY2tzDQo+IGNvdWxkIGNhdXNlIHByb2JsZW1zIHdpdGgg
dXNlci1zcGFjZSBwcm9ncmFtcy4NCj4gDQo+IEJlc3QgcmVnYXJkcw0KPiBUaG9tYXMNCj4gDQo+
IA0KPiA+DQo+ID4gQlIsDQo+ID4gSmFuaS4NCj4gPg0KPiA+DQo+ID4+IEJlc3QgcmVnYXJkcw0K
PiA+PiBUaG9tYXMNCj4gPj4NCj4gPj4gWzFdDQo+ID4+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4u
Y29tL2xpbnV4L3Y2LjE5Ljgvc291cmNlL2RyaXZlcnMvZ3B1L2RybS9hc3QvYQ0KPiA+PiBzdF9k
cC5jI0wxNTcNCj4gPj4NCj4gPj4+DQo+ID4+PiAgICAJLyoNCj4gPj4+DQo+ID4+PiAtLS0NCj4g
Pj4+IGJhc2UtY29tbWl0OiA1ZWU4ZGJmNTQ2MDJkYzM0MGQ2MjM1YjFkNmFhMTdjMGYyODNmNDhj
DQo+ID4+PiBjaGFuZ2UtaWQ6IDIwMjYwMzEzLXVwc3RyZWFtX2FzdF9kcF9lZGlkLTVmZTZhZGY3
YWQzNg0KPiA+Pj4NCj4gPj4+IEJlc3QgcmVnYXJkcywNCj4gDQo+IC0tDQo+IC0tDQo+IFRob21h
cyBaaW1tZXJtYW5uDQo+IEdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINCj4gU1VTRSBTb2Z0d2Fy
ZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQo+IEZyYW5rZW5zdHIuIDE0NiwgOTA0NjEgTsO8cm5i
ZXJnLCBHZXJtYW55LCB3d3cuc3VzZS5jb20NCj4gR0Y6IEpvY2hlbiBKYXNlciwgQW5kcmV3IE1j
RG9uYWxkLCBXZXJuZXIgS25vYmxpY2gsIChIUkIgMzY4MDksIEFHDQo+IE7DvHJuYmVyZykNCj4g
DQoNCg==
