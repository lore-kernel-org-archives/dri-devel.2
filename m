Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD092C98317
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D6FC10F4D4;
	Thu, 24 Sep 2026 12:05:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="VQukQEwz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jQ6jfFL7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VmqcXyyu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3Xryt/r2";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 725D210F4D4
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 12:05:14 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C1DBC21F43;
 Thu, 24 Sep 2026 12:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790251508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3/ut1muUCOASS07qjNauoQjT+MCK7YbrWPDfElhjUq0=;
 b=VQukQEwz6ybiS0uNN1gVJWrXQdqk8qLiyDQV0Zyw/PuFI02kkbCxkoxX4w5P7CpQB21d7a
 0XcPQdAdBktrtZOp6DzOd2QiQavGQSgfdYiuvag1bsB6ccijcAlwyBsEAbpCCZXP9xia5A
 LhYQdi6P0/xu8cK63GP4OqsPujr8It4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790251508;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3/ut1muUCOASS07qjNauoQjT+MCK7YbrWPDfElhjUq0=;
 b=jQ6jfFL7fV8hfaPF0buBg5dg2UedfrcspqeJVTZ9lg/TxeVe7qsCzQ7RNIRPIkYopV4TL8
 wySbo0U+c+Q+viDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790251504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3/ut1muUCOASS07qjNauoQjT+MCK7YbrWPDfElhjUq0=;
 b=VmqcXyyuxzK4Ciwl9HeOR0M6r6z9s14Ep/WfD42Y4llu/sKR/cCFjW9eVX+ZXNjf8Wqo6X
 CXk+1/ArmTy5ShPWXLiPDq8WNo2EOwKmUeSpTannaQGInjTfKMB7rP+QmiqumlFseOq1qF
 MwS+MvYrwdVWrKjDBHK7yY0YP/cV2x4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790251504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3/ut1muUCOASS07qjNauoQjT+MCK7YbrWPDfElhjUq0=;
 b=3Xryt/r2s/pG04N8bEI/fUVohKjBIJ8pF4wYB1fNGWPpneS27EADisWSECJI2X40fxYRzJ
 /YDpALDej/iWewCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D94F13354;
 Thu, 24 Sep 2026 12:05:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id k5tBAvARtWryTAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 24 Sep 2026 12:05:04 +0000
Message-ID: <e32e77d3-bb57-43b2-bf61-41ee73055cb8@suse.de>
Date: Thu, 24 Sep 2026 14:05:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] fbdev: describe where the boot logo goes in one
 place
To: Max Pedraza <maximpedraza@gmail.com>, Helge Deller <deller@gmx.de>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260923201035.51007-1-maximpedraza@gmail.com>
 <20260923201035.51007-2-maximpedraza@gmail.com>
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
In-Reply-To: <20260923201035.51007-2-maximpedraza@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_SEVEN(0.00)[11];
 FREEMAIL_TO(0.00)[gmail.com,gmx.de,ffwll.ch,kernel.org];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[dt];
 MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, imap1.dmz-prg2.suse.org:helo,
 suse.com:url]
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

Am 23.09.26 um 22:10 schrieb Max Pedraza:
> fb_prepare_logo() works out how many rows to keep clear for the logo and
> fb_show_logo_line() works out where to draw it, and both of them open code
> the same decision: centred if fb_center_logo, top left otherwise. The two
> calculations have to agree, because fbcon erases whatever falls outside the
> rows that were reserved, and nothing makes them.
>
> Give the position a small structure of its own, with -1 on an axis meaning
> centre on that axis, and have both callers ask for it. fb_center_logo
> becomes {-1, -1} rather than a second path, and the arithmetic lives in one
> function that both use, so they cannot end up disagreeing.
>
> The structure and logo_place_axis() go in linux_logo.h rather than in the
> frame buffer code, since where a logo goes is a property of the logo, not
> of the one thing that draws it today.

No, the position is not a property of the logo. The code in linux_logo.h 
is only about the image itself.

In the case of fbdev, the policy for drawin the the image should be part 
of fbcon.

Best regards
Thomas

