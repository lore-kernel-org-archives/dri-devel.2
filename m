Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F91106FD6A
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 01:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7BA610EAF5;
	Fri, 13 Mar 2026 01:52:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WUuPMba6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FD6F10E042;
 Fri, 13 Mar 2026 01:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773366739; x=1804902739;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wbjNJLd8atOYnQ6zYbAQNjHcXD+p8VTla29he68mD/I=;
 b=WUuPMba68C7wtMnFGt9MUIXTBHVSE3mvVYldh1HGt+gK3H66oVv6V/FF
 dBtvVTDga20EO4QWdkkgRRC+5m4vePqZNRcVofAofPlth5oK3WE5wl9RX
 QzppQYgloczoVMwIVUM79dw5dnwOieieZcgloVOBnullkd4S+mlgF4kMi
 reD1ixsHFT+/SX1vyUUC3K8QGERFy//DpRPrCNQWPMM2aa0UCYZ+0/1IT
 gxGED7XZBhnbEKxzNiEcM29wqrTJQejcWbOKZHGhH3Y6Y0Y9qNBIMzuSN
 XnuGNqdEpCLWD7VDEHibn8PxCf0A5tjwG/fymtnKSByoUOLNS/pzoFjxm g==;
X-CSE-ConnectionGUID: zGRyuyKnRWOkLAxHzDjpaQ==
X-CSE-MsgGUID: KCNR1ROZRQO62ntK0BfeZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74354578"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="74354578"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 18:52:12 -0700
X-CSE-ConnectionGUID: f8z5cZEsSmmRmu7hbGUhLA==
X-CSE-MsgGUID: 2bx2yGadTfm3aOlekBjFhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="220108497"
Received: from debox1-desk4.jf.intel.com ([10.88.27.138])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 18:52:12 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 irenic.rajneesh@gmail.com, ilpo.jarvinen@linux.intel.com,
 srinivas.pandruvada@linux.intel.com, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, xi.pardee@linux.intel.com
Cc: david.e.box@linux.intel.com, hansg@kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 10/22] platform/x86/intel/pmt: Move header decode into common
 helper
Date: Thu, 12 Mar 2026 18:51:49 -0700
Message-ID: <20260313015202.3660072-11-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313015202.3660072-1-david.e.box@linux.intel.com>
References: <20260313015202.3660072-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Unify PMT discovery table parsing by moving header decode logic into the
class driver. A new helper, pmt_read_header(), now fills in the standard
header fields from the discovery table, replacing the per-namespace
pmt_header_decode callbacks in telemetry and crashlog.

This centralizes the discovery table bit-field definitions in class.h,
removes duplicate decode code from telemetry and crashlog, and prepares the
PMT class for additional discovery sources.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmt/class.c     | 38 +++++++++++++++-------
 drivers/platform/x86/intel/pmt/class.h     | 15 +++++++--
 drivers/platform/x86/intel/pmt/crashlog.c  | 17 ----------
 drivers/platform/x86/intel/pmt/telemetry.c | 26 ---------------
 4 files changed, 40 insertions(+), 56 deletions(-)

diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/=
intel/pmt/class.c
index 9b315334a69b..a4d6ffed2fed 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -8,6 +8,7 @@
  * Author: "Alexander Duyck" <alexander.h.duyck@linux.intel.com>
  */
=20
+#include <linux/bitfield.h>
 #include <linux/kernel.h>
 #include <linux/log2.h>
 #include <linux/intel_vsec.h>
@@ -368,26 +369,41 @@ static int intel_pmt_dev_register(struct intel_pmt_en=
try *entry,
 	return ret;
 }
