Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41323C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6258310E0C2;
	Thu, 27 Aug 2026 20:55:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XXtZCXq/";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E54C510E0C2
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:55:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvJfcRZDJ3Nu2ltCIcUndinYXh6prYkiy6Xm8nWuvOUXU8YhAbNH+OWuUN4pDyQy8ElR5r1xP/H92OOMpM4m28y8l6oZwECJ2juN49TJaGfKcwqidqqsh4HSLRy5rqgVkYayV+KzG26fRuxU4Xn2GiWhE/i/En0mB/ATRH6CLnrof7kRYvxebHso8dyG959XIflgV3GyJHn5OQi1v5W46o8wjCsiqjghs24K5ExGotXMuVIvRUDGvhcvhXPOF8wlTyv1iEgfO52FXe4NLNDA+7SgXCZSm5hnx2Sk7yO6ievdd0kqnv2NPqwxhDcbccdrAyY0kR94tRsj8g3njzaj0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfb1g/B9d+5fvgQxZpttjcmE8zRiwL1waWPfEKOg6EY=;
 b=eD3atW1r4Zr2DGh2ynTcv9fnWtW0cY+P8hYBQsVN9Y5WMbcXiZbRy1Yaw+BlqyRl9GagvD4v+wKYUgVZ8WN34dJ2nyCAwvdqYJfhnSOYyLem/gzTYkyLDypZ0UT9YDnrtp+Fgvb2Cui1pxKYlCo7YcyIRHYM/cBNEK9lObernz+ycj+x+VeBT7MkjbJOXHiV9gKVdhS14bOTURcrxrhzYbeIqMnOewVPEE9gPlkwW5wyum+fy+4uT44KKZ25kghkMzFTXM1Q7UOxWSbQRrNNhbERWZi2tfI5Yk2dzJmWCf7k59QgEgMUJevBhbJvhQvWyHQp3+4noxhspcpoTW53AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfb1g/B9d+5fvgQxZpttjcmE8zRiwL1waWPfEKOg6EY=;
 b=XXtZCXq/2qRx0c3B9q3h2/A4YMnZxV0Kt/Rbsrhg5Ucs3InSaHRJk7X6V3bXLJ1YF7bHoKJ+EGakkHyiLLpwYHmpRNcDZK1IfiHEf4LqUkk8vMfIcBpHaPPUUHuSfXJqIgo5Ehq0DOxIcsqKYCRG1oj0bZ6b7Vb30TUyt1fvnry7iP/OZJ3QquxfEnTNBoVkkV6KoBQXCcvqxaZtGeP7DAo2/wGwe8AEXLon4f+vSRX5l6EuRR6elZqIHeY3bi/1Io3LP6O1taHKdEM4ckd7AvO+QZ8OPln+yNay8EgCgIPTk4gdx1YREv7Wn7BZ0vXpvLfoolPCJWswglYaDmp5Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAWPR04MB11569.eurprd04.prod.outlook.com (2603:10a6:102:50a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 20:55:33 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 20:55:33 +0000
Date: Thu, 27 Aug 2026 16:55:26 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] accel: ethosu: Ensure SRAM size is 0 on mapping
 failure
Message-ID: <apCkPrt8qZvWRsvl@lizhi-Precision-Tower-5810>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
 <20260827-ethosu-fixes-v1-4-346f9ea8791c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827-ethosu-fixes-v1-4-346f9ea8791c@kernel.org>
