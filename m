Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF492C79FB7
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 06:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F1410F2F8;
	Thu, 10 Sep 2026 06:19:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="xfT0KhTh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J/yJmeNx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="amGcVMHS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wsDvyjxl";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9F2B10F2D6
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 06:19:08 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 366441FD90;
 Thu, 10 Sep 2026 06:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789021143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nVLVc+IGXcOzgczLWJwX8qmORWyrGKhNdPGp1kdsM2E=;
 b=xfT0KhThSIutVmQj7awPGLTnr1FWECZpHpHsC6GLH5fcCfPhZr3jN7B9AjPUtzBsL3QNAp
 Z9ABvVNinFJ3JHDp/CBYy5XRw0p7VdlwO/WFeZFpzKE40F/mnxP+zuLMHqQeCaD5TjqgPR
 cxOd47vFieOPEWi7AznksYQJ8QycHMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789021143;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nVLVc+IGXcOzgczLWJwX8qmORWyrGKhNdPGp1kdsM2E=;
 b=J/yJmeNx2MDZP2q+MigOwLWIyWe5TO6Yhz+gHa3uUCu4Q7uXq1t1554J3TcvOzHSNED85w
 Z5gYlCgFuxqsdDAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789021139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nVLVc+IGXcOzgczLWJwX8qmORWyrGKhNdPGp1kdsM2E=;
 b=amGcVMHSP5X0T6lerl0EK/k0OxZwiEjdlbfsDG4H1d/WxwU4Q06UztUmTEEnpDoWvN2s/O
 iSPXTNheMJ/zTls2jXiWsxA39741ZHlHSdt0fEVRgkCfNlsYEouW8cjmIH8gjnV7hhf2zm
 CimZUurmShncyK4y9ZOiMUKISUlkwAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789021139;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nVLVc+IGXcOzgczLWJwX8qmORWyrGKhNdPGp1kdsM2E=;
 b=wsDvyjxl31NZHNJ3UDZOZUViKaoqSYhhPzPzYtWo3adlTqUKRkJ+vSS2VmVYKFtmflA3yi
 98gko85GAEBYOqAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A654313889;
 Thu, 10 Sep 2026 06:18:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3A1iJ9JLomqJFgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 10 Sep 2026 06:18:58 +0000
Message-ID: <25a054ed-fe77-47e2-8537-f572cb7fc9a8@suse.de>
Date: Thu, 10 Sep 2026 08:18:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/tiny: arcpgu: Replace simple display pipe with
 regular atomic helpers
