Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3497CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C0210F414;
	Wed, 30 Sep 2026 14:15:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IXLyUOWq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C989010E14E;
 Wed, 30 Sep 2026 14:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790777719; x=1822313719;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=+Y+W1NtAVnX4cXff5RXSRzwok/ylodMDatebHTE6VAM=;
 b=IXLyUOWqdvbl+wOrP6EA+QBpR+cOhwTN6b23ZUulDinMpUmkxUtJb8f7
 qDRjaThe6fcAabP4TGiJ1XxXDpmETdBYw6G905kv8NCBqbcAbfkjzN2qD
 dPewk97zvgyyQTkbk9WzzLpj5Osqb4dAeuBiLeu9yQ7a3mO904Zc06s0f
 h8InQY+GurqUoL4PBsp69UdoBuZssy7EJrrSAG5GYRSkqZhOVvRM6sLeP
 C68NbtlF9ADx1li8mey70V+6ZbVNWKFg9GqfkkdaqdoKSuTjN7jjFLpij
 CyCVApptqTQPd5MzQ7/ucQ0SXHUYgSexcvKX8UAaZLCbStGrN2hQ0awX7 g==;
X-CSE-ConnectionGUID: UnOyI6ooS/KdFl4PTqUnvw==
X-CSE-MsgGUID: nkfpToCrRcSxGXEHRUQoXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90470000"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="90470000"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 07:15:02 -0700
X-CSE-ConnectionGUID: zAYicykvTDOhJOiV1qnzkw==
X-CSE-MsgGUID: 9bu09rbVR+uzybqT6FC05w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="279499583"
Received: from sannilnx-dsk.jer.intel.com (HELO [127.0.1.1]) ([10.12.231.107])
 by orviesa005-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 07:14:59 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
Date: Wed, 30 Sep 2026 17:14:46 +0300
Subject: [PATCH v3 1/2] mtd: mtd_intel_dg: add survivability partition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-cri_surviv-v3-1-357aeed5fc60@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790777694; l=4348;
 i=alexander.usyskin@intel.com; s=20260315; h=from:subject:message-id;
 bh=+Y+W1NtAVnX4cXff5RXSRzwok/ylodMDatebHTE6VAM=;
 b=tYKbzy7Y6Glx6HLyf6ObdWEdMyUCTTZw3pMGpVmSL03oDAEJpNLBmA193phfO0t81nBB04GCp
 nXYcxT5Bpd0DXpUIldtHdI+SW9vLUQFxLyyueb2xpXHEv5uTxIPPheR
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

Add option to expose additional fixed-sized partition starting
from the beginning of storage.
Xe driver can request this partition exposure if firmware or hardware
have detected failure that may involve corrupted partition table.
Fixed-sized partition allows full storage re-write in this situation.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/mtd/devices/mtd_intel_dg.c | 65 ++++++++++++++++++++++++++++----------
 include/linux/intel_dg_nvm_aux.h   |  1 +
 2 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/devices/mtd_intel_dg.c b/drivers/mtd/devices/mtd_intel_dg.c
