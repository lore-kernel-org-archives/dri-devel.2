Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7FAF43841
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AFD110E831;
	Thu, 16 Apr 2026 07:42:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vC8wlrH9";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013011.outbound.protection.outlook.com [52.101.72.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2FAF10E831
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:42:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1+/m6tu3pUk/MYGEfaHI8n04xbScCnCZw3B1cN5dydOtin/NtiG8sRTi2DmZTWmL4QCyz7ukWYqoOZvWTdNLBGIspnC0XcAcHRrmypIN8UcGvwkPrlVKhXIls4zQPq4ANhGXDOACRIkU31//id/z8jG+ts0kiDR/5SF3UnlgMT5AFSF0LiEK9cVFJY0I73ShVswFfC6x4dH9ZLbQYuoadoRiFdlAWszYJ71RimFwjKvuFpfWqOw7JMjMPQjiGbqCA9aVi8aiJM3Wcl7U4maWVGuEI7IeoMy0s52XebgaCM/6h/v8MzUAvHlN53QozCB18MKFvQXzzzVuoMVxVVp6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWI+1lJZyfvuIEh2mneHJRuQMMCpRKU1IgrLj8qOMDI=;
 b=u+gTcoWRKWk2Di61yVWdBlK/KkLJrqChuz2+vpphrBeLtsnH//sXuSjxiyXlKUx8rmp66ABQ1GLwCDQQc8HFi7/e4biGmw9kIz33pNgtiLMmN4oBmyB6PH8v2gtNgOs6ti8dVHsC8FCR5iC8CUXr8gMv6a21zLp1stYLjQhkAUj/qC82p1u4DguZ4jxGcaiCQJeQS21UCXeNvZougURx3x3z27HQ0B/tEkvsP2Dbhe4Di72cWhrSUbBAjSZM0WN2TFCDWm1iNJfxKDRRhFZfMYfyL7VnQCSjMmQPUVUr3nFfnyGES5FqhimQpd4BppEwrGgIJwn3fphgPRG6fVchnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWI+1lJZyfvuIEh2mneHJRuQMMCpRKU1IgrLj8qOMDI=;
 b=vC8wlrH9cMOsPFtUhFM50MPYHx93prvz1VBtUZAuHrjinb9Bmp1Sk0VoxdaBZ68y29BweHfJJj8UFGTG3blnISnHoSvkKpnJIhz/sLvfzirinN9IQn303+nIAxXcHUis/ecqgiAlmCBwOrByD87e1brF6J9qQS9CDXIUyJzOl5xTh1O3KCk2gw5spZItKwDhbZO0RHRj6tHyM1AOR798Axian5RRi5vCsc/XQDzMZgb4gQ2sykWumWgwf35VMGATL9H7JRLvk7vgXbefEtphT2LhtwvOX0zfHk1YysamdzTHR7iq63oRsRrE5kZgehRMM+Y0QV83T/KKI23rmDDBrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by PAXPR04MB8457.eurprd04.prod.outlook.com (2603:10a6:102:1d8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 07:42:23 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 07:42:22 +0000
Date: Thu, 16 Apr 2026 10:42:18 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, 
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: fsl-ldb: support downstream bridges in
 addition to panels
Message-ID: <wkh4dc5cih32o6dv4xsqjgxgxfahdxmnj7uuaqmpklkajrtwvv@cxiovgnrr7rs>
References: <20260408072802.3947600-1-xiaolei.wang@windriver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408072802.3947600-1-xiaolei.wang@windriver.com>
X-ClientProxiedBy: FR4P281CA0321.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::13) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|PAXPR04MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: 819a6c83-2c83-48a9-d9bf-08de9b8bb216
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 7qBDmrm0bSVjTqJZ9xQI/Q/fdrXhevId0lG/QmS1HQ6LcaYPXp2MIL/TDRAEBsWnxwjfCRfCJ7VxZhXvXD3b9BFxIuMs2IkyNH1JtU25XWdK9urOyXqpocNjK+4MyZXK+IRkrvUTFmbswx4FlAlbx4MiwriZQsNUkkM7HHNSv2SD187tdkJiHCwK/KJWqvAUwe+cKhJprmRY1Q9tD61wiJYHQO7upzHs6aW8pAbAvm/PidO58IK1cMU4GK+0+QHrCmZLmzyYUNlNkZTL7cwSbSUG9YcTTzYxNMHaZTVVmyDhWHonn9mpei5PSQfatd3t7Z7PSUoOc1D09u8JE4XG+WQW1/jv2UIyfR6zugD+RKV1qEDPLp6Jw/TDEX06N8/Jf/krDlNfBVDy8GGH/vQvnkLtmyA9OG+tmrM5aj4CJgWRF/kdmABmHjv4JhHjF85ARFL2F6iUpt9krCsT8WMvvxkDDL9X5H0Bbp+5nAep4vYVyKOnyT1n9j0QK/3+kHAwiHKDIAf+KHVIEr+Hxcc+3SmhY6vpZTaIbtG06d16qZbHmrA1Ye2u9sUaCMJfQBCRtnFqLQTS/XX2Qzs/8dfj8tAiK55NDXJdM0ufWQpaC+hnjWuYz2bYqDiElGDyVlQ9r5x5Z1rUzl3ZbWtcdjE02CVDwOEb1YCIxjqx9eJjvfCXtdoSV0ocjCPkadw+c3HS80xbW5i4swCv166vNU+h4pefnp4i0BfhzQPBfOiOGwo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ie2X/nGdnB0vCsR3bifMG0baJjSdu229dJJYufzVXwIMuT5QrtNV+dKvXyhM?=
 =?us-ascii?Q?+wRleKrYHme117GWoDeXASqlNH2ThTh+4uYMuqVd8AxTnRmq4raVdHjZowep?=
 =?us-ascii?Q?WOlpLKI4sAdiU+rItP6eFBF8HrwmCDqZtZofr9QrnQLkgQGHE/iwtCeP7bhM?=
 =?us-ascii?Q?s3Vw3kybLnJwHwOeQAICpzQbJ+vBjcmtrCeasNttu68zTFH2Id1d8u9+Rfml?=
 =?us-ascii?Q?RmDhJgNg4pgVLzDhuPO4iLeNexh42l+iHyBeo7s8g/4kyOH6ULr8ozDjHZbf?=
 =?us-ascii?Q?uvbmvdB5yC/05tzL4I+9GrbnV4ucpFwJ4UrQvV6/HLGo33wqQJsHrHOulzSJ?=
 =?us-ascii?Q?lqB35iB/NNWp+pIbOQmNERjZjuK2IMbNahnIb3h8t1p72O7PQSa8/FrjtLeG?=
 =?us-ascii?Q?/+2O9DCn5C4e+qjsLLQ5EQCDfcl0Jc+IEtuVHiK8AdOcrtPRvnBJC2aDzrD+?=
 =?us-ascii?Q?5okw0pcAUyWNzwlkoiNVNBAgA+fdqyscB7gPxBFTGwFfnae3HEKPE3nW6zQZ?=
 =?us-ascii?Q?fQG0wXJNd+jrUhCVXteva6PnOVq43BkezhEK0lHUyM3qS3WA9mvnI+Kz1EuR?=
 =?us-ascii?Q?p0Q8+ABnb+uTB74OgQPJA3dqtil+BEZi5r5ui6GzPLQtRFXYE1FLT6ICy2vh?=
 =?us-ascii?Q?C1vZsPbNeFQaKOtfnQhYeiabAGc7AAvndYS1fF+nO1TaqOiGGpzT/jS4Seld?=
 =?us-ascii?Q?iYVX9FPmLkZfUtlKKR4aSVxqgLQQ/rWigQv+qdQaGZ1M3gZTeZHWrv5OFBcD?=
 =?us-ascii?Q?eCI65tEz1bC96nLYNtT12am9rUXbe6bZT3h2+ZPlAFmS5TucgRw5S0dFuoRv?=
 =?us-ascii?Q?ZGLESrC1hVYtHp43+FJRedM76tl+B8gY4R3h7+H42eNqWM7+yOs1tIHkSD+M?=
 =?us-ascii?Q?sTHBvDW1mwgSJPT91cVn0KCG6000i5xe5StkN77t0RVuDWdpMQ+DzcktcYnX?=
 =?us-ascii?Q?BZyNn2SG2ASF9xxO4Jd69cl0lwx39ze/09IIi5yAe6oz0pDfGpT2tYnbpHQ5?=
 =?us-ascii?Q?4XY8hJlg5y2Fe5L/gSONaWj85LwhteoFcyKap0BErF3C7nm/tp116RPPWrIC?=
 =?us-ascii?Q?+M7UJMDrcbl36Orzx9ukv/wMYRcTAROHZF2RtOK2EqofBebljRJylgPNgw0S?=
 =?us-ascii?Q?VSM2QqOKP2AkI5ozj1Cjmau0gforYW+kas9COLiQAHlTQgLnU15W4LhNmfIX?=
 =?us-ascii?Q?+wlG2UZYfEgJz4T2rKP2aM/zroStf/opFYjFqi9JU1F6on3nlSBA8fnXW6Dv?=
 =?us-ascii?Q?nxRtfZ5e6K2SuSb6ISFUQk3nd5END6gKTxbdYYzhj2UDLiThx0en0OVMQ1jf?=
 =?us-ascii?Q?JvGT0DDIayId3EphP3cyhed1gntyZu7Dt0YzNjPz4TTaJxM/V/LCCISBgivW?=
 =?us-ascii?Q?7owxgjfhcrIEWo1yo03oXah2CEHVVM0kZ+gj6DNQRflIo/KTE7uwaZb0FJO1?=
 =?us-ascii?Q?nWLTCi4cfVaK/4SAzu3Nwts6KvI2faSf3KrNeBRqSVPDw+hSxc9DkGKpQT9a?=
 =?us-ascii?Q?RdrJoj4nzAS/l/CDAeIDMBpLcfUmTdhOJo4xgUBuRsZQGfsZc8Df+G0FvW2x?=
 =?us-ascii?Q?OdqYu8PWxK1LUivQ0lWu/OIKv/nAKXwq3gQ4Ep4469ExQ71k71apd2F9v5OZ?=
 =?us-ascii?Q?tBAqamvTHkevhlQjFEc/4c3L5Od9v4aNNcXKffgHYH8h7vEiPXVs0E4pMrAv?=
 =?us-ascii?Q?ZbmlPtc5i8isEdKiX77AXSiUaL9Qr5T0ijWREBYfFVchfeM2xJTaXUvhQPNi?=
 =?us-ascii?Q?AgfRY52+CqbBBhiANbsjUGRuyjGHgdE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819a6c83-2c83-48a9-d9bf-08de9b8bb216
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 07:42:22.6908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Vyi1nKhoIuniGRUyjB/U2pmNTPeyzaD9dHgEXkln93FXeeJdoTPM5aUSWug/nBu2vheRrJbqD4yVJbsw5hl8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8457
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

