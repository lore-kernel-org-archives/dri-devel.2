Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE02ECA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0C4710E69A;
	Mon, 28 Sep 2026 16:12:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="uZjuIRv1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1MQ6OWa6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R/JWyV97";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O1Ckxs1f";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C35A10E64F;
 Mon, 28 Sep 2026 16:12:36 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D92371FB51;
 Mon, 28 Sep 2026 16:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790611950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pyff3cghlQpfxKQ8MAKmPaSMdDocUqnZkZObvNc3RxY=;
 b=uZjuIRv1T/mguF8xvhdtk4zZOQNdo8l8bsg8bIIV0TIYaVzAnRR/ADKbqRCGv6uRx2K1/1
 bncXQ7Pl+rqy/1K6OOIFq07dS7mTK6Nc8NOztrmti/RrrxmNfSNAWKJEXYqFQ9McewH3dd
 4sCW6h7deay8LmjwE3c98QWH2gg45XM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790611950;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pyff3cghlQpfxKQ8MAKmPaSMdDocUqnZkZObvNc3RxY=;
 b=1MQ6OWa61bK0uG8M8PZKBBVXuyRpJO5QLufmfgQXuKqcd1kjW+lUp9y20pKYvjbyy8ifv1
 F/GKtO21CyWBQpBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="R/JWyV97";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=O1Ckxs1f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790611945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pyff3cghlQpfxKQ8MAKmPaSMdDocUqnZkZObvNc3RxY=;
 b=R/JWyV97qtesVVTYlx3wRBT3ddSe/5vueiWUceGEgEbAe4eoojQWxxk5YpWeFsc3POblbk
 FM+5CNssqkJYi0AsltvCipByCwf0V/dL+J+rw05D4corLYPs10hERv/P6e9Ex9j0QMscwY
 RLgyRhG89x4yTG4pTt0ldNuhtkJBkOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790611945;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pyff3cghlQpfxKQ8MAKmPaSMdDocUqnZkZObvNc3RxY=;
 b=O1Ckxs1f4rG9UKSB8pRG92P7/orKJe9wHFjzrqxjpDdMisuOFAK4ybXsohHFasN6pAF71O
 DZznj1DlA2yoRqBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 212061340F;
 Mon, 28 Sep 2026 16:12:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5PFbOuiRumoIagAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 28 Sep 2026 16:12:25 +0000
Message-ID: <a4593bf7-2036-432f-ba6a-85321fcb28df@suse.de>
Date: Mon, 28 Sep 2026 18:12:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] drm: Move drm_timeout_abs_to_jiffies() to
 drm_timeout.c
From: Thomas Zimmermann <tzimmermann@suse.de>
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
 <20260915-drm-timeout-helpers-v3-1-f2ae987d861f@igalia.com>
 <3a146579-b9c6-4d4c-835b-89871b0dcd6a@suse.de>
Content-Language: en-US
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
In-Reply-To: <3a146579-b9c6-4d4c-835b-89871b0dcd6a@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D92371FB51
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 FREEMAIL_TO(0.00)[igalia.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,amd.com,intel.com,raspberrypi.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[19];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
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



Am 28.09.26 um 18:03 schrieb Thomas Zimmermann:
[...]
>>   -/**
>> - * drm_timeout_abs_to_jiffies - calculate jiffies timeout from 
>> absolute value
>> - *
>> - * @timeout_nsec: timeout nsec component in ns, 0 for poll
>> - *
>> - * Calculate the timeout in jiffies from an absolute time in sec/nsec.
>> - */
>> -signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec)
>
> As Jani noted, the types seem to be off here. The timeout should 
> likely by unsigned. Jiffies are counted in u64 and the helper should 
> return it as such.

Scratch that. Jiffies are stored in unsigned long. So this should be 
returned.

>
> If you have the time, another such patch on top would be appreciated.

^ This.

Best regards
Thomas


