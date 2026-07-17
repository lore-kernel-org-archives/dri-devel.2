Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B2DC44516
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:28:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C97510F4CE;
	Fri, 17 Jul 2026 09:28:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MVfd0njG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B68110F4CB;
 Fri, 17 Jul 2026 09:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784280514; x=1815816514;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=q6EPouJUVLKKGy2+4B89VL/ohh0IZnZ+7zZye80Lnj0=;
 b=MVfd0njGzZpyX1cKUROfkMvNvopJTeujXK51s/cqks8sJJvHhwz+k187
 BZdNy1t6eQAZUUa8fHoj1FGg4sIVNlH5/+h5u8OwXCgFEpXLyqOlaAlv/
 BqlmhKNjHSYLcNxZeeM+dK5MjnAQANNyN34sCZTVf7VTI6VKJutbEl2cc
 oQoy4yF/4ai+UKJ8MS6Df7+0/H4rzU/zNcsBrwMFjzrnALa1JL8IPpIAo
 XR0+ZzpIUQ0u21jCpZOYx/6Sh62O/cLQVc/1x51wWNbGSC1eW3j8a+oKe
 MgRTCWaW1L9eLJL/gcNkNybBsAxZGILT+o7ShJCmSJ8XIEF2eB+ZGtWMG Q==;
X-CSE-ConnectionGUID: k+jaXEzSTfuoH4yuntqnCQ==
X-CSE-MsgGUID: entAmu1cTdSG4vP6On1CQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84827751"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="84827751"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 02:28:33 -0700
X-CSE-ConnectionGUID: /YM0gONUTMW7aHaBxwWLzg==
X-CSE-MsgGUID: wX0Q3WwSRV2G/3MOP1l1rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="254973572"
Received: from abityuts-desk1.ger.corp.intel.com (HELO fedora)
 ([10.245.245.155])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 02:28:30 -0700
Date: Fri, 17 Jul 2026 11:28:21 +0200
From: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dim-tools@lists.freedesktop.org
Subject: [PULL] drm-xe-fixes
Message-ID: <aln1tRUXZJ_qzD65@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi Dave, Simona

This week's drm-xe-fixes PR. Also slightly late.

A set of driver-only fixes all over the place.

Thanks,
Thomas

drm-xe-fixes-2026-07-17:
Driver Changes:
- Fix BO prefetch with CONSULT_MEM_ADVISE_PREF_LOCK (Himal)
- Hold a dma-buf reference for imported BOs (Nitin)
- Fix writable override for CRI (Alexander)
- Fix VF CCS attach/detach race with in-flight BO moves (Matthew Brost)
- Fix WOPCM size for LNL+ (Daniele)
- Reset current_op in xe_pt_update_ops_init (Zongyao Bai)
- Keep scheduler timeline name alive (Arvind)
- Hold device ref until queue teardown completes (Arvind)
- Disable display in admin only PF mode (Satyanarayana)
The following changes since commit a13c140cc289c0b7b3770bce5b3ad42ab35074aa:

  Linux 7.2-rc3 (2026-07-12 14:16:39 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-fixes-2026-07-17

for you to fetch changes up to 130910bac905a42225f93841e338bbea4a431b1a:

  drm/xe/pf: Disable display in admin only PF mode (2026-07-16 16:53:38 +0200)

----------------------------------------------------------------
Driver Changes:
- Fix BO prefetch with CONSULT_MEM_ADVISE_PREF_LOCK (Himal)
- Hold a dma-buf reference for imported BOs (Nitin)
- Fix writable override for CRI (Alexander)
- Fix VF CCS attach/detach race with in-flight BO moves (Matthew Brost)
- Fix WOPCM size for LNL+ (Daniele)
- Reset current_op in xe_pt_update_ops_init (Zongyao Bai)
- Keep scheduler timeline name alive (Arvind)
- Hold device ref until queue teardown completes (Arvind)
- Disable display in admin only PF mode (Satyanarayana)

----------------------------------------------------------------
Alexander Usyskin (1):
      drm/xe/nvm: fix writable override for CRI

Arvind Yadav (2):
      drm/xe/guc: Keep scheduler timeline name alive
      drm/xe/guc: Hold device ref until queue teardown completes

Daniele Ceraolo Spurio (1):
      drm/xe/wopcm: fix WOPCM size for LNL+

Himal Prasad Ghimiray (1):
      drm/xe/vm: Fix BO prefetch with CONSULT_MEM_ADVISE_PREF_LOC

Matthew Brost (1):
      drm/xe/vf: Fix VF CCS attach/detach race with in-flight BO moves

Nitin Gote (1):
      drm/xe: Hold a dma-buf reference for imported BOs

Satyanarayana K V P (1):
      drm/xe/pf: Disable display in admin only PF mode

Zongyao Bai (1):
      drm/xe/pt: Reset current_op in xe_pt_update_ops_init()

 drivers/gpu/drm/xe/xe_bo.c                   | 58 +++++++++++++++++------
 drivers/gpu/drm/xe/xe_bo.h                   |  3 +-
 drivers/gpu/drm/xe/xe_bo_types.h             |  2 +
 drivers/gpu/drm/xe/xe_device.c               |  4 +-
 drivers/gpu/drm/xe/xe_device_types.h         |  2 +-
 drivers/gpu/drm/xe/xe_dma_buf.c              |  2 +-
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h |  5 ++
 drivers/gpu/drm/xe/xe_guc_submit.c           | 70 ++++++++++++++++------------
 drivers/gpu/drm/xe/xe_guc_types.h            |  2 -
 drivers/gpu/drm/xe/xe_migrate.c              |  5 +-
 drivers/gpu/drm/xe/xe_migrate.h              |  1 +
 drivers/gpu/drm/xe/xe_module.c               | 49 +++++++++++++++++++
 drivers/gpu/drm/xe/xe_module.h               |  5 ++
 drivers/gpu/drm/xe/xe_nvm.c                  |  9 +++-
 drivers/gpu/drm/xe/xe_pci.c                  |  9 +++-
 drivers/gpu/drm/xe/xe_pt.c                   |  3 ++
 drivers/gpu/drm/xe/xe_sriov_vf_ccs.c         | 20 +++++++-
 drivers/gpu/drm/xe/xe_sriov_vf_ccs.h         |  3 +-
 drivers/gpu/drm/xe/xe_vm.c                   | 25 ++++++++--
 drivers/gpu/drm/xe/xe_wopcm.c                | 15 ++++--
 20 files changed, 223 insertions(+), 69 deletions(-)
