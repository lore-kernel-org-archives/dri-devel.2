Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3C7606A323
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mEXIaH02
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4DB410F2DA;
	Mon,  9 Nov 2026 13:56:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9D4510F2DA;
 Mon,  9 Nov 2026 13:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794232568; x=1825768568;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=oV49gAQLEypq9avgiK9q6549HVhMmh/9j0RfkzHqnHQ=;
 b=mEXIaH02fUCURoKBVkS+6DTtAHLM7D4dg6M28p1wbQb6CYSo46tXobvY
 E+vryKP4RazNVBNdfRIF1LL4QpoPoXlgUDg7QQy0WSqFaQ+uDEyXjKPO7
 tc3pzWkB1YOMHNmtjXJ93zUr72dssDrdo14oJa7R/awZBOGtUNEexujj7
 bwXZxoZWN/e6he8BlDlTXzGMek7E0BVTD9VfEBjIOf76VJDWlxTEy62dY
 ZCFT5KmUMPZC13+tOX0PGf2zG+4lsUKc+PJjmqRMJUjuiRT79AIY2LSRS
 ZGkbaUGEv2xyY1z+FG3yrpkRaebxkRh3YutcJpg/ACeTfZlSJp8HmnOHO g==;
X-CSE-ConnectionGUID: Hyzgd4YJRLS2BMIhy5CBVQ==
X-CSE-MsgGUID: /K1QN+fdTFipr4or7jdkqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2850692"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2850692"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:56:07 -0800
X-CSE-ConnectionGUID: faELxFf1SIujguJjDWFcog==
X-CSE-MsgGUID: K3gmYn9gRMutsUGE72eKqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8202463"
Received: from pgcooper-mobl2.ger.corp.intel.com (HELO
 mkuoppal-desk.home.arpa) ([10.245.246.220])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:56:03 -0800
From: Mika Kuoppala <mika.kuoppala@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: simona.vetter@ffwll.ch, matthew.brost@intel.com, christian.koenig@amd.com,
 thomas.hellstrom@linux.intel.com, joonas.lahtinen@linux.intel.com,
 gustavo.sousa@intel.com, jan.maslak@intel.com,
 dominik.karol.piatkowski@intel.com, rodrigo.vivi@intel.com,
 andrzej.hajda@intel.com, matthew.auld@intel.com,
 maciej.patelczyk@intel.com, gwan-gyeong.mun@intel.com,
 michal.wajdeczko@intel.com, dri-devel@lists.freedesktop.org,
 Mika Kuoppala <mika.kuoppala@linux.intel.com>
Subject: [PATCH 00/20] Intel Xe GPU Debug Support (eudebug) v11
Date: Mon,  9 Nov 2026 15:55:25 +0200
Message-ID: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This is the v11 patch series for Intel Xe GPU debug support (eudebug).

This is eudebug core only. The EU page fault block (v10 patches
20-27) is not part of current series and will be sent when we have
reached agreement about this series.

One TTM specific core patch is first in the series.

Series should address all but one (see Open questions) sashiko
findings on v10:
https://sashiko.dev/#/patchset/20260903145952.848051-1-mika.kuoppala%40linux.intel.com

Additionally we did multiple local Sashiko runs with claude-opus-5.5 and
gemini-4-argon to get further comments on reworks. All non code
change issues were addressed by more documentation and comments.

We addressed over 170 review findings. Most came from sashiko of
which 13 of them high severity and about 80 medium.

Claude Opus 5.5 was used as an AI coding assistant.

# Major changes from v10

All per connection state is now guarded by a single mutex.
It replaces multiple smaller locks and eliminates all use
of READ_ONCE/WRITE_ONCE access. This addresses most of sashiko
UAF concerns.

Discovery no longer runs on a workqueue. The connect ioctl
takes the target's ioctl_lock for write and pushes
all discovery events into the kfifo before returing.
This avoids the issues discussed in patch 4 in previous
series.

eudebug is now mutually exclusive with OA in addition to SR-IOV.
These interfere with eachothers in HW.

# Open questions

In patch 14, the userptr vm access path still resolves the
addresses through a task_struct's current mm rather than the mm
at bind time. See the XXX FIXME comment in the patch.

# Supported HW

The series has been test with IGT on the following platforms:

- Lunarlake (LNL)
- Battlemage (BMG)
- Pantherlake (PTL)

The code for this submission can be found at:
https://gitlab.freedesktop.org/miku/kernel/-/tree/eudebug-v11

