Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767BC606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=otuoD64u;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Gwzv4cqc;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=otuoD64u;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Gwzv4cqc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D177A10E98A;
	Mon, 16 Nov 2026 07:48:53 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4D8F10E98A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 07:48:41 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 23B331FD07;
 Mon, 16 Nov 2026 07:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794815320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=guRRbYJ5ODIlbpeRuftDzrYA3DIg3+8jJ/nadwjB6uQ=;
 b=otuoD64uc+JP26JxiZ6Qkfpr+N6USGYuzuIz1SlOEv6+uzF0XLMOCniCmsr36hK0oTRC7X
 G9C1k451dCfZhKuZyw6x1dFLV8LaRVnN0ZcHOP9Yy2Be5ObZLNdoyLQaLYI2skm3B1M5wJ
 nK+Y5TCVEHwBpeLN8Tyt5Lpe6XOGbwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794815320;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=guRRbYJ5ODIlbpeRuftDzrYA3DIg3+8jJ/nadwjB6uQ=;
 b=Gwzv4cqcBQqniflQvRU+lT5Frxd0Syk7/1aGdsjmHxLIg8KZbY+fEeE2Rx9/NQfNl0RDB2
 8/ukpa7xEiOg/jCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=otuoD64u;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Gwzv4cqc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794815320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=guRRbYJ5ODIlbpeRuftDzrYA3DIg3+8jJ/nadwjB6uQ=;
 b=otuoD64uc+JP26JxiZ6Qkfpr+N6USGYuzuIz1SlOEv6+uzF0XLMOCniCmsr36hK0oTRC7X
 G9C1k451dCfZhKuZyw6x1dFLV8LaRVnN0ZcHOP9Yy2Be5ObZLNdoyLQaLYI2skm3B1M5wJ
 nK+Y5TCVEHwBpeLN8Tyt5Lpe6XOGbwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794815320;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=guRRbYJ5ODIlbpeRuftDzrYA3DIg3+8jJ/nadwjB6uQ=;
 b=Gwzv4cqcBQqniflQvRU+lT5Frxd0Syk7/1aGdsjmHxLIg8KZbY+fEeE2Rx9/NQfNl0RDB2
 8/ukpa7xEiOg/jCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 987EF13408;
 Mon, 16 Nov 2026 07:48:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dXiCE1e1+mqmPQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 16 Nov 2026 07:48:39 +0000
Message-ID: <556dd1ab-a1af-4c8b-be6e-04382ed0b958@suse.de>
Date: Mon, 16 Nov 2026 08:48:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/fbdev-dma: Copy the shadow buffer on unblank
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Javier Martinez Canillas <javierm@redhat.com>
References: <20261112091630.3947184-1-angelo.compagnucci@gmail.com>
 <20261113110708.927665-1-angelo.compagnucci@gmail.com>
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
In-Reply-To: <20261113110708.927665-1-angelo.compagnucci@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 23B331FD07
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.00 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 XM_UA_NO_VERSION(0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,kernel.org,lists.freedesktop.org]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,redhat.com];
 RCPT_COUNT_SEVEN(0.00)[7]; TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, bootlin.com:url, suse.com:url]
X-Spam-Score: -12.00
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

Am 13.11.26 um 12:07 schrieb Angelo Compagnucci:
> With a shadow buffer, what userspace draws in fbdev reaches the
> framebuffer memory only when the damage worker runs. Turning the display
> on shows the framebuffer memory as it is. So a program that draws its
> first picture and then unblanks, such as a boot splash, shows an older
> picture for a moment.
>
> Seen on an ILI9341 panel (tinydrm ili9341): enabling the pipe sends the
> whole framebuffer memory to the panel, still black, and the splash only
> replaces it once the damage worker runs.
>
> Nothing can be flushed to a display that is off. But the copy from the
> shadow buffer into the framebuffer memory does not need the display. On
> unblank, copy the whole shadow buffer into the framebuffer memory before
> turning the display on. The damage worker still flushes the damage once
> the display is on.
>
> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> ---
> Changes v1 -> v2:
>    - Do not flush the damage before unblanking: nothing can reach a
>      display that is off. Instead, in fbdev-dma, copy the whole shadow
>      buffer into the framebuffer memory on unblank, which needs no
>      display [Thomas Zimmermann]

