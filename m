Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B03FC79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 899FE10F310;
	Thu, 10 Sep 2026 07:00:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="v3SQpQN0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="roK3aGUA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sTt/hL4U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="84eAL0i8";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC0C210F310
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 07:00:39 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 033FA21CBD;
 Thu, 10 Sep 2026 07:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789023634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IgY2p/1VYq+NpfQrfYhlrmpdFXdH9QOR1QxiOpNnd40=;
 b=v3SQpQN0lkf+uNjpkzZo5TpNgNSvR2tKedNkemSMPLcbVIHV7sYXHZBvaT4QkI5XRVSdw3
 YTVb8LEyAOubYoIaRd/j+1M3EdNiC0WxZ0ly6iOokdQwiWUu7rqp6NO8KcyRIGSeWou5j/
 mpt3ysa1LulDN95glRfgRDD+bMZ62m0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789023634;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IgY2p/1VYq+NpfQrfYhlrmpdFXdH9QOR1QxiOpNnd40=;
 b=roK3aGUAI1MmRLxVRtoSFC/fC5d8MfcwUCjnMpCsVkhlT6Txt6fH0qbbxEzwsWeeMsOtL4
 rm+J4NK/UvpHOHDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789023630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IgY2p/1VYq+NpfQrfYhlrmpdFXdH9QOR1QxiOpNnd40=;
 b=sTt/hL4UHqp8pp1lUdYbXuasxy61Refhxst7qxEzYUpkPnE1tJyVWZ0CmH+59LLa1dOKY1
 FKuWxmQ4aXy0e+qHtDy1/iQTRUM12a/LdEc4Zx4YluH2E1JcLg12Ef+BEnPxyp9S/36jMM
 sysAohiC7nTapSSQrqKL1foNW89YkBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789023630;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IgY2p/1VYq+NpfQrfYhlrmpdFXdH9QOR1QxiOpNnd40=;
 b=84eAL0i8i+CkjbtAdo9A5gB7kzqg8s74nrWeBg2rEPzJxbb5pfwOzQrjpLuXrGwgG2Vu6y
 tEZSsvn7skZwUPBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8A1D13433;
 Thu, 10 Sep 2026 07:00:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OJ6YJ41VompnJAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 10 Sep 2026 07:00:29 +0000
Message-ID: <79e6c340-abea-4d83-adb1-e1a40cc190c4@suse.de>
Date: Thu, 10 Sep 2026 09:00:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 39/41] drm/vmwgfx: Convert to atomic_create_state
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Zack Rusin <zack.rusin@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com
References: <20260908-drm-no-more-plane-reset-v4-0-a31b3fcfc989@kernel.org>
 <20260908-drm-no-more-plane-reset-v4-39-a31b3fcfc989@kernel.org>
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
In-Reply-To: <20260908-drm-no-more-plane-reset-v4-39-a31b3fcfc989@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:url,
 suse.de:mid]
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



