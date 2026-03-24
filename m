Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EE3F532FE
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C82B610E637;
	Tue, 24 Mar 2026 09:11:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="d35X0Uta";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63F9110E637;
 Tue, 24 Mar 2026 09:11:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774343500; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=d8MnFBQkKpHJ4TH23zDPo4o46LfLDPrpOVdPHNE8ffXdXoFxGc7Z2FEQ4wf6xDvr2cm7f+ehIE1nYTny/bZbLEgXKPGNowaLSVzidCx+RDP0QVrCp1rUpzEgSWZboLirKnaw3feRFwxKdgLPp9qDSBWOC9EQ+PdE64D0Fb72wRo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774343500;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=AQWLMORUnkVbiNjJGAhEshPKUTqZoxqhRKKnwPG0jLg=; 
 b=NH0ufGdazv3xhvW3Ffcl7B4X+OXgsO2OwuF9YchQH2o1qCxwFwAHLOp6Zc9AN4bYNWjkBXcO8A/Gl4hBfRmU2ZDpNdH4anSXnKBrZDzPcZvm1CE1utnQ6TUPnwdidE/PxAo/b5tjhVe35PQLV7xLoUd4trRPY7FM8r/TZMm+Zzk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774343500; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=AQWLMORUnkVbiNjJGAhEshPKUTqZoxqhRKKnwPG0jLg=;
 b=d35X0UtaEM7Po2FmSfpYS/6GcdVCuoJdv3y7/qdxC4D7X6PAayQR7Kq9dY6FsyOk
 EqCn9VqIS2DDtW5r6H2IvfwLjVfCoPmKAaXUTbFOlMt00Gc2rXszoXyC6oQA7gOJ0jf
 iE+gFM6eC7gQYaMiIKr+UMRYfL2+ysQVrvP/2n1E=
Received: by mx.zohomail.com with SMTPS id 1774343497883801.6427108884712;
 Tue, 24 Mar 2026 02:11:37 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>,
 Liu Ying <victor.liu@nxp.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v3 04/14] drm/amdgpu: display: Convert to
 drm_output_color_format
Date: Tue, 24 Mar 2026 10:11:29 +0100
Message-ID: <7113873.lOV4Wx5bFT@workhorse>
In-Reply-To: <20260305-drm-rework-color-formats-v3-4-f3935f6db579@kernel.org>
References: <20260305-drm-rework-color-formats-v3-0-f3935f6db579@kernel.org>
 <20260305-drm-rework-color-formats-v3-4-f3935f6db579@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

On Thursday, 5 March 2026 10:04:56 Central European Standard Time Maxime Ripard wrote:
> Now that we introduced a new drm_output_color_format enum to represent
> what DRM_COLOR_FORMAT_* bits were representing, we can switch to the new
> enum.
> 
> The main difference is that while DRM_COLOR_FORMAT_ was a bitmask,
> drm_output_color_format is a proper enum. However, the enum was done is
> such a way than DRM_COLOR_FORMAT_X = BIT(DRM_OUTPUT_COLOR_FORMAT_X) so
> the transitition is easier.
> 
> The only thing we need to consider is if the original code meant to use
> that value as a bitmask, in which case we do need to keep the bit shift,
> or as a discriminant in which case we don't.
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a8e4e3ab5e40276b3c723297ca6520688079e0a7..2fe9044e1e91d7581fd5032b9883548f8e5e1b43 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6723,15 +6723,15 @@ static void fill_stream_properties_from_drm_display_mode(
>  		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
>  	else if (drm_mode_is_420_also(info, mode_in)
>  			&& aconnector
>  			&& aconnector->force_yuv420_output)
>  		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR420;
> -	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR422)
> +	else if ((connector->display_info.color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422))
>  			&& aconnector
>  			&& aconnector->force_yuv422_output)
>  		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR422;
> -	else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_YCBCR444)
> +	else if ((connector->display_info.color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444))
>  			&& stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
>  		timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR444;
>  	else
>  		timing_out->pixel_encoding = PIXEL_ENCODING_RGB;
>  
> 
> 

Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

I've been running this patch as part of my color format work and it
works precisely as it's supposed to (which is also quite evident from
the simple conversion in the code.)

Kind regards,
Nicolas Frattaroli


