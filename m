Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5BAC98305
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED46910E758;
	Tue, 22 Sep 2026 12:05:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="AD5LUNYl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VKD5bNSC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AU6A8U+w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HuvSan5H";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D3DD10E6D6;
 Tue, 22 Sep 2026 12:05:15 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A127B1F848;
 Tue, 22 Sep 2026 12:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790078709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mG50yrhBt4z5+M8rQ3Re///L3K8412WRA2PJZLydl88=;
 b=AD5LUNYl4jZNJG+WUPylBExGwcEt/hLv5RQvpT8ooybgW5WBv+Befm8S1Kr50wEFSokeH9
 Jtz2PhkWSWg4bw8wwnGvzsW309igMiETeGRE/EL7Rw/Kz/Ict8s0awelYcTNJrup6YZMHt
 eoJ3ThFM4gnBO1+C2DtSGepeLABd5M0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790078709;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mG50yrhBt4z5+M8rQ3Re///L3K8412WRA2PJZLydl88=;
 b=VKD5bNSCBNti2jtssVe+Cs9YNXLD9zLrdBLu5J0gXh6QDQkDAcMsHQMSJLFpkbq3KdMBnp
 d3TPLOZkbisRHJCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790078705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mG50yrhBt4z5+M8rQ3Re///L3K8412WRA2PJZLydl88=;
 b=AU6A8U+w5zk+XDABrDHcgkNuEl140uydFyhwwasDkDhX9FjNPrExK3N4SY55F9DW86sjhF
 JznGKAn2aA7Dcl9hQGUwvEdbAPHcHiU6raSHf+W4XMY3V7iKr+Q4v0PlpQZRIdMtG+4++9
 AQ/xi1ZkaAFNlrloYOEiRRP17iCUURY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790078705;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mG50yrhBt4z5+M8rQ3Re///L3K8412WRA2PJZLydl88=;
 b=HuvSan5HMXYDzWqnUcS7jcq14WP1WpHXIVl/u10wY1zlB4rgCRR3OauilZvHIie0nbvo23
 6n70cOs9K+X88KDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 142A7136D9;
 Tue, 22 Sep 2026 12:05:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m4rVKvBusmoJGAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 22 Sep 2026 12:05:04 +0000
Message-ID: <b60d3430-ca99-40b6-aaa0-7b8d481ebda6@suse.de>
Date: Tue, 22 Sep 2026 14:05:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/14] backlight: add kernel-internal backlight API
To: Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>,
 David Herrmann <dh.herrmann@gmail.com>,
 Marta Lofstedt <marta.lofstedt@intel.com>,
 Mario Limonciello <superm1@kernel.org>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-3-mario.limonciello@amd.com>
 <0fb724cc-ac12-4502-b338-1c4f310f043a@suse.de>
 <CAFOAJEdFPrwHZV5y1E_u_Wd6oE_viPsPztxYW6PRZHJ-zdPFMQ@mail.gmail.com>
 <ff86caeb-4388-4660-b3c0-ddc42bc274e3@amd.com>
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
In-Reply-To: <ff86caeb-4388-4660-b3c0-ddc42bc274e3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWELVE(0.00)[17];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.freedesktop.org,amd.com,ffwll.ch,linux.intel.com,kernel.org,gmail.com,intel.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid, suse.com:url]
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

Am 22.09.26 um 13:34 schrieb Mario Limonciello:
>
>
> On 9/22/26 03:49, Javier Martinez Canillas wrote:
>> On Tue, Sep 22, 2026 at 10:24 AM Thomas Zimmermann 
>> <tzimmermann@suse.de> wrote:
>>>
>>> Hi Mario
>>>
>>> Am 08.09.26 um 06:40 schrieb Mario Limonciello:
>>>> So far backlights have only been controlled via sysfs. However, 
>>>> sysfs is
>>>> not a proper user-space API for runtime modifications, and never was
>>>> intended to provide such. The DRM drivers are now prepared to provide
>>>> such a backlight link so user-space can control backlight via DRM
>>>> connector properties. This allows us to employ the same 
>>>> access-management
>>>> we use for mode-setting.
>>>>
>>>> This patch adds a few kernel-internal backlight helpers so we can 
>>>> modify
>>>> backlights from within DRM, a brightness-changed notification, and a
>>>> per-device takeover count so that legacy sysfs writes can be inhibited
>>>> (-EBUSY) while a luminance-aware DRM client is in control.
>>>>
>>>> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
>>>>
>>
>> [...]
>>
>>>> @@ -150,6 +153,13 @@ static ssize_t bl_power_store(struct device 
>>>> *dev, struct device_attribute *attr,
>>>>        struct backlight_device *bd = to_backlight_device(dev);
>>>>        unsigned long power, old_power;
>>>>
>>>> +     /* A luminance-aware DRM client has taken over this 
>>>> backlight; the
>>>> +      * legacy sysfs interface is disabled until the last such client
>>>> +      * goes away.
>>>> +      */
>>>> +     if (atomic_read(&bd->drm_takeover) > 0)
>>>> +             return -EBUSY;
>>>> +
>>>>        rc = kstrtoul(buf, 0, &power);
>>>>        if (rc)
>>>>                return rc;
>>>> @@ -214,6 +224,13 @@ static ssize_t brightness_store(struct device 
>>>> *dev,
>>>>        struct backlight_device *bd = to_backlight_device(dev);
>>>>        unsigned long brightness;
>>>>
>>>> +     /* A luminance-aware DRM client has taken over this 
>>>> backlight; the
>>>> +      * legacy sysfs interface is disabled until the last such client
>>>> +      * goes away.
>>>> +      */
>>>> +     if (atomic_read(&bd->drm_takeover) > 0)
>>>> +             return -EBUSY;
>>>
>>> Can you really do that?  AFAIU sysfs is now a de-facto uapi for 
>>> backlights.
>>
>> And regardless if this can be done or not, I belive that would be
>> better if this is something that drivers decide to do and just return
>> -EBUSY from their struct backlight_ops..update_status.
>>
>> Ideally the sysfs interface should continue to be work as Thomas said
>> and a write could trigger a mode set for example, but I don't know if
>> that is feasible to do due locking.
>>
>
> Well the problem ends up being that something can change brightness 
> behind the compositor's back if you leave sysfs available.
>
> The whole design here is to put the compositor in control.  For 
> example if compositor wants to enforce brightness to be a certain 
> value when certain content is being displayed.

And as I mentioned, it might not be that easy. Sysfs has been the entry 
point to backlight brightness so far AFAIU.

Did you consider treating this similar to display hotplugging?  When the 
user plug a display in or out, the DRM driver sends a message to the 
compositor in user space. [1]  I think it might be possible to do a 
similar thing for changes to brightness.

[1] 
https://elixir.bootlin.com/linux/v7.2.6/source/drivers/gpu/drm/drm_probe_helper.c#L747

Best regards
Thomas



-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


