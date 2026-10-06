Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53848CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 09:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C9F610E2ED;
	Tue,  6 Oct 2026 09:37:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MF7/xxkA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A96010E2ED
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 09:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791279471; x=1822815471;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DWP+y/UGO/8j+tdHXupyEexHfUu++uH7BPJlXwYsl1w=;
 b=MF7/xxkA4qk5THKBIqpMmhSoD35RAhgS6WywyLIgQur/OHnMSI+FsA3X
 s4bedFA3d6YK5k0ZCoOUt9rHt3scbx88dFqqIAchE52TzvgmttN1hw+LX
 600Vbec4QyCt3ljhBs6iZH2h5YEal4NETo5oU9lH/GondVhmT7l+CWDZm
 Q6RrmiQ5PqqdcavC/CwsPtijdd1lNms1R++TZW2WtKmSvM7BX1wkirgcL
 QR89ELVb7R9J0OHDzDdIKL0jAYCjcqv4aH3sRECZGa2ThqsHtXSn9gN3q
 qBlu+0J0bA9HUybOdlCH8ifmVIbmCD+aaSk8ptC8tMEMFV5q1ljTyWEIv w==;
X-CSE-ConnectionGUID: irJwcejBReiD3SgbzlXx0w==
X-CSE-MsgGUID: qMNIwxbJRrGpXTYUWhOnTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="13171"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="13171"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:37:50 -0700
X-CSE-ConnectionGUID: SAjc7NYATOWWNCTl9T33cg==
X-CSE-MsgGUID: ma6bHeWrSveoP/ZK2FHFIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="303375902"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:37:49 -0700
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH] accel/ivpu: Limit DMA address width to 42 bits on 40XX and
 later
Date: Tue,  6 Oct 2026 11:37:40 +0200
Message-ID: <20261006093740.2304835-1-karol.wachowski@linux.intel.com>
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

On 40XX and later the NPU does not treat address bits 42 and above as
part of the memory address, as the hardware uses them internally, but
ivpu sets a 48-bit DMA mask for these generations.

In practice the IOMMU capabilities already limit the DMA addresses to
42 bits, so this does not fix an observed problem. Set the DMA mask to
42 bits anyway, so the driver does not depend on the IOMMU
configuration to stay within the range the NPU can address. 37XX keeps
its 38-bit mask.

Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index ab1a9448c2cc..6b71edf566e7 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -709,7 +709,7 @@ static int ivpu_pci_init(struct ivpu_device *vdev)
 	}
 
 	if (ivpu_hw_ip_gen(vdev) >= IVPU_HW_IP_40XX)
-		dma_bits = 48;
+		dma_bits = 42;
 	else
 		dma_bits = 38;
 
-- 
2.43.0

