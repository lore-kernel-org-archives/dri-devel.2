Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7404C606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RvfUoK8J;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QTL0IBEI;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RvfUoK8J;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QTL0IBEI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA08B10EFB9;
	Tue, 24 Nov 2026 07:47:44 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D37C410F256
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:47:32 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4B6501FBF8;
 Tue, 24 Nov 2026 07:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795506451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oOy2yoxFTmtBtmqxddydcBqpF8aGEH7F/iYI6h7X9Aw=;
 b=RvfUoK8JJZe4f5lyx5Lz0+zPMnfXTy8v7njLppBgBVYV9+OYxNUS2W9fcwJGqMCAfkOnF3
 aqFG5+egUF2rBiuN8GPJcDMgqd/0M2D6q7Z3iGEPkkh9zp8dMb7YNVpggKpaJ8hF3Ixw0z
 Fl/etUjMWvJJT4KVfs6pGp6IH1jdFpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795506451;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oOy2yoxFTmtBtmqxddydcBqpF8aGEH7F/iYI6h7X9Aw=;
 b=QTL0IBEIbQT850ndMXYNNwXMSr8MzU9rt2RETzPKXHuYtDSO77baHodckBS+K4wuPZvn+w
 mwXZhkOS8Gwt32Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795506451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oOy2yoxFTmtBtmqxddydcBqpF8aGEH7F/iYI6h7X9Aw=;
 b=RvfUoK8JJZe4f5lyx5Lz0+zPMnfXTy8v7njLppBgBVYV9+OYxNUS2W9fcwJGqMCAfkOnF3
 aqFG5+egUF2rBiuN8GPJcDMgqd/0M2D6q7Z3iGEPkkh9zp8dMb7YNVpggKpaJ8hF3Ixw0z
 Fl/etUjMWvJJT4KVfs6pGp6IH1jdFpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795506451;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oOy2yoxFTmtBtmqxddydcBqpF8aGEH7F/iYI6h7X9Aw=;
 b=QTL0IBEIbQT850ndMXYNNwXMSr8MzU9rt2RETzPKXHuYtDSO77baHodckBS+K4wuPZvn+w
 mwXZhkOS8Gwt32Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 744561339F;
 Tue, 24 Nov 2026 07:47:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TsLkCRJBBWuHYQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 24 Nov 2026 07:47:30 +0000
Message-ID: <dfbc0fdf-9490-472a-8649-e392df2e0608@suse.de>
Date: Tue, 24 Nov 2026 08:47:29 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v3 1/5] drm: Split framebuffer pixel offset
 calculation from drm_fb_dma_get_gem_addr()
To: Chen-Yu Tsai <wenst@chromium.org>, Liu Ying <victor.liu@nxp.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-sunxi@lists.linux.dev, imx@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261124074041.115251-1-wenst@chromium.org>
 <20261124074041.115251-2-wenst@chromium.org>
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
In-Reply-To: <20261124074041.115251-2-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; RCPT_COUNT_TWELVE(0.00)[17];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,lists.linux.dev,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, chromium.org:email, suse.de:email]
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

Am 24.11.26 um 08:39 schrieb Chen-Yu Tsai:
> Currently drm_fb_dma_get_gem_addr() calculates the offset into the
> framebuffer memory for the framebuffer's unclipped source coordinates,
> adds that to the framebuffer's backing storage, and returns the result.
>
> We are about to add a variant that uses the clipped source coordinates,
> so there is already some reuse of code. However, calculating the data
> offset for a given pixel is not specific to the DMA FB helpers. The
> offset is only related to the framebuffer.
>
> Split out the offset calculation into a new framebuffer helper so that
> non-DMA users can also reuse the same code.
>
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: <stable@vger.kernel.org> # dependency for next patch
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

This patch is useful on its own and could be merged independently from 
the others.

Best regards
Thomas

