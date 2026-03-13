Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC93106FD68
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 01:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B529910EAF8;
	Fri, 13 Mar 2026 01:52:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cjH2Xi7J";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBCAB10E441;
 Fri, 13 Mar 2026 01:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773366740; x=1804902740;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e1S8raHL6U6wBJ8ruzzvM0H21MrzxEn6TFDGtuGpeH4=;
 b=cjH2Xi7JyD8zWKWCB6reEIZjvJuXphmUqgmqMbM5aNun3X4ONmELeISU
 NvZK+rtH1eWRjgAa++KnQp9HEzRr3sg+JjyPGlf7uqY1sta3Ruvtn+iRm
 w5fHB0O0XTe0GMR6j2AX+SBqB04JivD0TVEV4b4e8DIx5GPua2AngprLS
 nmS6rE1+N6qFjiQmqTZURMcLHZR4pM5/+shqzBd3a7MyWG9CLOJ8QN78L
 0A8H7JkUhy7jALepCnU/FWg0B1fpdd3k9FRYloxkVsYXH3iCMv4C1ml5J
 ClNu7gZsdxUTeNyAzN8XnbSgI816vcb2lk5SNpqlwSqrVfs8xwMGBHYPq w==;
X-CSE-ConnectionGUID: S1Vgdvp3R1quAZUou1rTKQ==
X-CSE-MsgGUID: tLxI0EL+SpO1cdkXlTw8Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74354608"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="74354608"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 18:52:12 -0700
X-CSE-ConnectionGUID: 89UbklxMTcKhw/hQkw800g==
X-CSE-MsgGUID: W7Ipz7btQ3Oexz/az466tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="220108518"
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
Subject: [PATCH 17/22] platform/x86/intel/pmc/ssram: Refactor DEVID/PWRMBASE
 extraction into helper
Date: Thu, 12 Mar 2026 18:51:56 -0700
Message-ID: <20260313015202.3660072-18-david.e.box@linux.intel.com>
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

Move DEVID/PWRMBASE extraction into pmc_ssram_get_devid_pwrmbase().

This is a preparatory refactor to place functionality in a common helper
for reuse by a subsequent patch, while keeping behavior unchanged in this
step.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 .../platform/x86/intel/pmc/ssram_telemetry.c  | 31 ++++++++++++-------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/pla=
tform/x86/intel/pmc/ssram_telemetry.c
index 9c3d7ba2fd52..75a80a74a069 100644
--- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
+++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
@@ -27,6 +27,23 @@ DEFINE_FREE(pmc_ssram_telemetry_iounmap, void __iomem *,=
 if (_T) iounmap(_T))
 static struct pmc_ssram_telemetry pmc_ssram_telems[3];
 static bool device_probed;
=20
+static inline u64 get_base(void __iomem *addr, u32 offset)
+{
+	return lo_hi_readq(addr + offset) & GENMASK_ULL(63, 3);
+}
+
+static void pmc_ssram_get_devid_pwrmbase(void __iomem *ssram, unsigned int=
 pmc_idx)
+{
+	u64 pwrm_base;
+	u16 devid;
+
+	pwrm_base =3D get_base(ssram, SSRAM_PWRM_OFFSET);
+	devid =3D readw(ssram + SSRAM_DEVID_OFFSET);
+
+	pmc_ssram_telems[pmc_idx].devid =3D devid;
+	pmc_ssram_telems[pmc_idx].base_addr =3D pwrm_base;
+}
+
 static int
 pmc_ssram_telemetry_add_pmt(struct pci_dev *pcidev, u64 ssram_base, void _=
_iomem *ssram)
 {
@@ -63,18 +80,12 @@ pmc_ssram_telemetry_add_pmt(struct pci_dev *pcidev, u64=
 ssram_base, void __iomem
 	return intel_vsec_register(&pcidev->dev, &info);
 }
=20
-static inline u64 get_base(void __iomem *addr, u32 offset)
-{
-	return lo_hi_readq(addr + offset) & GENMASK_ULL(63, 3);
-}
-
 static int
 pmc_ssram_telemetry_get_pmc(struct pci_dev *pcidev, unsigned int pmc_idx, =
u32 offset)
 {
 	void __iomem __free(pmc_ssram_telemetry_iounmap) *tmp_ssram =3D NULL;
 	void __iomem __free(pmc_ssram_telemetry_iounmap) *ssram =3D NULL;
-	u64 ssram_base, pwrm_base;
-	u16 devid;
+	u64 ssram_base;
=20
 	ssram_base =3D pci_resource_start(pcidev, 0);
 	tmp_ssram =3D ioremap(ssram_base, SSRAM_HDR_SIZE);
@@ -99,11 +110,7 @@ pmc_ssram_telemetry_get_pmc(struct pci_dev *pcidev, uns=
igned int pmc_idx, u32 of
 		ssram =3D no_free_ptr(tmp_ssram);
 	}
=20
-	pwrm_base =3D get_base(ssram, SSRAM_PWRM_OFFSET);
-	devid =3D readw(ssram + SSRAM_DEVID_OFFSET);
-
-	pmc_ssram_telems[pmc_idx].devid =3D devid;
-	pmc_ssram_telems[pmc_idx].base_addr =3D pwrm_base;
+	pmc_ssram_get_devid_pwrmbase(ssram, pmc_idx);
=20
 	/* Find and register and PMC telemetry entries */
 	return pmc_ssram_telemetry_add_pmt(pcidev, ssram_base, ssram);
--=20
2.43.0

