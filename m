Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28BBEC01DF
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 12:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41AD810E347;
	Mon, 23 Mar 2026 12:11:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Pi3eas9C";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A34E10E021;
 Mon, 23 Mar 2026 12:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774267871; x=1805803871;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MAIabYMZDm4pt0yXUI0+YbcdPcR2pRhl6gfJJ9j3YqM=;
 b=Pi3eas9CWNZh/izEuJTFY3NWG+6bgzbb3tmb3HKQmvLSn0taJJul9qVf
 o6yPRQfPT7WqWml//pbJN7EfiBt6FrfS8FktbQ5cSA/w5TzZHVobJo8Uz
 b/aQIDVT6q7LYipQtvVBLdehEhy08xn+EQ6NmAAJaeXUHmKU+YZP2gclB
 YO1Md9WLgcp6gIjEN6N4X/9wQxEtZkVcPsGvm0nU4timUw5cmOeUtlFeB
 0A13aicwTNUM8o4yo4xVU2Ei2Qdo5IE6GYfPrc0rHLfAnKFthRbPqSzBs
 OgauT/FNzjTOi1k9at+9yQrgdb0SMJX0JS++pcIRIIqLZDiPlJSZXiKWa Q==;
X-CSE-ConnectionGUID: 4WZHmmlzSia0hOqnSlvqdQ==
X-CSE-MsgGUID: 9sgPFYorSTKdIZLhIXYxUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75454600"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="75454600"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 05:11:10 -0700
X-CSE-ConnectionGUID: mmF30YyhQaqSbF1hN9k8ow==
X-CSE-MsgGUID: fBiM4LulS3yjca7nX6M1sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="228083714"
Received: from emr-371.sh.intel.com ([10.67.116.154])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 05:11:08 -0700
From: "Baoli.Zhang" <baoli.zhang@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: "Baoli.Zhang" <baoli.zhang@linux.intel.com>,
 "Junxiao . Chang" <junxiao.chang@intel.com>
Subject: [PATCH v1] drm/xe: use krealloc_array to prevent integer overflow
Date: Mon, 23 Mar 2026 20:00:49 +0800
Message-ID: <20260323120051.983301-1-baoli.zhang@linux.intel.com>
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
 drivers/gpu/drm/xe/xe_configfs.c   | 2 +-
 drivers/gpu/drm/xe/xe_vm_madvise.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

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
index bc39a9a9790c3..82afe4bef0725 100644
--- a/drivers/gpu/drm/xe/xe_vm_madvise.c
+++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
@@ -63,8 +63,9 @@ static int get_vmas(struct xe_vm *vm, struct xe_vmas_in_madvise_range *madvise_r
 
 		if (madvise_range->num_vmas == max_vmas) {
 			max_vmas <<= 1;
-			__vmas = krealloc(madvise_range->vmas,
-					  max_vmas * sizeof(*madvise_range->vmas),
+			__vmas = krealloc_array(madvise_range->vmas,
+					  max_vmas,
+					  sizeof(*madvise_range->vmas),
 					  GFP_KERNEL);
 			if (!__vmas) {
 				kfree(madvise_range->vmas);
-- 
2.43.0

