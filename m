Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08647CC6B0F
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3928910E74E;
	Tue, 13 Oct 2026 07:11:55 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A27710F504
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 07:11:43 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 15BA221F63;
 Tue, 13 Oct 2026 07:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791875502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Y3EbprZowi6aXLTEY89acelPd95mHvgoSDTQsddNejQ=;
 b=CDxhC/f9WDlkPkrAm7wtX6ehHbrqBywz0l7T0ly5yyPwhEa2eTBhP7+NrLrlE4RDXoNuFB
 dHM81Ln2NNj79VdSqjvgfQlqDqLnAmxP4JBNoDX+WNO8r+3NgoiVQRjh8VMKryYeA9wtyo
 KUS2jmqcnzjhzMNsejqxMQf88cc586w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791875502;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Y3EbprZowi6aXLTEY89acelPd95mHvgoSDTQsddNejQ=;
 b=IPL46ARl1jPdkdk4UbcOylbt+zv+VJlY2wTSkwSS8PdDSy52JEr2NUyq2rJI/gm2MEAM8Z
 5x3dRbPNGjixU4CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791875502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Y3EbprZowi6aXLTEY89acelPd95mHvgoSDTQsddNejQ=;
 b=CDxhC/f9WDlkPkrAm7wtX6ehHbrqBywz0l7T0ly5yyPwhEa2eTBhP7+NrLrlE4RDXoNuFB
 dHM81Ln2NNj79VdSqjvgfQlqDqLnAmxP4JBNoDX+WNO8r+3NgoiVQRjh8VMKryYeA9wtyo
 KUS2jmqcnzjhzMNsejqxMQf88cc586w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791875502;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Y3EbprZowi6aXLTEY89acelPd95mHvgoSDTQsddNejQ=;
 b=IPL46ARl1jPdkdk4UbcOylbt+zv+VJlY2wTSkwSS8PdDSy52JEr2NUyq2rJI/gm2MEAM8Z
 5x3dRbPNGjixU4CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C70D1349D;
 Tue, 13 Oct 2026 07:11:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id W0lcOazZzWpHTgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 13 Oct 2026 07:11:41 +0000
Message-ID: <64707239-eac7-4259-a8ff-7ec43d13860e@suse.de>
Date: Tue, 13 Oct 2026 09:11:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/format-helper: Add XRGB8888 to UYVY conversion
To: Ho Jie Feng <hjf3108@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
References: <20261012170857.199561-1-hjf3108@gmail.com>
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
In-Reply-To: <20261012170857.199561-1-hjf3108@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,vger.kernel.org];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo]
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

Am 12.10.26 um 19:08 schrieb Ho Jie Feng:
> Add a helper for devices that use packed UYVY but accept XRGB8888
> framebuffers.

Is there a description of UYVY available somewhere?

>
> Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
> ---
> This is used for a driver, ms912x that I will be submitting. It only
> supports uyvy framebuffers.

Please resubmit as part of the driver series. We're not going to merge 
it without callers anyway.

