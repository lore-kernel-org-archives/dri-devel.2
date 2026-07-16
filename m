Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C163C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 21:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CAEA10E0A3;
	Thu, 16 Jul 2026 21:19:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Au5IlBnr";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A82D510E0A3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 21:19:40 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5aeb59d54b1so3148733e87.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 14:19:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784236779; cv=none;
 d=google.com; s=arc-20260327;
 b=Hc8MQxCrQU9P09iNi2y2wHAcKcJR+YxXZvHbIcSmRWGdnakuENm7Y5MaYHE3CcYj1t
 1FV5bgtVnn831xycrgwQ7bWHG+lnZFrBthRcjB7MF1NO4EeUvjdHjw7xxDj2dbY9rXyR
 8Xj38a7ViBgW+/SYI5zXezskRXie9nwiqSkz99BtJoq+QOs6ImBD9SijHLaJYh6V8sBW
 Nq32H8bnffz/8Evh/EfOrnMPjOl2Qwfvw51+lonJN4QdVXZl9vqQX2E7PoCsdHWjNBkh
 Pl/RaiyMaUMy1hs8PU7NFstDpGC2ayTbcmZMiwgSLp+uaS3jhCAak36X2aKlLigAeamq
 Tfdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zYJZVa6pJsj5mxAW+2FCJM9HLntDNEgnj0RiqQalRx8=;
 fh=WPdTBFEKs0vFjbrFegYXS1FuS3VesTcjYiSpkHYhSsM=;
 b=jPOQSzcI9N/JNqzZIPCNNoTGaW3Ikwk60Z9ZZTkg9HiZHc7sXagFaVVDh7vZEbI0Zl
 T7la3KOp5P8tQ4Q8qSLlzv4TkYDvOFSmzwH+QxxM74YUInfzLv7ibST/uH6Xyvkv8i/f
 O3zRfRu7BVrNegHA11Xj3HutI7nTTbeXWygdP308syk9Y8Di9xXyIy5yJgb9eKfpPRO3
 rkHMtk966lQ7Zf8XgQ93Ef+5C+3vxG7ZOGPMxrh8Njua42TwKAHvpLsuSaOptVtyX5CP
 lyLaM+ZoVnREI9UMzKHdxcxiNzAZN9WVvWSPhfzTOawsCfbuA+jAjFSBQdf+jzNqbSoQ
 QbDw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784236779; x=1784841579; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zYJZVa6pJsj5mxAW+2FCJM9HLntDNEgnj0RiqQalRx8=;
 b=Au5IlBnrngKboyYZtutp0OyxmgZIYznbcFpPcgfhaf8ajijFlTiOi4RvkMwBz3kzwZ
 7ihcaAHiDUxxg3LJN1YIXM8IMx6FHEMp8p0GHifekkR7ykF26vXnRvp+CcH3fSOWq51W
 q+RwMp2AYmGbR6e856pPYz6Hr+mgW1DwQ5CmSVhiijHvXs88HG/+3GfuK1sBtsglaQgb
 7Bh+9/NpwqF3a4XFbmbLQGP5EQFy6iaLFvtD//ZmSrRqEEC7Rl0F0/AJAOOBuBKScI5g
 V1DPDFE2vj8SVuy6FnQkkNhl9blWBK2AwRseef41cGmto5K7EHdVErWsJYqFgHQSVVZm
 il9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784236779; x=1784841579;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zYJZVa6pJsj5mxAW+2FCJM9HLntDNEgnj0RiqQalRx8=;
 b=nTc45lX3pnluokMP3bjUXFUnQfP1IAbRpoSMjqFUC2GiEStX2pnxbguCSZsxCsJPvo
 DOIzgXP/4Iu/CeTTyoMSTG6LwRAtTmwZJKqN7IoXndrGUO7nQsr3JKFoUl1w3+XPOm86
 ctCD5oxBiQWU5R9efz4xocjLpb6OtkBwDwa4+ys8uiI4xqg24bfEICobnJ57vYL6fQdf
 T2VLNMtjhi+mAP88msM9oOqq/LpFJr+ljLIONpxcf5Suy6Bzl/jb4FFI7NhAbuJM+zBP
 VKZa+qsW8NSMb2iuF0X7c956j1odSWK8TYoxUnxE70XblDnxdJg3TSgFY5JRFNdWSiE2
 /bKA==
