Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E2CC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 13:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50DFB10E5DC;
	Wed,  8 Jul 2026 13:03:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="VGWGn+Y+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6dGjxnbX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VGWGn+Y+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6dGjxnbX";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CEE810E5DC
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 13:03:48 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 861A076026;
 Wed,  8 Jul 2026 13:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783515826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vx4MUMUPW+cvPFm4OHv8pg1uFv77h5nfjhtL0ZgDfqs=;
 b=VGWGn+Y+Ub/X3cWSoJx8lW+U782iCaR6v0WNvUoyKlJJBqCQDVerhihUhqseGWx71cxd3h
 R5e0TjYUw3agBeehXrNv0Zy/v1dpPCoOnZZ7UpmQf4g/h3oRpemM8XBiv1AwhQDc4kxQLz
 wGPSjrD1Bx0weLl4UmP2PD5e0iZvFpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783515826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vx4MUMUPW+cvPFm4OHv8pg1uFv77h5nfjhtL0ZgDfqs=;
 b=6dGjxnbXJR4C1BA/EXMtjuhVIxLXQ+bWkbQPZ79XzVKw0WY2BJan/2JQ+1mtbvhGAzLjtt
 0ZOtOIOAUh5OIpDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VGWGn+Y+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6dGjxnbX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783515826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vx4MUMUPW+cvPFm4OHv8pg1uFv77h5nfjhtL0ZgDfqs=;
 b=VGWGn+Y+Ub/X3cWSoJx8lW+U782iCaR6v0WNvUoyKlJJBqCQDVerhihUhqseGWx71cxd3h
 R5e0TjYUw3agBeehXrNv0Zy/v1dpPCoOnZZ7UpmQf4g/h3oRpemM8XBiv1AwhQDc4kxQLz
 wGPSjrD1Bx0weLl4UmP2PD5e0iZvFpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783515826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vx4MUMUPW+cvPFm4OHv8pg1uFv77h5nfjhtL0ZgDfqs=;
 b=6dGjxnbXJR4C1BA/EXMtjuhVIxLXQ+bWkbQPZ79XzVKw0WY2BJan/2JQ+1mtbvhGAzLjtt
 0ZOtOIOAUh5OIpDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCF9C779AE;
 Wed,  8 Jul 2026 13:03:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0NupNLFKTmoOLQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 08 Jul 2026 13:03:45 +0000
