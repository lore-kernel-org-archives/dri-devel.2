Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92E4606A339
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 07:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=qt7Ucvl7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4045210E08E;
	Wed, 25 Nov 2026 07:07:21 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011042.outbound.protection.outlook.com [52.101.125.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE73810E08E
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 07:07:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gg7UWrhk9LTygnePALTXPcgyxt+aELoP/LgRIwOzOkNBDzs7iyyaJh/8oA3sfA8hgns1ERCM5DbkoaOTVSt+/gmmffkME6vBEdvIt39zeZgxhts7nsXJLOVf8udaJydTPJ4rJa/cAKjkwcyD+Px0TL3fEaXbrzBFlstYu8+g//e8lgQ7PHlVXCmZfNHvoce++KnsrY13Dq96hYwJr8tLkyw797EOqj5RoL+uIL/3sv7uwzNRF+2tiOrOed/3xs+gi3jedeaA47zNPdoYvpSVDSlLPtMjPAKy6i5phG60nNpKdkUfTH3ueqCf4IbfkWEtnqFfVDuGl/cVeFfeHPXdxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8ERCvElYiYFighdrAaE9mn7ER/svGyGDs/vSX9CIAk=;
 b=BmeLx87b4wXEMrFC7EUtUlqHQ/9eqpSxY7oaMV/OM9vEheWG0tZ828qW/G9l5DwgrSQ6uvRJ/mzM0ip6t0JtTHo1eBq5ZeF8p8InGiO5cmhy5dGkXPRSGOPSfYor71Y/Nk9qNu1C3+xt47zserOfbPEbzjN3CMLfqOGw5nLZ9R47plFQAvlbrF/vrPX1k73UkTY0qX6eduu+3+2U8jP9rVutDBNsrvQ2bEW8k29C1PHkQdSTmWOZyxqGspzTNDV8HtxV6u0IUMI9UqmjiZZ2/CP6k6VX5wVWzi9ZXIC00Uhg2V+gXKyIOhlxd3/KKbJ8kBaQtx2OVWur/jLZVansnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8ERCvElYiYFighdrAaE9mn7ER/svGyGDs/vSX9CIAk=;
 b=qt7Ucvl79ghIaiZEZ/Pt5H0XsJGbNKav0FCEklJ+tRH4WmGi+ABh5ahsyaBSpUA58Tq/db7vdNR2SoQyvR8vcRnVsxuScYVdJl/UWwLlrW9Gtu5lZwyFmBOcN+vlNV3vUi451pbn72m/xu1+rYCbbmvtuYnRhTOjGGcy5IoNbsA=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TYCPR01MB6785.jpnprd01.prod.outlook.com (2603:1096:400:b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 07:07:10 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 07:07:00 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
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
Subject: RE: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU instance
 from the DRM device
Thread-Topic: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU instance
 from the DRM device
Thread-Index: AQHdc2mHvfvfxGybKU23d8MzJCmRZbc78H6ggAESzwCAAALngIAAKXaAgAAOCVCAACsuAIAABMHQgAA0sICAAMXVQA==
Date: Wed, 25 Nov 2026 07:07:00 +0000
Message-ID: <TYYPR01MB660340BEF9704BB69FE150FC86432@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <68fcf838eee14c1906f23b2b7c74c560793cd1d4.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <OS3PR01MB65968FEBCB08429F11188CE986452@OS3PR01MB6596.jpnprd01.prod.outlook.com>
 <awVW5B4p06FUfBHw@tom-desktop>
 <TYYPR01MB6603AA1B7A48B7D899604EE586442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awV8G86QIth4GtaA@tom-desktop>
 <TYYPR01MB6603A1FB28A473A400A2C49386442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awWsGjt6cW_CSoMH@tom-desktop>
 <OS3PR01MB659637409ADFF9CFC2AD395186442@OS3PR01MB6596.jpnprd01.prod.outlook.com>
 <awXcSSnNeaOQFQZ5@tom-desktop>
In-Reply-To: <awXcSSnNeaOQFQZ5@tom-desktop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|TYCPR01MB6785:EE_
x-ms-office365-filtering-correlation-id: 4ac8ef4c-24c4-43ee-be98-08df4ac2b3b8
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|38070700021|10067099003|56012099006|11063799006|261022075727099003|261022105027099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003|4143699003;
x-microsoft-antispam-message-info: HW+0BoqQrGccnPfflBjDyIVxSxbhwNvhmYekCq30VrtCfJvq0vDiNCKZ5/Rbz8p/RJ2qAhgpQCYxhIWfWRzJUheQtDx8fbByyQgjt8JSIFrQEg7hbPV8StNSC3YselTykmar8EZwwBYG0eOLsY0vE6P4nKZOcUvkW9a7ME00by1Hm8l4cJuVjZsHBp4jFoCkdClLKh34zR07wD8bIKbO+7KCV7e+gccyiddfrKBS2VIBXAbNgnV1pWRIF286XOW3UECEWeLo8dsZvZGnZ5durzAdmxQklS0T+Uko2vI/z6c6foVkrSnANKS1nvGLnVh6Ox2gqWC6cOu4yxPmytzs7/wiT5yIVKanKV6F5hmuf1Uf6APFywO9flkxDbiBwcf9gAFNJZsi0Sftc9fPhLcppZG9AV0vjuTo575ECPiW7rln164CMJoo0VdSDFM8DXNzma2BvLqICCBsNf+i7bjvSwS0QjiKAh+W/L8Z7ass6MzaRroIYQWZ1czmVPO9ViNEY80obxXUEW4rwxadhKwTLQfEhE3GdkbJdr0L/Qcf5r7gL3KOKvtD8dXfLcbP6ekGGuKiWCHaD/bjq4GFqWu4uBqVf66lXBfqed7OGgRvHIlykk+AKV1CR5K6B0l6zuHm6PM4DcElUTjjpdY1pxNa/A3QHkGbtYE5N50S5jjen2UyuaDO49y/WQGWnoUlV7lXOmGrq0O39aEtHzlmHAD+xLQLqwV0vtm0ES3bq+3pTXQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYYPR01MB6603.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(261022075727099003)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+fXFZu2HR7vUDmp81kwIT19tcix7Z1W2q/1wC+3JjolZSyL7s4xXdjIBFzxX?=
 =?us-ascii?Q?QFHLmyS45+4r+uqMnd9WoIdMKG3ddi7MUf8B2lgU0AOlaVd/D1nF/FyRdW39?=
 =?us-ascii?Q?2QmRas1bQyUn8xELbWuiXanGWLBu36PRYWOvP379++33djD0xAXKXr67YGsd?=
 =?us-ascii?Q?H0KXQkJPAA2LKeTQG66Xg3JYd+s+iDCBFdgdZkptCZ1MTHjZPBPIL82gZM5R?=
 =?us-ascii?Q?szEpR4Ce19c4nCDTwtOoChIP38VJ1HgkAEW2txus/qsJTdkYOCXyh92W/t5E?=
 =?us-ascii?Q?eg0OF0+7rVGxHZJm1ooVzRGQziBo61zeZGn3o+UIDq9PRlOA/huwGZs32eIP?=
 =?us-ascii?Q?yO4j7FUWerWErNmjjsbIOMc45tOL9z4OCnJytIW4r5ygRGKiyziWHMP+VInj?=
 =?us-ascii?Q?3WePuwX7IjHVwQ454x3qZe8FulU5clnVRVvFJZwgMJRMdVCWYKlG4hVeWIHB?=
 =?us-ascii?Q?pI3sPx8NGiBc/gtmYNqokxET0YUNvC14uZY7lWiaoyMqL+YucvEHPvZsWjjI?=
 =?us-ascii?Q?Ow35QZm6w7iTTQSMxJ59hXlDwHewY5i2k/iODByhaUDxC9TF4Jxd2U0RgGiX?=
 =?us-ascii?Q?tFUkyuvtBWksL+rBFYjJJHPaB3ji0jNai7EZw+kyqewALgr+DPm40qCloMcq?=
 =?us-ascii?Q?JTNc6suEaMVw0pJESU0spfu6/TGRlHeivg5TK9ZkkcEQunxKrWSu54PiRZVs?=
 =?us-ascii?Q?TAz7qeVjAGtqTJp0ZfWekt2mnmzh7bm0wmQ7tIHm1kw9ui7XjbhaKeUUK8Is?=
 =?us-ascii?Q?5FmMm74ngZW2QFiwkj86z+X1sxAJvtKO6RbJKx/camvPqGKbnovKV3dmZyqh?=
 =?us-ascii?Q?nntgPOWoiGGbVQStFqqQzPEcqk4XrL1UlDocnqw+w7RhARxHdUuoWaceJ6eE?=
 =?us-ascii?Q?4KCBG6JVEKO3o/GY2oa8XB9N2qEC3exvxH/tY4RpvyEc2MCZolKRDDAhQrSt?=
 =?us-ascii?Q?2T90EL8RsVfAJC6bEb5JhL8fO7wqwRuto9iLxKjCKhybTa5lKwmhQ/S6Q1yj?=
 =?us-ascii?Q?uGogCTUHkMXi0p03IEJhkjk9pInCFVrv2/oR86dlJEIhipA3Whou+65Xrhgo?=
 =?us-ascii?Q?l8wgxbik3jb6SkrW2Vw6TGYYIk/Q+PgcJwXkDog/o15q+2bUUcl+0heQeEpa?=
 =?us-ascii?Q?QBUIR00v2wuHMEig/nvhOE1DZBNnMKygREXeNAABtZVdrUcaHtiPQEDfx8LJ?=
 =?us-ascii?Q?ANIhWjb51z7ZUxxGlj6Lzp/NxNAFiIeI0ueF0Bw/hbwPs7+LY5V5G1Yuo90x?=
 =?us-ascii?Q?e9yDNQ7hq/BwNsQqqbZMM30aGLAvLFSxeq+FMGaibUmmLHZPtrAFMv++eSQx?=
 =?us-ascii?Q?arLI2+tG6fmJQfSlDagCe/pmcSlS+wAgJYBhwVShT8ZsiWdXEA54wokf0OLC?=
 =?us-ascii?Q?70duC2kHq0y1j5MseXMANVrfMAmhl2BKXQdY7N5o5vsvhNPzcxQ/rvD9UMJT?=
 =?us-ascii?Q?VIjlST7jVQBJhq0arCdkxNzvjM4evq1mvlWNxbIwgLFsTPEh5maiFGho+bLH?=
 =?us-ascii?Q?HFxGSddDfwxc+QVwXFRDbJA0cdKlXjRrb4CS+dvHZzs0t3nkm1A2xKh7xDJo?=
 =?us-ascii?Q?Ycerr7RQNZin9QsPfjM17QE7c+S1O5j2McoVEBVDR+sCOga5wZHOF4o8eho6?=
 =?us-ascii?Q?zfT7HhOVD6saH53rBtss4nzxGndqbAlX1auO75DUmZ+g+UEhlpk0Gkskx5H6?=
 =?us-ascii?Q?9C9ZSJHTp6lSteh02sOOM0k3UoLPKW24z4UPKJKOolP22T+Arx241/yVtb93?=
 =?us-ascii?Q?1YlngaZFmg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac8ef4c-24c4-43ee-be98-08df4ac2b3b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 07:07:00.8642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xd2Nf2jo33gXK5ndN+eHumOIVVhpTbXR4WQm+Td5ndh9zWCsUMVMJVxebH+ONKBC9L0k1WP4g5PbLN7Vq+P1SLA1XRN6cJPWQiQhZo42jPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6785
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
> Sent: 24 November 2026 18:50
> Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU insta=
nce from the DRM device
>=20
> Hi Biju,
>=20
> On Tue, Nov 24, 2026 at 04:04:48PM +0000, Biju Das wrote:
> > Hi Tommaso,
> >
> > > -----Original Message-----
> > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > Sent: 24 November 2026 15:24
> > > Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU
> > > instance from the DRM device
> > >
> > > Hi Biju,
> > >
> > > On Tue, Nov 24, 2026 at 12:51:18PM +0000, Biju Das wrote:
> > > >
> > > > Hi Tommaso,
> > > >
> > > > > -----Original Message-----
> > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > Sent: 24 November 2026 11:59
> > > > > Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the
> > > > > DU instance from the DRM device
> > > > >
> > > > > Hi Biju,
> > > > >
> > > > > On Tue, Nov 24, 2026 at 09:33:13AM +0000, Biju Das wrote:
> > > > > > Hi Tommaso,
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > Sent: 24 November 2026 09:21
> > > > > > > Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate
> > > > > > > the DU instance from the DRM device
> > > > > > >
> > > > > > > Hi Biju,
> > > > > > > Thanks for your review.
> > > > > > >
> > > > > > > On Mon, Nov 23, 2026 at 04:59:32PM +0000, Biju Das wrote:
> > > > > > > > Hi Tommaso,
> > > > > > > >
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: Tommaso Merciai
> > > > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > > Sent: 13 November 2026 12:20
> > > > > > > > > Subject: [PATCH v10 08/12] drm: renesas: rz-du: Separate
> > > > > > > > > the DU instance from the DRM device
> > > > > > > > >
> > > > > > > > > On RZ/G3E two DU instances share a DRM device, which can
> > > > > > > > > only be created once both instances have been probed.
> > > > > > > > >
> > > > > > > > > Split the DU device structure: keep the match data and
> > > > > > > > > the registers in a structure allocated with the platform
> > > > > > > > > device, and allocate the KMS objects with the DRM device
> > > > > > > > > in a new
> > > > > > > > > rzg2l_du_instance_init() helper, as they are released
> > > > > > > with it.
> > > > > > > > >
> > > > > > > > > No functional change intended.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Tommaso Merciai
> > > > > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > > > > ---
> > > > > > > > > v9->v10:
> > > > > > > > >  - New patch.
> > > > > > > > >
> > > > > > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 61
> > > > > > > > > ++++++++++++++------
> > > > > > > > >  1 file changed, 44 insertions(+), 17 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git
> > > > > > > > > a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > > b/drivers/gpu/drm/renesas/rz- du/rzg2l_du_drv.c index
> > > > > > > > > d3cccbdf9012..d102876c07e1 100644
> > > > > > > > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > > > > @@ -162,6 +162,27 @@ static int
> > > > > > > > > rzg2l_du_pm_resume(struct device
> > > > > > > > > *dev)  static DEFINE_SIMPLE_DEV_PM_OPS(rzg2l_du_pm_ops,
> > > > > > > > >  				rzg2l_du_pm_suspend, rzg2l_du_pm_resume);
> > > > > > > > >
> > > > > > > > > +/*
> > > > > > > > > +-------------------------------------------------------
> > > > > > > > > +----
> > > > > > > > > +----
> > > > > > > > > +----
> > > > > > > > > +----
> > > > > > > > > +------
> > > > > > > > > + * DU instance
> > > > > > > > > + */
> > > > > > > > > +
> > > > > > > > > +static int rzg2l_du_instance_init(struct rzg2l_du_device=
 *du,
> > > > > > > > > +				  struct drm_device *ddev) {
> > > > > > > > > +	struct rzg2l_du_device *rcdu;
> > > > > > > > > +
> > > > > > > > > +	rcdu =3D drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
> > > > > > > > > +	if (!rcdu)
> > > > > > > > > +		return -ENOMEM;
> > > > > > > >
> > > > > > > > Why there is duplicate allocation of rcdu? One in probe()
> > > > > > > > and here
> > > > > > >
> > > > > > > The two allocations have different lifetimes.
> > > > > > >
> > > > > > > The one in rzg2l_du_probe() is tied to the platform device.
> > > > > > > It holds what is needed before the DRM device exists and
> > > > > > > outside of the component bind (dev, info, mmio, and
> > > > > > > ddev/is_master for the master, PM and remove), as on RZ/G3E
> > > > > the DRM device is only created once both instances have been prob=
ed.
> > > > > > >
> > > > > > > The one in rzg2l_du_instance_init() holds the KMS objects
> > > > > > > (crtcs, vsps, lvds, index). Their drmm cleanup handlers
> > > > > > > point into it and run when the DRM device is released, which
> > > > > > > can happen after the platform device has been unbound,
> > > > > so it has to be allocated with the DRM device.
> > > > > >
> > > > > > Then there is an issue right, platform unbound will unmap mmio
> > > > > > and other data structures it allocated in rzg2l_du_probe()and
> > > > > > drm driver is using after that( Use after free Bug)
> > > > >
> > > > > Mmmm In theory no.
> > > > >
> > > > > The KMS part keeps its own copy of dev, info and mmio, and its
> > > > > drmm cleanup handlers only drop references, they don't access the=
 hardware.
> > > >
> > > > Can you please make sure these variables set to NULL, after
> > > > Platform unbound?
> > >
> > > Please correct me if I'm wrong but IMHO this patch keeps the same
> > > behaviour as the driver before this series.
> > >
> > > Where rcdu is embedded in the DRM device (devm_drm_dev_alloc()) and
> > > mmio is devm managed. Setting the pointers to NULL would only turn an=
 invalid access into a NULL
> dereference no?
> >
> > Ack.
> >
> > But why you need copy? What preventing to use original allocated rcdu
> > in rzg2l_du_modeset_init_du()?
>=20
> The copy is needed because the two DUs share one DRM device, which can on=
ly be created at bind time,
> once both instances have been probed.

That is ok. Both DU's share 1 DRM device.

>=20
> Before this series, the DRM device was allocated in probe with devm_drm_d=
ev_alloc(), and rcdu was
> embedded in it.
>=20

OK.

> Now each instance needs its own structure at probe time (dev, info, mmio)=
, before the DRM device is
> allocated with devm_drm_dev_alloc() in the master bind, so it is allocate=
d with devm_kzalloc().
>=20

That is ok.

> The KMS objects (crtcs[], vsps[]) belong to the shared DRM device, so at =
bind time each instance
> allocates its own structure for them with drmm_kzalloc(), released with t=
he DRM device.

Why we need drmm_kzalloc() here? Can't we use pointer allocated with devm_k=
zalloc()=20
to avoid another copy?

>=20
> Each instance copies its own dev, info and mmio into that structure, as t=
hey are used by the KMS code,
> e.g. rzg2l_du_crtc_set_display_timing()
> (mmio), rzg2l_du_encoders_init() (info) and rzg2l_du_crtc_create() (dev).

Since each probe's DU allocates rcdu, can't we reuse same rcdu for holding
dev, info and mmio and pass the pointer to KMS code to reuse mmio,info and=
=20
dev in rzg2l_du_crtc_set_display_timing(), rzg2l_du_encoders_init() and
rzg2l_du_crtc_create()

Is the below code[1] does not work? Do you see any issues?

[1]
static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
				  struct drm_device *ddev)
{
	du->ddev =3D ddev;

	du->index =3D ddev->mode_config.num_crtc;

	ret =3D rzg2l_du_modeset_init_du(du);
	if (ret < 0)
		return ret;

	if (WARN_ON(drm_crtc_index(&du->crtcs[0].crtc) !=3D du ->index))
		return -EINVAL;

	return 0;
}

Cheers,
Biju
