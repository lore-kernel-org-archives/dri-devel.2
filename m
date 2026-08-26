Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB1AC61DC4
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 09:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 015FF10EC5C;
	Wed, 26 Aug 2026 09:02:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="lVYUUbmW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C8Ek5Y0r";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wcb5vcQX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4G+1oaRE";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E3F610EC5C
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:02:43 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 866088729F;
 Wed, 26 Aug 2026 09:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787734957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dymrFq7cMgaBHpryy8JimJ3C2NvSAsWz1FSzIbvymmw=;
 b=lVYUUbmWB2yPvUIJENwvPR9ZqIrQpdRlXT/MuuvBcF60ORgjyBTBgr/AjWAq7FjMcusdTI
 Zr98D1pxy4+Vecio2N/L/qXdQ1q+IYXlVLBwfwDGQW4aLc0Ol/W9JzGZ39jsoYdadV/rdx
 XaHNIk1Hk8utLQNe36ebGnjYwczi34I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787734957;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dymrFq7cMgaBHpryy8JimJ3C2NvSAsWz1FSzIbvymmw=;
 b=C8Ek5Y0rkPdFtQVo+lY5/RImbuIiMG6UPmotF+752cwtLOBG3iL3TkD4tw93gdT45a5XEP
 7mvoVKVdm6BcOmDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787734953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dymrFq7cMgaBHpryy8JimJ3C2NvSAsWz1FSzIbvymmw=;
 b=Wcb5vcQXekeh2sG9Zld0Vo1AEHMnx6RUj18l5JS2dVJrngr4f/oe9GJP6u95Glp8Siu6nz
 7jABeHPqTBRUYimDPhSIq8AzZ2bNaT9dJ77oFArLKtOcsV14jC6Z0TZ0zZlrLfdrYH03Q5
 Q6MHmCs03SFCWduyMPt9pddWXTSmlq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787734953;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dymrFq7cMgaBHpryy8JimJ3C2NvSAsWz1FSzIbvymmw=;
 b=4G+1oaRE1o0EObOw/SzbPX+8X3uF0rQDqnJr9LqTeye2+VrDUpIJCS9C85gU+D6Gdk6gWC
 0lX8YA0BbFHOeHCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40CF413533;
 Wed, 26 Aug 2026 09:02:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7QycDqmrjmrCVQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 26 Aug 2026 09:02:33 +0000
Message-ID: <4489d462-28f6-4acf-87a0-0a0bdb6a8ccd@suse.de>
Date: Wed, 26 Aug 2026 11:02:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sysfb: Clear entire framebuffer in atomic_disable
To: oushixiong1025@163.com
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
References: <20260826075613.483617-1-oushixiong1025@163.com>
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
In-Reply-To: <20260826075613.483617-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FREEMAIL_TO(0.00)[163.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9];
 FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org,kylinos.cn];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email, suse.de:email, suse.de:mid,
 suse.com:url, imap1.dmz-prg2.suse.org:helo]
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

Am 26.08.26 um 09:56 schrieb oushixiong1025@163.com:
> From: Shixiong Ou <oushixiong@kylinos.cn>
>
> drm_sysfb_plane_helper_atomic_disable() previously used
> plane_state->src_* coordinates to construct the clear rectangle,
> which depends on user-controlled input. Instead, clear the entire
> visible framebuffer region using fb_mode dimensions, and use
> drm_format_info_min_pitch() to compute the safe per-line clear size
> without touching non-visible bytes at the end of each line.
>
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>

Thank you for implementing the idea. This looks good AFAICT

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/sysfb/drm_sysfb_modeset.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> index 9a4c210d6f96..c109ecab9d7a 100644
> --- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> +++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> @@ -376,28 +376,28 @@ void drm_sysfb_plane_helper_atomic_disable(struct drm_plane *plane,
>   	struct drm_device *dev = plane->dev;
>   	struct drm_sysfb_device *sysfb = to_drm_sysfb_device(dev);
>   	struct iosys_map dst = sysfb->fb_addr;
> -	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	void __iomem *dst_vmap = dst.vaddr_iomem; /* TODO: Use mapping abstraction */
>   	unsigned int dst_pitch = sysfb->fb_pitch;
>   	const struct drm_format_info *dst_format = sysfb->fb_format;
>   	struct drm_rect dst_clip;
> -	unsigned long lines, linepixels, i;
> +	unsigned long lines, linepixels, dst_size, i;
>   	int idx;
>   
> -	drm_rect_init(&dst_clip,
> -		      plane_state->src_x >> 16, plane_state->src_y >> 16,
> -		      plane_state->src_w >> 16, plane_state->src_h >> 16);
> +	drm_rect_init(&dst_clip, 0, 0,
> +		      sysfb->fb_mode.hdisplay, sysfb->fb_mode.vdisplay);
>   
>   	lines = drm_rect_height(&dst_clip);
>   	linepixels = drm_rect_width(&dst_clip);
> +	dst_size = min_t(unsigned long,
> +			 drm_format_info_min_pitch(dst_format, 0, linepixels),
> +			 dst_pitch);
>   
>   	if (!drm_dev_enter(dev, &idx))
>   		return;
>   
>   	/* Clear buffer to black if disabled */
> -	dst_vmap += drm_fb_clip_offset(dst_pitch, dst_format, &dst_clip);
>   	for (i = 0; i < lines; ++i) {
> -		memset_io(dst_vmap, 0, linepixels * dst_format->cpp[0]);
> +		memset_io(dst_vmap, 0, dst_size);
>   		dst_vmap += dst_pitch;
>   	}
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


