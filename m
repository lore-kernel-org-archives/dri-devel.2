Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24983C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62A3510ED4F;
	Tue, 29 Sep 2026 08:20:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="tkRzg3kf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RCTqvwqT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fZQXVFKV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZOffk6JZ";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80AAA10ED4F;
 Tue, 29 Sep 2026 08:20:17 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C0B1E21D8C;
 Tue, 29 Sep 2026 08:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790670011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nETDWloaEVpCPGnd6lUlXYN5U1Kh7s4QPVRJfhErP4A=;
 b=tkRzg3kfMk2G9Lg6lWi2Kx3p8OxasRIs5Jxe5XD2UUWENkfzqI2YBcOrrLIsxRgf2GeRwR
 S3EpMBgb/iczAHSzjShEjyVZyvMN77/+KZKALwRQwcXoTK5yRcn7t8Gz1paiVFV7kXtN0/
 nkJzQaU3+Y3d/FFBK6BQNuI7yHELKM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790670011;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nETDWloaEVpCPGnd6lUlXYN5U1Kh7s4QPVRJfhErP4A=;
 b=RCTqvwqTirx4Td1evatueRVJLQLeFxS6JY9ckGe+gpBBeF87oIZU6NViTAWPTk4YdmM9KR
 9u9sxNGZ9UVY3BAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fZQXVFKV;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZOffk6JZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790670007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nETDWloaEVpCPGnd6lUlXYN5U1Kh7s4QPVRJfhErP4A=;
 b=fZQXVFKV2PCuq1HXNlmMILqPISyVgX/knLNUwKEZpiH6SQky9Ki6d5NWDJmWBBvmBi3TCT
 4KRbFLo4qGNML+aPkKFTWgsKdfmz2vw0zR5RAFYaY5js26kfec7YFylPlPN5b0qCWq7/mv
 4QEymfmYd/otba8ltuX+W0DFx0mFGH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790670007;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nETDWloaEVpCPGnd6lUlXYN5U1Kh7s4QPVRJfhErP4A=;
 b=ZOffk6JZnoQWBVaPSE6RxmdDPmmidgFVsbFHc5I12L460Fc2ov5FI/iFClZomF9uzRrjW4
 VlllxrW1JDIpTfCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FF67133F1;
 Tue, 29 Sep 2026 08:20:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AUnWNrZ0u2p0RwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 29 Sep 2026 08:20:07 +0000
Message-ID: <75a63281-c3f1-496f-8ff6-e44372c135f2@suse.de>
Date: Tue, 29 Sep 2026 10:20:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] drm/i915: Use drm_timeout_rel_to_jiffies()
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
 <20260915-drm-timeout-helpers-v3-5-f2ae987d861f@igalia.com>
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
In-Reply-To: <20260915-drm-timeout-helpers-v3-5-f2ae987d861f@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 FREEMAIL_TO(0.00)[igalia.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,amd.com,intel.com,raspberrypi.com];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[19]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,igalia.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:url];
 URIBL_BLOCKED(0.00)[igalia.com:email,suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C0B1E21D8C
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



Am 15.09.26 um 21:42 schrieb Maíra Canal:
> nsecs_to_jiffies_timeout() originated here and has since been copied into
> another driver. It is now available in "drm_timeout.c", so use it and drop
> the local definition.
>
> Signed-off-by: Maíra Canal <mcanal@igalia.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/i915/gem/i915_gem_wait.c | 17 +++--------------
>   1 file changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_wait.c b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
> index 2893df65c359..872d4045813a 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_wait.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
> @@ -7,6 +7,8 @@
>   #include <linux/dma-fence-chain.h>
>   #include <linux/jiffies.h>
>   
> +#include <drm/drm_timeout.h>
> +
>   #include "gt/intel_engine.h"
>   #include "gt/intel_rps.h"
>   
> @@ -184,25 +186,12 @@ i915_gem_object_wait(struct drm_i915_gem_object *obj,
>   	return !timeout ? -ETIME : 0;
>   }
>   
> -static inline unsigned long nsecs_to_jiffies_timeout(const u64 n)
> -{
> -	/* nsecs_to_jiffies64() does not guard against overflow */
> -	if ((NSEC_PER_SEC % HZ) != 0 &&
> -	    div_u64(n, NSEC_PER_SEC) >= MAX_JIFFY_OFFSET / HZ)
> -		return MAX_JIFFY_OFFSET;
> -
> -	return min_t(u64, MAX_JIFFY_OFFSET, nsecs_to_jiffies64(n) + 1);
> -}
> -
>   static unsigned long to_wait_timeout(s64 timeout_ns)
>   {
>   	if (timeout_ns < 0)
>   		return MAX_SCHEDULE_TIMEOUT;
>   
> -	if (timeout_ns == 0)
> -		return 0;
> -
> -	return nsecs_to_jiffies_timeout(timeout_ns);
> +	return drm_timeout_rel_to_jiffies(timeout_ns);
>   }
>   
>   /**
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


