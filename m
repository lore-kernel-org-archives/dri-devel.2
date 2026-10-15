Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E670BCC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:16:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 189E410E283;
	Thu, 15 Oct 2026 11:16:34 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FA4010E283
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 11:16:28 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1C28422B;
 Thu, 15 Oct 2026 13:14:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1792062864;
 bh=AMQezvz7kS5wMuY8Rft3IfVsBdryJebnully3o+6iAU=;
 h=From:Subject:Date:To:Cc:From;
 b=W3IBLT2TIznwR9Ht6ozwraNLMh7Y4rRqyK0rvLsUyZOBSCXOt6/4sTrRlifXwsTMU
 sxwAC49z+/K4ympNq8KAx0KpYcf9Vzgn3eY/VdMC67yty/WriEb4XqtEJdG5GV+uAN
 iOwjr70XnCiuZRCmhLKr3f7Ee7yfM54sWWhpnXN0=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v5 00/13] drm/bridge: tc358762: Various small fixes
Date: Thu, 15 Oct 2026 14:15:51 +0300
Message-Id: <20261015-tc358762-fixes-v5-0-7cd721a6451b@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOi10GoC/3XPwW7DIAwG4FepOI+K4OCEnfYeVQ8EzMphYYIqW
 lXl3evkkkpZjr+t/5P9FJVKoio+T09RaEo15ZGD+TgJf3PjN8kUOAutNCrQKO8eTN+hljH9UZU
 YEdEoFZwlwaXfQuuCO5cr51uq91weqz81y/SQmhqpJJrYdlbrzkXzlQK5mschuxLOPv+IRZz0u
 9LtFM0KT2wA3zLmDhTYFNPAToHlFrT9YPi5frAHSrspVu1vaVkhiB7cYHzo4R9lnucX4G6D9YU
 BAAA=
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
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2506;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=AMQezvz7kS5wMuY8Rft3IfVsBdryJebnully3o+6iAU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq0LYBV3YPUhU3biEtc6zSG4tJtporL3f1Y2SVR
 e42pF3aMa6JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCatC2AQAKCRD6PaqMvJYe
 9ctXD/9CQLcYIOZ5SrQ7EeY5PgKvbN08iLuJjUDHRtvdxeRZzcN0JBTE5EdT2DtLLhTvxeVgP+A
 KyZYG7WFdayVpp/Knpl74vNpRXeR6Z6EnmThdAY6mDjDLRu2kxqrRhZUS4dT9x1nKKhLy8oA40+
 xwP+e/kkHlRyDhyqET/Rvj5JO66KBnrtAfbZbGoFlcvHhiRNQ68cQFk9jhRO3u4d+MtQuniacHN
 I8VowVqBVoIEFdycn6ODkNu7RxrKP0cb34lmBhAMZ0InXLrWrhjLMm+f8NIakm63EaVUxp1k/ue
 71L5zb5HT7IThGcChyGSglu4oFBo7PHpR1wuNwCpSzqEeuRcDtPSMenLqAkFrJVOQw3PQ57RtCl
 xfZaZ+DHod2yGKtfJx40++rF7ife5XCeFrfxj1EDzny+sBA15XxIhJ4qMLXS8o163vFb+bQ/QhU
 U+I1uKZtHn072/Z3fxVmP0AX30GXsRMmE2BQSz9K9vH8uCzZco5JplUqtbnVjn31prj4CRzZHun
 YPvXgyS0L/mUcisO4ILmjpPCFwpphQzG7CxbJAsSntResyYDd2A1T/8B+jdERlwhv2LGFR3Dacd
 xsij3mLwS1cjJc0vKtCq00plaYCCgZd1iJS/otN1q60VPJrX5AMxE/H8PGOezO0KK/7xE2FeiMc
 iA+6A15EntinmrA==
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
Changes in v5:
- Rebase on v7.3-rc7 to remove a minor patch context conflict
- Link to v4: https://patch.msgid.link/20260907-tc358762-fixes-v4-0-e3fc3ab5cd83@ideasonboard.com

Changes in v4:
- Rebased on latest upstream, fixing the minor compilation issues that it
  brought
- Added R-b tags
- Link to v3: https://lore.kernel.org/r/20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com

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
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20260326-tc358762-fixes-6f666500da9e

Best regards,
--  
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

