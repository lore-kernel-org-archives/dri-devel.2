Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB94106FD65
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 01:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06F4110EAF9;
	Fri, 13 Mar 2026 01:52:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="geiiSDLJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9B8E10EAD7;
 Fri, 13 Mar 2026 01:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773366740; x=1804902740;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RFMAz3gtqVPr0spLvBGURASuHF6nJbAQptgHl3lAlNs=;
 b=geiiSDLJfaSevQ3aKs0w+Qc1MXDvAPWCYcDkpFOUUjs5TJogLQflibnD
 Pozc16F+qv01ubdszgGJZhC41VHcd/ZEcx/UKo6q306BRx2k/riQ1EMFu
 l5DN6uYmf2edaXlBREuYbFbklVtSTvufLKvK+h5RUdozwaycTsY2iyZU8
 +V3b4Y5LGfz7TECH4+ft+EE5O5FH95sXho5sNe7qlELqDURI2FHC0kBxF
 KxLjmDxWZ0bkHbGXmSqUp6AUl5/rOGlzl3cOOHfEfzuJ0stMNwu2OIDP7
 WPjHehsfSSMPpF1cj0XWKNe59K7B3CY20zhnPjBEGDyZ1A4E9X/pR/T7q w==;
X-CSE-ConnectionGUID: eqI0qjUjQ5W0lAV6khXIBA==
X-CSE-MsgGUID: k35dtHeHRLasyJmvn0dR7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74354607"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="74354607"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2026 18:52:12 -0700
X-CSE-ConnectionGUID: ukU4FvFWTqeuDfszU6JniQ==
X-CSE-MsgGUID: h4eqBIB4Req9XaOI4ac/bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="220108515"
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
Subject: [PATCH 16/22] platform/x86/intel/pmc/ssram: Use fixed-size static pmc
 array
Date: Thu, 12 Mar 2026 18:51:55 -0700
Message-ID: <20260313015202.3660072-17-david.e.box@linux.intel.com>
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

Switch pmc_ssram_telems from a devm-allocated pointer to a fixed-size
static array, eliminating per-probe allocation overhead and simplifying
lifetime management.

Correspondingly simplify pmc_ssram_telemetry_get_pmc_info() validation to
check devid availability and tighten input bounds checking. Drop
null-pointer checks now that the storage is static.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/ssram_telemetry.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/pla=
tform/x86/intel/pmc/ssram_telemetry.c
index 1deb4d71da3f..9c3d7ba2fd52 100644
--- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
+++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
@@ -24,7 +24,7 @@
=20
 DEFINE_FREE(pmc_ssram_telemetry_iounmap, void __iomem *, if (_T) iounmap(_=
T))
=20
-static struct pmc_ssram_telemetry *pmc_ssram_telems;
+static struct pmc_ssram_telemetry pmc_ssram_telems[3];
 static bool device_probed;
=20
 static int
@@ -140,7 +140,7 @@ int pmc_ssram_telemetry_get_pmc_info(unsigned int pmc_i=
dx,
 	if (pmc_idx >=3D MAX_NUM_PMC)
 		return -EINVAL;
=20
-	if (!pmc_ssram_telems || !pmc_ssram_telems[pmc_idx].devid)
+	if (!pmc_ssram_telems[pmc_idx].devid)
 		return -ENODEV;
=20
 	pmc_ssram_telemetry->devid =3D pmc_ssram_telems[pmc_idx].devid;
@@ -153,12 +153,6 @@ static int pmc_ssram_telemetry_probe(struct pci_dev *p=
cidev, const struct pci_de
 {
 	int ret;
=20
-	pmc_ssram_telems =3D devm_kzalloc(&pcidev->dev, sizeof(*pmc_ssram_telems)=
 * MAX_NUM_PMC,
-					GFP_KERNEL);
-	if (!pmc_ssram_telems) {
-		ret =3D -ENOMEM;
-		goto probe_finish;
-	}
=20
 	ret =3D pcim_enable_device(pcidev);
 	if (ret) {
--=20
2.43.0

