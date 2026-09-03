Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046C8C624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D73B10F50D;
	Thu,  3 Sep 2026 10:53:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="usUeMIii";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E40BE10F50D
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 10:53:26 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6E57B2335;
 Thu,  3 Sep 2026 12:51:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788432713;
 bh=pPLn8AajgOA0NudMomsdMRz+fMVynaZRSOcM8YEekmk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=usUeMIiigXwMVFb2jnbq5rwbL/qU5HD9Yovp4GwkAUvRa6jAkz8Y3XAuL6+mS4+JG
 hM+AHArh9JviJoced862gtsdeeoEbeBt0Xli3BhGx3RBov/ALVQOOK4g9csHAz4MPs
 rnMFSeJz61Zz/+2JSh9Sk0JYQTQXhG4oogxcIuv8=
Message-ID: <85ce561d-fd2b-4705-9136-0173670e9148@ideasonboard.com>
Date: Thu, 3 Sep 2026 13:53:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tidss: dispc: Switch to drm_fb_dma_get_gem_addr() for
 framebuffer addresses
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jyri Sarha <jyri.sarha@iki.fi>
References: <20260903063142.3770509-1-wenst@chromium.org>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20260903063142.3770509-1-wenst@chromium.org>
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

Hi,

On 03/09/2026 09:31, Chen-Yu Tsai wrote:
> dispc_plane_state_dma_addr() and dispc_plane_state_p_uv_addr() are
> basically the same as drm_fb_dma_get_addr(), without the support for

drm_fb_dma_get_gem_addr()

> formats with block parameters. Since the driver doesn't support any of
> those formats, the result is the same.
> 
> Switch to drm_fb_dma_get_gem_addr() for getting the framebuffer addresses.
> Drop the const modifier on "struct drm_plane_state *state" for
> dispc_plane_setup() so that the state can be passed to
> drm_fb_dma_get_gem_addr().

Or add const modifier to drm_fb_dma_get_gem_addr(). But it's ok either way.

> Using the helper also future proofs the driver in case block parameters
> are added for more formats, especially the common sub-sampled YUV
> formats.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   drivers/gpu/drm/tidss/tidss_dispc.c | 38 +++--------------------------
>   drivers/gpu/drm/tidss/tidss_dispc.h |  2 +-
>   2 files changed, 4 insertions(+), 36 deletions(-)

Looks good to me. I can pick this up and fix the above typo while 
applying, or wait for v2 if you want to do something about the const.

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index 58d5eb033bdb..2a0ec11a6c90 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -2157,47 +2157,15 @@ int dispc_plane_check(struct dispc_device *dispc, u32 hw_plane,
>   	return 0;
>   }
>   
> -static
> -dma_addr_t dispc_plane_state_dma_addr(const struct drm_plane_state *state)
> -{
> -	struct drm_framebuffer *fb = state->fb;
> -	struct drm_gem_dma_object *gem;
> -	u32 x = state->src_x >> 16;
> -	u32 y = state->src_y >> 16;
> -
> -	gem = drm_fb_dma_get_gem_obj(state->fb, 0);
> -
> -	return gem->dma_addr + fb->offsets[0] + x * fb->format->cpp[0] +
> -		y * fb->pitches[0];
> -}
> -
> -static
> -dma_addr_t dispc_plane_state_p_uv_addr(const struct drm_plane_state *state)
> -{
> -	struct drm_framebuffer *fb = state->fb;
> -	struct drm_gem_dma_object *gem;
> -	u32 x = state->src_x >> 16;
> -	u32 y = state->src_y >> 16;
> -
> -	if (WARN_ON(state->fb->format->num_planes != 2))
> -		return 0;
> -
> -	gem = drm_fb_dma_get_gem_obj(fb, 1);
> -
> -	return gem->dma_addr + fb->offsets[1] +
> -		(x * fb->format->cpp[1] / fb->format->hsub) +
> -		(y * fb->pitches[1] / fb->format->vsub);
> -}
> -
>   void dispc_plane_setup(struct dispc_device *dispc, u32 hw_plane,
> -		       const struct drm_plane_state *state,
> +		       struct drm_plane_state *state,
>   		       u32 hw_videoport)
>   {
>   	bool lite = dispc->feat->vid_info[hw_plane].is_lite;
>   	u32 fourcc = state->fb->format->format;
>   	u16 cpp = state->fb->format->cpp[0];
>   	u32 fb_width = state->fb->pitches[0] / cpp;
> -	dma_addr_t dma_addr = dispc_plane_state_dma_addr(state);
> +	dma_addr_t dma_addr = drm_fb_dma_get_gem_addr(state->fb, state, 0);
>   	struct dispc_scaling_params scale;
>   
>   	dispc_vid_calc_scaling(dispc, state, &scale, lite);
> @@ -2229,7 +2197,7 @@ void dispc_plane_setup(struct dispc_device *dispc, u32 hw_plane,
>   	if (state->fb->format->num_planes == 2) {
>   		u16 cpp_uv = state->fb->format->cpp[1];
>   		u32 fb_width_uv = state->fb->pitches[1] / cpp_uv;
> -		dma_addr_t p_uv_addr = dispc_plane_state_p_uv_addr(state);
> +		dma_addr_t p_uv_addr = drm_fb_dma_get_gem_addr(state->fb, state, 1);
>   
>   		dispc_vid_write(dispc, hw_plane,
>   				DISPC_VID_BA_UV_0, p_uv_addr & 0xffffffff);
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
> index 739d211d0018..2183254f1ab7 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.h
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.h
> @@ -140,7 +140,7 @@ int dispc_plane_check(struct dispc_device *dispc, u32 hw_plane,
>   		      const struct drm_plane_state *state,
>   		      u32 hw_videoport);
>   void dispc_plane_setup(struct dispc_device *dispc, u32 hw_plane,
> -		       const struct drm_plane_state *state,
> +		       struct drm_plane_state *state,
>   		       u32 hw_videoport);
>   void dispc_plane_enable(struct dispc_device *dispc, u32 hw_plane, bool enable);
>   const u32 *dispc_plane_formats(struct dispc_device *dispc, unsigned int *len);

