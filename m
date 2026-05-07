Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091DFCD37AA
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 21:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77B4310E2C8;
	Thu,  7 May 2026 21:08:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="aHAtmzxz";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013047.outbound.protection.outlook.com [52.101.72.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D62B10E2C8
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 21:08:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+nEphKY2U5IQY4R1+N0SUsblvPDFF+inXYmxinnFdt8RW+yh9N4fifLYGgVqrIObGNAlbTns6b9YBdnbQLCWgX7G9OtirITYgQb2A1fryeLrIuSkglA2DQndTDUDnqgEEuSYg78Tagl5aMh9H3CtKSw/YDhfbouVSYdZUlJzarpwRczEcO3Fapa8QXfI+nzspwaZuUpLsfuI7qAsavIp+1VGq1ReddUIGJNbVQtXKPRZ1y24wCmcUYMyGY1LyjlbK3D8ZJlK8HRIy0BnmwrfhZ0TjL/REhw4x3QjKt6424RX9vS8LvHonZ8IMK4c7UbQiGMuAV2ZngjSmiFkJUccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Dtcr049p0EJGsAsqkEVu0AC9WSYEbM8jTdJetZMbdg=;
 b=r8tupm95DkYE4G/nGfiQhTeeGpZbNw4gMJmNqvfkjuSAM+6b4CLwiBVvIzq1yS2eJ22C04fAxIVo9BXl0RlQMFpd6ixawS5YqTP+1ISJjMcwGGX4QDOSFJyaEH0sAVwEiVpujrBmDwyRhjckCXzNd/Jeg0YxjTRzgx31y0mJllVlJ+mIxZjAdKTRecL/E+LyOBP7IIUcyBm0GTq0A7Qcgq9cu/PlZyjN8uHKopo6XdEm1zrylzP7WLAg1PsQX41qh0/LAjMvjnP2KlP/Se8irTIJUSNKkAJXkz2gejycbksiY3I4uHlX1HjB0TlUQA5KizMhGlBkvkSON/aFeJgcMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Dtcr049p0EJGsAsqkEVu0AC9WSYEbM8jTdJetZMbdg=;
 b=aHAtmzxz/tXyfpfVFozhFv7nCcgh0vfkGUZ8rKQHXtQU4GjV8H6Z7zFy7Fdvwye+z1BZh6H0dpmD9XgtMzzylK4Ns+F/kd2FLUFy1holwADV97mcElnNLLZjcM1L0ZfoVLskdo2DqJIkk/klJdUfo7IHBj3NQnx860rb8qvz1etTIv6Dx/qk/tZzCy+GEzn/IxXVel3HcuS3JzGhFMH+P69E2hvbe8OOQGjkFJeWRpBOlba3aQWxuDLinmODsuUO+Kc3arVq+IiaPcx3iX8WpxPk9nT6+5V4pnOTVmQcFJbY2myabUQg+3AQhxrndgOcaKrEZppALjxFU7bwhlbeGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU2PR04MB8773.eurprd04.prod.outlook.com (2603:10a6:10:2e0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 21:08:22 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 21:08:22 +0000
Date: Thu, 7 May 2026 17:08:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: imx93-mipi-dsi: Fix mode validation
Message-ID: <afz_PgdCHxFqtx1T@lizhi-Precision-Tower-5810>
References: <20260227-imx93-mipi-dsi-fix-mode-validation-v1-1-a9cd67991280@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-imx93-mipi-dsi-fix-mode-validation-v1-1-a9cd67991280@nxp.com>
X-ClientProxiedBy: SN6PR16CA0066.namprd16.prod.outlook.com
 (2603:10b6:805:ca::43) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU2PR04MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f2cabd0-1349-4863-62cf-08deac7cc511
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|52116014|1800799024|7416014|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: BB/IyHx+anZKq5TZ24nIkn+Ptn5WbF2v15Z6NNM5mc3tClR2Nc8ZoRVw24EqNSdA91CmLj9mPwpKT30fJvF/YYlei7vaCoK0f4KW8ao245evm6r0t3eJmCkD8wYFSCiRxr6cs/fJ4f2z4pd5ctkQt5WjBGLfJYkoaOBh9PNSx6ZZczNcL0G7jxGr2ScK7cZwWHOFcTCy/a5oBadXQGNm+pDFoLrrhZQip5+/MfbkGi4goUgZPfPE+b4E5HBU6W261Lwk8j1vZgv8W/ieZWWAzLMBHJgB2UTIMC3USZWjqVcdXjXnQJb7CQ5yGWWhKuEYNmC1q1limA2acP8t44FsWgTbGIsmxnSNGS8IWDVbD6agHQkml8uQwHuW2xodU2Wi8igKmHeNeqshIgqYYFvd5Hn/gV2u1Nj2XhTPvmiBGLNvohjw90OvsMqK4NB1LKCzOR0j6oarH/W/jVE4WGoe45xcphtSkTaM9wEWeU8ZhPJQL9AwHyQBA4KNiDry5HN1qM67uCpF/SxbbvUhqPjo0nfA0NAVBp0DoAYhk61+9Ii/p4TYG5NpQ6/DHFhLNIj2mBBHfsmRDeF6TjB2TaNjr89ojwVjtPBHbHSggNVg/Ab+30cQM1z520XneT+xN1nRiSxl1QGpuPrygDkPS3w497rA7nG9DDPYYPBBn4n70oq1dJYeMSNLP/29+sE7lnQftH8YDFFq0NrBIR+eFTC1Fl/qg0OyedIkCru0LhsxcNuEUJ30fo/nrXu24Y7Wzi7p
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB9366.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(52116014)(1800799024)(7416014)(38350700014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QqQuXkMA6oEe6rVZ0quGRXiTTuYC7HWB75jukyZjpWH1cb0/9flP+wqQeA3e?=
 =?us-ascii?Q?rDERDAp5xhOiGQD3sqLB8Bh/qQ2qwKMo7kPl/QWc2q4Ddmq1BRb2Vrv03kM/?=
 =?us-ascii?Q?sU1XIHrwxgUXqc/NgU4hHsr67zhz1GDNdRpiHVpW/hKpQQNcf6RZajWTufDd?=
 =?us-ascii?Q?LOnu2B9/uMefGgDe4kLvsbeJs+36oqR3E82DcCGSRrZLiQ0WURrzYozn+izD?=
 =?us-ascii?Q?vDyuRvCCX650cUbcP7PFPyYZVmVVRZLkKw42DpoNfwJMmDFKll+nph0tp8id?=
 =?us-ascii?Q?UmO0apzlYIUp8WHQC4esRxKirSJ2XYCpYxs8sDWiI17bze8n9wxh7GXqMd7R?=
 =?us-ascii?Q?qWPC5TsOXTjdWTatnfdeUV7HTJvsW/EzbjPnlpbo9/feMf8bik9rAlEKz1O3?=
 =?us-ascii?Q?vYXAHX5vYDEfFoFdqO9USvuq0WQXIMS1tGzaGEb1OOveA2fAlYv+gTsEBZ0J?=
 =?us-ascii?Q?7ILrqehZXTWXkQwyFh13WSU1GRQqn1eC1qp/k7BlsEgWMrmRVnIQVn7YABQy?=
 =?us-ascii?Q?5q6yrQ13VXycNrioh/7gGJ/wJ/iYCdYneuIHlvUVRI45PDRSdouMh0zxzesZ?=
 =?us-ascii?Q?3+N6UyDkH1aqRqcGEaZHW0fO1PzWv6o1nKnjZ8XY17sVrsXoVg4CfN42+wic?=
 =?us-ascii?Q?NlxxXSGFD79w1WHxjbM6TCuvIN8IEaSE8U6h5hcijWUYJN977n4LgNv/y+a6?=
 =?us-ascii?Q?w4NwhHWtATJEzfkCRDggVSREmAraQzfQ4Q4S75iQg5aigMIhX4JPaZtXV1W4?=
 =?us-ascii?Q?XqcOZGdYk9lehth969bCoT0oOY65AAfPRtECf41xO4Xdrmtl70xs7YQSsI2O?=
 =?us-ascii?Q?0kR3KgvBR35CNYUhxFuCY9MLNwqPBycaW80A3w9veJ9dGYIK9ClWGBLJwdnP?=
 =?us-ascii?Q?MaTVRLHaqDhUDw28B9MnGeXaAvVjgohjKisrFCtMM3BL6zJiwnIpFa4+9hfD?=
 =?us-ascii?Q?cBQIAKEdSIb+MZqyxeGfZsQwgZiQ28OpqsLfxefQ+GbfIwm41/wrfGuS0ox6?=
 =?us-ascii?Q?JUOGKPQlhfJiNV+gQvP3xjT+1DBcJJXpQIwsDH+1BrcNSHlczYRLCzgxLZ42?=
 =?us-ascii?Q?fcvOp7RnDqahByLdoioUSByVBGUwGXGqwIprTe7Ld5lf7tWW/trGz+gLK6ur?=
 =?us-ascii?Q?cfFRqKEGKI3isIQ0ytwi7Bh2z1QFMk687EifL+HrpYVJI1rCJW54YZPJ24gg?=
 =?us-ascii?Q?m2kC4WHflFPvdBudo61fyvoxuuEl3YAc4dFna0LqGICyUU7sxgPphLHlrq4Z?=
 =?us-ascii?Q?qfsdgpM66vx0Aprvx/M3iSJcg55iTAhiPOqTiUA+OfKZBYw8auzWo2v9Isgd?=
 =?us-ascii?Q?I2/rbaheyMXdqn9nlr+ESNYa1rhoNYKu0OsqCbbp9vWALUlExp9LEBhgrM6s?=
 =?us-ascii?Q?Kg46S8ZoRU9vOq94S0fTWbXcysutEATqrqryMS5q6gGdfw9RW3mA2v55J6Jb?=
 =?us-ascii?Q?DG+GqagdSvC4pPyPeC9oVv+UUdktbojO65cqgGRUCIXIX/ks2zHsPl1cHFYy?=
 =?us-ascii?Q?F4OB5XDkYXsY2dgcAuLeRvqSdYsDoW9N+fWjcdALBBtePYSHmJIJ5cgDf3KI?=
 =?us-ascii?Q?ygLej2Bv2zayew8aszvksWFytfXDXOaKqAGV7vxBEzT4jpfsydyn+yWYJ8fj?=
 =?us-ascii?Q?6bpbGgujiIRt3srVoQnP5GPbwQ2tHMPSrEqYvUyd4X98QpdP/LZ4DxmEJzM2?=
 =?us-ascii?Q?iRrlAS+SGbqDQPxiP1U8WjQkTQRqqCKUP7AC4XMKv/LpjD1O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2cabd0-1349-4863-62cf-08deac7cc511
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 21:08:21.9330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGuTbEIUskFlqgopI24fCXfPCmmKxEhZuRK2gTJIv6XbcMazl1neqSkMVZFaIFvpe5OJvxnkjOyB4L9LI7IR0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8773
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

On Fri, Feb 27, 2026 at 03:36:41PM +0800, Liu Ying wrote:
> Instead of checking the last bridge's operation bit masks against
> DRM_BRIDGE_OP_DETECT and DRM_BRIDGE_OP_EDID to determine if allowing
> +/-0.5% pixel clock rate deviation, check any bridge after this bridge,
> because the last bridge is usually a display connector bridge without
> any operation bit mask when the clock rate deviation is allowed.
>
> Fixes: ce62f8ea7e3f ("drm/bridge: imx: Add i.MX93 MIPI DSI support")
> Fixes: 5849eff7f067 ("drm/bridge: imx93-mipi-dsi: use drm_bridge_chain_get_last_bridge()")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c | 33 ++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c b/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
> index 8f312f9edf97..6d65df9ed970 100644
> --- a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
> @@ -493,21 +493,24 @@ static enum drm_mode_status
>  imx93_dsi_validate_mode(struct imx93_dsi *dsi, const struct drm_display_mode *mode)
>  {
>  	struct drm_bridge *dmd_bridge = dw_mipi_dsi_get_bridge(dsi->dmd);
> -	struct drm_bridge *last_bridge __free(drm_bridge_put) =
> -		drm_bridge_chain_get_last_bridge(dmd_bridge->encoder);
> -
> -	if ((last_bridge->ops & DRM_BRIDGE_OP_DETECT) &&
> -	    (last_bridge->ops & DRM_BRIDGE_OP_EDID)) {
> -		unsigned long pixel_clock_rate = mode->clock * 1000;
> -		unsigned long rounded_rate;
> -
> -		/* Allow +/-0.5% pixel clock rate deviation */
> -		rounded_rate = clk_round_rate(dsi->clk_pixel, pixel_clock_rate);
> -		if (rounded_rate < pixel_clock_rate * 995 / 1000 ||
> -		    rounded_rate > pixel_clock_rate * 1005 / 1000) {
> -			dev_dbg(dsi->dev, "failed to round clock for mode " DRM_MODE_FMT "\n",
> -				DRM_MODE_ARG(mode));
> -			return MODE_NOCLOCK;
> +
> +	drm_for_each_bridge_in_chain_from(dmd_bridge, bridge) {
> +		if ((bridge->ops & DRM_BRIDGE_OP_DETECT) &&
> +		    (bridge->ops & DRM_BRIDGE_OP_EDID)) {
> +			unsigned long pixel_clock_rate = mode->clock * 1000;
> +			unsigned long rounded_rate;
> +
> +			/* Allow +/-0.5% pixel clock rate deviation */
> +			rounded_rate = clk_round_rate(dsi->clk_pixel, pixel_clock_rate);
> +			if (rounded_rate < pixel_clock_rate * 995 / 1000 ||
> +			    rounded_rate > pixel_clock_rate * 1005 / 1000) {
> +				dev_dbg(dsi->dev,
> +					"failed to round clock for mode " DRM_MODE_FMT "\n",
> +					DRM_MODE_ARG(mode));
> +				return MODE_NOCLOCK;
> +			}
> +
> +			break;
>  		}
>  	}
>
>
> ---
> base-commit: 877552aa875839314afad7154b5a561889e87ea9
> change-id: 20260227-imx93-mipi-dsi-fix-mode-validation-425c872a2493
>
> Best regards,
> --
> Liu Ying <victor.liu@nxp.com>
>
