Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1002606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=c1PjPkec
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 287C910FB0B;
	Wed, 18 Nov 2026 11:34:13 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011044.outbound.protection.outlook.com [40.107.74.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4DE310FB0B
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 11:34:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gq97p6IJqWYsNJ6cZfcrSQ+xzL0f7hIX5HY/Qm0rXf3dQIfeb9DJ3M1eLKUveqEkDqav+ABieZPBCTltbdBI5tGriGD5SDWocSh01YsErdoumL2jIilAA+/mpJ6xKzV8uCeOHAA8szMJ3rIYYv/5X772xoaO69iwW/txDRd4c0KG7F4y2v7YIb+Iy70M7FbNyu6m/hN0etvKtNo81HP8xUW5Rx6fUiTMtn8F4Im1d4kNqmVJa2LQZsw74VnvbkBl/Cl2kEA2F24GOj387Wn0ZO+GZI1LXxK6MkbfUVZ55Bplw/dEe5Z4zfN2S3sfJpkFUVue2SwCLF8Qj+VXoL0I2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXQXAqBi9NPkMP7qrCXjRoJx/7SfXpbLuCSMmLt2CyI=;
 b=ZWvq1FGL1c0ceZYrJrWQMdDUdFu4gzCmNqp9fQJCxDic01eJltoqxIhEEWOaGSNvb4dbsB7smdqqPY+AIH1+iev9+pxlazMyBUWjscgEHck/7ZUFz0nQx+KqilZp8XyTCWePnDRz8tl5dGOwzQFa4XtjbUWHP+Km+z3rGq9j2CzsAoCJf/qMuqnUsooDDE/bkKYMT8xJXDea3Cqi+MReoqob60a3fIZkNDZ+9pZfu80KgcZRkvBN9xR3V2LRUlSW5Cu092qClvkAamxPH/JaTRy1BX5RzT4OASzBaAZfliZgmbb9B7UyBbMDmTQ13BVRI6QJ9w6TAEJfzP/m/dj4ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXQXAqBi9NPkMP7qrCXjRoJx/7SfXpbLuCSMmLt2CyI=;
 b=c1PjPkecQW5y3BKA5mYpxegMce7CUDLK0UgUNd0bgnHlBhTgOATpffyEnWnG7KC6JEzldjUiKVkASn2hhj/DYashZFb8NPg+K3n+aSAkIfS1wDz4zMdEwlo4OwJE9IXpfOR7cLol5tpxBPTjtuv3v2rA8cXLNoVtBIVv+NjOBqs=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TY4PR01MB13334.jpnprd01.prod.outlook.com (2603:1096:405:1df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 11:34:02 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 11:34:02 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tommaso
 Merciai <tomm.merciai@gmail.com>
Subject: RE: [PATCH] drm: renesas: rz-du: Add suspend/resume support
Thread-Topic: [PATCH] drm: renesas: rz-du: Add suspend/resume support
Thread-Index: AQHdcn9jGtAl/8lyWUeAzooLZoTu0bczvEGQ
Date: Wed, 18 Nov 2026 11:34:02 +0000
Message-ID: <TYYPR01MB6603D3210C7C4149A7AB32E8867A2@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <20261112-b4-tm-pm-du-v1-1-507474331137@bp.renesas.com>
In-Reply-To: <20261112-b4-tm-pm-du-v1-1-507474331137@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|TY4PR01MB13334:EE_
x-ms-office365-filtering-correlation-id: 37204583-0237-474a-cc65-08df4567d84d
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|261009223027099003|261022075727099003|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261102123227099003|261028144727099003|56012099006|11063799006|10067099003|38070700021;
x-microsoft-antispam-message-info: 3FOzkAinUwCONxaiqQBmXCTlvao6WZOtLtYrqvWpNTusp6yo1TXSXsRmS2p/7eKLd3r5ZOGDBTGlTU20bWk07wKbkmmdV+PIPUOwBJPFIqXWuPMzvQNZB7bMz73B+7+2q6pdIj5W24SzoWyUgMXD/bZBTOqsLgZH9MoxM10sz4Jlgz4vxtCn33LfTz2qXmKX6wwL6QmVjGCUyGF9T1BIwRU/gdhQ8PrTzwQTdsOytFBcqPA/7NvUdPmbePwo7B99juS0t4YCBJZJlkIST8DVeHM0S10ALa+CVxljbCJv+DN2qB4mTsAfUgFSNYmMa0Jcwv3fNxjIhS1thb7j3a75PTTd4YCM/ojQSrY3UQ64UeGF2s0YHeH2176wW0jBNAV3DSN/HaWQkQehoCAPg4yVKHf6FTTlAvFrjlbXuodSfxE+WLKC+5e87C6bG2pIAyw1L0oUMYbZOaMIIIaGrcBLux+4zvt/dlUBrbFlKOp5BFoT2edZewa/pjrP0aDQBK2meFjV0MdFRIn7NUo/Mo+LjxtSSe07c55gMMNDDUJazkVPpFJ4s8RKE3UdImSZbkfAQtdA6U3kK5S5RQ0THGy8+BPLrNr8qEkma45akcUzidTW4uKVsa8OgfMnFWXWD5ZirDtxvITZtSSu3AKS/baUIzM/X9yCK25zShbWuGutoGrglWWLt80FIdOHleGjB0fcvhCoOt1aKePBjLkl3EQIi2EjyMYNH/3oRXyjrVni/jw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYYPR01MB6603.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(261022075727099003)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(56012099006)(11063799006)(10067099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2hUNzRib3d2MmtJUTBKTGlwRnpjdmZwTGtnOC9Xbk05d0E5Ujk0WWliR05T?=
 =?utf-8?B?RFhFMzI4dUhzRFYzaHpWSDZ1YkdKOWpJTkNVRmJYMTdvVit3eUdlc1RJWWI1?=
 =?utf-8?B?L2VFL3ZKWHgwWWprNnhWb2puUmJXWExyT0ZBQ3FuZkxNeEZwMnpqUjJ2aHNI?=
 =?utf-8?B?TnJOK1QzemVLVzZSR21CdWMwdWtaczVPZkx4VXM1STFUSEtNL1ZpTmpnYkhD?=
 =?utf-8?B?WHVDVFQ1NGpibXpKUVZtdHBFS1o5TmI3UDJiclFLUFNZYTN2VW1aWWpKa0ZO?=
 =?utf-8?B?NUlJelM1S2ViVHNiMnV4SHlBVXc5dGVqOURNSVlSTkNyazNhSGMxb2lMenQ3?=
 =?utf-8?B?VHMvb0NCRGovek5vQ284UmNXa1JLVmcySU9xaUFKMzRDRWk1amZ5aEFHZVBm?=
 =?utf-8?B?eUtLMEdPaGhOYUc4cjVITXp4OE40OGxlODY4cEdLdUN6SlNPY1JyeGFTT3hy?=
 =?utf-8?B?L0FCZnlEdk9NTXVKb3FTbnZSd2ZZejd2MC9BMmhhWWZhT2UzcXhaTXZtQWRB?=
 =?utf-8?B?ZzZod05UQi9xelRoQWNFbTlQem1ZTGkyQXdXYWZsMG42U0tsRTNidHFTVUJ4?=
 =?utf-8?B?UG91OGJPWm1Id3BzMUtsN093enNabXhvYkNPUTM2Yi9QSC9ITnhZZDZMR3Nw?=
 =?utf-8?B?YmtpVWJDR1VUZS9oV205emVjNkFnVkM5d1czVGEyeUN0Q3o4NGsycUxpS3pt?=
 =?utf-8?B?eWgrdkxIMDg3a051QmxZNy9CQytEcVp4THNvZng4NjVWWWp3TGdURGp5Rmsx?=
 =?utf-8?B?dC82Z2plZS9YYjFDZnBKam9vSXl0eEs2YmtXVDNrVlRicVphZkM4eUtUQ2dp?=
 =?utf-8?B?dVplYWtha3JidEUrclFOR2VuSU9sMkdLMUxLNWhIVnpXQXZZMUFYTXIyVlZw?=
 =?utf-8?B?cVJNSGZDaWxTcGNjVzlodEduRmR5K05XTlJzSHpyR1VUOFZNV0d4Q3pjdUg0?=
 =?utf-8?B?NmpvRDNNcmlLc0E0SmxxS3I1aTIrZUNGcjV4ZVhyVWtrRXhCSjdEa0F3NllD?=
 =?utf-8?B?ZmNKNWFMdnJMTFB6WFlwR2Z2YnlOSjBoSFhXOGFNa1JITEVhZGx1aXUvcncx?=
 =?utf-8?B?TkZRc2tGQkdjUjE0WTltRyt6eGtwcmZ4QU5NQkliY2Q0ODVHeHhmSU5QL21C?=
 =?utf-8?B?aElkQnA3dDdVU2Zvb0hrSUZKd0tabXd0SjcwVTZvRTdjMUV6YVJENEdJZ2pS?=
 =?utf-8?B?cEZDNmR3Ykc1ejEvTUl2N2QzVE9kMG8rME1NSkZzak5ucXVKdWx4eDNVK0g0?=
 =?utf-8?B?eEVPWkk2Ui93Y3lhTU5HZFUvTlU3VnNVK2pRSGlib1hZMXp5ODhyY09nS01F?=
 =?utf-8?B?aHpzQ0NTNDhuZGtaVzZNek0zM0hyemZONHZjMlFtWGxLZ2hia1dzRDFVK0hV?=
 =?utf-8?B?N05MMENlbk9FQWFtM0FZcU9TdkhiS05MSkZNSEUwZDZ5U2ZZSkdMdUE5N2gv?=
 =?utf-8?B?Q0xJb0NiaXhRY1pJNjU5OUpFSHg4bEptMmU5RjZMaG5DVE95RkVCblNsaURS?=
 =?utf-8?B?emJiVXdaQXJnUEdTUkdDRmREME0xK1k3UVVFVzcwM0RoZVRKWHRiOXVtUllV?=
 =?utf-8?B?a2xCUVdERW81Z1I5ZW5LZ0JScGlBQ1FZYTVDejYwQWt3MmZXb2dPeWsxS2ox?=
 =?utf-8?B?czByRWFDb3BGaVRQdnJxUEtqZWhndFRCSjVaNkRYckJveVEzc2luUjFsRWoy?=
 =?utf-8?B?RUNDTDdVQUpkRHJwR0g3OUVOL29xeTIwQi9teG0rOUtXTVpUZ2d1VWF4NjBr?=
 =?utf-8?B?U3Nianc2V2ZRYm9ya2lTU1d3V3hsaFBFa05GWUJBM3pWc1BDaXJJYWlOQ0da?=
 =?utf-8?B?SVYrcmdURjhBb05pQXdSVW9acGRPb2dLczdsWllLdjJnaE9HZTMyaUJnRWtT?=
 =?utf-8?B?NnhuWW1aT2sxeUFBc0xWU1BRZDd5ZllBdThPeGgrVkJhcmFtMy9ZUGQreGx3?=
 =?utf-8?B?MmxxSUJjbndla0wwZ2RVcTdYaWtLaEFibFR4ZnJRYVAwMmF4eTJjTXExVFVk?=
 =?utf-8?B?SFYyU3liakhFSjNoRHo0SHAwZWxpd1BkbVlvYlJqVDh4M3hRRFBNaCsvRW9n?=
 =?utf-8?B?SnRCczM2MVMyM1F0dWVMeFEyT2FEU002R0VzNStIMkU1K3lPUWtOV0pWOWQ4?=
 =?utf-8?B?UjJGV25BdlJqcVFYTGsyUDc2YlFrWUJkdk45Qm9INFFmVHM1UzN2N1ZVNWox?=
 =?utf-8?B?ZEI4eUhtczFlZjVXcjM2REFNc0VtNEhJc3AzT2VFWDNkblpHWW5kdWs1OVIr?=
 =?utf-8?B?ekE4K3JZSGMrTmNIT3VIdG9jWGZ3L0VJS3MwcDVFcDNQSE5KZFFnYytRQkx1?=
 =?utf-8?B?SFN2RUxtclh5VytaTTNuckg2eXh1Y3drZ21wc0RUNEd1RDVUUDdzdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37204583-0237-474a-cc65-08df4567d84d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 11:34:02.2309 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XjMcYt6AmwMdY1zCVJ7hU27SZyHIPaFKIQZCnGp129Zw7ZOSRBuc/gMk7ZZiyJifgMJ0n4koCb2SDPNfBayBcdgVIhOUFZoML6ti3H4Vdag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13334
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVG9tbWFzbyBNZXJj
aWFpIDx0b21tYXNvLm1lcmNpYWkueHJAYnAucmVuZXNhcy5jb20+DQo+IFNlbnQ6IDEyIE5vdmVt
YmVyIDIwMjYgMDg6MjUNCj4gU3ViamVjdDogW1BBVENIXSBkcm06IHJlbmVzYXM6IHJ6LWR1OiBB
ZGQgc3VzcGVuZC9yZXN1bWUgc3VwcG9ydA0KPiANCj4gQWRkIHN1c3BlbmQvcmVzdW1lIHN1cHBv
cnQgdG8gdGhlIFJaL0cyTCBEVSBkcml2ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUb21tYXNv
IE1lcmNpYWkgPHRvbW1hc28ubWVyY2lhaS54ckBicC5yZW5lc2FzLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL2dwdS9kcm0vcmVuZXNhcy9yei1kdS9yemcybF9kdV9kcnYuYyB8IDIyICsrKysrKysr
KysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JlbmVzYXMvcnotZHUvcnpnMmxfZHVfZHJ2
LmMgYi9kcml2ZXJzL2dwdS9kcm0vcmVuZXNhcy9yei0NCj4gZHUvcnpnMmxfZHVfZHJ2LmMNCj4g
aW5kZXggNmMyZGM4NmFiYzdkLi5jN2Q3MWRkOTE5OGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9yZW5lc2FzL3J6LWR1L3J6ZzJsX2R1X2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9yZW5lc2FzL3J6LWR1L3J6ZzJsX2R1X2Rydi5jDQo+IEBAIC0xNDAsNiArMTQwLDI3IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2RyaXZlciByemcybF9kdV9kcml2ZXIgPSB7DQo+ICAJ
Lm1pbm9yCQkJPSAwLA0KPiAgfTsNCj4gDQo+ICsvKg0KPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gKy0t
LS0tLQ0KPiArICogUG93ZXIgbWFuYWdlbWVudA0KPiArICovDQo+ICsNCj4gK3N0YXRpYyBpbnQg
cnpnMmxfZHVfcG1fc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpIHsNCj4gKwlzdHJ1Y3Qgcnpn
MmxfZHVfZGV2aWNlICpyY2R1ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsNCj4gKwlyZXR1
cm4gZHJtX21vZGVfY29uZmlnX2hlbHBlcl9zdXNwZW5kKCZyY2R1LT5kZGV2KTsNCj4gK30NCj4g
Kw0KPiArc3RhdGljIGludCByemcybF9kdV9wbV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KSB7
DQo+ICsJc3RydWN0IHJ6ZzJsX2R1X2RldmljZSAqcmNkdSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYp
Ow0KPiArDQo+ICsJcmV0dXJuIGRybV9tb2RlX2NvbmZpZ19oZWxwZXJfcmVzdW1lKCZyY2R1LT5k
ZGV2KTsNCj4gK30NCj4gKw0KPiArc3RhdGljIERFRklORV9TSU1QTEVfREVWX1BNX09QUyhyemcy
bF9kdV9wbV9vcHMsDQo+ICsJCQkJcnpnMmxfZHVfcG1fc3VzcGVuZCwgcnpnMmxfZHVfcG1fcmVz
dW1lKTsNCj4gKw0KPiAgLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAqIFBsYXRmb3JtIGRy
aXZlcg0KPiAgICovDQo+IEBAIC0yMjcsNiArMjQ4LDcgQEAgc3RhdGljIHN0cnVjdCBwbGF0Zm9y
bV9kcml2ZXIgcnpnMmxfZHVfcGxhdGZvcm1fZHJpdmVyID0gew0KPiAgCS5yZW1vdmUJCT0gcnpn
MmxfZHVfcmVtb3ZlLA0KPiAgCS5zaHV0ZG93bgk9IHJ6ZzJsX2R1X3NodXRkb3duLA0KPiAgCS5k
cml2ZXIJCT0gew0KPiArCQkucG0JPSBwbV9zbGVlcF9wdHIoJnJ6ZzJsX2R1X3BtX29wcyksDQo+
ICAJCS5uYW1lCT0gInJ6ZzJsLWR1IiwNCj4gIAkJLm9mX21hdGNoX3RhYmxlID0gcnpnMmxfZHVf
b2ZfdGFibGUsDQo+ICAJfSwNCj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogNjMwMDU5YTVhNjMy
Mzc3YjliN2I0ODdiYWNjZGU5MmI3YWUxZGQ0Nw0KPiBjaGFuZ2UtaWQ6IDIwMjYxMTEyLWI0LXRt
LXBtLWR1LWVkYzA3OWM1OWE5Zg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBUb21tYXNv
IE1lcmNpYWkgPHRvbW1hc28ubWVyY2lhaS54ckBicC5yZW5lc2FzLmNvbT4NCg0KQXBwbGllZCB0
byBuZXh0Lg0KDQoNCg==
