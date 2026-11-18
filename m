Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E103606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y76Q4IPO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 095E010E6E2;
	Wed, 18 Nov 2026 21:45:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB3910E6E2;
 Wed, 18 Nov 2026 21:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795038329; x=1826574329;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=E8Mi5GwSGcSZlzHnI46hbjXPMPdMhOLYxYEXR8H1SGA=;
 b=Y76Q4IPO+q73eS/usnXkSvAMj9rzKw081uhrfdAMZ7vVeSLflj+YYa3r
 I2FfsKa1fJqzaVx0rF237m7l0Kjg7NMIx0EgcLyYwDCIuZ5bGTtjJuREW
 0Pj5WowP+5/Qw12z+PT/USpaXWPNO7tO1UCGdmFxpMUWqDA7xOZ62IHk9
 iLyNo6cVBDVI5NaTGpKRgnZP7A25+BheY6Vg9Fyyo2ipuBwQjS2Pxx+yD
 ze9AHaigMe1/ia1QaBptdLehnIw7XBotf8GcaTeVQcWmronz+ZvUkfmz3
 F5vQt/yEBvRy/a6mdAgfpBOU3Ng1nNZjGGYonfgN/0zCSJx3IDIiIGavy Q==;
X-CSE-ConnectionGUID: /c9C9BivTk+vmY8SZu7S1w==
X-CSE-MsgGUID: F3PiDKDcSVWnaoAJPHKISA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3862514"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3862514"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:45:28 -0800
X-CSE-ConnectionGUID: 8ARsq6GQRFi7BBoNvbfCfQ==
X-CSE-MsgGUID: 5Dh0BXP9QGu7NcXtqx61Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10390641"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:45:21 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Alessio Belle <alessio.belle@imgtec.com>,
 Alison Wang <alison.wang@nxp.com>, asahi@lists.linux.dev,
 Danilo Krummrich <dakr@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 imagination@lists.freedesktop.org, Janne Grunau <j@jannau.net>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Lyude Paul <lyude@redhat.com>, Magnus Damm <magnus.damm@gmail.com>,
 nouveau@lists.freedesktop.org, Paul Cercueil <paul@crapouillou.net>,
 Russell King <linux@armlinux.org.uk>, Sasha Finkelstein <k@chaosmail.tech>,
 Stefan Agner <stefan@agner.ch>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Subject: [PATCH v4 00/20] drm: Increase COMPILE_TEST=y coverage
Date: Wed, 18 Nov 2026 23:44:57 +0200
Message-ID: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

This series contains a few of my earlier COMPILE_TEST=y coverage
patches that are still not applied. I've also included whole new
set of patches based a more recent excursion with Claude. It
managed to identify some additional drivers we can target.

Compile tested on x86-32, x86-64, arm, and arm64, and I've also 
tried to silence all the resulting new compiler and sparse warnings.
Also a few kernel-doc warnings crept up in pvr so also tried to
clear those out.

The tilcdc DT change is the only one that I think might have
any functional impact. And since I have zero idea about DT
treat it with suspicion!

Assisted by Claude Sonnet 5.5

Cc: Alessio Belle <alessio.belle@imgtec.com>
Cc: Alison Wang <alison.wang@nxp.com>
Cc: asahi@lists.linux.dev
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: imagination@lists.freedesktop.org
Cc: Janne Grunau <j@jannau.net>
Cc: Jyri Sarha <jyri.sarha@iki.fi>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-mips@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
Cc: Luigi Santivetti <luigi.santivetti@imgtec.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: nouveau@lists.freedesktop.org
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Sasha Finkelstein <k@chaosmail.tech>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>

Ville Syrjälä (20):
  drm/tilcdc: Allow build without __iowmb()
  drm/tilcdc: Drop volatile from the mmio pointer in tilcdc_write64()
  drm/tilcdc: Use __le64 for the fallback 64bit write
  drm/tilcdc: Fix endpoint node names in the legacy panel overlay
  drm/tilcdc: Allow build with COMPILE_TEST=y
  drm/armada: Fix printk arguments
  drm/armada: Fix armada_debugfs_crtc_reg_write() return type
  drm/armada: Fix sparse __iomem address space warnings
  drm/armada: Allow build with COMPILE_TEST=y
  drm/fsl-dcu: Allow build with COMPILE_TEST=y
  drm/adp: Include linux/bitfield.h
  drm/adp: Allow build with COMPILE_TEST=y
  drm/imagination: Include io-64-nonatomic-lo-hi.h
  drm/imagination: Use rcu_access_pointer() for dma_fence::ops
  drm/imagination: Allow build with COMPILE_TEST=y
  drm/imagination: Drop stale kernel-doc for
    pvr_mmu_backing_page.pvr_dev
  drm/imagination: Fix kernel-doc for pvr_mmu_op_context anonymous
    structs
  drm/ingenic: Allow ingenic-dw-hdmi build with COMPILE_TEST=y
  drm/nouveau: Allow platform driver build with COMPILE_TEST=y
  drm/rcar-du: Allow VSP and writeback build with COMPILE_TEST=y

 drivers/gpu/drm/adp/Kconfig                     |  2 +-
 drivers/gpu/drm/adp/adp_drv.c                   |  1 +
 drivers/gpu/drm/armada/Kconfig                  |  2 +-
 drivers/gpu/drm/armada/armada_debugfs.c         |  2 +-
 drivers/gpu/drm/armada/armada_fbdev.c           |  2 +-
 drivers/gpu/drm/armada/armada_gem.c             |  7 ++++---
 drivers/gpu/drm/fsl-dcu/Kconfig                 |  2 +-
 drivers/gpu/drm/imagination/Kconfig             |  3 ++-
 drivers/gpu/drm/imagination/pvr_ccb.c           |  5 +++--
 drivers/gpu/drm/imagination/pvr_device.h        |  1 +
 drivers/gpu/drm/imagination/pvr_mmu.c           | 14 ++++++--------
 drivers/gpu/drm/imagination/pvr_queue.c         | 17 +++++++++--------
 drivers/gpu/drm/ingenic/Kconfig                 |  2 +-
 drivers/gpu/drm/nouveau/Kconfig                 |  2 +-
 drivers/gpu/drm/renesas/rcar-du/Kconfig         |  4 ++--
 drivers/gpu/drm/tilcdc/Kconfig                  |  2 +-
 drivers/gpu/drm/tilcdc/tilcdc_panel_legacy.dtso |  4 ++--
 drivers/gpu/drm/tilcdc/tilcdc_regs.h            |  7 +++++--
 18 files changed, 43 insertions(+), 36 deletions(-)

-- 
2.56.0
