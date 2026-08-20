Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0297EC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 06:38:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3612810E038;
	Thu, 20 Aug 2026 06:38:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="RKH0ex5M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AHNcU0nt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F7xU+dBY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vNieZpzi";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA58A10E038;
 Thu, 20 Aug 2026 06:38:02 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A30D33ED9;
 Thu, 20 Aug 2026 06:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787207860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MUXh/Wkm5tFQmj9zs5Wo2lEa/xlKF6J+m5iHYTUL1ho=;
 b=RKH0ex5MkmJtY2uD7i76EggdXnGhXY8WTEmfz9SPgcK6CAwl+6h442x7A2sxaOpO+SlBig
 jGqGhhVDUTXpubDrqdY6qTtuAubtt3quUi3jOOT/deUKHN8ifM+MCNM0M9QIfCIu4Ijm5M
 zsRIi6K3rW63eQV+aSmP8cpq9h0aI9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787207860;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MUXh/Wkm5tFQmj9zs5Wo2lEa/xlKF6J+m5iHYTUL1ho=;
 b=AHNcU0ntD69IvwDRN1pd+inQn9fXxG7g1YHsAJNTv07VVBh1yIQqBW+QMa2WbjyFw3/6zR
 vRSChQybWFjUpxBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=F7xU+dBY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vNieZpzi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787207856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MUXh/Wkm5tFQmj9zs5Wo2lEa/xlKF6J+m5iHYTUL1ho=;
 b=F7xU+dBYnFARY2U7edBa+1n/z35xEVyM9Nt+aWHqjDe+igrp3FQLoYZo3y++UFPFiLsLzI
 GlEQ1J294YKmsb/6ZCW+3Y4KnDwn4AVJ+xbFU5NTHlI7cWKpQyZCnFwVMYZhdp1/isB4RA
 1ZwoFYqQZ8MYrn2lLH7foztY7HhtYG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787207856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MUXh/Wkm5tFQmj9zs5Wo2lEa/xlKF6J+m5iHYTUL1ho=;
 b=vNieZpziuyls+ZVPvqGpX6qug5rn+aQ9aY4tWJP2BVX1RMBzIMlMJxkdYJvmJ34nOX1vEh
 Sj7Sy6nB8BfammCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A52927A8;
 Thu, 20 Aug 2026 06:37:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zt8oCbCghmotIgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 20 Aug 2026 06:37:36 +0000
Message-ID: <25a9543a-c5bc-4094-9386-28ff69d0ccd7@suse.de>
Date: Thu, 20 Aug 2026 08:37:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] drm: Move drm_timeout_abs_to_jiffies() to
 drm_timeout.c
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
References: <20260817-drm-timeout-helpers-v2-0-73052b669f49@igalia.com>
 <20260817-drm-timeout-helpers-v2-1-73052b669f49@igalia.com>
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
In-Reply-To: <20260817-drm-timeout-helpers-v2-1-73052b669f49@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A30D33ED9
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[19]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[igalia.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,amd.com,intel.com,raspberrypi.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.com:url];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Am 17.08.26 um 23:05 schrieb Maíra Canal:
> drm_timeout_abs_to_jiffies() began as a static helper inside the syncobj
> wait implementation and was later exported in place, so that it could be
> called by multiple drivers (e.g. panfrost, lima, tegra and accel
> drivers). All of them reach it through drm_utils.h.
>
> Give it a file of its own, so that timeout conversion helpers have a
> home, which will be useful when we add new timeout handlers. The
> declaration stays in drm_utils.h, so no caller changes.

Personally I'd prefer a drm_timeout.h header. There aren't that many 
callers after all.  drm_utils.h is then only about panel quirks and 
could be renamed accordingly.

Best regards
Thomas

