Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EF4CA5FC7
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:15:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CCD710F416;
	Wed, 30 Sep 2026 14:15:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CdmVcyGy";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A02E10E796;
 Wed, 30 Sep 2026 14:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790777720; x=1822313720;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=r6J6OMUuexc90xruyZevzc+hksoDZaaD+TsUNdnaTAg=;
 b=CdmVcyGyVtAutZXuHI1uW+5AvZeZoPhkfLnUjtWgU4hVKDHC+5hUS5hF
 3ieR2nM6elFvB91zO3RG76o7Yb8CO0on6z9LHo8lGNbpPzIYbhYYsM1cj
 GVRUeh5AZOBb0feeB2ohNDEITnvlLd+hbPvTTOAB+Y9E+iRn6Ew3T0oKK
 PxiIIHZ+RhFR+aoMKDsTXufn/kizaAKKH1OcMwLZ5emb+WaecUi5Dx3Cp
 l1SmE+DoTziuGv/iju/GDFc2K2Ee+u58YDJR0A3DZOJkiz+2j/vF1/W1p
 aKKndg86E1VKlJ7uYcr+ZCm+5lvrd4ThifLGCX4bms0U3IyzU8Ip9Nr+z Q==;
X-CSE-ConnectionGUID: S2CC8zicSo+gJtMKWwaiaQ==
X-CSE-MsgGUID: qlx/F08uQBWYbeszK41TbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90470011"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="90470011"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 07:15:06 -0700
X-CSE-ConnectionGUID: fOVCP+umQgCtQQCqJjmfTA==
X-CSE-MsgGUID: TdFU7jRiTDiSb5/IIIHGYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="279499634"
Received: from sannilnx-dsk.jer.intel.com (HELO [127.0.1.1]) ([10.12.231.107])
 by orviesa005-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 07:15:02 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
Date: Wed, 30 Sep 2026 17:14:47 +0300
Subject: [PATCH v3 2/2] drm/xe/nvm: define survivabilty partition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-cri_surviv-v3-2-357aeed5fc60@intel.com>
References: <20260930-cri_surviv-v3-0-357aeed5fc60@intel.com>
In-Reply-To: <20260930-cri_surviv-v3-0-357aeed5fc60@intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Menachem Adin <menachem.adin@intel.com>, 
 Alexander Usyskin <alexander.usyskin@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790777694; l=2014;
 i=alexander.usyskin@intel.com; s=20260315; h=from:subject:message-id;
 bh=r6J6OMUuexc90xruyZevzc+hksoDZaaD+TsUNdnaTAg=;
 b=JvPy//bs0zDBw4pGxJbZY8ZpVFjuqHVy5C93fVA5jAW0TcsKYD53soRLZiE2I2Whnjms8mPR/
 uRjQj4eFtBEDKgxP8+WyvXmH3/7GS/0yzpArkMTk8wh9rdsIdxPSzOK
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

Define 8M survivability partition for CRI when
storage is open for write override.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/gpu/drm/xe/xe_nvm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_nvm.c b/drivers/gpu/drm/xe/xe_nvm.c
index 51a1a431ad85..783c3103a8a4 100644
--- a/drivers/gpu/drm/xe/xe_nvm.c
+++ b/drivers/gpu/drm/xe/xe_nvm.c
@@ -56,10 +56,11 @@ static bool xe_nvm_non_posted_erase(struct xe_device *xe)
 	}
 }
 
-static bool xe_nvm_writable_override(struct xe_device *xe)
+static bool xe_nvm_writable_override(struct xe_device *xe, size_t *survivability_size)
 {
 	struct xe_mmio *mmio = xe_root_tile_mmio(xe);
 	bool writable_override;
+	size_t s_size = 0;
 	struct xe_reg reg;
 	u32 test_bit, test_val;
 
@@ -68,6 +69,7 @@ static bool xe_nvm_writable_override(struct xe_device *xe)
 		reg = PCODE_SCRATCH(0);
 		test_bit = FDO_MODE;
 		test_val = FDO_MODE;
+		s_size = SZ_8M;
 		break;
 	case XE_BATTLEMAGE:
 		reg = HECI_FWSTS2(DG2_GSC_HECI2_BASE);
@@ -91,12 +93,17 @@ static bool xe_nvm_writable_override(struct xe_device *xe)
 		break;
 	default:
 		drm_err(&xe->drm, "Unknown platform\n");
+		*survivability_size = 0;
 		return true;
 	}
 
 	writable_override = (xe_mmio_read32(mmio, reg) & test_bit) == test_val;
-	if (writable_override)
+	if (writable_override) {
 		drm_info(&xe->drm, "NVM access overridden by jumper\n");
+		*survivability_size = s_size;
+	} else {
+		*survivability_size = 0;
+	}
 	return writable_override;
 }
 
@@ -143,7 +150,7 @@ int xe_nvm_init(struct xe_device *xe)
 	if (!nvm)
 		return -ENOMEM;
 
-	nvm->writable_override = xe_nvm_writable_override(xe);
+	nvm->writable_override = xe_nvm_writable_override(xe, &nvm->survivability_size);
 	nvm->non_posted_erase = xe_nvm_non_posted_erase(xe);
 	nvm->bar.parent = &pdev->resource[0];
 	nvm->bar.start = GEN12_GUNIT_NVM_BASE + pdev->resource[0].start;

-- 
2.53.0

