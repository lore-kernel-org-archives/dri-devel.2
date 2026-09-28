Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910CCCA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:37:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA5E110E93D;
	Mon, 28 Sep 2026 16:37:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Xbzczbtl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oKjJnJY8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SrQQnyQ1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kYzGZZvA";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB77310E93D;
 Mon, 28 Sep 2026 16:37:48 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F13A321EA4;
 Mon, 28 Sep 2026 16:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790613463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S4iM9XLY2XGuoN/j+o6k8TksS6rQOnfmLzJbJ+cpdeg=;
 b=XbzczbtlT5vzgK/4vkGL4xsymZu5tID4sSlWw8PwUUgbWuUbxP/wJHmXf0o5gF2ytbMlfL
 DTdqyG/3Hu3ObzGeaH1qpj1Kcb0+VqVQG7YHE1QxQOQJUnSv2mw6Tghi/tgiNtBVs9qBr3
 1MvZ3rt1nZPP92E5WFchnYJPPSAoUUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790613463;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S4iM9XLY2XGuoN/j+o6k8TksS6rQOnfmLzJbJ+cpdeg=;
 b=oKjJnJY8qSyL6LbYPFJ+jYOWoQMzQ0Dy7RthDSMXmU1vIUVWH/o7qgEmgPKuxH+4z+i39m
 BuC1xjlJ1VIB42CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790613459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S4iM9XLY2XGuoN/j+o6k8TksS6rQOnfmLzJbJ+cpdeg=;
 b=SrQQnyQ1MrIbwuaWtadyM83MaaT3mK9v6RTBZYRkyPXJ41FNj+I9QRnAqa44+SNmG337La
 /oNwg5i0BHnG27OVaVedbJ1kGmBvtSPTYvGF/tO3gWmknh44huj7G8q20tA1lkLxO6G68v
 7Qx86TE+r89IEMUuoKaByitGGn6pXzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790613459;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S4iM9XLY2XGuoN/j+o6k8TksS6rQOnfmLzJbJ+cpdeg=;
 b=kYzGZZvA9WL8QDcL0pRd8EJRO54HcPeMKBRsDtI2BSXXYHso27AHMRT/kmKefHGjA0j2yU
 mfBuvHjfargdjFDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58849133F1;
 Mon, 28 Sep 2026 16:37:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tVPkCtKXumr+BQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 28 Sep 2026 16:37:38 +0000
Message-ID: <7a19a212-194a-4d5b-b0a0-6d2bee24f636@suse.de>
Date: Mon, 28 Sep 2026 18:37:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] drm: Add drm_timeout_rel_to_jiffies()
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
References: <20260915-drm-timeout-helpers-v3-0-f2ae987d861f@igalia.com>
 <20260915-drm-timeout-helpers-v3-2-f2ae987d861f@igalia.com>
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
In-Reply-To: <20260915-drm-timeout-helpers-v3-2-f2ae987d861f@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[19];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[igalia.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,amd.com,intel.com,raspberrypi.com];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.com:url,igalia.com:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, igalia.com:email, suse.de:mid,
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

Hi

Am 15.09.26 um 21:42 schrieb Maíra Canal:
> drm_timeout_abs_to_jiffies() covers the drivers whose wait UAPI takes an
> absolute deadline, but there is no equivalent for the drivers that
> express a wait as a duration. Drivers such as i915 and v3d convert the
> value themselves.
>
> Converting a nanosecond duration to jiffies needs some care.
> nsecs_to_jiffies() returns unsigned long, so on 32-bit a large
> userspace-supplied timeout overflows its range and is silently truncated.
>
> i915 already handles both cases in a local helper, which v3d has a copy
> of. Add the same conversion to the core, so that it is available to any
> driver and both copies can be dropped.
>
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/drm_timeout.c | 45 +++++++++++++++++++++++++++++++++++++++++++
>   include/drm/drm_timeout.h     |  1 +
>   2 files changed, 46 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_timeout.c b/drivers/gpu/drm/drm_timeout.c
> index 35e10293e0a1..ee545475429c 100644
> --- a/drivers/gpu/drm/drm_timeout.c
> +++ b/drivers/gpu/drm/drm_timeout.c
> @@ -9,6 +9,7 @@
>   #include <linux/export.h>
>   #include <linux/jiffies.h>
>   #include <linux/ktime.h>
> +#include <linux/math64.h>
>   #include <linux/sched.h>
>   
>   #include <drm/drm_timeout.h>
> @@ -48,3 +49,47 @@ signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec)
>   	return timeout_jiffies64 + 1;
>   }
>   EXPORT_SYMBOL(drm_timeout_abs_to_jiffies);
> +
> +/**
> + * drm_timeout_rel_to_jiffies - calculate jiffies timeout from relative value
> + * @timeout_nsec: relative timeout in ns, 0 for poll
> + *
> + * Calculate the timeout in jiffies from a relative timeout in ns, for drivers
> + * whose UAPI expresses a wait as a duration rather than as a deadline.
> + *
> + * The result is clamped to MAX_JIFFY_OFFSET. That keeps it positive once it is
> + * converted to the signed long taken by dma_fence_wait_timeout() and friends,
> + * which matters on 32-bit, and keeps it distinct from MAX_SCHEDULE_TIMEOUT so
> + * that a finite wait is never understood as an infinite one.
> + *
> + * It's strongly discouraged to use relative timeouts in uAPIs, as they do not
> + * survive a restarted ioctl. A signal-interrupted ioctl is re-entered with the
> + * same arguments, so the duration starts counting from zero again. New uAPIs
> + * should take an absolute deadline and use drm_timeout_abs_to_jiffies().
> + *
> + * Returns:
> + * 0 if @timeout_nsec is 0. Otherwise the equivalent number of jiffies and
> + * clamped to MAX_JIFFY_OFFSET.
> + */
> +unsigned long drm_timeout_rel_to_jiffies(u64 timeout_nsec)
> +{
> +	u64 secs;
> +	u32 rem;
> +
> +	/* Make 0 timeout means poll, as for the absolute variant. */
> +	if (timeout_nsec == 0)
> +		return 0;
> +
> +	/*
> +	 * As nsecs_to_jiffies64() does not guard against overflow, split
> +	 * the timeout into whole seconds and nanoseconds. This way
> +	 * nsecs_to_jiffies64() is always handed a value below a second.
> +	 */
> +	secs = div_u64_rem(timeout_nsec, NSEC_PER_SEC, &rem);
> +	if (secs >= MAX_JIFFY_OFFSET / HZ)
> +		return MAX_JIFFY_OFFSET;
> +
> +	return min_t(u64, MAX_JIFFY_OFFSET,
> +		     secs_to_jiffies(secs) + nsecs_to_jiffies64(rem) + 1);

The timeout is controled by user space, right? Can these additions 
overflow?  I see that secs is tested against MAX_JIFFY_OFFSET, but is 
that sufficient?

BTW there was this NSEC % HZ test in the original code? What was it good 
for? It is no longer useful?

Best regards
Thomas


> +}
> +EXPORT_SYMBOL(drm_timeout_rel_to_jiffies);
> diff --git a/include/drm/drm_timeout.h b/include/drm/drm_timeout.h
> index cd9621c52062..6ee222a3e97c 100644
> --- a/include/drm/drm_timeout.h
> +++ b/include/drm/drm_timeout.h
> @@ -12,5 +12,6 @@
>   #include <linux/types.h>
>   
>   signed long drm_timeout_abs_to_jiffies(s64 timeout_nsec);
> +unsigned long drm_timeout_rel_to_jiffies(u64 timeout_nsec);
>   
>   #endif
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


