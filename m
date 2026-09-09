Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FA2C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C34F810EF7B;
	Wed,  9 Sep 2026 07:11:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="vNs+D0Pg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RWGZAnFM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hEGDkRml";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0W9jX+aB";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE6D610EF7B
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 07:11:41 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CF943219DA;
 Wed,  9 Sep 2026 07:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788937896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aUI4+zj2EvS7gfICS4d+xSlhGhCbEQduwf6oUT/4Mvw=;
 b=vNs+D0PgQQ7bcIZg4GmY1h2B21xvsg0Mp7IaVzFBtdGSPCvP2dPzoOVb7J43DoYWuKp7vH
 Gdai9vJBpdlu58OP22Vw+8kW5hYomboi2uurVCQCC8Ji/CtgY+Mvk0VZQNWlLl2VMxdvG6
 FhyvTUKp2b0FVD7B9cd5/JOkR6XB7zw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788937896;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aUI4+zj2EvS7gfICS4d+xSlhGhCbEQduwf6oUT/4Mvw=;
 b=RWGZAnFMmHCLsiHaMgzbkJcvriqHe1gPd8UWdoJUFHBaiLWs/0XCVjKPp53+ZXn/FpsYNK
 4Mpsk0FAbI7IkpCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hEGDkRml;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0W9jX+aB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788937891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aUI4+zj2EvS7gfICS4d+xSlhGhCbEQduwf6oUT/4Mvw=;
 b=hEGDkRmlYbS7p/eXvaVURNRZSi6jHir1dsVL5rMgyRbNGL39sCQ8FWVzu7SWa60m306gET
 9o7Jv9aQ7rL9+d7g12ONNfIKAIWBwxJcquH7bhaiX9pJIoV+2nvHl6O2YiO46iUzts1N6J
 GEx59gpBIs5oLeyR8Co9ikcWK20/56o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788937891;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aUI4+zj2EvS7gfICS4d+xSlhGhCbEQduwf6oUT/4Mvw=;
 b=0W9jX+aBJwb/Ra3Pyr7LXpACfLWa5084QRQ0fgG25P3rvClw/eT7PWsvZKDajf8CKZ85oD
 weSH8oFFXzPfKhAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D5531347F;
 Wed,  9 Sep 2026 07:11:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SuGCBKMGoWqcZwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 09 Sep 2026 07:11:31 +0000
Message-ID: <559028c6-7707-4d4c-a879-6487e0b5e3c5@suse.de>
Date: Wed, 9 Sep 2026 09:11:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] drm/atomic: Allow filling a commit with pristine
 object states
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
 <20260908-drm-reset-state-flag-v3-8-905570f387a4@kernel.org>
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
In-Reply-To: <20260908-drm-reset-state-flag-v3-8-905570f387a4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CF943219DA
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
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



