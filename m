Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FECCA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 08:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CD3010F7A5;
	Fri,  2 Oct 2026 08:12:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="RwMxqI6C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XZ2Q3u/1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oYUr4K7a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I23bQ1iV";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F6B510F7A5
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 08:12:37 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BAF641FE33;
 Fri,  2 Oct 2026 08:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790928751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eOLciC3EFO6+x6OdmqxNHBlj9SqcRISQTR/fa8SqC1w=;
 b=RwMxqI6CJKywu0Nhutkodzt1RwbplGhZXqvy7Ur8Pg0NOmuZRaVoC6gB1colWp7Kr1V6Vu
 P8q3rRGwGjEefCkiyrvKF13Ns3ki1by6Kq/QbZ0ouGiDNFYZA9T7Gq3AO2eN5z1dQ60bUN
 CL6f2kDTqcnPPYgmsjnyocYZDvg2JUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790928751;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eOLciC3EFO6+x6OdmqxNHBlj9SqcRISQTR/fa8SqC1w=;
 b=XZ2Q3u/1usmdGJfhlwNm9G+MCQXx52Xs2FXn55HhhzEx6MOrr+R4j7TvbdBBFH/DolyKK8
 t5o1BSesH6/4dnAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oYUr4K7a;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=I23bQ1iV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790928747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eOLciC3EFO6+x6OdmqxNHBlj9SqcRISQTR/fa8SqC1w=;
 b=oYUr4K7av+aqQpm0XxUlO930mwFbW7iGkgQTCgs5R6XuTd/7KCeAWadPcOsknOpmaeHFWn
 3ckGrdF+GOO5BLolLBmMqqccfgmezc1PW6XZRvJ8L7qaSza+hlrOCuUYJP5ZpFKJzGtE0B
 TRPWzp6D2AgqnWLTkHy27ruM5+7DtlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790928747;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eOLciC3EFO6+x6OdmqxNHBlj9SqcRISQTR/fa8SqC1w=;
 b=I23bQ1iVyVZfT3AI5TRgYvY2p2Qq+8p8XfHXuBaUYdAXwG6+uwXM3rXCsMIrulB9WTF3JA
 JuCO236pBKHDZcCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72F1413691;
 Fri,  2 Oct 2026 08:12:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id G/DLBWtnv2ocKwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 02 Oct 2026 08:12:27 +0000
Message-ID: <55914ef9-517d-48dd-a084-0f553f04cb8a@suse.de>
Date: Fri, 2 Oct 2026 10:12:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/ssd130x: stale pixels when the GPU renders into the
 framebuffer
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Fabio Piparo <holofermes@gmail.com>, Melissa Wen <mwen@igalia.com>,
 Chema Casanova <jmcasanova@igalia.com>
