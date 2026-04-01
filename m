Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5182A10F6FB3
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 14:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9613910E1ED;
	Wed,  1 Apr 2026 14:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JKxXQoVO";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012034.outbound.protection.outlook.com
 [40.107.200.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E941110E1ED
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 14:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6PzEZ5mcM0/GxnxONq0I90eysStsvczfntRAxmxVfa4QBBYEeyf9lI1G0jJep0xkM/+WrVyBXe3vOVRAnSUuYkUI1Up+1sxoZ4MmogkjKqROvwQNsPB5TRGiND7JQssPt+pv5Nw1rCEiVvIBHiHav7s8CCc0c8b2NQ3UxySQPQzRGzLG6zY8r88ajxCyWTeHQ21qhh5ZaGUjkMpWEacP9m6PTEmQVhjulbQLegi0VZX12L539zGXQnHyegcdIWlcvdl0vLBisc/gpSG8Atcs0RM+yLmAiFrjh695qCxUSwacm2UxMdjtQ3QU0uU/YZlBI3xsWIu0576jdEC8c42Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wlc0yo0Ey0AzVyUL6VfrqYOHRiceYbzOEoDOQqMjIfE=;
 b=zC1QScEUmJk2DQooCkBeFoGdWeWUoaonPgdoR3/6KsD9xmB1eb1yC1Xg/EovnhmtpI4G0y6mLB0vUqU1hRpzY/o+V6zEzGrOjIIwtIZNogERBtdzAOaXXpLDR+d8kpTITgYKsnMrbnVd6SaZA8TIB0H2ZuopsakN2hQq7LCRifi3R8dJ2KhpglG7fpoZSo0q6agYNKaGdIAr5xISMeiIA1glLTJXILR9ATuxEN2WRIdl+yQIbsAYePbZFMARlOgNWlIu9G+dtvzocHj68funS1hwu5mQ2UYJeM7lfednl5yQgZiYLZaW5u3MBFRQAqSWfQr6vFEGZ0C+qCLlveiSkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wlc0yo0Ey0AzVyUL6VfrqYOHRiceYbzOEoDOQqMjIfE=;
 b=JKxXQoVOeSeurisBy0mpEvrsOZjZk6cbGV4Ud2ANNyLF/dZZyhwCLYmy07vl+rchCR2wNCZ164kOCSazDc5n05EKYeLsZ9TKGAB11CuiXmYNontgg7PzRuMhFuxy05CVjCN1E+W8ng1LXxvsgUJEaNqopaUsHHqRAdHWv1+q1XM=
Received: from CH2PR18CA0025.namprd18.prod.outlook.com (2603:10b6:610:4f::35)
 by DS7PR10MB5165.namprd10.prod.outlook.com (2603:10b6:5:297::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 14:43:00 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::8e) by CH2PR18CA0025.outlook.office365.com
 (2603:10b6:610:4f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.31 via Frontend Transport; Wed,
 1 Apr 2026 14:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:42:59 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 09:42:49 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 09:42:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 09:42:49 -0500
Received: from [172.24.233.62] (devarsh-precision-tower-3620.dhcp.ti.com
 [172.24.233.62])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 631EgjBR261255;
 Wed, 1 Apr 2026 09:42:45 -0500
Message-ID: <96444379-712c-4e21-8f3c-55eaad850cd4@ti.com>
Date: Wed, 1 Apr 2026 20:12:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: sii902x: Add Power Management hooks with
 audio context
To: Sen Wang <sen@ti.com>, Andrzej Hajda <andrzej.hajda@intel.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
CC: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Rahul
 Donadkar" <r-donadkar@ti.com>, Siddharth Jain <s-jain1@ti.com>
References: <20260401013758.4149091-1-sen@ti.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20260401013758.4149091-1-sen@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|DS7PR10MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e92d254-5c52-4bee-f4ee-08de8ffcf838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yPiMkK607BjyPL0/aDQY3TfqP7zLBO92j2w2PITpQu/SgAJbZBZZJKiVQ5j5B3sVLiXeCZsQ+oPE3H95vcWZGDb+/QRO4v1eN1t/xTGJ1bMMl3yy66IVMVkS9i7XlCwwE4QKglsJ2VnoKpjgbXrivtrflHKi4ZhfXpDUz+3o1TSOTnHVlVeqfucZNipRgQ+Iaunpqd/mmt3G0r5Q7X/4YSc556OtrRLLFm/b8iW1XjiHeGpgb/YQPZGofQ7R5XLrZ0orL0FKF4aQvq/6K8D1nim9xHhcJ/sq6Hf9eavJXiK1AFcfJyyv6G49SKmf6AQBWWZZrMUKefoy995lQJ+uQUQeVyxuiHOVtvC9VT5ktSlN4Ozj5oP7kFW0yrly/LiE3hU+A7iuq4XStUEJ3bGJjtrHWyo0MAx03ge4zZR9/6S3vgcGtjDp7z3OW6ljypbvpwj/KaG0IE40ezcRPv4Wr2YzsYyccVbYBdIzbF/RGidiqvO3NJleD7FrOjGlMqTX0AVCMblbBCzrwZcgh8NegQnYesXRe8PPlUFveckGNLHWTKUaGxcoCEvxWAo7Agbk3vWP/OzQ49PoKAw6g5ifyV9VhHbhx1EMGaLGcw274KLN/sunlrICUTN+PlIqYuhfHDKYpkTUbh/dIEflmApKzJBUi3x/uM9mpmmwtRYE+lEGldbop/ItbZXBsiV6Zn0HTUm6jF8grELZX/aTZ0IduEjKn+A3XFVXPGJ1a9Nuts4=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(13003099007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZpA3uAlGaYiv+L1lP5NnakijnvIjyMJXm8fA2NaQxQ1D6oC1kgqDHhYBr1sSvuwZJjaTQiytchkmZJAwTVG1d6O7Vh9AiX/NuHomD5GbTnihJDD0cIk84RmqWuOEycoX5htMhV25iyj/rVXBatoUoNACnQwj+jmmvnh4qfsboK4KvqwGU4/e4t2/9uNsmG9Go9/b+u3rk3bScKlkswSvUWksfr1ON6XnsiFmfjrn8tLDlWYW+sU8kLsmCuLIFd7k4IjwItsi6x3ixyn/gWecMwS+zI7Asum3Bk2lozRgLSRGbRrhxf8LqpB2rUTt/dbGvo2yIao3lowFgi6GRY2LhT5rtEIDu9XkKiEaZjNNZIu4jfhe63A+p/LrsWykkb5GDtST3VN2n9lpR5NjsJaoDsAwSnhcffSz4SKa0p1Mw7Gg5k0EKXv1PlH/Oq/vtsyC
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:42:59.1261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e92d254-5c52-4bee-f4ee-08de8ffcf838
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5165
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

On 01/04/26 07:07, Sen Wang wrote:

Sorry but this is not very clear, is this a V2 to 
https://lore.kernel.org/all/e6497541-f3e7-4533-a188-9d422cb34d74@ti.com/ ?

In that case, the subject should mention it as PATCH v2 along with 
changelog as documented in kernel patch guidelines : 
https://docs.kernel.org/process/submitting-patches.html

> Add suspend and resume hooks. On suspend, save TPI mode, interrupt
> enable, and audio register context (when active). On resume, detect
> power loss by comparing the saved TPI value; if changed, reset the
> device and restore TPI mode and interrupts. Restore audio registers
> and re-enable mclk if audio was active before suspend.
> 
> Audio register values are read back during suspend rather than cached
> during hw_params, as the sii902x requires a specific register write
> sequence during initialization that must be preserved on resume.
> 
> Based on initial PM hooks implementation by:
>    Aradhya Bhatia <a-bhatia1@ti.com>
>    Jayesh Choudhary <j-choudhary@ti.com>
> 
> Signed-off-by: Sen Wang <sen@ti.com>
> ---
> Tested on TI SK-AM62P-LP board with HDMI audio playback across multiple
> suspend/resume cycles.

Could you please also share the test logs ? Did you verify that both 
audio/video context resume back seamlessly afer resuming from system 
suspend ?

I guess this still does not support runtime suspend/resume ?

And assuming this is v2, here you should mention changelog and v1 link:
V1: https://lore.kernel.org/all/e6497541-f3e7-4533-a188-9d422cb34d74@ti.com/
> 
>   drivers/gpu/drm/bridge/sii902x.c | 165 +++++++++++++++++++++++++++++++
>   1 file changed, 165 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index 12497f5ce4ff..8da8ca22ac99 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -179,6 +179,8 @@ struct sii902x {
>   	struct gpio_desc *reset_gpio;
>   	struct i2c_mux_core *i2cmux;
>   	u32 bus_width;
> +	unsigned int ctx_tpi;
> +	unsigned int ctx_interrupt;
>   
>   	/*
>   	 * Mutex protects audio and video functions from interfering
> @@ -189,6 +191,13 @@ struct sii902x {
>   		struct platform_device *pdev;
>   		struct clk *mclk;
>   		u32 i2s_fifo_sequence[4];
> +		bool active;
> +		/* Audio register context for suspend/resume */
> +		unsigned int ctx_i2s_input_config;
> +		unsigned int ctx_audio_config_byte2;
> +		unsigned int ctx_audio_config_byte3;
> +		u8 ctx_i2s_stream_header[SII902X_TPI_I2S_STRM_HDR_SIZE];
> +		u8 ctx_audio_infoframe[SII902X_TPI_MISC_INFOFRAME_SIZE];
>   	} audio;
>   };
>   
> @@ -755,6 +764,8 @@ static int sii902x_audio_hw_params(struct device *dev, void *data,
>   	if (ret)
>   		goto out;
>   
> +	sii902x->audio.active = true;
> +
>   	dev_dbg(dev, "%s: hdmi audio enabled\n", __func__);
>   out:
>   	mutex_unlock(&sii902x->mutex);
> @@ -777,6 +788,8 @@ static void sii902x_audio_shutdown(struct device *dev, void *data)
>   	regmap_write(sii902x->regmap, SII902X_TPI_AUDIO_CONFIG_BYTE2_REG,
>   		     SII902X_TPI_AUDIO_INTERFACE_DISABLE);
>   
> +	sii902x->audio.active = false;
> +
>   	mutex_unlock(&sii902x->mutex);
>   
>   	clk_disable_unprepare(sii902x->audio.mclk);
> @@ -1069,6 +1082,157 @@ static const struct drm_bridge_timings default_sii902x_timings = {
>   		 | DRM_BUS_FLAG_DE_HIGH,
>   };
>   
> +static int sii902x_resume(struct device *dev)
> +{
> +	struct sii902x *sii902x = dev_get_drvdata(dev);
> +	unsigned int tpi_reg, status;
> +	int ret, i;
> +
> +	ret = regmap_read(sii902x->regmap, SII902X_REG_TPI_RQB, &tpi_reg);
> +	if (ret)
> +		return ret;
> +
> +	if (tpi_reg != sii902x->ctx_tpi) {
> +		/*
> +		 * TPI register context has changed. SII902X power supply
> +		 * device has been turned off and on.
> +		 */
> +		sii902x_reset(sii902x);
> +
> +		/* Configure the device to enter TPI mode. */
> +		ret = regmap_write(sii902x->regmap, SII902X_REG_TPI_RQB, 0x0);
> +		if (ret)
> +			return ret;
> +
> +		/* Re-enable the interrupts */
> +		regmap_write(sii902x->regmap, SII902X_INT_ENABLE,
> +			     sii902x->ctx_interrupt);
> +	}
> +
> +	/* Clear all pending interrupts */
> +	regmap_read(sii902x->regmap, SII902X_INT_STATUS, &status);
> +	regmap_write(sii902x->regmap, SII902X_INT_STATUS, status);
> +
> +	/*
> +	 * Restore audio context if audio was active before suspend,
> +	 * in the matching order of sii902x_audio_hw_params() initialization.
> +	 */
> +	if (sii902x->audio.active) {

audio.active should be protected with mutex lock as done elsewhere in 
the driver?

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

Do we need to restore the indirect registers status too with the 
constants that were used ?

/* Decode Level 0 Packets */ 

regmap_write(regmap, SII902X_IND_SET_PAGE, 0x02);  /* 0xBC */ 

regmap_write(regmap, SII902X_IND_OFFSET,  0x24);  /* 0xBD */ 

regmap_write(regmap, SII902X_IND_VALUE,   0x02);  /* 0xBE */ 

```

> +	return 0;
> +
> +err_audio_resume:
> +	clk_disable_unprepare(sii902x->audio.mclk);
> +	dev_err(dev, "Failed to restore audio registers: %d\n", ret);
> +	return ret;
> +}
> +
> +static int sii902x_suspend(struct device *dev)
> +{
> +	struct sii902x *sii902x = dev_get_drvdata(dev);
> +	int ret;
> +

Have you reviewed Table 3.8 of the datasheet ?

I think we should probably be utilizing different operating modes during 
suspend/resume cycles.

For e.g. with system suspend go to D3 cold state which is absolute 
minimum power.

For runtime suspend thought, have to be little careful as the D state 
should be chosen such that it does not have a too high resume latency.
If D3 doesn't have too high then probably use the same else use D2.

> +	ret = regmap_read(sii902x->regmap, SII902X_REG_TPI_RQB,
> +			  &sii902x->ctx_tpi);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(sii902x->regmap, SII902X_INT_ENABLE,
> +			  &sii902x->ctx_interrupt);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Save audio context if audio is active, in the matching order
> +	 * of sii902x_audio_hw_params() initialization.
> +	 */
> +	if (sii902x->audio.active) {

Here too, I think mutex protection required while accessing this flag.

> +		ret = regmap_read(sii902x->regmap, SII902X_TPI_AUDIO_CONFIG_BYTE2_REG,
> +				  &sii902x->audio.ctx_audio_config_byte2);
> +		if (ret)
> +			goto err_audio_suspend;
> +
> +		ret = regmap_read(sii902x->regmap, SII902X_TPI_I2S_INPUT_CONFIG_REG,
> +				  &sii902x->audio.ctx_i2s_input_config);
> +		if (ret)
> +			goto err_audio_suspend;
> +
> +		ret = regmap_read(sii902x->regmap, SII902X_TPI_AUDIO_CONFIG_BYTE3_REG,
> +				  &sii902x->audio.ctx_audio_config_byte3);
> +		if (ret)
> +			goto err_audio_suspend;
> +
> +		ret = regmap_bulk_read(sii902x->regmap, SII902X_TPI_I2S_STRM_HDR_BASE,
> +				       sii902x->audio.ctx_i2s_stream_header,
> +				       SII902X_TPI_I2S_STRM_HDR_SIZE);
> +		if (ret)
> +			goto err_audio_suspend;
> +
> +		ret = regmap_bulk_read(sii902x->regmap, SII902X_TPI_MISC_INFOFRAME_BASE,
> +				       sii902x->audio.ctx_audio_infoframe,
> +				       SII902X_TPI_MISC_INFOFRAME_SIZE);
> +		if (ret)
> +			goto err_audio_suspend;
> +

In the previous revision, my comment was to skip  register reads for 
restoring the context and instead populate the context in hw_params itself :

something as below :
@@ -710,18 +717,36 @@ static int sii902x_audio_hw_params(struct device 
*dev, void *data,
         ret = regmap_write(sii902x->regmap, 

                            SII902X_TPI_AUDIO_CONFIG_BYTE2_REG, 

                            config_byte2_reg); 

-       if (ret < 0) 

+       if (ret < 0) 

                 goto out; 

+       sii902x->audio.ctx_audio_config_byte2 = config_byte2_reg; 

  

         ret = regmap_write(sii902x->regmap, 
SII902X_TPI_I2S_INPUT_CONFIG_REG,
                            i2s_config_reg); 

         if (ret) 

                 goto out; 

+       sii902x->audio.ctx_i2s_input_config = i2s_config_reg; 

  

         for (i = 0; i < ARRAY_SIZE(sii902x->audio.i2s_fifo_sequence) && 

                     sii902x->audio.i2s_fifo_sequence[i]; i++) 

                 regmap_write(sii902x->regmap, 

                              SII902X_TPI_I2S_ENABLE_MAPPING_REG,

and likewise and then you don't have to do reg reads in resume back

> +		/*
> +		 * audio.active is kept true so that resume restores the audio
> +		 * context. sii902x_audio_shutdown() clears it when the stream
> +		 * is explicitly closed.
> +		 */
> +		clk_disable_unprepare(sii902x->audio.mclk);
> +	}
> +
> +	return 0;
> +
> +err_audio_suspend:
> +	dev_err(dev, "Failed to save audio context: %d\n", ret);
> +	return ret;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(sii902x_pm_ops, sii902x_suspend, sii902x_resume);
> +

Can we add runtime suspend/resume hooks too ?

>   static int sii902x_init(struct sii902x *sii902x)
>   {
>   	struct device *dev = &sii902x->i2c->dev;
> @@ -1247,6 +1411,7 @@ static struct i2c_driver sii902x_driver = {
>   	.remove = sii902x_remove,
>   	.driver = {
>   		.name = "sii902x",
> +		.pm = pm_sleep_ptr(&sii902x_pm_ops),
>   		.of_match_table = sii902x_dt_ids,
>   	},
>   	.id_table = sii902x_i2c_ids,

Regards
Devarsh
