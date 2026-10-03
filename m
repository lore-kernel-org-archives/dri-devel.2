Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F81CA5FF0
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AAF410E19B;
	Sun,  4 Oct 2026 17:18:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=saltyming.net header.i=@saltyming.net header.b="EDHQuxC3";
	dkim-atps=neutral
X-Greylist: delayed 4273 seconds by postgrey-1.36 at gabe;
 Sat, 03 Oct 2026 23:44:07 UTC
Received: from smtp-sv1.saltyming.net (smtp-sv1.saltyming.net [152.53.31.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68EA010E2E5
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 23:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=saltyming-dkim-202512; d=saltyming.net;
 c=relaxed/relaxed; 
 h=MIME-Version:Message-ID:Date:Subject:To:From:Content-Type; t=1791071044;
 x=1791675844; bh=VeZYO3jefwb4yxSTzrfcJ0DSsI77zkNa5o+LTFguS6Y=; b=EDHQuxC3ko
 40w1kgF0Qm4oCx7PEqIsr0Oonsj9COlhraCIf+xpl3jQXl5fT0DniD0DXgw2KX1Jozh07Mpfaef
 mzwZBX1n9JN5ikOt3s4SBOmWKvkOjGeksZjyNTzMOh8G2qJCwgmwe83hEFvA8Y4mJSmKV6W+ft/
 WLhPAvEEcF5fHR3Flm9QIVE7sxhGXw8ZP1cXAtH3cDHoYCLJBQTiHsit3HPsxKIM6/eYqCvFMIk
 JfAKPnAIFGUZRW8xNVROBvmyZHHZXJ6Hc7lIkICZHUT/sqp91VwEc8qFNzUoqX6e/tyS2o/QG7I
 jgxYZDlO3JbLxgvGq4wO8MG4MnFy8f5A==;
Received: by smtp-sv1.saltyming.net (SaltyMail) with ESMTPSA
 (version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256)
 (No client certificate requested)
 id a7350ea4-edff-414b-b391-00e7e8286900
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 22:34:27 +0000
X-Virus-Status: Clean
X-Security-Tags: spf_none, dkim_none, dmarc_fail, dmarc_quarantine, arc_none,
 av_clean, ham
From: Hamin Sung <hamin@saltyming.net>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Aaron Kling <webgeek1234@gmail.com>, Hamin Sung <hamin@saltyming.net>
Subject: [RFC PATCH 0/2] drm/nouveau: select GT21x performance levels by load
 through devfreq
Date: Sun,  4 Oct 2026 07:34:18 +0900
Message-ID: <20261003223420.77993-1-hamin@saltyming.net>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

On GT21x (GT215, GT216, GT218, MCP89), nouveau can reclock by hand, and
booting with nouveau.config=NvClkMode=auto selects the clock subdev's
automatic mode.  Nothing adjusts the automatic pstate on these GPUs, so
automatic mode means the highest pstate.

This series measures graphics engine load with the PDAEMON idle counters
(patch 1) and lets the devfreq simple_ondemand governor choose the pstate
from it while automatic mode is selected (patch 2), along the lines of
the Tegra devfreq support from commit 6ca1701cecdb ("drm/nouveau: Support
devfreq for Tegra").  Nothing changes unless NvClkMode=auto is given at
load time, and a fixed pstate written to debugfs still wins.

The devfreq device lives in the DRM layer rather than next to
gk20a_devfreq.c, because PCI suspend, resume, runtime PM and unbind are
handled in nouveau_drm.c, while nvkm subdev init runs again on every
resume.

On GT21x boards that need memory link training, the first pstate change
runs into the "scheduling while atomic" bug fixed by "drm/nouveau/fb/gt215:
don't sleep with PFIFO paused during link training", which I sent
separately for drm-misc-fixes.  This series makes that first change happen
automatically, so it should go in after that fix.

Testing:

  - built with W=1 and sparse, with and without CONFIG_PM_DEVFREQ, and the
    Kconfig change checked on x86 and on an arm64 defconfig with Tegra
  - GeForce 310M (GT218), 6.18.54 backport: its VBIOS has a single usable
    performance level (the 135 and 405 MHz entries are marked 0xff), so the
    series as posted does not register a devfreq device there.  With a
    local change allowing a single level, devfreq registered
    (simple_ondemand, one OPP at 625 MHz, delayed 100 ms timer) and the
    load samples read 0% when idle, 3-4% while kmscube rendered at 60 fps,
    and 0% again afterwards.

So the counters and the sampling path work, but pstate changes driven by
the governor are untested: I have no GT21x board with several performance
levels.  Reports from anyone whose debugfs pstate file lists more than one
level would help, which is why this is an RFC.

Questions:

  - Is the DRM-layer placement fine, or should this move into nvkm and
    share code with gk20a_devfreq.c?
  - Selecting DEVFREQ_GOV_SIMPLE_ONDEMAND from DRM_NOUVEAU when PM_DEVFREQ
    is enabled: acceptable, or should it be left to the configuration?
  - The 100 ms polling interval and the 50%/20% thresholds were chosen to
    keep the costly GT21x pstate changes infrequent; better defaults are
    welcome.

These patches were written with an AI coding assistant (see the
Assisted-by tags) at my direction, from a session that read the nouveau
clk, pmu and devfreq code and the envytools PDAEMON counter
documentation; the assistant also ran the builds and the hardware test
above on my machine.  I have reviewed the code and take responsibility
for it.

Hamin Sung (2):
  drm/nouveau/pmu/gt215: add graphics engine load counters
  drm/nouveau: select GT21x performance levels by load through devfreq

 drivers/gpu/drm/nouveau/Kbuild                |   1 +
 drivers/gpu/drm/nouveau/Kconfig               |   1 +
 .../gpu/drm/nouveau/include/nvkm/subdev/pmu.h |   2 +
 drivers/gpu/drm/nouveau/nouveau_devfreq.c     | 328 ++++++++++++++++++
 drivers/gpu/drm/nouveau/nouveau_devfreq.h     |  19 +
 drivers/gpu/drm/nouveau/nouveau_drm.c         |   7 +
 drivers/gpu/drm/nouveau/nouveau_drv.h         |   1 +
 .../gpu/drm/nouveau/nvkm/subdev/pmu/base.c    |  29 ++
 .../gpu/drm/nouveau/nvkm/subdev/pmu/gt215.c   |  40 +++
 .../gpu/drm/nouveau/nvkm/subdev/pmu/priv.h    |   5 +
 10 files changed, 433 insertions(+)
 create mode 100644 drivers/gpu/drm/nouveau/nouveau_devfreq.c
 create mode 100644 drivers/gpu/drm/nouveau/nouveau_devfreq.h


base-commit: 70456f05d4b6396b22048c4b8cd3cb98ecf9f9e3
-- 
2.55.0


