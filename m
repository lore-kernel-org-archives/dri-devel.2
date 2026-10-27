Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B231606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FKk22f8/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D247110F81D;
	Tue, 27 Oct 2026 20:31:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD34310F81B;
 Tue, 27 Oct 2026 20:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793133073; x=1824669073;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8BnK2KQ4ibOZkRTyuLi3UkHkUEBA/vACF3EcIMjSQy4=;
 b=FKk22f8/IO59CWBssPdPnXykERiRRvfncoABn2j07ZAGqFcJRgKSxQop
 pBTHV3smqOx/sPAxJCe7+COXpZlxSwT68fbL/Cq1ryeBrJd+N0A+dtVSi
 rvahaafKMymThOjSw76nNYRdkSF+Ngic8IfKjLZfac1XvocKwrbt3Je86
 kq/c6Amk7OVV6148NZJimfoSJcOBvZZLJeFiTXFqHbPmuYF0StMLag/Ug
 bPMMbPE1h7QIR1TPCbgXWC6uyqp2EWSMFeuxAdLZ8/OuZm/is0LoQiMtv
 oAs0AGANdzYCK69q3nhvj4ulzN1NwigA7iKCksnSM9TPe3Jcnz3myTSVo w==;
X-CSE-ConnectionGUID: A+nxm6tnRbq1CSnWsUFM7g==
X-CSE-MsgGUID: bOJX6Qg7TSanKcaSuT3m3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1832107"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1832107"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 13:31:13 -0700
X-CSE-ConnectionGUID: zyG7cil1QSyyQPAnEiN+sA==
X-CSE-MsgGUID: 34n/UaY4Tbi2SEAzy57MgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="5035063"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 13:31:12 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v5 0/3] Add a minimum age gate to the shrinker + LRU fixes
Date: Tue, 27 Oct 2026 13:31:04 -0700
Message-Id: <20261027203107.1065800-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix misuse of the TTM LRU in Xe + add a minimum age gate to the shrinker
which is hidden behind a Kconfig for shrinker tuning.

Matt 

Matthew Brost (3):
  drm/xe: Bump the LRU on a successful page fault
  drm/ttm: Allow skipping to the next priority in the bo LRU cursor
  drm/xe: Add a minimum age gate to the shrinker

 drivers/gpu/drm/ttm/ttm_bo_util.c    |   3 +
 drivers/gpu/drm/ttm/ttm_resource.c   |  35 +++++-
 drivers/gpu/drm/xe/Kconfig.profile   |  15 +++
 drivers/gpu/drm/xe/xe_bo.c           |  83 ++++++++++++++
 drivers/gpu/drm/xe/xe_bo.h           |   5 +
 drivers/gpu/drm/xe/xe_bo_types.h     |   8 ++
 drivers/gpu/drm/xe/xe_device_sysfs.c |  35 ++++++
 drivers/gpu/drm/xe/xe_pagefault.c    |   5 +
 drivers/gpu/drm/xe/xe_shrinker.c     | 164 +++++++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_shrinker.h     |   3 +
 drivers/gpu/drm/xe/xe_vm.c           |   4 +-
 drivers/gpu/drm/xe/xe_vm_types.h     |   8 ++
 include/drm/ttm/ttm_bo.h             |  19 ++++
 include/drm/ttm/ttm_resource.h       |   2 +
 14 files changed, 375 insertions(+), 14 deletions(-)

-- 
2.34.1

