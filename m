Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF2FC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 13:02:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7508A10E5D6;
	Wed,  8 Jul 2026 13:02:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="WIPZDABK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f4PjU3G4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L7ucXGfe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bIUTr4Aw";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE43C10E5D6
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 13:02:20 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D44FD7605B;
 Wed,  8 Jul 2026 13:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783515739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GwGnfA6G4ylXesCDxSkBZDTZ68dGjfJfzkNtJHgtlCM=;
 b=WIPZDABKV1jYwD94oRLSL/gmjWNQLsDl4RyppHX8Fqdzg5AKEmufO7lF1V4YxaptOmbyW8
 kI8MYUikXlw/B+1HGx5rAKTg2dK/QZVj+q7Z/p/cj9lkCAy5YHy3I3TmjnK4RytU0qtaCA
 jmgldMuKhCTOeRwEl9Rfil2vnS2FPTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783515739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GwGnfA6G4ylXesCDxSkBZDTZ68dGjfJfzkNtJHgtlCM=;
 b=f4PjU3G4Fk8sofDALXBA+yEYGGyuw5EWwrG6oeNMjus0C9+4x8ssW9D3HmREUrT5BWfm+U
 anASh/sAkk/PVIBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=L7ucXGfe;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bIUTr4Aw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783515735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GwGnfA6G4ylXesCDxSkBZDTZ68dGjfJfzkNtJHgtlCM=;
 b=L7ucXGfeda1sYKy+hiZa+WV+nPB20gttblumdtNMl9hxKeaNCTUDPQFwVDJtw85Ezz20EX
 SHqriPVhBNz4oNYayVCvRG1eeTyELma9zVYoC94eR0NTRK7kKB7fxWapsT0tNo1xp49UEX
 ASR4Z0oEr9MDEquQe7dE6ocVQOqZ7DA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783515735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GwGnfA6G4ylXesCDxSkBZDTZ68dGjfJfzkNtJHgtlCM=;
 b=bIUTr4AwI8Pd3kUGaQ5sn4+9Nln8LIApYq8XJ461ncBT0Ndxr8OMqGVWSvse2WL9kM9j+L
 pFqmb0FbTLnaTkCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34E6E779AE;
 Wed,  8 Jul 2026 13:02:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lm9+C1dKTmoAKwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 08 Jul 2026 13:02:15 +0000
Message-ID: <4d1ddd5d-2635-4ee0-8481-78f3a034233b@suse.de>
Date: Wed, 8 Jul 2026 15:02:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] drm/mcde: replace struct drm_simple_display_pipe with
 regular atomic helpers
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
 <20260705-drm-simple-kms-removal-v1-4-b4e1ca053623@oss.qualcomm.com>
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
In-Reply-To: <20260705-drm-simple-kms-removal-v1-4-b4e1ca053623@oss.qualcomm.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url, suse.com:url,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, suse.de:mid,
 suse.de:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D44FD7605B
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

Hi

Am 04.07.26 um 20:31 schrieb Ze Huang:
> Convert MCDE to explicit plane, CRTC and encoder objects.
>
> Keep FIFO, event and framebuffer update sequencing intact, and install
> GEM framebuffer prepare callback explicitly.
>
> Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/mcde/mcde_display.c | 162 +++++++++++++++++++++++++++---------
>   drivers/gpu/drm/mcde/mcde_drm.h     |   6 +-
>   drivers/gpu/drm/mcde/mcde_drv.c     |   3 +-
>   3 files changed, 129 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/gpu/drm/mcde/mcde_display.c b/drivers/gpu/drm/mcde/mcde_display.c
> index 257a6e84dd58..4d86fa5030eb 100644
> --- a/drivers/gpu/drm/mcde/mcde_display.c
> +++ b/drivers/gpu/drm/mcde/mcde_display.c
> @@ -10,6 +10,7 @@
>   #include <linux/regulator/consumer.h>
>   #include <linux/media-bus-format.h>
>   
> +#include <drm/drm_atomic_helper.h>
>   #include <drm/drm_device.h>
>   #include <drm/drm_fb_dma_helper.h>
>   #include <drm/drm_fourcc.h>
> @@ -18,7 +19,6 @@
>   #include <drm/drm_gem_dma_helper.h>
>   #include <drm/drm_mipi_dsi.h>
>   #include <drm/drm_print.h>
> -#include <drm/drm_simple_kms_helper.h>
>   #include <drm/drm_bridge.h>
>   #include <drm/drm_vblank.h>
>   #include <video/mipi_display.h>
> @@ -132,7 +132,7 @@ void mcde_display_irq(struct mcde *mcde)
>   	writel(mispp, mcde->regs + MCDE_RISPP);
>   
>   	if (vblank)
> -		drm_crtc_handle_vblank(&mcde->pipe.crtc);
> +		drm_crtc_handle_vblank(&mcde->crtc);
>   
>   	if (misovl)
>   		dev_info(mcde->dev, "some stray overlay IRQ %08x\n", misovl);
> @@ -157,13 +157,35 @@ void mcde_display_disable_irqs(struct mcde *mcde)
>   	writel(0xFFFFFFFF, mcde->regs + MCDE_RISCHNL);
>   }
>   
> -static int mcde_display_check(struct drm_simple_display_pipe *pipe,
> -			      struct drm_plane_state *pstate,
> -			      struct drm_crtc_state *cstate)
> +static int mcde_plane_helper_atomic_check(struct drm_plane *plane,
> +					  struct drm_atomic_commit *state)
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

