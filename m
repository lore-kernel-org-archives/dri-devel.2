Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815DAC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:13:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD6C110EF7C;
	Wed,  9 Sep 2026 07:13:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="XMaBlZ4h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KpfGXUGd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="05ckgCl+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zpddfNJO";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C53B610EF7C
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 07:13:23 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 390A421A00;
 Wed,  9 Sep 2026 07:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788937998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=x8uJilnmUy/XFJpskMKu+wg6506AQybsjIRC3u9gKjo=;
 b=XMaBlZ4hEgmjR8qzjG44u3Hg/LNqM8IHKlGN3Ps7N/DBEfUktsQZ+BUQYudn/GO1YZdTmB
 NLvO5uRdvLTSpnSBQjozi48TnIwJqqvT4uWxYR/Yso4ASEN5aB/LHG2KF84mj/JfncHk5v
 QtParL/YZcpbM06GTzcTEX0bzzx98B8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788937998;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=x8uJilnmUy/XFJpskMKu+wg6506AQybsjIRC3u9gKjo=;
 b=KpfGXUGdGG0At9dTIdNsBR/7ml8aBmRkMDEuWt0GFBW6N8acwSTiAj9W4I9ON+lW66l630
 8eoONkT508iFQgAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=05ckgCl+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zpddfNJO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788937994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=x8uJilnmUy/XFJpskMKu+wg6506AQybsjIRC3u9gKjo=;
 b=05ckgCl+0K3so2HMDtnVw1QUC3cABleSa96TE/3mq+lletkh7f7J+81xJiXIlucpdl+iHH
 CEl3NnIpuQaQ9U8U6Rzqb3k9fDOUdtXek8IX143YRwlL9tEDqd4d3VUQZi0pqujMh2a/2w
 hD/d8R38c+5JucSfps8NOnMVbLf1fzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788937994;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=x8uJilnmUy/XFJpskMKu+wg6506AQybsjIRC3u9gKjo=;
 b=zpddfNJOyMAg4BJqZF9W/EAOXLT03sdD09zkEpHfxm2BZvgWPkX6RwE/wyoVXizjd4usWl
 UPuIxs5hVF0b2eDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B92C41347F;
 Wed,  9 Sep 2026 07:13:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AvcILAkHoWpwaQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 09 Sep 2026 07:13:13 +0000
Message-ID: <70b689d2-5876-4bb6-a784-3c0bff2e4b4e@suse.de>
Date: Wed, 9 Sep 2026 09:13:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/11] drm/atomic-uapi: Add DRM_MODE_ATOMIC_RESET flag
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
 <20260908-drm-reset-state-flag-v3-9-905570f387a4@kernel.org>
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
In-Reply-To: <20260908-drm-reset-state-flag-v3-9-905570f387a4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 390A421A00
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[16];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
> From: Sebastian Wick <sebastian.wick@redhat.com>
>
> Userspace currently has no atomic way to reset all KMS object states
> to their defaults. To bring a display pipeline to a known state, a
> compositor must explicitly set every property on every object, which
> requires tracking which properties exist and what their defaults are.
>
> Introduce DRM_MODE_ATOMIC_RESET (0x0800) which, when passed to the
> atomic ioctl, fills the commit with default states for all KMS
> objects before applying the properties supplied in the request.
> Properties not explicitly included in the commit remain at their
> defaults (CRTCs inactive, planes disabled, connectors unbound, and
> so on).
>
> The flag cannot be combined with DRM_MODE_PAGE_FLIP_ASYNC, since a
> full state reset is incompatible with an async flip.
>
> Signed-off-by: Sebastian Wick <sebastian.wick@redhat.com>
> Co-developed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>


