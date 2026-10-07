Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B58ACA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80CDA10E60A;
	Wed,  7 Oct 2026 16:19:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hxpoQGKz";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FFD310E60A
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 16:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791389945; x=1822925945;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TlhZd+Ha4wr09+5yECc2qPRaEBj99E1h8ZaNYFuvvWo=;
 b=hxpoQGKzQaotJAQtbo4Qonh9pZZTm10q/emVY7jabufJWCdlfM20kFnL
 m+BJWsfEjICIP9MxoNR5Iv8ROYucQnXS7i102L/mcjfmQt0fX7IAbIu8Z
 AI6BSvJdUvSyqJs8PraKoTIxiDBy7wy3XvAX3RHXNCWf+1G4+7O6po4L3
 daBviB+XZBkmUmwda0IrMpLFNA0jkorApc1/l4QE+mytb+vAAkHmsr7SV
 MsWf9FJZjT6U8sH1y9TVX6omnw7idLc788ssW26raXRBUmY2BFBywlSkS
 jt69b0bbJeuTwOXaz7aC+1uV0MsG5raMYQaKFqP16U6Togyw/Vk3RHqed A==;
X-CSE-ConnectionGUID: EhPxCxzBRzykbgVbbP8W4g==
X-CSE-MsgGUID: nLeXlz9mTpmNV32AueqRvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="39767"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="39767"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 09:19:04 -0700
X-CSE-ConnectionGUID: 8pCH8h0tRyOrpWycpMbvTA==
X-CSE-MsgGUID: lD65SaJpRSanqzgeFJnF2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="275268632"
Received: from akacprow-dev3.igk.intel.com ([10.91.220.47])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 09:19:02 -0700
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Subject: [PATCH v2] accel/ivpu: Improve IVPU_TEST_MODE_FW_TEST handling
Date: Wed,  7 Oct 2026 18:13:23 +0200
Message-ID: <20261007161323.2737682-1-andrzej.kacprowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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

In IVPU_TEST_MODE_FW_TEST mode the driver triggers a firmware boot but
does not wait for boot completion. Because it never waits for the boot
to finish, it cannot send a message and expect a response from the
firmware.

Exit ivpu_boot() early in this mode, bypassing ivpu_hw_sched_init() and
the rest of the post-boot initialization. ivpu_hw_sched_init() was
sending a message that timed out and failed the boot sequence.

Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 8c1c87e69f91..538179dcd316 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -485,6 +485,9 @@ int ivpu_boot(struct ivpu_device *vdev)
 	ivpu_ipc_enable(vdev);
 
 	if (!ivpu_fw_is_warm_boot(vdev)) {
+		if (ivpu_test_mode & IVPU_TEST_MODE_FW_TEST)
+			return 0;
+
 		ret = ivpu_pm_dct_init(vdev);
 		if (ret)
 			goto err_disable_ipc;
-- 
2.43.0

