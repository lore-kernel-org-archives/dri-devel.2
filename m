Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB21C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BEF510F1D2;
	Thu, 27 Aug 2026 20:57:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="S2ZRXir6";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011020.outbound.protection.outlook.com
 [40.107.130.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 409F710F1D2
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:57:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZTzmkFuAU9O1fhEK34M5mZSDz18rX/iShAH0+U1nnJPcWRsTa4XGuuNKFu75cW9eRfLkCmZdj8Q3EA6qtUSp6zimyBJizD3rlchnetwqnNhk3uKuQ29SIrurAZ0Xq+j6B070/SXNcF9SUUu/k41OEerzP6j7dd/KuTPyrS38zvt636xbKCj+gXT4haTWImT5zlP+tVWmA7dRWNI6BiTat5iVOoSjg5NHfUzeC+k547JeXN556JqfaPRvt92iIEo4Hhd7BMS4pmyeV0xfsmIKfuu+wDeoBlC13QjKgNu13IgkOCRVfL+L13rkL2SAlCDmhR+BYnHsS66nbGK2JNfcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tGM9AW+WOJ4aOkd0eHhkkRK+rwSWeG0CUwho4v4eyU=;
 b=E3UzyX/P2g4KDuhwneGD9NP8n0/HLqyZlEwqeDOYrJvJLc5RWfRNWwMzAS1oAeM2MBiWFjFtJGKeFvfJQpAcsNgDmY2JwNA/vK9UBX9pDg+VL9jYkLX6KoXmQoKMS8Nzj+D3LpXYi9HpHYqNSZ6OqDP0Q6EAiCXOgtRxpo1/cb6OIl3g2uWu5dUNLRLtwfv85oYaI0035lp4in44OrA5eatuvCBUodmByvHSPZZnbSt5q2nBI2bEDLQFWx/RTZblPvR20KFmumeg8kVL0Lj+VBDO4/SLD7FwTyvhx6ss3kWKVw9WFuXeySiN4RLnLLzDEchinYT03/DWj2raFZs5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tGM9AW+WOJ4aOkd0eHhkkRK+rwSWeG0CUwho4v4eyU=;
 b=S2ZRXir6fuDmAzJpN7S1V18aaI13GO+EYZL//dk/wjkl/wd200WHQRre+pXAueX4kNFhwO+nflZe5hl/czquGHo3u8ymKm9m3VBv9AiJrApWe7oQf/w3n34PlKb8wwt5DMKw07xgqpNdrvppoiCP6P1sySdDbRp7Rzgpot0svz3C6v4ZYWKgnfVMKDWBBTuzBql023GMm9DRLNErEHFE5wVEXEmUqtoFetK9Z3RXEPj2vNP4Q7DyEriWiEr0JHzwwou3+DCdH2p/vgxW+7pXwUXr96IZE8Sh+af7TuzywuarorAIwNzFHaM4VT/dxvUhyGpda4nol8+3zvEsQKtyPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAWPR04MB11569.eurprd04.prod.outlook.com (2603:10a6:102:50a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 20:57:18 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 20:57:18 +0000
Date: Thu, 27 Aug 2026 16:57:10 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] accel: ethosu: Ensure SRAM region size matches job
Message-ID: <apCkpjQtKRaTNQ1n@lizhi-Precision-Tower-5810>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
 <20260827-ethosu-fixes-v1-5-346f9ea8791c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827-ethosu-fixes-v1-5-346f9ea8791c@kernel.org>