X-Gm-Message-State: AOJu0YypITB+4qiUozS73cIjRE9j/Hg7qLDokQeUzp8IYAtMqEMfteEI
 4o/EOxDNYx6ifDgUt6BWXZ7kKq1d1u6R7ioGG49ZmGFEfPsHEtinw48I3Cx2Vd2TgwGbGi/1ipj
 p84nfZBCm0g0Rd0XPXLSLeTH/4mDgKC8=
X-Gm-Gg: AfdE7cnNpcD2CprASnch7gKvaUuXXoZWWwskgOOskYg9J8qCzvLkYTGwJA9UBpdihCo
 Vf+I6NWTYyWpZCCW+yllZNv5LGHDHcX6McFKgK0PhTXOlEdyBwaPIXBlTUOlTok6lIhLb0FgkNp
 jxtih++PDWIqsI2Af8WyMwELz3nZfP53uISXr6+L6b5inRa2jhBDdt95jUC42WsNFRoCWNamfer
 Ulupj0eHCMMlEW9paUSHLgxuNYPTQopy4PQ4Brseb2JPJaFbheSGNZ4MRYRcOZYNX5K7iYYPegw
 CzgMPso3czEnzYPu2QPEjzQnEQJ80YM/LhafY/ZZfWBZ1QUv/wwNxYX6rDT9DsJ8BjpbKh8Uumi
 v6A9O
X-Received: by 2002:a05:6512:3ca0:b0:5ae:bbe5:2076 with SMTP id
 2adb3069b0e04-5b28dd6f98bmr123691e87.52.1784236778311; Thu, 16 Jul 2026
 14:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260714101146.200416-1-kieweg.leander@gmail.com>
 <69a8c2a6-d0f3-4362-bfa1-04923db6f3cc@suse.de>
In-Reply-To: <69a8c2a6-d0f3-4362-bfa1-04923db6f3cc@suse.de>
From: Leander Kieweg <kieweg.leander@gmail.com>
Date: Thu, 16 Jul 2026 23:19:26 +0200
X-Gm-Features: AUfX_mzGxb4_nZhrElpdqX1OGlkRyvGXZ3ROjXjZTkwCFoQscuHHMNBlRZzaLmk
Message-ID: <CAMwcS0g6S5f4vnyS6KEmsLFmTW=YmnSAY06OTovPWqza4iFwTg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] drm: Add DRM driver for GlandaGPU (VHDL soft-IP
 GPU)
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Thomas,

Thanks a lot for the detailed feedback, this is exactly the kind of
guidance I was hoping for.

> We already have a driver for a RasPi-based USB display that someone made
> in their spare time. So being a hobbyist project is not a problem per se.

Good to know, thanks for clarifying that.

> 2d primitives are likely not very useful for DRM. The canonical
> reference of why is at [1]. The tl;dr is that there's no standard API,
> and GPU-CPU transfers and setup costs are too high to make it
> significantly faster than software rendering.
>
> Various people have proposed to add some form of 2d pipeline to DRM, but
> nothing concrete has ever emerged.
>
> Conceptually, DRM doesn't really render anything. It composes the screen
> from already-rendered buffers. Rendering to these buffers is mostly done
> by Mesa drivers with some help from DRM's kernel drivers. If you want
> hardware rendering, you'd need memory management for off-screen
> rendering that Mesa can use independently from display output. Therefore
> these simple draw and clear primitives aren't that useful. You need to
> design a full rendering pipeline instead.
>
> [1] https://blog.ffwll.ch/2018/08/no-2d-in-drm.html

Sima's blog post that you linked makes the reasoning much clearer than what
I'd pieced together on my own. I understand this means the current
fixed-function
ioctls are really only a placeholder, not something to build on further as is.

