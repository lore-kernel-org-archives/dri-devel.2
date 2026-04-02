Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26933CC6B03
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 07:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7703410F11A;
	Thu,  2 Apr 2026 07:07:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c0saDIeg";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E05110F0E6
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 07:07:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvncpNY2A4JKtlNZIa7fprfWUTdaQiUhAcArmuwtlqyloz1x9o/YYB9wDcT6I4F2gaWm/yImQ76DHn7fxKZPiTupj3XrNGAoGxeiIYkY/pEfgpwzwlZ5ron9xkluXUwajgZEJ8wn/9nl+e5Xxj4fS1hmSNBnP8L9hOVtvVpjRo/Di6xAlKCxGzu9g09N/RFL4Mc+TKgKoio9Y8BQc+yDVlPpuRz5s1y1oYYSVwJ2b+Ww2BrNMjA2h+teITiz5BS7vzBVlbiI10T1QR01fo4casVpxz+P342UOBfOqFkkYAZ2UatqiIkhbqe710SWzCAB7S+pQVcoJEKSLvKRGPbVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdJpw9B/uuZTceSj8KMdcMuyulSLqok1Ing2Lhr0iF4=;
 b=kU9MTGo0w65IONxcCQCGVUFbC9IaPZiLrBiT2xqt2RbieKGOmxulpTTunjxGJ2Ot8Mn77q7NnsA76Svfbuo5eZfXkkoF5PbXW1iSJUecxolFqb+YBUcO+9Er4ScQr1Epzca9T9F4aAUjcA+mFfW0RA6GiOrx62OZxPS/SYQKdaBK1FqcdApPdkK9hJ5OrXlSinLgTmTSUnfeQkkpwIDMu5hSFFbiWO+ul9+azIo8YzdLKcAD8kLxqyiMS0sXm4az2i8y9zpDjUSbYAewLO1WvkvNj0bSNCJgC1lUJMqD750ngWbOVcV8G4SDzzqqiGicjf5lWVOzQWScm8zHJ/SsIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdJpw9B/uuZTceSj8KMdcMuyulSLqok1Ing2Lhr0iF4=;
 b=c0saDIegVbVBI0OM5AGsIbchNYwPaSzGVRwIVGGhJf8BimBjRA9guF+p313IMQPljalcqWdIfy2jk+PPslIXYoKmTnaWN6wDJtaztNgPGH7Qfr9uMO6vS/CJsP3gD41Bm5hkNAvvFSTKcXAHpfo9elW31hjRpgoKi0KPbqk1jak=
