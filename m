Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21547C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F77910EECA;
	Wed,  5 Aug 2026 15:02:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="O9z2LW3a";
	dkim-atps=neutral
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010009.outbound.protection.outlook.com [52.101.229.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77CA110EECA
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 15:02:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLUgKFOBsOc3AXIn7oqEMugbojajkp9e67kapus5pK3jiX3KvkXYoruKFGWmbZs82yhVEXWGhcsrBkz8mG4eAN9eOulB6tuY6PAIkbtPwu1cZWUwtMxfPRY7c4rnkvIRvr5JUID5CJ+7T47hVOU12sGvodktwWCs0PBrAjeqhUaalNVeeGfudBHLbo576q7vIf43qdmvd0bDwGA79iOcIyRqrcITgpIeZ13MN3L9Ps03fcO/n9Gji3BtdnDKyVxlzcjwELq5Pm4pFcOLsASX62ArkVohCL0TmFyn/ScXRFhGScIWhNu2jSytA84womGovfPPR4S+f8fCUBTAuLHFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlSq7st24iN1HeCztkbkCdAHFcRT8MaS60Kgpsmhw1k=;
 b=iS6Uq2oCWYGaUdlrxX6Rhuon0FVdM4vDRAdBfYCfv5NItSOmpi4D4d+f7HY9vb5fPfDU0HDXWDTLcN5iAEHdiUvM2+okHd8Mei/g0+GOTV0oNHPOcjPN8F4NZbPxMzyOYd6mFGlh7fDQykvPBqMgs2uvOugWI5X/+ldmDGkJEEdkCWkjGUKt7Oih/2uCAMz3PEbNYzat9n4EEoeN7LHMLdQSw2m5iPZypPdKCPU9Ags61m5/f5gFxnorWR1QrZet+v0kjn1XYAmkSvvXTZsqm9cxigl5cEi5afubaqVq/H/dIoX/wAWGHSjFrO5ACYUlNVoGlV7xqIqQQgrwpjaXow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlSq7st24iN1HeCztkbkCdAHFcRT8MaS60Kgpsmhw1k=;
 b=O9z2LW3ayQv2fQKn4+MA9d4MQPmA88AV0Ii7HqYRVad6wGOBnxLcIqbV+1LCzBB5Tnd5HHs+kVeWNQnqoVBEIp1ItMHMJFtA69gRnFpDxD6pjuWeBHuGF6bcCYuCWn/zFE7PsjbrKduyUNfNPIOlzu9KeY3nKmTqsPPeE2+V2DM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OSCPR01MB14837.jpnprd01.prod.outlook.com (2603:1096:604:3b0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 15:02:22 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 15:02:22 +0000
Date: Wed, 5 Aug 2026 17:02:10 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 03/16] drm: renesas: rzg2l_mipi_dsi: Add
 activation_dly to hw_info
Message-ID: <anNQco6rT9GZkeKi@tom-desktop>
References: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
 <20260729125516.230757-4-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729125516.230757-4-biju.das.jz@bp.renesas.com>
X-ClientProxiedBy: FR5P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::10) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OSCPR01MB14837:EE_
X-MS-Office365-Filtering-Correlation-Id: 8936e370-d913-43fb-a40d-08def3028d51
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|23010399003|366016|1800799024|38350700014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QKl+D3LCyZiwJFJWfMufd1Y/PNR8mY2GKoc5tnuKz5gdXKXoeh0DdsmVV2qC8INhH0nUgQCAjYVy3DDLK+MarhQ7pyfoA7hDrps1c0ko1EcRdOWjNDXdurLGA2jjVu1j6hOBVOS8cwi+Jn+MTRuVV8mZb0CFxpVkF6s+/wfGV1ruudAtpRA7Tn05ynyDy44Or2KbVkA5tWo1FfLu2Fa8yn4Uoy2niD6W0aQbIYdBR/vid+2lYdgiOZLpjGj3kuHZvnkyv/PRe5DxzAjsNT/NF/15KiSA0kvDdVzADke7wjnNNRIllX4p0gLqS1e3+47QL6te35Q0cG0RjJTgIMMWieu1yG0/KUXx14kfs/jpNQHw+oD4LGfQaWFN4eF3iaCm4tdHdRJlO6LGdXai7mYV/ZJWXywwxN7wPTo5S6GCiiW0DCUjJ2CGawxs3J0KrXqISvwOuoirN30zIjV/7TbiuIIa6HbP7TfmH9wCeAJfRC2RyavP3St3QF2qyCSl5qbU3ILuvykbanTypM76TGgkjizxYQ9btNGOmgOvy1j+tBs3vgAA0yd9DHGzaxbJ8XOl/z4vvkEE9BEjCVXydoZecautAQbrr+7ttyWumuaX4KA/WlldMhScjcdSg7+edUWmz8Mmo4cuRoD+kSeE3wXxhpndeblhzRNy73Qih0Zhsa6/ZHlU0D/1oMw87vdGSGAab61vtPpNZg0amY14aiDSlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(366016)(1800799024)(38350700014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m7gC9PstCBlyh8377KKLQs++51HXYNN/u7lo9GWcOP5r3rzr9ZLwqjqLmzSW?=
 =?us-ascii?Q?jKmyDTkzMZxhvJ+1fAEXSzIm5dmsa+rbTO2Xctl2dE8W/yugetMyEsBSvm89?=
 =?us-ascii?Q?Im9F7pXBbBwXMaG8jn066vN1VIfATMeZ2eibdu302qkTMSANUUKfVGug9g/X?=
 =?us-ascii?Q?MgoF2Xl1vZQFviUOx6paMMOY+f4DAleTb3hJLPnudNAJNpKUYhWZ0QXedLGH?=
 =?us-ascii?Q?W4P8gEGHRploHBFjikcyPg00TjInHa95brDf34li5GYcmhXhV4UyGZi7DcZm?=
 =?us-ascii?Q?zyLkom7etHw4cS02EQ3eSdVMf7hpTOEGSXHOzqmCIpBnctvpBaIalogT8cH0?=
 =?us-ascii?Q?FBobBJcngKKbo2F5yxtNc15z8oQPN+OzwLQ6CW0xaeSO19ghtrvgHs3JgH3J?=
 =?us-ascii?Q?rvTqQWmo+VblUgJVzd7FW5sluazAyWS2YR2TGhliV5fDlVWtuDJvZ+cKr3g/?=
 =?us-ascii?Q?0mY58dF9Eb2JwddC0mYkMoEvBrGaKLNYoO4iHPoWTdXV0p1nvWpr6fAqitUw?=
 =?us-ascii?Q?QhuONP5KTI1TgbH8V7COcJYdCCFCiQCqOyiSfpXAFFW+LDeM2mL3E29KgUsl?=
 =?us-ascii?Q?CBs4E0Rc7dzdpcakYqJl4PZOFcphO6osWRM5wK0/DlefladqFurjnFOfKXjw?=
 =?us-ascii?Q?qW4moeb+K3ENlAP7QJ/ZPDc7EOEs1CvBjsYoh23OmOW8f8LAkh8cG8HDGlUT?=
 =?us-ascii?Q?Gi03Ew5/MUO8r3Pn1zc7KImlIsLIvR1dDxSvaHtt5V+wddAWlJSYDCGSsESJ?=
 =?us-ascii?Q?JbYrzD/XFj0wAXjWl8+A38sHLzokdxOBvW8j0x1yGqceEQZso20s5MAw0Wp3?=
 =?us-ascii?Q?CaDQ6LJsGV0d3Ef/HIB9ZteZHoAIFgcG5tzAJ/jeaKwo4QdqlECc6ZlRZwea?=
 =?us-ascii?Q?ROSP0ZmQJ0YGw75BXWe1rpcV1VWaKTSstAsF4Zu1R9qvurR8/UB6yw37k3Zs?=
 =?us-ascii?Q?SAK8OltvB68TwJ7DTd+Yx1Dg62SmmwW7m07ab4qN0AhfFJVFJ/w7WBx41Vhc?=
 =?us-ascii?Q?RlphtUgHgZzadnWo0bO0dFcXekdA/9bciOxPAUbgdhrIJTtmhEIZ39xcqtTU?=
 =?us-ascii?Q?h5n8I9k5B2noO5+iR6Wyv4oEBXyVTAvljyX1P7r7S1f1WvqjkKtLI9MqdU1E?=
 =?us-ascii?Q?vLl4ELpxdhvuCw32RXmDUePWnt9WEaQBGyKinsMpRj2JhqfnTiM52CDiyV5/?=
 =?us-ascii?Q?a1PuWUSeXSja7LmDZK2W7qJtfbgcrhlg7E7s5uvkL1PxrrBuJfnozbpit2w9?=
 =?us-ascii?Q?rwLOzb8dhyCY4x206Gw3jt7QotoNlQx+5kNYHJku+bqlFaHmVQJCw1UGjMHI?=
 =?us-ascii?Q?FiZ2muguA8MSloBdJ0Y27+z+wCrFCX1CTzwCBBG01acCKrE/9aGA9zoqaU1A?=
 =?us-ascii?Q?fBJ6n+6KxRDoAxetjlx5VuARindRBwCbkG7I5G5AjKAWtuaIiMuQkY3ctkx/?=
 =?us-ascii?Q?h2eqyk5CTLPu3qOrscs73jqFo3AaAi95COsR5jBp71TCDDnYan+mP+lXS+Sh?=
 =?us-ascii?Q?qtx8zG+rHRuR4ief5+shppwEu1vdpu9AFVaEVWxN+2bnkNyEYtFK7B/x9t/n?=
 =?us-ascii?Q?eL3ps7MkRkkItIE9NgShAT4sXlyPCLN1F/udCJlWwvi8aj17L3fPwOajK7M8?=
 =?us-ascii?Q?quB0KXI7nD4+jjuSq8k3bC5eh2pOXD38/ZPS11qGg+F/tnxKuRpqmSY0pi5q?=
 =?us-ascii?Q?FIvd6xS02KugGD3HIIjakeBqbsgvTRzDGs/2R55ajYWHTTz7Cklyf5dXlcB5?=
 =?us-ascii?Q?XQFk7DVbnarmlfiLyA2kwTetx4DTti3XdaUm9FPDC0C1f0CBsEKx?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8936e370-d913-43fb-a40d-08def3028d51
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 15:02:22.4061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oqc8rKjhKHgHKJ6UV9j2aQnRCtChS71iRSYq/yEcKIoxI9z1+t7dGvIXHdN7IsXe8djMcBlPxZWlFzwBQ2QNCPgWSxykgKSq81cDo1qVmY93EnthiRVYhcw4X3vVDP/Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14837
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

On Wed, Jul 29, 2026 at 01:54:55PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> Move the post-reset activation delay into the hw_info structure as
> activation_dly, allowing SoC-specific values to be defined per
> compatible. This prepares the driver for supporting SoCs that require a
> different delay after reset deassertion.
> 

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Kind Regards,
Tommaso

> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * No change.
> ---
>  drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> index 2128fd16ebc9..1538eeece2b5 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> @@ -59,6 +59,7 @@ struct rzg2l_mipi_dsi_hw_info {
>  	u32 dphyctrl0_init_val;
>  	unsigned long min_dclk;
>  	unsigned long max_dclk;
> +	u16 activation_dly;
>  	u8 features;
>  };
>  
> @@ -806,7 +807,7 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
>  		if (ret < 0)
>  			goto err_phy;
>  
> -		fsleep(1000);
> +		fsleep(dsi->info->activation_dly);
>  	}
>  
>  	return 0;
> @@ -1534,6 +1535,7 @@ static const struct rzg2l_mipi_dsi_hw_info rzg2l_mipi_dsi_info = {
>  			      DSIDPHYCTRL0_RE_VDD_DETVCCQLV18 | DSIDPHYCTRL0_EN_BGR,
>  	.min_dclk = 5803,
>  	.max_dclk = 148500,
> +	.activation_dly = 1000,
>  };
>  
>  static const struct of_device_id rzg2l_mipi_dsi_of_table[] = {
> -- 
> 2.43.0
> 
