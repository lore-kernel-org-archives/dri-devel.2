Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694E9C98305
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F09110EC46;
	Tue, 22 Sep 2026 10:18:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="b1kwt8pT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F17D210EC37;
 Tue, 22 Sep 2026 10:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790072281; x=1821608281;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ytPJs3u7mQEPpcw57j9EgWtf3WHsyqzZl+34YrpJlUs=;
 b=b1kwt8pTrKyJFgTW3EPKTFpXjrEpboonx7wgyRwRqIvCc/7ofJJVmkiD
 EWivqg5KwTJJn4A/ICKcH0wtE6lpTi2A6SYvgT1Sb24Vb0QgEeZ+oGRQj
 FIFQhM/k20R9D8BtG9Yc/E1Udo8OvygEmkknw0W3juJhKNFsAY/5Le660
 jdtcYPooWgP/xIwVMO/RXOTlQyEtRfYQuaQhLTqI0dLeiGdiH/xF2Hmg8
 yzhCE2p+cE5nf+O0DGbUnLTMN3FqTxNuebfXNcQUyBxOUtMMgAzgPZTHb
 t+RGJsqXE5gj/8+3jnVFsOx6fv3RSluepdkAv5wflCmM81z9l3OkJA8Ib g==;
X-CSE-ConnectionGUID: 0NQ1aRzOSl2Q7Z97/odf6Q==
X-CSE-MsgGUID: 770h0r4AQvmkPHN2hH55Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101322850"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="101322850"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:18:01 -0700
X-CSE-ConnectionGUID: tnaIxMLlSMqGroUq3ZAj/A==
X-CSE-MsgGUID: wMlM66RUSpO95338qP84Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="299307923"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:17:59 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH v2 12/15] drm/xe/ttm: Reject VRAM allocations on wedged devices
Date: Tue, 22 Sep 2026 15:46:57 +0530
Message-ID: <20260922101721.1583542-13-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922101721.1583542-1-arvind.yadav@intel.com>
References: <20260922101721.1583542-1-arvind.yadav@intel.com>
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

VRAM is no longer usable after the device is wedged. Reject observed
VRAM allocations with -ENODEV and stop placement fallback.

An allocation racing with the wedge may still complete. The wedged fault
path prevents new VRAM CPU mappings, and device teardown releases the
resource.

v2:
 - Return -ENODEV to stop placement fallback after a permanent wedge.
   (Rodrigo)

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
index 9a514d983e90..088a690067b9 100644
--- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
+++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
@@ -105,6 +105,7 @@ static int xe_ttm_vram_mgr_new(struct ttm_resource_manager *man,
 			       const struct ttm_place *place,
 			       struct ttm_resource **res)
 {
+	struct xe_device *xe = ttm_to_xe_device(tbo->bdev);
 	struct xe_ttm_vram_mgr *mgr = to_xe_ttm_vram_mgr(man);
 	struct xe_ttm_vram_mgr_resource *vres;
 	struct gpu_buddy *mm = &mgr->mm;
@@ -112,6 +113,9 @@ static int xe_ttm_vram_mgr_new(struct ttm_resource_manager *man,
 	unsigned long lpfn;
 	int err;
 
+	if (xe_device_wedged(xe))
+		return -ENODEV;
+
 	lpfn = place->lpfn;
 	if (!lpfn || lpfn > man->size >> PAGE_SHIFT)
 		lpfn = man->size >> PAGE_SHIFT;
-- 
2.43.0

