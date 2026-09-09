Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB508C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33AAA10EEF9;
	Wed,  9 Sep 2026 06:52:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="v+plabNE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nEH0lAf9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gu+5AEWN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tc0tr02Y";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D278810EEF9
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:52:14 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 22187219FE;
 Wed,  9 Sep 2026 06:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788936729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cTt0jFB4+zQipgMujsRjRecWNFqUaVl5wuX8dC/vqwk=;
 b=v+plabNEMMlL5CS/NLEx9p4dMTPWFXNYkiuIKXSvvUjDNVczgU5a5gyOlTzTPRnYNv9BRF
 OTVUXNGpGKs7yIKv5srGD/yL8RApHoC9JymkwIRF3SXtneQwnaYeaAQgphZ3GW00RSD0dp
 edL+JhcZ0T3z0LVMq+gmnuyoJfwa7iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788936729;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cTt0jFB4+zQipgMujsRjRecWNFqUaVl5wuX8dC/vqwk=;
 b=nEH0lAf9Ba+IiozM9frriYkJuYYEc2ZJrBeJxEUK0DigeAQRRI+aIRSEabSW8EpMwDcFaN
 gMZ5bmoQPPN7/DDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788936725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cTt0jFB4+zQipgMujsRjRecWNFqUaVl5wuX8dC/vqwk=;
 b=gu+5AEWNwxIObakbGBg1FJyyvonGroxc/+Y5D1DHVNwT/mRpjyenOFcY18zRUNZBkXMCTd
 CP+tu+RtH9qH2LvWsMW0xBDjRhjrcDpdnamYslNsIqdXpFY6GQbSrlZsMUJ0twJczEkXAI
 ZsB/IU6V7Ui09t9QyMJBmIQe8YqQ0p8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788936725;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cTt0jFB4+zQipgMujsRjRecWNFqUaVl5wuX8dC/vqwk=;
 b=Tc0tr02YJKvVGufqSo1zSvIGw+jsn3ST8u/eYo6w8zzpe4jiE11glpFqL/xc68kkRDOvgy
 +kZuENZvVhpeCBAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F93F1347F;
 Wed,  9 Sep 2026 06:52:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RIpSHRQCoWqVVQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 09 Sep 2026 06:52:04 +0000
Message-ID: <00b9f0f0-baf4-4407-b2cb-055949edd48c@suse.de>
Date: Wed, 9 Sep 2026 08:52:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/11] drm/atomic: Create function to insert connector
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
 <20260908-drm-reset-state-flag-v3-6-905570f387a4@kernel.org>
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
In-Reply-To: <20260908-drm-reset-state-flag-v3-6-905570f387a4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[16];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
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



