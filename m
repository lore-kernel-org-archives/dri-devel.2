Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669C7CDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87AB510E196;
	Thu, 25 Jun 2026 08:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="iQ3S+z6J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UmgP42r2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iQ3S+z6J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UmgP42r2";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF2DB10E196
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 08:08:23 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4AB42716D3;
 Thu, 25 Jun 2026 08:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782374902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GhU05X/DdN4XNAXD/9A9Gv7LpEp9nvmG9isXnJjDkKI=;
 b=iQ3S+z6JUdPtuWwIcCCwgahFonLqi3XfaH2p+/arctMlS9ipXq6EnxkvKRqk/07Foc96Gi
 4nBqbxIX4Le95BPAcuE37baNh3Pcl2XyA3OkV5I2t/K03ZNl2f/kwyyraRKOsDGzjntZiD
 uruwq4CLlpWKWfFRTRf1LXVnefKKwuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782374902;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GhU05X/DdN4XNAXD/9A9Gv7LpEp9nvmG9isXnJjDkKI=;
 b=UmgP42r2fM3+Nw+EEbhgkIvkf0elL/nwayEvpvZ8lkazedSseE9plKIRi4r6HWud0LP5DH
 riKYghd1u0krKZCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782374902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GhU05X/DdN4XNAXD/9A9Gv7LpEp9nvmG9isXnJjDkKI=;
 b=iQ3S+z6JUdPtuWwIcCCwgahFonLqi3XfaH2p+/arctMlS9ipXq6EnxkvKRqk/07Foc96Gi
 4nBqbxIX4Le95BPAcuE37baNh3Pcl2XyA3OkV5I2t/K03ZNl2f/kwyyraRKOsDGzjntZiD
 uruwq4CLlpWKWfFRTRf1LXVnefKKwuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782374902;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GhU05X/DdN4XNAXD/9A9Gv7LpEp9nvmG9isXnJjDkKI=;
 b=UmgP42r2fM3+Nw+EEbhgkIvkf0elL/nwayEvpvZ8lkazedSseE9plKIRi4r6HWud0LP5DH
 riKYghd1u0krKZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00BD4779A8;
 Thu, 25 Jun 2026 08:08:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fYuBOvXhPGrMJwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 25 Jun 2026 08:08:21 +0000
Message-ID: <99c89977-85f8-41d4-afbd-ef39e2355c6e@suse.de>
Date: Thu, 25 Jun 2026 10:08:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/37] drm/bridge: analogix-anx6345: Switch to atomic
 bridge callbacks
