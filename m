Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3916CD98CF
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 305D310E4EF;
	Mon, 15 Jun 2026 15:03:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KEMOPX4O";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013030.outbound.protection.outlook.com
 [40.107.162.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA30210E4EF
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 15:03:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VumPx1zblPMM4o4eDbimFVwDyv0fj1RBmtvpsVA/xm2e+cwgVdLe+PVas2n+UtSZGXjrfZYZOW4N0PKVU5kCaVUjtVB2YiSdGcl2l2Rsi1doQmh0prR5rZbp3rWd+Equ9lC8/LU8F1kL2ILfgs6+vL2KCyhzC06uFTG+dMAizyd1W1AxXXAIj13pscuOlelkN2h3Ye4HN9lS8oWkzPFZZO8PA9N0gheOkxM9rNg7RmeyL7KpvPro13FOgF5W5hCbih367+eb3ivybFO5XWtwq5VWplDx2AprbTqS4nT+4X/zCyVjLbivjfF67CpkDJP5FOkVdrgju2hRaZ4c6rj7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01GJeQ3TVm3SyhAseN+7iFx4vEgjBNUF+MzfqM9H9Og=;
 b=boj45KobT3A7XFhzpnyWGMupa9U/jKk36jGeV7BJA/qc0ysj40u9hHJBnviI/rplpsFItlk9rI+VeZF+K9NNfANdPt0ZXNhNVQ0x4yBUKZuC5ts7jjuYg/+ZDIj/hTiKgn6aa0+019r1Z07NzZyWkYgOm9hfhFeAH6QgJr47rHoWmkBYSp6RAfd8+48UDLl4yjpPq44CMajoNWSpa2oW4EKn75JFd3WqEV1hLbVW026sGauzWiETeQ7gcVXdFoT8F3lfDe+RhmNonLJG9CvgKsBVMGHmmn1naGzNCL8IqPRzYqcpq9SsJDTcp9Ac59d8NB6h0b+vMlkDkUp04mRq+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01GJeQ3TVm3SyhAseN+7iFx4vEgjBNUF+MzfqM9H9Og=;
 b=KEMOPX4ObD6pl9fEdEzqbBbj00mY2HdLIKHKxGE9vEE3dlJmzCZ1BePkb/DELnEvEWJF/VFv4xelAbFUxS42zHdD0liw0ol7z4I8Nu9x7hIjhEXBS5cn26AuwWcCKZ35ox+NfV30U2FioMGN9q6JkRBdvku6lsZu8H1HP5aQ9E3tqk0X8+6XubPVrFcEjaFsUTXtrGFsPHpUuid4d0suSWkJGRoIE1qhdnKre2zMZt6fwnEy4Squsbof3cWmPe4r8KCc1PlRBu7WKLg6Ds9FZGV/zPlWanxWG62m8zwFNXXOVXf3yiWsLX/kOQTBROyY+W1jmsNEXwG5iYo91IMAgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DBBPR04MB7594.eurprd04.prod.outlook.com (2603:10a6:10:203::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:03:11 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:03:11 +0000
Date: Mon, 15 Jun 2026 10:02:58 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Ying Liu <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-clk@vger.kernel.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v9 2/9] drm/bridge: fsl-ldb: Get the next non-panel bridge
Message-ID: <ajAUIsjY83qZnolY@SMW015318>
References: <20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com>
 <20260612-dcif-upstreaming-v9-2-8d0ff89aa3c5@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612-dcif-upstreaming-v9-2-8d0ff89aa3c5@oss.nxp.com>
X-ClientProxiedBy: SA1P222CA0077.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DBBPR04MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: 402aba23-27c2-4049-4ac3-08decaef3742
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|19092799006|1800799024|366016|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pypDiHwFIow2CC5BAXOqk/KHeTmbKvLDy2Jtkb1SoviDxIrRbto7CSngY8jyJ14ikQqK7e4Jd/6LShM2sQweiO690RZbAT012Dl/rTySXikuN9UPw2s6JE8i4ZC866GG2ilFxlwS6v84MEqWLQtMj9yxuV9K7DTEZY2UKcLWge2rRwVwOV+KHEXkIlA8ZrAj9J1dSG7jZndedUol9yVVjtOkU1xDZvZr1EcY7e+SDd2+iggBCDkyxTmHGouaPOSMXqYQhvq3NbO+jy6cYJ0TdcxgUgvUyg6+zkgxljzLibpmPSXYWwDKmD8trmDll/X2b6sCVrNfFJyUWU6yhzr7TeJZy/MBaulIQlZJmrt2XhFl8F9mnzNrqvidFfftEM0nNGsQBqudBQHdpbMn/Xe9bfcTNY9WeN/kSc9e+VGd0MWVuG9EVJ8j8bsXpH9osj8Trwt4cp2lhoQQGBZceiHZwEsTbIs7mXdVo/1+OYcy3pJ+HrPz2JmCK3E+PjwGiaTcYHkm2I4OP9s2CgSzi/JB5e44DOyZX3knE1STESQKfBknJozHlKuYyjYav7mHstP+6bV1bmBYZUunmVJ9NS5KFq2o57DzHZbMb4ZSM6hdhvJCZauw1UGC22HtmDoH9Ryb+0vHdYS2EcSag2OI2SKq1OTcFrZEvofVtQ7svdE8iYxyT5xN3KNn2ve/vDocF6gs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(19092799006)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jDgaE5tUK+M48vLSOGJN/GV8/27zYgWARTNgOutTcw+xdG8+0eNVWah11LpP?=
 =?us-ascii?Q?78qDDsIQaqzpnB01Nj/X+0NU1qbXVPJFFSr2q0RnLSBhZvlcPFgd3yu3o1mX?=
 =?us-ascii?Q?CrIPBWx6fi9kkIJTymkuL1V5xxsW8Hg5PWxlFMZBakn4fXpOE18pGDs4OJeg?=
 =?us-ascii?Q?0xNJtzspFIbos1Wbdi3IfGvmJ6tYEKLtp18oW0VZLKqXqDAsqqq2mIuk7boS?=
 =?us-ascii?Q?ksESQjkMPZ1mMdueekjm/SYFghOn5uVA4hGDttdPj19UCorLChBzaqwpQBle?=
 =?us-ascii?Q?tbT1chf37ZY8r1Vo2ZxWUuatQsdtem0IKAfZquBecOCBgT4vX40nyH58zNlB?=
 =?us-ascii?Q?Vm+hsmxkiMsBymSbGBNJcCJkZHPZ9pK71vaB2YP+qbXPqIdTlWfF6sYauJop?=
 =?us-ascii?Q?e8Evl0jFHwxTDuaE9ATOXPl39pYIuiOsAm+jgpYNGwGSMI9kyMq5Pd9y59JZ?=
 =?us-ascii?Q?bncqUP31mwXYJqkgucTEOClxKoNTu30ggFvGQtaiGZWXZTdZAeSGj4jrAiwm?=
 =?us-ascii?Q?cCgUfJA4RXfgAQxRkukh36kXk0EmkpWlnhWLYkh6haf0ByZQErMnDFbASuFd?=
 =?us-ascii?Q?RNKaX+9cPKcYBgkVVTRMjdABZISiMVERSMXic5kQh5yHrJA8GiLL+lSSf9EU?=
 =?us-ascii?Q?z/gP/kenyQdwha9DwF6eGB+vSYr858SlmrXtiFcKCuam6Lq3pp2lx2QkNyN4?=
 =?us-ascii?Q?EOSP7skqNX5opdxM18o4rePnLjMb80OkMPNy13JvsfNoz62INr4AJ88WB0Tb?=
 =?us-ascii?Q?uaX4DwdUYQq0OA0qT4btMTSQSLr6txS+/1BnYCPYRwDS3huRFTl8l5pKJxL1?=
 =?us-ascii?Q?lU4bej66baUrCY6hRmXAZXmhzNRNgk4WNLAMDf1d4bnXvbzw+kq5eXQlhq/y?=
 =?us-ascii?Q?nkaQUSpvjIYopQke/8HiJtp4m+fqG8zx4NCH5iF0UVTHbd7fwynvc9g5xAiz?=
 =?us-ascii?Q?akTjPg034t2jo60Ekge6vD56bs6gnajrIypIUwMr2t9gnSWL6XNUSVGWVg/k?=
 =?us-ascii?Q?Z+PuT9/hyUpHgiixfnmdG/rsodTfAlz4Sah5DxJZ2k3FKEanEf30qCel6PDX?=
 =?us-ascii?Q?2Z1US4hvRHr8CPrZsTHo8Bwm2s/9TZaykHa97nG6dtD4HVLS1odrIow8VyfC?=
 =?us-ascii?Q?l+/GPtvjlAaGe+JUyt1vQT8V9V4UKeVS8sXjfBJbrw3dKIPu2B2veik2PgsR?=
 =?us-ascii?Q?bMn6Gy0uvV1TBye8Ci9w18TfrtKdg4oLYUBERsVmDYL6LmSUmoTNqvDYR7fJ?=
 =?us-ascii?Q?5HU7MS70U/zg4nSySmvjQvMmGoKBy3+fkOTh1yyY6gcgrmbVhdU/TXjNx8c2?=
 =?us-ascii?Q?t7jhjO3JWLnNhOGXCe0KpzWVV57gZeGfr78dktKp8iX85N2OcPFhnRXqmzPC?=
 =?us-ascii?Q?ksGdpgnkWHvXSWY9YC1rSD1fWXbRiM7aS+82WSGCS/iv+GbhQdM1Aj7J+T9d?=
 =?us-ascii?Q?jKDVxsN9p2Domll5/B/PzOaabto7wMDF7IsVn145t/B3/xp85aZSauziHaYb?=
 =?us-ascii?Q?xIGuCmVqpLDtvJWLUWxnpaPTc6qnIRQqGoVt/t4vVq+JItlxh3U8tJ8O/DVM?=
 =?us-ascii?Q?qNxfMpUxrpmN4/U00Q3RYrMWSQk/dI4Q7xpseVRa5WP/B+K7ZgKNKEdLSKLl?=
 =?us-ascii?Q?I10UYmko6A9kKJTGmaBZsrd7PwqkIqgt1ZvgBgmj19QM8lzS+xnt/0z/gxyR?=
 =?us-ascii?Q?9sNNkTwMspuDRH9wXHUWpzBkiK/NzrL36zXkyo96jl3a9wCCPA/RP7Y4BEjg?=
 =?us-ascii?Q?0B4zWXmkdeOxp9k+X4wcYDPGKzLpTGW7e8lcVZQXTN88riydWQV/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 402aba23-27c2-4049-4ac3-08decaef3742
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:03:10.9658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m69fSsl7jUiGl8po+14H762LBK0Iv0g+4TAEfSSFtOsmkTj0bMmzoJnew2UHEntUhS8KTka3KIvT4qMUdnLx8oDD1QBi68x/KZuRAmhTvN1qdCza6B2AcR2j5CQzVKFl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7594
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

On Fri, Jun 12, 2026 at 02:58:33PM +0300, Laurentiu Palcu wrote:
> From: Liu Ying <victor.liu@nxp.com>
>
> The next bridge in bridge chain could be a panel bridge or a non-panel
> bridge.  Use devm_drm_of_get_bridge() to replace the combination
> function calls of of_drm_find_panel() and devm_drm_panel_bridge_add()
> to get either a panel bridge or a non-panel bridge, instead of getting
> a panel bridge only.
>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/gpu/drm/bridge/fsl-ldb.c | 31 ++++++++++++-------------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
> index 9bfaa3f933709..bd03c36ee696c 100644
> --- a/drivers/gpu/drm/bridge/fsl-ldb.c
> +++ b/drivers/gpu/drm/bridge/fsl-ldb.c
> @@ -15,7 +15,6 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_of.h>
> -#include <drm/drm_panel.h>
>
>  #define LDB_CTRL_CH0_ENABLE                    BIT(0)
>  #define LDB_CTRL_CH0_DI_SELECT                 BIT(1)
> @@ -86,7 +85,6 @@ static const struct fsl_ldb_devdata fsl_ldb_devdata[] = {
>  struct fsl_ldb {
>         struct device *dev;
>         struct drm_bridge bridge;
> -       struct drm_bridge *panel_bridge;
>         struct clk *clk;
>         struct regmap *regmap;
>         const struct fsl_ldb_devdata *devdata;
> @@ -119,7 +117,7 @@ static int fsl_ldb_attach(struct drm_bridge *bridge,
>  {
>         struct fsl_ldb *fsl_ldb = to_fsl_ldb(bridge);
>
> -       return drm_bridge_attach(encoder, fsl_ldb->panel_bridge,
> +       return drm_bridge_attach(encoder, fsl_ldb->bridge.next_bridge,
>                                  bridge, flags);
>  }
>
> @@ -296,9 +294,8 @@ static const struct drm_bridge_funcs funcs = {
>  static int fsl_ldb_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> -       struct device_node *panel_node;
>         struct device_node *remote1, *remote2;
> -       struct drm_panel *panel;
> +       struct drm_bridge *next_bridge;
>         struct fsl_ldb *fsl_ldb;
>         int dual_link;
>
> @@ -321,36 +318,32 @@ static int fsl_ldb_probe(struct platform_device *pdev)
>         if (IS_ERR(fsl_ldb->regmap))
>                 return PTR_ERR(fsl_ldb->regmap);
>
> -       /* Locate the remote ports and the panel node */
> +       /* Locate the remote ports. */
>         remote1 = of_graph_get_remote_node(dev->of_node, 1, 0);
>         remote2 = of_graph_get_remote_node(dev->of_node, 2, 0);
>         fsl_ldb->ch0_enabled = (remote1 != NULL);
>         fsl_ldb->ch1_enabled = (remote2 != NULL);
> -       panel_node = of_node_get(remote1 ? remote1 : remote2);
>         of_node_put(remote1);
>         of_node_put(remote2);
>
> -       if (!fsl_ldb->ch0_enabled && !fsl_ldb->ch1_enabled) {
> -               of_node_put(panel_node);
> -               return dev_err_probe(dev, -ENXIO, "No panel node found");
> -       }
> +       if (!fsl_ldb->ch0_enabled && !fsl_ldb->ch1_enabled)
> +               return dev_err_probe(dev, -ENXIO, "No next bridge node found");
>
>         dev_dbg(dev, "Using %s\n",
>                 fsl_ldb_is_dual(fsl_ldb) ? "dual-link mode" :
>                 fsl_ldb->ch0_enabled ? "channel 0" : "channel 1");
>
> -       panel = of_drm_find_panel(panel_node);
> -       of_node_put(panel_node);
> -       if (IS_ERR(panel))
> -               return PTR_ERR(panel);
> -
>         if (of_property_present(dev->of_node, "nxp,enable-termination-resistor"))
>                 fsl_ldb->use_termination_resistor = true;
>
> -       fsl_ldb->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
> -       if (IS_ERR(fsl_ldb->panel_bridge))
> -               return PTR_ERR(fsl_ldb->panel_bridge);
> +       next_bridge = devm_drm_of_get_bridge(dev, dev->of_node,
> +                                            fsl_ldb->ch0_enabled ? 1 : 2,
> +                                            0);
> +       if (IS_ERR(next_bridge))
> +               return dev_err_probe(dev, PTR_ERR(next_bridge),
> +                                    "failed to get next bridge\n");
>
> +       fsl_ldb->bridge.next_bridge = drm_bridge_get(next_bridge);
>
>         if (fsl_ldb_is_dual(fsl_ldb)) {
>                 struct device_node *port1, *port2;
>
> --
> 2.51.0
>
