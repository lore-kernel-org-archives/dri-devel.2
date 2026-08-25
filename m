Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46CDC61DB4
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E44710E9C7;
	Tue, 25 Aug 2026 10:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="c6GZIEsn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3Z5WpXpt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WP0CSgnd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/RE26S1t";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DEEB10E9C7
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 10:21:29 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6FD9786D68;
 Tue, 25 Aug 2026 10:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787653283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=swMNJAV0EcauD3NHp94va5PH1/WvfMii+KDu1uR8vl4=;
 b=c6GZIEsniWXVamWzpv25r1ld7tzEJhv3KbzZ2f8rL7VsYjmWkuJal+38XULe0DToXGx1qH
 GzCixrDBmMcRmxgAl/XTbpxlgfdHw788xazPCkCtAnc1YAub1kYihu32Xk4jrlgGJ4/pF/
 wu/2K1D1zGWhsoEjwKL7OlX+F0SC0NU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787653283;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=swMNJAV0EcauD3NHp94va5PH1/WvfMii+KDu1uR8vl4=;
 b=3Z5WpXpt5HEW6UH5OOQHdKstCymGA7Lk93pHFl1finQYaCJ6jHVOopeie9ckLkNHsqg32Q
 id0AiDAXbcsW4LCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787653279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=swMNJAV0EcauD3NHp94va5PH1/WvfMii+KDu1uR8vl4=;
 b=WP0CSgnd++Vu4sgbZhtSlKZFf/FO2f+nKCtG+fjR9bqwqopWylaRRA+qMrkq4AXcTO6u24
 mZyRHkqoZYesQ7AaaQ1w4uBJyISa17mdzHR8L//JfFJbReG+gnGboVFcvu9/ympxn8quxj
 OxLBZ+ev57bQYxLJ5FAtnPu6zH+bfxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787653279;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=swMNJAV0EcauD3NHp94va5PH1/WvfMii+KDu1uR8vl4=;
 b=/RE26S1tzj3fob07yaf0mfBpL54zQ+tvHiVNy8zD3p7ojpwKhjuro0vRLxYMzrAgnNh8ye
 RWkHdlrIAipsC2Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5190313331;
 Tue, 25 Aug 2026 10:21:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id U7ufEp9sjWoTfQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 25 Aug 2026 10:21:19 +0000
Message-ID: <7a61b8fc-68f4-4d8d-b5ff-0ffd9a9507fc@suse.de>
Date: Tue, 25 Aug 2026 12:21:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/cirrus-qemu: Validate BAR0 size during probe
To: Slawomir Stepien <sst@poczta.fm>
Cc: sashiko-reviews@lists.linux.dev, syzbot <syzbot@kernel.org>,
 dri-devel@lists.freedesktop.org
References: <b11f8965-5896-4119-98b7-6bd0eb9fa139@mail.kernel.org>
 <20260825074432.0B4511F00A3A@smtp.kernel.org>
 <ce0912d6-fdc4-4ead-9388-a9e0e9a1954c@suse.de> <ao1ketQ4oxNiWGAM@nr200>
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
In-Reply-To: <ao1ketQ4oxNiWGAM@nr200>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_TO(0.00)[poczta.fm];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[poczta.fm];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, syzkaller.appspot.com:url,
 suse.com:url, poczta.fm:email, imap1.dmz-prg2.suse.org:helo]
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

