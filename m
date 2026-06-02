Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0ABCD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 07:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED56E10ECAA;
	Tue,  2 Jun 2026 07:24:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="KjigxSta";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Oa8/4UA+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KjigxSta";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Oa8/4UA+";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A15310ECAC
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 07:24:31 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 68FC0689B9;
 Tue,  2 Jun 2026 07:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780385070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YA7u4erDHW+Hxaw1NenhDal0L6bBYN4FIoKC+BRYDJ4=;
 b=KjigxStaVgEvtuuKCwpkE2tzOpgFv1On5L+/Vcq98wL0L52DPyFlsvFaylUlXMDK7BN9R8
 eS+0dtolMp/TjVRhY3tzkvIqVzQ74tr37tTF9BHU8V9H1FvJ09iuBGT7h/kB9bfWSXjJnr
 RK9V3kHKNUrV4+ylooJkafXf2kFXggs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780385070;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YA7u4erDHW+Hxaw1NenhDal0L6bBYN4FIoKC+BRYDJ4=;
 b=Oa8/4UA+YsXh68Of9MBOM29XtmkJCbJOE1o/VcipvgqmwrmWdhmlxlKBgTlqy7FP5ZSGim
 4i76SURfdLfOwdAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780385070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YA7u4erDHW+Hxaw1NenhDal0L6bBYN4FIoKC+BRYDJ4=;
 b=KjigxStaVgEvtuuKCwpkE2tzOpgFv1On5L+/Vcq98wL0L52DPyFlsvFaylUlXMDK7BN9R8
 eS+0dtolMp/TjVRhY3tzkvIqVzQ74tr37tTF9BHU8V9H1FvJ09iuBGT7h/kB9bfWSXjJnr
 RK9V3kHKNUrV4+ylooJkafXf2kFXggs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780385070;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YA7u4erDHW+Hxaw1NenhDal0L6bBYN4FIoKC+BRYDJ4=;
 b=Oa8/4UA+YsXh68Of9MBOM29XtmkJCbJOE1o/VcipvgqmwrmWdhmlxlKBgTlqy7FP5ZSGim
 4i76SURfdLfOwdAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AB87779A7;
 Tue,  2 Jun 2026 07:24:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sXFVBS6FHmqpUQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 02 Jun 2026 07:24:30 +0000
