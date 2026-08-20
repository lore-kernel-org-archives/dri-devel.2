Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAD4C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 06:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCB2D10EF0A;
	Thu, 20 Aug 2026 06:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Ea3TBV9a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mtWC9orN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JyvAL0sl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fqk28GyM";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2624710E0F6;
 Thu, 20 Aug 2026 06:54:22 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 638CF84F15;
 Thu, 20 Aug 2026 06:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787208856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=R1ngbWEjFgxmUD7Z+BwhT1MATuq4D2MzeDdpvo04RrM=;
 b=Ea3TBV9aJHMQ4nGbhso8lG+QJ0OjfuTfK7IOL11mRsL9VW2IUIOcH50hdNc1xJX2PxNVgB
 UmXkAkCQnRaDCk/WNtFaamAVdzjwTTkjGsY8uYocPV4RZHhNZlcP5hNEuL0McKqwYQoJ7/
 10EPUAGAnxrb5TuD/T6Lcu7rkxPwSuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787208856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=R1ngbWEjFgxmUD7Z+BwhT1MATuq4D2MzeDdpvo04RrM=;
 b=mtWC9orNdouFa8DCLWPXTWFpyfzRAzc5mA+ApcZp7qQI6kESaiiC4rfC5cMD7CJkllCTmk
 2T/gc7F418D8O+Dg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JyvAL0sl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fqk28GyM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787208852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=R1ngbWEjFgxmUD7Z+BwhT1MATuq4D2MzeDdpvo04RrM=;
 b=JyvAL0slVAMJ4ZgNEpYmekyQVQL1yRiBbvb86J7CIf20JcNzrfMs8V4+lapVo9JkNFo57m
 w8zRj9vDJhMHpAadQqieC8GZGnYWSYLS1vpeFobHXFTBfA8lPMQZWN+KaZMJpgGN0qcqoM
 idlFnJtGBwx3tXl1Nn2+PvhFXExsy2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787208852;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=R1ngbWEjFgxmUD7Z+BwhT1MATuq4D2MzeDdpvo04RrM=;
 b=fqk28GyMqbm+M6byic1Pp0d8keCsy1LHCZ34KQutnpLNCu6jSMeo54DPAbOPg8GS9mbXF1
 TBunt1qeiHlZm1CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E675C27A8;
 Thu, 20 Aug 2026 06:54:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id odyVNpOkhmr4MQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 20 Aug 2026 06:54:11 +0000
Message-ID: <fa6953ff-1de3-40c9-8910-549083bb9a88@suse.de>
Date: Thu, 20 Aug 2026 08:54:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] drm: Add drm_timeout_rel_to_jiffies()
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
 <20260817-drm-timeout-helpers-v2-2-73052b669f49@igalia.com>
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
In-Reply-To: <20260817-drm-timeout-helpers-v2-2-73052b669f49@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 638CF84F15
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[igalia.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,amd.com,intel.com,raspberrypi.com];
 RCPT_COUNT_TWELVE(0.00)[19]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email, suse.com:url, suse.de:mid,
 suse.de:dkim, imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
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
>   drivers/gpu/drm/drm_timeout.c | 34 ++++++++++++++++++++++++++++++++++
>   include/drm/drm_utils.h       |  1 +
>   2 files changed, 35 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_timeout.c b/drivers/gpu/drm/drm_timeout.c
> index 78e9f65e5477..18c2719d1fe9 100644
> --- a/drivers/gpu/drm/drm_timeout.c
> +++ b/drivers/gpu/drm/drm_timeout.c
> @@ -9,6 +9,7 @@
>   #include <linux/export.h>
>   #include <linux/jiffies.h>
>   #include <linux/ktime.h>
> +#include <linux/math64.h>
>   #include <linux/sched.h>
>   
>   #include <drm/drm_utils.h>
> @@ -45,3 +46,36 @@ signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec)
>   	return timeout_jiffies64 + 1;
>   }
>   EXPORT_SYMBOL(drm_timeout_abs_to_jiffies);
> +
> +/**
> + * drm_timeout_rel_to_jiffies - calculate jiffies timeout from relative value
> + *
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

I would not speak of uAPIs here, as it's unrelated to the function at 
hand. You might want to mention it in the commit description though.

Please also see my comments on the docs of drm_timeout_abs_to_jiffies(). 
Most of it applies here as well.

Best regards
Thomas

> + */
> +unsigned long drm_timeout_rel_to_jiffies(u64 timeout_nsec)
> +{
> +	/* make 0 timeout means poll, as for the absolute variant */
> +	if (timeout_nsec == 0)
> +		return 0;
> +
> +	/* nsecs_to_jiffies64() does not guard against overflow */
> +	if ((NSEC_PER_SEC % HZ) != 0 &&
> +	    div_u64(timeout_nsec, NSEC_PER_SEC) >= MAX_JIFFY_OFFSET / HZ)
> +		return MAX_JIFFY_OFFSET;
> +
> +	return min_t(u64, MAX_JIFFY_OFFSET, nsecs_to_jiffies64(timeout_nsec) + 1);
> +}
> +EXPORT_SYMBOL(drm_timeout_rel_to_jiffies);
> diff --git a/include/drm/drm_utils.h b/include/drm/drm_utils.h
> index 6a46f755daba..8c0cc9835413 100644
> --- a/include/drm/drm_utils.h
> +++ b/include/drm/drm_utils.h
> @@ -25,5 +25,6 @@ const struct drm_panel_backlight_quirk *
>   drm_get_panel_backlight_quirk(const struct drm_edid *edid);
>   
>   signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec);
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
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


