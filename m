Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BADCD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 12:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35B3F10E3CC;
	Mon, 15 Jun 2026 12:14:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="VJIW+hB1";
	dkim-atps=neutral
X-Greylist: delayed 603 seconds by postgrey-1.36 at gabe;
 Mon, 15 Jun 2026 12:14:05 UTC
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3EB810E3BD
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 12:14:05 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20260615120357eb2c953a880002077a
 for <dri-devel@lists.freedesktop.org>;
 Mon, 15 Jun 2026 14:03:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=lCOoc1nkAj9LM105Jbsd+SDj6HDskDfhiImH70CCtpM=;
 b=VJIW+hB1r1v2BVNgjuHpz6m0c3XuTFAuC/jxb2JCOs91V5KqN1/rIudfcyLJzmwMVZcyu3
 k4kYp6CZ1PwOIxG8TelhNFFt1GTde3wxRMv4THGZFLSHEZPVkh9//BGZYZEJC8VNJAIP6Nwf
 2UXdbonCtfumlbbYGnB9IGuA0Q3MU7iDYLL0bM1BwnLn7HZkhBsLlmKC1fg9QaSxtWhcz8lx
 S37v3jWBHhxulH3QQHqvux22KJSG5S5EokxDK3y2mDzJ1CVmuLXKEi+beE4JKcnLLynlU0IE
 STyI2qoMO+ZTrxK7VvWSSCMZ1mgkLnIetYx98tLDOYi2spHtQ8KPIelQ==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-leds@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 Andrew Davis <afd@ti.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: [PATCH 0/3] Convert LP8864 LED driver to backlight class
Date: Mon, 15 Jun 2026 14:03:46 +0200
Message-ID: <20260615120353.3409035-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

This series converts the TI LP8864/LP8866 driver from a pure LED class
driver to a backlight class driver, while preserving backward-compatible
LED class device registration.

The motivation is a use case on a hot-pluggable segment of an I2C bus.
The generic led-backlight driver (drivers/video/backlight/led_bl.c) is
a platform driver and thus inherently non-hotpluggable -- it cannot react
to dynamic appearance/disappearance of the underlying I2C device. By
making the LP8864 driver directly register a backlight class device, it
becomes a self-contained I2C driver that properly supports hot-plug/unplug
events without depending on a separate platform device for backlight
functionality.

The LED class device registration is retained for backward compatibility:
if the "led" child node is present in the device-tree, an LED class device
is registered in addition to the backlight device.

No in-tree device-trees reference this driver, so there is no mainline
impact. Out-of-tree users who previously relied on the LP8864 as a backend
for the generic led-backlight platform driver will notice a backlight class
device appearing directly.

Alexander Sverdlin (3):
  dt-bindings: backlight: ti,lp8864: Add backlight class properties
  leds: lp8864: Rename struct lp8864_led and local variables
  backlight: lp8864: Convert from LED to backlight class driver

 .../bindings/leds/backlight/ti,lp8864.yaml    |  16 +-
 MAINTAINERS                                   |   2 +-
 drivers/leds/Kconfig                          |  12 --
 drivers/leds/Makefile                         |   1 -
 drivers/video/backlight/Kconfig               |  15 ++
 drivers/video/backlight/Makefile              |   1 +
 .../backlight/lp8864_bl.c}                    | 169 ++++++++++++------
 7 files changed, 147 insertions(+), 69 deletions(-)
 rename drivers/{leds/leds-lp8864.c => video/backlight/lp8864_bl.c} (55%)

-- 
2.54.0

