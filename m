Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287A8FF8862
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6963410E222;
	Mon, 27 Apr 2026 08:16:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="hlTKKBpV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qcXu4slc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hlTKKBpV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qcXu4slc";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B37F10E222
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 08:16:22 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8223E6A94D;
 Mon, 27 Apr 2026 08:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777277780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BX4raB6T4rmFud8OAcvCz8tOECk6x1ETc7sFYC7jpg0=;
 b=hlTKKBpVXtHaoIZ7NCFrEy8MOrPN4oTkgAIk9dBLOIqg+lXzN9umUgViO+kgbTQJ6firJ/
 4NCrWOUL/6PYUEZJ/sKum1+8HQVSWczGRdtAwWTmSLKwj5GlPQpenBoitRw9YTeqY38FOI
 47au1jKs4OChL5vbT4g5Y69UjBm3YZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777277780;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BX4raB6T4rmFud8OAcvCz8tOECk6x1ETc7sFYC7jpg0=;
 b=qcXu4slcRWhwJiq6WJN/EOQMVsxjMwraLaaEMnDIIM01PDcRV95fG/Y6nwvVGHc/bsXX89
 IdOdWFUr6Isda2Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777277780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BX4raB6T4rmFud8OAcvCz8tOECk6x1ETc7sFYC7jpg0=;
 b=hlTKKBpVXtHaoIZ7NCFrEy8MOrPN4oTkgAIk9dBLOIqg+lXzN9umUgViO+kgbTQJ6firJ/
 4NCrWOUL/6PYUEZJ/sKum1+8HQVSWczGRdtAwWTmSLKwj5GlPQpenBoitRw9YTeqY38FOI
 47au1jKs4OChL5vbT4g5Y69UjBm3YZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777277780;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BX4raB6T4rmFud8OAcvCz8tOECk6x1ETc7sFYC7jpg0=;
 b=qcXu4slcRWhwJiq6WJN/EOQMVsxjMwraLaaEMnDIIM01PDcRV95fG/Y6nwvVGHc/bsXX89
 IdOdWFUr6Isda2Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46500593B0;
 Mon, 27 Apr 2026 08:16:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Llb3D1Qb72lBCwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 27 Apr 2026 08:16:20 +0000
