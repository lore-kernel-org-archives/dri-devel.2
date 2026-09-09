Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C173BC79F82
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 01:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB5C310E031;
	Wed,  9 Sep 2026 01:39:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h0zD6f1o";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5418F10E031
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 01:39:10 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39931869b4aso503021a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 18:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788917950; x=1789522750; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JjI4DgjlDDON3NUoadRh7LpaMb/RUtoIPEQT63OcGFI=;
 b=h0zD6f1o76n7T8X7fz02fYYsXFLfA6cuZg+u1ifG9V44tTwwnRveD2Smjgb/RqHp5N
 l2229K8ZxFBo6hCBDsA+Q4c2w6jMw0r+pIn4zZXSayR1vgLMgj1NAJojzKsOkiyqmbIB
 EoOg0gm29MTy12m/Jrfg4f4b4Z9mB/wNhoLI57TSWlIdnDSsO9zn9UwBY5W8Cks399Qe
 3YiXMrYN1L7N22iZj6M5x9m1n/F+JTTv5aYIUxqptutphn3NCUS7QT3f8eJ+XprPJxLj
 BGfKamVX3uzZ7X9G9SEddjui97n2y8gMrRYFXoCSISFB/TTOrMDlf7bTfImJ81kggitY
 kqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788917950; x=1789522750;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JjI4DgjlDDON3NUoadRh7LpaMb/RUtoIPEQT63OcGFI=;
 b=oKJd2snI3dBb9bXHQGDbC9vn5iQsYoN23NW8S+JjPdLO3fdV1osJ8n7gSiBxZi6ryI
 mtZa/WxUmfhzGZQGp9tZZDE4XwUP1+aLjmiMQLWqg9WBkAUewgDAq0PatjkZ1OMVzV0Y
 TXCvzbu0m5VuZ/K92dOEbkzCF+5DsbUntmAMm210Joli6X0mek4okKW50pMCzTozKISz
 6dd4CD3ZlrGkL4CAtO1GEJvDhZWKuO7O0cJl15ucXFTYBbfxrW5JZzdxBY335R6y6/hj
 j3ddK2M+JK7hCIqwgh5/ZbyZtSUfHmSrsLYB2bERYfKGqdOHZumhGuWanKLV4GuqS2iu
 VDnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByNjl0w2A8fjnBN2XLmFaFAgp6t9MzJrA2XzGrxcuigY3a35GAk+FIOPLh8v+8OjNvjWuhmBdMhaus=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mcKhzwitn8M8mTm1wu/YsII0lpAu5lmm0Q2hTc/9dyadAmZV3j
 Br8SSqhOU+Ik1hlXyXORZEfisuo85YKP62Pr2i3eUt1iLJh1+kU/VAma
X-Gm-Gg: AYBFou2xRVUu9yBkm6FKfCJZ1VXcfDOWQa6osvz4ziGED3Bhs3RXPRPyALuhUdFrJR/
 Tk/fpHCS2PieJ2Q02tntfOl/HTbDgTarF9Ip3eEdwIltQhVp6f70nG52xunqNZgy0FfwLqc1LN/
 Rs7nsdBBzWk3XwVIZERo4DYdtPzA+jxrg6p9JnhL1PPOVcUesn0S6lWh0FkAftY1WhsO/L/rZmF
 oDkLkYI8jJFI8Cxl3O+xT6OwSLOntIsiJ9HbSfkS5e68pgBCNiYBIeH+6pwtcd68UiVh6bsOt3+
 Yu3xBSxs3PSKp6C2MYn1/AkeRHY8t11NQpCUpg/Msij6ggj4oa0o0lHAU/3Wpi7V/CqhPCgpXND
 HFSTYpstZiVzlPXyRaPBt50CaTKX4xMD8Okqi2lUFkfK8zprQ7bs93Wrl3/wN4NiEsQJZ82JieF
 R8SxdW/2zYqXB7aSRsGZbCrUN3r9qZjL/NDA4zpRovfgVCkraN4OQ7qbSUQB5qvO4TDM4fg9Bwz
 QDK/NHAtPuaHiCKFz9t28zB5bpLTpDlqWLHmRnPxg==
X-Received: by 2002:a17:90b:384d:b0:398:bac0:238e with SMTP id
 98e67ed59e1d1-39b3d8377camr26729792a91.6.1788917949644; 
 Tue, 08 Sep 2026 18:39:09 -0700 (PDT)
