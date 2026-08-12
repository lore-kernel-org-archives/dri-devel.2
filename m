Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F35C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ADC710F246;
	Thu, 13 Aug 2026 09:42:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=dewith.io header.i=@dewith.io header.b="AIz0tDJT";
	dkim-atps=neutral
Received: from meve.dewith.io (meve.dewith.io [157.90.20.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 105DC10E44D
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 19:22:20 +0000 (UTC)
Received: from localhost (70-26-208-87.ftth.glasoperator.nl [87.208.26.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256) (No client certificate requested)
 by meve.dewith.io (Postfix) with ESMTPSA id B29F924D5E;
 Wed, 12 Aug 2026 19:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dewith.io; s=default; 
 t=1786562537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BBvR3O2yKy9Eq+jxgHrWStTlkby5tY3HNjx7mbhFrIE=;
 b=AIz0tDJTXxsc5nV3s7jIVQVrEbDmD77Sh0Lxch6C1xuVvq6FM1+CzcAd09ApGwHyEpbgc5
 xNjHtu6ay6RJpkYDIVmrngSeYpggGaw+u1zepoy7fWiCkRRJxEnoRcxbTvHqcqix/8iLYi
 BiH9HuJo/pB+foDm9gwf9Z+c4rM2HtA=
From: Wim de With <wf@dewith.io>
Subject: [PATCH v2 0/2] backlight: Add support for Orient Chip OCP8178
Date: Wed, 12 Aug 2026 21:21:45 +0200
Message-Id: <20260812-ocp8178-backlight-v2-0-4ad18b48bef8@dewith.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02MSw6CMBQAr0K6tuS1RSyuvIdxAeWVPj+UtFVMC
 He36MblJDOzsIiBMLJjsbCAL4rkxwxyVzDj2nFATn1mJkHWoEFzbyYtDpp3rbndaXCJN9j2Chs
 FaBXL3RTQ0vv7PF9+HJ/dFU3aRpthg3/w5EIO/961BLGvRClAKKi44LM99ThTciV5tq4fO/Kaz
 awAAAA=
X-Change-ID: 20260808-ocp8178-backlight-9ead3e930ef3
To: Wim de With <wf@dewith.io>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

The ClockworkPi uConsole[1] is a modular handheld console manufactured
by Clockwork Tech that runs Linux. It consists of a mainboard which
connects a number of peripherals, such as the screen, batteries and
keyboard. This mainboard hosts a system on a module (SoM), such as the
Raspberry Pi Compute Module as a so-called core to provide the compute
for the device. The device supports different kinds of SoM as cores. The
mainboard is shared between different devices, such as the DevTerm[2].

Currently, the uConsole requires a number of out-of-tree drivers to
support the hardware. In addition, most (if not all) supported SoMs
require vendor kernels. In practice, this means that kernel support for
the device is scattered across various repositories in the form of
patches with dubious quality.

This patch series is the first in an attempt to upstream as many of the
needed drivers as possible. The goal is to support at least the
mainboard and the peripherals of the uConsole in the upstream kernel.
These drivers should find their way downstream to the SoM vendor kernels
eventually.

This series adds the driver for the backlight controller, the Orient
Chip OCP8178. I wrote the driver from scratch using the datasheet, to
avoid any copyright or attribution problems.

[1]: https://www.clockworkpi.com/home-uconsole
[2]: https://www.clockworkpi.com/home-devterm

v2:
- Add a note in the commit message that the 1-Wire protocol is not the
  one implemented in drivers/w1
- Explicitly reject sleepable GPIO and don't use _cansleep() functions
- Fix bug where interrupts were restored during timing-critical section
- Remove unnecessary logging
- Add missing \n to dev_err_probe message
- Remove linux/mod_devicetable.h include
- Remove struct init padding
- Remove unnecessary backlight_is_blank() check
- Use appropriate delay functions
- Set RFA explicitly and move comment
- Format DT binding YAML

---
Wim de With (2):
      dt-bindings: backlight: Add Orient Chip OCP8178
      backlight: Add support for Orient Chip OCP8178

 .../bindings/leds/backlight/ocs,ocp8178.yaml       |  47 +++++
 MAINTAINERS                                        |   6 +
 drivers/video/backlight/Kconfig                    |  10 +
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/ocp8178_bl.c               | 235 +++++++++++++++++++++
 5 files changed, 299 insertions(+)
---
base-commit: 315f4bd234b3b8a3ed3a71fd4c53b110cf373720
change-id: 20260808-ocp8178-backlight-9ead3e930ef3

Best regards,
--  
Wim de With <wf@dewith.io>

