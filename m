Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94007C5DF70
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF34E10E755;
	Mon, 17 Aug 2026 17:18:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="PCAMKr3G";
	dkim-atps=neutral
X-Greylist: delayed 602 seconds by postgrey-1.36 at gabe;
 Mon, 17 Aug 2026 17:18:24 UTC
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7F1D10E6AD
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 17:18:24 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20260817170819de641ce83300020743
 for <dri-devel@lists.freedesktop.org>;
 Mon, 17 Aug 2026 19:08:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=m9poIef59bV+6SuT8en2A4joXQB6tWZFKbgAakg0YTg=;
 b=PCAMKr3GT+2XxPCAwpOAP8oX5TYSEJ7gNNWQFrcwbdxmPBAc651N0kyhorHq4Vcwmo5ZZk
 iv3KJINCDigN5a5WUwm+AzPrcKCB4kzVBX9kKPysHKMh06tkRxfZCjnO5ZmXWuvqyr+q7KTW
 XPYslf9L1Z+71a7ILEHLOLQr4dxJScOcTWfjEGmLxiWpg3Og4x278WZ9+QZuxegLRUU7dvxA
 OLxqC5JHMHLQVWHAxJtBFREcL5HbB05k9Q1n9fGxgneU8aWa58WfCktgqosJvzUe9wZOnR9X
 JU+ndXbeOZSyFfwU6RMKx1eSU0F6OZUEGx6SEayOiKrheNMV00TrxVMQ==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Andrew Davis <afd@ti.com>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: [PATCH 0/2] leds: lp8864: Expose a backlight via led_bl helper
Date: Mon, 17 Aug 2026 19:08:13 +0200
Message-ID: <20260817170817.1933046-1-alexander.sverdlin@siemens.com>
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

This series lets the TI LP8864/LP8866 LED driver expose a standard
backlight class device in addition to its LED class device, so it can
be consumed by display/panel stacks that expect a backlight.

This is a replacement for the earlier series "Convert LP8864 LED driver
to backlight class" [1], which took a much more invasive route: it moved
the driver from drivers/leds/ to drivers/video/backlight/ and added
backlight class registration on top.

Feedback on that approach was that a working LED driver should not be
relocated and re-typed just to gain a backlight interface.

The new approach keeps the LP8864 a plain LED driver and instead teaches
the existing generic led-backlight code to register a backlight on behalf
of a self-contained LED provider:

 * Patch 1 factors the backlight registration out of led_bl's probe path
   into a shared helper and exports devm_led_backlight_register(). This
   registers a backlight class device driven by a single LED, without a
   device-tree node, bound to the caller's device lifetime. The registration
   is now fully devres-managed, so the explicit .remove callback goes away.
   The exported symbol is a no-op when led-backlight support is not
   reachable (IS_REACHABLE(CONFIG_BACKLIGHT_LED)), so callers need no
   Kconfig plumbing and are not force-selected to build led_bl.

 * Patch 2 calls that helper from the LP8864 driver, spawning a backlight
   tied to the I2C device lifetime.

Compared to [1] this means:

 * The driver stays in drivers/leds/ and remains an ordinary LED driver.
 * The generic led_bl helper becomes reusable by other self-contained LED
   providers.

The motivating use case is unchanged: an LP8864 on a hot-pluggable segment
of an I2C bus. The generic led-backlight platform driver cannot react to a
dynamically (dis)appearing I2C device; letting the I2C driver register the
backlight directly makes it a self-contained, hot-plug-safe driver.

[1] https://lore.kernel.org/all/20260615120353.3409035-1-alexander.sverdlin@siemens.com/

Alexander Sverdlin (2):
  backlight: led_bl: Add devm_led_backlight_register() helper
  leds: lp8864: Register a backlight device

 drivers/leds/leds-lp8864.c       |   5 +-
 drivers/video/backlight/led_bl.c | 130 ++++++++++++++++++++-----------
 include/linux/led_bl.h           |  20 +++++
 3 files changed, 109 insertions(+), 46 deletions(-)
 create mode 100644 include/linux/led_bl.h

-- 
2.55.0

