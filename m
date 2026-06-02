Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B388CD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 07:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 665F5113893;
	Tue,  2 Jun 2026 07:04:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="f0I3fILU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2VP9wB3N";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dFvz5TKj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MYAFlN5r";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 943BB11388F
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 07:04:01 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 36156682F8;
 Tue,  2 Jun 2026 07:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780383840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vCLVz4Ny02ykXSMd6XQto1pdK/ycW1OygOhuDeG9yEc=;
 b=f0I3fILUFB92sKIAog0/RqMPNo7cAyu6I2hPcN25S5q+sQzDlO0cz7XdNOZcqGuOwUyMfy
 zn5+DSL0t+paqgBO8fjj2epMwcKJO8qQ+yfUSOslmavNn3lELc6pJ8Kb3Gzhr5UnNpocnR
 TqSz2Nn8q47vPsCBS+4kmxdag8VF6t4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780383840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vCLVz4Ny02ykXSMd6XQto1pdK/ycW1OygOhuDeG9yEc=;
 b=2VP9wB3Nuiie5MiL66TPLMjf79RCVaGSSBKOGU7FQgah7r09gayQsLu9oyz3y41A/+wRMk
 DG9PM/Aq65Adi2Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780383839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vCLVz4Ny02ykXSMd6XQto1pdK/ycW1OygOhuDeG9yEc=;
 b=dFvz5TKjwhYzlchYRoDvWo1W/SmBeHJowVfRhZ3TfQoBhodf0qwan73nlp52nMlfIeF45v
 X2lGvRfQceXYZWCMUw4vTTfOCjFu+2DseRDmvVzzo55A2AW1CQnCMUaGinaApHaOWGaj6/
 MsXbV8hwQiJrtVSZSPzBSzpeFkP0yYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780383839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vCLVz4Ny02ykXSMd6XQto1pdK/ycW1OygOhuDeG9yEc=;
 b=MYAFlN5rrtpJOrKBz+qLqoMv7D5oIS+pMNpGezRJqCxBscVhYxynx4d0v1CHKosIAIP82p
 OPC4Wmr28+knE7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D851A779A7;
 Tue,  2 Jun 2026 07:03:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lDspM16AHmqVPgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 02 Jun 2026 07:03:58 +0000
Message-ID: <cebd7c2c-cfd4-4f1c-a334-3783fabfae71@suse.de>
Date: Tue, 2 Jun 2026 09:03:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/76] drm/atomic-state-helper: Reorder
 __drm_atomic_helper_bridge_state_init() arguments
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
 <20260530-drm-no-more-bridge-reset-v1-2-875d828d31bc@kernel.org>
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
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-2-875d828d31bc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.984]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWELVE(0.00)[13];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_TO(0.00)[kernel.org,intel.com,linaro.org,ideasonboard.com,kwiboo.se,gmail.com,bootlin.com,linux.intel.com,ffwll.ch];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid, suse.com:url,
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



Am 30.05.26 um 15:59 schrieb Maxime Ripard:
> The convention for state init helpers is to pass the state pointer
> as the first argument and the object pointer second.
>
> __drm_atomic_helper_bridge_state_init() has them in the opposite
> order. Swap the arguments to follow the convention, and update the
> cdns-mhdp8546 caller.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 2 +-
>   drivers/gpu/drm/drm_atomic_state_helper.c           | 8 ++++----
>   include/drm/drm_atomic_state_helper.h               | 4 ++--
>   3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 4e3015d10a97..063f073034c1 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -1927,11 +1927,11 @@ cdns_mhdp_bridge_atomic_reset(struct drm_bridge *bridge)
>   
>   	cdns_mhdp_state = kzalloc_obj(*cdns_mhdp_state);
>   	if (!cdns_mhdp_state)
>   		return NULL;
>   
> -	__drm_atomic_helper_bridge_state_init(bridge, &cdns_mhdp_state->base);
> +	__drm_atomic_helper_bridge_state_init(&cdns_mhdp_state->base, bridge);
>   
>   	return &cdns_mhdp_state->base;
>   }
>   
>   static u32 *cdns_mhdp_get_input_bus_fmts(struct drm_bridge *bridge,
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index c38e514f336f..8f04eae7a754 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -886,19 +886,19 @@ void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
>   EXPORT_SYMBOL(drm_atomic_helper_bridge_destroy_state);
>   
>   /**
>    * __drm_atomic_helper_bridge_state_init() - Initialize a bridge state to its
>    *					default
> - * @bridge: the bridge this state refers to
>    * @state: bridge state to initialize
> + * @bridge: the bridge this state refers to
>    *
>    * Initializes the bridge state to default values. This is meant to be called
>    * by the bridge &drm_bridge_funcs.atomic_reset hook for bridges that subclass
>    * the bridge state.
>    */
> -void __drm_atomic_helper_bridge_state_init(struct drm_bridge *bridge,
> -				      struct drm_bridge_state *state)
> +void __drm_atomic_helper_bridge_state_init(struct drm_bridge_state *state,
> +					   struct drm_bridge *bridge)
>   {
>   	memset(state, 0, sizeof(*state));
>   	__drm_atomic_helper_private_obj_create_state(&bridge->base, &state->base);
>   	state->bridge = bridge;
>   }
> @@ -920,9 +920,9 @@ drm_atomic_helper_bridge_reset(struct drm_bridge *bridge)
>   
>   	bridge_state = kzalloc_obj(*bridge_state);
>   	if (!bridge_state)
>   		return ERR_PTR(-ENOMEM);
>   
> -	__drm_atomic_helper_bridge_reset(bridge, bridge_state);
> +	__drm_atomic_helper_bridge_state_init(bridge_state, bridge);
>   	return bridge_state;
>   }
>   EXPORT_SYMBOL(drm_atomic_helper_bridge_reset);
> diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
> index 6a715d8e1f4a..cbc760598b9e 100644
> --- a/include/drm/drm_atomic_state_helper.h
> +++ b/include/drm/drm_atomic_state_helper.h
> @@ -100,9 +100,9 @@ void __drm_atomic_helper_bridge_duplicate_state(struct drm_bridge *bridge,
>   						struct drm_bridge_state *state);
>   struct drm_bridge_state *
>   drm_atomic_helper_bridge_duplicate_state(struct drm_bridge *bridge);
>   void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
>   					    struct drm_bridge_state *state);
> -void __drm_atomic_helper_bridge_state_init(struct drm_bridge *bridge,
> -				      struct drm_bridge_state *state);
> +void __drm_atomic_helper_bridge_state_init(struct drm_bridge_state *state,
> +					   struct drm_bridge *bridge);
>   struct drm_bridge_state *
>   drm_atomic_helper_bridge_reset(struct drm_bridge *bridge);
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


