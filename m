Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7ED7CD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 19:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 129F710E2A9;
	Tue, 12 May 2026 19:19:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UAQwiONS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1119C10E2A9;
 Tue, 12 May 2026 19:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778613587; x=1810149587;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=EuMqPelopBeDArrWKk2175+d6q9fCx7CditHqqGkoHw=;
 b=UAQwiONSlutOl+9ga2LdPap6fi6bmza8XDeFe4pORw2ZzNhcs62fY23F
 i65U5NPSqhE/xoZTJqX746MxAmUSHVzsmLO/Xm2IoldsGp70YOCZEyKEl
 7OxAF842Zd2lJJ7HtrvpDst29gja3VSU4H6eLiaPllRL5Ncl7vZebroD3
 gQbaSr6GE4r0mlVH6DF3h7MpXoZNXcEGlrcgI4guICMuqxZnM34+9eIym
 dHZzB3Gga6iggBQlY5idriDSh30VSm9uIsQCOYzfy5eSCTmZcq/fMXcpQ
 db4rZWj2fUGCCyBzBcSdfoJyG6/7Jy8cCq+NqE9yMMC9J7pm71krXlEbz A==;
X-CSE-ConnectionGUID: EfcPW1yCSo2AEDBIjrq1rQ==
X-CSE-MsgGUID: sbrZWaLERbawHYCdm6oLdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83406343"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="83406343"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 12:19:46 -0700
X-CSE-ConnectionGUID: yF3zCk34Q4idbIEjgBERiQ==
X-CSE-MsgGUID: 5kT/gbdrRSm7FarWzwopQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="237781373"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa008.jf.intel.com with ESMTP; 12 May 2026 12:19:41 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: simona.vetter@ffwll.ch, airlied@gmail.com, kuba@kernel.org,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, maarten@lankhorst.se,
 zachary.mckevitt@oss.qualcomm.com, rodrigo.vivi@intel.com,
 riana.tauro@intel.com, michal.wajdeczko@intel.com,
 matthew.d.roper@intel.com, umesh.nerlige.ramappa@intel.com,
 mallesh.koujalagi@intel.com, anoop.c.vijay@intel.com,
 aravind.iddamsetty@linux.intel.com, Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 0/9] Introduce error threshold to drm_ras
Date: Wed, 13 May 2026 00:46:01 +0530
Message-ID: <20260512191610.1817578-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series reuses some pieces of [1] and introduces error threshold to
drm_ras infrastructure. This allows user to get and set the threshold
value of a specific error.

Detailed description in commit message and documentation.

[1] https://patchwork.freedesktop.org/series/164393/

v2: Document threshold definition (Riana)
    Return -EOPNOTSUPP on threshold callbacks absence (Riana)
    Cancel and free genlmsg on failure (Riana)
    Document threshold value bounds checking responsibility (Riana)
    Add RAS operation status codes (Riana)

Raag Jadav (6):
  drm/ras: Update counter helpers with counter naming
  drm/ras: Introduce get-error-threshold
  drm/ras: Introduce set-error-threshold
  drm/xe/ras: Get error threshold support
  drm/xe/ras: Set error threshold support
  drm/xe/drm_ras: Wire up error threshold callbacks

Riana Tauro (3):
  drm/xe/uapi: Add additional error components to xe drm_ras
  drm/xe/xe_ras: Move xe drm_ras registration
  drm/xe/xe_ras: Control xe drm_ras registration with a flag

 Documentation/gpu/drm-ras.rst                 |  18 ++
 Documentation/netlink/specs/drm_ras.yaml      |  40 +++-
 drivers/gpu/drm/drm_ras.c                     | 174 +++++++++++++++++-
 drivers/gpu/drm/drm_ras_nl.c                  |  27 +++
 drivers/gpu/drm/drm_ras_nl.h                  |   4 +
 drivers/gpu/drm/xe/xe_device.c                |  19 +-
 drivers/gpu/drm/xe/xe_device_types.h          |   2 +
 drivers/gpu/drm/xe/xe_drm_ras.c               |  27 +++
 drivers/gpu/drm/xe/xe_hw_error.c              |  13 --
 drivers/gpu/drm/xe/xe_pci.c                   |   3 +
 drivers/gpu/drm/xe/xe_pci_types.h             |   1 +
 drivers/gpu/drm/xe/xe_ras.c                   | 150 +++++++++++++++
 drivers/gpu/drm/xe/xe_ras.h                   |   5 +
 drivers/gpu/drm/xe/xe_ras_types.h             |  50 +++++
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.c       |  29 +++
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.h       |   3 +
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |   4 +
 include/drm/drm_ras.h                         |  29 +++
 include/uapi/drm/drm_ras.h                    |   3 +
 include/uapi/drm/xe_drm.h                     |  11 +-
 20 files changed, 581 insertions(+), 31 deletions(-)

-- 
2.43.0

