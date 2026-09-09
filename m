Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4062C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:31:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2893010EECC;
	Wed,  9 Sep 2026 06:31:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="myaRdGsa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3oz1h7eE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fJvfytp4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yzFArzV+";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C695110EECC
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:31:08 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ECCDA1F79C;
 Wed,  9 Sep 2026 06:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788935463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ukbUOG2rKT1Ej+kB+aDSzr7OQjOLlu9tMNdz6i0Z15w=;
 b=myaRdGsa7gLHnoS+Taajh7MABZxePeB9Zu64JilXMFfYZAxoo+Jfd2gBzv60/2SfjG31TF
 9EEb1PmaFG2+JiSP5RNuQEu+sHqw/rO7rBDlIav8WNZgV2/DOWNhs8ACoveL+ZDCCH3G5c
 7uSJT88YqTHNSYQACNW7vgZjw5MZOQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788935463;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ukbUOG2rKT1Ej+kB+aDSzr7OQjOLlu9tMNdz6i0Z15w=;
 b=3oz1h7eEOJgmTnCzjZJ1F9AxsncJ9W4HQ0n6EXTK1DZ7kHg5i1uFiRBH2az6PvVrswRg7v
 h7RONf9zzXcCBHCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788935458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ukbUOG2rKT1Ej+kB+aDSzr7OQjOLlu9tMNdz6i0Z15w=;
 b=fJvfytp4DNPw2X6+Dj+zCD3e7DH1fIBv+tD2i6RKSEwtXQ4xlmtAh1Js8XoEh7MyFbLrYU
 pJG3S19TdcEsmllO+ODKunaCxnuMxB8mc5aWdnRMQCODfBIg8O0VlJ5ttLtdp0olslxUtG
 wVpHAVU0QGhRu/o+HKKDcdAw4TJ0uK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788935458;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ukbUOG2rKT1Ej+kB+aDSzr7OQjOLlu9tMNdz6i0Z15w=;
 b=yzFArzV+NS0w5mkO2O+C0JC9W/UcOK1Qe/N9oHYc3I0SbwgibI9xqR+S7S/XpAWrH39/rY
 7YXLIaTX4QItCBCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56E0713354;
 Wed,  9 Sep 2026 06:30:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gV7BEyL9oGpCQQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 09 Sep 2026 06:30:58 +0000
Message-ID: <19146699-b0ae-4268-833b-82aa3bf35fba@suse.de>
Date: Wed, 9 Sep 2026 08:30:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/11] drm/atomic: Create function to insert CRTC state
 into a commit
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
 <20260908-drm-reset-state-flag-v3-2-905570f387a4@kernel.org>
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
In-Reply-To: <20260908-drm-reset-state-flag-v3-2-905570f387a4@kernel.org>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
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
> drm_atomic_get_crtc_state() allocates a new CRTC state by duplicating
> the current one and inserts it into the atomic commit as a single
> operation.
>
> However, a later change will need to insert a CRTC state into a
> commit without going through the full allocation and duplication path
> in drm_atomic_get_crtc_state().
>
> Extract the state insertion logic into a new static
> drm_atomic_commit_set_crtc_state() helper, and convert
> drm_atomic_get_crtc_state() to use it.

Another change that makes sense on its own.

>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/drm_atomic.c | 29 +++++++++++++++++++++++------
>   1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 5c0f7b7024d1..153d959bd4ff 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -421,10 +421,27 @@ void __drm_atomic_commit_free(struct kref *ref)
>   
>   	drm_dev_put(dev);
>   }
>   EXPORT_SYMBOL(__drm_atomic_commit_free);
>   
> +static int drm_atomic_commit_set_crtc_state(struct drm_atomic_commit *commit,
> +					    struct drm_crtc *crtc,
> +					    struct drm_crtc_state *crtc_state)
> +{
> +	int index = drm_crtc_index(crtc);
> +
> +	drm_modeset_lock_assert_held(&crtc->mutex);
> +
> +	commit->crtcs[index].state_to_destroy = crtc_state;
> +	commit->crtcs[index].old_state = crtc->state;
> +	commit->crtcs[index].new_state = crtc_state;
> +	commit->crtcs[index].ptr = crtc;
> +	crtc_state->state = commit;
> +
> +	return 0;
> +}
> +
>   /**
>    * drm_atomic_get_crtc_state - get CRTC state
>    * @state: global atomic state object
>    * @crtc: CRTC to get state object for
>    *
> @@ -443,11 +460,11 @@ EXPORT_SYMBOL(__drm_atomic_commit_free);
>    */
>   struct drm_crtc_state *
>   drm_atomic_get_crtc_state(struct drm_atomic_commit *state,
>   			  struct drm_crtc *crtc)
>   {
> -	int ret, index = drm_crtc_index(crtc);
> +	int ret;
>   	struct drm_crtc_state *crtc_state;
>   
>   	WARN_ON(!state->acquire_ctx);
>   	drm_WARN_ON(state->dev, state->checked);
>   
> @@ -461,15 +478,15 @@ drm_atomic_get_crtc_state(struct drm_atomic_commit *state,
>   
>   	crtc_state = crtc->funcs->atomic_duplicate_state(crtc);
>   	if (!crtc_state)
>   		return ERR_PTR(-ENOMEM);
>   
> -	state->crtcs[index].state_to_destroy = crtc_state;
> -	state->crtcs[index].old_state = crtc->state;
> -	state->crtcs[index].new_state = crtc_state;
> -	state->crtcs[index].ptr = crtc;
> -	crtc_state->state = state;
> +	ret = drm_atomic_commit_set_crtc_state(state, crtc, crtc_state);
> +	if (ret) {
> +		crtc->funcs->atomic_destroy_state(crtc, crtc_state);
> +		return ERR_PTR(ret);
> +	}
>   
>   	drm_dbg_atomic(state->dev, "Added [CRTC:%d:%s] %p state to %p\n",
>   		       crtc->base.id, crtc->name, crtc_state, state);
>   
>   	return crtc_state;
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


