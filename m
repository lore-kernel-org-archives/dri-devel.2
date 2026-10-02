Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EA0CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B90310F816;
	Fri,  2 Oct 2026 09:48:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FsuJjrU5";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A24F10E425;
 Fri,  2 Oct 2026 09:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790934501; x=1822470501;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RbcWBmCUPxJ+y+RKr8MXYk/AIpKv9AVVXztnaBm7aIk=;
 b=FsuJjrU53WMJgU2igrkRUkGJN0a2+iS6782KSlyGRnw+/t4O3Qdj4THl
 F192fSbjMXd6mACVeTL1Tk5jN3XQ4dumUbAdsBxPSUVqdpITJ7ayvAoH8
 6OCan6Hbg3aY7HywUyW6OruhKzDsaVxmiBDtl/R1VBFKc5wPU55uNc1e9
 AckbvvUOU25VYD25wjsvMUBc/fJm6mbLWTyIt4Kqnuj75jzUNC1LJQLwN
 qqyj8TttbKyNU0/5IwheFOBoyx9PLTRQoZUGohWhTGfFKKblmNl8BpIYT
 kf3yWm34Ns00qfEOx4kn/Rl2KjY9owJ/JdEfzxz0O6s42X8/s9PJOEJpA Q==;
X-CSE-ConnectionGUID: WsC1y8loSqy/rDx2PNNKcw==
X-CSE-MsgGUID: KEgTWTPOTp+xmvMxgL0VUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="102374093"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="102374093"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 02:48:21 -0700
X-CSE-ConnectionGUID: p0x8X6ozTo2s8vpYu1Y3mQ==
X-CSE-MsgGUID: 9fXOdM5bTF2RRK4GAMke+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="280959261"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa004.fm.intel.com with ESMTP; 02 Oct 2026 02:48:16 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
 id 6CEE299; Fri, 02 Oct 2026 11:48:15 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jani Nikula <jani.nikula@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/1] media: Consolidate AtomISP v2 PCI IDs in the pci_ids.h
Date: Fri,  2 Oct 2026 11:43:43 +0200
Message-ID: <20261002094813.856439-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

We have a few drivers using same pair of the PCI IDs across the kernel and
there seems more to go, consolidate AtomISP v2 PCI IDs in pci_ids.h database.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Assuming that media subsystem is the main beneficiary I think it is the best
to route it via that tree. For others (i915, PCI, PDx86), please Ack if you
are agree.

 drivers/gpu/drm/i915/display/intel_display_power.c   |  6 +++---
 drivers/platform/x86/intel/atomisp2/pm.c             |  6 +++---
 drivers/staging/media/atomisp/pci/atomisp_internal.h |  2 --
 drivers/staging/media/atomisp/pci/atomisp_v4l2.c     | 10 +++++-----
 include/linux/pci_ids.h                              |  2 ++
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_power.c b/drivers/gpu/drm/i915/display/intel_display_power.c
index 2e534ddb7347..ee2c59b72b4a 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power.c
+++ b/drivers/gpu/drm/i915/display/intel_display_power.c
@@ -2086,9 +2086,9 @@ static void assert_ved_power_gated(struct intel_display *display)
 static void assert_isp_power_gated(struct intel_display *display)
 {
 	static const struct pci_device_id isp_ids[] = {
-		{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0f38)},
-		{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x22b8)},
-		{}
+		{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ISP_BYT) },
+		{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ISP_BSW) },
+		{ }
 	};
 
 	drm_WARN(display->drm, !pci_dev_present(isp_ids) &&
diff --git a/drivers/platform/x86/intel/atomisp2/pm.c b/drivers/platform/x86/intel/atomisp2/pm.c
index ad1f99140962..f3dee0e58f62 100644
--- a/drivers/platform/x86/intel/atomisp2/pm.c
+++ b/drivers/platform/x86/intel/atomisp2/pm.c
@@ -121,9 +121,9 @@ static UNIVERSAL_DEV_PM_OPS(isp_pm_ops, isp_pci_suspend,
 			    isp_pci_resume, NULL);
 
 static const struct pci_device_id isp_id_table[] = {
-	{ PCI_VDEVICE(INTEL, 0x0f38), },
-	{ PCI_VDEVICE(INTEL, 0x22b8), },
-	{ 0, }
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ISP_BYT) },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ISP_BSW) },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, isp_id_table);
 
