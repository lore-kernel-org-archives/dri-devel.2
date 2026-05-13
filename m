Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327A5CD4F3E
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 13:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB22710EE56;
	Wed, 13 May 2026 13:10:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ggELsJ2v";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4524210EE4B
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:10:42 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7E1BDA06;
 Wed, 13 May 2026 15:10:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778677832;
 bh=s/Kc/VXC4IJK5XqDl3sCotaDavYE8E6bhOvS9KtoSos=;
 h=From:Subject:Date:To:Cc:From;
 b=ggELsJ2vRSR1cYzQllYDV3nhGBfRTtGgGlqNdjFl6BOfdMvMLqijb5mRKe+BYWXs4
 0ThdsoP1cup2taLkA7x61gjcl2C/tSuJfxxnlIIv4hS2cDRW/isHAdxZLUCBWeaUzc
 HS2SKO6S5DuFIeJ6w0YiLfR2+jdv6lp9euBglYlU=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v3 00/13] drm/bridge: tc358762: Various small fixes
Date: Wed, 13 May 2026 16:10:09 +0300
Message-Id: <20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADJ4BGoC/3XMQQ7CIBQE0Ks0rMVQKB/rynsYFwgfy8JioCGap
 nf3tysTdTkzmTezgjliYcdmZhlrLDGNFNSuYW6w4w159JSZFBKEksAnp/TBgOQhPrFwCACghfC
 2R0anR8ZtoM/5QnmIZUr5tfm1Xdu/VG254KBDZ3opjQ36FD3aksZrstnvXbqzVazyUzFfiiSFm
 t4r1xFmfyjLsrwBZBn1uvkAAAA=
X-Change-ID: 20260326-tc358762-fixes-6f666500da9e
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2103;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=s/Kc/VXC4IJK5XqDl3sCotaDavYE8E6bhOvS9KtoSos=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBHhHChiPyIiATGGT4zqjaP+5PvPtj62Krpqhv
 JpCh2WdMc6JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagR4RwAKCRD6PaqMvJYe
 9SwjD/48BYu/B9hf5BLuEmkAAnixzlehl+9HrMKHBQLFpTBot/F0pAmDip74fA97rjHtgmOha1p
 o9j27M06loby4TVm8SiG9c4ERemoWtU3jdFKPHJ3G4M9LgnrO1jLvruO8FgyqIkrAsvQfiKySK5
 p9C4es8g9Hgs8SjNyvQf/U4x1BZMIz2Pe/iTuQbooWq/tgyuxp+pjMe/5Yl7oYsoQvee6Dy01LV
 +bK1ahcs6bMI5SmMSFudvnM6zQib3h1cOz9zGm/bRiXGzofkF7L01F0bTeMEsvH3RL5qJgveBED
 3Ml+v5rkN4T6Gg669j40jCfIPQRz3KcQC7Y4JG75I1qSVD7l6jbnEl46MImYVPY3tV2pMDccS1q
 ED3PecpmGY2WmsiiPFDcZwraMmIJO314ib1Gti15NMV81ro/pJOz7SCv6gqKyP96j0SJvFfJ5IM
 WnZTJKg1NtECvcen+NBQ3F2d/Tm+6Vh692lcgv2IocBEF2u/bqmN8SZ5atXw3nffF7Y+q5PzUAV
 qP7FLj1xM8urAQ1nxjyqYYJPduycwepXHX2ADKeiGykDCRhsrTh4VQ6HmPmYJTom7EAHpdsMcDi
 zsh3gGrIQ/fE59tl5x/+SHECoQSF8+Ctny4N65ycoVq/pZsmc7VeCKhfV8H+AlfA3/c5R8JtuSq
 XBr5xH1Rx+DFqzw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

While trying to get Raspberry Pi display v1.1 working on Beagleboard
platforms, I noticed various small issues with the tc358762 driver.

The series also contains a patch to fix the timings in the
powertip,ph800480t013-idf02 panel. The combination of tc358762 +
ph800480t013 is used in the Raspberry Pi display module, so it makes
sense to fix them together.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes in v3:
- Add missing #include <linux/bitfield.h>
- New patch: "drm/panel-simple: Fix powertip,ph800480t013-idf02 timings"
- Link to v2: https://lore.kernel.org/r/20260327-tc358762-fixes-v2-0-3589d3c45f4a@ideasonboard.com

Changes in v2:
- Always enable VTG. There should be no downside, and it fixes unstable
  hsync
- Add four new patches at the end
- Extend the patch desc in "Drop SPICMR write" a bit
- Link to v1: https://lore.kernel.org/r/20260326-tc358762-fixes-v1-0-65f479227af5@ideasonboard.com

---
Tomi Valkeinen (13):
      drm/bridge: tc358762: Clean up register defines
      drm/bridge: tc358762: Improve SYSCTRL register defines
      drm/bridge: tc358762: Improve LCDCTRL defines
      drm/bridge: tc358762: Configure SYSCTRL first
      drm/bridge: tc358762: Drop SPICMR write
      drm/bridge: tc358762: Improve DPI enable handling
      drm/bridge: tc358762: Update comment about the number of lanes
      drm/bridge: tc358762: Support VTG
      drm/bridge: tc358762: Fix sync polarities
      drm/bridge: tc358762: Move tc358762_init() into tc358762_enable()
      drm/bridge: tc358762: Drop drm_bridge_funcs.mode_set
      drm/bridge: tc358762: Set DE_POL and DCLK_POL properly
      drm/panel-simple: Fix powertip,ph800480t013-idf02 timings

 drivers/gpu/drm/bridge/tc358762.c    | 203 +++++++++++++++++++++++------------
 drivers/gpu/drm/panel/panel-simple.c |  14 +--
 2 files changed, 144 insertions(+), 73 deletions(-)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260326-tc358762-fixes-6f666500da9e

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

