Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CE8F99C76
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 06:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED76810E426;
	Mon, 20 Apr 2026 06:11:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aoWj/UZ0";
	dkim-atps=neutral
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD5710E426
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 06:11:58 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-7b178633e35so1781597b3.0
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 23:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776665517; x=1777270317; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f8Nyf4cpJRKorO7rgUUCbDBAbZjdSUwn4aYVqe/Bdmk=;
 b=aoWj/UZ0ZsSZXl73hjgsKT6I2AdxLXUpp5fASN/6SChq16z0h+eHBJqcX2Gh22Ryjb
 JSCUJ+htnYnmRk1Lgt/aA7eYayFzL1Ohs0eBf7F46HV/klfIZXDydHnzLFxeTyooemJU
 IIuxs6DYkpP+gh8YApubGRNOo6W6kCDZqDmYT0qtLhAzqaaiDgkA1ocjQ0wplR/36/Nx
 pSmTYd3eaSUz6baTOw6gFZv+Po+2bjqTKmMw7NcuBJaOqjmj7hM4LpWN3FGcq1pH3GUp
 1kDSKtEHFkjl32C2bX8YJmMArMbcYmi/L5F6+McqSJfzGYIi2bg+OGuF0kBnKApAA3T+
 EwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776665517; x=1777270317;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f8Nyf4cpJRKorO7rgUUCbDBAbZjdSUwn4aYVqe/Bdmk=;
 b=cnf4CVe4KxwJFSO0b7cIpj/poSYoQbx7zFjgHvghnmHIsFMMGJ2ndOEGQU5M/cIXQy
 0onaBSRxqdWXuhMpgzN/1UDY63LK5YSSjbJXw9TiDfFGMmewq6bTECDno7n5wv83A3QH
 FK0enEz2ALZuT91KD0QPN4oiyI1NGdll+rkBVZ2OrQptevGJbotaOTobJAA1VHoG7aap
 awUqoUTwTrUWECZpiDiBYmfou8unninRjOTEHV9YlHT83ifjxhpI6E0Ue33q/VhGpM5m
 3+0Ms0SPb1j2OqPdJWbbWEJI0vRbbMnrZipRm3cBocvkW/2kuK7dY1l0pOsjt6GeT96N
 oOsQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/aI7nHiDnosRqKziFDtqvYy9Cadr5dZ4gf01pcSbxOGlODzJQEyXIJMWGNwvG2pxsIT8sPqMBcqDw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwldTARER/CeVSBtumM0rfLT15U6PWDWpbGSqUTL4MuCt1san+O
 BUDEEzExyLVVVkVTRulxbyAIssyUvw91p8GcPG9zC+NjkQfV427JXeVG
X-Gm-Gg: AeBDieuLJmmG+lpzVO8gaxqTtdJEUtaF9/+YFBzuUaNy4sZRXKocgIG8NLiLIzErkhf
 cSo4amAnSEgNeh1hrOapuXVJ4GU7WU34i+BcwOEwKE0ajgphaKfHIWdrZCDntpgxuGM/G/gWvWO
 Ggs3RtDaeXbs+FoFBKiTrSM/gDpGkFUfhcu0nfV/OjsPFC2Nl2eC/qRYXCnm7Lrz7OVhP8CxMPs
 Hu9Il9S9lp4Sa8h9vqnGJTFTwYE8s+tc0qsuJzkFpZ22awt1j4zunDoBAUV2kxDjs2wMWe/Kjzn
 i0mDI65TLkkka7m6x7pS06W31A1SQYqbNsmymMBbPdigQTd4dD+WM/C4QOuwGMPqETzqlnpoegH
 oh2XH8go/I6h/weXnBEZOd8/GGjpX7XaEGpZd5H7+m+99WX25s17+YNnvSK66jbOhHi4/L92x8z
 JIanE+eKpWR0o9PzqXhgJSokiy4QLHuqseabZyCpfkedodvnikdN0trww6VeumttUDLc+XAjfi9
 hi+
X-Received: by 2002:a05:690c:4485:b0:7b6:db48:2f1d with SMTP id
 00721157ae682-7b9eccea04amr83767167b3.0.1776665517197; 
 Sun, 19 Apr 2026 23:11:57 -0700 (PDT)
