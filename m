Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1763C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4408B10F160;
	Wed,  8 Jul 2026 15:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IV/VS91r";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87AA310F189;
 Wed,  8 Jul 2026 15:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783524215; x=1815060215;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:to:cc;
 bh=2bHyd0HYt0l7hyE2ucHxpvOuK+AjtrhAl7AvVaHul+w=;
 b=IV/VS91rPNikudf6pjV7tEc/9co6HsX9Ld6klt0G1Dl5djTg1GmhkD7r
 2Yfki44H7oMmo1ebl3cFs8z/0fYdQ0CjJR4rlIi/Jsommj6BckAsLlMYp
 Cmycv1rvFgAF/zDi6YDkmdRudojc8nXAQNXiWX17tNC7i/CoGXif8ljMd
 k0sv26r2a/fmB1qSPPHCFefvttVMoYiOKOHNzxOXemJAbur3kymrIOvJN
 ggVudZ/gP8oKEWw3xk+78RpnR2aCRcmw0A3Cm+nab37rvqDUnQzv4tM1+
 HWVFBLL1w84zRiJiTiQVk4FYhinft2EMiqTqWefbEYTPoZRpPIOop6/if Q==;
X-CSE-ConnectionGUID: w723QATVROmushc1grEWDQ==
X-CSE-MsgGUID: Xxj+5nBeTamQA0DAWbmSug==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94795912"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="94795912"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 08:23:35 -0700
X-CSE-ConnectionGUID: v7cevtXwQgSkrAfmoaX+cQ==
X-CSE-MsgGUID: wxWuiIpTQsWxdUN/fWviSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="278710205"
Received: from sannilnx-dsk.jer.intel.com (HELO [127.0.1.1]) ([10.12.231.107])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 08:23:32 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
Date: Wed, 08 Jul 2026 18:00:17 +0300
Subject: [PATCH] drm/xe/nvm: fix writable override for CRI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-cri_nvm_fdo_flip-v1-1-792373667334@intel.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBMs+6OrREjpWAOloiCBdPek5
 bd4L0PEQBhhrjIETBTJ2YKmrkCdmz2QkS6GlrcDH/nEVCBp0y2NdtJc5JkQYu+7HhutJyiZD2j
 o+ZfL+r4fclTRvGIAAAA=
X-Change-ID: 20260708-cri_nvm_fdo_flip-333b545e1dd8
To: Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Alexander Usyskin <alexander.usyskin@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783522843; l=2075;
 i=alexander.usyskin@intel.com; s=20260315; h=from:subject:message-id;
 bh=2bHyd0HYt0l7hyE2ucHxpvOuK+AjtrhAl7AvVaHul+w=;
 b=u69QQyE7bZIM7sHe+PyjKm6pWbCkMTCF227z8KfKfdORYwtCWqsrtIbSe48v65lka92Q8wfz+
 5Zjzil3vWjOBuedkUx3D3Y2Mq1cPazPHNEaOQ64EwJK1QBlwWFX1yef
X-Developer-Key: i=alexander.usyskin@intel.com; a=ed25519;
 pk=X+qoF/nFCdDOV04IForWSxnkyoCAbUE10egZi6PSfcU=
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

The witable override should be set when FDO_MODE bit is enabled.
Fix the comparison to distingush this case from legacy systems
where bit should be disabled to have override.

Cc: stable@vger.kernel.org
Fixes: 9dde74fd9e65 ("drm/xe/nvm: enable cri platform")
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/gpu/drm/xe/xe_nvm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_nvm.c b/drivers/gpu/drm/xe/xe_nvm.c
index 33487e91f366..d50ee414e83e 100644
--- a/drivers/gpu/drm/xe/xe_nvm.c
+++ b/drivers/gpu/drm/xe/xe_nvm.c
@@ -60,35 +60,39 @@ static bool xe_nvm_writable_override(struct xe_device *xe)
 	struct xe_mmio *mmio = xe_root_tile_mmio(xe);
 	bool writable_override;
 	struct xe_reg reg;
-	u32 test_bit;
+	u32 test_bit, test_val;
 
 	switch (xe->info.platform) {
 	case XE_CRESCENTISLAND:
 		reg = PCODE_SCRATCH(0);
-		test_bit = FDO_MODE;
+		test_val = test_bit = FDO_MODE;
 		break;
 	case XE_BATTLEMAGE:
 		reg = HECI_FWSTS2(DG2_GSC_HECI2_BASE);
 		test_bit = HECI_FW_STATUS_2_NVM_ACCESS_MODE;
+		test_val = 0;
 		break;
 	case XE_PVC:
 		reg = HECI_FWSTS2(PVC_GSC_HECI2_BASE);
 		test_bit = HECI_FW_STATUS_2_NVM_ACCESS_MODE;
+		test_val = 0;
 		break;
 	case XE_DG2:
 		reg = HECI_FWSTS2(DG2_GSC_HECI2_BASE);
 		test_bit = HECI_FW_STATUS_2_NVM_ACCESS_MODE;
+		test_val = 0;
 		break;
 	case XE_DG1:
 		reg = HECI_FWSTS2(DG1_GSC_HECI2_BASE);
 		test_bit = HECI_FW_STATUS_2_NVM_ACCESS_MODE;
+		test_val = 0;
 		break;
 	default:
 		drm_err(&xe->drm, "Unknown platform\n");
 		return true;
 	}
 
-	writable_override = !(xe_mmio_read32(mmio, reg) & test_bit);
+	writable_override = (xe_mmio_read32(mmio, reg) & test_bit) == test_val;
 	if (writable_override)
 		drm_info(&xe->drm, "NVM access overridden by jumper\n");
 	return writable_override;

---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260708-cri_nvm_fdo_flip-333b545e1dd8

Best regards,
-- 
Alexander Usyskin <alexander.usyskin@intel.com>

