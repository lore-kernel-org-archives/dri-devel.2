Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452DEC44500
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05E5110F43A;
	Thu,  2 Jul 2026 15:10:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="l0Osp2qv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC22510F447;
 Thu,  2 Jul 2026 15:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783005030; x=1814541030;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=ZqPDId4rZ0crapCTq1eL01OWkFGEpp+rSALCnzW0tyc=;
 b=l0Osp2qvQj8r9Rl/qUOI4inX7b5KLEEyySq1rStgx3n8N4ljHYEL9ws7
 aQAUl/LZFE5vJszNyOCgaQd7F26UocEDRyGKCuUjxas02A0KWxfEBRskK
 lE+3GPZjwDMY92XWdJbiyuzUdZQGbON1RjATGJiMfUFPJo75B7XU9oAoU
 jvP2EtVzKFKeL7dKlrX0YcZ/fHjBOTFiGHdEuhf6L7MLVZvvF2aN63hDS
 6GCePCrImMVFaMcJ1Pip45T7GAiKX9rGVIGjbHNoehw9OeLd5/XkrBkPJ
 vLyzBOtIId2xwwMUmNyHtOI2VcWZUeTVW+kjkMwEwiudXHCJEAupbP8Ys Q==;
X-CSE-ConnectionGUID: 6NSTBeE4RoyX4AG2iV7Jaw==
X-CSE-MsgGUID: Jdih+9KXSNel97Et777R4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="82751168"
X-IronPort-AV: E=Sophos;i="6.25,144,1779174000"; d="scan'208";a="82751168"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2026 08:10:29 -0700
X-CSE-ConnectionGUID: wCXkafQbQ7OtQtjmelQETw==
X-CSE-MsgGUID: C7earjokT/CYAXobTXsUJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,144,1779174000"; d="scan'208";a="254819431"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO fedora)
 ([10.245.244.232])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2026 08:10:26 -0700
Date: Thu, 2 Jul 2026 17:10:09 +0200
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
Message-ID: <akZ_UbrL94G4F2iA@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
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

Hi Dave, Simona!

Here's the drm-xe-fixes PR towards -rc2.

Mostly various fixes sprinkled all over the place, with the notable
exception of the RTP/OA whitelist fixes backport, manly by Ashutosh

Thanks,
Thomas

drm-xe-fixes-2026-07-02:
Driver Changes:
- Wedge from the timeout handler only after releasing the queue (Rodrigo)
- Fix a NULL pointer dereference (Francois)
- Remove redundant exec_queue_suspended (Lu)
- RTP / OA whitelist fixes (Ashutosh, Gustavo, Thomas)
- Return error on non-migratable faults requiring devmem (Matt Brost)
- Skip FORCE_WC and vm_bound check for external dma-bufs (Matt Auld)
- Hold notifier lock for write on inject test path (Shuicheng)
- Drop bogus static from finish in force_invalidate (Shuicheng)
- Fix double-free of managed BO in error path (Shuicheng)
- Don't attempt to process FAST_REQ or EVENT relays (Michal)
- Fix NPD in bo_meminfo (Matthew Auld)
- Prevent invalid cursor access for purged BOs (Matthew Auld)
- Fix offset alignment for MERT WHITELST_OA_MERT_MMIO_TRG (Ashutosh)
The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-fixes-2026-07-02

for you to fetch changes up to 959b5016e4646b55fd2fd0438932e4c4e9ce171f:

  drm/xe/oa: Fix offset alignment for MERT WHITELIST_OA_MERT_MMIO_TRG (2026-07-02 12:29:44 +0200)

----------------------------------------------------------------
Driver Changes:
- Wedge from the timeout handler only after releasing the queue (Rodrigo)
- Fix a NULL pointer dereference (Francois)
- Remove redundant exec_queue_suspended (Lu)
- RTP / OA whitelist fixes (Ashutosh, Gustavo, Thomas)
- Return error on non-migratable faults requiring devmem (Matt Brost)
- Skip FORCE_WC and vm_bound check for external dma-bufs (Matt Auld)
- Hold notifier lock for write on inject test path (Shuicheng)
- Drop bogus static from finish in force_invalidate (Shuicheng)
- Fix double-free of managed BO in error path (Shuicheng)
- Don't attempt to process FAST_REQ or EVENT relays (Michal)
- Fix NPD in bo_meminfo (Matthew Auld)
- Prevent invalid cursor access for purged BOs (Matthew Auld)
- Fix offset alignment for MERT WHITELST_OA_MERT_MMIO_TRG (Ashutosh)