=20
-int intel_pmt_dev_create(struct intel_pmt_entry *entry, struct intel_pmt_n=
amespace *ns,
-			 struct intel_vsec_device *intel_vsec_dev, int idx)
+static int pmt_read_header(struct intel_vsec_device *ivdev, int idx,
+			   struct intel_pmt_entry *entry)
 {
-	struct device *dev =3D &intel_vsec_dev->auxdev.dev;
-	struct resource	*disc_res;
-	int ret;
+	struct intel_pmt_header *header =3D &entry->header;
+	struct device *dev =3D &ivdev->auxdev.dev;
+	u64 headers[2];
=20
-	disc_res =3D &intel_vsec_dev->resource[idx];
-
-	entry->disc_table =3D devm_ioremap_resource(dev, disc_res);
+	entry->disc_table =3D devm_ioremap_resource(dev, &ivdev->resource[idx]);
 	if (IS_ERR(entry->disc_table))
 		return PTR_ERR(entry->disc_table);
=20
+	memcpy_fromio(headers, entry->disc_table, 2 * sizeof(u64));
+
+	header->access_type =3D FIELD_GET(PMT_ACCESS_TYPE, headers[0]);
+	header->telem_type =3D FIELD_GET(PMT_TELEM_TYPE, headers[0]);
+	/* Size is measured in DWORDS, but accessor returns bytes */
+	header->size =3D PMT_GET_SIZE(FIELD_GET(PMT_SIZE, headers[0]));
+	header->guid =3D FIELD_GET(PMT_GUID32, headers[0]);
+	header->base_offset =3D FIELD_GET(PMT_BASE_OFFSET, headers[1]);
+
+	return 0;
+}
+
+int intel_pmt_dev_create(struct intel_pmt_entry *entry, struct intel_pmt_n=
amespace *ns,
+			 struct intel_vsec_device *intel_vsec_dev, int idx)
+{
+	int ret;
+
 	if (ns->pmt_pre_decode) {
 		ret =3D ns->pmt_pre_decode(intel_vsec_dev, entry);
 		if (ret)
 			return ret;
 	}
=20
-	ret =3D ns->pmt_header_decode(entry, dev);
+	ret =3D pmt_read_header(intel_vsec_dev, idx, entry);
 	if (ret)
 		return ret;
=20
@@ -397,11 +413,11 @@ int intel_pmt_dev_create(struct intel_pmt_entry *entr=
y, struct intel_pmt_namespa
 			return ret;
 	}
=20
-	ret =3D intel_pmt_populate_entry(entry, intel_vsec_dev, disc_res);
+	ret =3D intel_pmt_populate_entry(entry, intel_vsec_dev, &intel_vsec_dev->=
resource[idx]);
 	if (ret)
 		return ret;
=20
-	return intel_pmt_dev_register(entry, ns, dev);
+	return intel_pmt_dev_register(entry, ns, &intel_vsec_dev->auxdev.dev);
 }
 EXPORT_SYMBOL_NS_GPL(intel_pmt_dev_create, "INTEL_PMT");
=20
diff --git a/drivers/platform/x86/intel/pmt/class.h b/drivers/platform/x86/=
intel/pmt/class.h
index 8a0db0ef58c1..06f90c7ce6b3 100644
--- a/drivers/platform/x86/intel/pmt/class.h
+++ b/drivers/platform/x86/intel/pmt/class.h
@@ -11,6 +11,19 @@
=20
 #include "telemetry.h"
=20
+/* PMT Discovery Table DWORD 1 */
+#define PMT_ACCESS_TYPE		GENMASK_ULL(3, 0)
+#define PMT_TELEM_TYPE		GENMASK_ULL(7, 4)
+#define PMT_SIZE		GENMASK_ULL(27, 12)
+#define PMT_GUID32		GENMASK_ULL(63, 32)
+
+/* PMT Discovery Table DWORD 2 */
+#define PMT_BASE_OFFSET		GENMASK_ULL(31, 0)
+#define PMT_TELE_ID		GENMASK_ULL(63, 32)
+
+/* Get size bytes from DWORDs */
+#define PMT_GET_SIZE(v)		((v) << 2)
+
 /* PMT access types */
 #define ACCESS_BARID		2
 #define ACCESS_LOCAL		3
