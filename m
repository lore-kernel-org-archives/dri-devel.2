Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75CACD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 12:05:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EB9D10E7D6;
	Mon, 18 May 2026 12:05:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="laaGXP/g";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013031.outbound.protection.outlook.com
 [40.107.162.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 669D410E7D6
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 12:05:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wktTlSVqfZLQPEkwGe/ELOBrnGrpL8a4YXpjRLSN8FooI0mZ5RMDrB+BkWk/WawQYdbxCspnmAO6BMQAs0fD04cbyrbBzhScr2m5NjLINsh1aOQmGgc0S0Xxv1Gc5aJg97fbjp/S8uKNfHb07xSKuQdgfpD+lmhHKdclU9vjIIi8B8EwXBegJTIVpImNxpv0gx3cU+TMwiPu7Q7UJLz4PRTRXdQpjXWOtICuH4GFzpWfFR/pWMgRS5Z9NxA+TniEDwx6y4xGu0mZbDWa9IuFejJry0gvCpaCO+nSN0SGJioJQxF5CCxF9bpWEbffghKYQN5q5/Zxi9oh+zNkPWfwcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDxuOpfIOYT72bPJ15mpmilBs/RaSXzitxNg0KonYmo=;
 b=gVy2uDqfk5u3F4qNLaAYPW0zI+eXIGjJOlaZuuvrGOAvBiaCNp1BM6PmRHSyQ0uxlJUv+hTx6hXSfpSdvnjUYGO812TfS4CGhp4zW5KQU5Q2Xa+1293mO51FKwznhurCEDtMWJrnOvuGKiiM0VFDY5mIPGzoFjScmLtLBIjpsi02kVCOW5n+UrZpQh3boH58sXiuaXRaUjPGh0H/KSHy4U2/EmZe/P9hMsJO982nHYbnmnZpG9e1VOpKEGq6o2pGLQDYskuz18BMH4mkWzQr3iQU/Jz5XXoAxVcnEcY4NEFTeNwy3mYQpKejVMDeZ9jEaDnTqdcNzxIw6CerjV1JGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDxuOpfIOYT72bPJ15mpmilBs/RaSXzitxNg0KonYmo=;
 b=laaGXP/gZTBR3EjK3KfOgKwzUpMIg8FmV6LpV1GwuhinVpne+5L1YK+3rufgvFT98n63npNFounrnEHcxR3F2keVAEXDQZDIl0PEDFOPDY9NsCvUeveSITMPDUwyK0AMkyN5WXlCz0hZ8b/sW6PkYDXi8jo2d36D78lVXHcpl6upD+BnWfko8M0RCMiMVeAdf8Ls/2zWrbcmkN78niPhO2uhfVmaIKeaI8kS5tU1RGsfBMrYLJSWEnRjmEclqdI64jWt9zmYB7h2EQigjTCjPiKRgtUsw7xrokKWVXv3XYHAIoxlEXwVb2E4a39RkJCiEOJA5ePQqztl7rq799KsAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by DU0PR04MB9225.eurprd04.prod.outlook.com (2603:10a6:10:350::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 12:05:41 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 12:05:41 +0000
Date: Mon, 18 May 2026 15:05:37 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Yicong Hui <yiconghui@gmail.com>
Cc: l.stach@pengutronix.de, maarten.lankhorst@linux.intel.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, me@brighamcampbell.com
Subject: Re: [PATCH] drm/imx: Fix three kernel-doc warnings in dcss-scaler.c
Message-ID: <zu7ancfarhze3lw27d7g4i6sk2z7hjv5frybile67jru4thml2@sfakblqlfsdv>
References: <20260406180013.2442096-1-yiconghui@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406180013.2442096-1-yiconghui@gmail.com>
X-ClientProxiedBy: FR4P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::15) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|DU0PR04MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c94636f-4f90-4ceb-cbd3-08deb4d5c7f7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|19092799006|1800799024|11063799003|56012099003|18002099003|22082099003|27256017;
X-Microsoft-Antispam-Message-Info: Pt/LJODFSHjRk8iLQe5IEGzN8s3rtj5N2nT1ZpOLm4IgLnb+34PN48PAXojVGteL+8Nb/N6qQ9cmwO+uuFh77lqbD6wG6BGgTob1P1vpBM08+aIZwx25VUuzaXdSVgU1tnB1SMAFvtVGIJLuZc2Pf9kxJEiTFzswBP3jCmNmrGM2d9PUbEbZb2v0oDEx5wvyHbNoxBzlzWPyZYgsNl0oJ410fLUP47zW7BZN6+ZEsM7vg/TPLaqp9BkVs4+W7sqb9/3SufSLVNrgS+gn9heo3uz47Ghb24K8y+1wiU5UxXUOHoQ4xGwOfYPmaCSMDWdaCvWo0iNZT/4/XA1hc4DROiibYlAv1Lf4ZwYxELHdfbWqqgjTwpduGoj2zyM9qAnYFGiHp8NMhQjppPvco9GcDwlgErzFMs2Lq/f41EdyRa3inqW3W2Wi3GTstXW+QKo5jh7MSj3XLI0DsB39ZbW1Dp2C3cmB2xNAvR62u2g7dKI+OvN0HiWckl/gLqwKrDLeRp/D9REyEYd9X8EtfThrJG6UpyrCl4f2LpHN8u5W/gcgalgSsp6uN3t/PK8KbuDs/uG0bPmthxk5vepI7WM+WzkvatmTL5WihxWPXsqn8mDaZ30xec3hqg7WzCsV5rEVL86z3Wejze3l32+U7xZgh174YPS2/kBxpHYR804+TbUStkwgl0kXluLP1WtFgHQ8zVdhnB0D7t+ljjdw8dFEugcObHvm3sKWWIH6PSmeWGnZpLQ41DifRyuv5KB0Z3DE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(11063799003)(56012099003)(18002099003)(22082099003)(27256017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jSiZ1qgQUwYO+uOUXH7VE3CE/nLmFjWQ2DaY3vDyjGssVfCF5AATK70f9ACJ?=
 =?us-ascii?Q?yk0KtTK5Z7S2cUKDTWvBLxZK9mfGm7DhXlo24B//pEOk8LxK7KHp0qWKrZ7M?=
 =?us-ascii?Q?0u8iorFY8ra5seo3eldNkcvNnrORB6YfG24RX4xIOttMW5wR26Fq17DIdu59?=
 =?us-ascii?Q?T9JoGFf3Lg36c2oBxFnhbchA9BNRFlgljgxaLQXK4sDjWjdHKyy8vvD9Mjcg?=
 =?us-ascii?Q?ioEYIO7D8n8lFd01KNFdPzGH/U15IxDkCbnvuEYTrynfFFza39gDKqTgfJxA?=
 =?us-ascii?Q?XguJlI0Xe1X7I9VeKR4ByOJhq9ES3jN7gsKJYdzNuwb9t/JhjHmX5WTX+6qP?=
 =?us-ascii?Q?wMCNr8FtNojbd3+gquUaV/QII8r1IRWpZKz0+/iBf1uYCnB1TmjUlkyTz0lM?=
 =?us-ascii?Q?qEXelHLVZEZx9biBjB14wP3l0RL39me2Zr9KfihyaFbYn6zJlAMyWrO22SdU?=
 =?us-ascii?Q?Wm8BXZUOoW85LdeOtYVsBA4v9zFpMiYB8Kb/waLrdguaW75GRM8qtBy2u2y6?=
 =?us-ascii?Q?MqpRh4XukJaCkMM+V4VBaMdYlRv2hAEfCpo1sUo+a2NPGucXPP8++tU0r+1c?=
 =?us-ascii?Q?P0Nz93YgpdgF1/5ko6qWFKcxH900aaTxiFt4ncUdpmi63077E/MU5Mzo8aj+?=
 =?us-ascii?Q?ee/GH9bjdozppEj+iksCQBOAdsde7s0BmdKbmq7X5r6uOcuNS2r7UNwyM6cM?=
 =?us-ascii?Q?J8LZg7HFiO3UnbUFn9Pc5BBtMxBC09BaJ3k7EGaF8rHy+RUjfVJ4wvwU4Fn8?=
 =?us-ascii?Q?NfXOsvRRqN9Eh4N1MO6TVY1BixpniM6HSHfzeKt/IJ9lPD1RKhvFxBRQol2S?=
 =?us-ascii?Q?JG9fwKJG0T4pP+GtEFZUN3vJrf+HakiO94wAxOWSFSQvCKey5AVj3NmSdAcF?=
 =?us-ascii?Q?+lGifG6r/2GMCDwhTla0zXFm61L4UnZVycsEcMqY3YSkdLpujtuNuDkI4ISi?=
 =?us-ascii?Q?MumIz9mImdesV56xYGwUnlBqXAYUtso92v9LTNDyMHapOv/jeroJLRMnu0qr?=
 =?us-ascii?Q?Bx7ROyWaYvZRDElxUptfE2zOSI1eJQGY5n9R0fhX6GLPtNTKREYZ+E5l612c?=
 =?us-ascii?Q?g0JuPOE+z8GaY6fkctfLtr7WzNiIupstpbWQ/YaZiPVk3rY9u2ZiY1gH73TP?=
 =?us-ascii?Q?gDO0xTUs0KWxNQnhNkcho1UGgBZtfuW7Hsq4eHxsZ0GR2xLRQqbzsBKkt7Uc?=
 =?us-ascii?Q?ZTVneng2SfhnWImWkPHfCugG5LgLjYTX+4RZqufubg11tb07p/5oE0qn2A0e?=
 =?us-ascii?Q?OwDKo4BaMELJmhTyd8JDduDYssRfa2KEynIygwELPzpTb2CRg/9AQHVQZyxV?=
 =?us-ascii?Q?UhujTBCP5uJmkZRjnZPlbYIkm+6TFRoMRw6WPSEwpYKovibqOQ4PYuzTQeDd?=
 =?us-ascii?Q?woqFXBStnPoYf2Ol/rPosk3ucn5ravhCNBZ9oT27YGCuzW+ou4xSk9+GaGcb?=
 =?us-ascii?Q?Q6csxDjDIenVf+rOh+zgaajuXmdhvuOBPWzBexrz08OGlx9GV9PszxUrEtOv?=
 =?us-ascii?Q?1R6aRoYkC5zktQrLrZ1vEe5l6M5QNb+oEmrhTAH/40xull4eRpAlntEpLn4w?=
 =?us-ascii?Q?gtClCRafjhC1PgHqxzSux0sA4ALIpGDp+brRmAGviu911Fbxb4PcV25oeRsY?=
 =?us-ascii?Q?zvI1gQbFW93spfVXWdnkgswFs7QHTNiNLYooIEzg4Gi5Weo2OmesecFkOjk8?=
 =?us-ascii?Q?P7icHw6mIAr5jr45kC5MVqRanmKk4uTECV1zgx6/MPWhPtcn6Cgym9PahCe9?=
 =?us-ascii?Q?ni0jnNpYHBB2aRCvhiz2ey5GO72+wnc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c94636f-4f90-4ceb-cbd3-08deb4d5c7f7
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 12:05:41.1703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfKT3IeXLo/08Y0oxIeq4Ok+XVopXTEMlQ32DO1XGdtQk146gp9TjkWHspmb5WxUUccIIepPCixmI92QsldqHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9225
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

Hi Yicong,

On Mon, Apr 06, 2026 at 07:00:13PM +0100, Yicong Hui wrote:
> Fix the following W=1 kerneldoc warnings by adding the missing parameter
> descriptions for @phase0_identity and @nn_interpolation in
> dcss_scaler_filter_design() and @phase0_identity in
> dcss_scaler_gaussian_filter()
> 
> Warning: drivers/gpu/drm/imx/dcss/dcss-scaler.c:173 function parameter 'phase0_identity' not described in 'dcss_scaler_gaussian_filter'
> Warning: drivers/gpu/drm/imx/dcss/dcss-scaler.c:270 function parameter 'phase0_identity' not described in 'dcss_scaler_filter_design'
> Warning: drivers/gpu/drm/imx/dcss/dcss-scaler.c:270 function parameter 'nn_interpolation' not described in 'dcss_scaler_filter_design'
> 
> Fixes: 9021c317b770 ("drm/imx: Add initial support for DCSS on iMX8MQ")
> Signed-off-by: Yicong Hui <yiconghui@gmail.com>

Sorry, I totally missed your patch... :/

Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

-- 
Thanks,
Laurentiu
