Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8466BC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D350010E214;
	Mon,  6 Jul 2026 08:01:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="ZpOXbjS5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bTQM92CH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZpOXbjS5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bTQM92CH";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9A3210E214
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 08:01:14 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5D53275BB4;
 Mon,  6 Jul 2026 08:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783324873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Eol3pFSp5FANi6gqhU/0FQxR1lqwhB/1DOs8F+qHl3A=;
 b=ZpOXbjS5VM5yesg7YgX3ioRId3bJRp7RciAGBqT9vFAkCfJT9dHq0PH8bCungq1kzqBw/9
 ZYFtPD2ZeY4xVbZ9efu/SRCPICtf0fH8Q6Xl9ieiEO9Hz67UOmQgW/d6ZSBWaUccrpelGL
 spOdxfSqoQvWlKlGuzW5oPNtb/oIn0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783324873;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Eol3pFSp5FANi6gqhU/0FQxR1lqwhB/1DOs8F+qHl3A=;
 b=bTQM92CHlooYbex+c9cktnZIj7dWM7FPh/QvmtYuG5H+mm8owXLhELv3+peLP2aut61G/W
 EC3gyeQpX9cQbxAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783324873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Eol3pFSp5FANi6gqhU/0FQxR1lqwhB/1DOs8F+qHl3A=;
 b=ZpOXbjS5VM5yesg7YgX3ioRId3bJRp7RciAGBqT9vFAkCfJT9dHq0PH8bCungq1kzqBw/9
 ZYFtPD2ZeY4xVbZ9efu/SRCPICtf0fH8Q6Xl9ieiEO9Hz67UOmQgW/d6ZSBWaUccrpelGL
 spOdxfSqoQvWlKlGuzW5oPNtb/oIn0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783324873;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Eol3pFSp5FANi6gqhU/0FQxR1lqwhB/1DOs8F+qHl3A=;
 b=bTQM92CHlooYbex+c9cktnZIj7dWM7FPh/QvmtYuG5H+mm8owXLhELv3+peLP2aut61G/W
 EC3gyeQpX9cQbxAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C709F779AA;
 Mon,  6 Jul 2026 08:01:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dMQ3L8hgS2ryEgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 06 Jul 2026 08:01:12 +0000
