Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AB7CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 11:37:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2418110F035;
	Wed, 20 May 2026 11:37:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="A3/QERJs";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78EFC10F02C;
 Wed, 20 May 2026 11:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779277037; x=1810813037;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=h9lIIGPBRWuvAxRmYbaM1T1DdlyDk967/m4bDWfWYhE=;
 b=A3/QERJsjQTY/zvUB5K+RZCSo6kXbUjt93zk2LJROmYgwuk+XVfPmdWE
 ID6D9ydw4OmWuOsEr2DIO1yv8plH2TOyN8ENn7WWqLvhZ8g9YlBIkHBQq
 EGVkd3Lfa/sdLBWipvkAgcdLDzrsHPqxWtIvijpPrU2iCZ/gjhAOJQFfs
 bVtsUfDVnOqf5ilEx7A7BpPRm70yUq5kEwz/oyxJaqfcw7LgWj7XcWO65
 pXlCHvAsyy/0YFSSabHRJvNWeBj20eegiNvMCeNGcdFgjNyM4Tu2lCTaH
 ImuG21eIaAzOYBG4bKmOQjke791quds35rSLAnm9G/PrTPG3J9/UayL/i A==;
X-CSE-ConnectionGUID: N4YecpxJQ7uWgHTo0Tkz2Q==
X-CSE-MsgGUID: Xt/f2LyoSXWP2Kc4CcLwig==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="84027520"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="84027520"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 04:37:16 -0700
X-CSE-ConnectionGUID: iThzBx/hSZ+tDKm5S+dvgw==
X-CSE-MsgGUID: xGICK5F7SS+fMvt+LD89oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="237153572"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa007.fm.intel.com with ESMTP; 20 May 2026 04:37:12 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v6 5/5] drm/xe: Suppress Surprise Link Down on non-hotplug
 device
Date: Wed, 20 May 2026 17:03:57 +0530
Message-ID: <20260520113351.171119-12-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520113351.171119-7-mallesh.koujalagi@intel.com>
References: <20260520113351.171119-7-mallesh.koujalagi@intel.com>
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

A PUNIT (power management unit) error recovery on GPUs
triggers a power cycle (cold reset). On platforms where
the upstream port is not hotplug capable, the brief link drop
caused by powering the device off and back on is reported
by hardware as a Surprise Link Down (SLD), which AER then
escalates as an Uncorrectable Fatal Error. That error fires
before the device finishes coming back up and defeats the
very recovery we are attempting.

To keep the expected, recovery-induced link drop from being raised as
a fatal AER event, mask the Surprise Link Down bit
(PCI_ERR_UNC_SURPDN) in the upstream port's AER Uncorrectable Error
Mask register before punit_error_handler() requests the cold reset.
The mask is only applied when the slot is not hotplug capable.

Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
v6:
- Expand commit message to explain why SUR_DN is masked. (Raag/Riana)
- Check Slot Implemented bit before reading Slot Capabilities, per
  PCIe spec. (Riana)
- Add debug log.
---
 drivers/gpu/drm/xe/xe_ras.c | 66 +++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 604470565bf3..f1a6d7b23c93 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -224,8 +224,74 @@ static enum xe_ras_recovery_action handle_core_compute_errors(struct xe_device *
 	return XE_RAS_RECOVERY_ACTION_RECOVERED;
 }
 
+#ifdef CONFIG_PCIEAER
+static bool pcie_slot_is_hotplug_capable(struct pci_dev *usp)
+{
+	struct pci_dev *root_port = pci_upstream_bridge(usp);
+	u32 sltcap;
+	u16 flags;
+
+	if (!root_port)
+		return false;
+
+	/*
+	 * Per PCIe spec, the Slot Capabilities register contents are
+	 * undefined unless the Slot Implemented bit in the PCI Express
+	 * Capabilities register is set. Check it before reading SLTCAP.
+	 */
+	if (pcie_capability_read_word(root_port, PCI_EXP_FLAGS, &flags))
+		return false;
+
+	if (!(flags & PCI_EXP_FLAGS_SLOT))
+		return false;
+
+	if (pcie_capability_read_dword(root_port, PCI_EXP_SLTCAP, &sltcap))
+		return false;
+
+	return (sltcap & (PCI_EXP_SLTCAP_HPC | PCI_EXP_SLTCAP_PCP)) ==
+		(PCI_EXP_SLTCAP_HPC | PCI_EXP_SLTCAP_PCP);
+}
+
+static void pcie_suppress_surprise_link_down(struct pci_dev *usp)
+{
+	u32 aer_uncorr_mask;
+	u16 aer_cap;
+
+	aer_cap = usp->aer_cap;
+	if (!aer_cap) {
+		dev_dbg(&usp->dev,
+			"AER capability not present; cannot mask Surprise Link Down for cold reset\n");
+		return;
+	}
+
+	pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, &aer_uncorr_mask);
+	aer_uncorr_mask |= PCI_ERR_UNC_SURPDN;
+	pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, aer_uncorr_mask);
+	dev_dbg(&usp->dev, "Non-hotplug slot: Surprise Link Down masked for cold reset\n");
+}
+#endif /* CONFIG_PCIEAER */
+
 static void punit_error_handler(struct xe_device *xe)
 {
+#ifdef CONFIG_PCIEAER
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
+	struct pci_dev *vsp, *usp;
+
+	/*
+	 * Device Hierarchy:
+	 *
+	 * Root Port --> Upstream Switch Port (USP) --> Virtual Switch Port (VSP) --> SGunit
+	 *
+	 * Cold reset power-cycles the slot, dropping the PCIe link. On a non-hotplug
+	 * slot this triggers a spurious Surprise Link Down AER event on the USP.
+	 * Suppress it if the slot is not hotplug capable.
+	 */
+	vsp = pci_upstream_bridge(pdev);
+	usp = vsp ? pci_upstream_bridge(vsp) : NULL;
+
+	if (usp && !pcie_slot_is_hotplug_capable(usp))
+		pcie_suppress_surprise_link_down(usp);
+#endif
 	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
 	xe_device_declare_wedged(xe);
 }
-- 
2.34.1

