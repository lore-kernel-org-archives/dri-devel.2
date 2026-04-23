Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D985F94CBC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 235D510EF53;
	Thu, 23 Apr 2026 05:57:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lUQz86px";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFBCD10EAEE;
 Thu, 23 Apr 2026 05:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776923823; x=1808459823;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6mVJI366d0BK3am7pMwcum5OHh+aQOcg6S9qgczD/KA=;
 b=lUQz86pxLoEpr3TUQAXYKLFNDuaaxiQvo+zh2d91g9WRhXOmdC+5BcAZ
 ZZDT40QtiP/Z2GATjuWWIcH8usbRtuFO+lFyprKqG9X5c5lo4kQsoqo72
 6H6KP0Nx/fzA0VN5JPPK9I1NaRb0lCznSeZ02FYMbgphcDpOpEzl7vz42
 /MiNm+SEIsrSfdXP5wkxjSoPhaz7kQZhug1wgPy4wI2wJQF71tTUbqCXm
 OjMpHnSAKKpVeSejSHwD7E4FxX6KC4/u/scB9iLcfEwywxt77SF2WM17P
 Xc20Uef4W+gzdQK0516SHwC6WfpPauPN1MxS0TE7LafEhhkEXdfP2xaFS g==;
X-CSE-ConnectionGUID: UqnblR3BRhykq+EWoHeuWw==
X-CSE-MsgGUID: j9Y3RJ12RJKgn6Mx9MYfjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="89273781"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="89273781"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 22:57:03 -0700
X-CSE-ConnectionGUID: IehJUA0kRoWplzM7WPws9w==
X-CSE-MsgGUID: qUgOYuTWS5qFSRIHk9Z+Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="255853900"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 22:57:03 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>,
 Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v2 4/5] drm/xe: Set TTM device beneficial_order to 9 (2M)
Date: Wed, 22 Apr 2026 22:56:55 -0700
Message-Id: <20260423055656.1696379-5-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260423055656.1696379-1-matthew.brost@intel.com>
References: <20260423055656.1696379-1-matthew.brost@intel.com>
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

Set the TTM device beneficial_order to 9 (2M), which is the sweet
spot for Xe when attempting reclaim on system memory BOs, as it matches
the large GPU page size. This ensures reclaim is attempted at the most
effective order for the driver.

Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 4b45b617a039..3f719ab08d1c 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -500,7 +500,8 @@ struct xe_device *xe_device_create(struct pci_dev *pdev,
 
 	err = ttm_device_init(&xe->ttm, &xe_ttm_funcs, xe->drm.dev,
 			      xe->drm.anon_inode->i_mapping,
-			      xe->drm.vma_offset_manager, 0);
+			      xe->drm.vma_offset_manager,
+			      TTM_ALLOCATION_POOL_BENEFICIAL_ORDER(get_order(SZ_2M)));
 	if (WARN_ON(err))
 		return ERR_PTR(err);
 
-- 
2.34.1