Am 08.09.26 um 16:35 schrieb Maxime Ripard:
> The upcoming DRM_MODE_ATOMIC_RESET flag will need to create an atomic
> commit that brings the entire device back to a pristine state, as if
> no configuration had ever been applied.
>
> Create drm_atomic_commit_fill_with_defaults() which iterates over all
> CRTCs, planes, connectors, and color operations in the device and
> inserts a fresh default state for each one into the commit. This uses
> the atomic_create_state() hooks rather than atomic_duplicate_state(),
> since atomic_create_state() provides exactly this pristine state on a
> per-object basis.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/drm_atomic.c | 123 +++++++++++++++++++++++++++++++++++++++++++
>   drivers/gpu/drm/drm_ioctl.c  |   1 +
>   include/drm/drm_atomic.h     |   1 +
>   3 files changed, 125 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 508a027398af..4c15757308d6 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -1661,10 +1661,133 @@ bool drm_atomic_can_create_state(struct drm_device *dev)
>   
>   	return true;
>   }
>   EXPORT_SYMBOL(drm_atomic_can_create_state);
>   
> +/**
> + * drm_atomic_commit_fill_with_defaults - populate a commit with pristine states
> + * @commit: atomic commit to fill
> + *
> + * Iterate over all CRTCs, planes, connectors, and color operations in
> + * the device and insert a freshly created default state for each one
> + * into @commit. The states are created through the atomic_create_state()
> + * hooks, producing the same initial state the driver starts with rather
> + * than a copy of the current hardware state.
> + *
> + * This is meant to be used with the %DRM_MODE_ATOMIC_RESET flag, which
> + * needs to bring the device back to a known baseline before applying
> + * userspace property changes on top.
> + *
> + * Returns:
> + * 0 on success, or a negative error code on failure.
> + */
> +int drm_atomic_commit_fill_with_defaults(struct drm_atomic_commit *commit)
> +{
> +	struct drm_device *dev = commit->dev;
> +	struct drm_mode_config *config = &dev->mode_config;
> +	struct drm_crtc *crtc;
> +	struct drm_plane *plane;
> +	struct drm_connector *connector;
> +	struct drm_connector_list_iter conn_iter;
> +	struct drm_colorop *colorop;
> +	int ret;
> +
> +	WARN_ON(!commit->acquire_ctx);

drm_WARN_ON

> +
> +	if (!drm_atomic_can_create_state(dev))
> +		return -EOPNOTSUPP;

I'd push this test into the caller and maybe do a 
drm_WARN_ON(!_can_create_state) here.   I think that this helper 
shouldn't even be called if there's no reset support.

Best regards
Thomas


> +
> +	/*
> +	 * Private objects are ignored because none have userspace
> +	 * properties we might want to reset. atomic_check
> +	 * implementations will derive or infer their private obj state
> +	 * from the state that will end up being committed anyway.
> +	 */
> +	drm_for_each_colorop(colorop, dev) {
> +		struct drm_colorop_state *colorop_state;
> +
> +		ret = drm_modeset_lock(&colorop->plane->mutex, commit->acquire_ctx);
> +		if (ret)
> +			return ret;
> +
> +		colorop_state = drm_atomic_helper_colorop_create_state(colorop);
> +		if (IS_ERR(colorop_state))
> +			return PTR_ERR(colorop_state);
> +
> +		ret = drm_atomic_commit_set_colorop_state(commit, colorop, colorop_state);
> +		if (ret) {
> +			drm_colorop_atomic_destroy_state(colorop, colorop_state);
> +			return ret;
> +		}
> +	}
> +
> +	drm_for_each_plane(plane, dev) {
> +		struct drm_plane_state *plane_state;
> +
> +		ret = drm_modeset_lock(&plane->mutex, commit->acquire_ctx);
> +		if (ret)
> +			return ret;
> +
> +		plane_state = plane->funcs->atomic_create_state(plane);
> +		if (IS_ERR(plane_state))
> +			return PTR_ERR(plane_state);
> +
> +		ret = drm_atomic_commit_set_plane_state(commit, plane, plane_state);
> +		if (ret) {
> +			plane->funcs->atomic_destroy_state(plane, plane_state);
> +			return ret;
> +		}
> +	}
> +
> +	drm_for_each_crtc(crtc, dev) {
> +		struct drm_crtc_state *crtc_state;
> +
> +		ret = drm_modeset_lock(&crtc->mutex, commit->acquire_ctx);
> +		if (ret)
> +			return ret;
> +
> +		crtc_state = crtc->funcs->atomic_create_state(crtc);
> +		if (IS_ERR(crtc_state))
> +			return PTR_ERR(crtc_state);
> +
> +		ret = drm_atomic_commit_set_crtc_state(commit, crtc, crtc_state);
> +		if (ret) {
> +			crtc->funcs->atomic_destroy_state(crtc, crtc_state);
> +			return ret;
> +		}
> +	}
> +
> +	drm_connector_list_iter_begin(dev, &conn_iter);
> +	drm_for_each_connector_iter(connector, &conn_iter) {
> +		struct drm_connector_state *connector_state;
> +
> +		ret = drm_modeset_lock(&config->connection_mutex, commit->acquire_ctx);
> +		if (ret) {
> +			drm_connector_list_iter_end(&conn_iter);
> +			return ret;
> +		}
> +
> +		connector_state = connector->funcs->atomic_create_state(connector);
> +		if (IS_ERR(connector_state)) {
> +			drm_connector_list_iter_end(&conn_iter);
> +			ret = PTR_ERR(connector_state);
> +			return ret;
> +		}
> +
> +		ret = drm_atomic_commit_set_connector_state(commit, connector, connector_state);
> +		if (ret) {
> +			connector->funcs->atomic_destroy_state(connector, connector_state);
> +			drm_connector_list_iter_end(&conn_iter);
> +			return ret;
> +		}
> +	}
> +	drm_connector_list_iter_end(&conn_iter);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_atomic_commit_fill_with_defaults);
> +
>   /**
>    * drm_atomic_add_encoder_bridges - add bridges attached to an encoder
>    * @state: atomic state
>    * @encoder: DRM encoder
>    *
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index 9039a39c4324..0dbf04d4aa9e 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -31,10 +31,11 @@
>   #include <linux/export.h>
>   #include <linux/nospec.h>
>   #include <linux/pci.h>
>   #include <linux/uaccess.h>
>   
> +#include <drm/drm_atomic.h>
>   #include <drm/drm_auth.h>
>   #include <drm/drm_crtc.h>
>   #include <drm/drm_drv.h>
>   #include <drm/drm_file.h>
>   #include <drm/drm_ioctl.h>
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index 7dc26e3da65c..b60f67619bfa 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -701,10 +701,11 @@ int drm_crtc_commit_wait(struct drm_crtc_commit *commit);
>   struct drm_atomic_commit * __must_check
>   drm_atomic_commit_alloc(struct drm_device *dev);
>   void drm_atomic_commit_clear(struct drm_atomic_commit *state);
>   
>   bool drm_atomic_can_create_state(struct drm_device *dev);
> +int drm_atomic_commit_fill_with_defaults(struct drm_atomic_commit *commit);
>   
>   /**
>    * drm_atomic_commit_get - acquire a reference to the atomic state
>    * @state: The atomic state
>    *
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


