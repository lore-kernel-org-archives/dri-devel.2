Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB744C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 21:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8405F10F1D3;
	Thu, 27 Aug 2026 21:08:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eVUuAiHk";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011003.outbound.protection.outlook.com [52.101.70.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8C1810F1D3
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 21:08:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTz5DIReNUDbkKvhwmLOYimAn42mzxytMxfLPTmdIvhr8TzruD6JHFnMZaaArKGU300YP++Y6qVBzN9FRE0LddPlTfBTHBAJAl7sPhe3OcVdHhuyy7y+4lIJuL+uT5JlvbL34aNbC1SKmwooJqj7UMpZ7dTrUxkOz5+FgzllRhGqhs1Tnmcer0E1g1HyjHRL+Xv7qnB6MjYdOl2KPA40AFHfIk8jjbvxziBeKfp3wUe0LmZMu5eyMwt7mFy0vc0lyqqFQPA5sSuubI5r3zCVL2Ckn9uMALVhBoahkrQrbFtQZ8Qq+ZT4QD0H1cwH8qoPdOK+jPtNEp//KM5BTQ1+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/1jGQByZBJtPs80xUtwhyTixpmN7TzxNeKAcqZTSvU=;
 b=k3OJv6JI1fzGH+nhwH26hJQEE8UYgM/pCAaPCEw3Fe6aPgfS2w64Vz9KMnXGkZGZQ40TgDPjqSEdDLjAR76xu8NdZlqDYLRUE5iS3vQPlgSBP8daVNd91LrZy0txGnI7JH0GckuP9CYCx8Z2WdSjmjibHOmSbOgbMWT9X0CHrn2V/PZ3kJ4IrlqpYAez2owipYRgWDyghE4ZLcsHh0TMoQZzzWt4Any9baoeJpLuP6BJvYIAHlU7RcscRU2jlrJOhReeEWosk5DTK+f3/pt0aDyOGZf4rxCp/O6jnfzmZF2Yva+5+CoGTYOB2FIr3ixuPeKA1ckC561HoKH7vA+iTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/1jGQByZBJtPs80xUtwhyTixpmN7TzxNeKAcqZTSvU=;
 b=eVUuAiHkEcn+dU1AZEKOv6kvkfGzSC7yYmJOLDEOwICemeWc/JNrGtDBUya7o8650kobEq1qxQgtPjQ1BWkZZGrD2G/tiGpQNoRJorlxR0fE9hczarcwNpVWdfCUfZ2aft/DVKymL9Nk6W75yotm0decQvFzM4h6y//q1gz/VzvDhA6CGy6dCm2qBELoOJLE6jxQIsiN7ozTGXPhn4zi30OZtdbr8jssXief6Ge44ZNGaJOK0WOMEnJbqBJ+9Iq4a52tl5ZoZnDP2/8V59O0bOjwAKde/BQGJEBWVWf8ZHgqsSpHrRxR3ULK5FXTUn4xN5dZPskojnjDak4vqCmQEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB398878.eurprd04.prod.outlook.com (2603:10a6:800:35f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Thu, 27 Aug
 2026 21:08:22 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 21:08:22 +0000
Date: Thu, 27 Aug 2026 17:08:14 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] accel: ethosu: Fix probe error cleanup
Message-ID: <apCnPtUSknO0XBSY@lizhi-Precision-Tower-5810>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
 <20260827-ethosu-fixes-v1-6-346f9ea8791c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827-ethosu-fixes-v1-6-346f9ea8791c@kernel.org>