Your planes' atomic_check functions should always run 
drm_atomic_helper_check_plane_state() first. Otherwise, the plane state 
will be incorrect.

If there is no crtc, simply pass NULL for the CRTC state.  I'd advise to 
duplicate the pattern at [1] from lines 487 to 498.  After 
_check_plane_state() ran, the atomic_check can do additional tests.

If not looked over all the other patches for this problem, but this 
comment would apply to all of them.

[1] 
https://elixir.bootlin.com/linux/v7.1.2/source/drivers/gpu/drm/mgag200/mgag200_mode.c#L487

> +
> +	cstate = drm_atomic_get_new_crtc_state(state, crtc);
> +	if (!cstate)
> +		return 0;
> +
> +	ret = drm_atomic_helper_check_plane_state(pstate, cstate,
> +						  DRM_PLANE_NO_SCALING,
> +						  DRM_PLANE_NO_SCALING,
> +						  false, false);
> +	if (ret)
> +		return ret;
> +
> +	if (!pstate->visible)
> +		return 0;
> +
> +	mode = &cstate->mode;
>   
>   	if (fb) {
>   		u32 offset = drm_fb_dma_get_gem_addr(fb, pstate, 0);
> @@ -1149,16 +1171,14 @@ static void mcde_setup_dsi(struct mcde *mcde, const struct drm_display_mode *mod
>   	*dsi_formatter_frame = formatter_frame;
>   }
>   
> -static void mcde_display_enable(struct drm_simple_display_pipe *pipe,
> -				struct drm_crtc_state *cstate,
> -				struct drm_plane_state *plane_state)
> +static void mcde_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> +					   struct drm_atomic_commit *state)
>   {
> -	struct drm_crtc *crtc = &pipe->crtc;
> -	struct drm_plane *plane = &pipe->plane;
>   	struct drm_device *drm = crtc->dev;
>   	struct mcde *mcde = to_mcde(drm);
> +	struct drm_crtc_state *cstate = crtc->state;
>   	const struct drm_display_mode *mode = &cstate->mode;
> -	struct drm_framebuffer *fb = plane->state->fb;
> +	struct drm_framebuffer *fb = mcde->plane.state->fb;
>   	u32 format = fb->format->format;
>   	int dsi_pkt_size;
>   	int fifo_wtrmrk;
> @@ -1298,9 +1318,9 @@ static void mcde_display_enable(struct drm_simple_display_pipe *pipe,
>   	dev_info(drm->dev, "MCDE display is enabled\n");
>   }
>   
> -static void mcde_display_disable(struct drm_simple_display_pipe *pipe)
> +static void mcde_crtc_helper_atomic_disable(struct drm_crtc *crtc,
> +					    struct drm_atomic_commit *state)
>   {
> -	struct drm_crtc *crtc = &pipe->crtc;
>   	struct drm_device *drm = crtc->dev;
>   	struct mcde *mcde = to_mcde(drm);
>   	struct drm_pending_vblank_event *event;
> @@ -1381,17 +1401,23 @@ static void mcde_set_extsrc(struct mcde *mcde, u32 buffer_address)
>   	writel(buffer_address + mcde->stride, mcde->regs + MCDE_EXTSRCXA1);
>   }
>   
> -static void mcde_display_update(struct drm_simple_display_pipe *pipe,
> -				struct drm_plane_state *old_pstate)
> +static void mcde_plane_helper_atomic_update(struct drm_plane *plane,
> +					    struct drm_atomic_commit *state)
>   {
> -	struct drm_crtc *crtc = &pipe->crtc;
> -	struct drm_device *drm = crtc->dev;
> -	struct mcde *mcde = to_mcde(drm);
> -	struct drm_pending_vblank_event *event = crtc->state->event;
> -	struct drm_plane *plane = &pipe->plane;
> +	struct drm_crtc *crtc = plane->state->crtc;
> +	struct drm_device *drm;
> +	struct mcde *mcde;
> +	struct drm_pending_vblank_event *event;
>   	struct drm_plane_state *pstate = plane->state;
>   	struct drm_framebuffer *fb = pstate->fb;
>   
> +	if (!crtc)
> +		return;

The helper first does vblank handling and then handles visibility by 
testing "if (fb)". No need for this test.

> +
> +	drm = crtc->dev;
> +	mcde = to_mcde(drm);
> +	event = crtc->state->event;
> +

And this needs to handle !crtc without returning.

>   	/*
>   	 * Handle any pending event first, we need to arm the vblank

And the next block handled vblanks, which is not the right place. That's 
a preexisting issue.  Vblank handling is better done in the crtc's 
atomic_flush.

Best regards
Thomas

>   	 * interrupt before sending any update to the display so we don't
> @@ -1443,9 +1469,8 @@ static void mcde_display_update(struct drm_simple_display_pipe *pipe,
>   	}
>   }
>   
> -static int mcde_display_enable_vblank(struct drm_simple_display_pipe *pipe)
> +static int mcde_crtc_enable_vblank(struct drm_crtc *crtc)
>   {
> -	struct drm_crtc *crtc = &pipe->crtc;
>   	struct drm_device *drm = crtc->dev;
>   	struct mcde *mcde = to_mcde(drm);
>   	u32 val;
> @@ -1462,9 +1487,8 @@ static int mcde_display_enable_vblank(struct drm_simple_display_pipe *pipe)
>   	return 0;
>   }
>   
> -static void mcde_display_disable_vblank(struct drm_simple_display_pipe *pipe)
> +static void mcde_crtc_disable_vblank(struct drm_crtc *crtc)
>   {
> -	struct drm_crtc *crtc = &pipe->crtc;
>   	struct drm_device *drm = crtc->dev;
>   	struct mcde *mcde = to_mcde(drm);
>   
> @@ -1474,13 +1498,56 @@ static void mcde_display_disable_vblank(struct drm_simple_display_pipe *pipe)
>   	writel(0xFFFFFFFF, mcde->regs + MCDE_RISPP);
>   }
>   
> -static struct drm_simple_display_pipe_funcs mcde_display_funcs = {
> -	.check = mcde_display_check,
> -	.enable = mcde_display_enable,
> -	.disable = mcde_display_disable,
> -	.update = mcde_display_update,
> -	.enable_vblank = mcde_display_enable_vblank,
> -	.disable_vblank = mcde_display_disable_vblank,
> +static int mcde_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *state)
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
> +static const struct drm_crtc_funcs mcde_crtc_funcs = {
> +	.reset			= drm_atomic_helper_crtc_reset,
> +	.destroy		= drm_crtc_cleanup,
> +	.set_config		= drm_atomic_helper_set_config,
> +	.page_flip		= drm_atomic_helper_page_flip,
> +	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
> +	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
> +	.enable_vblank		= mcde_crtc_enable_vblank,
> +	.disable_vblank		= mcde_crtc_disable_vblank,
> +};
> +
> +static const struct drm_crtc_helper_funcs mcde_crtc_helper_funcs = {
> +	.atomic_check	= mcde_crtc_helper_atomic_check,
> +	.atomic_enable	= mcde_crtc_helper_atomic_enable,
> +	.atomic_disable	= mcde_crtc_helper_atomic_disable,
> +};
> +
> +static const struct drm_plane_funcs mcde_plane_funcs = {
> +	.update_plane		= drm_atomic_helper_update_plane,
> +	.disable_plane		= drm_atomic_helper_disable_plane,
> +	.reset			= drm_atomic_helper_plane_reset,
> +	.destroy		= drm_plane_cleanup,
> +	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
> +	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
> +};
> +
> +static const struct drm_plane_helper_funcs mcde_plane_helper_funcs = {
> +	.prepare_fb	= drm_gem_plane_helper_prepare_fb,
> +	.atomic_check	= mcde_plane_helper_atomic_check,
> +	.atomic_update	= mcde_plane_helper_atomic_update,
> +};
> +
> +static const struct drm_encoder_funcs mcde_encoder_funcs = {
> +	.destroy = drm_encoder_cleanup,
>   };
>   
>   int mcde_display_init(struct drm_device *drm)
> @@ -1510,11 +1577,30 @@ int mcde_display_init(struct drm_device *drm)
>   	if (ret)
>   		return ret;
>   
> -	ret = drm_simple_display_pipe_init(drm, &mcde->pipe,
> -					   &mcde_display_funcs,
> -					   formats, ARRAY_SIZE(formats),
> -					   NULL,
> -					   mcde->connector);
> +	ret = drm_universal_plane_init(drm, &mcde->plane, 0,
> +				       &mcde_plane_funcs,
> +				       formats, ARRAY_SIZE(formats),
> +				       NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
> +	if (ret)
> +		return ret;
> +
> +	drm_plane_helper_add(&mcde->plane, &mcde_plane_helper_funcs);
> +
> +	ret = drm_crtc_init_with_planes(drm, &mcde->crtc, &mcde->plane,
> +					NULL, &mcde_crtc_funcs, NULL);
> +	if (ret)
> +		return ret;
> +
> +	drm_crtc_helper_add(&mcde->crtc, &mcde_crtc_helper_funcs);
> +
> +	ret = drm_encoder_init(drm, &mcde->encoder, &mcde_encoder_funcs,
> +			       DRM_MODE_ENCODER_NONE, NULL);
> +	if (ret)
> +		return ret;
> +
> +	mcde->encoder.possible_crtcs = drm_crtc_mask(&mcde->crtc);
> +
> +	ret = drm_connector_attach_encoder(mcde->connector, &mcde->encoder);
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/gpu/drm/mcde/mcde_drm.h b/drivers/gpu/drm/mcde/mcde_drm.h
> index ecb70b4b737c..6123afb1e3b8 100644
> --- a/drivers/gpu/drm/mcde/mcde_drm.h
> +++ b/drivers/gpu/drm/mcde/mcde_drm.h
> @@ -4,7 +4,7 @@
>    * Parts of this file were based on the MCDE driver by Marcus Lorentzon
>    * (C) ST-Ericsson SA 2013
>    */
> -#include <drm/drm_simple_kms_helper.h>
> +#include <drm/drm_encoder.h>
>   
>   #ifndef _MCDE_DRM_H_
>   #define _MCDE_DRM_H_
> @@ -72,7 +72,9 @@ struct mcde {
>   	struct drm_panel *panel;
>   	struct drm_bridge *bridge;
>   	struct drm_connector *connector;
> -	struct drm_simple_display_pipe pipe;
> +	struct drm_plane plane;
> +	struct drm_crtc crtc;
> +	struct drm_encoder encoder;
>   	struct mipi_dsi_device *mdsi;
>   	bool dpi_output;
>   	s16 stride;
> diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
> index 5f2c462bad7e..401cf8ab83bc 100644
> --- a/drivers/gpu/drm/mcde/mcde_drv.c
> +++ b/drivers/gpu/drm/mcde/mcde_drv.c
> @@ -186,8 +186,7 @@ static int mcde_modeset_init(struct drm_device *drm)
>   	}
>   
>   	/* Attach the bridge. */
> -	ret = drm_simple_display_pipe_attach_bridge(&mcde->pipe,
> -						    mcde->bridge);
> +	ret = drm_bridge_attach(&mcde->encoder, mcde->bridge, NULL, 0);
>   	if (ret) {
>   		dev_err(drm->dev, "failed to attach display output bridge\n");
>   		return ret;
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


