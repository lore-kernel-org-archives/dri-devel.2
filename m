Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434B4CA600E
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B67710E4E2;
	Thu,  8 Oct 2026 10:05:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PJ6J3fh8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CBC910E4E2
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 10:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791453955; x=1822989955;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=k4tN/Tz8ZiO/2LesZGnRqTWLdpJ9L1dEZgdOLuGnmZI=;
 b=PJ6J3fh8QBPGXJjuxTghnZ6CbXqorTUaC3WmOKdo8V0b6GCbv2Tm9H0q
 s1HZlcum/PxIaSgrcDIR0YvPHe3RkN9E6Do9vhCdku8aexVAL59x+L2EE
 Eeo5+9o39hvKx6ltqHdcx7eugp2MYLGp5yFhMWrtX4TIbv2C9bFQOIMdU
 oSZVfmBH/ykasyMTd0G4DApRd6YxP6vO1beESBNq0i/UDJLsZ/Wk6/KbW
 vCz7I17WeQFegpzaCf5c0TQqMbWDuUtXRGmETwI4b3/LGdohqHYMuxpHr
 LPQ5WlmV5HnI+9TYLDbdGl+36+V2UVHPSl5ktyhdKaFHvuRBjZ0F2Xypg A==;
X-CSE-ConnectionGUID: 0GgLrSncStyWYdk87st5JA==
X-CSE-MsgGUID: V8VLfDiYTjWB+wb/23VxIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="241855"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="241855"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 03:05:54 -0700
X-CSE-ConnectionGUID: hPuix8RuT2mfXvCUgk8Vww==
X-CSE-MsgGUID: p2q5QWxTRwauk0085/qqrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="7815"
Received: from akacprow-dev3.igk.intel.com ([10.91.220.47])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 03:05:53 -0700
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Subject: [PATCH v3] accel/ivpu: Improve IVPU_TEST_MODE_FW_TEST handling
Date: Thu,  8 Oct 2026 12:00:13 +0200
Message-ID: <20261008100013.3006983-1-andrzej.kacprowski@linux.intel.com>
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

In FW_TEST mode, boot the firmware but skip the ready wait and all
subsequent firmware communication. The firmware test reports its
results through the firmware log.

Disable driver timeouts in this mode so timeout handling does not
interrupt the firmware test.

Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_drv.c | 3 +++
 drivers/accel/ivpu/ivpu_hw.c  | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 6b71edf566e7..8c3fb0f01a31 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -539,6 +539,9 @@ int ivpu_boot(struct ivpu_device *vdev)
 	ivpu_hw_irq_enable(vdev);
 	ivpu_ipc_enable(vdev);
 
+	if (ivpu_test_mode & IVPU_TEST_MODE_FW_TEST)
+		return 0;
+
 	if (!ivpu_fw_is_warm_boot(vdev)) {
 		ret = ivpu_pm_dct_init(vdev);
 		if (ret)
diff --git a/drivers/accel/ivpu/ivpu_hw.c b/drivers/accel/ivpu/ivpu_hw.c
index 59a5de8d9270..8b63140e3160 100644
--- a/drivers/accel/ivpu/ivpu_hw.c
+++ b/drivers/accel/ivpu/ivpu_hw.c
@@ -94,7 +94,7 @@ static void wa_init(struct ivpu_device *vdev)
 
 static void timeouts_init(struct ivpu_device *vdev)
 {
-	if (ivpu_test_mode & IVPU_TEST_MODE_DISABLE_TIMEOUTS) {
+	if (ivpu_test_mode & (IVPU_TEST_MODE_DISABLE_TIMEOUTS | IVPU_TEST_MODE_FW_TEST)) {
 		/* in milliseconds, negative value disables the timeout */
 		vdev->timeout.boot = -1;
 		vdev->timeout.jsm = -1;
-- 
2.43.0

