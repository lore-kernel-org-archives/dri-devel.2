Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14053606A326
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=KRjKOpH2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BCCA10F64A;
	Tue, 24 Nov 2026 14:11:39 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011014.outbound.protection.outlook.com [52.101.125.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6D6E10F64F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:11:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfZyY2Xica6ppewwmzrv2Xvc8hU4YUJx9ZpR+aAg9Gs4IsBDj/nkjBK9bwy4adShsQAJzygYbAvKVwkeo58smEImAYWmXg5mEt8Lv4QOc/H1swYH1M6/fC0u/GKGJdtjdCKrhFoXRWH1Stzrs443p7juDWgp+JcWCxu0fsL2u+RbGHGWtVjaykrlVUh5esHndoWyk5BEkxw2MYQAR2eJb98o0+P36/fidzVK8zLq5aKwDiJZLjV5CmJu8dfMo9UIzgDgkSduNcx3mi7dk85U3mHxrF1p685CdfjyDGHq330Or0438BuW0G80CgHnTczFnd4trr8lRZYf4XQSgAiCcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwU+40D0hD/YTKFtW8HY5zladqe1WYjA9TgD19mnTzA=;
 b=lmFfhWRmAqTD3o7Q4kpWQt5zNfFUOuccvgz/1nHz4OAu4WFlS3/3wd4hgWf1lw415lldUv6hrekayBMsL2+i2idO57b2RHYEB0ZtOTFiOkLZLNHbrHT0AfXdfdeMJaCcZNJ8XfUsj6PcnvW62rO7pBcyJSvj/Gp5+00r8xu+ZoVluXcXGkSGnZQKpHXjb/1WFT0EnysaRB9bHpAYfViuGlYWv+s0zVvW5CHqGjuMwYmiYek6aQbKZPf+0G6GhDD4IrPPVLi/XjGR1pRydSPhiStT98dl8u9a7AUh5PdAUEW3kVARDCNXRLGlg6/N/Dt/TQZrDgVkgu4s83Vtf5XJHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwU+40D0hD/YTKFtW8HY5zladqe1WYjA9TgD19mnTzA=;
 b=KRjKOpH2lxxT3KmSk1ZnZZrp6qrayXTi9ySvHxg7asz3cE3AEJ0gc+nCHIuZSC4GTbGlDcR1hRUQT6LzM9UBB+2VGgvt69IUyad9UhiQsZEX0mh9cqYTYuYzDxWHBPW+eCM52gFtzt1eFVwYED4AC/u3QxtinPh3nqRP/cxI+q4=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by OSRPR01MB12000.jpnprd01.prod.outlook.com (2603:1096:604:234::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 14:11:17 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 14:11:17 +0000
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
Subject: RE: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU
 instances in one DRM device
Thread-Topic: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU
 instances in one DRM device
Thread-Index: AQHdc2mQXc9YOQBvg02jmZuHcmeGVrc781HAgAE6mgCAABQz0IAADw6AgAABgjA=
Date: Tue, 24 Nov 2026 14:11:16 +0000
Message-ID: <TYYPR01MB6603D650B839F808ACBA811F86442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <e22a176720a38df652c7f7eabe27219da50f217d.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <TYYPR01MB660397C3B66F6EED53656B2086442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awV6pAtcSz8e9Q74@tom-desktop>
 <TYYPR01MB660334463EC01FCF06F7A9E586442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awWXLFAbDd_35Q-l@tom-desktop>
In-Reply-To: <awWXLFAbDd_35Q-l@tom-desktop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|OSRPR01MB12000:EE_
x-ms-office365-filtering-correlation-id: d6ead4db-c18e-4643-4c53-08df4a34ce27
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|23010399003|1800799024|38070700021|10067099003|11063799006|4143699003|56012099006|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: V7gmrYJ79sECEBys1dL6Ezf3H4oYbMlpmUGsFuNUhVDjn/Q+9Ln/6JE9fLMQnrHgbG8NkHS7rMN0rBJOsDRxaBKg9spee69T73LAwsGn7SH0/5Njx9ARKD2vHSvqRl7lJDi49DI3hsraIyYvWARWfsDOVRqYD6FYvlx5av1uRovkG0mD2okG552tUQyi5Rd1efw+YZx14Rlxr2VjQWE84IxsgCfeniteTCih1apGnobFXxCqpVD8y8/k6ZtTUwcTej66lkJNFCxTBpB1E8R3+SanQ/CFU2KIbFZk5QmJCnwIzn3IMDENJXmod5pnNgYf//OrnNCIVqEVqXSUSYLZJyaTBtm7GJfzCp9sG9lU38VlUXzI1Jpjn2L/+fosjrUVIEkAcejw7V6M6LnCs/NgqPbnpYYjhyTBPvjkivsJCZ6KiIDZFHXneGhzhVOxJHHOln6laiEftluAuRiZ7RLowN+EHbQnJU9q9J0hm0xodLl41EjHDiTYSYD/5Ke4AgRm/1/xSafHQHO6aYSbUCI4DQJJG9o8bDBuht1jCt6vP3mQWVRQMA9avKqx/xxS1njI2yyAMAgnY02+KFYGY1ne0jK56pvOw7YfQL7vtLA3wzOG4NjBPSsLVWq1t1tmAg3EWRDebbCBzxiAIz7k1717MGcfqn4VSaKNCMOw40R8qb/yHN3rX1P+KJ6T1o36BoHL7ZVtIzWRnK0h7wzhgX+qSNps5Y+FDYRe4pmBJ2Ihhb0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYYPR01MB6603.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ulF+OFkxIorIOPoM4wd3eg/PpgTezQtElJryp1b8pPwXYN8CsxKAycGpK/?=
 =?iso-8859-1?Q?ZPE9z4Fy2ICjZaE9fHFb/nYmvPNN2W7FLOppxOcqgQY3BAZnIj5C6gR4/a?=
 =?iso-8859-1?Q?KMoOBJeYB/+nHVUFLaGk0G+mzz4rSWGEG7LISucPlPBcdMKvi3XlCXf2VA?=
 =?iso-8859-1?Q?dgiYjaTwHsg0NNubsTKxkhOZW6E3TEL0X4p3d8iMd8mTnKjqn1q7G/+yea?=
 =?iso-8859-1?Q?U3GqJU07awORExDgcymK7cq8X3CgqERCWvP3JeFPoHCloWGi6cwjbAw9AR?=
 =?iso-8859-1?Q?gB4zeMtObo1hLdGNHrI1zR6ztftwP6WRCch1ZWXOx3I56INE8oG8murWnb?=
 =?iso-8859-1?Q?3U/ud3dOmV6qVNSBfZst7oiR6h9Iev3P0DnjS2IJ5luM4+qSc11e8OVVG3?=
 =?iso-8859-1?Q?M+pOXhHQJx4lh0/BFCH6lquye0iTiab2TZq9fpaxRkVo81mimGFKQDRr1G?=
 =?iso-8859-1?Q?ghKKzlsRglfvtLBWVwX+wuhLs+nQY669OVXYjL4TJdCvEi0vWHXUSs7n+g?=
 =?iso-8859-1?Q?+oo44ETro25c5BKSgX4yFJTnRJNmOtxgeHrHiwxmhA5xaD0AYW+AKyjuf8?=
 =?iso-8859-1?Q?uStyiaLWfooUU8jf0xEOjj1ubODo+sGfrGGvFpWqiXzG2V2xFbTYUGf+Fh?=
 =?iso-8859-1?Q?LjQdwyzf5bXYc8rTqO8mWKGcLBeU8sRgk4BWJWllqT5VKOBMaUyu+3IXhB?=
 =?iso-8859-1?Q?NVr9EeWwPrlAeJkwqdFpB0Y5lB+U6M3k4Az7SsPqCVuNqHUD9vJ+1sN+1a?=
 =?iso-8859-1?Q?h0NchKw+ZwS//aLXtbzgFIPIuX1hpTwRREVcKh/K+sUU+BCYSuilelsLdk?=
 =?iso-8859-1?Q?zORdZ+fTBhJUM10Flka9H6OK2sw5Y2escHd8RDeiFOsJE5BQT8UMJbQm+P?=
 =?iso-8859-1?Q?dc9TLf1M8y4wqlrGQIcbJJeW8/Zbp3JjPvu7t7d4nEdOEuLdc3kcpcsLiz?=
 =?iso-8859-1?Q?Pgmr3gonQ+tpDRX/jbXR7XJc2qQxnXCE/8azykRtRvJh1uBqwZRNsqAxex?=
 =?iso-8859-1?Q?7xkeLmzJFH2g4kmWTWBe2LNVH3FZfPS76/ihdgiQRfeCijBan8bfP+lmXo?=
 =?iso-8859-1?Q?dSU3Bj07PDueTKrBJetx/rIm5qia7Dsug2LX1Ej4Po61qh0j2S4AzOzMUo?=
 =?iso-8859-1?Q?tena9S8xd3uHFhy9oSkwks2OyXDufzcp4hp8yWRSrBA1HDCdMxZOiBZx6V?=
 =?iso-8859-1?Q?QwPbz6+K9dkfr8+f+pu7QIbuEkNsZl5h5v996W9qRhdcj0nlzS3Vw975EJ?=
 =?iso-8859-1?Q?xUjqch71rTAmdH4LUtdQy5uoauJdOFXFFDws0x/492/wJb0NxBU36aaDLt?=
 =?iso-8859-1?Q?z+jdPXMH+ek67foLnLndMbZz51ZK2OI1CeTQWD2WsU+0qIBjVu0pVQxDCN?=
 =?iso-8859-1?Q?edF6eruWDmJ6+bC2Dhskdz7B9kR90F0wMlXB5W/ENtEFye/hSf91Ume6Z/?=
 =?iso-8859-1?Q?l79Cu+3GdbIkFv0hKB6VDFqAfoOkYUxooKKkra+EDJ7Vsv3EJdt+yCbu6F?=
 =?iso-8859-1?Q?rGomj9Mhb/7Gh9kn6mbhPctjUSRoMgIWOGhHMU+mZimBWILk7ded7iqQqd?=
 =?iso-8859-1?Q?fPRM7bXqLhA15Bl4frkiP+tRgvqYyA1b8004PX6u8H0+nSFRk0tqiTNCSv?=
 =?iso-8859-1?Q?YxKAmvx3l4rzT3fjpKF6z1IevRHZhjwIwx2MAAobXkL3HZb4MWIT9bnv1F?=
 =?iso-8859-1?Q?Fm+is720CXueSiRw/9fzr31ao3c4XQxwo9LCszqxD/i4ucSLWsFp6MKbsp?=
 =?iso-8859-1?Q?pG4HEtXpiWsgUZaZDbo8bdX0GGEskhaNMwvhAuOpbjFTYDfRiq0iodn7PS?=
 =?iso-8859-1?Q?C0nQttL5zw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ead4db-c18e-4643-4c53-08df4a34ce27
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 14:11:16.7273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gmdsvISCP2FFhKtnEs6/sVhEu+xOD9xlYuvW133fagHWjBpYx+FKGzQqYdZ1qxwf+/aItDZHJJTdQgpqUFfuECGNNUD084RmwJJo2OwBSCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB12000
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
> Sent: 24 November 2026 13:59
> Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU in=
stances in one DRM device
>=20
> Hi Biju,
>=20
> On Tue, Nov 24, 2026 at 01:18:43PM +0000, Biju Das wrote:
> > Hi Tommaso,
> >
> > > -----Original Message-----
> > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > Sent: 24 November 2026 11:53
> > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support several
> > > DU instances in one DRM device
> > >
> > > Hi Biju,
> > > Thanks for your review.
> > >
> > > On Tue, Nov 24, 2026 at 07:47:04AM +0000, Biju Das wrote:
> > > > Hi Tommaso,
> > > >
> > > > > -----Original Message-----
> > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > Sent: 13 November 2026 12:20
> > > > > Subject: [PATCH v10 10/12] drm: renesas: rz-du: Support several
> > > > > DU instances in one DRM device
> > > > >
> > > > > RZ/G3E has two DU instances that share a single DRM device.
> > > > >
> > > > > Add an RZG2L_DU_FEATURE_COMPONENT flag and use the component
> > > > > framework for it. The first available
> > > DU
> > > > > instance is the master and creates the DRM device, the other one =
binds to it as a component.
> > > > >
> > > > > If only one DU instance is available, it creates the DRM device
> > > > > directly at probe time, as on SoCs without the flag.
> > > > >
> > > > > Set the index of each instance to the number of CRTCs already cre=
ated.
> > > > >
> > > > > Signed-off-by: Tommaso Merciai
> > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > ---
> > > > > v9->v10:
> > > > >  - New patch.
> > > > >
> > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 118 +++++++++++++=
+++++-
> > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h |   2 +
> > > > >  2 files changed, 115 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > b/drivers/gpu/drm/renesas/rz- du/rzg2l_du_drv.c index
> > > > > 93d59e2cf8a4..873586f2ef28 100644
> > > > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > @@ -7,6 +7,7 @@
> > > > >   * Based on rcar_du_drv.c
> > > > >   */
> > > > >
> > > > > +#include <linux/component.h>
> > > > >  #include <linux/dma-mapping.h>
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/of.h>
> > > > > @@ -14,10 +15,12 @@
> > > > >
> > > > >  #include <drm/clients/drm_client_setup.h>  #include
> > > > > <drm/drm_atomic_helper.h>
> > > > > +#include <drm/drm_crtc.h>
> > > > >  #include <drm/drm_drv.h>
> > > > >  #include <drm/drm_fbdev_dma.h>
> > > > >  #include <drm/drm_gem_dma_helper.h>  #include
> > > > > <drm/drm_managed.h>
> > > > > +#include <drm/drm_of.h>
> > > > >  #include <drm/drm_print.h>
> > > > >  #include <drm/drm_probe_helper.h>
> > > > >
> > > > > @@ -170,6 +173,7 @@ static int rzg2l_du_instance_init(struct rzg2=
l_du_device *du,
> > > > >  				  struct drm_device *ddev)
> > > > >  {
> > > > >  	struct rzg2l_du_device *rcdu;
> > > > > +	int ret;
> > > > >
> > > > >  	rcdu =3D drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
> > > > >  	if (!rcdu)
> > > > > @@ -180,9 +184,28 @@ static int rzg2l_du_instance_init(struct rzg=
2l_du_device *du,
> > > > >  	rcdu->mmio =3D du->mmio;
> > > > >  	rcdu->ddev =3D ddev;
> > > > >
> > > > > -	return rzg2l_du_modeset_init_du(rcdu);
> > > > > +	rcdu->index =3D ddev->mode_config.num_crtc;
> > > > > +
> > > > > +	ret =3D rzg2l_du_modeset_init_du(rcdu);
> > > > > +	if (ret < 0)
> > > > > +		return ret;
> > > > > +
> > > > > +	if (WARN_ON(drm_crtc_index(&rcdu->crtcs[0].crtc) !=3D rcdu->ind=
ex))
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	return 0;
> > > > >  }
> > > > >
> > > > > +static int rzg2l_du_instance_bind(struct device *dev, struct dev=
ice *master,
> > > > > +				  void *data)
> > > > > +{
> > > > > +	return rzg2l_du_instance_init(dev_get_drvdata(dev), data); }
> > > > > +
> > > > > +static const struct component_ops rzg2l_du_instance_ops =3D {
> > > > > +	.bind =3D rzg2l_du_instance_bind, };
> > > > > +
> > > > >  /* -------------------------------------------------------------=
----------------
> > > > >   * DRM device
> > > > >   */
> > > > > @@ -191,7 +214,7 @@ struct rzg2l_du_drm {
> > > > >  	struct drm_device ddev;
> > > > >  };
> > > > >
> > > > > -static int rzg2l_du_drm_init(struct device *dev)
> > > > > +static int rzg2l_du_drm_init(struct device *dev, bool
> > > > > +has_components)
> > > > >  {
> > > > >  	struct rzg2l_du_device *du =3D dev_get_drvdata(dev);
> > > > >  	struct rzg2l_du_drm *rzgdrm;
> > > > > @@ -213,6 +236,12 @@ static int rzg2l_du_drm_init(struct device *=
dev)
> > > > >  	if (ret < 0)
> > > > >  		goto error;
> > > > >
> > > > > +	if (has_components) {
> > > > > +		ret =3D component_bind_all(dev, ddev);
> > > > > +		if (ret < 0)
> > > > > +			goto error;
> > > > > +	}
> > > > > +
> > > > >  	ret =3D rzg2l_du_modeset_init_finish(ddev);
> > > > >  	if (ret < 0)
> > > > >  		goto error_fini;
> > > > > @@ -235,6 +264,8 @@ static int rzg2l_du_drm_init(struct device
> > > > > *dev)
> > > > >
> > > > >  error_fini:
> > > > >  	drm_kms_helper_poll_fini(ddev);
> > > > > +	if (has_components)
> > > > > +		component_unbind_all(dev, ddev);
> > > > >  error:
> > > > >  	/*
> > > > >  	 * Don't use dev_err_probe(), as it would overwrite the probe
> > > > > deferral @@ -246,7 +277,7 @@ static int rzg2l_du_drm_init(struct =
device *dev)
> > > > >  	return ret;
> > > > >  }
> > > > >
> > > > > -static void rzg2l_du_drm_fini(struct device *dev)
> > > > > +static void rzg2l_du_drm_fini(struct device *dev, bool
> > > > > +has_components)
> > > > >  {
> > > > >  	struct rzg2l_du_device *du =3D dev_get_drvdata(dev);
> > > > >  	struct drm_device *ddev =3D du->ddev; @@ -254,6 +285,83 @@
> > > > > static void rzg2l_du_drm_fini(struct device *dev)
> > > > >  	drm_dev_unregister(ddev);
> > > > >  	drm_atomic_helper_shutdown(ddev);
> > > > >  	drm_kms_helper_poll_fini(ddev);
> > > > > +
> > > > > +	if (has_components)
> > > > > +		component_unbind_all(dev, ddev);
> > > > > +
> > > > > +	du->ddev =3D NULL;
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > +---------------------------------------------------------------
> > > > > +--------
> > > > > +------
> > > > > + * Component master
> > > > > + */
> > > > > +
> > > > > +static int rzg2l_du_master_bind(struct device *dev) {
> > > > > +	return rzg2l_du_drm_init(dev, true); }
> > > > > +
> > > > > +static void rzg2l_du_master_unbind(struct device *dev) {
> > > > > +	rzg2l_du_drm_fini(dev, true);
> > > > > +}
> > > > > +
> > > > > +static const struct component_master_ops rzg2l_du_master_ops =3D=
 {
> > > > > +	.bind =3D rzg2l_du_master_bind,
> > > > > +	.unbind =3D rzg2l_du_master_unbind, };
> > > > > +
> > > > > +static int rzg2l_du_instance_probe(struct rzg2l_du_device *du) {
> > > > > +	struct component_match *match =3D NULL;
> > > > > +	const struct of_device_id *of_id;
> > > > > +	struct device *dev =3D du->dev;
> > > > > +
> > > > > +	if (!rzg2l_du_has(du, RZG2L_DU_FEATURE_COMPONENT))
> > > > > +		return rzg2l_du_drm_init(dev, false);
> > > > > +
> > > > > +	for_each_available_child_of_node_scoped(dev->of_node->parent, n=
p) {
> > > > > +		of_id =3D of_match_node(dev->driver->of_match_table, np);
> > > > > +		if (!of_id || of_id->data !=3D du->info)
> > > > > +			continue;
> > > > > +
> > > > > +		/* The first available DU instance is the component master. */
> > > > > +		if (!du->is_master) {
> > > > > +			if (np !=3D dev->of_node)
> > > > > +				return component_add(dev, &rzg2l_du_instance_ops);
> > > > > +
> > > > > +			du->is_master =3D true;
> > > > > +			continue;
> > > > > +		}
> > > > > +
> > > > > +		drm_of_component_match_add(dev, &match, component_compare_of,
> > > > > +np);
> > > >
> > > >
> > > > The master=A0is chosen purely by DT order. If the first available D=
U
> > > > never probes, the second never gets a DRM device. How do you handle=
 this case?
> > >
> > > All available instances are part of the component match, so the DRM
> > > device is only created once all of them have probed, whichever one
> > > is the master.
> > >
> > > This is how the component framework works.
> > >
> > > To use a single DU, the other one can be disabled in DT, in this
> > > case the remaining instance becomes the master and initializes the
> > > DRM device on its own.
> >
> >
> > Assume both DU's available and run time
> >
> > second DU is probed first and master never probed at all.
> > What is the state of second DU as bind never calls?
>=20
>=20
> The second DU probes, registers itself with component_add() and stays idl=
e, without touching the
> hardware.
>=20
> When the master probes, both instances are bound and the DRM device is cr=
eated.
>=20
> If the master never probes, there is no DRM device, because the bind is o=
nly triggered once the master
> has registered the aggregate device with
> component_master_add_with_match()

Not sure is it the normal use case? DU0 and DU1 are independent devices

1) DU0 or DU1 should work independently irrespective of the probe failure o=
f
   other device

2) When both DU's are probed, then we need to aggregate the device using co=
mponent
   framework so that use case like dynamically switching DSI0 to DSI1 can b=
e achieved.

Cheers,
Biju