X-ClientProxiedBy: PH7P220CA0131.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::33) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAWPR04MB11569:EE_
X-MS-Office365-Filtering-Correlation-Id: e76b4fae-f05a-470a-c0fc-08df047dc842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|19092799006|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SRJNkx7+NrRiVJ5UWf/yXAsSFv7SffFLH0Eaewpg6tc25w1W4XjrIFy3mvOa8sCWojomZ7Tr46s7mAZvXlKcjD74WpzsuRxqcL/1muqtWnp3xaaMjbt9husBPfRpIIhLvRcwY+6jdx3icRTKf+K6FiZV7Zx32hGbvlSAw46YPJnh9wmGkIk5MeVKmSS+5E+0K3Uw8JuVv142J1D4MT3d62OU4iS0T7INRuiAGa+qQBsuWdn/XTTs9QmA5Gy1ZvVuVrZIX/qCYyosAoVBpYEHgyfY+rxX7wk+Hy9q/td8LHudSGijPSdvE980MC8lym7zEpJrb9aL1RAAxXdmWd51lW8PvzomwlsVu/WvqW4/gGDC3Ub3xtGob8bG5KV+9k8YUB/51RQw0Vvm7fLeAm8R3ajnYWE+FGxcqE/ZT8eoUDkix7EQ+OnM1rO4F8D8FWrZwi8gUatNuyjHfqpgmJ1ZgsoI7F5dirMTWwLssvLTlWUnhfrY3h+WryJ1sgNsOPOVH76n3HP85rYrTQVi1VNO1w19kloHQ1CaIDuKsEo5mvUjHZ5kaENE3CG71P4t4NZFM5ErvZfPk/R6bFdg2Fvg1nBz49ChTB8rYVfnN3RczW8w+gA+qtzH2n2dxxZ2cqiIIOle8PhjlAeS9AM2IgUsNT2mfLbQy+QGbep6HIfdjG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(19092799006)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NJUG4srbzmCmMFj+AoBE74UMLKT+iQlheiLageMZCMnaFTcENi7jOc4gbfwv?=
 =?us-ascii?Q?TSQ9D3UJi+ZQh9/CYLNvcm5Cc+t2Ln33v+5YIJ2ECW4und4p3yFzn4GjakI1?=
 =?us-ascii?Q?5Ux92a9IsPYptpl9Mhe/Fp/bp4rv9Mqi5eCjYWY63Jv1NLN68xd9VIpIlaPm?=
 =?us-ascii?Q?EeHX8N/ztGGgFX0rhUrnXXnwJf/p6lbP90cQ68XQWofgLjyV7YD5sgD/azrH?=
 =?us-ascii?Q?nTGEFJaLCYUcR86lq82tJ791ZHbf5WZbay9rdzcN7cGjoWw4n74eVC0JnDod?=
 =?us-ascii?Q?RdbQajsQL5rLouBeuAgCpqlaKlMmVs1hIffNlIZgfT4yq0uEjMCKbgVbZE9z?=
 =?us-ascii?Q?6dXfQuSjml9YZ+Gq2spotxEUQE4pkY5lKXikTBnwr5O3Rwux/ZQEQrZUSS9v?=
 =?us-ascii?Q?08R2RYck2f4M0vsJPW8y0ILDqjfVGifYHh6mtppS/HuhIfxE9L9yVR0iV9Mp?=
 =?us-ascii?Q?NAD8i2VB5J/qRQSFMPbr7t4zrwJuSGMWLSwxsMKosQGyuCsobeE78svoZYRo?=
 =?us-ascii?Q?H7Jn59+RrzBAxWnfwx5F4I1mFbCIkBHSXJtRaTbQSYhlvy9PWeHc7s41rndT?=
 =?us-ascii?Q?bA1mnFXXR/MvM7NGY8ODYq4G1nNCu1dtz/BfDkyvcSQDArq8D2pXNSaXIVMK?=
 =?us-ascii?Q?mL4WicYHEsfHsHi6we6DoUSGJsSVEEQ11sZrfVZlnlhqs4WSHi+9WiIS36Ix?=
 =?us-ascii?Q?Oz5ITBf5b8vsO8td4M+bl5zUfmB/3a4ag1AcqlL+UKc51APta1/3aBWmTQK8?=
 =?us-ascii?Q?h2MfXLZZNaKWgFrV6S13a51JFVvHNcThRns2HPLmSRLxh/+Ich00FbB5stNZ?=
 =?us-ascii?Q?hD/xFJrqazfUmbLw9bm3XeJ/9Jlz7IgNxp1TXtDldfDZnxf6JHSvbIvw25ig?=
 =?us-ascii?Q?0uCGttG2lFd8yGCMOerytp9UMfcpx9aRCqMUfq8J0WeqANfytahpUSys2CO+?=
 =?us-ascii?Q?3UwzbXh9DEgdbq5TgBE7OFW0waz3bn3+F0GlXtXG9C/oITy315O9oxj16/2S?=
 =?us-ascii?Q?4cGjmC1jrmp/YzuIEla49ooueiwb1bGRn5jO4SDnjvfpvEPkeO0xWyo6wL3h?=
 =?us-ascii?Q?OKf4/JoE6WKBD8FE0E0K9rO2uhQ5yV5ergOury3uzHjDpCWTNxOe36oCDvJB?=
 =?us-ascii?Q?jw82BDDs3pWVpvIoauWATRAyotK9P/PO4O14Mmn9968UQa3bpawxoJ68BKp/?=
 =?us-ascii?Q?IF3Vn6klkGp3Qb7vvtBjKX2eS/VBgh2RpTRXuFMfrkKzWC7vTXWugn5AwI/S?=
 =?us-ascii?Q?LQvvVmX/97OIYYUrG3dX5BaXVQJkMJoFYpjydIB0M64JdZWyUvzh48KLrwRu?=
 =?us-ascii?Q?kwDy+P1ziMPdeOnW0LGjcArmeQzNZxq6XfFAzres/F5e+ttRZhk2uHDA7ThU?=
 =?us-ascii?Q?3MG3xPJHZQKr35UbyGiLRseBaW5o/jMVbP2A0/sAzG4JppTJzs3eR4lYpKhm?=
 =?us-ascii?Q?BSA93j9PR70C04fu4pwLGJFcE4/hEL5vp/5I2wUosuBD9pmu3fw9tkBuuaul?=
 =?us-ascii?Q?JhIBi5KGsqGe/1OPUWunR70LIjxzXU4Tm7Jo5W5T+9g2PMV2YpKzVjf9AMWn?=
 =?us-ascii?Q?UjMtsdmCdGITABFSWy9TX1pB+e+NLMaDTEsp2zQAso+Xh3IJRAJQlMrMUS9t?=
 =?us-ascii?Q?a66pIiO2VcOOQkqOt9DRl5CzxkSc2K/XjkR0A2Uc9pTHiZ/rBDASc32cN31d?=
 =?us-ascii?Q?eLwG6TvVgTUwBcAQHtVVvO+PdmBf1nqTKvUhOEOEnYZjxQ78oQ9awmFilNE2?=
 =?us-ascii?Q?xzqCmwJvUBtH9iG9euL42wQHY73A3SbC1MkvWyLE+7aaqS8iLmb/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76b4fae-f05a-470a-c0fc-08df047dc842
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:57:18.8728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBSlz8+f4sYCIjZMgi1EKtaOZedqsTyYeolIOletbljOrjedGMqIRqKBmmv0MtCU1fy+t/yGr0qR2osDFrqqLemH+1jgKSO4DgIhn0Y7xENy/WcAnnrBFQbpAX6u+VQi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11569
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

