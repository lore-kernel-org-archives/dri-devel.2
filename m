Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3094CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C64710F318;
	Fri, 12 Jun 2026 08:11:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Q64vE8M1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D83910F318;
 Fri, 12 Jun 2026 08:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781251869; x=1812787869;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uEcbUe7HkkYC9HnbXnIP4dRUx6F/+cUUtZhKG2NpgVw=;
 b=Q64vE8M1+9WtjNdjCwmoYOfjHrptuLjTaWpf6IDEID+JEPnUc04A4rd/
 Xa1ztEihTXR/FMd/oVej0P/fHzV/dZqIhjI/43yYsprcBU0T0JTsynIuc
 hQfGwpSQbqjyS8ynohnuib0BDCFu/tiR0AxeRARLVE3oKpr9FonGKFR8Y
 hw/7PkYMiiijOd6BmderYho6u3wuCEJeXD/ycwd4n7kS9YFi6sCfAniW2
 3qOBildniiUFLBqgjnCH0mYGzcw0OP2Xj3TUjyooc9Wq77Ls9AwMWzlnQ
 clqUKFW7PZNh81JZ96SoGSm8IyK9r6aSA05BnRhFb9+26OisrPTEv+/C7 w==;
X-CSE-ConnectionGUID: nbSuhrg2QgOgC+JfHTTghw==
X-CSE-MsgGUID: TAaoM8kdSLK83xrchuXbLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85921429"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="85921429"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 01:11:09 -0700
X-CSE-ConnectionGUID: JEAo/jQDRU+hfXrFiE8e4A==
X-CSE-MsgGUID: GMQqvm2bRTSeGV5hz3aYCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="245667210"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa006.jf.intel.com with ESMTP; 12 Jun 2026 01:11:04 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v8 5/6] drm/xe: Suppress Surprise Link Down on device
Date: Fri, 12 Jun 2026 13:37:28 +0530
Message-ID: <20260612080722.26726-13-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612080722.26726-8-mallesh.koujalagi@intel.com>
References: <20260612080722.26726-8-mallesh.koujalagi@intel.com>
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

PUNIT errors can only be recovered using a power-cycle. Xe KMD
sends a uevent to notify userspace to trigger a power cycle.
On platforms where link drop caused by powering the device off and
back on is reported by hardware as a Surprise Link Down (SLD), which
AER then escalates as an Uncorrectable Fatal Error. That error fires
before the device finishes coming back up and defeats the
very recovery we are attempting.

To keep the expected, recovery-induced link drop from being raised as
a fatal AER event, mask the Surprise Link Down bit
(PCI_ERR_UNC_SURPDN) in the upstream port's AER Uncorrectable Error
Mask register before punit_error_handler() requests the cold reset.

Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
v6:
- Expand commit message to explain why SUR_DN is masked. (Raag/Riana)
- Check Slot Implemented bit before reading Slot Capabilities, per
  PCIe spec. (Riana)
- Add debug log.

v7:
- Handle surprise link down event properly. (Aravind/Riana)
- Update commit message. (Riana)
- Correct log message.

v8:
- Use find_usp_dev() in punit_error_handler() function.
---
 drivers/gpu/drm/xe/xe_ras.c | 65 ++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 93a56a0269f1..15c2fa0d323a 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -209,8 +209,57 @@ static enum xe_ras_recovery_action handle_core_compute_errors(struct xe_ras_erro
 	return XE_RAS_RECOVERY_ACTION_RECOVERED;
 }
 
+static struct pci_dev *find_usp_dev(struct pci_dev *pdev)
+{
+	struct pci_dev *vsp;
+
+	/*
+	 * Device Hierarchy:
+	 *
+	 * Upstream Switch Port (USP) --> Virtual Switch Port (VSP) --> SGunit (GPU endpoint)
+	 */
+	vsp = pci_upstream_bridge(pdev);
+	if (!vsp)
+		return NULL;
+
+	return pci_upstream_bridge(vsp);
+}
+
+#ifdef CONFIG_PCIEAER
+static void pcie_suppress_surprise_link_down(struct pci_dev *usp)
+{
+	u32 aer_uncorr_mask;
+	u16 aer_cap;
+
+	aer_cap = usp->aer_cap;
+	if (!aer_cap) {
+		dev_dbg(&usp->dev,
+			"AER capability not present\n");
+		return;
+	}
+
+	pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, &aer_uncorr_mask);
+	aer_uncorr_mask |= PCI_ERR_UNC_SURPDN;
+	pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, aer_uncorr_mask);
+	dev_dbg(&usp->dev, "Surprise Link Down masked for cold reset\n");
+}
+#endif /* CONFIG_PCIEAER */
+
 static void punit_error_handler(struct xe_device *xe)
 {
+#ifdef CONFIG_PCIEAER
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
+	struct pci_dev *usp;
+
+	/*
+	 * Cold reset power-cycles the slot, dropping the PCIe link. The
+	 * slot triggers a spurious Surprise Link Down AER event on the USP.
+	 */
+	usp = find_usp_dev(pdev);
+
+	if (usp)
+		pcie_suppress_surprise_link_down(usp);
+#endif
 	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
 	xe_device_declare_wedged(xe);
 }
@@ -503,22 +552,6 @@ enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
 	return XE_RAS_RECOVERY_ACTION_RESET;
 }
 
-static struct pci_dev *find_usp_dev(struct pci_dev *pdev)
-{
-	struct pci_dev *vsp;
-
-	/*
-	 * Device Hierarchy:
-	 *
-	 * Upstream Switch Port (USP) --> Virtual Switch Port (VSP) --> SGunit (GPU endpoint)
-	 */
-	vsp = pci_upstream_bridge(pdev);
-	if (!vsp)
-		return NULL;
-
-	return pci_upstream_bridge(vsp);
-}
-
 static void aer_unmask_and_downgrade_internal_error(struct xe_device *xe)
 {
 	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
-- 
2.34.1

