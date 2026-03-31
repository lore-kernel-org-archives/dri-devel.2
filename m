Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3266A1061B3C
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 12:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EDAA10EA6F;
	Tue, 31 Mar 2026 12:36:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="LOrETlhH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F43610E98E
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 12:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ldMEs/qs4xXRjeu4SDplxiYzd1YMJheCJwCeLHroOy4=; b=LOrETlhHB4oECCSLwyumNKWr4i
 8fyYIHAONalAc4MDhpXDm4WyURJpL1RviI+0Z9yfLIjhosZ49y7aV8oVh/5gjdMjIenI8LlD4g/S8
 7GjCWSPQWZfCa0lRFKFKEqVqXCOgsilCxXpADFFkitJ0TG/h+PSmHbf2WxpY368ea89V/nUwiciGF
 LbffkD26prk6Or+5kp9Ft/+j4e1uNk6qcQR5nkLs7EOqr7ss2qJVCyHcxehVz7K1yCGN9Jj7niCAJ
 S4dlIimpn5iGfSbWLRwGMCLgJpnwTe4R6h+P0lXM57s6Cctq3m34M8X8n32D2MWLJ0eMDdaBA00BV
 1e61BoqA==;
Received: from [189.7.87.169] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w7YKO-009RtV-6E; Tue, 31 Mar 2026 14:36:16 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v9 0/3] Power Management for Raspberry Pi V3D GPU
Date: Tue, 31 Mar 2026 09:35:50 -0300
Message-Id: <20260331-v3d-power-management-v9-0-f52ff87bfd36@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XRwW7DIAwG4FepOI8J20Bgp73HtAMJpkVakyqps
 k1V3n2k0tRMEdrxt+AzNjcx8Zh5Ei+Hmxh5zlMe+hL800F0p9AfWeZYskCFRjXo5ExRXoZPHuU
 59OHIZ+6vkrltywkdO29FuXoZOeWvO/v2XvIpT9dh/L53mWGt/gPOIJVsnEoesQWl3Ws+ho8cn
 rvhLFZxxo1CUFGwKIowGtsq8FbvFPpVrAKwFYWKohlco9lBjHan6I2CNUUXpQsJYwIbNeNOMQ8
 FgSqKWfcSXEsOuKXG7xS7VWrbtetEyjpKkbyzZqc0D4UAK0pTFJ+UsgGi7sxecRul+tNuVTRRe
 Y2KyaQ/yrIsPxN1ZXmjAgAA
X-Change-ID: 20250728-v3d-power-management-eebb2024dc96
To: Stefan Wahren <wahrenst@gmx.net>, Maxime Ripard <mripard@kernel.org>, 
 Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 kernel-dev@igalia.com, Philipp Zabel <p.zabel@pengutronix.de>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6539; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=C5LQgiQwZvI7mMmQ7lHD0GUhI64xp1WOdwgXNCbIRlU=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBpy7+7Y/7Foj+kLxI9awvm8qASSdqVtDe/LLht0
 IVKqfkX0yWJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCacu/uwAKCRA/8w6Kdoj6
 qoivB/9nr50epnOHzsQbDGG0O8v/C7FjYTBwMnSJqQCelb9RhLZhl/CH6+x4yEshUp3BYTcsyIk
 x2RbkWd2i8VJ0IXR73WrjQMqA0M0sxlVwOTyhyRxwHtlQqMKpmwXWK1cYgmNHCV6EFynwkF7i7o
 HJgjWOyp6AssQm27DpFEymFw1twBRnjBk+uW0EUivLEHyzYbmDWVETEL5yZ3HicZds5DF42W3sC
 EOj4/TNZrQZgRXMnpyMaCtEzWCit5bzlV60AutDxNyTX+pACn94eBBijeLncmwYMQ60EwDjhWZk
 VNoNhvHWUbzoMdn4yvSnwgtvGJwJHvdK72IlnVMTpDjQOoh4
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

This series introduces Runtime Power Management (PM) support for the
Raspberry Pi V3D GPU.

