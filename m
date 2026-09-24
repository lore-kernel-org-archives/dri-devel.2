Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC68C98317
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B075210E191;
	Thu, 24 Sep 2026 12:21:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Yr3oUlsx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w2JK/jvU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xvPUmbsM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jz7LgWUL";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 719AB10E191
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 12:21:49 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8BB6C21F73;
 Thu, 24 Sep 2026 12:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790252503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f7HtuDW9EZkGwdWyeKYvLGrIi0LDhwnCyUDBSw+fqUc=;
 b=Yr3oUlsx8kjSIcqj5bLafBkbx/Mzxqti5iY6lEZvW0/Tgb/XPm9LBiaP5rTqVdAxhhJbcm
 yrRw2WIXmrQjp4b04bUVfTIFHGpJCNIi0+VweCS0CuGhjDExoEyblWGE9/z6I4Ml2qWVad
 d+Qsx293UGTD2Gm1g4AbJIylF6QC9z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790252503;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f7HtuDW9EZkGwdWyeKYvLGrIi0LDhwnCyUDBSw+fqUc=;
 b=w2JK/jvUK/8O73meT8M8WqcWfj8vatAQyKH67wUQjDhYe+2ZvrGO1XSm5wn54yQAa0t2YV
 8+MtJ366/3tt9hDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xvPUmbsM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Jz7LgWUL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790252499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f7HtuDW9EZkGwdWyeKYvLGrIi0LDhwnCyUDBSw+fqUc=;
 b=xvPUmbsMJCEsQ0P0jVpfuBcTIxgwHSQRhkvsnEQmCfYvoQAVg57+/dOD7Ueh8p/sDvWq28
 cTta5Q/emspvBFdvRJfRCGc3O7A6UEBn0xGdmYcdbSBYWN4gh0xt0yPtwGN+9/SxwWFgaz
 dxk/cnSDU4fA7+tUk3UYjfNxce2rGT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790252499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f7HtuDW9EZkGwdWyeKYvLGrIi0LDhwnCyUDBSw+fqUc=;
 b=Jz7LgWULCLTX1xDD9uoQWN7j+ft3z2NWOrRVczmiJQWuwon8lekZIqZg8a9rUA1BYEQlk1
 r4k35/oOBRLMAqBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAC3F1366F;
 Thu, 24 Sep 2026 12:21:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OeCFLdIVtWq/XwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 24 Sep 2026 12:21:38 +0000
Message-ID: <64e273d4-2660-437d-8871-e2bfa3c377c9@suse.de>
Date: Thu, 24 Sep 2026 14:21:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Boot logo supplied by the device tree
To: Max Pedraza <maximpedraza@gmail.com>, Helge Deller <deller@gmx.de>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260923201035.51007-1-maximpedraza@gmail.com>
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
In-Reply-To: <20260923201035.51007-1-maximpedraza@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8BB6C21F73
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,gmx.de,ffwll.ch,kernel.org];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[11]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[dt];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
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

Hi,

the whole Linux logo on the console is somewhat gimmicky and IMHO should 
not be further extended. Also fbdev as a whole has realistically run its 
course. We fix bugs and occasionally clean up the code, but it is 
questionable whether new feature make much sense. Even more so as the 
drivers your system uses appear to be DRM ones.

There is a proposal for a DRM splash screen at [1]. It retrieves the 
device vendor's logo from the firmware and displays it at the given 
coordinates. IMHO you should start with this series and add DT support 
there.

Best regards
Thomas

[1] 
https://lore.kernel.org/dri-devel/20260510-drm_client_splash-v3-0-a9aee9f0b2fc@valla.it/