X-ClientProxiedBy: PH8P220CA0039.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::31) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB398878:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b07bb65-b3e0-4cc1-3e2a-08df047f538e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|1800799024|366016|23010399003|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cOZXrTyZBAx4yGymCOk+Q8VAZyjU9fMRkZ1soU8eNT+aFUOplIzNfxUXSvs1JLVWAt3+fpGMbor7w0EvQK7nNOf0agdYgpyJeKx2NdMcZX0UMbOkgvYRXxRo+tEMnEYhglAHWr8AzsRFgJHwv89wHcYGKuNYCLveLmQCypvcv7Z8/RqdnqDwmEuy7bnelDzshdN3/FvcTWE2Jxh2t2OjJdWu38iAT2rzdqzKZmyNQNZt2TNFDupfrfKiTBbFb1E7ahRHHuayd53bfM3ZF4cwWVo9OocEDp+jCzNIOF6eoh40hKfaSNBxQUBoq6f/cRkH36m8wqOi2jElJwdYs2RvtQ/B6NbsKUFjfJ/PfEE6Ok41j0Dp14S3X+nKnh1UJx5z5Q8fk2FVD4wDmaDf6hRKtkx8SDrPgW06gE2tm6M2IKsVUfSFfwWduXnKQnVzV9WBxhvM9OEmh6mRr+xLMvL6x26FXFo8H+U6DwraTUnlKH57YAAAHdLKWveUAHDND0YUHbX1ZPVRDNiBpukcRQYL+NVAnClEKBf9qAjsogTmYbT0XEKjmHqyR9UJvI0qW1mcy8dIhjxBzzf/a58VWmVNu2ONPVfaDkGgJgw0cE6hLif4ungES18Mt4LqA2pYbYCxj8OIZZNo1w2c12jyMLOthToiZ6ZX5AWCMwN76IYa6bc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(23010399003)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ph8S3C11OLZRhxGHI/D6k9Nmsndv25S6kdwIBtbPhPz07oySvvKbJmh4zJH1?=
 =?us-ascii?Q?2FJR59sdQyNKeznyGG3yJ6/7crFQlfYozR7Oh4hE5KdJFmE//XQ98155vtRn?=
 =?us-ascii?Q?q3ylLSyeBFzNZ8CSc0l6sC2Qfo1BNLsV86t7JP/vy01cnTBbh7THvYTyorSv?=
 =?us-ascii?Q?zFSd3HVKFD3k/537Yn+ra4+WRY3gizFYkRKcgWXP/R/AoCNtwjs+2FLdJgJ6?=
 =?us-ascii?Q?suOpNiN3zNnkKJp7Vpy+uDCGkyjJEqfME6FsTVfkQWmUXn3dqzOqhwguEX2S?=
 =?us-ascii?Q?Tnn7MfY6/pEeDRv6bDugjaAhjBK1IzKFE2Qv0E1FZGO+Vx00/3SUQeLW5eOn?=
 =?us-ascii?Q?qVE8EUwrH7bVssAm4ZzNdY1E/CsFXutGU919faiuyE5SY8rfg596SJxIAQAj?=
 =?us-ascii?Q?iw7jDUflF0HICuOjhLuRUrmY5VPuKlRkwlAyEHDVeCaflQG3rJI04vY97zeU?=
 =?us-ascii?Q?zdyDNk4ULvQ+Xi/H4atK6qSedtdeYi2W7LeuwDR8CwiqwZlzX3BIg6L5uwiF?=
 =?us-ascii?Q?wPNjqHSrr1xpDpAUSnxEcICnS1QXrKZBHj9GEdJqbHXW7ccP1B5YS8hHAr2F?=
 =?us-ascii?Q?O3yETxYRFuiaDPK+ku0XjN5r5KTb7wN6yUSDyQn6TPZ4wzsPNu0GPkaBbqyf?=
 =?us-ascii?Q?tJxVQsqVvuAqaODjTXMtHYcEP54M3B6wQX1/4Y2dJUQXOMnPN2/KwbrQ8byP?=
 =?us-ascii?Q?jOwTZ5eUzbE/ND96rdM9P6zqQbVV8F81PspOdqtpRZnTKX0d0f4pZhOre5uM?=
 =?us-ascii?Q?OZtJwe4hgOehatpSmu7Bg1tp/SZJt/8R2CnC6m2Fqhcp/A3K/StfU/VKZKCt?=
 =?us-ascii?Q?3MLaerM2+ebZ5SApPKiikCWPswuZxv/SOjWSPwck1w7j5boy/dDoyqP1z8af?=
 =?us-ascii?Q?IloZK1a2HlbEY2GpZAuU2IVjWb+5XNr4MFNFrzyO7QYOgvAEY7aDsaOYjtTJ?=
 =?us-ascii?Q?fiTi5EAMh1Q6oLJt8lmb5Caz23i2fx+SEt7xGej2xI2b+t6RrrLEmDlKRo9y?=
 =?us-ascii?Q?MI4aYjzN9N47YjfKTctZyO4sxMx5RyWG5a34s98H3QxD7rwxnYmsMVy8bwz1?=
 =?us-ascii?Q?4ZzU0QNgkIQtWmwZ8WsmSy7xt95WZv5Fo32U6opMLz2+G5CbmXgP9tZEH6vY?=
 =?us-ascii?Q?bepOPXYsoTtMtwZyxrb8bmK0cGczrmZm3IriwLn6WjKbHCfBNSihEkAQI9Hu?=
 =?us-ascii?Q?vzFGLFm6iUJDWe5+FnrywXanEI5IQkLIWnuzIEBUFkR0fiAjbG6eazFZG+sE?=
 =?us-ascii?Q?ihpsuh/9aNBJueRpaZLEoiVokH5mI/rv+uY5HeuEM6cat6tRTTizWvI6BUWF?=
 =?us-ascii?Q?Int4aKv3dTSFbSOEI/lTV7w0erBfHcjLADbXeN7dn/bX6LqUIGT9LgqZ+QQN?=
 =?us-ascii?Q?wEC80CBiP+wp12v1k6cA/Ai+EM871I+nAU046Ol94fzKL3pfHvg4l7bLhLDS?=
 =?us-ascii?Q?oIzb/WGkH13wu4b8HxDRdrYTHC5UDvbr+neSZ1x54IVnOyZBycO8Tkhr0AV5?=
 =?us-ascii?Q?5elQPuXa0ABWDhksQRPYDC+u0kdEfFlOl2YafB4vH12vv48jqdOqaZbYspU8?=
 =?us-ascii?Q?69QpC/U1tDnvkpN1+C9EzfXXgZ8XNw8ihcK66u3jFfRemTwn/UxRsCusDZdm?=
 =?us-ascii?Q?hXi2wT40gtqjv124Tlp2Xc+3Y/rO+SL2s+Y4O9F0d1y2KLHaVTyjGMMXXb10?=
 =?us-ascii?Q?xZSEPhmkOfuDTVCWZG9u8yFKP7RLIrrk3JpvPh/UT+uw3cjaFexH3131Ox9V?=
 =?us-ascii?Q?oYNDqbM58xAMFrlcBLRCpa6QEb33hl+mpD55yunJ9gDVHu3J9PLe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b07bb65-b3e0-4cc1-3e2a-08df047f538e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 21:08:22.2196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYya2WVg24MWiAsc1aQOyiSXCH+x/T8XoYzoOm8ypiTM4KjdJkbeFQMSfpyztg/BP1bTzpJP4FJ0o3RJOu2OfZDmSjl+BkY8Ff6c1e2CE2WI5NZB8J9/O7+Rpi4VrDPL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB398878
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