Currently, the V3D clock remains enabled for the entire system uptime,
even when the GPU is idle. With the introduction of Runtime PM, the
clock can now be disabled during idle periods. For example, with this
series applied to a Raspberry Pi 5, if we check `vcgencmd measure_clock
v3d`, we get:

(idle)

$ vcgencmd measure_clock v3d
frequency(0)=0

(running glmark2)

$ vcgencmd measure_clock v3d
frequency(0)=960016128

I left Melissa's R-b in the last patch even with the changes, as I
considered them uncontroversial. However, Melissa, please let me know if
you would like to have your tag removed or you would like to request more
changes to the last patch.

In the case of no comments, I plan to merge this series by the end of
next week.

Best regards,
- Maíra

v1 -> v2: https://lore.kernel.org/r/20250728-v3d-power-management-v1-0-780f922b1048@igalia.com

- [1/5] NEW PATCH: "clk: bcm: rpi: Add missing logs if firmware fails" (Stefan Wahren)
- [2/5] Remove the "Fixes:" tag (Stefan Wahren)
- [2/5] dev_err_ratelimited() instead of dev_err() (Stefan Wahren)
- [2/5] Instead of logging the clock ID, use clk_hw_get_name(hw) to log the name (Stefan Wahren)
- [2/5] Add a newline character at the end of the log message (Stefan Wahren)
- [2/5] Use CLK_IS_CRITICAL for all clocks that can't be disabled (Maxime Ripard)
- [3/5] NEW PATCH: "clk: bcm: rpi: Maximize V3D clock"
- [4/5] Use devm_reset_control_get_optional_exclusive() (Philipp Zabel)
- [4/5] Make sure that resources are cleaned in the inverse order of allocation (Philipp Zabel)

v2 -> v3: https://lore.kernel.org/r/20250731-v3d-power-management-v2-0-032d56b01964@igalia.com

- Rebased on top of drm-misc-next
- Patches "[PATCH v2 1/5] clk: bcm: rpi: Add missing logs if firmware
  fails", "[PATCH v2 2/5] clk: bcm: rpi: Turn firmware clock on/off when
  preparing/unpreparing", and "[PATCH v2 3/5] clk: bcm: rpi: Maximize
  V3D clock" were applied to clk-next.
- [1/4] NEW PATCH: "clk: bcm: rpi: Let V3D consumers manage clock rate"
- [2/4] NEW PATCH: "clk: bcm: rpi: Mark PIXEL_CLK and HEVC_CLK as CLK_IGNORE_UNUSED"
- [3/4] Add Philipp's R-b (Philipp Zabel)
- [4/4] s/DRM_ERROR/drm_err
- [4/4] Set the clock rate to 0 during suspend and to the maximum rate during resume

v3 -> v4: https://lore.kernel.org/r/20260116-v3d-power-management-v3-0-4e1874e81dd6@igalia.com

- Rebased on top of drm-misc-next
- [1/6, 3/6] Add Melissa's A-b (Melissa Wen)
- [2/6] NEW PATCH: "clk: bcm: rpi: Add a comment about RPI_FIRMWARE_SET_CLOCK_STATE
  behavior" (Stefan Wahren)
- [4/6] NEW PATCH: "drm/v3d: Use devm_reset_control_get_optional_exclusive()" (Melissa Wen)
- [5/6] Include more context in the commit message (Melissa Wen)
- [5/6, 6/6] Instead of creating the function v3d_gem_allocate(), use v3d_gem_init()
  and move HW initialization out of it (Melissa Wen)

v4 -> v5: https://lore.kernel.org/r/20260126-v3d-power-management-v4-0-caf2df16d4e2@igalia.com

- [2/7] Add Stefan's A-b (Stefan Wahren)
- [2/7, 5/7, 6/7] Add Melissa's R-b (Melissa Wen)
- [4/7] NEW PATCH: "pmdomain: bcm: bcm2835-power: Increase ASB control timeout"
- [7/7] Remove redundant pm_runtime_mark_last_busy() from v3d_pm_runtime_put()
- [7/7] Use pm_runtime_get_if_active() in v3d_mmu_flush_all() instead of
  pm_runtime_get_noresume() + pm_runtime_active()
