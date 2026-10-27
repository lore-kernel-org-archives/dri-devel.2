Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA54606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kAFhKQP+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C94710E4F3;
	Tue, 27 Oct 2026 22:49:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3090710E0AE;
 Tue, 27 Oct 2026 22:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793141347; x=1824677347;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=PyT9OGBhtj/L4eX5YB5KrMA7p3mhdS2urXL9bJSrwAU=;
 b=kAFhKQP+wH1eCptx09fs09w3+z02ljt+mY1IJMrKbdALf4xVgoZFa8OU
 KQ4VcigwAIXfmn5XM5v+QUyg5/Jx1VpR5G0yyh1ir59PE/OMAHuto6q2a
 f2U+qKjFPSqJ0o7sj/zAUZUKVNn9g6nr9tvXrFPQ1/RUtV4vEmXDTBU3K
 lPxzLuA+RKV1FXWBWKv+yiCTS/ksZvhozfTKvJgdco0N7cd30Q8LUlxqJ
 Rhl/Igg0QAJOK8p3wDTDeKQMG/vA75xfRxxZdFZdpVAgeqzVb7GDPGRhJ
 s59uPYod1W7FLLaT1+nBYHeK4Ah6c8iRBIXVMPVa+qyDS2lGf922bcwBH g==;
X-CSE-ConnectionGUID: HMZZqhfFTAaWK60t6LFVtA==
X-CSE-MsgGUID: Fs49C4kmQsebTuI7/w8DDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1842030"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1842030"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 15:49:07 -0700
X-CSE-ConnectionGUID: DTdNmclKSRO2WXvdzo+fWQ==
X-CSE-MsgGUID: arljolqKQ/a0iT2WiIpOhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="5056293"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 15:49:07 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v6 0/3] Add a minimum age gate to the shrinker + LRU fixes
Date: Tue, 27 Oct 2026 15:48:59 -0700
Message-Id: <20261027224902.1085762-1-matthew.brost@intel.com>
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
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
 drivers/gpu/drm/xe/xe_pagefault.c    |   7 ++
 drivers/gpu/drm/xe/xe_shrinker.c     | 164 +++++++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_shrinker.h     |   3 +
 drivers/gpu/drm/xe/xe_vm.c           |   4 +-
 drivers/gpu/drm/xe/xe_vm_types.h     |   8 ++
 include/drm/ttm/ttm_bo.h             |  19 ++++
 include/drm/ttm/ttm_resource.h       |   2 +
 14 files changed, 377 insertions(+), 14 deletions(-)

-- 
2.34.1

