Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E73CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:18:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4201B10E6D5;
	Mon, 22 Jun 2026 13:18:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gel6Qp3c";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2931E10E6D4;
 Mon, 22 Jun 2026 13:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782134333; x=1813670333;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yFBozhfqX5ZdoD8CMQqWK9Ana6PK1RLAtTN8nEmObGI=;
 b=gel6Qp3cjYNBr9QLlvHaqnhgkHxXTdblCDj8oLtUBzX8Xkair/+FqYwp
 NBcdCAl27nLs04dF6xlb3/XSyPftLqRpfDA4W7fi98GG2y0L4ZwezsKz7
 8/nYx5ICCwKlTtFDUIPzom8rcQ4TibPmqFU5S34ssQV4zYjJ0EzeP9G9Y
 YK90hZbMlIGr8IcfilHZ/wtyZz0loRd1aTdkxgEzs9HCeT7scCoDDhlo7
 H0/J3Wxo7Rj64l6WRQVxlQ2E0ZMpG+Ymila3UO+l4TgpYRhu/FvuQN9qq
 IYb+niK9U4B20/8nLFCqn/xCZT9+qZwn14J9yAlSZOwdjR9QH1qtdYn/J A==;
X-CSE-ConnectionGUID: AyEVZxL9SjuPoxrd3aIZxg==
X-CSE-MsgGUID: G+6MFH9JTCGINORvz0oOWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="93458821"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="93458821"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 06:18:53 -0700
X-CSE-ConnectionGUID: KE00tlRkQim/q21D8Z0n9Q==
X-CSE-MsgGUID: t01gsLcVRwG0s6DkqpsbZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="245074771"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa010.fm.intel.com with ESMTP; 22 Jun 2026 06:18:48 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v9 5/6] drm/xe: Suppress Surprise Link Down on device
Date: Mon, 22 Jun 2026 18:45:04 +0530
Message-ID: <20260622131458.144873-13-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622131458.144873-8-mallesh.koujalagi@intel.com>
References: <20260622131458.144873-8-mallesh.koujalagi@intel.com>
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
After the reset finishes, clear the Surprise Down Error Status bit
in the Uncorrectable Error Status register.

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

v9:
- Removed #ifdef CONFIG_PCIEAER. (Riana)
- Used pci_find_ext_capability() instead of usp->aer_cap.
- Clear the PCI_ERR_UNC_SURPDN status bit (W1C) after
  reset complete. (Lukas Wunner)
- Use pci_clear_and_set_config_dword() helper.
---
 drivers/gpu/drm/xe/xe_ras.c | 60 +++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 1eb2bbaccd9b..5a2fee5a1308 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -256,8 +256,37 @@ static struct pci_dev *find_usp_dev(struct pci_dev *pdev)
 	return pci_upstream_bridge(vsp);
 }
 
+static void pcie_suppress_surprise_link_down(struct pci_dev *usp)
+{
+	u16 aer_cap;
+
+	/*
+	 * Cold reset power-cycles the slot, dropping the PCIe link.
+	 * This triggers a spurious Surprise Link Down AER event on the
+	 * Upstream Switch Port (USP). Mask this error to avoid false
+	 * error reporting during recovery.
+	 */
+	aer_cap = pci_find_ext_capability(usp, PCI_EXT_CAP_ID_ERR);
+	if (!aer_cap) {
+		dev_dbg(&usp->dev,
+			"AER capability not present\n");
+		return;
+	}
+
+	pci_clear_and_set_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, 0, PCI_ERR_UNC_SURPDN);
+	dev_dbg(&usp->dev, "Surprise Link Down masked for cold reset\n");
+}
+
 static void punit_error_handler(struct xe_device *xe)
 {
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
+	struct pci_dev *usp;
+
+	usp = find_usp_dev(pdev);
+
+	if (usp)
+		pcie_suppress_surprise_link_down(usp);
+
 	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
 	xe_device_declare_wedged(xe);
 }
@@ -573,7 +602,7 @@ int xe_ras_clear_counter(struct xe_device *xe, u8 severity, u8 component)
 static void aer_unmask_and_downgrade_internal_error(struct xe_device *xe)
 {
 	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
-	u32 aer_uncorr_mask, aer_uncorr_sev, aer_uncorr_status;
+	u32 aer_uncorr_status;
 	struct pci_dev *usp;
 	u16 aer_cap;
 
@@ -595,6 +624,17 @@ static void aer_unmask_and_downgrade_internal_error(struct xe_device *xe)
 	if (aer_uncorr_status & PCI_ERR_UNC_INTN)
 		pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_STATUS, PCI_ERR_UNC_INTN);
 
+	/*
+	 * Even though we masked the Surprise Link Down bit before the reset, the
+	 * USP hardware still records the event in its status register. Since the
+	 * USP itself is never power-cycled, that status bit survives the reset and
+	 * stays set. If we unmask the error below without clearing the status first,
+	 * it will immediately fire as a new AER error and undo the recovery we just
+	 * completed. Write 1 to clear it (W1C) before unmasking.
+	 */
+	if (aer_uncorr_status & PCI_ERR_UNC_SURPDN)
+		pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_STATUS, PCI_ERR_UNC_SURPDN);
+
 	/*
 	 * All errors are steered to USP which is a PCIe AER Compliant device.
 	 * Downgrade all the errors to non-fatal to prevent PCIe bus driver
@@ -604,20 +644,22 @@ static void aer_unmask_and_downgrade_internal_error(struct xe_device *xe)
 	 * The Uncorrectable Error Severity Register has the 'Uncorrectable
 	 * Internal Error Severity' set to fatal by default. Set this to
 	 * non-fatal and unmask the error.
+	 *
+	 * Also restore the Surprise Link Down mask that was set in
+	 * pcie_suppress_surprise_link_down() before the cold reset. The USP is
+	 * never power-cycled, so the mask bit persists and must be cleared here
+	 * to ensure link-down events are reported normally going forward.
 	 */
 
 	/* Initialize Uncorrectable Error Severity Register */
-	pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_SEVER, &aer_uncorr_sev);
-	aer_uncorr_sev &= ~PCI_ERR_UNC_INTN;
-	pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_SEVER, aer_uncorr_sev);
+	pci_clear_and_set_config_dword(usp, aer_cap + PCI_ERR_UNCOR_SEVER, PCI_ERR_UNC_INTN, 0);
 
-	/* Initialize Uncorrectable Error Mask Register */
-	pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, &aer_uncorr_mask);
-	aer_uncorr_mask &= ~PCI_ERR_UNC_INTN;
-	pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, aer_uncorr_mask);
+	/* Unmask Uncorrectable Internal Error and restore Surprise Link Down to unmasked */
+	pci_clear_and_set_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK,
+				       PCI_ERR_UNC_INTN | PCI_ERR_UNC_SURPDN, 0);
 
 	pci_save_state(usp);
-	dev_dbg(&usp->dev, "Uncorrectable Internal Errors downgraded and unmasked\n");
+	dev_dbg(&usp->dev, "AER: INTN downgraded to non-fatal, INTN and SLD unmasked\n");
 }
 
 /**
-- 
2.34.1