>
> No functional change.
>
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/Makefile      |  1 +
>   drivers/gpu/drm/drm_syncobj.c | 33 ------------------------------
>   drivers/gpu/drm/drm_timeout.c | 47 +++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 48 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index e97faabcd783..0a0d7ea08347 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -68,6 +68,7 @@ drm-y := \
>   	drm_rect.o \
>   	drm_syncobj.o \
>   	drm_sysfs.o \
> +	drm_timeout.o \
>   	drm_trace_points.o \
>   	drm_vblank.o \
>   	drm_vblank_work.o \
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index 2fa170a29a62..cf03681de6f7 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -1193,39 +1193,6 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>   	return timeout;
>   }
>   
> -/**
> - * drm_timeout_abs_to_jiffies - calculate jiffies timeout from absolute value
> - *
> - * @timeout_nsec: timeout nsec component in ns, 0 for poll
> - *
> - * Calculate the timeout in jiffies from an absolute time in sec/nsec.
> - */
> -signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec)
> -{
> -	ktime_t abs_timeout, now;
> -	u64 timeout_ns, timeout_jiffies64;
> -
> -	/* make 0 timeout means poll - absolute 0 doesn't seem valid */
> -	if (timeout_nsec == 0)
> -		return 0;
> -
> -	abs_timeout = ns_to_ktime(timeout_nsec);
> -	now = ktime_get();
> -
> -	if (!ktime_after(abs_timeout, now))
> -		return 0;
> -
> -	timeout_ns = ktime_to_ns(ktime_sub(abs_timeout, now));
> -
> -	timeout_jiffies64 = nsecs_to_jiffies64(timeout_ns);
> -	/*  clamp timeout to avoid infinite timeout */
> -	if (timeout_jiffies64 >= MAX_SCHEDULE_TIMEOUT - 1)
> -		return MAX_SCHEDULE_TIMEOUT - 1;
> -
> -	return timeout_jiffies64 + 1;
> -}
> -EXPORT_SYMBOL(drm_timeout_abs_to_jiffies);
> -
>   static int drm_syncobj_array_wait(struct drm_device *dev,
>   				  struct drm_file *file_private,
>   				  struct drm_syncobj_wait *wait,
> diff --git a/drivers/gpu/drm/drm_timeout.c b/drivers/gpu/drm/drm_timeout.c
> new file mode 100644
> index 000000000000..78e9f65e5477
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_timeout.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Timeout conversion helpers for wait ioctls.
> + *
> + * Copyright 2017 Red Hat
> + * Copyright 2016 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/export.h>
> +#include <linux/jiffies.h>
> +#include <linux/ktime.h>
> +#include <linux/sched.h>
> +
> +#include <drm/drm_utils.h>
> +
> +/**
> + * drm_timeout_abs_to_jiffies - calculate jiffies timeout from absolute value
> + *
> + * @timeout_nsec: timeout nsec component in ns, 0 for poll
> + *
> + * Calculate the timeout in jiffies from an absolute time in sec/nsec.
> + */
> +signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec)
> +{
> +	ktime_t abs_timeout, now;
> +	u64 timeout_ns, timeout_jiffies64;
> +
> +	/* make 0 timeout means poll - absolute 0 doesn't seem valid */
> +	if (timeout_nsec == 0)
> +		return 0;
> +
> +	abs_timeout = ns_to_ktime(timeout_nsec);
> +	now = ktime_get();
> +
> +	if (!ktime_after(abs_timeout, now))
> +		return 0;
> +
> +	timeout_ns = ktime_to_ns(ktime_sub(abs_timeout, now));
> +
> +	timeout_jiffies64 = nsecs_to_jiffies64(timeout_ns);
> +	/*  clamp timeout to avoid infinite timeout */
> +	if (timeout_jiffies64 >= MAX_SCHEDULE_TIMEOUT - 1)
> +		return MAX_SCHEDULE_TIMEOUT - 1;
> +
> +	return timeout_jiffies64 + 1;
> +}
> +EXPORT_SYMBOL(drm_timeout_abs_to_jiffies);
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


