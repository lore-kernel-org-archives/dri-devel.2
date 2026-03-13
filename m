Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAA6106FD71
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 01:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A74710EAC9;
	Fri, 13 Mar 2026 01:52:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="W1+q/hw1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E27ED10EAD0;
 Fri, 13 Mar 2026 01:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773366740; x=1804902740;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=B8JS8RQBRrQVr1GSRI9Lf2J0JExHYR/5c0SOq7MzXKg=;
 b=W1+q/hw18pW4+2GejPmUh2Yg2DANks+/VED5720ec3zGc+J21r1tvdzH
 pWHhV23CA1TvMET/Y+BjZLVCtIWh1bBxuKCE0IZOBR5h5Ny+PjZAViY8r
 gTM34zkPYssYURWLQXa+FP2NjE6lFNBLrAVYUnMgEqtG81mFK9GpW5Q8a
 WmcMI4J6tcLoQH0n4c+icCr/es8gir590Ty6isF1ZP1wQndntNZ6myfPG
 NTes3omJdWVSamXjFq4p6uS3G1jQEirA7WREBQLApQDTM9/v7mGe30Szl
 s16Y8QZQnWpAB6uk9Ha0V/FNryuCMT4LKlVGYTEtgVm5TgXKghI6qXewN w==;
X-CSE-ConnectionGUID: +ZPXQoppTVSFPipQAYtUrA==
X-CSE-MsgGUID: qTwq4AbOTCC1sNYugVB9mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74354620"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="74354620"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 18:52:12 -0700
X-CSE-ConnectionGUID: Bfxnia9TQTyslxJwaFfbTA==
X-CSE-MsgGUID: OChU2o0pQYuVC2HLS/q5lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="220108530"
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
Subject: [PATCH 21/22] platform/x86/intel/pmc/ssram: Make PMT registration
 optional
Date: Thu, 12 Mar 2026 18:52:00 -0700
Message-ID: <20260313015202.3660072-22-david.e.box@linux.intel.com>
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

The SSRAM telemetry driver extracts essential PMC device ID and power
management base address information that intel_pmc_core depends on for core
functionality. PMT registration failure should not prevent this critical
data from being available, as it would break intel_pmc_core operation
entirely.

Change the behavior to log a warning when PMT registration fails but
continue with successful driver initialization, ensuring the primary
telemetry data remains accessible to dependent drivers.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/ssram_telemetry.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/pla=
tform/x86/intel/pmc/ssram_telemetry.c
index b937ebb2322f..12b7c1299c2f 100644
--- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
+++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
@@ -106,6 +106,7 @@ pmc_ssram_telemetry_get_pmc_pci(struct pci_dev *pcidev,=
 unsigned int pmc_idx, u3
 	void __iomem __free(pmc_ssram_telemetry_iounmap) *tmp_ssram =3D NULL;
 	void __iomem __free(pmc_ssram_telemetry_iounmap) *ssram =3D NULL;
 	u64 ssram_base;
+	int ret;
=20
 	ssram_base =3D pci_resource_start(pcidev, 0);
 	tmp_ssram =3D ioremap(ssram_base, SSRAM_HDR_SIZE);
@@ -133,7 +134,11 @@ pmc_ssram_telemetry_get_pmc_pci(struct pci_dev *pcidev=
, unsigned int pmc_idx, u3
 	pmc_ssram_get_devid_pwrmbase(ssram, pmc_idx);
=20
 	/* Find and register and PMC telemetry entries */
-	return pmc_ssram_telemetry_add_pmt(pcidev, ssram_base, ssram);
+	ret =3D pmc_ssram_telemetry_add_pmt(pcidev, ssram_base, ssram);
+	if (ret)
+		dev_warn(&pcidev->dev, "could not register PMT\n");
+
+	return 0;
 }
=20
 static int pmc_ssram_telemetry_pci_init(struct pci_dev *pcidev)
@@ -208,12 +213,12 @@ static int pmc_ssram_telemetry_acpi_init(struct pci_d=
ev *pcidev,
=20
 	ret =3D intel_vsec_register(&pcidev->dev, &info);
 	if (ret)
-		goto cleanup_acpi_disc;
+		dev_warn(&pcidev->dev, "could not register PMT\n");
=20
 	ret =3D pmc_ssram_telemetry_get_pmc_acpi(pcidev, index);
=20
-cleanup_acpi_disc:
 	kfree(acpi_disc);
+
 cleanup_acpi_buf:
 	ACPI_FREE(buf.pointer);
=20
--=20
2.43.0

