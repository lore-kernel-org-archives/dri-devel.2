Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5A6C98307
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:51:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9569210E700;
	Tue, 22 Sep 2026 15:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="EPoE6bBT";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazolkn19011075.outbound.protection.outlook.com
 [52.103.32.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F39010ED93;
 Tue, 22 Sep 2026 15:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AC5bW1k9hrrv2ms73LNfPpJnTeZOdKPzjYEgnnCEnxsBjxNwvHjGudg60Y0tX0StZS5plpHlwXv2BtVPI2KSBIFBBXLZ6PGIgJqxaarykcyVzJ1c/PuknQdOfu5vzKw7RWm3SYFZ6aT5ByR6dfthto1Hyz+yuk/2YwFviJSZTyAYsq6hFWN0Q3QVOjpCj3yd60ll8BjdrHtAI7iRHKh+R/DWTOQTQWyvmcvb5GGQ2kAqSFw3z/v/QOs9SNMhWJuCfaicZ3EzA06V3m5ve8vwFmfMXSI+YZmp6RaDLtOhNAJ5kd1L5qrjBhExt4hxqMrLGkO0A4ia8I191tkE3rs6DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ryIpeCzRKDPi20cE+9xKyP+yK0a+xKJIGvs0Vv8WiA=;
 b=RJ5REJEMOv3UMx/PphXperHPs57bXh6LFn7c5vHdxVkhc+vpo7Yfwj6rMnjQOCeAhvuYYI08qPplUS51iXdThs6ZQiihshBl2HqrzptVnVOXiZHAt6IqLQf1wFhXGlacHUdtuQOmcdIjaaFaYFgbYm3k+u79OI+zT1+ENnV8WL6yvzkBXs1mk6uOP3EdYBv3ScXonv5oP7PEKqT9F5Q2KmMiYcj224z0UmI6PIDGLd5tYDILcsXIsm0j5wTSnro6Z6nGKZlnyOeccu417RLzTWIIJ/eOx3dkGbk29dxz1PI74AwZ7PWsfDzJJrbxiBjGoqHh6Pz8nRBM8XsqFoEyfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ryIpeCzRKDPi20cE+9xKyP+yK0a+xKJIGvs0Vv8WiA=;
 b=EPoE6bBTiC1loRv1p8hFU6QSXXbq+B/tE1Ceo1GlCKzEzyPYWZUsT0PN9C3YOGTc3LP8tzcavH4csEuvMM2i5z+NlM1GuAnATr5TEXr6p6W9YR89Ck61ARXUMB+RSo8qVvd3dNMwBejMBWiJEWXyCvRo4YavtpgbXuKziLnBuerX7be22K7PumVzzMgGfd4sy9nHuZjif6h8+xiLM84WDcMfSGQJXF1TZvkwa9ruFpEMDJabIgf964jc4nA0uFQwgbHjlM0M71TNkgiTQbSJzzqYzmMU+vBzYlBTiKVfZ2R/ErLgXXLDP7SEaWltvazxiEwKsOfccfwDA7o7GQVIKg==
Received: from DB9PR03MB7388.eurprd03.prod.outlook.com (2603:10a6:10:223::18)
 by DU0PR03MB8743.eurprd03.prod.outlook.com (2603:10a6:10:3ca::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 15:51:24 +0000
Received: from DB9PR03MB7388.eurprd03.prod.outlook.com
 ([fe80::2ce4:f394:cc5e:6d48]) by DB9PR03MB7388.eurprd03.prod.outlook.com
 ([fe80::2ce4:f394:cc5e:6d48%3]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 15:51:24 +0000
From: Arthur Liberman <arthur_liberman@hotmail.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
Subject: [PATCH 0/3] drm/amd/display: fix NULL derefs on MST HPD and teardown
Thread-Topic: [PATCH 0/3] drm/amd/display: fix NULL derefs on MST HPD and
 teardown
Thread-Index: AQHdSqoZls0hw0TPkUyfm1fNCkwksw==
Date: Tue, 22 Sep 2026 15:51:24 +0000
Message-ID: <DB9PR03MB73884B0D604BA858636247CF8A832@DB9PR03MB7388.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR03MB7388:EE_|DU0PR03MB8743:EE_
x-ms-office365-filtering-correlation-id: c160fd11-5842-4b75-1a34-08df18c15b18
x-ms-exchange-slblob-mailprops: znQPCv1HvwUXBahuwteIkQeW30lJPuxOOlXpeUFOkZLvojDHFIqO84JObT9U8fiUwPijj2preClOD/cGIjUhYn9u7ckpSbrG7wk1gwngSPBGDoh6AuJpIF4CUlKMCYWWcAUiNQrGiAn97dvfkBh9rj9tfde9gTdIpLTV8TAlgcmOSpXtYYBVRMpiLUEFZ7per8dJFMUW7L0FGWJm52oq9Mt+KqrGGk4edWNE9dUF1kQzXFPCj2Gnk8T9pMaR6dkWMtyToDpdp/LbZic8tOuGKZ5982ffOITPU9hDPHFKqZo4rJtix0RCgs8v+LZI1DmckYOx+qpgVCbI/WiUD1wsL0mBh+E7vgN6LkaNHSOtDbnvn802GB1l2RixWhmQdNyMm0xerBVC0nXPpAvBW106cwMtcRa05NFz2woybiyZ6fMJgCKQVJJeVXStXmwYRQdXsACoKyCLWF5M4ELcszGB8B9w1wj82cVjf+uAIYpI6DLKOgY7w0jC6YaANzrY5e0dmEW+iPjcgkhJ+jFO+VfAe8wLeUFAELmK1zkCAD3BPu7P4qb8iIw/FQe6mKVFhmPsgThzm10nE9jr8eOtnkyZ3PxbLiPfVflGg+UlbDcyGhBOfoB6vxw6CqMUgQ42FN9UtRd43FuBXSMNKtqDcaFzLM12AIoRBnaX7V3ymMLhq2E5shy4rtK051w+uYiSsbyP3uy0Hr8fAYXp0Cxh2R1XQbqvEr4PXe4I5uWEnDqbMpLgRFMMtW8tSjASlCY80FHp/uIq63pK8T8=
x-microsoft-antispam: BCL:0;
 ARA:14566002|8062599012|19110799012|4140399003|8060799015|25010399006|16041099003|15080799012|37011999003|31061999003|15030799006|24021099003|40105399003|53005399003|2607281247196008|102099032|3412199025|440099028;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?fk5ERDpuy6Gbp+GXC9O4W3aO64DrnMpmvDPBtTSXqxk/EskoJt//W6v0Un?=
 =?iso-8859-1?Q?UJDaAwJB/3MR56Fz+HZMp31WAlg14F7CG6vLrIwsmOqF4SQ3PJ50S3S89f?=
 =?iso-8859-1?Q?FliPNXtC6bimKr1BnLIwvpCi+sXBQP7VREXGZQu+qQghAVUVY6hdMelPeR?=
 =?iso-8859-1?Q?YXMEJ9auoocyKLeUpXq2brI0yBiejq7eilctISZkBLM+WFyfqh8I06vEjK?=
 =?iso-8859-1?Q?WfBkRGASUu+xIlpQ6ga74nfz0nEjy1lgSfeZyiKwIUcetgzONA6LFE2DZy?=
 =?iso-8859-1?Q?K4Lr7nBde2O55sIn18Jjw6SP9rUcgrr35bxmtlb9HufaT8NbxiclZ0DTeB?=
 =?iso-8859-1?Q?aDjapIbTBnE/tGcoVu7j83OTYAd+6HRFA2ATPNWsdlLmTKWovnoFnuTEkk?=
 =?iso-8859-1?Q?L4J6AXB30P1GhZwhhUCPT1ovKNse+RLl1amnn3fDo0amMAXx8351StfMS0?=
 =?iso-8859-1?Q?YXEpU/Gm5Mtyyh0BBa6KEmKAHTAyHg6V1OnRkoibRB1KtUoNC+WxV4YN7j?=
 =?iso-8859-1?Q?phT2Dg1NGANfnZIdzwLC+3NLoIOYYgZEbLEALYFGcrL4DAKA9uV2ap13Ba?=
 =?iso-8859-1?Q?M6AClmM4VOpBzk/7lcdjLgstxOu/VaHrcsJIjB0UGtGWILty15Wyqu7PLv?=
 =?iso-8859-1?Q?+pe5P4NJlnt5xbzxbD7jhiJ3tSqQ201ITOJdALR8baQt/NqlmGkS51lmaB?=
 =?iso-8859-1?Q?QOebnSROhtHk7lAO5vjcN/XEdRm9RLrUpzcC5sNZVSERHBlTvxm8ZBq5/s?=
 =?iso-8859-1?Q?S2zFMZWGuE1Kz6g/ya/6LYmjQS1CuAwRXzEAWoWAsu5IlSOFBaMFfLXkz9?=
 =?iso-8859-1?Q?OyvI+nITqtDPSBMxjw8UxV33Dn35LmSfEq0clzIUzWOKUnYpIrBLiS1jQ1?=
 =?iso-8859-1?Q?RtddQkXnkIyq9BvTFfla0RdcfhipFJyomHZ9HKVLBeAOeBWSpjrtnpZKlo?=
 =?iso-8859-1?Q?3eHj+wcJP0c4ynvP9EOya/x02Y3QTqmzSNGYMgUdJuYWSePg2fB6kBc8to?=
 =?iso-8859-1?Q?es3V1wsVZ3I/b6XRgOUpqYrINOrmY7D2LLs8bkGRFanzoSCJi5FnZiYqft?=
 =?iso-8859-1?Q?6n/20buXmCH1xXwr66xjDzU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lC3/yx+hBZI1QK5/dRs0GhS3C6MIykbZ7IzBUxHIs5sxXUY4DINUoIuZZC?=
 =?iso-8859-1?Q?YQbc0r1d/OVrextVgBiXaUh1fVpDp+yJMne6dRl4m+H8oBJQ+RXuM9LZ90?=
 =?iso-8859-1?Q?gPoPXC9RuQAPduFd8Esg7O/9JNYewHvfV1pHxdnWoHnDUwakTCP6KWRAok?=
 =?iso-8859-1?Q?LnjSXuHb2czYmKF9VyO8JSFunefD2TFYZEnOFZIsY/TxUsOVC9o/ntyY0U?=
 =?iso-8859-1?Q?twnd/gBe8qYG9PtS5S916XIdrPjnKF+BpRpP9ZIqYsQDVidUGm21gLJZH7?=
 =?iso-8859-1?Q?LiX5nRuiJeEsCbA2Jni0Lh9xKN9jCVzuOK5QY88QpkVfAnM7K2abYn0X4d?=
 =?iso-8859-1?Q?5SMc7wInARawip0Z1OYaXcF7UmIuCeAsAUVx41SaNdHCHrvFoH+MhMjzV7?=
 =?iso-8859-1?Q?yw6rqJPavztipOhvygl5/yGYc42o4rBaXXQ5wqww8KaDceUmkKf8AUjzoh?=
 =?iso-8859-1?Q?bfFsF3Sf25hX2oTaonXj8TXW+hwrvjA+/QZXGUPKGYgn1LkipCobBi5BUt?=
 =?iso-8859-1?Q?YHPn38cma3GOZ42aQWgae2UTfttC9H3bR2pZ+AvlbbzLznb9Q+GVJAns80?=
 =?iso-8859-1?Q?7lVH0+HGRipfk9KOFQPorlczGhv0hK4uMvdVTVaYCYcfHnYr1xgI8QLrr2?=
 =?iso-8859-1?Q?eawDMEtMtb07lcHyngzkxz6t2KCkQyV8oEmm2Mtfa5ouJXirYg57EPQknD?=
 =?iso-8859-1?Q?vnh6QmD7wmof23zayWnnU48Akv+nLGkzwB5SdlzFKYwvJb6WBsQ+3cAY8Y?=
 =?iso-8859-1?Q?i0J7tT3eoqI+Zc+mB4bVY8maMS0GM7NyIG6vMoiKwWZQIt7gDJOP93hQDG?=
 =?iso-8859-1?Q?GKDNaMQ3LGTbydOvps5wgqfKxp0Lx6M7pYqvgq+NLjlNp52SkaLGGr6VTF?=
 =?iso-8859-1?Q?uKQnatEKd2e2KOdZQ5vTDWhO3WTYrIeyQwaH0/KyshhX3uzJ0x1tQys8Sx?=
 =?iso-8859-1?Q?98hbnNHwBj1kQJiNf92u9bt31qBqx05+RJJhTXtCbzTbj3qPG/hpC/gzjo?=
 =?iso-8859-1?Q?sMr+s2fzic9ZVEk86ocXv0yl9sLB/lWg0/8IwIZ2lObSR/JwOLZksASdsH?=
 =?iso-8859-1?Q?WI8u0ztsJG3VaSMGBqzRPYQyDxohrybaAJ/bZ5nTBWzvUKbABNA9s27SPT?=
 =?iso-8859-1?Q?6k8rlV66WZby2+uAMNxzKhgt0LEXBkVwdR5IIqStQJOKt611BDQlFu0P4I?=
 =?iso-8859-1?Q?C1o0QnOBbfID8qpZyKEUmY7Y28E28ZoEKsN7gQ/rv7oSMB9faj4QgqZFvc?=
 =?iso-8859-1?Q?fCaN5Aps0cjJ53yaodRH5g3Z8oa/3/K44tFBGx01+QRU2JdBON6sqLZYJK?=
 =?iso-8859-1?Q?3+t9xjFvDaW12zFjHqHPDSOfCW/IlVB+kX0C2hmmOWlrrhUhzOezDehI9j?=
 =?iso-8859-1?Q?kz8EKO4cgbX7/nlW750xB6eeVpxUW92apKBUVEETOG/y9vC+k1xjLNDTo0?=
 =?iso-8859-1?Q?W9Gr5UtPyrCx1uJt?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-6-msonline-outlook-24844.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7388.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c160fd11-5842-4b75-1a34-08df18c15b18
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 15:51:24.5603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8743
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

From b554858dc4f2c48be0d44e3c66ed781842365bd1 Mon Sep 17 00:00:00 2001=0A=
Message-ID: <cover.1790083445.git.arthur_liberman@hotmail.com>=0A=
From: Arthur Liberman <arthur_liberman@hotmail.com>=0A=
Date: Tue, 22 Sep 2026 16:24:05 +0300=0A=
Subject: [PATCH 0/3] drm/amd/display: fix NULL derefs on MST HPD and teardo=
wn=0A=
=0A=
*** BLURB HERE ***=0A=
=0A=
Arthur Liberman (3):=0A=
  drm/amd/display: fix NULL stream deref on MST DPMS-off=0A=
  drm/amd/display: skip destructive HPD verify on live links=0A=
  drm/amd/display: skip MST slot release if port is gone=0A=
=0A=
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c |  6 +++++-=0A=
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 14 ++++++++++++--=0A=
 .../drm/amd/display/dc/link/link_detection.c    | 17 ++++++++++++++++-=0A=
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c |  7 +++++++=0A=
 4 files changed, 40 insertions(+), 4 deletions(-)=0A=
=0A=
=0A=
base-commit: cf48bd0a46279f4607956cb17c71bda96ee802e3=0A=
-- =0A=
2.55.0=0A=
=0A=
