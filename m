Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D0DCD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 12:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10B9910FE27;
	Fri, 29 May 2026 12:13:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CXgRakhZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9D2410FE27
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 12:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780056785; x=1811592785;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4A/c8Oy9znqnw/CbgfQDRXvRioPD8P0qyZunjaa9+VQ=;
 b=CXgRakhZYAMGeLMkaCMjNouCjboMkhXIUcD/jNGoBk72YeXMArfu4RFO
 fEz69Q26CiBm3PUczG3oJe9vzsQFb5hiMDg8iBqM8ijuVgDbvQSwRNVU+
 uDmdP8N4M4Qji7Ot+ntaNLazkDPjR0SdS15TCc5epAnJFnxejNTsYsaS2
 AEbF6rtBXDROFFVEu/yuX7EO1m/CWZB6KI22VOnPMXvZZs7Ua4jAuYYpl
 kRGD7Z2gWgUxJM5ljraRMQ4x0H5PnF0dTQLEHwiMtHQEtV65kNyHLjrTL
 WsNIu5SdNmmUxXGzIhaRqrnGXRPBW/OV/TO8n6p8awcewxGlEVaPfuBcd g==;
X-CSE-ConnectionGUID: qVaWVj3ySXGKPCxCgB6nfg==
X-CSE-MsgGUID: 35kWVe7vQs++80d8WxUwhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="91216969"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="91216969"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 05:13:05 -0700
X-CSE-ConnectionGUID: WrXtacOESniLFFbzwLkLvA==
X-CSE-MsgGUID: 85olzGkhQlao+snk3CeScA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="238643413"
Received: from akacprow-dev3.igk.intel.com ([10.91.220.47])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 05:13:03 -0700
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 karol.wachowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 stable@vger.kernel.org
Subject: [PATCH] accel/ivpu: Add bounds check for firmware runtime memory
Date: Fri, 29 May 2026 14:08:53 +0200
Message-ID: <20260529120853.135876-1-andrzej.kacprowski@linux.intel.com>
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

Validate that the firmware runtime memory specified in the image
header is properly aligned and sized to hold the firmware image.
This prevents errors during memory allocation and image transfer.

Fixes: 2007e210b6a1 ("accel/ivpu: Split FW runtime and global memory buffers")
Cc: <stable@vger.kernel.org> # v7.0+
Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_fw.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
index 107f8ad31050..33c50779c06b 100644
--- a/drivers/accel/ivpu/ivpu_fw.c
+++ b/drivers/accel/ivpu/ivpu_fw.c
@@ -259,6 +259,22 @@ static int ivpu_fw_parse(struct ivpu_device *vdev)
 		return -EINVAL;
 	}
 
+	if (!PAGE_ALIGNED(runtime_addr)) {
+		ivpu_err(vdev, "Runtime address 0x%llx not page aligned\n", runtime_addr);
+		return -EINVAL;
+	}
+
+	if (!PAGE_ALIGNED(runtime_size)) {
+		ivpu_err(vdev, "Runtime size %llu not page aligned\n", runtime_size);
+		return -EINVAL;
+	}
+
+	if (runtime_size < image_size) {
+		ivpu_err(vdev, "Runtime size too small: %llu, image size: %llu\n",
+			 runtime_size, image_size);
+		return -EINVAL;
+	}
+
 	if (!ivpu_is_within_range(image_load_addr, image_size, &vdev->hw->ranges.runtime)) {
 		ivpu_err(vdev, "Invalid firmware load address: 0x%llx and size %llu\n",
 			 image_load_addr, image_size);
-- 
2.43.0

