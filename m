Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05ED106FD70
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 01:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A418E10EAF2;
	Fri, 13 Mar 2026 01:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="i/6ca6Eh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA1310E042;
 Fri, 13 Mar 2026 01:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773366740; x=1804902740;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cHvNmyfTzDEKzQJQTUfCW1OK/LXgebpLZjQDLiY0EOc=;
 b=i/6ca6EhoezJCZrrALWj4DspbuZ//3Jq1D//GMGhTNuV2saQB6N9FUpF
 ySX57AYI2ER7/ob991mwY/g3RwWUklHUXeOw+Ibf63R9OeVDEHacQwdLS
 wP12Qy/sSLr41wl8xzTp5awJfb9pp1//o7nFKJLsLVg+LyoevKAIpVCYv
 LNpSeElib+eJU+jHWJrgpaDcxt3xHhxdXYRbHGwuKzgXPb35k+OVLAv5V
 3lr6McjE4LiEk5l4lVTCtx/0WG8qZPd+hNTLNrV/jGqxEuVi8jzi45G4Y
 3yZZNclHEP1YS5XNHRavxZyzVLQGXgqTK+xk06FFV+EEcYRphGkWiAkYa A==;
X-CSE-ConnectionGUID: 3dF+Y7AITm6Q3o17uo79/g==
X-CSE-MsgGUID: +EaMI9EMT9q3cdh2oDC3fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74354619"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="74354619"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 18:52:12 -0700
X-CSE-ConnectionGUID: WVo9RwH3TsGWzeplyQEDkA==
X-CSE-MsgGUID: 1WxKWnpJRjyQpgUpeyGOvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="220108527"
Received: from debox1-desk4.jf.intel.com ([10.88.27.138])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 18:52:13 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 irenic.rajneesh@gmail.com, ilpo.jarvinen@linux.intel.com,
 srinivas.pandruvada@linux.intel.com, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, xi.pardee@linux.intel.com
Cc: david.e.box@linux.intel.com, hansg@kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 20/22] platform/x86/intel/pmc/ssram: Add ACPI discovery
 scaffolding
Date: Thu, 12 Mar 2026 18:51:59 -0700
Message-ID: <20260313015202.3660072-21-david.e.box@linux.intel.com>
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

Prepare the SSRAM telemetry driver for ACPI-based discovery by adding the
common initialization path and selection framework needed for resource
discovery from the ACPI companion device.

At this stage, existing supported devices continue to use the PCI path.
This change lays the groundwork for follow-on patches that wire platform
IDs to the ACPI policy path.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 .../platform/x86/intel/pmc/ssram_telemetry.c  | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/pla=
tform/x86/intel/pmc/ssram_telemetry.c
index 246efdcf6950..b937ebb2322f 100644
--- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
+++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2023, Intel Corporation.
  */
=20
+#include <linux/acpi.h>
 #include <linux/cleanup.h>
 #include <linux/intel_vsec.h>
 #include <linux/pci.h>
@@ -26,14 +27,17 @@ DEFINE_FREE(pmc_ssram_telemetry_iounmap, void __iomem *=
, if (_T) iounmap(_T))
=20
 enum resource_method {
 	RES_METHOD_PCI,
+	RES_METHOD_ACPI,
 };
=20
 struct ssram_type {
 	enum resource_method method;
+	enum pmc_index p_index;
 };
=20
 static const struct ssram_type pci_main =3D {
 	.method =3D RES_METHOD_PCI,
+	.p_index =3D PMC_IDX_MAIN,
 };
=20
 static struct pmc_ssram_telemetry pmc_ssram_telems[3];
@@ -146,6 +150,76 @@ static int pmc_ssram_telemetry_pci_init(struct pci_dev=
 *pcidev)
 	return ret;
 }
