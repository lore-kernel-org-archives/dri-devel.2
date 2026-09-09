Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B7FC79FB5
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3958F10EF6D;
	Wed,  9 Sep 2026 06:58:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="0/8vtP+X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X11V6Uef";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vzPQdsZT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rENVUtkq";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC5A110EF6D
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:58:41 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1898721A15;
 Wed,  9 Sep 2026 06:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788937116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BxGowlxBehHp9k2qr8/gotoZnXf4or006RpTsEQpy28=;
 b=0/8vtP+X0Url+sEnYAO+6hb2ATixIlTo5ysTVK+7u+YwkNuuMK9W1drQ0fJuoX4v2wuxa2
 8Ylo65ZoD9xoN8RIQh2E/SSucflRCF8Bd8CloUDHysc3lvX7RqkoX/zgNJ3o0w3L+zGlzb
 gqqjuUWkSa2oYeWN0EEdjus06D4Ck7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788937116;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BxGowlxBehHp9k2qr8/gotoZnXf4or006RpTsEQpy28=;
 b=X11V6UefNRudncesuOIeT5dQIPSJkYd5O/2CIlgIaNXfxmEgpsGhCYkXcDFyS+XQJekkzB
 LhpEnMQPSq0NZhCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788937112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BxGowlxBehHp9k2qr8/gotoZnXf4or006RpTsEQpy28=;
 b=vzPQdsZTMCMn5nV9xGej1uESyw+gQavRdJswE4Bt5xfnGSmSVTho5syrOlTqbJx42kBarP
 eguQ6iZPvXB3dMhOzXTtIXZo0y9fDVRym1yQbT/H/giPrGFI7GsdJuWkHka2uXCxgy2aTt
 A5r/1ivw/ZKkI+1MBV/5GO1SjqAPAyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788937112;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BxGowlxBehHp9k2qr8/gotoZnXf4or006RpTsEQpy28=;
 b=rENVUtkqOys1WMmI1Z8T9Bsk8w7ltswhqfiAzu4gyFVp54gUQSl7rXjK8hx5DiyUfg4M1w
 ZH6JQCYXfltUzKDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E0011347F;
 Wed,  9 Sep 2026 06:58:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S/U2IZcDoWpmWwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 09 Sep 2026 06:58:31 +0000
Message-ID: <66236146-7c2d-4bbd-a508-d415fbb358ce@suse.de>
Date: Wed, 9 Sep 2026 08:58:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] drm/atomic: Add drm_atomic_can_create_state()
 helper
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Daniel Stone <daniels@collabora.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, =?UTF-8?Q?Jonas_=C3=85dahl?=
 <jadahl@redhat.com>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>,
 Victoria Brekenfeld <victoria@system76.com>, Xaver Hugl
 <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260908-drm-reset-state-flag-v3-0-905570f387a4@kernel.org>
 <20260908-drm-reset-state-flag-v3-7-905570f387a4@kernel.org>
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
In-Reply-To: <20260908-drm-reset-state-flag-v3-7-905570f387a4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
 RCPT_COUNT_TWELVE(0.00)[16]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
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

Am 08.09.26 um 16:35 schrieb Maxime Ripard:
> The atomic reset path will need to create pristine default states from
> scratch for every plane, CRTC, and connector. This requires all of them
> to implement the atomic_create_state hook.
>
> Introduce a drm_atomic_can_create_state() helper that iterates over all
> planes, CRTCs, and connectors and returns whether they all provide the
> hook. Color operations are excluded since they always use
> drm_atomic_helper_colorop_create_state() directly.
>
> This will be used both as a precondition before filling a commit with
> default states, and to report the device capability to userspace.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/drm_atomic.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
>   include/drm/drm_atomic.h     |  2 ++
>   2 files changed, 51 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 19678e8a2bd4..508a027398af 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -1612,10 +1612,59 @@ drm_atomic_get_new_bridge_state(const struct drm_atomic_commit *state,
>   
>   	return drm_priv_to_bridge_state(obj_state);
>   }
>   EXPORT_SYMBOL(drm_atomic_get_new_bridge_state);
>   
> +/**
> + * drm_atomic_can_create_state - check if a device supports creating pristine states
> + * @dev: DRM device

I find this name a bit vague, because all mode-setting pipelines can 
create states in one way or another. Given how it is used, I suggest 
naming this helper _can_create_default_states or _can_reset_state.

Best regards
Thomas

> + *
> + * Check whether every plane, CRTC, and connector in @dev implements the
> + * &drm_plane_funcs.atomic_create_state, &drm_crtc_funcs.atomic_create_state,
> + * and &drm_connector_funcs.atomic_create_state hooks respectively. These hooks
> + * are required to create default states from scratch rather than duplicating
> + * the current state.
> + *
> + * Color operations are not checked because they always use
> + * drm_atomic_helper_colorop_create_state() and do not have a per-driver hook.
> + *
> + * Returns:
> + * True if all objects implement atomic_create_state, false otherwise.
> + */
> +bool drm_atomic_can_create_state(struct drm_device *dev)
> +{
> +	struct drm_connector_list_iter conn_iter;
> +	struct drm_connector *connector;
> +	struct drm_plane *plane;
> +	struct drm_crtc *crtc;
> +
> +	/*
> +	 * colorops don't have an atomic_create_state hook but
> +	 * drm_atomic_helper_colorop_create_state()
> +	 */
> +
> +	drm_for_each_plane(plane, dev)
> +		if (!plane->funcs->atomic_create_state)
> +			return false;
> +
> +	drm_for_each_crtc(crtc, dev)
> +		if (!crtc->funcs->atomic_create_state)
> +			return false;
> +
> +	drm_connector_list_iter_begin(dev, &conn_iter);
> +	drm_for_each_connector_iter(connector, &conn_iter) {
> +		if (!connector->funcs->atomic_create_state) {
> +			drm_connector_list_iter_end(&conn_iter);
> +			return false;
> +		}
> +	}
> +	drm_connector_list_iter_end(&conn_iter);
> +
> +	return true;
> +}
> +EXPORT_SYMBOL(drm_atomic_can_create_state);
> +
>   /**
>    * drm_atomic_add_encoder_bridges - add bridges attached to an encoder
>    * @state: atomic state
>    * @encoder: DRM encoder
>    *
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index 00b3e9fc429a..7dc26e3da65c 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -700,10 +700,12 @@ int drm_crtc_commit_wait(struct drm_crtc_commit *commit);
>   
>   struct drm_atomic_commit * __must_check
>   drm_atomic_commit_alloc(struct drm_device *dev);
>   void drm_atomic_commit_clear(struct drm_atomic_commit *state);
>   
> +bool drm_atomic_can_create_state(struct drm_device *dev);
> +
>   /**
>    * drm_atomic_commit_get - acquire a reference to the atomic state
>    * @state: The atomic state
>    *
>    * Returns a new reference to the @state
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


