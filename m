Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEFE606A329
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j3qv+wbV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E59BC10F260;
	Mon,  2 Nov 2026 22:32:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1C1F10F298;
 Mon,  2 Nov 2026 22:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793658746; x=1825194746;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UzMkKop+on2VdIBOwscyAZlmYg33vzOWA9UVzA+EagY=;
 b=j3qv+wbVP86B41Sz5onyAWhHFAtS/Mx7XKnBnBTpg0a7GtvnNLFkjoJ+
 mUGUDKVLsZM6c1axz2JI+gFXG6UguMJ2KzXjQQlwyD4v74MkeanwWXE9w
 SQTKVZBQl48pAmkZ4lO4NX7aqIbyNFQEk+RmfQoidTfkfihRV0alYfSRw
 lAVYAuEUT9cYR0jPkw4pYo9qrLvgF2iohzHmZ+sN/pP5Ioen59wQ9R49P
 KW/s8ePTykyCwS0bQbGo5lO1mqjGlyYwpUEKmT9/k9BwOZ0Pzz+y7pmn2
 loy1ZOhvH29AzHGXtvOCwZsICUxRy1ulnQsrDgBNsQHVNmHDo3rbtNNBG A==;
X-CSE-ConnectionGUID: eiI23Yc8QkKVYmRyDYCM+A==
X-CSE-MsgGUID: AcPn0flBRnqsDFnbzVYyBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2268429"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2268429"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 14:32:26 -0800
X-CSE-ConnectionGUID: wGV8M1nmQKKNrowsr0MF9g==
X-CSE-MsgGUID: dNyfEjl3Txa5Lqz524rdKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6628955"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 14:32:26 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v7 0/3] Add a minimum age gate to the shrinker + LRU fixes
Date: Mon,  2 Nov 2026 14:32:17 -0800
Message-Id: <20261102223220.1411858-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

 drivers/gpu/drm/ttm/ttm_bo_util.c    |  19 ++++
 drivers/gpu/drm/ttm/ttm_resource.c   |  33 +++++-
 drivers/gpu/drm/xe/Kconfig.profile   |  15 +++
 drivers/gpu/drm/xe/xe_bo.c           |  87 ++++++++++++++
 drivers/gpu/drm/xe/xe_bo.h           |   5 +
 drivers/gpu/drm/xe/xe_bo_types.h     |   8 ++
 drivers/gpu/drm/xe/xe_device_sysfs.c |  35 ++++++
 drivers/gpu/drm/xe/xe_pagefault.c    |   7 ++
 drivers/gpu/drm/xe/xe_shrinker.c     | 164 +++++++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_shrinker.h     |   3 +
 drivers/gpu/drm/xe/xe_vm.c           |   6 +-
 drivers/gpu/drm/xe/xe_vm_types.h     |   8 ++
 include/drm/ttm/ttm_bo.h             |   2 +
 include/drm/ttm/ttm_resource.h       |   1 +
 14 files changed, 379 insertions(+), 14 deletions(-)

-- 
2.34.1