Am 23.09.26 um 22:10 schrieb Max Pedraza:
> Embedded products routinely need their own boot logo. Today that means
> pointing CONFIG_LOGO_LINUX_CLUT224_FILE at a different image, which bakes
> it into the kernel image. Two products that share a board support package
> but differ in branding therefore need two kernel builds, and rebranding an
> existing product means rebuilding and requalifying a kernel for what is
> purely a cosmetic change.
>
> This series lets the logo be described by the device tree instead: a node
> compatible with "boot-logo-clut224" under /chosen supplies the image in
> the same paletted format the built-in CLUT224 logos already use, and the
> kernel prefers it over the built-in ones when it is present and enabled.
> If the node is absent or disabled, nothing changes.
>
> The image can come from the node itself (patches 2-3) or from a reserved
> memory region the bootloader filled in (patches 5-6), because the image
> and its placement are independent axes of variation. One board sold to
> several customers wants several device trees differing in the logo. One
> customer with several products built on that board, with different panels,
> wants the same logo placed differently on each: there the image belongs in
> a shared binary and only the placement belongs in the device tree.
>
> Patch 1 is a cleanup that stands on its own. fb_prepare_logo() works out
> how many rows to keep clear for the logo and fb_show_logo_line() works out
> where to draw it, and both open code the same decision; nothing makes them
> agree, even though fbcon erases whatever falls outside the rows that were
> reserved. It gives the position a structure of its own, in linux_logo.h,
> with -1 on an axis meaning centre on that axis, so that fb_center_logo
> becomes a value rather than a second code path and both callers share one
> calculation. No functional change. The device tree placement in patch 4
> then only fills the same structure in from the node, which is parsed in
> logo.c next to the image that comes from it, so that everything that knows
> the binding lives in one place and the frame buffer code only asks for the
> result.
>
> We have been carrying a cruder version of this downstream on an AM335x
> product since 2020, across a handful of board revisions, and it has
> removed a real maintenance burden for us.
>
> Where this fits
> ---------------
>
> There are already ways to get a picture on the screen early, and this does
> not replace any of them. A bootloader splash handed over through a
> simple-framebuffer node is the earliest of all. A userspace splash is the
> most flexible, and is what most systems end up using. What neither covers
> is the case where nothing initialises the display before the kernel does.
>
> That case is not exotic. U-Boot's SPL can boot the kernel directly, and
> display initialisation lives in U-Boot proper, which then never runs:
> there is no splash to hand over and nothing for a simple-framebuffer node
> to point at. Falcon mode exists to cut boot time, which is the same reason
> one cares about how early the logo appears, so the two tend to arrive
> together. Userspace is far too late to fill that gap: on the board I
> tested, the kernel has the panel up at 3.2 seconds.
>
> Rob Herring asked in v2 why a simple-framebuffer handover would not do,
> and I answered that it did not work on our hardware. That was wrong, and I
> am correcting it here: the node I had measured it with was incomplete, and
> with a complete one it does work. What it does not do is help where there
> is no splash to hand over in the first place, and it does not survive the
> native driver.
>
> simplefb registers fb0 at 1.79 seconds with the bootloader's image; tilcdc
> initialises at 3.16 seconds, registers its own fb1 and reprograms the
> controller to scan that buffer, which starts empty, so the screen goes
> black. Nothing is evicted and nothing is cleared: the two frame buffers
> coexist, and cat /dev/fb0 > /dev/fb1 brings the picture straight back. It
> is only that nobody does it, and by the time anything could, userspace is
> already up, which is the moment a splash was there to cover. With
> simpledrm it does not even survive in memory, since it hands its clients
> shmem buffers and blits them onto the firmware framebuffer, so the first
> frame any client commits overwrites what the bootloader drew. A logo the
> kernel draws itself has none of this: there is nothing to carry across.
>
> Notes on the binding
> --------------------
>
>    - The compatible has no "linux," prefix. Rob asked why it was Linux
>      specific, and nothing in the node is: it describes an image and where
>      it goes, which any consumer can read. A bootloader drawing the same
>      logo before the kernel starts is the obvious other one. The 224 is the
>      palette limit of the format, which is what lets the kernel use the
>      image the way it already uses its built-in logos, without converting
>      it.
>    - The palette size is derived from the length of the "clut" property
>      instead of being a separate property, so it cannot disagree with the
>      palette actually supplied.
>    - "data" holds plain palette indices. The 32 entry offset the frame
>      buffer layer reserves for the console is an implementation detail and
>      is applied by the kernel.
>    - "logo-position" takes -1 on an axis to mean centre on that axis, which
>      is what fb_center_logo already meant. A boolean could only centre both
>      axes or neither, and next to explicit coordinates it would have to
>      override them silently.
>    - "logo-rotation" turns the logo, not the screen. "logo-position" and
>      "logo-offset" are screen pixels whatever the rotation says, and a
>      quarter turn only changes how much room the logo takes up.
>    - "logo-position" and "logo-offset" are spelled with the prefix because
>      plain "position" and "offset" are already used elsewhere in the tree
>      with an incompatible type, which dtschema rejects.
>    - The reserved memory path takes a "memory-region" phandle rather than a
>      bare address. The reservation is what makes the memory safe to read at
>      all, and it is what gives the kernel a size to bounds check against.
>
> The byte arrays are not written by hand: patch 7 adds ppmtodtlogo, a host
> tool along the lines of the existing pnmtologo -- plain C, no
> dependencies, no quantization of its own -- that turns a PPM image into
> the node or into the memory region blob. It is what produced everything
> tested below.
>
> Until chosen.yaml knows about the node, dtbs_check rejects it on any board
> that uses it: it allows only ^framebuffer under /chosen. I sent that one
> line change as dt-schema pull request 204, and Rob closed it saying he
> expects it is either not needed or will change, given this discussion.
> That seems like the right order to me, so I am not asking for it again
> here: once the shape of the binding is settled, the schema change follows
> from it, and I will send it then.
>
> On a system that has DRM but no frame buffer device, nothing draws the
> logo at all: fbcon is what draws it today, and without it there is no
> consumer. Showing it there needs an in-kernel DRM client, which I have
> working on top of this series and will send separately. I mention it
> because it is the reason the node is parsed in logo.c rather than in
> fb_logo.c: the same node then puts the logo on the same pixel whichever of
> the two draws it, rotated or not, which I checked on the same board.
>
> Testing: built for arm with CONFIG_LOGO_DT_CLUT224 both enabled and
> disabled, and each of the seven patches builds on its own, with the option
> enabled from the patch that introduces it. Also built for x86_64 with
> CONFIG_OF=n, where nothing is left unresolved and the placement data is
> dropped from the image, and for powerpc Cell -- where SPU_BASE makes
> CONFIG_FB_LOGO_EXTRA real -- to a linked vmlinux. No compiler warnings,
> W=1 clean on the files touched, checkpatch --strict clean apart from the
> MAINTAINERS reminder for the new tool, which the existing drivers/video/
> entry already covers. A full dt_binding_check has one complaint for this
> binding and none other in the whole tree: the chosen.yaml rejection
> described above.
>
> Boot tested under qemu-system-arm -M versatilepb with PL111 and fbcon, at
> 16bpp, over a 26 case matrix: absolute positions, per axis centring, all
> four corners, offsets including negative ones, out of range values, the
> three rotations, and each rotation combined with an offset and with an
> absolute position, each compared pixel by pixel against the source image
> rotated to match. A position out of range on both axes is clamped to the
> corner, and the console text then overwrites the rows below what fbcon
> reserved. Supplying the same image through a reserved region instead
> produces an identical logo area. Blobs with a bad magic, a geometry larger
> than the reservation and an out of range pixel are each rejected with a
> warning, with no logo drawn and no crash.
>
> Also boot tested on real hardware: an AM335x board (tilcdc) with an
> 800x480 panel at 16bpp. The product logo comes up where the node asks,
> both carried in the device tree and taken from a bootloader-loaded
> reserved memory region, and the two produce a frame buffer that is
> identical byte for byte. Dumping /dev/fb0 and comparing it against the
> source image, the logo lands on exactly the pixel the binding predicts:
> 16836 of 16836 pixels match, and one pixel of displacement in any
> direction drops that to about 90%. With logo-rotation = "ccw" it lands on
> the rotated position the same way, every pixel.
>
> Changes since v2:
>    - Rebased onto current mainline (v7.3-rc3).
>    - Dropped the "linux," prefix from the compatible, and renamed the
>      binding to match, per Rob.
>    - A rotation asked for by the device tree now turns the logo and not the
>      screen: "logo-position" and "logo-offset" stay in screen pixels, and a
>      quarter turn only changes how much room the logo takes up. v2 fed the
>      device tree rotation into the path fbcon uses for a rotated console,
>      which places the logo in the console's own frame and maps the result
>      back, so a vertical offset came out horizontal on a screen that was not
>      rotated. Found by testing it on the panel. fb_rotate_logo() is split
>      into the part that turns the image and the part that moves the
>      placement, and the console path is unchanged.
>    - The placement properties are read in logo.c, next to the image, and the
>      frame buffer code only asks for the result, so that the binding is
>      parsed in a single place.
>    - Added patch 1, which pulls the logo position out into something both
>      fb_prepare_logo() and fb_show_logo_line() share, after Helge pointed out
>      that the placement patch was stamped in rather than merged with the
>      existing code. That turned up a real bug: the reservation took the larger
>      of the console position and the device tree one while the drawing took
>      only the device tree one.
>    - IS_ENABLED() instead of #ifdef, per Helge, so the code is compile checked
>      whatever the configuration.
>    - The device tree is read once, from fb_prepare_logo(), rather than from
>      every accessor.
>    - Dropped "logo-centered" for -1 in "logo-position", per Helge.
>    - The position and offset are added in 64 bits and both are bounded in the
>      binding; in int, a large pair from the device tree wrapped instead of
>      landing against an edge.
>    - The copy of the image is no longer freed from a late initcall, which ran
>      before async_synchronize_full() and so could pull it out from under a
>      display driver still probing. Pixels are allocated with kvmalloc().
>    - The example declares compatible and model on the root node, and the
>      binding no longer requires the image properties unconditionally, which
>      made the reserved memory form unreachable. Both found by Rob's bot.
>    - Extra logos are not drawn when the device tree supplied the logo; they
>      stack up from an arbitrary point once it has been placed.
>
>
> Max Pedraza (7):
>    fbdev: describe where the boot logo goes in one place
>    dt-bindings: display: add a device tree supplied boot logo
>    video: logo: allow the boot logo to come from the device tree
>    fbdev: honour the device tree boot logo placement properties
>    dt-bindings: display: allow the boot logo in a reserved memory region
>    video: logo: allow the boot logo to come from a reserved memory region
>    video: logo: add ppmtodtlogo host tool
>
>   .../bindings/display/boot-logo-clut224.yaml   | 161 +++++++
>   MAINTAINERS                                   |   1 +
>   drivers/video/fbdev/core/fb_logo.c            | 221 ++++++++--
>   drivers/video/logo/Kconfig                    |  12 +
>   drivers/video/logo/Makefile                   |   6 +-
>   drivers/video/logo/logo.c                     | 332 +++++++++++++-
>   drivers/video/logo/ppmtodtlogo.c              | 416 ++++++++++++++++++
>   include/linux/linux_logo.h                    |  59 +++
>   8 files changed, 1170 insertions(+), 38 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/display/boot-logo-clut224.yaml
>   create mode 100644 drivers/video/logo/ppmtodtlogo.c
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


