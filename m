Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685F2C44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9EA510F7DE;
	Fri, 10 Jul 2026 07:46:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="c8rV9qLY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7w+noYTL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c8rV9qLY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7w+noYTL";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A909910F7DE
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 07:46:27 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1FE91760D8;
 Fri, 10 Jul 2026 07:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783669586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W+A2msIOHT5wFpCllu2eSLJxU0WpB3lZuWJb2rAOwu4=;
 b=c8rV9qLYMCohkB4Njn0LAFtIhuHGjHmCE4R6hmV1xR9vAql/0GdgOu+XVuJMkhS8XkIh2s
 JdDCJLvKzOCe8gzCdQNg80RZD7tKh845TpxPo2Pr5xRxWnpeiM/f4/Qfq115mpfyyQTwmH
 1xj64VCD4RzH0MRhJYhBL5bIcBvMQ0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783669586;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W+A2msIOHT5wFpCllu2eSLJxU0WpB3lZuWJb2rAOwu4=;
 b=7w+noYTL0RsWjvGrqReag2xDdVjLSX8cdq6oskvIu+TQVfbS7t+IJE1c+DjztCKdHOjhY6
 ZmP9hTFIFtP6SWCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=c8rV9qLY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7w+noYTL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783669586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W+A2msIOHT5wFpCllu2eSLJxU0WpB3lZuWJb2rAOwu4=;
 b=c8rV9qLYMCohkB4Njn0LAFtIhuHGjHmCE4R6hmV1xR9vAql/0GdgOu+XVuJMkhS8XkIh2s
 JdDCJLvKzOCe8gzCdQNg80RZD7tKh845TpxPo2Pr5xRxWnpeiM/f4/Qfq115mpfyyQTwmH
 1xj64VCD4RzH0MRhJYhBL5bIcBvMQ0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783669586;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W+A2msIOHT5wFpCllu2eSLJxU0WpB3lZuWJb2rAOwu4=;
 b=7w+noYTL0RsWjvGrqReag2xDdVjLSX8cdq6oskvIu+TQVfbS7t+IJE1c+DjztCKdHOjhY6
 ZmP9hTFIFtP6SWCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBC38779BD;
 Fri, 10 Jul 2026 07:46:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lls3N1GjUGocOAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 10 Jul 2026 07:46:25 +0000
Message-ID: <21892d29-9be7-4009-9a3c-9e317ec7f57b@suse.de>
Date: Fri, 10 Jul 2026 09:46:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/60] drm/gem-atomic-helper: Convert simple-kms shadow
 helpers to create_plane_state
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-3-302d986fe5f0@kernel.org>
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
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-3-302d986fe5f0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:email, suse.de:dkim, suse.de:mid,
 suse.com:url]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1FE91760D8
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

Am 09.07.26 um 13:50 schrieb Maxime Ripard:
> drm_gem_simple_kms_reset_shadow_plane() implements the reset_plane
> hook for simple-kms shadow-buffered planes. Since the reset hook
> conflates initial state creation with hardware and software reset
> during suspend/resume, convert it to the create_plane_state pattern.
>
> Replace it with drm_gem_simple_kms_create_shadow_plane_state(), which
> implements the create_plane_state hook using
> drm_gem_create_shadow_plane_state(). Update
> DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS accordingly.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/drm_gem_atomic_helper.c | 15 ++++++++++-----
>   include/drm/drm_gem_atomic_helper.h     |  5 +++--
>   2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
> index 7ef67c2d77ce..ae854555fd12 100644
> --- a/drivers/gpu/drm/drm_gem_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
> @@ -448,21 +448,26 @@ void drm_gem_simple_kms_end_shadow_fb_access(struct drm_simple_display_pipe *pip
>   	drm_gem_end_shadow_fb_access(&pipe->plane, plane_state);
>   }
>   EXPORT_SYMBOL(drm_gem_simple_kms_end_shadow_fb_access);
>   
>   /**
> - * drm_gem_simple_kms_reset_shadow_plane - resets a shadow-buffered plane
> + * drm_gem_simple_kms_create_shadow_plane_state - creates shadow-buffered plane state
>    * @pipe: the simple display pipe
>    *
> - * This function implements struct drm_simple_display_funcs.reset_plane
> + * This function implements struct drm_simple_display_pipe_funcs.create_plane_state
>    * for shadow-buffered planes.
> + *
> + * Returns:
> + * A pointer to a new plane state on success, or an ERR_PTR()-encoded
> + * error code otherwise.
>    */
> -void drm_gem_simple_kms_reset_shadow_plane(struct drm_simple_display_pipe *pipe)
> +struct drm_plane_state *
> +drm_gem_simple_kms_create_shadow_plane_state(struct drm_simple_display_pipe *pipe)
>   {
> -	drm_gem_reset_shadow_plane(&pipe->plane);
> +	return drm_gem_create_shadow_plane_state(&pipe->plane);
>   }
> -EXPORT_SYMBOL(drm_gem_simple_kms_reset_shadow_plane);
> +EXPORT_SYMBOL(drm_gem_simple_kms_create_shadow_plane_state);
>   
>   /**
>    * drm_gem_simple_kms_duplicate_shadow_plane_state - duplicates shadow-buffered plane state
>    * @pipe: the simple display pipe
>    *
> diff --git a/include/drm/drm_gem_atomic_helper.h b/include/drm/drm_gem_atomic_helper.h
> index 43657d8fb1c8..8a3bb27233db 100644
> --- a/include/drm/drm_gem_atomic_helper.h
> +++ b/include/drm/drm_gem_atomic_helper.h
> @@ -131,11 +131,12 @@ void drm_gem_end_shadow_fb_access(struct drm_plane *plane, struct drm_plane_stat
>   
>   int drm_gem_simple_kms_begin_shadow_fb_access(struct drm_simple_display_pipe *pipe,
>   					      struct drm_plane_state *plane_state);
>   void drm_gem_simple_kms_end_shadow_fb_access(struct drm_simple_display_pipe *pipe,
>   					     struct drm_plane_state *plane_state);
> -void drm_gem_simple_kms_reset_shadow_plane(struct drm_simple_display_pipe *pipe);
> +struct drm_plane_state *
> +drm_gem_simple_kms_create_shadow_plane_state(struct drm_simple_display_pipe *pipe);
>   struct drm_plane_state *
>   drm_gem_simple_kms_duplicate_shadow_plane_state(struct drm_simple_display_pipe *pipe);
>   void drm_gem_simple_kms_destroy_shadow_plane_state(struct drm_simple_display_pipe *pipe,
>   						   struct drm_plane_state *plane_state);
>   
> @@ -148,10 +149,10 @@ void drm_gem_simple_kms_destroy_shadow_plane_state(struct drm_simple_display_pip
>    * functions.
>    */
>   #define DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS \
>   	.begin_fb_access = drm_gem_simple_kms_begin_shadow_fb_access, \
>   	.end_fb_access = drm_gem_simple_kms_end_shadow_fb_access, \
> -	.reset_plane = drm_gem_simple_kms_reset_shadow_plane, \
> +	.create_plane_state = drm_gem_simple_kms_create_shadow_plane_state, \
>   	.duplicate_plane_state = drm_gem_simple_kms_duplicate_shadow_plane_state, \
>   	.destroy_plane_state = drm_gem_simple_kms_destroy_shadow_plane_state
>   
>   #endif /* __DRM_GEM_ATOMIC_HELPER_H__ */
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