>
>   drivers/gpu/drm/drm_format_helper.c   | 73 +++++++++++++++++++++++++++
>   drivers/gpu/drm/drm_format_internal.h | 21 ++++++++
>   include/drm/drm_format_helper.h       |  4 ++
>   3 files changed, 98 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
> index 6cddf05c493bd..606733ca43fb4 100644
> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -1379,3 +1379,76 @@ void drm_fb_xrgb8888_to_gray2(struct iosys_map *dst, const unsigned int *dst_pit
>   }
>   EXPORT_SYMBOL(drm_fb_xrgb8888_to_gray2);
>   
> +static void drm_fb_xrgb8888_to_uyvy_line(void *dbuf, const void *sbuf, unsigned int width)
> +{
> +	u8 *transfer_buffer = dbuf;
> +	const __le32 *temp_buffer = sbuf;

For naming, please follow the conventions used by the other helpers in 
this file.

> +	unsigned int i, dst_offset = 0;
> +	unsigned int pixel1, pixel2;
> +	unsigned int r1, g1, b1, r2, g2, b2;
> +	unsigned int r, g, b;
> +	unsigned int v, y1, u, y2;
> +
> +	for (i = 0; i < width; i += 2) {
> +		pixel1 = le32_to_cpup(&temp_buffer[i]);
> +		pixel2 = le32_to_cpup(&temp_buffer[i + 1]);
> +
> +		r1 = (pixel1 & 0x00ff0000) >> 16;
> +		g1 = (pixel1 & 0x0000ff00) >> 8;
> +		b1 =  pixel1 & 0x000000ff;
> +		r2 = (pixel2 & 0x00ff0000) >> 16;
> +		g2 = (pixel2 & 0x0000ff00) >> 8;
> +		b2 =  pixel2 & 0x000000ff;
> +
> +		y1 = drm_pixel_rgb_to_y_bt601(r1, g1, b1);
> +		y2 = drm_pixel_rgb_to_y_bt601(r2, g2, b2);
> +
> +		r = r1 + r2;
> +		g = g1 + g2;
> +		b = b1 + b2;
> +
> +		v = drm_pixel_rgb2_to_v_bt601(r, g, b);
> +		u = drm_pixel_rgb2_to_u_bt601(r, g, b);
> +
> +		transfer_buffer[dst_offset++] = u;
> +		transfer_buffer[dst_offset++] = y1;
> +		transfer_buffer[dst_offset++] = v;
> +		transfer_buffer[dst_offset++] = y2;

Rather that writing bytes individually, use put_unaligned_le32() or a 
similar helper.  Byte order within a pixel is little endian, although 
I'm not sure what this means for UYVY.

> +	}
> +}
> +
> +/**
> + * drm_fb_xrgb8888_to_uyvy - Convert XRGB8888 to UYVY clip buffer
> + * @dst: Array of UYVY destination buffers
> + * @dst_pitch: Array of numbers of bytes between the start of two consecutive scanlines
> + *             within @dst; can be NULL if scanlines are stored next to each other.
> + * @src: Array of XRGB8888 source buffers
> + * @fb: DRM framebuffer
> + * @clip: Clip rectangle area to copy; x1 and x2 must be even
> + * @state: Transform and conversion state
> + *
> + * This function copies parts of a framebuffer to display memory and converts the
> + * color format during the process. The parameters @dst, @dst_pitch and @src refer
> + * to arrays. Each array must have at least as many entries as there are planes in
> + * @fb's format. Each entry stores the value for the format's respective color plane
> + * at the same index.
> + *
> + * This function does not apply clipping on @dst (i.e. the destination is at the
> + * top-left corner).
> + *
> + * Drivers can use this function for UYVY devices that don't support XRGB8888
> + * natively. ITU BT.601 is being used for the RGB -> YUV conversion.
> + */
> +void drm_fb_xrgb8888_to_uyvy(struct iosys_map *dst, const unsigned int *dst_pitch,
> +			     const struct iosys_map *src, const struct drm_framebuffer *fb,
> +			     const struct drm_rect *clip, struct drm_format_conv_state *state)
> +{
> +	static const u8 dst_pixsize[DRM_FORMAT_MAX_PLANES] = {
> +		2,
> +	};
> +
> +	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, src, fb, clip, false, state,
> +		    drm_fb_xrgb8888_to_uyvy_line);
> +}
> +EXPORT_SYMBOL(drm_fb_xrgb8888_to_uyvy);
> +
> diff --git a/drivers/gpu/drm/drm_format_internal.h b/drivers/gpu/drm/drm_format_internal.h
> index ce29dd05bcc55..7a4cfb0d188cb 100644
> --- a/drivers/gpu/drm/drm_format_internal.h
> +++ b/drivers/gpu/drm/drm_format_internal.h
> @@ -159,6 +159,27 @@ static inline u32 drm_pixel_xrgb8888_to_abgr2101010(u32 pix)
>   	       drm_pixel_xrgb8888_to_xbgr2101010(pix);
>   }
>   
> +static inline u32 drm_pixel_rgb_to_y_bt601(u32 r, u32 g, u32 b)
> +{
> +	const u32 luma = (16U << 16) + 16829 * r + 33039 * g + 6416 * b + 32768;
> +
> +	return luma >> 16;
> +}
> +
> +static inline u32 drm_pixel_rgb2_to_u_bt601(u32 r2, u32 g2, u32 b2)
> +{
> +	const u32 u = (128U << 17) - 9714 * r2 - 19071 * g2 + 28784 * b2 + 65536;
> +
> +	return u >> 17;
> +}
> +
> +static inline u32 drm_pixel_rgb2_to_v_bt601(u32 r2, u32 g2, u32 b2)
> +{
> +	const u32 v = (128U << 17) + 28784 * r2 - 24103 * g2 - 4681 * b2 + 65536;
> +
> +	return v >> 17;
> +}
> +

These helpers seem too fine-grained. IMHO it would be better to have a 
helper like  drm_pixel_rgb_to_uyvy() that takes two RGB values and 
returns the assembled 16-bit UYVY value.

Best regards
Thomas

>   /*
>    * Conversion from ARGB8888
>    */
> diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
> index 2b5c1aef80b0e..e50f96e07484c 100644
> --- a/include/drm/drm_format_helper.h
> +++ b/include/drm/drm_format_helper.h
> @@ -136,4 +136,8 @@ void drm_fb_xrgb8888_to_gray2(struct iosys_map *dst, const unsigned int *dst_pit
>   			      const struct iosys_map *src, const struct drm_framebuffer *fb,
>   			      const struct drm_rect *clip, struct drm_format_conv_state *state);
>   
> +void drm_fb_xrgb8888_to_uyvy(struct iosys_map *dst, const unsigned int *dst_pitch,
> +			     const struct iosys_map *src, const struct drm_framebuffer *fb,
> +			     const struct drm_rect *clip, struct drm_format_conv_state *state);
> +
>   #endif /* __LINUX_DRM_FORMAT_HELPER_H */

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