Received: from [192.168.0.203]
 (2607-8700-5500-a805-0000-0000-0000-0002.16clouds.com.
 [2607:8700:5500:a805::2]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33688cfc714sm21198511eec.20.2026.09.08.18.38.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 18:39:08 -0700 (PDT)
Message-ID: <395cded7-4f9f-47ff-810e-41bed3f8a068@gmail.com>
Date: Wed, 9 Sep 2026 09:38:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe
 when PHY is down
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: royalnet026@gmail.com, Laurent.pinchart@ideasonboard.com,
 airlied@gmail.com, andrzej.hajda@intel.com, luca.ceresoli@bootlin.com,
 cristian.ciocaltea@collabora.com, daniels@collabora.com,
 detlev.casanova@collabora.com, dmitry.baryshkov@oss.qualcomm.com,
 heiko@sntech.de, jernej.skrabec@gmail.com, jonas@kwiboo.se,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, rfoss@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de, macromorgan@hotmail.com,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260908070220.41574-1-rmxpzlb@gmail.com> <ap_3zjRWm5-RXKKx@venus>
Content-Language: en-US
From: Frank Zhang <rmxpzlb@gmail.com>
In-Reply-To: <ap_3zjRWm5-RXKKx@venus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/8/26 20:10, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Sep 08, 2026 at 03:02:20PM +0800, Frank Zhang wrote:
>> The following panic was observed during system reboot:
>>
>> Kernel panic - not syncing: Asynchronous SError Interrupt
>> CPU: 6 UID: 1000 PID: 2348 Comm: pipewire ... 7.0.5+ #4 PREEMPT(full)
>> Call trace:
>>   ...
>>   regmap_update_bits_base+0x70/0xa8
>>   dw_hdmi_qp_bridge_clear_audio_infoframe+0x3c/0x58 [dw_hdmi_qp]
>>   drm_bridge_connector_clear_audio_infoframe+0x2c/0x48 [drm_display_helper]
>>   ...
>>   dw_hdmi_qp_audio_disable+0x28/0xa8 [dw_hdmi_qp]
>>   drm_bridge_connector_audio_shutdown+0x38/0x68 [drm_display_helper]
>>   drm_connector_hdmi_audio_shutdown+0x28/0x40 [drm_display_helper]
>>   hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
>>   ...
>>   snd_pcm_release_substream+0xcc/0x120 [snd_pcm]
>>   snd_pcm_release+0x4c/0xc0 [snd_pcm]
>>   ...
>>
>> The root cause is pipewire tries to close the HDMI audio device after
>> atomic_disable(), which sets tmds_char_rate to 0 and disables the PHY.
>>
>> In this case, dw_hdmi_qp_audio_disable() will call
>> dw_hdmi_qp_bridge_clear_audio_infoframe(), accessing register without
>> checking tmds_char_rate.
>>
>> Guard the register access in drm_display_helper callback function with
>> tmds_char_rate check.
>>
>> Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
>>
>> ---
>> Changes in v2:
>> - Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside
>>    the if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
>> - Link to v1: https://lore.kernel.org/all/20260416093150.13853-1-rmxpzlb@gmail.com/
>>
>> Changes in v3:
>> - Add a tmds_char_rate guard in clear_audio_infoframe path.
>> - Decouple write_audio_infoframe from clear_audio_infoframe.
>> - Balance the PKTSCHED_AMD_TX_EN bit enable/disable.
>> - Link to v2: https://lore.kernel.org/all/20260418101936.7731-1-rmxpzlb@gmail.com/
>>
>> Changes in v4:
>> - Update panic stack on 7.0.5
>> - Link to v3: https://lore.kernel.org/all/20260423081514.15444-1-rmxpzlb@gmail.com/
>>
>> Changes in v5:
>> - Reuse the origin dw_hdmi_qp_bridge_clear_audio_infoframe and add
>>    tmds_char_rate guard in new callback function.
>> - Link to v4: https://lore.kernel.org/all/20260512103153.8861-1-rmxpzlb@gmail.com/
>> ---
>>   drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
>> index 1c214a8e6dc2..8729783d4eb6 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
>> @@ -880,7 +880,7 @@ static int dw_hdmi_qp_bridge_clear_spd_infoframe(struct drm_bridge *bridge)
>>   	return 0;
>>   }
>>   
>> -static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
>> +static int __dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
>>   {
>>   	struct dw_hdmi_qp *hdmi = bridge->driver_private;
>>   
>> @@ -893,6 +893,16 @@ static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
>>   	return 0;
>>   }
>>   
>> +static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
>> +{
>> +	struct dw_hdmi_qp *hdmi = bridge->driver_private;
>> +
>> +	if (hdmi->tmds_char_rate > 0)
>> +		return __dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);
>> +
>> +	return 0;
>> +}
>> +
>>   static void dw_hdmi_qp_write_pkt(struct dw_hdmi_qp *hdmi, const u8 *buffer,
>>   				 size_t start, size_t len, unsigned int reg)
>>   {
>> @@ -987,7 +997,7 @@ static int dw_hdmi_qp_bridge_write_audio_infoframe(struct drm_bridge *bridge,
>>   {
>>   	struct dw_hdmi_qp *hdmi = bridge->driver_private;
>>   
>> -	dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);
>> +	__dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);
> 
> Why? Having the extra tmds_char_rate check being done here is not a
> problem except for some extra instructions. Considering this is
> definetly not a hot path, introducing the extra function is not
> worth the trouble. Just patch the original function to add the check
> resulting in a nice and simple 2 lines fix and you are done.
Add tmds_char_rate check in the original function 
`dw_hdmi_qp_bridge_clear_audio_infoframe` discussed in v1, Detlev 
Casanova recommend no need to check for tmds_char_rate in every
dw_hdmi_qp_bridge_clear_audio_infoframe() call.>
>>   
>>   	/*
>>   	 * AUDI_CONTENTS0: { RSV, HB2, HB1, RSV }
>> -- 
>> 2.55.0
>>
> 
> Greetings,
> 
> -- Sebastian

