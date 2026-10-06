Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC58CA6002
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 05:40:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A34C10E093;
	Tue,  6 Oct 2026 05:40:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Vn37lnp2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5344810E030;
 Tue,  6 Oct 2026 05:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791265216; x=1822801216;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=LDj7dUSyBwhHjEEdlxV1nwl8/S1LnLk2ncMdqYP/LnY=;
 b=Vn37lnp2D3AlqwQnzlH4aI3tNFfkxuB5yj2VkG4UFG0KWmxO3J2DrkWm
 yQuNMM2odiP4qu/YMvEDCCW34tPPMte92X1ChexObCzII7t7jAcZMKnJd
 gAVGXy2vUeoQUc2WBfRwvLLD7pgkmZBNhyXcjR0LA/0/ncq2fy6NYmtSW
 R7VNJWjhOY7TSfIUI4IcR2RtzDPGs2ZbTWyqE2Saa9GlkirQ77j3H90ip
 sYaPA+X4qc8lvtRjNhs8HyMi5xsHM/cYLsnbDxXHb4Ejm8+SQQHUXIKad
 jw9Q2xZVqxX2bCA0ysdByRAh4tbxu1+lTSlLRwukBSw6O+xWDmBmpcgSR w==;
X-CSE-ConnectionGUID: 7yg10b+HRE+PShAizpj+/g==
X-CSE-MsgGUID: g191H6oDQBmsQIm93dvUPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="109434279"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="109434279"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 22:40:16 -0700
X-CSE-ConnectionGUID: 1EIPOtKrSJO3bMNNmzJ2ug==
X-CSE-MsgGUID: 89LnyumfTyqe08rZaXcE7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="285160492"
Received: from pranay-x299-aorus-gaming-3-pro.iind.intel.com ([10.223.74.54])
 by fmviesa005-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 22:40:14 -0700
From: Pranay Samala <pranay.samala@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: chaitanya.kumar.borah@intel.com, sameer.lattannavar@intel.com,
 pranay.samala@intel.com
Subject: [PATCH v2 0/2] Expose HDR status in debugfs
Date: Tue,  6 Oct 2026 11:10:02 +0530
Message-ID: <20261006054004.285744-1-pranay.samala@intel.com>
X-Mailer: git-send-email 2.53.0
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

i915_display_info currently doesn't show whether HDR is active on a
connector. This series adds per-connector HDR details in three parts:
sink capability (from the EDID), whether userspace has set
HDR_OUTPUT_METADATA, and whether the driver has actually enabled HDR
output.

Patch 1 adds a small hdmi_eotf_get_name() helper to video/hdmi so the
EOTF can be printed by name. Patch 2 adds the debugfs output.

v2:
- Move the EOTF name helper to the common hdmi code (Jani)
- Use drm_printer for indentation instead of manual tabs (Jani)
- Treat any non-SDR EOTF as HDR capable
- Print the EDID luminance only when present, in nits
- Add units to the HDR output luminance values

Pranay Samala (2):
  video/hdmi: Add hdmi_eotf_get_name()
  drm/i915/debugfs: Add HDR status to i915_display_info

 .../drm/i915/display/intel_display_debugfs.c  | 90 +++++++++++++++++++
 drivers/video/hdmi.c                          | 23 +++++
 include/linux/hdmi.h                          |  2 +
 3 files changed, 115 insertions(+)

-- 
2.53.0

