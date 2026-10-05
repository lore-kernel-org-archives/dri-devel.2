Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C07CA5FFF
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4059E10E75B;
	Mon,  5 Oct 2026 09:08:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Dv4VhUkp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ss+09w9S";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zs1ECutM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8tpnkVhS";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF73410E44C;
 Mon,  5 Oct 2026 09:08:32 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E71B121E85;
 Mon,  5 Oct 2026 09:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791191307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=98F7Rn252eb4cpJvwGOAfOsgXP/KQ/FjyO2QNIyVecI=;
 b=Dv4VhUkpdbh70qcdEMhqz8DR7r4Bn7EatApwefCOIC/FayX2XsUjm4it1KhOvHCZZqCdEp
 CKDhf7qJWLqzJImSC/sz7qdusuos98sTE4YqPf10qINSD7Ld6GxJCub3Dk9dmxiNJGRj3l
 zllrQC2PceioFfU9H13z/LNhHdGEvG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791191307;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=98F7Rn252eb4cpJvwGOAfOsgXP/KQ/FjyO2QNIyVecI=;
 b=ss+09w9SgD5DVFBuqNWFeJZhYM33pckhekOFh+uJbjAm7LxZTXRvbRHrkZf4Z2hqxJhYkY
 ukqjy4DBy35RagBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791191302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=98F7Rn252eb4cpJvwGOAfOsgXP/KQ/FjyO2QNIyVecI=;
 b=Zs1ECutMZ4QGeuhh7l2ftvQKabH6cRH3oXt4AsE28tCY+DEgLuO8NUsq5dIa5BANSlpvpA
 713mHqgO8GWr/CoLHoCeWq/F5bkTqonVJkNG9jwo0yRwxfPFrhd8Ye+/niGoGgMNpRNG/p
 EJG1mpP+J/lhymgHmTBcYOvtns3y2xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791191302;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=98F7Rn252eb4cpJvwGOAfOsgXP/KQ/FjyO2QNIyVecI=;
 b=8tpnkVhS52cJHamzdwUWZQOIQ2+rxgBfGJWAKjPpahmrnjWNuWkrGYkifhsX+7cEpOMN5b
 IjzhpWpg7nE0mDAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5933213A1B;
 Mon,  5 Oct 2026 09:08:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tZ/JBgVpw2rMTgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 05 Oct 2026 09:08:21 +0000
Message-ID: <e9be1ef8-9884-4117-9eed-ba179248ffc6@suse.de>
Date: Mon, 5 Oct 2026 11:08:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/7] drm: Define user readable error codes for atomic
 ioctl
To: Arun R Murthy <arun.r.murthy@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, xaver.hugl@kde.org,
 harry.wentland@amd.com, uma.shankar@intel.com, louis.chauvet@bootlin.com,
 naveen1.kumar@intel.com, ramya.krishna.yella@intel.com
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, Suraj Kandpal <suraj.kandpal@intel.com>
References: <20260331-atomic-v11-0-6a1df7ec5af8@intel.com>
 <20260331-atomic-v11-1-6a1df7ec5af8@intel.com>
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
In-Reply-To: <20260331-atomic-v11-1-6a1df7ec5af8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[intel.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,ursulin.net,kde.org,amd.com,bootlin.com];
 RCPT_COUNT_TWELVE(0.00)[19]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, intel.com:email, bootlin.com:url,
 suse.de:mid, imap1.dmz-prg2.suse.org:helo]
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

Hi,

I just watched the recording of your presentation at XDC2026 and had a 
thoughts on it. Comments are below

