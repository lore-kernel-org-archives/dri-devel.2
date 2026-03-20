Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B1E1099B36
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 18:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07D0E10EB2A;
	Fri, 20 Mar 2026 18:35:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZZpBAKLy";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3579010EB00;
 Fri, 20 Mar 2026 18:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774031749; x=1805567749;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/xKrutZJIMkwQc/fRa1ZsEwJazxvQVyyBisOZn9/VBY=;
 b=ZZpBAKLysnaW5LI7MCRau9mNk6T9QGTaKm24Iiw4D0GF33xJBUZ4PrCE
 qN7Oiwu8TFIufh+zWGPnDfiTCtE948eCEf9yADn42BiFXgR1OyGNOqlrZ
 prXGj4EP0eE4a7tUE8Z+TKGkBfMGc8dNM+OyM2zMWJ1gRXfVUMV+oayZr
 YzJTVgXXkLfUDIZCA11WXLl36DpCKmYl2VXiUiebGQzYlCh4rvZ+slqFt
 CW4hicjv5gYG25grueYp+dtXSiqQA+Ft2WPk3sv5c7Cg6MeZPQ28+w0Lo
 xhkfJIvHhqGx+GOhMMWRFgdwDAqEy1Gy9187TPQoL3psFzQq6am3H732P A==;
X-CSE-ConnectionGUID: bvi41iAHSXeboRCH6f+MoQ==
X-CSE-MsgGUID: 3Vy3vOLlRlqGsJdSCCANWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="75092813"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="75092813"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 11:35:49 -0700
X-CSE-ConnectionGUID: 7FfpdhANRRGGPr3gpu2dbA==
X-CSE-MsgGUID: PK2LwWSITEGmcb3ZoGpmaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="223399389"
Received: from dut4086lnl.fm.intel.com ([10.105.10.101])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 11:35:48 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: saurabhg.gupta@intel.com, alex.zuo@intel.com, jonathan.cavitt@intel.com,
 joonas.lahtinen@linux.intel.com, matthew.brost@intel.com,
 jianxun.zhang@intel.com, shuicheng.lin@intel.com,
 dri-devel@lists.freedesktop.org, Michal.Wajdeczko@intel.com,
 michal.mrozek@intel.com, raag.jadav@intel.com, ivan.briano@intel.com,
 matthew.auld@intel.com, dafna.hirschfeld@intel.com, jose.souza@intel.com,
 thomas.hellstrom@linux.intel.com
Subject: [PATCH v38 0/4] drm/xe/xe_vm: Implement xe_vm_get_property_ioctl
Date: Fri, 20 Mar 2026 18:35:47 +0000
Message-ID: <20260320183547.61017-6-jonathan.cavitt@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add additional information to each VM so they can report up to the first
50 seen faults.  Only pagefaults are saved this way currently, though in
the future, all faults should be tracked by the VM for future reporting.

Additionally, of the pagefaults reported, only failed pagefaults are
saved this way, as successful pagefaults should recover silently and not
need to be reported to userspace.

To allow userspace to access these faults, a new ioctl -
xe_vm_get_property_ioct - was created.

v2: (Matt Brost)
- Break full ban list request into a separate property.
- Reformat drm_xe_vm_get_property struct.
- Remove need for drm_xe_faults helper struct.
- Separate data pointer and scalar return value in ioctl.
- Get address type on pagefault report and save it to the pagefault.
- Correctly reject writes to read-only VMAs.
- Miscellaneous formatting fixes.

v3: (Matt Brost)
- Only allow querying of failed pagefaults

v4:
- Remove unnecessary size parameter from helper function, as it
  is a property of the arguments. (jcavitt)
- Remove unnecessary copy_from_user (Jainxun)
- Set address_precision to 1 (Jainxun)
- Report max size instead of dynamic size for memory allocation
  purposes.  Total memory usage is reported separately.

v5:
- Return int from xe_vm_get_property_size (Shuicheng)
- Fix memory leak (Shuicheng)
- Remove unnecessary size variable (jcavitt)

v6:
- Free vm after use (Shuicheng)
- Compress pf copy logic (Shuicheng)
- Update fault_unsuccessful before storing (Shuicheng)
- Fix old struct name in comments (Shuicheng)
- Keep first 50 pagefaults instead of last 50 (Jianxun)
- Rename ioctl to xe_vm_get_faults_ioctl (jcavitt)

v7:
- Avoid unnecessary execution by checking MAX_PFS earlier (jcavitt)
- Fix double-locking error (jcavitt)
- Assert kmemdump is successful (Shuicheng)
- Repair and move fill_faults break condition (Dan Carpenter)
- Free vm after use (jcavitt)
- Combine assertions (jcavitt)
- Expand size check in xe_vm_get_faults_ioctl (jcavitt)
- Remove return mask from fill_faults, as return is already -EFAULT or 0
  (jcavitt)

