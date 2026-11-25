Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F9E606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 12:50:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B84DE10E01F;
	Wed, 25 Nov 2026 12:50:05 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023109.outbound.protection.outlook.com
 [40.107.44.109])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2551910E01F
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 12:50:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7KsKo87EDN7DdL5lXtXYZlDqEJlvstFkTBH9n3HnGYkk5rC6kBBsiLGa0Y+I8PJ8BQnCInquq2fYC5xR0DIHAuDRfGQlVuHWqgANftvkp+OIchmTFJDZXrqQd9P1qkWdh9HnHhEnuqrGmQg3t/28if1VEwcLcOMiCf8XGntEGMAFrD26IK9hAkZUBcc/55T7VoVttNzKjukHnwQpRuo5YKh4O590EQcQuegICTZTqxwipO8VhDUWH4v0S0xjjlNSCzRE0Z/mBPI7diSNc3YJDGiTXPOJ81VpEJk9FpWZdnuRj/6npsr73FcI7c+ow4tVYzKf9VnHFI2SI74gEXWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziZXSeddkUVshXkI6JtFHzAnruYRCAOnzoqZWqTJmDA=;
 b=aP8yAcL+5/jllWA/HBR4EZtyxs8r8+i2Nf/GKBGbN1XP9Qt0V8jQP3vg8L2FvA7lV5hA/vdlm/DT20eHk9I2qf1yLYfX8H/zHlFB8nxL+tcDwwOPdbgJmoAAepCIEVvs8eW7w+vhlD8v5y2z9nVv8DkmwaHWCIjhYM9spI+2bfqtzw955DaPussVeoxEhZK7NxTeM4amwRglu2Q6uPd/i3INuO74Emg7HQwOFPUbX/SqEt0ernjnyrJDslBBIijlHHS2OLTznD/bMWKyqVYYorBd7p9ZJnJnOCePUVLhB/HbttbqnmT4IcBwMC6eF+ZKwtS7HUi4raHE3UnfKIrvMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from JH0SPRMB0074.apcprd06.prod.outlook.com (2603:1096:990:63::5) by
 KL1PR0601MB5776.apcprd06.prod.outlook.com with HTTP via P2P;
 Wed, 25 Nov 2026 12:49:58 +0000
