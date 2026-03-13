Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABAA106FD6E
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 01:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48C2810EADE;
	Fri, 13 Mar 2026 01:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FartJxd1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01A0610EADA;
 Fri, 13 Mar 2026 01:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773366740; x=1804902740;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TDOjwrAiE0+YRhpVFIaO2hLNE/kMQhYEezbZ6Pqkkvw=;
 b=FartJxd1BD1QlxXNMzyvUIXiPBbpeEkLopv6yDZnfm9EVoYws/ELerTU
 TujtG4hQu20XlTE6My/9JT1HMyxJON75io5IBGw0YLXiaxNUPv2FEz/I4
 zCWabswfKpynr0K/E/JN4UyLycjChKp3PWOHquODDUflRxr+IaoxBvcoO
 uoEkvQKqD7Y9oC6rHSFWA5YxGXm/VaBQK2J0xU9q89F2LQkRDsI1m8OW1
 ZZFU1WZI3u1IxxVM3APVNfWMyHqpf/+mnz6UxJMhdI5S0LJTL4FDml2cI
 VzlT+h2AKS6URTimcpe+H2+CVoY4qZbNRsRznVVa73oHYmbP5o/fvcVsM g==;
X-CSE-ConnectionGUID: t2tC+bB3Tb2aTX8c8OQs1A==
X-CSE-MsgGUID: LwEcLg7jSdGVejUsAoYrYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74354621"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="74354621"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 18:52:12 -0700
X-CSE-ConnectionGUID: 2v/npuzSSlG6rGW/t+sNeA==
X-CSE-MsgGUID: r5vIVCK9Q2+ACBBE2zQiCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="220108533"
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
Subject: [PATCH 22/22] platform/x86/intel/pmc: Add NVL PCI IDs for SSRAM
 telemetry discovery
Date: Thu, 12 Mar 2026 18:52:01 -0700
Message-ID: <20260313015202.3660072-23-david.e.box@linux.intel.com>
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

Add Nova Lake S PMC device IDs to enable binding of the SSRAM telemetry
driver on NVL platforms, and map them to the ACPI-based discovery policy.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.h            |  5 +++++
 drivers/platform/x86/intel/pmc/ssram_telemetry.c | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/i=
ntel/pmc/core.h
index 284aced99f72..57557ad7d43b 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -329,6 +329,11 @@ enum ppfear_regs {
 #define PMC_DEVID_MTL_IOEP	0x7ecf
 #define PMC_DEVID_MTL_IOEM	0x7ebf
=20
+/* NVL */
+#define PMC_DEVID_NVL_PCDH	0xd37e
+#define PMC_DEVID_NVL_PCDS	0xd47e
+#define PMC_DEVID_NVL_PCHS	0x6e27
+
 extern const char *pmc_lpm_modes[];
=20
 struct pmc_bit_map {
diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/pla=
tform/x86/intel/pmc/ssram_telemetry.c
index 12b7c1299c2f..930b4a510c71 100644
--- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
+++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
@@ -40,6 +40,16 @@ static const struct ssram_type pci_main =3D {
 	.p_index =3D PMC_IDX_MAIN,
 };
=20
+static const struct ssram_type acpi_main =3D {
+	.method =3D RES_METHOD_ACPI,
+	.p_index =3D PMC_IDX_MAIN,
+};
+
+static const struct ssram_type acpi_pch =3D {
+	.method =3D RES_METHOD_ACPI,
+	.p_index =3D PMC_IDX_PCH,
+};
+
 static struct pmc_ssram_telemetry pmc_ssram_telems[3];
=20
 static inline u64 get_base(void __iomem *addr, u32 offset)
@@ -310,6 +320,12 @@ static const struct pci_device_id pmc_ssram_telemetry_=
pci_ids[] =3D {
 		.driver_data =3D (kernel_ulong_t)&pci_main },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_WCL_PCDN),
 		.driver_data =3D (kernel_ulong_t)&pci_main },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_NVL_PCDH),
+		.driver_data =3D (kernel_ulong_t)&acpi_main },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_NVL_PCDS),
+		.driver_data =3D (kernel_ulong_t)&acpi_main },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_NVL_PCHS),
+		.driver_data =3D (kernel_ulong_t)&acpi_pch },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pmc_ssram_telemetry_pci_ids);
--=20
2.43.0