Tests:
https://gitlab.freedesktop.org/DominikPiatkowski-Intel/igt-gpu-tools/-/tree/eudebug-dev-next

Userspace:
https://github.com/intel/compute-runtime/
(behind compile-time default disabled flags
NEO_ENABLE_XE_EU_DEBUG_SUPPORT and NEO_USE_XE_EU_DEBUG_EXP_UPSTREAM)

GDB: https://sourceware.org/pipermail/gdb-patches/2026-August/229340.html

This series continues from the following previous submissions:
v1: https://lists.freedesktop.org/archives/intel-xe/2024-July/043605.html
v2: https://lists.freedesktop.org/archives/intel-xe/2024-October/052260.html
v3: https://lists.freedesktop.org/archives/intel-xe/2024-December/061476.html
v4: https://lists.freedesktop.org/archives/intel-xe/2025-August/091645.html
v5: https://lists.freedesktop.org/archives/intel-xe/2025-October/097859.html
v6: https://lists.freedesktop.org/archives/intel-xe/2025-December/106405.html
v7: https://lists.freedesktop.org/archives/intel-xe/2026-February/115750.html
v8: https://lists.freedesktop.org/archives/intel-xe/2026-April/124147.html
v9: https://lists.freedesktop.org/archives/intel-xe/2026-June/128834.html
v10: https://lists.freedesktop.org/archives/intel-xe/2026-September/139020.html


Christoph Manszewski (5):
  drm/xe: Implement SR-IOV and eudebug exclusivity
  drm/xe: Introduce ADD_DEBUG_DATA and REMOVE_DEBUG_DATA vm bind ops
  drm/xe/eudebug: Introduce vm bind and vm bind debug data events
  drm/xe/eudebug_test: Introduce eudebug live tests
  drm/xe: Add xe_client_debugfs and introduce debug_data file

Dominik Grzegorzek (5):
  drm/xe: Add EUDEBUG_ENABLE exec queue property
  drm/xe/eudebug: Introduce exec_queue events
  drm/xe/eudebug: Add hw enablement
  drm/xe/eudebug: Introduce EU control interface
  drm/xe/eudebug: Introduce per device attention scan worker