On Thu, Aug 27, 2026 at 03:33:05PM -0500, Rob Herring (Arm) wrote:
> Once the job scheduler has been initialized, failures from ethosu_init()
> or drm_dev_register() return from probe without tearing it down. The
> registration failure also leaves the SRAM-pool allocation in use, because
> the platform remove callback is not called after a failed probe.
>
> Unwind the initialized resources on both paths. Also do not call
> drm_sched_fini() after a failed drm_sched_init(): the scheduler initializer
> already unwinds its partial setup, while drm_sched_fini() requires a
> successfully initialized scheduler.
>
> Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/accel/ethosu/ethosu_drv.c | 14 ++++++++++++--
>  drivers/accel/ethosu/ethosu_job.c |  6 +-----
>  2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
> index f1af7b3ea038..41ecfc623d42 100644
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c
> @@ -371,13 +371,23 @@ static int ethosu_probe(struct platform_device *pdev)
>
>  	ret = ethosu_init(ethosudev);
>  	if (ret)
> -		return ret;
> +		goto err_job_fini;
>
>  	ret = drm_dev_register(&ethosudev->base, 0);

Does this involve any hardware access by callbck? I suppose
pm_runtime_put_autosuspend() should be end of ethosu_init().

>  	if (ret)
> -		pm_runtime_dont_use_autosuspend(ethosudev->base.dev);
> +		goto err_pm_runtime;
> +
> +	pm_runtime_put_autosuspend(ethosudev->base.dev);
> +	return 0;
>
> +err_pm_runtime:
> +	pm_runtime_dont_use_autosuspend(ethosudev->base.dev);

it should be call by pm_runtime_disable_action().

Frank
>  	pm_runtime_put_autosuspend(ethosudev->base.dev);
> +	if (ethosudev->sram)
> +		gen_pool_free(ethosudev->srampool, (unsigned long)ethosudev->sram,
> +			      ethosudev->npu_info.sram_size);
> +err_job_fini:
> +	ethosu_job_fini(ethosudev);
>  	return ret;
>  }
>
> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
> index 0982722a9195..7cadd75ad0ba 100644
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c
> @@ -349,14 +349,10 @@ int ethosu_job_init(struct ethosu_device *edev)
>  	ret = drm_sched_init(&edev->sched, &args);
>  	if (ret) {
>  		dev_err(dev, "Failed to create scheduler: %d\n", ret);
> -		goto err_sched;
> +		return ret;
>  	}
>
>  	return 0;
> -
> -err_sched:
> -	drm_sched_fini(&edev->sched);
> -	return ret;
>  }
>
>  void ethosu_job_fini(struct ethosu_device *dev)
>
> --
> 2.53.0
>