> ---
>   drivers/gpu/drm/drm_atomic.c      |  3 +++
>   drivers/gpu/drm/drm_atomic_uapi.c | 13 +++++++++++++
>   drivers/gpu/drm/drm_ioctl.c       |  3 +++
>   include/uapi/drm/drm.h            | 10 ++++++++++
>   include/uapi/drm/drm_mode.h       | 14 +++++++++++++-
>   5 files changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 4c15757308d6..d5b3a7d99239 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -1625,10 +1625,13 @@ EXPORT_SYMBOL(drm_atomic_get_new_bridge_state);
>    * the current state.
>    *
>    * Color operations are not checked because they always use
>    * drm_atomic_helper_colorop_create_state() and do not have a per-driver hook.
>    *
> + * This is used to report the %DRM_CAP_ATOMIC_RESET capability to userspace,
> + * and as a precondition in drm_atomic_commit_fill_with_defaults().
> + *
>    * Returns:
>    * True if all objects implement atomic_create_state, false otherwise.
>    */
>   bool drm_atomic_can_create_state(struct drm_device *dev)
>   {
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index d52504d823bc..fe794a65a727 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -1665,10 +1665,17 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>   		drm_dbg_atomic(dev,
>   			       "commit failed: page-flip event requested with test-only commit\n");
>   		return -EINVAL;
>   	}
>   
> +	if ((arg->flags & DRM_MODE_ATOMIC_RESET) &&
> +			(arg->flags & DRM_MODE_PAGE_FLIP_ASYNC)) {
> +		drm_dbg_atomic(dev,
> +			       "commit failed: reset cannot be combined with async flip\n");
> +		return -EINVAL;
> +	}
> +
>   	state = drm_atomic_commit_alloc(dev);
>   	if (!state)
>   		return -ENOMEM;
>   
>   	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
> @@ -1680,10 +1687,16 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>   	copied_objs = 0;
>   	copied_props = 0;
>   	fence_state = NULL;
>   	num_fences = 0;
>   
> +	if (arg->flags & DRM_MODE_ATOMIC_RESET) {
> +		ret = drm_atomic_commit_fill_with_defaults(state);
> +		if (ret)
> +			goto out;
> +	}
> +
>   	for (i = 0; i < arg->count_objs; i++) {
>   		uint32_t obj_id, count_props;
>   		struct drm_mode_object *obj;
>   
>   		if (get_user(obj_id, objs_ptr + copied_objs)) {
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index 0dbf04d4aa9e..f13bb7c490c4 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -303,10 +303,13 @@ static int drm_getcap(struct drm_device *dev, void *data, struct drm_file *file_
>   		break;
>   	case DRM_CAP_ATOMIC_ASYNC_PAGE_FLIP:
>   		req->value = drm_core_check_feature(dev, DRIVER_ATOMIC) &&
>   			     dev->mode_config.async_page_flip;
>   		break;
> +	case DRM_CAP_ATOMIC_RESET:
> +		req->value = drm_atomic_can_create_state(dev);
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
>   	return 0;
>   }
> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> index bc7ef7684099..b6e2f2edd122 100644
> --- a/include/uapi/drm/drm.h
> +++ b/include/uapi/drm/drm.h
> @@ -793,10 +793,20 @@ struct drm_gem_change_handle {
>    * If set to 1, the driver supports &DRM_MODE_PAGE_FLIP_ASYNC for atomic
>    * commits.
>    */
>   #define DRM_CAP_ATOMIC_ASYNC_PAGE_FLIP	0x15
>   
> +/**
> + * DRM_CAP_ATOMIC_RESET
> + *
> + * If set to 1, the driver supports the &DRM_MODE_ATOMIC_RESET flag in
> + * &DRM_IOCTL_MODE_ATOMIC commits. When supported, userspace can pass that
> + * flag to reset all KMS object states to their defaults before applying
> + * property changes.
> + */
> +#define DRM_CAP_ATOMIC_RESET	0x16
> +
>   /* DRM_IOCTL_GET_CAP ioctl argument type */
>   struct drm_get_cap {
>   	__u64 capability;
>   	__u64 value;
>   };
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index ed1a660a3dfd..32eb3f650d7a 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -1326,10 +1326,21 @@ struct drm_mode_destroy_dumb {
>    * To the best of the driver's knowledge, visual artifacts are guaranteed to
>    * not appear when this flag is not set. Some sinks might display visual
>    * artifacts outside of the driver's control.
>    */
>   #define DRM_MODE_ATOMIC_ALLOW_MODESET 0x0400
> +/**
> + * DRM_MODE_ATOMIC_RESET
> + *
> + * Reset all KMS object states (CRTCs, planes, connectors, color operations)
> + * to their default values before applying the properties in this commit.
> + * Properties not explicitly included in the commit will remain at their
> + * defaults (CRTCs inactive, planes disabled, connectors unbound, etc.).
> + *
> + * This flag cannot be combined with &DRM_MODE_PAGE_FLIP_ASYNC.
> + */
> +#define DRM_MODE_ATOMIC_RESET 0x0800
>   
>   /**
>    * DRM_MODE_ATOMIC_FLAGS
>    *
>    * Bitfield of flags accepted by the &DRM_IOCTL_MODE_ATOMIC IOCTL in
> @@ -1338,11 +1349,12 @@ struct drm_mode_destroy_dumb {
>   #define DRM_MODE_ATOMIC_FLAGS (\
>   		DRM_MODE_PAGE_FLIP_EVENT |\
>   		DRM_MODE_PAGE_FLIP_ASYNC |\
>   		DRM_MODE_ATOMIC_TEST_ONLY |\
>   		DRM_MODE_ATOMIC_NONBLOCK |\
> -		DRM_MODE_ATOMIC_ALLOW_MODESET)
> +		DRM_MODE_ATOMIC_ALLOW_MODESET |\
> +		DRM_MODE_ATOMIC_RESET)
>   
>   struct drm_mode_atomic {
>   	__u32 flags;
>   	__u32 count_objs;
>   	__u64 objs_ptr;
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