To: Davide Bonatto <bonatto.davide@gmail.com>,
 Alexey Brodkin <abrodkin@synopsys.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260909092455.131962-1-bonatto.davide@gmail.com>
 <20260909125806.174851-1-bonatto.davide@gmail.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20260909125806.174851-1-bonatto.davide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MID_RHS_MATCH_FROM(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 TAGGED_RCPT(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,synopsys.com,linux.intel.com,kernel.org,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.com:url]
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

Please stop spamming this list with patch mails

Am 09.09.26 um 14:58 schrieb Davide Bonatto:
> The drm_simple_display_pipe helper is considered legacy/deprecated in
> favor of explicitly managing individual plane, CRTC, and encoder objects
> using standard atomic helpers.
>
> Migrate arcpgu to initialize its primary plane, CRTC, and encoder
> explicitly, and route mode validation, enable, and disable hooks
> through drm_crtc_helper_funcs, and plane updates through
> drm_plane_helper_funcs.
>
> Signed-off-by: Davide Bonatto <bonatto.davide@gmail.com>
> ---
> v5:
>    - Fix NULL pointer dereference in arc_pgu_crtc_atomic_check() by checking
>      crtc_state->plane_mask instead of manually querying plane state.
> v4:
>    - Use drm_atomic_get_plane_state() in CRTC .atomic_check to ensure
>      the primary plane state is attached and locked, avoiding false -EINVAL
>      rejections and broken partial atomic commits.
> v3:
>    - Add CRTC .atomic_check hook to validate primary plane presence
>      and avoid NULL pointer dereference in arc_pgu_set_pxl_fmt().
>    - Pass framebuffer explicitly to arc_pgu_mode_set() and read plane
>      state via drm_atomic_get_new_plane_state() in CRTC enable to prevent UAF.
>    - Keep CRTC global enable bit intact during plane disable to avoid
>      hardware state desync.
> v2:
>    - Add .prepare_fb callback to support implicit synchronization.
>    - Add .atomic_check using drm_atomic_helper_check_plane_state()
>      to validate hardware scaling/clipping constraints.
>    - Implement arc_pgu_plane_atomic_disable() to stop DMA and clear
>      buffer address register, preventing hardware DMA scanout UAF.
>
>   drivers/gpu/drm/tiny/arcpgu.c | 188 +++++++++++++++++++++++++++-------
>   1 file changed, 150 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
> index c93d61ac0bb7..c6308fee568d 100644
> --- a/drivers/gpu/drm/tiny/arcpgu.c
> +++ b/drivers/gpu/drm/tiny/arcpgu.c
> @@ -5,6 +5,8 @@
>    * Copyright (C) 2016 Synopsys, Inc. (www.synopsys.com)
>    */
>   
> +#include "drm/drm_gem_atomic_helper.h"
> +
>   #include <linux/clk.h>
>   
>   #include <drm/clients/drm_client_setup.h>
> @@ -23,6 +25,8 @@
>   #include <drm/drm_of.h>
>   #include <drm/drm_probe_helper.h>
>   #include <drm/drm_simple_kms_helper.h>
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_bridge.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/module.h>
>   #include <linux/of_reserved_mem.h>
> @@ -52,13 +56,17 @@ struct arcpgu_drm_private {
>   	struct drm_device	drm;
>   	void __iomem		*regs;
>   	struct clk		*clk;
> -	struct drm_simple_display_pipe pipe;
> +	struct drm_plane	plane;
> +	struct drm_crtc		crtc;
> +	struct drm_encoder	encoder;
>   	struct drm_connector	sim_conn;
>   };
>   
>   #define dev_to_arcpgu(x) container_of(x, struct arcpgu_drm_private, drm)
>   
> -#define pipe_to_arcpgu_priv(x) container_of(x, struct arcpgu_drm_private, pipe)
> +#define crtc_to_arcpgu_priv(x) container_of(x, struct arcpgu_drm_private, crtc)
> +
> +#define plane_to_arcpgu(x) container_of(x, struct arcpgu_drm_private, plane)
>   
>   static inline void arc_pgu_write(struct arcpgu_drm_private *arcpgu,
>   				 unsigned int reg, u32 value)
> @@ -115,14 +123,19 @@ static const u32 arc_pgu_supported_formats[] = {
>   	DRM_FORMAT_ARGB8888,
>   };
>   
> -static void arc_pgu_set_pxl_fmt(struct arcpgu_drm_private *arcpgu)
> +static void arc_pgu_set_pxl_fmt(struct arcpgu_drm_private *arcpgu,
> +				const struct drm_framebuffer *fb)
>   {
> -	const struct drm_framebuffer *fb = arcpgu->pipe.plane.state->fb;
> -	uint32_t pixel_format = fb->format->format;
> +	u32 pixel_format;
>   	u32 format = DRM_FORMAT_INVALID;
>   	int i;
>   	u32 reg_ctrl;
>   
> +	if (!fb)
> +		return;
> +
> +	pixel_format = fb->format->format;
> +
>   	for (i = 0; i < ARRAY_SIZE(arc_pgu_supported_formats); i++) {
>   		if (arc_pgu_supported_formats[i] == pixel_format)
>   			format = arc_pgu_supported_formats[i];
> @@ -139,10 +152,10 @@ static void arc_pgu_set_pxl_fmt(struct arcpgu_drm_private *arcpgu)
>   	arc_pgu_write(arcpgu, ARCPGU_REG_CTRL, reg_ctrl);
>   }
>   
> -static enum drm_mode_status arc_pgu_mode_valid(struct drm_simple_display_pipe *pipe,
> -					       const struct drm_display_mode *mode)
> +static enum drm_mode_status arc_pgu_crtc_mode_valid(struct drm_crtc *crtc,
> +						    const struct drm_display_mode *mode)
>   {
> -	struct arcpgu_drm_private *arcpgu = pipe_to_arcpgu_priv(pipe);
> +	struct arcpgu_drm_private *arcpgu = crtc_to_arcpgu_priv(crtc);
>   	long rate, clk_rate = mode->clock * 1000;
>   	long diff = clk_rate / 200; /* +-0.5% allowed by HDMI spec */
>   
> @@ -153,9 +166,10 @@ static enum drm_mode_status arc_pgu_mode_valid(struct drm_simple_display_pipe *p
>   	return MODE_NOCLOCK;
>   }
>   
> -static void arc_pgu_mode_set(struct arcpgu_drm_private *arcpgu)
> +static void arc_pgu_mode_set(struct arcpgu_drm_private *arcpgu,
> +			     const struct drm_framebuffer *fb)
>   {
> -	struct drm_display_mode *m = &arcpgu->pipe.crtc.state->adjusted_mode;
> +	struct drm_display_mode *m = &arcpgu->crtc.state->adjusted_mode;
>   	u32 val;
>   
>   	arc_pgu_write(arcpgu, ARCPGU_REG_FMT,
> @@ -189,54 +203,127 @@ static void arc_pgu_mode_set(struct arcpgu_drm_private *arcpgu)
>   	arc_pgu_write(arcpgu, ARCPGU_REG_STRIDE, 0);
>   	arc_pgu_write(arcpgu, ARCPGU_REG_START_SET, 1);
>   
> -	arc_pgu_set_pxl_fmt(arcpgu);
> +	arc_pgu_set_pxl_fmt(arcpgu, fb);
>   
>   	clk_set_rate(arcpgu->clk, m->crtc_clock * 1000);
>   }
>   
> -static void arc_pgu_enable(struct drm_simple_display_pipe *pipe,
> -			   struct drm_crtc_state *crtc_state,
> -			   struct drm_plane_state *plane_state)
> +static void arc_pgu_crtc_atomic_enable(struct drm_crtc *crtc,
> +				       struct drm_atomic_commit *state)
>   {
> -	struct arcpgu_drm_private *arcpgu = pipe_to_arcpgu_priv(pipe);
> +	struct arcpgu_drm_private *arcpgu = crtc_to_arcpgu_priv(crtc);
> +	struct drm_plane_state *plane_state =
> +		drm_atomic_get_new_plane_state(state, &arcpgu->plane);
> +	const struct drm_framebuffer *fb = plane_state ? plane_state->fb : NULL;
>   
> -	arc_pgu_mode_set(arcpgu);
> +	arc_pgu_mode_set(arcpgu, fb);
>   
>   	clk_prepare_enable(arcpgu->clk);
>   	arc_pgu_write(arcpgu, ARCPGU_REG_CTRL,
>   		      arc_pgu_read(arcpgu, ARCPGU_REG_CTRL) |
> -		      ARCPGU_CTRL_ENABLE_MASK);
> +		ARCPGU_CTRL_ENABLE_MASK);
>   }
>   
> -static void arc_pgu_disable(struct drm_simple_display_pipe *pipe)
> +static void arc_pgu_crtc_atomic_disable(struct drm_crtc *crtc,
> +					struct drm_atomic_commit *state)
>   {
> -	struct arcpgu_drm_private *arcpgu = pipe_to_arcpgu_priv(pipe);
> +	struct arcpgu_drm_private *arcpgu = crtc_to_arcpgu_priv(crtc);
>   
>   	clk_disable_unprepare(arcpgu->clk);
>   	arc_pgu_write(arcpgu, ARCPGU_REG_CTRL,
> -			      arc_pgu_read(arcpgu, ARCPGU_REG_CTRL) &
> -			      ~ARCPGU_CTRL_ENABLE_MASK);
> +		      arc_pgu_read(arcpgu, ARCPGU_REG_CTRL) &
> +		~ARCPGU_CTRL_ENABLE_MASK);
>   }
>   
> -static void arc_pgu_update(struct drm_simple_display_pipe *pipe,
> -			   struct drm_plane_state *state)
> +static void arc_pgu_plane_atomic_update(struct drm_plane *plane,
> +					struct drm_atomic_commit *state)
>   {
> -	struct arcpgu_drm_private *arcpgu;
> +	struct arcpgu_drm_private *arcpgu = plane_to_arcpgu(plane);
> +	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_gem_dma_object *gem;
>   
> -	if (!pipe->plane.state->fb)
> +	if (!new_plane_state->fb)
>   		return;
>   
> -	arcpgu = pipe_to_arcpgu_priv(pipe);
> -	gem = drm_fb_dma_get_gem_obj(pipe->plane.state->fb, 0);
> +	gem = drm_fb_dma_get_gem_obj(new_plane_state->fb, 0);
>   	arc_pgu_write(arcpgu, ARCPGU_REG_BUF0_ADDR, gem->dma_addr);
>   }
>   
> -static const struct drm_simple_display_pipe_funcs arc_pgu_pipe_funcs = {
> -	.update = arc_pgu_update,
> -	.mode_valid = arc_pgu_mode_valid,
> -	.enable	= arc_pgu_enable,
> -	.disable = arc_pgu_disable,
> +static void arc_pgu_plane_atomic_disable(struct drm_plane *plane,
> +					 struct drm_atomic_commit *state)
> +{
> +	struct arcpgu_drm_private *arcpgu = plane_to_arcpgu(plane);
> +
> +	arc_pgu_write(arcpgu, ARCPGU_REG_BUF0_ADDR, 0);
> +}
> +
> +static int arc_pgu_plane_atomic_check(struct drm_plane *plane,
> +				      struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
> +	struct drm_crtc_state *crtc_state;
> +
> +	if (!new_plane_state->crtc)
> +		return 0;
> +
> +	crtc_state = drm_atomic_get_new_crtc_state(state, new_plane_state->crtc);
> +	if (!crtc_state)
> +		return -EINVAL;
> +
> +	return drm_atomic_helper_check_plane_state(new_plane_state, crtc_state,
> +						   DRM_PLANE_NO_SCALING,
> +						   DRM_PLANE_NO_SCALING,
> +						   false, true);
> +}
> +
> +static int arc_pgu_crtc_atomic_check(struct drm_crtc *crtc,
> +				     struct drm_atomic_commit *state)
> +{
> +	struct drm_crtc_state *crct_state = drm_atomic_get_new_crtc_state(state, crtc);
> +
> +	if (!crct_state->enable)
> +		return 0;
> +
> +	if (!crct_state->plane_mask)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static const struct drm_crtc_helper_funcs arc_pgu_crtc_helper_funcs = {
> +	.mode_valid	= arc_pgu_crtc_mode_valid,
> +	.atomic_enable	= arc_pgu_crtc_atomic_enable,
> +	.atomic_disable = arc_pgu_crtc_atomic_disable,
> +	.atomic_check	= arc_pgu_crtc_atomic_check,
> +};
> +
> +static const struct drm_crtc_funcs arc_pgu_crtc_funcs = {
> +	.reset			= drm_atomic_helper_crtc_reset,
> +	.destroy		= drm_crtc_cleanup,
> +	.set_config		= drm_atomic_helper_set_config,
> +	.page_flip		= drm_atomic_helper_page_flip,
> +	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
> +	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
> +};
> +
> +static const struct drm_plane_helper_funcs arc_pgu_plane_helper_funcs = {
> +	.atomic_update	= arc_pgu_plane_atomic_update,
> +	.prepare_fb	= drm_gem_plane_helper_prepare_fb,
> +	.atomic_check	= arc_pgu_plane_atomic_check,
> +	.atomic_disable = arc_pgu_plane_atomic_disable,
> +};
> +
> +static const struct drm_plane_funcs arc_pgu_plane_funcs = {
> +	.update_plane = drm_atomic_helper_update_plane,
> +	.disable_plane = drm_atomic_helper_disable_plane,
> +	.destroy = drm_plane_cleanup,
> +	.reset = drm_atomic_helper_plane_reset,
> +	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
> +};
> +
> +static const struct drm_encoder_funcs arc_pgu_encoder_funcs = {
> +	.destroy = drm_encoder_cleanup
>   };
>   
>   static const struct drm_mode_config_funcs arcpgu_drm_modecfg_funcs = {
> @@ -301,13 +388,38 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
>   			return ret;
>   	}
>   
> -	ret = drm_simple_display_pipe_init(drm, &arcpgu->pipe, &arc_pgu_pipe_funcs,
> -					   arc_pgu_supported_formats,
> -					   ARRAY_SIZE(arc_pgu_supported_formats),
> -					   NULL, connector);
> +	ret = drm_universal_plane_init(drm, &arcpgu->plane, 0,
> +				       &arc_pgu_plane_funcs, arc_pgu_supported_formats,
> +				       ARRAY_SIZE(arc_pgu_supported_formats), NULL,
> +				       DRM_PLANE_TYPE_PRIMARY, NULL);
> +
>   	if (ret)
>   		return ret;
>   
> +	drm_plane_helper_add(&arcpgu->plane, &arc_pgu_plane_helper_funcs);
> +
> +	ret = drm_crtc_init_with_planes(drm, &arcpgu->crtc, &arcpgu->plane, NULL,
> +					&arc_pgu_crtc_funcs, NULL);
> +
> +	if (ret)
> +		return ret;
> +
> +	drm_crtc_helper_add(&arcpgu->crtc, &arc_pgu_crtc_helper_funcs);
> +
> +	ret = drm_encoder_init(drm, &arcpgu->encoder, &arc_pgu_encoder_funcs,
> +			       DRM_MODE_ENCODER_NONE, NULL);
> +
> +	if (ret)
> +		return ret;
> +
> +	arcpgu->encoder.possible_crtcs = drm_crtc_mask(&arcpgu->crtc);
> +
> +	if (connector) {
> +		ret = drm_connector_attach_encoder(connector, &arcpgu->encoder);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	if (encoder_node) {
>   		/* Locate drm bridge from the hdmi encoder DT node */
>   		struct drm_bridge *bridge __free(drm_bridge_put) =
> @@ -315,7 +427,7 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
>   		if (!bridge)
>   			return -EPROBE_DEFER;
>   
> -		ret = drm_simple_display_pipe_attach_bridge(&arcpgu->pipe, bridge);
> +		ret = drm_bridge_attach(&arcpgu->encoder, bridge, NULL, 0);
>   		if (ret)
>   			return ret;
>   	}
> @@ -342,7 +454,7 @@ static int arcpgu_show_pxlclock(struct seq_file *m, void *arg)
>   	struct drm_device *drm = node->minor->dev;
>   	struct arcpgu_drm_private *arcpgu = dev_to_arcpgu(drm);
>   	unsigned long clkrate = clk_get_rate(arcpgu->clk);
> -	unsigned long mode_clock = arcpgu->pipe.crtc.mode.crtc_clock * 1000;
> +	unsigned long mode_clock = arcpgu->crtc.mode.crtc_clock * 1000;
>   
>   	seq_printf(m, "hw  : %lu\n", clkrate);
>   	seq_printf(m, "mode: %lu\n", mode_clock);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


