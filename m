Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDA6CD6E5D
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 21:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35B5910E14A;
	Tue,  2 Jun 2026 21:01:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="g/vOA9ES";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AE0F10E5E5
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 21:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780434056;
 bh=Nm41nf7LMZhJDpK1ZklP3HkjMp0TeaGHvlDLxKRJpWE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=g/vOA9ESm5QsZvtz4J+owM+EoVL5A3D+rQ2Zhp9PQdWUE7BDnbd1vQ61t1XtRy9Im
 Sl1+4vpvjKcnq9N03fpS+75IFtSkfKa8E86ThpKFublJB7EEXlANwsyZ6MAYAuUUHC
 /Mg86spic96cnVeVV7loKAaCpqllQ+ObO2XuGnS8mVRQ+Rn8k9/3RTzlh5WhBG77WD
 Lpjl/L/t5SJ+5LcP8G+PgLYNci8UNI2bYOrcz89JKhQW0AZyaUBhU3efJoNXOohY5/
 3PC/SNg+A3iK5/KiHaeue6nii9FOsnxC5nbWJFHSUi8fVJVsO7br0IFAWadnQIURL0
 AJEjYaw7/kM7w==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3171B17E09B8;
 Tue,  2 Jun 2026 23:00:56 +0200 (CEST)
Message-ID: <b89a3039-05b7-4e4f-8306-07a37d2bd3c9@collabora.com>
Date: Wed, 3 Jun 2026 00:00:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe
 when PHY is down
To: Frank Zhang <rmxpzlb@gmail.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: detlev.casanova@collabora.com, daniels@collabora.com,
 dmitry.baryshkov@oss.qualcomm.com, heiko@sntech.de,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260512103153.8861-1-rmxpzlb@gmail.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20260512103153.8861-1-rmxpzlb@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Frank,

On 5/12/26 1:31 PM, Frank Zhang wrote:
> The following panic was observed during system reboot:
> 
> Kernel panic - not syncing: Asynchronous SError Interrupt
> CPU: 6 UID: 1000 PID: 2348 Comm: pipewire ... 7.0.5+ #4 PREEMPT(full)
> Call trace:
>  ...
>  regmap_update_bits_base+0x70/0xa8
>  dw_hdmi_qp_bridge_clear_audio_infoframe+0x3c/0x58 [dw_hdmi_qp]
>  drm_bridge_connector_clear_audio_infoframe+0x2c/0x48 [drm_display_helper]
>  ...
>  dw_hdmi_qp_audio_disable+0x28/0xa8 [dw_hdmi_qp]
>  drm_bridge_connector_audio_shutdown+0x38/0x68 [drm_display_helper]
>  drm_connector_hdmi_audio_shutdown+0x28/0x40 [drm_display_helper]
>  hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
>  ...
>  snd_pcm_release_substream+0xcc/0x120 [snd_pcm]
>  snd_pcm_release+0x4c/0xc0 [snd_pcm]
>  ...
> 
> The root cause is pipewire tries to close the HDMI audio device after
> atomic_disable(), which sets tmds_char_rate to 0 and disables the PHY.
> 
> In this case, dw_hdmi_qp_audio_disable() will call
> dw_hdmi_qp_bridge_clear_audio_infoframe(), accessing register without
> checking tmds_char_rate.
> 
> Add a tmds_char_rate guard in dw_hdmi_qp_bridge_clear_audio_infoframe().
> Decouple write_audio_infoframe from clear_audio_infoframe to avoid the
> redundant check in the write path.
> Add PKTSCHED_AMD_TX_EN to the clear mask to keep the enable/disable
> balance.
> 
> Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
> Cc: stable@vger.kernel.org
> Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
> 
> ---
> Changes in v2:
> - Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside
>   the if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
> - Link to v1: https://lore.kernel.org/all/20260416093150.13853-1-rmxpzlb@gmail.com/
> 
> Changes in v3:
> - Add a tmds_char_rate guard in clear_audio_infoframe path.
> - Decouple write_audio_infoframe from clear_audio_infoframe.
> - Balance the PKTSCHED_AMD_TX_EN bit enable/disable.
> - Link to v2: https://lore.kernel.org/all/20260418101936.7731-1-rmxpzlb@gmail.com/
> 
> Changes in v4:
> - Update panic stack on 7.0.5
> - Link to v3: https://lore.kernel.org/all/20260423081514.15444-1-rmxpzlb@gmail.com/
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> index d649a1cf07f5..1c18f8650fcd 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> @@ -886,11 +886,11 @@ static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
>  {
>  	struct dw_hdmi_qp *hdmi = bridge->driver_private;
>  
> -	dw_hdmi_qp_mod(hdmi, 0,
> -		       PKTSCHED_ACR_TX_EN |
> -		       PKTSCHED_AUDS_TX_EN |
> -		       PKTSCHED_AUDI_TX_EN,
> -		       PKTSCHED_PKT_EN);
> +	if (hdmi->tmds_char_rate)
> +		dw_hdmi_qp_mod(hdmi, 0,
> +			       PKTSCHED_ACR_TX_EN | PKTSCHED_AMD_TX_EN |
> +			       PKTSCHED_AUDS_TX_EN | PKTSCHED_AUDI_TX_EN,
> +			       PKTSCHED_PKT_EN);
>  
>  	return 0;
>  }
> @@ -989,7 +989,10 @@ static int dw_hdmi_qp_bridge_write_audio_infoframe(struct drm_bridge *bridge,
>  {
>  	struct dw_hdmi_qp *hdmi = bridge->driver_private;
>  
> -	dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);
> +	dw_hdmi_qp_mod(hdmi, 0,
> +		       PKTSCHED_ACR_TX_EN | PKTSCHED_AMD_TX_EN |
> +		       PKTSCHED_AUDS_TX_EN | PKTSCHED_AUDI_TX_EN,
> +		       PKTSCHED_PKT_EN);

Is "avoid the redundant check in the write path" the only reason of open-coding
dw_hdmi_qp_bridge_clear_audio_infoframe()? 

Performance wise, I don't think there are any real gains here, so we'd be better
off reusing the existing code where possible.

Regards,
Cristian
