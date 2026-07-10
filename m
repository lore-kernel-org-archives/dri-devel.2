Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B397CC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 147CB10F7FB;
	Fri, 10 Jul 2026 07:52:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="p4xCA710";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VgZ7KB03";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MfkDZdn5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BJGzMIJK";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2C4B10F7F2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 07:52:51 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9E42D76391;
 Fri, 10 Jul 2026 07:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783669970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gamjBdhe5MDO9dPZ0pdYqI3DoxNaIDftqQBdrfxt96k=;
 b=p4xCA710kVEdLqGm7Vjuf70ybFgpr8vr1ExyNIh/Jg6WFpoEz2FvapPMc4qGA8g3+BhWXA
 gU7aUEbn/rGCDAlLck+kU6iho8RYDm3Ne7fwRyZop4qgW318PYkaTV4OAa2Wku8x1diHqB
 LiMi9wLW3kUDXKRddYEWBxw/UH4oiOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783669970;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gamjBdhe5MDO9dPZ0pdYqI3DoxNaIDftqQBdrfxt96k=;
 b=VgZ7KB03LcHwqqjQZAOdjgTItjVPBuDIHuQYZ/Ye7Hkp2JZ9aFK67Pa30X1tamcMXWhQ/l
 BU2DhHbV/lpuQnCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MfkDZdn5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BJGzMIJK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783669969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gamjBdhe5MDO9dPZ0pdYqI3DoxNaIDftqQBdrfxt96k=;
 b=MfkDZdn53vrtaSJsqayKjDwz84ZBk2bG2B1R7nSMhwGLog+cx7ASuFsoKdqnMecTvAT3xt
 Ge6Zkr28gYDD3PWd9+TjEtwefqSj1+2HI/7ts8+NKIuvjhvZDFD7cqiBGmAl5ZRzPJ5i5s
 D5w/r7LfP1lk56l8hOLvCoG4MMO0IQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783669969;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gamjBdhe5MDO9dPZ0pdYqI3DoxNaIDftqQBdrfxt96k=;
 b=BJGzMIJK9bm0zGoOefZTDqo7sEj2Vl4H75Zd9Ya2hHcI/6UrCZDBpZD4rT0CtXsyuLWD95
 M/fS5wmVWc7qiBAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7890B779BD;
 Fri, 10 Jul 2026 07:52:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MLECHNGkUGpfPgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 10 Jul 2026 07:52:49 +0000
Message-ID: <dd7b8d52-f22c-42ba-b256-80fb3b68c368@suse.de>
Date: Fri, 10 Jul 2026 09:52:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/60] drm/gem-atomic-helper: Remove
 drm_gem_reset_shadow_plane()
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-5-302d986fe5f0@kernel.org>
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
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-5-302d986fe5f0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MID_RHS_MATCH_FROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:url,suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9E42D76391
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



Am 09.07.26 um 13:50 schrieb Maxime Ripard:
> drm_gem_reset_shadow_plane() is no longer used: all callers now go
> through drm_gem_create_shadow_plane_state() via the
> atomic_create_state hook. Remove it.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

I think it would make sense to merge this change into patch 4. Your choice.

> ---
>   drivers/gpu/drm/drm_gem_atomic_helper.c | 23 -----------------------
>   include/drm/drm_gem_atomic_helper.h     |  1 -
>   2 files changed, 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
> index ae854555fd12..3bb6bfd560d3 100644
> --- a/drivers/gpu/drm/drm_gem_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
> @@ -337,33 +337,10 @@ void __drm_gem_reset_shadow_plane(struct drm_plane *plane,
>   		__drm_atomic_helper_plane_reset(plane, NULL);
>   	}
>   }
>   EXPORT_SYMBOL(__drm_gem_reset_shadow_plane);
>   
> -/**
> - * drm_gem_reset_shadow_plane - resets a shadow-buffered plane
> - * @plane: the plane
> - *
> - * This function implements struct &drm_plane_funcs.reset_plane for
> - * shadow-buffered planes. It assumes the current plane state to be
> - * of type struct drm_shadow_plane and it allocates the new state of
> - * this type.
> - */
> -void drm_gem_reset_shadow_plane(struct drm_plane *plane)
> -{
> -	struct drm_shadow_plane_state *shadow_plane_state;
> -
> -	if (plane->state) {
> -		drm_gem_destroy_shadow_plane_state(plane, plane->state);
> -		plane->state = NULL; /* must be set to NULL here */
> -	}
> -
> -	shadow_plane_state = kzalloc_obj(*shadow_plane_state);
> -	__drm_gem_reset_shadow_plane(plane, shadow_plane_state);
> -}
> -EXPORT_SYMBOL(drm_gem_reset_shadow_plane);
> -
>   /**
>    * drm_gem_begin_shadow_fb_access - prepares shadow framebuffers for CPU access
>    * @plane: the plane
>    * @plane_state: the plane state of type struct drm_shadow_plane_state
>    *
> diff --git a/include/drm/drm_gem_atomic_helper.h b/include/drm/drm_gem_atomic_helper.h
> index da8a4fb442b4..2deb0cd9ebbe 100644
> --- a/include/drm/drm_gem_atomic_helper.h
> +++ b/include/drm/drm_gem_atomic_helper.h
> @@ -92,11 +92,10 @@ void __drm_gem_duplicate_shadow_plane_state(struct drm_plane *plane,
>   					    struct drm_shadow_plane_state *new_shadow_plane_state);
>   void __drm_gem_destroy_shadow_plane_state(struct drm_shadow_plane_state *shadow_plane_state);
>   void __drm_gem_reset_shadow_plane(struct drm_plane *plane,
>   				  struct drm_shadow_plane_state *shadow_plane_state);
>   
> -void drm_gem_reset_shadow_plane(struct drm_plane *plane);
>   void __drm_gem_shadow_plane_state_init(struct drm_plane *plane,
>   				       struct drm_shadow_plane_state *shadow_plane_state);
>   struct drm_plane_state *drm_gem_create_shadow_plane_state(struct drm_plane *plane);
>   struct drm_plane_state *drm_gem_duplicate_shadow_plane_state(struct drm_plane *plane);
>   void drm_gem_destroy_shadow_plane_state(struct drm_plane *plane,
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