> ---
> fb->offsets and fb->pitches are (or should have been) checked by the
> driver's .fb_create callback, either in drm_gem_fb_init_with_funcs()
> or reimplementing the checks directly.
>
> Changes since v2:
> - Change offset local variable and return type to u64, and use
>    mul_u32_u32() to avoid 32-bit overflow before widening
> Changes since v1:
> - New patch
> ---
>   drivers/gpu/drm/drm_fb_dma_helper.c | 28 ++----------------
>   drivers/gpu/drm/drm_framebuffer.c   | 46 +++++++++++++++++++++++++++++
>   include/drm/drm_framebuffer.h       |  3 ++
>   3 files changed, 52 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/drm_fb_dma_helper.c
> index fd71969d2fb1..ab0f37d8a5ff 100644
> --- a/drivers/gpu/drm/drm_fb_dma_helper.c
> +++ b/drivers/gpu/drm/drm_fb_dma_helper.c
> @@ -75,36 +75,14 @@ dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
>   				   unsigned int plane)
>   {
>   	struct drm_gem_dma_object *obj;
> -	dma_addr_t dma_addr;
> -	u8 h_div = 1, v_div = 1;
> -	u32 block_w = drm_format_info_block_width(fb->format, plane);
> -	u32 block_h = drm_format_info_block_height(fb->format, plane);
> -	u32 block_size = fb->format->char_per_block[plane];
> -	u32 sample_x;
> -	u32 sample_y;
> -	u32 block_start_y;
> -	u32 num_hblocks;
>   
>   	obj = drm_fb_dma_get_gem_obj(fb, plane);
>   	if (!obj)
>   		return 0;
>   
> -	dma_addr = obj->dma_addr + fb->offsets[plane];
> -
> -	if (plane > 0) {
> -		h_div = fb->format->hsub;
> -		v_div = fb->format->vsub;
> -	}
> -
> -	sample_x = (state->src_x >> 16) / h_div;
> -	sample_y = (state->src_y >> 16) / v_div;
> -	block_start_y = (sample_y / block_h) * block_h;
> -	num_hblocks = sample_x / block_w;
> -
> -	dma_addr += fb->pitches[plane] * block_start_y;
> -	dma_addr += block_size * num_hblocks;
> -
> -	return dma_addr;
> +	return obj->dma_addr + drm_framebuffer_get_block_offset(fb, plane,
> +								state->src_x >> 16,
> +								state->src_y >> 16);
>   }
>   EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_addr);
>   
> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
> index d32aceb6ca9b..589619bd8f0b 100644
> --- a/drivers/gpu/drm/drm_framebuffer.c
> +++ b/drivers/gpu/drm/drm_framebuffer.c
> @@ -21,6 +21,7 @@
>    */
>   
>   #include <linux/export.h>
> +#include <linux/math64.h>
>   #include <linux/uaccess.h>
>   
>   #include <drm/drm_atomic.h>
> @@ -1208,6 +1209,51 @@ void drm_framebuffer_print_info(struct drm_printer *p, unsigned int indent,
>   	}
>   }
>   
> +/**
> + * drm_framebuffer_get_block_offset() - Get offset to start of pixel block for
> + * the given framebuffer and coordinates.
> + * @fb: The framebuffer
> + * @plane: Which plane
> + * @x: x coordinate for pixel
> + * @y: y coordinate for pixel
> + *
> + * This function will usually be called from the PLANE callback functions,
> + * or from one of the helpers that calculates the framebuffer's DMA address.
> + *
> + * Return: offset from start of framebuffer to start of pixel block
> + */
> +u64 drm_framebuffer_get_block_offset(struct drm_framebuffer *fb, unsigned int plane,
> +				     unsigned int x, unsigned int y)
> +{
> +	u8 h_div = 1, v_div = 1;
> +	u32 block_w = drm_format_info_block_width(fb->format, plane);
> +	u32 block_h = drm_format_info_block_height(fb->format, plane);
> +	u32 block_size = fb->format->char_per_block[plane];
> +	u32 sample_x;
> +	u32 sample_y;
> +	u32 block_start_y;
> +	u32 num_hblocks;
> +	u64 offset;
> +
> +	offset = fb->offsets[plane];
> +
> +	if (plane > 0) {
> +		h_div = fb->format->hsub;
> +		v_div = fb->format->vsub;
> +	}
> +
> +	sample_x = x / h_div;
> +	sample_y = y / v_div;
> +	block_start_y = (sample_y / block_h) * block_h;
> +	num_hblocks = sample_x / block_w;
> +
> +	offset += mul_u32_u32(fb->pitches[plane], block_start_y);
> +	offset += mul_u32_u32(block_size, num_hblocks);
> +
> +	return offset;
> +}
> +EXPORT_SYMBOL(drm_framebuffer_get_block_offset);
> +
>   #ifdef CONFIG_DEBUG_FS
>   static int drm_framebuffer_info(struct seq_file *m, void *data)
>   {
> diff --git a/include/drm/drm_framebuffer.h b/include/drm/drm_framebuffer.h
> index 38b24fc8978d..6f838b485730 100644
> --- a/include/drm/drm_framebuffer.h
> +++ b/include/drm/drm_framebuffer.h
> @@ -220,6 +220,9 @@ void drm_framebuffer_remove(struct drm_framebuffer *fb);
>   void drm_framebuffer_cleanup(struct drm_framebuffer *fb);
>   void drm_framebuffer_unregister_private(struct drm_framebuffer *fb);
>   
> +u64 drm_framebuffer_get_block_offset(struct drm_framebuffer *fb, unsigned int plane,
> +				     unsigned int x, unsigned int y);
> +
>   /**
>    * drm_framebuffer_get - acquire a framebuffer reference
>    * @fb: DRM framebuffer

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