Received: from BL1PR13CA0383.namprd13.prod.outlook.com (2603:10b6:208:2c0::28)
 by CY8PR10MB6441.namprd10.prod.outlook.com (2603:10b6:930:63::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 07:07:38 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2c0:cafe::d5) by BL1PR13CA0383.outlook.office365.com
 (2603:10b6:208:2c0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.16 via Frontend Transport; Thu,
 2 Apr 2026 07:07:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 07:07:38 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 02:07:37 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 02:07:36 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Apr 2026 02:07:36 -0500
Received: from [172.24.233.62] (devarsh-precision-tower-3620.dhcp.ti.com
 [172.24.233.62])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63277Vro1554634;
 Thu, 2 Apr 2026 02:07:32 -0500
Message-ID: <58abc6bd-2f34-4b85-b26e-34324079ec50@ti.com>
Date: Thu, 2 Apr 2026 12:37:31 +0530
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
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Donadkar,
 Rishikesh" <r-donadkar@ti.com>, "Jain, Swamil" <s-jain1@ti.com>
References: <20260401013758.4149091-1-sen@ti.com>
 <96444379-712c-4e21-8f3c-55eaad850cd4@ti.com>
 <09d3cf4d-ecb3-444a-8e88-7d51599007fe@ti.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <09d3cf4d-ecb3-444a-8e88-7d51599007fe@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|CY8PR10MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: af744a91-564c-4b47-a7c0-08de9086862f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +pQZTktZA/fPzJnTxKGum4Ut8iPVrG8d59U8JFHUzeepiocpm0MDtZKIsLgGXSFzRXMiyjCwkV7/B2/vWemv+elFLyC9wJmLaOmC4D3RJZ+RpXqk5n8x0nknUr93SMxoVH/0QRGluNTal0dJBXIQ9N1v3k2nWY1nRLxuuFUc4z3k/Z83w4fAp5nhgPUCxP+wYkflMvKTx3i9qkgz7Ez5GID5zy5mbxOTCAlNEr+1rpAqFg7IkF8LqXIwF8kP4QWRQRj91dEJZfshUCQOPcIH5oaS8J2Z81W8jL9XvzQksUeYyzWz9nX5oklLx5s+lctD6Shm8+4L0m7PHm4rsEW3RzcwTaXiYZOus7zGut4dEUBdAyH5rTVpE/wezgFhqgDeY623YHs4/mSOkPzwdxNCglAe/OSsHxUxoj81z7klK4noZCOReaDPp4YwWRQzbeMGCKn1H0O1hsDPI+5Tw9AUPlHYCW3Rpr7kQsSteyEE3tZc/y8H491GCYVzeWAVi7Gx/bOXzcwVSXD+C/BzQm9UVw5png6tH8p6mhX+LvGBieQ+jgZyyjkaeyX3C6QTRqMRJJGOVNA/6dCEeCW9fdBmEn132nV+Ns7SoCWdFPSTlQwF4/3F1+9HJQKlbSwdNY/ypYpCwpvsVeW+8v421scM598kLx07rApY2hDJjyDa1DGFLCFU2boZWJTjM51D1qgEsPsbuXu8Gi1iMwKXvn7mNrRV10SV4uxmLgrUJvX0wI0JW7RjfeG8A0t3EXJvKlbKhxvpI+Favfgc95VvGA5zaQ==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(13003099007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IMpgBS6rRJH8MUXNk5HC4jKsHIjwIpwAc0+GdOTX9Ad5+hOhDsqgVZcTcPNKi50nHgKYDzaIJwToC+cg3MuDe74kugnifymZkLQwDd92YSawb6lM+BIYNobPSC42aBas0hyMEcdy5q/yTGI/87albb3A2W7u9cnwz8FLJTxtz3Td90fRQZuyAVFlYgbyzk50C3mU/3aZ8CQm01eoqxWKPzNn2UXod/aqWr/+tdRccazB9m2Mtys+rWIVDeiDsynpUs2DW7qqR4KK9P6pksfrOLL2v/jHomnCoW+RlHBo5Bkbv5UZXbMOv6+/316SUIFTk0ooaAqgD9wknl00Wcb3En/yhDwERRQtR8n37qSaC2p0V0dgTCg8zYA5ZENzE8ilFesZcvex1bpn+HK5njT/a9QWZl3dh58cTlkW+fbkhJmv7FOg16W11p1/yaWUOgVk
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 07:07:38.3283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af744a91-564c-4b47-a7c0-08de9086862f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6441
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

Thanks for the update.

On 02/04/26 05:03, Sen Wang wrote:
> On 4/1/26 09:42, Thakkar, Devarsh wrote:
>> Hi Sen,
>>
>> On 01/04/26 07:07, Sen Wang wrote:
>>
>> Sorry but this is not very clear, is this a V2 to
>> https://lore.kernel.org/all/e6497541-f3e7-4533- 
>> a188-9d422cb34d74@ti.com/ ?
>>
>> In that case, the subject should mention it as PATCH v2 along with
>> changelog as documented in kernel patch guidelines :
>> https://docs.kernel.org/process/submitting-patches.html
>>
> Hi Devarsh, Thanks for your review.
> 
> This new patch encompasses more features than the previous patch to
> warrant it being a separate patch. But nonetheless my apologies for
> not stating the indirection in my commit message.
> 

I don't think this qualifies to make it an independent patch altogether, 
as long as goal of the patch is same as the initial one posted, this 
should be labelled as a V2 with linkage to V1 in changelog. And the 
follow up patch should be labelled V3.

The changelog should capture the changes under ---:

V1->V2 : What changed
V2->V3 : What changed

along with links for V1 and V2.

This gives the reviewer necessary context on architecture and reasoning 
behind new changes/approaches even if it means the new patch contains 
some extra feature which was not present in previous patch.

Regards
Devarsh


>>> Add suspend and resume hooks. On suspend, save TPI mode, interrupt
>>> enable, and audio register context (when active). On resume, detect
>>> power loss by comparing the saved TPI value; if changed, reset the
>>> device and restore TPI mode and interrupts. Restore audio registers
>>> and re-enable mclk if audio was active before suspend.
>>>
>>> Audio register values are read back during suspend rather than cached
>>> during hw_params, as the sii902x requires a specific register write
>>> sequence during initialization that must be preserved on resume.
>>>
>>> Based on initial PM hooks implementation by:
>>>     Aradhya Bhatia <a-bhatia1@ti.com>
>>>     Jayesh Choudhary <j-choudhary@ti.com>
>>>
>>> Signed-off-by: Sen Wang <sen@ti.com>
>>> ---
>>> Tested on TI SK-AM62P-LP board with HDMI audio playback across multiple
>>> suspend/resume cycles.
>>
>> Could you please also share the test logs ? Did you verify that both
>> audio/video context resume back seamlessly afer resuming from system
>> suspend ?
>>
> 
> Okay I'll attach it to the commit message for v2 patch.
> 
>> I guess this still does not support runtime suspend/resume ?
>>
> No it doesn't, I don't know if full suspend/resume is necessarily the 
> correct solution for runtime as well, besides there's also ways to do it 
> in mode_set/atomic callbacks. Not well-versed in DRM framework to draw 
> the conclusion here.
> 
> Runtime PM should ideally decouple sound and video to maximize the power 
> saving. Let me take a deeper look and see if this chip has features that 
> benefits from runtime PM.
> 
>> And assuming this is v2, here you should mention changelog and v1 link:
>> V1: https://lore.kernel.org/all/e6497541-f3e7-4533- 
>> a188-9d422cb34d74@ti.com/
>>>
>>>    drivers/gpu/drm/bridge/sii902x.c | 165 +++++++++++++++++++++++++++ 
>>> ++++
>>>    1 file changed, 165 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/ 
>>> bridge/sii902x.c
>>> index 12497f5ce4ff..8da8ca22ac99 100644
>>> --- a/drivers/gpu/drm/bridge/sii902x.c
>>> +++ b/drivers/gpu/drm/bridge/sii902x.c
>>> @@ -179,6 +179,8 @@ struct sii902x {
>>>        struct gpio_desc *reset_gpio;
>>>        struct i2c_mux_core *i2cmux;
>>>        u32 bus_width;
>>> +    unsigned int ctx_tpi;
>>> +    unsigned int ctx_interrupt;
>>>        /*
>>>         * Mutex protects audio and video functions from interfering
>>> @@ -189,6 +191,13 @@ struct sii902x {
>>>            struct platform_device *pdev;
>>>            struct clk *mclk;
>>>            u32 i2s_fifo_sequence[4];
>>> +        bool active;
>>> +        /* Audio register context for suspend/resume */
>>> +        unsigned int ctx_i2s_input_config;
>>> +        unsigned int ctx_audio_config_byte2;
>>> +        unsigned int ctx_audio_config_byte3;
>>> +        u8 ctx_i2s_stream_header[SII902X_TPI_I2S_STRM_HDR_SIZE];
>>> +        u8 ctx_audio_infoframe[SII902X_TPI_MISC_INFOFRAME_SIZE];
>>>        } audio;
>>>    };
>>> @@ -755,6 +764,8 @@ static int sii902x_audio_hw_params(struct device 
>>> *dev, void *data,
>>>        if (ret)
>>>            goto out;
>>> +    sii902x->audio.active = true;
>>> +
>>>        dev_dbg(dev, "%s: hdmi audio enabled\n", __func__);
>>>    out:
>>>        mutex_unlock(&sii902x->mutex);
>>> @@ -777,6 +788,8 @@ static void sii902x_audio_shutdown(struct device 
>>> *dev, void *data)
>>>        regmap_write(sii902x->regmap, SII902X_TPI_AUDIO_CONFIG_BYTE2_REG,
>>>                 SII902X_TPI_AUDIO_INTERFACE_DISABLE);
>>> +    sii902x->audio.active = false;
>>> +
>>>        mutex_unlock(&sii902x->mutex);
>>>        clk_disable_unprepare(sii902x->audio.mclk);
>>> @@ -1069,6 +1082,157 @@ static const struct drm_bridge_timings 
>>> default_sii902x_timings = {
>>>             | DRM_BUS_FLAG_DE_HIGH,
>>>    };
>>> +static int sii902x_resume(struct device *dev)
>>> +{
>>> +    struct sii902x *sii902x = dev_get_drvdata(dev);
>>> +    unsigned int tpi_reg, status;
>>> +    int ret, i;
>>> +
>>> +    ret = regmap_read(sii902x->regmap, SII902X_REG_TPI_RQB, &tpi_reg);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    if (tpi_reg != sii902x->ctx_tpi) {
>>> +        /*
>>> +         * TPI register context has changed. SII902X power supply
>>> +         * device has been turned off and on.
>>> +         */
>>> +        sii902x_reset(sii902x);
>>> +
>>> +        /* Configure the device to enter TPI mode. */
>>> +        ret = regmap_write(sii902x->regmap, SII902X_REG_TPI_RQB, 0x0);
>>> +        if (ret)
>>> +            return ret;
>>> +
>>> +        /* Re-enable the interrupts */
>>> +        regmap_write(sii902x->regmap, SII902X_INT_ENABLE,
>>> +                 sii902x->ctx_interrupt);
>>> +    }
>>> +
>>> +    /* Clear all pending interrupts */
>>> +    regmap_read(sii902x->regmap, SII902X_INT_STATUS, &status);
>>> +    regmap_write(sii902x->regmap, SII902X_INT_STATUS, status);
>>> +
>>> +    /*
>>> +     * Restore audio context if audio was active before suspend,
>>> +     * in the matching order of sii902x_audio_hw_params() 
>>> initialization.
>>> +     */
>>> +    if (sii902x->audio.active) {
>>
>> audio.active should be protected with mutex lock as done elsewhere in
>> the driver?
>>
> Sounds good, I'm assuming PM resume/suspend are atomic but nonetheless 
> need to safeguard it from existing ops.
>>> +        ret = clk_prepare_enable(sii902x->audio.mclk);
>>> +        if (ret) {
>>> +            dev_err(dev, "Failed to re-enable mclk: %d\n", ret);
>>> +            return ret;
>>> +        }
>>> +
>>> +        ret = regmap_write(sii902x->regmap, 
>>> SII902X_TPI_AUDIO_CONFIG_BYTE2_REG,
>>> +                   sii902x->audio.ctx_audio_config_byte2);
>>> +        if (ret)
>>> +            goto err_audio_resume;
>>> +
>>> +        ret = regmap_write(sii902x->regmap, 
>>> SII902X_TPI_I2S_INPUT_CONFIG_REG,
>>> +                   sii902x->audio.ctx_i2s_input_config);
>>> +        if (ret)
>>> +            goto err_audio_resume;
>>> +
>>> +        for (i = 0; i < ARRAY_SIZE(sii902x->audio.i2s_fifo_sequence) &&
>>> +             sii902x->audio.i2s_fifo_sequence[i]; i++) {
>>> +            ret = regmap_write(sii902x->regmap,
>>> +                       SII902X_TPI_I2S_ENABLE_MAPPING_REG,
>>> +                       sii902x->audio.i2s_fifo_sequence[i]);
>>> +            if (ret)
>>> +                goto err_audio_resume;
>>> +        }
>>> +
>>> +        ret = regmap_write(sii902x->regmap, 
>>> SII902X_TPI_AUDIO_CONFIG_BYTE3_REG,
>>> +                   sii902x->audio.ctx_audio_config_byte3);
>>> +        if (ret)
>>> +            goto err_audio_resume;
>>> +
>>> +        ret = regmap_bulk_write(sii902x->regmap, 
>>> SII902X_TPI_I2S_STRM_HDR_BASE,
>>> +                    sii902x->audio.ctx_i2s_stream_header,
>>> +                    SII902X_TPI_I2S_STRM_HDR_SIZE);
>>> +        if (ret)
>>> +            goto err_audio_resume;
>>> +
>>> +        ret = regmap_bulk_write(sii902x->regmap, 
>>> SII902X_TPI_MISC_INFOFRAME_BASE,
>>> +                    sii902x->audio.ctx_audio_infoframe,
>>> +                    SII902X_TPI_MISC_INFOFRAME_SIZE);
>>> +        if (ret)
>>> +            goto err_audio_resume;
>>> +    }
>>> +
>>
>> Do we need to restore the indirect registers status too with the
>> constants that were used ?
>>
>> /* Decode Level 0 Packets */
>>
>> regmap_write(regmap, SII902X_IND_SET_PAGE, 0x02);  /* 0xBC */
>>
>> regmap_write(regmap, SII902X_IND_OFFSET,  0x24);  /* 0xBD */
>>
>> regmap_write(regmap, SII902X_IND_VALUE,   0x02);  /* 0xBE */
>>
>> ```
>>
> I didn't see any difference when I restore these registers but let me 
> double check just to be sure.
>>> +    return 0;
>>> +
>>> +err_audio_resume:
>>> +    clk_disable_unprepare(sii902x->audio.mclk);
>>> +    dev_err(dev, "Failed to restore audio registers: %d\n", ret);
>>> +    return ret;
>>> +}
>>> +
>>> +static int sii902x_suspend(struct device *dev)
>>> +{
>>> +    struct sii902x *sii902x = dev_get_drvdata(dev);
>>> +    int ret;
>>> +
>>
>> Have you reviewed Table 3.8 of the datasheet ?
>>
>> I think we should probably be utilizing different operating modes during
>> suspend/resume cycles.
>>
>> For e.g. with system suspend go to D3 cold state which is absolute
>> minimum power.
>>
>> For runtime suspend thought, have to be little careful as the D state
>> should be chosen such that it does not have a too high resume latency.
>> If D3 doesn't have too high then probably use the same else use D2.
>>
>>> +    ret = regmap_read(sii902x->regmap, SII902X_REG_TPI_RQB,
>>> +              &sii902x->ctx_tpi);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = regmap_read(sii902x->regmap, SII902X_INT_ENABLE,
>>> +              &sii902x->ctx_interrupt);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    /*
>>> +     * Save audio context if audio is active, in the matching order
>>> +     * of sii902x_audio_hw_params() initialization.
>>> +     */
>>> +    if (sii902x->audio.active) {
>>
>> Here too, I think mutex protection required while accessing this flag.
>>
> 
> Understood
>>> +        ret = regmap_read(sii902x->regmap, 
>>> SII902X_TPI_AUDIO_CONFIG_BYTE2_REG,
>>> +                  &sii902x->audio.ctx_audio_config_byte2);
>>> +        if (ret)
>>> +            goto err_audio_suspend;
>>> +
>>> +        ret = regmap_read(sii902x->regmap, 
>>> SII902X_TPI_I2S_INPUT_CONFIG_REG,
>>> +                  &sii902x->audio.ctx_i2s_input_config);
>>> +        if (ret)
>>> +            goto err_audio_suspend;
>>> +
>>> +        ret = regmap_read(sii902x->regmap, 
>>> SII902X_TPI_AUDIO_CONFIG_BYTE3_REG,
>>> +                  &sii902x->audio.ctx_audio_config_byte3);
>>> +        if (ret)
>>> +            goto err_audio_suspend;
>>> +
>>> +        ret = regmap_bulk_read(sii902x->regmap, 
>>> SII902X_TPI_I2S_STRM_HDR_BASE,
>>> +                       sii902x->audio.ctx_i2s_stream_header,
>>> +                       SII902X_TPI_I2S_STRM_HDR_SIZE);
>>> +        if (ret)
>>> +            goto err_audio_suspend;
>>> +
>>> +        ret = regmap_bulk_read(sii902x->regmap, 
>>> SII902X_TPI_MISC_INFOFRAME_BASE,
>>> +                       sii902x->audio.ctx_audio_infoframe,
>>> +                       SII902X_TPI_MISC_INFOFRAME_SIZE);
>>> +        if (ret)
>>> +            goto err_audio_suspend;
>>> +
>>
>> In the previous revision, my comment was to skip  register reads for
>> restoring the context and instead populate the context in hw_params 
>> itself :
>>
>> something as below :
>> @@ -710,18 +717,36 @@ static int sii902x_audio_hw_params(struct device
>> *dev, void *data,
>>           ret = regmap_write(sii902x->regmap,
>>
>>                              SII902X_TPI_AUDIO_CONFIG_BYTE2_REG,
>>
>>                              config_byte2_reg);
>>
>> -       if (ret < 0)
>>
>> +       if (ret < 0)
>>
>>                   goto out;
>>
>> +       sii902x->audio.ctx_audio_config_byte2 = config_byte2_reg;
>>
>>
>>           ret = regmap_write(sii902x->regmap,
>> SII902X_TPI_I2S_INPUT_CONFIG_REG,
>>                              i2s_config_reg);
>>
>>           if (ret)
>>
>>                   goto out;
>>
>> +       sii902x->audio.ctx_i2s_input_config = i2s_config_reg;
>>
>>
>>           for (i = 0; i < ARRAY_SIZE(sii902x->audio.i2s_fifo_sequence) &&
>>
>>                       sii902x->audio.i2s_fifo_sequence[i]; i++)
>>
>>                   regmap_write(sii902x->regmap,
>>
>>                                SII902X_TPI_I2S_ENABLE_MAPPING_REG,
>>
>> and likewise and then you don't have to do reg reads in resume back
>>
> Okay, let me analyze this.
>>> +        /*
>>> +         * audio.active is kept true so that resume restores the audio
>>> +         * context. sii902x_audio_shutdown() clears it when the stream
>>> +         * is explicitly closed.
>>> +         */
>>> +        clk_disable_unprepare(sii902x->audio.mclk);
>>> +    }
>>> +
>>> +    return 0;
>>> +
>>> +err_audio_suspend:
>>> +    dev_err(dev, "Failed to save audio context: %d\n", ret);
>>> +    return ret;
>>> +}
>>> +
>>> +static DEFINE_SIMPLE_DEV_PM_OPS(sii902x_pm_ops, sii902x_suspend, 
>>> sii902x_resume);
>>> +
>>
>> Can we add runtime suspend/resume hooks too ?
>>
> 
> I can add what we have for runtime, although I need to investigate this 
> is actually makes a difference.
> 
>>>    static int sii902x_init(struct sii902x *sii902x)
>>>    {
>>>        struct device *dev = &sii902x->i2c->dev;
>>> @@ -1247,6 +1411,7 @@ static struct i2c_driver sii902x_driver = {
>>>        .remove = sii902x_remove,
>>>        .driver = {
>>>            .name = "sii902x",
>>> +        .pm = pm_sleep_ptr(&sii902x_pm_ops),
>>>            .of_match_table = sii902x_dt_ids,
>>>        },
>>>        .id_table = sii902x_i2c_ids,
>>
>> Regards
>> Devarsh
> 
> Thanks for your review Devarsh, let me investigate and follow-up with a 
> v2 patch.
> 
> Best regards,
> Sen Wang