Message-ID: <781d75e9-47f2-432c-beb4-abab3aff49a3@suse.de>
Date: Mon, 27 Apr 2026 10:16:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix build for CONFIG_DRM_FBDEV_EMULATION=n
To: Yury Norov <ynorov@nvidia.com>, Dave Airlie <airlied@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
References: <20260424184821.294103-1-ynorov@nvidia.com>
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
In-Reply-To: <20260424184821.294103-1-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; TAGGED_RCPT(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[9];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[gmail.com];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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

Am 24.04.26 um 20:48 schrieb Yury Norov:
> The merge-commit 02e778f12359 ("Merge tag 'amd-drm-next-7.1-2026-03-12' of
> https://gitlab.freedesktop.org/agd5f/linux into drm-next") removes stubs
> for drm_fb_helper_xxx() functions, so the buld gets broken if
> DRM_FBDEV_EMULATION is not set.
>
> ‘drm_fb_helper_gem_is_fb’; did you mean ‘drm_fb_helper_from_client’? [-Wimplicit-function-declaration]
>   1777 |                 if (!drm_fb_helper_gem_is_fb(dev->fb_helper, fb->obj[0])) {
>        |                      ^~~~~~~~~~~~~~~~~~~~~~~
>        |                      drm_fb_helper_from_client
>
> Restore the stubs.
> Fixes: 02e778f12359 ("Merge tag 'amd-drm-next-7.1-2026-03-12' of https://gitlab.freedesktop.org/agd5f/linux into drm-next")
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>   include/drm/drm_fb_helper.h | 111 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 111 insertions(+)
>
> diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> index bf391903443d..ca214b5c0283 100644
> --- a/include/drm/drm_fb_helper.h
> +++ b/include/drm/drm_fb_helper.h
> @@ -273,6 +273,117 @@ int drm_fb_helper_hotplug_event(struct drm_fb_helper *fb_helper);
>   int drm_fb_helper_initial_config(struct drm_fb_helper *fb_helper);
>   bool drm_fb_helper_gem_is_fb(const struct drm_fb_helper *fb_helper,
>   			     const struct drm_gem_object *obj);
> +#else
> +static inline bool drm_fb_helper_gem_is_fb(const struct drm_fb_helper *fb_helper,
> +					   const struct drm_gem_object *obj)
> +{
> +	return false;
> +}

Only this helper is required. The others have been removed.

Best regards
Thomas

> +
> +static inline void drm_fb_helper_prepare(struct drm_device *dev,
> +					 struct drm_fb_helper *helper,
> +					 unsigned int preferred_bpp,
> +					 const struct drm_fb_helper_funcs *funcs)
> +{
> +}
> +
> +static inline void drm_fb_helper_unprepare(struct drm_fb_helper *fb_helper)
> +{
> +}
> +
> +static inline int drm_fb_helper_init(struct drm_device *dev,
> +		       struct drm_fb_helper *helper)
> +{
> +	/* So drivers can use it to free the struct */
> +	helper->dev = dev;
> +	dev->fb_helper = helper;
> +
> +	return 0;
> +}
> +
> +static inline void drm_fb_helper_fini(struct drm_fb_helper *helper)
> +{
> +	if (helper && helper->dev)
> +		helper->dev->fb_helper = NULL;
> +}
> +
> +static inline int drm_fb_helper_blank(int blank, struct fb_info *info)
> +{
> +	return 0;
> +}
> +
> +static inline int drm_fb_helper_pan_display(struct fb_var_screeninfo *var,
> +					    struct fb_info *info)
> +{
> +	return 0;
> +}
> +
> +static inline int drm_fb_helper_set_par(struct fb_info *info)
> +{
> +	return 0;
> +}
> +
> +static inline int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
> +					  struct fb_info *info)
> +{
> +	return 0;
> +}
> +
> +static inline int
> +drm_fb_helper_restore_fbdev_mode_unlocked(struct drm_fb_helper *fb_helper)
> +{
> +	return 0;
> +}
> +
> +static inline void drm_fb_helper_unregister_info(struct drm_fb_helper *fb_helper)
> +{
> +}
> +
> +static inline void
> +drm_fb_helper_fill_info(struct fb_info *info,
> +			struct drm_fb_helper *fb_helper,
> +			struct drm_fb_helper_surface_size *sizes)
> +{
> +}
> +
> +static inline int drm_fb_helper_setcmap(struct fb_cmap *cmap,
> +					struct fb_info *info)
> +{
> +	return 0;
> +}
> +
> +static inline int drm_fb_helper_ioctl(struct fb_info *info, unsigned int cmd,
> +				      unsigned long arg)
> +{
> +	return 0;
> +}
> +
> +#ifdef CONFIG_FB_DEFERRED_IO
> +static inline void drm_fb_helper_deferred_io(struct fb_info *info,
> +					     struct list_head *pagelist)
> +{
> +}
> +#endif
> +
> +static inline void drm_fb_helper_set_suspend(struct drm_fb_helper *fb_helper,
> +					     bool suspend)
> +{
> +}
> +
> +static inline void
> +drm_fb_helper_set_suspend_unlocked(struct drm_fb_helper *fb_helper, bool suspend)
> +{
> +}
> +
> +static inline int drm_fb_helper_hotplug_event(struct drm_fb_helper *fb_helper)
> +{
> +	return 0;
> +}
> +
> +static inline int drm_fb_helper_initial_config(struct drm_fb_helper *fb_helper)
> +{
> +	return 0;
> +}
>   #endif
>   
>   #endif

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


