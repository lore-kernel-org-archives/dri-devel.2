Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E1B606A331
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=jcGpFyJ/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A4B410E683;
	Tue, 24 Nov 2026 10:08:36 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E781C10E683
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:08:29 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0056CBE1;
 Tue, 24 Nov 2026 11:05:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795514755;
 bh=bqS2jLSNi4KhTg5256S2HyjiKNyp3MPa8cc8mHOrG3c=;
 h=From:Subject:Date:To:Cc:From;
 b=jcGpFyJ/3mp1B7M6cPhTN6ks7GQDn5lTil05Zc3eZPHEEdp3BW0fS/1A5PSD6dwSO
 sXVJHQwR14mf/YTaZ0on9smnOhR67rs6PLHt9d+OmjSdo8bxCrA4fbdtHGTawFLgCG
 FTKHYoXly93seXApGE3j9VHfSBIuCpUt2wFuYrrE=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v6 00/13] drm/bridge: tc358762: Various small fixes
Date: Tue, 24 Nov 2026 12:07:51 +0200
Message-Id: <20261124-tc358762-fixes-v6-0-bd38fed6460f@ideasonboard.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPhhBWsC/3XPy07EMAwF0F8ZZU1QXnYaVvwHYpEnkwXNKBlVo
 FH/HXcWDFLp8tq6R/aNjdxrHuzldGM9L3XUNlPApxOLZz9/ZF4TZaaEQqEV8mvUMFlUvNSvPDg
 WRAQhkneZUenS831Bnbd3yuc6rq1/3/1FbtNDapFccIRirFPK+gKvNWU/2hya7+k5tk+2iYv6q
 9idokihiUs6GsL8gaIfCki9U/R2C7opAD03BXegmIfixP4WQ0rWJWofIKZJHyjwq0ghYacAKTY
 mq6RHAzL8o6zr+gONbx0WywEAAA==
X-Change-ID: 20260326-tc358762-fixes-6f666500da9e
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andreas Kemnade <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2739;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=bqS2jLSNi4KhTg5256S2HyjiKNyp3MPa8cc8mHOrG3c=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBrBWISYllNkML3d6OudedAurtgf2wLc/m3t5vRe
 hwlYsbpwWiJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCawViEgAKCRD6PaqMvJYe
 9dHQD/9ctOuc1r09O7eX8oWJbVYdlU9C1CWOydQ0k3vKDXwiUmCC6G0YZ5VHObO/irs5j0JIT+5
 AVGZjZBFwj3Zlyh5eBji6Ypm1uVB8ko1a3SCaGgM9Np+v8Y6B8kdL41VZjg2ro7/1ngVEgTuKtZ
 b+TsdBD+BOYLQsDmDZlWFEWvsDXHLw8jbdb8VnPd4EqCS7w5m7mb+P++jxB/KPYVjn0pTqGs5xe
 JCIMyhqxd+SM9sZ5BV7EX1Yrcty9+fBRrwis++IncaSXxv+ML9k03szJUkIA7ngshGsyL0Rda0N
 H6P2KkG9i0t02f9D49STskdH/cymBtchogV+cCd1whg3PaRs0Ywqh3UtuMn93/prD7epp2CQ12N
 ElpuN0ebyI9/0M+SI2JgloQV53mJu3ODz5mdViZSRb33qCFEUf/MHJAhxME8+yULTYH9MePq8cE
 teFV5LEENCcOX4moRpnaCrVFNybrh2AWALGl+nYTf8Cf5mmFvMV6GIm7OAdE54GE2JDS6PG6/Km
 Rp0IBz0nCirvTlUgYSWUE8Cw8vyRM0Z8ZO9kOVMDpuiTYUCfT23gjE3Q0nCdeLjqErmdFjghIDB
 IGPmh8E2FAFmZpWpH7NPbSzOH8iqgHyb9ujX60pfe13BzqZv5CzEaauPxwa9B4lmcBHVlxUjzwM
 h9YOLiyQxlIQZcA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

While trying to get Raspberry Pi display v1.1 working on Beagleboard
platforms, I noticed various small issues with the tc358762 driver.

The series also contains a patch to fix the timings in the
powertip,ph800480t013-idf02 panel. The combination of tc358762 +
ph800480t013 is used in the Raspberry Pi display module, so it makes
sense to fix them together.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes in v6:
- Add Andreas' reviewed-bys
- Fix an error handling issue reported by Sashiko in "Improve DPI enable
  handling"
- Link to v5: https://patch.msgid.link/20261015-tc358762-fixes-v5-0-7cd721a6451b@ideasonboard.com

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

 drivers/gpu/drm/bridge/tc358762.c    | 207 ++++++++++++++++++++++++-----------
 drivers/gpu/drm/panel/panel-simple.c |  14 +--
 2 files changed, 148 insertions(+), 73 deletions(-)
---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20260326-tc358762-fixes-6f666500da9e

Best regards,
--  
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

