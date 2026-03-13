Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42447106FD6F
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 01:52:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F02F10EAE8;
	Fri, 13 Mar 2026 01:52:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NbrOgtPF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6D6F10E042;
 Fri, 13 Mar 2026 01:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773366739; x=1804902739;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cXXek5wUIos0vxn+OWuVgbE2WFWXLMr+474FLK0b+lY=;
 b=NbrOgtPFBTQS6h5oY9wlspPgrm7qU31gdNhzKjA3vakOrcQJ93AOr4SX
 zGfiVq+CI2yGPhfdzqmYWfdYd2cNGuQVnRP61Ovi/cLo0+NF3WxI937Td
 EP0V4A6gRkQPN52l4QvAcQziBmGE+G9f9KJ5gma+KoYc9K9YO7SBEYVXr
 Pekatakt8RixCg3J/JHKbwRy1tHAtHEWvc5kzR6xBoHP7QEF4yv5QjoB6
 YESauOh7jKK4id6dxbtE5Oqjq2ugdmP4BCx2CZlFLbcQaC65Kb+ch1YaB
 8OHqj7zjEPTQngvkbM5U8/waEV4SZqNLLEIv6OMQ+Crh5mb8Qq/KFPrWy A==;
X-CSE-ConnectionGUID: OvEl9Ki+QXufdszPGdkfaQ==
X-CSE-MsgGUID: zf1oTTbKQpGQ934CHNUn9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74354596"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="74354596"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 18:52:12 -0700
X-CSE-ConnectionGUID: Q8I7qYMDQJKJCXUbekXMHA==
X-CSE-MsgGUID: 2yPxCl5dRq6r5SbBum0MAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="220108509"
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
Subject: [PATCH 14/22] platform/x86/intel/pmc: Add ACPI PWRM telemetry driver
 for Nova Lake S
Date: Thu, 12 Mar 2026 18:51:53 -0700
Message-ID: <20260313015202.3660072-15-david.e.box@linux.intel.com>
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

Add an ACPI-based PMC PWRM telemetry driver for Nova Lake S. The driver
locates PMT discovery data in _DSD under the Intel VSEC UUID, parses it,
and registers telemetry regions with the PMT/VSEC framework so PMC
telemetry is exposed via existing PMT interfaces.

Export pmc_parse_telem_dsd() and pmc_find_telem_guid() to support ACPI
discovery in other PMC drivers (e.g., ssram_telemetry) without duplicating
ACPI parsing logic. Also export acpi_disc_t typedef from core.h for callers
to properly declare discovery table arrays.

Selected by INTEL_PMC_CORE. Existing PCI functionality is preserved.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/Kconfig        |  14 ++
 drivers/platform/x86/intel/pmc/Makefile       |   2 +
 drivers/platform/x86/intel/pmc/core.h         |  12 +
 .../platform/x86/intel/pmc/pwrm_telemetry.c   | 227 ++++++++++++++++++
 4 files changed, 255 insertions(+)
 create mode 100644 drivers/platform/x86/intel/pmc/pwrm_telemetry.c

diff --git a/drivers/platform/x86/intel/pmc/Kconfig b/drivers/platform/x86/=
intel/pmc/Kconfig
index 0f19dc7edcf9..937186b0b5dd 100644
--- a/drivers/platform/x86/intel/pmc/Kconfig
+++ b/drivers/platform/x86/intel/pmc/Kconfig
@@ -9,6 +9,7 @@ config INTEL_PMC_CORE
 	depends on ACPI
 	depends on INTEL_PMT_TELEMETRY
 	select INTEL_PMC_SSRAM_TELEMETRY
+	select INTEL_PMC_PWRM_TELEMETRY
 	help
 	  The Intel Platform Controller Hub for Intel Core SoCs provides access
 	  to Power Management Controller registers via various interfaces. This
@@ -39,3 +40,16 @@ config INTEL_PMC_SSRAM_TELEMETRY
 	  (including sysfs).
=20
 	  This option is selected by INTEL_PMC_CORE.
+
+config INTEL_PMC_PWRM_TELEMETRY
+	tristate
+	help
+	  This driver discovers PMC PWRM telemetry regions described in ACPI
+	  _DSD and registers them with the Intel VSEC framework as Intel PMT
+	  telemetry devices.
+
+	  It validates the ACPI discovery data and publishes the discovered
+	  regions so they can be accessed through the Intel PMT telemetry
+	  interfaces (including sysfs).
+
+	  This option is selected by INTEL_PMC_CORE.
diff --git a/drivers/platform/x86/intel/pmc/Makefile b/drivers/platform/x86=
/intel/pmc/Makefile
index bb960c8721d7..fdbb768f7b09 100644
--- a/drivers/platform/x86/intel/pmc/Makefile
+++ b/drivers/platform/x86/intel/pmc/Makefile
@@ -12,3 +12,5 @@ obj-$(CONFIG_INTEL_PMC_CORE)		+=3D intel_pmc_core_pltdrv.o
 # Intel PMC SSRAM driver
 intel_pmc_ssram_telemetry-y		+=3D ssram_telemetry.o
 obj-$(CONFIG_INTEL_PMC_SSRAM_TELEMETRY)	+=3D intel_pmc_ssram_telemetry.o
