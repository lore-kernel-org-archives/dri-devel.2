Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AA9F5A8BA
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 02:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A63310E05E;
	Tue, 21 Apr 2026 02:31:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BKtaZBeR";
	dkim-atps=neutral
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com
 [74.125.224.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1577B10E05E
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 02:31:32 +0000 (UTC)
Received: by mail-yx1-f54.google.com with SMTP id
 956f58d0204a3-6500ff16c0aso401612d50.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 19:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776738691; x=1777343491; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ipI0idJGNrZodVG5ZIm4eDtcetTLm6jd3SJUdqoCiio=;
 b=BKtaZBeRn5ZC+/B5Z7M+yiSINvqCmeMpGdM5xAnDjUuDIA54b7LU0jg55ONFYc7QU3
 foitqWjD0Bg5I/oJIEBQTDiZv+CvMYC382K8nGAYiDv+WGjmUaDwWSIu1IY8Zu12DnGp
 Cq8Xx2mcBt1TauzPoyK+qUs7Lfww/kfxxVwioIuAbTJE4yUdJAxYQy+jlwXSy7mh161I
 UdOXmQc1TWiw4nubZy3pwVzqqvqJhIz9bZKoj7+0idQtSsK4nENX7p2CeJvybbSznGJK
 fhOEb9ssIUDEbjgsiZYJkLWxLznif3suvrEsOnSLIY/kKfuukC4/JjLvN75+R6bpFaux
 7wTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776738691; x=1777343491;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ipI0idJGNrZodVG5ZIm4eDtcetTLm6jd3SJUdqoCiio=;
 b=CQNgvVYFDjWiforG/0jI8DF7WlH77u/0Y8Vw8vNrGrjHZTdZ0foqrX3gnRXQqxZC2U
 nKOBArHOY1+YU5CIzpP8yj3or3K1l3VDMfCLUxek/L9/XfottG4JgeGx5NEsLZmgWKQK
 1gm046TZOrQLHNwxbZqGdRkUlerQAQrS+XWfGBbPZM9RmWJkVdxSPdCLfwUv0IHD/NbL
 G4Xe17blkvWWBVpjiCpNgYr1UzCY89jN0ozBytm4mfMsVxvaliiUl3GSsiKOUJNSiR+4
 mFFZF9Fsczst2PWgnoKrZU63YpyIf97yohWh7o9/v/aCQcbv0fP0MRgw8BZf2FH4t4lW
 ifRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+0JOCV6M/gWd/8eakMO47iupKydeDAHvEZRfsToahOu9rIDEUKzooapMNQJyJOT05MHrhEnFyP2Cg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1WjVp7PUf56m1K/DN2MFAVBXC+T37nKHsTA1wZwhsaYKZjWbH
 YUjU0v4t+pOKZHC2hZAYO5iO3VWWOlE4GcJNoYU7GfMLGrCDUE6JcEs4
X-Gm-Gg: AeBDiespY36Tk/QcMl5Pji02JHYQVay/J7p8o3/DUVGdCNfj8Nh+aE4VSR+/lEW/NLc
 QRPQiNSWJJAbXCqX71CHuDTEzNlEitHfr6nNF0ePjeat/D3SWFDvuQit5f4OyrSGJGmIHm1dSfJ
 eKn0/CnjvVrDFBtfo6MkHbJU+0ns0IGUFOS9TQI4udHa7s2w1X4LhalGkR13YPGYJUmfk0EM3oe
 +tMzO22ehLZFJj7lGjpBAdZvUB3dAO5JQaDVKzdERSH7aG8UDWx4xy4mirfm5l7UbARtxXEURNt
 TOiv4tFBmlekKXvDhPi8eTXG72yGeMeekGpUYMOC+1EgjB/Uy3Rg9w4obfiVEm3p2HbbvE7i9ce
 Mn1mH4wEpVjlNzJO4Oi9MB9ybXqV5xXx0P/Wznmp81kSiDYiYtD1V//0b9NYklQVoa/Xqxes2Tk
 WnpI4zekTYq0FZWpC/tPvfeabGOtH3kO3vQuWqps+AQbwL+KS8Wx74aUyP3L+3IIiqjbiGsCHcS
 OKsnkmLJtefiak=
X-Received: by 2002:a05:690c:4b92:b0:7b1:c8e4:3271 with SMTP id
 00721157ae682-7b9ed12bbc9mr119038577b3.3.1776738691366; 
 Mon, 20 Apr 2026 19:31:31 -0700 (PDT)
Received: from [192.168.11.79]
 (2607-8700-5500-a805-0000-0000-0000-0002.16clouds.com.
 [2607:8700:5500:a805::2]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7b9ee8be8e4sm52804197b3.14.2026.04.20.19.31.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 19:31:30 -0700 (PDT)
Message-ID: <99f6fde4-ac69-4e7d-a345-a378762eb9bb@gmail.com>
Date: Tue, 21 Apr 2026 10:31:19 +0800
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
 <9c198d0e-a675-4d7e-a485-5a8ee4d97f88@gmail.com>
 <ggmfrel7xrhigcsvoegxwdxpljohiyspzcmhpmkxkqycu53zwm@ltkecyoshdax>
Content-Language: en-US
In-Reply-To: <ggmfrel7xrhigcsvoegxwdxpljohiyspzcmhpmkxkqycu53zwm@ltkecyoshdax>
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

On 4/20/26 17:00, Dmitry Baryshkov wrote:
> On Mon, Apr 20, 2026 at 02:11:28PM +0800, Frank Zhang wrote:
>> On 4/19/26 08:40, Dmitry Baryshkov wrote:
>>> On Sat, Apr 18, 2026 at 06:19:36PM +0800, Frank Zhang wrote:
>>>> The following panic was observed during system reboot:
>>>>
>>>> Kernel panic - not syncing: Asynchronous SError Interrupt
>>>> CPU: 7 UID: 1000 PID: 2637 Comm: pipewire ... 6.19.10-300.fc44.aarch64
>>>> Call trace:
>>>>    ...
>>>>    regmap_update_bits_base+0x5c/0x90
>>>>    dw_hdmi_qp_bridge_clear_infoframe+0xb0/0x120 [dw_hdmi_qp]
>>>>    drm_bridge_connector_clear_infoframe+0x28/0x48 [drm_display_helper]
>>>>    ...
>>>>    dw_hdmi_qp_audio_disable+0x24/0xb8 [dw_hdmi_qp]
>>>>    drm_bridge_connector_audio_shutdown+0x30/0x60 [drm_display_helper]
>>>>    drm_connector_hdmi_audio_shutdown+0x24/0x38 [drm_display_helper]
>>>>    hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
>>>>    ...
>>>>    snd_pcm_release_substream.part.0+0x44/0xd8 [snd_pcm]
>>>>    snd_pcm_release+0x60/0xe8 [snd_pcm]
>>>>    ...
>>>>
>>>> The root cause is pipewire tries to close the HDMI audio device after
>>>> atomic_disable(), which sets tmds_char_rate to 0 and disable the PHY.
>>>>
>>>> In this case, dw_hdmi_qp_audio_disable() will call
>>>> drm_atomic_helper_connector_hdmi_clear_audio_infoframe() directly,
>>>> accessing registers without checking tmds_char_rate.
>>>>
>>>> Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside the
>>>> if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
>>>>
>>>> Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
>>>> Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
>>>>
>>>> ---
>>>> Changes in v2:
>>>> - Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside
>>>>     the if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
>>>> - Link to v1: https://lore.kernel.org/all/20260416093150.13853-1-rmxpzlb@gmail.com/
>>>>
>>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
>>>> index d649a1cf07f5..7760527484c8 100644
>>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
>>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
>>>> @@ -526,10 +526,10 @@ static void dw_hdmi_qp_audio_disable(struct drm_bridge *bridge,
>>>>    {
>>>>    	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
>>>> -	drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
>>>> -
>>>> -	if (hdmi->tmds_char_rate)
>>>> +	if (hdmi->tmds_char_rate) {
>>>> +		drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
>>>>    		dw_hdmi_qp_audio_disable_regs(hdmi);
>>>> +	}
>>>
>>> Will audio and audio infoframe remain disabled after consequetive
>>> atomic_enable() call?
>>>
>>>>    }
>>>>    static int dw_hdmi_qp_i2c_read(struct dw_hdmi_qp *hdmi,
>>>> -- 
>>>> 2.53.0
>>>>
>>>
>>
>> Sorry, I missed clearing the audio infoframe when the PHY is down. The next
>> atomic_enable() will write the stale audio infoframe. My mistake.
>>
>> To clear the stale audio infoframe, dw_hdmi_qp_audio_disable() can handle it
>> in the else branch directly, but this seems like a layering violation for a
>> bridge driver
>>
>> I think the better approach is to add a 'reset_audio_infoframe' interface in
>> drm_hdmi_state_helper.c that does basically the same as
>> drm_atomic_helper_connector_hdmi_clear_audio_infoframe(), but only clearing
>> the software state without calling clear_infoframe(). It's also a bit odd
>> since it would only be used by dw-hdmi-qp.
> 
> That sounds too fine-grained and it also will not work straight ahead...
> 
> Just for my understanding, let's consider the opposite situation: the
> user tries to start audio playback before setting the mode. How is it
> handled in the driver?
> 

audio_prepare() will return -ENODEV before the mode is set.

I admit modifying dw-hdmi-qp is more reasonable. I have a new approach:

dw-hdmi-qp should have an internal function to clear the audio infoframe 
related registers.
dw_hdmi_qp_bridge_clear_audio_infoframe() should check tmds_char_rate, 
call the new function only when tmds_char_rate is available.
dw_hdmi_qp_bridge_write_audio_infoframe() should call the new function 
directly instead of dw_hdmi_qp_bridge_clear_audio_infoframe(), without 
checking tmds_char_rate.
dw_hdmi_qp_audio_disable() doesn't need any modification.

With this approach, clear_audio_infoframe guards register access by 
checking tmds_char_rate, while write_audio_infoframe does not need to 
check it again. How about it?

Thanks,
Frank Zhang

>>
>> I'd like to get the maintainers' opinion about adding such an interface.
>>
>> Thanks,
>> Frank Zhang
>>
> 

