Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142E8CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 693CD10E621;
	Mon, 22 Jun 2026 11:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="u0beMWS5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MGtVM6qc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u0beMWS5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MGtVM6qc";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C257810E621
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 11:18:23 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2128275CE0;
 Mon, 22 Jun 2026 11:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782127102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GemY+t/gNXJ5FAPkMVvBmRdszf9oTZAX5txMwTRb4uM=;
 b=u0beMWS5X6qJYUbNTG6+NexYSpPTNl2633v68TUkuhhkJPZ0TzGnwEm2OmYVfnK7l3RQ+1
 140ApDdFTCalVSONcMYWImVtyKCdlcEM2FBlHTp+wkxYzYHxP3lbdj/aSmUr0q79pFGqNt
 SyxERJ2arN4myLuuzzX6IMk75FJL0Wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782127102;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GemY+t/gNXJ5FAPkMVvBmRdszf9oTZAX5txMwTRb4uM=;
 b=MGtVM6qcSde7DMLOp09MX7daj4eB1VEDExC1WiFTylf2utSEpYYGDio9pufrk5aUenfZfh
 6gk1/gHrE6QqIqDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=u0beMWS5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MGtVM6qc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782127102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GemY+t/gNXJ5FAPkMVvBmRdszf9oTZAX5txMwTRb4uM=;
 b=u0beMWS5X6qJYUbNTG6+NexYSpPTNl2633v68TUkuhhkJPZ0TzGnwEm2OmYVfnK7l3RQ+1
 140ApDdFTCalVSONcMYWImVtyKCdlcEM2FBlHTp+wkxYzYHxP3lbdj/aSmUr0q79pFGqNt
 SyxERJ2arN4myLuuzzX6IMk75FJL0Wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782127102;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GemY+t/gNXJ5FAPkMVvBmRdszf9oTZAX5txMwTRb4uM=;
 b=MGtVM6qcSde7DMLOp09MX7daj4eB1VEDExC1WiFTylf2utSEpYYGDio9pufrk5aUenfZfh
 6gk1/gHrE6QqIqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8D9D779A8;
 Mon, 22 Jun 2026 11:18:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kWg2N/0ZOWr7IgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 22 Jun 2026 11:18:21 +0000
Message-ID: <6d21aee6-ed68-47a2-aa46-270340a3f520@suse.de>
Date: Mon, 22 Jun 2026 13:18:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/fb_helper: Determine proper crtc_index within
 drm_fb_helper_fb_dirty
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 "H. Nikolaus Schaller" <hns@goldelico.com>, sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, Andreas Kemnade <akemnade@kernel.org>
References: <5118b37e579cec220f2d2b6ab0bb1ecfb67f0d5c.1781803617.git.hns@goldelico.com>
 <20260618174310.70DB11F000E9@smtp.kernel.org>
 <50FDBC3B-BFC2-4BC6-B216-78C2C24D9E30@goldelico.com>
 <1c9e0e24-9c4a-4259-8700-cf9e5fd60ca3@suse.de>
 <8773121ff24730f0b4c2d0037132e4507380a77f.camel@iscas.ac.cn>
 <10f7b889-9e4c-40cd-9aca-b545b9675a37@suse.de>
 <4d76953415ccaf99dc5f5590c1a8a71ac2b29cae.camel@iscas.ac.cn>
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
In-Reply-To: <4d76953415ccaf99dc5f5590c1a8a71ac2b29cae.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:url,suse.de:mid,suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2128275CE0
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

Am 22.06.26 um 11:47 schrieb Icenowy Zheng:
> 在 2026-06-22一的 11:11 +0200，Thomas Zimmermann写道：
>> Hi
>>
>> Am 19.06.26 um 18:59 schrieb Icenowy Zheng:
>>> 在 2026-06-19五的 10:50 +0200，Thomas Zimmermann写道：
>>>> (cc Icenowy)
>>>>
>>>> Hi,
>>>>
>>>> there are a number of similar reports. Does the attached patch
>>>> fix
>>>> the
>>>> problem. It picks up what you do, but in a more correct way.
>>> Yes, this patch looks okay, but I wonder whether the crtc index
>>> query
>>> should be done in drm_client_modeset_wait_for_vblank() instead.
>> There's another call to this helper from the ioctl helper. It has a
>> lengthy comment about using CRTC 0 only and how these indices don't
>> make
>> much sense with fbdev. I'll look into generalizing the code a bit,
> I think both codepaths are based on the same (wrong) assumption that
> CRTC 0 is always the first used CRTC, so that codepath should also be
> fixed; integrating the logic into drm_client_modeset_wait_for_vblank()
> will not affect drivers that use CRTC 0 first, but will make drivers
> that have fixed CRTC preference work with FBIO_WAITFORVSYNC too (which
> currently do not work).

DRM's fbdev emulation is legacy code and most likely not used besides 
the kernel's console. Until we have a bug reports against the ioctl, 
there nothing to fix here.

Interfaces for drm_client_ are supposed to work with any client. 
Integrating that look-up code there might make other clients unhappy.

Best regards
Thomas

