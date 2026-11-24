Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4A9606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=R9/0E505
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB62B10F3E4;
	Tue, 24 Nov 2026 09:33:26 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011068.outbound.protection.outlook.com [52.101.125.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9DC210F3E4
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 09:33:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHrIzPzxCAqIPvO1HunaoT5dg5CYj5adMrD/ZslFXrB1KkFNRG1NS7CEeuwodPIEa2JXKo7+Dx9ANL6Fsw3bMHDZHZUfuu/PuLM0i3YZZFNqhnyf00xtPoHVGcfl1Ep/WykZBgB95x8MfVzSBn0VDy/6tKU18qlFbb1nG0UH1mUuw0rIhKtwjzE4KhnvPRR8ONvl+rU1+I8PapTyWK79bs0z8kKbLaVoqjD6VAeHCx7uDXh1Qnfh8Tj7tnA8+8+PTcTp2DH+CArebLaUMZFR4u5t3UxWEAtQceDFrUI1Wn82v30Cl4rTybKp3FWZHOLrcH5A6IDjYkk5Eb7LAcjuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGJxNW5c8LP/xWB+Eze/8+iwB7Mp/NpgNXBTjuI8a40=;
 b=le8XfcaCgRp2NIzlAGhsSdshzSQr2xWTWv8nGCFPNe3l0ESbnY/M2DjWCtX7yjYlaXbWNQwYGqFdiGsB9iw71IDJPL6uuxTwRd8I1n4X0b8gZdDbrwSuE/AKCCOhW6n3q+E9m0R/0d2my3c7uKqFDckunpYdhyLsPmsBnRdnGuHjzcom3fUq2wzMi2r32EbEC6B+JpZ4bmVi2xkHy2v0zX3f1uM+EA23r343jyhdIsjeMnKhCGAJhnWHCTuqmVI79DUK8EpJCCHKGY6iEP+egkA1ifINuaBSs6sIfu9m1RfnNCF3Al4a+qj5h0gcw/T1SZ4e+gVq4pp37Ph0XBRqZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGJxNW5c8LP/xWB+Eze/8+iwB7Mp/NpgNXBTjuI8a40=;
 b=R9/0E505eoVId1HLfivAOAtjV2UOY5nv2B1IVtOI2ngRmUn5GlKlaAr4gLl0x4c5RQoS2acwBfJoMtmt0FugEWqrUd4XQyqHxNThA2mXA9MpJ4ClBGMwjzOJN1/5MNuAwQbFSbVClK8Rt6bP6G3uRa0EDLJQCe/R64vTbIRzm7o=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TY3PR01MB11560.jpnprd01.prod.outlook.com (2603:1096:400:375::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 09:33:13 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 09:33:13 +0000
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
Thread-Index: AQHdc2mHvfvfxGybKU23d8MzJCmRZbc78H6ggAESzwCAAALngA==
Date: Tue, 24 Nov 2026 09:33:13 +0000
Message-ID: <TYYPR01MB6603AA1B7A48B7D899604EE586442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <68fcf838eee14c1906f23b2b7c74c560793cd1d4.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <OS3PR01MB65968FEBCB08429F11188CE986452@OS3PR01MB6596.jpnprd01.prod.outlook.com>
 <awVW5B4p06FUfBHw@tom-desktop>
In-Reply-To: <awVW5B4p06FUfBHw@tom-desktop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|TY3PR01MB11560:EE_
x-ms-office365-filtering-correlation-id: 8d5e8d07-ec09-4401-869f-08df4a0df643
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|23010399003|38070700021|10067099003|11063799006|4143699003|56012099006|261021121427099003|261022105027099003|261022075727099003|261021123027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|18002099003|22082099003;
x-microsoft-antispam-message-info: RnnGetbb4UuzcIIVQtJSMnZzGM0scH5ekIbGbN4hNol+uW8REbvNoLTN6zaeCDSqn96PP+yInftqaA9HL/3Ukz8YuPrBoKAiXaH/da9snq3S7sXYDor/UBHeSZDzcpi9lo9gE5o+UluIQWfSHiG02TW8XnsSaVs2u9HdoMlYF1w2IWzTfQM1DPOakT0zlVT4L33VVJYoPL1tUq3hdQedf4LJzwPji75Zsc6Qd0Ty/pNU8vAy/jhHTQNbctZ0Dp3dF9wGbBNInVk285PGxl6RxkbCArZXdoDBuUED8dwjsr+TNl6Abnv8Q4MxM5vAqIvjuM3WrcB6BgQ4Amo7ENCMeN9G3cmxx6T91Um8hjKUJGH44y0her4e1qKTlQNhtCFuD79MeP5RHsqil/dH1hiuPi5P96Xfh1Ni+G//zdPTBNwKB1CJucp5ivf2u4C7P6oix809YYlqYEwr+rXXwJN0sh3vEn109Ho2iEzB56eKw6ajtKhcdzF5tbV//flcduQtHz0y+RtC+d0DqH11/M+zMILmNaA51MX3sJBQ0vnNWGb7PtpS7qtW1m6QVQAzDnpTXQ8M7G5xU3ab53LDbsCw1OCsYCz3yxpNiZxfNYdQbt8/hcMDv8vgjPBCEdoyo4V/OiOPmecNPfwFiKkQXe8c1RuklajeNOEs5C2EIzRyLD0GTjVM/9d9KL9mN0OdWf99prOPOEplsE4CYZDxvH/OvRm9BNYD8SZA+qhi7mlNIsQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYYPR01MB6603.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4kajit7li8TPfActacLDprj2Um1hWQPjvqK2SXzis6kud7GStVdvE8carqdX?=
 =?us-ascii?Q?9g3t9HuJ1hOLGIr8G+tDxf4SbWozahgRR891Gd4fTQKSlhzBPbed/F8O2Oo+?=
 =?us-ascii?Q?iwKL/dH1ExlKuakR115lVvJcToGqLYvCREmZMCHmTl5PhtCsEQdAkpqRA+np?=
 =?us-ascii?Q?LrRiQ0yu39YVFvfBRXFBLp3rZRHeZQrS6cv4wHCNn7OFLsmBndSjK6nphpri?=
 =?us-ascii?Q?F00XHwywMc+7DjKOLdgRyI2hGEPjQ28ZXw+vaLGrBgmDY60kAOHm77l1ZiDE?=
 =?us-ascii?Q?hJFJxHZLUao9cssQPHxyWxvi+mzsyWxQEJcEpUeGjY4cuxQrU8FsPsXIoXNi?=
 =?us-ascii?Q?qAMGuldb6SjqJhDta5Vpc83jo94aVwOuYIQTHW0MwzyuBergNT7fwPXDGxwz?=
 =?us-ascii?Q?35d0CwNQY0khwdyHNXdgNGB2S8/12GlL/hD2E9xq13H4UJJA03UWZOoOAkrP?=
 =?us-ascii?Q?YDOWuag4UOZO6yz4AQ/iHvWoMPjS6L2lx32+XWvVq/e3QJ2i9WbM5WCq8J/O?=
 =?us-ascii?Q?3tAgzrPSQdfNmqeh34Qf0f7Rp9gwzNoMMEEslypkh3lhNsgeB6kinlmW1Itl?=
 =?us-ascii?Q?hYpws6o58RlM2mSSmGEDJn8gMsOzRnsH+9q/ejDzPaB4dyf0JYi+BlfqbPFv?=
 =?us-ascii?Q?HUM+OOJIHaXC7VWboQTGAEsfxTEKovTxF7eFgScPBUDKUVfl/hiIfZtFSZEx?=
 =?us-ascii?Q?BBxk9itX8ohcl42ujcohqPPlMyAwiNJErOIqqlAi+UF4Q3fEB+p32o+XhcYf?=
 =?us-ascii?Q?bCILtzTynBwTeuTDcb6m2q8HJ1E04hhXcaMxYkRohBxuzkl0kSJOsnnOz+5q?=
 =?us-ascii?Q?rd8DlxI7bMEiBDYeZM1uQHM7Djlo+YhI5jTcwjuN11HsKO4CwdTG+AX/OS1H?=
 =?us-ascii?Q?wm6f50gwChoByhCn1oJUPCIoaYzCBQhzBlWgp7GleqKFkmCJ70O4G8T9r7XJ?=
 =?us-ascii?Q?x5z3j+3/e/gSaQOtdXCR+fdeUDnBgfJy0OtRFxV6+XeLvxz1tdC0I68yd5rb?=
 =?us-ascii?Q?FA51zkmKOxVfr+m7pFfsl7sddBwPLTf4utOLUzALMdSe692wxa0GZWPgf9+V?=
 =?us-ascii?Q?ui1PP4RPBSFIkP1ko8iNMEc195XsUbIZ/gmJsXvYnW2mzaqwwY43/cFtzrx7?=
 =?us-ascii?Q?uW2JQTz6/5jm7anZJdwHWj65u9Su9ugDDfXqR5U4R/HI54/yPdq6RItXVlUY?=
 =?us-ascii?Q?X2NTUUu1I3qbO3asOpO9TxKHAIseFIsGRfcklj+pd0G3cqBWM9roLJU92vYk?=
 =?us-ascii?Q?iTBV8yj/q2z/oRTNj9OPHFUR718qjMKBMQ4+KWxV5+pr+FA3UNiBwHfWBG/h?=
 =?us-ascii?Q?4H0bI5aFnwoNlwYS95Nl7RwwLTXqnMv4XweuT/FAP6hnQ7scy2AKwGnbCF7l?=
 =?us-ascii?Q?clQali+jbUBbCIhBKXO0jrap1W7fIOIfpUGEe5j0LPfYvCoWhgYPGVg6dXnB?=
 =?us-ascii?Q?LqscrHJ6WJjKPz7txTRDVwXjqlgYdK9TYUMgPzo2xa9voYaA8GiIlyY4O+9b?=
 =?us-ascii?Q?f0B7Ba7emxAnueKlqMXfZTZATz4CsSVrESqnqa9WLykkIDEPFUc6qUgycpTw?=
 =?us-ascii?Q?UkAZm2u9YsGfJP1bvFh42hZNDdJEBFtgP+5IWUOQpLSDjwFHkJZuPYCtWDgn?=
 =?us-ascii?Q?Ssxc1tku/jqYVkmS1lecd+NFwujUwGldErTrguvtJTIysfFfjwFlVZsj6VEG?=
 =?us-ascii?Q?gPutvm7tMjYO7E3hYIE/fFqzVpOWi3z9dA2avZkcEfEedRA7RQo39PYGu97C?=
 =?us-ascii?Q?tYz+5ddEpw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5e8d07-ec09-4401-869f-08df4a0df643
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 09:33:13.6233 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5aACbGCTSM2syBMu0ij0lSudSrASaP3a5yMryhF8vpHJ9FPo8BtD9nYLF5etmbhcpyA64w0t624xqhDUwiupb0RhNfFarge4IektA6b3xJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11560
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
> Sent: 24 November 2026 09:21
> Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU insta=
nce from the DRM device
>=20
> Hi Biju,
> Thanks for your review.
>=20
> On Mon, Nov 23, 2026 at 04:59:32PM +0000, Biju Das wrote:
> > Hi Tommaso,
> >
> > > -----Original Message-----
> > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > Sent: 13 November 2026 12:20
> > > Subject: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU
> > > instance from the DRM device
> > >
> > > On RZ/G3E two DU instances share a DRM device, which can only be
> > > created once both instances have been probed.
> > >
> > > Split the DU device structure: keep the match data and the registers
> > > in a structure allocated with the platform device, and allocate the
> > > KMS objects with the DRM device in a new rzg2l_du_instance_init() hel=
per, as they are released
> with it.
> > >
> > > No functional change intended.
> > >
> > > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > ---
> > > v9->v10:
> > >  - New patch.
> > >
> > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 61
> > > ++++++++++++++------
> > >  1 file changed, 44 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > b/drivers/gpu/drm/renesas/rz- du/rzg2l_du_drv.c index
> > > d3cccbdf9012..d102876c07e1 100644
> > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > @@ -162,6 +162,27 @@ static int rzg2l_du_pm_resume(struct device
> > > *dev)  static DEFINE_SIMPLE_DEV_PM_OPS(rzg2l_du_pm_ops,
> > >  				rzg2l_du_pm_suspend, rzg2l_du_pm_resume);
> > >
> > > +/*
> > > +-------------------------------------------------------------------
> > > +----
> > > +------
> > > + * DU instance
> > > + */
> > > +
> > > +static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
> > > +				  struct drm_device *ddev)
> > > +{
> > > +	struct rzg2l_du_device *rcdu;
> > > +
> > > +	rcdu =3D drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
> > > +	if (!rcdu)
> > > +		return -ENOMEM;
> >
> > Why there is duplicate allocation of rcdu? One in probe() and here
>=20
> The two allocations have different lifetimes.
>=20
> The one in rzg2l_du_probe() is tied to the platform device. It holds what=
 is needed before the DRM
> device exists and outside of the component bind (dev, info, mmio, and dde=
v/is_master for the master,
> PM and remove), as on RZ/G3E the DRM device is only created once both ins=
tances have been probed.
>=20
> The one in rzg2l_du_instance_init() holds the KMS objects (crtcs, vsps, l=
vds, index). Their drmm
> cleanup handlers point into it and run when the DRM device is released, w=
hich can happen after the
> platform device has been unbound, so it has to be allocated with the DRM =
device.

Then there is an issue right, platform unbound will unmap mmio and other da=
ta structures it allocated
in rzg2l_du_probe()and drm driver is using after that( Use after free Bug)

Cheers,
Biju

>=20
> Thanks, Tommaso
>=20
> >
> > Cheers,
> > Biju
> >
> > > +
> > > +	rcdu->dev =3D du->dev;
> > > +	rcdu->info =3D du->info;
> > > +	rcdu->mmio =3D du->mmio;
> > > +	rcdu->ddev =3D ddev;
> > > +
> > > +	return rzg2l_du_modeset_init_du(rcdu); }
> > > +
> > >  /* -----------------------------------------------------------------=
------------
> > >   * Platform driver
> > >   */
> > > @@ -190,44 +211,48 @@ static void rzg2l_du_shutdown(struct
> > > platform_device *pdev)
> > >
> > >  static int rzg2l_du_probe(struct platform_device *pdev)  {
> > > +	const struct rzg2l_du_device_info *info;
> > >  	struct rzg2l_du_device *rcdu;
> > >  	struct rzg2l_du_drm *rzgdrm;
> > > +	void __iomem *mmio;
> > >  	int ret;
> > >
> > >  	if (drm_firmware_drivers_only())
> > >  		return -ENODEV;
> > >
> > > -	/* Allocate and initialize the RZ/G2L device structure. */
> > > -	rzgdrm =3D devm_drm_dev_alloc(&pdev->dev, &rzg2l_du_driver,
> > > -				    struct rzg2l_du_drm, ddev);
> > > -	if (IS_ERR(rzgdrm))
> > > -		return PTR_ERR(rzgdrm);
> > > +	info =3D of_device_get_match_data(&pdev->dev);
> > > +
> > > +	/* I/O resources */
> > > +	mmio =3D devm_platform_ioremap_resource(pdev, 0);
> > > +	if (IS_ERR(mmio))
> > > +		return PTR_ERR(mmio);
> > > +
> > > +	ret =3D dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> > > +	if (ret)
> > > +		return ret;
> > >
> > > -	rcdu =3D drmm_kzalloc(&rzgdrm->ddev, sizeof(*rcdu), GFP_KERNEL);
> > > +	/* Allocate and initialize the RZ/G2L device structure. */
> > > +	rcdu =3D devm_kzalloc(&pdev->dev, sizeof(*rcdu), GFP_KERNEL);
> > >  	if (!rcdu)
> > >  		return -ENOMEM;
> > >
> > >  	platform_set_drvdata(pdev, rcdu);
> > >
> > >  	rcdu->dev =3D &pdev->dev;
> > > -	rcdu->info =3D of_device_get_match_data(rcdu->dev);
> > > -	rcdu->ddev =3D &rzgdrm->ddev;
> > > -
> > > -	/* I/O resources */
> > > -	rcdu->mmio =3D devm_platform_ioremap_resource(pdev, 0);
> > > -	if (IS_ERR(rcdu->mmio))
> > > -		return PTR_ERR(rcdu->mmio);
> > > +	rcdu->info =3D info;
> > > +	rcdu->mmio =3D mmio;
> > >
> > > -	ret =3D dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> > > -	if (ret)
> > > -		return ret;
> > > +	rzgdrm =3D devm_drm_dev_alloc(&pdev->dev, &rzg2l_du_driver,
> > > +				    struct rzg2l_du_drm, ddev);
> > > +	if (IS_ERR(rzgdrm))
> > > +		return PTR_ERR(rzgdrm);
> > >
> > >  	/* DRM/KMS objects */
> > >  	ret =3D rzg2l_du_modeset_init_drm(&rzgdrm->ddev);
> > >  	if (ret < 0)
> > >  		goto error;
> > >
> > > -	ret =3D rzg2l_du_modeset_init_du(rcdu);
> > > +	ret =3D rzg2l_du_instance_init(rcdu, &rzgdrm->ddev);
> > >  	if (ret < 0)
> > >  		goto error;
> > >
> > > @@ -243,6 +268,8 @@ static int rzg2l_du_probe(struct platform_device =
*pdev)
> > >  	if (ret)
> > >  		goto error_fini;
> > >
> > > +	rcdu->ddev =3D &rzgdrm->ddev;
> > > +
> > >  	drm_info(&rzgdrm->ddev, "Device %s probed\n",
> > > dev_name(&pdev->dev));
> > >
> > >  	drm_client_setup(&rzgdrm->ddev, NULL);
> > > --
> > > 2.54.0
> >