Message-ID: <2f2f0744-02a0-44ae-a8af-df6163869be4@suse.de>
Date: Mon, 6 Jul 2026 10:01:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] drm/arcpgu: replace struct drm_simple_display_pipe
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
 <20260705-drm-simple-kms-removal-v1-1-b4e1ca053623@oss.qualcomm.com>
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
In-Reply-To: <20260705-drm-simple-kms-removal-v1-1-b4e1ca053623@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,qualcomm.com:email,bootlin.com:url,suse.de:mid,suse.com:url];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[oss.qualcomm.com,synopsys.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,jms.id.au,codeconstruct.com.au,nxp.com,pengutronix.de,epam.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_TWELVE(0.00)[22];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TAGGED_RCPT(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email, bootlin.com:url,
 suse.com:url, suse.de:mid]
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
> Instantiate plane, CRTC and encoder directly and wire them up with
> standard atomic helpers.
>
> This removes arcpgu's dependency on deprecated simple-KMS display pipe
> interface.
>
> Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/tiny/arcpgu.c | 165 +++++++++++++++++++++++++++++++++---------
>   1 file changed, 131 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
> index c93d61ac0bb7..375cdb79e4e8 100644
> --- a/drivers/gpu/drm/tiny/arcpgu.c
> +++ b/drivers/gpu/drm/tiny/arcpgu.c
> @@ -17,12 +17,12 @@
>   #include <drm/drm_fbdev_dma.h>
>   #include <drm/drm_fourcc.h>
>   #include <drm/drm_framebuffer.h>
> +#include <drm/drm_gem_atomic_helper.h>
>   #include <drm/drm_gem_dma_helper.h>
>   #include <drm/drm_gem_framebuffer_helper.h>
>   #include <drm/drm_module.h>
>   #include <drm/drm_of.h>
>   #include <drm/drm_probe_helper.h>
> -#include <drm/drm_simple_kms_helper.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/module.h>
>   #include <linux/of_reserved_mem.h>
> @@ -52,14 +52,14 @@ struct arcpgu_drm_private {
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
> -
>   static inline void arc_pgu_write(struct arcpgu_drm_private *arcpgu,
>   				 unsigned int reg, u32 value)
>   {
> @@ -117,7 +117,7 @@ static const u32 arc_pgu_supported_formats[] = {
>   
>   static void arc_pgu_set_pxl_fmt(struct arcpgu_drm_private *arcpgu)
>   {
> -	const struct drm_framebuffer *fb = arcpgu->pipe.plane.state->fb;
> +	const struct drm_framebuffer *fb = arcpgu->plane.state->fb;
>   	uint32_t pixel_format = fb->format->format;
>   	u32 format = DRM_FORMAT_INVALID;
>   	int i;
> @@ -139,10 +139,10 @@ static void arc_pgu_set_pxl_fmt(struct arcpgu_drm_private *arcpgu)
>   	arc_pgu_write(arcpgu, ARCPGU_REG_CTRL, reg_ctrl);
>   }
>   
> -static enum drm_mode_status arc_pgu_mode_valid(struct drm_simple_display_pipe *pipe,
> -					       const struct drm_display_mode *mode)
> +static enum drm_mode_status arcpgu_crtc_helper_mode_valid(struct drm_crtc *crtc,
> +							  const struct drm_display_mode *mode)
>   {
> -	struct arcpgu_drm_private *arcpgu = pipe_to_arcpgu_priv(pipe);
> +	struct arcpgu_drm_private *arcpgu = dev_to_arcpgu(crtc->dev);
>   	long rate, clk_rate = mode->clock * 1000;
>   	long diff = clk_rate / 200; /* +-0.5% allowed by HDMI spec */
>   
> @@ -155,7 +155,7 @@ static enum drm_mode_status arc_pgu_mode_valid(struct drm_simple_display_pipe *p
>   
>   static void arc_pgu_mode_set(struct arcpgu_drm_private *arcpgu)
>   {
> -	struct drm_display_mode *m = &arcpgu->pipe.crtc.state->adjusted_mode;
> +	struct drm_display_mode *m = &arcpgu->crtc.state->adjusted_mode;
>   	u32 val;
>   
>   	arc_pgu_write(arcpgu, ARCPGU_REG_FMT,
> @@ -194,11 +194,10 @@ static void arc_pgu_mode_set(struct arcpgu_drm_private *arcpgu)
>   	clk_set_rate(arcpgu->clk, m->crtc_clock * 1000);
>   }
>   
> -static void arc_pgu_enable(struct drm_simple_display_pipe *pipe,
> -			   struct drm_crtc_state *crtc_state,
> -			   struct drm_plane_state *plane_state)
> +static void arcpgu_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> +					     struct drm_atomic_commit *state)

Since you're adding these functions anew, please use 'commit' for the 
name of the drm_atomic_commit.  Here and everywhere else in the series.  
You don't have to update existing functions, of course.

The name 'state' is a bit off here and comes from when drm_atomic_commit 
was still called drm_atomic_state.

CRTCs, plane, etc have state, but the update of these states is called 
commit.


>   {
> -	struct arcpgu_drm_private *arcpgu = pipe_to_arcpgu_priv(pipe);
> +	struct arcpgu_drm_private *arcpgu = dev_to_arcpgu(crtc->dev);
>   
>   	arc_pgu_mode_set(arcpgu);
>   
> @@ -208,9 +207,10 @@ static void arc_pgu_enable(struct drm_simple_display_pipe *pipe,
>   		      ARCPGU_CTRL_ENABLE_MASK);
>   }
>   
> -static void arc_pgu_disable(struct drm_simple_display_pipe *pipe)
> +static void arcpgu_crtc_helper_atomic_disable(struct drm_crtc *crtc,
> +					      struct drm_atomic_commit *state)
>   {
> -	struct arcpgu_drm_private *arcpgu = pipe_to_arcpgu_priv(pipe);
> +	struct arcpgu_drm_private *arcpgu = dev_to_arcpgu(crtc->dev);
>   
>   	clk_disable_unprepare(arcpgu->clk);
>   	arc_pgu_write(arcpgu, ARCPGU_REG_CTRL,
> @@ -218,35 +218,106 @@ static void arc_pgu_disable(struct drm_simple_display_pipe *pipe)
>   			      ~ARCPGU_CTRL_ENABLE_MASK);
>   }
>   
> -static void arc_pgu_update(struct drm_simple_display_pipe *pipe,
> -			   struct drm_plane_state *state)
> +static void arcpgu_plane_helper_atomic_update(struct drm_plane *plane,
> +					      struct drm_atomic_commit *state)
>   {
>   	struct arcpgu_drm_private *arcpgu;
>   	struct drm_gem_dma_object *gem;
>   
> -	if (!pipe->plane.state->fb)
> +	if (!plane->state->fb)
>   		return;
>   
> -	arcpgu = pipe_to_arcpgu_priv(pipe);
> -	gem = drm_fb_dma_get_gem_obj(pipe->plane.state->fb, 0);
> +	arcpgu = dev_to_arcpgu(plane->dev);
> +	gem = drm_fb_dma_get_gem_obj(plane->state->fb, 0);
>   	arc_pgu_write(arcpgu, ARCPGU_REG_BUF0_ADDR, gem->dma_addr);
>   }
>   
> -static const struct drm_simple_display_pipe_funcs arc_pgu_pipe_funcs = {
> -	.update = arc_pgu_update,
> -	.mode_valid = arc_pgu_mode_valid,
> -	.enable	= arc_pgu_enable,
> -	.disable = arc_pgu_disable,
> -};
> -
>   static const struct drm_mode_config_funcs arcpgu_drm_modecfg_funcs = {
> -	.fb_create  = drm_gem_fb_create,
> +	.fb_create = drm_gem_fb_create,
>   	.atomic_check = drm_atomic_helper_check,
>   	.atomic_commit = drm_atomic_helper_commit,
>   };
>   
>   DEFINE_DRM_GEM_DMA_FOPS(arcpgu_drm_ops);
>   
> +static int arcpgu_plane_helper_atomic_check(struct drm_plane *plane,
> +					    struct drm_atomic_commit *state)
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


Return directly here.


> +}
> +
> +static const struct drm_plane_helper_funcs arcpgu_plane_helper_funcs = {
> +	.prepare_fb	= drm_gem_plane_helper_prepare_fb,
> +	.atomic_check	= arcpgu_plane_helper_atomic_check,
> +	.atomic_update	= arcpgu_plane_helper_atomic_update,
> +};
> +
> +static bool arcpgu_plane_format_mod_supported(struct drm_plane *plane,
> +					      u32 format,
> +					      u64 modifier)
> +{
> +	return modifier == DRM_FORMAT_MOD_LINEAR;
> +}

Please remove this function. It doesn't really do anything besides DRM's 
standard behavior.

> +
> +static const struct drm_plane_funcs arcpgu_plane_funcs = {
> +	.update_plane		= drm_atomic_helper_update_plane,
> +	.disable_plane		= drm_atomic_helper_disable_plane,
> +	.destroy		= drm_plane_cleanup,
> +	.reset			= drm_atomic_helper_plane_reset,
> +	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
> +	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
> +	.format_mod_supported	= arcpgu_plane_format_mod_supported,
> +};
> +
> +static int arcpgu_crtc_helper_atomic_check(struct drm_crtc *crtc,
> +					   struct drm_atomic_commit *state)
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

Instead of using out, I'd rather use

   if (crtc->enable) {
       //do checks
   }

   return add_affected planes.

Seems more natural to me.

> +}
> +
> +static const struct drm_crtc_helper_funcs arcpgu_crtc_helper_funcs = {
> +	.mode_valid	= arcpgu_crtc_helper_mode_valid,
> +	.atomic_check	= arcpgu_crtc_helper_atomic_check,
> +	.atomic_enable	= arcpgu_crtc_helper_atomic_enable,
> +	.atomic_disable	= arcpgu_crtc_helper_atomic_disable,
> +};
> +
> +static const struct drm_crtc_funcs arcpgu_crtc_funcs = {
> +	.reset			= drm_atomic_helper_crtc_reset,
> +	.destroy		= drm_crtc_cleanup,
> +	.set_config		= drm_atomic_helper_set_config,
> +	.page_flip		= drm_atomic_helper_page_flip,
> +	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
> +	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
> +};
> +
> +static const struct drm_encoder_funcs arcpgu_encoder_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
>   static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
>   {
>   	struct platform_device *pdev = to_platform_device(arcpgu->drm.dev);
> @@ -254,6 +325,9 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
>   	struct device_node *endpoint_node = NULL;
>   	struct drm_connector *connector = NULL;
>   	struct drm_device *drm = &arcpgu->drm;
> +	struct drm_plane *plane;
> +	struct drm_encoder *encoder;
> +	struct drm_crtc *crtc;
>   	int ret;
>   
>   	arcpgu->clk = devm_clk_get(drm->dev, "pxlclk");
> @@ -301,12 +375,35 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
>   			return ret;
>   	}
>   
> -	ret = drm_simple_display_pipe_init(drm, &arcpgu->pipe, &arc_pgu_pipe_funcs,
> -					   arc_pgu_supported_formats,
> -					   ARRAY_SIZE(arc_pgu_supported_formats),
> -					   NULL, connector);
> +	plane = &arcpgu->plane;
> +	ret = drm_universal_plane_init(drm, plane, 0,
> +				       &arcpgu_plane_funcs,
> +				       arc_pgu_supported_formats,
> +				       ARRAY_SIZE(arc_pgu_supported_formats),
> +				       NULL,
> +				       DRM_PLANE_TYPE_PRIMARY, NULL);
>   	if (ret)
>   		return ret;
> +	drm_plane_helper_add(plane, &arcpgu_plane_helper_funcs);
> +
> +	crtc = &arcpgu->crtc;
> +	ret = drm_crtc_init_with_planes(drm, crtc, plane, NULL,
> +					&arcpgu_crtc_funcs, NULL);
> +	if (ret)
> +		return ret;
> +	drm_crtc_helper_add(crtc, &arcpgu_crtc_helper_funcs);
> +
> +	encoder = &arcpgu->encoder;
> +	ret = drm_encoder_init(drm, encoder, &arcpgu_encoder_funcs, DRM_MODE_ENCODER_NONE, NULL);
> +	if (ret)
> +		return ret;
> +	encoder->possible_crtcs = drm_crtc_mask(crtc);


I think plane, CRTC, and encoder should go before testing the 
encoder_node at [1].

Then comes the encoder_node test.  If true, do a single encoder-node 
branch,  or else to a single connector-based branch.   That would 
simplify the overall logic in this helper.

[1] 
https://elixir.bootlin.com/linux/v7.1.2/source/drivers/gpu/drm/tiny/arcpgu.c#L287


> +
> +	if (connector) {
> +		ret = drm_connector_attach_encoder(connector, encoder);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	if (encoder_node) {
>   		/* Locate drm bridge from the hdmi encoder DT node */
> @@ -315,7 +412,7 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
>   		if (!bridge)
>   			return -EPROBE_DEFER;
>   
> -		ret = drm_simple_display_pipe_attach_bridge(&arcpgu->pipe, bridge);
> +		ret = drm_bridge_attach(encoder, bridge, NULL, 0);
>   		if (ret)
>   			return ret;
>   	}
> @@ -342,7 +439,7 @@ static int arcpgu_show_pxlclock(struct seq_file *m, void *arg)
>   	struct drm_device *drm = node->minor->dev;
>   	struct arcpgu_drm_private *arcpgu = dev_to_arcpgu(drm);
>   	unsigned long clkrate = clk_get_rate(arcpgu->clk);
> -	unsigned long mode_clock = arcpgu->pipe.crtc.mode.crtc_clock * 1000;
> +	unsigned long mode_clock = arcpgu->crtc.mode.crtc_clock * 1000;

Here, mode is an obsolete field. The correct field is crtc->state->mode.

Best regards
Thomas

>   
>   	seq_printf(m, "hw  : %lu\n", clkrate);
>   	seq_printf(m, "mode: %lu\n", mode_clock);
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


