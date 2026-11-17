Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15224606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=lrmbIHHs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B6AE10EABF;
	Tue, 17 Nov 2026 07:25:49 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFBEC10EABF
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 07:25:42 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id DA733E4E;
 Tue, 17 Nov 2026 08:23:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1794900194;
 bh=qkKRy2LjXRv1NsXd/bizCc9huz674Yo2speAYeGcyjA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lrmbIHHsE7oaZmVetovLOltXR258Wo7VcP8QRNnad+/H9HY/Cjtq60KGL9EUBTQHF
 a1GQz0OqyMk+a0ErJ45MX10J5dyke3oDSXypj/0X+B0f3A+ad4a+mskYe1rhe8tEX5
 22AGfAmxjIX68ptp1M3h5LAKI5WV4VZa0sW3gQgw=
Message-ID: <c9f69e4b-5e6e-40fc-b84e-b7cc92963247@ideasonboard.com>
Date: Tue, 17 Nov 2026 09:25:38 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 33/39] drm/tidss: dispc: Improve mode checking logs
To: Maxime Ripard <mripard@kernel.org>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <20261106-drm-state-readout-v8-33-cbe78624e1bc@kernel.org>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261106-drm-state-readout-v8-33-cbe78624e1bc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 06/11/2026 15:14, Maxime Ripard wrote:
> The dispc_vp_mode_valid() function checks whether a mode can be handled
> by the display controller.
> 
> There's a whole bunch of criteria, and it's not clear when a rejection
> happens why it did. Add logs on each rejection criterion to make it
> clearer.
> 
> Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/tidss/tidss_dispc.c | 45 +++++++++++++++++++++++++++++--------
>   1 file changed, 36 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index e516f493d6d9..b5fb296fddcc 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -1318,4 +1318,6 @@ static int check_pixel_clock(struct dispc_device *dispc, u32 hw_videoport,
>   			     unsigned long clock)
>   {
> +	struct tidss_device *tidss = dispc->tidss;
> +	struct drm_device *dev = &tidss->ddev;
>   	unsigned long round_clock;
>   
> @@ -1332,6 +1334,9 @@ static int check_pixel_clock(struct dispc_device *dispc, u32 hw_videoport,
>   	 * use the same 5% check here.
>   	 */
> -	if (dispc_pclk_diff(clock, round_clock) > 5)
> +	if (dispc_pclk_diff(clock, round_clock) > 5) {
> +		drm_dbg(dev, "Pixel clock %lu differs from rounded clock %lu by more than 5%%.",
> +			clock, round_clock);
>   		return -EINVAL;
> +	}

Thanks, I'll pick this up to drm-misc-next, but I'll drop the ending 
dots and add linefeeds when applying.

  Tomi


>   
>   	return 0;
> @@ -1342,4 +1347,6 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
>   					 const struct drm_display_mode *mode)
>   {
> +	struct tidss_device *tidss = dispc->tidss;
> +	struct drm_device *dev = &tidss->ddev;
>   	u32 hsw, hfp, hbp, vsw, vfp, vbp;
>   	enum dispc_vp_bus_type bus_type;
> @@ -1347,12 +1354,18 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
>   	bus_type = dispc->feat->vp_bus_type[hw_videoport];
>   
> -	if (WARN_ON(bus_type == DISPC_VP_TIED_OFF))
> +	if (WARN_ON(bus_type == DISPC_VP_TIED_OFF)) {
> +		drm_dbg(dev, "Invalid bus type.");
>   		return MODE_BAD;
> +	}
>   
> -	if (mode->hdisplay > 4096)
> +	if (mode->hdisplay > 4096) {
> +		drm_dbg(dev, "Number of active horizontal pixels above hardware limits.");
>   		return MODE_BAD;
> +	}
>   
> -	if (mode->vdisplay > 4096)
> +	if (mode->vdisplay > 4096) {
> +		drm_dbg(dev, "Number of active vertical lines above hardware limits.");
>   		return MODE_BAD;
> +	}
>   
>   	if (check_pixel_clock(dispc, hw_videoport, mode->clock * 1000))
> @@ -1360,6 +1373,8 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
>   
>   	/* TODO: add interlace support */
> -	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> +	if (mode->flags & DRM_MODE_FLAG_INTERLACE) {
> +		drm_dbg(dev, "Interlace modes not supported.");
>   		return MODE_NO_INTERLACE;
> +	}
>   
>   	/*
> @@ -1371,6 +1386,8 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
>   	 * But for simplicity we enforce that always.
>   	 */
> -	if ((mode->hdisplay % 2) != 0)
> +	if ((mode->hdisplay % 2) != 0) {
> +		drm_dbg(dev, "Number of active horizontal pixels must be even.");
>   		return MODE_BAD_HVALUE;
> +	}
>   
>   	hfp = mode->hsync_start - mode->hdisplay;
> @@ -1384,10 +1401,18 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
>   	if (hsw < 1 || hsw > 256 ||
>   	    hfp < 1 || hfp > 4096 ||
> -	    hbp < 1 || hbp > 4096)
> +	    hbp < 1 || hbp > 4096) {
> +		drm_dbg(dev,
> +			"Horizontal blanking or sync outside of hardware limits (fp: %u, sw: %u, bp: %u).",
> +			hfp, hsw, hbp);
>   		return MODE_BAD_HVALUE;
> +	}
>   
>   	if (vsw < 1 || vsw > 256 ||
> -	    vfp > 4095 || vbp > 4095)
> +	    vfp > 4095 || vbp > 4095) {
> +		drm_dbg(dev,
> +			"Vertical blanking or sync outside of hardware limits (fp: %u, sw: %u, bp: %u).",
> +			vfp, vsw, vbp);
>   		return MODE_BAD_VVALUE;
> +	}
>   
>   	if (dispc->memory_bandwidth_limit) {
> @@ -1399,6 +1424,8 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
>   		bandwidth = div_u64(bandwidth, mode->htotal * mode->vtotal);
>   
> -		if (dispc->memory_bandwidth_limit < bandwidth)
> +		if (dispc->memory_bandwidth_limit < bandwidth) {
> +			drm_dbg(dev, "Required memory bandwidth outside of hardware limits.");
>   			return MODE_BAD;
> +		}
>   	}
>   
> 

