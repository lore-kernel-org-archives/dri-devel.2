Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB89A606A31D
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 12:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UnCp/ga0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 689CF10FBEE;
	Wed, 28 Oct 2026 12:21:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2338C10FBE5;
 Wed, 28 Oct 2026 12:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793190102; x=1824726102;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=t7JUaZEJfNWanWA4rdaDWi9dYzoJDfBRLKdKz5TOTxU=;
 b=UnCp/ga0lodfob1mJs0o9EVHsIc8s2+e2z+0GUb47pHoJfsYunXtw9kg
 Q1HCUYNEP5qwJJk8uE131pA1kbnepDpyiISQzfKa774iTPFLMIHt/Frvd
 SPb3PxOg/wVqPEuN/7mxSVMjub4QYjnnClXdlDmu1+G/UE7i+ExQ5qfAU
 fZZNFfTEMJUO4OmcUzMcIzh1wPMMGKlNqotUHzLrA8Qw2q/qQBrAZf1Cv
 TGI3+8lcd7OAWOZHSwUcH1MUj1lW3NgU6Nj0Le62wzQsIMGW6sqWFaKhF
 EVrbryLc3+ApupOQyQ1OAOtEid0/1hVcIS09FiLTt9omMe3p5ugcB7hL1 Q==;
X-CSE-ConnectionGUID: tqc83vHXQqi8CLWQ073z3w==
X-CSE-MsgGUID: hLpQZPAVQDGCF+KHjncWkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1939031"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1939031"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 05:21:41 -0700
X-CSE-ConnectionGUID: eIofGgE9Tc2VMItUIJnddw==
X-CSE-MsgGUID: BX17nw/OQhKDJTivNGv4+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4838450"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 05:21:40 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: rodrigo.vivi@intel.com, matthew.brost@intel.com,
 himal.prasad.ghimiray@intel.com, thomas.hellstrom@linux.intel.com,
 sanjay.kumar.yadav@intel.com
Subject: [PATCH v2 0/4] drm/xe: Fix VM teardown and migration queue recovery
Date: Wed, 28 Oct 2026 17:51:21 +0530
Message-ID: <20261028122125.3772832-1-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On BMG, terminating a process with Ctrl+C while GPU work is running
under VRAM pressure can cause an RCS page fault followed by a migration
queue timeout on BCS8. Recovery can then end in repeated timeouts and
device wedging.

During file close, exec queues are killed asynchronously. VM teardown
can remove their mappings before queue cleanup has finished, while
the hardware may still access them.

This series starts scheduling disable earlier, marks VMs as closing
before queue cleanup, and keeps their mappings until the tracked
queues have been freed. It also holds a device reference across final
VM destruction.

File close uses one five-second queue-wait budget across all VMs.
If cleanup is still pending, VM teardown is deferred. VM destroy
defers without waiting for queues whose handles remain owned by
userspace. Existing teardown waits are unchanged.

With the reduced four-patch series, I have not reproduced the failure
in my current testing. The hardware link between the RCS fault and
the BCS8 stall remains under investigation.

Changes in v2:
- Reduce the series to four patches following review.
- Run deferred VM close and final VM destruction on the
  module-lifetime destroy workqueue.
- Use a shared queue-wait budget during file close and defer teardown
  when queues remain.

Arvind Yadav (3):
  drm/xe: Hold a device reference across deferred VM destruction
  drm/xe: Mark VMs as closing before queue cleanup
  drm/xe: Defer VM teardown until exec queue cleanup completes

Matthew Brost (1):
  drm/xe: Disable scheduling early on FD close to avoid CAT error
    cascade

 drivers/gpu/drm/xe/xe_device.c               |  25 ++-
 drivers/gpu/drm/xe/xe_exec_queue.c           |  22 ++-
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h |   2 +-
 drivers/gpu/drm/xe/xe_guc_submit.c           |  46 ++++-
 drivers/gpu/drm/xe/xe_pagefault.c            |   2 +-
 drivers/gpu/drm/xe/xe_svm.c                  |   3 +-
 drivers/gpu/drm/xe/xe_vm.c                   | 191 +++++++++++++++++--
 drivers/gpu/drm/xe/xe_vm.h                   |  14 +-
 drivers/gpu/drm/xe/xe_vm_types.h             |  16 ++
 9 files changed, 286 insertions(+), 35 deletions(-)

-- 
2.43.0

