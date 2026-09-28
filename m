Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6824CA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C389610E105;
	Mon, 28 Sep 2026 16:22:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dKbUATTq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FDAF10E105
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 16:22:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E33CF415AE;
 Mon, 28 Sep 2026 16:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E36C1F000FF;
 Mon, 28 Sep 2026 16:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790612535;
 bh=qg3X+kdxoIWMjV+DfXe6h75eyqNhu8yttfmSXvX9ux8=;
 h=From:Subject:Date:To:Cc;
 b=dKbUATTq4fjTaREfaqOEJGvKEw83Tkv2bH+3PvipH+013sWwF/VxYiBwbK+eoOwZy
 k7KhBu9U6ZrpmwjNv441irC7hYgx1ptdfTcbR2jUdYIxskcQpdihnFXHt0NIZ9kew0
 ivHFhvBWAPG3mi6hGj8BhsucDAoySnOrGIDQlBCTiIHru/oQgpD/N6lUZUKqdvUlmN
 EWGOkNOOu1+dI1m+I66QxLEq9rMMZl5se+TWXwquTqfu0bjp01p1uAnryJoLAUNEyZ
 fYPjsSmoKLJ2zaiQYbQV65uNVVT5I/cWA70HrblFyyzYkQjHeJk+iAmNVoW67BM2Wy
 Rm54b9XunksrA==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
Date: Mon, 28 Sep 2026 18:22:00 +0200
Message-Id: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBswibSuEi1MxxpIE4UIorsnL
 d/i/wcKZaYCU/NAposLn7Giaxuwu4kbIbtqkEIOYpQaXQ4YODG6wphMpANpTR6d0quSZrS98lD
 rlMnz/Z/n5X0/x9i3pGkAAAA=
X-Change-ID: 20260928-drm-mipi-dsi-panel-ebpf-d78b72a9c47f
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Albert Esteve <aesteve@redhat.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Maxime Ripard <mripard@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4301; i=mripard@kernel.org;
 h=from:subject:message-id; bh=5lHqMWuG2SC/nvr8+jRbwofW8j9/nXRWESqbC2CG75I=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm7phjskmP3W/my72a6h9id8ra8E4bWkqpTYr+rP48xP
 6birXm/YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzEJpWx4UnduYjC+p/PzPNt
 VvU+/nxQrc+y/voPa6HDJzYu3f7liYbArLZ+l7VMjyaKC9xwsEngYqyPXXZksrx6Ycbi47cYfkm
 bmn+1+Vy3KePL/Aydw58Et22dxR95wPlUzj75jeccSldGuL0CAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

Panels in general, and MIPI-DSI panels in particular, are pretty
difficult to support and require pretty much a panel driver for each
panel produced. Most of them are pretty simple, and require an opaque
initialization sequence that is usually poorly documented.

This creates a tension between OEMs and distros because OEMs will
typically get a new panel to react to a sourcing issue during
production, and thus need some swift turnaround between getting their
new panel and it being operational in the OS. Distributions on the other
hand can take years to ship a kernel with that new panel driver.

To solve this, I followed the example of HID-BPF and wrote a panel
driver that will rely on BPF programs to perform the panel
initialization. That way, we can ship the programs separately from the
kernel, and with a different lifecycle. If this driver is accepted, the
plan is to have a userspace component started by udev to identify and
load the right BPF program for the panels found on the device.

This driver is fully functional and works with both 5" and 7" Touch
Display 2 panels for the RaspberryPi. However, it breaks away from the
typical panel driver in multiple ways:

- BPF programs can only be loaded by userspace. This leaves us with two
  choices: 

  * We prevent the driver from loading until the script itself is
    loaded. This has the side effect of preventing any other output to
    be used until the initramfs is ran at the earliest, and possibly
    ever if the loader isn't installed for example.

  * Or we probe the driver all the time, but only report it as connected
    once a program has been registered. This is somewhat unconventional,
    but allows the other outputs to be functional, *and* allows the user
    to force the output if their panel doesn't require any
    initialization or during debugging. I chose this solution.

- It's not a panel driver, but a bridge one, which is also pretty
  unconventional. This is required because panel drivers don't have
  access to a detect callback that is required for the above, but I also
  think that the recent work from Luca blurs the line from panels and
  bridges and we'll end up going that road anyway.

Let me know what you think,
Maxime

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Maxime Ripard (6):
      dt-bindings: display: Add panel-mipi-dsi-bpf generic panel binding
      drm/panel: Add generic MIPI-DSI panel driver with BPF init sequences
      drm/panel: dsi-bpf: Add BPF program build infrastructure and helper header
      drm/panel: dsi-bpf: Add Raspberry Pi 7-inch panel BPF program
      drm/panel: dsi-bpf: Add Raspberry Pi 5-inch panel BPF program
      [DO NOT MERGE] arm64: dts: broadcom: Add Raspberry Pi ILI9881C DSI panel overlays

 .../bindings/display/panel/panel-mipi-dsi-bpf.yaml | 184 +++++++++
 arch/arm64/boot/dts/broadcom/Makefile              |   8 +
 .../bcm2711-rpi-4-b-dsi-ili9881-5inch.dtso         |  22 +
 .../bcm2711-rpi-4-b-dsi-ili9881-7inch.dtso         |  22 +
 .../dts/broadcom/bcm2711-rpi-4-b-dsi-ili9881.dtsi  |  65 +++
 drivers/gpu/drm/panel/Kconfig                      |   3 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/bpf/Kconfig                  |  28 ++
 drivers/gpu/drm/panel/bpf/Makefile                 |  10 +
 .../gpu/drm/panel/bpf/panel-bpf-mipi-dsi-core.c    | 452 +++++++++++++++++++++
 .../gpu/drm/panel/bpf/panel-bpf-mipi-dsi-kfuncs.c  | 278 +++++++++++++
 drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi-ops.c | 242 +++++++++++
 .../gpu/drm/panel/bpf/panel-bpf-mipi-dsi-trace.c   |   4 +
 .../gpu/drm/panel/bpf/panel-bpf-mipi-dsi-trace.h   | 246 +++++++++++
 drivers/gpu/drm/panel/bpf/panel-bpf-mipi-dsi.h     | 264 ++++++++++++
 drivers/gpu/drm/panel/bpf/progs/Makefile           |  93 +++++
 .../panel/bpf/progs/Raspberrypi__dsi-5inch.bpf.c   | 266 ++++++++++++
 .../panel/bpf/progs/Raspberrypi__dsi-7inch.bpf.c   | 271 ++++++++++++
 .../gpu/drm/panel/bpf/progs/panel-bpf-mipi-dsi.h   |  95 +++++
 19 files changed, 2554 insertions(+)
---
base-commit: 6e375de99d0c420169481fcd36064177ab55b09d
change-id: 20260928-drm-mipi-dsi-panel-ebpf-d78b72a9c47f

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

