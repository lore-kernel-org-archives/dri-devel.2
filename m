Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E6EC79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B433210E189;
	Wed,  9 Sep 2026 08:48:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="koaN25tX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="27oMGI1z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C4n+K1W6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rqGCZqYL";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E245710E189
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 08:48:40 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 438ED219BC;
 Wed,  9 Sep 2026 08:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788943715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YTEXwsrUGYDgo+aiMh5AffT7gikOASUBFy5OyOwQuOM=;
 b=koaN25tXdMw5EaBb468hgQpThadytQOFWk5kZcHFOWSdHw+xnzsAmJu1Z2tFIEKWqIOWFS
 vXbBFVaOCgDgF04AN6AC4DjS2jYbSG5gy/bmoCpAylmV9MyOOm+VinIfAOhmO/lM1iKCkS
 0hNFXl8IBdlBUZBYNpug5Id8oNi2Fhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788943715;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YTEXwsrUGYDgo+aiMh5AffT7gikOASUBFy5OyOwQuOM=;
 b=27oMGI1zTGfCrM1TeqtIs4hz9J+cmtweCcyIGMoLm5aEokCkH9b71s6nFc9vUO2AxxC/fz
 w512b2WKgKSLw2CQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=C4n+K1W6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rqGCZqYL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788943711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YTEXwsrUGYDgo+aiMh5AffT7gikOASUBFy5OyOwQuOM=;
 b=C4n+K1W6kIrm1ytnMDEbGe6kHJWK5VIa4S4YYGfVhdGMJV1hYVgmMfO03NIDcGqhyqjvr2
 fxNdnz9UVBl0noFI8pYAPTcRM6y2NvMkwNm+sDd4ikN/N22yJRyzB5kGn4XGBB6MDV8tIt
 HY2UsNF/TAqW+odD1VmiMofDoG+8fZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788943711;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YTEXwsrUGYDgo+aiMh5AffT7gikOASUBFy5OyOwQuOM=;
 b=rqGCZqYLiCZHm0CMbnf66dqWyAyuFwjBgyZGdozZio49pjRRn+IICt6wNYdqJNE2+LHjPx
 TLnjOc5Y0Kk3sGDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F19C31347F;
 Wed,  9 Sep 2026 08:48:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YP//OF4doWpGRwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 09 Sep 2026 08:48:30 +0000
Message-ID: <fdac2899-94c0-4fae-8808-228ea23f3251@suse.de>
Date: Wed, 9 Sep 2026 10:48:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/sysfb: Use iosys_map_memset() to clear buffer
To: Chen-Yu Tsai <wenst@chromium.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260903084823.4156065-1-wenst@chromium.org>
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
In-Reply-To: <20260903084823.4156065-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 438ED219BC
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.de:dkim,suse.de:email,suse.de:mid,chromium.org:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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



Am 03.09.26 um 10:48 schrieb Chen-Yu Tsai:
> The atomic disable in drm/sysfb currently clears the buffer using
> memset_io(). Since the mapping is provided in a |struct iosys_map|,
> it is better to use the related API instead of extracting the vaddr.
> This is mentioned as a TODO item.
>
> Switch to iosys_map_memset(), which takes the mapping as well as an
> offset into the mapping.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
> Changes since v1:
> - Rebased onto drm-misc-next
> - second patch is gone as it was already implemented
> ---
>   drivers/gpu/drm/sysfb/drm_sysfb_modeset.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> index b92cc4b7d2ad..13df0925163a 100644
> --- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> +++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> @@ -375,8 +375,6 @@ void drm_sysfb_plane_helper_atomic_disable(struct drm_plane *plane,
>   {
>   	struct drm_device *dev = plane->dev;
>   	struct drm_sysfb_device *sysfb = to_drm_sysfb_device(dev);
> -	struct iosys_map dst = sysfb->fb_addr;
> -	void __iomem *dst_vmap = dst.vaddr_iomem; /* TODO: Use mapping abstraction */
>   	unsigned int dst_pitch = sysfb->fb_pitch;
>   	const struct drm_format_info *dst_format = sysfb->fb_format;
>   	struct drm_rect dst_clip;
> @@ -396,10 +394,8 @@ void drm_sysfb_plane_helper_atomic_disable(struct drm_plane *plane,
>   		return;
>   
>   	/* Clear buffer to black if disabled */
> -	for (i = 0; i < lines; ++i) {
> -		memset_io(dst_vmap, 0, dst_size);
> -		dst_vmap += dst_pitch;
> -	}
> +	for (i = 0; i < lines; ++i)
> +		iosys_map_memset(&sysfb->fb_addr, dst_pitch * i, 0, dst_size);
>   
>   	drm_dev_exit(idx);
>   }

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