Am 08.09.26 um 16:35 schrieb Maxime Ripard:
> drm_atomic_get_connector_state() allocates a new connector state by
> duplicating the current one and inserts it into the atomic commit as
> a single operation.
>
> However, a later change will need to insert a connector state into a
> commit without going through the full allocation and duplication path
> in drm_atomic_get_connector_state().
>
> Extract the state insertion logic, including the dynamic array
> reallocation, into a new static
> drm_atomic_commit_set_connector_state() helper, and convert
> drm_atomic_get_connector_state() to use it.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/drm_atomic.c | 67 +++++++++++++++++++++++++++-----------------
>   1 file changed, 42 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 1be4af940ed1..19678e8a2bd4 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -1412,10 +1412,46 @@ drm_atomic_get_new_crtc_for_encoder(struct drm_atomic_commit *state,
>   
>   	return conn_state->crtc;
>   }
>   EXPORT_SYMBOL(drm_atomic_get_new_crtc_for_encoder);
>   
> +static int drm_atomic_commit_set_connector_state(struct drm_atomic_commit *commit,
> +						 struct drm_connector *connector,
> +						 struct drm_connector_state *connector_state)
> +{
> +	struct drm_mode_config *config = &connector->dev->mode_config;
> +	int index;
> +
> +	drm_modeset_lock_assert_held(&config->connection_mutex);
> +
> +	index = drm_connector_index(connector);
> +	if (index >= commit->num_connector) {
> +		struct __drm_connnectors_state *c;
> +		int alloc = max(index + 1, config->num_connector);
> +
> +		c = krealloc_array(commit->connectors, alloc,
> +				   sizeof(*commit->connectors), GFP_KERNEL);

This entire branch looks like it mostly open-codes the functionality of 
krealloc_array(). If you can use __GFP_ZERO here, it appears that this 
whole branching could be collapsed to a single unconditional 
reallocation plus an update of num_connector.

Best regards
Thomas

> +		if (!c)
> +			return -ENOMEM;
> +
> +		commit->connectors = c;
> +		memset(&commit->connectors[commit->num_connector], 0,
> +		       sizeof(*commit->connectors) * (alloc - commit->num_connector));
> +
> +		commit->num_connector = alloc;
> +	}
> +
> +	drm_connector_get(connector);
> +	commit->connectors[index].state_to_destroy = connector_state;
> +	commit->connectors[index].old_state = connector->state;
> +	commit->connectors[index].new_state = connector_state;
> +	commit->connectors[index].ptr = connector;
> +	connector_state->state = commit;
> +
> +	return 0;
> +}
> +
>   /**
>    * drm_atomic_get_connector_state - get connector state
>    * @state: global atomic state object
>    * @connector: connector to get state object for
>    *
> @@ -1430,53 +1466,34 @@ EXPORT_SYMBOL(drm_atomic_get_new_crtc_for_encoder);
>    */
>   struct drm_connector_state *
>   drm_atomic_get_connector_state(struct drm_atomic_commit *state,
>   			  struct drm_connector *connector)
>   {
> -	int ret, index;
> +	int ret;
>   	struct drm_mode_config *config = &connector->dev->mode_config;
>   	struct drm_connector_state *connector_state;
>   
>   	WARN_ON(!state->acquire_ctx);
>   	drm_WARN_ON(state->dev, state->checked);
>   
>   	ret = drm_modeset_lock(&config->connection_mutex, state->acquire_ctx);
>   	if (ret)
>   		return ERR_PTR(ret);
>   
> -	index = drm_connector_index(connector);
> -
> -	if (index >= state->num_connector) {
> -		struct __drm_connnectors_state *c;
> -		int alloc = max(index + 1, config->num_connector);
> -
> -		c = krealloc_array(state->connectors, alloc,
> -				   sizeof(*state->connectors), GFP_KERNEL);
> -		if (!c)
> -			return ERR_PTR(-ENOMEM);
> -
> -		state->connectors = c;
> -		memset(&state->connectors[state->num_connector], 0,
> -		       sizeof(*state->connectors) * (alloc - state->num_connector));
> -
> -		state->num_connector = alloc;
> -	}
> -
>   	connector_state = drm_atomic_get_new_connector_state(state, connector);
>   	if (connector_state)
>   		return connector_state;
>   
>   	connector_state = connector->funcs->atomic_duplicate_state(connector);
>   	if (!connector_state)
>   		return ERR_PTR(-ENOMEM);
>   
> -	drm_connector_get(connector);
> -	state->connectors[index].state_to_destroy = connector_state;
> -	state->connectors[index].old_state = connector->state;
> -	state->connectors[index].new_state = connector_state;
> -	state->connectors[index].ptr = connector;
> -	connector_state->state = state;
> +	ret = drm_atomic_commit_set_connector_state(state, connector, connector_state);
> +	if (ret) {
> +		connector->funcs->atomic_destroy_state(connector, connector_state);
> +		return ERR_PTR(ret);
> +	}
>   
>   	drm_dbg_atomic(connector->dev, "Added [CONNECTOR:%d:%s] %p state to %p\n",
>   			 connector->base.id, connector->name,
>   			 connector_state, state);
>   
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