index a566e86eb5e3..976246e94e79 100644
--- a/drivers/mtd/devices/mtd_intel_dg.c
+++ b/drivers/mtd/devices/mtd_intel_dg.c
@@ -31,6 +31,7 @@ struct intel_dg_nvm {
 	void __iomem *base;
 	void __iomem *base2;
 	bool non_posted_erase;
+	bool survivability_enabled;
 
 	size_t size;
 	unsigned int nregions;
@@ -430,6 +431,15 @@ static int intel_dg_nvm_init(struct intel_dg_nvm *nvm, struct device *device,
 	/* clean error register, previous errors are ignored */
 	idg_nvm_error(nvm);
 
+	if (nvm->survivability_enabled) {
+		nvm->size = nvm->regions[0].offset + nvm->regions[0].size - 1;
+		dev_dbg(device, "Registered survivability region %s size=%lld\n",
+			nvm->regions[0].name,
+			nvm->regions[0].size);
+		n = 1;
+		goto out;
+	}
+
 	ret = idg_nvm_is_valid(nvm);
 	if (ret) {
 		dev_err(device, "The MEM is not valid %d\n", ret);
@@ -481,6 +491,7 @@ static int intel_dg_nvm_init(struct intel_dg_nvm *nvm, struct device *device,
 			n++;
 	}
 
+out:
 	nvm->non_posted_erase = non_posted_erase;
 
 	dev_dbg(device, "Registered %d regions\n", n);
@@ -753,15 +764,19 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
 
 	device = &aux_dev->dev;
 
-	/* count available regions */
-	for (nregions = 0, i = 0; i < INTEL_DG_NVM_REGIONS; i++) {
-		if (invm->regions[i].name)
-			nregions++;
-	}
+	if (invm->survivability_size) {
+		nregions = 1;
+	} else {
+		/* count available regions */
+		for (nregions = 0, i = 0; i < INTEL_DG_NVM_REGIONS; i++) {
+			if (invm->regions[i].name)
+				nregions++;
+		}
 
-	if (!nregions) {
-		dev_err(device, "no regions defined\n");
-		return -ENODEV;
+		if (!nregions) {
+			dev_err(device, "no regions defined\n");
+			return -ENODEV;
+		}
 	}
 
 	nvm = kzalloc_flex(*nvm, regions, nregions);
@@ -771,21 +786,39 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
 	kref_init(&nvm->refcnt);
 	mutex_init(&nvm->lock);
 	nvm->nregions = nregions;
+	nvm->survivability_enabled = !!invm->survivability_size;
 
-	for (n = 0, i = 0; i < INTEL_DG_NVM_REGIONS; i++) {
-		if (!invm->regions[i].name)
-			continue;
-
+	if (invm->survivability_size) { /* survivability partition */
 		char *name = kasprintf(GFP_KERNEL, "%s.%s",
-				       dev_name(&aux_dev->dev), invm->regions[i].name);
+				       dev_name(&aux_dev->dev), "DATA");
 		if (!name) {
 			ret = -ENOMEM;
 			goto err_norpm;
 		}
 
-		nvm->regions[n].name = name;
-		nvm->regions[n].id = i;
-		n++;
+		nvm->regions[0].name = name;
+		nvm->regions[0].id = 0;
+		nvm->regions[0].offset  = 0;
+		nvm->regions[0].size = invm->survivability_size;
+		nvm->regions[0].is_readable = true;
+		nvm->regions[0].is_writable = true;
+		n = 1;
+	} else {
+		for (n = 0, i = 0; i < INTEL_DG_NVM_REGIONS; i++) {
+			if (!invm->regions[i].name)
+				continue;
+
+			char *name = kasprintf(GFP_KERNEL, "%s.%s",
+					       dev_name(&aux_dev->dev), invm->regions[i].name);
+			if (!name) {
+				ret = -ENOMEM;
+				goto err_norpm;
+			}
+
+			nvm->regions[n].name = name;
+			nvm->regions[n].id = i;
+			n++;
+		}
 	}
 
 	ret = devm_pm_runtime_enable(device);
diff --git a/include/linux/intel_dg_nvm_aux.h b/include/linux/intel_dg_nvm_aux.h
index 625d46a6b96e..84b5b6e0c4ea 100644
--- a/include/linux/intel_dg_nvm_aux.h
+++ b/include/linux/intel_dg_nvm_aux.h
@@ -21,6 +21,7 @@ struct intel_dg_nvm_dev {
 	struct auxiliary_device aux_dev;
 	bool writable_override;
 	bool non_posted_erase;
+	size_t survivability_size;
 	struct resource bar;
 	struct resource bar2;
 	const struct intel_dg_nvm_region *regions;

-- 
2.53.0

