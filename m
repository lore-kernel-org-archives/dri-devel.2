Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0233FD8777
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0481710E668;
	Tue, 17 Mar 2026 14:19:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KXpCj6/z";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D836310E668;
 Tue, 17 Mar 2026 14:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773757163; x=1805293163;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hrLfHSYtq10Ih1lzzACnCQyYk2Whjzww/0CADzUVK30=;
 b=KXpCj6/zLYumtgLUj8xtJSo9S7I2Y+HiVcqoaEzjRkdK5YaobAVBXuhR
 +TIZaMtAZM1Vn9n/nUl5TJsAYS/Ndc1Zsf1oYXi5PSCTldmqog3Kj/EfB
 kjNEeqm1GDAWFZdQracoE9Vqztx572cwqdD39ZwWC+4tDcWHrIsuxfVy0
 PSx/uE038sHE1Xe3bmuFVu7oy6o/rwU9DYl5cTTnv3I+W//75nLfv6MfH
 4n9GDVjMLzsWzdh8KKbdplAYrfiaJrBbu0QO5mkFIKiBa1dJu55ueKVOF
 Mnhp2/uLvzNcukMxVhct8JXX5A4IR+1V8tuXoXx/JRPwizmsOoWFf7xbY Q==;
X-CSE-ConnectionGUID: aFLKSXUlSBusNajFpAmGUg==
X-CSE-MsgGUID: y/zi61baTweh3LV1tqUwLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74973130"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="74973130"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 07:19:23 -0700
X-CSE-ConnectionGUID: FZWAN9NWTumo4yCqCsfO+Q==
X-CSE-MsgGUID: q7AjjABPSfWT+rNqylP2CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="260184975"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO fedora)
 ([10.245.245.163])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 07:19:21 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/3] drm/ttm: Improve the TTM operation context
 gfp_retry_mayfail behaviour
Date: Tue, 17 Mar 2026 15:18:53 +0100
Message-ID: <20260317141856.237876-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.53.0
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

Two small patches around the gfp_retry_mayfail behaviour, and
one patch to improve associated kerneldoc.

Patch 1 ensures we don't spam the kernel log on allocation failures.

Patch 2 extends the gfp_retry_mayfail to swap readback.

Patch 3 Improves on the associated kerneldocs.

v2:
- Add patch 3. (Sima).

Thomas Hellström (3):
  drm/ttm: Don't spam the log on buffer object backing store allocation
    failure
  drm/ttm: Avoid invoking the OOM killer when reading back swapped
    content
  drm/ttm: Update the struct ttm_operation_ctx kerneldoc

 drivers/gpu/drm/ttm/ttm_backup.c |  6 ++++--
 drivers/gpu/drm/ttm/ttm_pool.c   |  7 +++++--
 include/drm/ttm/ttm_backup.h     |  2 +-
 include/drm/ttm/ttm_bo.h         | 28 +++++++++++++++++++---------
 4 files changed, 29 insertions(+), 14 deletions(-)

-- 
2.53.0

