Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6757606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=KwLnfvcq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16CC910F4E5;
	Tue, 24 Nov 2026 11:53:52 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010002.outbound.protection.outlook.com [52.101.228.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E223610F4E5
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 11:53:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhcIrL1hnVKGcoi/NjfL42aR5WTVe2NKTUZ/IRgsk+eRQIkEhwQbKU6TotLGfzQIQwt5e9MV4Bp62QTxiV4HBCyJaRFQnG3Vp1YAvTUQeFMn5cUb8fYJM0xUyKHaOEUEOtl5VoojroQbZ6EJzZE0d/ccwlhy8mWLePGnw2HTws/HQF0iZLwg0YQm9lNkk6ZzIpY6dhhwVZ5zMINE8jRpWJ+DSP1oWt92jak1S0/M6Ap4L9aN2669/heJUubOPGI30QjElEyTbw5GrBtmVOTzvI0BUtLSbrDo/D8lNLsS8DIbhTLlkhpAXEet+punukS8Ja8PkE4+j5Ww41I6s8/dFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxTgkgg/d1BjPUMbQVCWA8D298ZUPMyIGFuu1NkanSM=;
 b=tMpBzFMcY8uwF3c+7T7h3reSOCFABuCVA331G5Ul8w3C7Jv9uTHG51StvpxEJUw1G5QUY5M0CVB3HkmzW/u6dnbpdVV0ekcmRc2pNCt3bNC8h9B4BG+mXCWr5qn+SY3//aeL68gZIERaZFU3514wxYeyyXfsykX4nHUCV53znfKGH0lJnMnh//zWxA6xc8ZWsFGZSKge8G0Te3hr5/9UgfbocEyrwZje7b8HHU5t+SP17dI8z7i4akDnFt/JTbEGvnRW9m8RVX7nxysSZro8GKyrzkmQInjctbY0R4wKdZmlgVFtCWgSV2VAPgOQnK+zZTk/1syy3MI739N4/2aPiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxTgkgg/d1BjPUMbQVCWA8D298ZUPMyIGFuu1NkanSM=;
 b=KwLnfvcqi48qN175q7SXLgzJIAZONvix7BXlkZVmk3nyxYpK17R57w6ZOVbjLidB2Vefgeum4btW5lFwdjqtxrJpt2a8WhzzmJ+FDQYl+QmPAMo9r6UXyijT796Ya6hXX2JVyRsiMRu9ppYvYHEL8FwAZs0LERDOVPBWMxU3kYg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TYRPR01MB16144.jpnprd01.prod.outlook.com
 (2603:1096:405:2e3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 11:53:29 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 11:53:29 +0000
Date: Tue, 24 Nov 2026 12:53:08 +0100
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
Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU
 instances in one DRM device
Message-ID: <awV6pAtcSz8e9Q74@tom-desktop>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <e22a176720a38df652c7f7eabe27219da50f217d.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <TYYPR01MB660397C3B66F6EED53656B2086442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYYPR01MB660397C3B66F6EED53656B2086442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: FR4P281CA0339.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::13) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TYRPR01MB16144:EE_
X-MS-Office365-Filtering-Correlation-Id: d743e2e3-3408-4d17-f529-08df4a218dd0
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|366016|23010399003|1800799024|38350700014|10067099003|11063799006|4143699003|260925022911599003|260925021311599003|260925021911599003|56012099006|261021121427099003|261028144727099003|261022075727099003|261022105027099003|261026121527099003|261021123027099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261009223327099003|261102123227099003|261026140227099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: To3a3Tmeu3wGxDRT7VReWYPwPn+HSKqnFAYO7HCbO17yNLv/aTnEQrt75/DCi4eQnhtFkaPDTG5t7Jp8rwVTAPmK0mJDWuSu9wE0atBgE8+11xhgUlO7jciClwMyHRb3JtyN2Ngsol/MeV/+jNVYpsjcJ6gYiRjNCqWd3U7aYCOmi3QHM/bMubtU7OzEtOorTbCYOAUgr1Sg2eqd0q4LwmL7vFiVg3iZuuCdxBEDy75nNYQSQXeBhXt35c8GNmd3/bRP9imk0bAWWN5FXSiQFQMLIEBo2qZ/VKW7FsqCeq52KKWbkF8IPJpvWTMWCFD/GW2XCaLisE0imfHIdoTf2Rb68QJJ8yYVmpYq21pyVcZewk8fI83cnqJOi0+UwXxHPa5Q4m3qo65HF8s9uh7WjDpwpJVTBPjzJ3vSeb6MLGdLDcOhAqkwpsn+zPyMsemyFCR4jJpUklFMLXtLqG9reDxYI51KOO8QrVSm41o0oFK7j5vP+4BNk99KqK4RvjsJkjWl0PBA1zgUJ4ddjAC47eONe9NZ8f13QCgsbPObO0BqUXOI5eJWPzZo/jgkr9OHBkXlZ3Cevo4rtyDsd1IrLxjHaj7pOHoDEaDMcXGiuAzNVVbtW6m8AO0X9DvAsYrtkdSfINAucqLJKomaW2V3GbeNfqfItckRlh0+8519eKlmoJILJeHhCWOKW119ohB21BRHvR0pwx3/pkMM11/tfhGfXy6+y+ACiYHoi4omyv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(366016)(23010399003)(1800799024)(38350700014)(10067099003)(11063799006)(4143699003)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(261021121427099003)(261028144727099003)(261022075727099003)(261022105027099003)(261026121527099003)(261021123027099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223327099003)(261102123227099003)(261026140227099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?D34hxotp8lKo7Xth63uTVh4TG3sotL5nj3gmfDimD9fhdETOjYvYtaeqnH?=
 =?iso-8859-1?Q?LmQrMYrGHeY72oShF0LRrNr8FgKgCQsdJhuFU6YvvvUCD6q+SbgMKjDCwt?=
 =?iso-8859-1?Q?zYmP6XwH9BBMu+DvLbSKbF6EQX/eABpotLiFawZ8Mhmht1VLn0qAYwIxA3?=
 =?iso-8859-1?Q?zAmhPB4S9oW8PZSyksyVrVZNr2rrz1Gk1A5crg1aXzCXBF4OkpXLWD1KT9?=
 =?iso-8859-1?Q?16FoPulbl0bTWL9KmMhlBSiCWmU6CfJVGSpJS5MDB/gvuso3i//jAHYoP1?=
 =?iso-8859-1?Q?AuGhwnIyGvXhtAV3X3jTF8A+x01V9RkhNZAaBJyTnltRDC8iN+XXA/6wc7?=
 =?iso-8859-1?Q?giMhP8aXVRWuDHv+rzeSrSjtyTJFRoYZDApS2ontozEXHIc6HkqRM7/5T4?=
 =?iso-8859-1?Q?VAf3QQ0ZvwO4gEiAcwaOx+lhqiBrOH60lHVTOdZOEs+LPAhMi9xIn3aMAv?=
 =?iso-8859-1?Q?N84Dh8KOkeG/fogxjIm8Hco6YsrQoNKbilj/sj5TNL27fsRrRu7avZ/6o7?=
 =?iso-8859-1?Q?vWrjPy1HOKhjD8E6Gs9DyPrC7fivRes4UtneF5uIZXRpYW5WUGCQfCF2eM?=
 =?iso-8859-1?Q?e+y+oeiQVa06OJV6scqLoULvXi3GKpuNxQ6g+i+Xmjge7z7hiydlRQy2U3?=
 =?iso-8859-1?Q?wCnEpozwRrzl1E1ARXtR0kUG0xaoZnhBQDKJtgNe/kD0ki8bFNpFw7F6Kh?=
 =?iso-8859-1?Q?KzgQ21Een+QPq7rszyw7TyLg+ZMcwisfs5pqZuiCx53HQK/EvmwHM6m338?=
 =?iso-8859-1?Q?DIDPKpABlAis9jDsmtUab/XJQqJ0wjzVUt0ffunhh/UwNN9B37qDt2QtJG?=
 =?iso-8859-1?Q?dwIbbkisxJUky9SDhFXUapJupUVchjCQZg2FkiZF68u6JraSjBMk/HDiRr?=
 =?iso-8859-1?Q?UeY8CX7JL6rWOwQIcdRB7gpoNUWSlVDcUqoeIIPVXPJWhKr0Y2s98gtrhH?=
 =?iso-8859-1?Q?x/sfuxnVF76GptwVMUg7QtsuAXzwl4VY6grFF0Ar91W7fFa3sZB12xeaui?=
 =?iso-8859-1?Q?po6MhyJjXT4UHqLBtthsQcwIM55jR6PFfPGFnUpfg9vQGcft0kfgmfSRSP?=
 =?iso-8859-1?Q?kT6AqzQl2zRPQC75Hj+KTwIA3Ka+QyjmjHxFlyUEODEpWF+Jv3fqiaSwve?=
 =?iso-8859-1?Q?bAM7JNr7VLEZR7++CxUoOy37iGun5NI6nfnxHXJUfw+AHVFPhoSpSHXXwA?=
 =?iso-8859-1?Q?1etQlX6RwiRcqVEg3ZZVr+ln/rCT9v+vKJ47ZLKcqZGTSjAIyRIyfJFZpt?=
 =?iso-8859-1?Q?/d1CKs5VQKCs+EGH4LchE9GoOMtEvoDx2x60kNpxXj0Gj1tDtJ9qtUN7zU?=
 =?iso-8859-1?Q?zk5W+tNHJltXCdpXSJtFvx++zJrZpMOucBmM7hgfixdvsxW0oJvto2AQYJ?=
 =?iso-8859-1?Q?2gcUgUix4m1ku5lX0m1iA8GatxG5kmcjd42PyFaL4XMvTWzPKRHbaOEeLS?=
 =?iso-8859-1?Q?IYWotUECdpIiI148kEs/rcdzimCRdE9VGfDqBLy8aHD6+8WMVQrl4QI6mj?=
 =?iso-8859-1?Q?2heinV4SJ0LPsjtaD3Mp11dFoqOMlbjM/bL/IhIllwHp8iKQrp2yjEn9DJ?=
 =?iso-8859-1?Q?wTo3INApEcVaPZrvqCGQe0XIUxeOJ2dwT0Rxbu/TeGb9NXqTM8SZOjDQTP?=
 =?iso-8859-1?Q?nhfmgTb43vuK3Voa6qBRYQkGrx3G0zk1gXG1x+ohdyebdRWFw9sDSbNIYG?=
 =?iso-8859-1?Q?J5DGz9Flm/t+a2Tc9ZiXC65WWYJ7tYCWg0M9/KwjiDmNP3ET9Dyk/W37CV?=
 =?iso-8859-1?Q?TeIZlzwsASAZv5rzxb/0R5hFV5D+FUk4nIE/s6A03E1G1FFejSM/ipFDiC?=
 =?iso-8859-1?Q?jVgOAEjoCHjSiEB/FIBgjGLBgKPse/8nqul171tY9I++w+/5OQMJ?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d743e2e3-3408-4d17-f529-08df4a218dd0
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:53:29.2806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i508PeeM4WqvjJHG8QPWAsg/SEwOm42bno7jTOccnUU5LCCUpLyyQSzHkMkKAOqXC8LZHFtjkJpWydlBn4M9Ndt95je66kyGqHgTdjb8m7Lo0suzuYvyE8V2LRz48ur9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16144
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Biju,
Thanks for your review.

On Tue, Nov 24, 2026 at 07:47:04AM +0000, Biju Das wrote:
> Hi Tommaso,
> 
> > -----Original Message-----
> > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > Sent: 13 November 2026 12:20
> > Subject: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU instances in one DRM device
> > 
> > RZ/G3E has two DU instances that share a single DRM device.
> > 
> > Add an RZG2L_DU_FEATURE_COMPONENT flag and use the component framework for it. The first available DU
> > instance is the master and creates the DRM device, the other one binds to it as a component.
> > 
> > If only one DU instance is available, it creates the DRM device directly at probe time, as on SoCs
> > without the flag.
> > 
> > Set the index of each instance to the number of CRTCs already created.
> > 
> > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > ---
> > v9->v10:
> >  - New patch.
> > 
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 118 ++++++++++++++++++-
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h |   2 +
> >  2 files changed, 115 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-
> > du/rzg2l_du_drv.c
> > index 93d59e2cf8a4..873586f2ef28 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > @@ -7,6 +7,7 @@
> >   * Based on rcar_du_drv.c
> >   */
> > 
> > +#include <linux/component.h>
> >  #include <linux/dma-mapping.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > @@ -14,10 +15,12 @@
> > 
> >  #include <drm/clients/drm_client_setup.h>  #include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_crtc.h>
> >  #include <drm/drm_drv.h>
> >  #include <drm/drm_fbdev_dma.h>
> >  #include <drm/drm_gem_dma_helper.h>
> >  #include <drm/drm_managed.h>
> > +#include <drm/drm_of.h>
> >  #include <drm/drm_print.h>
> >  #include <drm/drm_probe_helper.h>
> > 
> > @@ -170,6 +173,7 @@ static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
> >  				  struct drm_device *ddev)
> >  {
> >  	struct rzg2l_du_device *rcdu;
> > +	int ret;
> > 
> >  	rcdu = drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
> >  	if (!rcdu)
> > @@ -180,9 +184,28 @@ static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
> >  	rcdu->mmio = du->mmio;
> >  	rcdu->ddev = ddev;
> > 
> > -	return rzg2l_du_modeset_init_du(rcdu);
> > +	rcdu->index = ddev->mode_config.num_crtc;
> > +
> > +	ret = rzg2l_du_modeset_init_du(rcdu);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (WARN_ON(drm_crtc_index(&rcdu->crtcs[0].crtc) != rcdu->index))
> > +		return -EINVAL;
> > +
> > +	return 0;
> >  }
> > 
> > +static int rzg2l_du_instance_bind(struct device *dev, struct device *master,
> > +				  void *data)
> > +{
> > +	return rzg2l_du_instance_init(dev_get_drvdata(dev), data); }
> > +
> > +static const struct component_ops rzg2l_du_instance_ops = {
> > +	.bind = rzg2l_du_instance_bind,
> > +};
> > +
> >  /* -----------------------------------------------------------------------------
> >   * DRM device
> >   */
> > @@ -191,7 +214,7 @@ struct rzg2l_du_drm {
> >  	struct drm_device ddev;
> >  };
> > 
> > -static int rzg2l_du_drm_init(struct device *dev)
> > +static int rzg2l_du_drm_init(struct device *dev, bool has_components)
> >  {
> >  	struct rzg2l_du_device *du = dev_get_drvdata(dev);
> >  	struct rzg2l_du_drm *rzgdrm;
> > @@ -213,6 +236,12 @@ static int rzg2l_du_drm_init(struct device *dev)
> >  	if (ret < 0)
> >  		goto error;
> > 
> > +	if (has_components) {
> > +		ret = component_bind_all(dev, ddev);
> > +		if (ret < 0)
> > +			goto error;
> > +	}
> > +
> >  	ret = rzg2l_du_modeset_init_finish(ddev);
> >  	if (ret < 0)
> >  		goto error_fini;
> > @@ -235,6 +264,8 @@ static int rzg2l_du_drm_init(struct device *dev)
> > 
> >  error_fini:
> >  	drm_kms_helper_poll_fini(ddev);
> > +	if (has_components)
> > +		component_unbind_all(dev, ddev);
> >  error:
> >  	/*
> >  	 * Don't use dev_err_probe(), as it would overwrite the probe deferral @@ -246,7 +277,7 @@
> > static int rzg2l_du_drm_init(struct device *dev)
> >  	return ret;
> >  }
> > 
> > -static void rzg2l_du_drm_fini(struct device *dev)
> > +static void rzg2l_du_drm_fini(struct device *dev, bool has_components)
> >  {
> >  	struct rzg2l_du_device *du = dev_get_drvdata(dev);
> >  	struct drm_device *ddev = du->ddev;
> > @@ -254,6 +285,83 @@ static void rzg2l_du_drm_fini(struct device *dev)
> >  	drm_dev_unregister(ddev);
> >  	drm_atomic_helper_shutdown(ddev);
> >  	drm_kms_helper_poll_fini(ddev);
> > +
> > +	if (has_components)
> > +		component_unbind_all(dev, ddev);
> > +
> > +	du->ddev = NULL;
> > +}
> > +
> > +/*
> > +-----------------------------------------------------------------------
> > +------
> > + * Component master
> > + */
> > +
> > +static int rzg2l_du_master_bind(struct device *dev) {
> > +	return rzg2l_du_drm_init(dev, true);
> > +}
> > +
> > +static void rzg2l_du_master_unbind(struct device *dev) {
> > +	rzg2l_du_drm_fini(dev, true);
> > +}
> > +
> > +static const struct component_master_ops rzg2l_du_master_ops = {
> > +	.bind = rzg2l_du_master_bind,
> > +	.unbind = rzg2l_du_master_unbind,
> > +};
> > +
> > +static int rzg2l_du_instance_probe(struct rzg2l_du_device *du) {
> > +	struct component_match *match = NULL;
> > +	const struct of_device_id *of_id;
> > +	struct device *dev = du->dev;
> > +
> > +	if (!rzg2l_du_has(du, RZG2L_DU_FEATURE_COMPONENT))
> > +		return rzg2l_du_drm_init(dev, false);
> > +
> > +	for_each_available_child_of_node_scoped(dev->of_node->parent, np) {
> > +		of_id = of_match_node(dev->driver->of_match_table, np);
> > +		if (!of_id || of_id->data != du->info)
> > +			continue;
> > +
> > +		/* The first available DU instance is the component master. */
> > +		if (!du->is_master) {
> > +			if (np != dev->of_node)
> > +				return component_add(dev, &rzg2l_du_instance_ops);
> > +
> > +			du->is_master = true;
> > +			continue;
> > +		}
> > +
> > +		drm_of_component_match_add(dev, &match, component_compare_of, np);
> 
> 
> The master is chosen purely by DT order. If the first available DU never probes,
> the second never gets a DRM device. How do you handle this case?

All available instances are part of the component match, so the DRM
device is only created once all of them have probed, whichever one is
the master. 

This is how the component framework works.

To use a single DU, the other one can be disabled in DT, in this case
the remaining instance becomes the master and initializes the DRM
device on its own.

> 
> Deferral from master_bind also only works via the component_add/
> component_master_add_with_match return path,

Yes, the bind is attempted from the probe of the last instance completing
the match, and -EPROBE_DEFER is returned from that probe, which is then
retried.


> 
> Have you tested with a late-probing DSI or LVDS bridge?

---------------------------------------------------------------------
Test has been done with later patches were DSI support and pm support
will be introduced:
	
	(DU0 | DU1) -> DSI
---------------------------------------------------------------------



For late-probing testing tI've blacklisted the followings driver:

modprobe.blacklist=rzg2l_du_drm,rzg2l_mipi_dsi,adv7511

modprobe rzg2l_du_drm
modprobe rzg2l_mipi_dsi 
modprobe adv7511

modetest -M rzg2l-du

modetest -M rzg2l-du -s 47@45:1920x1080-59.94@XR24
modetest -M rzg2l-du -s 47@60:1920x1080-59.94@XR24

logs:
root@smarc-rzg3e:~# modprobe rzg2l_du_drm
root@smarc-rzg3e:~# modprobe rzg2l_mipi_dsi
root@smarc-rzg3e:~# modprobe adv7511

[   34.097032] rzg2l-du 16460000.display: bound 16490000.display (ops rzg2l_du_instance_ops [rzg2l_du_drm])
[   34.107851] [drm] Initialized rzg2l-du 1.0.0 for 16460000.display on minor 1
[   34.114977] rzg2l-du 16460000.display: [drm] Device 16460000.display probed
[   34.251434] Console: switching to colour frame buffer device 240x67
[   34.301448] rzg2l-du 16460000.display: [drm] fb0: rzg2l-dudrmfb frame buffer device
[   34.305835] systemd-journald[202]: Successfully sent stream file descriptor to service manager.

root@smarc-rzg3e:~#
root@smarc-rzg3e:~#
root@smarc-rzg3e:~#
root@smarc-rzg3e:~#
root@smarc-rzg3e:~# modetest -M rzg2l-du
Encoders:
id      crtc    type    possible crtcs  possible clones
46      45      none    0x00000003      0x00000001

Connectors:
id      encoder status          name            size (mm)       modes   encoders
47      46      connected       HDMI-A-1        700x390         30      46
  modes:
        index name refresh (Hz) hdisp hss hse htot vdisp vss vse vtot
  #0 1920x1080 60.00 1920 2008 2052 2200 1080 1084 1089 1125 148500 flags: phsync, pvsync; type: preferred, driver
  #1 1920x1080 59.94 1920 2008 2052 2200 1080 1084 1089 1125 148352 flags: phsync, pvsync; type: driver
  #2 1920x1080 50.00 1920 2448 2492 2640 1080 1084 1089 1125 148500 flags: phsync, pvsync; type: driver
  #3 1680x1050 59.88 1680 1728 1760 1840 1050 1053 1059 1080 119000 flags: phsync, nvsync; type: driver
  #4 1600x900 60.00 1600 1624 1704 1800 900 901 904 1000 108000 flags: phsync, pvsync; type: driver
  #5 1280x1024 75.02 1280 1296 1440 1688 1024 1025 1028 1066 135000 flags: phsync, pvsync; type: driver
  #6 1280x1024 60.02 1280 1328 1440 1688 1024 1025 1028 1066 108000 flags: phsync, pvsync; type: driver
  #7 1440x900 59.90 1440 1488 1520 1600 900 903 909 926 88750 flags: phsync, nvsync; type: driver
  #8 1280x800 59.91 1280 1328 1360 1440 800 803 809 823 71000 flags: phsync, nvsync; type: driver
  #9 1152x864 75.00 1152 1216 1344 1600 864 865 868 900 108000 flags: phsync, pvsync; type: driver
  #10 1280x720 60.00 1280 1390 1430 1650 720 725 730 750 74250 flags: phsync, pvsync; type: driver
  #11 1280x720 59.94 1280 1390 1430 1650 720 725 730 750 74176 flags: phsync, pvsync; type: driver
  #12 1280x720 50.00 1280 1720 1760 1980 720 725 730 750 74250 flags: phsync, pvsync; type: driver
  #13 1024x768 75.03 1024 1040 1136 1312 768 769 772 800 78750 flags: phsync, pvsync; type: driver
  #14 1024x768 70.07 1024 1048 1184 1328 768 771 777 806 75000 flags: nhsync, nvsync; type: driver
  #15 1024x768 60.00 1024 1048 1184 1344 768 771 777 806 65000 flags: nhsync, nvsync; type: driver
  #16 832x624 74.55 832 864 928 1152 624 625 628 667 57284 flags: nhsync, nvsync; type: driver
  #17 800x600 75.00 800 816 896 1056 600 601 604 625 49500 flags: phsync, pvsync; type: driver
  #18 800x600 72.19 800 856 976 1040 600 637 643 666 50000 flags: phsync, pvsync; type: driver
  #19 800x600 60.32 800 840 968 1056 600 601 605 628 40000 flags: phsync, pvsync; type: driver
  #20 800x600 56.25 800 824 896 1024 600 601 603 625 36000 flags: phsync, pvsync; type: driver
  #21 720x576 50.00 720 732 796 864 576 581 586 625 27000 flags: nhsync, nvsync; type: driver
  #22 720x480 60.00 720 736 798 858 480 489 495 525 27027 flags: nhsync, nvsync; type: driver
  #23 720x480 59.94 720 736 798 858 480 489 495 525 27000 flags: nhsync, nvsync; type: driver
  #24 640x480 75.00 640 656 720 840 480 481 484 500 31500 flags: nhsync, nvsync; type: driver
  #25 640x480 72.81 640 664 704 832 480 489 492 520 31500 flags: nhsync, nvsync; type: driver
  #26 640x480 66.67 640 704 768 864 480 483 486 525 30240 flags: nhsync, nvsync; type: driver
  #27 640x480 60.00 640 656 752 800 480 490 492 525 25200 flags: nhsync, nvsync; type: driver
  #28 640x480 59.94 640 656 752 800 480 490 492 525 25175 flags: nhsync, nvsync; type: driver
  #29 720x400 70.08 720 738 846 900 400 412 414 449 28320 flags: nhsync, pvsync; type: driver
  props:
        1 EDID:
                flags: immutable blob
                blobs:

                value:
                        00ffffffffffff004c2d0070324e4e34
                        0e1f0103804627782a1c02a853459623
                        1b4d58bfef80714f81c0810081809500
                        a9c0b3000101023a801871382d40582c
                        4500ba892100001e000000fd00324b1e
                        5112000a202020202020000000fc0043
                        3332523530780a2020202020000000ff
                        00483443523430303033345a002001f3
                        02031af14690041f1312032309070783
                        01000066030c00100080023a80d07238
                        2d40102c4580ba892100001e011d0072
                        51d01e206e285500ba892100001e011d
                        00bc52d01e20b8285540ba892100001e
                        8c0ad08a20e02d10103e9600ba892100
                        00182a4480a07038274030203500ba89
                        2100001a00000000000000000000002c
        2 DPMS:
                flags: enum
                enums: On=0 Standby=1 Suspend=2 Off=3
                value: 0
        5 link-status:
                flags: enum
                enums: Good=0 Bad=1
                value: 0
        7 non-desktop:
                flags: immutable range
                values: 0 1
                value: 0
        4 TILE:
                flags: immutable blob
                blobs:

                value:
        48 max bpc:
                flags: range
                values: 8 8
                value: 8
        49 color format:
                flags: enum
                enums: AUTO=0 RGB=1
                value: 0

CRTCs:
id      fb      pos     size
45      71      (0,0)   (1920x1080)
  #0 1920x1080 60.00 1920 2008 2052 2200 1080 1084 1089 1125 148500 flags: phsync, pvsync; type: preferred, driver
  props:
        25 VRR_ENABLED:
                flags: range
                values: 0 1
                value: 0
60      0       (0,0)   (0x0)
  #0  nan 0 0 0 0 0 0 0 0 0 flags: ; type:
  props:
        25 VRR_ENABLED:
                flags: range
                values: 0 1
                value: 0

Planes:
id      crtc    fb      CRTC x,y        x,y     gamma size      possible crtcs
35      45      71      0,0             0,0     0               0x00000001
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 1
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        37 alpha:
                flags: range
                values: 0 65535
                value: 65535
        38 zpos:
                flags: range
                values: 0 1
                value: 0
        39 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0
40      0       0       0,0             0,0     0               0x00000001
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 0
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        42 alpha:
                flags: range
                values: 0 65535
                value: 65535
        43 zpos:
                flags: range
                values: 0 1
                value: 1
        44 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0
50      0       0       0,0             0,0     0               0x00000002
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 1
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        52 alpha:
                flags: range
                values: 0 65535
                value: 65535
        53 zpos:
                flags: range
                values: 0 1
                value: 0
        54 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0
55      0       0       0,0             0,0     0               0x00000002
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 0
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        57 alpha:
                flags: range
                values: 0 65535
                value: 65535
        58 zpos:
                flags: range
                values: 0 1
                value: 1
        59 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0

Frame buffers:
id      size    pitch


modetest -M rzg2l-du -s 47@45:1920x1080-59.94@XR24
setting mode 1920x1080-59.94Hz on connectors 47, crtc 45

modetest -M rzg2l-du -s 47@60:1920x1080-59.94@XR24
setting mode 1920x1080-59.94Hz on connectors 47, crtc 60

> 
> Have you tested component bind/unbind/rebind of both master and slave?

For bind/unbind/rebind testing:

echo 16490000.display > /sys/bus/platform/drivers/rzg2l-du/unbind;
echo 16490000.display > /sys/bus/platform/drivers/rzg2l-du/bind

modetest -M rzg2l-du -s 47@45:1920x1080-59.94@XR24
modetest -M rzg2l-du -s 47@60:1920x1080-59.94@XR24

echo 16460000.display > /sys/bus/platform/drivers/rzg2l-du/unbind
echo 16460000.display > /sys/bus/platform/drivers/rzg2l-du/bind

modetest -M rzg2l-du -s 47@45:1920x1080-59.94@XR24
modetest -M rzg2l-du -s 47@60:1920x1080-59.94@XR24
	

logs below:

root@smarc-rzg3e:~# killall weston
root@smarc-rzg3e:~# [   41.334337] systemd-journald[200]: Successfully sent stream file descriptor to service manager.
echo 16460000.display > /sys/bus/platform/drivers/rzg2l-du/unbind
[   46.426867] Console: switching to colour dummy device 80x25
root@smarc-rzg3e:~# echo 16460000.display > /sys/bus/platform/drivers/rzg2l-du/bind
[   49.070454] rzg2l-du 16460000.display: bound 16490000.display (ops rzg2l_du_instance_ops [rzg2l_du_drm])
[   49.080934] [drm] Initialized rzg2l-du 1.0.0 for 16460000.display on minor 1
[   49.088044] rzg2l-du 16460000.display: [drm] Device 16460000.display probed
[   49.279781] Console: switching to colour frame buffer device 240x67
[   49.330057] rzg2l-du 16460000.display: [drm] fb0: rzg2l-dudrmfb frame buffer device
root@smarc-rzg3e:~# [   49.363063] systemd-journald[200]: Successfully sent stream file descriptor to service manager.

root@smarc-rzg3e:~#
root@smarc-rzg3e:~#
root@smarc-rzg3e:~# [   50.534177] kauditd_printk_skb: 5 callbacks suppressed
[   50.534192] audit: type=1334 audit(946684832.568:22): prog-id=18 op=UNLOAD
[   50.546285] audit: type=1334 audit(946684832.568:23): prog-id=17 op=UNLOAD
[   50.553146] audit: type=1334 audit(946684832.568:24): prog-id=16 op=UNLOAD
echo 16460000.display > /sys/bus/platform/drivers/rzg2l-du/unbind[   51.133730]

[   51.626775] Console: switching to colour dummy device 80x25
root@smarc-rzg3e:~# echo 16460000.display > /sys/bus/platform/drivers/rzg2l-du/bind
[   53.269741] rzg2l-du 16460000.display: bound 16490000.display (ops rzg2l_du_instance_ops [rzg2l_du_drm])
[   53.280220] [drm] Initialized rzg2l-du 1.0.0 for 16460000.display on minor 1
[   53.287318] rzg2l-du 16460000.display: [drm] Device 16460000.display probed
[   53.479225] Console: switching to colour frame buffer device 240x67
[   53.529185] rzg2l-du 16460000.display: [drm] fb0: rzg2l-dudrmfb frame buffer device
root@smarc-rzg3e:~# [   53.539745] systemd-journald[200]: Successfully sent stream file descriptor to service manager.

root@smarc-rzg3e:~#
root@smarc-rzg3e:~#
root@smarc-rzg3e:~# echo 16460000.display > /sys/bus/platform/drivers/rzg2l-du/unbind
[   57.766813] Console: switching to colour dummy device 80x25
[   57.815545] systemd-journald[200]: Data hash table of /run/log/journal/02e142bc802e4550b9efefd2285280e1/system.journal has a fill level at 75.0 (10924 of 14563 items, 8388608 file size, 7
67 bytes per hash table item), suggesting rotation.
[   57.836680] systemd-journald[200]: /run/log/journal/02e142bc802e4550b9efefd2285280e1/system.journal: Journal header limits reached or header out-of-date, rotating.
[   57.851259] systemd-journald[200]: Rotating...
[   57.856364] systemd-journald[200]: Reserving 333 entries in field hash table.
root@smarc-rzg3e:~# [   57.869671] systemd-journald[200]: Reserving 14563 entries in data hash table.
[   57.877270] systemd-journald[200]: Vacuuming...
[   57.882656] systemd-journald[200]: Vacuuming done, freed 0B of archived journals from /run/log/journal/02e142bc802e4550b9efefd2285280e1.
echo 16460000.display > /sys/bus/platform/drivers/rzg2l-du/bind
[   59.169758] rzg2l-du 16460000.display: bound 16490000.display (ops rzg2l_du_instance_ops [rzg2l_du_drm])
[   59.180273] [drm] Initialized rzg2l-du 1.0.0 for 16460000.display on minor 1
[   59.187363] rzg2l-du 16460000.display: [drm] Device 16460000.display probed
[   59.379197] Console: switching to colour frame buffer device 240x67
[   59.429414] rzg2l-du 16460000.display: [drm] fb0: rzg2l-dudrmfb frame buffer device
root@smarc-rzg3e:~# [   59.464090] systemd-journald[200]: Successfully sent stream file descriptor to service manager.

root@smarc-rzg3e:~# modetest -M rzg2l-du -s 47@45:1920x1080-59.94@XR24
setting mode 1920x1080-59.94Hz on connectors 47, crtc 45

root@smarc-rzg3e:~# modetest -M rzg2l-du -s 47@60:1920x1080-59.94@XR24
setting mode 1920x1080-59.94Hz on connectors 47, crtc 60



echo 16490000.display > /sys/bus/platform/drivers/rzg2l-du/unbind;
[  111.818673] Console: switching to colour dummy device 80x25
root@smarc-rzg3e:~# echo 16490000.display > /sys/bus/platform/drivers/rzg2l-du/unbind;^C
root@smarc-rzg3e:~# echo 16490000.display > /sys/bus/platform/drivers/rzg2l-du/bind
[  117.530345] rzg2l-du 16460000.display: bound 16490000.display (ops rzg2l_du_instance_ops [rzg2l_du_drm])
[  117.543450] [drm] Initialized rzg2l-du 1.0.0 for 16460000.display on minor 1
[  117.550564] rzg2l-du 16460000.display: [drm] Device 16460000.display probed
[  117.742291] Console: switching to colour frame buffer device 240x67
[  117.792105] rzg2l-du 16460000.display: [drm] fb0: rzg2l-dudrmfb frame buffer device
[  117.795892] systemd-journald[200]: Successfully sent stream file descriptor to service manager.
root@smarc-rzg3e:~#
root@smarc-rzg3e:~#
root@smarc-rzg3e:~#
root@smarc-rzg3e:~# echo 16490000.display > /sys/bus/platform/drivers/rzg2l-du/unbind;
[  121.578706] Console: switching to colour dummy device 80x25
root@smarc-rzg3e:~# echo 16490000.display > /sys/bus/platform/drivers/rzg2l-du/bind
[  122.881739] rzg2l-du 16460000.display: bound 16490000.display (ops rzg2l_du_instance_ops [rzg2l_du_drm])
[  122.892215] [drm] Initialized rzg2l-du 1.0.0 for 16460000.display on minor 1
[  122.899310] rzg2l-du 16460000.display: [drm] Device 16460000.display probed
[  123.091215] Console: switching to colour frame buffer device 240x67
[  123.141287] rzg2l-du 16460000.display: [drm] fb0: rzg2l-dudrmfb frame buffer device
[  123.146450] systemd-journald[200]: Successfully sent stream file descriptor to service manager.
root@smarc-rzg3e:~# echo 16490000.display > /sys/bus/platform/drivers/rzg2l-du/unbind;
[  124.526683] Console: switching to colour dummy device 80x25
root@smarc-rzg3e:~# echo 16490000.display > /sys/bus/platform/drivers/rzg2l-du/bind
[  125.643119] rzg2l-du 16460000.display: bound 16490000.display (ops rzg2l_du_instance_ops [rzg2l_du_drm])
[  125.653626] [drm] Initialized rzg2l-du 1.0.0 for 16460000.display on minor 1
[  125.660745] rzg2l-du 16460000.display: [drm] Device 16460000.display probed
[  125.668228] rzg2l-du 16460000.display: [drm] Cannot find any crtc or sizes
[  125.675588] rzg2l-du 16460000.display: [drm] Cannot find any crtc or sizes
[  126.298364] Console: switching to colour frame buffer device 240x67
[  126.348428] rzg2l-du 16460000.display: [drm] fb0: rzg2l-dudrmfb frame buffer device


root@smarc-rzg3e:~# modetest -M rzg2l-du -s 47@45:1920x1080-59.94@XR24
setting mode 1920x1080-59.94Hz on connectors 47, crtc 45

root@smarc-rzg3e:~# modetest -M rzg2l-du -s 47@60:1920x1080-59.94@XR24
setting mode 1920x1080-59.94Hz on connectors 47, crtc 60

> 
> Have you tested PM and shutdown on the second DU?                                                                                                                               
>      du->ddev is only set on the master's platform data. The slave's PM suspend/resume and 
>      shutdown therefore call the helpers with NULL

For pm testing:

killall weston
modetest -M rzg2l-du

modetest -M rzg2l-du -s 47@45:1920x1080-59.94@XR24
modetest -M rzg2l-du -s 47@60:1920x1080-59.94@XR24

echo s2idle > /sys/power/mem_sleep
echo mem > /sys/power/state

modetest -M rzg2l-du -s 47@45:1920x1080-59.94@XR24
modetest -M rzg2l-du -s 47@60:1920x1080-59.94@XR24

echo deep > /sys/power/mem_sleep
echo mem > /sys/power/state

logs below:


root@smarc-rzg3e:~# killall weston
root@smarc-rzg3e:~# modetest -M rzg2l-du
Encoders:
id      crtc    type    possible crtcs  possible clones
46      45      none    0x00000003      0x00000001

Connectors:
id      encoder status          name            size (mm)       modes   encoders
47      46      connected       HDMI-A-1        700x390         30      46
  modes:
        index name refresh (Hz) hdisp hss hse htot vdisp vss vse vtot
  #0 1920x1080 60.00 1920 2008 2052 2200 1080 1084 1089 1125 148500 flags: phsync, pvsync; type: preferred, driver
  #1 1920x1080 59.94 1920 2008 2052 2200 1080 1084 1089 1125 148352 flags: phsync, pvsync; type: driver
  #2 1920x1080 50.00 1920 2448 2492 2640 1080 1084 1089 1125 148500 flags: phsync, pvsync; type: driver
  #3 1680x1050 59.88 1680 1728 1760 1840 1050 1053 1059 1080 119000 flags: phsync, nvsync; type: driver
  #4 1600x900 60.00 1600 1624 1704 1800 900 901 904 1000 108000 flags: phsync, pvsync; type: driver
  #5 1280x1024 75.02 1280 1296 1440 1688 1024 1025 1028 1066 135000 flags: phsync, pvsync; type: driver
  #6 1280x1024 60.02 1280 1328 1440 1688 1024 1025 1028 1066 108000 flags: phsync, pvsync; type: driver
  #7 1440x900 59.90 1440 1488 1520 1600 900 903 909 926 88750 flags: phsync, nvsync; type: driver
  #8 1280x800 59.91 1280 1328 1360 1440 800 803 809 823 71000 flags: phsync, nvsync; type: driver
  #9 1152x864 75.00 1152 1216 1344 1600 864 865 868 900 108000 flags: phsync, pvsync; type: driver
  #10 1280x720 60.00 1280 1390 1430 1650 720 725 730 750 74250 flags: phsync, pvsync; type: driver
  #11 1280x720 59.94 1280 1390 1430 1650 720 725 730 750 74176 flags: phsync, pvsync; type: driver
  #12 1280x720 50.00 1280 1720 1760 1980 720 725 730 750 74250 flags: phsync, pvsync; type: driver
  #13 1024x768 75.03 1024 1040 1136 1312 768 769 772 800 78750 flags: phsync, pvsync; type: driver
  #14 1024x768 70.07 1024 1048 1184 1328 768 771 777 806 75000 flags: nhsync, nvsync; type: driver
  #15 1024x768 60.00 1024 1048 1184 1344 768 771 777 806 65000 flags: nhsync, nvsync; type: driver
  #16 832x624 74.55 832 864 928 1152 624 625 628 667 57284 flags: nhsync, nvsync; type: driver
  #17 800x600 75.00 800 816 896 1056 600 601 604 625 49500 flags: phsync, pvsync; type: driver
  #18 800x600 72.19 800 856 976 1040 600 637 643 666 50000 flags: phsync, pvsync; type: driver
  #19 800x600 60.32 800 840 968 1056 600 601 605 628 40000 flags: phsync, pvsync; type: driver
  #20 800x600 56.25 800 824 896 1024 600 601 603 625 36000 flags: phsync, pvsync; type: driver
  #21 720x576 50.00 720 732 796 864 576 581 586 625 27000 flags: nhsync, nvsync; type: driver
  #22 720x480 60.00 720 736 798 858 480 489 495 525 27027 flags: nhsync, nvsync; type: driver
  #23 720x480 59.94 720 736 798 858 480 489 495 525 27000 flags: nhsync, nvsync; type: driver
  #24 640x480 75.00 640 656 720 840 480 481 484 500 31500 flags: nhsync, nvsync; type: driver
  #25 640x480 72.81 640 664 704 832 480 489 492 520 31500 flags: nhsync, nvsync; type: driver
  #26 640x480 66.67 640 704 768 864 480 483 486 525 30240 flags: nhsync, nvsync; type: driver
  #27 640x480 60.00 640 656 752 800 480 490 492 525 25200 flags: nhsync, nvsync; type: driver
  #28 640x480 59.94 640 656 752 800 480 490 492 525 25175 flags: nhsync, nvsync; type: driver
  #29 720x400 70.08 720 738 846 900 400 412 414 449 28320 flags: nhsync, pvsync; type: driver
  props:
        1 EDID:
                flags: immutable blob
                blobs:

                value:
                        00ffffffffffff004c2d0070324e4e34
                        0e1f0103804627782a1c02a853459623
                        1b4d58bfef80714f81c0810081809500
                        a9c0b3000101023a801871382d40582c
                        4500ba892100001e000000fd00324b1e
                        5112000a202020202020000000fc0043
                        3332523530780a2020202020000000ff
                        00483443523430303033345a002001f3
                        02031af14690041f1312032309070783
                        01000066030c00100080023a80d07238
                        2d40102c4580ba892100001e011d0072
                        51d01e206e285500ba892100001e011d
                        00bc52d01e20b8285540ba892100001e
                        8c0ad08a20e02d10103e9600ba892100
                        00182a4480a07038274030203500ba89
                        2100001a00000000000000000000002c
        2 DPMS:
                flags: enum
                enums: On=0 Standby=1 Suspend=2 Off=3
                value: 0
        5 link-status:
                flags: enum
                enums: Good=0 Bad=1
                value: 0
        7 non-desktop:
                flags: immutable range
                values: 0 1
                value: 0
        4 TILE:
                flags: immutable blob
                blobs:

                value:
        48 max bpc:
                flags: range
                values: 8 8
                value: 8
        49 color format:
                flags: enum
                enums: AUTO=0 RGB=1
                value: 0

CRTCs:
id      fb      pos     size
45      62      (0,0)   (1920x1080)
  #0 1920x1080 60.00 1920 2008 2052 2200 1080 1084 1089 1125 148500 flags: phsync, pvsync; type: preferred, driver
  props:
        25 VRR_ENABLED:
                flags: range
                values: 0 1
                value: 0
60      0       (0,0)   (0x0)
  #0  nan 0 0 0 0 0 0 0 0 0 flags: ; type: 
  props:
        25 VRR_ENABLED:
                flags: range
                values: 0 1
                value: 0

Planes:
id      crtc    fb      CRTC x,y        x,y     gamma size      possible crtcs
35      45      62      0,0             0,0     0               0x00000001
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 1
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        37 alpha:
                flags: range
                values: 0 65535
                value: 65535
        38 zpos:
                flags: range
                values: 0 1
                value: 0
        39 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0
40      0       0       0,0             0,0     0               0x00000001
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 0
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        42 alpha:
                flags: range
                values: 0 65535
                value: 65535
        43 zpos:
                flags: range
                values: 0 1
                value: 1
        44 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0
50      0       0       0,0             0,0     0               0x00000002
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 1
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        52 alpha:
                flags: range
                values: 0 65535
                value: 65535
        53 zpos:
                flags: range
                values: 0 1
                value: 0
        54 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0
55      0       0       0,0             0,0     0               0x00000002
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 0
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        57 alpha:
                flags: range
                values: 0 65535
                value: 65535
        58 zpos:
                flags: range
                values: 0 1
                value: 1
        59 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0

Frame buffers:
id      size    pitch

root@smarc-rzg3e:~# modetest -M rzg2l-du -s 47@45:1920x1080-59.94@XR24
setting mode 1920x1080-59.94Hz on connectors 47, crtc 45
[   44.559633] systemd-journald[202]: Successfully sent stream file descriptor to service manager.
^C
root@smarc-rzg3e:~# modetest -M rzg2l-du -s 47@60:1920x1080-59.94@XR24
setting mode 1920x1080-59.94Hz on connectors 47, crtc 60
[   50.450287] kauditd_printk_skb: 5 callbacks suppressed
[   50.450302] audit: type=1334 audit(946684832.636:22): prog-id=18 op=UNLOAD
[   50.462403] audit: type=1334 audit(946684832.636:23): prog-id=17 op=UNLOAD
[   50.469318] audit: type=1334 audit(946684832.636:24): prog-id=16 op=UNLOAD
^C
root@smarc-rzg3e:~# echo s2idle > /sys/power/mem_sleep
root@smarc-rzg3e:~# echo mem > /sys/power/state
[   55.950242] PM: suspend entry (s2idle)
[   55.954103] Filesystems sync: 0.000 seconds
[   55.964559] Freezing user space processes
[   55.970155] Freezing user space processes completed (elapsed 0.001 seconds)
[   55.977115] OOM killer disabled.
[   55.980337] Freezing remaining freezable tasks
[   55.986028] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   56.116254] renesas-gbeth 15c30000.ethernet end0: Link is Down
[   58.164169] dwmac4: Master AXI performs any burst length
[   58.169653] renesas-gbeth 15c30000.ethernet end0: No Safety Features support found
[   58.177374] renesas-gbeth 15c30000.ethernet end0: IEEE 1588-2008 Advanced Timestamp supported
[   58.186087] renesas-gbeth 15c30000.ethernet end0: configuring for phy/rgmii-id link mode
[   58.203707] dwmac4: Master AXI performs any burst length
[   58.209154] renesas-gbeth 15c40000.ethernet end1: No Safety Features support found
[   58.216866] renesas-gbeth 15c40000.ethernet end1: IEEE 1588-2008 Advanced Timestamp supported
[   58.225526] renesas-gbeth 15c40000.ethernet end1: configuring for phy/rgmii-id link mode
[   58.281889] usb usb1: root hub lost power or was reset
[   58.287057] usb usb2: root hub lost power or was reset
[   58.368314] usb usb5: root hub lost power or was reset
[   58.373641] usb usb6: root hub lost power or was reset
[   58.456301] usb usb4: root hub lost power or was reset
[   58.461640] usb usb3: root hub lost power or was reset
[   58.666593] usb 6-1: reset high-speed USB device number 2 using ehci-platform
[   58.926707] OOM killer enabled.
[   58.929875] Restarting tasks: Starting
[   58.934849] Restarting tasks: Done
[   58.939359] random: crng reseeded on system resumption
[   58.951835] PM: suspend exit
root@smarc-rzg3e:~# [   60.725440] renesas-gbeth 15c30000.ethernet end0: Link is Up - 1Gbps/Full - flow control off

root@smarc-rzg3e:~# 
root@smarc-rzg3e:~# 
root@smarc-rzg3e:~# 
root@smarc-rzg3e:~# modetest -M rzg2l-du
Encoders:
id      crtc    type    possible crtcs  possible clones
46      45      none    0x00000003      0x00000001

Connectors:
id      encoder status          name            size (mm)       modes   encoders
47      46      connected       HDMI-A-1        700x390         30      46
  modes:
        index name refresh (Hz) hdisp hss hse htot vdisp vss vse vtot
  #0 1920x1080 60.00 1920 2008 2052 2200 1080 1084 1089 1125 148500 flags: phsync, pvsync; type: preferred, driver
  #1 1920x1080 59.94 1920 2008 2052 2200 1080 1084 1089 1125 148352 flags: phsync, pvsync; type: driver
  #2 1920x1080 50.00 1920 2448 2492 2640 1080 1084 1089 1125 148500 flags: phsync, pvsync; type: driver
  #3 1680x1050 59.88 1680 1728 1760 1840 1050 1053 1059 1080 119000 flags: phsync, nvsync; type: driver
  #4 1600x900 60.00 1600 1624 1704 1800 900 901 904 1000 108000 flags: phsync, pvsync; type: driver
  #5 1280x1024 75.02 1280 1296 1440 1688 1024 1025 1028 1066 135000 flags: phsync, pvsync; type: driver
  #6 1280x1024 60.02 1280 1328 1440 1688 1024 1025 1028 1066 108000 flags: phsync, pvsync; type: driver
  #7 1440x900 59.90 1440 1488 1520 1600 900 903 909 926 88750 flags: phsync, nvsync; type: driver
  #8 1280x800 59.91 1280 1328 1360 1440 800 803 809 823 71000 flags: phsync, nvsync; type: driver
  #9 1152x864 75.00 1152 1216 1344 1600 864 865 868 900 108000 flags: phsync, pvsync; type: driver
  #10 1280x720 60.00 1280 1390 1430 1650 720 725 730 750 74250 flags: phsync, pvsync; type: driver
  #11 1280x720 59.94 1280 1390 1430 1650 720 725 730 750 74176 flags: phsync, pvsync; type: driver
  #12 1280x720 50.00 1280 1720 1760 1980 720 725 730 750 74250 flags: phsync, pvsync; type: driver
  #13 1024x768 75.03 1024 1040 1136 1312 768 769 772 800 78750 flags: phsync, pvsync; type: driver
  #14 1024x768 70.07 1024 1048 1184 1328 768 771 777 806 75000 flags: nhsync, nvsync; type: driver
  #15 1024x768 60.00 1024 1048 1184 1344 768 771 777 806 65000 flags: nhsync, nvsync; type: driver
  #16 832x624 74.55 832 864 928 1152 624 625 628 667 57284 flags: nhsync, nvsync; type: driver
  #17 800x600 75.00 800 816 896 1056 600 601 604 625 49500 flags: phsync, pvsync; type: driver
  #18 800x600 72.19 800 856 976 1040 600 637 643 666 50000 flags: phsync, pvsync; type: driver
  #19 800x600 60.32 800 840 968 1056 600 601 605 628 40000 flags: phsync, pvsync; type: driver
  #20 800x600 56.25 800 824 896 1024 600 601 603 625 36000 flags: phsync, pvsync; type: driver
  #21 720x576 50.00 720 732 796 864 576 581 586 625 27000 flags: nhsync, nvsync; type: driver
  #22 720x480 60.00 720 736 798 858 480 489 495 525 27027 flags: nhsync, nvsync; type: driver
  #23 720x480 59.94 720 736 798 858 480 489 495 525 27000 flags: nhsync, nvsync; type: driver
  #24 640x480 75.00 640 656 720 840 480 481 484 500 31500 flags: nhsync, nvsync; type: driver
  #25 640x480 72.81 640 664 704 832 480 489 492 520 31500 flags: nhsync, nvsync; type: driver
  #26 640x480 66.67 640 704 768 864 480 483 486 525 30240 flags: nhsync, nvsync; type: driver
  #27 640x480 60.00 640 656 752 800 480 490 492 525 25200 flags: nhsync, nvsync; type: driver
  #28 640x480 59.94 640 656 752 800 480 490 492 525 25175 flags: nhsync, nvsync; type: driver
  #29 720x400 70.08 720 738 846 900 400 412 414 449 28320 flags: nhsync, pvsync; type: driver
  props:
        1 EDID:
                flags: immutable blob
                blobs:

                value:
                        00ffffffffffff004c2d0070324e4e34
                        0e1f0103804627782a1c02a853459623
                        1b4d58bfef80714f81c0810081809500
                        a9c0b3000101023a801871382d40582c
                        4500ba892100001e000000fd00324b1e
                        5112000a202020202020000000fc0043
                        3332523530780a2020202020000000ff
                        00483443523430303033345a002001f3
                        02031af14690041f1312032309070783
                        01000066030c00100080023a80d07238
                        2d40102c4580ba892100001e011d0072
                        51d01e206e285500ba892100001e011d
                        00bc52d01e20b8285540ba892100001e
                        8c0ad08a20e02d10103e9600ba892100
                        00182a4480a07038274030203500ba89
                        2100001a00000000000000000000002c
        2 DPMS:
                flags: enum
                enums: On=0 Standby=1 Suspend=2 Off=3
                value: 0
        5 link-status:
                flags: enum
                enums: Good=0 Bad=1
                value: 0
        7 non-desktop:
                flags: immutable range
                values: 0 1
                value: 0
        4 TILE:
                flags: immutable blob
                blobs:

                value:
        48 max bpc:
                flags: range
                values: 8 8
                value: 8
        49 color format:
                flags: enum
                enums: AUTO=0 RGB=1
                value: 0

CRTCs:
id      fb      pos     size
45      62      (0,0)   (1920x1080)
  #0 1920x1080 60.00 1920 2008 2052 2200 1080 1084 1089 1125 148500 flags: phsync, pvsync; type: preferred, driver
  props:
        25 VRR_ENABLED:
                flags: range
                values: 0 1
                value: 0
60      0       (0,0)   (0x0)
  #0  nan 0 0 0 0 0 0 0 0 0 flags: ; type: 
  props:
        25 VRR_ENABLED:
                flags: range
                values: 0 1
                value: 0

Planes:
id      crtc    fb      CRTC x,y        x,y     gamma size      possible crtcs
35      45      62      0,0             0,0     0               0x00000001
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 1
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        37 alpha:
                flags: range
                values: 0 65535
                value: 65535
        38 zpos:
                flags: range
                values: 0 1
                value: 0
        39 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0
40      0       0       0,0             0,0     0               0x00000001
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 0
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        42 alpha:
                flags: range
                values: 0 65535
                value: 65535
        43 zpos:
                flags: range
                values: 0 1
                value: 1
        44 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0
50      0       0       0,0             0,0     0               0x00000002
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 1
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        52 alpha:
                flags: range
                values: 0 65535
                value: 65535
        53 zpos:
                flags: range
                values: 0 1
                value: 0
        54 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0
55      0       0       0,0             0,0     0               0x00000002
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 0
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        57 alpha:
                flags: range
                values: 0 65535
                value: 65535
        58 zpos:
                flags: range
                values: 0 1
                value: 1
        59 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0

Frame buffers:
id      size    pitch

root@smarc-rzg3e:~# modetest -M rzg2l-du -s 47@45:1920x1080-59.94@XR24
setting mode 1920x1080-59.94Hz on connectors 47, crtc 45
^C
root@smarc-rzg3e:~# modetest -M rzg2l-du -s 47@60:1920x1080-59.94@XR24
setting mode 1920x1080-59.94Hz on connectors 47, crtc 60
^C
root@smarc-rzg3e:~# echo deep > /sys/power/mem_sleep
root@smarc-rzg3e:~# echo mem > /sys/power/state
[   86.526300] PM: suspend entry (deep)
[   86.529989] Filesystems sync: 0.000 seconds
[   86.543798] Freezing user space processes
[   86.549193] Freezing user space processes completed (elapsed 0.001 seconds)
[   86.556145] OOM killer disabled.
[   86.559367] Freezing remaining freezable tasks
[   86.565016] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   86.684418] renesas-gbeth 15c30000.ethernet end0: Link is Down
[   86.706835] Disabling non-boot CPUs ...
[   86.715969] psci: CPU3 killed (polled 0 ms)
[   86.728817] psci: CPU2 killed (polled 0 ms)
[   86.741605] psci: CPU1 killed (polled 0 ms)
NOTICE:  BL2: v2.10.5(release):2.10.5/rz_soc_dev-169-g1410189b0
NOTICE:  BL2: Built : 17:45:23, Jul 30 2025
NOTICE:  BL2: SYS_LSI_MODE: 0x13e06
NOTICE:  BL2: SYS_LSI_DEVID: 0x8679447
NOTICE:  BL2: SYS_LSI_PRR: 0x0
NOTICE:  BL2: Booting BL31
[   86.750589] Enabling non-boot CPUs ...
[   86.754920] GICv3: CPU1: found redistributor 100 region 0:0x0000000014960000
[   86.754960] CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
[   86.755931] CPU1 is up
[   86.772062] GICv3: CPU2: found redistributor 200 region 0:0x0000000014980000
[   86.772085] CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
[   86.772773] CPU2 is up
[   86.788895] GICv3: CPU3: found redistributor 300 region 0:0x00000000149a0000
[   86.788918] CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
[   86.789790] CPU3 is up
[   86.825010] rzv2h-cpg 10420000.clock-controller: Failed to enable CLK_ON 0x63c/adg_0_audio_clka
[   86.840289] dwmac4: Master AXI performs any burst length
[   86.845741] renesas-gbeth 15c30000.ethernet end0: No Safety Features support found
[   86.853480] renesas-gbeth 15c30000.ethernet end0: IEEE 1588-2008 Advanced Timestamp supported
[   86.862207] renesas-gbeth 15c30000.ethernet end0: configuring for phy/rgmii-id link mode
[   86.879788] dwmac4: Master AXI performs any burst length
[   86.885260] renesas-gbeth 15c40000.ethernet end1: No Safety Features support found
[   86.892958] renesas-gbeth 15c40000.ethernet end1: IEEE 1588-2008 Advanced Timestamp supported
[   86.901615] renesas-gbeth 15c40000.ethernet end1: configuring for phy/rgmii-id link mode
[   86.958678] usb usb1: root hub lost power or was reset
[   86.963847] usb usb2: root hub lost power or was reset
[   87.044240] usb usb5: root hub lost power or was reset
[   87.049560] usb usb6: root hub lost power or was reset
[   87.132269] usb usb4: root hub lost power or was reset
[   87.137619] usb usb3: root hub lost power or was reset
[   87.342563] usb 6-1: reset high-speed USB device number 2 using ehci-platform
[   87.602717] OOM killer enabled.
[   87.605883] Restarting tasks: Starting
[   87.610733] Restarting tasks: Done
[   87.614240] random: crng reseeded on system resumption
[   87.628591] PM: suspend exit
root@smarc-rzg3e:~# 
root@smarc-rzg3e:~# 
root@smarc-rzg3e:~# modetest -M rzg2l-du
Encoders:
id      crtc    type    possible crtcs  possible clones
46      45      none    0x00000003      0x00000001

Connectors:
id      encoder status          name            size (mm)       modes   encoders
47      46      connected       HDMI-A-1        700x390         30      46
  modes:
        index name refresh (Hz) hdisp hss hse htot vdisp vss vse vtot
  #0 1920x1080 60.00 1920 2008 2052 2200 1080 1084 1089 1125 148500 flags: phsync, pvsync; type: preferred, driver
  #1 1920x1080 59.94 1920 2008 2052 2200 1080 1084 1089 1125 148352 flags: phsync, pvsync; type: driver
  #2 1920x1080 50.00 1920 2448 2492 2640 1080 1084 1089 1125 148500 flags: phsync, pvsync; type: driver
  #3 1680x1050 59.88 1680 1728 1760 1840 1050 1053 1059 1080 119000 flags: phsync, nvsync; type: driver
  #4 1600x900 60.00 1600 1624 1704 1800 900 901 904 1000 108000 flags: phsync, pvsync; type: driver
  #5 1280x1024 75.02 1280 1296 1440 1688 1024 1025 1028 1066 135000 flags: phsync, pvsync; type: driver
  #6 1280x1024 60.02 1280 1328 1440 1688 1024 1025 1028 1066 108000 flags: phsync, pvsync; type: driver
  #7 1440x900 59.90 1440 1488 1520 1600 900 903 909 926 88750 flags: phsync, nvsync; type: driver
  #8 1280x800 59.91 1280 1328 1360 1440 800 803 809 823 71000 flags: phsync, nvsync; type: driver
  #9 1152x864 75.00 1152 1216 1344 1600 864 865 868 900 108000 flags: phsync, pvsync; type: driver
  #10 1280x720 60.00 1280 1390 1430 1650 720 725 730 750 74250 flags: phsync, pvsync; type: driver
  #11 1280x720 59.94 1280 1390 1430 1650 720 725 730 750 74176 flags: phsync, pvsync; type: driver
  #12 1280x720 50.00 1280 1720 1760 1980 720 725 730 750 74250 flags: phsync, pvsync; type: driver
  #13 1024x768 75.03 1024 1040 1136 1312 768 769 772 800 78750 flags: phsync, pvsync; type: driver
  #14 1024x768 70.07 1024 1048 1184 1328 768 771 777 806 75000 flags: nhsync, nvsync; type: driver
  #15 1024x768 60.00 1024 1048 1184 1344 768 771 777 806 65000 flags: nhsync, nvsync; type: driver
  #16 832x624 74.55 832 864 928 1152 624 625 628 667 57284 flags: nhsync, nvsync; type: driver
  #17 800x600 75.00 800 816 896 1056 600 601 604 625 49500 flags: phsync, pvsync; type: driver
  #18 800x600 72.19 800 856 976 1040 600 637 643 666 50000 flags: phsync, pvsync; type: driver
  #19 800x600 60.32 800 840 968 1056 600 601 605 628 40000 flags: phsync, pvsync; type: driver
  #20 800x600 56.25 800 824 896 1024 600 601 603 625 36000 flags: phsync, pvsync; type: driver
  #21 720x576 50.00 720 732 796 864 576 581 586 625 27000 flags: nhsync, nvsync; type: driver
  #22 720x480 60.00 720 736 798 858 480 489 495 525 27027 flags: nhsync, nvsync; type: driver
  #23 720x480 59.94 720 736 798 858 480 489 495 525 27000 flags: nhsync, nvsync; type: driver
  #24 640x480 75.00 640 656 720 840 480 481 484 500 31500 flags: nhsync, nvsync; type: driver
  #25 640x480 72.81 640 664 704 832 480 489 492 520 31500 flags: nhsync, nvsync; type: driver
  #26 640x480 66.67 640 704 768 864 480 483 486 525 30240 flags: nhsync, nvsync; type: driver
  #27 640x480 60.00 640 656 752 800 480 490 492 525 25200 flags: nhsync, nvsync; type: driver
  #28 640x480 59.94 640 656 752 800 480 490 492 525 25175 flags: nhsync, nvsync; type: driver
  #29 720x400 70.08 720 738 846 900 400 412 414 449 28320 flags: nhsync, pvsync; type: driver
  props:
        1 EDID:
                flags: immutable blob
                blobs:

                value:
                        00ffffffffffff004c2d0070324e4e34
                        0e1f0103804627782a1c02a853459623
                        1b4d58bfef80714f81c0810081809500
                        a9c0b3000101023a801871382d40582c
                        4500ba892100001e000000fd00324b1e
                        5112000a202020202020000000fc0043
                        3332523530780a2020202020000000ff
                        00483443523430303033345a002001f3
                        02031af14690041f1312032309070783
                        01000066030c00100080023a80d07238
                        2d40102c4580ba892100001e011d0072
                        51d01e206e285500ba892100001e011d
                        00bc52d01e20b8285540ba892100001e
                        8c0ad08a20e02d10103e9600ba892100
                        00182a4480a07038274030203500ba89
                        2100001a00000000000000000000002c
        2 DPMS:
                flags: enum
                enums: On=0 Standby=1 Suspend=2 Off=3
                value: 0
        5 link-status:
                flags: enum
                enums: Good=0 Bad=1
                value: 0
        7 non-desktop:
                flags: immutable range
                values: 0 1
                value: 0
        4 TILE:
                flags: immutable blob
                blobs:

                value:
        48 max bpc:
                flags: range
                values: 8 8
                value: 8
        49 color format:
                flags: enum
                enums: AUTO=0 RGB=1
                value: 0

CRTCs:
id      fb      pos     size
45      62      (0,0)   (1920x1080)
  #0 1920x1080 60.00 1920 2008 2052 2200 1080 1084 1089 1125 148500 flags: phsync, pvsync; type: preferred, driver
  props:
        25 VRR_ENABLED:
                flags: range
                values: 0 1
                value: 0
60      0       (0,0)   (0x0)
  #0  nan 0 0 0 0 0 0 0 0 0 flags: ; type: 
  props:
        25 VRR_ENABLED:
                flags: range
                values: 0 1
                value: 0

Planes:
id      crtc    fb      CRTC x,y        x,y     gamma size      possible crtcs
35      45      62      0,0             0,0     0               0x00000001
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 1
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        37 alpha:
                flags: range
                values: 0 65535
                value: 65535
        38 zpos:
                flags: range
                values: 0 1
                value: 0
        39 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0
40      0       0       0,0             0,0     0               0x00000001
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 0
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        42 alpha:
                flags: range
                values: 0 65535
                value: 65535
        43 zpos:
                flags: range
                values: 0 1
                value: 1
        44 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0
50      0       0       0,0             0,0     0               0x00000002
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 1
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        52 alpha:
                flags: range
                values: 0 65535
                value: 65535
        53 zpos:
                flags: range
                values: 0 1
                value: 0
        54 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0
55      0       0       0,0             0,0     0               0x00000002
  formats: RGB8 AR12 XR12 AR15 XR15 RG16 BG24 RG24 BA24 BX24 AR24 XR24 UYVY YUYV YVYU NV12 NV21 NV16 NV61 YU12 YV12 YU16 YV16 YU24 YV24
  props:
        9 type:
                flags: immutable enum
                enums: Overlay=0 Primary=1 Cursor=2
                value: 0
        32 IN_FORMATS:
                flags: immutable blob
                blobs:

                value:
                        01000000000000001900000018000000
                        01000000800000005247423841523132
                        58523132415231355852313552473136
                        42473234524732344241323442583234
                        41523234585232345559565959555956
                        595659554e5631324e5632314e563136
                        4e563631595531325956313259553136
                        59563136595532345956323400000000
                        ffffff01000000000000000000000000
                        0000000000000000
                in_formats blob decoded:
                         RGB8:  LINEAR(0x0)
                         AR12:  LINEAR(0x0)
                         XR12:  LINEAR(0x0)
                         AR15:  LINEAR(0x0)
                         XR15:  LINEAR(0x0)
                         RG16:  LINEAR(0x0)
                         BG24:  LINEAR(0x0)
                         RG24:  LINEAR(0x0)
                         BA24:  LINEAR(0x0)
                         BX24:  LINEAR(0x0)
                         AR24:  LINEAR(0x0)
                         XR24:  LINEAR(0x0)
                         UYVY:  LINEAR(0x0)
                         YUYV:  LINEAR(0x0)
                         YVYU:  LINEAR(0x0)
                         NV12:  LINEAR(0x0)
                         NV21:  LINEAR(0x0)
                         NV16:  LINEAR(0x0)
                         NV61:  LINEAR(0x0)
                         YU12:  LINEAR(0x0)
                         YV12:  LINEAR(0x0)
                         YU16:  LINEAR(0x0)
                         YV16:  LINEAR(0x0)
                         YU24:  LINEAR(0x0)
                         YV24:  LINEAR(0x0)
        57 alpha:
                flags: range
                values: 0 65535
                value: 65535
        58 zpos:
                flags: range
                values: 0 1
                value: 1
        59 pixel blend mode:
                flags: enum
                enums: None=2 Pre-multiplied=0 Coverage=1
                value: 0

Frame buffers:
id      size    pitch

root@smarc-rzg3e:~# [  102.244161] systemd-journald[202]: Sent WATCHDOG=1 notification.
modetest -M rzg2l-du -s 47@45:1920x1080-59.94@XR24
setting mode 1920x1080-59.94Hz on connectors 47, crtc 45
^C
root@smarc-rzg3e:~# modetest -M rzg2l-du -s 47@60:1920x1080-59.94@XR24
setting mode 1920x1080-59.94Hz on connectors 47, crtc 60

> 
> > +	}
> > +
> > +	if (IS_ERR(match))
> > +		return PTR_ERR(match);
> 
> Why this error path cannot be inside loop?

component_match_add_release() ignores further calls once the match is an
error pointer, so a single check after the loop is enough.

Kind regards,
Tommaso

> 
> Cheers,
> Biju
> 
> > +
> > +	if (!match)
> > +		return rzg2l_du_drm_init(dev, false);
> > +
> > +	return component_master_add_with_match(dev, &rzg2l_du_master_ops,
> > +match); }
> > +
> > +static void rzg2l_du_instance_remove(struct rzg2l_du_device *du) {
> > +	if (!rzg2l_du_has(du, RZG2L_DU_FEATURE_COMPONENT)) {
> > +		rzg2l_du_drm_fini(du->dev, false);
> > +		return;
> > +	}
> > +
> > +	if (!du->is_master) {
> > +		component_del(du->dev, &rzg2l_du_instance_ops);
> > +		return;
> > +	}
> > +
> > +	component_master_del(du->dev, &rzg2l_du_master_ops);
> > +
> > +	if (du->ddev)
> > +		rzg2l_du_drm_fini(du->dev, false);
> >  }
> > 
> >  /* -----------------------------------------------------------------------------
> > @@ -262,7 +370,7 @@ static void rzg2l_du_drm_fini(struct device *dev)
> > 
> >  static void rzg2l_du_remove(struct platform_device *pdev)  {
> > -	rzg2l_du_drm_fini(&pdev->dev);
> > +	rzg2l_du_instance_remove(platform_get_drvdata(pdev));
> >  }
> > 
> >  static void rzg2l_du_shutdown(struct platform_device *pdev) @@ -304,7 +412,7 @@ static int
> > rzg2l_du_probe(struct platform_device *pdev)
> >  	rcdu->info = info;
> >  	rcdu->mmio = mmio;
> > 
> > -	return rzg2l_du_drm_init(&pdev->dev);
> > +	return rzg2l_du_instance_probe(rcdu);
> >  }
> > 
> >  static struct platform_driver rzg2l_du_platform_driver = { diff --git a/drivers/gpu/drm/renesas/rz-
> > du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > index 2952c9d7348b..4c2e12206d83 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > @@ -21,6 +21,7 @@ struct device;
> >  struct drm_property;
> > 
> >  #define RZG2L_DU_FEATURE_DPIO_OE	BIT(0)	/* Has DPIO output enable control */
> > +#define RZG2L_DU_FEATURE_COMPONENT	BIT(1)	/* Has several DU instances in one DRM device */
> > 
> >  enum rzg2l_du_output {
> >  	RZG2L_DU_OUTPUT_DSI0,
> > @@ -71,6 +72,7 @@ struct rzg2l_du_device {
> > 
> >  	struct drm_device *ddev;
> >  	unsigned int index;
> > +	bool is_master;
> > 
> >  	struct rzg2l_du_crtc crtcs[RZG2L_DU_MAX_CRTCS];
> >  	unsigned int num_crtcs;
> > --
> > 2.54.0
> 
> 
