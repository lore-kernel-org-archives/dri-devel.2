Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5FFC79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A11B810EEDD;
	Wed,  9 Sep 2026 06:36:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="cRzoqgyK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qKhCez59";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D8jAZf+h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hMjaeG2e";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEE0910EEDD
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:36:06 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0C0911F7C7;
 Wed,  9 Sep 2026 06:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788935761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5sd51LBID5ZXpkGjay/T8MMAPNeGs/V7W0I0XT5GDgU=;
 b=cRzoqgyKxfMBhN5Q9OK8ybuab0cVwjzWi5fvptOvVDBCy6nAszrSYa0lLr8bCUvrlL2aZU
 7GTRL7pXIummqVWUYKEGwk8LoiW4Q/S0yYkkse6et3u1Yk4sCUltSypaAI1jF7RTKqmpQq
 lRPbDkoaja9sf/C0QOzXc8+TwOW2cms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788935761;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5sd51LBID5ZXpkGjay/T8MMAPNeGs/V7W0I0XT5GDgU=;
 b=qKhCez59xLfKLgeoL+Hi80bnuYjP+CQRfYEq8svLuqFe5grC0b6eKCcblh2XXG+52+VPhs
 LmrImtJ0at0HO9DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788935757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5sd51LBID5ZXpkGjay/T8MMAPNeGs/V7W0I0XT5GDgU=;
 b=D8jAZf+h/ufg2SnfYz4F1JyQ67w+ZyrMxO45W/7qozUrUyClXYCtMNeZwZYn0dVLm+SXur
 TGOiiEG1ZBJZmLFzDvjvLdFfohHh8H/XJwug9wYXa+THMcNO/d5JBH8Vax0WdOqCaXYbVs
 7xkcMBvo07tkQv3MNzyVUo17l9NHQVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788935757;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5sd51LBID5ZXpkGjay/T8MMAPNeGs/V7W0I0XT5GDgU=;
 b=hMjaeG2eNetg4gevGRkSgSvvK7tyF7rbpoBigDdk0ZL0aD7o19uy5r01p6+MepyCw6nkLK
 ofj8HF4ANFB2MMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D28F13354;
 Wed,  9 Sep 2026 06:35:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BAA7IUz+oGppRQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 09 Sep 2026 06:35:56 +0000
Message-ID: <727da7ab-9148-4c80-8810-0f31e9290427@suse.de>
Date: Wed, 9 Sep 2026 08:35:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/11] drm/atomic: Create function to insert colorop
 state into a commit
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
 <20260908-drm-reset-state-flag-v3-4-905570f387a4@kernel.org>
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
In-Reply-To: <20260908-drm-reset-state-flag-v3-4-905570f387a4@kernel.org>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, suse.com:url]
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



Am 08.09.26 um 16:35 schrieb Maxime Ripard:
> drm_atomic_get_colorop_state() allocates a new colorop state by
> duplicating the current one and inserts it into the atomic commit as
> a single operation.
>
> However, a later change will need to insert a colorop state into a
> commit without going through the full allocation and duplication path
> in drm_atomic_get_colorop_state().
>
> Extract the state insertion logic into a new static
> drm_atomic_commit_set_colorop_state() helper, and convert
> drm_atomic_get_colorop_state() to use it.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

with the question of the return value again.

> ---
>   drivers/gpu/drm/drm_atomic.c | 29 +++++++++++++++++++++++------
>   1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index f62323679f44..f6a31c9d477d 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -704,10 +704,27 @@ drm_atomic_get_plane_state(struct drm_atomic_commit *state,
>   
>   	return plane_state;
>   }
>   EXPORT_SYMBOL(drm_atomic_get_plane_state);
>   
> +static int drm_atomic_commit_set_colorop_state(struct drm_atomic_commit *commit,
> +					       struct drm_colorop *colorop,
> +					       struct drm_colorop_state *colorop_state)
> +{
> +	int index = drm_colorop_index(colorop);
> +
> +	drm_modeset_lock_assert_held(&colorop->plane->mutex);
> +
> +	commit->colorops[index].state_to_destroy = colorop_state;
> +	commit->colorops[index].old_state = colorop->state;
> +	commit->colorops[index].new_state = colorop_state;
> +	commit->colorops[index].ptr = colorop;
> +	colorop_state->state = commit;
> +
> +	return 0;
> +}
> +
>   /**
>    * drm_atomic_get_colorop_state - get colorop state
>    * @state: global atomic state object
>    * @colorop: colorop to get state object for
>    *
> @@ -723,11 +740,11 @@ EXPORT_SYMBOL(drm_atomic_get_plane_state);
>    */
>   struct drm_colorop_state *
>   drm_atomic_get_colorop_state(struct drm_atomic_commit *state,
>   			     struct drm_colorop *colorop)
>   {
> -	int ret, index = drm_colorop_index(colorop);
> +	int ret;
>   	struct drm_colorop_state *colorop_state;
>   
>   	WARN_ON(!state->acquire_ctx);
>   
>   	colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
> @@ -740,15 +757,15 @@ drm_atomic_get_colorop_state(struct drm_atomic_commit *state,
>   
>   	colorop_state = drm_atomic_helper_colorop_duplicate_state(colorop);
>   	if (!colorop_state)
>   		return ERR_PTR(-ENOMEM);
>   
> -	state->colorops[index].state_to_destroy = colorop_state;
> -	state->colorops[index].ptr = colorop;
> -	state->colorops[index].old_state = colorop->state;
> -	state->colorops[index].new_state = colorop_state;
> -	colorop_state->state = state;
> +	ret = drm_atomic_commit_set_colorop_state(state, colorop, colorop_state);
> +	if (ret) {
> +		drm_colorop_atomic_destroy_state(colorop, colorop_state);
> +		return ERR_PTR(ret);
> +	}
>   
>   	drm_dbg_atomic(colorop->dev, "Added [COLOROP:%d:%d] %p state to %p\n",
>   		       colorop->base.id, colorop->type, colorop_state, state);
>   
>   	return colorop_state;
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


