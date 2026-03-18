Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F60103E179
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 13:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A19CA10E029;
	Wed, 18 Mar 2026 13:39:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="p3aEpQ//";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012070.outbound.protection.outlook.com
 [40.107.200.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F244210E121
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 13:39:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2VbaRV3QW9AKB/RhslRlpBrlAVerVdYOSPX8AyErWYbSlLQ66fRCBIYY4a3DbL9ah/IoyIMwGqN0VBhiZKf2Bg8e//ejkO1LCdI3z2RUngRHntoe/F7ZZcnx25cgLiJnY5rgwsTrW9YNCroNEB0WVikf8z8jXNzhcNPiIGzLPMRQj7IQIfJw16bEthjv8tGlZGu5DUwQm8ua4A5GU3CQl5icgdEF19S9Nn0EIfi8NXvndp4c61piZdc98IFlEBX4Csl/Sg0q745Dwzosa7+WC2RDLckW3HAFdyYAQxWt84xRBfBqZb2hjfE6ZDDwt7snusyZi2HWAIHg4aYTrwUrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRzUmKTCi5FMuHi4oP6zMA75DNv6Nb7heTk6U5Tt3eI=;
 b=VZlAuSIz0y75V2XIH/eMu7/ou2foyaOVVWMcrvWhYLJGPREgwWsPWk9vViKM3q65HOL4HqMjhGrWi6+a6pCh1/XPit+afodJYCdjU3x+5Hp2Yh+7GBSQR7uYBiLsEE4RehjZ1o1zQTqWAFhQunwB3XQmUyP3uaRqlRlbOq8wkE/nnvytPBvwOvZ0euvmDlQ2Bfkq5TB8eSQ8ZdTU5exIh1mr0hmDqlrNkmjtW6iWGHG4x70FQigbqPbtAIsBdIwJrsOAWhMSCO8/kVarrqOij0B+HyLVt//XoU9YcYtijMiMmp6ibdtiINgfcwra528hWJF1hZgd5MOxB7C56x+XKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRzUmKTCi5FMuHi4oP6zMA75DNv6Nb7heTk6U5Tt3eI=;
 b=p3aEpQ//72LqISsgKdoIbBcRs8J1WZ06zDqB50YB8vG8EdXf034VpqDWPpDg0nWkuHF1tGVMZcuOdlc5lz6Q7vCU6rTbnEdTzQjBTRRX8vt/9sFKp/QmQuPHyPN4bx80bHFAlfTpsxh6vl4bVxPfZYvk1YtkzVeir4WQ8kMG9jA=
Received: from BN1PR10CA0028.namprd10.prod.outlook.com (2603:10b6:408:e0::33)
 by SJ0PR10MB5630.namprd10.prod.outlook.com (2603:10b6:a03:3d2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 13:39:44 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::c5) by BN1PR10CA0028.outlook.office365.com
 (2603:10b6:408:e0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 13:39:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 13:39:42 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 08:39:41 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 08:39:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 08:39:41 -0500
Received: from [172.24.233.62] (devarsh-precision-tower-3620.dhcp.ti.com
 [172.24.233.62])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62IDdavH909978;
 Wed, 18 Mar 2026 08:39:37 -0500
Message-ID: <db9c7a49-6e1b-4ddd-a4ca-721a2c1419cd@ti.com>
Date: Wed, 18 Mar 2026 19:09:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: sii902x: Add audio context to suspend/resume
 routine
To: Sen Wang <sen@ti.com>, <andrzej.hajda@intel.com>,
 <neil.armstrong@linaro.org>, <rfoss@kernel.org>, <airlied@gmail.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <dri-devel@lists.freedesktop.org>,
 <jani.nikula@intel.com>, <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>
CC: <tomi.valkeinen@ideasonboard.com>, <r-donadkar@ti.com>, <s-jain1@ti.com>
References: <20260211211018.149916-1-sen@ti.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20260211211018.149916-1-sen@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|SJ0PR10MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 4285f3e5-68b2-4328-2c1f-08de84f3cfac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: H3qnOm2HiRfd6dE7Sj7+i6PGSmfddwWF949E0awpRHuWZ6A7emQJpaYMPm6m12nf8vFfM0ggBE2/rjCRmHUtANfpPoUPJJ1MALJc7h3b4kwNp2YdO+Upq55Ken2bStM/+Q/0VEDC6HyWZEnJ7GhPmLWeun3OO57ZCloMLCqGTYbjoCuFhdovLrrhs2BDa0WfsOoJCauIDD99+1woAJA7iQOWV0QU3hyXLJd1+lhmGFEe+A2JhzJLurSC66yzdu7JyicvfaiUvYacKaqx1by3mK5K21p495CKQO3AiUwVS2q11OFk7Rv6l2xD9T1JoTALNypxzuOh6nNPIa2/6ENaR4vlQNuNLuH4+DmNbcnN9I93tHue2c0SPBXJexFKwHn1jX0DsVYcygCb2TzUIf8pRHRJjPG90ZNHdnsiWRw0WtFfgw+1tRK2JBDkJafVpSgsduapYywYimIOUB+i8xjKxRz/XGBTDSzMavYDGT0bF12qmfH03hWZGd5/o4qj7V5kZOOHP6pFX4CsZZjtOddZIps346w5O9VpupDj+GYIWU8F81nTbbLKIeDUuXDTlhKoz/g41Bb2ADaEDFjb6eqQPpq22lC1zu54Dj4BV4UeYETgcXuSIPHBljKivMEjYuqm3It4Qw25jbXyufSk6D6Nr6GLVYHfEoL0szwf8YTXf2H59C9l2G3ppNFLuFtnib0kt2fN77SKu9UK8ZK9+TeqyOM0FtBIc4wHYDdTCIOh8qDsfKfPwgERVcFMEbojbWL5POYPgdRthrVcEszAMaLZFdKI5Dx5Zleexufj5GQupFqIu7zCoKfX8dd3C9lnuVgP
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0ohrlAx/j/brx6lMLZ0+CNfGQe3ZlnWpMg7ZSQO8xTDS3TPeI+vO1ZfGCFhjOANpJRnFm2buQfCTA7mLl/CX+/kb5uC+wpGY317NjEu0b3x4+FFKzd+fhIojkl8PoN3cFs2jlXFqJIQHUdlCM/PecDaxo0xYfoNi60H9om+3+7RmLom73EASyAYeH1ScpPkzGek1pai6dgZ2m1EWtQiOQbf4A2WAifsAUUs7MjJ2+H3L4UEYzMl+tB8t4jOBdNYzRh367JzqPCJTyYR+G8TL1iFeiyNu91PvnDm4IjkGv0/IelHZn/LbpljnovYUFqKH91gafUE645tUTkM4oszzqLIDi7O0p2Q2W0elZdsbeP/kPUE2yeQpbsfKXKusmQmLwsLTSpyONAIPhShIoEXhYyDMOCbqdQTTeAQDdcrH3WccV9WGXZil439Am3Sz5BrX
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 13:39:42.8023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4285f3e5-68b2-4328-2c1f-08de84f3cfac
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5630
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

Hi Sen,

Thanks for the patch.

On 12/02/26 02:40, Sen Wang wrote:
> The sii902x driver has existing suspend/resume handlers that save and
> restore video-related register context (TPI mode and interrupts), but
> these handlers were not saving/restoring audio configuration registers.
> This caused HDMI audio to stop working after system suspend/resume cycles.
> 
> Therefore add audio-related register context to the existing
> suspend/resume handlers when audio context needs to be saved/restored. As
> well as mclk for the sake of power saving, in the case of sii902x being
> the frame producer.
> 
> The audio context is only saved/restored when audio.active is true,
> avoiding unnecessary register access when audio is not in use.
> 
> Tested on TI SK-AM62P-LP board with HDMI audio playback across multiple
> suspend/resume cycles.
> 
> Signed-off-by: Sen Wang <sen@ti.com>
> ---
>   drivers/gpu/drm/bridge/sii902x.c | 91 +++++++++++++++++++++++++++++++-
>   1 file changed, 90 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index 134657041799..fd38a6ae86b2 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -192,6 +192,13 @@ struct sii902x {
>   		struct platform_device *pdev;
>   		struct clk *mclk;
>   		u32 i2s_fifo_sequence[4];
> +		bool active;
> +		/* Audio register context for save/resume */
> +		unsigned int ctx_i2s_input_config;
> +		unsigned int ctx_audio_config_byte2;
> +		unsigned int ctx_audio_config_byte3;
> +		u8 ctx_i2s_stream_header[SII902X_TPI_I2S_STRM_HDR_SIZE];
> +		u8 ctx_audio_infoframe[SII902X_TPI_MISC_INFOFRAME_SIZE];
>   	} audio;
>   };
>   
> @@ -764,6 +771,8 @@ static int sii902x_audio_hw_params(struct device *dev, void *data,
>   	if (ret)
>   		goto out;
>   
> +	sii902x->audio.active = true;
> +
>   	dev_dbg(dev, "%s: hdmi audio enabled\n", __func__);
>   out:
>   	mutex_unlock(&sii902x->mutex);
> @@ -786,6 +795,8 @@ static void sii902x_audio_shutdown(struct device *dev, void *data)
>   	regmap_write(sii902x->regmap, SII902X_TPI_AUDIO_CONFIG_BYTE2_REG,
>   		     SII902X_TPI_AUDIO_INTERFACE_DISABLE);
>   
> +	sii902x->audio.active = false;
> +
>   	mutex_unlock(&sii902x->mutex);
>   
>   	clk_disable_unprepare(sii902x->audio.mclk);
> @@ -1081,7 +1092,7 @@ static int __maybe_unused sii902x_resume(struct device *dev)
>   {
>   	struct sii902x *sii902x = dev_get_drvdata(dev);
>   	unsigned int tpi_reg, status;
> -	int ret;
> +	int ret, i;
>   
>   	ret = regmap_read(sii902x->regmap, SII902X_REG_TPI_RQB, &tpi_reg);
>   	if (ret)
> @@ -1109,7 +1120,62 @@ static int __maybe_unused sii902x_resume(struct device *dev)
>   	regmap_read(sii902x->regmap, SII902X_INT_STATUS, &status);
>   	regmap_write(sii902x->regmap, SII902X_INT_STATUS, status);
>   
> +	/*
> +	 * Restore audio context if audio was active before suspend,
> +	 * in the matching order of sii902x_audio_hw_params()
> +	 * initialization
> +	 */
> +	if (sii902x->audio.active) {
> +		/* Re-enable mclk */
> +		ret = clk_prepare_enable(sii902x->audio.mclk);
> +		if (ret) {
> +			dev_err(dev, "Failed to re-enable mclk: %d\n", ret);
> +			return ret;
> +		}
> +
> +		ret = regmap_write(sii902x->regmap, SII902X_TPI_AUDIO_CONFIG_BYTE2_REG,
> +				   sii902x->audio.ctx_audio_config_byte2);
> +		if (ret)
> +			goto err_audio_resume;
> +
> +		ret = regmap_write(sii902x->regmap, SII902X_TPI_I2S_INPUT_CONFIG_REG,
> +				   sii902x->audio.ctx_i2s_input_config);
> +		if (ret)
> +			goto err_audio_resume;
> +
> +		for (i = 0; i < ARRAY_SIZE(sii902x->audio.i2s_fifo_sequence) &&
> +		     sii902x->audio.i2s_fifo_sequence[i]; i++) {
> +			ret = regmap_write(sii902x->regmap,
> +					   SII902X_TPI_I2S_ENABLE_MAPPING_REG,
> +					   sii902x->audio.i2s_fifo_sequence[i]);
> +			if (ret)
> +				goto err_audio_resume;
> +		}
> +
> +		ret = regmap_write(sii902x->regmap, SII902X_TPI_AUDIO_CONFIG_BYTE3_REG,
> +				   sii902x->audio.ctx_audio_config_byte3);
> +		if (ret)
> +			goto err_audio_resume;
> +
> +		ret = regmap_bulk_write(sii902x->regmap, SII902X_TPI_I2S_STRM_HDR_BASE,
> +					sii902x->audio.ctx_i2s_stream_header,
> +					SII902X_TPI_I2S_STRM_HDR_SIZE);
> +		if (ret)
> +			goto err_audio_resume;
> +
> +		ret = regmap_bulk_write(sii902x->regmap, SII902X_TPI_MISC_INFOFRAME_BASE,
> +					sii902x->audio.ctx_audio_infoframe,
> +					SII902X_TPI_MISC_INFOFRAME_SIZE);
> +		if (ret)
> +			goto err_audio_resume;
> +	}
> +
>   	return 0;
> +
> +err_audio_resume:
> +	clk_disable_unprepare(sii902x->audio.mclk);
> +	dev_err(dev, "Failed to restore audio registers: %d\n", ret);
> +	return ret;
>   }
>   
>   static int __maybe_unused sii902x_suspend(struct device *dev)
> @@ -1122,6 +1188,29 @@ static int __maybe_unused sii902x_suspend(struct device *dev)
>   	regmap_read(sii902x->regmap, SII902X_INT_ENABLE,
>   		    &sii902x->ctx_interrupt);
>   
> +	/*
> +	 * Save audio context if audio is active, and
> +	 * in the matching order of sii902x_audio_hw_params()
> +	 * initialization
> +	 */
> +	if (sii902x->audio.active) {
> +		regmap_read(sii902x->regmap, SII902X_TPI_AUDIO_CONFIG_BYTE2_REG,
> +			    &sii902x->audio.ctx_audio_config_byte2);
> +		regmap_read(sii902x->regmap, SII902X_TPI_I2S_INPUT_CONFIG_REG,
> +			    &sii902x->audio.ctx_i2s_input_config);
> +		regmap_read(sii902x->regmap, SII902X_TPI_AUDIO_CONFIG_BYTE3_REG,
> +			    &sii902x->audio.ctx_audio_config_byte3);
> +		regmap_bulk_read(sii902x->regmap, SII902X_TPI_I2S_STRM_HDR_BASE,
> +				 sii902x->audio.ctx_i2s_stream_header,
> +				 SII902X_TPI_I2S_STRM_HDR_SIZE);
> +		regmap_bulk_read(sii902x->regmap, SII902X_TPI_MISC_INFOFRAME_BASE,
> +				 sii902x->audio.ctx_audio_infoframe,
> +				 SII902X_TPI_MISC_INFOFRAME_SIZE);
> +


In resume path you were checking failure for each regmap_write I guess 
similar approach is needed here if going with register reads, so in case 
one or more regmap_read/regmap_bulk_read fails you can return error with 
dev_err message.

But I think even better approach would be to cache the corresponding reg 
values to corresponding struct members during hw_params callback itself 
given all the parameters being used sii902x->audio.ctx do not change 
between hw_params callback and suspend callback as all these params are 
stream related? , If so that would avoid costly i2c operations for 
reading register values which can be skipped in this function.

> +		/* Disable mclk during suspend */
> +		clk_disable_unprepare(sii902x->audio.mclk);
> +	}
> +


audio.active should be cleared here or do we need to call audio_shutdown 
explicitly?

Regards
Devarsh