- [7/7] Add missing PM runtime calls to v3d_perfmon_start() and v3d_perfmon_stop()

v5 -> v6: https://lore.kernel.org/r/20260213-v3d-power-management-v5-0-7a8b381eb379@igalia.com

- [1/6] NEW PATCH: "clk: bcm: rpi: Manage clock rate in prepare/unprepare callbacks" (Maxime Ripard)
    - Replaces "clk: bcm: rpi: Let V3D consumers manage clock rate" and
      "clk: bcm: rpi: Add a comment about RPI_FIRMWARE_SET_CLOCK_STATE
      behavior" 
- [6/6] Stop setting min and max clock rates directly in v3d (Maxime Ripard)

v6 -> v7: https://lore.kernel.org/r/20260218-v3d-power-management-v6-0-40683fd39865@igalia.com

- Drop commit "[PATCH v6 2/6] clk: bcm: rpi: Mark PIXEL_CLK and HEVC_CLK as CLK_IGNORE_UNUSED"
- [1/5] Add comment about why is okay to set the clock's rate at prepare/unprepare (Maxime Ripard)
- [1/5] Use clk_hw_get_rate_range() (Maxime Ripard)
- [2/5] Add Stefan's R-b and stable tag (Stefan Wahren)
- [3/5] Add Philipp's R-b (Philipp Zabel)
- [5/5] Keep the alphabetical order in the Makefile (Stefan Wahren)
- [5/5] Propagate `reset_control_assert()` error (Stefan Wahren)
- [5/5] Add v3d_init_hw_state() before v3d_mmu_set_page_table()
- [5/5] Stop any active perfmon during suspend

v7 -> v8: https://lore.kernel.org/r/20260312-v3d-power-management-v7-0-9f006a1d4c55@igalia.com

- "[PATCH v7 2/5] pmdomain: bcm: bcm2835-power: Increase ASB control timeout"
  was merged through -fixes (Thanks Stefan and Ulf!)
- "[PATCH v7 1/5] clk: bcm: rpi: Manage clock rate in prepare/unprepare callbacks"
  was merged through clk-fixes (Thanks Maxime and Stephen!)
- Rebased on top of drm-misc-next.
- [3/3] The perfmon will never be active during a suspend call (Melissa Wen)
- [3/3] No need to call reset_control_(de)assert() as bcm2835-power doesn't
  implement these hooks.
- [3/3] Increase the autosuspend delay to 100ms, as 50ms was too short for RPi 4.
- [3/3] Add Melissa's R-b (Melissa Wen)

v8 -> v9: https://lore.kernel.org/r/20260328-v3d-power-management-v8-0-94336830df5f@igalia.com

- [1/3, 2/3] Add Florian's R-b (Florian Fainelli) 
- [3/3] Handle v3d_resume_sms() and v3d_suspend_sms() errors (Florian Fainelli)

---
Maíra Canal (3):
      drm/v3d: Use devm_reset_control_get_optional_exclusive()
      drm/v3d: Allocate all resources before enabling the clock
      drm/v3d: Introduce Runtime Power Management

 drivers/gpu/drm/v3d/Makefile      |   1 +
 drivers/gpu/drm/v3d/v3d_debugfs.c |  23 +++++-
 drivers/gpu/drm/v3d/v3d_drv.c     | 160 ++++++++++++++++++--------------------
 drivers/gpu/drm/v3d/v3d_drv.h     |  18 +++++
 drivers/gpu/drm/v3d/v3d_gem.c     |  18 ++---
 drivers/gpu/drm/v3d/v3d_irq.c     |  15 ++--
 drivers/gpu/drm/v3d/v3d_mmu.c     |  10 ++-
 drivers/gpu/drm/v3d/v3d_perfmon.c |  18 ++++-
 drivers/gpu/drm/v3d/v3d_power.c   |  87 +++++++++++++++++++++
 drivers/gpu/drm/v3d/v3d_submit.c  |  19 ++++-
 10 files changed, 253 insertions(+), 116 deletions(-)
---
base-commit: 86a28e154c3a754cf661c91b57eb96816e8485df
change-id: 20250728-v3d-power-management-eebb2024dc96

