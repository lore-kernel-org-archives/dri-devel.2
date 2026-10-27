Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFADF606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Xx875mX1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F70210E2BE;
	Tue, 27 Oct 2026 20:16:08 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 142B810E2BE
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 20:16:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXKtHVgqCdaRA13Tbv+mpUxdyTWhUL4EFQlB1DvHaVZBgGj6YhneL3Dz80XcXCQ83+xXC+bhuiubkPhQuXBoEpYHxN1POethsTA+Kcgz6SMuv5XFr1AvsLjwnZ0lYyhNSjFr0pwe8DBImLxac7gr2/r29gIXJeSg4P2vlsG5Iy15QXxEcbfBGerX4YBLXA5K5WAdl/JJ8uaWjBycSJApM0MIB+cgtozdRp+mvgT0ZAcz2okwzkWpxyDxoaQT3PkvK1LzSgtkh6yTnvKqk2EgO4YIONu3NGeufi1Rez2c0qu/xNthQeACWThe6vJzpdmPwZsV7NeDqid1UF7/sGgb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5TfRiu2gXD+rJl9YBa0r87kAIynSsmDKQ5Opi4Z3nM=;
 b=rOZkXovtb4piiA1MRZitnhFi4LwJWpNeAE3bkr6hHnuU1jwGdWNJNuUx5Bo9I9rVysZiqmce6Bire/27d3XQiWUFAI+mBm6Ff7XeqBxbegc1nyM7nzK/HZszt23bYfKYN/xky2WB9yTLoB3oQJjJ9Jy8TWKUeHAPpH2y9Qu13txzz4Z53TcDT1WZqio5Qe12zYq7lU0x9woNgyQvhlbcisDBu8iA/nQJ/G5577oppJ0O1n0ai1o1NuQ7W2rvhB+DEPoFD1sF4gIrpb2OXA0zAHVu7yF+vzmQ0MsMBMHeyHDTcH4iSB/MtrbIrE4LOLqEpbnPBYFr4l9wFjBHDGqJRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5TfRiu2gXD+rJl9YBa0r87kAIynSsmDKQ5Opi4Z3nM=;
 b=Xx875mX1ZCqC46IHRwn5+lXEY/YU/YekYbgE+dqhp4ISyyInPpI08qbFZuSNLo60ZKvyDi+DLbgfe/WtNdIfFX49cSQkPWVNev4ubTsrRtYa0d66wRLPsbDzTpBBTl54gahnPZu44+vgtrWtfNFo02dJfXgnvoFuwLUf32PhFmb4DlhGkarCutb+rDWga8XWSJmPMyRbyDR3a5pYdYKvgnlxHYfEIqJB71AmHpk5lXe8pCrAr4ez2FjtsnfGq8iMz8XMyokm6HkICSB3OKavsY6N0FeMDOKOrMFWzVkjVvKQiy/5Okr3lYNsh13l9sLs+RSXsLbbZNW7XLBvmEih5w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AS1PR04MB9237.eurprd04.prod.outlook.com (2603:10a6:20b:4d1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 20:15:58 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 20:15:58 +0000
Date: Tue, 27 Oct 2026 16:15:48 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Paul Cercueil <paul.cercueil@bootlin.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] drm/imx/lcdc: fix inconsistent indenting
Message-ID: <auEGdEb1NrLIK9_B@lizhi-Precision-Tower-5810>
References: <20261007-drm-bridge-imx-lcdc-indentation-v1-1-3bcf98f3951e@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007-drm-bridge-imx-lcdc-indentation-v1-1-3bcf98f3951e@bootlin.com>
X-ClientProxiedBy: PH3PEPF0000409B.namprd05.prod.outlook.com
 (2603:10b6:518:1::47) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AS1PR04MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: ce119538-5388-4ead-87a2-08df34671cd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|19092799006|56012099006|261021121427099003|11063799006|261022075727099003|261021123027099003|261009223027099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: HUwy4zJuXLMiTmOgPRB3Sd5yTPS0S2MZ1hZ3VENGlqYaAXuWJT7UKAFwefIqA9npxNbLTxZVLLsHIUE6IDM8qw+7AtRH2m7sB0uXB5gGYodoZNEzybeF4pyOicv4WfM2DIC4E6eVCf4flM5kOEY+KnrouFnnXNdp2hbHLUDS763qFp6sSxJ3ZsW7khtyRcNYKlkeFWbBC1/f88xSZTl8RCnXMPmnAbVgAIYAFEd/XmcSsViI/7WvN6dxmrgWWc+dLpipGQcEFZN2/vTNofR9esPsBMfUtpc1yVzzChyn/dT+f8rPMQVyYaU9qgqB4o+Ph1cT5JktfjoZ+vy4wzu7UFpfWFJdw2/sxFLJgrcNkStbcUuPwHE/6PqQFWtc4T0hkv0s9iCeof2Z/QYaqrYuykuk6q7oRW46T7JHxwOwe2Wo8+cnwo6KKPN4RUAd8ikWu9eQe63+UXI9xrOoXK9Wne+HeaiHCb/CpPEJrHzH3Xx11D57TfKw0lIwVdjWDDgQnLgCFolqYZz/eyOqlHiCRhBl9ef9Q1eOpMBMm7Rn/fgmtlA22MBDE4sii5ygcTY787wQ1MlvD9K94dg7G047nHbNmvjbtjO+SiMFWeUXfTQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(19092799006)(56012099006)(261021121427099003)(11063799006)(261022075727099003)(261021123027099003)(261009223027099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d1QAXHU2q++EAQ9RKmGS8amzgVr1A+3Wmq2HwRF0H4Ug4vKQUwuhzgmt+Gjd?=
 =?us-ascii?Q?J++Mwbk/4YMmKu6vdRKPzpWJ1eMotpwQpvlZVVRPTeXnZmdv4d/XcYlhFEWd?=
 =?us-ascii?Q?uagrvHCGOCPOvmf1rrfN1itLsqkjfiAf5B/HTAd/f4TmEEvxfOdvHySL3MxE?=
 =?us-ascii?Q?9ArrKdeWrTyrJeKFo6W+Ja+2ydfUTrE7eBWf8vafdXnGJ7gwqsL4t+oYnAu0?=
 =?us-ascii?Q?fhg/tlElwBD5cJFh8Ki/ISW+QrB3Nm0JTGs+k5QIOcq+AEnWzU3AtZhvhYYs?=
 =?us-ascii?Q?FJWtl3+0nueph4aoyUV25mzukdGJoGxrxo7sOr5yR3WAZTlJd8ClgeD0AGmu?=
 =?us-ascii?Q?VCSuWMZ3R5I7JXpEfVFIneLr7HAflYdz3D2gtuA5v+ovFF+GDIwadE8gwrlw?=
 =?us-ascii?Q?gSKRbUkcaheut5Gqx4MFHuinkCgmFpQJ98/8byrBI/mrhotkEi0wd+E5LpAc?=
 =?us-ascii?Q?Z2XBWB5wCvBq9KzPTQInon6zda9BejXWDCr6uIinzWpM6s8jwmjUq6OpJzPn?=
 =?us-ascii?Q?36DP74cqEOQvKCbwSNA3NJTDFmNkOpaKWQRWCiabh1LO+/IAGTSlesP3UIEM?=
 =?us-ascii?Q?er8Vks2gGJlJnXggZJTkcBIUSN6JtP5/lT9aEfOqciCreX75iqA8tE54YzXm?=
 =?us-ascii?Q?JJmL52ubJ0ECxaVCe3yZFwn3Ce3s5CHcmh5IM0m+GYuuyP4ShtWOnzYJUgPj?=
 =?us-ascii?Q?NEK3jTTIirm6sojRULk6zsLePkr0WXQKsdDcVuO3rjuFNF5T8qL4w1bujN2q?=
 =?us-ascii?Q?ousco9YmKEnT7EDQP6XlO7hXMs9SomTvqRBh7eGsbYhnT41Y6OUXj4hP8nz0?=
 =?us-ascii?Q?v99AKJ0Zlx4yxBOUaVZnJpsSXdVBKdeSMBKcLSN9vZekOuBrEozeDlXh+Zc3?=
 =?us-ascii?Q?t69f/EKBo/ucjMWOvQCKjla8XETRpwG1NJ4Lca2Ma5xKS90bc1yyvurtA3Xy?=
 =?us-ascii?Q?gzEm51NVjVVfZn/mKCru2cgITXYAqnPIOsRsHBo6P00+7TuIFnog4wzWByVM?=
 =?us-ascii?Q?TuRoluwWfEOwZ9AUaM9KGD9W4XuFf5F89bdGbfK4qz8QeX+Gmy/5sUSeIqLu?=
 =?us-ascii?Q?RaKg9Z6lh9LoPF58DngDEbWvifBsoTrbt4djyQQaqzYStsBWmeFLBMj8kQLE?=
 =?us-ascii?Q?BsRnSQFzoctNamviSd+wI2/fecPCzHjiJ3h01Tr1cUsqEmt4jeNyTQfWgG7q?=
 =?us-ascii?Q?hxPYwZp+oApjT3ceYCAhCFxERdmHhP/EGFa6Cu/wuB8TSAJmJVXhNmExNTGG?=
 =?us-ascii?Q?PphT4r8BHE6gzerb/lk/xMc6fB6d4tsw2MYtXK3n+q0cG5oYZOVP8f+0Yf9H?=
 =?us-ascii?Q?hKPR00/+/lv/thocR8yqA24E3c8G89FTgfjbRizCsthUlpWy7ikpv9zX9pdh?=
 =?us-ascii?Q?rivxix/Sj5pddRIGHnp1z/6tuSYnv/Xev60mmli99ruX4D9wRUjPs6Um4xsX?=
 =?us-ascii?Q?ksVPKVg5+VxYJ9Ty8D+SQ1FsDaRdD0apdhh53DcXaslHR/HxqXQjbER1ntsZ?=
 =?us-ascii?Q?X101ZbQPVFgXoWPMLijFcmB7huwQ9kHfgjo5sf7rYtbYmHrg/mw2Pe/AsXSN?=
 =?us-ascii?Q?6LdrB1x3ORGS7tuSYl6SXMa5X5M45X6peVuc/sIIBVlhVJghBg8eoeQ+lr/a?=
 =?us-ascii?Q?b3PwwnIOXg/VXs9Di8axZ9TD6bLzqE2bfAuAiNpdoM02TqA8oiouYuWL7Y6Q?=
 =?us-ascii?Q?kU1CE8Nh/OVEKWABzrPqr1HSzb9GmZ16mbRcxdesilsVTETBB6qlpkkfn7No?=
 =?us-ascii?Q?VSfA0oYTc4Hkd1PTI3suP7K28Fvr0fqV79FA5ANzh6NQof9h7e6S?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce119538-5388-4ead-87a2-08df34671cd8
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 20:15:58.1021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnx/Vq9xrNNmQhuZi3qxiJyiA4h3JOqMxz7O1smoxe3qHvbsZ8SgdQL1bkqfS3XlDH87eX5d8YzyH9uRyTV5Oqejt8lpXdtSTn+BnU1a4/FD0JciwI5FymwTudzz1jWH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9237
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 07, 2026 at 02:11:53PM +0200, Luca Ceresoli wrote:
> Fix incorrect indentation introduced by mistake while fixing patch
> conflict.
>
> Fixes: 4136a58ced8e ("drm/imx/lcdc: stop using deprecated devm_drm_of_get_bridge()")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202610060513.s5yUX86m-lkp@intel.com/
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/gpu/drm/imx/lcdc/imx-lcdc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c b/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
> index 0f95b5592980..30469f98acd1 100644
> --- a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
> +++ b/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
> @@ -542,7 +542,7 @@ static int imx_lcdc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return dev_err_probe(drm->dev, ret, "Cannot attach bridge\n");
>
> -lcdc->connector = drm_bridge_connector_init(drm, encoder);
> +	lcdc->connector = drm_bridge_connector_init(drm, encoder);
>  	if (IS_ERR(lcdc->connector))
>  		return dev_err_probe(drm->dev, PTR_ERR(lcdc->connector), "Cannot init bridge connector\n");
>
>
> ---
> base-commit: 5d7b464a4f517d1db533b1b231f42ddcf4e1dff4
> change-id: 20261007-drm-bridge-imx-lcdc-indentation-2975e44ea6e3
>
> Best regards,
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
