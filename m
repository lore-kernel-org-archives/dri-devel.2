Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D65106FD72
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 01:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3F7210EAE5;
	Fri, 13 Mar 2026 01:52:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="oDPly3Mr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F205810EAD1;
 Fri, 13 Mar 2026 01:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773366740; x=1804902740;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9EZCD23+p8RudnMdCZ4NNN4C1wB08jPQU64kU8m1jT0=;
 b=oDPly3MrrhaBtNsatresrI8Vd5wYvp8JRsuaDp5TrIXwRbeG+Hk7OJwO
 Zd1YUpvrxzcHEeisDqqsjIdyexShyCAdz5tYukXijHIR8QPd2TrFZe5Bq
 QpABl8d/xBEOdDYWSeEW5q7RB3jaNnCuggL2708K6rNLK2K/mHA6vecXw
 vUETKb8nhYc/4joHUOP4QYBJRjOypKDNnbwW9wgQCErBxE0WcBKRFUAHA
 YoEQH9J066cedJ2YIncDxSBTzCJZq1Ic/AItoNlD97xmufbt1Hh3C3caA
 h/qsd/MofUf+kfYRkIYylHa53Qv4m3ytATn9/Q/WVDBBoETBadY7B9p2v A==;
X-CSE-ConnectionGUID: WAakOdvNQAGB1ArPI8LCmA==
X-CSE-MsgGUID: V76eauPSQD6NJh3lEqSVOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74354616"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="74354616"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 18:52:12 -0700
X-CSE-ConnectionGUID: LJvuCfgKQWq/SleK9LG13Q==
X-CSE-MsgGUID: n86wPIh7RMiVY8p+4qan0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="220108525"
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
Subject: [PATCH 19/22] platform/x86/intel/pmc/ssram: Refactor memory barrier
 for reentrant probe
Date: Thu, 12 Mar 2026 18:51:58 -0700
Message-ID: <20260313015202.3660072-20-david.e.box@linux.intel.com>
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

From: Xi Pardee <xi.pardee@linux.intel.com>

Switch the readiness synchronization from a global device_probed flag to
per-index devid publication. This is required because a subsequent patch
makes probe reentrant, so a single global flag can no longer reliably
signal completion.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 .../platform/x86/intel/pmc/ssram_telemetry.c  | 34 ++++++++-----------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/pla=
tform/x86/intel/pmc/ssram_telemetry.c
index 7db98037c521..246efdcf6950 100644
--- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
+++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
@@ -37,7 +37,6 @@ static const struct ssram_type pci_main =3D {
 };
=20
 static struct pmc_ssram_telemetry pmc_ssram_telems[3];
-static bool device_probed;
=20
 static inline u64 get_base(void __iomem *addr, u32 offset)
 {
@@ -52,8 +51,13 @@ static void pmc_ssram_get_devid_pwrmbase(void __iomem *s=
sram, unsigned int pmc_i
 	pwrm_base =3D get_base(ssram, SSRAM_PWRM_OFFSET);
 	devid =3D readw(ssram + SSRAM_DEVID_OFFSET);
=20
-	pmc_ssram_telems[pmc_idx].devid =3D devid;
 	pmc_ssram_telems[pmc_idx].base_addr =3D pwrm_base;
+	/*
+	 * Memory barrier is used to ensure the correct write order between base_=
addr
+	 * and devid.
+	 */
+	smp_wmb();
+	pmc_ssram_telems[pmc_idx].devid =3D devid;
 }
=20
 static int
@@ -151,32 +155,28 @@ static int pmc_ssram_telemetry_pci_init(struct pci_de=
v *pcidev)
  * * 0           - Success
  * * -EAGAIN     - Probe function has not finished yet. Try again.
  * * -EINVAL     - Invalid pmc_idx
- * * -ENODEV     - PMC device is not available
  */
 int pmc_ssram_telemetry_get_pmc_info(unsigned int pmc_idx,
 				     struct pmc_ssram_telemetry *pmc_ssram_telemetry)
 {
+	if (pmc_idx >=3D MAX_NUM_PMC)
+		return -EINVAL;
+
 	/*
 	 * PMCs are discovered in probe function. If this function is called befo=
re
-	 * probe function complete, the result would be invalid. Use device_probed
-	 * variable to avoid this case. Return -EAGAIN to inform the consumer to =
call
+	 * probe function complete, the result would be invalid. Use devid to avo=
id
+	 * this case. Return -EAGAIN to inform the consumer to call
 	 * again later.
 	 */
-	if (!device_probed)
+	if (!pmc_ssram_telems[pmc_idx].devid)
 		return -EAGAIN;
=20
+	pmc_ssram_telemetry->devid =3D pmc_ssram_telems[pmc_idx].devid;
 	/*
 	 * Memory barrier is used to ensure the correct read order between
-	 * device_probed variable and PMC info.
+	 * devid variable and base_addr.
 	 */
 	smp_rmb();
-	if (pmc_idx >=3D MAX_NUM_PMC)
-		return -EINVAL;
-
-	if (!pmc_ssram_telems[pmc_idx].devid)
-		return -ENODEV;
-
-	pmc_ssram_telemetry->devid =3D pmc_ssram_telems[pmc_idx].devid;
 	pmc_ssram_telemetry->base_addr =3D pmc_ssram_telems[pmc_idx].base_addr;
 	return 0;
 }
@@ -209,12 +209,6 @@ static int pmc_ssram_telemetry_probe(struct pci_dev *p=
cidev, const struct pci_de
 		ret =3D -EINVAL;
=20
 probe_finish:
-	/*
-	 * Memory barrier is used to ensure the correct write order between PMC i=
nfo
-	 * and device_probed variable.
-	 */
-	smp_wmb();
-	device_probed =3D true;
 	return ret;
 }
=20
--=20
2.43.0

