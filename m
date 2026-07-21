Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81244C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAB7610E2F9;
	Tue, 21 Jul 2026 12:34:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="ZerweVVR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aRM/syaU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="haJtgDw1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="85mOsnWH";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61BA810E2F9
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 12:34:34 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 78BD87A4FC;
 Tue, 21 Jul 2026 12:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784637272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XLC7K3D+fscEP1Bhu5yk5sMhY01/G+sILu3WrR3mOT8=;
 b=ZerweVVRqnhWCTh/pmN3goQnc9vy3zDXNJ41HilrRnOgR+AIHTaB8itQWFNDUHkw5s+qUc
 l2jhHVh6A1M2ugKLSkdNt6kGftoeRmQG8RBqS9QhUtChsprLYq81jAexUnrJdmSRfGAz3c
 fTq5SwAot4vrZRE/bLZJtVq0Vy0m9tU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784637272;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XLC7K3D+fscEP1Bhu5yk5sMhY01/G+sILu3WrR3mOT8=;
 b=aRM/syaU0BCPZXaj/piBuA7jTu4XH6Gi5eVrd4Dlnc4rudYvjNOWzVpTeKm0Zh0xxY55V2
 haguG6oZsxtYC+Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784637271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XLC7K3D+fscEP1Bhu5yk5sMhY01/G+sILu3WrR3mOT8=;
 b=haJtgDw1Bc0odZVwis5kFtOsU126qaQ6M6N90b1Y3M8gxsn0gI4WHviQNrd4zTOatv5lMn
 N+RD9kQrQqbVxvGuWohzbDTYJ+V3PgzcDBub6VGKld+EqGBxdlRgyFIE6fxFUxcQFyEaVr
 lpEYI0nFKE1QKhTXVNC2IEGT+4YeKK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784637271;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XLC7K3D+fscEP1Bhu5yk5sMhY01/G+sILu3WrR3mOT8=;
 b=85mOsnWHdhsBaRxZ4y2FJROWU/SWiYT6qs9BLMgGpe9Ft851EKuEgAl8r+n6MlwA+9DjZv
 Ox1dlEqnfY6rr1Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB8F8779AA;
 Tue, 21 Jul 2026 12:34:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ee4BJlVnX2qXUwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 21 Jul 2026 12:34:29 +0000
Message-ID: <83da6a1a-4fa4-43e4-aaab-775ff4f127d5@suse.de>
Date: Tue, 21 Jul 2026 14:34:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] drm: Add DRM driver for GlandaGPU (VHDL soft-IP
 GPU)
To: Leander Kieweg <kieweg.leander@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
References: <20260714101146.200416-1-kieweg.leander@gmail.com>
 <69a8c2a6-d0f3-4362-bfa1-04923db6f3cc@suse.de>
 <CAMwcS0g6S5f4vnyS6KEmsLFmTW=YmnSAY06OTovPWqza4iFwTg@mail.gmail.com>
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
In-Reply-To: <CAMwcS0g6S5f4vnyS6KEmsLFmTW=YmnSAY06OTovPWqza4iFwTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[dt]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_TO(0.00)[gmail.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,gmail.com,ffwll.ch,linux.intel.com,kernel.org];
 RCPT_COUNT_SEVEN(0.00)[10]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
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

