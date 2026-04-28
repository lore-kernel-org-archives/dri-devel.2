Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5615CFF886F
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 06:50:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B064710E86F;
	Tue, 28 Apr 2026 06:50:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="ELAquDQ0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FsKKlwSb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ELAquDQ0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FsKKlwSb";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 872E410E9DE
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 06:50:04 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 29A3E5BD38;
 Tue, 28 Apr 2026 06:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777359003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5rxnWdzljLHPCqtl4M3b4bLWAiq6aTt87b9DpIcZMn4=;
 b=ELAquDQ04wcIgHFeXJroVXs8cYzzb2k+AXdCOXgr/VcD+AD9jHDue0VQSKRLzxpFFAUqFm
 QO9I5FNIkL+d7GWWLrtu7ZwH9/5k3PQ7zmmvK7s+FEM8AKaZaVB/+VyTDFa8XdJMQMsf2A
 7QZUatW0Ji0bWUADU1dQPp0ThIkGj0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777359003;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5rxnWdzljLHPCqtl4M3b4bLWAiq6aTt87b9DpIcZMn4=;
 b=FsKKlwSb2ns7fmfFYFbR7KHbBBzdNMuiqNt41EthhAVaaREAUo3tq3xiT4wcJZaSvpdqci
 c9k1WQWZ4iC7IkDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ELAquDQ0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FsKKlwSb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777359003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5rxnWdzljLHPCqtl4M3b4bLWAiq6aTt87b9DpIcZMn4=;
 b=ELAquDQ04wcIgHFeXJroVXs8cYzzb2k+AXdCOXgr/VcD+AD9jHDue0VQSKRLzxpFFAUqFm
 QO9I5FNIkL+d7GWWLrtu7ZwH9/5k3PQ7zmmvK7s+FEM8AKaZaVB/+VyTDFa8XdJMQMsf2A
 7QZUatW0Ji0bWUADU1dQPp0ThIkGj0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777359003;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5rxnWdzljLHPCqtl4M3b4bLWAiq6aTt87b9DpIcZMn4=;
 b=FsKKlwSb2ns7fmfFYFbR7KHbBBzdNMuiqNt41EthhAVaaREAUo3tq3xiT4wcJZaSvpdqci
 c9k1WQWZ4iC7IkDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE568593B0;
 Tue, 28 Apr 2026 06:50:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Lh4WNZpY8GkBUgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 28 Apr 2026 06:50:02 +0000
Message-ID: <f5581e5c-c83c-4c8a-bfb7-9fa029ba1a2f@suse.de>
Date: Tue, 28 Apr 2026 08:50:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: fix build for CONFIG_DRM_FBDEV_EMULATION=n
To: Yury Norov <ynorov@nvidia.com>, Dave Airlie <airlied@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
References: <20260428024942.452389-1-ynorov@nvidia.com>
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
In-Reply-To: <20260428024942.452389-1-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[gmail.com];
 MID_RHS_MATCH_FROM(0.00)[]; TAGGED_RCPT(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.com:url, suse.de:dkim, suse.de:mid,
 suse.de:email]
X-Rspamd-Queue-Id: 29A3E5BD38
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



Am 28.04.26 um 04:49 schrieb Yury Norov:
> The merge-commit 02e778f12359 ("Merge tag 'amd-drm-next-7.1-2026-03-12' of
> https://gitlab.freedesktop.org/agd5f/linux into drm-next") removes the stub
> for drm_fb_helper_gem_is_fb(), so the buld gets broken if DRM_FBDEV_EMULATION
> is not set.
>
> ‘drm_fb_helper_gem_is_fb’; did you mean ‘drm_fb_helper_from_client’? [-Wimplicit-function-declaration]
>   1777 |                 if (!drm_fb_helper_gem_is_fb(dev->fb_helper, fb->obj[0])) {
>        |                      ^~~~~~~~~~~~~~~~~~~~~~~
>        |                      drm_fb_helper_from_client
>
> Restore it.
>
> Fixes: 02e778f12359 ("Merge tag 'amd-drm-next-7.1-2026-03-12' of https://gitlab.freedesktop.org/agd5f/linux into drm-next")
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
> v2: restore only drm_fb_helper_gem_is_fb() (Thomas)
>
>   include/drm/drm_fb_helper.h | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> index bf391903443d..0c5e5ed7b5e7 100644
> --- a/include/drm/drm_fb_helper.h
> +++ b/include/drm/drm_fb_helper.h
> @@ -273,6 +273,12 @@ int drm_fb_helper_hotplug_event(struct drm_fb_helper *fb_helper);
>   int drm_fb_helper_initial_config(struct drm_fb_helper *fb_helper);
>   bool drm_fb_helper_gem_is_fb(const struct drm_fb_helper *fb_helper,
>   			     const struct drm_gem_object *obj);
> +#else
> +static inline bool drm_fb_helper_gem_is_fb(const struct drm_fb_helper *fb_helper,
> +					   const struct drm_gem_object *obj)
> +{
> +	return false;
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


