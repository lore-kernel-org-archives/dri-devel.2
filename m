Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4CEC44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CBE910E132;
	Wed, 15 Jul 2026 13:02:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="YDFrDkQj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="umqU3idl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OQQTPGAd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5aZKSF2k";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 498E510E132
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 13:02:50 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D18983E32;
 Wed, 15 Jul 2026 13:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784120567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Zn5TUF2JrLRskPZDKlSpfO914IbDbWxlosyWdVR9LC8=;
 b=YDFrDkQj6DSD4Sf6b/M0s532pk1XSBN8+HQsfopPCZyJrrUToGGhszVCrr07JQIi5Jwkvl
 rZ7ckDecs7FtoSr+9AvU98fTakthSNHQKCqiVqVqdCybR/kAQcv0bHKqCIb1OQs3Zi/RFB
 IWkA07hZhgR++tKv4txwX1Z99GHFi6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784120567;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Zn5TUF2JrLRskPZDKlSpfO914IbDbWxlosyWdVR9LC8=;
 b=umqU3idl9U8YCaTlmOxwojkdhJ7GCt2kkjIl/biN/D5fRZL8QF8140p5QvpyftViDeWARx
 Y4gdSErUNQp5VNBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784120562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Zn5TUF2JrLRskPZDKlSpfO914IbDbWxlosyWdVR9LC8=;
 b=OQQTPGAdmboTpsQrU2RVJmtlgb7oz1oelO0oXO73aLQNwNSm818gfUp9DHgeN89hf+UFUj
 eKWGGpix5oCogal0sbiMeFvi+gbJr+qYpovlbnRCwINt8LLSwiUtrPdPThbBVjuZwvqde3
 nBFkSGTjrth2jpF0Pimu+c/zbc4OQGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784120562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Zn5TUF2JrLRskPZDKlSpfO914IbDbWxlosyWdVR9LC8=;
 b=5aZKSF2kRKpPwBUkFABWvcVsu7KYoD+I3zrAUu5yX8KIT/KX7m5uO8Oa/mcHaiKPGMVduQ
 kTeiKfMefiAOMuCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84A67779AD;
 Wed, 15 Jul 2026 13:02:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6kKNHvKEV2rUdwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 15 Jul 2026 13:02:42 +0000
Message-ID: <69a8c2a6-d0f3-4362-bfa1-04923db6f3cc@suse.de>
Date: Wed, 15 Jul 2026 15:02:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] drm: Add DRM driver for GlandaGPU (VHDL soft-IP
 GPU)
To: Leander Kieweg <kieweg.leander@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
References: <20260714101146.200416-1-kieweg.leander@gmail.com>
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
In-Reply-To: <20260714101146.200416-1-kieweg.leander@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[dt]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org,vger.kernel.org];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,linux.intel.com,kernel.org];
 RCPT_COUNT_SEVEN(0.00)[10]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ffwll.ch:url, 60hz:email, suse.com:url,
 imap1.dmz-prg2.suse.org:helo, suse.de:mid, qemu.org:url]
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

Am 14.07.26 um 12:11 schrieb Leander Kieweg:
> Hi everyone,
>
> This series adds a DRM driver for GlandaGPU, a custom open-source 2D
> graphics core I designed in VHDL. It currently runs on a Cyclone V
> SoC (Terasic DE10-Standard), with VGA output at 640x480@60Hz. I also
> built a QEMU fork that emulates the same MMIO/VRAM interface as a
> digital twin, so I can develop and test without needing the FPGA
> board.

That is a pretty cool project.

>
>    Hardware/VHDL:    https://github.com/stiangglanda/GlandaGPU
>    QEMU fork:        https://github.com/stiangglanda/qemu-glandagpu
>    Userspace tests:  https://github.com/stiangglanda/GlandaGPU-userspace-tests
>
> I'm sending this as an RFC because I'd like feedback on the
> following points before cleaning up the series further:
>
> 1) Mainline viability of custom FPGA hardware
>
>     GlandaGPU isn't a commercial chip, it's an open-source soft GPU
>     core. The DE10-Standard itself is a regular purchasable dev
>     board, and the RTL is public, so anyone can reproduce the exact
>     hardware. Testing doesn't require the FPGA either, since the
>     QEMU twin models the same interface. I know this is unusual
>     compared to typical mainline DRM hardware. I'd like to know
>     whether this is workable, or whether it's a dealbreaker for
>     mainline.

We already have a driver for a RasPi-based USB display that someone made 
in their spare time. So being a hobbyist project is not a problem per se.

>
> 2) UAPI / ioctls / userspace
>
>     The driver currently exposes three fixed ioctls (CLEAR,
>     DRAW_RECT, DRAW_LINE), mapping directly onto the current
>     hardware command set. I have two related questions here:

2d primitives are likely not very useful for DRM. The canonical 
reference of why is at [1]. The tl;dr is that there's no standard API, 
and GPU-CPU transfers and setup costs are too high to make it 
significantly faster than software rendering.

Various people have proposed to add some form of 2d pipeline to DRM, but 
nothing concrete has ever emerged.