Am 16.07.26 um 23:19 schrieb Leander Kieweg:
> Hi Thomas,
>
> Thanks a lot for the detailed feedback, this is exactly the kind of
> guidance I was hoping for.
>
>> We already have a driver for a RasPi-based USB display that someone made
>> in their spare time. So being a hobbyist project is not a problem per se.
> Good to know, thanks for clarifying that.
>
>> 2d primitives are likely not very useful for DRM. The canonical
>> reference of why is at [1]. The tl;dr is that there's no standard API,
>> and GPU-CPU transfers and setup costs are too high to make it
>> significantly faster than software rendering.
>>
>> Various people have proposed to add some form of 2d pipeline to DRM, but
>> nothing concrete has ever emerged.
>>
>> Conceptually, DRM doesn't really render anything. It composes the screen
>> from already-rendered buffers. Rendering to these buffers is mostly done
>> by Mesa drivers with some help from DRM's kernel drivers. If you want
>> hardware rendering, you'd need memory management for off-screen
>> rendering that Mesa can use independently from display output. Therefore
>> these simple draw and clear primitives aren't that useful. You need to
>> design a full rendering pipeline instead.
>>
>> [1] https://blog.ffwll.ch/2018/08/no-2d-in-drm.html
> Sima's blog post that you linked makes the reasoning much clearer than what
> I'd pieced together on my own. I understand this means the current
> fixed-function
> ioctls are really only a placeholder, not something to build on further as is.
>
>> Using a single ioctl per command will kill performance. So, if anything,
>> you'd want the command-buffer model.  To make it fast for 2d primitives,
>> you'd likely have to model it like a 3d pipeline: have all 2d graphics
>> buffers in the display memory already and submit a large batch of
>> rendering commands that generate the entire screen at once.
> That's a helpful concrete direction, thank you. I'll look into what a
> command-buffer submission model would need to look like for this.
>
>> Rule of thumb is that you need a working user-space side for ioctls.
>> Mesa would be the premier target for 3d.
>>
>> I'm not much involved in Mesa, but I think Mesa is quickly moving
>> towards programmable pipelines. Getting drivers for fixed-function
>> hardware merged might be hard.
>>
>> How complicated is it to model a stream processor (i.e. GPU core) in VHDL?
> I think it's doable at a small scope. Some memory to hold uploaded
> bytecode, a minimal CPU core (I'd probably base the ISA on a reduced
> RISC-V subset, mainly to get an existing compiler toolchain for free)
> that processes it and writes the result into the framebuffer. That
> part sounds genuinely fun to build, and I'm actually looking forward
> to it, though it's a fair amount of work and I'll need to find the
> time for it.
>
> For throughput I'd design the core with multiple instances in mind
> from the start, e.g. 4 cores each responsible for a quarter of the
> screen, and scale that further once the basic version works. I'd
> still get a single instance working first before parallelizing it.
>
>> Can you use a PCI device for that and let the kernel do all the work?
>> See [2] for how to get a PCI device id.
>>
>> [2] https://www.qemu.org/docs/master/specs/pci-ids.html
> I want to make sure I understand this correctly before I start on
> it. My real hardware (DE10-Standard) stays exactly as it is, still
> using platform_driver via devicetree, completely unchanged. Only the
> QEMU device would change, from the current fixed-address platform
> device to a proper virtual PCI device (with a reserved vendor/device
> ID and BARs for VRAM/MMIO). On the driver side, that would mean
> adding pci_driver support alongside the existing platform_driver, so
> the exact same driver would run on both, just with two different
> probe functions depending on whether it's found via devicetree (real
> hardware) or via PCI enumeration (QEMU). Is that right?

Yes, exactly this. I'm not sure if you can have both in a single module 
.ko file, but your driver can have multiple modules.



>
>> That's indeed a good thing to have in hardware.
>>
>> I mentioned that the 2d/3d rendering is probably complicated to get
>> done. If I may suggest an alternative, you could implement additional
>> features of the mode-setting pipeline. Besides the primary plane that
>> your hardware already supports, you could add a cursor plane. Or you
>> could add overlay planes for displaying YUV formats (i.e., video
>> frames). Or you could implement existing DRM properties, such as
>> scaling, background colors, or HDR.  These features are already
>> supported by user space. Your device would be usable immediately.
> This is a great suggestion, thank you. A hardware cursor plane
> actually fits something I'd already been considering for the hardware
> side, so that'll be my next bigger hardware update.
>
> Scaling looks approachable too, and I like that it wouldn't need
> extra memory on the hardware side, so I'm adding that to the list as
> well. Background color I think I can already cover with the existing
> CLEAR command.

To clarify: background color is a hardware feature.  Pixels have an 
alpha channel that blends them with the underlying plane.  On the 
primary plane, there's no underlying plane. So it would be black. Some 
hardware also allows to configure this to some other color per CRTC.


>
> YUV overlay support is more future work for me, my current memory
> layout would need a bigger restructuring first to fit that in given
> how limited memory is on this hardware, but the idea itself sounds
> appealing since the VHDL side looks fairly contained. HDR isn't
> realistic here either way, my test display can't do it and I'd
> expect to hit memory limits before anything else.

Indeed. I think, if you want to add some more advanced features, you 
will need more memory for the device.

Best regards
Thomas


>
>> Glad to hear it didn't work. drm_simple_display_pipe is obsolete and on
>> its way out. Please don't use it.
> Good to know, I'll drop that idea entirely then.
>
> Given all this, my plan for v2 is to drop the ioctl-based UAPI
> entirely (removing the custom ioctls means there's no UAPI to keep
> stable, which takes the pressure off getting the command-buffer
> design right immediately), address the style/review comments from
> Uwe and from your code review on patch 2, switch the QEMU test path
> from the fixed-address platform device to a proper PCI device as
> discussed above, and possibly add background color support since
> that doesn't require any hardware changes. The cursor plane, scaling,
> and the stream processor work will be separate follow-ups once the
> hardware side catches up.
>
> Thanks again for taking the time, this gives me a lot to work with.
>
> Best regards,
> Leander

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


