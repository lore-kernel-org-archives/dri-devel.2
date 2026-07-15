Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3D0C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:09:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C705110F0CF;
	Wed, 15 Jul 2026 14:09:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="K1Nl8Q0E";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C44A10F0CE;
 Wed, 15 Jul 2026 14:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784124544; x=1815660544;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=ATALO6HNchOr9CMZnlOgxknZVX2fMM4WKANowkCK63U=;
 b=K1Nl8Q0ENqM0zdy1bHwGILEXfoYMTZIB3T3rnwhRF5U4L5hgMfVnB9TP
 26ZQENgoRF2b9VxJsw9eUB36PlTeQTPr+0hwxil9/PLoa4JBsKv+GeNzV
 xlHqgSxY/P3iRtYmA78bW8PA01SdEfeLxoFs4kATsb9P6ChyM3sZeVVhC
 W60AoJyxqCiWulyc+PFnFWH/wOPqykRoOVYHdK83S6/HVQMpmv7mw9DCz
 uaCQCSe0cc0S9D+oiwTCqIemoxmp6Zca64wXG7CzXStPhIw5lz8E6M2zT
 dUz+cSEsj2UotBc3P0y1Jbb5D7n8Y+XVZq+F4MEsXaTb8xj4oPzx6Svu5 g==;
X-CSE-ConnectionGUID: NvymG6E5QP6o4KiDaYJZ2w==
X-CSE-MsgGUID: utC6WJXQQ0SnY0gISFTVag==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84615783"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="84615783"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 07:09:04 -0700
X-CSE-ConnectionGUID: D3ODEsDjRwGEhzgsVE+hxw==
X-CSE-MsgGUID: 4B664tSAR4CBpXPEpOOoig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="251777896"
Received: from sannilnx-dsk.jer.intel.com (HELO [127.0.1.1]) ([10.12.231.107])
 by fmviesa006-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 07:08:59 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
Date: Wed, 15 Jul 2026 16:45:29 +0300
Subject: [PATCH 1/2] mtd: mtd_intel_dg: add survivability partition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-cri_surviv-v1-1-61763a6f1076@intel.com>
References: <20260715-cri_surviv-v1-0-61763a6f1076@intel.com>
In-Reply-To: <20260715-cri_surviv-v1-0-61763a6f1076@intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Alexander Usyskin <alexander.usyskin@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784123168; l=5677;
 i=alexander.usyskin@intel.com; s=20260315; h=from:subject:message-id;
 bh=ATALO6HNchOr9CMZnlOgxknZVX2fMM4WKANowkCK63U=;
 b=99dOaOuPtNF4sVbMxAPYsGJ6YFuaMNGPDcK0J22YBe7oVG2lCNq/LiyE/OP3GdenmBtnP0cwW
 B8j6P0+QU9TDHr3geGHNQ8IRIFm5r0ZvWPdEIVwoZJ9Co6dcJ+rIptT
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

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/mtd/devices/mtd_intel_dg.c | 80 +++++++++++++++++++++++++++-----------
 include/linux/intel_dg_nvm_aux.h   |  1 +
 2 files changed, 59 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/devices/mtd_intel_dg.c b/drivers/mtd/devices/mtd_intel_dg.c
