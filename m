Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715A5107760E
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6A4510E79F;
	Wed, 18 Mar 2026 19:35:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OgtMdajj";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010015.outbound.protection.outlook.com
 [40.93.198.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4772910E771
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 19:35:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FwCC2cJHebG1aWDtI74Cxix2bM/PtsmYVDEWDWM4A8PM5HTDp/7adcPdGK1lM2a5ZZB92U47HH1ISqNTe2uquDZfYXUCuCcT9xd/BZIOiKT3jnrpEpHeEvpj5CLtGXGP75QgGDbF8hyn1HWI6/Inz2otpdKFolBa+nzTdUATdR9ZkT9Oo6aRLLZ/XdBhbOFv0LSDvBbaogfDnJghszYYQrT1vvDTzNg8SX00WcNehd/R3X20P9aDXGlepM8OEFmuTITQJ/duDAIZOO1EKA0OPgVNAVsHzVD1vLOoaMNtVAK6VizAabb18mm7Rhv4SQs4oKycCcK9/SaIuuR/f8AYew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bZReghmC4KXB97a/VHVPiUZshAiQOuYEOdn2rsYVAU=;
 b=xC8WAhXUtyzuHsFyByB+jOoGGaOLSoEF2rNfOLQy7fY7rW1GGgw3BCKYk4lDFVMy1v9CGO9+pfB9OQ4l7c8pnNYv9xFEABjF1rhLcfn2LT8iDCdXYVxCok4nO153m6sFEzLr62X4oSfkdJI4f0HqPfacdvpdDHb4Y9IrBTs/qmS6ctd8NkXIDkHMYN8rZQWQ8dHF3re0oN4EnZv84gaqeyNEcWVoYaE4urah5QH6E5WoM7nwfI1I9Kn1GDoTIvwB2ibFUZ0AyvM/UacyAqg4Y8MPYVrHLdY+ED1UZGvZ4jFZo6ZQbFSYxD9POT7iV98rxx3ibr2MfxBD0Q5CA5xDTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bZReghmC4KXB97a/VHVPiUZshAiQOuYEOdn2rsYVAU=;
 b=OgtMdajj7UW8eHBTdtYB3GbzVkQ+sNVIkbaspH3nX1Gmcwbh4/5b57Whur9Lg1Zcu4xi8JPSM4/geypd9Qt5LLtZOpydUCP9WTGkBgedR5LWaGA75eWNgD4SDfp0NnWotNP3aXkx9e8ulIC73s2gqP/McPdbC9hLe+GrXO9rI+0=
Received: from SJ0PR13CA0014.namprd13.prod.outlook.com (2603:10b6:a03:2c0::19)
 by SJ5PPF4D4E723EA.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::79f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 19:35:35 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::e5) by SJ0PR13CA0014.outlook.office365.com
 (2603:10b6:a03:2c0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Wed,
 18 Mar 2026 19:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 19:35:35 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 14:35:34 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 14:35:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 14:35:33 -0500
Received: from [128.247.81.183] (ltpf5gwk6l.dhcp.ti.com [128.247.81.183] (may
 be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62IJZX07880362;
 Wed, 18 Mar 2026 14:35:33 -0500
Message-ID: <e6497541-f3e7-4533-a188-9d422cb34d74@ti.com>
Date: Wed, 18 Mar 2026 14:35:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: sii902x: Add audio context to suspend/resume
 routine
To: "Thakkar, Devarsh" <devarsht@ti.com>, "andrzej.hajda@intel.com"
 <andrzej.hajda@intel.com>, "neil.armstrong@linaro.org"
 <neil.armstrong@linaro.org>, "rfoss@kernel.org" <rfoss@kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "jani.nikula@intel.com" <jani.nikula@intel.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
CC: "Donadkar, Rishikesh" <r-donadkar@ti.com>, "Jain, Swamil" <s-jain1@ti.com>
References: <20260211211018.149916-1-sen@ti.com>
 <db9c7a49-6e1b-4ddd-a4ca-721a2c1419cd@ti.com>
Content-Language: en-US
From: "Wang, Sen" <sen@ti.com>
In-Reply-To: <db9c7a49-6e1b-4ddd-a4ca-721a2c1419cd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|SJ5PPF4D4E723EA:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e876e5-e951-4b73-d77d-08de852586da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3ty0pO6gRrMqA2BBaoCyzDX8xOneuodkLGqIwMvKW0WMXu9VHspEYsmz/rwEzPRbndZM5f4sCVQvccto/Vhw+MfD3wWtVD0i3m7IRMM03vkuwXRghP7l4xR0jNB4qnLaI5+KeKR/K12bL71F7C1UESYvICI8fax60g9Z2l8hTrlmpQ8KpdCgMneua+au+xbDbwpalKaKkGtWGBZR2NNc0P3A3Hwl2yjUJiKauy6FF+9ZYwYqU2XIwNXLm4K0lS6CJ9ICvnXs8VbI4BmK365pY16XgOcXSdYrkUPzZXxoQgfubwVV1zO8zfI7Haeg0J5C5Z+5qNnjEXnFm4DYXQcDDMYOmm5KnOMHnlWSUOgv6SqoLoO1urumRFAIMWfRYCiQmDvwv+C5D5M5x/5qUSV30mBwCyrQVEv0MG5Z5aKy2DEADWBtUielHNe7Oxe6xprlgp0LvlEut3tpMmw67H1p2s0HW0hDJcaV6gJHrpj5+3C0OBo4QSXH5rAqQ1zJE3LfFQn8zWdol1ccEpLZM7PkhS6/QX+TQAiQcIoLoZQpQW75A1OF5DNHvbTK3soOPSXvTXauvDfc2ZQnYzye/uKb1dlWW3WfFooODGW4y6jOlOHZxALtDeJchCNCUmMxydzHDy4OZLk/NF7LTCTWLZajurS3swZxcG853YF2rV6i0An7tsTB8IvjeRzr+Gi55Ta2dDAi5poGnzACcW7vNLDczOsMudhHdZvH1JV5axuRAEdEzOOBWdjXRxcJF9r+QHMeq8EMzf8Xc9leF93FGhoXo10QUkDIfvpIhEN0XnRf43W/sY81774CZyQ7Mehf8sPE
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pg63bBtWBHAsFgpA5k/+Ay/vPV3FVZEGXpuemoTsgjHYRHiZKjBb2MiBmjlOQRcxVvMLPCya2YdibYPxWFUk5O24oDyoiCsZHFDHUQudbShr+nxqlk28ggFwndDCCZ/z0vG3AXt7xq8KexlFibXCua8Rhi2tXjMcwARVd3UL3l+YrXWPueNcEzuJejR6kvDgvZ40PgvLgESLxQOuGYaSfvp2AnwWT6fsLjHIAIWjI/qLpBkKyyJp3d9TyPTkKvtE5R2LZbCWBJw/O/WxKonHkOhClAjhirviVyLpEQvXV7WYP83Dbtj3If+yztuPoPXzYypELXrVcDO0GovX1/F+xR01/asvLf2jTU7iI8BtJgtGNd8gaBkmPGTEELSi6R5hadiP4hRhKsXPFub0zzT4kr8Va+3Nci5UV+c+Mi0ES+oUlY3uzvN/1heWGdyRH4/3
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 19:35:35.4729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e876e5-e951-4b73-d77d-08de852586da
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4D4E723EA
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

Hi Devarsh,

Thanks for the review.

On 3/18/2026 8:39 AM, Thakkar, Devarsh wrote:
> Hi Sen,
> 
> Thanks for the patch.
> 
> On 12/02/26 02:40, Sen Wang wrote:
>> The sii902x driver has existing suspend/resume handlers that save and
>> restore video-related register context (TPI mode and interrupts), but
>> these handlers were not saving/restoring audio configuration registers.
>> This caused HDMI audio to stop working after system suspend/resume cycles.
>>
>> Therefore add audio-related register context to the existing
>> suspend/resume handlers when audio context needs to be saved/restored. As
>> well as mclk for the sake of power saving, in the case of sii902x being
>> the frame producer.
>>
>> The audio context is only saved/restored when audio.active is true,
>> avoiding unnecessary register access when audio is not in use.
>>
>> Tested on TI SK-AM62P-LP board with HDMI audio playback across multiple
>> suspend/resume cycles.
>>
>> Signed-off-by: Sen Wang <sen@ti.com>
>> ---
>>    drivers/gpu/drm/bridge/sii902x.c | 91 +++++++++++++++++++++++++++++++-
>>    1 file changed, 90 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
>> index 134657041799..fd38a6ae86b2 100644
>> --- a/drivers/gpu/drm/bridge/sii902x.c
>> +++ b/drivers/gpu/drm/bridge/sii902x.c
>> @@ -192,6 +192,13 @@ struct sii902x {
>>    		struct platform_device *pdev;
>>    		struct clk *mclk;
>>    		u32 i2s_fifo_sequence[4];
>> +		bool active;
>> +		/* Audio register context for save/resume */
>> +		unsigned int ctx_i2s_input_config;
>> +		unsigned int ctx_audio_config_byte2;
>> +		unsigned int ctx_audio_config_byte3;
>> +		u8 ctx_i2s_stream_header[SII902X_TPI_I2S_STRM_HDR_SIZE];
>> +		u8 ctx_audio_infoframe[SII902X_TPI_MISC_INFOFRAME_SIZE];
>>    	} audio;
>>    };
>>    
>> @@ -764,6 +771,8 @@ static int sii902x_audio_hw_params(struct device *dev, void *data,
>>    	if (ret)
>>    		goto out;
>>    
>> +	sii902x->audio.active = true;
>> +
>>    	dev_dbg(dev, "%s: hdmi audio enabled\n", __func__);
>>    out:
>>    	mutex_unlock(&sii902x->mutex);
>> @@ -786,6 +795,8 @@ static void sii902x_audio_shutdown(struct device *dev, void *data)
>>    	regmap_write(sii902x->regmap, SII902X_TPI_AUDIO_CONFIG_BYTE2_REG,
>>    		     SII902X_TPI_AUDIO_INTERFACE_DISABLE);
>>    
>> +	sii902x->audio.active = false;
>> +
>>    	mutex_unlock(&sii902x->mutex);
>>    
>>    	clk_disable_unprepare(sii902x->audio.mclk);
>> @@ -1081,7 +1092,7 @@ static int __maybe_unused sii902x_resume(struct device *dev)
>>    {
>>    	struct sii902x *sii902x = dev_get_drvdata(dev);
>>    	unsigned int tpi_reg, status;
>> -	int ret;
>> +	int ret, i;
>>    
>>    	ret = regmap_read(sii902x->regmap, SII902X_REG_TPI_RQB, &tpi_reg);
>>    	if (ret)
>> @@ -1109,7 +1120,62 @@ static int __maybe_unused sii902x_resume(struct device *dev)
>>    	regmap_read(sii902x->regmap, SII902X_INT_STATUS, &status);
>>    	regmap_write(sii902x->regmap, SII902X_INT_STATUS, status);
>>    
>> +	/*
>> +	 * Restore audio context if audio was active before suspend,
>> +	 * in the matching order of sii902x_audio_hw_params()
>> +	 * initialization
>> +	 */
>> +	if (sii902x->audio.active) {
>> +		/* Re-enable mclk */
>> +		ret = clk_prepare_enable(sii902x->audio.mclk);
>> +		if (ret) {
>> +			dev_err(dev, "Failed to re-enable mclk: %d\n", ret);
>> +			return ret;
>> +		}
>> +
>> +		ret = regmap_write(sii902x->regmap, SII902X_TPI_AUDIO_CONFIG_BYTE2_REG,
>> +				   sii902x->audio.ctx_audio_config_byte2);
>> +		if (ret)
>> +			goto err_audio_resume;
>> +
>> +		ret = regmap_write(sii902x->regmap, SII902X_TPI_I2S_INPUT_CONFIG_REG,
>> +				   sii902x->audio.ctx_i2s_input_config);
>> +		if (ret)
>> +			goto err_audio_resume;
>> +
>> +		for (i = 0; i < ARRAY_SIZE(sii902x->audio.i2s_fifo_sequence) &&
>> +		     sii902x->audio.i2s_fifo_sequence[i]; i++) {
>> +			ret = regmap_write(sii902x->regmap,
>> +					   SII902X_TPI_I2S_ENABLE_MAPPING_REG,
>> +					   sii902x->audio.i2s_fifo_sequence[i]);
>> +			if (ret)
>> +				goto err_audio_resume;
>> +		}
>> +
>> +		ret = regmap_write(sii902x->regmap, SII902X_TPI_AUDIO_CONFIG_BYTE3_REG,
>> +				   sii902x->audio.ctx_audio_config_byte3);
>> +		if (ret)
>> +			goto err_audio_resume;
>> +
>> +		ret = regmap_bulk_write(sii902x->regmap, SII902X_TPI_I2S_STRM_HDR_BASE,
>> +					sii902x->audio.ctx_i2s_stream_header,
>> +					SII902X_TPI_I2S_STRM_HDR_SIZE);
>> +		if (ret)
>> +			goto err_audio_resume;
>> +
>> +		ret = regmap_bulk_write(sii902x->regmap, SII902X_TPI_MISC_INFOFRAME_BASE,
>> +					sii902x->audio.ctx_audio_infoframe,
>> +					SII902X_TPI_MISC_INFOFRAME_SIZE);
>> +		if (ret)
>> +			goto err_audio_resume;
>> +	}
>> +
>>    	return 0;
>> +
>> +err_audio_resume:
>> +	clk_disable_unprepare(sii902x->audio.mclk);
>> +	dev_err(dev, "Failed to restore audio registers: %d\n", ret);
>> +	return ret;
>>    }
>>    
>>    static int __maybe_unused sii902x_suspend(struct device *dev)
>> @@ -1122,6 +1188,29 @@ static int __maybe_unused sii902x_suspend(struct device *dev)
>>    	regmap_read(sii902x->regmap, SII902X_INT_ENABLE,
>>    		    &sii902x->ctx_interrupt);
>>    
>> +	/*
>> +	 * Save audio context if audio is active, and
>> +	 * in the matching order of sii902x_audio_hw_params()
>> +	 * initialization
>> +	 */
>> +	if (sii902x->audio.active) {
>> +		regmap_read(sii902x->regmap, SII902X_TPI_AUDIO_CONFIG_BYTE2_REG,
>> +			    &sii902x->audio.ctx_audio_config_byte2);
>> +		regmap_read(sii902x->regmap, SII902X_TPI_I2S_INPUT_CONFIG_REG,
>> +			    &sii902x->audio.ctx_i2s_input_config);
>> +		regmap_read(sii902x->regmap, SII902X_TPI_AUDIO_CONFIG_BYTE3_REG,
>> +			    &sii902x->audio.ctx_audio_config_byte3);
>> +		regmap_bulk_read(sii902x->regmap, SII902X_TPI_I2S_STRM_HDR_BASE,
>> +				 sii902x->audio.ctx_i2s_stream_header,
>> +				 SII902X_TPI_I2S_STRM_HDR_SIZE);
>> +		regmap_bulk_read(sii902x->regmap, SII902X_TPI_MISC_INFOFRAME_BASE,
>> +				 sii902x->audio.ctx_audio_infoframe,
>> +				 SII902X_TPI_MISC_INFOFRAME_SIZE);
>> +
> 
> 
> In resume path you were checking failure for each regmap_write I guess
> similar approach is needed here if going with register reads, so in case
> one or more regmap_read/regmap_bulk_read fails you can return error with
> dev_err message.
> 

Okay sounds good, I'll add that precaution checks as well.

> But I think even better approach would be to cache the corresponding reg
> values to corresponding struct members during hw_params callback itself
> given all the parameters being used sii902x->audio.ctx do not change
> between hw_params callback and suspend callback as all these params are
> stream related? , If so that would avoid costly i2c operations for
> reading register values which can be skipped in this function.
> 

I tried using regcache on the context save/restore, but there is 
definitely some state machine write sequence that I'm struggling to 
isolate. The moment I changed the flow from the init route, context 
save/restore no longer works.

The driver is definitely too scuffed to go through this kind of major 
revision if we wanted to incorporate regcache. So unfortunately this is 
the second best option to consider.

>> +		/* Disable mclk during suspend */
>> +		clk_disable_unprepare(sii902x->audio.mclk);
>> +	}
>> +
> 
> 
> audio.active should be cleared here or do we need to call audio_shutdown
> explicitly?
> 
This is a bad wording on my part, audio.active indicates an active 
stream. Stream status should be preserved and resumes playback on
context restore.

Also my apologies on sending an incomplete patch, looks like there's
a prerequisite patch sitting in vendor kernel that was never upstreamed.
Will clean it up and send a new patch altogether.

Best,
Sen Wang

> Regards
> Devarsh
> 

