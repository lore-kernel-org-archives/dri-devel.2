Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F8BC61DCD
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAAF510EF98;
	Thu, 27 Aug 2026 10:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TXaWv+0j";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52A8C10E643;
 Thu, 27 Aug 2026 10:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787825930; x=1819361930;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VZiHrrSANxY47CWW/mWmmyIDhb1J7rIU+VQNH1NvdzI=;
 b=TXaWv+0jVNh1KAErNg9s3ebQgq1wlK7XpvzejLnjXiSYFpqpFXpBh4en
 Y0VyN36sSiE0dmsMeLPw/YLNW6ro7oC9Lh0EBpzrqrblI4BZIiwuzs3t5
 1kSJtoho/oAkKNnnYHqTrF9KcprmV4Ct1hbmf3080mmnPdhiurJA/dKAI
 9WO6SNgJhOj3LbHxrqtQwxi8I7AnJ4rh1AUjpgaaV+huDCO3tuUSoodZS
 GRXyqV5xN2IoRm+mOoYOLbnp+HWUbnNpGogFpQDtPURuEQGWEtKDFQtut
 Sp8BXtOiK5PN99lY0NqDgqOaEijKbcwIo9T+GXuYNKjKZHaKfnzNnmO2D w==;
X-CSE-ConnectionGUID: AbxLpcKBRBi9/Uif4/kAGw==
X-CSE-MsgGUID: DHdKgTTNThi019ZUtGS3jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88445877"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88445877"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:50 -0700
X-CSE-ConnectionGUID: tnS/eY1wTVGw+0G20iCuEA==
X-CSE-MsgGUID: db/MisDRRveUqAWV40QLDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="306057652"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:48 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH 10/13] drm/xe/ttm: Reject VRAM allocations on wedged devices
Date: Thu, 27 Aug 2026 15:47:58 +0530
Message-ID: <20260827101801.1247654-11-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827101801.1247654-1-arvind.yadav@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
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

VRAM is no longer usable after the device is wedged. Reject new VRAM
allocations with -ENOSPC so TTM can try another placement, such as TT.

An allocation racing with the wedge may still complete. The wedged fault
path prevents new VRAM CPU mappings, and device teardown releases the
resource.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
index 05911904c1f9..d0b266672010 100644
--- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
+++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
@@ -54,6 +54,7 @@ static int xe_ttm_vram_mgr_new(struct ttm_resource_manager *man,
 			       const struct ttm_place *place,
 			       struct ttm_resource **res)
 {
+	struct xe_device *xe = ttm_to_xe_device(tbo->bdev);
 	struct xe_ttm_vram_mgr *mgr = to_xe_ttm_vram_mgr(man);
 	struct xe_ttm_vram_mgr_resource *vres;
 	struct gpu_buddy *mm = &mgr->mm;
@@ -61,6 +62,9 @@ static int xe_ttm_vram_mgr_new(struct ttm_resource_manager *man,
 	unsigned long lpfn;
 	int err;
 
+	if (xe_device_wedged(xe))
+		return -ENOSPC;
+
 	lpfn = place->lpfn;
 	if (!lpfn || lpfn > man->size >> PAGE_SHIFT)
 		lpfn = man->size >> PAGE_SHIFT;
-- 
2.43.0