That's not really the issue. There's hardware/drivers where we need the 
CRTC to be switched on before we can transfer display data. Search 
drm_atomic_helper_commit_tail_rpm() [1] for that. IDK how much of a 
problem this is in practice. Flushing buffers on such a system might 
give actual errors instead of just some temporary display noise.

What exactly are you trying to achieve?

[1] 
https://elixir.bootlin.com/linux/v7.3.1/source/drivers/gpu/drm/drm_atomic_helper.c#L2009

Best regards
Thomas


>    - The fbdev helpers are unchanged, so the title changed too; v1 was
>      "drm/fb-helper: flush damage before unblanking"
>
>   drivers/gpu/drm/drm_fbdev_dma.c | 44 ++++++++++++++++++++++++++-------
>   1 file changed, 35 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_fbdev_dma.c b/drivers/gpu/drm/drm_fbdev_dma.c
> index 452f84400350..cc8813538bd9 100644
> --- a/drivers/gpu/drm/drm_fbdev_dma.c
> +++ b/drivers/gpu/drm/drm_fbdev_dma.c
> @@ -93,15 +93,6 @@ static void drm_fbdev_dma_shadowed_fb_destroy(struct fb_info *info)
>   	drm_client_release(&fb_helper->client);
>   }
>   
> -static const struct fb_ops drm_fbdev_dma_shadowed_fb_ops = {
> -	.owner = THIS_MODULE,
> -	.fb_open = drm_fbdev_dma_fb_open,
> -	.fb_release = drm_fbdev_dma_fb_release,
> -	FB_DEFAULT_DEFERRED_OPS(drm_fbdev_dma_shadowed),
> -	DRM_FB_HELPER_DEFAULT_OPS,
> -	.fb_destroy = drm_fbdev_dma_shadowed_fb_destroy,
> -};
> -
>   /*
>    * struct drm_fb_helper
>    */
> @@ -196,6 +187,41 @@ static const struct drm_fb_helper_funcs drm_fbdev_dma_helper_funcs = {
>    * struct drm_fb_helper
>    */
>   
> +static int drm_fbdev_dma_shadowed_fb_blank(int blank, struct fb_info *info)
> +{
> +	struct drm_fb_helper *fb_helper = info->par;
> +	struct drm_clip_rect clip = {
> +		.x2 = fb_helper->fb->width,
> +		.y2 = fb_helper->fb->height,
> +	};
> +
> +	/*
> +	 * Turning the display on shows the framebuffer memory. Copy the
> +	 * shadow buffer into it first, so it holds what was drawn. This
> +	 * does not need the display; the damage worker still flushes the
> +	 * damage once the display is on.
> +	 */
> +	if (blank == FB_BLANK_UNBLANK)
> +		drm_fbdev_dma_damage_blit(fb_helper, &clip);
> +
> +	return drm_fb_helper_blank(blank, info);
> +}
> +
> +static const struct fb_ops drm_fbdev_dma_shadowed_fb_ops = {
> +	.owner = THIS_MODULE,
> +	.fb_open = drm_fbdev_dma_fb_open,
> +	.fb_release = drm_fbdev_dma_fb_release,
> +	FB_DEFAULT_DEFERRED_OPS(drm_fbdev_dma_shadowed),
> +	/* DRM_FB_HELPER_DEFAULT_OPS, with a blank that copies the shadow */
> +	.fb_check_var = drm_fb_helper_check_var,
> +	.fb_set_par = drm_fb_helper_set_par,
> +	.fb_setcmap = drm_fb_helper_setcmap,
> +	.fb_blank = drm_fbdev_dma_shadowed_fb_blank,
> +	.fb_pan_display = drm_fb_helper_pan_display,
> +	.fb_ioctl = drm_fb_helper_ioctl,
> +	.fb_destroy = drm_fbdev_dma_shadowed_fb_destroy,
> +};
> +
>   static int drm_fbdev_dma_driver_fbdev_probe_tail(struct drm_fb_helper *fb_helper,
>   						 struct drm_fb_helper_surface_size *sizes)
>   {

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


