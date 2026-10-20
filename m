Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86963606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GxUlSXF8;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=j4D+5XZC;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GxUlSXF8;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=j4D+5XZC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EABE910EC05;
	Tue, 20 Oct 2026 13:57:22 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B7A110EBD8
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 13:57:11 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 728E51F7D8;
 Tue, 20 Oct 2026 13:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792504629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UJMubidmylJDsxYCR+T7l/FmNAGpyGcMQR4ciJIBILA=;
 b=GxUlSXF83vf2MUr1jT68XemcZjCvquscRotCIKYLCA5L0PceaJayv0QglREDAgcAJ5i2G+
 mrIdEnRymdRJFJUOwRJlQ/Jym6NEWplwigaN4d08kIghA3cPFMWXbqq4Y+fVfhUdWE1yBj
 GMG3Ijv2IxGnkVDD3OXOCA1NF7C6j94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792504629;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UJMubidmylJDsxYCR+T7l/FmNAGpyGcMQR4ciJIBILA=;
 b=j4D+5XZCJ1nkznhnt46Mis5une9oXpJRRAlPIbUgCvtqdICOgR1VI4WaRtgsPGAGwpkH4Y
 v7pb5LCVxpaGZeDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792504629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UJMubidmylJDsxYCR+T7l/FmNAGpyGcMQR4ciJIBILA=;
 b=GxUlSXF83vf2MUr1jT68XemcZjCvquscRotCIKYLCA5L0PceaJayv0QglREDAgcAJ5i2G+
 mrIdEnRymdRJFJUOwRJlQ/Jym6NEWplwigaN4d08kIghA3cPFMWXbqq4Y+fVfhUdWE1yBj
 GMG3Ijv2IxGnkVDD3OXOCA1NF7C6j94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792504629;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UJMubidmylJDsxYCR+T7l/FmNAGpyGcMQR4ciJIBILA=;
 b=j4D+5XZCJ1nkznhnt46Mis5une9oXpJRRAlPIbUgCvtqdICOgR1VI4WaRtgsPGAGwpkH4Y
 v7pb5LCVxpaGZeDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A488136C6;
 Tue, 20 Oct 2026 13:57:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3OQ8LTRz12o+HQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 20 Oct 2026 13:57:08 +0000
Message-ID: <5415d7a6-3d63-47ce-ad25-98e9108b5cf3@suse.de>
Date: Tue, 20 Oct 2026 15:57:08 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 55/75] drm/atomic-state-helper: Rename
 connector_tv_margins_reset to state_init
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Ruben Wauters <rubenru09@aol.com>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-55-586c9c026823@kernel.org>
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
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-55-586c9c026823@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9];
 FREEMAIL_ENVRCPT(0.00)[aol.com,gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.freedesktop.org,igalia.com,raspberrypi.com,aol.com];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, imap1.dmz-prg2.suse.org:helo,
 suse.com:url]
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_PDS_OTHER_BAD_TLD,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Am 14.10.26 um 19:27 schrieb Maxime Ripard:
> Recent commits renamed other reset helpers to use the state_init
> suffix when they only initialize properties rather than allocate or
> update the object state itself.
>
> drm_atomic_helper_connector_tv_margins_reset() falls in the same
> category: it initializes the TV margin properties from the kernel
> command line without allocating any state. It also reads the
> connector state through connector->state, coupling it to the reset
> path.
>
> Rename it to drm_atomic_helper_connector_tv_margins_state_init() and
> pass the connector state explicitly as a parameter. This decouples
> it from the reset hook and prepares for the conversion to
> atomic_create_state where connector->state is not yet assigned.

Seems reasonable to me.

>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Please see my nitpicks below.

