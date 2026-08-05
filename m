Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445F0C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 14:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 807EE10EEAD;
	Wed,  5 Aug 2026 14:55:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="KsWzYdRJ";
	dkim-atps=neutral
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010008.outbound.protection.outlook.com [52.101.229.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B425610E20D
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 14:55:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgN/rnq30XTczNyuQ+Lmd1lJzUXgurV8H7WAyvNJHdkE0nwmzDViUgVnU+5piL29B4VBs4wNyK/4qohPiLJ+zu25ttMMvUh9HmYu4k5CUQ1i6p6HHREANG1/7Kuu2W7YdAGSs8Bl3FmPXpnZXK/z+EjZxQcmFIAx2AjwiWzz3bxnJjzO69AW3VBp5VPdeY6Y2MmS4r7+cQGdTxGQqu688//t8/iF462spkfc94ehyMB0Sh/I/YSZKn3yP9Cq7qhuwprGvdB3SFSxLkt/ZAbURKswOyvNGa5v69yJpaMbyJvyt9hGgqFE8HYpHxoE1jt6uDfKMNyKzb1qokwaA1/oPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGQN1WysUIyIv6BALo/YZiUPvIbAluUAmM/xwJEY5Ag=;
 b=dHxXFfDT5jvdsZw4oulnP5NDFEVlkrwWceZlw9Yc+CTNQOQt7OOIrNpt3dDSfWblTVULLcUg1k5OxRDv4daTDlPPM7J9SDGV2J5IvkPFBudYrYDlky3HM4l46CRXcoHsDvY0/3Q0r84A4LBISpHhHbRWSV41YMsVR6wAZHy9Iz9lNsK78TiqpdevZ0os0zDq2BSK3Wc5J+QwwoPsB3UIcqx/iL8CJdpn9cKTPHep4Y/ZlDtgCk/16fd2a3WA5PCMtdOfojGgHOZ0XdJltu9m9T1ei+0098QdH/9vcoTj8LCGkMBqVM3TjPLfsVtrDOPglftxHD8qgRnPMhTp5hyn3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGQN1WysUIyIv6BALo/YZiUPvIbAluUAmM/xwJEY5Ag=;
 b=KsWzYdRJ9Kjp9gnanDrP4x8cgN+w/sMdv24yN3bFLJ5cCpPrjE1/SFb+uhaTnAc8qmq/Zx5kb6QGV0P4LtbfieqWEsNFTAcBbKwo4Pa1JVeIbzHAl4IuC9G1x44XcaaWtpru/6DsHROlIT/C5E66fa6PD8pQos4maWbenTY8pTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OSCPR01MB15927.jpnprd01.prod.outlook.com (2603:1096:604:3ef::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 14:55:17 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 14:55:17 +0000
Date: Wed, 5 Aug 2026 16:55:01 +0200
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
Subject: Re: [PATCH v2 08/16] drm: renesas: rz-du: Add RZ/G3L (R9A08G046) DU
 support
Message-ID: <anNOxTRIUKtjyKKs@tom-desktop>
References: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
 <20260729125516.230757-9-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729125516.230757-9-biju.das.jz@bp.renesas.com>
X-ClientProxiedBy: FR3P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::12) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OSCPR01MB15927:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b8b270b-868b-430f-4de7-08def3018fb5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|38350700014|10067099003|11063799006|5023799004|56012099006|4143699003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: uwIe6s17e4qFzpcoicTLodr5jKjsUyrCDU8tlKhfw2mHy1SLixU9Fn6STsF+l81C8hhOtX2N4sgK8fdBYBWpJk0k5uRZiwIsHgQOID0Kuo19Gxj3Axkb1dWprAV2LkipHEk3Kl+23GLy1/poOB2O9ZL2L1esTxCbuQ2Sipyzm822w+RrK1JyR2TUmC7k8a5CKl7NOaHFEmu27F9pgc0cL+pIA+YtKtEO+2EpJQb6FUFaIMJcTqsCcIQjd5CuEntC7DpzajvgiE5M6BTy1BlD2GobuQf5wF3FVUXhAcnOH0pggp2HuC7sdtcPCsYlbzIBylW327b0d2TCilewv6NdiOOkDnr3grRHoGzflwDH5Twf9etotvX2Q422DdpFY51QqaWFz+IQy1C1sU1TBC5HnFGbG5sSkFy4e02ogWe4X7dpVhVkrMLOq1ukDcoD1CFGwGTeQ9yFEEl6jQx5Od5A6E5kWJCcWGLI+C2AffJq8eDwZJuwDpepPYtnaZFzn7K3JEhPZqYSyY7PN1G3auAIE66qpc8485Y6mB/zXb/THudI9tTQhDp4+epLiM1cw5wShhjv3iePA+/vcWZ9nIgpeZZWxt8SWzt4qDFk29TJl3AGDKFEGi8XgVJJSlVPsH9+Z6Yek2Gg+1TnyGRe227bZDheHKvrxhFb2kc32HJ09RZTmE8TXPCRkA48alxMmb/9ucR/O3abx30SF0fi2KWnYpl06uEKKYGbLC66akYna0k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(38350700014)(10067099003)(11063799006)(5023799004)(56012099006)(4143699003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XkHbfh+VX2t2EhrXXav0oiHar3wD6Ctg29ToNJyGX5tqZMadS4iZ5157mMk/?=
 =?us-ascii?Q?r46zEzat5bLNxXA9Mi1YJtNnlf1SFYJBSNn4It1JqQeg2AAHv9xnXd3udnMB?=
 =?us-ascii?Q?Qd10uNRAQgFYRCyraUshWer3qhf6DsdUhs2ngoRvKJQ6/15X4e/JQIByEGTv?=
 =?us-ascii?Q?utue9I4QBrhFN219BbC3/jzHL5YSkJKxOgJwRl6QT2ltIjWwZn5tav1P5yNq?=
 =?us-ascii?Q?pfbZjgyiIgNYD0h2DoydRLmlId8XYCLi0a4sWC7wNDoD9ywg0dnL53/NtzCI?=
 =?us-ascii?Q?9uY25VQvC2zyJMYyw29tbOagEv/Iarg4u+0jj2gjvJXW+DwB+TcY17EgGuVe?=
 =?us-ascii?Q?k0y6IYCPcAwpabfn2RTkVPYox+WvrMnTcHT/g88KYdyE0HWs+W5zKbf+Nz3U?=
 =?us-ascii?Q?LJ6Yyre5O8/ukH5NE9U6RL8WZsUtSbNUwHY6VrS2F/mJCUhHH29GXQ41DltB?=
 =?us-ascii?Q?9scalzwhwq53ZHPmndagKwvPujcMQcetSl1q3O9hecS1uly2XNPoCJAopN7+?=
 =?us-ascii?Q?yqT9gErK4nmAMHbf50LCPb2d7JZMfs3HAgua5VH9iha5tzCkoCdPBovBHhSx?=
 =?us-ascii?Q?6ZTlEjbMSlYEDOJeRel1BbR8/S0MlEwMFRyJzjAABH627c/UMpIIwsrfEkh+?=
 =?us-ascii?Q?7bTMRHuQagRY6xFDbAcvh687nL836ISidNXGL1ivuZ0kGimK+sZx4vuwUA9b?=
 =?us-ascii?Q?ZZ83kW5a/HIv4wfhw/tv2FWHOKDOUh/88wZyH4RptzahLSEcgEfNip+osiEK?=
 =?us-ascii?Q?RWKDjQQFEf8P7D3B01cdliBp/X5LYryBvVmahadxs3fPf587kXIKWeziAJW/?=
 =?us-ascii?Q?wCXLvyVvqPCb3YU9rK6C+IL1cAzaiacs/vjiCYJg97NTf2as6RrCm1XXIU9M?=
 =?us-ascii?Q?odzp7BxPIPHcYt/MwGuFdjEpxNZJqn7eViD/M2+YL3imjsyJBXEzTG1YkGwy?=
 =?us-ascii?Q?8ChQg6Rs3R3AAkRqKHfgaRShs0Hf5k6iqf8XZB95/8RMtmXcBw5J310mKeGv?=
 =?us-ascii?Q?MLHAvsarMLGtdlu+T4b5ZeQ/3qdK5dO3rpch3dbiDB1xMJ08Uzd2ug+Yu7pK?=
 =?us-ascii?Q?mrz6/t4uD9IF0U0WVGc0oPEDnW/CNAcspilIp6rq03LMIQc7LlosC48rfTgt?=
 =?us-ascii?Q?YcaKs6H/CLkF4hW9Rtvkk6NuVoNb3S7+SqZZk3zlrJYLGaeZec6b1EWFOMEB?=
 =?us-ascii?Q?VnkH6ONKrlNAPvJvyzfl7+rLhPDZwfdSoW4WYwktbTDn6CaxotVn4jfM5xPz?=
 =?us-ascii?Q?Nwke1+24CIcFOVXiydqariTQlKRksa20r8x1sT1rsUqp/yKGYqQ+NXnKrn/e?=
 =?us-ascii?Q?ruaSpYMyVcKzVSMzdiWnHW+GKhJtvZHuAfTTqADuYi/pFkVZ6BH4HX03FxVH?=
 =?us-ascii?Q?zG/Hku6wMn2WjBde9/RAxUr/JE96+LdLK+fsCGZE2mUvGMktftBSSJfchk+X?=
 =?us-ascii?Q?RL2uF9y+cORpo2TB3s62HJWlBt3jyV+a7dRMD6BDmXgxSC6X7B3gyIfvFUR9?=
 =?us-ascii?Q?d0GSzPsUz+/bdDZV9gHTKNgq8ASE3Q9fRa0GIV2J7bQEwuMKPmidmK1/yBO8?=
 =?us-ascii?Q?XhM3dJGQ3vdUNytI2uooDrqe99rRtbiAA3WPX1v89zhdRpPOiclu1yGyUJZU?=
 =?us-ascii?Q?fMwQXlWXU5EGROl12mOrVb87krCRIEIByIRLRTUHY1qzdldnaRFtYrJ9QSxS?=
 =?us-ascii?Q?z+71FhmW584t5yJ9YvW5rb60z698tv8R+TveXz0yOaRnwZKItPD3Ldi/TOwQ?=
 =?us-ascii?Q?wFCsqvuR4upwI6ceMI3FRktiPfFzlzFo6eT9emEr0OZziC/gWoqA?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8b270b-868b-430f-4de7-08def3018fb5
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 14:55:16.8965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QStHuYHbpGkmhcdm04p7u1ohxQtEMWbfQD0i3om1Vbewv+Swk/xA5qDjNzi7WC5A3z50ceByrVY6BurugXQRKOYa0n/8zl0LUxaitxYdAcKnEbAfkSRBzQyP72qofdXd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15927
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
Thanks for your patch.

On Wed, Jul 29, 2026 at 01:55:00PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> Add Display Unit support for the Renesas RZ/G3L SoC (R9A08G046). It is
> similar to the one found on RZ/G2L, but has LVDS support.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Dropped the macro RZG2L_DU_FEATURE_SMUX2_DSI_CLK and RZG2L_DU_MAX_LVDS.
>  * Dropped the variable rcdu from struct rzg2l_du_encoder.
>  * Dropped the variable lvds from struct rzg2l_du_device.
> ---
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 22 +++++++++++++++++++-
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h |  1 +
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> index 3d13f61d3c97..a8d841421a0b 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> @@ -55,6 +55,24 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a07g044_info = {
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
> +};

rzg2l_du_r9a08g046_info declares RZG2L_DU_OUTPUT_DPAD0 route but we are
not specifying mode_clock_min/mode_clock_max so
rzg2l_du_encoder_mode_valid() returns MODE_CLOCK_HIGH for every mode on the
RZG2L_DU_OUTPUT_DPAD0 output.

Please correct me if I'm wrong.

Kind regards,
Tommaso

> +
>  static const struct rzg2l_du_device_info rzg2l_du_r9a09g057_info = {
>  	.channels_mask = BIT(0),
>  	.routes = {
> @@ -81,6 +99,7 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a09g077_info = {
>  static const struct of_device_id rzg2l_du_of_table[] = {
>  	{ .compatible = "renesas,r9a07g043u-du", .data = &rzg2l_du_r9a07g043u_info },
>  	{ .compatible = "renesas,r9a07g044-du", .data = &rzg2l_du_r9a07g044_info },
> +	{ .compatible = "renesas,r9a08g046-du", .data = &rzg2l_du_r9a08g046_info },
>  	{ .compatible = "renesas,r9a09g057-du", .data = &rzg2l_du_r9a09g057_info },
>  	{ .compatible = "renesas,r9a09g077-du", .data = &rzg2l_du_r9a09g077_info },
>  	{ /* sentinel */ }
> @@ -92,7 +111,8 @@ const char *rzg2l_du_output_name(enum rzg2l_du_output output)
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
> index baf076d69cda..7812f36edbe0 100644
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
> -- 
> 2.43.0
> 
