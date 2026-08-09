Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78328C5AC80
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 08:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8836D10E11A;
	Sun,  9 Aug 2026 08:56:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Hwkd4okI";
	dkim-atps=neutral
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EF6810E0BA
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 08:56:23 +0000 (UTC)
Received: from mail01.layka.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id CD14A42C9D;
 Sun, 09 Aug 2026 10:56:21 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pBgEsEW16gPa; Sun,  9 Aug 2026 10:56:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1786265781; bh=tBqlMlT7UHfWvC+iM4q4LAoLrnSqP15+B84HIVXvEGc=;
 h=From:Subject:Date:To:Cc;
 b=Hwkd4okISVdmgMk4Tnhxw2v/r4Ziwu4Vl73fl9n0WNKrR6OG79BvXt3YuzJBCTVTK
 qGCQYeLABR4r5m+iJrKjobiVywRn7ZnxVuIPxhaWic7Oc5cNZtaAN/ZNbht6hkMPbf
 gzYG955hxBx8amMmHq88VM0xGHALD11yAKqNjaCFLQi51nStwFkd9CVRZoCQ6l/V38
 qh709tETtryQEADj6VUrN+B0V8dKhhyjyZ4ZeEh+v1pfr/eQ8sQJK5kFIHd7lWM8Sg
 XiKU2pC6ju2hnSZY6VXGQaMukQtZ16pk3RaCexYT80J7fcPkjOP3K/m88DJKfQsAFK
 jZAB3+FQj6ayw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v5 0/3] Fixes and enhancements for Exynos (7870) DSIM
 bridge driver
Date: Sun, 09 Aug 2026 14:25:58 +0530
Message-Id: <20260809-exynos-dsim-fixes-v5-0-6e63dc6c238f@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NTW7CMBAF4Ksgr3E1P4ltWPUeVReOPYAXjZGNI
 hDK3euwiSqiLt8bvW+eqkpJUtVx91RFplRTHlvo9zsVLn48i06xZUVABpA6LffHmKuONf3oU7p
 L1T07jsabE1hWbXct8jq02dd3y5dUb7k8Xi8mXNr/tAk1aCSK0FlPHPEzplpyvn3kclaLN9FqE
 Lgtg5rhXW/FIYMn/27waljiLYObAYHRC8ZBQng3utVwcNgyumYEb2zoUQwO9q8xz/MvxwpaFoA
 BAAA=
X-Change-ID: 20260124-exynos-dsim-fixes-5383d6a6f073
To: Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, stable@vger.kernel.org
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

Since v6.17, there is a regression for the Exynos 7870 DSIM driver. The
display occasionally had random aberration when the panel was turned on.
The first patch addresses that.

The second patch replaces an implicit loop for waiting for PLL
stabilization with an interrupt-based solution, which should be more
reliable. This solution was suggested by Inki Dae in a discussion of an
earlier patch series sent by me. For further details, refer to its
commit description.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Changes in v5:
- Fix incorrect goto label s/err_unbind_all/err_mode_config_cleanup (Sashiko)
- Link to v4: https://patch.msgid.link/20260809-exynos-dsim-fixes-v4-0-ca67c51e61b7@disroot.org

Changes in v4:
- Clarify active-hight MFLUSH_VS in code comment (Luca Seresoli)
- Move aperture_remove_all_conflicting_devices() before
  component_bind_all() (Sashiko)
- Change `timeout` type to unsigned long (Inki Dae)
- Correct typo s/Calcutate/Calculate (Inki Dae)
- Correct inverted condition waiting for PLL stable completion
  (Inki Dae)
- Do not exclusively conclude IRQ routine for PLL_STABLE interrupt
  (Inki Dae)
- Explicitly enable PLL_STABLE and SW_RST_RELEASE interrupts during
  reset action (Inki Dae)
- Wait for SW_RST_RELEASE interrupt before setting up clock (Inki Dae)
- Fall back to bit testing for PLL stabilization when timed out
- Link to v3: https://patch.msgid.link/20260723-exynos-dsim-fixes-v3-0-0c31ae1dbecc@disroot.org

Changes in v3:
- Add patch for removing conflicting devices for DRM (Sam Day)
- Link to v2: https://lore.kernel.org/r/20260208-exynos-dsim-fixes-v2-0-a857e8130a2a@disroot.org

Changes in v2:
- drop now-not-required [v1 1/3] (Marek Szyprowski)
- Link to v1: https://lore.kernel.org/r/20260124-exynos-dsim-fixes-v1-0-122d047a23d1@disroot.org

---
Kaustabh Chakraborty (3):
      drm/bridge: samsung-dsim: enable MFLUSH_VS for Exynos 7870 DSIM
      drm/bridge: samsung-dsim: use DSIM interrupt to wait for PLL stability
      drm/exynos: remove simplefb nodes before init

 drivers/gpu/drm/bridge/samsung-dsim.c   | 56 +++++++++++++++++++++++++--------
 drivers/gpu/drm/exynos/exynos_drm_drv.c |  6 ++++
 include/drm/bridge/samsung-dsim.h       |  1 +
 3 files changed, 50 insertions(+), 13 deletions(-)
---
base-commit: 290aaf24a551d5a0dce037e3fab30820f9113a10
change-id: 20260124-exynos-dsim-fixes-5383d6a6f073

Best regards,
--  
Kaustabh Chakraborty <kauschluss@disroot.org>