@@ -61,8 +74,6 @@ struct intel_pmt_entry {
 struct intel_pmt_namespace {
 	const char *name;
 	struct xarray *xa;
-	int (*pmt_header_decode)(struct intel_pmt_entry *entry,
-				 struct device *dev);
 	int (*pmt_pre_decode)(struct intel_vsec_device *ivdev,
 			      struct intel_pmt_entry *entry);
 	int (*pmt_post_decode)(struct intel_vsec_device *ivdev,
diff --git a/drivers/platform/x86/intel/pmt/crashlog.c b/drivers/platform/x=
86/intel/pmt/crashlog.c
index f936daf99e4d..67795e2cb1ed 100644
--- a/drivers/platform/x86/intel/pmt/crashlog.c
+++ b/drivers/platform/x86/intel/pmt/crashlog.c
@@ -516,28 +516,11 @@ static int pmt_crashlog_pre_decode(struct intel_vsec_=
device *ivdev,
 	return 0;
 }
=20
-static int pmt_crashlog_header_decode(struct intel_pmt_entry *entry,
-				      struct device *dev)
-{
-	void __iomem *disc_table =3D entry->disc_table;
-	struct intel_pmt_header *header =3D &entry->header;
-
-	header->access_type =3D GET_ACCESS(readl(disc_table));
-	header->guid =3D readl(disc_table + GUID_OFFSET);
-	header->base_offset =3D readl(disc_table + BASE_OFFSET);
-
-	/* Size is measured in DWORDS, but accessor returns bytes */
-	header->size =3D GET_SIZE(readl(disc_table + SIZE_OFFSET));
-
-	return 0;
-}
-
 static DEFINE_XARRAY_ALLOC(crashlog_array);
 static struct intel_pmt_namespace pmt_crashlog_ns =3D {
 	.name =3D "crashlog",
 	.xa =3D &crashlog_array,
 	.pmt_pre_decode =3D pmt_crashlog_pre_decode,
-	.pmt_header_decode =3D pmt_crashlog_header_decode,
 };
=20
 /*
diff --git a/drivers/platform/x86/intel/pmt/telemetry.c b/drivers/platform/=
x86/intel/pmt/telemetry.c
index d22f633638be..80773e3c3efa 100644
--- a/drivers/platform/x86/intel/pmt/telemetry.c
+++ b/drivers/platform/x86/intel/pmt/telemetry.c
@@ -27,14 +27,6 @@
=20
 #include "class.h"
=20
-#define TELEM_SIZE_OFFSET	0x0
-#define TELEM_GUID_OFFSET	0x4
-#define TELEM_BASE_OFFSET	0x8
-#define TELEM_ACCESS(v)		((v) & GENMASK(3, 0))
-#define TELEM_TYPE(v)		(((v) & GENMASK(7, 4)) >> 4)
-/* size is in bytes */
-#define TELEM_SIZE(v)		(((v) & GENMASK(27, 12)) >> 10)
-
 /* Used by client hardware to identify a fixed telemetry entry*/
 #define TELEM_CLIENT_FIXED_BLOCK_GUID	0x10000000
=20
@@ -69,23 +61,6 @@ static bool pmt_telem_region_overlaps(struct device *dev=
, u32 guid, u32 type)
 	return false;
 }
=20
-static int pmt_telem_header_decode(struct intel_pmt_entry *entry,
-				   struct device *dev)
-{
-	void __iomem *disc_table =3D entry->disc_table;
-	struct intel_pmt_header *header =3D &entry->header;
-
-	header->access_type =3D TELEM_ACCESS(readl(disc_table));
-	header->guid =3D readl(disc_table + TELEM_GUID_OFFSET);
-	header->base_offset =3D readl(disc_table + TELEM_BASE_OFFSET);
-
-	/* Size is measured in DWORDS, but accessor returns bytes */
-	header->size =3D TELEM_SIZE(readl(disc_table));
-	header->telem_type =3D TELEM_TYPE(readl(entry->disc_table));
-
-	return 0;
-}
-
 static int pmt_telem_post_decode(struct intel_vsec_device *ivdev,
 				 struct intel_pmt_entry *entry)
 {
@@ -135,7 +110,6 @@ static DEFINE_XARRAY_ALLOC(telem_array);
 static struct intel_pmt_namespace pmt_telem_ns =3D {
 	.name =3D "telem",
 	.xa =3D &telem_array,
-	.pmt_header_decode =3D pmt_telem_header_decode,
 	.pmt_post_decode =3D pmt_telem_post_decode,
 	.pmt_add_endpoint =3D pmt_telem_add_endpoint,
 };
--=20
2.43.0