> Using a single ioctl per command will kill performance. So, if anything,
> you'd want the command-buffer model.  To make it fast for 2d primitives,
> you'd likely have to model it like a 3d pipeline: have all 2d graphics
> buffers in the display memory already and submit a large batch of
> rendering commands that generate the entire screen at once.

That's a helpful concrete direction, thank you. I'll look into what a
command-buffer submission model would need to look like for this.

> Rule of thumb is that you need a working user-space side for ioctls.
> Mesa would be the premier target for 3d.
>
> I'm not much involved in Mesa, but I think Mesa is quickly moving
> towards programmable pipelines. Getting drivers for fixed-function
> hardware merged might be hard.
>
> How complicated is it to model a stream processor (i.e. GPU core) in VHDL?

I think it's doable at a small scope. Some memory to hold uploaded
bytecode, a minimal CPU core (I'd probably base the ISA on a reduced
RISC-V subset, mainly to get an existing compiler toolchain for free)
that processes it and writes the result into the framebuffer. That
part sounds genuinely fun to build, and I'm actually looking forward
to it, though it's a fair amount of work and I'll need to find the
time for it.

For throughput I'd design the core with multiple instances in mind
from the start, e.g. 4 cores each responsible for a quarter of the
screen, and scale that further once the basic version works. I'd
still get a single instance working first before parallelizing it.

> Can you use a PCI device for that and let the kernel do all the work?
> See [2] for how to get a PCI device id.
>
> [2] https://www.qemu.org/docs/master/specs/pci-ids.html

I want to make sure I understand this correctly before I start on
it. My real hardware (DE10-Standard) stays exactly as it is, still
using platform_driver via devicetree, completely unchanged. Only the
QEMU device would change, from the current fixed-address platform
device to a proper virtual PCI device (with a reserved vendor/device
ID and BARs for VRAM/MMIO). On the driver side, that would mean
adding pci_driver support alongside the existing platform_driver, so
the exact same driver would run on both, just with two different
probe functions depending on whether it's found via devicetree (real
hardware) or via PCI enumeration (QEMU). Is that right?

> That's indeed a good thing to have in hardware.
>
> I mentioned that the 2d/3d rendering is probably complicated to get
> done. If I may suggest an alternative, you could implement additional
> features of the mode-setting pipeline. Besides the primary plane that
> your hardware already supports, you could add a cursor plane. Or you
> could add overlay planes for displaying YUV formats (i.e., video
> frames). Or you could implement existing DRM properties, such as
> scaling, background colors, or HDR.  These features are already
> supported by user space. Your device would be usable immediately.

This is a great suggestion, thank you. A hardware cursor plane
actually fits something I'd already been considering for the hardware
side, so that'll be my next bigger hardware update.

Scaling looks approachable too, and I like that it wouldn't need
extra memory on the hardware side, so I'm adding that to the list as
well. Background color I think I can already cover with the existing
CLEAR command.

YUV overlay support is more future work for me, my current memory
layout would need a bigger restructuring first to fit that in given
how limited memory is on this hardware, but the idea itself sounds
appealing since the VHDL side looks fairly contained. HDR isn't
realistic here either way, my test display can't do it and I'd
expect to hit memory limits before anything else.

> Glad to hear it didn't work. drm_simple_display_pipe is obsolete and on
> its way out. Please don't use it.

Good to know, I'll drop that idea entirely then.

Given all this, my plan for v2 is to drop the ioctl-based UAPI
entirely (removing the custom ioctls means there's no UAPI to keep
stable, which takes the pressure off getting the command-buffer
design right immediately), address the style/review comments from
Uwe and from your code review on patch 2, switch the QEMU test path
from the fixed-address platform device to a proper PCI device as
discussed above, and possibly add background color support since
that doesn't require any hardware changes. The cursor plane, scaling,
and the stream processor work will be separate follow-ups once the
hardware side catches up.

Thanks again for taking the time, this gives me a lot to work with.

Best regards,
Leander
