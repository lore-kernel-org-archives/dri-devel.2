Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CF6F99C6B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 21:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67E8D10EA9C;
	Fri, 17 Apr 2026 21:21:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GIrIOe85";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0452B10E120;
 Fri, 17 Apr 2026 21:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776460874; x=1807996874;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zinImahNnQ7G8Aah47MMc2rdGquA+bSjr2q6X8QR25g=;
 b=GIrIOe850TQTu8VfbVj1XNmY4K44AyKch6Tyga+dT6v0ffaZ56HIFvns
 tquoSXVLxIvaKqkprV7bJrXiz3YOuPPW3ibkHWfRNRnpJC5iIqoxpdLzg
 MFSxqT3KrUJ8FMReuSXtJwOwdelTbXQH/1piG7g9ME0pOtSSj10eL48j+
 ALLKIrzm4wr5apWzDexFysTJNzB2ADlB7zRPFAO2fj9HgVT+3yKBT8qEn
 gM01TYk/Qt6htQanGKXWoP71vujxFlrhfEOLJq9TbqSgKcOULo5GfvNec
 Uh2JCQKjGqps34jOxf7Pe15k9nFahFBaIoxKsNnX5kLL1N9K0UBtO7IpQ w==;
X-CSE-ConnectionGUID: 1o+QhBLoTgmdYuOFZGabYw==
X-CSE-MsgGUID: mds1xydTSsagaO4enAfoIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="95046058"
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; d="scan'208";a="95046058"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 14:20:59 -0700
X-CSE-ConnectionGUID: MwtYXDOWQUyeNjvc1Pi/IA==
X-CSE-MsgGUID: k5pcRkPYSRSBd7NZSrDrgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; d="scan'208";a="235503751"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa004.jf.intel.com with ESMTP; 17 Apr 2026 14:20:53 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: simona.vetter@ffwll.ch, airlied@gmail.com, kuba@kernel.org,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, maarten@lankhorst.se,
 zachary.mckevitt@oss.qualcomm.com, rodrigo.vivi@intel.com,
 riana.tauro@intel.com, michal.wajdeczko@intel.com,
 matthew.d.roper@intel.com, umesh.nerlige.ramappa@intel.com,
 mallesh.koujalagi@intel.com, soham.purkait@intel.com,
 anoop.c.vijay@intel.com, aravind.iddamsetty@linux.intel.com,
 Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 00/11] Introduce error threshold to drm_ras
Date: Sat, 18 Apr 2026 02:46:35 +0530
Message-ID: <20260417211730.837345-1-raag.jadav@intel.com>
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

This series reuses some pieces of [1] and [2] and introduces error
threshold to drm_ras infrastructure. This allows user to get and set
the threshold value of a specific error.

Detailed description in commit message and documentation.

[1] https://patchwork.freedesktop.org/series/164393/
[2] https://patchwork.freedesktop.org/series/160184/

Raag Jadav (9):
  drm/ras: Update counter helpers with counter naming
  drm/ras: Introduce get-error-threshold
  drm/ras: Introduce set-error-threshold
  drm/xe/sysctrl: Add system controller interrupt handler
  drm/xe/sysctrl: Add system controller event support
  drm/xe/ras: Introduce correctable error handling
  drm/xe/ras: Get error threshold support
  drm/xe/ras: Set error threshold support
  drm/xe/drm_ras: Wire up error threshold callbacks

Riana Tauro (2):
  drm/xe/uapi: Add additional error components to XE drm_ras
  drm/xe/ras: Add flag for Xe RAS

 Documentation/gpu/drm-ras.rst                 |  17 ++
 Documentation/netlink/specs/drm_ras.yaml      |  49 +++++
 drivers/gpu/drm/drm_ras.c                     | 165 +++++++++++++-
 drivers/gpu/drm/drm_ras_nl.c                  |  27 +++
 drivers/gpu/drm/drm_ras_nl.h                  |   4 +
 drivers/gpu/drm/xe/Makefile                   |   2 +
 drivers/gpu/drm/xe/regs/xe_irq_regs.h         |   1 +
 drivers/gpu/drm/xe/xe_device_types.h          |   2 +
 drivers/gpu/drm/xe/xe_drm_ras.c               |  29 ++-
 drivers/gpu/drm/xe/xe_hw_error.c              |   2 +-
 drivers/gpu/drm/xe/xe_irq.c                   |   2 +
 drivers/gpu/drm/xe/xe_pci.c                   |   3 +
 drivers/gpu/drm/xe/xe_pci_types.h             |   1 +
 drivers/gpu/drm/xe/xe_ras.c                   | 207 ++++++++++++++++++
 drivers/gpu/drm/xe/xe_ras.h                   |  19 ++
 drivers/gpu/drm/xe/xe_ras_types.h             | 123 +++++++++++
 drivers/gpu/drm/xe/xe_sysctrl.c               |  46 +++-
 drivers/gpu/drm/xe/xe_sysctrl.h               |   2 +
 drivers/gpu/drm/xe/xe_sysctrl_event.c         |  87 ++++++++
 drivers/gpu/drm/xe/xe_sysctrl_event_types.h   |  57 +++++
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |  22 ++
 drivers/gpu/drm/xe/xe_sysctrl_types.h         |   7 +
 include/drm/drm_ras.h                         |  27 +++
 include/uapi/drm/drm_ras.h                    |  12 +
 include/uapi/drm/xe_drm.h                     |  11 +-
 25 files changed, 906 insertions(+), 18 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_ras.c
 create mode 100644 drivers/gpu/drm/xe/xe_ras.h
 create mode 100644 drivers/gpu/drm/xe/xe_ras_types.h
 create mode 100644 drivers/gpu/drm/xe/xe_sysctrl_event.c
 create mode 100644 drivers/gpu/drm/xe/xe_sysctrl_event_types.h

-- 
2.43.0