Hi Xiaolei,

On Wed, Apr 08, 2026 at 03:28:02PM +0800, Xiaolei Wang wrote:
> The fsl-ldb driver currently only supports connecting to a drm_panel
> via of_drm_find_panel(). This prevents it from working with downstream
> bridge chips such as the ITE IT6263 LVDS-to-HDMI converter.
> 
> Replace of_drm_find_panel() + devm_drm_panel_bridge_add() with
> devm_drm_of_get_bridge(), which handles both panels and bridges.
> 
> This fixes the LVDS-to-HDMI display output path on i.MX8MP EVK.

There's already a patch sent out for this:
https://lore.kernel.org/all/20260304-dcif-upstreaming-v8-2-bec5c047edd4@oss.nxp.com/

> 
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>  drivers/gpu/drm/bridge/fsl-ldb.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
> index 5c3cf37200bc..2936c945ba52 100644
> --- a/drivers/gpu/drm/bridge/fsl-ldb.c
> +++ b/drivers/gpu/drm/bridge/fsl-ldb.c
> @@ -292,9 +292,7 @@ static const struct drm_bridge_funcs funcs = {
>  static int fsl_ldb_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device_node *panel_node;
>  	struct device_node *remote1, *remote2;
> -	struct drm_panel *panel;
>  	struct fsl_ldb *fsl_ldb;
>  	int dual_link;
>  
> @@ -322,25 +320,18 @@ static int fsl_ldb_probe(struct platform_device *pdev)
>  	remote2 = of_graph_get_remote_node(dev->of_node, 2, 0);
>  	fsl_ldb->ch0_enabled = (remote1 != NULL);
>  	fsl_ldb->ch1_enabled = (remote2 != NULL);
> -	panel_node = of_node_get(remote1 ? remote1 : remote2);
>  	of_node_put(remote1);
>  	of_node_put(remote2);
>  
> -	if (!fsl_ldb->ch0_enabled && !fsl_ldb->ch1_enabled) {
> -		of_node_put(panel_node);
> +	if (!fsl_ldb->ch0_enabled && !fsl_ldb->ch1_enabled)
>  		return dev_err_probe(dev, -ENXIO, "No panel node found");
> -	}
>  
>  	dev_dbg(dev, "Using %s\n",
>  		fsl_ldb_is_dual(fsl_ldb) ? "dual-link mode" :
>  		fsl_ldb->ch0_enabled ? "channel 0" : "channel 1");
>  
> -	panel = of_drm_find_panel(panel_node);
> -	of_node_put(panel_node);
> -	if (IS_ERR(panel))
> -		return PTR_ERR(panel);
> -
> -	fsl_ldb->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
> +	fsl_ldb->panel_bridge = devm_drm_of_get_bridge(dev, dev->of_node,
> +						       fsl_ldb->ch0_enabled ? 1 : 2, 0);
>  	if (IS_ERR(fsl_ldb->panel_bridge))
>  		return PTR_ERR(fsl_ldb->panel_bridge);
>  
> -- 
> 2.43.0
> 

-- 
Thanks,
Laurentiu
