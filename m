Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9783AC44503
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D296C10F39B;
	Thu,  9 Jul 2026 06:31:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ifI5efxZ";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C84910F399
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:31:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uq5bsKoaaK/im2XxZTck1iOjy+d/ShlbeAt2IExfuzBWrIVMBh0Wx39Qe7Cu3h13irzdz+C7xWkyOV03+rllLk82L+3O7WSBnl7kgbQYT5Yv6AxgEujMr1lgzMO9YIgiqXjmLKH7x7lTd0VXmCRfXkCxh9ZGYjkM5U69d+7t907kSF1CrTubM/7+xv44xeXQQEqBd4QZVsG7eAGm/FDld6f6a3fb73EkOQEesTrs1pePtEWglBotM2+vbOPdxoZsME1Gs8hHw5p2sdVEHQDORcVR1/FiSrhRz+ymNyj0dSpKhYrDZojSrSs5AB3onkfo6Ea4IA9fJiaT8iekS+RXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8DPv8kkEC9Yh9+QtClD8vC8dWL/7URFjUvAwvsLzrA=;
 b=txlJAnZE96NFK7p6xnMxkzELdb4Q6rCLVky17EQZJA6FzHPp4yYwXxM6n5oY9wL9Ap327gAZi4AKMpXev1c1ZyzSXILK9gALNl+4xONH2Tlzv+9hk6m8+lkd1IEmI1QC7aJ8307sSf7PFOIXM4MmtP4JaZw3OECPUFTG3wKFNf5GOfAg1LEXZ8fkXw5O3FieqNHXny46atprBlclEi++Zx/NzrkgsnTcdE6SA7tKWUAhR1oned8TIYeeFK4bJvFWqf9ucpJDn3SjQba9I8ppRjLfhMOLpTlS0RXOWsH/V1yXhJG1maYD5Th+Nqm+PeFm3CMlhdGvSjSxaK2m3L9Ajg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8DPv8kkEC9Yh9+QtClD8vC8dWL/7URFjUvAwvsLzrA=;
 b=ifI5efxZgIMWTkmgFlKD1y+tOdp14uht10uP+vvENq9ahAkByDR/YMk1bPri/C5RPz0cpGwBkdpj2KpVuOnmdTR0ze9zO782sf01hF1WUtOp6HX/LMGepjv2D+qRFmgs2n2VTlly+5p3+naewbvzbHJFRrV9Jehud6T7SPx35DWmQ+N1xPVO0Mxg+8aIwWSrCdA5mrC7xVeqnSXjIMZb2udDVRAp2d4XoGtF8maMvlV/7QIQqlfcojJNr9gntCK4xLOzoHpa9kPjSeEwyV2cnyRWNZc+et0hkRNed7VlWl3Hx56r1ZRiUNR4gGF6mBtq4rL0yqkR/Jyz+9Owl1pavg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by VE1PR04MB7344.eurprd04.prod.outlook.com (2603:10a6:800:1a1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 06:31:25 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 06:31:25 +0000
Date: Thu, 9 Jul 2026 14:32:57 +0800
From: Liu Ying <victor.liu@nxp.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] drm/imx: Switch to irq_domain_create_linear()
Message-ID: <ak9Amc3uqJ6kWYqu@raspi>
References: <20260708095645.385291-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708095645.385291-1-jirislaby@kernel.org>
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|VE1PR04MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e09389b-876f-4911-6a6b-08dedd83b2b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|376014|19092799006|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: eSDe1XQvzPwpQ37tkFG+xmlpiQ7Y7HMY+7KJsDjPrPb+vH5SlC91KJvaV4vneqoC97nh4svsK3AmxcWWUR0utjGJjOK8Yw61S15O3UgF1H+3CNyv6dn48JY4YKd1ZJy+aQ3DDqZq1wrckx9pZL8Kto1g0Y/YPe2jH/vvUkk3+l27/eqrhyfx64tRxzqtgOXwYi1oa0rtUiIEp3o/xbe7NByrCT2JlHypSH0rgrkiCXXNa34Jt85aNzmXpyWLCyvQdrWPVsVqnGRMDXJBvKE5TOdJ4mdvMhZO4a9+93k5Xt1EK8qLsvTPE6v3Wn3hlhvHvIJPoI8LT3w9/6bFVN6hOwZ/ADoMMQb8Y3xxwkQAs0RcJNWFaBr1Q5x1YpD2RSmU3FNxIPijWBFLm7wG9EgxaLTCoOo3oRveEprJdyCw2NiSZoVdDqGeerM1e+LGCfQYQd3e2Eec0GSJBN5Chy7iGJJqfmPDNPgw4zkFdXJ3ci6fe/jefk7S6slBrg4qpc5cLl7eHsI4q67IlVRo4/0YSFR9L9lXTAtF1vtMjTGKaSoc3TWH0kI19si2xnbsSF1kfuiC2Xp4vsF++1N1ZvWklD5+iIgIh8u/aHQxucBD21iEAChlSXccLz8Qe5zve3UkateXUfkS2mXAdsPK1XZNqFSnGt6poRJn3tBi7J3MfVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(19092799006)(366016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bpMY3dBR4ddAMMCu9i6CKbR2Nmfy0bczlcZPJlh1QDsbP3BSsic8sb6XpFER?=
 =?us-ascii?Q?XCKAi1Mk1pzGGCABLlwcPQkW4RBXJxx5GhDRCa7N6yv+AmVwIkW8Ncj8tz0l?=
 =?us-ascii?Q?adRZ/rz+Ak4MYo+NosFfB6OV+i3DKIUizP7YwmmKoZWnbPsyqv43RiBd99QJ?=
 =?us-ascii?Q?3QcQDc0LVd76ih2Emz5wpC+eD6FuA+toUaqp5Mga0lMzfLp1lkBLpv0PpaZN?=
 =?us-ascii?Q?2Q8AvPc6uWbpkuaP7z5+8dQkd6ZOsVLQXmAwYEkflaV1ApEfCKx4YgfT6W+a?=
 =?us-ascii?Q?6x/Zhj4YkWB9Z7wE0MY/svdVKFNAevnJS9PFALB8uK1WrkyypQFXhzit4JH5?=
 =?us-ascii?Q?YvCARGYXno3Lh2j5EwGOao6SW75YV2SvTa3yd2DM5LFOb45/p1i1dgj4oMgt?=
 =?us-ascii?Q?4RvlMvteS9kHfQhY9jfBtY91RKTAdASLLyuNyEIiMy1luzWQFZxjV3xZlWNu?=
 =?us-ascii?Q?E8rXcMArMNeJFPbUqUEmKR8xFZmHr58W3Mqtr+ij/dFDAcAkCgtc7GR/GH+U?=
 =?us-ascii?Q?Mmit8tboZ7nU1Z98tsmpHDj+Q+L1Zc/Ez6kTZCD9chbwk5gaq5A8KqYSXp3l?=
 =?us-ascii?Q?1i71nBwu7QLyVDiWC9jWGKcnsuxYjRo5lcTzTqi/qmTI9in6960tkQ/K/h1g?=
 =?us-ascii?Q?h7vE3FHH9Fo8XWawMg9hemhDhA9q5jqEl5Q4/LxwRkpEA3hh2/tM6n12DbhR?=
 =?us-ascii?Q?yFOVLiaXvvi3aZ4U419veVz+8TetCHpyJJ+1yJitWqoDjSNFVDL2B3lAmIXd?=
 =?us-ascii?Q?ySt9N/25YHU7LEJcNWQmI7d3bKPCOMhGWVbck90pbQAgVxpcnQVkQmbUmmwO?=
 =?us-ascii?Q?/dnwJG3NlhCeezx0lYU07pbGFYg5ybcrKPELGExpxrn4xA3QL6ZG7Q7bSXmF?=
 =?us-ascii?Q?aysGQ0HhRvxLSi6yi/LTlR9cMcRwuNNtdg59P4Xi/Rx3Y7VFwLdyp7UYc7PD?=
 =?us-ascii?Q?Fs6QZdM/JmvfI6VSkZSEDIlTpgWP4Gr+gXuznzSEWA3mrX0nDGPaLnIRdNi5?=
 =?us-ascii?Q?MOt1rpmdOs5ndKBIyuPB0ltU7C7vqxepD1KgguW5SgMW47H8ClA+RMoNMhtT?=
 =?us-ascii?Q?yZ3LS3UVfimqUPgw4FUGJF84fDwv5+8YnbEyQvM8ekGbMdZEyGEJePLpscF5?=
 =?us-ascii?Q?2x5eW5V/p2iHwHvQnZPzMq9L86m28vvXp5vaB1IEu4ACldKkQm87OYx43C4y?=
 =?us-ascii?Q?Ags8KhkkiljRGULxKGyVZ8DTFxOCexQqEcGb17UU5aF+ANG6E4R8bIW9/RAV?=
 =?us-ascii?Q?BXQx7gfdVJRvPdrCwn2RNJ9C9bdQo3BGy0ji+Ez+67WK4qna5YgFNFN9QPdp?=
 =?us-ascii?Q?9BzwrAqHZ6Wytl2PVcaJF0P4gRj3/7PSU4f3y2XvvcI0c/Uvpqx6M9YBJNxn?=
 =?us-ascii?Q?PwP1Gsi6tJJHjr+KtdCPUcqjw8cnSd/4BVWU4YjYA39hQsDxEnlPQAPCief+?=
 =?us-ascii?Q?pccZSVHsRKlmsJny+fA5+4veRLPbbZZo4cF4aACIUeThSD12jmKLxkeCXG/d?=
 =?us-ascii?Q?G5gVVwAXI9CC3a2Y0h0Ki5asZtG3bMY5LX4TZ9Ez4/PEuOuew1krFW9qnYAa?=
 =?us-ascii?Q?ETTZeJxkeJz8/5kkm2lj7w5nbOKv/G42aAmTPLAE+BRT4u/mDxOGEqHqJ29u?=
 =?us-ascii?Q?Pga8/zG8zWeTJey8pen0DdQGcGX44dBSbVK3yk/1BMCqvbIVoSykItPPLz4b?=
 =?us-ascii?Q?tGwV43KQ28LrCVmYQD2rUp1m6RNbdK83LyM9zEOrv3EhzP55qB0WWFHO2SGv?=
 =?us-ascii?Q?8EpdlIHWxA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e09389b-876f-4911-6a6b-08dedd83b2b6
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:31:25.1409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ER1Yds/a56FfUfRl71chtIIWwf46f/1rzQ684eV9wtcUGOv59QEqL0x0J9w1eHedWrZf13x5lYrLR8+/WZ/znQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7344
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

On Wed, Jul 08, 2026 at 11:56:44AM +0200, Jiri Slaby (SUSE) wrote:
> irq_domain_add_linear() is going away as being obsolete now. Switch to
> the preferred irq_domain_create_linear(). That differs in the first
> parameter: It takes more generic struct fwnode_handle instead of struct
> device_node. Therefore, of_fwnode_handle() is added around the
> parameter.
> 
> Note some of the users can likely use dev->fwnode directly instead of
> indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
> guaranteed to be set for all, so this has to be investigated on case to
> case basis (by people who can actually test with the HW).
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Liu Ying <victor.liu@nxp.com>
> ---
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/gpu/drm/imx/dc/dc-ic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/imx/dc/dc-ic.c b/drivers/gpu/drm/imx/dc/dc-ic.c
> index a270ae4030cd..d8aa46ee6a7a 100644
> --- a/drivers/gpu/drm/imx/dc/dc-ic.c
> +++ b/drivers/gpu/drm/imx/dc/dc-ic.c
> @@ -174,7 +174,7 @@ static int dc_ic_probe(struct platform_device *pdev)
>  		regmap_write(data->regs, USERINTERRUPTMASK(i), 0xffffffff);
>  	}
>  
> -	data->domain = irq_domain_add_linear(dev->of_node, IRQ_COUNT,
> +	data->domain = irq_domain_create_linear(of_fwnode_handle(dev->of_node), IRQ_COUNT,
>  					     &irq_generic_chip_ops, data);

'./scripts/checkpatch.pl --strict' complaints:
CHECK: Alignment should match open parenthesis
#34: FILE: drivers/gpu/drm/imx/dc/dc-ic.c:178:
+	data->domain = irq_domain_create_linear(of_fwnode_handle(dev->of_node), IRQ_COUNT,
 					     &irq_generic_chip_ops, data);

Acked-by: Liu Ying <victor.liu@nxp.com>

>  	if (!data->domain) {
>  		dev_err(dev, "failed to create IRQ domain\n");
> -- 
> 2.55.0
> 

-- 
Regards,
Liu Ying