+intel_pmc_pwrm_telemetry-y		+=3D pwrm_telemetry.o
+obj-$(CONFIG_INTEL_PMC_PWRM_TELEMETRY)	+=3D intel_pmc_pwrm_telemetry.o
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/i=
ntel/pmc/core.h
index 118c8740ad3a..284aced99f72 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -562,6 +562,8 @@ int pmc_core_pmt_get_blk_sub_req(struct pmc_dev *pmcdev=
, struct pmc *pmc,
 extern const struct file_operations pmc_core_substate_req_regs_fops;
 extern const struct file_operations pmc_core_substate_blk_req_fops;
=20
+extern const guid_t intel_vsec_guid;
+
 #define pmc_for_each_mode(mode, pmc)						\
 	for (unsigned int __i =3D 0, __cond;					\
 	     __cond =3D __i < (pmc)->num_lpm_modes,				\
@@ -583,4 +585,14 @@ static const struct file_operations __name ## _fops =
=3D {			\
 	.release	=3D single_release,				\
 }
=20
+struct intel_vsec_header;
+union acpi_object;
+
+/* Avoid checkpatch warning */
+typedef u32 (*acpi_disc_t)[4];
+
+int pmc_parse_telem_dsd(union acpi_object *obj,
+			struct intel_vsec_header *header,
+			acpi_disc_t *acpi_disc);
+union acpi_object *pmc_find_telem_guid(union acpi_object *dsd);
 #endif /* PMC_CORE_H */
diff --git a/drivers/platform/x86/intel/pmc/pwrm_telemetry.c b/drivers/plat=
form/x86/intel/pmc/pwrm_telemetry.c
new file mode 100644
index 000000000000..25ca6979c214
--- /dev/null
+++ b/drivers/platform/x86/intel/pmc/pwrm_telemetry.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel PMC PWRM ACPI driver
+ *
+ * Copyright (C) 2025, Intel Corporation
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/intel_vsec.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/uuid.h>
+
+#include "core.h"
+
+#define ENTRY_LEN		5
+
+/* DWORD2 */
+#define DVSEC_ID_MASK		GENMASK(15, 0)
+#define NUM_ENTRIES_MASK	GENMASK(23, 16)
+#define ENTRY_SIZE_MASK		GENMASK(31, 24)
+
+/* DWORD3 */
+#define TBIR_MASK		GENMASK(2, 0)
+#define DISC_TBL_OFF_MASK	GENMASK(31, 3)
+
+const guid_t intel_vsec_guid =3D
+	GUID_INIT(0x294903fb, 0x634d, 0x4fc7, 0xaf, 0x1f, 0x0f, 0xb9,
+		  0x56, 0xb0, 0x4f, 0xc1);
+
+static bool is_valid_entry(union acpi_object *pkg)
+{
+	int i;
+
+	if (!pkg || pkg->type !=3D ACPI_TYPE_PACKAGE || pkg->package.count !=3D E=
NTRY_LEN)
+		return false;
+
+	if (pkg->package.elements[0].type !=3D ACPI_TYPE_STRING)
+		return false;
+
+	for (i =3D 1; i < ENTRY_LEN; i++)
+		if (pkg->package.elements[i].type !=3D ACPI_TYPE_INTEGER)
+			return false;
+
+	return true;
+}
+
+int pmc_parse_telem_dsd(union acpi_object *obj,
+			struct intel_vsec_header *header,
+			u32 (**acpi_disc)[4])
+{
+	union acpi_object *vsec_pkg;
+	union acpi_object *disc_pkg;
+	u64 hdr0;
+	u64 hdr1;
+	int num_regions;
+	int i;
+
+	if (!header)
+		return -EINVAL;
+
+	if (!obj || obj->type !=3D ACPI_TYPE_PACKAGE || obj->package.count !=3D 2)
+		return -EINVAL;
+
+	/* First Package is DVSEC info */
+	vsec_pkg =3D &obj->package.elements[0];
+	if (!is_valid_entry(vsec_pkg))
+		return -EINVAL;
+
+	hdr0 =3D vsec_pkg->package.elements[3].integer.value;
+	hdr1 =3D vsec_pkg->package.elements[4].integer.value;
+
+	header->id          =3D FIELD_GET(DVSEC_ID_MASK, hdr0);
+	header->num_entries =3D FIELD_GET(NUM_ENTRIES_MASK, hdr0);
+	header->entry_size  =3D FIELD_GET(ENTRY_SIZE_MASK, hdr0);
+	header->tbir        =3D FIELD_GET(TBIR_MASK, hdr1);
+	header->offset      =3D FIELD_GET(DISC_TBL_OFF_MASK, hdr1);
+
+	/* Second Package contains the discovery tables */
+	disc_pkg =3D &obj->package.elements[1];
+	if (disc_pkg->type !=3D ACPI_TYPE_PACKAGE || disc_pkg->package.count < 1)
+		return -EINVAL;
+
+	num_regions =3D disc_pkg->package.count;
+	if (header->num_entries !=3D num_regions)
+		return -EINVAL;
+
+	*acpi_disc =3D kmalloc_array(num_regions, sizeof(**acpi_disc), GFP_KERNEL=
);
+	if (!*acpi_disc)
+		return -ENOMEM;
+
+	for (i =3D 0; i < num_regions; i++) {
+		union acpi_object *pkg;
+		u64 value;
+		int j;
+
+		pkg =3D &disc_pkg->package.elements[i];
+		if (!is_valid_entry(pkg)) {
+			kfree(*acpi_disc);
+			return -EINVAL;
+		}
+
+		/* Element 0 is a descriptive string; DWORD values start at index 1. */
+		for (j =3D 1; j < ENTRY_LEN; j++) {
+			value =3D pkg->package.elements[j].integer.value;
+			if (value > U32_MAX) {
+				kfree(*acpi_disc);
+				return -ERANGE;
+			}
+
+			(*acpi_disc)[i][j - 1] =3D value;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(pmc_parse_telem_dsd, "INTEL_PMC_CORE");
+
+union acpi_object *pmc_find_telem_guid(union acpi_object *dsd)
+{
+	int i;
+
+	if (!dsd || dsd->type !=3D ACPI_TYPE_PACKAGE)
+		return NULL;
+
+	for (i =3D 0; i + 1 < dsd->package.count; i +=3D 2) {
+		union acpi_object *uuid_obj, *data_obj;
+		guid_t uuid;
+
+		uuid_obj =3D &dsd->package.elements[i];
+		data_obj =3D &dsd->package.elements[i + 1];
+
+		if (uuid_obj->type !=3D ACPI_TYPE_BUFFER ||
+		    uuid_obj->buffer.length !=3D 16)
+			continue;
+
+		memcpy(&uuid, uuid_obj->buffer.pointer, 16);
+		if (guid_equal(&uuid, &intel_vsec_guid))
+			return data_obj;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_NS_GPL(pmc_find_telem_guid, "INTEL_PMC_CORE");
+
+static int pmc_pwrm_acpi_probe(struct platform_device *pdev)
+{
+	struct acpi_buffer buf =3D { ACPI_ALLOCATE_BUFFER, NULL };
+	acpi_handle handle =3D ACPI_HANDLE(&pdev->dev);
+	struct intel_vsec_header header;
+	struct intel_vsec_header *headers[2] =3D { &header, NULL };
+	struct intel_vsec_platform_info info =3D { };
+	struct device *dev =3D &pdev->dev;
+	struct resource *res;
+	u32 (*acpi_disc)[4];
+	union acpi_object *dsd;
+	acpi_status status;
+	int ret;
+
+	if (!handle)
+		return -ENODEV;
+
+	status =3D acpi_evaluate_object(handle, "_DSD", NULL, &buf);
+	if (ACPI_FAILURE(status))
+		return dev_err_probe(dev, -ENODEV, "Could not evaluate _DSD: %s\n",
+				     acpi_format_exception(status));
+
+	dsd =3D pmc_find_telem_guid(buf.pointer);
+	if (!dsd) {
+		ret =3D -ENODEV;
+		goto cleanup_acpi_buf;
+	}
+
+	ret =3D pmc_parse_telem_dsd(dsd, &header, &acpi_disc);
+	if (ret)
+		goto cleanup_acpi_buf;
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, header.tbir);
+	if (!res) {
+		ret =3D -EINVAL;
+		goto cleanup_acpi_disc;
+	}
+
+	info.headers =3D headers;
+	info.caps =3D VSEC_CAP_TELEMETRY;
+	info.acpi_disc =3D acpi_disc;
+	info.src =3D INTEL_VSEC_DISC_ACPI;
+	info.base_addr =3D res->start;
+
+	ret =3D intel_vsec_register(&pdev->dev, &info);
+
+cleanup_acpi_disc:
+	kfree(acpi_disc);
+cleanup_acpi_buf:
+	ACPI_FREE(buf.pointer);
+
+	return ret;
+}
+
+static const struct acpi_device_id pmc_pwrm_acpi_ids[] =3D {
+	{ "INTC1122", 0 }, /* Nova Lake */
+	{ "INTC1129", 0 }, /* Nova Lake */
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, pmc_pwrm_acpi_ids);
+
+static struct platform_driver pmc_pwrm_acpi_driver =3D {
+	.probe =3D pmc_pwrm_acpi_probe,
+	.driver =3D {
+		.name =3D "intel_pmc_pwrm_acpi",
+		.acpi_match_table =3D ACPI_PTR(pmc_pwrm_acpi_ids),
+	},
+};
+module_platform_driver(pmc_pwrm_acpi_driver);
+
+MODULE_AUTHOR("David E. Box <david.e.box@linux.intel.com>");
+MODULE_DESCRIPTION("Intel PMC PWRM ACPI driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("INTEL_VSEC");
--=20
2.43.0