Message-ID: <747ae980-9358-4e15-84e3-6e2f3e143423@suse.de>
Date: Wed, 8 Jul 2026 15:03:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] drm/pl111: replace struct drm_simple_display_pipe
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
 <20260705-drm-simple-kms-removal-v1-5-b4e1ca053623@oss.qualcomm.com>
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
In-Reply-To: <20260705-drm-simple-kms-removal-v1-5-b4e1ca053623@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWELVE(0.00)[22];
 FREEMAIL_TO(0.00)[oss.qualcomm.com,synopsys.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,jms.id.au,codeconstruct.com.au,nxp.com,pengutronix.de,epam.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:mid, suse.de:dkim, qualcomm.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 861A076026
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



Am 04.07.26 um 20:31 schrieb Ze Huang:
> Replace PL111 simple display pipe with explicit plane, CRTC and encoder
> objects.
>
> Keep existing hardware programming and vblank behavior, and install GEM
> framebuffer prepare helper explicitly.
>
> Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/pl111/pl111_display.c | 174 ++++++++++++++++++++++++++--------
>   drivers/gpu/drm/pl111/pl111_drm.h     |   5 +-
>   drivers/gpu/drm/pl111/pl111_drv.c     |   3 +-
>   3 files changed, 136 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
> index 5d10bc5fdf1f..b1bdd4c9dbe6 100644
> --- a/drivers/gpu/drm/pl111/pl111_display.c
> +++ b/drivers/gpu/drm/pl111/pl111_display.c
> @@ -15,6 +15,7 @@
>   #include <linux/media-bus-format.h>
>   #include <linux/of_graph.h>
>   
> +#include <drm/drm_atomic_helper.h>
>   #include <drm/drm_fb_dma_helper.h>
>   #include <drm/drm_fourcc.h>
>   #include <drm/drm_framebuffer.h>
> @@ -37,7 +38,7 @@ irqreturn_t pl111_irq(int irq, void *data)
>   		return IRQ_NONE;
>   
>   	if (irq_stat & CLCD_IRQ_NEXTBASE_UPDATE) {
> -		drm_crtc_handle_vblank(&priv->pipe.crtc);
> +		drm_crtc_handle_vblank(&priv->crtc);
>   
>   		status = IRQ_HANDLED;
>   	}
> @@ -49,10 +50,10 @@ irqreturn_t pl111_irq(int irq, void *data)
>   }
>   
>   static enum drm_mode_status
> -pl111_mode_valid(struct drm_simple_display_pipe *pipe,
> -		 const struct drm_display_mode *mode)
> +pl111_crtc_helper_mode_valid(struct drm_crtc *crtc,
> +			     const struct drm_display_mode *mode)
>   {
> -	struct drm_device *drm = pipe->crtc.dev;
> +	struct drm_device *drm = crtc->dev;
>   	struct pl111_drm_dev_private *priv = drm->dev_private;
>   	u32 cpp = DIV_ROUND_UP(priv->variant->fb_depth, 8);
>   	u64 bw;
> @@ -83,13 +84,35 @@ pl111_mode_valid(struct drm_simple_display_pipe *pipe,
>   	return MODE_OK;
>   }
>   
> -static int pl111_display_check(struct drm_simple_display_pipe *pipe,
> -			       struct drm_plane_state *pstate,
> -			       struct drm_crtc_state *cstate)
> +static int pl111_plane_helper_atomic_check(struct drm_plane *plane,
> +					   struct drm_atomic_commit *state)
>   {
> -	const struct drm_display_mode *mode = &cstate->mode;
> -	struct drm_framebuffer *old_fb = pipe->plane.state->fb;
> +	struct drm_plane_state *pstate = drm_atomic_get_new_plane_state(state, plane);
> +	struct drm_crtc *crtc = pstate->crtc;
> +	struct drm_crtc_state *cstate;
> +	const struct drm_display_mode *mode;
> +	struct drm_framebuffer *old_fb = plane->state->fb;
>   	struct drm_framebuffer *fb = pstate->fb;
> +	int ret;
> +
> +	if (!crtc)
> +		return 0;
> +
> +	cstate = drm_atomic_get_new_crtc_state(state, crtc);
> +	if (!cstate)
> +		return 0;
> +
> +	ret = drm_atomic_helper_check_plane_state(pstate, cstate,
> +						  DRM_PLANE_NO_SCALING,
> +						  DRM_PLANE_NO_SCALING,
> +						  false, false);

This is another case of _check_plane_state() running conditionally.

> +	if (ret)
> +		return ret;
> +
> +	if (!pstate->visible)
> +		return 0;
> +
> +	mode = &cstate->mode;
>   
>   	if (mode->hdisplay % 16)
>   		return -EINVAL;
> @@ -117,16 +140,14 @@ static int pl111_display_check(struct drm_simple_display_pipe *pipe,
>   	return 0;
>   }
>   
> -static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
> -				 struct drm_crtc_state *cstate,
> -				 struct drm_plane_state *plane_state)
> +static void pl111_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> +					    struct drm_atomic_commit *state)
>   {
> -	struct drm_crtc *crtc = &pipe->crtc;
> -	struct drm_plane *plane = &pipe->plane;
>   	struct drm_device *drm = crtc->dev;
>   	struct pl111_drm_dev_private *priv = drm->dev_private;
> +	struct drm_crtc_state *cstate = crtc->state;
>   	const struct drm_display_mode *mode = &cstate->mode;
> -	struct drm_framebuffer *fb = plane->state->fb;
> +	struct drm_framebuffer *fb = priv->plane.state->fb;
>   	struct drm_connector *connector = priv->connector;
>   	struct drm_bridge *bridge = priv->bridge;
>   	bool grayscale = false;
> @@ -355,9 +376,9 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
>   		drm_crtc_vblank_on(crtc);
>   }
>   
> -static void pl111_display_disable(struct drm_simple_display_pipe *pipe)
> +static void pl111_crtc_helper_atomic_disable(struct drm_crtc *crtc,
> +					     struct drm_atomic_commit *state)
>   {
> -	struct drm_crtc *crtc = &pipe->crtc;
>   	struct drm_device *drm = crtc->dev;
>   	struct pl111_drm_dev_private *priv = drm->dev_private;
>   	u32 cntl;
> @@ -387,17 +408,23 @@ static void pl111_display_disable(struct drm_simple_display_pipe *pipe)
>   	clk_disable_unprepare(priv->clk);
>   }
>   
> -static void pl111_display_update(struct drm_simple_display_pipe *pipe,
> -				 struct drm_plane_state *old_pstate)
> +static void pl111_plane_helper_atomic_update(struct drm_plane *plane,
> +					     struct drm_atomic_commit *state)
>   {
> -	struct drm_crtc *crtc = &pipe->crtc;
> -	struct drm_device *drm = crtc->dev;
> -	struct pl111_drm_dev_private *priv = drm->dev_private;
> -	struct drm_pending_vblank_event *event = crtc->state->event;
> -	struct drm_plane *plane = &pipe->plane;
> +	struct drm_crtc *crtc = plane->state->crtc;
> +	struct drm_device *drm;
> +	struct pl111_drm_dev_private *priv;
> +	struct drm_pending_vblank_event *event;
>   	struct drm_plane_state *pstate = plane->state;
>   	struct drm_framebuffer *fb = pstate->fb;
>   
> +	if (!crtc)
> +		return;
> +
> +	drm = crtc->dev;
> +	priv = drm->dev_private;
> +	event = crtc->state->event;
> +
>   	if (fb) {
>   		u32 addr = drm_fb_dma_get_gem_addr(fb, pstate, 0);
>   
> @@ -416,9 +443,8 @@ static void pl111_display_update(struct drm_simple_display_pipe *pipe,
>   	}
>   }
>   
> -static int pl111_display_enable_vblank(struct drm_simple_display_pipe *pipe)
> +static int pl111_display_enable_vblank(struct drm_crtc *crtc)
>   {
> -	struct drm_crtc *crtc = &pipe->crtc;
>   	struct drm_device *drm = crtc->dev;
>   	struct pl111_drm_dev_private *priv = drm->dev_private;
>   
> @@ -427,21 +453,63 @@ static int pl111_display_enable_vblank(struct drm_simple_display_pipe *pipe)
>   	return 0;
>   }
>   
> -static void pl111_display_disable_vblank(struct drm_simple_display_pipe *pipe)
> +static void pl111_display_disable_vblank(struct drm_crtc *crtc)
>   {
> -	struct drm_crtc *crtc = &pipe->crtc;
>   	struct drm_device *drm = crtc->dev;
>   	struct pl111_drm_dev_private *priv = drm->dev_private;
>   
>   	writel(0, priv->regs + priv->ienb);
>   }
>   
> -static struct drm_simple_display_pipe_funcs pl111_display_funcs = {
> -	.mode_valid = pl111_mode_valid,
> -	.check = pl111_display_check,
> -	.enable = pl111_display_enable,
> -	.disable = pl111_display_disable,
> -	.update = pl111_display_update,
> +static int pl111_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *state)
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
> +
> +static struct drm_crtc_funcs pl111_crtc_funcs = {
> +	.reset			= drm_atomic_helper_crtc_reset,
> +	.destroy		= drm_crtc_cleanup,
> +	.set_config		= drm_atomic_helper_set_config,
> +	.page_flip		= drm_atomic_helper_page_flip,
> +	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
> +	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
> +};
> +
> +static const struct drm_crtc_helper_funcs pl111_crtc_helper_funcs = {
> +	.mode_valid	= pl111_crtc_helper_mode_valid,
> +	.atomic_check	= pl111_crtc_helper_atomic_check,
> +	.atomic_enable	= pl111_crtc_helper_atomic_enable,
> +	.atomic_disable	= pl111_crtc_helper_atomic_disable,
> +};
> +
> +static const struct drm_plane_funcs pl111_plane_funcs = {
> +	.update_plane		= drm_atomic_helper_update_plane,
> +	.disable_plane		= drm_atomic_helper_disable_plane,
> +	.reset			= drm_atomic_helper_plane_reset,
> +	.destroy		= drm_plane_cleanup,
> +	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
> +	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
> +};
> +
> +static const struct drm_plane_helper_funcs pl111_plane_helper_funcs = {
> +	.prepare_fb	= drm_gem_plane_helper_prepare_fb,
> +	.atomic_check	= pl111_plane_helper_atomic_check,
> +	.atomic_update	= pl111_plane_helper_atomic_update,
> +};
> +
> +static const struct drm_encoder_funcs pl111_encoder_funcs = {
> +	.destroy = drm_encoder_cleanup,
>   };
>   
>   static int pl111_clk_div_choose_div(struct clk_hw *hw, unsigned long rate,
> @@ -583,18 +651,40 @@ int pl111_display_init(struct drm_device *drm)
>   		return ret;
>   
>   	if (!priv->variant->broken_vblank) {
> -		pl111_display_funcs.enable_vblank = pl111_display_enable_vblank;
> -		pl111_display_funcs.disable_vblank = pl111_display_disable_vblank;
> +		pl111_crtc_funcs.enable_vblank = pl111_display_enable_vblank;
> +		pl111_crtc_funcs.disable_vblank = pl111_display_disable_vblank;
>   	}
>   
> -	ret = drm_simple_display_pipe_init(drm, &priv->pipe,
> -					   &pl111_display_funcs,
> -					   priv->variant->formats,
> -					   priv->variant->nformats,
> -					   NULL,
> -					   priv->connector);
> +	ret = drm_universal_plane_init(drm, &priv->plane, 0,
> +				       &pl111_plane_funcs,
> +				       priv->variant->formats,
> +				       priv->variant->nformats,
> +				       NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
>   	if (ret)
>   		return ret;
>   
> +	drm_plane_helper_add(&priv->plane, &pl111_plane_helper_funcs);
> +
> +	ret = drm_crtc_init_with_planes(drm, &priv->crtc, &priv->plane,
> +					NULL, &pl111_crtc_funcs, NULL);
> +	if (ret)
> +		return ret;
> +
> +	drm_crtc_helper_add(&priv->crtc, &pl111_crtc_helper_funcs);
> +
> +	ret = drm_encoder_init(drm, &priv->encoder, &pl111_encoder_funcs,
> +			       DRM_MODE_ENCODER_NONE, NULL);
> +	if (ret)
> +		return ret;
> +
> +	priv->encoder.possible_crtcs = drm_crtc_mask(&priv->crtc);
> +
> +	if (priv->connector) {
> +		ret = drm_connector_attach_encoder(priv->connector,
> +						   &priv->encoder);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/pl111/pl111_drm.h b/drivers/gpu/drm/pl111/pl111_drm.h
> index d1fe756444ee..ec92a5a180a8 100644
> --- a/drivers/gpu/drm/pl111/pl111_drm.h
> +++ b/drivers/gpu/drm/pl111/pl111_drm.h
> @@ -21,7 +21,6 @@
>   #include <drm/drm_encoder.h>
>   #include <drm/drm_gem.h>
>   #include <drm/drm_panel.h>
> -#include <drm/drm_simple_kms_helper.h>
>   
>   /*
>    * CLCD Controller Internal Register addresses
> @@ -135,7 +134,9 @@ struct pl111_drm_dev_private {
>   	struct drm_connector *connector;
>   	struct drm_panel *panel;
>   	struct drm_bridge *bridge;
> -	struct drm_simple_display_pipe pipe;
> +	struct drm_plane plane;
> +	struct drm_crtc crtc;
> +	struct drm_encoder encoder;
>   
>   	void *regs;
>   	u32 memory_bw;
> diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
> index ac7b1d12a0f5..f649c266c33a 100644
> --- a/drivers/gpu/drm/pl111/pl111_drv.c
> +++ b/drivers/gpu/drm/pl111/pl111_drv.c
> @@ -168,8 +168,7 @@ static int pl111_modeset_init(struct drm_device *dev)
>   		goto out_bridge;
>   	}
>   
> -	ret = drm_simple_display_pipe_attach_bridge(&priv->pipe,
> -						    bridge);
> +	ret = drm_bridge_attach(&priv->encoder, bridge, NULL, 0);
>   	if (ret)
>   		return ret;
>   
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


