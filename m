Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69F06081764
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ABvYDXGp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DC0010FED8;
	Wed,  4 Nov 2026 20:14:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2967C10E51D;
 Wed,  4 Nov 2026 20:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793823241; x=1825359241;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dHWxAdJ+M2tVCOZu1K8Tp4yUNPgLaSZabScl/nlP+fU=;
 b=ABvYDXGpIqU4bnPBxssmfl5y1EsHe8YJ5tjEKpEBj6VTp/oI3+C6h3QC
 H5Wn3ZnY6qBcmP2QytQzU0zQ6XjUL4za8EsiAqVtVh+sqqAPVcdbyCxCh
 vDU/zV8EQ+HiAGKBuACrSOpNaHQsY3aDr+Mf/zhNsAahlU64shMLbmOM5
 EfjDubkY0Y1FtdULc2pv8xQJIhKZRQYE/FVCr3c2Z5mpi3Xvh0y1XUfrk
 239Yx4RLfQVvrtkxFbsNTeAmRnE9zrXZK4ns8+/l5658v/0aNt20ZXfs3
 2beQb6+/41Dfo/x66InzYMnnaHKZ8iyaV8RgNEIlqI8q/di9zbOuYArW0 g==;
X-CSE-ConnectionGUID: kzYE5iefSyqB0Oiux0Gddw==
X-CSE-MsgGUID: NnrdGaOkQCGAZ38wUs+hPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2589044"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2589044"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 12:14:00 -0800
X-CSE-ConnectionGUID: u63GZ+EbSuyDI7hOz0738g==
X-CSE-MsgGUID: XGe2hIpzRauNXFR7xgvTjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6868444"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO fedora)
 ([10.245.244.20])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 12:13:58 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <nat@pixelcluster.dev>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 0/4] drm/ttm, drm/xe: Support partially backed-up ttm_tts
Date: Wed,  4 Nov 2026 21:13:27 +0100
Message-ID: <20261104201331.2462-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The TTM shrinker backs up a ttm_tt page by page, and can stop part way
through, for example on an allocation failure. A failed restore can
likewise leave some pages resident and some backed up. The ttm_tt has no
way to represent such a partially backed-up state, so its status and the
driver's shrinker accounting can become inconsistent.

This series introduces TTM_TT_FLAG_PARTIAL, which allows a tt to be
partially backed up, keeping track of the pages that were already backed
up and the pages that are still resident. Xe shrinker accounting is
converted to track the number of remaining resident pages so that
partial tts are accounted correctly.

Patch 1 stops marking backed-up shmem folios accessed.
Patch 2 is a pure refactor of the Xe shrinker account helpers.
Patch 3 introduces TTM_TT_FLAG_PARTIAL and the matching Xe accounting.
Patch 4 gates reserve-dipping backup retries on may_writeback.

Note that patch 4 may increase the number of partially backed-up
ttm_tts, since a backup that would need to dip into the kernel reserves
is now aborted when writeback isn't allowed, keeping the progress made
so far. This makes the partial tt handling of patch 3 more important.

Testing:
- W=1 build, checkpatch and kernel-doc are clean.
- TTM and Xe KUnit tests pass.
- The partial backup and restore paths are exercised by the
  shrink-fault-inject* subtests of the xe_bo_shrink IGT test, posted
  separately, using the TTM backup_fault_inject debugfs attribute. They
  need CONFIG_FAULT_INJECTION and CONFIG_FAULT_INJECTION_DEBUG_FS. The
  may_writeback retry in patch 4 is only hit statistically by that test.

IGT test: https://patchwork.freedesktop.org/series/176563/

Test-with: 20261021123315.10033-1-thomas.hellstrom@linux.intel.com

AI tool use: an AI coding assistant was used for review and for
drafting parts of the implementation and commit messages. The author has
reviewed and takes responsibility for all of the changes.

Thomas Hellström (4):
  drm/ttm: Don't mark backed-up shmem folios accessed
  drm/xe/bo: Pass page and tt counts to the shrinker account helpers
  drm/ttm, drm/xe: Introduce TTM_TT_FLAG_PARTIAL for partially backed-up
    tts
  drm/ttm, drm/xe: Gate reserve-dipping backup retries on may_writeback

 drivers/gpu/drm/ttm/ttm_backup.c        |   1 -
 drivers/gpu/drm/ttm/ttm_bo.c            |   5 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c       |   9 +-
 drivers/gpu/drm/ttm/ttm_pool.c          | 175 +++++++++++++++++++++---
 drivers/gpu/drm/ttm/ttm_pool_internal.h |   2 +
 drivers/gpu/drm/ttm/ttm_tt.c            |  36 ++++-
 drivers/gpu/drm/xe/tests/xe_bo.c        |   6 +-
 drivers/gpu/drm/xe/xe_bo.c              | 110 ++++++++++-----
 drivers/gpu/drm/xe/xe_bo.h              |   9 +-
 drivers/gpu/drm/xe/xe_shrinker.c        |  39 +++++-
 include/drm/ttm/ttm_bo.h                |   9 +-
 include/drm/ttm/ttm_tt.h                |  58 ++++++--
 12 files changed, 371 insertions(+), 88 deletions(-)

-- 
2.56.0