Am 08.09.26 um 16:47 schrieb Maxime Ripard:
> The plane reset implementation creates a custom state
> subclass, but only initializes a pristine state without resetting any
> hardware. This is equivalent to what atomic_create_state expects.
> Convert to it.
>
> Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: zack.rusin@broadcom.com
> ---
>   drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  | 17 +++++++----------
>   drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |  2 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c  |  4 ++--
>   drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c |  4 ++--
>   drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c |  4 ++--
>   5 files changed, 14 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> index 0b470809661c..9031dccad31d 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> @@ -277,31 +277,28 @@ vmw_du_plane_duplicate_state(struct drm_plane *plane)
>   	return state;
>   }
>   
>   
>   /**
> - * vmw_du_plane_reset - creates a blank vmw plane state
> + * vmw_du_plane_create_state - creates a blank vmw plane state
>    * @plane: drm plane
>    *
> - * Resets the atomic state for @plane by freeing the state pointer (which might
> - * be NULL, e.g. at driver load time) and allocating a new empty state object.
> + * Allocates a new empty state object.
>    */
> -void vmw_du_plane_reset(struct drm_plane *plane)
> +struct drm_plane_state *vmw_du_plane_create_state(struct drm_plane *plane)
>   {
>   	struct vmw_plane_state *vps;
>   
> -	if (plane->state)
> -		vmw_du_plane_destroy_state(plane, plane->state);
> -
>   	vps = kzalloc_obj(*vps);
> -
>   	if (!vps) {
>   		DRM_ERROR("Cannot allocate vmw_plane_state\n");

I think this is another case where kzalloc already prints a warning for us.

> -		return;
> +		return ERR_PTR(-ENOMEM);
>   	}
>   
> -	__drm_atomic_helper_plane_reset(plane, &vps->base);
> +	__drm_atomic_helper_plane_state_init(&vps->base, plane);
> +
> +	return &vps->base;
>   }
>   
>   
>   /**
>    * vmw_du_plane_destroy_state - destroy plane state
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> index e641f33341e6..5085d8bccf0a 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> @@ -409,11 +409,11 @@ void vmw_du_primary_plane_destroy(struct drm_plane *plane);
>   /* Atomic Helpers */
>   int vmw_du_primary_plane_atomic_check(struct drm_plane *plane,
>   				      struct drm_atomic_commit *state);
>   void vmw_du_plane_cleanup_fb(struct drm_plane *plane,
>   			     struct drm_plane_state *old_state);
> -void vmw_du_plane_reset(struct drm_plane *plane);
> +struct drm_plane_state *vmw_du_plane_create_state(struct drm_plane *plane);
>   struct drm_plane_state *vmw_du_plane_duplicate_state(struct drm_plane *plane);
>   void vmw_du_plane_destroy_state(struct drm_plane *plane,
>   				struct drm_plane_state *state);
>   void vmw_du_plane_unpin_surf(struct vmw_plane_state *vps);
>   
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
> index a4b28341f622..b147f5db9df5 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
> @@ -362,20 +362,20 @@ vmw_ldu_primary_plane_atomic_update(struct drm_plane *plane,
>   
>   static const struct drm_plane_funcs vmw_ldu_plane_funcs = {
>   	.update_plane = drm_atomic_helper_update_plane,
>   	.disable_plane = drm_atomic_helper_disable_plane,
>   	.destroy = vmw_du_primary_plane_destroy,
> -	.reset = vmw_du_plane_reset,
> +	.atomic_create_state = vmw_du_plane_create_state,
>   	.atomic_duplicate_state = vmw_du_plane_duplicate_state,
>   	.atomic_destroy_state = vmw_du_plane_destroy_state,
>   };
>   
>   static const struct drm_plane_funcs vmw_ldu_cursor_funcs = {
>   	.update_plane = drm_atomic_helper_update_plane,
>   	.disable_plane = drm_atomic_helper_disable_plane,
>   	.destroy = vmw_cursor_plane_destroy,
> -	.reset = vmw_du_plane_reset,
> +	.atomic_create_state = vmw_du_plane_create_state,
>   	.atomic_duplicate_state = vmw_du_plane_duplicate_state,
>   	.atomic_destroy_state = vmw_du_plane_destroy_state,
>   };
>   
>   /*
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
> index a05f935f1841..89714d5c235b 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
> @@ -754,20 +754,20 @@ vmw_sou_primary_plane_atomic_update(struct drm_plane *plane,
>   
>   static const struct drm_plane_funcs vmw_sou_plane_funcs = {
>   	.update_plane = drm_atomic_helper_update_plane,
>   	.disable_plane = drm_atomic_helper_disable_plane,
>   	.destroy = vmw_du_primary_plane_destroy,
> -	.reset = vmw_du_plane_reset,
> +	.atomic_create_state = vmw_du_plane_create_state,
>   	.atomic_duplicate_state = vmw_du_plane_duplicate_state,
>   	.atomic_destroy_state = vmw_du_plane_destroy_state,
>   };
>   
>   static const struct drm_plane_funcs vmw_sou_cursor_funcs = {
>   	.update_plane = drm_atomic_helper_update_plane,
>   	.disable_plane = drm_atomic_helper_disable_plane,
>   	.destroy = vmw_cursor_plane_destroy,
> -	.reset = vmw_du_plane_reset,
> +	.atomic_create_state = vmw_du_plane_create_state,
>   	.atomic_duplicate_state = vmw_du_plane_duplicate_state,
>   	.atomic_destroy_state = vmw_du_plane_destroy_state,
>   };
>   
>   /*
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> index 939da0e11dbb..cbf55084110a 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> @@ -1472,20 +1472,20 @@ vmw_stdu_crtc_atomic_flush(struct drm_crtc *crtc,
>   
>   static const struct drm_plane_funcs vmw_stdu_plane_funcs = {
>   	.update_plane = drm_atomic_helper_update_plane,
>   	.disable_plane = drm_atomic_helper_disable_plane,
>   	.destroy = vmw_du_primary_plane_destroy,
> -	.reset = vmw_du_plane_reset,
> +	.atomic_create_state = vmw_du_plane_create_state,
>   	.atomic_duplicate_state = vmw_du_plane_duplicate_state,
>   	.atomic_destroy_state = vmw_du_plane_destroy_state,
>   };
>   
>   static const struct drm_plane_funcs vmw_stdu_cursor_funcs = {
>   	.update_plane = drm_atomic_helper_update_plane,
>   	.disable_plane = drm_atomic_helper_disable_plane,
>   	.destroy = vmw_cursor_plane_destroy,
> -	.reset = vmw_du_plane_reset,
> +	.atomic_create_state = vmw_du_plane_create_state,
>   	.atomic_duplicate_state = vmw_du_plane_duplicate_state,
>   	.atomic_destroy_state = vmw_du_plane_destroy_state,
>   };
>   
>   
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