v8:
- Revert back to using drm_xe_vm_get_property_ioctl
- s/Migrate/Move (Michal)
- s/xe_pagefault/xe_gt_pagefault (Michal)
- Create new header file, xe_gt_pagefault_types.h (Michal)
- Add and fix kernel docs (Michal)
- Rename xe_vm.pfs to xe_vm.faults (jcavitt)
- Store fault data and not pagefault in xe_vm faults list (jcavitt)
- Store address, address type, and address precision per fault (jcavitt)
- Store engine class and instance data per fault (Jianxun)
- Properly handle kzalloc error (Michal W)
- s/MAX_PFS/MAX_FAULTS_SAVED_PER_VM (Michal W)
- Store fault level per fault (Micahl M)
- Apply better copy_to_user logic (jcavitt)

v9:
- More kernel doc fixes (Michal W, Jianxun)
- Better error handling (jcavitt)

v10:
- Convert enums to defines in regs folder (Michal W)
- Move xe_guc_pagefault_desc to regs folder (Michal W)
- Future-proof size logic for zero-size properties (jcavitt)
- Replace address type extern with access type (Jianxun)
- Add fault type to xe_drm_fault (Jianxun)

v11:
- Remove unnecessary switch case logic (Raag)
- Compress size get, size validation, and property fill functions into a
  single helper function (jcavitt)
- Assert valid size (jcavitt)
- Store pagefaults in non-fault-mode VMs as well (Jianxun)

v12:
- Remove unnecessary else condition
- Correct backwards helper function size logic (jcavitt)
- Fix kernel docs and comments (Michal W)

v13:
- Move xe and user engine class mapping arrays to header (John H)

v14:
- Fix double locking issue (Jianxun)
- Use size_t instead of int (Raag)
- Remove unnecessary includes (jcavitt)

v15:
- Do not report faults from reserved engines (Jianxun)

v16:
- Remove engine class and instance (Ivan)

v17:
- Map access type, fault type, and fault level to user macros (Matt
  Brost, Ivan)

v18:
- Add uAPI merge request to this cover letter

v19:
- Perform kzalloc outside of lock (Auld)

v20:
- Fix inconsistent use of whitespace in defines

v21:
- Remove unnecessary size assertion (jcavitt)

v22:
- Fix xe_vm_fault_entry kernel docs (Shuicheng)

v23:
- Nit fixes (Matt Brost)

v24:
- s/xe_pagefault_desc.h/xe_guc_pagefault_desc.h (Dafna)
- Move PF_MSG_LEN_DW to regs folder (Dafna)

v25:
- Revert changes from last revision (John H)
- Add missing bspec (Michal W)

v26:
- Rebase on top of latest change to xe_pagefault layer (jcavitt)

v27:
- Apply max line length (Matt Brost)
- Correctly ignore fault mode in save_pagefault_to_vm (jcavitt)

v28:
- Do not copy_to_user in critical section (Matt Brost)
- Assert args->size is multiple of sizeof(struct xe_vm_fault) (Matt
  Brost)
- s/save_pagefault_to_vm/xe_pagefault_save_to_vm (Matt Brost)
- Use guard instead of spin_lock/unlock (Matt Brost)
- GT was added to xe_pagefault struct.  Use xe_gt_hw_engine
  instead of creating a new helper function (Matt Brost)

v29:
- Track address precision separately and report it accurately (Matt
  Brost)
- Remove unnecessary memset (Matt Brost)

v30:
- Keep u8 values together (Matt Brost)

v31:
- Rebase (jcavitt)

v32:
- Rebase (jcavitt)

v33:
- Rebase (jcavitt)

v34:
- Rebase (jcavitt)
- Save space for future expansion in pagefault struct (Matt Brost)

v35:
- Revert v34
- Rebase (jcavitt)
- Remove fixed value addr_precision (Matt Brost)
  - Since address precision is fixed, remove debug print statement as
    well (jcavitt)

v36:
- Rebase (jcavitt)
- s/Refactor/Rebase where needed in cover letter (jcavitt)

v37:
- Report canonicalized address (Jose)
- Mask out prefetch data from access type (Jose, jcavitt)

v38:
- Clarify address is canonical (José)

uAPI: https://github.com/intel/compute-runtime/pull/878
Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Suggested-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Suggested-by: Matthew Brost <matthew.brost@intel.com>
Cc: Zhang Jianxun <jianxun.zhang@intel.com>
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: Michal Wajdeczko <Michal.Wajdeczko@intel.com>
Cc: Michal Mrozek <michal.mrozek@intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>
Cc: John Harrison <john.c.harrison@intel.com>
Cc: Ivan Briano <ivan.briano@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Dafna Hirschfeld <dafna.hirschfeld@intel.com>
Cc: Jose Souza <jose.souza@intel.com>

Jonathan Cavitt (4):
  drm/xe/xe_pagefault: Disallow writes to read-only VMAs
  drm/xe/uapi: Define drm_xe_vm_get_property
  drm/xe/xe_vm: Add per VM fault info
  drm/xe/xe_vm: Implement xe_vm_get_property_ioctl

 drivers/gpu/drm/xe/xe_device.c    |   2 +
 drivers/gpu/drm/xe/xe_pagefault.c |  32 +++++
 drivers/gpu/drm/xe/xe_vm.c        | 191 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_vm.h        |  12 ++
 drivers/gpu/drm/xe/xe_vm_types.h  |  29 +++++
 include/uapi/drm/xe_drm.h         |  86 ++++++++++++++
 6 files changed, 352 insertions(+)

-- 
2.43.0

