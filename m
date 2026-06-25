Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63C0CDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26C7D10E305;
	Thu, 25 Jun 2026 07:55:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="fIYISGEz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sL36MAEu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tF9wyL1Y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PRp17d5r";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A25C710E305
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 07:55:50 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1BD697166F;
 Thu, 25 Jun 2026 07:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782374149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MEaCVYlQJSa7GIPtDtUlsm2vEzZVaHfIv4t6eDGZzjg=;
 b=fIYISGEzFdzo4Jg2g67MqST8RDtJuT9/9Lv3YAJWofzoOd2jFN68ifdjXNCSx9Eytm+9U3
 KItjsBidxjDPV79KrvhgZ8yCcPmsLBBKnsLKtCZqjn+y1Xjqyl5lS8/KpOriVE4GPnE+pC
 Lw1mJdOaOqLHAlSf9L9vka96QMRl3Ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782374149;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MEaCVYlQJSa7GIPtDtUlsm2vEzZVaHfIv4t6eDGZzjg=;
 b=sL36MAEuyHqSPcfK5bHO7ICe17YgnGY72JN00WYP2rFrQz4yPeOw/tHDw22n9v3YZKesrA
 Nnsb1J9hyJJQqDCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782374148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MEaCVYlQJSa7GIPtDtUlsm2vEzZVaHfIv4t6eDGZzjg=;
 b=tF9wyL1YGUgXf/vwZLsc/bvC2BT49IXqR8Clu/knGaBtcucCp/XSwr+2m2mMkhd8J6PoVm
 vlVLuwh+qKEziYX7faEKynT8vBcQC3RqVh6e15Swi9pwRqUMqnigjb2pR9QDcfjABF2NMK
 uX9nKpxI4wJTcDzICyr+kaeB5daUyfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782374148;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MEaCVYlQJSa7GIPtDtUlsm2vEzZVaHfIv4t6eDGZzjg=;
 b=PRp17d5r/o3DdY7G/fZ9dfnhUYv8YNKOh6KzPD+bTLmfH1BhLgvsmuFrhNgpJAg1Djifw/
 7mKC7jc3eCx4hvDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3082779A8;
 Thu, 25 Jun 2026 07:55:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KN92LgPfPGqDHAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 25 Jun 2026 07:55:47 +0000
Message-ID: <798816a3-28f1-4b23-8d51-ada047f803fc@suse.de>
Date: Thu, 25 Jun 2026 09:55:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/37] drm/bridge: chrontel-ch7033: Switch to atomic
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
 <20260617-drm-all-atomic-bridges-v1-6-b63e6316166b@kernel.org>
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
In-Reply-To: <20260617-drm-all-atomic-bridges-v1-6-b63e6316166b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[kernel.org,intel.com,linaro.org,linux.intel.com,gmail.com,ffwll.ch];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[ideasonboard.com,kwiboo.se,gmail.com,bootlin.com,lists.freedesktop.org];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TAGGED_RCPT(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, suse.de:mid,
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

Hi Maxime

Am 17.06.26 um 12:14 schrieb Maxime Ripard:
> The chrontel-ch7033 bridge still uses the deprecated non-atomic bridge
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
>   drivers/gpu/drm/bridge/chrontel-ch7033.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/chrontel-ch7033.c b/drivers/gpu/drm/bridge/chrontel-ch7033.c
> index a237c65ebd69..92d464727e41 100644
> --- a/drivers/gpu/drm/bridge/chrontel-ch7033.c
> +++ b/drivers/gpu/drm/bridge/chrontel-ch7033.c
> @@ -328,19 +328,21 @@ static enum drm_mode_status ch7033_bridge_mode_valid(struct drm_bridge *bridge,
>   	if (mode->vdisplay >= 1080)
>   		return MODE_BAD_VVALUE;
>   	return MODE_OK;
>   }
>   
> -static void ch7033_bridge_disable(struct drm_bridge *bridge)
> +static void ch7033_bridge_disable(struct drm_bridge *bridge,
> +				  struct drm_atomic_commit *commit)
>   {
>   	struct ch7033_priv *priv = bridge_to_ch7033_priv(bridge);
>   
>   	regmap_write(priv->regmap, 0x03, 0x04);
>   	regmap_update_bits(priv->regmap, 0x52, RESETDB, 0x00);
>   }
>   
> -static void ch7033_bridge_enable(struct drm_bridge *bridge)
> +static void ch7033_bridge_enable(struct drm_bridge *bridge,
> +				 struct drm_atomic_commit *commit)
>   {
>   	struct ch7033_priv *priv = bridge_to_ch7033_priv(bridge);
>   
>   	regmap_write(priv->regmap, 0x03, 0x04);
>   	regmap_update_bits(priv->regmap, 0x52, RESETDB, RESETDB);
> @@ -512,15 +514,18 @@ static void ch7033_bridge_mode_set(struct drm_bridge *bridge,
>   	regmap_write(priv->regmap, 0x11, mode->clock >> 8);
>   	regmap_write(priv->regmap, 0x12, mode->clock);
>   }
>   
>   static const struct drm_bridge_funcs ch7033_bridge_funcs = {
> +	.atomic_create_state = drm_atomic_helper_bridge_create_state,
> +	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> +	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>   	.attach = ch7033_bridge_attach,
>   	.detach = ch7033_bridge_detach,
>   	.mode_valid = ch7033_bridge_mode_valid,
> -	.disable = ch7033_bridge_disable,
> -	.enable = ch7033_bridge_enable,
> +	.atomic_disable = ch7033_bridge_disable,
> +	.atomic_enable = ch7033_bridge_enable,
>   	.mode_set = ch7033_bridge_mode_set,

This driver uses mode_set and the docs have a number of comments on 
that. Does this need to be reworked as well?

Best regards
Thomas

>   };
>   
>   static const struct regmap_config ch7033_regmap_config = {
>   	.reg_bits = 8,
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


