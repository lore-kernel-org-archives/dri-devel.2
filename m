Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BA6C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41EC110E438;
	Mon, 21 Sep 2026 07:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="KhO8TJY5";
	dkim-atps=neutral
X-Greylist: delayed 395 seconds by postgrey-1.36 at gabe;
 Sun, 20 Sep 2026 03:51:12 UTC
Received: from mail-proxy49146.mail.163.com (mail-proxy49146.mail.163.com
 [45.254.49.146])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13C6110E22A;
 Sun, 20 Sep 2026 03:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=/4
 6K7CKA4FLhX8P6PiPB9A09fZBI9tPYG8e8QYie1OE=; b=KhO8TJY5g1a3ioZPnF
 cuXNGN9dUvAgRLekldk2ssfQBCsNtmDCmjJmQhOVU1d9K02XaScw6d6OHgtak8Jj
 2ok7aQWYd7itUYCjuwwB1VDrvPF/lzLwRz1/rLXK8GZ3vn80ttzk8/AwiOnttNv1
 QxkvN4H3har5U7egTcO+v9CgQ=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCnd59jVq9qEHkyBg--.226S2;
 Sun, 20 Sep 2026 11:43:34 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: alessio.belle@imgtec.com
Cc: luigi.santivetti@imgtec.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, imagination@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 frank.binns@imgtec.com, matt.coster@imgtec.com, sarah.walker@imgtec.com,
 donald.robson@imgtec.com, boris.brezillon@collabora.com, hppiscas@163.com
Subject: [PATCH v2] drm/imagination: clamp freelist reconstruction requests
Date: Sun, 20 Sep 2026 11:43:29 +0800
Message-ID: <20260920034329.16614-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCnd59jVq9qEHkyBg--.226S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw47Jr43Kr48WF1xAw15XFb_yoW5GF43pa
 95CayUJrWkJa1IgrsxA3Wjqa45Aan7A3WfKry5WwnrZr13trs0ya9akF15Xry5trs7Zr47
 ArnFgrZ5ZF4UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziBMKNUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbCxQY1-WqvVmaBAQAA3+
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

The firmware reconstruction count controls accesses to the request's
fixed freelist ID array and the copy into the fixed response array.
Neither access currently bounds the count to those protocol arrays.

Clamp the count to the request capacity, which is shared by the response
layout, and use that count consistently for reconstruction and response
publication. Keep the firmware recovery exchange instead of dropping an
oversized request without a response, as discussed with the firmware
maintainer.

The issue was found by our static-analysis tool.

Fixes: 6eedddab733b ("drm/imagination: Implement free list and HWRT create and destroy ioctls")
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
Changes since v1:
https://lore.kernel.org/all/20260813152759.35856-1-pengpeng@iscas.ac.cn/
Include drm_print.h for drm_warn_once(), brace the multiline warning
block, and shorten its text as Alessio requested.

 drivers/gpu/drm/imagination/pvr_free_list.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_free_list.c b/drivers/gpu/drm/imagination/pvr_free_list.c
index e85cac83834c..faf5e586d8dc 100644
--- a/drivers/gpu/drm/imagination/pvr_free_list.c
+++ b/drivers/gpu/drm/imagination/pvr_free_list.c
@@ -8,6 +8,7 @@
 #include "pvr_vm.h"
 
 #include <drm/drm_gem.h>
+#include <drm/drm_print.h>
 #include <linux/slab.h>
 #include <linux/xarray.h>
 #include <uapi/drm/pvr_drm.h>
@@ -612,13 +613,21 @@ pvr_free_list_process_reconstruct_req(struct pvr_device *pvr_dev,
 	};
 	struct rogue_fwif_freelists_reconstruction_data *resp =
 		&resp_cmd.cmd_data.free_lists_reconstruction_data;
+	u32 count = min_t(u32, req->freelist_count,
+			  ARRAY_SIZE(req->freelist_ids));
 
-	for (u32 i = 0; i < req->freelist_count; i++)
+	if (count != req->freelist_count) {
+		drm_warn_once(from_pvr_device(pvr_dev),
+			      "Requested reconstruction of %u freelists, limiting to %u\n",
+			      req->freelist_count, count);
+	}
+
+	for (u32 i = 0; i < count; i++)
 		pvr_free_list_reconstruct(pvr_dev, req->freelist_ids[i]);
 
-	resp->freelist_count = req->freelist_count;
+	resp->freelist_count = count;
 	memcpy(resp->freelist_ids, req->freelist_ids,
-	       req->freelist_count * sizeof(resp->freelist_ids[0]));
+	       count * sizeof(resp->freelist_ids[0]));
 
 	WARN_ON(pvr_kccb_send_cmd(pvr_dev, &resp_cmd, NULL));
 }

base-commit: 518e5b794c06c0f0eb40df3e202274a66202c137
-- 
2.50.1 (Apple Git-155)

