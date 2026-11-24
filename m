Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A276606A322
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=fmGGiFTS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7201B10F508;
	Tue, 24 Nov 2026 11:59:52 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010009.outbound.protection.outlook.com [52.101.229.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E160E10F512
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 11:59:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUN6/LHj6D98F5UB1GkMOPWncQ4thHdoGqvln008LDig8B2R6wJkIQhCFltty1+clXZ8egL7Wc8H66WJ58ad2NaRpKYn3v0wH/EUqoM6XsOVIKRbgBVs7qjI+2jt3gXVE4Rlb4BWd+6tYty/fWt6cEqtV5CtI//ymw34gzAwJ9vmOD+PqO/WHtnCFK0pMjf45bNcyb2Zoz2x0J3hDGKv5FRHHaY9ovYIIBKAtCS/LvNoZO+rQvYF3tzxsL3NNIV/nwQlMVIWClU0DSP35NqJ45bSLbpktLYyVYUeQ+FJZu4tW+1OO4IFNRtBxOopkhrgqXkeQR2/CqDOYSTjiouogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkQ7O4ci2DO+2OuuLaZzYN6eFECYXykIeXfRK7Rpi3g=;
 b=YTlSyEsK4cQmn0dXVWbfNNnoTUjFeVSoLUoltEcGyIvuy9D9fivQ9CZZdPnm4Gio/B3JoTqNuXxTc+eg2DtWDyYdw0uuFZKPgufiDlp5lAeCTJ0YPPteCkGVs0osavXul5e4NaL5lDSEIJJcLHOczIR6FgngIzDGZ8ykEmSFNyLRY6suHvbl3twlI1fJIGdEo5oeouz1cdqDUbodnymdTQAdamwTk2ivGg6EJ8IFsMxuEEaKUjDBwN9QcHOIa2xyXXt423KlNw58KNY3sGLV9bbrpFOe/ajDgFXpxbfXNTYjtFfwM26XIs0gRd4ePCv8YI+CFIyBKVsuCeodrE+p2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkQ7O4ci2DO+2OuuLaZzYN6eFECYXykIeXfRK7Rpi3g=;
 b=fmGGiFTSZjyAl/B0/O27qJ8LM+fWVcdR0C+DrdBF+hO+s02q899PRxwDTfVReA59vTPnlQDUBdAfWmnjiTc37/wFjgfDsUeFDwYWKKaxzH+jUx8DxYRdnaYHqSePoKqUQ2DT2ko2zMQjLOxD4VchaWFMZJaDGvL1xxiUDZ62wsg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS7PR01MB13793.jpnprd01.prod.outlook.com
 (2603:1096:604:36a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 11:59:42 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 11:59:42 +0000
Date: Tue, 24 Nov 2026 12:59:23 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Tommaso Merciai <tomm.merciai@gmail.com>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "magnus.damm" <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU instance
 from the DRM device
Message-ID: <awV8G86QIth4GtaA@tom-desktop>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <68fcf838eee14c1906f23b2b7c74c560793cd1d4.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <OS3PR01MB65968FEBCB08429F11188CE986452@OS3PR01MB6596.jpnprd01.prod.outlook.com>
 <awVW5B4p06FUfBHw@tom-desktop>
 <TYYPR01MB6603AA1B7A48B7D899604EE586442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYYPR01MB6603AA1B7A48B7D899604EE586442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: FR4P281CA0347.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::15) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OS7PR01MB13793:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c23e799-1643-4d95-0f62-08df4a226c91
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|23010399003|1800799024|38350700014|10067099003|11063799006|4143699003|56012099006|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cLL6SStOtZFdQB9ZX/ZynibUxmxkGnOkxQrc4i7wiogKxdgq/QOt06af7BuEMJePh9LdhEg3kYW8rNxB0anqRSycUeYE0fQEB19+DL9o3Xo7L3gpXOdBdRGz9bwP1favQ8aoQ5d5OPkPLgsHVQfnMYBNqj6gZ46zfdVz82yh/6s3M6NHrwj6BsJ5f/wCXdtetpJJMMgBHVqD4aEmfitpawFIsTfVl66Q3Quiu4x0XigITvGN7l0Vyt/FVt3S1TQIAb3LbqJVarN6mKFVoTuX57zmmeMDPyXZp3nHrdS4kax23FST1Yig94ukPoo2CLeTW0IfZWLm/YClNzqIMM2gUnSgc+opFQaCQbxq3aQejN2/yrtpNvcdSx4hCax3KVHFn9eutmmq1RSKSrdp16SLv6TyDRg1QmxqXZgZ4Bctefe95p10B4uOLDskeIwO76g89UycnbwfnwTfiy5s2Csuz3F0kFPz6wCkcs7jY7mZZP2aiVXL3ayZxcPWhvvZMrLZ3pLn54MYuVXu4Y8ngeOuQYYOINTHSiMOH/b+GDVKU8t4NdCdv2g3ScPdOnESSAyqcDRX+y92VUZd67eGa/LbKoKAQPhVzUjptVdAC/xGi6/81CqWZgEXoRMflSfqoZn5e9aaeFRvYdQ2p++1NJGl6bX1QHyPYr+WT8adzKllCizM/qzUW7/qCk85Cy+Et+E2WZ3sdNzbo59yCv+RngXd4MNOIZvi+wDVtFKbr7Fvp0g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(23010399003)(1800799024)(38350700014)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QjdhB8Z8rthagdnddK8NtVkAU6rf6Su1FCCVTXoybVUQ/63eOjFkY6PZmAoO?=
 =?us-ascii?Q?XQ2IM4J6+DvK/hZBCewEHuKQsRFI/sRiVEb7FJJ34YK/cy/2fMSwzsKYByH5?=
 =?us-ascii?Q?CRFoRzNEjUvZmNxt0OCw5QBZOYBOR3jmODWRfCeVSGJu8amHtwr7S9uOwMyV?=
 =?us-ascii?Q?uZP4t18+mw1SbOMAtRf70jrk/IoUpgG3ZmBJFMCx1Jxjuntjzy1Ly5jzzqdL?=
 =?us-ascii?Q?mN5N+9UZ+BqlkKCSh6uIkzq2FvdhHYiWHhGWJWEC7NwYNM2BjnExHq/FluDt?=
 =?us-ascii?Q?6xm48jF7JaJ/W0ZXPgo+2ZApSq9S14rfv9fIK89L/QZffPx+ADEyShrcOxeM?=
 =?us-ascii?Q?MsrxmSlas0FvpKxeU3h9Wlx2nPHOv4Jv05oYMrQ1k631Cwclv0ODDoyRg9uM?=
 =?us-ascii?Q?HXgW2UUZfUMrc2s/RBaABGqojgY77E4dJ7/ahKi3lm29iZHNijI3VFXmpZkp?=
 =?us-ascii?Q?K+g79eF/bSSmC/qc/A2Gq8d3yyyyyJ3ND6PaXCW+GAuICtYlv9ihji+NbIFD?=
 =?us-ascii?Q?9ZsE+8FQJvL0Vy1PTbDfCdt4QY+RAKnWdyjWlbXpo2VWG4DSzH6sz2zE7HGs?=
 =?us-ascii?Q?xeBdWnPgInliPscEU03u8eTRmp7/W4FPycBnJRvRE0PPwzl5KiMaC8ENyg6s?=
 =?us-ascii?Q?/4Tb39RlBa2h0iG+TH0grdwZSQHq4Iyt56FanWDVaMBSHnYJTytgXj34yFXA?=
 =?us-ascii?Q?gwpjbMUuq3RkHaIob4MCqIK8dODM7UaK4euB8v3x1QuGBJNTl8goi1+tKAMZ?=
 =?us-ascii?Q?weOqrcEpRvoo2NrNtLW4G8mNGyHXZTGA4owrZ7KM9Fh7W1dA8cUDI9n06Uxg?=
 =?us-ascii?Q?C2AE1nE2i4vrz1GHtIUYk7w8huUesTsHL4LtWxYnKWrjPdK7ddOQrGoLVKFc?=
 =?us-ascii?Q?ljKgg3nVO1qvlIxNtspRuB0GPSHE46L7Me6AuY4jX6oyq1vA4z4xiYalpFCk?=
 =?us-ascii?Q?UOTIHPRA3dLJPBiCiRhqFZhSkqYM+yR1tsEJuSyOl9kcndGNysaI2Y9joOBJ?=
 =?us-ascii?Q?w0M+HoqGZNcFkU6l/Hv950SFlkLj9YtZUz2eLpd8zhRZt8I+JebDTsOoiLVy?=
 =?us-ascii?Q?jgbqLALlGjBqtEB9H3aFJm56v8bQroeZSDnOFUEy5a7PwZIe9V5Y1USvTIXJ?=
 =?us-ascii?Q?WQWh8Jm2BpStSaoPjc1LtqnoTf71UG7hICdCrG+JAYkSA8sXLErF3f1L0D0B?=
 =?us-ascii?Q?WJ8r+mq5VJ6qgYPhb26lhfjNofol3a0zjq4RjrIdNb4RglllI6Sq/BhomrqA?=
 =?us-ascii?Q?+xShbJzqnRFFoHWoFQLXERzmxaJqA205xsgQrrJxJWqtvu8gIQIryuYDps5d?=
 =?us-ascii?Q?pp5iPfb6eflCbi7tge1i16aul41zNn8Ge+aqNdsWRSf2Jf2yxjaO0h5vm6sH?=
 =?us-ascii?Q?D33r7quIYasnbx1edrjtSauxm6BDLP4trNND/213x3P34RV72oe39VG9nnwB?=
 =?us-ascii?Q?h9ZFTHMIMcRLlSRo7PvZ2kno9evzL8C+G27fkOVxchPtp2pvEV+0N/b72CVi?=
 =?us-ascii?Q?ob4dKGKQbNVRRd08UGhsi0kgbKfENPWK4Rm+KXCgc6vkOjYBM0OJGs+nkpfh?=
 =?us-ascii?Q?eWUos7jFYeQ9hrCcbsX59l4AHbTRMTs3YJq6ae819OUSRdi9dn+BfI8SYf06?=
 =?us-ascii?Q?y+8LO5OddiuGPWM0mwixrrBiGlFwPkLqvh8UI5qvwhqxzQ490tV8lfgiVwvZ?=
 =?us-ascii?Q?FQXlIFnp3gUNRRfYWAAcapDfGMcYEF9bHnph7Epoq33vCY9LLU+w1syGP3Li?=
 =?us-ascii?Q?sK3IET4QXOOYTpPuWzDk0SxhEEZ4YYE1QFtLmwqsX6a767giX+Xg?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c23e799-1643-4d95-0f62-08df4a226c91
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:59:42.3650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /y9IOBvwgrrjfxqriN4NpDrb/fPVB9DkPvXGo/takpuo6Cm0ir2c2AEUMQHDyPmm3k99I0e9wEGHiCzz4PbdvZh9BSzp5zZnpLv/cMXscu+8enMEFC3XR95Zj4DClXbB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB13793
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

Hi Biju,

On Tue, Nov 24, 2026 at 09:33:13AM +0000, Biju Das wrote:
> Hi Tommaso,
> 
> > -----Original Message-----
> > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > Sent: 24 November 2026 09:21
> > Subject: Re: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU instance from the DRM device
> > 
> > Hi Biju,
> > Thanks for your review.
> > 
> > On Mon, Nov 23, 2026 at 04:59:32PM +0000, Biju Das wrote:
> > > Hi Tommaso,
> > >
> > > > -----Original Message-----
> > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > Sent: 13 November 2026 12:20
> > > > Subject: [PATCH v10 08/12] drm: renesas: rz-du: Separate the DU
> > > > instance from the DRM device
> > > >
> > > > On RZ/G3E two DU instances share a DRM device, which can only be
> > > > created once both instances have been probed.
> > > >
> > > > Split the DU device structure: keep the match data and the registers
> > > > in a structure allocated with the platform device, and allocate the
> > > > KMS objects with the DRM device in a new rzg2l_du_instance_init() helper, as they are released
> > with it.
> > > >
> > > > No functional change intended.
> > > >
> > > > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > ---
> > > > v9->v10:
> > > >  - New patch.
> > > >
> > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 61
> > > > ++++++++++++++------
> > > >  1 file changed, 44 insertions(+), 17 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > b/drivers/gpu/drm/renesas/rz- du/rzg2l_du_drv.c index
> > > > d3cccbdf9012..d102876c07e1 100644
> > > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > @@ -162,6 +162,27 @@ static int rzg2l_du_pm_resume(struct device
> > > > *dev)  static DEFINE_SIMPLE_DEV_PM_OPS(rzg2l_du_pm_ops,
> > > >  				rzg2l_du_pm_suspend, rzg2l_du_pm_resume);
> > > >
> > > > +/*
> > > > +-------------------------------------------------------------------
> > > > +----
> > > > +------
> > > > + * DU instance
> > > > + */
> > > > +
> > > > +static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
> > > > +				  struct drm_device *ddev)
> > > > +{
> > > > +	struct rzg2l_du_device *rcdu;
> > > > +
> > > > +	rcdu = drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
> > > > +	if (!rcdu)
> > > > +		return -ENOMEM;
> > >
> > > Why there is duplicate allocation of rcdu? One in probe() and here
> > 
> > The two allocations have different lifetimes.
> > 
> > The one in rzg2l_du_probe() is tied to the platform device. It holds what is needed before the DRM
> > device exists and outside of the component bind (dev, info, mmio, and ddev/is_master for the master,
> > PM and remove), as on RZ/G3E the DRM device is only created once both instances have been probed.
> > 
> > The one in rzg2l_du_instance_init() holds the KMS objects (crtcs, vsps, lvds, index). Their drmm
> > cleanup handlers point into it and run when the DRM device is released, which can happen after the
> > platform device has been unbound, so it has to be allocated with the DRM device.
> 
> Then there is an issue right, platform unbound will unmap mmio and other data structures it allocated
> in rzg2l_du_probe()and drm driver is using after that( Use after free Bug)

Mmmm In theory no.

The KMS part keeps its own copy of dev, info and mmio, and its drmm
cleanup handlers only drop references, they don't access the hardware.


Kind regards,
Tommaso

> 
> Cheers,
> Biju
> 
> > 
> > Thanks, Tommaso
> > 
> > >
> > > Cheers,
> > > Biju
> > >
> > > > +
> > > > +	rcdu->dev = du->dev;
> > > > +	rcdu->info = du->info;
> > > > +	rcdu->mmio = du->mmio;
> > > > +	rcdu->ddev = ddev;
> > > > +
> > > > +	return rzg2l_du_modeset_init_du(rcdu); }
> > > > +
> > > >  /* -----------------------------------------------------------------------------
> > > >   * Platform driver
> > > >   */
> > > > @@ -190,44 +211,48 @@ static void rzg2l_du_shutdown(struct
> > > > platform_device *pdev)
> > > >
> > > >  static int rzg2l_du_probe(struct platform_device *pdev)  {
> > > > +	const struct rzg2l_du_device_info *info;
> > > >  	struct rzg2l_du_device *rcdu;
> > > >  	struct rzg2l_du_drm *rzgdrm;
> > > > +	void __iomem *mmio;
> > > >  	int ret;
> > > >
> > > >  	if (drm_firmware_drivers_only())
> > > >  		return -ENODEV;
> > > >
> > > > -	/* Allocate and initialize the RZ/G2L device structure. */
> > > > -	rzgdrm = devm_drm_dev_alloc(&pdev->dev, &rzg2l_du_driver,
> > > > -				    struct rzg2l_du_drm, ddev);
> > > > -	if (IS_ERR(rzgdrm))
> > > > -		return PTR_ERR(rzgdrm);
> > > > +	info = of_device_get_match_data(&pdev->dev);
> > > > +
> > > > +	/* I/O resources */
> > > > +	mmio = devm_platform_ioremap_resource(pdev, 0);
> > > > +	if (IS_ERR(mmio))
> > > > +		return PTR_ERR(mmio);
> > > > +
> > > > +	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> > > > +	if (ret)
> > > > +		return ret;
> > > >
> > > > -	rcdu = drmm_kzalloc(&rzgdrm->ddev, sizeof(*rcdu), GFP_KERNEL);
> > > > +	/* Allocate and initialize the RZ/G2L device structure. */
> > > > +	rcdu = devm_kzalloc(&pdev->dev, sizeof(*rcdu), GFP_KERNEL);
> > > >  	if (!rcdu)
> > > >  		return -ENOMEM;
> > > >
> > > >  	platform_set_drvdata(pdev, rcdu);
> > > >
> > > >  	rcdu->dev = &pdev->dev;
> > > > -	rcdu->info = of_device_get_match_data(rcdu->dev);
> > > > -	rcdu->ddev = &rzgdrm->ddev;
> > > > -
> > > > -	/* I/O resources */
> > > > -	rcdu->mmio = devm_platform_ioremap_resource(pdev, 0);
> > > > -	if (IS_ERR(rcdu->mmio))
> > > > -		return PTR_ERR(rcdu->mmio);
> > > > +	rcdu->info = info;
> > > > +	rcdu->mmio = mmio;
> > > >
> > > > -	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> > > > -	if (ret)
> > > > -		return ret;
> > > > +	rzgdrm = devm_drm_dev_alloc(&pdev->dev, &rzg2l_du_driver,
> > > > +				    struct rzg2l_du_drm, ddev);
> > > > +	if (IS_ERR(rzgdrm))
> > > > +		return PTR_ERR(rzgdrm);
> > > >
> > > >  	/* DRM/KMS objects */
> > > >  	ret = rzg2l_du_modeset_init_drm(&rzgdrm->ddev);
> > > >  	if (ret < 0)
> > > >  		goto error;
> > > >
> > > > -	ret = rzg2l_du_modeset_init_du(rcdu);
> > > > +	ret = rzg2l_du_instance_init(rcdu, &rzgdrm->ddev);
> > > >  	if (ret < 0)
> > > >  		goto error;
> > > >
> > > > @@ -243,6 +268,8 @@ static int rzg2l_du_probe(struct platform_device *pdev)
> > > >  	if (ret)
> > > >  		goto error_fini;
> > > >
> > > > +	rcdu->ddev = &rzgdrm->ddev;
> > > > +
> > > >  	drm_info(&rzgdrm->ddev, "Device %s probed\n",
> > > > dev_name(&pdev->dev));
> > > >
> > > >  	drm_client_setup(&rzgdrm->ddev, NULL);
> > > > --
> > > > 2.54.0
> > >