Message-ID: <d640577b-ea48-43ce-ad2f-c0e92b6f1248@suse.de>
Date: Tue, 2 Jun 2026 09:24:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/76] drm/bridge: Add new atomic_create_state callback
To: Maxime Ripard <mripard@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
 <20260530-drm-no-more-bridge-reset-v1-4-875d828d31bc@kernel.org>
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
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-4-875d828d31bc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[kernel.org,intel.com,linaro.org,ideasonboard.com,kwiboo.se,gmail.com,bootlin.com,linux.intel.com,ffwll.ch];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[13];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TAGGED_RCPT(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
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

Am 30.05.26 um 15:59 schrieb Maxime Ripard:
> Commit 47b5ac7daa46 ("drm/atomic: Add new atomic_create_state callback
> to drm_private_obj") introduced a new pattern for allocating drm object
> states: atomic_create_state, a dedicated hook that allocates and
> initializes a pristine state without any side effect.
>
> The bridge atomic_reset callback is already fallible and in practice
> only allocates and initializes state without touching hardware.
> However, the reset name does not make this contract clear: callers
> and implementers cannot tell from the name alone whether the hardware
> will be affected or when the hook is safe to call.
>
> Add an atomic_create_state callback to drm_bridge_funcs to make the
> contract explicit: allocate a pristine state, initialize it, no side
> effects. The core calls it when available, falling back to
> atomic_reset otherwise.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/drm_bridge.c |  8 ++++++--
>   include/drm/drm_bridge.h     | 33 +++++++++++----------------------
>   2 files changed, 17 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 687b36eea0c7..ef06c1aa509a 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -498,11 +498,14 @@ static struct drm_private_state *
>   drm_bridge_atomic_create_priv_state(struct drm_private_obj *obj)
>   {
>   	struct drm_bridge *bridge = drm_priv_to_bridge(obj);
>   	struct drm_bridge_state *state;
>   
> -	state = bridge->funcs->atomic_reset(bridge);
> +	if (bridge->funcs->atomic_create_state)
> +		state = bridge->funcs->atomic_create_state(bridge);
> +	else
> +		state = bridge->funcs->atomic_reset(bridge);
>   	if (IS_ERR(state))
>   		return ERR_CAST(state);
>   
>   	return &state->base;
>   }
> @@ -513,11 +516,12 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
>   	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
>   };
>   
>   static bool drm_bridge_is_atomic(struct drm_bridge *bridge)
>   {
> -	return bridge->funcs->atomic_reset != NULL;
> +	return (bridge->funcs->atomic_create_state ||
> +		bridge->funcs->atomic_reset);
>   }
>   
>   /**
>    * drm_bridge_attach - attach the bridge to an encoder's chain
>    *
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 4ba3a5deef9a..a6c07d339afa 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -502,35 +502,24 @@ struct drm_bridge_funcs {
>   			    struct drm_bridge_state *bridge_state,
>   			    struct drm_crtc_state *crtc_state,
>   			    struct drm_connector_state *conn_state);
>   
>   	/**
> -	 * @atomic_reset:
> +	 * @atomic_create_state:
>   	 *
> -	 * Reset the bridge to a predefined state (or retrieve its current
> -	 * state) and return a &drm_bridge_state object matching this state.
> -	 * This function is called at attach time.
> -	 *
> -	 * The atomic_reset hook is mandatory if the bridge implements any of
> -	 * the atomic hooks, and should be left unassigned otherwise. For
> -	 * bridges that don't subclass &drm_bridge_state, the
> -	 * drm_atomic_helper_bridge_reset() helper function shall be used to
> -	 * implement this hook.
> -	 *
> -	 * Note that the atomic_reset() semantics is not exactly matching the
> -	 * reset() semantics found on other components (connector, plane, ...).
> -	 *
> -	 * 1. The reset operation happens when the bridge is attached, not when
> -	 *    drm_mode_config_reset() is called
> -	 * 2. It's meant to be used exclusively on bridges that have been
> -	 *    converted to the ATOMIC API
> +	 * Allocate a pristine, initialized, state for the bridge
> +	 * object and return it. This callback must have no side
> +	 * effects: in particular, the returned state must not be
> +	 * assigned to the object's state pointer and it must not affect
> +	 * the hardware state.
>   	 *
>   	 * RETURNS:
> -	 * A valid drm_bridge_state object in case of success, an ERR_PTR()
> -	 * giving the reason of the failure otherwise.
> +	 *
> +	 * A new, pristine, bridge state instance or an error pointer
> +	 * on failure.
>   	 */
> -	struct drm_bridge_state *(*atomic_reset)(struct drm_bridge *bridge);

This needs to remain for now, right?

Best regards
Thomas

> +	struct drm_bridge_state *(*atomic_create_state)(struct drm_bridge *bridge);
>   
>   	/**
>   	 * @detect:
>   	 *
>   	 * Check if anything is attached to the bridge output.
> @@ -1369,11 +1358,11 @@ drm_bridge_get_current_state(struct drm_bridge *bridge)
>   	/*
>   	 * Only atomic bridges will have bridge->base initialized by
>   	 * drm_atomic_private_obj_init(), so we need to make sure we're
>   	 * working with one before we try to use the lock.
>   	 */
> -	if (!bridge->funcs || !bridge->funcs->atomic_reset)
> +	if (!bridge->funcs || !bridge->funcs->atomic_create_state)
>   		return NULL;
>   
>   	drm_modeset_lock_assert_held(&bridge->base.lock);
>   
>   	if (!bridge->base.state)
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