Am 31.03.26 um 11:03 schrieb Arun R Murthy:
> There can be multiple reasons for a failure in atomic_ioctl. Most often
> in these error conditions -EINVAL is returned. User/Compositor would
> have to blindly take a call on failure of this ioctl so as to use
> ALLOW_MODESET or retry. It would be good if user/compositor gets a
> readable error code on failure so they can take proper corrections in
> the next commit.
> The struct drm_mode_atomic is being passed by the user/compositor which
> holds the properties for modeset/flip. Reusing the same struct for
> returning the error code in case of failure, thereby creation of new
> uapi/interface for returning the error code is not required.
> The element 'reserved' in the struct drm_mode_atomic is used for
> returning the user readable error code. This points to the struct
> drm_mode_atomic_err_code. Failure reasons as a string can also be added
> on need basis by the variable failure_string in the same struct
> drm_mode_atomic_err_code.
>
> v3: Remove fixed error (Jani/Xaver)
> v5: Fix kernel-doc (Jani)
> v7: Rephrase the kernel doc description (Suraj)
> v8: Removed the below enum and suggest to use INVALID_API_USAGE (Xaver)
> 	DRM_MODE_ATOMIC_ASYNC_NOT_SUPP_PLANE
> 	DRM_MODE_ATOMIC_ASYNC_MODIFIER_NOT_SUPP
> v10: Added more error codes for the enum
> v11: Add default/unspecified error code
>
> Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
> Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
> ---
>   include/uapi/drm/drm_mode.h | 56 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)
>
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index a4bdc4bd11bc142e9d3b172397e18a1909a21488..8bf5fd8533912dc7a188aad19cc3741dd2099592 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -48,6 +48,7 @@ extern "C" {
>   #define DRM_CONNECTOR_NAME_LEN	32
>   #define DRM_DISPLAY_MODE_LEN	32
>   #define DRM_PROP_NAME_LEN	32
> +#define DRM_MODE_ATOMIC_FAILURE_STRING_LEN	128
>   
>   #define DRM_MODE_TYPE_BUILTIN	(1<<0) /* deprecated */
>   #define DRM_MODE_TYPE_CLOCK_C	((1<<1) | DRM_MODE_TYPE_BUILTIN) /* deprecated */
> @@ -1346,6 +1347,61 @@ struct drm_mode_destroy_dumb {
>   		DRM_MODE_ATOMIC_NONBLOCK |\
>   		DRM_MODE_ATOMIC_ALLOW_MODESET)
>   
> +/**
> + * enum drm_mode_atomic_failure_codes -  error codes for failures in atomic_ioctl

I have serious doubts about these failure codes. The core issue to me is 
that when the kernel driver detects an impossible commit, it probably 
knows best how to fix it. Yet the failure codes often lack actionable 
meaning. Examples below

> + * @DRM_MODE_ATOMIC_UNSPECIFIED_ERROR: this is the default/unspecified error.

This one does not give a hint to what happens. Should userspace abort or 
fall back to TEST_ONLY?

> + * @DRM_MODE_ATOMIC_INVALID_API_USAGE: invallid API usage(DRM_ATOMIC not
> + *				       enabled, invalid falg, page_flip event
> + *				       with test-only, etc)

I've seen this being used in the i915 patch for a async flip.  Could 
mean anything there (format, driver specifics).

> + * @DRM_MODE_ATOMIC_NEED_FULL_MODESET: Need full modeset on all connected crtc's

This one is helpful because it gives user space an actionable hint.

> + * @DRM_MODE_ATOMIC_ASYNC_PROP_CHANGED: Property changed in async flip
> + * @DRM_MODE_ATOMIC_SCANOUT_BW: For a given resolution, refresh rate and the
> + *                              color depth cannot be accomodated. Resolution
> + *                              is to lower the refresh rate or color depth.
> + * @DRM_MODE_ATOMIC_CONNECTOR_BW: Refers to the limitation on the link rate on
> + *                                a given connector.
> + * @DRM_MODE_ATOMIC_PIPE_BW: Limitation on the pipe, either pipe not available
> + *                           or the pipe scaling factor limitation.
> + * @DRM_MODE_ATOMIC_MEMORY_DOMAIN: Any other memory/bandwidth related limitation
> + *                                 other then the ones specified above.
> + * @DRM_MODE_ATOMIC_SPEC_VIOLOATION: Limitation of a particular feature on that
> + *                                   hardware. To get to know the feature, the
> + *                                   property/object causing this is being sent
> + *                                   back to user @failure_objs_ptr in the
> + *                                   struct drm_mode_atomic_err_code

There codes don't seem actionable to me.

What I'm proposing is a set if hints (instead of failure) that give user 
space a clear instruction on what to try next.

I assume you're familiar with the mode-status codes? [1] They do this to 
some extend.

[1] 
https://elixir.bootlin.com/linux/v7.2.8/source/include/drm/drm_modes.h#L91

> + */
> +enum drm_mode_atomic_failure_codes {
> +	DRM_MODE_ATOMIC_UNSPECIFIED_ERROR,
> +	DRM_MODE_ATOMIC_INVALID_API_USAGE,
> +	DRM_MODE_ATOMIC_NEED_FULL_MODESET,
> +	DRM_MODE_ATOMIC_ASYNC_PROP_CHANGED,
> +	DRM_MODE_ATOMIC_SCANOUT_BW,
> +	DRM_MODE_ATTOMIC_CONNECTOR_BW,
> +	DRM_MODE_ATTOMIC_PIPE_BW,
> +	DRM_MODE_ATOMIC_MEMORY_DOMAIN,
> +	DRM_MODE_ATOMIC_SPEC_VIOLOATION,
> +};
> +
> +/**
> + * struct drm_mode_atomic_err_code - struct to store the error code
> + *
> + * pointer to this struct will be stored in reserved variable of
> + * struct drm_mode_atomic to report the failure cause to the user.
> + *
> + * @failure_code: error codes defined in enum drm_moide_atomic_failure_code
> + * @failure_objs_ptr: pointer to the drm_object that caused error
> + * @reserved: reserved for future use
> + * @count_objs: count of drm_objects if multiple drm_objects caused error
> + * @failure_string: user readable error message string
> + */
> +struct drm_mode_atomic_err_code {
> +	__u64 failure_code;
> +	__u64 failure_objs_ptr;
> +	__u64 reserved;
> +	__u32 count_objs;
> +	char failure_string[DRM_MODE_ATOMIC_FAILURE_STRING_LEN];

I'd don't think we should return error strings from the kernel. If we 
do, these strings will become uAPI. And I guarantee that someone will 
start parsing them for information. We'll be in a situation where we 
cannot ever change the strings.

For error logging, we can put messages directly in the kernel log or you 
can build them in user space from within libdrm.

Best regards
Thomas


> +};
> +
>   struct drm_mode_atomic {
>   	__u32 flags;
>   	__u32 count_objs;
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