>
> Thanks,
> Icenowy
>
>> but
>> I'd rather not fully integrate the logic into
>> drm_client_modeset_wait_for_vblank().
>>
>> Best regards
>> Thomas
>>
>>> I will test this patch this weekend.
>>>
>>> Thanks,
>>> Icenow
>>>
>>>> Best regards
>>>> Thomas
>>>>
>>>> Am 18.06.26 um 19:56 schrieb H. Nikolaus Schaller:
>>>>>> Am 18.06.2026 um 19:43 schrieb sashiko-bot@kernel.org:
>>>>>>
>>>>>> Thank you for your contribution! Sashiko AI review found 3
>>>>>> potential issue(s) to consider:
>>>>>> - [High] Lockless access to `crtc->state` and `crtc->primary-
>>>>>>> state` can lead to a Use-After-Free due to concurrent
>>>>>>> atomic
>>>>>> commits.
>>>>>> - [High] The patch breaks vblank synchronization for legacy
>>>>>> (non-
>>>>>> atomic) DRM drivers.
>>>>>> - [Medium] The logic selects the first matching CRTC instead
>>>>>> of
>>>>>> the last active one, contradicting the commit message.
>>>>>> --
>>>>>>
>>>>>> commit 0337b26b606b4d905d72ea2be31bcb984fe62c6e
>>>>>> Author: H. Nikolaus Schaller <hns@goldelico.com>
>>>>>>
>>>>>> drm/fb_helper: Determine proper crtc_index within
>>>>>> drm_fb_helper_fb_dirty
>>>>>>
>>>>>> This commit updates the dirty framebuffer worker to search
>>>>>> for a
>>>>>> matching
>>>>>> active CRTC instead of hardcoding the wait for vblank to CRTC
>>>>>> index 0. It
>>>>>> aims to avoid vblank timeouts when CRTC 0 is inactive.
>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/drm_fb_helper.c
>>>>>>> b/drivers/gpu/drm/drm_fb_helper.c
>>>>>>> --- a/drivers/gpu/drm/drm_fb_helper.c
>>>>>>> +++ b/drivers/gpu/drm/drm_fb_helper.c
>>>>>> [ ... ]
>>>>>>> @@ -232,9 +232,23 @@ static void
>>>>>>> drm_fb_helper_fb_dirty(struct
>>>>>>> drm_fb_helper *helper)
>>>>>>> struct drm_clip_rect clip_copy;
>>>>>>> unsigned long flags;
>>>>>>> int ret;
>>>>>>> + unsigned int crtc_index = 0;
>>>>>>> + struct drm_crtc *crtc;
>>>>>>>
>>>>>>> mutex_lock(&helper->lock);
>>>>>>> - drm_client_modeset_wait_for_vblank(&helper->client, 0);
>>>>>>> +
>>>>>>> + drm_for_each_crtc(crtc, dev) {
>>>>>>> + if (crtc->primary && crtc->primary->state &&
>>>>>>> +    crtc->primary->state->fb == helper->fb &&
>>>>>>> +    crtc->state && crtc->state->active) {
>>>>>> [Severity: High]
>>>>>> Can this lockless access to crtc->state and crtc->primary-
>>>>>>> state
>>>>>> result in a
>>>>>> use-after-free?
>>>>> No idea...
>>>>>
>>>>>> The drm_fb_helper_fb_dirty() function holds helper->lock, but
>>>>>> does not hold
>>>>>> the DRM modeset locks required to protect these state
>>>>>> pointers.
>>>>>> During a
>>>>> Which locks are exactly recommended to add? What is their
>>>>> name/pointer?
>>>>>
>>>>>> concurrent atomic modeset commit, the DRM core allocates new
>>>>>> state objects,
>>>>>> swaps them into place, and frees the old objects via kfree().
>>>>>>
>>>>>> If this code reads an old state pointer and gets preempted,
>>>>>> could
>>>>>> it then
>>>>>> dereference the pointer after it has been freed by the
>>>>>> concurrent
>>>>>> commit?
>>>>>>
>>>>>> [Severity: High]
>>>>>> Does this break vblank synchronization for legacy non-atomic
>>>>>> DRM
>>>>>> drivers?
>>>>>> Legacy drivers do not use the atomic modesetting
>>>>>> infrastructure,
>>>>>> so their
>>>>>> crtc->state and crtc->primary->state pointers remain NULL.
>>>>>> Since
>>>>>> the condition
>>>>>> above requires these pointers to be non-NULL, the loop will
>>>>>> skip
>>>>>> the vblank
>>>>>> wait entirely for legacy drivers. This skips the intended
>>>>>> rate-
>>>>>> limiting
>>>>>> behavior and could lead to unbounded damage worker execution.
>>>>> What is the solution? And is this important.
>>>>>
>>>>> Before d8c4bddcd8bcb ("drm/fb-helper: Synchronize dirty worker
>>>>> with
>>>>> vblank")
>>>>>
>>>>> there was also no rate-limiting behavior.
>>>>>
>>>>>>> + crtc_index = drm_crtc_index(crtc) + 1;
>>>>>>> + break;
>>>>>> [Severity: Medium]
>>>>>> The commit message states "If multiple CRTCs match, the last
>>>>>> active one is
>>>>>> selected." Does the break statement here cause the first
>>>>>> active
>>>>>> CRTC to be
>>>>>> selected instead, bypassing the remaining matches in the
>>>>>> list?
>>>>> Yes, that is correct. The description is indeed wrong.
>>>>>
>>>>>>> + }
>>>>>>> + }
>>>>>>> +
>>>>>>> + if (crtc_index > 0)
>>>>>>> + drm_client_modeset_wait_for_vblank(&helper->client,
>>>>>>> crtc_index - 1);
>>>>>>> +
>>>>>>> mutex_unlock(&helper->lock);
>>>>>> -- 
>>>>>> Sashiko AI review ·
>>>>>> https://sashiko.dev/#/patchset/5118b37e579cec220f2d2b6ab0bb1ecfb67f0d5c.1781803617.git.hns@goldelico.com?part=1

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