To: Maxime Ripard <mripard@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org
References: <20260617-drm-all-atomic-bridges-v1-0-b63e6316166b@kernel.org>
 <20260617-drm-all-atomic-bridges-v1-2-b63e6316166b@kernel.org>
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
In-Reply-To: <20260617-drm-all-atomic-bridges-v1-2-b63e6316166b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[12]; TAGGED_RCPT(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[ideasonboard.com,kwiboo.se,gmail.com,bootlin.com,lists.freedesktop.org];
 FREEMAIL_TO(0.00)[kernel.org,intel.com,linaro.org,linux.intel.com,gmail.com,ffwll.ch];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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

Am 17.06.26 um 12:14 schrieb Maxime Ripard:
> The analogix-anx6345 bridge still uses the deprecated non-atomic bridge
> callbacks.
>
> Switch to their atomic counterparts, adding the bridge state
> handlers if not already present.
>
> Generated by the following Coccinelle script:
>
> @ is_bridge @
> identifier funcs;
> @@
>
>   struct drm_bridge_funcs funcs = {
> 	...,
>   };
>
> @ has_create_state depends on is_bridge @
> identifier funcs, f;
> @@
>
> struct drm_bridge_funcs funcs = {
>    ...,
>    .atomic_create_state = f,
>    ...,
> };
>
> @ update_struct depends on (is_bridge && !has_create_state) @
> identifier is_bridge.funcs;
> identifier f;
> @@
>
>   struct drm_bridge_funcs funcs = {
> +	.atomic_create_state = drm_atomic_helper_bridge_create_state,
> +	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> +	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>   	...,
>   };
>
> @ update_pre_enable_struct depends on (is_bridge && !has_create_state) @
> identifier is_bridge.funcs;
> identifier f;
> @@
>
>   struct drm_bridge_funcs funcs = {
>   	...,
> -	.pre_enable = f,
> +	.atomic_pre_enable = f,
>   	...,
>   };
>
> @ update_pre_enable_impl depends on update_pre_enable_struct @
> identifier update_pre_enable_struct.f;
> identifier b;
> @@
>
> -void f(struct drm_bridge *b)
> +void f(struct drm_bridge *b, struct drm_atomic_commit *commit)
>   {
> 	...
>   }
>
> @ update_enable_struct depends on (is_bridge && !has_create_state) @
> identifier is_bridge.funcs;
> identifier f;
> @@
>
>   struct drm_bridge_funcs funcs = {
>   	...,
> -	.enable = f,
> +	.atomic_enable = f,
>   	...,
>   };
>
> @ update_enable_impl depends on update_enable_struct @
> identifier update_enable_struct.f;
> identifier b;
> @@
>
> -void f(struct drm_bridge *b)
> +void f(struct drm_bridge *b, struct drm_atomic_commit *commit)
>   {
> 	...
>   }
>
> @ update_disable_struct depends on (is_bridge && !has_create_state) @
> identifier is_bridge.funcs;
> identifier f;
> @@
>
>   struct drm_bridge_funcs funcs = {
>   	...,
> -	.disable = f,
> +	.atomic_disable = f,
>   	...,
>   };
>
> @ update_disable_impl depends on update_disable_struct @
> identifier update_disable_struct.f;
> identifier b;
> @@
>
> -void f(struct drm_bridge *b)
> +void f(struct drm_bridge *b, struct drm_atomic_commit *commit)
>   {
> 	...
>   }
>
> @ update_post_disable_struct depends on (is_bridge && !has_create_state) @
> identifier is_bridge.funcs;
> identifier f;
> @@
>
>   struct drm_bridge_funcs funcs = {
>   	...,
> -	.post_disable = f,
> +	.atomic_post_disable = f,
>   	...,
>   };
>
> @ update_post_disable_impl depends on update_post_disable_struct @
> identifier update_post_disable_struct.f;
> identifier b;
> @@
>
> -void f(struct drm_bridge *b)
> +void f(struct drm_bridge *b, struct drm_atomic_commit *commit)
>   {
> 	...
>   }
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> index f3fe47b12edc..eba5c6dcb5ad 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> @@ -564,11 +564,12 @@ anx6345_bridge_mode_valid(struct drm_bridge *bridge,
>   		return MODE_CLOCK_HIGH;
>   
>   	return MODE_OK;
>   }
>   
> -static void anx6345_bridge_disable(struct drm_bridge *bridge)
> +static void anx6345_bridge_disable(struct drm_bridge *bridge,
> +				   struct drm_atomic_commit *commit)
>   {
>   	struct anx6345 *anx6345 = bridge_to_anx6345(bridge);
>   
>   	/* Power off all modules except configuration registers access */
>   	anx6345_set_bits(anx6345->map[I2C_IDX_TXCOM], SP_POWERDOWN_CTRL_REG,
> @@ -578,11 +579,12 @@ static void anx6345_bridge_disable(struct drm_bridge *bridge)
>   
>   	if (anx6345->powered)
>   		anx6345_poweroff(anx6345);
>   }
>   
> -static void anx6345_bridge_enable(struct drm_bridge *bridge)
> +static void anx6345_bridge_enable(struct drm_bridge *bridge,
> +				  struct drm_atomic_commit *commit)
>   {
>   	struct anx6345 *anx6345 = bridge_to_anx6345(bridge);
>   	int err;
>   
>   	if (anx6345->panel)
> @@ -598,15 +600,18 @@ static void anx6345_bridge_enable(struct drm_bridge *bridge)
>   	if (err)
>   		DRM_ERROR("Failed to enable DP output: %d\n", err);
>   }
>   
>   static const struct drm_bridge_funcs anx6345_bridge_funcs = {
> +	.atomic_create_state = drm_atomic_helper_bridge_create_state,
> +	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> +	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>   	.attach = anx6345_bridge_attach,
>   	.detach = anx6345_bridge_detach,
>   	.mode_valid = anx6345_bridge_mode_valid,
> -	.disable = anx6345_bridge_disable,
> -	.enable = anx6345_bridge_enable,
> +	.atomic_disable = anx6345_bridge_disable,
> +	.atomic_enable = anx6345_bridge_enable,

More of a style issue:  since these enable/disable helpers now implement 
the atomic callbacks, could they be renamed to _atomic_enable and 
_atomic_disable ?  IIRC I've seen other cases with _pre_enable and 
_post_disable that might be renamed as well.

Best regards
Thomas

>   };
>   
>   static void unregister_i2c_dummy_clients(struct anx6345 *anx6345)
>   {
>   	unsigned int i;
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


