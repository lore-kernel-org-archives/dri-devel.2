Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7DEC624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 03:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42B4810E42D;
	Wed,  2 Sep 2026 03:55:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="hXkxYRGU";
	dkim-atps=neutral
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Wed, 02 Sep 2026 03:55:42 UTC
Received: from mail-m2447.xmail.ntesmail.com (mail-m2447.xmail.ntesmail.com
 [45.195.24.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72BA410E42D
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 03:55:42 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4c3421b99;
 Wed, 2 Sep 2026 11:50:36 +0800 (GMT+08:00)
Message-ID: <02c265f6-0898-4f11-9954-df7d99d082a0@rock-chips.com>
Date: Wed, 2 Sep 2026 11:50:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/rockchip: vop: don't round the pixel clock when
 the encoder owns the PLL
To: Vasily Khoruzhick <anarsoul@gmail.com>
References: <20260901234351.190506-1-anarsoul@gmail.com>
 <20260901234351.190506-2-anarsoul@gmail.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Heiko Stuebner <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260901234351.190506-2-anarsoul@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa0603d78cf03a7kunmd4641de6777468
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHk5LVkNDHkgdTE5DT0hJSVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=hXkxYRGUTNJ+EBFYZebUMPOQYzzXe0YgsR8/U+uLudyOlqvb6h4/nQ3d0FlZP/epUPQcRw2jCIwm4l27p20zvzXm383NwFlzVKkBUJS9rIgpL8STUGEzZAovXw7AkVWlO8yUJa9wk1tUqUlk0/w1deu7s0LqsKAjsG9tRtPiyT4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=eO9EKqCmJNfj/s/4A4JryqayHbddHlXAMJmfe1dVe0A=;
 h=date:mime-version:subject:message-id:from;
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

Hello Vasily,

On 9/2/2026 7:42 AM, Vasily Khoruzhick wrote:
> On RK3399 the HDMI reference clock is VPLL, a dedicated PLL that is a
> parent of the VOP dclk. dw_hdmi_rockchip_mode_valid() accepts a mode
> only if VPLL can produce its pixel clock, and encoder mode_set() then
> programs VPLL to that rate. However vop_crtc_mode_fixup() ran first,
> in the check phase, and rounded adjusted_mode->clock through
> clk_round_rate() on the dclk. At that point VPLL still sits at its
> previous rate, so the dclk composite picks whichever of VPLL/CPLL/GPLL
> gets closest at its *current* rate and stores that inexact value.
> 

Why did vop_crtc_mode_fixup() run first? Within drm_atomic_helper_check_modeset(), 
mode_valid() is executed before mode_fixup().

> For 1366x768 (85.5 MHz) this yields GPLL/7 = 84.857 MHz. mode_set()
> then requests 84.857 MHz from VPLL, which the PLL rate table snaps
> down to 74.25 MHz, and the VOP ends up on GPLL/7. The panel receives a
> timing 0.75% slow, which some monitors misdetect (e.g. as 1195x768)
> and display distorted. Only modes whose clock happens to be an exact
> GPLL or CPLL fraction (74.25, 148.5, 297 MHz, ...) were unaffected.
>

Did you designate VPLL as the parent clock of the VOP dclk in the DTS?

> Let the encoder tell the CRTC, via a new rockchip_crtc_state flag set
> in its atomic_check, that it will program a dedicated dclk parent to
> exactly the requested pixel clock. Move the rounding from mode_fixup
> to atomic_check, which runs after the encoder's atomic_check as
> recommended by the DRM documentation, and skip it when the flag is
> set. With VPLL then set to the exact rate before the VOP enables,
> clk_set_rate() on the dclk finds an exact match on VPLL.
> 
> The flag is only meaningful within the check that sets it and is
> cleared when the state is duplicated, so it cannot leak into a later
> modeset on the same CRTC with a different encoder. Behaviour for
> encoders without a dedicated PLL is unchanged.
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c |  8 ++++++-
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  9 ++++++++
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 25 +++++++++++++++------
>  3 files changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> index b6e154c35e7c..ece44c6ec95c 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> @@ -300,8 +300,8 @@ dw_hdmi_rockchip_encoder_atomic_check(struct drm_encoder *encoder,
>  				      struct drm_crtc_state *crtc_state,
>  				      struct drm_connector_state *conn_state)
>  {
> -	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
>  	struct rockchip_hdmi *hdmi = to_rockchip_hdmi(encoder);
> +	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
>  	union phy_configure_opts opts = {};
>  	u32 bus_format;
>  
> @@ -327,6 +327,12 @@ dw_hdmi_rockchip_encoder_atomic_check(struct drm_encoder *encoder,
>  
>  	s->output_type = DRM_MODE_CONNECTOR_HDMIA;
>  	s->bus_format = bus_format;
> +	/*
> +	 * The reference clock (e.g. VPLL on RK3399) is a parent of the VOP
> +	 * dclk, and mode_set() programs it to the pixel clock, which
> +	 * mode_valid() already guaranteed it can produce.
> +	 */
> +	s->dclk_exact = !!hdmi->ref_clk;
> 

What about RK3328? It uses hdmi->hdmiphy_clk.


>  	if (!hdmi->phy || !conn_state->hdmi.tmds_char_rate)
>  		return 0;
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> index 4705dc6b8bd7..8cb828ae9af6 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> @@ -57,6 +57,15 @@ struct rockchip_crtc_state {
>  	u32 bus_format;
>  	u32 bus_flags;
>  	int color_space;
> +	/*
> +	 * Set by an encoder's atomic_check when it owns a dedicated PLL that
> +	 * feeds the CRTC's dclk and will program it to exactly
> +	 * adjusted_mode->clock at mode_set time. The CRTC must then not
> +	 * round the pixel clock against the current clock tree, which does
> +	 * not reflect that PLL's future rate. Only valid within one check,
> +	 * it is cleared when the state is duplicated.
> +	 */
> +	bool dclk_exact;
>  };
>  #define to_rockchip_crtc_state(s) \
>  		container_of(s, struct rockchip_crtc_state, base)
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 0090d8ff0c79..73a92ccbcb94 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -1207,11 +1207,9 @@ static enum drm_mode_status vop_crtc_mode_valid(struct drm_crtc *crtc,
>  	return MODE_OK;
>  }
>  
> -static bool vop_crtc_mode_fixup(struct drm_crtc *crtc,
> -				const struct drm_display_mode *mode,
> -				struct drm_display_mode *adjusted_mode)
> +static void vop_crtc_adjust_clock(struct vop *vop,
> +				  struct drm_display_mode *adjusted_mode)
>  {
> -	struct vop *vop = to_vop(crtc);
>  	unsigned long rate;
>  
>  	/*
> @@ -1245,8 +1243,6 @@ static bool vop_crtc_mode_fixup(struct drm_crtc *crtc,
>  		rate = clk_round_rate(vop->dclk,
>  				      adjusted_mode->clock * 1000 + 999);
>  	adjusted_mode->clock = DIV_ROUND_UP(rate, 1000);
> -
> -	return true;
>  }
>  
>  static bool vop_dsp_lut_is_enabled(struct vop *vop)
> @@ -1558,6 +1554,19 @@ static int vop_crtc_atomic_check(struct drm_crtc *crtc,
>  	s = to_rockchip_crtc_state(crtc_state);
>  	s->enable_afbc = afbc_planes > 0;
>  
> +	/*
> +	 * Round the pixel clock to what the dclk can really produce, unless
> +	 * the encoder will program a dedicated dclk parent PLL to exactly
> +	 * this rate at mode_set time. In that case the clock tree seen here
> +	 * (with that PLL still at its old rate) would pick a worse, inexact
> +	 * source and bake that rate into adjusted_mode, defeating the PLL.
> +	 *
> +	 * Same condition the atomic helpers use for the mode_fixup callback.
> +	 */
> +	if ((crtc_state->mode_changed || crtc_state->connectors_changed) &&
> +	    !s->dclk_exact)
> +		vop_crtc_adjust_clock(vop, &crtc_state->adjusted_mode);
> +
>  	return 0;
>  }
> 

What about other display interfaces? For example, the .mode_fixup 
corresponding to cdn-dp will not be called.

> @@ -1623,7 +1632,6 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
>  
>  static const struct drm_crtc_helper_funcs vop_crtc_helper_funcs = {
>  	.mode_valid = vop_crtc_mode_valid,
> -	.mode_fixup = vop_crtc_mode_fixup,
>  	.atomic_check = vop_crtc_atomic_check,
>  	.atomic_begin = vop_crtc_atomic_begin,
>  	.atomic_flush = vop_crtc_atomic_flush,
> @@ -1643,6 +1651,9 @@ static struct drm_crtc_state *vop_crtc_duplicate_state(struct drm_crtc *crtc)
>  	if (!rockchip_state)
>  		return NULL;
>  
> +	/* Only valid within the check phase that sets it. */
> +	rockchip_state->dclk_exact = false;
> +
>  	__drm_atomic_helper_crtc_duplicate_state(crtc, &rockchip_state->base);
>  	return &rockchip_state->base;
>  }

-- 
Best, 
Chaoyi