X-ClientProxiedBy: SN7P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::32) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAWPR04MB11569:EE_
X-MS-Office365-Filtering-Correlation-Id: 1633a0f6-267d-4bf4-d7c3-08df047d8959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|19092799006|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HecMJRKNrPa1E2Y4Vwy3Wpi1cqcl/j2DrWN/GQVfhk1DNBZ3xM55UmP7sMU56DpVq/brOLsEqOmv+A8YrAOTAQZPOXkDa7QAPcNkomb/0vs69KDDcjP2A1io8nhqf3x95I/vsRZMgx/a96wUkR/5bSyCZkB93/MWsmETSPXe6ykRGpCDFHCCLafBMDROoxtvArtZoE9gzMNrXoRq4u79zxFehZOjZ9CxVcf/wt1YPYf4UyzAvvBvWAZEN8HABTsqYyHrv/cn3i6GdTo7gmxRzPP0Ax1hvoQKO1qBcZ7Cf0q1yLjqpwH8NlCj/UVTMOGxIWeO8in3VFjJu8g/pIKarPfFzMBAkzfjsnRRLLKvav2+IoMR60Wp+QXg6rNCmwMN+n+Wgy1g1Csbe1umQ0aLZXHay3K2ykATdb8TXF57G4xhg3YKZ67aOfkMhVcRrSSMWfIAbvNL2gk8RpnFiWzod0dEWSW0PIfXlEkmO87e7qL2dD8SzTOcwek4Af1DYVlDUR/idaaT1OxbOE4l2nzszaZGPVa0ZiEqQiQu4/XsabfAeJlO84Mp6h3L/LsFPr8sT1K6Eo1zq31SmU2lDSsXUAMdgeasIL+g/t/+6r4sS/NnV3hvSkBQy13kNE69TMBAq8E1KQK8uswtM5fH4/ALvGRdj8v9zX3X+JFvhp3pPOU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(19092799006)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nIQHj+D0b2O6jg4ZiwtJ4niaavudQuoCjm9RcCvk+aDXp5PS20kdpR+Eaglk?=
 =?us-ascii?Q?+BSoRkz3mT01fSoq7e3KZuUIx1nXLkQDeHclCnxiPjNN8YukoHdbkcOjn0Pa?=
 =?us-ascii?Q?RCXh+yj9zNFD7oyds1zxB/KBniogy44yiDSrjysPFNpemhVa2LtkRmsqsxJp?=
 =?us-ascii?Q?qveDmDELDt1s4bInkdzrsw8x3Nft0XIs2KAz/9pSbJhQ3dnuXJl62ZuJafzg?=
 =?us-ascii?Q?kPN3YmSgnYVwLazVZ3yqu0ip8Y8tVt/FqQ4UbRbYCAmpOt+nZ03hjGfMKVJ8?=
 =?us-ascii?Q?tWPCikot84LVX6BqIgpSV/72BUu4811yBhabTX2pDwoc2eNjWQoIoVQCttRG?=
 =?us-ascii?Q?JQmcbK82eWIosfiLZBetHpUZnVRCKn2V3PsFght++U8u5Fj1wAnfvw2i3RPG?=
 =?us-ascii?Q?VPkXG34Zdb1HfTSWhih0gr6KbJ1yU56mCHKrflzNY/QJ7RMJsfzwmiGosxG3?=
 =?us-ascii?Q?nhZ0Dyo8C/hgBtZeNYg27iOJ3n8PNOBwe1bwofrD2M6R14ohKely0KFxx8sd?=
 =?us-ascii?Q?p5UfZw3eLw6UQ0eqHb6imOolfilRSpGg34EdwEHwCNHET8myiPx6nIjbC6vs?=
 =?us-ascii?Q?6OwqLO9NIgc+eWJ8uVwmqAFixSBH64Rzyrgi2uR4qvr23RiPRclLEjc4IgCt?=
 =?us-ascii?Q?kxaXq0zEde7b8QlSIf11mCnt3hM9bMA32fz1m0xlph3x8WNg96YNvupWjWoQ?=
 =?us-ascii?Q?NhZAOk1FBP724VVyYah7OtdPg1eAMf0BDzKL6A2Q1ZWDp3uT3xOvEjUx3o/t?=
 =?us-ascii?Q?KnmdV6W5INHi5p1aGgz3aA++g0J2Vz0zqfmcHB8qxy3i34cW3EeV4eSLCoo4?=
 =?us-ascii?Q?yRtC7aKMLy7lGtwHmvkdNeKGAzQsSd8eQkZ16pMAb2Q2qN0sT8LTQTEyudFX?=
 =?us-ascii?Q?b/y20PAO/HLEkKXdovlFyDcsYCGszxA/nR7ywL2DQOraPxM/v61B6GlnxVDy?=
 =?us-ascii?Q?Z+E5LaRVaxQxbWMEJLHSLJ8BVMpqDOCPMQbqwxq0MUMpONlzM13t2+bNEmfM?=
 =?us-ascii?Q?gKNGHvWXl9LGnqF+NEvA7vid7IBX9pv/dKkDB3isottVOwuUcpC/JfHjeP/3?=
 =?us-ascii?Q?gFR1fq3rI6dkb6UPtlhCCCY6KitNjGpLrK1kUoIagV5V0mA+ZbwzDc7k0O/I?=
 =?us-ascii?Q?EUWpEcYwqo9FbzreEFkjPid+Ur2cfoGKXJawD7e3IAmwuGfbBp8Upyv8O0WK?=
 =?us-ascii?Q?XHGpeyk7kt08z3s1NKTz7Nhs48OltgeDYpK7BZXGTd9HQaJvt+fKZ4t0RT/8?=
 =?us-ascii?Q?yCKA3GNvhrdQ1lKm9+o2DHTwg2D+9BDfXPlLVmgd/KgSrO5yVMuKZroqA6C/?=
 =?us-ascii?Q?Kaq1TkN/YmqZQ6QjW0K6YeMm4n/G8dFbVn3vA1s2NfaFGXr87eS60imyL7qa?=
 =?us-ascii?Q?8aUF0dcbj2lwq5Fj//T+66PERhKuGrgjz6eDH4dsg6So/a2oL7p20Pd3Pxgj?=
 =?us-ascii?Q?q6TZIX+hGF7IITmfZqxmxfjHplu0HgvsVMvOL+w8X5hTiZDoKwt4c5+qnOWb?=
 =?us-ascii?Q?IMsyZIPkXz1SMj4+v4/DlgC7WgqPDEwrypi1ZSWqG17T+Yp4Qhio/DH1ReTh?=
 =?us-ascii?Q?HpYrsT01PlbuMi9Kl/mVTSTrX0CGEas6hAathFjbuE3cfYL8J+WlVyJAe9CJ?=
 =?us-ascii?Q?w94lWGY/CctV1MJmRSqU9b3s3aRQ9u/QykzpqmOlL28eS8NukAG3/GX7rUI9?=
 =?us-ascii?Q?VWjVJs25I2IePMxiuE6U9ZG5YjufSvgPWVqLZy6N/QjrHwPceUD+XUunJIZV?=
 =?us-ascii?Q?xwXcpRKtfYQitHnOZYkK1bA0hmsRZwkYRJ5QMLcStmuXxSe3l2nO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1633a0f6-267d-4bf4-d7c3-08df047d8959
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:55:33.3782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gndYtlD1xTExGBBrrHR44N1QM+ftXeKkPTuWXpEf2Fg13DkOf/W5XGfC2FynoMXyK6tA/mpoR50OQzBtOxhhjOO4To8VFJdnNIQ2aoXY1D4uXtg6aOa09yZrD0lz0I9u
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

