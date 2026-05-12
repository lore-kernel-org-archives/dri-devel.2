Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A260CCD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 13:29:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FA1D10EAC8;
	Tue, 12 May 2026 13:29:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PReq8hpW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD3CB10EAC8;
 Tue, 12 May 2026 13:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778592591; x=1810128591;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=K7xN87kNxeGauXGYEKVz45xa6GFgVrxbWkxUfvc7s8w=;
 b=PReq8hpWtpsG3aUxVhCv3duLgQQJOQV4+pX65SuZZm1K6zueu//XPKfD
 9Yj3uVo4YJeysb1NXhEaSU3jJv7X1e1MPprDakq8h/p9wrN9Ql9DMOtMp
 Y6NMroFw7xfZ0X59/atDHiDg7QWC3LjPLau0+qaCfp7sE/FHQMgaYu4bb
 FSxAlaUrueuYa1b74I41Tldro/ouUXnOeHHIpXuhbjGOHagjkMp7DRRHu
 5k7gOg+9SDIJZeuxvg5mZ42BlFf0/CZ9CFK6YjpJp/lVWD8PLNtQgl4UM
 7iyYWPbWzUDztBm3jFxHfccfHcDbHKPGYeJ7wsb1ZFnYtI1qoQ4VAQkF/ Q==;
X-CSE-ConnectionGUID: TfBjwBfCTL2mfW4JKYCckA==
X-CSE-MsgGUID: 8SEad03nQbixc1ArbAFdVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="102164726"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="102164726"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 06:29:51 -0700
X-CSE-ConnectionGUID: R9c+HuXDQgiUmw/bUh1qgQ==
X-CSE-MsgGUID: XJ61F77nRlahlUUFiRZVtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="237855931"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa009.jf.intel.com with ESMTP; 12 May 2026 06:29:47 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v5 5/5] drm/xe: Suppress Surprise Link Down on non-hotplug
 device
Date: Tue, 12 May 2026 18:56:20 +0530
Message-ID: <20260512132614.1793083-12-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512132614.1793083-7-mallesh.koujalagi@intel.com>
References: <20260512132614.1793083-7-mallesh.koujalagi@intel.com>
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

If the slot is not hotplug capable, pcie_suppress_surprise_link_down()
masks the Surprise Link Down bit (PCI_ERR_UNC_SURPDN) in the USP's AER
Uncorrectable Error Mask register before punit_error_handler()
triggers the cold reset.

Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
 drivers/gpu/drm/xe/xe_ras.c | 51 +++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 604470565bf3..67b4f25370c9 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -224,8 +224,59 @@ static enum xe_ras_recovery_action handle_core_compute_errors(struct xe_device *
 	return XE_RAS_RECOVERY_ACTION_RECOVERED;
 }
 
+#ifdef CONFIG_PCIEAER
+static bool pcie_slot_is_hotplug_capable(struct pci_dev *usp)
+{
+	struct pci_dev *root_port = pci_upstream_bridge(usp);
+	u32 sltcap;
+
+	if (!root_port)
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
+	if (!aer_cap)
+		return;
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

