Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2B5C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 488A710E544;
	Tue, 29 Sep 2026 08:07:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="s/0deL0s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5hCa7PoA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rqFZbwRq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OduqukU2";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3005610E544;
 Tue, 29 Sep 2026 08:07:30 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DF10B21CE9;
 Tue, 29 Sep 2026 08:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790669244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L+QGPiP//e7Js9o0sP26yA6tf2Fm46JYPpPJ/rdE/QE=;
 b=s/0deL0s1emqvjcVb2M+kwcjzHhGe79Z6ICC2aZXVhzxbMEGOjVZBhCT3HkL+ubboxd3K5
 ajwrOr6a7SVqMVir83d1G/KhCHHHgOBPToK6/ggHsVbMRzY3SzEeZhzIratJ8c6Ss8wMqK
 WxeHDECMPhwtWGTP91KFjOV6wdwV8zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790669244;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L+QGPiP//e7Js9o0sP26yA6tf2Fm46JYPpPJ/rdE/QE=;
 b=5hCa7PoANUTovHm+jPuhtG3sncL57tU5MISfOrXcWq2noxGzaHIijHszn6bjK1qh/gIbC9
 PBz6EJVQCbJS/wCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rqFZbwRq;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OduqukU2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790669239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L+QGPiP//e7Js9o0sP26yA6tf2Fm46JYPpPJ/rdE/QE=;
 b=rqFZbwRqx2PWf+ifQluQSSKeJkrFcOHsOyZZxNIChx/3CimfkbbEwzD2kag+G22MfWVfp2
 5KwOvIKBkJulQMqiATfrXPokqlZ1jwxArB3FuofaWMOwhOBQCLDUjFcHFa7bRlY8RTvCfN
 uZXmSfU9XIzq1MQEdgonWpgdInfuRv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790669239;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L+QGPiP//e7Js9o0sP26yA6tf2Fm46JYPpPJ/rdE/QE=;
 b=OduqukU2zx3UkvpDYvUJyJLwsXi2S3Kv/SXZ38wC2UiZk0lILxfuNhGPU4VM73/ZpPPH4l
 rc3iXbgdgC0FcyAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46C63136E4;
 Tue, 29 Sep 2026 08:07:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id i/p9Abdxu2pMOQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 29 Sep 2026 08:07:19 +0000
Message-ID: <1a4e787f-c61f-4892-ae7e-344880f5c7bf@suse.de>
Date: Tue, 29 Sep 2026 10:07:18 +0200
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
 <7a19a212-194a-4d5b-b0a0-6d2bee24f636@suse.de>
 <7dda1960-9e73-43af-bbb8-e6e7ba32a8f3@igalia.com>
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
In-Reply-To: <7dda1960-9e73-43af-bbb8-e6e7ba32a8f3@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.31 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_TO(0.00)[igalia.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,amd.com,intel.com,raspberrypi.com];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[19]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:url,suse.de:dkim,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DF10B21CE9
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

Am 28.09.26 um 20:09 schrieb Maíra Canal:
> Hi Thomas,
>
> Thank you for your review!
>
> On 28/09/26 13:37, Thomas Zimmermann wrote:
>
> [...]
>
>>> +unsigned long drm_timeout_rel_to_jiffies(u64 timeout_nsec)
>>> +{
>>> +    u64 secs;
>>> +    u32 rem;
>>> +
>>> +    /* Make 0 timeout means poll, as for the absolute variant. */
>>> +    if (timeout_nsec == 0)
>>> +        return 0;
>>> +
>>> +    /*
>>> +     * As nsecs_to_jiffies64() does not guard against overflow, split
>>> +     * the timeout into whole seconds and nanoseconds. This way
>>> +     * nsecs_to_jiffies64() is always handed a value below a second.
>>> +     */
>>> +    secs = div_u64_rem(timeout_nsec, NSEC_PER_SEC, &rem);
>>> +    if (secs >= MAX_JIFFY_OFFSET / HZ)
>>> +        return MAX_JIFFY_OFFSET;
>>> +
>>> +    return min_t(u64, MAX_JIFFY_OFFSET,
>>> +             secs_to_jiffies(secs) + nsecs_to_jiffies64(rem) + 1);
>>
>> The timeout is controled by user space, right? Can these additions 
>> overflow?  I see that secs is tested against MAX_JIFFY_OFFSET, but is 
>> that sufficient?
>
> Although the timeout is controlled by user-space, the additions cannot
> overflow here. The secs test bounds the multiplication, which is why it
> is written as secs >= MAX_JIFFY_OFFSET / HZ rather than secs * HZ >=
> MAX_JIFFY_OFFSET (which could overflow).
>
> Past that check, we know that the remaining is smaller than one second
> and therefore, nsecs_to_jiffies64(rem) <= HZ - 1. So, the sum + 1 is at
> most MAX_JIFFY_OFFSET.
>
>>
>> BTW there was this NSEC % HZ test in the original code? What was it 
>> good for? It is no longer useful?
>>
>
> I believe that NSEC_PER_SEC % HZ was only useful to check if it was a
> plain division, which wouldn't overflow. With the current approach, I
> believe it's no longer needed.

Thanks for answering my questions.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Best regards
Thomas


>
> Best regards,
> - Maíra
>> Best regards
>> Thomas
>>
>>
>>> +}
>>> +EXPORT_SYMBOL(drm_timeout_rel_to_jiffies);
>>> diff --git a/include/drm/drm_timeout.h b/include/drm/drm_timeout.h
>>> index cd9621c52062..6ee222a3e97c 100644
>>> --- a/include/drm/drm_timeout.h
>>> +++ b/include/drm/drm_timeout.h
>>> @@ -12,5 +12,6 @@
>>>   #include <linux/types.h>
>>>   signed long drm_timeout_abs_to_jiffies(s64 timeout_nsec);
>>> +unsigned long drm_timeout_rel_to_jiffies(u64 timeout_nsec);
>>>   #endif
>>>
>>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


