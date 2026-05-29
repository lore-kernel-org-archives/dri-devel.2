Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82879CD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 12:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB3E010FE23;
	Fri, 29 May 2026 12:12:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OauzyPAz";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C466D10FE23
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 12:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780056773; x=1811592773;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JE8LA9juPD4juxz/MBf5J8J9Ac/f41r/b9qVSaNW1ow=;
 b=OauzyPAzO5AHpSEodgDyFwkKsW86sODmAP+rK0Ai7w3K4ZE+OJY8bXYD
 HYMycK6Q3Rn+7B/9Q5DdDB4tWDauWf/iKu0vJqDoaAsPb/W4e59mvAD5Y
 C1wHX3m2e3+CUp9C42bmusi7bpc9THLIomBhDixNTkhbvu+4CWCET+0wV
 nDkyGUYrZU+woAT2sYTISgmYK52JCk87gKqe2ZCP1ZAl5ASs2URwFGThl
 0ECVQVuwzU0mvHY2244ehl8m2gY069wAb9GF+PVRnz5RYVxAW4JmIHgub
 UNCs6RSsKK036pu8yY4shfL5MF55+nuQBk6ryuNMUscmCTtaz1RKB5Eyg w==;
X-CSE-ConnectionGUID: KQfwuSYMRcmO67yx9VvBVg==
X-CSE-MsgGUID: TFMY2n6eT+eJ9JXHYBpQfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="91216945"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="91216945"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 05:12:53 -0700
X-CSE-ConnectionGUID: GONU+tfLSqyGrcb+KMdNIg==
X-CSE-MsgGUID: YbkXHhWWTuaGq6BkQqDhRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="238643348"
Received: from akacprow-dev3.igk.intel.com ([10.91.220.47])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 05:12:51 -0700
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 karol.wachowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 stable@vger.kernel.org
Subject: [PATCH] accel/ivpu: Add buffer overflow check in MS get_info_ioctl
Date: Fri, 29 May 2026 14:08:41 +0200
Message-ID: <20260529120841.135852-1-andrzej.kacprowski@linux.intel.com>
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

Add validation that the info size returned from the metric stream info
query is not exceeded when checked against the allocated buffer size.
If the firmware returns a size larger than the buffer, reject the
operation with -EOVERFLOW instead of proceeding with an incorrect
buffer copy.

Fixes: cdfad4db7756 ("accel/ivpu: Add NPU profiling support")
Cc: <stable@vger.kernel.org> # v6.18+
Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_ms.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_ms.c b/drivers/accel/ivpu/ivpu_ms.c
index be43851f5f32..cd176e77b9a0 100644
--- a/drivers/accel/ivpu/ivpu_ms.c
+++ b/drivers/accel/ivpu/ivpu_ms.c
@@ -291,6 +291,13 @@ int ivpu_ms_get_info_ioctl(struct drm_device *dev, void *data, struct drm_file *
 	if (ret)
 		goto unlock;
 
+	if (info_size > ivpu_bo_size(bo)) {
+		ivpu_warn_ratelimited(vdev, "MS info overflow: %#llx > %#zx\n",
+				      info_size, ivpu_bo_size(bo));
+		ret = -EOVERFLOW;
+		goto unlock;
+	}
+
 	if (args->buffer_size < info_size) {
 		ret = -ENOSPC;
 		goto unlock;
-- 
2.43.0

