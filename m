Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5240CA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BFBE10E21B;
	Mon, 28 Sep 2026 16:37:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tgwwdITK";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D707A10E21B
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 16:37:14 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id D2BE68FD;
 Mon, 28 Sep 2026 18:35:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1790613323;
 bh=79ekLGQx1Tor6z02KqQn9lGJBkxxAMsnhhsc0gv/Pv4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tgwwdITKp4bfEl3NckTRce+gdM4AqUQST43w9pHEv3HmzcSUOqUmik84htz5qPg3X
 OcLpOr9Mikj4IUIaukMWgueo2gjofH/ExaxDKh1qFqsWzuUQvNYFgZg4MLBuMKQJqT
 zLI18YDW8IyTiyPLslMQtK6pLIx4CdsGLPz0oBLc=
Date: Mon, 28 Sep 2026 19:37:11 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Albert Esteve <aesteve@redhat.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 llvm@lists.linux.dev, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
Message-ID: <20260928163711.GA210522@killaraus.ideasonboard.com>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
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

Hi Maxime,

On Mon, Sep 28, 2026 at 06:22:00PM +0200, Maxime Ripard wrote:
> Hi,
> 
> Panels in general, and MIPI-DSI panels in particular, are pretty
> difficult to support and require pretty much a panel driver for each
> panel produced. Most of them are pretty simple, and require an opaque
> initialization sequence that is usually poorly documented.
> 
> This creates a tension between OEMs and distros because OEMs will
> typically get a new panel to react to a sourcing issue during
> production, and thus need some swift turnaround between getting their
> new panel and it being operational in the OS. Distributions on the other
> hand can take years to ship a kernel with that new panel driver.
> 
> To solve this, I followed the example of HID-BPF and wrote a panel
> driver that will rely on BPF programs to perform the panel
> initialization. That way, we can ship the programs separately from the
> kernel, and with a different lifecycle. If this driver is accepted, the
> plan is to have a userspace component started by udev to identify and
> load the right BPF program for the panels found on the device.

Interesting idea.

How would that work for devices that want early display support ? In
particular, how does it interact with your recent work on "fastboot"
support (with the kernel drivers taking over a running display
configured by the boot loader) ?

I'm also wondering about the incentives for vendors to upstream the
code. How will we avoid having a proliferation of out-of-tree drivers ?

> This driver is fully functional and works with both 5" and 7" Touch
> Display 2 panels for the RaspberryPi. However, it breaks away from the
> typical panel driver in multiple ways:
> 
> - BPF programs can only be loaded by userspace. This leaves us with two
>   choices: 
> 
>   * We prevent the driver from loading until the script itself is
>     loaded. This has the side effect of preventing any other output to
>     be used until the initramfs is ran at the earliest, and possibly
>     ever if the loader isn't installed for example.
> 
>   * Or we probe the driver all the time, but only report it as connected
>     once a program has been registered. This is somewhat unconventional,
>     but allows the other outputs to be functional, *and* allows the user
>     to force the output if their panel doesn't require any
>     initialization or during debugging. I chose this solution.
> 
> - It's not a panel driver, but a bridge one, which is also pretty
>   unconventional. This is required because panel drivers don't have
>   access to a detect callback that is required for the above, but I also
>   think that the recent work from Luca blurs the line from panels and
>   bridges and we'll end up going that road anyway.
> 
> Let me know what you think,
> Maxime
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Maxime Ripard (6):
>       dt-bindings: display: Add panel-mipi-dsi-bpf generic panel binding
>       drm/panel: Add generic MIPI-DSI panel driver with BPF init sequences
>       drm/panel: dsi-bpf: Add BPF program build infrastructure and helper header
>       drm/panel: dsi-bpf: Add Raspberry Pi 7-inch panel BPF program
>       drm/panel: dsi-bpf: Add Raspberry Pi 5-inch panel BPF program
>       [DO NOT MERGE] arm64: dts: broadcom: Add Raspberry Pi ILI9881C DSI panel overlays
> 
>  .../bindings/display/panel/panel-mipi-dsi-bpf.yaml | 184 +++++++++
>  arch/arm64/boot/dts/broadcom/Makefile              |   8 +
>  .../bcm2711-rpi-4-b-dsi-ili9881-5inch.dtso         |  22 +
>  .../bcm2711-rpi-4-b-dsi-ili9881-7inch.dtso         |  22 +
>  .../dts/broadcom/bcm2711-rpi-4-b-dsi-ili9881.dtsi  |  65 +++
>  drivers/gpu/drm/panel/Kconfig                      |   3 +
>  drivers/gpu/drm/panel/Makefile                     |   1 +
>  drivers/gpu/drm/panel/bpf/Kconfig                  |  28 ++
>  drivers/gpu/drm/panel/bpf/Makefile                 |  10 +
>  .../gpu/drm/panel/bpf/panel-bpf-mipi-dsi-core.c    | 452 +++++++++++++++++++++
>  .../gpu/drm/panel/bpf/panel-bpf-mipi-dsi-kfuncs.c  | 278 +++++++++++++
>  drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-ops.c | 242 +++++++++++
>  .../gpu/drm/panel/bpf/panel-bpf-mipi-dsi-trace.c   |   4 +
>  .../gpu/drm/panel/bpf/panel-bpf-mipi-dsi-trace.h   | 246 +++++++++++
>  drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi.h     | 264 ++++++++++++
>  drivers/gpu/drm/panel/bpf/progs/Makefile           |  93 +++++
>  .../panel/bpf/progs/Raspberrypi__dsi-5inch.bpf.c   | 266 ++++++++++++
>  .../panel/bpf/progs/Raspberrypi__dsi-7inch.bpf.c   | 271 ++++++++++++
>  .../gpu/drm/panel/bpf/progs/panel-bpf-mipi-dsi.h   |  95 +++++
>  19 files changed, 2554 insertions(+)
> ---
> base-commit: 6e375de99d0c420169481fcd36064177ab55b09d
> change-id: 20260928-drm-mipi-dsi-panel-ebpf-d78b72a9c47f

-- 
Regards,

Laurent Pinchart