Received: from [192.168.11.79]
 (2607-8700-5500-a805-0000-0000-0000-0002.16clouds.com.
 [2607:8700:5500:a805::2]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-65314e3510esm4693954d50.10.2026.04.19.23.11.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Apr 2026 23:11:56 -0700 (PDT)
Message-ID: <9c198d0e-a675-4d7e-a485-5a8ee4d97f88@gmail.com>
Date: Mon, 20 Apr 2026 14:11:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Frank Zhang <rmxpzlb@gmail.com>
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe
 when PHY is down
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, detlev.casanova@collabora.com,
 cristian.ciocaltea@collabora.com, Laurent.pinchart@ideasonboard.com,
 jonas@kwiboo.se, jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260418101936.7731-1-rmxpzlb@gmail.com>
 <hdl63shkqubkvczlg7ryjah5psiqzrhu5llelzaetw7skbpujv@nyxgriryjxd5>
Content-Language: en-US
In-Reply-To: <hdl63shkqubkvczlg7ryjah5psiqzrhu5llelzaetw7skbpujv@nyxgriryjxd5>
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

On 4/19/26 08:40, Dmitry Baryshkov wrote:
> On Sat, Apr 18, 2026 at 06:19:36PM +0800, Frank Zhang wrote:
>> The following panic was observed during system reboot:
>>
>> Kernel panic - not syncing: Asynchronous SError Interrupt
>> CPU: 7 UID: 1000 PID: 2637 Comm: pipewire ... 6.19.10-300.fc44.aarch64
>> Call trace:
>>   ...
>>   regmap_update_bits_base+0x5c/0x90
>>   dw_hdmi_qp_bridge_clear_infoframe+0xb0/0x120 [dw_hdmi_qp]
>>   drm_bridge_connector_clear_infoframe+0x28/0x48 [drm_display_helper]
>>   ...
>>   dw_hdmi_qp_audio_disable+0x24/0xb8 [dw_hdmi_qp]
>>   drm_bridge_connector_audio_shutdown+0x30/0x60 [drm_display_helper]
>>   drm_connector_hdmi_audio_shutdown+0x24/0x38 [drm_display_helper]
>>   hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
>>   ...
>>   snd_pcm_release_substream.part.0+0x44/0xd8 [snd_pcm]
>>   snd_pcm_release+0x60/0xe8 [snd_pcm]
>>   ...
>>
>> The root cause is pipewire tries to close the HDMI audio device after
>> atomic_disable(), which sets tmds_char_rate to 0 and disable the PHY.
>>
>> In this case, dw_hdmi_qp_audio_disable() will call
>> drm_atomic_helper_connector_hdmi_clear_audio_infoframe() directly,
>> accessing registers without checking tmds_char_rate.
>>
>> Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside the
>> if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
>>
>> Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
>> Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
>>
>> ---
>> Changes in v2:
>> - Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside
>>    the if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
>> - Link to v1: https://lore.kernel.org/all/20260416093150.13853-1-rmxpzlb@gmail.com/
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
>> index d649a1cf07f5..7760527484c8 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
>> @@ -526,10 +526,10 @@ static void dw_hdmi_qp_audio_disable(struct drm_bridge *bridge,
>>   {
>>   	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
>>   
>> -	drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
>> -
>> -	if (hdmi->tmds_char_rate)
>> +	if (hdmi->tmds_char_rate) {
>> +		drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
>>   		dw_hdmi_qp_audio_disable_regs(hdmi);
>> +	}
> 
> Will audio and audio infoframe remain disabled after consequetive
> atomic_enable() call?
> 
>>   }
>>   
>>   static int dw_hdmi_qp_i2c_read(struct dw_hdmi_qp *hdmi,
>> -- 
>> 2.53.0
>>
> 

Sorry, I missed clearing the audio infoframe when the PHY is down. The 
next atomic_enable() will write the stale audio infoframe. My mistake.

To clear the stale audio infoframe, dw_hdmi_qp_audio_disable() can 
handle it in the else branch directly, but this seems like a layering 
violation for a bridge driver

I think the better approach is to add a 'reset_audio_infoframe' 
interface in drm_hdmi_state_helper.c that does basically the same as 
drm_atomic_helper_connector_hdmi_clear_audio_infoframe(), but only 
clearing the software state without calling clear_infoframe(). It's also 
a bit odd since it would only be used by dw-hdmi-qp.

I'd like to get the maintainers' opinion about adding such an interface.

Thanks,
Frank Zhang

