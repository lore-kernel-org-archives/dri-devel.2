Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C829C79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D95510EED3;
	Wed,  9 Sep 2026 06:34:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="qc7a0T7I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HtlYJRlW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m6o3RiO9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z1DdhI9m";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C251B10EED3
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:34:27 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F2689219AC;
 Wed,  9 Sep 2026 06:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788935662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xJObUBGnkUxW+wvrR5z6kByIYO+JORY2AXipapUkFwA=;
 b=qc7a0T7If+JsyHF/eKR/ej/8FQoszKLVTq+l5QYOxRCaHA3kMyajuRqXzij3Xu1C6DIdo0
 qcWS2G3wD0QHRCoXIGbULSH3eDC7xMj7zc3Sh8BQtOuTxGqrHuDtCM8XeheqACcvfJNQGd
 edb3jTwbTLZriimde/UsUHyswt+DbG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788935662;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xJObUBGnkUxW+wvrR5z6kByIYO+JORY2AXipapUkFwA=;
 b=HtlYJRlWQpBG1o24fwSpl1qfRfe0+kBdeCcw/ZADpdoeABOqm9MTETS7Z3wSsFtnwFmi7Q
 /heYXe/pm/R+3sAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788935658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xJObUBGnkUxW+wvrR5z6kByIYO+JORY2AXipapUkFwA=;
 b=m6o3RiO9uwp8n1SAb/qlvmVD5Lf7xPqnido8/ihsXM59/WQdeFnEJCdYMshV++pilSVOdB
 2BhvC0K/C/7U9HjbLh7CriV0BfjRZRszIcTuD/bvBYlqRXXZndvB7vCf9LFHc51kS5ksO8
 ssXn0aACF+sjdiwTD9mq/l7lLIM4dZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788935658;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xJObUBGnkUxW+wvrR5z6kByIYO+JORY2AXipapUkFwA=;
 b=z1DdhI9m/mIhKAli2W8sqPqH8Sq73selusIXmLdrjNOdy1b5jo7LeKpAQpwj6R3qUeT2TW
 b/X2G0HlnDz3/dBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 663D8138D2;
 Wed,  9 Sep 2026 06:34:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pVbAF+n9oGr6QwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 09 Sep 2026 06:34:17 +0000
Message-ID: <0553006c-9cc9-47dc-8ac9-e71e4c617968@suse.de>
Date: Wed, 9 Sep 2026 08:34:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] drm/atomic: Create function to insert plane
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
 <20260908-drm-reset-state-flag-v3-3-905570f387a4@kernel.org>
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
In-Reply-To: <20260908-drm-reset-state-flag-v3-3-905570f387a4@kernel.org>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email, suse.com:url,
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
> drm_atomic_get_plane_state() allocates a new plane state by
> duplicating the current one and inserts it into the atomic commit as
> a single operation.
>
> However, a later change will need to insert a plane state into a
> commit without going through the full allocation and duplication path
> in drm_atomic_get_plane_state().
>
> Extract the state insertion logic into a new static
> drm_atomic_commit_set_plane_state() helper, and convert
> drm_atomic_get_plane_state() to use it.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

But there's a question below.

> ---
>   drivers/gpu/drm/drm_atomic.c | 29 +++++++++++++++++++++++------
>   1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 153d959bd4ff..f62323679f44 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -624,10 +624,27 @@ static int drm_atomic_connector_check(struct drm_connector *connector,
>   	}
>   
>   	return 0;
>   }
>   
> +static int drm_atomic_commit_set_plane_state(struct drm_atomic_commit *commit,
> +					     struct drm_plane *plane,
> +					     struct drm_plane_state *plane_state)
> +{
> +	int index = drm_plane_index(plane);
> +
> +	drm_modeset_lock_assert_held(&plane->mutex);
> +
> +	commit->planes[index].state_to_destroy = plane_state;
> +	commit->planes[index].old_state = plane->state;
> +	commit->planes[index].new_state = plane_state;
> +	commit->planes[index].ptr = plane;
> +	plane_state->state = commit;
> +
> +	return 0;

I've notices that in other commits as well: why does it have a return 
value when the function cannot fail?  If there isn't a need later on, it 
should preferably by removed.

Best regards
Thomas

> +}
> +
>   /**
>    * drm_atomic_get_plane_state - get plane state
>    * @state: global atomic state object
>    * @plane: plane to get state object for
>    *
> @@ -642,11 +659,11 @@ static int drm_atomic_connector_check(struct drm_connector *connector,
>    */
>   struct drm_plane_state *
>   drm_atomic_get_plane_state(struct drm_atomic_commit *state,
>   			  struct drm_plane *plane)
>   {
> -	int ret, index = drm_plane_index(plane);
> +	int ret;
>   	struct drm_plane_state *plane_state;
>   
>   	WARN_ON(!state->acquire_ctx);
>   	drm_WARN_ON(state->dev, state->checked);
>   
> @@ -665,15 +682,15 @@ drm_atomic_get_plane_state(struct drm_atomic_commit *state,
>   
>   	plane_state = plane->funcs->atomic_duplicate_state(plane);
>   	if (!plane_state)
>   		return ERR_PTR(-ENOMEM);
>   
> -	state->planes[index].state_to_destroy = plane_state;
> -	state->planes[index].ptr = plane;
> -	state->planes[index].old_state = plane->state;
> -	state->planes[index].new_state = plane_state;
> -	plane_state->state = state;
> +	ret = drm_atomic_commit_set_plane_state(state, plane, plane_state);
> +	if (ret) {
> +		plane->funcs->atomic_destroy_state(plane, plane_state);
> +		return ERR_PTR(ret);
> +	}
>   
>   	drm_dbg_atomic(plane->dev, "Added [PLANE:%d:%s] %p state to %p\n",
>   		       plane->base.id, plane->name, plane_state, state);
>   
>   	if (plane_state->crtc) {
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


