Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADBCC44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAC0F10E80B;
	Mon,  6 Jul 2026 08:31:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Y8Pp2bIE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6u6uZVkl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y8Pp2bIE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6u6uZVkl";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07B3310E31E
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 08:31:49 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A83BD75C7E;
 Mon,  6 Jul 2026 08:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783326707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yBMVc7xwfp9NEqn2MR6jLvvNVPYQN2ceK1qG0SilURc=;
 b=Y8Pp2bIEJOvqFArQfafXNNlHCuvjUD4s8uc1Pe+piHq3MU/6m3LaJYAjbJ4DSxuo7jWfKt
 xnVW4/1lnJHBdOeGtDl65a0iOL9LZ2POaTTegnFndfPqKdc4XS2ypOpCzbjtnGGFqoF5qu
 5Ssr++QxgOKMtPzYPVpUU/3m6Euh4co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783326707;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yBMVc7xwfp9NEqn2MR6jLvvNVPYQN2ceK1qG0SilURc=;
 b=6u6uZVkls9RRmtQlb5EVzE7TvU+aIZ6nQTtEX+9yzBdSPezKwGMoFDSQxDmRFXEpyJcqTS
 YjEW4ePKxA1MXiCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783326707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yBMVc7xwfp9NEqn2MR6jLvvNVPYQN2ceK1qG0SilURc=;
 b=Y8Pp2bIEJOvqFArQfafXNNlHCuvjUD4s8uc1Pe+piHq3MU/6m3LaJYAjbJ4DSxuo7jWfKt
 xnVW4/1lnJHBdOeGtDl65a0iOL9LZ2POaTTegnFndfPqKdc4XS2ypOpCzbjtnGGFqoF5qu
 5Ssr++QxgOKMtPzYPVpUU/3m6Euh4co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783326707;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yBMVc7xwfp9NEqn2MR6jLvvNVPYQN2ceK1qG0SilURc=;
 b=6u6uZVkls9RRmtQlb5EVzE7TvU+aIZ6nQTtEX+9yzBdSPezKwGMoFDSQxDmRFXEpyJcqTS
 YjEW4ePKxA1MXiCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 160F5779AA;
 Mon,  6 Jul 2026 08:31:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 90i2A/NnS2rrMAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 06 Jul 2026 08:31:47 +0000
Message-ID: <4e35e133-364a-4743-9ca0-f0799bdf28f8@suse.de>
Date: Mon, 6 Jul 2026 10:31:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] drm/aspeed: replace struct drm_simple_display_pipe
 with regular atomic helpers
To: Ze Huang <ze.huang@oss.qualcomm.com>,
 Alexey Brodkin <abrodkin@synopsys.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>,
 Hans de Goede <hansg@kernel.org>, Alex Lanzano <lanzano.alex@gmail.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, xen-devel@lists.xenproject.org
References: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com>
 <20260705-drm-simple-kms-removal-v1-2-b4e1ca053623@oss.qualcomm.com>
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
In-Reply-To: <20260705-drm-simple-kms-removal-v1-2-b4e1ca053623@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWELVE(0.00)[22];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_TO(0.00)[oss.qualcomm.com,synopsys.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,jms.id.au,codeconstruct.com.au,nxp.com,pengutronix.de,epam.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, qualcomm.com:email]
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

common points from my arcgpu review applied here as well. See below for 
a new other things.

