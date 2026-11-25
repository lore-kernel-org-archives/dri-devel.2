Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D549D606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Z0IO74jY;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tab7oHoK;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Z0IO74jY;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tab7oHoK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F13F210E1DC;
	Wed, 25 Nov 2026 14:39:14 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F28710E1DC
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 14:39:03 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 01C1E21EA3;
 Wed, 25 Nov 2026 14:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795617542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=w1k0JasMDVnxxHnD7TaSvpEAx3hcO7tS9A0nVEqyPcU=;
 b=Z0IO74jYAHe+FEwdl3BIPXcRAuPtpPwdnVGgWBgL5Lxvs6FfFlDcPamWkPARoc8qXgu4wT
 cFWDPq3hkQB9bsStEpnSWlNnhmVCNhjqRaQREH+DjPcpLLSKGefPg+Bq3kKHH+SrAOZ7i+
 mbKU+rSmSbLpcv+To7nrv76ZUGp5KeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795617542;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=w1k0JasMDVnxxHnD7TaSvpEAx3hcO7tS9A0nVEqyPcU=;
 b=tab7oHoK17Kr8v7XgTwKusZp8yznzPhU4sTnXn9Xb8gCcZEaDt1XFM6LVrN1se4XRjSbkY
 G2QBVwGrxYEECHCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795617542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=w1k0JasMDVnxxHnD7TaSvpEAx3hcO7tS9A0nVEqyPcU=;
 b=Z0IO74jYAHe+FEwdl3BIPXcRAuPtpPwdnVGgWBgL5Lxvs6FfFlDcPamWkPARoc8qXgu4wT
 cFWDPq3hkQB9bsStEpnSWlNnhmVCNhjqRaQREH+DjPcpLLSKGefPg+Bq3kKHH+SrAOZ7i+
 mbKU+rSmSbLpcv+To7nrv76ZUGp5KeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795617542;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=w1k0JasMDVnxxHnD7TaSvpEAx3hcO7tS9A0nVEqyPcU=;
 b=tab7oHoK17Kr8v7XgTwKusZp8yznzPhU4sTnXn9Xb8gCcZEaDt1XFM6LVrN1se4XRjSbkY
 G2QBVwGrxYEECHCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7121D134CA;
 Wed, 25 Nov 2026 14:39:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7YlmCQXzBmsDcAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 25 Nov 2026 14:39:01 +0000
Message-ID: <7a8138e9-60de-4a60-a036-6c9be9dbb986@suse.de>
Date: Wed, 25 Nov 2026 15:39:00 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/sti: cursor: do not resize the pixmap from
 .atomic_check()
To: Minseo Park <hiyoukou@gmail.com>, dri-devel@lists.freedesktop.org
Cc: alain.volmat@foss.st.com, rgallaispou@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, benjamin.gaignard@linaro.org
References: <20261125142330.15298-1-hiyoukou@gmail.com>
 <20261125142330.15298-2-hiyoukou@gmail.com>
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
In-Reply-To: <20261125142330.15298-2-hiyoukou@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[];
 FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[9]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[foss.st.com,gmail.com,linux.intel.com,kernel.org,ffwll.ch,linaro.org];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29
X-Spam-Level: 
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

Hi

