Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491C9C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 702CF10E0E2;
	Fri, 14 Aug 2026 07:05:18 +0000 (UTC)
X-Greylist: delayed 399 seconds by postgrey-1.36 at gabe;
 Thu, 13 Aug 2026 15:34:49 UTC
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C97610F3B1
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [111.196.241.250])
 by APP-01 (Coremail) with SMTP id qwCowAA3DPCA4n1qOb55BQ--.54080S2;
 Thu, 13 Aug 2026 23:28:00 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>
Cc: Alessio Belle <Alessio.Belle@imgtec.com>,
 Sarah Walker <sarah.walker@imgtec.com>,
 Donald Robson <donald.robson@imgtec.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] drm/imagination: clamp freelist reconstruction requests
Date: Thu, 13 Aug 2026 23:27:59 +0800
Message-ID: <20260813152759.35856-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAA3DPCA4n1qOb55BQ--.54080S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGry7KFyfCF4rWr4UZr15XFb_yoW5WryUpa
 1rJay7KrWkJF4IgrZxAa10ga45Aan2kay3Kry5Cw13Zrn0yrsIyayayr15Xry5trs7Zr42
 qrnFgrWrZF4jyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
 n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
 kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
 67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8Jw
 CI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
 CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
 sGvfC2KfnxnUUI43ZEXa7VUbo5l5UUUUU==
X-Originating-IP: [111.196.241.250]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Mailman-Approved-At: Fri, 14 Aug 2026 07:04:05 +0000
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

The firmware reconstruction request contains a count followed by a
fixed array of ROGUE_FWIF_MAX_FREELISTS_TO_RECONSTRUCT IDs. The host
uses the count to walk the request array and to copy IDs into an equally
sized response array without checking the protocol maximum.

A firmware count above that maximum therefore makes both operations
access beyond their protocol objects. Clamp the count to the array
capacity, reconstruct only that bounded subset, and report the same
bounded count to firmware. This follows the recovery contract confirmed
by the firmware maintainers: an incomplete bounded update is preferable
to an unrepresentable response and gives firmware a chance to recover.

Warn once because an oversized count is a firmware bug, while avoiding
repeated log flooding if firmware retries the malformed request.

Fixes: 6eedddab733b ("drm/imagination: Implement free list and HWRT create and destroy ioctls")
Assisted-by: Codex:gpt-5
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since the RFC: https://lore.kernel.org/all/20260722040942.85459-1-pengpeng@iscas.ac.cn/
- implement the maintainer-confirmed bounded recovery policy
- warn once when firmware exceeds the protocol array capacity
- disclose the use of Codex

The protocol extents and recovery path were reviewed statically. The
change was not tested on PowerVR hardware.

 drivers/gpu/drm/imagination/pvr_free_list.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_free_list.c b/drivers/gpu/drm/imagination/pvr_free_list.c
index e85cac83834c..23dbc227b081 100644
--- a/drivers/gpu/drm/imagination/pvr_free_list.c
+++ b/drivers/gpu/drm/imagination/pvr_free_list.c
@@ -612,13 +612,20 @@ pvr_free_list_process_reconstruct_req(struct pvr_device *pvr_dev,
 	};
 	struct rogue_fwif_freelists_reconstruction_data *resp =
 		&resp_cmd.cmd_data.free_lists_reconstruction_data;
+	u32 count = min_t(u32, req->freelist_count,
+			  ARRAY_SIZE(req->freelist_ids));
 
-	for (u32 i = 0; i < req->freelist_count; i++)
+	if (count != req->freelist_count)
+		drm_warn_once(from_pvr_device(pvr_dev),
+			      "Firmware requested reconstruction of %u freelists, limiting to %u\n",
+			      req->freelist_count, count);
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
-- 
2.50.1 (Apple Git-155)