> ---
> Cc: "Maíra Canal" <mcanal@igalia.com>
> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> Cc: Ruben Wauters <rubenru09@aol.com>
> ---
>   drivers/gpu/drm/drm_atomic_state_helper.c | 14 ++++++++------
>   drivers/gpu/drm/gud/gud_connector.c       |  3 ++-
>   drivers/gpu/drm/vc4/vc4_hdmi.c            |  3 ++-
>   include/drm/drm_atomic_state_helper.h     |  3 ++-
>   4 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index 406157a3660f..6238066fd5d6 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -480,26 +480,27 @@ drm_atomic_helper_connector_create_state(struct drm_connector *connector)
>   	return state;
>   }
>   EXPORT_SYMBOL(drm_atomic_helper_connector_create_state);
>   
>   /**
> - * drm_atomic_helper_connector_tv_margins_reset - Resets TV connector properties
> + * drm_atomic_helper_connector_tv_margins_state_init - Initializes TV connector properties
> + * @state: the DRM State object

No capital S in state, please

>    * @connector: DRM connector
>    *
> - * Resets the TV-related properties attached to a connector.
> + * Initializes the TV-related properties attached to a connector.
>    */
> -void drm_atomic_helper_connector_tv_margins_reset(struct drm_connector *connector)
> +void drm_atomic_helper_connector_tv_margins_state_init(struct drm_connector_state *state,
> +						       struct drm_connector *connector)
>   {
>   	struct drm_cmdline_mode *cmdline = &connector->cmdline_mode;
> -	struct drm_connector_state *state = connector->state;
>   
>   	state->tv.margins.left = cmdline->tv_margins.left;
>   	state->tv.margins.right = cmdline->tv_margins.right;
>   	state->tv.margins.top = cmdline->tv_margins.top;
>   	state->tv.margins.bottom = cmdline->tv_margins.bottom;
>   }
> -EXPORT_SYMBOL(drm_atomic_helper_connector_tv_margins_reset);
> +EXPORT_SYMBOL(drm_atomic_helper_connector_tv_margins_state_init);
>   
>   /**
>    * drm_atomic_helper_connector_tv_reset - Resets Analog TV connector properties
>    * @connector: DRM connector
>    *
> @@ -568,11 +569,12 @@ void drm_atomic_helper_connector_tv_reset(struct drm_connector *connector)
>   	if (prop)
>   		if (!drm_object_property_get_default_value(&connector->base,
>   							   prop, &val))
>   			state->tv.hue = val;
>   
> -	drm_atomic_helper_connector_tv_margins_reset(connector);
> +	drm_atomic_helper_connector_tv_margins_state_init(connector->state,
> +							  connector);

Nit: coding style allows for 100 characters per line. Not line-breaking 
here and in a few places below is ok, I think.

Best regards
Thomas

>   }
>   EXPORT_SYMBOL(drm_atomic_helper_connector_tv_reset);
>   
>   /**
>    * drm_atomic_helper_connector_tv_check - Validate an analog TV connector state
> diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gud_connector.c
> index 8141c3a1e30a..a57f2565d33e 100644
> --- a/drivers/gpu/drm/gud/gud_connector.c
> +++ b/drivers/gpu/drm/gud/gud_connector.c
> @@ -352,11 +352,12 @@ static void gud_connector_reset(struct drm_connector *connector)
>   	struct gud_connector *gconn = to_gud_connector(connector);
>   
>   	drm_atomic_helper_connector_reset(connector);
>   	connector->state->tv = gconn->initial_tv_state;
>   	/* Set margins from command line */
> -	drm_atomic_helper_connector_tv_margins_reset(connector);
> +	drm_atomic_helper_connector_tv_margins_state_init(connector->state,
> +							  connector);
>   	if (gconn->initial_brightness >= 0)
>   		connector->state->tv.brightness = gconn->initial_brightness;
>   }
>   
>   static const struct drm_connector_funcs gud_connector_funcs = {
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 3a90dbb61f4e..cf84eff847d1 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -507,11 +507,12 @@ static int vc4_hdmi_connector_atomic_check(struct drm_connector *connector,
>   
>   static void vc4_hdmi_connector_reset(struct drm_connector *connector)
>   {
>   	drm_atomic_helper_connector_reset(connector);
>   	__drm_atomic_helper_connector_hdmi_state_init(connector, connector->state);
> -	drm_atomic_helper_connector_tv_margins_reset(connector);
> +	drm_atomic_helper_connector_tv_margins_state_init(connector->state,
> +							  connector);
>   }
>   
>   static const struct drm_connector_funcs vc4_hdmi_connector_funcs = {
>   	.debugfs_init = drm_hdmi_connector_debugfs_init,
>   	.force = drm_atomic_helper_connector_hdmi_force,
> diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
> index 4706eeab52c1..4dac741af22c 100644
> --- a/include/drm/drm_atomic_state_helper.h
> +++ b/include/drm/drm_atomic_state_helper.h
> @@ -72,11 +72,12 @@ void drm_atomic_helper_connector_reset(struct drm_connector *connector);
>   struct drm_connector_state *
>   drm_atomic_helper_connector_create_state(struct drm_connector *connector);
>   void drm_atomic_helper_connector_tv_reset(struct drm_connector *connector);
>   int drm_atomic_helper_connector_tv_check(struct drm_connector *connector,
>   					 struct drm_atomic_commit *state);
> -void drm_atomic_helper_connector_tv_margins_reset(struct drm_connector *connector);
> +void drm_atomic_helper_connector_tv_margins_state_init(struct drm_connector_state *state,
> +						       struct drm_connector *connector);
>   void
>   __drm_atomic_helper_connector_duplicate_state(struct drm_connector *connector,
>   					   struct drm_connector_state *state);
>   struct drm_connector_state *
>   drm_atomic_helper_connector_duplicate_state(struct drm_connector *connector);
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