On Thu, Aug 27, 2026 at 03:33:03PM -0500, Rob Herring (Arm) wrote:
> On a mapping failure of the SRAM, the SRAM size is left as non-zero. The
> probe will succeed as the error return is not checked since having SRAM is
> not a hard requirement. The non-zero size allows jobs to access SRAM which
> is left pointing to physical base address 0x0.
>
> Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/accel/ethosu/ethosu_drv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
> index d121fb0d7732..f1af7b3ea038 100644
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c
> @@ -281,8 +281,6 @@ static int ethosu_device_suspend(struct device *dev)
>
>  static int ethosu_sram_init(struct ethosu_device *ethosudev)
>  {
> -	ethosudev->npu_info.sram_size = 0;
> -
>  	ethosudev->srampool = of_gen_pool_get(ethosudev->base.dev->of_node, "sram", 0);
>  	if (!ethosudev->srampool)
>  		return 0;
> @@ -293,6 +291,7 @@ static int ethosu_sram_init(struct ethosu_device *ethosudev)
>  							     ethosudev->npu_info.sram_size,
>  							     &ethosudev->sramphys);
>  	if (!ethosudev->sram) {
> +		ethosudev->npu_info.sram_size = 0;
>  		dev_err(ethosudev->base.dev, "failed to allocate from SRAM pool\n");
>  		return -ENOMEM;
>  	}
>
> --
> 2.53.0
>