index f2fa8f68d190..d11ddc687c4a 100644
--- a/drivers/mtd/devices/mtd_intel_dg.c
+++ b/drivers/mtd/devices/mtd_intel_dg.c
@@ -31,6 +31,7 @@ struct intel_dg_nvm {
 	void __iomem *base;
 	void __iomem *base2;
 	bool non_posted_erase;
+	bool survivability_enabled;
 
 	size_t size;
 	unsigned int nregions;
@@ -205,6 +206,13 @@ static unsigned int idg_nvm_get_region(const struct intel_dg_nvm *nvm, loff_t fr
 {
 	unsigned int i;
 
+	/*
+	 * When survivability region is enabled it positioned on index 0 and has region_id = 0
+	 * Region 0 is special, via this region whole device memory can be accessed.
+	 */
+	if (nvm->survivability_enabled)
+		return 0;
+
 	for (i = 0; i < nvm->nregions; i++) {
 		if ((nvm->regions[i].offset + nvm->regions[i].size - 1) >= from &&
 		    nvm->regions[i].offset <= from &&
@@ -443,32 +451,39 @@ static int intel_dg_nvm_init(struct intel_dg_nvm *nvm, struct device *device,
 		u32 address, base, limit, region;
 		u8 id = nvm->regions[i].id;
 
-		address = NVM_FLREG(id);
-		region = idg_nvm_read32(nvm, address);
+		if (nvm->regions[i].size) { /* pre-defined survivability region */
+			limit = nvm->regions[i].offset + nvm->regions[i].size - 1;
 
-		base = FIELD_GET(NVM_FREG_BASE_MASK, region) << NVM_FREG_ADDR_SHIFT;
-		limit = (FIELD_GET(NVM_FREG_ADDR_MASK, region) << NVM_FREG_ADDR_SHIFT) |
-			NVM_FREG_MIN_REGION_SIZE;
+			if (nvm->size < limit)
+				nvm->size = limit;
+		} else {
+			address = NVM_FLREG(id);
+			region = idg_nvm_read32(nvm, address);
 
-		dev_dbg(device, "[%d] %s: region: 0x%08X base: 0x%08x limit: 0x%08x\n",
-			id, nvm->regions[i].name, region, base, limit);
+			base = FIELD_GET(NVM_FREG_BASE_MASK, region) << NVM_FREG_ADDR_SHIFT;
+			limit = (FIELD_GET(NVM_FREG_ADDR_MASK, region) << NVM_FREG_ADDR_SHIFT) |
+				NVM_FREG_MIN_REGION_SIZE;
 
-		if (base >= limit || (i > 0 && limit == 0)) {
-			dev_dbg(device, "[%d] %s: disabled\n",
-				id, nvm->regions[i].name);
-			nvm->regions[i].is_readable = 0;
-			continue;
-		}
+			dev_dbg(device, "[%d] %s: region: 0x%08X base: 0x%08x limit: 0x%08x\n",
+				id, nvm->regions[i].name, region, base, limit);
 
-		if (nvm->size < limit)
-			nvm->size = limit;
+			if (base >= limit || (i > 0 && limit == 0)) {
+				dev_dbg(device, "[%d] %s: disabled\n",
+					id, nvm->regions[i].name);
+				nvm->regions[i].is_readable = 0;
+				continue;
+			}
 
-		nvm->regions[i].offset = base;
-		nvm->regions[i].size = limit - base + 1;
-		/* No write access to descriptor; mask it out*/
-		nvm->regions[i].is_writable = idg_nvm_region_writable(access_map, id);
+			if (nvm->size < limit)
+				nvm->size = limit;
 
-		nvm->regions[i].is_readable = idg_nvm_region_readable(access_map, id);
+			nvm->regions[i].offset = base;
+			nvm->regions[i].size = limit - base + 1;
+			/* No write access to descriptor; mask it out*/
+			nvm->regions[i].is_writable = idg_nvm_region_writable(access_map, id);
+
+			nvm->regions[i].is_readable = idg_nvm_region_readable(access_map, id);
+		}
 		dev_dbg(device, "Registered, %s id=%d offset=%lld size=%lld rd=%d wr=%d\n",
 			nvm->regions[i].name,
 			nvm->regions[i].id,
@@ -748,7 +763,7 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
 	struct intel_dg_nvm *nvm;
 	struct device *device;
 	unsigned int nregions;
-	unsigned int i, n;
+	unsigned int i, n = 0;
 	int ret;
 
 	device = &aux_dev->dev;
@@ -764,6 +779,9 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
 		return -ENODEV;
 	}
 
+	if (invm->survivability_size)
+		nregions++;
+
 	nvm = kzalloc_flex(*nvm, regions, nregions);
 	if (!nvm)
 		return -ENOMEM;
@@ -771,8 +789,26 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
 	kref_init(&nvm->refcnt);
 	mutex_init(&nvm->lock);
 	nvm->nregions = nregions;
+	nvm->survivability_enabled = !!invm->survivability_size;
+
+	if (invm->survivability_size) { /* this partition should be at idx 0 */
+		char *name = kasprintf(GFP_KERNEL, "%s.%s",
+				       dev_name(&aux_dev->dev), "DATA");
+		if (!name) {
+			ret = -ENOMEM;
+			goto err_norpm;
+		}
+
+		nvm->regions[n].name = name;
+		nvm->regions[n].id = 0;
+		nvm->regions[n].offset  = 0;
+		nvm->regions[n].size = invm->survivability_size;
+		nvm->regions[n].is_readable = true;
+		nvm->regions[n].is_writable = true;
+		n++;
+	}
 
-	for (n = 0, i = 0; i < INTEL_DG_NVM_REGIONS; i++) {
+	for (i = 0; i < INTEL_DG_NVM_REGIONS; i++) {
 		if (!invm->regions[i].name)
 			continue;
 
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