>
> Best regards
> Thomas
>
>
>> -{
>> -    ktime_t abs_timeout, now;
>> -    u64 timeout_ns, timeout_jiffies64;
>> -
>> -    /* make 0 timeout means poll - absolute 0 doesn't seem valid */
>> -    if (timeout_nsec == 0)
>> -        return 0;
>> -
>> -    abs_timeout = ns_to_ktime(timeout_nsec);
>> -    now = ktime_get();
>> -
>> -    if (!ktime_after(abs_timeout, now))
>> -        return 0;
>> -
>> -    timeout_ns = ktime_to_ns(ktime_sub(abs_timeout, now));
>> -
>> -    timeout_jiffies64 = nsecs_to_jiffies64(timeout_ns);
>> -    /*  clamp timeout to avoid infinite timeout */
>> -    if (timeout_jiffies64 >= MAX_SCHEDULE_TIMEOUT - 1)
>> -        return MAX_SCHEDULE_TIMEOUT - 1;
>> -
>> -    return timeout_jiffies64 + 1;
>> -}
>> -EXPORT_SYMBOL(drm_timeout_abs_to_jiffies);
>> -
>>   static int drm_syncobj_array_wait(struct drm_device *dev,
>>                     struct drm_file *file_private,
>>                     struct drm_syncobj_wait *wait,
>> diff --git a/drivers/gpu/drm/drm_timeout.c 
>> b/drivers/gpu/drm/drm_timeout.c
>> new file mode 100644
>> index 000000000000..35e10293e0a1
>> --- /dev/null
>> +++ b/drivers/gpu/drm/drm_timeout.c
>> @@ -0,0 +1,50 @@
>> +// SPDX-License-Identifier: MIT
>> +/*
>> + * Timeout conversion helpers for wait ioctls.
>> + *
>> + * Copyright 2017 Red Hat
>> + * Copyright 2016 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <linux/export.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/ktime.h>
>> +#include <linux/sched.h>
>> +
>> +#include <drm/drm_timeout.h>
>> +
>> +/**
>> + * drm_timeout_abs_to_jiffies - calculate jiffies timeout from 
>> absolute value
>> + * @timeout_nsec: timeout nsec component in ns, 0 for poll
>> + *
>> + * Calculate the timeout in jiffies from an absolute time in ns. The 
>> result is
>> + * clamped to MAX_SCHEDULE_TIMEOUT - 1 to avoid infinite timeouts.
>> + *
>> + * Returns:
>> + * The number of jiffies until the given timeout, or the upper limit.
>> + */
>> +signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec)
>> +{
>> +    ktime_t abs_timeout, now;
>> +    u64 timeout_ns, timeout_jiffies64;
>> +
>> +    /* make 0 timeout means poll - absolute 0 doesn't seem valid */
>> +    if (timeout_nsec == 0)
>> +        return 0;
>> +
>> +    abs_timeout = ns_to_ktime(timeout_nsec);
>> +    now = ktime_get();
>> +
>> +    if (!ktime_after(abs_timeout, now))
>> +        return 0;
>> +
>> +    timeout_ns = ktime_to_ns(ktime_sub(abs_timeout, now));
>> +
>> +    timeout_jiffies64 = nsecs_to_jiffies64(timeout_ns);
>> +    /*  clamp timeout to avoid infinite timeout */
>> +    if (timeout_jiffies64 >= MAX_SCHEDULE_TIMEOUT - 1)
>> +        return MAX_SCHEDULE_TIMEOUT - 1;
>> +
>> +    return timeout_jiffies64 + 1;
>> +}
>> +EXPORT_SYMBOL(drm_timeout_abs_to_jiffies);
>> diff --git a/drivers/gpu/drm/lima/lima_gem.c 
>> b/drivers/gpu/drm/lima/lima_gem.c
>> index 0c73860bb501..97e1dc541c2e 100644
>> --- a/drivers/gpu/drm/lima/lima_gem.c
>> +++ b/drivers/gpu/drm/lima/lima_gem.c
>> @@ -10,7 +10,7 @@
>>     #include <drm/drm_file.h>
>>   #include <drm/drm_syncobj.h>
>> -#include <drm/drm_utils.h>
>> +#include <drm/drm_timeout.h>
>>     #include <drm/lima_drm.h>
>>   diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c 
>> b/drivers/gpu/drm/panfrost/panfrost_drv.c
>> index 96a66d673ba6..70c05210ea84 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
>> @@ -18,7 +18,7 @@
>>   #include <drm/drm_ioctl.h>
>>   #include <drm/drm_print.h>
>>   #include <drm/drm_syncobj.h>
>> -#include <drm/drm_utils.h>
>> +#include <drm/drm_timeout.h>
>>     #include "panfrost_device.h"
>>   #include "panfrost_drv.h"
>> diff --git a/drivers/gpu/drm/tegra/uapi.c b/drivers/gpu/drm/tegra/uapi.c
>> index c0ac6b45f2d7..bee310b07eb0 100644
>> --- a/drivers/gpu/drm/tegra/uapi.c
>> +++ b/drivers/gpu/drm/tegra/uapi.c
>> @@ -7,7 +7,7 @@
>>     #include <drm/drm_drv.h>
>>   #include <drm/drm_file.h>
>> -#include <drm/drm_utils.h>
>> +#include <drm/drm_timeout.h>
>>     #include "drm.h"
>>   #include "uapi.h"
>> diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c 
>> b/drivers/gpu/drm/xe/xe_wait_user_fence.c
>> index 51eb940ceb4e..e241f3ec3547 100644
>> --- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
>> +++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
>> @@ -7,7 +7,7 @@
>>     #include <drm/drm_device.h>
>>   #include <drm/drm_file.h>
>> -#include <drm/drm_utils.h>
>> +#include <drm/drm_timeout.h>
>>   #include <uapi/drm/xe_drm.h>
>>     #include "xe_device.h"
>> diff --git a/include/drm/drm_timeout.h b/include/drm/drm_timeout.h
>> new file mode 100644
>> index 000000000000..cd9621c52062
>> --- /dev/null
>> +++ b/include/drm/drm_timeout.h
>> @@ -0,0 +1,16 @@
>> +/* SPDX-License-Identifier: MIT */
>> +/*
>> + * Function prototypes for timeout conversion helpers for wait ioctls.
>> + *
>> + * Copyright 2017 Red Hat
>> + * Copyright 2016 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#ifndef __DRM_TIMEOUT_H__
>> +#define __DRM_TIMEOUT_H__
>> +
>> +#include <linux/types.h>
>> +
>> +signed long drm_timeout_abs_to_jiffies(s64 timeout_nsec);
>> +
>> +#endif
>> diff --git a/include/drm/drm_utils.h b/include/drm/drm_utils.h
>> index 7e077484c5bb..c61dee76451c 100644
>> --- a/include/drm/drm_utils.h
>> +++ b/include/drm/drm_utils.h
>> @@ -25,6 +25,4 @@ struct drm_panel_backlight_quirk {
>>   const struct drm_panel_backlight_quirk *
>>   drm_get_panel_backlight_quirk(const struct drm_edid *edid);
>>   -signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec);
>> -
>>   #endif
>>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


