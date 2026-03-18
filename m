Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7941410706E8
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 979EE10E7BB;
	Wed, 18 Mar 2026 10:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ZmjytHhE";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010004.outbound.protection.outlook.com [52.101.228.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8824F10E7B9
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 10:41:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHTPvSJYC3mynShT5gqvyUVcQWSO7JoHBcGxLqwVubz2iUzffwzxyfPPi/FhZ7Je2RPw1vz1/UVthBK/nerfeh9MLFzAkk6h5EpOXQaIpLk0cwmAGnoSmeibLCTFG9EnSglF0no1Awu6GBc2YfRveh69Owo8iUUFX4P8+G+JzVbi1G6ocQ91xUrnrtowpWv58dYZ+tU3CEeXcLYqBV46D0Zy48Fy3t61S1eo3oG8DmcuSOfdSvXR4ztoWGpc9nKAGxH1atGB6X7ew5vx5pk7VBQ4zjn3m8kup1jYIFxYOHjnJKO/TR7CEaesCbF8CgMa1O5P3QtVNPzfp1ABe8/ipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Yn9wMOkEhavetx6j81LIZjKd7IcVWLupAI0ilzCga0=;
 b=BqX+4NTdXR+lHWpeJim7Q00Rm1kBPqQnbdRl63ojbsULQ4jxf0gIw5ARipWrpb3neJF5PhO6fMiiJ9qOSquyYJnxcHamP39DqSgKee1de0Z4JDsFsYGTrMw3iupfk5cR3VlARl6sOfBhELCes6eIX8kl6HLI8/xj4kHNbFfyII1YOLWNdSKN5IlJ/hNv8uwmqr2/b7MoKvmpXgBoxQd69niBXCDP6g9V52QXjT/RhcuQpHBcW/nXB8XG+ojwPmB4mOIXBEEorS7kIA57j1MY1onbQ51BwKK/nkTchcDXJ8/Ha8DXUu9n2sMFQRLjGrbgSSz3pygHyWg5T8O9/djIVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Yn9wMOkEhavetx6j81LIZjKd7IcVWLupAI0ilzCga0=;
 b=ZmjytHhEdIae7gHMnJHvJ9dGNiEPaMwuM9CwNNVscA/yBt+eg9y4xDOconJ/af2/S4B8xq/OZ6Ps9z/Vj85M4V71nWueMb17jaqE62MbqDwO2ksbWGaWiM0Jyf3gp8S9f2vJ7ytax/PnSPV5sSIR+DD0KOzfyq4vUfDk25V/wrg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB15495.jpnprd01.prod.outlook.com (2603:1096:604:3bf::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Wed, 18 Mar
 2026 10:41:44 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 10:41:43 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Steven Price <steven.price@arm.com>, Boris
 Brezillon <boris.brezillon@collabora.com>, =?iso-8859-1?Q?Adri=E1n_Larumbe?=
 <adrian.larumbe@collabora.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, magnus.damm
 <magnus.damm@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
 <biju.das.au@gmail.com>
Subject: RE: [PATCH 0/4] Add RZ/G3L GFX support
Thread-Topic: [PATCH 0/4] Add RZ/G3L GFX support
Thread-Index: AQHcq92jqlOikktt60KW1zPKDVgZpbW0L7rg
Date: Wed, 18 Mar 2026 10:41:43 +0000
Message-ID: <TY3PR01MB11346576B64AA81E5E9E3D146864EA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260304134845.267030-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260304134845.267030-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB15495:EE_
x-ms-office365-filtering-correlation-id: 3e9476c6-b206-4d00-a73e-08de84daf279
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: ClPDazLyDL9qPYVKh+dURdNFH4z4oX7DEkzZLQ145AYcm4yskz577NYUZ9n+1ExX3y9q1a8y2J6KlZb1YzBsLfRgENCsGYSN3aG+9TqAF1+YlfVVkZ4NZhqrYW2K6dJn88ziP1ZE79swZBsJ/CQi9P1wSQjoqOe9J4FOSU4SjiER7dRE6xe9Ncvp0xIr8sO5u+j1xTnl083kxk7YwBINUKtWdBqvMzZ5kR2t/9FE66qcKyABPEORwlTgolIPlHL774xoA6swC84Y52wckVEemaLhRpt2Z1zQ9zVtD/rB2+6c6AjO2zA0l9Uoj/HNl60ZatFYtVSE3oyLeAMbji4K/RBOC4CZyOffxOeW4fJnMC1/xxBc/9uMsdcmAUQ/2kCXnwZDnHxEx8nS0JXEv7hu6WVvQoToc9vGOk5f6S71prxbLMF5C7kPkU+0etrnVUqsU5vMeNope0/p5KEDeDZD1I7CcZiOhspNxGpWg18MKSkLkOqrxwpd+A9/ijbXtjmE7U/TKNK8L1ibd/jeMdX8np20y5j5cUT05rS1w6nNVJd+A++7oO/HcKSgJCoLboZ9MfbIS4J/7KTRQ8nJHMr7LbwyzSyZlJchXfSNkWygjaZUsl4ek/Na1TX1osypT1z3zlGZ43F226MqqwgVlCTkMetPwwIOPfHoeAqT6JArM2/3tb9pyfUMKfb9RNj8zLvxbj0+4iw0SASpNaMHTaw13YV3zca9sBKO7SL1Up2Aw8JKnSH4I61xo7jT53vmYwxkM5AYm2gDR4ncwyexVihtnFNhbmmZX6Doji59Yw1jilh3NkS2EP5M3Hsnyj/tqAkb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ow4vumcY8UDU60KW5/igkmQt4ZBbfWHm5ClDzDggk0CDqPyyiqkH6qiRlt?=
 =?iso-8859-1?Q?Vrkahn9iYzIt5eka2UvRbVUKuVUgueJsAfmJ/FyqjcRRqwyQ2S+tbkpj4N?=
 =?iso-8859-1?Q?MmQgTm4yFTbP+I2I6PCgeAfd4vtt6FNS/M3AOIvqTDbxsW/3dSIdX3bIes?=
 =?iso-8859-1?Q?SueQVYocmpQB2ZhRIg1bDPVjuHAR7UpfqSSCFq1rZNT//0BiL1625mJBDZ?=
 =?iso-8859-1?Q?ugUrqOulC8x2TYvOYspvDnhbbiHGq3gJSlY/SaH3132cJe3OxvGsmho7yR?=
 =?iso-8859-1?Q?EGqFrBGQnF1+2yfvprzmasTdGY0X1kmyW5Ugl6R5oDkuyjHgYduU46nvbM?=
 =?iso-8859-1?Q?+kKKnXZGwwviBQKYkBPRx29exseX2VTf/aDDViq58dDL3r2q802i5boQQu?=
 =?iso-8859-1?Q?PiFYu7B9UeFnRLWzO+u1I6ihzfwgtaeFKc/q2VAuwX2iA3okDgYZWBsfOf?=
 =?iso-8859-1?Q?CYN5+NxPE+zITc2k0Fa4qZbMaQEV+Yp6Vf1nf+JTOLhzzX8yQjACtML4Zv?=
 =?iso-8859-1?Q?s8kJ6lIed/BG8IW066WlfGlyjw+1HAzZOwoNGPdzBNRv2sW6MrjIOw8KNb?=
 =?iso-8859-1?Q?Dd46Nvi1hka5mtOxuvPkpqqYNaS5Yk5TZsufydmZVpqvO5FTYL57MK5/OM?=
 =?iso-8859-1?Q?1ziHmvFDc7G51f5TtB9+G2vcAsc5qYrBDqBKcQcobudVfXzN66FqhY7lfO?=
 =?iso-8859-1?Q?wh8plj3aSsVTbj+/OhOCPTh2h85wm6d/PA26HKkuEZjdr2KSu9sK6eCgaY?=
 =?iso-8859-1?Q?EgxVbH7PxyKl9ESpy6opbrhde8IVWbARewKNBJ0sGhIiUyCSc3ALon5BWz?=
 =?iso-8859-1?Q?3RT3cQ+S1jSZIG0eh788OCOqArNIyWIRHXo+y4VcezROLzzm27E/61683j?=
 =?iso-8859-1?Q?2qHwxSx9+G5TNmA+4rKdd/m//6uD6MH03fTfeZ0gNVnyhmhri0v5dij5Ik?=
 =?iso-8859-1?Q?IWvZUFiPOHHmhBXvfMmyyS99HLXkwgPKZT8nGMnP4/m4kVV2IgRPouIthY?=
 =?iso-8859-1?Q?bqT1uf17SpWbCl3CDVkorPvUZEUQKtSKQs2W9N/VS1O6vzaqOAAkV0c2Am?=
 =?iso-8859-1?Q?l0aBrSigJB/yUJv2XN/d4F8BVhUF7bKdR+scRuUCcOmZZqufvRIsvsvZ96?=
 =?iso-8859-1?Q?uF4teK2ZmZGxFhWm4h3OIlosfVMJDbwabCFZV/VVgXpdMAx+Yzuo1rAiW4?=
 =?iso-8859-1?Q?8TP1Qee0tWQdSELx/boCGkgkauToJhugUg/KI36OaPVLT8wh7aSaf75tp1?=
 =?iso-8859-1?Q?g2TdO5pFFfwV3L6LRmGPx/AyHvKh+cZ+rXKsE/6F0QheF47RDTdTw1jC4l?=
 =?iso-8859-1?Q?rb6F/wk7tDGQ9R2X7q+HbLpuGzQcsLkesVLe5O1hJsL6yP9oIYo1bBQyP/?=
 =?iso-8859-1?Q?FtqlpadajUVfJa+P9TfIV0raHqC7iFgPvqvirVaZrxEHhwbp8hwv+ffwXD?=
 =?iso-8859-1?Q?K/rxWyrsu+7togDbyjfsGveZwguMg7t2vb5GEsUDQOHGQhOx6CDgezytWP?=
 =?iso-8859-1?Q?1EST7m0TI7s2cUmG/KWM/7T2Ki/BgaqukEgvbCUcGKzke2PaMMAexIFsn9?=
 =?iso-8859-1?Q?8ufgK2BQeLnC19IowW8kDp6N3MNR04l3QL+fniHSaDxbbejXLI3gJirVAU?=
 =?iso-8859-1?Q?QnX1lLvvpxav5sDNlurk49q8Y/P4mNkm4rMh81kM+u4bWPQLUstT/3nDVt?=
 =?iso-8859-1?Q?797pyXHM3U3yNWBYqwW+YO+/yH591KtV43DoWWwUj8EkJnAT6hI5l+FRCh?=
 =?iso-8859-1?Q?fTWQmSfH4Hu8NPuxCjfqRI6aZi1+54ieNX0aKk3JTetajD0b+otadqGl6r?=
 =?iso-8859-1?Q?zRFzCz74rA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9476c6-b206-4d00-a73e-08de84daf279
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 10:41:43.8849 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EFbtUt4X94T5dUS9Do4+BgX9qNU+SaGJVCYIfynAkc0W7jn0zZSsLuWzbLrpEBjW+TugiICKKImoJqdGsxuO0MioL+Nh6xT00iRXAK61DqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB15495
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

Hi All,

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 04 March 2026 13:49
> Subject: [PATCH 0/4] Add RZ/G3L GFX support
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> The Renesas RZ/G3L SoC includes the Arm Mali-G31 GPU as a 3D Graphics Eng=
ine (GE3D). The Arm Mali-G31
> GPU is a graphics acceleration platform that is based on open standards. =
It supports 2D graphics, 3D
> graphics, and General Purpose computing on GPU (GPGPU). Add the binding a=
nd driver support for
> suspend/resume functionality along with some improvements in panfrost dri=
ver.
>=20
> Biju Das (4):
>   dt-bindings: gpu: mali-bifrost: Add compatible for RZ/G3L SoC
>   drm/panfrost: Drop redundant optional clock checks in runtime PM
>   drm/panfrost: Add bus_ace optional clock support for RZ/G2L
>   drm/panfrost: Add GPU_PM_RT support for RZ/G3L SoC
>=20
>  .../bindings/gpu/arm,mali-bifrost.yaml        |  2 ++
>  drivers/gpu/drm/panfrost/panfrost_device.c    | 36 ++++++++++++++-----
>  drivers/gpu/drm/panfrost/panfrost_device.h    |  1 +
>  drivers/gpu/drm/panfrost/panfrost_drv.c       |  1 +
>  4 files changed, 32 insertions(+), 8 deletions(-)
>=20
> --
> 2.43.0

Gentle ping.

Cheers,
Biju
