Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EC7606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=HRDJ4b3+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6294B10E149;
	Wed, 25 Nov 2026 07:28:28 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010006.outbound.protection.outlook.com [52.101.229.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0410810E149
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 07:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fk+NyLtVbrIfAy9qBnq8+eea9vmlBM7lB2F+bNpFNTKtbg5yvXNqFuMGicAIrzTmPOxoycOl9f46CpH1tJm7QNEiw4QgGx8HQsTCjAZjqGMW/hKu7EqNjzinrZTpzGvYlVSUr82L1EOitUXPmkCggFFVoeCgfNuvJBPYgPi4s8wXXztr9IDnlqOqAmY+Oor3RC5mfQcwvGhvwJpdlnhsdtkwRVWHoy6L74/lKiDKe5DFKBc2cmxBGmBU7BcJ6xhu1ZSk/OEm9X3km34vc20D8jjaMTyjmfnf03KTUBZVROJU0sxrOPebLHFdCe6A+pp8Fiu8NF2onWajFwAXcDvHxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0NQSTqIom/R+Fw4NXBRGY7WWHeIjq89gXNE0EmU+jQ=;
 b=N0AoesZP+HIN0P61RLzBVPYe8B3VVt9aAazi0do+f5aymu/g/0+0+GwfGVoLZMf1ZoObnC4znWL+KEC6V78r31mASQ6L6nGzLqJRzVPZ8foosNukweqABW7DzkcsDTqDQbPcSBsCbeysWYSvURgnPD8K+21IayfXvAfO3ceDaUPgRTGGWIKYMAk/P+j0xjjWwFNtILN013j+BE8JT7PMSRlE8ub0DL/inj7T+U74flFRdcbc93EoZ3sua1t9zFfuIfGJE6eUG4DqQZjEK8mWLRjTOeU5um7elsGPyowY4QTq76iCLPRr/WZIPLcR2Y99i0Rg6jCSwb3r+NlTJtpCTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0NQSTqIom/R+Fw4NXBRGY7WWHeIjq89gXNE0EmU+jQ=;
 b=HRDJ4b3+Gfq7UWfJF5yrFvc1B4dw3jZsXR4cg0fv6VjWXARoY/+O+fzYWNbohKnvKF3V2jrPdHfjEmbEVqVymg4y7UUMappn1UYgnyWKhGhOuHmy+itePj1cRFvIsxgaI4sEnMX5LFdAPQC0dOyeQ8FS63JTVCqzWVzh3QyhZa0=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TY4PR01MB14004.jpnprd01.prod.outlook.com (2603:1096:405:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 07:28:18 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 07:28:18 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
CC: Tommaso Merciai <tomm.merciai@gmail.com>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 "magnus.damm" <magnus.damm@gmail.com>, Laurent Pinchart
 <laurent.pinchart+renesas@ideasonboard.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU
 instances in one DRM device
Thread-Topic: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU
 instances in one DRM device
Thread-Index: AQHdc2mQXc9YOQBvg02jmZuHcmeGVrc781HAgAE6mgCAABQz0IAADw6AgAABgjCAAA1wAIABElhg
Date: Wed, 25 Nov 2026 07:28:17 +0000
Message-ID: <TYYPR01MB66037146324486059A62A60486432@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <e22a176720a38df652c7f7eabe27219da50f217d.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <TYYPR01MB660397C3B66F6EED53656B2086442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awV6pAtcSz8e9Q74@tom-desktop>
 <TYYPR01MB660334463EC01FCF06F7A9E586442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awWXLFAbDd_35Q-l@tom-desktop>
 <TYYPR01MB6603D650B839F808ACBA811F86442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awWkwJTxdJV1owf-@tom-desktop>
In-Reply-To: <awWkwJTxdJV1owf-@tom-desktop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|TY4PR01MB14004:EE_
x-ms-office365-filtering-correlation-id: 493ec2b0-82e9-4826-09bf-08df4ac5acec
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|376014|366016|6133799003|261009223027099003|18002099003|22082099003|56012099006|4143699003|11063799006|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261021123027099003|261022075727099003|261021121427099003|261022105027099003|38070700021|10067099003;
x-microsoft-antispam-message-info: x+VtMBDbF8jr65oD2FsqplhaGlftN0mFcq0oiPZPBPfDw82LAyIbVEgQ45uj2kH0zWEGpYQHZ71b0zxxO55rj2PrkSorQTX6Q4VP4AbsZZ7ISjc9tVEg+vHItewO8F8DYltuhfI8pW+AiGE645flXcW3qGtazZ0PJ76pQlXwKjSA7RDqea/VtatvsT6F95iWXBVHWahyKW5QnQSEs1VdFy+TG5lAcyugnTRkq3WKtOei1yvpMKejH5t/FZjT0+5rzrRqaPDp+IzBSZKTFyU0jdmHoo/JK6M5x28cmBKup9tL574zE6C462AC0qNiuuN9/MSgC4u9uQFGDb8/+iJ+Zq31GF7BMHY876+B9xl3lirsCP7qIR4JjWMkvfA5GjbPlNGR9ikvD2I7uptHmTS1Ov1RBR/G/6/QL3E8RxNZwl4Y/qCS40abV65p862eDqCsMRX/+AOChiobL84dPentQpskxu8F87AEqVhU0A14thMo6tpztJY+kE8KIzmJhKdKXqz3Hq9tlzr4SLiX0pZ1t3IFy5N8fe8DkWzHn6nh/5LSBX4ZlPoENA5iux3AkholZ+A6QqsfeDbVM+aL4hBd3uuJtyh3Ck85SnT/oaEdOhxTNGPn9aWkE9Vx7R1hlF95NuCkqimOG5P0uM2+bHo1wgTermRWvs7bVX1K2E0umA/8rTjGS84f/2qED7uQtxWEEPfTNKd9Sw9GkulVo6pSag==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYYPR01MB6603.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(366016)(6133799003)(261009223027099003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021123027099003)(261022075727099003)(261021121427099003)(261022105027099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?59H63X5UC0psIRhXBD4qXJcPMjXJJYvPuUQSrTfrSjyoRLkudrR0N2gCLl?=
 =?iso-8859-1?Q?m3THo2ZvQleKyoU8aUduRqex6ns8oRo/8mUA+3xFP+bDXCai58/YMUkqq+?=
 =?iso-8859-1?Q?9KtGvjtRe3aGPt+GeF/834Mh+gR/HxowNh3Z1dn0ztvpekxID1wUB1Nmma?=
 =?iso-8859-1?Q?cpUok1GE2ZFs+pIqs9Iwc1ro4pbnkFWZOzy/u7fyu1slcoYdGqZrfanq6m?=
 =?iso-8859-1?Q?8OHJHrtQYo4Bq8mDoJcxTjvqTOlSIy08RMBZIiUz8ux91pri8U70WvXgwD?=
 =?iso-8859-1?Q?v//pHgKx54PyR6NMpQf8TTfC7q0o6cMbCZsaYHoVSPuYgOvuAHBx5s0/2d?=
 =?iso-8859-1?Q?iLpemNr2rQLVjt6ZuH+UdjWZWzajFY46s6+siQ7si739ov5nbi+V0iPQ9W?=
 =?iso-8859-1?Q?C/t3mBMkDJh4gH2LzNb8CP45HOCo0hsA/j+n3dOReGw66wXUhLRahO6G3L?=
 =?iso-8859-1?Q?0An+PsmSJKxJUcz/ElFzcj6PzSJ73RB4YIEdM4mPTvR0qOy8YiuD8/SDxx?=
 =?iso-8859-1?Q?kn11qEXTyTVvZHlmcYAU1HaSdpO2Gxqq9T5LBpEpFSbvT4S8GS4l2/ixAQ?=
 =?iso-8859-1?Q?BGt30uTcn+duFlioKIdpoPTQ/OVyHXJZcW4jVlBXdP+ybjlmEzw98F6hks?=
 =?iso-8859-1?Q?a1wuvde3ss/vh8fsbCw9KzuHQVSXfyvvgNEFq7SgAPXwKMvgykyUjhr5Bp?=
 =?iso-8859-1?Q?d8lAp/NkeVixc/DEIosxfkfdHzlxghvznv2Mwi2ENsvGLjNVjUcpXuEG9x?=
 =?iso-8859-1?Q?ccDWkyEMPH7r+wjK/YV96ZLbf0cZxY2MnfZa8vNpXYDnyh72WiCfwbFCVG?=
 =?iso-8859-1?Q?Upg+LWKRBFk12uf6c47A2z5o7dwm68VeafB8CImhtEQjGLZnAPJydKjevk?=
 =?iso-8859-1?Q?4UeNYd6SuP+jThhWQoSvnAqES6h48gdycBOF+3MFO9E/CnYo/B5labQyOq?=
 =?iso-8859-1?Q?WS3kN863gb6iWN6ZUC3G3/2LsCqHiYLeF2SiG8iAPvnM2Cgi0Lmjem7vSh?=
 =?iso-8859-1?Q?YzPI6thMolevwxOJ5rkD3SZDbcbovvYcYM64QDjgzbxB2d78wRjo6ih2Cv?=
 =?iso-8859-1?Q?3KbgTKKBqQtZ//ukLxhl0BOxV9FbyABePfmmLqLd+a3uFtxC4QKIO8tD8n?=
 =?iso-8859-1?Q?LgF9TCziKIVCd0exLLDnOl3imx1qruwB+pARrHdSw7JFVaUMeVECLiNa2L?=
 =?iso-8859-1?Q?yd3ilyb8EAO3ESCld9yGKM9ZNGUiL+96l0a85xmOMtv+dC/mAe7pP7SwGx?=
 =?iso-8859-1?Q?lJX8OMo93oZzoEqKJ9j2+jJ0x65ZYy7jLORuaROqKvWcKL2wT/Kj6l00AT?=
 =?iso-8859-1?Q?kEHGZ5j2CQIWCoDaPwtek/oWQ+gvwX4hn+AlQMOoyQ/jc1XkeJuucE9/iH?=
 =?iso-8859-1?Q?8TBvV9cJHReWLFES8zW8vRzxENfn1OIyBT0H1PV/mCTF9nvUYjO4pq+Llg?=
 =?iso-8859-1?Q?4nZBava0RbFHenDRqE+IUsBChLaCndfO1UxPxRdQw46Q5UaJUx/h/PiJGM?=
 =?iso-8859-1?Q?3aJT5PfjVXLlOu0BX9MrcA7t0qqDsGcuUT6BJNVt53Up5jKJcRaRXRABPp?=
 =?iso-8859-1?Q?vqxX8WqJDdm3rEymUfpzIfJu/aE/MzkC9lYRTwxHEqS6dtoiKldB6HLPA+?=
 =?iso-8859-1?Q?aq1NjNtIYpaIGDnR8YJTf59c56lYF7uHAg2Q2V+m/XxcwMlny1KxtXuDBa?=
 =?iso-8859-1?Q?NYztI36fUEPSXfSOe/cb3h5sjuJhuwmtkrzC5CitIbe+BnaSscS02cp4mu?=
 =?iso-8859-1?Q?l5j+DinwMeMz6WT8pVNqU5addwbzxXAcUqbtXy0E69j1AFBIa0l5Y1Vtza?=
 =?iso-8859-1?Q?Iw4vbj3u6w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 493ec2b0-82e9-4826-09bf-08df4ac5acec
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 07:28:17.9793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixD2INfbWV9MvDJybBnmRJ7wwstEvZ7mUHW6g5J79g9/L3OY6QBbeLcii+P7YguMl8O5s67tIDpUCe2zGBNWPkg+hhuiFzd1/t99C9ZiULo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14004
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

Hi Tommaso,

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: 24 November 2026 14:53
> Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU in=
stances in one DRM device
>=20
> Hi Biju,
>=20
> On Tue, Nov 24, 2026 at 02:11:16PM +0000, Biju Das wrote:
> > Hi Tommaso,
> >
> > > -----Original Message-----
> > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > Sent: 24 November 2026 13:59
> > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support several
> > > DU instances in one DRM device
> > >
> > > Hi Biju,
> > >
> > > On Tue, Nov 24, 2026 at 01:18:43PM +0000, Biju Das wrote:
> > > > Hi Tommaso,
> > > >
> > > > > -----Original Message-----
> > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > Sent: 24 November 2026 11:53
> > > > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support
> > > > > several DU instances in one DRM device
> > > > >
> > > > > Hi Biju,
> > > > > Thanks for your review.
> > > > >
> > > > > On Tue, Nov 24, 2026 at 07:47:04AM +0000, Biju Das wrote:
> > > > > > Hi Tommaso,
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > Sent: 13 November 2026 12:20
> > > > > > > Subject: [PATCH v10 10/12] drm: renesas: rz-du: Support
> > > > > > > several DU instances in one DRM device
> > > > > > >
> > > > > > > RZ/G3E has two DU instances that share a single DRM device.
> > > > > > >
> > > > > > > Add an RZG2L_DU_FEATURE_COMPONENT flag and use the component
> > > > > > > framework for it. The first available
> > > > > DU
> > > > > > > instance is the master and creates the DRM device, the other =
one binds to it as a
> component.
> > > > > > >
> > > > > > > If only one DU instance is available, it creates the DRM
> > > > > > > device directly at probe time, as on SoCs without the flag.
> > > > > > >
> > > > > > > Set the index of each instance to the number of CRTCs already=
 created.
> > > > > > >
> > > > > > > Signed-off-by: Tommaso Merciai
> > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > ---
> > > > > > > v9->v10:
> > > > > > >  - New patch.
> > > > > > >
> > > > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 118 +++++++++=
+++++++++-
> > > > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h |   2 +
> > > > > > >  2 files changed, 115 insertions(+), 5 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > b/drivers/gpu/drm/renesas/rz- du/rzg2l_du_drv.c index
> > > > > > > 93d59e2cf8a4..873586f2ef28 100644
> > > > > > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > @@ -7,6 +7,7 @@
> > > > > > >   * Based on rcar_du_drv.c
> > > > > > >   */
> > > > > > >
> > > > > > > +#include <linux/component.h>
> > > > > > >  #include <linux/dma-mapping.h>  #include <linux/module.h>
> > > > > > > #include <linux/of.h> @@ -14,10 +15,12 @@
> > > > > > >
> > > > > > >  #include <drm/clients/drm_client_setup.h>  #include
> > > > > > > <drm/drm_atomic_helper.h>
> > > > > > > +#include <drm/drm_crtc.h>
> > > > > > >  #include <drm/drm_drv.h>
> > > > > > >  #include <drm/drm_fbdev_dma.h>  #include
> > > > > > > <drm/drm_gem_dma_helper.h>  #include <drm/drm_managed.h>
> > > > > > > +#include <drm/drm_of.h>
> > > > > > >  #include <drm/drm_print.h>
> > > > > > >  #include <drm/drm_probe_helper.h>
> > > > > > >
> > > > > > > @@ -170,6 +173,7 @@ static int rzg2l_du_instance_init(struct =
rzg2l_du_device *du,
> > > > > > >  				  struct drm_device *ddev)  {
> > > > > > >  	struct rzg2l_du_device *rcdu;
> > > > > > > +	int ret;
> > > > > > >
> > > > > > >  	rcdu =3D drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
> > > > > > >  	if (!rcdu)
> > > > > > > @@ -180,9 +184,28 @@ static int rzg2l_du_instance_init(struct=
 rzg2l_du_device *du,
> > > > > > >  	rcdu->mmio =3D du->mmio;
> > > > > > >  	rcdu->ddev =3D ddev;
> > > > > > >
> > > > > > > -	return rzg2l_du_modeset_init_du(rcdu);
> > > > > > > +	rcdu->index =3D ddev->mode_config.num_crtc;
> > > > > > > +
> > > > > > > +	ret =3D rzg2l_du_modeset_init_du(rcdu);
> > > > > > > +	if (ret < 0)
> > > > > > > +		return ret;
> > > > > > > +
> > > > > > > +	if (WARN_ON(drm_crtc_index(&rcdu->crtcs[0].crtc) !=3D rcdu-=
>index))
> > > > > > > +		return -EINVAL;
> > > > > > > +
> > > > > > > +	return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > +static int rzg2l_du_instance_bind(struct device *dev, struct=
 device *master,
> > > > > > > +				  void *data)
> > > > > > > +{
> > > > > > > +	return rzg2l_du_instance_init(dev_get_drvdata(dev), data); =
}
> > > > > > > +
> > > > > > > +static const struct component_ops rzg2l_du_instance_ops =3D =
{
> > > > > > > +	.bind =3D rzg2l_du_instance_bind, };
> > > > > > > +
> > > > > > >  /* ---------------------------------------------------------=
--------------------
> > > > > > >   * DRM device
> > > > > > >   */
> > > > > > > @@ -191,7 +214,7 @@ struct rzg2l_du_drm {
> > > > > > >  	struct drm_device ddev;
> > > > > > >  };
> > > > > > >
> > > > > > > -static int rzg2l_du_drm_init(struct device *dev)
> > > > > > > +static int rzg2l_du_drm_init(struct device *dev, bool
> > > > > > > +has_components)
> > > > > > >  {
> > > > > > >  	struct rzg2l_du_device *du =3D dev_get_drvdata(dev);
> > > > > > >  	struct rzg2l_du_drm *rzgdrm;
> > > > > > > @@ -213,6 +236,12 @@ static int rzg2l_du_drm_init(struct devi=
ce *dev)
> > > > > > >  	if (ret < 0)
> > > > > > >  		goto error;
> > > > > > >
> > > > > > > +	if (has_components) {
> > > > > > > +		ret =3D component_bind_all(dev, ddev);
> > > > > > > +		if (ret < 0)
> > > > > > > +			goto error;
> > > > > > > +	}
> > > > > > > +
> > > > > > >  	ret =3D rzg2l_du_modeset_init_finish(ddev);
> > > > > > >  	if (ret < 0)
> > > > > > >  		goto error_fini;
> > > > > > > @@ -235,6 +264,8 @@ static int rzg2l_du_drm_init(struct devic=
e
> > > > > > > *dev)
> > > > > > >
> > > > > > >  error_fini:
> > > > > > >  	drm_kms_helper_poll_fini(ddev);
> > > > > > > +	if (has_components)
> > > > > > > +		component_unbind_all(dev, ddev);
> > > > > > >  error:
> > > > > > >  	/*
> > > > > > >  	 * Don't use dev_err_probe(), as it would overwrite the pro=
be
> > > > > > > deferral @@ -246,7 +277,7 @@ static int rzg2l_du_drm_init(str=
uct device *dev)
> > > > > > >  	return ret;
> > > > > > >  }
> > > > > > >
> > > > > > > -static void rzg2l_du_drm_fini(struct device *dev)
> > > > > > > +static void rzg2l_du_drm_fini(struct device *dev, bool
> > > > > > > +has_components)
> > > > > > >  {
> > > > > > >  	struct rzg2l_du_device *du =3D dev_get_drvdata(dev);
> > > > > > >  	struct drm_device *ddev =3D du->ddev; @@ -254,6 +285,83 @@
> > > > > > > static void rzg2l_du_drm_fini(struct device *dev)
> > > > > > >  	drm_dev_unregister(ddev);
> > > > > > >  	drm_atomic_helper_shutdown(ddev);
> > > > > > >  	drm_kms_helper_poll_fini(ddev);
> > > > > > > +
> > > > > > > +	if (has_components)
> > > > > > > +		component_unbind_all(dev, ddev);
> > > > > > > +
> > > > > > > +	du->ddev =3D NULL;
> > > > > > > +}
> > > > > > > +
> > > > > > > +/*
> > > > > > > +------------------------------------------------------------=
---
> > > > > > > +--------
> > > > > > > +------
> > > > > > > + * Component master
> > > > > > > + */
> > > > > > > +
> > > > > > > +static int rzg2l_du_master_bind(struct device *dev) {
> > > > > > > +	return rzg2l_du_drm_init(dev, true); }
> > > > > > > +
> > > > > > > +static void rzg2l_du_master_unbind(struct device *dev) {
> > > > > > > +	rzg2l_du_drm_fini(dev, true);
> > > > > > > +}
> > > > > > > +
> > > > > > > +static const struct component_master_ops rzg2l_du_master_ops=
 =3D {
> > > > > > > +	.bind =3D rzg2l_du_master_bind,
> > > > > > > +	.unbind =3D rzg2l_du_master_unbind, };
> > > > > > > +
> > > > > > > +static int rzg2l_du_instance_probe(struct rzg2l_du_device *d=
u) {
> > > > > > > +	struct component_match *match =3D NULL;
> > > > > > > +	const struct of_device_id *of_id;
> > > > > > > +	struct device *dev =3D du->dev;
> > > > > > > +
> > > > > > > +	if (!rzg2l_du_has(du, RZG2L_DU_FEATURE_COMPONENT))
> > > > > > > +		return rzg2l_du_drm_init(dev, false);
> > > > > > > +
> > > > > > > +	for_each_available_child_of_node_scoped(dev->of_node->paren=
t, np) {
> > > > > > > +		of_id =3D of_match_node(dev->driver->of_match_table, np);
> > > > > > > +		if (!of_id || of_id->data !=3D du->info)
> > > > > > > +			continue;
> > > > > > > +
> > > > > > > +		/* The first available DU instance is the component master=
. */
> > > > > > > +		if (!du->is_master) {
> > > > > > > +			if (np !=3D dev->of_node)
> > > > > > > +				return component_add(dev, &rzg2l_du_instance_ops);
> > > > > > > +
> > > > > > > +			du->is_master =3D true;
> > > > > > > +			continue;
> > > > > > > +		}
> > > > > > > +
> > > > > > > +		drm_of_component_match_add(dev, &match, component_compare_=
of,
> > > > > > > +np);
> > > > > >
> > > > > >
> > > > > > The master=A0is chosen purely by DT order. If the first availab=
le DU
> > > > > > never probes, the second never gets a DRM device. How do you ha=
ndle this case?
> > > > >
> > > > > All available instances are part of the component match, so the D=
RM
> > > > > device is only created once all of them have probed, whichever on=
e
> > > > > is the master.
> > > > >
> > > > > This is how the component framework works.
> > > > >
> > > > > To use a single DU, the other one can be disabled in DT, in this
> > > > > case the remaining instance becomes the master and initializes th=
e
> > > > > DRM device on its own.
> > > >
> > > >
> > > > Assume both DU's available and run time
> > > >
> > > > second DU is probed first and master never probed at all.
> > > > What is the state of second DU as bind never calls?
> > >
> > >
> > > The second DU probes, registers itself with component_add() and stays=
 idle, without touching the
> > > hardware.
> > >
> > > When the master probes, both instances are bound and the DRM device i=
s created.
> > >
> > > If the master never probes, there is no DRM device, because the bind =
is only triggered once the
> master
> > > has registered the aggregate device with
> > > component_master_add_with_match()
> >
> > Not sure is it the normal use case? DU0 and DU1 are independent devices
> >
> > 1) DU0 or DU1 should work independently irrespective of the probe failu=
re of
> >    other device
> >
> > 2) When both DU's are probed, then we need to aggregate the device usin=
g component
> >    framework so that use case like dynamically switching DSI0 to DSI1 c=
an be achieved.
>=20
> IMHO 1) and 2) can't be achieved together.
>=20

I guess we can achieve both use cases, if we define a companion property in=
 the second device.
This is a static design choice left to the DT user to choose between either=
 1 or 2.

Krystof/Rob/Conor: Is it ok to add optional companion property to support b=
oth
1 and 2? Otherwise, we plan to stick with use case 2.

Use case 1: 1 DRM device per DU
Use case 2: 1 DRM device for 2 DU's

Cheers,
Biju
