Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92844C44524
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED70010EFD1;
	Thu, 23 Jul 2026 07:09:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.b="GQfLbNCo";
	dkim-atps=neutral
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11012027.outbound.protection.outlook.com [40.107.75.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F8E110ECB5
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:58:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhYs1BYWbd27trFVJ0inOkPs6AR/a6hiLNGUXIfiJi1LouCg5jgFdazKUNi9PeLWM5/07+8wrNnnAcBERsikszaOBl1x7wVhxxRc06lj7KfAjPfs16tB7xkmYh2bkVNBCshy135V/t4neNLYUkO+PAMVXgNm4bI5nwk0X+eEsOTjnWxFaS3i9b5NDCIFzjokj6okshKhBHmE3rnndvD/coCA3113lZHtTNWg35wc3gfAaeOSVH0cJBwsSuMe7PgfNeHnlinA+VzS6SE+usdSAmLQnvA4gWnF7ghyHgL5E1EpoFjj+OZgGRYWAR2pu4ZLhQYA3MLhHv/UmuP0MpRdKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UubTSuLqqIwcanYCwxBxQGd72IKcLAUB62vjlgVIhG4=;
 b=MwHMKmBheYj1h4QkSj/yFPUSkedf2aZwmntcpnLmVtXQo+afrfbScjAwtyLFyKF4tyfAfZsO43HoR+bELqw7H4psDwNwq/6y8+Oe0RZEqS9jphRNf/ir2LPNIRFNxmb1VclCjYa8IcxkGkHissdlK8AwbIODw16Aa78tiblJMFmfrXK6gSvnUDNdsGqV7bEktIgXobojC3jX1CRuNCGYXUt8TQ3MMDNd6HqK20CloEpZchjteZrpRrWCQW8heglHay4z0s0jtSoXkeWb+vlQNM48cYbNA5zj7FN+s1BmAJEay9w9Bbwz/F+xdJ5zaJGEKd7JzhT1EOW6Ssa2Ah2jeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UubTSuLqqIwcanYCwxBxQGd72IKcLAUB62vjlgVIhG4=;
 b=GQfLbNCopg8rya93GRy/u95gV+08LSK11RtBuUWttDKma4Sx6ADNhCuWyAWZU2vt7RhKXifY7nW2efIKFhHF1UGuFSNIN0WbLKCHFgPHu58q4S4ru2j41Nn7JE953plW00XtqCltNH0D6or/PZhcIdyZquO6cxuyam6R48pLMrL/mR3khTcW/29tgypCvW2OTE0NgB/vCOQXPpTVWvwdhT1ZtjMbThqt7Zd587emdN+D83fL9WxZaGccZrjds3OQ/qfxn2s+eiHel0PujPuLM+RZ7FItjSEylrFaCQRBwWT9DpCCPwhVsshV4EVMOlAV/zEEteKJFCTSu5pRFYD2hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI3PR06MB8492.apcprd06.prod.outlook.com (2603:1096:4:2a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 07:58:34 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 07:58:33 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Helge Deller <deller@gmx.de>, Pan Chuang <panchuang@vivo.com>,
 Kees Cook <kees@kernel.org>,
 linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
 dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/7] fbdev: pxa3xx-gcu: Remove redundant dev_err()
Date: Wed, 22 Jul 2026 15:57:44 +0800
Message-Id: <20260722075803.570532-5-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722075803.570532-1-panchuang@vivo.com>
References: <20260722075803.570532-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0296.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::8) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SI3PR06MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b20ff7-8aff-4342-8385-08dee7c706e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|52116014|366016|38350700014|22082099003|18002099003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: RLQYBT0v3fTGrywfff/yIt3HY5nEPSAHruxPP9BQO4tjFY5sXk2uqlqJSg2OQGkhgX02xRTwBF1LU23cS+yPZItX0Iz4VsNYAbzyZjL/O46mE4x+09Fjccn4U5+LEHf8ooV5pxzm42GbNnB1ntRW4umwvSjI7Bp5QbjFSUvhZ2kSAdsMnr8QbeDFqH3HAcYpPw41lqFvsDggCWFQbmkJQa65fxScFKhWP5xIv57qBfdC1XFFJsEy3LvCLXkLUycTlozd6Tjai30IPLX9ePYu4vkduTD0RLBH+EgunTVrHLU2TB8iuDkj5tO/BTkQ5LBhFql6HyP34p8ChwnK4oOHDevB3aLcW/NL56q6OMq5xiQ8CdS3i0ygLiq2740yN7BNt3r9H6AcPdGZmvuLWiyg1Jvswj7MfBFAhLRu+aFQzka+UC3UCbuRF7BR0nVp/um1vrSzzIvMnp7qij8jL4XF1AibArVrf3JVujCepOXwjQrPsjLkL7j28Nmk604ugKN+4kWW1DlVXY1ZjS9q3h2XrWwVH5WAgkF4WbGnzsYsUOX/7vwUimZBvcO1sXFX8CFWiiIboS5Nsopin1I4EaAS12AO754HOprWDzog//m8TTC//mhomsOrW4TPxn5XjIXqXVzghseCF6YulOHHm6eSc5MuyFEoxo69ol58XSYEitnR1noDEAoVNPMM9s75AwVXLgKFJD384v0Ku3G5/7+dWKGHLSL+Gl3bTC8zQuXlqs8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5832.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(52116014)(366016)(38350700014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z2YbFOd/Dga+Kj4mJcFJXFBXD3brvhK+Lg+GHwheFal/+0aKI9nBXVRaKUPy?=
 =?us-ascii?Q?FxeZXoU3HlfjMIAjT5AsqemjUrHM+FfaQQ62msTDoKo4w2IuLg9xnz6dhLaW?=
 =?us-ascii?Q?E5sRUR57j/gz7xdy+K9llkCsuQ4wpcxytf8PJK5ITy047rUCel9qdwOmvdhj?=
 =?us-ascii?Q?yl3aWugfIF5m6KkCKwo7D7fO7hA9x2qoqYKBJ6w69fRRFytOa73kJf5vOZM+?=
 =?us-ascii?Q?mNnGijoQ0ajS+bRKDIx1R60Qr0S8/faJiIVFGIKalA9ztR0Vusp2+NF/kIrl?=
 =?us-ascii?Q?Sc7Q04SRp//6nFmTKwK5Hh0/XzIHhWnb1LnlJq4HYgsImrJMD8QuwS+BizAw?=
 =?us-ascii?Q?I0A+z44lg4F/DUro83KQwNOOkWVXniA2iju3maz/Ps6pLRz4s+uRaVzsYQu/?=
 =?us-ascii?Q?oo6DVPqS+Z+kK3Z/2gc/ydbHBnZlTg3Nr4K9ciWShopOFrFkizEVJ/Nxyx5S?=
 =?us-ascii?Q?9IOCC6Oamrc6fZguVLY5mNWyvWUMWl6K30ArKSZAAfidJNPtzzNid1JhRp6f?=
 =?us-ascii?Q?yvvZcrIKZmCLu/qxYklp1LwLXfUh9cyEvmI7C27RmYgN3gMshu4iiF4Lk8iY?=
 =?us-ascii?Q?3QeKL4B6w4/FpWrYd2aWBd+FZgqnBVCDoq7iwSEjauB0WjtrpErIBDWJo/hD?=
 =?us-ascii?Q?YKqjC50U4EH22WqTK7sraa0LNdYU8kg8XoJCeYccWLq0kB2c0ceIujGb8phR?=
 =?us-ascii?Q?KQMDO6P+at0brgOL0jbrW7srXO4h50z7s/jUvq+sy8oDCHoEPkn4tTZWiYNK?=
 =?us-ascii?Q?kxoI8F0b9l6NFw24mq2Xw1LFaHTDwR1Lm6Fvb9sb8dWInvDZ+fiP2lJdhJmO?=
 =?us-ascii?Q?BwlGs/rHviPXecGtq6fLoXmgwabHy4hQPsvHGC2ND2mgoDIh4IvxJNVPv3am?=
 =?us-ascii?Q?qf5LsIIEFykyv2COfwqXMrFilRjsySo152x9/S2nyDPkiuu14YJ7DDUeRzZl?=
 =?us-ascii?Q?LuAWeRBSQ8xvAJWFCjFPTSNcz9D6AcDXLMNL9EI832pEGgyurDQmQt6c90L7?=
 =?us-ascii?Q?dNXMOM9tTVdtuPXaR5ZS9GwsYVaSEceqml/XJU/lN1CaPK4rKwDItPwwscgY?=
 =?us-ascii?Q?gl/LfrsWaI+3q+sClcP4wX14kMmPlPZuqlyqJDL8HAGEyTOjz9SKWWLOpuFC?=
 =?us-ascii?Q?0DWk72mpr/RqrSBHC1PWyt5d0AYRGGODK76vUqkMEzhzog75eWZeOBqt8JgL?=
 =?us-ascii?Q?sn8q2fFJg5qOhdqMYipI4b9Qoyqmh3bPPDi1PqL8WlQpggWQovM4ZPfrt44r?=
 =?us-ascii?Q?Eyfomb5GzOFB/euT1eHY3nwk4rjXwGHMv/vIYdBj4x3NoF/f7u3+rRAsYtSR?=
 =?us-ascii?Q?/uBN3MZlwHZwE0qIs//k7TZZ3wpe5wooQLp76ddWrM7rj/D3mxwNFyprlUf5?=
 =?us-ascii?Q?r0j2yRtaN8dLiJleDjr1CB+95gcA0jKdluTVdTCs5jRKHQIYvOwRVtJa6ST5?=
 =?us-ascii?Q?gtxhQLPo48eujQG0IUwdi/8DAEaMNrmYyKIpmpe42qHAU4Y80NVf0r65b8OF?=
 =?us-ascii?Q?tRinOITAci9CaDuDFzt9Z6A5rqbwUxj5ynBCLkhikOpoW/3wtxvPCIkDeUpi?=
 =?us-ascii?Q?nWnZkqCvZ1H183aUEq5ocK55peG0CYif4tfBWH+CyX0tpjKmw3qRCRA/EhH8?=
 =?us-ascii?Q?4Tv7LyvJsgvqTI28YzA60Ir0pZrBoHfsBEUEWHdhfU8FQGjRABOts9Pap3C6?=
 =?us-ascii?Q?EPdDow3g+nWxznprgawA+jVWYay6xvq0E0qYq+aXj0WtsLKgKk/uUbycPNQE?=
 =?us-ascii?Q?eMIbrUy1Bg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b20ff7-8aff-4342-8385-08dee7c706e4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 07:58:33.5118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVa8Lk7L86CBhFJIe2wiE1z7vHxm2SjNcIKV2Nt+0Cem0xNvK32xsucEKbl0ckx3sX3QxIj6PR0k5YQ1veS5rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR06MB8492
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:31 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/video/fbdev/pxa3xx-gcu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index a2320e2fb8f2..fc5bd7e7aae6 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -615,10 +615,8 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(dev, irq, pxa3xx_gcu_handle_irq,
 			       0, DRV_NAME, priv);
-	if (ret < 0) {
-		dev_err(dev, "request_irq failed\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	/* allocate dma memory */
 	priv->shared = dma_alloc_coherent(dev, SHARED_SIZE,
-- 
2.34.1

