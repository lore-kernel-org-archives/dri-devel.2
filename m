Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51236606A689
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=MsBBygqU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A1A010F56C;
	Tue, 24 Nov 2026 12:51:29 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011014.outbound.protection.outlook.com [52.101.125.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F08C10F56C
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:51:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0JgaacK8WUMV0SeZsJInn2IaFJjLtLLkySut7JhaAO+CMQr2CS7BLgz9B1szEX++9BbdfncgAzu+yJe1eyrB4WPDAVbEaK4zhUvBF0Yiy1LrBNKDxMO0pY3bsBhviomtdsMhe323jxYa6pOS2VyPqLiLQbruYoxkqCkKAVDZUb24NTM+jpTek2RBEq/Q9TMmw4irhyZw7E5dBu31XYccyAVrJPKnjiZT4S26MEfxnHGuoWCjcy0fIQerNtdSXU3Z4rIOUrBGp3e1BsXAWOsJTq8hF3J3K13qKI7j3PK+szLp51FkCfxjBcn0e8+Z2w3eH1w2Sxnh7Kz32wB2+S4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rozjt1/ifSK53gHZpzMdccZ3i4gpOnzll+aS8uOQDGg=;
 b=TulOhLiko3W4f43wTLu0uOW0vGF0Wu3Ao7R6cAT/QF0tfZXnIGb3CLVp9xZcnhSlY7UD+/X9ZHPQJH9NoYNtadsY3ISLTTB2b9fCp+pvjMWaFOwWJQtlIIMMttQBs/bCJOsQLBwbZJR9ye2/VnUOvSxZwBZ9kOf6ot3BI7CKSjAYYAPCbmnc0dinc/Shr2tEMcaDMUx09iclb5ASZHywX+Pbx0HCENozmkQQ5GSuvDIcpbvOmPloL7EWBibqungWzN/RoiXTnHA8ol5zxYJ1+0snXivTCRLdiz+iZ8/igVbiBfWjVcJSGCxa+jXxHV/4OPUWa56rNd41EHXSXp8AWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rozjt1/ifSK53gHZpzMdccZ3i4gpOnzll+aS8uOQDGg=;
 b=MsBBygqU2yxNgUz0htm4YtOw/hwo4ghOEK+2NPkO+3ghsfs4uW1UfOkMAyYXpTo0AUPTalmN4+B3+CEbFdtLnefDBBE4qonVusaZchdFj2ONqYCoY83aXR5ybz13SRHzfYVfctPWpHycC9lpUxVKNByPLpVaOXUUqIXK+VsfkYk=
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com (2603:1096:400:e0::9)
 by TYWPR01MB9885.jpnprd01.prod.outlook.com (2603:1096:400:224::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 12:51:18 +0000
Received: from TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f]) by TYYPR01MB6603.jpnprd01.prod.outlook.com
 ([fe80::145b:b854:162:2e7f%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 12:51:18 +0000
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
Thread-Index: AQHdc2mHvfvfxGybKU23d8MzJCmRZbc78H6ggAESzwCAAALngIAAKXaAgAAOCVA=
Date: Tue, 24 Nov 2026 12:51:18 +0000
Message-ID: <TYYPR01MB6603A1FB28A473A400A2C49386442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <68fcf838eee14c1906f23b2b7c74c560793cd1d4.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <OS3PR01MB65968FEBCB08429F11188CE986452@OS3PR01MB6596.jpnprd01.prod.outlook.com>
 <awVW5B4p06FUfBHw@tom-desktop>
 <TYYPR01MB6603AA1B7A48B7D899604EE586442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awV8G86QIth4GtaA@tom-desktop>
In-Reply-To: <awV8G86QIth4GtaA@tom-desktop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6603:EE_|TYWPR01MB9885:EE_
x-ms-office365-filtering-correlation-id: a23f73ef-cd3a-48dd-90a0-08df4a29a244
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|261102123227099003|261026140227099003|261026121527099003|261022075727099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|11063799006|4143699003|56012099006|10067099003|38070700021|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: nrZ1LT7BzGybvkCDfh/CDb+wjUFt6gxyKLuDCv9juqPUtM3I7Zuu57qghg+YCv4DYTJl8xOJVaY6xefqJCAsN7cn3kt6cOa9ZTXNgf7DiSB+djJF6M3Djoq/iRSgjhrkayodAJkWRTm7rB1j8StXOwBvT5VWWgHYwjuUaWLnxWv9Cb7uwMMUFmY2rx86xvmOBvYJNZdBIGgvmRaIBs8nPpMKLHJvp4QulaUXxKunu6wiQEbYyasPXfjeNEPVhzFIC4PyaFROc38ddbyv0atmYJeCfMmVGJqTfZPeGVrcLWM4RGg4UvvI3dwDqYyhliA/9dw/QFZiQa3CfOuLA3Q53GYkiCVibDHdvYK16qYBGVPFgLhFvnNe3iN5ye8SM04eWuh1CRduM36tcsF+V7Uqlh8m8+20JmsbxSZTAVZ8rQd1fB9zbaaegpnsxfBs7jsyEd0rS8q6uW1e4UDSBOz0J+8Uw4ZUMDebjEGCWSHkhwNacxc0SgjzmZqXWqIRzASVZacRsxmxYeYLin/a9whjiK+0S/Qiwg8Efptm5hTkf8oQxpIL/K0CoESNZincxJ/IqrahLCDCU981gmAXAwkMfchWDwxIciZ1bpH9p7+QF6sPDbFw58XULyLgo0GGbLwg2GbvIu3eXUj4R+PB7peimH4bhEb2fxWJbN+FSmRwz/9zjNp6/1JFvGxatR9Q32ptVoks30eYzCMfiiKguclvt3vdzTm2Ez3+W3KcLz6ZbOM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYYPR01MB6603.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(261102123227099003)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(11063799006)(4143699003)(56012099006)(10067099003)(38070700021)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9BDcRuyW+3Rj4nta64Nt8ItHSRkYxe8tdPlUW7iUhICHQ9LqqnViOxAogKGm?=
 =?us-ascii?Q?YOBxF0zM61z2j4KIviAeklVCwMEChwCnVVtdjW6KkaiTCeYabQFlgFkd+lqz?=
 =?us-ascii?Q?RJOuMhkbjUnZrL8Gmr4dNqxH7Ji4sWyOSzYQ7dQbTg+kCOp998dBwDaTjdzZ?=
 =?us-ascii?Q?a8mcnl1rSzZkzSmLHiv+WPNfX7WXmIys1Wb6XOIHU+7a1rtt0QRwxY2rqOau?=
 =?us-ascii?Q?OE8qKPeWW2dv1mtKkwAzQ5tcvftjgDldfZyzwqWnAgnc1ha4qTZmiX8vYC1q?=
 =?us-ascii?Q?CCcQUrLC4wCXBmy2Ci9v3cwjNTWb1KeRQKfQO7Fff5hcQAMQ3ifuItHmO8H2?=
 =?us-ascii?Q?ZPaY/+I6GUuvxwZClufhYZ3Bh2kgjCgQnydIAxC0EhyrgI9eGmIrXi92Bmgk?=
 =?us-ascii?Q?DZKE2tORT9iirncdQvdkI9JM132He/NBTt/760ThlbWWNT3IMHtzhu0cr8Yf?=
 =?us-ascii?Q?nPp2FXn+U42/IuLCnkFGQL9rrh90HMtDq7wNzTde26adEPkbd+Ujm3gsJRmk?=
 =?us-ascii?Q?GYDkmPkf9BGt6zwY677vt9OF4L4/M3JufPtOKYSYxxgcxU7q5Ip5uO34FDZ4?=
 =?us-ascii?Q?1YYTHCDk/YUVB4ekrgbpPMpfHZCj1jcBOgHOY0E1v7xnFl/FaIFxVM/dvhUn?=
 =?us-ascii?Q?Rnhn9nac12wxtGNsaIXwkr82lQFXGsKjYZqmh4F95OcbB7yJZrBxhkSzkgeH?=
 =?us-ascii?Q?xgGd7FDHZ3uRkUQ/pV57zRypkYwv9KMpbPg6NPHp10FzSRGIz+Mt6N9H4dRE?=
 =?us-ascii?Q?+lbx6lTuLqnglXDNmJ7hVHp3wyngEqAjy0t+F/JwyqgpNsTofzrMj7zN8ztP?=
 =?us-ascii?Q?xvvCfshMcyqzR4LhlCThZyBJJT0t3GbLRIErMTKUV8wlIDD2XXr9DhCLhEz4?=
 =?us-ascii?Q?JycCGjuY4GdWCvavm3+PmNVJLbN0K+Jt7red2VN5GWn5RlFhZpiYrXtyOhDY?=
 =?us-ascii?Q?/tNy5K/H+Xl9JMK1zSDlU/JHch0dk1fpvGewC0h7s1WFP+96TFRqXLwSekqI?=
 =?us-ascii?Q?/Xqdeic+kO9nejA5SjljPWy0sThHyNDPyNJB4GdGQ67j9VsMpQFiT9Cy6xVT?=
 =?us-ascii?Q?8dchu4AV5RcvzWoRh7nUGM2qiWEf3vps9L2qSffi2ZrRwrJ2R6EPNqiS3jqf?=
 =?us-ascii?Q?qsTYwrgR0JrYzdZlCsJLH8hr0jC3+MR6wGX1Nhs9qLe9qgyfZpuASyJi4r7m?=
 =?us-ascii?Q?lDELtfmgFP56ZZuroyzEDfvJoDA6smdMFODdxvKwiZVi5b5BTqiXWfdy96rq?=
 =?us-ascii?Q?1lBOJ3hc9dDR0i384Sz0BuGzpeZrC4JyI4u2uY+IqWEPSMM83XD4IwIVJt/E?=
 =?us-ascii?Q?qpY+84vBsVSq/7tRB1cWZPk0P1ld7l3JmrjPc1ot8EMjpO3/BbNWu4uQIWjm?=
 =?us-ascii?Q?2nzmQz+CYGkC/Ck/UF3R5AC7KIsH8JGrtIQao27+qMiAGl7PTyn9ofCxzDHn?=
 =?us-ascii?Q?OgU3vV6S/tYZf17WifJGDdUhePriodqxiNFvkBm7/3ckuMmugvZx5NTpP6fs?=
 =?us-ascii?Q?e09eMnUGdAQWd/YjbMxEiD47tj/cOwotDFuokYlSHl3TaPFPjuWAqVhdiPzO?=
 =?us-ascii?Q?fnBJSHNxgAWEa/YW4daCe6vWuTRLyohTP6uusSGCj11Qzeh5IDdfGWeipRmM?=
 =?us-ascii?Q?cgxaFAcwZ07ndfdGGoZtY+hfi5C4entNiOT5VZzAnTxCkgrh7sovHSgAZ0BD?=
 =?us-ascii?Q?ts9Bkg3L5gxBwy+qw0EUTxk397J2h1D8ffXVyDB8TQQZfnPPwI1O6oLvAzjR?=
 =?us-ascii?Q?I9wpwtS1KQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6603.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23f73ef-cd3a-48dd-90a0-08df4a29a244
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 12:51:18.5749 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WTb081BNDFNQpchNFFbYxXY5oBViT8hSiZqj94/+R0Gthme/MfHUYbuzvv8TGrpvarIDKefca5x5e7EeI6FRnKEm/XCmJ9Kr1KcvLMOdmhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9885
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
> Sent: 24 November 2026 11:59
> Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU insta=
nce from the DRM device
>=20
> Hi Biju,
>=20
> On Tue, Nov 24, 2026 at 09:33:13AM +0000, Biju Das wrote:
> > Hi Tommaso,
> >
> > > -----Original Message-----
> > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > Sent: 24 November 2026 09:21
> > > Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU
> > > instance from the DRM device
> > >
> > > Hi Biju,
> > > Thanks for your review.
> > >
> > > On Mon, Nov 23, 2026 at 04:59:32PM +0000, Biju Das wrote:
> > > > Hi Tommaso,
> > > >
> > > > > -----Original Message-----
> > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > Sent: 13 November 2026 12:20
> > > > > Subject: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU
> > > > > instance from the DRM device
> > > > >
> > > > > On RZ/G3E two DU instances share a DRM device, which can only be
> > > > > created once both instances have been probed.
> > > > >
> > > > > Split the DU device structure: keep the match data and the
> > > > > registers in a structure allocated with the platform device, and
> > > > > allocate the KMS objects with the DRM device in a new
> > > > > rzg2l_du_instance_init() helper, as they are released
> > > with it.
> > > > >
> > > > > No functional change intended.
> > > > >
> > > > > Signed-off-by: Tommaso Merciai
> > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > ---
> > > > > v9->v10:
> > > > >  - New patch.
> > > > >
> > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 61
> > > > > ++++++++++++++------
> > > > >  1 file changed, 44 insertions(+), 17 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > b/drivers/gpu/drm/renesas/rz- du/rzg2l_du_drv.c index
> > > > > d3cccbdf9012..d102876c07e1 100644
> > > > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > @@ -162,6 +162,27 @@ static int rzg2l_du_pm_resume(struct device
> > > > > *dev)  static DEFINE_SIMPLE_DEV_PM_OPS(rzg2l_du_pm_ops,
> > > > >  				rzg2l_du_pm_suspend, rzg2l_du_pm_resume);
> > > > >
> > > > > +/*
> > > > > +---------------------------------------------------------------
> > > > > +----
> > > > > +----
> > > > > +------
> > > > > + * DU instance
> > > > > + */
> > > > > +
> > > > > +static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
> > > > > +				  struct drm_device *ddev)
> > > > > +{
> > > > > +	struct rzg2l_du_device *rcdu;
> > > > > +
> > > > > +	rcdu =3D drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
> > > > > +	if (!rcdu)
> > > > > +		return -ENOMEM;
> > > >
> > > > Why there is duplicate allocation of rcdu? One in probe() and here
> > >
> > > The two allocations have different lifetimes.
> > >
> > > The one in rzg2l_du_probe() is tied to the platform device. It holds
> > > what is needed before the DRM device exists and outside of the
> > > component bind (dev, info, mmio, and ddev/is_master for the master, P=
M and remove), as on RZ/G3E
> the DRM device is only created once both instances have been probed.
> > >
> > > The one in rzg2l_du_instance_init() holds the KMS objects (crtcs,
> > > vsps, lvds, index). Their drmm cleanup handlers point into it and
> > > run when the DRM device is released, which can happen after the platf=
orm device has been unbound,
> so it has to be allocated with the DRM device.
> >
> > Then there is an issue right, platform unbound will unmap mmio and
> > other data structures it allocated in rzg2l_du_probe()and drm driver
> > is using after that( Use after free Bug)
>=20
> Mmmm In theory no.
>=20
> The KMS part keeps its own copy of dev, info and mmio, and its drmm clean=
up handlers only drop
> references, they don't access the hardware.

Can you please make sure these variables set to NULL, after
Platform unbound?

Cheers,
Biju