diff --git a/drivers/staging/media/atomisp/pci/atomisp_internal.h b/drivers/staging/media/atomisp/pci/atomisp_internal.h
index 5a69580b8251..1a05fc331557 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_internal.h
+++ b/drivers/staging/media/atomisp/pci/atomisp_internal.h
@@ -37,7 +37,6 @@
 	(((isp)->media_dev.hw_revision & ATOMISP_HW_REVISION_MASK) == \
 	 ((rev) << ATOMISP_HW_REVISION_SHIFT))
 
-#define ATOMISP_PCI_DEVICE_SOC_BYT	0x0f38
 /* MRFLD with 0x1178: ISP freq can burst to 457MHz */
 #define ATOMISP_PCI_DEVICE_SOC_MRFLD	0x1178
 /* MRFLD with 0x1179: max ISP freq limited to 400MHz */
@@ -45,7 +44,6 @@
 /* MRFLD with 0x117a: max ISP freq is 400MHz and max freq at Vmin is 200MHz */
 #define ATOMISP_PCI_DEVICE_SOC_MRFLD_117A	0x117a
 #define ATOMISP_PCI_DEVICE_SOC_ANN	0x1478
-#define ATOMISP_PCI_DEVICE_SOC_CHT	0x22b8
 
 #define ATOMISP_PCI_REV_MRFLD_A0_MAX	0
 #define ATOMISP_PCI_REV_BYT_A0_MAX	4
diff --git a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
index 476fe143a591..ab8727a806bf 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
@@ -1239,7 +1239,7 @@ static int atomisp_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 		}
 		isp->hpll_freq = HPLL_FREQ_1600MHZ;
 		break;
-	case ATOMISP_PCI_DEVICE_SOC_BYT:
+	case PCI_DEVICE_ID_INTEL_ISP_BYT:
 		isp->media_dev.hw_revision =
 		    (ATOMISP_HW_REVISION_ISP2400
 		     << ATOMISP_HW_REVISION_SHIFT) |
@@ -1284,7 +1284,7 @@ static int atomisp_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 		isp->dfs = &dfs_config_merr;
 		isp->hpll_freq = HPLL_FREQ_1600MHZ;
 		break;
-	case ATOMISP_PCI_DEVICE_SOC_CHT:
+	case PCI_DEVICE_ID_INTEL_ISP_BSW:
 		isp->media_dev.hw_revision = (ATOMISP_HW_REVISION_ISP2401
 						 << ATOMISP_HW_REVISION_SHIFT);
 		isp->media_dev.hw_revision |= pdev->revision < 2 ?
@@ -1487,12 +1487,12 @@ static const struct pci_device_id atomisp_pci_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, ATOMISP_PCI_DEVICE_SOC_MRFLD_1179)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, ATOMISP_PCI_DEVICE_SOC_MRFLD_117A)},
 	/* Baytrail */
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, ATOMISP_PCI_DEVICE_SOC_BYT)},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ISP_BYT) },
 	/* Anniedale (Merrifield+ / Moorefield) */
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, ATOMISP_PCI_DEVICE_SOC_ANN)},
 	/* Cherrytrail */
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, ATOMISP_PCI_DEVICE_SOC_CHT)},
-	{0,}
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ISP_BSW) },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, atomisp_pci_tbl);
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 63774ae2bf71..0693e4532a68 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2732,6 +2732,7 @@
 #define PCI_DEVICE_ID_INTEL_HDA_HSW_3	0x0d0c
 #define PCI_DEVICE_ID_INTEL_HDA_BYT	0x0f04
 #define PCI_DEVICE_ID_INTEL_SST_BYT	0x0f28
+#define PCI_DEVICE_ID_INTEL_ISP_BYT	0x0f38
 #define PCI_DEVICE_ID_INTEL_8257X_SOL	0x1062
 #define PCI_DEVICE_ID_INTEL_82573E_SOL	0x1085
 #define PCI_DEVICE_ID_INTEL_82573L_SOL	0x108f
@@ -2787,6 +2788,7 @@
 #define PCI_DEVICE_ID_INTEL_VMD_201D	0x201d
 #define PCI_DEVICE_ID_INTEL_HDA_BSW	0x2284
 #define PCI_DEVICE_ID_INTEL_SST_BSW	0x22a8
+#define PCI_DEVICE_ID_INTEL_ISP_BSW	0x22b8
 #define PCI_DEVICE_ID_INTEL_DH89XXCC_LPC_MIN	0x2310
 #define PCI_DEVICE_ID_INTEL_DH89XXCC_LPC_MAX	0x231f
 #define PCI_DEVICE_ID_INTEL_82801AA_0	0x2410
-- 
2.50.1