Cc: dri-devel@lists.freedesktop.org
References: <CAB3Lz5ZuAJcgKpx0L-O3a-1psk+vwBMeH_Eux+OAgaYcyfFm6A@mail.gmail.com>
 <1f383114-e367-4b67-899b-14a393fece94@suse.de>
 <20260923160049.1741651-1-holofermes@gmail.com>
 <4a5917cb-d7d8-489a-85c1-a217b442a355@suse.de>
 <cbf22c0b-b36e-4bec-8461-27dfcb171d7b@igalia.com>
 <5cf16665-40a5-4321-a0c8-98af1d0263a0@suse.de>
 <xlv1pkxvdvs0.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
 <a8814ebf-1d6b-4f71-8f53-77b7476ba0d7@suse.de>
 <a9f52cac-e8bc-4ec2-b452-0fdcb32c4713@igalia.com>
 <xlv1jyo2enyv.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
 <3bfe2517-a5d3-4e86-99bd-6c28556f0f2d@igalia.com>
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
In-Reply-To: <3bfe2517-a5d3-4e86-99bd-6c28556f0f2d@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BAF641FE33
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 FREEMAIL_TO(0.00)[igalia.com,redhat.com,gmail.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
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

Hi

Am 30.09.26 um 21:57 schrieb Maíra Canal:
> + cc Chema (Mesa developer in V3D)
>
> Hi,
>
> On 30/09/26 12:52, Javier Martinez Canillas wrote:
>> Maíra Canal <mcanal@igalia.com> writes:
>>
>> Hello Maíra,
>>
>>> Hi,
>>>
>>> On 30/09/26 05:32, Thomas Zimmermann wrote:
>>>> Hi
>>>>
>>>> Am 30.09.26 um 09:48 schrieb Javier Martinez Canillas:
>>>> [...]
>>>>>>> I have a patch implementing begin/end_cpu_access to
>>>>>>> drm_gem_prime_dmabuf_ops, which fixed the issue. However, I'm 
>>>>>>> not sure
>>>>>>> we would like to support this use case upstream because, as you
>>>>>>> mentioned, dumb buffers are usually used for software-rendering 
>>>>>>> only.
>>>>>> Before we fix anything, I think we should talk to someone with
>>>>>> dma-buf/PRIME credentials.  As I outlined, the ideomatic pattern 
>>>>>> is a
>>>>>> producer-consumer relationship and HW rendering into dumb-buffers 
>>>>>> is not
>>>>>> supported. Those buffers should have been allocated on the v3d side.
>>>>>>
>>>>>> IMHO we should write down these rules in the PRIME documentation and
>>>>>> (soft-)enforce them in the implementation.
>>>>>>
>>>>> Yeah, I think either drm_gem_fb_begin_cpu_access() needs to also sync
>>>>> exported buffers (what Maíra is proposing as a fix) or there 
>>>>> should be
>>>>> documentation of the rules for cross-devices buffer sharing through
>>>>> PRIME.
>>>>
>>>> This specific case only happens with v3d and only this driver can know
>>>> when to flush caches. If we flush caches in begin_cpu_access, we 
>>>> easily
>>>> end up paying the overhead on all systems.
>>>>
>>>
>>> I believe that's the main issue. We would pay a reasonably big price to
>>> support this uncommon (and maybe even wrong) use case.
>>>
>>> P.S.: To be clear, I wasn't proposing a fix. I should have called my
>>> patch a "hack", because although it works, I don't believe we should
>>> support this use case for the reasons stated by Thomas.
>>>
>>
>> Yes, I agree with you. Making v3d to warn as Thomas suggested seems 
>> to be
>> the best compromise.
>
> I was thinking about Thomas' suggestion, and I might be missing
> something. If v3d warns when rendering to imported buffers, it will
> warn on every RPi 4/5, as Mesa renders the display path into dumb
> buffers imported from vc4. That works because vc4 buffers are WC and
> scanned out by hardware, so the CPU never reads them [1].

Oh, that's not good. It actually convinces me that v3d (and every other 
driver) should have warned about this situation. See my example below.


>
> From my point of view, the issue here is cross-device sharing of a dumb
> buffer that the exporter reads with the CPU through a cached mapping.

The whole workaround with WC doesn't fully capture the issue.

Imagine the renderer would have used discrete video memory (e.g. like on 
an old PCI device). Rendering to an imported buffer would simply not 
work at all. After rendering a frame into the video memory, the render 
driver would have to memcpy the result from the video memory to the 
imported buffer. This would need to be done on every frame because the 
importer doesn't know when exactly the exporter requires the image.  
  Sharing buffers in the other direction would work fine.  The importer 
(now ssd130x) can always setup a page mapping from the dma-buf's 
provided s/g table. The s/g table can refer directly to the video memory 
on the PCI device.


>
> [1] Right after writing this paragraph, I decided to read the
> documentation in drm_dumb_object.c and I found:
>
> * Note that dumb objects may not be used for gpu acceleration, as has 
> been
> * attempted on some ARM embedded platforms. Such drivers really must have
> * a hardware-specific ioctl to allocate suitable buffer objects.
>
> Does anyone know why Mesa kmsro create dumb buffers for rendering? Maybe
> I understood the documentation incorrectly, but it looks like we
> shouldn't be doing that.

The first bullet point talks specifically about GPU acceleration. Mesa 
creates dumb buffers for _software rendering_. Ssd130x scans out the 
final result and transfers it to the panel. No GPU rendering involved there.

Best regards
Thomas


>
> Best regards,
> - Maíra
>
>>
>>> Best regards,
>>> - Maíra
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


