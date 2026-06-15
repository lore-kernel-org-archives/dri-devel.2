Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D67FCD98CF
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3C2810E4D5;
	Mon, 15 Jun 2026 15:00:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sLZ8DtVv";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013007.outbound.protection.outlook.com [52.101.72.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D67F610E4D5
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 15:00:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsE5cm3JWonbTmkHYF/94cdaadhXZdVEqUnWUShn2kKAwbnZKy4/3cyIa4zaCc5BRFZXDgz6w4ZAQhP60bc5e3WElQp0R7XrpTWHW/qw6IsJ03Fsx3gJXccScUALrm7m+A729fL0bgwIZM6wW1ia872gFtwUmvs6QEtMMNQr96C6hSbUUmW99RqH1wALmFxtfSn0i/uYnqIlf6nYIbiuFWRtH1nQaiVBF6BUNX9dE3dOgqOl2fisg7tVytPaXozwb3idbMqlIvg48DHChy198BDJc2/3KMr9Nrg/HDCy9BlG88EDVP7ikjAcNxzMBeb567Dk/PeqK4FCrghdo094Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gL2iX27LaqUHWSIef5mDxSnOLHGNzPR+C4NOOC7wa4c=;
 b=lCV3haAQkwvydPTvSdQSAvyXZbX/JWt3z9GN/1lYndBAsUUEUAP0Q8i6ewSRBqIqpz0gYcXFUFPyIJKL22ycJEv+2SHSnvKscOUE+fcxLYnhclswyEn2OEccL+yzYX9/qvL/uYTvYXAN8hpBTos8Q1o4ntX68cWEeoiMo+RUvq0pZiVOtztdnyQkWLRS7pKtgkBQ8dbspuX1uD4awDHODJW7kY6PmBJppRlejk6HAxJWnzoYYphR8g92r5NibWW0zvopKeT/r5kTuJhLFWegMQdNqEicHKin27sUl+dR6uxuVvTt/4UqV0AakF0jQQYOg5zl2aI16F0wlBlM/ZdeGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gL2iX27LaqUHWSIef5mDxSnOLHGNzPR+C4NOOC7wa4c=;
 b=sLZ8DtVvbE8hxx5ZveFWYJBcZI4Fi0KrMMUoiwZJUY00WhUoOc3WSm87S+hvTJ4S5wAQXR0CkbR2Kuiw6igQxPi5z7RNP1YlemtWi+glXgMZU1t5AXGFJ18qbQTOUS0j8z5FdgOgrfHZyxumE8sJnfla4vOBNyg8dMyIIwGEPHKk1LC39NGZVMIS1J64izR+BjrLbnQyTyOFq+jl/oFjuz8vIYxD2AOhi5ZrMm/xGF/JF6HdYP/8jHtsk63DVQenSg/8wAwW7nPUQ+QuvmKx1G/kBuM+r01y7XbgisSKQFaXRYTBCnw7ei7T7c62PXMUwUdE2wRUS84Tq9kub7n/fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB9679.eurprd04.prod.outlook.com (2603:10a6:102:23d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:00:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:00:23 +0000
Date: Mon, 15 Jun 2026 10:00:11 -0500
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
Subject: Re: [PATCH v9 3/9] drm/bridge: fsl-ldb: Add support for i.MX94
Message-ID: <ajATe5SglMucurx4@SMW015318>
References: <20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com>
 <20260612-dcif-upstreaming-v9-3-8d0ff89aa3c5@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612-dcif-upstreaming-v9-3-8d0ff89aa3c5@oss.nxp.com>
X-ClientProxiedBy: SN7PR04CA0172.namprd04.prod.outlook.com
 (2603:10b6:806:125::27) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB9679:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f2bfac-3944-4dc7-105c-08decaeed325
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|7416014|376014|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: fnUp2WB9pGp7dQV8N3uH0nmFf1rmmRpWGiMvJGHgkarfBq4pKqA90idYNgEj64PIVxXjIz3GdME7NOM1tW120IJsuKt4lMtHmZct8YHF6ve24b3ykeeN1wzphMqPSdbY6yvRnLrDh61AORubnvDMyxoR242tfM0FM4zsTJ51qFLL+EubYiDofboNes3MlIum2kUUo9LKxendASIlb32OsgRn7zBay+Br4nSSaI+sVXiuJk07+7jqy1b6WwCulrMVzR1k9Er2fKAz4SseaCe565F62qgEqW0+rxrQoLFl4db+JoypeHU7Dqg9SgJw1lty9g9imixlDXziBlVhAN++lWfQSJAEB5VoNHwztIupAuXd3FFGA6p0db08fiGavUlUwwVJ+tjv4MkdarmDWmf768ikl3bJlhyqoez0JrRUpO2aIdryI+/IlvV6fL9rIDmMluYUWPIhTUA6xh8m2UzQOljBJEuVj2UIKNlckoLY6DwcxbKUwcRK26xgriV5GvemyoR+PxvGUgo9YjjYsJgMsZ9T6ZKdPBFjUJyQWJaFHThWMHMTuMeAk4sIvSMcjE+kekoNSJnJ+hmn5ULGl9m9z+vQoSRciE/IwMDRygzvnJtCdmjxW84m1bELcEgPFPUvnQeP4E0lrVfB/IFrJSsD3y5z/FzHLQrdD0WCCIKQyFuQ3LdpDCbTL94cyCo+0QSW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4BlIs+ntYpuDNfpAfCkzJaEHuy5GV1aw0Bdi3Qs8jfxcuT1oZgtCuNYq2MG8?=
 =?us-ascii?Q?NWxisMGNXuH48cawzdqaanVMZMrWc/fiVEMbO+p7dITtqLqeukgZr+h6dhDU?=
 =?us-ascii?Q?NHwgFmMKtRfUA+0E7t8PqeXqjKO2VTx3b7e3QrhRwI/bS1DJHUlHrnSdt5oY?=
 =?us-ascii?Q?83KmoDsirJ2GZxiQ3F7IC4nfVnX7oDrBaFNifsr8UU4jCewFQhTxxQ/QWwAs?=
 =?us-ascii?Q?wpJaL09huv9tu0cBz3drYAuZ+d7p7HttuLneltYDi0KTXucnx6g9GXmQKoVT?=
 =?us-ascii?Q?oOaINKKeO73vdsKOUCUGyYTR4TroARBPNaAUHiWZ5Gg0XLeLReb1E6HJ0rXd?=
 =?us-ascii?Q?eFi3iQ9lLnnYlPgKjHfss3biF5/8STnmmfNfHNXZb6vAm1JgG7OsnNNk50jL?=
 =?us-ascii?Q?/zdyo/5s93F7QBdCxqj3tWh7sZ+5/FLOEIJ+hXPu6J3ENGAozNXazdcdzqbT?=
 =?us-ascii?Q?XqcamWlUfgU/3w3aVsKeGx/lECUAbgQKVP19jzhjCIQMF7s1+atmdTfeAKE9?=
 =?us-ascii?Q?r3hyiagQ9eSTRboyeCChcTGQj2m10JYoU+QMR9TgCi0hqeacZPrI3QA7v/m8?=
 =?us-ascii?Q?YPS+pwyMYjZmDlOKANoK64sLzg4ioULnW5F/rHoR5sPz8g+yO8Jv9piRz/+e?=
 =?us-ascii?Q?4jz71/DwUT4e1c3BhYXXeszDDxE0DAbXrljJ6KCS76cSffmdLKawvdXnwlYc?=
 =?us-ascii?Q?dWccaonDk+i7km6KdYUiS9uVprZvDJdBjOjaipSdlp188GcpLvhU4O0l9Oun?=
 =?us-ascii?Q?iAk2Rdf5w6uIXWFLDwNJBgsjH0dnTwG3fBN3YjT0wXgKexkwU/Z1zCP8hl9a?=
 =?us-ascii?Q?q31EZzu62Sk8ijBnKuoJ4U0UR8CvLlm1GqoXTwsUUur4AKKnoc7/tIA4NWog?=
 =?us-ascii?Q?cWRqlkVsEFh7KoKQda5vMMd7/Va713/ssvi7VQTr5DW1fVjJtrYMRCwJbRfX?=
 =?us-ascii?Q?e9R9B+iQQEOa186Kc3hOgaCP0lbJKYB5BIDOikyJ0znl7n9cWNWvuWpMnitE?=
 =?us-ascii?Q?YRp4ylVS0SHyUf1eWwF0WnIj6+Tj9Btlidth8YAtN9da1LKLjMIa66SaoU4y?=
 =?us-ascii?Q?9TeIMkfR9t/wUqL53PPGb8mZEtZvDMDFks7JNvUtvd3Nihv1Fn6YpCsJmfek?=
 =?us-ascii?Q?CqyX6WnmISxvkVYlRBj5NHP3Qt/cCosrWbjfCfF2KNEPxzGo8O3wYF/QIlQc?=
 =?us-ascii?Q?PMg+4Ee2Q1XtaRTk4L+UMTJ8fxIIevYaeqlguGJw+jKgICflfQ2JOrcyKe+b?=
 =?us-ascii?Q?6OmjCSM2y9rsBo+hFD7f6L6D+N+IL7vZ1nO5HmT9DgUaoaIo6/OfRGMrlF68?=
 =?us-ascii?Q?q6mbH7IAjMr1fmtb+DFZI2VpsNqP3xCfH99c94VG62xWHzhqWyzo+tNHcx9f?=
 =?us-ascii?Q?B7lt9j13DD+W6nIBbmPolj8vAAty3v+N0ycQYbGJ+Nuj8LURdSwvRWF/bnDY?=
 =?us-ascii?Q?ur0fCPFa+WK76tm9qhkRx+IGE7OLoKEvpng2O7Y/oIDE4e0SlGvOTeE7rjGX?=
 =?us-ascii?Q?R18hhUoYWFubJY5hAP28yUrxABctKt/NyeJwLd7FT2qYE2xKyjvtzPRMm9s1?=
 =?us-ascii?Q?dAIF8ZtM5lCfw+MeUkJwfXRXEf4heKyqi6h5pHNUWDqB0W4Gm3r2fUZE8Xvk?=
 =?us-ascii?Q?D9D/UMjZyPfmXYKJGIPVO2CgeAsfMacYaR0aWLAJuXcr5O5k7nzoobShzj11?=
 =?us-ascii?Q?PiYH2E//DmniSuo7nQAG4ipnFUIDUYecKU6+j8iMiFHciOZudXW6GQ9UZXGs?=
 =?us-ascii?Q?Wi7VgGvKf/nOwyFux+iEj+gWp2UrgKUZ+brmnDaPVWrMpZjTfxp3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f2bfac-3944-4dc7-105c-08decaeed325
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:00:22.9514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01pq7/D+Ww3Yh1xCI7vn9e82Cett6ipEoS8X/X1qvs6CKhJj/rCLQi2TXGXKnUbQ9mITRff+J+o7p3934lE6Ssv/niiCDTIiYdEU+VyMIazP+0CQG6c7V5tVnK0MCsB2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9679
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

On Fri, Jun 12, 2026 at 02:58:34PM +0300, Laurentiu Palcu wrote:
>
> i.MX94 series LDB controller shares the same LDB and LVDS control
> registers as i.MX8MP and i.MX93 but supports a higher maximum clock
> frequency.
>
> Add a 'max_clk_khz' member to the fsl_ldb_devdata structure in order to
> be able to set different max frequencies for other platforms.
>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/gpu/drm/bridge/fsl-ldb.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
> index bd03c36ee696c..b4959f654f2ac 100644
> --- a/drivers/gpu/drm/bridge/fsl-ldb.c
> +++ b/drivers/gpu/drm/bridge/fsl-ldb.c
> @@ -57,6 +57,7 @@ enum fsl_ldb_devtype {
>         IMX6SX_LDB,
>         IMX8MP_LDB,
>         IMX93_LDB,
> +       IMX94_LDB,
>  };
>
>  struct fsl_ldb_devdata {
> @@ -64,21 +65,31 @@ struct fsl_ldb_devdata {
>         u32 lvds_ctrl;
>         bool lvds_en_bit;
>         bool single_ctrl_reg;
> +       u32 max_clk_khz;
>  };
>
>  static const struct fsl_ldb_devdata fsl_ldb_devdata[] = {
>         [IMX6SX_LDB] = {
>                 .ldb_ctrl = 0x18,
>                 .single_ctrl_reg = true,
> +               .max_clk_khz = 80000,
>         },
>         [IMX8MP_LDB] = {
>                 .ldb_ctrl = 0x5c,
>                 .lvds_ctrl = 0x128,
> +               .max_clk_khz = 80000,
>         },
>         [IMX93_LDB] = {
>                 .ldb_ctrl = 0x20,
>                 .lvds_ctrl = 0x24,
>                 .lvds_en_bit = true,
> +               .max_clk_khz = 80000,
> +       },
> +       [IMX94_LDB] = {
> +               .ldb_ctrl = 0x04,
> +               .lvds_ctrl = 0x08,
> +               .lvds_en_bit = true,
> +               .max_clk_khz = 148500,
>         },
>  };
>
> @@ -274,7 +285,7 @@ fsl_ldb_mode_valid(struct drm_bridge *bridge,
>  {
>         struct fsl_ldb *fsl_ldb = to_fsl_ldb(bridge);
>
> -       if (mode->clock > (fsl_ldb_is_dual(fsl_ldb) ? 160000 : 80000))
> +       if (mode->clock > (fsl_ldb_is_dual(fsl_ldb) ? 2 : 1) * fsl_ldb->devdata->max_clk_khz)
>                 return MODE_CLOCK_HIGH;
>
>         return MODE_OK;
> @@ -386,6 +397,8 @@ static const struct of_device_id fsl_ldb_match[] = {
>           .data = &fsl_ldb_devdata[IMX8MP_LDB], },
>         { .compatible = "fsl,imx93-ldb",
>           .data = &fsl_ldb_devdata[IMX93_LDB], },
> +       { .compatible = "fsl,imx94-ldb",
> +         .data = &fsl_ldb_devdata[IMX94_LDB], },
>         { /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, fsl_ldb_match);
>
> --
> 2.51.0
>
