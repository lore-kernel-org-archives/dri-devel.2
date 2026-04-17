Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DD0F436BB
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 16:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AEEF10EA5E;
	Fri, 17 Apr 2026 16:46:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="kxHnnlDD";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E3F810EA5E
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 16:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776444381; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gNyRgBDuwXgOu0QFDA9npEsNOsuVHDKaai6nilfJlmsPRZF4+vXft3EhQ79MYWEerIBTT/MpvaBA+cCHBkSPYz0xrXlhNwljUXkXt7bOT34LsYi1hYOKfoc3FPA99XOVJqfzaAdEIRIcdzKdGkVZsxrzwnuRyBzznk5oEgRVevA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776444381;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=oGlX3d40W6MY4p3k5QtkXjQ1vrtcvfTbzXPALvl67to=; 
 b=eXKGcAWkWM30UK5Sl+9c8UTn6YSoVS34pTvNtox6gHhvVOiTr3cTi7xktbgSxzWLs9VEAoyTRb0VSyPzE7usLNOS4az+MKIDttbKmRhCFgba0JMpp7QZaGk+l1SE+es9wcsy1uvz2kPxza3643o2Rf97b2Qup56+INxfGTJy1rk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
 dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776444381; 
 s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=oGlX3d40W6MY4p3k5QtkXjQ1vrtcvfTbzXPALvl67to=;
 b=kxHnnlDDfhFNHg1KsP0omgrvxFOObycmIAHfqPCcHkXfkoOev7/cWyzxfeKoYvSp
 iA9lxM+uh0hAWCfRpSsfGwO3WmE9EoabYXIyNVbuAQmxZ4GcbfvwOBHLFGRa2BjyvB3
 0n9azn1elX+ErDLUq+dYfBcuDC/rrESPXjQfknBQ=
Received: by mx.zohomail.com with SMTPS id 1776444379512769.9061064604867;
 Fri, 17 Apr 2026 09:46:19 -0700 (PDT)
Message-ID: <422b01a9-7b8f-4910-b153-5ffa6a1d3b4a@collabora.com>
Date: Fri, 17 Apr 2026 12:46:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe when
 PHY is down
To: Frank Zhang <rmxpzlb@gmail.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260416093150.13853-1-rmxpzlb@gmail.com>
Content-Language: en-US
From: Detlev Casanova <detlev.casanova@collabora.com>
In-Reply-To: <20260416093150.13853-1-rmxpzlb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
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

Please add me to CC if you send a v2.

On 4/16/26 05:31, Frank Zhang wrote:
> The following panic was observed during system reboot:
>
> Kernel panic - not syncing: Asynchronous SError Interrupt
> CPU: 7 UID: 1000 PID: 2637 Comm: pipewire ... 6.19.10-300.fc44.aarch64
> Call trace:
>   ...
>   regmap_update_bits_base+0x5c/0x90
>   dw_hdmi_qp_bridge_clear_infoframe+0xb0/0x120 [dw_hdmi_qp]
>   drm_bridge_connector_clear_infoframe+0x28/0x48 [drm_display_helper]
>   ...
>   dw_hdmi_qp_audio_disable+0x24/0xb8 [dw_hdmi_qp]
>   drm_bridge_connector_audio_shutdown+0x30/0x60 [drm_display_helper]
>   drm_connector_hdmi_audio_shutdown+0x24/0x38 [drm_display_helper]
>   hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
>   ...
>   snd_pcm_release_substream.part.0+0x44/0xd8 [snd_pcm]
>   snd_pcm_release+0x60/0xe8 [snd_pcm]
>   ...
>
> The root cause is pipewire tries to close the HDMI audio device after
> atomic_disable(), which sets tmds_char_rate to 0 and disable the PHY.
>
> In this case, dw_hdmi_qp_audio_disable() will call
> clear_audio_infoframe(), accessing registers without checking
> tmds_char_rate.
>
> Add a tmds_char_rate check in dw_hdmi_qp_bridge_clear_audio_infoframe()
> to skip the register write when the PHY is inactive.
>
> Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
Add a "Fixes:" tag so this gets backported were needed.
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> index d649a1cf07f5..f963dff81dc6 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> @@ -886,11 +886,12 @@ static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
>   {
>   	struct dw_hdmi_qp *hdmi = bridge->driver_private;
>   
> -	dw_hdmi_qp_mod(hdmi, 0,
> -		       PKTSCHED_ACR_TX_EN |
> -		       PKTSCHED_AUDS_TX_EN |
> -		       PKTSCHED_AUDI_TX_EN,
> -		       PKTSCHED_PKT_EN);
> +	if (hdmi->tmds_char_rate)
I'd rather move the call to 
drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside the if 
(hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
There is no need to check for tmds_char_rate in every 
dw_hdmi_qp_bridge_clear_audio_infoframe() call.
> +		dw_hdmi_qp_mod(hdmi, 0,
> +			       PKTSCHED_ACR_TX_EN |
> +			       PKTSCHED_AUDS_TX_EN |
> +			       PKTSCHED_AUDI_TX_EN,
> +			       PKTSCHED_PKT_EN);
>   
>   	return 0;
>   }

Regards,
Detlev.
