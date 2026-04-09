Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFD310FC456
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 01:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6144E10E741;
	Thu,  9 Apr 2026 01:33:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bcrLJpDT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 717D910E741;
 Thu,  9 Apr 2026 01:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775698433; x=1807234433;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7SAtYWVUOlf800s6bfc5eywit6yAaUAQJIieVusBzCs=;
 b=bcrLJpDToRCHifa1bfzq3pYeXGW02RUc5EgOd8WLxte8Z3xeAQ2R1MtX
 hRbAgLtkZrX1YgenXxTAdKwrwDnV3W6Q8LD8bJd6FLNcHzu/KNqgaYxi8
 wmuzu1iul8zZlm7Wb4J6gTClGP201a+tzvjBbdPMR2uc9kSWlQy3jKa6C
 O5bhIEQW7Nt6SMP/qwlrEwWznM9C3u8GOOu9l5oG+r+OMAkTWxJYmDYSS
 ofH3coR26xNw5qJmm87wJHHx0/mYC2UOGqm2cHyfK0MIIY0zxre6n4lzN
 T5ZR2IjZ0c2/P5k8d2YMud1IEgpFRuhchIe04NZXvrl6HwVYOKKrCa+TP Q==;
X-CSE-ConnectionGUID: pM2FYknJSeixV+rs3C3Svg==
X-CSE-MsgGUID: aLenxk0cRHuxMUWG+uIvbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76713061"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="76713061"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 18:33:53 -0700
X-CSE-ConnectionGUID: +bs49bXmR4SB0M8ZsFiGpA==
X-CSE-MsgGUID: Bp6tXyLvT7K9mgWpGij7zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="266600580"
Received: from emr-371.sh.intel.com ([10.67.116.154])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 18:33:51 -0700
From: "Baoli.Zhang" <baoli.zhang@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: "Baoli.Zhang" <baoli.zhang@linux.intel.com>,
 "Junxiao . Chang" <junxiao.chang@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/xe: use krealloc_array to prevent integer overflow
Date: Thu,  9 Apr 2026 09:25:19 +0800
Message-ID: <20260409012520.3531256-1-baoli.zhang@linux.intel.com>
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

Replace the use of krealloc() with krealloc_array() in xe driver to
mitigate the risk of integer overflow during memory allocation size
calculation.

Signed-off-by: Baoli.Zhang <baoli.zhang@linux.intel.com>
Signed-off-by: Junxiao.Chang <junxiao.chang@intel.com>
---
Changes in v2:
- Adjust continuation-line indentation in xe_vm_madvise.c (no functional change).

v1: https://patchwork.freedesktop.org/patch/713422/?series=163696&rev=1

 drivers/gpu/drm/xe/xe_configfs.c   | 2 +-
 drivers/gpu/drm/xe/xe_vm_madvise.c | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_configfs.c b/drivers/gpu/drm/xe/xe_configfs.c
index 7fd07d1280bb1..4cf903c904ba0 100644
--- a/drivers/gpu/drm/xe/xe_configfs.c
+++ b/drivers/gpu/drm/xe/xe_configfs.c
@@ -766,7 +766,7 @@ static ssize_t wa_bb_store(struct wa_bb wa_bb[static XE_ENGINE_CLASS_MAX],
 	 * 2. Allocate a u32 array and set the pointers to the right positions
 	 * according to the length of each class' wa_bb
 	 */
-	tmp = krealloc(wa_bb[0].cs, count * sizeof(u32), GFP_KERNEL);
+	tmp = krealloc_array(wa_bb[0].cs, count, sizeof(u32), GFP_KERNEL);
 	if (!tmp)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_vm_madvise.c
index bc39a9a9790c3..c90fea2b3d808 100644
--- a/drivers/gpu/drm/xe/xe_vm_madvise.c
+++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
@@ -63,9 +63,10 @@ static int get_vmas(struct xe_vm *vm, struct xe_vmas_in_madvise_range *madvise_r
 
 		if (madvise_range->num_vmas == max_vmas) {
 			max_vmas <<= 1;
-			__vmas = krealloc(madvise_range->vmas,
-					  max_vmas * sizeof(*madvise_range->vmas),
-					  GFP_KERNEL);
+			__vmas = krealloc_array(madvise_range->vmas,
+						max_vmas,
+						sizeof(*madvise_range->vmas),
+						GFP_KERNEL);
 			if (!__vmas) {
 				kfree(madvise_range->vmas);
 				return -ENOMEM;
-- 
2.43.0

