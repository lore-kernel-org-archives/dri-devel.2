Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49E1CD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 12:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0215210FDFC;
	Fri, 29 May 2026 12:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QL31/icI";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ADF710FDFC
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 12:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780056174; x=1811592174;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TZy73E+3IaSpE5wUpSsjK15CVH/hei5A9B1e1I4n2C8=;
 b=QL31/icIih6BjS2A2khWBRjzThdRAZ6WcQz0nVFZYb4JyGiTWnvVlbE9
 CH+L+0SRInVn8NSSl5mJR1qv3zhh4u0dUnMLpAqVb56Sy6zpR3Bd8//yd
 Ng4E5QSur2ZJZPtS2VMSFDeIJ+HOkiAdXBt6SyEdsFbw2oJYbCk2kdZ4t
 o1fN97KE45A2kcWtIhtN9yiWfNiGeeV8cUhDL1o3ay/5yU2/R0/KeHmI/
 yd0LzOMzaO+BYgu31yfgIZF0cpk8QCRoXJhjIlDZQwJqkweymgrhOU1K7
 hl+cAxkJfkTtWhkYdKIQ88JGCkHDno1/ZVr/K+cmT4jU9DqKYlLGlMIgy g==;
X-CSE-ConnectionGUID: KX8OhV2dR567BhhUP4q8Aw==
X-CSE-MsgGUID: zKNFH5pNRU2LFBlm+0A7HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="81021365"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="81021365"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 05:02:54 -0700
X-CSE-ConnectionGUID: 4Sb1i9p2Qi+eXKb1fuE7WA==
X-CSE-MsgGUID: bV4inkxeTmOMvhNb/7R5GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="239832279"
Received: from akacprow-dev3.igk.intel.com ([10.91.220.47])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 05:02:52 -0700
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 karol.wachowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 stable@vger.kernel.org
Subject: [PATCH] accel/ivpu: Add bounds checks for firmware log indices
Date: Fri, 29 May 2026 13:58:42 +0200
Message-ID: <20260529115842.135378-1-andrzej.kacprowski@linux.intel.com>
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

Add validation that read and write indices in the firmware log buffer
are within valid bounds (< data_size) before using them. If
out-of-bounds indices are encountered (from firmware), clamp them to
safe values instead of proceeding with invalid offsets.

This prevents potential out-of-bounds buffer access when firmware
supplies invalid log indices.

Fixes: 1fc1251149a7 ("accel/ivpu: Refactor functions in ivpu_fw_log.c")
Cc: <stable@vger.kernel.org> # v6.18+
Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_fw_log.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ivpu_fw_log.c
index 337c906b0210..275baf844b56 100644
--- a/drivers/accel/ivpu/ivpu_fw_log.c
+++ b/drivers/accel/ivpu/ivpu_fw_log.c
@@ -98,6 +98,11 @@ static void fw_log_print_buffer(struct vpu_tracing_buffer_header *log, const cha
 	u32 log_start = only_new_msgs ? READ_ONCE(log->read_index) : 0;
 	u32 log_end = READ_ONCE(log->write_index);
 
+	if (log_start >= data_size)
+		log_start = 0;
+	if (log_end > data_size)
+		log_end = data_size;
+
 	if (log->wrap_count == log->read_wrap_count) {
 		if (log_end <= log_start) {
 			drm_printf(p, "==== %s \"%s\" log empty ====\n", prefix, log->name);
-- 
2.43.0

