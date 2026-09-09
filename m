Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B65C79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7A5310E131;
	Wed,  9 Sep 2026 07:24:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="I4CWrIRE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fKyoB3Tq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J60PjoxO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cSvBQJlx";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5574410E131
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 07:24:52 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 849D821A5F;
 Wed,  9 Sep 2026 07:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788938686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Yl5e06UoiWWNjbj02pNlCdQxULBNGgKJHIdWoNlcIds=;
 b=I4CWrIREfLJCtEwTXlCpOdYudenaa7pfaVt+Suvua2X3r15aGrasdQOrYjdnQTEwnI4lCl
 fCwtSazSbLqYA3otofiUJAASY0+mQO9UvJ/1bn8LrGjWzIPMl+RXT6cbiPEEI7j3TxiJM0
 DgchngiocwflTtVIT5qEOHVdv4x51ZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788938686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Yl5e06UoiWWNjbj02pNlCdQxULBNGgKJHIdWoNlcIds=;
 b=fKyoB3Tqt0RUKa4GnNr1hX4a0Z7NWtRxOGZeKNMHWxTcna1mpOqvbtoJglTa8U5LYexWbH
 epGqCU5g1RtluEBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=J60PjoxO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cSvBQJlx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788938682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Yl5e06UoiWWNjbj02pNlCdQxULBNGgKJHIdWoNlcIds=;
 b=J60PjoxO1a4bNZcSm4KSwhI/xUHvW4SrS0WShninEMfBe/+bg53KJWdhc6CO4Cb8x6tfz5
 +EYsdpN2ZX9dBpWX311Z/iHKhlVb62U371qX3p1L0hwa5ucn5RAFeNQnUvOdaNbk+jCewh
 rwU8ZBTqsBBLuLwAhXDIiWXzWIDQWLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788938682;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Yl5e06UoiWWNjbj02pNlCdQxULBNGgKJHIdWoNlcIds=;
 b=cSvBQJlxd1p35vC+AYKgNbnlDTHqTzDvzTnFopPEdLLXXbQvfcF+lsmbHENOLfVHggRNeC
 uWAJ7Oo+trjV9bAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 047C81347F;
 Wed,  9 Sep 2026 07:24:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jcVqO7kJoWpUdAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 09 Sep 2026 07:24:41 +0000
Message-ID: <3c77a62c-13e2-44bd-a7e8-c2ea29dcf352@suse.de>
Date: Wed, 9 Sep 2026 09:24:41 +0200
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
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 849D821A5F
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.com:url];
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
[...]
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

Looking at this and the other places where _can_create_state is being 
used, I'd like to present a different design.

Scratch the helper entirely and introduce a dedicated callback in 
drm_mode_config_funcs that sets up the default state.  Your current 
helper drm_atomic_commit_fill_with_defaults would be the common 
implementation. The DRM core could test for the existence of this 
callback to see if default-reset is available. Sure, we'd have to modify 
all drivers, but it would be architecturally cleaner IMHO and give full 
control to the drivers. Best regards Thomas
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


