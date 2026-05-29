Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E71CD6E43
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 11:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 319B410FDFB;
	Fri, 29 May 2026 11:59:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cdNP1OLm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30FBD10FDF7
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 11:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780055946; x=1811591946;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=HHUIRMWGDIsqL9kQs+dk2T94LYVQaVJ3tsM6Xq18TxY=;
 b=cdNP1OLmC86f2izVRNHKSM8y5/kchhVEw7lNWu5h0YSLFYZPPPjflSvk
 Xo8RvPR6BMaf12O1CA7syb19dVwLr/YkXlNUdQmwG1TKvtv4JDSUdE2iJ
 IlejvWyGvPuUqmVVt9IwDtCDr8cINg2XY4m3l+SE3UUCv0GgalA8TFKud
 pX9O/2BvcngoEC/sbz7TFovxBxc0OO1b1MQuNHesWEwBaPlpMPyg1I5Hp
 sZj2mG8Yfyi0wG2u04H4bJYqJF0IogA+WaqESMwESw7Ni4Zb2kqrKwmOB
 JDSILHDKK9sIZyKRSJVEwgDoUk/xbQRIjtz3aDtd7GIFT+kFA1IkmhRIa w==;
X-CSE-ConnectionGUID: 7htad/dEQmquj4qVCjqyzA==
X-CSE-MsgGUID: FuuXrCE+TPmeX0w+uJsVCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80935257"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="80935257"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 04:59:06 -0700
X-CSE-ConnectionGUID: Jcl0HK4SSwmVhBT8VpUgoQ==
X-CSE-MsgGUID: 4sl67yWJTPKr9zzQS4ratg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="241788413"
Received: from akacprow-dev3.igk.intel.com ([10.91.220.47])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 04:59:04 -0700
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 karol.wachowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 stable@vger.kernel.org
Subject: [PATCH] accel/ivpu: Fix signed integer truncation in IPC receive
Date: Fri, 29 May 2026 13:54:53 +0200
Message-ID: <20260529115453.132291-1-andrzej.kacprowski@linux.intel.com>
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

Fix potential buffer overflow where firmware-supplied data_size is cast
to signed int before being used in min_t(). Large unsigned values
(>= 0x80000000) become negative, causing unsigned wraparound and
oversized memcpy operations that can overflow the stack buffer.

Change min_t(int, ...) to min_t(u32, ...) to ensure large values are
properly clamped instead of becoming negative.

Fixes: 3b434a3445ff ("accel/ivpu: Use threaded IRQ to handle JOB done messages")
Cc: <stable@vger.kernel.org> # v6.18+
Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
index f47df092bb0d..9980a7898bed 100644
--- a/drivers/accel/ivpu/ivpu_ipc.c
+++ b/drivers/accel/ivpu/ivpu_ipc.c
@@ -276,7 +276,7 @@ int ivpu_ipc_receive(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
 	if (ipc_buf)
 		memcpy(ipc_buf, rx_msg->ipc_hdr, sizeof(*ipc_buf));
 	if (rx_msg->jsm_msg) {
-		u32 size = min_t(int, rx_msg->ipc_hdr->data_size, sizeof(*jsm_msg));
+		u32 size = min_t(u32, rx_msg->ipc_hdr->data_size, sizeof(*jsm_msg));
 
 		if (rx_msg->jsm_msg->result != VPU_JSM_STATUS_SUCCESS) {
 			ivpu_err(vdev, "IPC resp result error: %d\n", rx_msg->jsm_msg->result);
-- 
2.43.0