Am 04.07.26 um 20:31 schrieb Ze Huang:
> Replace simple display pipe with explicit plane, CRTC and encoder
> objects. Move callbacks to plane and CRTC helpers, with vblank handling
> through drm_crtc_funcs.
>
> This removes intermediate simple-pipe layer and uses standard atomic
> helper wiring.
>
> Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/aspeed/aspeed_gfx.h      |   5 +-
>   drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c | 156 +++++++++++++++++++++++--------
>   drivers/gpu/drm/aspeed/aspeed_gfx_drv.c  |   3 +-
>   3 files changed, 123 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx.h b/drivers/gpu/drm/aspeed/aspeed_gfx.h
> index 4e6a442c3886..a34811564c0d 100644
> --- a/drivers/gpu/drm/aspeed/aspeed_gfx.h
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx.h
> @@ -2,7 +2,6 @@
>   /* Copyright 2018 IBM Corporation */
>   
>   #include <drm/drm_device.h>
> -#include <drm/drm_simple_kms_helper.h>
>   
>   struct aspeed_gfx {
>   	struct drm_device		drm;
> @@ -17,7 +16,9 @@ struct aspeed_gfx {
>   	u32				throd_val;
>   	u32				scan_line_max;
>   
> -	struct drm_simple_display_pipe	pipe;
> +	struct drm_plane		plane;
> +	struct drm_crtc			crtc;
> +	struct drm_encoder		encoder;
>   	struct drm_connector		connector;
>   };
>   #define to_aspeed_gfx(x) container_of(x, struct aspeed_gfx, drm)
> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
> index 7877a57b8e26..3294795c31c4 100644
> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
> @@ -5,6 +5,8 @@
>   #include <linux/reset.h>
>   #include <linux/regmap.h>
>   
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
>   #include <drm/drm_device.h>
>   #include <drm/drm_fb_dma_helper.h>
>   #include <drm/drm_fourcc.h>
> @@ -12,20 +14,13 @@
>   #include <drm/drm_gem_atomic_helper.h>
>   #include <drm/drm_gem_dma_helper.h>
>   #include <drm/drm_panel.h>
> -#include <drm/drm_simple_kms_helper.h>
>   #include <drm/drm_vblank.h>
>   
>   #include "aspeed_gfx.h"
>   
> -static struct aspeed_gfx *
> -drm_pipe_to_aspeed_gfx(struct drm_simple_display_pipe *pipe)
> -{
> -	return container_of(pipe, struct aspeed_gfx, pipe);
> -}
> -

Please create a new helper

   struct drm_aspeed_gfx *to_aspeed_gfx(drm_device *drm)

that does the upcast.

>   static int aspeed_gfx_set_pixel_fmt(struct aspeed_gfx *priv, u32 *bpp)
>   {
> -	struct drm_crtc *crtc = &priv->pipe.crtc;
> +	struct drm_crtc *crtc = &priv->crtc;
>   	struct drm_device *drm = crtc->dev;
>   	const u32 format = crtc->primary->state->fb->format->format;
>   	u32 ctrl1;
> @@ -79,7 +74,7 @@ static void aspeed_gfx_disable_controller(struct aspeed_gfx *priv)
>   
>   static void aspeed_gfx_crtc_mode_set_nofb(struct aspeed_gfx *priv)
>   {
> -	struct drm_display_mode *m = &priv->pipe.crtc.state->adjusted_mode;
> +	struct drm_display_mode *m = &priv->crtc.state->adjusted_mode;
>   	u32 ctrl1, d_offset, t_count, bpp;
>   	int err;
>   
> @@ -139,33 +134,31 @@ static void aspeed_gfx_crtc_mode_set_nofb(struct aspeed_gfx *priv)
>   	writel(priv->throd_val, priv->base + CRT_THROD);
>   }
>   
> -static void aspeed_gfx_pipe_enable(struct drm_simple_display_pipe *pipe,
> -			      struct drm_crtc_state *crtc_state,
> -			      struct drm_plane_state *plane_state)
> +static void aspeed_gfx_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> +						 struct drm_atomic_commit *state)

Please see my comment on arcgpu for the new naming of 'state'.

>   {
> -	struct aspeed_gfx *priv = drm_pipe_to_aspeed_gfx(pipe);
> -	struct drm_crtc *crtc = &pipe->crtc;
> +	struct aspeed_gfx *priv = container_of(crtc, struct aspeed_gfx, crtc);

Please use  your helper  to_aspeed_gfx(crtc->dev)  to do the upcast.  
Here any in other places.

>   
>   	aspeed_gfx_crtc_mode_set_nofb(priv);
>   	aspeed_gfx_enable_controller(priv);
>   	drm_crtc_vblank_on(crtc);
>   }
>   
> -static void aspeed_gfx_pipe_disable(struct drm_simple_display_pipe *pipe)
> +static void aspeed_gfx_crtc_helper_atomic_disable(struct drm_crtc *crtc,
> +						  struct drm_atomic_commit *state)
>   {
> -	struct aspeed_gfx *priv = drm_pipe_to_aspeed_gfx(pipe);
> -	struct drm_crtc *crtc = &pipe->crtc;
> +	struct aspeed_gfx *priv = container_of(crtc, struct aspeed_gfx, crtc);

Another upcast issue

>   
>   	drm_crtc_vblank_off(crtc);
>   	aspeed_gfx_disable_controller(priv);
>   }
>   
> -static void aspeed_gfx_pipe_update(struct drm_simple_display_pipe *pipe,
> -				   struct drm_plane_state *plane_state)
> +static void aspeed_gfx_plane_helper_atomic_update(struct drm_plane *plane,
> +						  struct drm_atomic_commit *state)
>   {
> -	struct aspeed_gfx *priv = drm_pipe_to_aspeed_gfx(pipe);
> -	struct drm_crtc *crtc = &pipe->crtc;
> -	struct drm_framebuffer *fb = pipe->plane.state->fb;
> +	struct aspeed_gfx *priv = container_of(plane, struct aspeed_gfx, plane);

to_aspeed_gfx(plane->dev)

> +	struct drm_crtc *crtc = &priv->crtc;
> +	struct drm_framebuffer *fb = plane->state->fb;
>   	struct drm_pending_vblank_event *event;
>   	struct drm_gem_dma_object *gem;
>   
> @@ -190,9 +183,9 @@ static void aspeed_gfx_pipe_update(struct drm_simple_display_pipe *pipe,
>   	writel(gem->dma_addr, priv->base + CRT_ADDR);
>   }
>   
> -static int aspeed_gfx_enable_vblank(struct drm_simple_display_pipe *pipe)
> +static int aspeed_gfx_crtc_enable_vblank(struct drm_crtc *crtc)
>   {
> -	struct aspeed_gfx *priv = drm_pipe_to_aspeed_gfx(pipe);
> +	struct aspeed_gfx *priv = container_of(crtc, struct aspeed_gfx, crtc);
>   	u32 reg = readl(priv->base + CRT_CTRL1);
>   
>   	/* Clear pending VBLANK IRQ */
> @@ -204,9 +197,9 @@ static int aspeed_gfx_enable_vblank(struct drm_simple_display_pipe *pipe)
>   	return 0;
>   }
>   
> -static void aspeed_gfx_disable_vblank(struct drm_simple_display_pipe *pipe)
> +static void aspeed_gfx_crtc_disable_vblank(struct drm_crtc *crtc)
>   {
> -	struct aspeed_gfx *priv = drm_pipe_to_aspeed_gfx(pipe);
> +	struct aspeed_gfx *priv = container_of(crtc, struct aspeed_gfx, crtc);
>   	u32 reg = readl(priv->base + CRT_CTRL1);
>   
>   	reg &= ~CRT_CTRL_VERTICAL_INTR_EN;
> @@ -216,12 +209,75 @@ static void aspeed_gfx_disable_vblank(struct drm_simple_display_pipe *pipe)
>   	writel(reg | CRT_CTRL_VERTICAL_INTR_STS, priv->base + CRT_CTRL1);
>   }
>   
> -static const struct drm_simple_display_pipe_funcs aspeed_gfx_funcs = {
> -	.enable		= aspeed_gfx_pipe_enable,
> -	.disable	= aspeed_gfx_pipe_disable,
> -	.update		= aspeed_gfx_pipe_update,
> -	.enable_vblank	= aspeed_gfx_enable_vblank,
> -	.disable_vblank	= aspeed_gfx_disable_vblank,
> +static int aspeed_gfx_plane_helper_atomic_check(struct drm_plane *plane,
> +						struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
> +	struct drm_crtc *crtc = plane_state->crtc;
> +	struct drm_crtc_state *crtc_state = NULL;
> +	int ret;
> +
> +	if (crtc)
> +		crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> +
> +	ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
> +						  DRM_PLANE_NO_SCALING,
> +						  DRM_PLANE_NO_SCALING,
> +						  false, false);
> +	return ret;
> +}

Return directly.

> +
> +static const struct drm_plane_helper_funcs aspeed_gfx_plane_helper_funcs = {
> +	.prepare_fb	= drm_gem_plane_helper_prepare_fb,
> +	.atomic_check	= aspeed_gfx_plane_helper_atomic_check,
> +	.atomic_update	= aspeed_gfx_plane_helper_atomic_update,
> +};
> +
> +static const struct drm_plane_funcs aspeed_gfx_plane_funcs = {
> +	.update_plane		= drm_atomic_helper_update_plane,
> +	.disable_plane		= drm_atomic_helper_disable_plane,
> +	.destroy		= drm_plane_cleanup,
> +	.reset			= drm_atomic_helper_plane_reset,
> +	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
> +	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
> +};
> +
> +static int aspeed_gfx_crtc_helper_atomic_check(struct drm_crtc *crtc,
> +					       struct drm_atomic_commit *state)
> +{
> +	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> +	int ret;
> +
> +	if (!crtc_state->enable)
> +		goto out;
> +
> +	ret = drm_atomic_helper_check_crtc_primary_plane(crtc_state);
> +	if (ret)
> +		return ret;
> +
> +out:
> +	return drm_atomic_add_affected_planes(state, crtc);
> +}

See arcpgu on a possible style improvement.

Best regards
Thomas

> +
> +static const struct drm_crtc_helper_funcs aspeed_gfx_crtc_helper_funcs = {
> +	.atomic_check	= aspeed_gfx_crtc_helper_atomic_check,
> +	.atomic_enable	= aspeed_gfx_crtc_helper_atomic_enable,
> +	.atomic_disable	= aspeed_gfx_crtc_helper_atomic_disable,
> +};
> +
> +static const struct drm_crtc_funcs aspeed_gfx_crtc_funcs = {
> +	.reset			= drm_atomic_helper_crtc_reset,
> +	.destroy		= drm_crtc_cleanup,
> +	.set_config		= drm_atomic_helper_set_config,
> +	.page_flip		= drm_atomic_helper_page_flip,
> +	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
> +	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
> +	.enable_vblank		= aspeed_gfx_crtc_enable_vblank,
> +	.disable_vblank		= aspeed_gfx_crtc_disable_vblank,
> +};
> +
> +static const struct drm_encoder_funcs aspeed_gfx_encoder_funcs = {
> +	.destroy = drm_encoder_cleanup,
>   };
>   
>   static const uint32_t aspeed_gfx_formats[] = {
> @@ -232,10 +288,36 @@ static const uint32_t aspeed_gfx_formats[] = {
>   int aspeed_gfx_create_pipe(struct drm_device *drm)
>   {
>   	struct aspeed_gfx *priv = to_aspeed_gfx(drm);
> +	struct drm_plane *plane = &priv->plane;
> +	struct drm_crtc *crtc = &priv->crtc;
> +	struct drm_encoder *encoder = &priv->encoder;
> +	int ret;
> +
> +	ret = drm_universal_plane_init(drm, plane, 0,
> +				       &aspeed_gfx_plane_funcs,
> +				       aspeed_gfx_formats,
> +				       ARRAY_SIZE(aspeed_gfx_formats),
> +				       NULL,
> +				       DRM_PLANE_TYPE_PRIMARY, NULL);
> +	if (ret)
> +		return ret;
> +	drm_plane_helper_add(plane, &aspeed_gfx_plane_helper_funcs);
> +
> +	ret = drm_crtc_init_with_planes(drm, crtc, plane, NULL,
> +					&aspeed_gfx_crtc_funcs, NULL);
> +	if (ret)
> +		return ret;
> +	drm_crtc_helper_add(crtc, &aspeed_gfx_crtc_helper_funcs);
> +
> +	ret = drm_encoder_init(drm, encoder, &aspeed_gfx_encoder_funcs,
> +			       DRM_MODE_ENCODER_NONE, NULL);
> +	if (ret)
> +		return ret;
> +	encoder->possible_crtcs = drm_crtc_mask(crtc);
> +
> +	ret = drm_connector_attach_encoder(&priv->connector, encoder);
> +	if (ret)
> +		return ret;
>   
> -	return drm_simple_display_pipe_init(drm, &priv->pipe, &aspeed_gfx_funcs,
> -					    aspeed_gfx_formats,
> -					    ARRAY_SIZE(aspeed_gfx_formats),
> -					    NULL,
> -					    &priv->connector);
> +	return 0;
>   }
> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> index 46094cca2974..b2d805f0c16d 100644
> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> @@ -21,7 +21,6 @@
>   #include <drm/drm_gem_framebuffer_helper.h>
>   #include <drm/drm_module.h>
>   #include <drm/drm_probe_helper.h>
> -#include <drm/drm_simple_kms_helper.h>
>   #include <drm/drm_vblank.h>
>   #include <drm/drm_drv.h>
>   
> @@ -130,7 +129,7 @@ static irqreturn_t aspeed_gfx_irq_handler(int irq, void *data)
>   	reg = readl(priv->base + CRT_CTRL1);
>   
>   	if (reg & CRT_CTRL_VERTICAL_INTR_STS) {
> -		drm_crtc_handle_vblank(&priv->pipe.crtc);
> +		drm_crtc_handle_vblank(&priv->crtc);
>   		writel(reg, priv->base + priv->int_clr_reg);
>   		return IRQ_HANDLED;
>   	}
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


