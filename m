Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4247A606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LdQz7XgZ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qwUuhnVD;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LdQz7XgZ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qwUuhnVD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95C8911231B;
	Fri, 13 Nov 2026 09:03:52 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE7C41121C8
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:03:25 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 520CD221B5;
 Fri, 13 Nov 2026 09:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794560604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TYu7GuJkUa7hH5Ry8NdLJOhUNcPyvJcA0yIktjCWpAI=;
 b=LdQz7XgZa4bGSZ+FVgIavZNSYRi0tZ3lvQZRx0elNBWui9mfAWi9s64I+2BTK9XwUGMFtW
 D9y6pXbXz0E7UKiELTIVvv3U+Hm1Ftv2WeXbejJCXbfgp+SOo3fF4GGjQdJ2IRTxmhA0oM
 xN9XlFgHxQSMZ2fiBEEl4B+xStuxVmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794560604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TYu7GuJkUa7hH5Ry8NdLJOhUNcPyvJcA0yIktjCWpAI=;
 b=qwUuhnVDKDenBcrhB72LWKUyETB+rSAdV15Onjetj66/rzq98fNv4+4oZVnjDJjpNwYOFJ
 UjToo4a6hOUkvvBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794560604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TYu7GuJkUa7hH5Ry8NdLJOhUNcPyvJcA0yIktjCWpAI=;
 b=LdQz7XgZa4bGSZ+FVgIavZNSYRi0tZ3lvQZRx0elNBWui9mfAWi9s64I+2BTK9XwUGMFtW
 D9y6pXbXz0E7UKiELTIVvv3U+Hm1Ftv2WeXbejJCXbfgp+SOo3fF4GGjQdJ2IRTxmhA0oM
 xN9XlFgHxQSMZ2fiBEEl4B+xStuxVmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794560604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TYu7GuJkUa7hH5Ry8NdLJOhUNcPyvJcA0yIktjCWpAI=;
 b=qwUuhnVDKDenBcrhB72LWKUyETB+rSAdV15Onjetj66/rzq98fNv4+4oZVnjDJjpNwYOFJ
 UjToo4a6hOUkvvBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9C6B134C3;
 Fri, 13 Nov 2026 09:03:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id szNeI1vS9mpPJwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 13 Nov 2026 09:03:23 +0000
Message-ID: <c0d988ee-d4e4-4bf5-89ea-4a05609638f5@suse.de>
Date: Fri, 13 Nov 2026 10:03:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/fb-helper: flush damage before unblanking
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Javier Martinez Canillas <javierm@redhat.com>
References: <20261112091630.3947184-1-angelo.compagnucci@gmail.com>
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
In-Reply-To: <20261112091630.3947184-1-angelo.compagnucci@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-11.79 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,kernel.org,lists.freedesktop.org]; 
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,redhat.com];
 RCPT_COUNT_SEVEN(0.00)[7]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.79
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

Am 12.11.26 um 10:16 schrieb Angelo Compagnucci:
> With a shadow buffer and deferred I/O, what userspace draws in fbdev
> reaches the DRM framebuffer only once the deferred I/O work and then the
> damage work have run. Unblanking turns the display on with the
> framebuffer as it is: a program drawing its first picture and then
> unblanking, such as a boot splash taking over the picture a bootloader
> left on a panel, shows the previous framebuffer contents for a moment.
>
> Seen on an Arietta G25 with an ILI9341 panel (tinydrm ili9341): enabling
> the pipe sends the whole framebuffer to the panel, still black, and the
> splash only replaces it once the damage work runs, a visible flicker.
>
> On unblank, flush the deferred I/O and the damage work first.
>
> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> ---
>   drivers/gpu/drm/clients/drm_fbdev_helper.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/clients/drm_fbdev_helper.c b/drivers/gpu/drm/clients/drm_fbdev_helper.c
> index 415764ee086a..5c584dee3e55 100644
> --- a/drivers/gpu/drm/clients/drm_fbdev_helper.c
> +++ b/drivers/gpu/drm/clients/drm_fbdev_helper.c
> @@ -150,6 +150,22 @@ static void drm_fb_helper_dpms(struct fb_info *info, int dpms_mode)
>   	mutex_unlock(&fb_helper->lock);
>   }
>   
> +/*
> + * Turning a display on sends it the framebuffer: first get there what was
> + * drawn in fbdev, still pending in deferred I/O or damage handling, else the
> + * display shows the framebuffer as it was before for a moment.
> + */
> +static void drm_fb_helper_flush_damage(struct fb_info *info)
> +{
> +	struct drm_fb_helper *helper = info->par;
> +
> +#ifdef CONFIG_FB_DEFERRED_IO
> +	if (info->fbdefio)
> +		flush_delayed_work(&info->deferred_work);
> +#endif
> +	flush_work(&helper->damage_work);
> +}
> +
>   /**
>    * drm_fb_helper_blank - implementation for &fb_ops.fb_blank
>    * @blank: desired blanking state
> @@ -163,6 +179,7 @@ int drm_fb_helper_blank(int blank, struct fb_info *info)
>   	switch (blank) {
>   	/* Display: On; HSync: On, VSync: On */
>   	case FB_BLANK_UNBLANK:
> +		drm_fb_helper_flush_damage(info);
>   		drm_fb_helper_dpms(info, DRM_MODE_DPMS_ON);

I think there's no guarantee that we can flush anything before 
unblanking the display.

Best regards
Thomas

>   		break;
>   	/* Display: Off; HSync: On, VSync: On */

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


