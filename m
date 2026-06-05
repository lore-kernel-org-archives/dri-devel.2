Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8041FCD6E79
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 12:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2D1B89A1F;
	Fri,  5 Jun 2026 12:29:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CbsLpwgc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 691B7112B18;
 Fri,  5 Jun 2026 12:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780662571; x=1812198571;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qERx+axThIb2cQ7YFpI1EyHYO1mMDL0oSOVOIPsHtdg=;
 b=CbsLpwgcE9XGGist5LFcEG89zE6yTkmEKlSDYGn/ULlfvjyLKJgImhgg
 ZWM3VSMKoMtB/Kz5dfBZ6RL3ybnoLBGc3drRXbnk3wXcGIeP+6AlNClHN
 H01MgfjxBioG7z2ylJg7JTATNN1a0LZNw/pH6hAnmsKXJFTW3yR023t4S
 iAG83M9Yrpzmr9oAIp+9HpP0uBYRwb8e2laVaVeIZG4Un/pt2doTRYTai
 b7G8SrONTC9EtL4NTYvnSjSbwdobuZGP5e/bekeqNvMj9rTQnmYvSyhbl
 19LcXQqYv0DEA0M54Dv0aOk/uSmmUekyWAAfxpRicOyfIZsh2wq/FunjQ w==;
X-CSE-ConnectionGUID: t3yMtlQ/SXikZBF8rVaESw==
X-CSE-MsgGUID: pyrZTwswQdK7fJwu51TWHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81527090"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="81527090"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 05:29:31 -0700
X-CSE-ConnectionGUID: UjPY4VITSfmR2ArYljvm0Q==
X-CSE-MsgGUID: kSOGYvkpQPisJwhvzHhO8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="240383706"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa006.fm.intel.com with ESMTP; 05 Jun 2026 05:29:27 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v7 5/6] drm/xe: Suppress Surprise Link Down on device
Date: Fri,  5 Jun 2026 17:55:49 +0530
Message-ID: <20260605122544.1021695-13-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605122544.1021695-8-mallesh.koujalagi@intel.com>
References: <20260605122544.1021695-8-mallesh.koujalagi@intel.com>
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
- Handle suprise link down event properly. (Aravind/Riana)
- Update commit message. (Riana)
- Corret log message.
---
 drivers/gpu/drm/xe/xe_ras.c | 38 +++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 9a90a7118e89..acdedf403649 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -209,8 +209,46 @@ static enum xe_ras_recovery_action handle_core_compute_errors(struct xe_ras_erro
 	return XE_RAS_RECOVERY_ACTION_RECOVERED;
 }
 
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
+	struct pci_dev *vsp, *usp;
+
+	/*
+	 * Device Hierarchy:
+	 *
+	 * Root Port --> Upstream Switch Port (USP) --> Virtual Switch Port (VSP) --> SGunit
+	 *
+	 * Cold reset power-cycles the slot, dropping the PCIe link. The
+	 * slot triggers a spurious Surprise Link Down AER event on the USP.
+	 */
+	vsp = pci_upstream_bridge(pdev);
+	usp = vsp ? pci_upstream_bridge(vsp) : NULL;
+
+	if (usp)
+		pcie_suppress_surprise_link_down(usp);
+#endif
 	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
 	xe_device_declare_wedged(xe);
 }
-- 
2.34.1