----------------------------------------------------------------
Ashutosh Dixit (10):
      drm/xe/rtp: Add RING_FORCE_TO_NONPRIV_DENY to OA whitelists
      drm/xe/rtp: Maintain OA whitelists separately
      drm/xe/rtp: Keep track of non-OA nonpriv slots
      drm/xe/rtp: Generalize whitelist_apply_to_hwe
      drm/xe/rtp: Save OA nonpriv registers to register save/restore lists
      drm/xe/rtp: Toggle 'deny' bit to (de-)whitelist OA regs
      drm/xe/rtp: (De-)whitelist OA registers for all hwe's for a gt
      drm/xe/oa: (De-)whitelist OA registers on OA stream open/release
      drm/xe/rtp: Ensure locking/ref counting for OA whitelists
      drm/xe/oa: Fix offset alignment for MERT WHITELIST_OA_MERT_MMIO_TRG

Francois Dugast (1):
      drm/xe/pt: Fix NULL pointer dereference in xe_pt_zap_ptes_entry()

Gustavo Sousa (1):
      drm/xe/rtp: Add struct types for RTP tables

Lu Yao (1):
      drm/xe: Remove redundant exec_queue_suspended() check in submit_exec_queue()

Matthew Auld (3):
      drm/xe/display: skip FORCE_WC and vm_bound check for external dma-bufs
      drm/xe: fix NPD in bo_meminfo()
      drm/xe/pt: prevent invalid cursor access for purged BOs

Matthew Brost (1):
      drm/xe: Return error on non-migratable faults requiring devmem

Michal Wajdeczko (1):
      drm/xe/pf: Don't attempt to process FAST_REQ or EVENT relays

Rodrigo Vivi (1):
      drm/xe: wedge from the timeout handler only after releasing the queue

Shuicheng Lin (3):
      drm/xe/userptr: Hold notifier_lock for write on inject test path
      drm/xe/userptr: Drop bogus static from finish in force_invalidate
      drm/xe/hw_engine: Fix double-free of managed BO in error path

Thomas Hellström (1):
      drm/xe/rtp: Fix build error with clang < 21 and non-const initializers

 drivers/gpu/drm/xe/display/xe_display_bo.c |   3 +-
 drivers/gpu/drm/xe/display/xe_fb_pin.c     |   3 +-
 drivers/gpu/drm/xe/tests/xe_rtp_test.c     | 103 +++++++++++------------------
 drivers/gpu/drm/xe/xe_drm_client.c         |  12 +++-
 drivers/gpu/drm/xe/xe_gt_debugfs.c         |   4 +-
 drivers/gpu/drm/xe/xe_guc_relay.c          |  13 ++--
 drivers/gpu/drm/xe/xe_guc_submit.c         |   9 ++-
 drivers/gpu/drm/xe/xe_hw_engine.c          |  20 +++---
 drivers/gpu/drm/xe/xe_hw_engine_types.h    |   8 +++
 drivers/gpu/drm/xe/xe_oa.c                 |   7 ++
 drivers/gpu/drm/xe/xe_oa_types.h           |   3 +
 drivers/gpu/drm/xe/xe_pt.c                 |  67 ++++++++++++++-----
 drivers/gpu/drm/xe/xe_reg_whitelist.c      | 102 ++++++++++++++++++++++++----
 drivers/gpu/drm/xe/xe_reg_whitelist.h      |   4 ++
 drivers/gpu/drm/xe/xe_rtp.c                |  31 ++++-----
 drivers/gpu/drm/xe/xe_rtp.h                |  24 ++++++-
 drivers/gpu/drm/xe/xe_rtp_types.h          |  10 +++
 drivers/gpu/drm/xe/xe_svm.c                |   6 +-
 drivers/gpu/drm/xe/xe_svm.h                |  15 ++++-
 drivers/gpu/drm/xe/xe_tuning.c             |  45 ++++++-------
 drivers/gpu/drm/xe/xe_userptr.c            |   2 +-
 drivers/gpu/drm/xe/xe_wa.c                 |  89 +++++++++++++------------
 22 files changed, 376 insertions(+), 204 deletions(-)
