Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77983C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4A6410EEF8;
	Wed,  9 Sep 2026 06:46:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="eT+qQyNX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5h8vmoY/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w+Y6wDqq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zPVJGGzo";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD93410EEF8
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:46:53 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1E3A8219F8;
 Wed,  9 Sep 2026 06:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788936408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BP/kW28H50YboJXia0eT7p9rdPAI2wPJOPKdsIC64/k=;
 b=eT+qQyNXrJdMBaSz+hHwroMPXlfT6FCVH7qKn3FPaO5lyAw1UHirl9oG4mjQII4t7Xsalz
 nkSopscxNjcmEvnVc91lsVUIWsd0ybZReSjlRANipzdjPopS717KkYJTfcCro8StJ9QdPU
 TNJiJ9sDnEAF9lxlizTmexHij+1F+JE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788936408;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BP/kW28H50YboJXia0eT7p9rdPAI2wPJOPKdsIC64/k=;
 b=5h8vmoY/CWeARB63HF6NhwHdk6OGF+7JnJ8z5mbyLUzWb3Y8fw+jQ6fWY9uK2+yYVLuIiX
 eLIGL5LbwQj5NQDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=w+Y6wDqq;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zPVJGGzo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788936404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BP/kW28H50YboJXia0eT7p9rdPAI2wPJOPKdsIC64/k=;
 b=w+Y6wDqqWola8FsMkZW/QpZzsmZcGDH9Rq9Ea6shm8eytZMuIOoIKnCNJLXDxTQyKKkSHP
 qIRj1WjKFbTcmukrlwH1sSq3NUcZK+Fu9/F2kXP5242em7jZrIqlxi4VLWufn/duRsNHgO
 ADehmAXTTdW3FOggwKULDKcZNuxuUTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788936404;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BP/kW28H50YboJXia0eT7p9rdPAI2wPJOPKdsIC64/k=;
 b=zPVJGGzokG7Qd5pBwzxl0rPVDkoOQ+OutNvBHa8xYrmeDQr1cd+liuG0ViMqFn+dxklMs1
 de7vtIJYzC+eG9CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90BB71347F;
 Wed,  9 Sep 2026 06:46:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IFX6IdMAoWruTwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 09 Sep 2026 06:46:43 +0000
Message-ID: <e133a72f-ac32-4226-b823-83b7f184b900@suse.de>
Date: Wed, 9 Sep 2026 08:46:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/11] drm/atomic: Create function to insert private
 obj state into a commit
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
 <20260908-drm-reset-state-flag-v3-5-905570f387a4@kernel.org>
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
In-Reply-To: <20260908-drm-reset-state-flag-v3-5-905570f387a4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1E3A8219F8
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[16]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
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
> drm_atomic_get_private_obj_state() allocates a new private object
> state by duplicating the current one and inserts it into the atomic
> commit as a single operation.
>
> However, a later change will need to insert a private object state
> into a commit without going through the full allocation and
> duplication path in drm_atomic_get_private_obj_state().
>
> Extract the state insertion logic, including the array reallocation,
> into a new static drm_atomic_commit_set_private_obj_state() helper,
> and convert drm_atomic_get_private_obj_state() to use it.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/drm_atomic.c | 57 ++++++++++++++++++++++++++++----------------
>   1 file changed, 37 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index f6a31c9d477d..1be4af940ed1 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -1101,10 +1101,41 @@ drm_atomic_private_obj_fini(struct drm_private_obj *obj)
>   	obj->funcs->atomic_destroy_state(obj, obj->state);
>   	drm_modeset_lock_fini(&obj->lock);
>   }
>   EXPORT_SYMBOL(drm_atomic_private_obj_fini);
>   
> +static int drm_atomic_commit_set_private_obj_state(struct drm_atomic_commit *commit,
> +						   struct drm_private_obj *obj,
> +						   struct drm_private_state *obj_state)
> +{
> +	struct __drm_private_objs_state *arr;
> +	int index, num_objs;
> +	size_t size;
> +
> +	drm_modeset_lock_assert_held(&obj->lock);
> +
> +	num_objs = commit->num_private_objs + 1;
> +	size = sizeof(*commit->private_objs) * num_objs;
> +	arr = krealloc(commit->private_objs, size, GFP_KERNEL);
> +	if (!arr)
> +		return -ENOMEM;

Just nitpicks: Would this be a candidate for krealloc_array() ? Could 
you avoid the additional memset by allocating with __GFP_ZERO?

Best regards
Thomas

> +
> +	commit->private_objs = arr;
> +	index = commit->num_private_objs;
> +	memset(&commit->private_objs[index], 0, sizeof(*commit->private_objs));
> +
> +	commit->private_objs[index].state_to_destroy = obj_state;
> +	commit->private_objs[index].old_state = obj->state;
> +	commit->private_objs[index].new_state = obj_state;
> +	commit->private_objs[index].ptr = obj;
> +	obj_state->state = commit;
> +
> +	commit->num_private_objs = num_objs;
> +
> +	return 0;
> +}
> +
>   /**
>    * drm_atomic_get_private_obj_state - get private object state
>    * @state: global atomic state
>    * @obj: private object to get the state for
>    *
> @@ -1117,13 +1148,11 @@ EXPORT_SYMBOL(drm_atomic_private_obj_fini);
>    */
>   struct drm_private_state *
>   drm_atomic_get_private_obj_state(struct drm_atomic_commit *state,
>   				 struct drm_private_obj *obj)
>   {
> -	int index, num_objs, ret;
> -	size_t size;
> -	struct __drm_private_objs_state *arr;
> +	int ret;
>   	struct drm_private_state *obj_state;
>   
>   	WARN_ON(!state->acquire_ctx);
>   	drm_WARN_ON(state->dev, state->checked);
>   
> @@ -1133,31 +1162,19 @@ drm_atomic_get_private_obj_state(struct drm_atomic_commit *state,
>   
>   	ret = drm_modeset_lock(&obj->lock, state->acquire_ctx);
>   	if (ret)
>   		return ERR_PTR(ret);
>   
> -	num_objs = state->num_private_objs + 1;
> -	size = sizeof(*state->private_objs) * num_objs;
> -	arr = krealloc(state->private_objs, size, GFP_KERNEL);
> -	if (!arr)
> -		return ERR_PTR(-ENOMEM);
> -
> -	state->private_objs = arr;
> -	index = state->num_private_objs;
> -	memset(&state->private_objs[index], 0, sizeof(*state->private_objs));
> -
>   	obj_state = obj->funcs->atomic_duplicate_state(obj);
>   	if (!obj_state)
>   		return ERR_PTR(-ENOMEM);
>   
> -	state->private_objs[index].state_to_destroy = obj_state;
> -	state->private_objs[index].old_state = obj->state;
> -	state->private_objs[index].new_state = obj_state;
> -	state->private_objs[index].ptr = obj;
> -	obj_state->state = state;
> -
> -	state->num_private_objs = num_objs;
> +	ret = drm_atomic_commit_set_private_obj_state(state, obj, obj_state);
> +	if (ret) {
> +		obj->funcs->atomic_destroy_state(obj, obj_state);
> +		return ERR_PTR(ret);
> +	}
>   
>   	drm_dbg_atomic(state->dev,
>   		       "Added new private object %p state %p to %p\n",
>   		       obj, obj_state, state);
>   
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