=20
+static int pmc_ssram_telemetry_get_pmc_acpi(struct pci_dev *pcidev,  unsig=
ned int pmc_idx)
+{
+	void __iomem __free(pmc_ssram_telemetry_iounmap) * ssram =3D NULL;
+	u64 ssram_base;
+
+	ssram_base =3D pci_resource_start(pcidev, 0);
+	if (!ssram_base)
+		return -ENODEV;
+
+	ssram =3D ioremap(ssram_base, SSRAM_HDR_SIZE);
+	if (!ssram)
+		return -ENOMEM;
+
+	pmc_ssram_get_devid_pwrmbase(ssram, pmc_idx);
+
+	return 0;
+}
+
+static int pmc_ssram_telemetry_acpi_init(struct pci_dev *pcidev,
+					 enum pmc_index index)
+{
+	struct acpi_buffer buf =3D { ACPI_ALLOCATE_BUFFER, NULL };
+	acpi_handle handle =3D ACPI_HANDLE(&pcidev->dev);
+	struct intel_vsec_header header;
+	struct intel_vsec_header *headers[2] =3D { &header, NULL };
+	struct intel_vsec_platform_info info =3D { };
+	union acpi_object *dsd;
+	u32 (*acpi_disc)[4];
+	acpi_status status;
+	int ret;
+
+	if (!handle)
+		return -ENODEV;
+
+	status =3D acpi_evaluate_object(handle, "_DSD", NULL, &buf);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
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
+	info.headers =3D headers;
+	info.caps =3D VSEC_CAP_TELEMETRY;
+	info.acpi_disc =3D acpi_disc;
+	info.src =3D INTEL_VSEC_DISC_ACPI;
+
+	/* This is an ACPI companion device. PCI BAR will be used for base addr. =
*/
+	info.base_addr =3D 0;
+
+	ret =3D intel_vsec_register(&pcidev->dev, &info);
+	if (ret)
+		goto cleanup_acpi_disc;
+
+	ret =3D pmc_ssram_telemetry_get_pmc_acpi(pcidev, index);
+
+cleanup_acpi_disc:
+	kfree(acpi_disc);
+cleanup_acpi_buf:
+	ACPI_FREE(buf.pointer);
+
+	return ret;
+}
+
 /**
  * pmc_ssram_telemetry_get_pmc_info() - Get a PMC devid and base_addr info=
rmation
  * @pmc_idx:               Index of the PMC
@@ -186,6 +260,7 @@ static int pmc_ssram_telemetry_probe(struct pci_dev *pc=
idev, const struct pci_de
 {
 	const struct ssram_type *ssram_type;
 	enum resource_method method;
+	enum pmc_index index;
 	int ret;
=20
 	ssram_type =3D (const struct ssram_type *)id->driver_data;
@@ -196,6 +271,7 @@ static int pmc_ssram_telemetry_probe(struct pci_dev *pc=
idev, const struct pci_de
 	}
=20
 	method =3D ssram_type->method;
+	index =3D ssram_type->p_index;
=20
 	ret =3D pcim_enable_device(pcidev);
 	if (ret) {
@@ -205,6 +281,8 @@ static int pmc_ssram_telemetry_probe(struct pci_dev *pc=
idev, const struct pci_de
=20
 	if (method =3D=3D RES_METHOD_PCI)
 		ret =3D pmc_ssram_telemetry_pci_init(pcidev);
+	else if (method =3D=3D RES_METHOD_ACPI)
+		ret =3D pmc_ssram_telemetry_acpi_init(pcidev, index);
 	else
 		ret =3D -EINVAL;
=20
@@ -238,6 +316,7 @@ static struct pci_driver pmc_ssram_telemetry_driver =3D=
 {
 };
 module_pci_driver(pmc_ssram_telemetry_driver);
=20
+MODULE_IMPORT_NS("INTEL_PMC_CORE");
 MODULE_IMPORT_NS("INTEL_VSEC");
 MODULE_AUTHOR("Xi Pardee <xi.pardee@intel.com>");
 MODULE_DESCRIPTION("Intel PMC SSRAM Telemetry driver");
--=20
2.43.0