>
> logo_place_axis() also clamps, which the open coded version did not: the
> result is now always a position at which the logo lies entirely on screen.
> That is not reachable today, since the only positions are the two the
> console offers, but it stops being something the next caller has to
> remember.
>
> No functional change intended.
>
> Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
> ---
>   drivers/video/fbdev/core/fb_logo.c | 58 +++++++++++++++++++-----------
>   include/linux/linux_logo.h         | 29 +++++++++++++++
>   2 files changed, 67 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/video/fbdev/core/fb_logo.c b/drivers/video/fbdev/core/fb_logo.c
> index 0bab8352b6..5ec9f9554f 100644
> --- a/drivers/video/fbdev/core/fb_logo.c
> +++ b/drivers/video/fbdev/core/fb_logo.c
> @@ -8,6 +8,17 @@
>   bool fb_center_logo __read_mostly;
>   int fb_logo_count __read_mostly = -1;
>   
> +/*
> + * The placement in effect, as asked for on the console command line.
> + */
> +static const struct logo_placement *fb_logo_placement(void)
> +{
> +	static const struct logo_placement centred = { .x = -1, .y = -1 };
> +	static const struct logo_placement top_left = { };
> +
> +	return fb_center_logo ? &centred : &top_left;
> +}
> +
>   static inline unsigned int safe_shift(unsigned int d, int n)
>   {
>   	return n < 0 ? d >> -n : d << n;
> @@ -281,7 +292,11 @@ static int fb_show_logo_line(struct fb_info *info, int rotate,
>   {
>   	u32 *palette = NULL, *saved_pseudo_palette = NULL;
>   	unsigned char *logo_new = NULL, *logo_rotate = NULL;
> +	const struct logo_placement *p;
> +	unsigned int xres = info->var.xres;
> +	unsigned int yres = info->var.yres;
>   	struct fb_image image;
> +	unsigned int block;
>   
>   	/* Return if the frame buffer is not mapped or suspended */
>   	if (logo == NULL || info->state != FBINFO_STATE_RUNNING ||
> @@ -322,26 +337,22 @@ static int fb_show_logo_line(struct fb_info *info, int rotate,
>   		fb_set_logo(info, logo, logo_new, fb_logo.depth);
>   	}
>   
> -	if (fb_center_logo) {
> -		int xres = info->var.xres;
> -		int yres = info->var.yres;
> +	image.width = logo->width;
> +	image.height = logo->height;
>   
> -		if (rotate == FB_ROTATE_CW || rotate == FB_ROTATE_CCW) {
> -			xres = info->var.yres;
> -			yres = info->var.xres;
> -		}
> +	if (rotate == FB_ROTATE_CW || rotate == FB_ROTATE_CCW)
> +		swap(xres, yres);
>   
> -		while (n && (n * (logo->width + 8) - 8 > xres))
> -			--n;
> -		image.dx = (xres - (n * (logo->width + 8) - 8)) / 2;
> -		image.dy = y ?: (yres - logo->height) / 2;
> -	} else {
> -		image.dx = 0;
> -		image.dy = y;
> -	}
> +	while (n && (n * (logo->width + 8) - 8 > xres))
> +		--n;
>   
> -	image.width = logo->width;
> -	image.height = logo->height;
> +	/* The copies are drawn in a row, so they are centred as one block */
> +	block = n ? n * (logo->width + 8) - 8 : logo->width;
> +
> +	p = fb_logo_placement();
> +	image.dx = logo_place_axis(p->x, xres, block);
> +	/* A stacked logo goes where the caller put it */
> +	image.dy = y ? y : logo_place_axis(p->y, yres, image.height);
>   
>   	if (rotate) {
>   		logo_rotate = kmalloc_array(logo->width, logo->height,
> @@ -418,6 +429,7 @@ static int fb_show_extra_logos(struct fb_info *info, int y, int rotate)
>   int fb_prepare_logo(struct fb_info *info, int rotate)
>   {
>   	int depth = fb_get_color_depth(&info->var, &info->fix);
> +	const struct logo_placement *p;
>   	unsigned int yres;
>   	int height;
>   
> @@ -480,9 +492,15 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
>   		}
>   	}
>   
> -	height = fb_logo.logo->height;
> -	if (fb_center_logo)
> -		height += (yres - fb_logo.logo->height) / 2;
> +	/*
> +	 * fbcon only leaves the first @height rows of the screen alone, so a
> +	 * logo placed further down would be drawn and then immediately
> +	 * cleared. Ask the same placement fb_show_logo_line() will use, so
> +	 * that the two cannot disagree.
> +	 */
> +	p = fb_logo_placement();
> +	height = logo_place_axis(p->y, yres, fb_logo.logo->height) +
> +		 fb_logo.logo->height;
>   #ifdef CONFIG_FB_LOGO_EXTRA
>   	height = fb_prepare_extra_logos(info, height, yres);
>   #endif
> diff --git a/include/linux/linux_logo.h b/include/linux/linux_logo.h
> index 1e727a2cb4..b3b15d3800 100644
> --- a/include/linux/linux_logo.h
> +++ b/include/linux/linux_logo.h
> @@ -13,6 +13,8 @@
>    */
>   
>   #include <linux/init.h>
> +#include <linux/minmax.h>
> +#include <linux/types.h>
>   
>   
>   #define LINUX_LOGO_MONO		1	/* monochrome black/white */
> @@ -36,6 +38,33 @@ extern const struct linux_logo logo_linux_clut224;
>   extern const struct linux_logo logo_spe_clut224;
>   
>   extern const struct linux_logo *fb_find_logo(int depth);
> +
> +/*
> + * Where a boot logo goes. A coordinate of -1 centres the logo on that axis.
> + * Whatever draws the logo describes its placement this way and computes it
> + * with logo_place_axis(), so that no two places can end up disagreeing about
> + * where the logo is.
> + */
> +struct logo_placement {
> +	s32 x, y;
> +};
> +
> +/*
> + * Place a logo along one axis. @pos is the coordinate asked for, or -1 to
> + * centre on that axis. The result is clamped so that the logo always lies
> + * entirely within the screen: the drawing code does not clip, so asking for
> + * more than that would otherwise scribble past the end of the frame buffer.
> + */
> +static inline int logo_place_axis(s32 pos, unsigned int span, unsigned int size)
> +{
> +	int last = (int)span - (int)size;
> +
> +	if (size > span)
> +		return 0;
> +
> +	return pos == -1 ? last / 2 : clamp(pos, 0, last);
> +}
> +
>   #ifdef CONFIG_FB_LOGO_EXTRA
>   extern void fb_append_extra_logo(const struct linux_logo *logo,
>   				 unsigned int n);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