Am 25.08.26 um 11:46 schrieb Slawomir Stepien:
> On sie 25, 2026 10:00, Thomas Zimmermann wrote:
>> (cc: Slawomir)
>>
>> Hi,
> Hello,
>
>> thanks for the fix. Please see below for changes that should go into the
>> patch.
> thanks I will look into them and make a manual v2!
>
>> Best regards
>> Thomas
>>
>> Am 25.08.26 um 09:44 schrieb sashiko-bot@kernel.org:
>>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>> - [High] The exact equality check for BAR0 size (`!= CIRRUS_VRAM_SIZE`) incorrectly rejects valid QEMU configurations with larger VRAM.
>>> - [High] The VRAM size validation check is placed after `aperture_remove_conflicting_pci_devices()`, meaning the firmware framebuffer is permanently destroyed even if the driver ultimately fails to bind.
>>> --
>>>
>>> --- Patch [1]: [PATCH] drm/cirrus-qemu: Validate BAR0 size during probe ---
>>> commit 75467ead62a494b6afbc057c666ab59f7e4b8915
>>> Author: Slawomir Stepien <sst@poczta.fm>
>>>
>>> drm/cirrus-qemu: Validate BAR0 size during probe
>>>
>>> This commit adds a check during PCI probe to verify that the BAR0 resource
>>> length equals CIRRUS_VRAM_SIZE. This is intended to prevent supervisor write
>>> page faults caused by writing past the end of the mapped I/O memory when
>>> smaller BARs are presented.
>>>
>>> Link: https://syzkaller.appspot.com/ai_job?id=ba262a3a-bccf-4ad8-a1b0-583c55d34fd6
>>>
>>>> diff --git a/drivers/gpu/drm/tiny/cirrus-qemu.c b/drivers/gpu/drm/tiny/cirrus-qemu.c
>>>> index 075221b431d37..70c995025f508 100644
>>>> --- a/drivers/gpu/drm/tiny/cirrus-qemu.c
>>>> +++ b/drivers/gpu/drm/tiny/cirrus-qemu.c
>>>> @@ -602,6 +602,9 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
>>>>    	dev = &cirrus->dev;
>>>> +	if (pci_resource_len(pdev, 0) != CIRRUS_VRAM_SIZE)
>>>> +		return -ENODEV;
>>>> +
>>> [Severity: High]
>>> Does this strict equality check unintentionally break valid QEMU
>>> configurations that have more than 4 MB of VRAM?
>>>
>>> When a VM is booted with a configuration like -device cirrus-vga,vgamem_mb=8,
>>> the BAR0 size will be 8 MB. The check in cirrus_pci_probe() evaluates
>>> to true (since 8 MB is not equal to 4 MB) and rejects the device by
>>> returning -ENODEV.
>>>
>>> Would it be safer to check if pci_resource_len(pdev, 0) < CIRRUS_VRAM_SIZE
>>> instead of requiring an exact match?
> It seems that 4MB is the default one and 8 and 16MB are just for compatibility:
>
> (qemu hw/display/cirrus_vga.c):
>
> 2951     /*
> 2952      * Follow real hardware, cirrus card emulated has 4 MB video memory.
> 2953      * Also accept 8 MB/16 MB for backward compatibility.
> 2954      */
> 2955     if (s->vga.vram_size_mb != 4 && s->vga.vram_size_mb != 8 &&
> 2956         s->vga.vram_size_mb != 16) {
> 2957         error_setg(errp, "Invalid cirrus_vga ram size '%u'",
> 2958                    s->vga.vram_size_mb);
> 2959         return;
> 2960     }
>
> I will add the 8 and 16MB then in v2.

Please check that  it is >= VRAM_SIZE, so we're flexible.

Best regards
Thomas

>
>>> [Severity: High]
>>> Is it safe to place this validation check after the call to
>>> aperture_remove_conflicting_pci_devices() earlier in cirrus_pci_probe()?
>>>
>>> If this new size check fails (either due to a malformed device or a larger
>>> valid VRAM size), cirrus_pci_probe() aborts with -ENODEV. However, because
>>> aperture_remove_conflicting_pci_devices() was already executed at the start
>>> of the probe function, the firmware framebuffers (like efifb or simplefb)
>>> have been permanently destroyed.
>>>
>>> Could this leave the system with a dead display output? Would it make sense
>>> to move this PCI configuration check to the very beginning of the probe
>>> function, before any destructive actions occur?
> Yeah I guess this new check can be before aperture_remove_conflicting_pci_devices().
>
>>>>    	cirrus->vram = devm_ioremap(&pdev->dev, pci_resource_start(pdev, 0),
>>>>    				    pci_resource_len(pdev, 0));
>>>>    	if (cirrus->vram == NULL)

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