On Thu, Aug 27, 2026 at 03:33:04PM -0500, Rob Herring (Arm) wrote:
> It is possible for userspace to set the job SRAM size to 0, but then still
> have SRAM accesses in the command stream. When the job SRAM size is 0,
> setting the region base register is skipped and a stale base address from
> a prior job is used.
>
> Check the region size against the job's SRAM size instead of just the size
> of the SRAM. The job's SRAM size was already checked against the total SRAM
> size.
>
> Fixes: 9cff90774872 ("accel: ethosu: Validate SRAM size on submit")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/accel/ethosu/ethosu_job.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
> index c33f2877b385..0982722a9195 100644
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c
> @@ -441,13 +441,13 @@ static int ethosu_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
>  			if (!cmd_info->region_size[i])
>  				continue;
>  			if (i == ETHOSU_SRAM_REGION) {
> -				if (cmd_info->region_size[i] <= edev->npu_info.sram_size)
> +				if (cmd_info->region_size[i] <= ejob->sram_size)
>  					continue;
>
>  				dev_err(dev->dev,
> -					"cmd stream region %d size greater than SRAM size (%llu > %u)\n",
> +					"cmd stream region %d size greater than job SRAM size (%llu > %u)\n",
>  					i, cmd_info->region_size[i],
> -					edev->npu_info.sram_size);
> +					ejob->sram_size);
>  				ret = -EINVAL;
>  				goto out_cleanup_job;
>  			}
>
> --
> 2.53.0
>
