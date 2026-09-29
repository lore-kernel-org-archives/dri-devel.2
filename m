Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7713DC9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A693010E65B;
	Tue, 29 Sep 2026 07:46:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cdt3tarS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B45D210E65B
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 07:46:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B2FF740606;
 Tue, 29 Sep 2026 07:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BEF1F000FF;
 Tue, 29 Sep 2026 07:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790668016;
 bh=XXJUlpDjaiGP4l7mB61rlnHQuI8q3fphbheI6JA+z3Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Cdt3tarSdQ0xIjfn0UtXy9zPr6eFklGIGkuyrgL80AvGIZr8PLzigAGBT0X+PxBNI
 BRzFPOL522zY0RUvtjkZRrEKCi2+8ZkVZK0aLXWrIM+FdOjKES9XYW0ls9VE8hnvj6
 JG4vU7ZqXv+l9jGbt5TfEh87+szt5Bbi/kLq0Zn3VNb/AU9pW8iecEC/GyMXIVLJKE
 vWTnhU+I5VbYbhgOhTMkII1u8l4yMfUdA7SiqHyBcyzxd5XKdDYzGqXzXe7p+Hw79P
 Xx56a0z+5DSEa9ZJLgPNESNnv+NsB/syl+HG0dhWdT9bBsaZ2T4ilAl6ezd0fIVLTk
 y4bbf+sR/xvDA==
Date: Tue, 29 Sep 2026 09:46:47 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Javier Martinez Canillas <javierm@redhat.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, llvm@lists.linux.dev, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
Message-ID: <artq_epowBo_VEDZ@beelink>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <6b80cb97-6706-412a-b013-9423f6f75153@linaro.org>
 <artgrTe6wvKxnUOG@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <artgrTe6wvKxnUOG@houat>
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

On Sep 29 2026, Maxime Ripard wrote:
> Hi Neil,
> 
> On Mon, Sep 28, 2026 at 06:39:58PM +0200, Neil Armstrong wrote:
> > On 9/28/26 18:22, Maxime Ripard wrote:
> > > Panels in general, and MIPI-DSI panels in particular, are pretty
> > > difficult to support and require pretty much a panel driver for each
> > > panel produced. Most of them are pretty simple, and require an opaque
> > > initialization sequence that is usually poorly documented.
> > > 
> > > This creates a tension between OEMs and distros because OEMs will
> > > typically get a new panel to react to a sourcing issue during
> > > production, and thus need some swift turnaround between getting their
> > > new panel and it being operational in the OS. Distributions on the other
> > > hand can take years to ship a kernel with that new panel driver.
> > > 
> > > To solve this, I followed the example of HID-BPF and wrote a panel
> > > driver that will rely on BPF programs to perform the panel
> > > initialization. That way, we can ship the programs separately from the
> > > kernel, and with a different lifecycle. If this driver is accepted, the
> > > plan is to have a userspace component started by udev to identify and
> > > load the right BPF program for the panels found on the device.
> > 
> > This is kind of late for serious applications except if we manage to
> > solve the bootloader to Linux display engine transition.
> 
> Virtually all "generic" distributions are shipping the panel as modules
> today anyway, because anything else is nothing but impractical. But
> maybe you don't consider them serious enough. Also, applications live in
> userspace already, so can be ran after this driver would be initialized
> anyway.

To add a little bit to what Maxime said, about the "userspace loader".

One thing I initially worked on on HID-BPF was a kernel-side loader.
Because BPF allows you to run the syscalls from the kernel itself,
nothing prevents you to make an extra "loader" module with the bpf.o
embedded in it that would do the loading of the BPF from within the
kernel itself.

On HID-BPF, my userspace loader was too fancy at some point and the
kernel loader started to be too big. Especially because we depend on
"potentially" connected devices, and embedding all the BPFs in the
module started to be way too much.

But for panels and embedded systems, it would totally make sense to have
a Kconfig that cherry picks which BPF needs to be embedded in the
panel-bpf-loader module, and that module gets loaded/included in the
vmlinux directly, and at probe time, it just attaches the struct_ops.

Well, of course this surely can be integrated with some DT definition
somewhere, but I haven't pushed the thinking too much.

Anyway, no userspace/initramfs required in this case!

Cheers,
Benjamin
