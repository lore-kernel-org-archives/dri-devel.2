Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAB61112243
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 23:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E615A10ED79;
	Wed,  1 Apr 2026 23:33:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XMwVn2b/";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011069.outbound.protection.outlook.com [52.101.57.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFAD610ED79
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 23:33:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlOtnZUgM6gWXBjtHpBEgsUoS6FrdwhihidfzUzATFbxLU9kxqT3aDw8xndeIj7lSVetreiKySKnWEO0M/t/PSNes7WMfhbgKDhoGnwyeP1h89CmI1puI4vqLRedM2cjd1ALPv+59YbtSoxIAGGf6uMZkSSh3FdyaqN6pn5GJCPy9edX6QxwPC/3b+mgtHF0Obd7hyTp0XrKYb2O/bV5wm6ArfATvT9OoS6AImQr16EG7LdP305XeP/ffxFFUT1/irJh7bIRLU/t5xbGq1F7XZXXvuhTYbHkdEctZhWAT0kNridpdo1iofjHYmBtJ84DzbmlpbCBX3wV9Z2vEN5w1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eK6eC4KiOeqVmcfG6iGgdEvhNIpcYBymhO/vehG9B3g=;
 b=vv1DdQ/CfE6RYCdqm14fDWd2tixMgoOq3TncUD+b543SYOM/bLix81j2bSUkbJ6fc6kZSnZ594PSv0NzI4ecD2o10ybiDnfscs5N2yoGie6EC/lP9zNf2X8LBH6dH0/3szwhdZr2xj72RrxZJWvD42j0KZcXGOfwDKIrZajccSWC3wNKZBGedT5iQE1YfbzBxAs8TD5/PgqywrFgHNX2MkpSwjsXmi8AJ77Zn1TgxOyfpTxGMr0N6xwfcGgNdcNemPI3rjGveAXA4IF/PsifSsqbwEoyYOiJ88naywqYDZR8sSJCXYEwHOTg7TyeMpbcZ1VJ0oWtpLjc1/kdnO7bhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eK6eC4KiOeqVmcfG6iGgdEvhNIpcYBymhO/vehG9B3g=;
 b=XMwVn2b/XLciAt2qPUT0YbUGkw5eDRmIp+hDOGiB6AQA71xbf4Amy+nbODzGthbXgswtic02HRXPbovGFIQ3CwgG+MdsIM7u2c3Syg8BmlpT1knxb8fSDB2fgmLOVXpAV9s7n50AmRN65JTgu9tJ/zOL1o/b5DRkfxK3K0kTQGk=
