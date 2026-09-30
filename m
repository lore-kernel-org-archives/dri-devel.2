Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C0FCA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 06:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E88ED10E4E3;
	Wed, 30 Sep 2026 06:48:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="QF6j0gXq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lSSsJ8y6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dqmpU21l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lYZZNlON";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F36210E4E3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:48:48 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 58D961F848;
 Wed, 30 Sep 2026 06:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790750922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oNNi0b9/KDAiIdnJzmOBnuHKAYhVEWpYywaYKcUcgB0=;
 b=QF6j0gXqFngo1GX7o4/2Qn59iuTVHpSPDXOze9nU6Sxe/5lZm9nXigaRO1frToJ7KQAP0Q
 tHmWbVYiVJ05zxL7XUp+6l/Xo3R9TvJknu/g4V7eAuzYPrBAsH9ChlYgyuoQM/z/emxbEJ
 HTD7UifSaOa30pt2O5tI9duRUaguWfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790750922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oNNi0b9/KDAiIdnJzmOBnuHKAYhVEWpYywaYKcUcgB0=;
 b=lSSsJ8y6zh3Fjhmo2F9Kphi5PkMG98L3+yyJaafgR5vFBQmICuTNOrqS8sC1LFDvm7jp56
 jKjbWoot/BqxJ2BQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dqmpU21l;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lYZZNlON
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790750918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oNNi0b9/KDAiIdnJzmOBnuHKAYhVEWpYywaYKcUcgB0=;
 b=dqmpU21lail9pnOW13qsRrkvsQw+t2rLxw6/O2Elniqh8gzsLTgyaIu2jz9OmOtX2j5Oxi
 ncyP+8DmqWr5W5pmzcH5oKpg7f9iGd0u/f3hraHoKw6kp0bmm5b6dasZDJ5vz0fC+V00AT
 H1RSEHCH8MTNvE/SCUKl62uirBo1lf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790750918;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oNNi0b9/KDAiIdnJzmOBnuHKAYhVEWpYywaYKcUcgB0=;
 b=lYZZNlONsi7Y7v8m+ciEFF8jw9rhFVmWhn15aDhB14gbbANOE4DmPf7KgIpCZoYnS7b7oe
 P4XbdJK/wnxJ0DAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A6AD136AD;
 Wed, 30 Sep 2026 06:48:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TeAfLcWwvGpADgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 30 Sep 2026 06:48:37 +0000
Message-ID: <5cf16665-40a5-4321-a0c8-98af1d0263a0@suse.de>
Date: Wed, 30 Sep 2026 08:48:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/ssd130x: stale pixels when the GPU renders into the
 framebuffer
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Fabio Piparo <holofermes@gmail.com>, Melissa Wen <mwen@igalia.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org
References: <CAB3Lz5ZuAJcgKpx0L-O3a-1psk+vwBMeH_Eux+OAgaYcyfFm6A@mail.gmail.com>
 <1f383114-e367-4b67-899b-14a393fece94@suse.de>
 <20260923160049.1741651-1-holofermes@gmail.com>
 <4a5917cb-d7d8-489a-85c1-a217b442a355@suse.de>
 <cbf22c0b-b36e-4bec-8461-27dfcb171d7b@igalia.com>
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
In-Reply-To: <cbf22c0b-b36e-4bec-8461-27dfcb171d7b@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_TO(0.00)[igalia.com,gmail.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 58D961F848
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

Am 29.09.26 um 23:50 schrieb Maíra Canal:
> Hi Thomas,
>
> On 29/09/26 06:04, Thomas Zimmermann wrote:
>> (cc'ing v3d maintainers Maira and Melissa)
>>
>> Hi
>>
>> Am 23.09.26 um 18:00 schrieb Fabio Piparo:
>>> Hi Thomas,
>>>
>>> Thanks for taking a look.
>>>
>>> On 14.09.26 10:43, Thomas Zimmermann wrote:
>>>> I assume you write these frames quickly one after the other? As i2c is
>>>> really slow, you might write to buffers that are still being 
>>>> transferred
>>>> in the background.
>>>>
>>>> Do you read back the status of the page flips? DRM should tell you 
>>>> when
>>>> it has completed transferring a frame. See [1]
>>> The test renders with the GPU: two dumb buffers allocated on the
>>> ssd130x device and shared with v3d over PRIME. It runs at 10 fps.
>>> Before each flip it calls glFinish(), then flips with
>>> DRM_MODE_PAGE_FLIP_EVENT and waits for the event before drawing into
>>> the other buffer. The same test drawing with the CPU instead comes out
>>> clean.
>>
>> A number of things come to my mind.
>>
>> - Dumb buffers (from ssd130x) are not meant for HW rendering. They 
>> are generally for software rendering only.
>>
>
> This reminded me of an issue I recently saw involving GPU rendering to
> dumb buffers when combining simpledrm and Panthor. It had the same
> symptom: this trail of glitches.
>
> After investigating that issue, I noticed that, on platforms where the
> GPU isn't DMA-coherent, when a shmem GEM buffer is exported via dma-
> buf to a GPU for rendering, the CPU can read stale data from its cache
> when later accessing the buffer, which manifests as rendering artifacts.

Exactly what we're seeing here. Thanks for the analysis.

>
> So, the GPU writes reach memory, but the CPU blit reads stale cache
> lines. drm_gem_fb_begin_cpu_access() only syncs imported buffers, and
> GEM dma_buf_ops have no begin/end_cpu_access, so nothing invalidates the
> CPU cache before the blit and the CPU reads stale cached data.
>
> I have a patch implementing begin/end_cpu_access to
> drm_gem_prime_dmabuf_ops, which fixed the issue. However, I'm not sure
> we would like to support this use case upstream because, as you
> mentioned, dumb buffers are usually used for software-rendering only.

Before we fix anything, I think we should talk to someone with 
dma-buf/PRIME credentials.  As I outlined, the ideomatic pattern is a 
producer-consumer relationship and HW rendering into dumb-buffers is not 
supported. Those buffers should have been allocated on the v3d side.

IMHO we should write down these rules in the PRIME documentation and 
(soft-)enforce them in the implementation.


>> - Hence, the ideomatic use for sharing graphics buffers is to model a 
>> producer-consumer relationship. Export the buffer from the device 
>> that generates the frame and import it to the buffer that displays it.
>>
>> - Since you're compositor's sharing happens in the opposite 
>> direction, ssd130x might not sync correctly. (I'm not sure of v3d 
>> requires a dedicated flush.)
>>
>> - Or maybe v3d needs to do a final cache flush after drawing to 
>> imported buffers.
>
> I don't think so...  Once the job completes, the GPU writes are in
> memory. I believe the stale copy is in the CPU cache, so the
> invalidation should happen on the CPU side.

OTOH it's not the exporter's (ssd130x here, but really _any_ driver) job 
to take care of it either. :/

Best regards
Thomas

>
> Best regards,
> - Maíra
>
>>
>> If nothing else helpers, we could use map_wc for shared buffers in 
>> ssd130x, but it seems like papering over something else.
>>
>> Best regards
>> Thomas
>>
>>
>>>
>>> I'm happy to send the test program if it would help.
>>>
>>> Best regards,
>>> Fabio
>>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


