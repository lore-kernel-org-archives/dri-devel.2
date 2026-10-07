Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01DCCA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2905F10E47A;
	Wed,  7 Oct 2026 10:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WbNvu+qu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C73C910E47A
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 10:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791368995; x=1822904995;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=yTGhHIpqora+k0ZrnMAC8B7HQuKACXOdpBDrK7ZAzp0=;
 b=WbNvu+qufMQnRSFRmdolMlXHdtQgI/yY5OC6i/2eXBxXIyUyXMry+fKp
 OxGwsYwKPqkc850fU04NoOdP/gQm/cONglKB/yu6eWPO2FtLf8+1hxvcV
 wXVoSjzejtXxpXMT4a3AYSiltKVOlxxZF1A4wpPgYvRGTVp3+oEglQLRs
 Np5Uj+CZrmumDE7kzJlPsXYIbhJ8X9EQF7+uUwpKQMZcB0fJjA5R8Pm0a
 M1XR6hjF1z4JGeFFfBeOpM1pZpvH9gFpQXT2OyE4nOOBMxKUr2yRAxXMY
 yFjrtt/Ywytt9i6HpBCmb88U5u6BYg9vVKNBJyegCegt5+kMM3+N8JYOX A==;
X-CSE-ConnectionGUID: npzgcvNlQHWGbYcBNEfR9g==
X-CSE-MsgGUID: 08Z7cdCtT+21WQBS9Pfm1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="21031"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="21031"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 03:29:54 -0700
X-CSE-ConnectionGUID: CjQAv5YcTTO78CrKr0puXw==
X-CSE-MsgGUID: z1YHd37YTGuATvp3/FHIVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="26271"
Received: from akacprow-dev3.igk.intel.com ([10.91.220.47])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 03:29:53 -0700
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com,
 dawid.osuchowski@linux.intel.com,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Subject: [PATCH] accel/ivpu: Improve IVPU_TEST_MODE_FW_TEST handling
Date: Wed,  7 Oct 2026 12:24:14 +0200
Message-ID: <20261007102414.2661045-1-andrzej.kacprowski@linux.intel.com>
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

When driver is operating in IVPU_TEST_MODE_FW_TEST debug mode
it should boot the firmware, but skip communication with
the firmware. There is no need to enable interrupts or send messages.
The output of the firmware test will be available in the
firmware log.

Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 8c1c87e69f91..186e6fe2a6fa 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -408,9 +408,6 @@ static int ivpu_wait_for_ready(struct ivpu_device *vdev)
 	unsigned long timeout;
 	int ret;
 
-	if (ivpu_test_mode & IVPU_TEST_MODE_FW_TEST)
-		return 0;
-
 	ivpu_ipc_consumer_add(vdev, &cons, IVPU_IPC_CHAN_BOOT_MSG, NULL);
 
 	timeout = jiffies + msecs_to_jiffies(vdev->timeout.boot);
@@ -474,6 +471,9 @@ int ivpu_boot(struct ivpu_device *vdev)
 		return ret;
 	}
 
+	if (ivpu_test_mode & IVPU_TEST_MODE_FW_TEST)
+		return 0;
+
 	ret = ivpu_wait_for_ready(vdev);
 	if (ret) {
 		ivpu_err(vdev, "Failed to boot the firmware: %d\n", ret);
-- 
2.43.0