Mika Kuoppala (10):
  drm/ttm: Add ttm_bo_access_locked()
  drm/xe/eudebug: Introduce eudebug interface
  drm/xe/eudebug: Add documentation
  drm/xe/eudebug: Add connection establishment documentation
  drm/xe/eudebug: Introduce discovery for resources
  drm/xe/eudebug: Mark guc contexts as debuggable
  drm/xe/eudebug: Add ufence events with acks
  drm/xe/eudebug: Add vm open/pread/pwrite
  drm/xe/eudebug: Add userptr vm pread/pwrite
  drm/xe/eudebug: Track debuggable exec queues

 .../ABI/testing/sysfs-driver-intel-xe-eudebug |   61 +
 Documentation/gpu/driver-uapi.rst             |    2 +
 Documentation/gpu/xe/index.rst                |    1 +
 Documentation/gpu/xe/xe_eudebug.rst           |  100 +
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 MAINTAINERS                                   |    2 +
 drivers/gpu/drm/ttm/ttm_bo_vm.c               |   61 +-
 drivers/gpu/drm/xe/Kconfig                    |   10 +
 drivers/gpu/drm/xe/Makefile                   |    7 +-
 drivers/gpu/drm/xe/abi/guc_actions_abi.h      |    5 +
 drivers/gpu/drm/xe/abi/guc_klvs_abi.h         |    1 +
 drivers/gpu/drm/xe/regs/xe_engine_regs.h      |    1 +
 drivers/gpu/drm/xe/regs/xe_gt_regs.h          |   41 +
 drivers/gpu/drm/xe/tests/xe_eudebug_test.c    |  241 ++
 drivers/gpu/drm/xe/tests/xe_live_test_mod.c   |    5 +
 drivers/gpu/drm/xe/xe_client_debugfs.c        |  134 +
 drivers/gpu/drm/xe/xe_client_debugfs.h        |   17 +
 drivers/gpu/drm/xe/xe_debug_data.c            |  388 ++
 drivers/gpu/drm/xe/xe_debug_data.h            |   22 +
 drivers/gpu/drm/xe/xe_debug_data_types.h      |   26 +
 drivers/gpu/drm/xe/xe_device.c                |   36 +-
 drivers/gpu/drm/xe/xe_device.h                |   53 +
 drivers/gpu/drm/xe/xe_device_types.h          |   75 +
 drivers/gpu/drm/xe/xe_eudebug.c               | 3196 +++++++++++++++++
 drivers/gpu/drm/xe/xe_eudebug.h               |  114 +
 drivers/gpu/drm/xe/xe_eudebug_hw.c            |  806 +++++
 drivers/gpu/drm/xe/xe_eudebug_hw.h            |   30 +
 drivers/gpu/drm/xe/xe_eudebug_types.h         |  212 ++
 drivers/gpu/drm/xe/xe_eudebug_vm.c            |  662 ++++
 drivers/gpu/drm/xe/xe_eudebug_vm.h            |   13 +
 drivers/gpu/drm/xe/xe_exec_queue.c            |  114 +-
 drivers/gpu/drm/xe/xe_exec_queue.h            |    2 +
 drivers/gpu/drm/xe/xe_exec_queue_types.h      |   15 +
 drivers/gpu/drm/xe/xe_gt_debug.c              |  228 ++
 drivers/gpu/drm/xe/xe_gt_debug.h              |   31 +
 drivers/gpu/drm/xe/xe_guc.c                   |   15 +
 drivers/gpu/drm/xe/xe_guc.h                   |    6 +
 drivers/gpu/drm/xe/xe_guc_ads.c               |    5 +
 drivers/gpu/drm/xe/xe_guc_submit.c            |   34 +
 drivers/gpu/drm/xe/xe_hw_engine.h             |   14 +
 drivers/gpu/drm/xe/xe_oa.c                    |   61 +
 drivers/gpu/drm/xe/xe_oa.h                    |    1 +
 drivers/gpu/drm/xe/xe_reg_sr.c                |   19 +-
 drivers/gpu/drm/xe/xe_reg_sr.h                |    4 +-
 drivers/gpu/drm/xe/xe_reg_whitelist.c         |    2 +-
 drivers/gpu/drm/xe/xe_rtp.c                   |    2 +-
 drivers/gpu/drm/xe/xe_sync.c                  |   47 +-
 drivers/gpu/drm/xe/xe_sync.h                  |    3 +
 drivers/gpu/drm/xe/xe_sync_types.h            |   29 +-
 drivers/gpu/drm/xe/xe_userptr.c               |    4 +
 drivers/gpu/drm/xe/xe_userptr.h               |   34 +
 drivers/gpu/drm/xe/xe_vm.c                    |  245 +-
 drivers/gpu/drm/xe/xe_vm_types.h              |   31 +
 drivers/gpu/drm/xe/xe_wa_oob.rules            |    4 +
 include/drm/ttm/ttm_bo.h                      |    2 +
 include/uapi/drm/xe_drm.h                     |  133 +-
 include/uapi/drm/xe_drm_eudebug.h             |  523 +++
 57 files changed, 7870 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-xe-eudebug
 create mode 100644 Documentation/gpu/xe/xe_eudebug.rst
 create mode 100644 drivers/gpu/drm/xe/tests/xe_eudebug_test.c
 create mode 100644 drivers/gpu/drm/xe/xe_client_debugfs.c
 create mode 100644 drivers/gpu/drm/xe/xe_client_debugfs.h
 create mode 100644 drivers/gpu/drm/xe/xe_debug_data.c
 create mode 100644 drivers/gpu/drm/xe/xe_debug_data.h
 create mode 100644 drivers/gpu/drm/xe/xe_debug_data_types.h
 create mode 100644 drivers/gpu/drm/xe/xe_eudebug.c
 create mode 100644 drivers/gpu/drm/xe/xe_eudebug.h
 create mode 100644 drivers/gpu/drm/xe/xe_eudebug_hw.c
 create mode 100644 drivers/gpu/drm/xe/xe_eudebug_hw.h
 create mode 100644 drivers/gpu/drm/xe/xe_eudebug_types.h
 create mode 100644 drivers/gpu/drm/xe/xe_eudebug_vm.c
 create mode 100644 drivers/gpu/drm/xe/xe_eudebug_vm.h
 create mode 100644 drivers/gpu/drm/xe/xe_gt_debug.c
 create mode 100644 drivers/gpu/drm/xe/xe_gt_debug.h
 create mode 100644 include/uapi/drm/xe_drm_eudebug.h

-- 
2.53.0