Received: from DS7PR05CA0081.namprd05.prod.outlook.com (2603:10b6:8:57::6) by
 PH0PR10MB6433.namprd10.prod.outlook.com (2603:10b6:510:21c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 23:33:21 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::25) by DS7PR05CA0081.outlook.office365.com
 (2603:10b6:8:57::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17 via Frontend Transport; Wed,
 1 Apr 2026 23:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 23:33:20 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 18:33:19 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 18:33:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 18:33:18 -0500
Received: from [128.247.81.246] (mz02jj9v.dhcp.ti.com [128.247.81.246])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 631NXIOM954717;
 Wed, 1 Apr 2026 18:33:18 -0500
Message-ID: <09d3cf4d-ecb3-444a-8e88-7d51599007fe@ti.com>
Date: Wed, 1 Apr 2026 18:33:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: sii902x: Add Power Management hooks with
 audio context
To: "Thakkar, Devarsh" <devarsht@ti.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>
CC: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Donadkar,
 Rishikesh" <r-donadkar@ti.com>, "Jain, Swamil" <s-jain1@ti.com>
References: <20260401013758.4149091-1-sen@ti.com>
 <96444379-712c-4e21-8f3c-55eaad850cd4@ti.com>
Content-Language: en-US
From: Sen Wang <sen@ti.com>
In-Reply-To: <96444379-712c-4e21-8f3c-55eaad850cd4@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|PH0PR10MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6c7887-1550-42ae-8ef5-08de90470efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|13003099007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: A70kMJjtMX89bXdjeuT8kqu/kFW3J1pkche0JDi9OhksAUvNfJ8T5S2b+L8YtF/ol1U/hQsW7jF9xf5C8ubX/1Y0G8rUyV4EWDpWEAhweiZCOV8VDFhBRfWDzh1KFQyouKoVlmMMJzmeuOh3ibFDbwcX7PMzMHCDFzua5yhzrJ8iY7rktD3o4sp2bcnshRFaMt/OxOnuRB5nj1ANcnusMgDbWo1pUFTDOth96WzHkg9REULoGwyrQjJhXnunURs/HdPT0SfWQaoGePTQ9U8XcGaxGH3GJBB4dIyk4vxwJBtDe+jS0q+cn9FcDzGCFL1OQbQKkLTF1JMKM2ATYiJyNoH2qISb5amD6xggSwUbsy3jm5PAel+/O6yRFNieNfDD+zmiXB0j+OuzO8HjWCDb7ZeZrrGL7fGwjWqE4eZFghOIn9cee0f4B7xANYGyXdl5IpCLlX+RkAM1+s1jtuRM7dXWGJGY31oGFrvbSBdPqi99++n9jzJ2O/MEL40mFrrclHjZCmHAvjlVYvv4LNW/cU83ZyeGnnL92OJLC40dsTF4slpoNe6WbwjcZq0rRgjLUNuKAXPI9ogZXV4x56Q28aMqdOqtvbejJxy1L1qjb1PEQXsXYOaQYpaE1g4TRBTSHpL0fy8ZTccNYzQcyrToksSqNfnmL7sF3Q9oA9Ao/ChlhwCGZ7kxZX09CvO6uUj5UBw3nfQ0fsdW9A/2GUbbKCaoNivNFq4tu1h1/2Ibewg=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(13003099007)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n2p2XzidpVKb4E3umQoqt/VSKUm9MAG4p5PYm9z6pnn348IHkZ9oVyTicte5la1N0n9KrJt1oFvq21cNNT/kydhqxlE9vXU6k+BiujW3If1Tloz59QPzOyjpX1VivkTqnC/g+EGHawu4W74IAmbF1EN3EDaxGVehyphdRRjc6d8IrqBE3b8whnsxkg7rRq6sUMfE927SMls6tVwWE5yh6mXPzbYu6zvvGo1/kL+Nvr9OqRIzlprFatigAlW+yEJn1wjeqsROXFDuS/nF9AkbmaMhm5bnW3l7At/sE7BHSw42u/rAB/u4maCFew+knf973Ty/ZPR7CgLC1FgscceJOkGySvZrMCHtgtbmAD+wumc+FB/Bl6/7Ut4fcIv74OsF/wDrZcErOfhHJz/bOlcpzFy1cAkT86VTNetq6eRK3uB4onu0G8V75duUXxXbfV8E
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 23:33:20.0697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6c7887-1550-42ae-8ef5-08de90470efd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6433
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

On 4/1/26 09:42, Thakkar, Devarsh wrote:
> Hi Sen,
> 
> On 01/04/26 07:07, Sen Wang wrote:
> 
> Sorry but this is not very clear, is this a V2 to
> https://lore.kernel.org/all/e6497541-f3e7-4533-a188-9d422cb34d74@ti.com/ ?
> 
> In that case, the subject should mention it as PATCH v2 along with
> changelog as documented in kernel patch guidelines :
> https://docs.kernel.org/process/submitting-patches.html
> 
Hi Devarsh, Thanks for your review.

This new patch encompasses more features than the previous patch to
warrant it being a separate patch. But nonetheless my apologies for
not stating the indirection in my commit message.

>> Add suspend and resume hooks. On suspend, save TPI mode, interrupt
>> enable, and audio register context (when active). On resume, detect
>> power loss by comparing the saved TPI value; if changed, reset the
>> device and restore TPI mode and interrupts. Restore audio registers
>> and re-enable mclk if audio was active before suspend.
>>
>> Audio register values are read back during suspend rather than cached
>> during hw_params, as the sii902x requires a specific register write
>> sequence during initialization that must be preserved on resume.
>>
>> Based on initial PM hooks implementation by:
>>     Aradhya Bhatia <a-bhatia1@ti.com>
>>     Jayesh Choudhary <j-choudhary@ti.com>
>>
>> Signed-off-by: Sen Wang <sen@ti.com>
>> ---
>> Tested on TI SK-AM62P-LP board with HDMI audio playback across multiple
>> suspend/resume cycles.
> 
> Could you please also share the test logs ? Did you verify that both
> audio/video context resume back seamlessly afer resuming from system
> suspend ?
> 

Okay I'll attach it to the commit message for v2 patch.

> I guess this still does not support runtime suspend/resume ?
> 
No it doesn't, I don't know if full suspend/resume is necessarily the 
correct solution for runtime as well, besides there's also ways to do it 
in mode_set/atomic callbacks. Not well-versed in DRM framework to draw 
the conclusion here.

Runtime PM should ideally decouple sound and video to maximize the power 
saving. Let me take a deeper look and see if this chip has features that 
benefits from runtime PM.

> And assuming this is v2, here you should mention changelog and v1 link:
> V1: https://lore.kernel.org/all/e6497541-f3e7-4533-a188-9d422cb34d74@ti.com/
>>
>>    drivers/gpu/drm/bridge/sii902x.c | 165 +++++++++++++++++++++++++++++++
>>    1 file changed, 165 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
>> index 12497f5ce4ff..8da8ca22ac99 100644
>> --- a/drivers/gpu/drm/bridge/sii902x.c
>> +++ b/drivers/gpu/drm/bridge/sii902x.c
>> @@ -179,6 +179,8 @@ struct sii902x {
>>    	struct gpio_desc *reset_gpio;
>>    	struct i2c_mux_core *i2cmux;
>>    	u32 bus_width;
>> +	unsigned int ctx_tpi;
>> +	unsigned int ctx_interrupt;
>>    
>>    	/*
>>    	 * Mutex protects audio and video functions from interfering
>> @@ -189,6 +191,13 @@ struct sii902x {
>>    		struct platform_device *pdev;
>>    		struct clk *mclk;
>>    		u32 i2s_fifo_sequence[4];
>> +		bool active;
>> +		/* Audio register context for suspend/resume */
>> +		unsigned int ctx_i2s_input_config;
>> +		unsigned int ctx_audio_config_byte2;
>> +		unsigned int ctx_audio_config_byte3;
>> +		u8 ctx_i2s_stream_header[SII902X_TPI_I2S_STRM_HDR_SIZE];
>> +		u8 ctx_audio_infoframe[SII902X_TPI_MISC_INFOFRAME_SIZE];
>>    	} audio;
>>    };
>>    
>> @@ -755,6 +764,8 @@ static int sii902x_audio_hw_params(struct device *dev, void *data,
>>    	if (ret)
>>    		goto out;
>>    
>> +	sii902x->audio.active = true;
>> +
>>    	dev_dbg(dev, "%s: hdmi audio enabled\n", __func__);
>>    out:
>>    	mutex_unlock(&sii902x->mutex);
>> @@ -777,6 +788,8 @@ static void sii902x_audio_shutdown(struct device *dev, void *data)
>>    	regmap_write(sii902x->regmap, SII902X_TPI_AUDIO_CONFIG_BYTE2_REG,
>>    		     SII902X_TPI_AUDIO_INTERFACE_DISABLE);
>>    
>> +	sii902x->audio.active = false;
>> +
>>    	mutex_unlock(&sii902x->mutex);
>>    
>>    	clk_disable_unprepare(sii902x->audio.mclk);
>> @@ -1069,6 +1082,157 @@ static const struct drm_bridge_timings default_sii902x_timings = {
>>    		 | DRM_BUS_FLAG_DE_HIGH,
>>    };
>>    
>> +static int sii902x_resume(struct device *dev)
>> +{
>> +	struct sii902x *sii902x = dev_get_drvdata(dev);
>> +	unsigned int tpi_reg, status;
>> +	int ret, i;
>> +
>> +	ret = regmap_read(sii902x->regmap, SII902X_REG_TPI_RQB, &tpi_reg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (tpi_reg != sii902x->ctx_tpi) {
>> +		/*
>> +		 * TPI register context has changed. SII902X power supply
>> +		 * device has been turned off and on.
>> +		 */
>> +		sii902x_reset(sii902x);
>> +
>> +		/* Configure the device to enter TPI mode. */
>> +		ret = regmap_write(sii902x->regmap, SII902X_REG_TPI_RQB, 0x0);
>> +		if (ret)
>> +			return ret;
>> +
>> +		/* Re-enable the interrupts */
>> +		regmap_write(sii902x->regmap, SII902X_INT_ENABLE,
>> +			     sii902x->ctx_interrupt);
>> +	}
>> +
>> +	/* Clear all pending interrupts */
>> +	regmap_read(sii902x->regmap, SII902X_INT_STATUS, &status);
>> +	regmap_write(sii902x->regmap, SII902X_INT_STATUS, status);
>> +
>> +	/*
>> +	 * Restore audio context if audio was active before suspend,
>> +	 * in the matching order of sii902x_audio_hw_params() initialization.
>> +	 */
>> +	if (sii902x->audio.active) {
> 
> audio.active should be protected with mutex lock as done elsewhere in
> the driver?
> 
Sounds good, I'm assuming PM resume/suspend are atomic but nonetheless 
need to safeguard it from existing ops.
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
> 
> Do we need to restore the indirect registers status too with the
> constants that were used ?
> 
> /* Decode Level 0 Packets */
> 
> regmap_write(regmap, SII902X_IND_SET_PAGE, 0x02);  /* 0xBC */
> 
> regmap_write(regmap, SII902X_IND_OFFSET,  0x24);  /* 0xBD */
> 
> regmap_write(regmap, SII902X_IND_VALUE,   0x02);  /* 0xBE */
> 
> ```
> 
I didn't see any difference when I restore these registers but let me 
double check just to be sure.
>> +	return 0;
>> +
>> +err_audio_resume:
>> +	clk_disable_unprepare(sii902x->audio.mclk);
>> +	dev_err(dev, "Failed to restore audio registers: %d\n", ret);
>> +	return ret;
>> +}
>> +
>> +static int sii902x_suspend(struct device *dev)
>> +{
>> +	struct sii902x *sii902x = dev_get_drvdata(dev);
>> +	int ret;
>> +
> 
> Have you reviewed Table 3.8 of the datasheet ?
> 
> I think we should probably be utilizing different operating modes during
> suspend/resume cycles.
> 
> For e.g. with system suspend go to D3 cold state which is absolute
> minimum power.
> 
> For runtime suspend thought, have to be little careful as the D state
> should be chosen such that it does not have a too high resume latency.
> If D3 doesn't have too high then probably use the same else use D2.
> 
>> +	ret = regmap_read(sii902x->regmap, SII902X_REG_TPI_RQB,
>> +			  &sii902x->ctx_tpi);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_read(sii902x->regmap, SII902X_INT_ENABLE,
>> +			  &sii902x->ctx_interrupt);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Save audio context if audio is active, in the matching order
>> +	 * of sii902x_audio_hw_params() initialization.
>> +	 */
>> +	if (sii902x->audio.active) {
> 
> Here too, I think mutex protection required while accessing this flag.
> 

Understood
>> +		ret = regmap_read(sii902x->regmap, SII902X_TPI_AUDIO_CONFIG_BYTE2_REG,
>> +				  &sii902x->audio.ctx_audio_config_byte2);
>> +		if (ret)
>> +			goto err_audio_suspend;
>> +
>> +		ret = regmap_read(sii902x->regmap, SII902X_TPI_I2S_INPUT_CONFIG_REG,
>> +				  &sii902x->audio.ctx_i2s_input_config);
>> +		if (ret)
>> +			goto err_audio_suspend;
>> +
>> +		ret = regmap_read(sii902x->regmap, SII902X_TPI_AUDIO_CONFIG_BYTE3_REG,
>> +				  &sii902x->audio.ctx_audio_config_byte3);
>> +		if (ret)
>> +			goto err_audio_suspend;
>> +
>> +		ret = regmap_bulk_read(sii902x->regmap, SII902X_TPI_I2S_STRM_HDR_BASE,
>> +				       sii902x->audio.ctx_i2s_stream_header,
>> +				       SII902X_TPI_I2S_STRM_HDR_SIZE);
>> +		if (ret)
>> +			goto err_audio_suspend;
>> +
>> +		ret = regmap_bulk_read(sii902x->regmap, SII902X_TPI_MISC_INFOFRAME_BASE,
>> +				       sii902x->audio.ctx_audio_infoframe,
>> +				       SII902X_TPI_MISC_INFOFRAME_SIZE);
>> +		if (ret)
>> +			goto err_audio_suspend;
>> +
> 
> In the previous revision, my comment was to skip  register reads for
> restoring the context and instead populate the context in hw_params itself :
> 
> something as below :
> @@ -710,18 +717,36 @@ static int sii902x_audio_hw_params(struct device
> *dev, void *data,
>           ret = regmap_write(sii902x->regmap,
> 
>                              SII902X_TPI_AUDIO_CONFIG_BYTE2_REG,
> 
>                              config_byte2_reg);
> 
> -       if (ret < 0)
> 
> +       if (ret < 0)
> 
>                   goto out;
> 
> +       sii902x->audio.ctx_audio_config_byte2 = config_byte2_reg;
> 
>    
> 
>           ret = regmap_write(sii902x->regmap,
> SII902X_TPI_I2S_INPUT_CONFIG_REG,
>                              i2s_config_reg);
> 
>           if (ret)
> 
>                   goto out;
> 
> +       sii902x->audio.ctx_i2s_input_config = i2s_config_reg;
> 
>    
> 
>           for (i = 0; i < ARRAY_SIZE(sii902x->audio.i2s_fifo_sequence) &&
> 
>                       sii902x->audio.i2s_fifo_sequence[i]; i++)
> 
>                   regmap_write(sii902x->regmap,
> 
>                                SII902X_TPI_I2S_ENABLE_MAPPING_REG,
> 
> and likewise and then you don't have to do reg reads in resume back
> 
Okay, let me analyze this.
>> +		/*
>> +		 * audio.active is kept true so that resume restores the audio
>> +		 * context. sii902x_audio_shutdown() clears it when the stream
>> +		 * is explicitly closed.
>> +		 */
>> +		clk_disable_unprepare(sii902x->audio.mclk);
>> +	}
>> +
>> +	return 0;
>> +
>> +err_audio_suspend:
>> +	dev_err(dev, "Failed to save audio context: %d\n", ret);
>> +	return ret;
>> +}
>> +
>> +static DEFINE_SIMPLE_DEV_PM_OPS(sii902x_pm_ops, sii902x_suspend, sii902x_resume);
>> +
> 
> Can we add runtime suspend/resume hooks too ?
> 

I can add what we have for runtime, although I need to investigate this 
is actually makes a difference.

>>    static int sii902x_init(struct sii902x *sii902x)
>>    {
>>    	struct device *dev = &sii902x->i2c->dev;
>> @@ -1247,6 +1411,7 @@ static struct i2c_driver sii902x_driver = {
>>    	.remove = sii902x_remove,
>>    	.driver = {
>>    		.name = "sii902x",
>> +		.pm = pm_sleep_ptr(&sii902x_pm_ops),
>>    		.of_match_table = sii902x_dt_ids,
>>    	},
>>    	.id_table = sii902x_i2c_ids,
> 
> Regards
> Devarsh

Thanks for your review Devarsh, let me investigate and follow-up with a 
v2 patch.

Best regards,
Sen Wang
