Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714E2C79FB5
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B1D410E315;
	Wed,  9 Sep 2026 06:29:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Tb4jeXvc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4TWE+OnT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U4BnwlC1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HoEvHJUI";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6D1110E07C
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:29:02 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 369F5219C9;
 Wed,  9 Sep 2026 06:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788935337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B0oCX5KMpd7x5PI6OZxyukHi8rD2vQm93yVg8CbvZCc=;
 b=Tb4jeXvcvx9gyX//R56F2xo2xIIiTANiRwTnMFwO20hA2y/jX1uhsySsURiudYm9CxriWd
 tGSLEdPGsVprp9Xro0fDT82k653sUtwU2cmWZHzRr01X2n+eAViFIHd54FQw1CxYVCKm89
 zPhuCw22s9n7GTUGzvn8jIMziRe3aQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788935337;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B0oCX5KMpd7x5PI6OZxyukHi8rD2vQm93yVg8CbvZCc=;
 b=4TWE+OnTzD9Ykx833TWy2cxSka6lpDjU1oY7kEFKMPiSjB1eENU+q7/9xyrjpJ6oDGKSpF
 5lH2I2sQ5kRw82CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788935333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B0oCX5KMpd7x5PI6OZxyukHi8rD2vQm93yVg8CbvZCc=;
 b=U4BnwlC14yHpa67+CwxYaLPKFPMmIm5Dmldgee7oa9X/foglmkt+AFPt30neN+CgXG3pva
 JZ7t5ixru3bklmHZnaKBoLjtwTAyjn6SGojDo0jzPfWi/QTTacWyf6itfnoW+kQIg6tcDX
 Ik9Cop4R88E8ZW7PLCPB+4z0d0MXZ1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788935333;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B0oCX5KMpd7x5PI6OZxyukHi8rD2vQm93yVg8CbvZCc=;
 b=HoEvHJUIb7Ao18J/W00fnvPl1gHQlx//mxzDrWGDVwywWkRK0JOvawx1KAxtwDCuoheqS6
 WhvvujRAm0UaHZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81A1A13354;
 Wed,  9 Sep 2026 06:28:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6lG4HaT8oGr9PgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 09 Sep 2026 06:28:52 +0000
Message-ID: <2b3ff8c0-09b4-48fd-9965-9df70d19778c@suse.de>
Date: Wed, 9 Sep 2026 08:28:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] drm/atomic: colorop: Rename state to
 state_to_destroy
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
 <20260908-drm-reset-state-flag-v3-1-905570f387a4@kernel.org>
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
In-Reply-To: <20260908-drm-reset-state-flag-v3-1-905570f387a4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[16];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,suse.com:url];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
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
> The atomic state tracking structures used to have a generic state
> field to track the state to free when tearing down the
> drm_atomic_commit. It has since been renamed to state_to_destroy in
> __drm_planes_state, __drm_crtcs_state, __drm_connnectors_state, and
> __drm_private_objs_state to better describe its purpose.
>
> The colorop support has been added after that rename, but
> __drm_colorops_state still uses the old state name. Rename it to
> state_to_destroy for consistency, and add the matching kerneldoc.

Makes sense. Please merge this as you see fit.

>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/drm_atomic.c        |  6 +++---
>   drivers/gpu/drm/drm_atomic_helper.c |  2 +-
>   include/drm/drm_atomic.h            | 18 +++++++++++++++++-
>   3 files changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 45df6376f408..5c0f7b7024d1 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -341,13 +341,13 @@ void drm_atomic_commit_default_clear(struct drm_atomic_commit *state)
>   
>   		if (!colorop)
>   			continue;
>   
>   		drm_colorop_atomic_destroy_state(colorop,
> -						 state->colorops[i].state);
> +						 state->colorops[i].state_to_destroy);
>   		state->colorops[i].ptr = NULL;
> -		state->colorops[i].state = NULL;
> +		state->colorops[i].state_to_destroy = NULL;
>   		state->colorops[i].old_state = NULL;
>   		state->colorops[i].new_state = NULL;
>   	}
>   
>   	for (i = 0; i < state->num_private_objs; i++) {
> @@ -706,11 +706,11 @@ drm_atomic_get_colorop_state(struct drm_atomic_commit *state,
>   
>   	colorop_state = drm_atomic_helper_colorop_duplicate_state(colorop);
>   	if (!colorop_state)
>   		return ERR_PTR(-ENOMEM);
>   
> -	state->colorops[index].state = colorop_state;
> +	state->colorops[index].state_to_destroy = colorop_state;
>   	state->colorops[index].ptr = colorop;
>   	state->colorops[index].old_state = colorop->state;
>   	state->colorops[index].new_state = colorop_state;
>   	colorop_state->state = state;
>   
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 285aac3554df..c4752bd7d999 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3349,11 +3349,11 @@ int drm_atomic_helper_swap_state(struct drm_atomic_commit *state,
>   		WARN_ON(colorop->state != old_colorop_state);
>   
>   		old_colorop_state->state = state;
>   		new_colorop_state->state = NULL;
>   
> -		state->colorops[i].state = old_colorop_state;
> +		state->colorops[i].state_to_destroy = old_colorop_state;
>   		colorop->state = new_colorop_state;
>   	}
>   
>   	drm_panic_lock(state->dev, flags);
>   	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index 88087910ab1a..00b3e9fc429a 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -157,11 +157,27 @@ struct drm_crtc_commit {
>   	bool abort_completion;
>   };
>   
>   struct __drm_colorops_state {
>   	struct drm_colorop *ptr;
> -	struct drm_colorop_state *state, *old_state, *new_state;
> +
> +	/**
> +	 * @state_to_destroy:
> +	 *
> +	 * Used to track the @drm_colorop_state we will need to free
> +	 * when tearing down the associated &drm_atomic_commit in
> +	 * $drm_mode_config_funcs.atomic_state_clear or
> +	 * drm_atomic_commit_default_clear().
> +	 *
> +	 * Before a commit, and the call to
> +	 * drm_atomic_helper_swap_state() in particular, it points to
> +	 * the same state than @new_state. After a commit, it points to
> +	 * the same state than @old_state.
> +	 */
> +	struct drm_colorop_state *state_to_destroy;
> +
> +	struct drm_colorop_state *old_state, *new_state;
>   };
>   
>   struct __drm_planes_state {
>   	struct drm_plane *ptr;
>   
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


