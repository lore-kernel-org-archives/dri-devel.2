Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB4CC982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 06:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA80910E24F;
	Mon, 21 Sep 2026 06:47:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Uts87KyO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zmhlwuUF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yHzCPONA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BnJK3Bo3";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DCA810E24F
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 06:47:54 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 627141F7BC;
 Mon, 21 Sep 2026 06:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789973268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NVGB9kYWuaDyxu5DT7vqAtvl8Ee4kNOAm7KX4EHo8dg=;
 b=Uts87KyOCT/ML4TSa2VVCjCQJIyjXHEVsZY8r6qcM9V1VPnKQ3qiilzVBib5R7o5IO0IRP
 xjs/Ju93K1a/G/3dX8z/iiMhM+VC6NqIzS9Zouz6B7RfwxbB6V46uiT1wmjFB+cmbsOewI
 gG5j6Owa0qSvfwkbxYgrSKcbSB/UmYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789973268;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NVGB9kYWuaDyxu5DT7vqAtvl8Ee4kNOAm7KX4EHo8dg=;
 b=zmhlwuUFQLorZeqUFEpPWgu1R+noDr72wDWHoBc70rCz1UDNKYEmbbmcHVppJyltB7MTZ+
 nDGfn18oCcOh0yAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yHzCPONA;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BnJK3Bo3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789973264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NVGB9kYWuaDyxu5DT7vqAtvl8Ee4kNOAm7KX4EHo8dg=;
 b=yHzCPONASkUajtapmqZTRILfhh3CIu1MgyrPl21N381Vpxam4Pe1Ago0jd1wqkNU4+40k+
 TPCXA4c0Qul+TxpLm+sq0Scb5G8rKyOFYm3aROh+phgCCzfhx8+b7hsfkVhYcGptsNpLCe
 +NLr/HvjQnaOurdj1QeoQ8d5Wt+ABZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789973264;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NVGB9kYWuaDyxu5DT7vqAtvl8Ee4kNOAm7KX4EHo8dg=;
 b=BnJK3Bo3ztYGJV4kQf1OlVwzf8YFHanJrhnFiEavxb8mWxnEYUrXm14GfeUwhD3VCR2X3h
 PGlFqSRAa0MuKfCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1310413793;
 Mon, 21 Sep 2026 06:47:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mrGINw/TsGqMRQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 21 Sep 2026 06:47:44 +0000
Message-ID: <23e010c3-45aa-48fd-ac30-5aa3e0fcb847@suse.de>
Date: Mon, 21 Sep 2026 08:47:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tiny: fix VRAM/EDID/transfer bounds in bochs,
 gm12u320, pixpaper, and sharp-memory
To: Hui Peng <benquike@gmail.com>, hansg@kernel.org, simona@ffwll.ch,
 airlied@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260919223513.3889412-1-benquike@gmail.com>
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
In-Reply-To: <20260919223513.3889412-1-benquike@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 627141F7BC
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_TO(0.00)[gmail.com,kernel.org,ffwll.ch,redhat.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.com:url];
 DKIM_TRACE(0.00)[suse.de:+]
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

I suggest to put that LLM away for a bit and rather try to get one of 
these drivers to work. Once you have that, try to make a test case for 
one of these "problems". And when that is ready, we can see how to fix it.

Best regards
Thomas

