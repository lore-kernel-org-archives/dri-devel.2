Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9037BC4453A
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 18:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9703610E0D8;
	Wed, 22 Jul 2026 18:58:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Sl5Qumeu";
	dkim-atps=neutral
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D40710E0D8
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 18:58:52 +0000 (UTC)
Received: from mail01.layka.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id DFA968695D;
 Wed, 22 Jul 2026 20:58:49 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IUKNuNWloxYK; Wed, 22 Jul 2026 20:58:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1784746728; bh=UfNqCcOeyh0EPGI9MOJP83FkVghh8sF7H6l5q4tKtFw=;
 h=From:Subject:Date:To:Cc;
 b=Sl5QumeunLrtHofgHBv/aoy+6EFb24yP8dg6quDUUgchsjYWKpeYaCungl1G6IBAq
 GFlQf0MqXMbyf8Ffr/Y5aJK1ajQUTTQO3h+iYeUlCU0X2vi+WzVw2LUKHoHmC6OHda
 z33fktrGK+kBICDDndSezEYgKSN1XDo735BqLpqPsGUCtOa521Fs5emCQpv9WCuMdO
 LGFIsqssOdxQ7GkcqQCYhyLG9z78Xf7GBwgMResozBPmpC6YkpgITg1yqAKiT35i0n
 a81oPqXmFjoowiqRPSM+/OaU83eEqwjrYYfUwhlmk1dIqa2P5RONUUi40iBC1zH11A
 Zcq+/Eg27ytIA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v3 0/3] Fixes and enhancements for Exynos (7870) DSIM
 bridge driver
Date: Thu, 23 Jul 2026 00:28:31 +0530
Message-Id: <20260723-exynos-dsim-fixes-v3-0-0c31ae1dbecc@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NTQrCMBAF4KuUrI0kk/4EV95DXAQzbWdhI5kSW
 krubtqNCOLyveF9swnGSMjiUm0iYiKmMJVgTpV4jG4aUJIvWYCCVmmoJS7rFFh6pqfsaUGWjbH
 Gt67tVWdE2b0iHocyu91LHonnENfjRdJ7+09LWiqpAbyqOwfG66snjiHM5xAHsXsJPgYo+8uAY
 jjbdGi1UQ7ct5FzfgPd/eoP+AAAAA==
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

 drivers/gpu/drm/bridge/samsung-dsim.c   | 48 +++++++++++++++++++++++----------
 drivers/gpu/drm/exynos/exynos_drm_drv.c |  6 +++++
 include/drm/bridge/samsung-dsim.h       |  1 +
 3 files changed, 41 insertions(+), 14 deletions(-)
---
base-commit: 290aaf24a551d5a0dce037e3fab30820f9113a10
change-id: 20260124-exynos-dsim-fixes-5383d6a6f073

Best regards,
--  
Kaustabh Chakraborty <kauschluss@disroot.org>

