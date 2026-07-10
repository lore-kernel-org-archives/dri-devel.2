Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B99C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7263410E13E;
	Fri, 10 Jul 2026 07:44:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="KKWIsUvZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cQ1731Gu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CnpuFza0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Eb83hgfP";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9208C10E13E
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 07:44:29 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D374F7666B;
 Fri, 10 Jul 2026 07:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783669468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S2wb48eb8E1xwn+5NnWyL4tRj+NMuhdDSFgZXul+B0w=;
 b=KKWIsUvZ5g8ScPWViKf/sqXjwjRYE//jLB3Y7en2TZDSKwGpZTNSUbETP0l3OAe/JUoicw
 75H9jDa3tEHUmIEUyKMSEKOGofUfUk0CYVGlyRKNgFN8ndkSbdl2mCgJw1nHjzKRH1Tlpz
 +DrXmN0iWo8FIJZb6JC8DDU2K9ayfiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783669468;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S2wb48eb8E1xwn+5NnWyL4tRj+NMuhdDSFgZXul+B0w=;
 b=cQ1731Gued9/yKbQkrEW7Pb6zsba75IzaOw2whGF/JowJ7xFVQ7CZNwpDQ5T8wwITq8SqC
 gSnj0UX9AKViwUDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CnpuFza0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Eb83hgfP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783669467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S2wb48eb8E1xwn+5NnWyL4tRj+NMuhdDSFgZXul+B0w=;
 b=CnpuFza0Vjk2vWgu2+M9nXb6am/3xTiqzwD/6TCKwJrNQGjY5gtwbDIWhUe34pAzeIH6XX
 uEm2km3myfFefD7+awJapXLKFEvmXWUT5p11xLits3vFTcisMVu0Yjb4BEGXB2vUPdKaK8
 9vMrRIpB5jBUwYmVq+9SzY5t1S8zzbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783669467;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S2wb48eb8E1xwn+5NnWyL4tRj+NMuhdDSFgZXul+B0w=;
 b=Eb83hgfP4A0ogWXa940EZZoaLUGxgEsrwDpqKlgjjCSsJTI0q/FfShZKYP2iFvSZpTZj/e
 E/ngYI4vwPgYprAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA5EA779BD;
 Fri, 10 Jul 2026 07:44:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6687KNuiUGr6NQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 10 Jul 2026 07:44:27 +0000
Message-ID: <7f67740b-379c-4d73-be30-c84860da864c@suse.de>
Date: Fri, 10 Jul 2026 09:44:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/60] drm/gem-atomic-helper: Create
 drm_gem_create_shadow_plane_state()
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-2-302d986fe5f0@kernel.org>
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
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-2-302d986fe5f0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D374F7666B
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, suse.de:mid, suse.de:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
> The GEM shadow-plane helpers only expose reset functions
> (drm_gem_reset_shadow_plane and __drm_gem_reset_shadow_plane) that
> handle both the initial state allocation and the reset path. The new
> atomic_create_state hook requires a function that only allocates and
> initializes a pristine state without any side effect.
>
> Create __drm_gem_shadow_plane_state_init() to initialize a
> pre-allocated shadow plane state, and
> drm_gem_create_shadow_plane_state() to allocate and initialize one
> from scratch.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/drm_gem_atomic_helper.c | 42 +++++++++++++++++++++++++++++++++
>   include/drm/drm_gem_atomic_helper.h     |  3 +++
>   2 files changed, 45 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
> index abef865c5f2c..7ef67c2d77ce 100644
> --- a/drivers/gpu/drm/drm_gem_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
> @@ -178,10 +178,52 @@ EXPORT_SYMBOL_GPL(drm_gem_plane_helper_prepare_fb);
>   
>   /*
>    * Shadow-buffered Planes
>    */
>   
> +/**
> + * __drm_gem_shadow_plane_state_init - initializes shadow-buffered plane state
> + * @plane: the plane
> + * @shadow_plane_state: the shadow-buffered plane state
> + *
> + * This function initializes a pre-allocated shadow-buffered plane state.
> + * Helpful for drivers that subclass struct drm_shadow_plane_state.
> + */
> +void __drm_gem_shadow_plane_state_init(struct drm_plane *plane,
> +				       struct drm_shadow_plane_state *shadow_plane_state)
> +{
> +	__drm_atomic_helper_plane_state_init(&shadow_plane_state->base, plane);
> +	drm_format_conv_state_init(&shadow_plane_state->fmtcnv_state);
> +}
> +EXPORT_SYMBOL(__drm_gem_shadow_plane_state_init);
> +
> +/**
> + * drm_gem_create_shadow_plane_state - creates a shadow-buffered plane state
> + * @plane: the plane
> + *
> + * This function implements struct &drm_plane_funcs.atomic_create_state for
> + * shadow-buffered planes. It assumes the new state to be of type
> + * struct drm_shadow_plane_state.
> + *
> + * Returns:
> + * A pointer to a new plane state on success, or an ERR_PTR()-encoded
> + * error code otherwise.
> + */
> +struct drm_plane_state *drm_gem_create_shadow_plane_state(struct drm_plane *plane)
> +{
> +	struct drm_shadow_plane_state *shadow_plane_state;
> +
> +	shadow_plane_state = kzalloc_obj(*shadow_plane_state);
> +	if (!shadow_plane_state)
> +		return ERR_PTR(-ENOMEM);
> +
> +	__drm_gem_shadow_plane_state_init(plane, shadow_plane_state);
> +
> +	return &shadow_plane_state->base;
> +}
> +EXPORT_SYMBOL(drm_gem_create_shadow_plane_state);

The module exports this helper, but it doesn't show up in the header 
file AFAICT.

Best regards
Thomas

> +
>   /**
>    * __drm_gem_duplicate_shadow_plane_state - duplicates shadow-buffered plane state
>    * @plane: the plane
>    * @new_shadow_plane_state: the new shadow-buffered plane state
>    *
> diff --git a/include/drm/drm_gem_atomic_helper.h b/include/drm/drm_gem_atomic_helper.h
> index 3e01c619a25e..43657d8fb1c8 100644
> --- a/include/drm/drm_gem_atomic_helper.h
> +++ b/include/drm/drm_gem_atomic_helper.h
> @@ -93,10 +93,13 @@ void __drm_gem_duplicate_shadow_plane_state(struct drm_plane *plane,
>   void __drm_gem_destroy_shadow_plane_state(struct drm_shadow_plane_state *shadow_plane_state);
>   void __drm_gem_reset_shadow_plane(struct drm_plane *plane,
>   				  struct drm_shadow_plane_state *shadow_plane_state);
>   
>   void drm_gem_reset_shadow_plane(struct drm_plane *plane);
> +void __drm_gem_shadow_plane_state_init(struct drm_plane *plane,
> +				       struct drm_shadow_plane_state *shadow_plane_state);
> +struct drm_plane_state *drm_gem_create_shadow_plane_state(struct drm_plane *plane);
>   struct drm_plane_state *drm_gem_duplicate_shadow_plane_state(struct drm_plane *plane);
>   void drm_gem_destroy_shadow_plane_state(struct drm_plane *plane,
>   					struct drm_plane_state *plane_state);
>   
>   /**
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


