Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36799606A327
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=c2VnzLuC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A03BA10F5C6;
	Tue, 24 Nov 2026 13:59:48 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011029.outbound.protection.outlook.com [40.107.74.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B565B10F5C6
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:59:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNdVvqMlqDATnSfjXqz5stmq8kbIr5dIe2QMW+z8kLzm6LeVJgTGUFb1maPztBSdQOI//0mn5MUtVsMVw834EGDGZVqefHVkzvahQofMNEFDoXYqAOeqMwSK53vUWFpOOpmOGWHVs169jN1qOswQ8D1ZiaUQwlUa75AA0ikCYbvk/ujT8xMNIjLYux4W6QG6ks2ps8oRYpKk37fkPJTmvIf9QGqF9mAWLdDj72mvH6x/bU7JbloYKVZHbXy5r+Z/Hp2xumXBnLPpsylRF6vVa9MqT1Ekzc55MVu09WboUD/TPslsSCV1UC3oxScQwNU7cLi2il2hLu2n5c9dbaDlrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCPrJExvRzTL+syjRTsslIWGjW+UwfS7cJ/Bttv7R0c=;
 b=fbh0RrsqM8MhppooFqkDWyw3vRxIHvydW0+ZWBbl2tqLbdqXZ6InNEKyW6VubolBdA/sUpC8wUyoD+oR9Zoz7XjzBpFsUr6CUTKV/UXR0K3/h1cULEvwKABM4+WHCT3YGuK7toRNfEFaelAdEhlNU9XeWlhyPnX97gJ9Q+T2AZp8cIl6JeaA6TCkqboVtnar4d/TolBqRSPVoch1Q7mX2uxjqli4FAX6jCOskZZRPd5J63wed3FAeQGKi3W7of54Q9XmOtqrGuJe6hF9ktAmRJEmSdMRLl/Hay2/RyCG6KAsYkUaebFODPQ4D5vrKMoEVO6BRY3fSLXUjn1TDUFHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCPrJExvRzTL+syjRTsslIWGjW+UwfS7cJ/Bttv7R0c=;
 b=c2VnzLuCNmiaUIBPeQkYWClRvyA4bD4DP0+BJrSRUxLoVOlPKA9EK+ovOPp6Pw1ug6F1CEKXPmsfJe8sd28WIECesPWUNiQ3Q8yaZ+VPh1qucajKbZo9jirAxJEoGaQTGeEn5+RleaIx9BIao2xjgsziVlBqqjs+5P8aBg+RpVk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TYWPR01MB8853.jpnprd01.prod.outlook.com
 (2603:1096:400:168::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 13:59:37 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 13:59:37 +0000
Date: Tue, 24 Nov 2026 14:59:19 +0100
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
Message-ID: <awWXLFAbDd_35Q-l@tom-desktop>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <e22a176720a38df652c7f7eabe27219da50f217d.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <TYYPR01MB660397C3B66F6EED53656B2086442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awV6pAtcSz8e9Q74@tom-desktop>
 <TYYPR01MB660334463EC01FCF06F7A9E586442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYYPR01MB660334463EC01FCF06F7A9E586442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: FR4P281CA0270.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::20) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TYWPR01MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: d2d84b70-dcb1-452a-849b-08df4a332d54
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|366016|1800799024|23010399003|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003|261028144727099003|261009221727099003|261102123227099003|261009221227099003|261009223027099003|261009220027099003|261026121527099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261009223327099003|261026140227099003|38350700014|10067099003;
X-Microsoft-Antispam-Message-Info: kj1itGLat09og/8Q3IFB9YxbD4QQhhoOb5rHbb+9mueLbzEdGwQZH7zLDAwAaULl9ljCD4Xd/YwUKoeM3oQAzaTY9UfeePPlJqqZnAm1GdCb1memCTzOvlcJpN+Q1OGI9lx+0XcH3zioGRH64d6Q4BC29AOxEQsPREyI0O/fUjLCW9ABF9oKjOqUbJFmhaC9OUZk0V0ZvcowFEHpjgQUJJjx0CKiSgE/12fq95sXmAsvPZIrjrKP4vPbB//Jh6rg4JBplfwS4tnnk8YE/zXVZyoE5emGOlWS/zCDDZg/+sxABTW3znPVY1fO8txEpfCsQwe1ufhIzYZ+eBdNLaqLShOshoig/cLapokifYbtfXkCJ+vY8Tg8+suD3Nfn7j1KNq3ExY/cv9wx+Gi1nZYXkiEENfWHEJZ1YJilqA0EBrFtpRrHPsr4v2RHfqDcvk2sLTN3wqnXRAtGvcmcXIhlxIMy7dwuZBpFb7EzrKwmh20km+3bKoDxORSeqyzV/VIydXxRQrJ+ctlMQIWePXcgXI/sQeLN5fZUlojB7M1/XdZ40uL+opn3oA5+bBuyEXSYPDC7LA27fv6FplAdjalp3viyBao/cP+OtUioexuQWihnGN9pkDJl0IHl9qBpclx25MH8X2+b7MWOEtEAO31V7YURqYnAUnTqpuLnHAgO7r8/lUog7qVIAWYYjX94oj1xIYm9Qv9XNbUL4LYmrg5xsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261028144727099003)(261009221727099003)(261102123227099003)(261009221227099003)(261009223027099003)(261009220027099003)(261026121527099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261009223327099003)(261026140227099003)(38350700014)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?4ICeDFtPAF/8G+0W+9mE56QEeCqO4Kb8cjnhnZh9kBHzfy88hjg3Jfk4Dy?=
 =?iso-8859-1?Q?x1i/ltoABM+UO412slBEJr0fLgmKZlsemYkLFwmJ31qIXywEkS0HcN9G1K?=
 =?iso-8859-1?Q?nyrCd82U1N6AjGmaGklfbwguu11Tl4+eIeFfUVV9XN8gkNY508ZyJImLKS?=
 =?iso-8859-1?Q?7CleBRRxmBKMBGtWZA6cJYmN+zS1Rq3Ed4ANhe3Ezzm/eT3N55DRMh4XgS?=
 =?iso-8859-1?Q?64nd7v7SnestzUR+/fVUwILzL/xVIfWB5YrkNEDnvebA1EyCIa+VIojdeT?=
 =?iso-8859-1?Q?b3mS5CVgEHqZEAM5tiu7UAgezZFZlSMITjDxxEl2/Q6JK0XvBiqv7CDtZb?=
 =?iso-8859-1?Q?Mzwd+mKfQmjWiV7xxNL1ibdMhA/QK9CN0EJphQE+yM7Y5MiZbdGpD2xEm2?=
 =?iso-8859-1?Q?woS0uVQ/dTMqa5mk7UZZ9TRKw+QuD5Re5me2+gBgJDzAsu1yC1/h34AW2S?=
 =?iso-8859-1?Q?8NOsx54+UX3BkgHjMZVdvOg2OhnVQKpWSxrqTZjvRdNcgDCNHYnF4zbeF/?=
 =?iso-8859-1?Q?LRQHuhMuBDgaqkVN4sURpq4Tf1Ece7JeiR/W8rX4Vz6GpHnf3ElIrVFhu2?=
 =?iso-8859-1?Q?PREERPEVee6F17I2PxPJ1oYtkmQJRu7qI3C0GTOG08AMmcpRupK/W26wOQ?=
 =?iso-8859-1?Q?9TZLDywXX0f979XciWiouYeYZYb1JEHwGzOsN6OBWI3LKBq4AINcE2l5cJ?=
 =?iso-8859-1?Q?HdrryfIDnDCWxKCHUpt9iGRaiLHVVAJlgth1sxPKIetwgvFNBW2cttelwX?=
 =?iso-8859-1?Q?UuMWigFeK/Hu7cKzTSJpar6M8nM5OUOw+gFWenRVe4QHYoRmTqdwDP7pyz?=
 =?iso-8859-1?Q?QL7lbA20DiafhsmAWRlU76rUbaj1ctstr6QOaz4bl/F0upzD5nDUmr6IYo?=
 =?iso-8859-1?Q?Pkmi863PrmHJ6rIR0crRm6OIoGC1DmItFKprGIQPCUDkBSeosDsR6brGZM?=
 =?iso-8859-1?Q?oOjTkFWrklK6pk2GYVTgOduLLSg8L1v4izeoNe0GeHWw0P6kq6biZ/JutT?=
 =?iso-8859-1?Q?3hHixJfOGrXGXkp1n4G/9vwri2qYBZoNDdWewPQoNi3NgPsTh2AHVzyR4n?=
 =?iso-8859-1?Q?ojX+EbvSMWZdWtPqbOvvbFjGC0c9IGSLI0oZzpVb7TLiF6hdEfgY9b/8qb?=
 =?iso-8859-1?Q?m8cyT34k8jr9JN6jj38Y2R0JfabAOLOEmuQROLAOhwgQkJKBfVgvofa1b4?=
 =?iso-8859-1?Q?nbTLJoWWzgpv4xg8YCMaJCymoA114D6VyfABjm7q1ttH3a5j1q3jYErn0+?=
 =?iso-8859-1?Q?UIIhynS+tjqLrOPoI/cPdE8ey419RFV3HDhGsmJ0qV3eylOqsbga218aPP?=
 =?iso-8859-1?Q?aU7i9pl8nXrvc1sL7PipvnnsSnE/IbxqdH4xMwLPk8R0uT7wXbCFZpto3X?=
 =?iso-8859-1?Q?GFpKYInfAJbtx3N6zTJwLH7wvVfDi5HlgxmJMDk2EMSN/LsDrP76M/kCVH?=
 =?iso-8859-1?Q?drbhZnsEAiYCfdfX6cCCSWHJui13fojaBgGD9gBWZ/c0wFd4A8ZLzPBW8x?=
 =?iso-8859-1?Q?gmrD18Q2dhl59PcXv0MFMsmi3Mznlzy/Xo9sBsT77Ja2kZnfy8DuPmvZSe?=
 =?iso-8859-1?Q?F4Le6P5yrTfORlbeJoC/khR8qJonwUSU4Tj/OowWra4miltMlU2ggYKBGL?=
 =?iso-8859-1?Q?xiw3Xlz2DeHZIsv3LqgTS1NcGnQL0088UFsWn/J6ZTmg6HNPgpJMNQ2ve3?=
 =?iso-8859-1?Q?1IqxB6wjA0z4KKXDGXCfurDzgV158ixSJk0FDCKfSVrsDf/gWRHnN/LeVf?=
 =?iso-8859-1?Q?UWGExHqaZeee6Sm94H4mkctcD8+DUJil6DRKLlnqVaCo9+dFoZUjd/vrx1?=
 =?iso-8859-1?Q?s2xksjAfHophhutIcTSlZdJIfv1Mbi9+wG/g1uOw0PIk4ZFT/etv?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d84b70-dcb1-452a-849b-08df4a332d54
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:59:37.7577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLP0CpPTzFeYyIH5e0RtVmnwfLsjZ/EwtziS75PynyH6sWzcBFk1u9+F829YmRnK9QqBII7iMwtOXFPPmI5LwCPkBMtTQTeq4X2JA0weiGEWCDg/cZNZySKqUz/HWJc6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8853
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

On Tue, Nov 24, 2026 at 01:18:43PM +0000, Biju Das wrote:
> Hi Tommaso,
> 
> > -----Original Message-----
> > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > Sent: 24 November 2026 11:53
> > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU instances in one DRM device
> > 
> > Hi Biju,
> > Thanks for your review.
> > 
> > On Tue, Nov 24, 2026 at 07:47:04AM +0000, Biju Das wrote:
> > > Hi Tommaso,
> > >
> > > > -----Original Message-----
> > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > Sent: 13 November 2026 12:20
> > > > Subject: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU instances in one DRM device
> > > >
> > > > RZ/G3E has two DU instances that share a single DRM device.
> > > >
> > > > Add an RZG2L_DU_FEATURE_COMPONENT flag and use the component framework for it. The first available
> > DU
> > > > instance is the master and creates the DRM device, the other one binds to it as a component.
> > > >
> > > > If only one DU instance is available, it creates the DRM device directly at probe time, as on SoCs
> > > > without the flag.
> > > >
> > > > Set the index of each instance to the number of CRTCs already created.
> > > >
> > > > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > ---
> > > > v9->v10:
> > > >  - New patch.
> > > >
> > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 118 ++++++++++++++++++-
> > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h |   2 +
> > > >  2 files changed, 115 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-
> > > > du/rzg2l_du_drv.c
> > > > index 93d59e2cf8a4..873586f2ef28 100644
> > > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > @@ -7,6 +7,7 @@
> > > >   * Based on rcar_du_drv.c
> > > >   */
> > > >
> > > > +#include <linux/component.h>
> > > >  #include <linux/dma-mapping.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/of.h>
> > > > @@ -14,10 +15,12 @@
> > > >
> > > >  #include <drm/clients/drm_client_setup.h>  #include <drm/drm_atomic_helper.h>
> > > > +#include <drm/drm_crtc.h>
> > > >  #include <drm/drm_drv.h>
> > > >  #include <drm/drm_fbdev_dma.h>
> > > >  #include <drm/drm_gem_dma_helper.h>
> > > >  #include <drm/drm_managed.h>
> > > > +#include <drm/drm_of.h>
> > > >  #include <drm/drm_print.h>
> > > >  #include <drm/drm_probe_helper.h>
> > > >
> > > > @@ -170,6 +173,7 @@ static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
> > > >  				  struct drm_device *ddev)
> > > >  {
> > > >  	struct rzg2l_du_device *rcdu;
> > > > +	int ret;
> > > >
> > > >  	rcdu = drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
> > > >  	if (!rcdu)
> > > > @@ -180,9 +184,28 @@ static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
> > > >  	rcdu->mmio = du->mmio;
> > > >  	rcdu->ddev = ddev;
> > > >
> > > > -	return rzg2l_du_modeset_init_du(rcdu);
> > > > +	rcdu->index = ddev->mode_config.num_crtc;
> > > > +
> > > > +	ret = rzg2l_du_modeset_init_du(rcdu);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	if (WARN_ON(drm_crtc_index(&rcdu->crtcs[0].crtc) != rcdu->index))
> > > > +		return -EINVAL;
> > > > +
> > > > +	return 0;
> > > >  }
> > > >
> > > > +static int rzg2l_du_instance_bind(struct device *dev, struct device *master,
> > > > +				  void *data)
> > > > +{
> > > > +	return rzg2l_du_instance_init(dev_get_drvdata(dev), data); }
> > > > +
> > > > +static const struct component_ops rzg2l_du_instance_ops = {
> > > > +	.bind = rzg2l_du_instance_bind,
> > > > +};
> > > > +
> > > >  /* -----------------------------------------------------------------------------
> > > >   * DRM device
> > > >   */
> > > > @@ -191,7 +214,7 @@ struct rzg2l_du_drm {
> > > >  	struct drm_device ddev;
> > > >  };
> > > >
> > > > -static int rzg2l_du_drm_init(struct device *dev)
> > > > +static int rzg2l_du_drm_init(struct device *dev, bool has_components)
> > > >  {
> > > >  	struct rzg2l_du_device *du = dev_get_drvdata(dev);
> > > >  	struct rzg2l_du_drm *rzgdrm;
> > > > @@ -213,6 +236,12 @@ static int rzg2l_du_drm_init(struct device *dev)
> > > >  	if (ret < 0)
> > > >  		goto error;
> > > >
> > > > +	if (has_components) {
> > > > +		ret = component_bind_all(dev, ddev);
> > > > +		if (ret < 0)
> > > > +			goto error;
> > > > +	}
> > > > +
> > > >  	ret = rzg2l_du_modeset_init_finish(ddev);
> > > >  	if (ret < 0)
> > > >  		goto error_fini;
> > > > @@ -235,6 +264,8 @@ static int rzg2l_du_drm_init(struct device *dev)
> > > >
> > > >  error_fini:
> > > >  	drm_kms_helper_poll_fini(ddev);
> > > > +	if (has_components)
> > > > +		component_unbind_all(dev, ddev);
> > > >  error:
> > > >  	/*
> > > >  	 * Don't use dev_err_probe(), as it would overwrite the probe deferral @@ -246,7 +277,7 @@
> > > > static int rzg2l_du_drm_init(struct device *dev)
> > > >  	return ret;
> > > >  }
> > > >
> > > > -static void rzg2l_du_drm_fini(struct device *dev)
> > > > +static void rzg2l_du_drm_fini(struct device *dev, bool has_components)
> > > >  {
> > > >  	struct rzg2l_du_device *du = dev_get_drvdata(dev);
> > > >  	struct drm_device *ddev = du->ddev;
> > > > @@ -254,6 +285,83 @@ static void rzg2l_du_drm_fini(struct device *dev)
> > > >  	drm_dev_unregister(ddev);
> > > >  	drm_atomic_helper_shutdown(ddev);
> > > >  	drm_kms_helper_poll_fini(ddev);
> > > > +
> > > > +	if (has_components)
> > > > +		component_unbind_all(dev, ddev);
> > > > +
> > > > +	du->ddev = NULL;
> > > > +}
> > > > +
> > > > +/*
> > > > +-----------------------------------------------------------------------
> > > > +------
> > > > + * Component master
> > > > + */
> > > > +
> > > > +static int rzg2l_du_master_bind(struct device *dev) {
> > > > +	return rzg2l_du_drm_init(dev, true);
> > > > +}
> > > > +
> > > > +static void rzg2l_du_master_unbind(struct device *dev) {
> > > > +	rzg2l_du_drm_fini(dev, true);
> > > > +}
> > > > +
> > > > +static const struct component_master_ops rzg2l_du_master_ops = {
> > > > +	.bind = rzg2l_du_master_bind,
> > > > +	.unbind = rzg2l_du_master_unbind,
> > > > +};
> > > > +
> > > > +static int rzg2l_du_instance_probe(struct rzg2l_du_device *du) {
> > > > +	struct component_match *match = NULL;
> > > > +	const struct of_device_id *of_id;
> > > > +	struct device *dev = du->dev;
> > > > +
> > > > +	if (!rzg2l_du_has(du, RZG2L_DU_FEATURE_COMPONENT))
> > > > +		return rzg2l_du_drm_init(dev, false);
> > > > +
> > > > +	for_each_available_child_of_node_scoped(dev->of_node->parent, np) {
> > > > +		of_id = of_match_node(dev->driver->of_match_table, np);
> > > > +		if (!of_id || of_id->data != du->info)
> > > > +			continue;
> > > > +
> > > > +		/* The first available DU instance is the component master. */
> > > > +		if (!du->is_master) {
> > > > +			if (np != dev->of_node)
> > > > +				return component_add(dev, &rzg2l_du_instance_ops);
> > > > +
> > > > +			du->is_master = true;
> > > > +			continue;
> > > > +		}
> > > > +
> > > > +		drm_of_component_match_add(dev, &match, component_compare_of, np);
> > >
> > >
> > > The master is chosen purely by DT order. If the first available DU never probes,
> > > the second never gets a DRM device. How do you handle this case?
> > 
> > All available instances are part of the component match, so the DRM
> > device is only created once all of them have probed, whichever one is
> > the master.
> > 
> > This is how the component framework works.
> > 
> > To use a single DU, the other one can be disabled in DT, in this case
> > the remaining instance becomes the master and initializes the DRM
> > device on its own.
> 
> 
> Assume both DU's available and run time
> 
> second DU is probed first and master never probed at all.
> What is the state of second DU as bind never calls?


The second DU probes, registers itself with component_add() and stays
idle, without touching the hardware. 

When the master probes, both instances are bound and the DRM device is
created.

If the master never probes, there is no DRM device, because the bind is
only triggered once the master has registered the aggregate device with
component_master_add_with_match()

Kind regards,
Tommaso

> 
> 
> 
> 
> > >
> > > > +	}
> > > > +
> > > > +	if (IS_ERR(match))
> > > > +		return PTR_ERR(match);
> > >
> > > Why this error path cannot be inside loop?
> > 
> > component_match_add_release() ignores further calls once the match is an
> > error pointer, so a single check after the loop is enough.
> 
> If there is an error, you can do early return, instead of keep looping.

Then we will have:

		drm_of_component_match_add(dev, &match, component_compare_of, np);
		if (IS_ERR(match))
			return PTR_ERR(match);
	}

	if (!match)
		return rzg2l_du_drm_init(dev, false);

Ok for me, thanks.

Kind regards,
Tommaso


> 
> Cheers,
> Biju
> 
