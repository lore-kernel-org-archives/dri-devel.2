Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697BD606A329
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=r+DEk+Oq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5BC110F6D1;
	Tue, 24 Nov 2026 14:53:18 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazon11011029.outbound.protection.outlook.com [40.107.74.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27EBD10F6C6
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:53:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsdJFqQPldAZN/zrE6PAxf4B8tWB7DKnGA4JPa1YEzjJ4RNHxoPIbuV1PpuVNWuXOPhR+n7W5inEljIcqklf8WSl95QP9N4aZwlbjuZ8SQQzWdTaLEivF+HWuHCyu/i41+31hPTeeaUpe33CF3NV588yaHSomhhNOkEqW6DW5z6lxxALEI9OzSAAqzQ3mnR9/gv+cF3nzQ6eGBqLeh5mNFlvBOgI0EaE1MY5pyVY1e1SXU40gs+FSJYZ/0GKfiN+5yc7MpnFJvP2JAFqYWrFahtW5BKEvs7sj4gzdBIuA9HQ1XQSWHK3qEh4IyUmTIGo51H6sI5f6zhWizzc+1yg1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jg8iPxnz26e3hiucLeOayFNz78o7M2jOAsypgWdMiUc=;
 b=Yxd7tcSaVVx1T8Db3aN9rPhTtsmbQtecOTdEJll2fiRt6K0iVHndCuDphe5kIAR5MUIhmlCi3DztRPeJ28Jy56VGHh44BlPLuj6Z4sAtRBjsqVea1fsV4+Qf6soxabtBwEs1SMO7s+TgT0ZAGyQ5bbFXMAVsIyHOxDxWJ1yd3hx0z6zR5mmN8ZlxjGsCfr7rKHBsn4F95ZfWe44r6j5D+YyeFEtDQ3OcH6HDPjPOiUnb8dLts1VW91si2FMGlFbr+b7a1xnYEobDn27iiOIjC+qXoEirTVNz2scju7v3F/XbLfTm38FaCbv1aKtjpiId//J6DPGr7icVj6YFwKh/Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg8iPxnz26e3hiucLeOayFNz78o7M2jOAsypgWdMiUc=;
 b=r+DEk+OqnU5PfV9fNnNRCjbHDUoz/Jv+adpmSt6DFdpwW2HGbE4HV2mxvTGCbLRcrqfY5E9ocTvw80WmleieLnVXi5Rkau6BReIMVCWyOA8ji/vJkMAwwj74heT1H+ClllLD/ZMYRk7Yh3aRSosqIA1sUIRIJe1dEv2nSEf3q50=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TYYPR01MB15560.jpnprd01.prod.outlook.com
 (2603:1096:405:291::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 14:53:07 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 14:53:07 +0000
Date: Tue, 24 Nov 2026 15:52:48 +0100
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
Message-ID: <awWkwJTxdJV1owf-@tom-desktop>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <e22a176720a38df652c7f7eabe27219da50f217d.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <TYYPR01MB660397C3B66F6EED53656B2086442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awV6pAtcSz8e9Q74@tom-desktop>
 <TYYPR01MB660334463EC01FCF06F7A9E586442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <awWXLFAbDd_35Q-l@tom-desktop>
 <TYYPR01MB6603D650B839F808ACBA811F86442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYYPR01MB6603D650B839F808ACBA811F86442@TYYPR01MB6603.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: FR4P281CA0440.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::19) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TYYPR01MB15560:EE_
X-MS-Office365-Filtering-Correlation-Id: 71aaae8d-3d7c-4826-ac29-08df4a3aa63e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|23010399003|1800799024|261009223327099003|38350700014|10067099003|4143699003|11063799006|56012099006|261021121427099003|261022105027099003|261021123027099003|261022075727099003|261009220027099003|261009221727099003|261026121527099003|261009221227099003|261028144727099003|261102123227099003|261026140227099003|261009223027099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: DJ6GDt+q76AiXEimP35ODxRACqljEGsok30D9rwCYUw0AG69kOGxuUD/TDaaGfTnaEbALxSDogWLlNYihC5Z3yPPI8cJWYrFro4CnDq7xZYT1gwioQM4QZvGz1uiqkotTDMMRSpcc3g6B2LgQrKIBgGZDmsE8eVecymUEzy1Z8MIUVsRpPYbNft+onpyCROrXi53o3Zdmos0pKVLPcRLu0Z9SPH1uUcgASC64o73t5Sdl4KRCG1HjB3LYLwnYcV5eQiKVLjV/oD9jGp8BioLY1BIR+Y4M9CUaTvJArFNGziJd4RqZiOgqrfR73dyTj00T7XVghyO/eaNi63164ThfDQrhze/kFVohJWYpjiy5jsspZktQtFzvWgbhcxcy59QkqjU/dbNHpFb/Wwjc8fRHienjetNXIxREXx+jT4rvuX12YH/aOgdRq86Y62w+napsAX2yxcHChRtccm3wTXZg4j1XWILh3t9/ei6bT7P1IFmarcDqy7zfEB9xg7nfbdLfqwqT2a5BXlgIKN9NPeH3AqycFHBR5rVrRRBCD7RKfuksPBI+ifgP/eG8k6R38dl3esjpCL7MagQhAWHYZu8+Ag7oauRqoHx+BPrbKVMpXIUKFmHjoNVFinP5F28iKtY15kFRX8F7QN6KQz0oPshL6rpbCCjzfrpfrJpcDvesLY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(23010399003)(1800799024)(261009223327099003)(38350700014)(10067099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261021123027099003)(261022075727099003)(261009220027099003)(261009221727099003)(261026121527099003)(261009221227099003)(261028144727099003)(261102123227099003)(261026140227099003)(261009223027099003)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?dufY7lOTYEoLrUrCQM/ZEK/iS7Q+pTxT0khBfjK+1fpSKk7u7RUWlCTeh7?=
 =?iso-8859-1?Q?c4YCEnVwCiLuheUJLsw22m0IJkPsoDHkyoCnMSMvbYOWTNom9JtV/9rx5t?=
 =?iso-8859-1?Q?eHFrTfd4KhKfHTxITuxrDHUTCuBcAMloAt63cXKkTVmIzOkN+m7+suy7S5?=
 =?iso-8859-1?Q?GKPLyxUqClRIa/gCkR8ttM4VAlupSHX1ehRKStxHYCxp+3BjgjYFYdes1D?=
 =?iso-8859-1?Q?zU7WltPYRVF1iKXwOKodAuGVx/n9cueWq0raGu4FK/BXvXv2lIhmMbNy/m?=
 =?iso-8859-1?Q?+mDrfKMX7TNDhc8dVbV5Q19+THf1TNbffENeXl6K1nqdpVla4XgrJOjL92?=
 =?iso-8859-1?Q?17bEag1fyLwimiIIxRVS3kt6jVPJGoTr6bB1Qdpyvd/daCbPMfgyv6Apen?=
 =?iso-8859-1?Q?LRyhN7FD677TM4qq70sli4CFmTEANz2+43EfsCsW+C7sYa9KQs7TCj789v?=
 =?iso-8859-1?Q?dtd/8XVmhZLjHoNDfIG4UOVucd4UcJdTUTmSy03iNiS9Z32WxfYq5uVuNy?=
 =?iso-8859-1?Q?kg/jKRWnLe6HjfhGbHIAgN9TYvN9fdZp42xiKCWf1ivpMT/wx2kARkP/kQ?=
 =?iso-8859-1?Q?1d3pbKaEDBxGvLaozXOtxaGQmNH+1YN6XpamDrnYHUPwAlmZLse9c+3YSN?=
 =?iso-8859-1?Q?eWvApNXXUthVj5j4nB2vUYT9qb+03sjE1EAtpE4TlhE3IRfUR2pGXBtsci?=
 =?iso-8859-1?Q?LkLQ1eYPh1q/Zotnmp49b3Ovvki2IIOiu25eLGd0GYWprNrEuQBSXQaD2y?=
 =?iso-8859-1?Q?gYp9V5LiuqQlHXeH19o7l5Xw9sgtgTYbfdo5tLbN3hdGg8Y9Pqil0i3JFd?=
 =?iso-8859-1?Q?9N/t7drviq2uKu6zvEXqavNMfLgGKeMt2i0vig8Ef8tQGA+fB61oSNbEBI?=
 =?iso-8859-1?Q?7chXZZb1dN3WMJh0Bc8bQc9whNFieU98BinzQ/inpI27+jj4GlQ6BxIQ0x?=
 =?iso-8859-1?Q?VJm///6gdxIpDduSAGufxF76LOb9kzm/GrePkWop16aPSqbgYrkwu5r/i2?=
 =?iso-8859-1?Q?nGKsokPuPhBQFFeTHBuUwNe6tioOw6vQCMQg+MhBXTXGTzWOUGzUYt6xcT?=
 =?iso-8859-1?Q?P9Xzsjn63KZ7e9yh7GWVok50NEiAX9g4qkd9JIDqf4tw1ZZIhBIwyGhRFu?=
 =?iso-8859-1?Q?k6xVc47Lxqo001mQrSuFxmU3stEl9Dy5R4APVWuxOsTKwzMqcXqECP5Q3Z?=
 =?iso-8859-1?Q?aAsK/WrBTXElVBwdmu84RzaWgAa8gdNC9kIbRmQ3kMteDEAi6RH71lh4Yv?=
 =?iso-8859-1?Q?u21qFs6ltjSgpE2o8i4WRk51CcCHKw+XzmvrsDKmJeRL83ggFJD2zymJ+j?=
 =?iso-8859-1?Q?aVmG98YnydWCiD4wkhb8anKlyBkAuojD/8eeaFU1Vgqj3drIcIkk3Uzdlb?=
 =?iso-8859-1?Q?1d0UeZ82aGPDksfYbZdH3cWlWEdSn7qtUvrzqdYn2n3BFNFebwVoBHneQd?=
 =?iso-8859-1?Q?WnglzX9b/nMQoKmj35A6HD/GusXIlrldymCKwOnXwunPnUGt+pX70tLMQ/?=
 =?iso-8859-1?Q?Av6QhP/KUx7Fmqr2c1hf6TJsY3twMD0Ucwpq1WLwJ9z9pOjTZrhlE8HaA9?=
 =?iso-8859-1?Q?ang9d0Yb9UP6zL+sgjz+RxSWKUF93ZslrFs/27TmZ6UjrTd+wD0V1FzQTe?=
 =?iso-8859-1?Q?djqurVR2UMcnv3V4jLL0kdcgbAmz/BrVTYYeaJq1qolcumS/SoEiUs3Anb?=
 =?iso-8859-1?Q?6Z066+S7u/JChTGMWkcNUCBRFtzZQkRVHHCTbzYacM9A6Sn3ZjuRwZryCZ?=
 =?iso-8859-1?Q?xYcCTTtwxZqbWNLg08TBbGDtUDmvtLtVeQQbk9HM6J+ROFmlvdCjzvyLNt?=
 =?iso-8859-1?Q?u7Wci7bvSpN9mfEdW1+dNTFaxzF/5H7nm9jp7kQG1iPpcMya/MRf?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71aaae8d-3d7c-4826-ac29-08df4a3aa63e
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:53:07.0808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5leJrM0Tb+1rMzNrit2o7UtEi+Ip+Ty3UAAnDw6mOMFBcAEdl3fhxAYbTpGCInWU6a9TR/nAPYnrwyoHaJ4W8p3SfDoTqPj6xMf0kaGtqWd8NDi1+1KJTUz9ihIU7qaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15560
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

On Tue, Nov 24, 2026 at 02:11:16PM +0000, Biju Das wrote:
> Hi Tommaso,
> 
> > -----Original Message-----
> > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > Sent: 24 November 2026 13:59
> > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support several DU instances in one DRM device
> > 
> > Hi Biju,
> > 
> > On Tue, Nov 24, 2026 at 01:18:43PM +0000, Biju Das wrote:
> > > Hi Tommaso,
> > >
> > > > -----Original Message-----
> > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > Sent: 24 November 2026 11:53
> > > > Subject: Re: [PATCH v10 10/12] drm: renesas: rz-du: Support several
> > > > DU instances in one DRM device
> > > >
> > > > Hi Biju,
> > > > Thanks for your review.
> > > >
> > > > On Tue, Nov 24, 2026 at 07:47:04AM +0000, Biju Das wrote:
> > > > > Hi Tommaso,
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > > > > > Sent: 13 November 2026 12:20
> > > > > > Subject: [PATCH v10 10/12] drm: renesas: rz-du: Support several
> > > > > > DU instances in one DRM device
> > > > > >
> > > > > > RZ/G3E has two DU instances that share a single DRM device.
> > > > > >
> > > > > > Add an RZG2L_DU_FEATURE_COMPONENT flag and use the component
> > > > > > framework for it. The first available
> > > > DU
> > > > > > instance is the master and creates the DRM device, the other one binds to it as a component.
> > > > > >
> > > > > > If only one DU instance is available, it creates the DRM device
> > > > > > directly at probe time, as on SoCs without the flag.
> > > > > >
> > > > > > Set the index of each instance to the number of CRTCs already created.
> > > > > >
> > > > > > Signed-off-by: Tommaso Merciai
> > > > > > <tommaso.merciai.xr@bp.renesas.com>
> > > > > > ---
> > > > > > v9->v10:
> > > > > >  - New patch.
> > > > > >
> > > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 118 ++++++++++++++++++-
> > > > > >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h |   2 +
> > > > > >  2 files changed, 115 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > b/drivers/gpu/drm/renesas/rz- du/rzg2l_du_drv.c index
> > > > > > 93d59e2cf8a4..873586f2ef28 100644
> > > > > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > > > @@ -7,6 +7,7 @@
> > > > > >   * Based on rcar_du_drv.c
> > > > > >   */
> > > > > >
> > > > > > +#include <linux/component.h>
> > > > > >  #include <linux/dma-mapping.h>
> > > > > >  #include <linux/module.h>
> > > > > >  #include <linux/of.h>
> > > > > > @@ -14,10 +15,12 @@
> > > > > >
> > > > > >  #include <drm/clients/drm_client_setup.h>  #include
> > > > > > <drm/drm_atomic_helper.h>
> > > > > > +#include <drm/drm_crtc.h>
> > > > > >  #include <drm/drm_drv.h>
> > > > > >  #include <drm/drm_fbdev_dma.h>
> > > > > >  #include <drm/drm_gem_dma_helper.h>  #include
> > > > > > <drm/drm_managed.h>
> > > > > > +#include <drm/drm_of.h>
> > > > > >  #include <drm/drm_print.h>
> > > > > >  #include <drm/drm_probe_helper.h>
> > > > > >
> > > > > > @@ -170,6 +173,7 @@ static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
> > > > > >  				  struct drm_device *ddev)
> > > > > >  {
> > > > > >  	struct rzg2l_du_device *rcdu;
> > > > > > +	int ret;
> > > > > >
> > > > > >  	rcdu = drmm_kzalloc(ddev, sizeof(*rcdu), GFP_KERNEL);
> > > > > >  	if (!rcdu)
> > > > > > @@ -180,9 +184,28 @@ static int rzg2l_du_instance_init(struct rzg2l_du_device *du,
> > > > > >  	rcdu->mmio = du->mmio;
> > > > > >  	rcdu->ddev = ddev;
> > > > > >
> > > > > > -	return rzg2l_du_modeset_init_du(rcdu);
> > > > > > +	rcdu->index = ddev->mode_config.num_crtc;
> > > > > > +
> > > > > > +	ret = rzg2l_du_modeset_init_du(rcdu);
> > > > > > +	if (ret < 0)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	if (WARN_ON(drm_crtc_index(&rcdu->crtcs[0].crtc) != rcdu->index))
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	return 0;
> > > > > >  }
> > > > > >
> > > > > > +static int rzg2l_du_instance_bind(struct device *dev, struct device *master,
> > > > > > +				  void *data)
> > > > > > +{
> > > > > > +	return rzg2l_du_instance_init(dev_get_drvdata(dev), data); }
> > > > > > +
> > > > > > +static const struct component_ops rzg2l_du_instance_ops = {
> > > > > > +	.bind = rzg2l_du_instance_bind, };
> > > > > > +
> > > > > >  /* -----------------------------------------------------------------------------
> > > > > >   * DRM device
> > > > > >   */
> > > > > > @@ -191,7 +214,7 @@ struct rzg2l_du_drm {
> > > > > >  	struct drm_device ddev;
> > > > > >  };
> > > > > >
> > > > > > -static int rzg2l_du_drm_init(struct device *dev)
> > > > > > +static int rzg2l_du_drm_init(struct device *dev, bool
> > > > > > +has_components)
> > > > > >  {
> > > > > >  	struct rzg2l_du_device *du = dev_get_drvdata(dev);
> > > > > >  	struct rzg2l_du_drm *rzgdrm;
> > > > > > @@ -213,6 +236,12 @@ static int rzg2l_du_drm_init(struct device *dev)
> > > > > >  	if (ret < 0)
> > > > > >  		goto error;
> > > > > >
> > > > > > +	if (has_components) {
> > > > > > +		ret = component_bind_all(dev, ddev);
> > > > > > +		if (ret < 0)
> > > > > > +			goto error;
> > > > > > +	}
> > > > > > +
> > > > > >  	ret = rzg2l_du_modeset_init_finish(ddev);
> > > > > >  	if (ret < 0)
> > > > > >  		goto error_fini;
> > > > > > @@ -235,6 +264,8 @@ static int rzg2l_du_drm_init(struct device
> > > > > > *dev)
> > > > > >
> > > > > >  error_fini:
> > > > > >  	drm_kms_helper_poll_fini(ddev);
> > > > > > +	if (has_components)
> > > > > > +		component_unbind_all(dev, ddev);
> > > > > >  error:
> > > > > >  	/*
> > > > > >  	 * Don't use dev_err_probe(), as it would overwrite the probe
> > > > > > deferral @@ -246,7 +277,7 @@ static int rzg2l_du_drm_init(struct device *dev)
> > > > > >  	return ret;
> > > > > >  }
> > > > > >
> > > > > > -static void rzg2l_du_drm_fini(struct device *dev)
> > > > > > +static void rzg2l_du_drm_fini(struct device *dev, bool
> > > > > > +has_components)
> > > > > >  {
> > > > > >  	struct rzg2l_du_device *du = dev_get_drvdata(dev);
> > > > > >  	struct drm_device *ddev = du->ddev; @@ -254,6 +285,83 @@
> > > > > > static void rzg2l_du_drm_fini(struct device *dev)
> > > > > >  	drm_dev_unregister(ddev);
> > > > > >  	drm_atomic_helper_shutdown(ddev);
> > > > > >  	drm_kms_helper_poll_fini(ddev);
> > > > > > +
> > > > > > +	if (has_components)
> > > > > > +		component_unbind_all(dev, ddev);
> > > > > > +
> > > > > > +	du->ddev = NULL;
> > > > > > +}
> > > > > > +
> > > > > > +/*
> > > > > > +---------------------------------------------------------------
> > > > > > +--------
> > > > > > +------
> > > > > > + * Component master
> > > > > > + */
> > > > > > +
> > > > > > +static int rzg2l_du_master_bind(struct device *dev) {
> > > > > > +	return rzg2l_du_drm_init(dev, true); }
> > > > > > +
> > > > > > +static void rzg2l_du_master_unbind(struct device *dev) {
> > > > > > +	rzg2l_du_drm_fini(dev, true);
> > > > > > +}
> > > > > > +
> > > > > > +static const struct component_master_ops rzg2l_du_master_ops = {
> > > > > > +	.bind = rzg2l_du_master_bind,
> > > > > > +	.unbind = rzg2l_du_master_unbind, };
> > > > > > +
> > > > > > +static int rzg2l_du_instance_probe(struct rzg2l_du_device *du) {
> > > > > > +	struct component_match *match = NULL;
> > > > > > +	const struct of_device_id *of_id;
> > > > > > +	struct device *dev = du->dev;
> > > > > > +
> > > > > > +	if (!rzg2l_du_has(du, RZG2L_DU_FEATURE_COMPONENT))
> > > > > > +		return rzg2l_du_drm_init(dev, false);
> > > > > > +
> > > > > > +	for_each_available_child_of_node_scoped(dev->of_node->parent, np) {
> > > > > > +		of_id = of_match_node(dev->driver->of_match_table, np);
> > > > > > +		if (!of_id || of_id->data != du->info)
> > > > > > +			continue;
> > > > > > +
> > > > > > +		/* The first available DU instance is the component master. */
> > > > > > +		if (!du->is_master) {
> > > > > > +			if (np != dev->of_node)
> > > > > > +				return component_add(dev, &rzg2l_du_instance_ops);
> > > > > > +
> > > > > > +			du->is_master = true;
> > > > > > +			continue;
> > > > > > +		}
> > > > > > +
> > > > > > +		drm_of_component_match_add(dev, &match, component_compare_of,
> > > > > > +np);
> > > > >
> > > > >
> > > > > The master is chosen purely by DT order. If the first available DU
> > > > > never probes, the second never gets a DRM device. How do you handle this case?
> > > >
> > > > All available instances are part of the component match, so the DRM
> > > > device is only created once all of them have probed, whichever one
> > > > is the master.
> > > >
> > > > This is how the component framework works.
> > > >
> > > > To use a single DU, the other one can be disabled in DT, in this
> > > > case the remaining instance becomes the master and initializes the
> > > > DRM device on its own.
> > >
> > >
> > > Assume both DU's available and run time
> > >
> > > second DU is probed first and master never probed at all.
> > > What is the state of second DU as bind never calls?
> > 
> > 
> > The second DU probes, registers itself with component_add() and stays idle, without touching the
> > hardware.
> > 
> > When the master probes, both instances are bound and the DRM device is created.
> > 
> > If the master never probes, there is no DRM device, because the bind is only triggered once the master
> > has registered the aggregate device with
> > component_master_add_with_match()
> 
> Not sure is it the normal use case? DU0 and DU1 are independent devices
> 
> 1) DU0 or DU1 should work independently irrespective of the probe failure of
>    other device
> 
> 2) When both DU's are probed, then we need to aggregate the device using component
>    framework so that use case like dynamically switching DSI0 to DSI1 can be achieved.

IMHO 1) and 2) can't be achieved together.

CRTCs and planes can't be added to a DRM device after it has been registered.
If DU0 registered the DRM device on its own, DU1 could not join it later.

To have both DUs in one DRM device, as needed for 2), the DRM device must be
created once both instances are present.

That is what the component framework does here.
I'm seeing others, let me say "multi-instance" drivers such as:

	- rockchip_drm_drv.c [1]
	- imx-drm-core.c [2]
	- sun4i_drv.c [3]

Which are working with the same pattern.

IMHO a probe failure is also unlikely in practice: the DU probe only maps the
registers, sets the DMA mask and allocates memory.

The dependencies (VSP, bridges, clocks) are looked up at bind time, where -EPROBE_DEFER
is handled. To use a single DU, the other one can be disabled in the
device tree.

[1] https://elixir.bootlin.com/linux/v7.4-rc1/source/drivers/gpu/drm/rockchip/rockchip_drm_drv.c#L145
[2] https://elixir.bootlin.com/linux/v7.4-rc1/source/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c#L210
[3] https://elixir.bootlin.com/linux/v7.4-rc1/source/drivers/gpu/drm/sun4i/sun4i_drv.c#L62

Kind regards,
Tommaso

> 
> Cheers,
> Biju
> 
> 
