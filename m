Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A20EC61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE7310E3D4;
	Thu, 27 Aug 2026 08:12:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="cmgMQYty";
	dkim-atps=neutral
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010043.outbound.protection.outlook.com [52.101.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8305E10EEF8
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:12:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlXRFGzK0gsxTEvw+G/0YpbiLQDcmkjPhJvxtZjpBLa2xm+XP/Oy8mcFwc+Sx+HpLQhpQL11xvqCaFy4U/Oq+xSTXQEQ7frHAVbUqcOQXQiytaMlXhoG804lkGoIGgStubs2iO2TzjFoNKEDjIZQKLAcWp/hUBf2Mydbh1aEAt2JyMCmRJlg1CrPLhgQ4QpAzLFG4JnWwfA13fM9eFaAhdSEpyfCuxr7fk0MEWlIQD6SvaoDiHXS4QE0/e4sHrEA6PrhUB4YE8xtQYBh9veff0CBYkCntipQN0Qh8lKr4UGa5T8mdpmSxw8UpcLf75Ddc4lIfa52gz0NIEQSOobKfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+M2pZGbMU/B6uitzLtvnjsOBjB4I4KAko6qph2o77k=;
 b=wr+rdwcPDhWXQULlqkagGivBGdEu4Se/6dDSd4jJQ5KjDCqjbzuAv0nSJvd+/1OlP+eJoh6LNq4E2IgWkZ8UCbrAmm49IPcA6OXC6aPKkMEawE6kaiic7rUR522ug2DJMjb36o4OT4sVLPjmvsPmfX2W5GChYTO+U3uVVM2QUg3y+5T4KbgyuNpbHwwSc+7nUn0uU2eYvrya7Bp60SnMGoNbEC0y902B7AhTvh2L8P17/oYhIlotUGr1nmbY3NAgSZFSJ2sFqm+Ny+r79o8s3INP7JZTh+YugPoNyRKmxr1XNRH0kAiWvIpSU46FnP3yc8yQk1VuWkRoPNbwuaFi+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+M2pZGbMU/B6uitzLtvnjsOBjB4I4KAko6qph2o77k=;
 b=cmgMQYtyZQjWC+7G7l16hj40IPxDoWpGzXS8jFm3b6/dTt8pl81C/lNE7FrDEqwvlTAUvLxy3C55WkNS4vcksvkH7zX7J79RWxK7/8ostpyVv7k5V11VXiNvtQ/WlF+PdqWP0OEz+uF9beoA7jE/R0uVtN/c91hMJKVcrPj2aqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYCPR01MB8689.jpnprd01.prod.outlook.com (2603:1096:400:18d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 27 Aug
 2026 08:12:46 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 08:12:45 +0000
Date: Thu, 27 Aug 2026 10:12:25 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 06/13] drm: renesas: rz-du: Add RZ/G3L (R9A08G046) DU
 support
Message-ID: <ao_xad3vB1e00GID@tom-desktop>
References: <20260826174854.199139-1-biju.das.jz@bp.renesas.com>
 <20260826174854.199139-7-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260826174854.199139-7-biju.das.jz@bp.renesas.com>
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TYCPR01MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: a27cad19-49a7-4e9c-cf7e-08df0412f92d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|366016|1800799024|376014|52116014|38350700014|4143699003|56012099006|18002099003|10067099003|11063799006|5023799004|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: he8DQPK3eantYx5bX/DgW5nOrrIMtkN1rvFD0FYlJgZ52gxax8iWma/aYxaZVnwXK9SVsNlqfHyd0QAPWosJRBfKmWPUrB638dDJ6PogdOwNDxWAHxBrx3uJ42JreHKWy2r71DxZ2WDnSIVGLctlWlLhVBtxMHhfGfo07wIK7mAX2OYOSuVmmOzZwGu78ke9qMsC6HMH/l0b4EYrcRZ3omcEJ/Hp797iQSh5LksKwNIsdIwGmC7+5qPXmAwqKqmbaamy3u8qqTi4yLaGxe3ZKuc1IWXmQSljB7DgZe376mqFSbCoQZVQ1JsBWbAdNeyn/jTRiiMdSDsL7/5U/+dhLF98azHNtnPMc8/AEHin8qxmHGnn3i1MYcRsrmO7rzyFyQJ/O1kOkMCj7hhPXA3kfKmI/MTQ0pvYjWd7wAO6D2i+r8dGQG4CuoP5i8PSDTKc5lmSWfjVE3IXR3MHei2SBW31K+o2nEY2Gx7sTQBXKz7UtuJXXmKHCddTYOAWcpfoAYibnQupa+sWk+2GKdp744Y5YA9uuih6rb3wFsYnKjueblfWwc6/C79a+DV1Trzd6nVyvui4epjYRf1PO+/zE6v1nClxV4MjOruYDI7x1I63aO+OD9RkGwOKuR6r9PfZevJ5sr9p+wvh4oCl5mAgyQG+IP00QCGiSpixWYTHOcfTwwGITvuh/sQoEBI1j1wdgO+GiYs6K5tIFGmcaNL3oxyask4bsP6GjzzQRTmbNYo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(366016)(1800799024)(376014)(52116014)(38350700014)(4143699003)(56012099006)(18002099003)(10067099003)(11063799006)(5023799004)(3023799007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RitFbjNJSlFoNlY0UFlEa1hKcE1ycDRLOWdJWFE1MDBLSWRuVjNFM3diZW5V?=
 =?utf-8?B?T21VU3BKNHhzZHlXM01La0dKNU9NT2ZFNlJNYk1XQUhQcHV5OThzTktJN0pW?=
 =?utf-8?B?UGJOdnpCRUZYdnhucXFVWVVKMml4aVhNN1hWSjkyQ3A5VksxZ05na0cwMXV5?=
 =?utf-8?B?a2ptcy8rYlRERFhQd2VrMGs0eWNOV1lYUXU5SDZESTgvSjY2T00rTWszYzU3?=
 =?utf-8?B?dzc4bzJRWGNkampHc21iQ3BmRHRGakFMZk15Uk5MTTVQQi9VdHltQzgrb3BB?=
 =?utf-8?B?dzN2SGI3eDZaVStBcE5aM0JpOTFBUEVUVWtsbUJyUmxmeHR2N29PcVE3eXhV?=
 =?utf-8?B?dTZ4SkxPMFI0VlVVL1o2bFN1bnkwTVlCeHlMRFA5V3J0NGxNM1p4bC9CK29M?=
 =?utf-8?B?aEpVTnhBSmNNS2o4dlJxWHJsd0lxRXAyRDc2Wmg3bENlTy8rbHNGSUZ1SVda?=
 =?utf-8?B?cVhLOUowTDlhSld3Yysxa0RkNC93dzhTQU9zWEVxVlBUOUdWQTdIYnA3dDNJ?=
 =?utf-8?B?dGo2UTMvdUFzWFhoYU9GZ1hZUC82MWdVREx0M2FjdUVJY09TbWZwbG1WeVNC?=
 =?utf-8?B?cVlqWmlYT3htZmZzQk5yRS9rNHNoeXYvL05JcDhsNkVyemdQaTNWSzkwRzRy?=
 =?utf-8?B?Qmpzd04zcTZhMGMvVHd6Y2drUE9KRW0xZXdwS1A3U3BQQnBuanNicWpLUnUw?=
 =?utf-8?B?NHNRQ1Z1VVFML3g0SWxkMGl0YnM2YlhKUWIyVHBuL2NUMGllMW5PU3RadStU?=
 =?utf-8?B?WUpqdjljQ2tpNXFnQzVMUEZZS0p3QmZqVWRnam4xY3dETkh0YmFVNWhSWUpC?=
 =?utf-8?B?NFo4Q2NhMFNOZkdubUpNN1k0YlY3UGd3RW9vRTU5L1R6YWxVY2tKYmZjMXlW?=
 =?utf-8?B?YWZsZUh4Q0ZOV2w4U01qOG1nZUJMQXl4U1JyZ2tWQVF5cm5OaVZSR0laSU1o?=
 =?utf-8?B?WVB2ckRFdDNHdHJlb2hzUldRMGl5SlJQSU45WnYyTk5xTWx5V1VYam5acndC?=
 =?utf-8?B?UzExblkwYXcrbVVGbVF1VHJRSVhFbmZTS0ZLbXVkcnM5bXNHVjJLQzlKVXIw?=
 =?utf-8?B?TGdNR0dwKzBma0t6REEzVHh6bXhoYnlkamtKK2JISThEenFxelhFVWtudTlY?=
 =?utf-8?B?RzU4a0Y5YmtJMjViTjNFdUppK2xzR0hjVzR2TVhLWnJzMDV0VnFLcGRDSFIv?=
 =?utf-8?B?K2tkRDZjT3VBTHJkMnc2Skx5UEVEZGI3N25mZ3lWRldoQ0VVZnV3ZFpBS3JB?=
 =?utf-8?B?WUxOL1hYUFZwWWN4anBwdzNsZzc2K3kwb25CY1hPQmNSemNmV3pDdGlTS1px?=
 =?utf-8?B?UFFFOHFLOUNPdnYwSTVLQnhOK3ZKNHRGV0VDb2x5WlVMaGF4Yit6bC9NWCtp?=
 =?utf-8?B?cnJqTVlSU0ZKdUw0UC9nVlRqcVRRWkZ2RUxjMWk1TjUxNTRVZndpWHcxWlB1?=
 =?utf-8?B?ZDZFaWxpTEZiK3A5bWhqS09yeCtJMzl0c3ROWU5QN1JtQXY2NENQRTJVdEJU?=
 =?utf-8?B?M3RVcmhVUm93WC9HQlpjalpiZmJvNFQzZ3RvWkhwVTVxenpMdDNJQklPWW11?=
 =?utf-8?B?QlFmYVFySytXNFYzQzYwZDA4a1RpcXZXY1IyRDNsSlZiZU94N2orSVhSTkZt?=
 =?utf-8?B?NkZJZ0t1eFBDd00vZi9sWko0RndTSmYyemNNNlZJTG9Lek5mY1R4aGxmcU01?=
 =?utf-8?B?MTBteXd6ZjlydS80L0VhSlFsdEc5V240RG1EN3FsdEFIamw4cGQ4M2tDbWF4?=
 =?utf-8?B?VDROazd0LzJxb0orUExYQklVY0tCcW1vblc5Sk5MYlV5OWpxT0Zya2hmMURY?=
 =?utf-8?B?TjlwT01tRnZ3bmxLOFFnS001THhLc2tnR0hJVVhVOU50NThPNllzenRDQmdq?=
 =?utf-8?B?bGc5T0FYVWNLQ0FpMGFicURHY09abEtXRE12VE1CZmYyenJBVExlM3dxTXhQ?=
 =?utf-8?B?MHJRbkM4QVJLRm5na2g5bmI4a1JlZlVZNnB0YW9CVzl5TnB2blBTb3RXbnVm?=
 =?utf-8?B?bzVLOWNKRGZNQUtJcTJydmpIdUhkaFJsR1U2TFVLUk8xNVpyNnhOempvK05v?=
 =?utf-8?B?UjNxNktuTDJNZFZIZGNnZDhMUU1ZWWZUSnM3ZnNVRmoweVlGVVQ2V3d2RmFn?=
 =?utf-8?B?OGVick1CYk9tdnlIVmFuSktsUG0zMEVmVEVqa3VYaEFFVnhzblFmRmgreUYz?=
 =?utf-8?B?TlE1ZS81MTEzSW93bmF0aGNwM1dOdXBVUXBFcjVSVEZoc1dJNHZTNGVwRG1P?=
 =?utf-8?B?ckRTL0x0b3Z0cENFbjdEampXRWpiVWFqeGNqME9lRXptc3VLa3JrQ2hSa3Vl?=
 =?utf-8?B?bDNudERSR3dnSnJ4OEhpSWNpODhSZWhDcEJDZlFGY1hZdjF2SXZGbVAzUEFV?=
 =?utf-8?Q?hKwmeOjg8ghy6nwFDoAN3k8x9uYoj7p/YMoS0?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27cad19-49a7-4e9c-cf7e-08df0412f92d
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 08:12:44.8263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGJ3qnWZ2CAH32HAQX6UCzXqfEASHeM6SvYryYsIAKMUXK+uxvtF6gQ+SUwceIyV9Cob2xfMPIEzkD0edx32t24mblUi1Agg0GGnUcB/iJUEVfQM5R898b0ritAvypQS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8689
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

Hi Biju,
Thanks, for your patch.

On Wed, Aug 26, 2026 at 06:48:40PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> Add Display Unit support for the Renesas RZ/G3L SoC (R9A08G046). It is
> similar to the one found on RZ/G2L, but has LVDS support.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2->v3:
>  * Set duty cycle handling in DU encoder
>  * Added min/max frequencies for DPI.
> v1->v2:
>  * Dropped the macro RZG2L_DU_FEATURE_SMUX2_DSI_CLK and RZG2L_DU_MAX_LVDS.
>  * Dropped the variable rcdu from struct rzg2l_du_encoder.
>  * Dropped the variable lvds from struct rzg2l_du_device.
> ---
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  | 24 ++++++++++++++++++-
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  |  3 ++-
>  .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  | 24 +++++++++++++++++++
>  3 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> index 3d13f61d3c97..6c2dc86abc7d 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> @@ -55,6 +55,26 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a07g044_info = {
>  	.mode_clock_max = 83500,
>  };
>  
> +static const struct rzg2l_du_device_info rzg2l_du_r9a08g046_info = {
> +	.channels_mask = BIT(0),
> +	.routes = {
> +		[RZG2L_DU_OUTPUT_DSI0] = {
> +			.possible_outputs = BIT(0),
> +			.port = 0,
> +		},
> +		[RZG2L_DU_OUTPUT_DPAD0] = {
> +			.possible_outputs = BIT(0),
> +			.port = 1,
> +		},
> +		[RZG2L_DU_OUTPUT_LVDS0] = {
> +			.possible_outputs = BIT(0),
> +			.port = 2,
> +		},
> +	},
> +	.mode_clock_min = 5440,
> +	.mode_clock_max = 87000,

Pixel clock must be within the following range:

	– Parallel = 5.4 to 87 MHz

rzg2l_du_encoder_mode_valid() is checking the DPAD0
output mode clock then here we should set:

	.mode_clock_min = 5400,

Thanks, Tommaso


> +};
> +
>  static const struct rzg2l_du_device_info rzg2l_du_r9a09g057_info = {
>  	.channels_mask = BIT(0),
>  	.routes = {
> @@ -81,6 +101,7 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a09g077_info = {
>  static const struct of_device_id rzg2l_du_of_table[] = {
>  	{ .compatible = "renesas,r9a07g043u-du", .data = &rzg2l_du_r9a07g043u_info },
>  	{ .compatible = "renesas,r9a07g044-du", .data = &rzg2l_du_r9a07g044_info },
> +	{ .compatible = "renesas,r9a08g046-du", .data = &rzg2l_du_r9a08g046_info },
>  	{ .compatible = "renesas,r9a09g057-du", .data = &rzg2l_du_r9a09g057_info },
>  	{ .compatible = "renesas,r9a09g077-du", .data = &rzg2l_du_r9a09g077_info },
>  	{ /* sentinel */ }
> @@ -92,7 +113,8 @@ const char *rzg2l_du_output_name(enum rzg2l_du_output output)
>  {
>  	static const char * const names[] = {
>  		[RZG2L_DU_OUTPUT_DSI0] = "DSI0",
> -		[RZG2L_DU_OUTPUT_DPAD0] = "DPAD0"
> +		[RZG2L_DU_OUTPUT_DPAD0] = "DPAD0",
> +		[RZG2L_DU_OUTPUT_LVDS0] = "LVDS0"
>  	};
>  
>  	if (output >= ARRAY_SIZE(names))
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> index baf076d69cda..e9626ef37cde 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> @@ -25,6 +25,7 @@ struct drm_property;
>  enum rzg2l_du_output {
>  	RZG2L_DU_OUTPUT_DSI0,
>  	RZG2L_DU_OUTPUT_DPAD0,
> +	RZG2L_DU_OUTPUT_LVDS0,
>  	RZG2L_DU_OUTPUT_MAX,
>  };
>  
> @@ -33,7 +34,7 @@ enum rzg2l_du_output {
>   * @possible_outputs: bitmask of possible outputs
>   * @port: device tree port number corresponding to this output route
>   *
> - * The DU has 2 possible outputs (DPAD0, DSI0). Output routing data
> + * The DU has 3 possible outputs (DPAD0, DSI0, LVDS0). Output routing data
>   * specify the valid SoC outputs, which CRTC can drive the output, and the type
>   * of in-SoC encoder for the output.
>   */
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> index 3d0999e4fcfd..a1b48973aa8e 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
> @@ -7,6 +7,7 @@
>   * Based on rcar_du_encoder.c
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/export.h>
>  #include <linux/of.h>
>  
> @@ -15,6 +16,7 @@
>  #include <drm/drm_bridge_connector.h>
>  #include <drm/drm_panel.h>
>  
> +#include "rzg2l_du_crtc.h"
>  #include "rzg2l_du_drv.h"
>  #include "rzg2l_du_encoder.h"
>  
> @@ -64,8 +66,30 @@ rzg2l_du_encoder_mode_valid(struct drm_encoder *encoder,
>  	return MODE_OK;
>  }
>  
> +static void rzg2l_du_encoder_atomic_mode_set(struct drm_encoder *encoder,
> +					     struct drm_crtc_state *crtc_state,
> +					     struct drm_connector_state *conn_state)
> +{
> +	struct rzg2l_du_encoder *renc = to_rzg2l_encoder(encoder);
> +	struct rzg2l_du_crtc *rcrtc = to_rzg2l_crtc(crtc_state->crtc);
> +	struct clk *clk_parent;
> +
> +	clk_parent = clk_get_parent(rcrtc->rzg2l_clocks.dclk);
> +
> +	/*
> +	 * Request appropriate duty cycle
> +	 * - LVDS path has DUTY H/L=4/3, 4/7 duty cycle.
> +	 * - DSI/RGB path has symmetric 50% duty cycle.
> +	 */
> +	if (renc->output == RZG2L_DU_OUTPUT_LVDS0)
> +		clk_set_duty_cycle(clk_parent, 4, 7);
> +	else
> +		clk_set_duty_cycle(clk_parent, 1, 2);
> +}
> +
>  static const struct drm_encoder_helper_funcs rzg2l_du_encoder_helper_funcs = {
>  	.mode_valid = rzg2l_du_encoder_mode_valid,
> +	.atomic_mode_set = rzg2l_du_encoder_atomic_mode_set,
>  };
>  
>  int rzg2l_du_encoder_init(struct rzg2l_du_device  *rcdu,
> -- 
> 2.43.0
> 
