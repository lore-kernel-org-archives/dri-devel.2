Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41ABC54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 353BC89906;
	Thu, 30 Jul 2026 03:33:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="M5jPIv6U";
	dkim-atps=neutral
X-Greylist: delayed 304 seconds by postgrey-1.36 at gabe;
 Thu, 30 Jul 2026 03:33:06 UTC
Received: from mail-m82237.xmail.ntesmail.com (mail-m82237.xmail.ntesmail.com
 [156.224.82.237])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3971610E07B
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 03:33:05 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 481c5dbc2;
 Thu, 30 Jul 2026 11:27:56 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v1 0/7] Add HPD support for Rockchip Analogix DP
Date: Thu, 30 Jul 2026 11:27:37 +0800
Message-Id: <20260730032744.381566-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fb1107efc03a8kunm040f79123746ca
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSxlPVhpDQkNIQk1NS0kdHVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=M5jPIv6UdHfbkWzCY96X6Pj0bLzAEZZRcyH61ovgYl9m3kd9ON0PPhp7nVeMAfIbeNn3EgNmfjz0Hv1QAsxV2LWOi+rNXJD6QDNCo+8Gga3dnOGM+R/mSBJm7XUcsZM5LPZ9SeLeyfS4nHe78t5M+QzivXqdBrCvm24vY5aGM4o=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=2DTb8Z0TivZDfrZk89jRLneek8ISpVFxvHsaLnCrg2Q=;
 h=date:mime-version:subject:message-id:from;
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

This series improves the HPD (Hotplug Detect) interrupt handling in
the Analogix DP driver to enable reliable native HPD pin detection on
Rockchip platforms, and introduces platform-specific HPD detection
schemes with fine-grained interrupt control.

On Rockchip platforms, the Analogix DP native HPD pin IRQ requires the
DP controller to remain powered, clocked and initialized to generate
plug/unplug interrupts. The previous driver enabled/disabled IRQ during
bridge enable/disable, which left no HPD detection when the display
pipeline was inactive. Additionally, the interrupt mute/unmute/clear
routines operated on all HPD interrupt bits unconditionally, lacking
the granularity needed for per-event control.

The series reorganizes IRQ and pm_runtime management into bind/unbind,
converts the interrupt type detection to a bitmask-based scheme for
fine-grained mute/unmute/clear operations, and configures Rockchip
platforms to use the HOTPLUG_CHG interrupt with a 2ms HPD deglitch
setting, which provides better stability than the PLUG + HPD_LOST
pair.

Tested on RK3576 with both native HPD pin and GPIO HPD configurations.

Native HPD pin mode:

  &edp {
      status = "okay";
      pinctrl-names = "default";
      pinctrl-0 = <&edp_txm0_pins>;
  };

GPIO HPD mode:

  &edp {
      status = "okay";
      pinctrl-names = "default";
      pinctrl-0 = <&edp0_hpd>;
      hpd-gpios = <&gpio4 RK_PC1 GPIO_ACTIVE_HIGH>;
  };

  &pinctrl {
      edp {
          edp0_hpd: edp0-hpd {
              rockchip,pins = <4 RK_PC1 0 &pcfg_pull_none>;
          };
      };
  };

Both configurations detect cable plug/unplug events correctly.

Patch 1: Move enable_irq()/disable_irq() to bind/unbind and hold a
         pm_runtime reference for Rockchip native HPD pin mode.
Patch 2: Convert analogix_dp_get_irq_type() to return a u32 bitmask
         instead of an enum, accumulating all pending interrupt flags.
Patch 3: Extend mute/unmute helpers to accept an irq_type bitmask for
         per-event interrupt masking.
Patch 4: Extend clear_hotplug_interrupts() to accept an irq_type
         bitmask for per-event pending interrupt clearing.
Patch 5: Simplify analogix_dp_config_interrupt() by removing redundant
         local macros and leveraging the unmute helper.
Patch 6: Configure Rockchip platforms to use HOTPLUG_CHG interrupt with
         2ms HPD deglitch; other platforms keep PLUG + HPD_LOST pair.
Patch 7: Skip native HPD interrupt register operations for GPIO HPD
         mode, where hotplug is detected through an external GPIO.

Damon Ding (7):
  drm/bridge: analogix_dp: Manage pm runtime and IRQ for native HPD pin
    detection
  drm/bridge: analogix_dp: Return bitmask from
    analogix_dp_get_irq_type()
  drm/bridge: analogix_dp: Extend mute/unmute HPD interrupts to accept
    irq bitmask
  drm/bridge: analogix_dp: Extend clear_hotplug_interrupts to accept IRQ
    bitmask
  drm/bridge: analogix_dp: Simplify analogix_dp_config_interrupt()
  drm/bridge: analogix_dp: Use platform-specific HPD detection scheme
  drm/bridge: analogix_dp: Skip native HPD interrupt ops for GPIO HPD

 .../drm/bridge/analogix/analogix_dp_core.c    |  46 ++++--
 .../drm/bridge/analogix/analogix_dp_core.h    |  10 +-
 .../gpu/drm/bridge/analogix/analogix_dp_reg.c | 146 ++++++++++++------
 3 files changed, 134 insertions(+), 68 deletions(-)

-- 
2.34.1

