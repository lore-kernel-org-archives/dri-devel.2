Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A085CD13DE
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 18:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E039210E484;
	Thu, 30 Apr 2026 18:23:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZEJDEZjV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A42A10F3EB;
 Thu, 30 Apr 2026 18:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777573423; x=1809109423;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/LNOjKC/kiZY6JfD2RWITRAyQVTUPMBtoPL7IFtUdHQ=;
 b=ZEJDEZjV2WMtbf8KnhcqxSNPR+mNsi4PKgCYAmNtgp361LqMZlBxMnBm
 KORdJymWr1i51fZGaCPeUHVlXQNxaCoNiGjN7IEDUVgZxQGUr2TI7B9kK
 EmbQ5cx4hIjTRNFGR78STbXvZPgdVV3667SqMNuKCZ9p0pojfxQeFJz/Y
 WD7UsrtBgUxC3phdMZJW7C2qEjcrXRry89cPW+rlMPXhDBr8NoeZ/bcUC
 PFNLH3wL4aWlG6TRvgA5LZiEBpcsKaFSLYaJA7mCdy7qHlEAhLVu+Lk5m
 iehKsvaybqYFtxf3sOvMj/kp+z1XobaMhQk/dqy6fgHhUGSgTTyOi0Rxn A==;
X-CSE-ConnectionGUID: Ep2LcMc1Q56oISFE8F8Vkw==
X-CSE-MsgGUID: 5AmyyyF+Tb67eS8V4nZchQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="82389016"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="82389016"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 11:23:42 -0700
X-CSE-ConnectionGUID: Fk2jxRHDTHyJvEv68khebw==
X-CSE-MsgGUID: KarcHiudT46NHhQqXvuDlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="231532227"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 11:23:42 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v3 5/6] drm/xe: Set TTM device beneficial_order to 9 (2M)
Date: Thu, 30 Apr 2026 11:23:34 -0700
Message-Id: <20260430182335.2132382-6-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430182335.2132382-1-matthew.brost@intel.com>
References: <20260430182335.2132382-1-matthew.brost@intel.com>
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
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
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