Am 20.09.26 um 00:35 schrieb Hui Peng:
> Fix framebuffer size, EDID extension count, and transfer buffer bounds
> checks across drivers/gpu/drm/tiny/ (bochs.c, gm12u320.c, pixpaper.c,
> and sharp-memory.c).
>
> Fixes: 77b8cabf3d52 ("drm/gm12u320: Move driver to drm/tiny")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
> index e2d957e51505..19d0af677321 100644
> --- a/drivers/gpu/drm/tiny/bochs.c
> +++ b/drivers/gpu/drm/tiny/bochs.c
> @@ -422,6 +422,8 @@ static int bochs_primary_plane_helper_atomic_check(struct drm_plane *plane,
>   						   struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
> +	struct drm_framebuffer *fb = new_plane_state->fb;
> +	struct bochs_device *bochs = to_bochs_device(plane->dev);
>   	struct drm_crtc *new_crtc = new_plane_state->crtc;
>   	struct drm_crtc_state *new_crtc_state = NULL;
>   	int ret;
> @@ -438,6 +440,9 @@ static int bochs_primary_plane_helper_atomic_check(struct drm_plane *plane,
>   	else if (!new_plane_state->visible)
>   		return 0;
>   
> +	if (fb && (u64)fb->pitches[0] * fb->height > bochs->fb_size)
> +		return -EINVAL;
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
> index 4ad074337af0..9dfbfc6bb1b6 100644
> --- a/drivers/gpu/drm/tiny/gm12u320.c
> +++ b/drivers/gpu/drm/tiny/gm12u320.c
> @@ -268,12 +268,18 @@ static void gm12u320_copy_fb_to_blocks(struct gm12u320_device *gm12u320)
>   	x2 = gm12u320->fb_update.rect.x2;
>   	y1 = gm12u320->fb_update.rect.y1;
>   	y2 = gm12u320->fb_update.rect.y2;
> -	vaddr = gm12u320->fb_update.src_map.vaddr; /* TODO: Use mapping abstraction properly */
> +
> +	ret = drm_gem_fb_vmap(fb, &gm12u320->fb_update.src_map, NULL);
> +	if (ret) {
> +		GM12U320_ERR("drm_gem_fb_vmap err: %d\n", ret);
> +		goto put_fb;
> +	}
> +	vaddr = gm12u320->fb_update.src_map.vaddr;
>   
>   	ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
>   	if (ret) {
>   		GM12U320_ERR("drm_gem_fb_begin_cpu_access err: %d\n", ret);
> -		goto put_fb;
> +		goto vunmap_fb;
>   	}
>   
>   	src = vaddr + y1 * fb->pitches[0] + x1 * 4;
> @@ -311,6 +317,8 @@ static void gm12u320_copy_fb_to_blocks(struct gm12u320_device *gm12u320)
>   	}
>   
>   	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
> +vunmap_fb:
> +	drm_gem_fb_vunmap(fb, &gm12u320->fb_update.src_map);
>   put_fb:
>   	drm_framebuffer_put(fb);
>   	gm12u320->fb_update.fb = NULL;
> @@ -418,6 +426,7 @@ static void gm12u320_fb_mark_dirty(struct drm_framebuffer *fb,
>   	} else {
>   		struct drm_rect *rect = &gm12u320->fb_update.rect;
>   
> +		gm12u320->fb_update.src_map = *map;
>   		rect->x1 = min(rect->x1, dirty->x1);
>   		rect->y1 = min(rect->y1, dirty->y1);
>   		rect->x2 = max(rect->x2, dirty->x2);
> @@ -583,8 +592,17 @@ static void gm12u320_pipe_update(struct drm_simple_display_pipe *pipe,
>   	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
>   	struct drm_rect rect;
>   
> -	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
> +	if (!state->fb) {
> +		gm12u320_stop_fb_update(to_gm12u320(pipe->crtc.dev));
> +		return;
> +	}
> +
> +	if (drm_atomic_helper_damage_merged(old_state, state, &rect)) {
>   		gm12u320_fb_mark_dirty(state->fb, &shadow_plane_state->data[0], &rect);
> +	} else if (old_state->fb != state->fb) {
> +		drm_rect_init(&rect, 0, 0, state->fb->width, state->fb->height);
> +		gm12u320_fb_mark_dirty(state->fb, &shadow_plane_state->data[0], &rect);
> +	}
>   }
>   
>   static const struct drm_simple_display_pipe_funcs gm12u320_pipe_funcs = {
> diff --git a/drivers/gpu/drm/tiny/pixpaper.c b/drivers/gpu/drm/tiny/pixpaper.c
> index d02ac26d007c..475e92c3410e 100644
> --- a/drivers/gpu/drm/tiny/pixpaper.c
> +++ b/drivers/gpu/drm/tiny/pixpaper.c
> @@ -865,7 +865,7 @@ static void pixpaper_plane_atomic_update(struct drm_plane *plane,
>   	struct drm_shadow_plane_state *shadow_plane_state =
>   		to_drm_shadow_plane_state(plane_state);
>   	struct drm_crtc *crtc = plane_state->crtc;
> -	struct pixpaper_panel *panel = to_pixpaper_panel(crtc->dev);
> +	struct pixpaper_panel *panel = to_pixpaper_panel(plane->dev);
>   
>   	struct drm_device *drm = &panel->drm;
>   	struct drm_framebuffer *fb = plane_state->fb;
> @@ -875,6 +875,9 @@ static void pixpaper_plane_atomic_update(struct drm_plane *plane,
>   	__le32 *src_pixels = NULL;
>   	struct pixpaper_error_ctx err = { .errno_code = 0 };
>   
> +	if (!crtc || !fb)
> +		return;
> +
>   	if (!drm_dev_enter(drm, &idx))
>   		return;
>   
> diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
> index 7efd7b567f3b..b365e7549666 100644
> --- a/drivers/gpu/drm/tiny/sharp-memory.c
> +++ b/drivers/gpu/drm/tiny/sharp-memory.c
> @@ -595,6 +595,9 @@ static int sharp_memory_probe(struct spi_device *spi)
>   		smd->vcom_mode = SHARP_MEMORY_SOFTWARE_VCOM;
>   		smd->sw_vcom_signal = kthread_run(sharp_memory_sw_vcom_signal_thread,
>   						  smd, "sw_vcom_signal");
> +		if (IS_ERR(smd->sw_vcom_signal))
> +			return dev_err_probe(dev, PTR_ERR(smd->sw_vcom_signal),
> +					     "Failed to start sw_vcom_signal thread\n");
>   
>   	} else if (!strcmp("external", vcom_mode_str)) {
>   		smd->vcom_mode = SHARP_MEMORY_EXTERNAL_VCOM;
> @@ -616,15 +619,21 @@ static int sharp_memory_probe(struct spi_device *spi)
>   	ret = sharp_memory_pipe_init(drm, smd, sharp_memory_formats,
>   				     ARRAY_SIZE(sharp_memory_formats),
>   				     NULL);
> -	if (ret)
> +	if (ret) {
> +		if (smd->sw_vcom_signal)
> +			kthread_stop(smd->sw_vcom_signal);
>   		return dev_err_probe(dev, ret, "Failed to initialize display pipeline.\n");
> +	}
>   
>   	drm_plane_enable_fb_damage_clips(&smd->plane);
>   	drm_mode_config_reset(drm);
>   
>   	ret = drm_dev_register(drm, 0);
> -	if (ret)
> +	if (ret) {
> +		if (smd->sw_vcom_signal)
> +			kthread_stop(smd->sw_vcom_signal);
>   		return dev_err_probe(dev, ret, "Failed to register drm device.\n");
> +	}
>   
>   	drm_client_setup(drm, NULL);
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