Conceptually, DRM doesn't really render anything. It composes the screen 
from already-rendered buffers. Rendering to these buffers is mostly done 
by Mesa drivers with some help from DRM's kernel drivers. If you want 
hardware rendering, you'd need memory management for off-screen 
rendering that Mesa can use independently from display output. Therefore 
these simple draw and clear primitives aren't that useful. You need to 
design a full rendering pipeline instead.

[1] https://blog.ffwll.ch/2018/08/no-2d-in-drm.html


>
>     a) I plan to keep developing the hardware further, which will
>        likely mean more ioctls over time (for example, polygon/3D
>        rendering is one direction I'm considering). Is it acceptable
>        to keep adding a new, separate ioctl for each drawing
>        primitive like this, or should I move to a generic
>        command-buffer submission model instead, similar to
>        DRM_IOCTL_VIRTGPU_EXECBUFFER in virtio_gpu, before this is
>        treated as stable?

Using a single ioctl per command will kill performance. So, if anything, 
you'd want the command-buffer model.  To make it fast for 2d primitives, 
you'd likely have to model it like a 3d pipeline: have all 2d graphics 
buffers in the display memory already and submit a large batch of 
rendering commands that generate the entire screen at once.


>
>     b) If I do end up with an ioctl-based acceleration UAPI, is
>        writing a Mesa/Gallium3D driver the expected way to make it
>        usable from userspace, or is there a lighter-weight option
>        that makes more sense for a project this size?

Rule of thumb is that you need a working user-space side for ioctls. 
Mesa would be the premier target for 3d.

I'm not much involved in Mesa, but I think Mesa is quickly moving 
towards programmable pipelines. Getting drivers for fixed-function 
hardware merged might be hard.

How complicated is it to model a stream processor (i.e. GPU core) in VHDL?


>
> 3) x86 QEMU platform test device
>
>     To let reviewers try the driver against the QEMU twin without
>     cross-compiling an ARM kernel and rootfs, I registered a
>     platform device at a fixed address on x86. I'm aware this
>     doesn't belong in the driver itself, so I isolated it into patch
>     3/3 and marked it "NOT FOR MERGE". Let me know if you'd rather
>     see it dropped entirely, relying only on documentation of the
>     QEMU-on-ARM testing path instead.

Can you use a PCI device for that and let the kernel do all the work? 
See [2] for how to get a PCI device id.

[2] https://www.qemu.org/docs/master/specs/pci-ids.html


>
> 4) Pixel format conversion
>
>     glanda_pipe_update() currently does a per-pixel software
>     conversion from XRGB8888 into the hardware's native packed
>     format on every flip. I'm aware this is a known bottleneck. I'm
>     planning to extend the VHDL to accept XRGB8888 natively so I can
>     drop this conversion entirely. I'm flagging it here as a known
>     limitation rather than blocking on it, since it's a hardware-side
>     change and doesn't affect the UAPI.

That's indeed a good thing to have in hardware.

I mentioned that the 2d/3d rendering is probably complicated to get 
done. If I may suggest an alternative, you could implement additional 
features of the mode-setting pipeline. Besides the primary plane that 
your hardware already supports, you could add a cursor plane. Or you 
could add overlay planes for displaying YUV formats (i.e., video 
frames). Or you could implement existing DRM properties, such as 
scaling, background colors, or HDR.  These features are already 
supported by user space. Your device would be usable immediately.


>
> 5) drm_simple_display_pipe vs. manual plane/CRTC/encoder
>
>     Since the driver only has a single plane, CRTC, and encoder, I
>     tried converting it to use drm_simple_display_pipe instead of the
>     manual setup. It compiled cleanly, but my userspace tests didn't
>     behave the way I expected. I haven't figured out why yet, so I
>     kept the manual setup for this RFC. I'm open to revisiting this
>     if that's the preferred direction.

Glad to hear it didn't work. drm_simple_display_pipe is obsolete and on 
its way out. Please don't use it.

Best regards
Thomas


>
> Testing Status:
>
> The driver has been tested and verified on both the QEMU fork (x86)
> and physical FPGA hardware (ARM) using:
>    - A custom static userspace test: https://github.com/stiangglanda/GlandaGPU-userspace-tests
>    - `modetest -M glandagpu -s 36:640x480 -v` (which successfully
>      displays the test pattern)
>
> Thanks for any feedback,
> Leander Kieweg
>
> Leander Kieweg (3):
>    dt-bindings: display: Add GlandaGPU binding
>    drm/glanda: Add initial DRM driver for GlandaGPU
>    NOT FOR MERGE: drm/glanda: Add x86 platform test device
>
>   .../bindings/display/glanda,gpu.yaml          |  49 ++
>   .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>   MAINTAINERS                                   |   7 +
>   drivers/gpu/drm/tiny/Kconfig                  |  25 +
>   drivers/gpu/drm/tiny/Makefile                 |   1 +
>   drivers/gpu/drm/tiny/glandagpu.c              | 808 ++++++++++++++++++
>   include/uapi/drm/glanda_drm.h                 |  40 +
>   7 files changed, 932 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/display/glanda,gpu.yaml
>   create mode 100644 drivers/gpu/drm/tiny/glandagpu.c
>   create mode 100644 include/uapi/drm/glanda_drm.h
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