Am 25.11.26 um 15:23 schrieb Minseo Park:
> sti_cursor_atomic_check() resizes the cursor pixmap whenever the
> requested size differs from the one it cached: it frees the buffer the
> hardware is using and allocates a new one.
>
> That is commit work done in the check phase.  An atomic commit with
> DRM_MODE_ATOMIC_TEST_ONLY runs drm_atomic_check_only(), which calls the
> plane .atomic_check() hooks and returns without ever calling
> .atomic_update(), and a commit whose check fails on some other object is
> dropped the same way.  In both cases the buffer is freed while CUR_PML
> still points at it, so the display engine keeps fetching the cursor from
> memory that has gone back to the DMA pool, until some later commit
> reprograms the register.
>
> .atomic_check() already rejects a cursor wider or taller than
> STI_CURS_MAX_SIZE, and the pixmap is CLUT8, so it never needs to be
> larger than 128 * 128 bytes.  Allocate it once when the plane is created
> and keep it for the lifetime of the device, with the managed allocator
> so that it is released on unbind.  Nothing has to be resized afterwards.
>
> With the pixmap no longer resized, struct sti_cursor does not need to
> cache the cursor size either.  .atomic_update() takes it from the plane
> state it is handed, which is the state .atomic_check() validated.  The
> dev member goes with them, it only had users in the code being removed.
>
> Fixes: dd86dc2f9ae1 ("drm/sti: implement atomic_check for the planes")
> Signed-off-by: Minseo Park <hiyoukou@gmail.com>
> ---
>   drivers/gpu/drm/sti/sti_cursor.c | 65 ++++++++++++++------------------
>   1 file changed, 28 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti/sti_cursor.c
> index 66f56355309f..0f0d7405dfef 100644
> --- a/drivers/gpu/drm/sti/sti_cursor.c
> +++ b/drivers/gpu/drm/sti/sti_cursor.c
> @@ -53,20 +53,14 @@ struct dma_pixmap {
>    * STI Cursor structure
>    *
>    * @sti_plane:    sti_plane structure
> - * @dev:          driver device
>    * @regs:         cursor registers
> - * @width:        cursor width
> - * @height:       cursor height
>    * @clut:         color look up table
>    * @clut_paddr:   color look up table physical address
>    * @pixmap:       pixmap dma buffer (clut8-format cursor)
>    */
>   struct sti_cursor {
>   	struct sti_plane plane;
> -	struct device *dev;
>   	void __iomem *regs;
> -	unsigned int width;
> -	unsigned int height;
>   	unsigned short *clut;
>   	dma_addr_t clut_paddr;
>   	struct dma_pixmap pixmap;
> @@ -146,14 +140,15 @@ static void cursor_debugfs_init(struct sti_cursor *cursor,
>   				 minor->debugfs_root, minor);
>   }
>   
> -static void sti_cursor_argb8888_to_clut8(struct sti_cursor *cursor, u32 *src)
> +static void sti_cursor_argb8888_to_clut8(struct sti_cursor *cursor, u32 *src,
> +					 unsigned int width, unsigned int height)
>   {
>   	u8  *dst = cursor->pixmap.base;
>   	unsigned int i, j;
>   	u32 a, r, g, b;
>   
> -	for (i = 0; i < cursor->height; i++) {
> -		for (j = 0; j < cursor->width; j++) {
> +	for (i = 0; i < height; i++) {
> +		for (j = 0; j < width; j++) {
>   			/* Pick the 2 higher bits of each component */
>   			a = (*src >> 30) & 3;
>   			r = (*src >> 22) & 3;
> @@ -188,7 +183,6 @@ static int sti_cursor_atomic_check(struct drm_plane *drm_plane,
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 drm_plane);
>   	struct sti_plane *plane = to_sti_plane(drm_plane);
> -	struct sti_cursor *cursor = to_sti_cursor(plane);
>   	struct drm_crtc *crtc = new_plane_state->crtc;
>   	struct drm_framebuffer *fb = new_plane_state->fb;
>   	struct drm_crtc_state *crtc_state;
> @@ -224,29 +218,6 @@ static int sti_cursor_atomic_check(struct drm_plane *drm_plane,
>   		return -EINVAL;
>   	}
>   
> -	/* If the cursor size has changed, re-allocated the pixmap */
> -	if (!cursor->pixmap.base ||
> -	    (cursor->width != src_w) ||
> -	    (cursor->height != src_h)) {
> -		cursor->width = src_w;
> -		cursor->height = src_h;
> -
> -		if (cursor->pixmap.base)
> -			dma_free_wc(cursor->dev, cursor->pixmap.size,
> -				    cursor->pixmap.base, cursor->pixmap.paddr);
> -
> -		cursor->pixmap.size = cursor->width * cursor->height;
> -
> -		cursor->pixmap.base = dma_alloc_wc(cursor->dev,
> -						   cursor->pixmap.size,
> -						   &cursor->pixmap.paddr,
> -						   GFP_KERNEL);
> -		if (!cursor->pixmap.base) {
> -			DRM_ERROR("Failed to allocate memory for pixmap\n");
> -			return -EINVAL;
> -		}
> -	}
> -
>   	if (!drm_fb_dma_get_gem_obj(fb, 0)) {
>   		DRM_ERROR("Can't get DMA GEM object for fb\n");
>   		return -EINVAL;
> @@ -271,6 +242,7 @@ static void sti_cursor_atomic_update(struct drm_plane *drm_plane,
>   	struct drm_framebuffer *fb = newstate->fb;
>   	struct drm_display_mode *mode;
>   	int dst_x, dst_y;
> +	unsigned int src_w, src_h;
>   	struct drm_gem_dma_object *dma_obj;
>   	u32 y, x;
>   	u32 val;
> @@ -281,11 +253,15 @@ static void sti_cursor_atomic_update(struct drm_plane *drm_plane,
>   	mode = &crtc->mode;
>   	dst_x = newstate->crtc_x;
>   	dst_y = newstate->crtc_y;
> +	/* src_w and src_h are in 16.16 format */
> +	src_w = newstate->src_w >> 16;
> +	src_h = newstate->src_h >> 16;
>   
>   	dma_obj = drm_fb_dma_get_gem_obj(fb, 0);
>   
>   	/* Convert ARGB8888 to CLUT8 */
> -	sti_cursor_argb8888_to_clut8(cursor, (u32 *)dma_obj->vaddr);
> +	sti_cursor_argb8888_to_clut8(cursor, (u32 *)dma_obj->vaddr,
> +				     src_w, src_h);
>   
>   	/* AWS and AWE depend on the mode */
>   	y = sti_vtg_get_line_number(*mode, 0);
> @@ -299,8 +275,8 @@ static void sti_cursor_atomic_update(struct drm_plane *drm_plane,
>   
>   	/* Set memory location, size, and position */
>   	writel(cursor->pixmap.paddr, cursor->regs + CUR_PML);
> -	writel(cursor->width, cursor->regs + CUR_PMP);
> -	writel(cursor->height << 16 | cursor->width, cursor->regs + CUR_SIZE);
> +	writel(src_w, cursor->regs + CUR_PMP);
> +	writel(src_h << 16 | src_w, cursor->regs + CUR_SIZE);
>   
>   	y = sti_vtg_get_line_number(*mode, dst_y);
>   	x = sti_vtg_get_pixel_number(*mode, dst_x);
> @@ -377,6 +353,22 @@ struct drm_plane *sti_cursor_create(struct drm_device *drm_dev,
>   		return NULL;
>   	}
>   
> +	/*
> +	 * Allocate the pixmap once, for the largest cursor the hardware
> +	 * supports.  It used to be reallocated from .atomic_check(), which
> +	 * freed a buffer the display engine could still be scanning out.
> +	 * Use the managed helper so it is released with the device.
> +	 */
> +	cursor->pixmap.size = STI_CURS_MAX_SIZE * STI_CURS_MAX_SIZE;
> +	cursor->pixmap.base = dmam_alloc_attrs(dev, cursor->pixmap.size,
> +					       &cursor->pixmap.paddr,
> +					       GFP_KERNEL,
> +					       DMA_ATTR_WRITE_COMBINE);
> +	if (!cursor->pixmap.base) {
> +		DRM_ERROR("Failed to allocate memory for pixmap\n");

This macro needs to become drm_err().

Best regards
Thomas

> +		goto err_clut;
> +	}
> +
>   	/* Allocate clut buffer */
>   	size = 0x100 * sizeof(unsigned short);
>   	cursor->clut = dma_alloc_wc(dev, size, &cursor->clut_paddr,
> @@ -387,7 +379,6 @@ struct drm_plane *sti_cursor_create(struct drm_device *drm_dev,
>   		goto err_clut;
>   	}
>   
> -	cursor->dev = dev;
>   	cursor->regs = baseaddr;
>   	cursor->plane.desc = desc;
>   	cursor->plane.status = STI_PLANE_DISABLED;

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