Received: from JH0SPRMB0074.apcprd06.prod.outlook.com
 ([fe80::d5a:16db:d97c:df7a]) by JH0SPRMB0074.apcprd06.prod.outlook.com
 ([fe80::d5a:16db:d97c:df7a%5]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 12:49:57 +0000
From: Luo Liu <Luo.Liu@cixtech.com>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
CC: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, "rfoss@kernel.org"
 <rfoss@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
 "jonas@kwiboo.se" <jonas@kwiboo.se>, "jernej.skrabec@gmail.com"
 <jernej.skrabec@gmail.com>, "luca.ceresoli@bootlin.com"
 <luca.ceresoli@bootlin.com>, =?utf-8?B?V3V5aSBTaGVuICjmsojmrabkuYkp?=
 <wuyi.shen@cixtech.com>, cix-kernel-upstream
 <cix-kernel-upstream@cixtech.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjMgMy81XSBkcm0vYnJpZGdlOiB0cmlsaW5lYXI6?=
 =?utf-8?Q?_add_the_DPTX_DRM_bridge?=
Thread-Topic: [PATCH v3 3/5] drm/bridge: trilinear: add the DPTX DRM bridge
Thread-Index: AQHdfAuE4zUklGK5S0CK6GMABrjgLbc+fT4AgABAieA=
Date: Wed, 25 Nov 2026 12:49:57 +0000
Message-ID: <JH0SPRMB00741515FE4859AFCB8D22D7F5432@JH0SPRMB0074.apcprd06.prod.outlook.com>
References: <20261124120114.3273161-1-Luo.Liu@cixtech.com>
 <20261124120114.3273161-4-Luo.Liu@cixtech.com>
 <82168811-c141-445a-97d1-e5c1ee38e0f4@rock-chips.com>
In-Reply-To: <82168811-c141-445a-97d1-e5c1ee38e0f4@rock-chips.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-traffictypediagnostic: JH0SPRMB0074:EE_|KL1PR0601MB5776:EE_
x-ms-publictraffictype: Email
client-request-id: 3e7ca073-5c28-4bc1-a6a2-17db368d72d4
request-id: 76c53e67-425a-4b6f-aa41-08df4af29c91
x-ms-office365-filtering-correlation-id: 76c53e67-425a-4b6f-aa41-08df4af29c91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|366016|1800799024|23010399003|376014|18002099003|6133799003|22082099003|56012099006|4143699003|261028144727099003|261026140227099003|261021121427099003|261026121527099003|261102123227099003|261022105027099003|261009223027099003|38070700021|10067099003;
x-microsoft-antispam-message-info: VbyQguRVu4n+W2fqjUE5kVux9RAFJidwfGAjYpmcGG87VCJ0Pllcy3alTeyi0RMrwGiCie88EiHcc1X9ilMS2lmVNC1qgBy6+zbitUtiz5MolEFeoNTf4Kn9/58FDZDF3uE1gEQ9l+2g7mtBT7GYqklU2RpJ5Eoe8ZeofO828b0d8Oc2vUskcpZxMOZL8LBDXFuGAMTo9XzkeDeCO4qzfiYL2gX5dHeYuxIolqy3QkE9Tp47jNzGsS/SAQzuNuC8QO8DfXZbW+qj8TuO+ovPyGDfjvcmJQ59omXnbiLfCKHUFPXBZiixLFaEE1Pz1K43DWUC93X7M5k+2YBX400zpwNyn9WTtTQIv4dl9lUF+jHlThAxyVTgi4+nEV8E2vkYbAYvBzuU0eH1NvtxsMzEvXCAzJISWRwyXbAK2VBrTWO9hVrnS2L+heJJ1ggelNmdqeScuk0pQSNHBkTbCigqsN5edOTBL/RBazCEFx9TkHtJvLjxfkN3d0LN9cKgbWAtd6a+8jp+KhydxDgxylco3TPTBv3CqOhkIaQwQ1S6lAGYrSYHmbf5Y37hBYobu4uWK/U0eUOlkpoI7jvPmXWyDQ/ct8sceaUW+LdciI6VWkJSQYQVL+I+klDvWnIsy4oyOVEvpl1JlqeHG2sdKah+lI9v+Rh6cD+MJsydXT274XNA5M1X+bQfLZ5njhuljBY2b9Z54zcjREFgOzMM5yGYiw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(366016)(1800799024)(23010399003)(376014)(18002099003)(6133799003)(22082099003)(56012099006)(4143699003)(261028144727099003)(261026140227099003)(261021121427099003)(261026121527099003)(261102123227099003)(261022105027099003)(261009223027099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnUwNmZzcDI3QS9TcW01Q1cyR2VYMEZkd2phOGdXZTUrZlVud2Vnc2dEeWhG?=
 =?utf-8?B?L0M2dENVYjFFWGZzNm9mb3hJSWY2ODFvcmtCYXhrZGdjMVRwMEwzcUlFMkdH?=
 =?utf-8?B?REIwU2dWTFQwNWlLNjZUM1B5akpCSXFaYlloUDhlS2Ywc1piR0dYa05EdHBJ?=
 =?utf-8?B?VWgvTHltK2E5TGlnZG5ZTjFHVko1RHJYbE5aakRKZ2lJY0dlZ2llV1VGeGJ0?=
 =?utf-8?B?UmczclBSaEE1R1FkbVVsR0kwTisyclpEVU5ncXBoU2ZRbFJJSnAyUlZNMW1y?=
 =?utf-8?B?QTRNTmYxWm1zTnREZUVTNDNrU2dDblRBMVR4d2hURWhzTDd0YStPWFNvTDBo?=
 =?utf-8?B?SXg0UDVmc2pheUtjZjBmU0w1d0xEa04vOEp2enBqZWMvTFZLRVNHRi9TTTVQ?=
 =?utf-8?B?U0VMQ2RSdEFlSkVNUG1wUVJBaUVIYUt4UUVBc0ZBN0Q1b2h3MnBzRE14eUhV?=
 =?utf-8?B?TXRDdjQzZm1jNkNmaG5RYnp4dHhVMzRDN2xsV2Q3cVk5Z09rbUJ1UzF6Y2dY?=
 =?utf-8?B?REVOZjVlaHlaZTgrVFptWllYbmVsQkY1Z1cyRmkxdi9nMjBIOXZyVktZc0pj?=
 =?utf-8?B?Mi9pU0lua3FhaUJKUzVpeFRQUEN4NUVQRWgrUDJXQkJwazJHM0J3SUMweUpu?=
 =?utf-8?B?SCs1bXdsa0EybjVEZHpmNzN2VnAxY2ZUSTYxczl5OXRJU1NJUGJILzBDbjBy?=
 =?utf-8?B?R0tZOS9ZbmNiOFdzdGhNSHJWQlZpZEIrellDUkFsRGs2UVJpSjhxY1ZPTTlk?=
 =?utf-8?B?OWdYcTlFVWxMTzk3aWkwa0laYWJkUy8vUlJvaUFoaWRPc2U1K3BNRlpLUEFY?=
 =?utf-8?B?S29JNjNmdEJML2ZQMmd2UVZtcFJvVDlFZ3RDeHAxNExFZ3RGalFkdW5qeWJj?=
 =?utf-8?B?NHVxMWtQcUthTHJtV3pZT1lNRTRjbW1TZ2M0SURlUWh2WnhCT2RaRUdLbVhQ?=
 =?utf-8?B?dWR6cUFaY1Rwa0NqaDBKUGY4dTNzT01GYkx5OUtwR3JmKzMxdUlUWjBQUm94?=
 =?utf-8?B?RmdzeHl6TGkxaUE5RnRvV0pOWE5mbGxIcm5NU1ZYbVlSaVgzbnI5L2pXd1dl?=
 =?utf-8?B?cXJOYW9wcFE5SFJlYm9INm05R1djQ0dJY0xVNmpyMVIxWTVudjZrVk0wcksv?=
 =?utf-8?B?RGRBQzg2Nkd2bS9hZ3pYM0p2ZlVwUjFSUHhiOTZYNzFGZm9IaVI5SGNuUHdW?=
 =?utf-8?B?TVhnR2FBUnZiVGRQcE1GVEhUQ3prYTNwblV0WGJIT1FERXN3UGxuRG55MU1t?=
 =?utf-8?B?b3JOcE9qczhBUlRPZHQ2TFJRZEJuMjEvSENSNFpuVGFtMUt4ZXRuWDNGTjNV?=
 =?utf-8?B?UjlVOElXeXJqdUZ3dG1qV2pRVVdtbU5FaWdZcTZXQy90T3dmclJvUFNoczBp?=
 =?utf-8?B?Q0hQU05yYmJWdXBQRkJJV2I0VE1XL3lOaklHdTVWUEFFUWFsSVBrYXNmdkd2?=
 =?utf-8?B?ZTV2QjQ3ajJINGNtN3hUVDZOYTNoc2JnbkhwZHJWdGZacWY0ZDJGYVk1bXI0?=
 =?utf-8?B?NjlLSHl2ZlpHcTk1OWdzdzMvb0MxRElZMS9hc0hYbWNGVzhjdXhZWW1OSkcw?=
 =?utf-8?B?c2FHYUk2YXhCK0FPQXRrbU4zTURzZGZOQTRsUjdmT25acTR6MmtvalIzSU4x?=
 =?utf-8?B?VmZiT2kwTjEyT3VKODU1RnJGUFgvRnprYXU5aXdoSG5qNUhCcGYySmR3N1Fo?=
 =?utf-8?B?WVlvdUk2TG0raTEzNzNDWEZkTnh6OFk5OHh4Wm11cTByd0JVajZsUFRMMHVF?=
 =?utf-8?B?dHVVb3Vwd0JwTG1zWStaT29XdGhpcW1uYkw3TGUvenJzRmJKRy9BOHRIQ0Vu?=
 =?utf-8?B?RHNKTUV1TWRUcDRDaEl6aHZma21wbWlHZDlGUVZTUXR0bzMzV0FoYStXZGg2?=
 =?utf-8?B?VDJldVJFR1dmNkxjWGMyYmlGd0JuK045elpxZzk0OXY4b3lGdHNibHVSRVBE?=
 =?utf-8?B?a3JONWZKbWdrOFVTdDZBSjkyYWhPRUkrRERpVWU4LzZmT3BONXllWmEvYytp?=
 =?utf-8?B?MjBVWVl1ZFN0dzRLNjU1R3FpSXhRMEdONDFEcDUydWR6S0wyNStodnNJUUN5?=
 =?utf-8?B?alpIY1pOV0I0NkE4S3ZxMDJySjdkSWNKdDlYZnNkaEJ4SlFTeSs4REU1QUMv?=
 =?utf-8?B?TnRXb28waGg2QVJiaHVtam9tWmhRcVlSQml3SXpMNytXMVVIaXNBeDZucWI2?=
 =?utf-8?B?WHhUYlNJR3pHSS9RL2Fwdk1DdFpFdGJmenRmdWJRQWpGTUJMZkZ2bkFhencr?=
 =?utf-8?B?U2NuTU8xU0lhRVIxdlRkME9NMG9QY0lIdnQ2TWFTdXByYkt4VjVjVGdTc3E1?=
 =?utf-8?Q?EqOpSLbcuu2hCt/uP3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0SPRMB0074.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c53e67-425a-4b6f-aa41-08df4af29c91
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 12:49:57.8980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FLG5B4sbET4O7FZi3EydyQYLckzik5n+ePQkEVZx9C8LA4P/wIokoHWN4onn+GkTshIyxUCeU8zIkw5KeDfXPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5776
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgQ2hhb3lpLA0KDQogICAgICAgIFRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgcmV2aWV3
IGFuZCBzdWdnZXN0aW9ucy4NCg0KPiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6
ujogQ2hhb3lpIENoZW4gPGNoYW95aS5jaGVuQHJvY2stY2hpcHMuY29tPg0KPiDlj5HpgIHml7bp
l7Q6IDIwMjblubQxMeaciDI15pelIDE2OjU1DQo+IOaUtuS7tuS6ujogTHVvIExpdSA8THVvLkxp
dUBjaXh0ZWNoLmNvbT4NCj4g5oqE6YCBOiBtYWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRlbC5j
b207IG1yaXBhcmRAa2VybmVsLm9yZzsNCj4gdHppbW1lcm1hbm5Ac3VzZS5kZTsgYW5kcnplai5o
YWpkYUBpbnRlbC5jb207IG5laWwuYXJtc3Ryb25nQGxpbmFyby5vcmc7DQo+IHJmb3NzQGtlcm5l
bC5vcmc7IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOw0KPiBjb25vcitkdEBr
ZXJuZWwub3JnOyBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOw0KPiBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsgbGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tOw0KPiBq
b25hc0Brd2lib28uc2U7IGplcm5lai5za3JhYmVjQGdtYWlsLmNvbTsgbHVjYS5jZXJlc29saUBi
b290bGluLmNvbTsgV3V5aQ0KPiBTaGVuICjmsojmrabkuYkpIDx3dXlpLnNoZW5AY2l4dGVjaC5j
b20+OyBjaXgta2VybmVsLXVwc3RyZWFtDQo+IDxjaXgta2VybmVsLXVwc3RyZWFtQGNpeHRlY2gu
Y29tPg0KPiDkuLvpopg6IFJlOiBbUEFUQ0ggdjMgMy81XSBkcm0vYnJpZGdlOiB0cmlsaW5lYXI6
IGFkZCB0aGUgRFBUWCBEUk0gYnJpZGdlDQo+DQo+IFtTb21lIHBlb3BsZSB3aG8gcmVjZWl2ZWQg
dGhpcyBtZXNzYWdlIGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tDQo+IGNoYW95aS5jaGVuQHJv
Y2stY2hpcHMuY29tLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQNCj4gaHR0cHM6Ly9h
a2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4NCj4gRVhURVJOQUwgRU1B
SUwNCj4NCj4gSGksDQo+DQo+IE9uIDExLzI0LzIwMjYgODowMSBQTSwgTHVvIExpdSB3cm90ZToN
Cj4gPiBBZGQgdGhlIERSTSBicmlkZ2UgdGhhdCBleHBvc2VzIHRoZSB0cmFuc21pdHRlciB0byBL
TVM6IGNvbm5lY3Rvcg0KPiA+IGRldGVjdGlvbiwgRURJRCBtb2RlIGVudW1lcmF0aW9uIHdpdGgg
YSBkb3duc3RyZWFtIHRpbWluZyBmYWxsYmFjaywNCj4gPiB2YWxpZGF0aW9uIG9mIGEgbW9kZSBh
Z2FpbnN0IHRoZSBzaW5rIGxpbmsgY2FwYWJpbGl0aWVzLCBhbmQgdGhlDQo+ID4gYXRvbWljIGVu
YWJsZSBhbmQgZGlzYWJsZSBwYXRocy4NCj4gPg0KPiA+IFRoZSBicmlkZ2UgaXMgbWVhbnQgdG8g
YmUgYXR0YWNoZWQgd2l0aA0KPiA+IERSTV9CUklER0VfQVRUQUNIX05PX0NPTk5FQ1RPUjsgdGhl
IGNvbm5lY3RvciBpcyBjcmVhdGVkIGJ5DQo+ID4gZHJtX2JyaWRnZV9jb25uZWN0b3JfaW5pdCgp
IGZyb20gdGhlIGJyaWRnZSBvcGVyYXRpb25zLCBzbyB0aGUgZHJpdmVyDQo+ID4gb25seSBpbXBs
ZW1lbnRzIHRoZSBicmlkZ2Ugc2lkZSBhbmQgbmV2ZXIgY3JlYXRlcyBhIGNvbm5lY3RvciBvZiBp
dHMgb3duLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTHVvIExpdSA8THVvLkxpdUBjaXh0ZWNo
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2JyaWRnZS90cmlsaW5lYXIvZHB0
eF9kcm0uYyB8IDYyMw0KPiA+ICsrKysrKysrKysrKysrKysrKysrICBkcml2ZXJzL2dwdS9kcm0v
YnJpZGdlL3RyaWxpbmVhci9kcHR4X2RybS5oIHwNCj4gPiAxNyArDQo+ID4gIDIgZmlsZXMgY2hh
bmdlZCwgNjQwIGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
Z3B1L2RybS9icmlkZ2UvdHJpbGluZWFyL2RwdHhfZHJtLmMNCj4gPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvZ3B1L2RybS9icmlkZ2UvdHJpbGluZWFyL2RwdHhfZHJtLmgNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3RyaWxpbmVhci9kcHR4X2RybS5j
DQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3RyaWxpbmVhci9kcHR4X2RybS5jDQo+ID4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmZkZTM0YmFjMTIz
MA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3Ry
aWxpbmVhci9kcHR4X2RybS5jDQo+ID4gQEAgLTAsMCArMSw2MjMgQEANCj4gPiArLy8gU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPiA+ICsvKg0KPiA+ICsgKiBEaXNwbGF5
UG9ydCBEUk0gYnJpZGdlIGhlbHBlcnMNCj4gPiArICoNCj4gPiArICogQ29weXJpZ2h0IDIwMjYg
Q2l4IFRlY2hub2xvZ3kgR3JvdXAgQ28uLCBMdGQuDQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArI2lu
Y2x1ZGUgPGxpbnV4L2RldmljZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+
ID4gKyNpbmNsdWRlIDxsaW51eC9tYXRoNjQuaD4NCj4gPiArDQo+ID4gKyNpbmNsdWRlIDxkcm0v
ZHJtX2F0b21pYy5oPg0KPiA+ICsjaW5jbHVkZSA8ZHJtL2RybV9hdG9taWNfc3RhdGVfaGVscGVy
Lmg+ICNpbmNsdWRlIDxkcm0vZHJtX2JyaWRnZS5oPg0KPiA+ICsjaW5jbHVkZSA8ZHJtL2RybV9l
ZGlkLmg+DQo+ID4gKw0KPiA+ICsjaW5jbHVkZSAiZHB0eC5oIg0KPg0KPiBUaGlzIGZpbGUgZG9l
cyBub3QgYXBwZWFyIHVudGlsIHBhdGNoIDQuDQoNCg0KWWVzLCBJIHdpbGwgYWRqdXN0IHBhdGNo
IDMgdG8gaW5jbHVkZSB0aGUgZHB0eC5oIGFuZCB0cmlsaW5lYXJfZHAuaCBoZWFkZXJzDQoNCg0K
Pg0KPiA+ICsjaW5jbHVkZSAiZHB0eF9kcm0uaCINCj4gPiArDQo+ID4gKyNkZWZpbmUgRFBUWF9N
SU5fSF9CQUNLUE9SQ0ggMTINCj4gPiArI2RlZmluZSBEUFRYX01JTl9CUFAgICAgICAgICAoNiAq
IDMpDQo+ID4gKw0KPg0KPg0KPiAtLQ0KPiBCZXN0LA0KPiBDaGFveWkNCg0KDQoNCuacrOmCruS7
tuWPiuWFtumZhOS7tuWMheWQq0NJWOWFrOWPuOeahOS/neWvhuS/oeaBr++8jOWPl+azleW+i+S/
neaKpO+8jOS7heS+m+acrOmCruS7tuaMh+WumueahOaUtuS7tuS6uuafpemYheOAguS4peemgeS7
u+S9leacque7j+aOiOadg+eahOS9v+eUqOOAgeS8oOaSreOAgeWIhuWPkeaIluWkjeWItuacrOmC
ruS7tuWPiuWFtuS7u+S9leWGheWuueOAguatpOmZkOWItumAgueUqOS6juaMh+WumuaUtuS7tuS6
uuS7peWklueahOaJgOacieS6uuWRmO+8jOWMheaLrOacque7j+aYjuehruaOiOadg+WkhOeQhuat
pOexu+S/oeaBr+eahENJWOWFrOWPuOWRmOW3peaIluS7o+eQhuS6uuOAguiLpeaCqOivr+aUtuac
rOmCruS7tu+8jOivt+eri+WNs+mAmuefpeWPkeS7tuS6uu+8jOW5tuawuOS5heWIoOmZpOmCruS7
tuWPiuaJgOaciemZhOS7tuOAguS6kuiBlOe9keS8oOi+k+aXoOazleS/neivgeWPiuaXtuaAp+OA
geWuieWFqOaAp+OAgeWujOaVtOaAp+WSjOaXoOeXheavkuaAp++8jENJWOWFrOWPuOWvueS7u+S9
leS8oOi+k+mUmeivr+aIlumBl+a8j+amguS4jeaJv+aLhei0o+S7u+OAgg0K
