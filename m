Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C993BCD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 16:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4346411358A;
	Mon,  1 Jun 2026 16:21:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CMDWm3Cs";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74CF411358A
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 16:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780330864; x=1811866864;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AKMN0szB49azcSqo4uiqRatTW6387T8GYKIDqVqi7dw=;
 b=CMDWm3Cssb+8+7Peg4uY3aFKxT6TiHyg2q4wFeJeMs38qSNlM5FxZxad
 ZKzx15IMt4WtDx+XPcGYPjkvxc7+eL+ISr8qhF+mwYq8CiICOBflOVu8S
 AVt/XUA/1lr5dBY0UUzRRiJ2KawXPAYeJM/hnfCuleBktJw3FWM7R+Wzh
 VDOWvqTE02X8Ys1ng6xOjDRStmGtgwbN0qr/mO/7B4eE7NUxo4MwQbc6h
 /23WZ71a2lGIhw6I6UVBArQbVAB7p8JAmpsl0jA3R8muplRdf4wemnhWk
 hjZS061CgmOcsdbazQTwm4xVzlZUdKsfsgeD3BUAG2C0IVaKwwXyKmGg0 g==;
X-CSE-ConnectionGUID: aFWqi4ksSDaWVOjlsxVRhA==
X-CSE-MsgGUID: tI96pLKbTTy3bkrdrRZ6ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="91780464"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="91780464"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 09:20:59 -0700
X-CSE-ConnectionGUID: dmjn0uI7QVyRYIo2oF9DMg==
X-CSE-MsgGUID: Fqd8yWQNQP2vlcwBJV5LfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="239453322"
Received: from akacprow-dev3.igk.intel.com ([10.91.220.47])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 09:20:57 -0700
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 karol.wachowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 david.laight.linux@gmail.com,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 stable@vger.kernel.org
Subject: [PATCH v2] accel/ivpu: Fix signed integer truncation in IPC receive
Date: Mon,  1 Jun 2026 18:16:43 +0200
Message-ID: <20260601161643.229342-1-andrzej.kacprowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b464b589-2d28-4617-baf0-eefbe14e170a@linux.intel.com>
References: <b464b589-2d28-4617-baf0-eefbe14e170a@linux.intel.com>
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

Change min_t(int, ...) to min() as both values are unsigned and can be
handled by min() without explicit cast.

Fixes: 3b434a3445ff ("accel/ivpu: Use threaded IRQ to handle JOB done messages")
Cc: <stable@vger.kernel.org> # v6.12+
Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
---
Changes in v2:
- Replaced min_t() with min()

 drivers/accel/ivpu/ivpu_ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
index f47df092bb0d..9347f05a2b79 100644
--- a/drivers/accel/ivpu/ivpu_ipc.c
+++ b/drivers/accel/ivpu/ivpu_ipc.c
@@ -276,7 +276,7 @@ int ivpu_ipc_receive(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
 	if (ipc_buf)
 		memcpy(ipc_buf, rx_msg->ipc_hdr, sizeof(*ipc_buf));
 	if (rx_msg->jsm_msg) {
-		u32 size = min_t(int, rx_msg->ipc_hdr->data_size, sizeof(*jsm_msg));
+		u32 size = min(rx_msg->ipc_hdr->data_size, sizeof(*jsm_msg));
 
 		if (rx_msg->jsm_msg->result != VPU_JSM_STATUS_SUCCESS) {
 			ivpu_err(vdev, "IPC resp result error: %d\n", rx_msg->jsm_msg->result);
-- 
2.43.0

