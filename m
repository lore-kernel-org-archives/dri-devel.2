Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723FFCA9ED3
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8B3D10E5A5;
	Fri, 26 Jun 2026 12:51:30 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2A2A10E5A5
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:51:29 +0000 (UTC)
Received: from localhost.localdomain (unknown [117.182.75.66])
 by APP-05 (Coremail) with SMTP id zQCowABHntHHdT5qTwJpFQ--.42803S2;
 Fri, 26 Jun 2026 20:51:20 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: dmitry.baryshkov@oss.qualcomm.com, kees@kernel.org, liviu.dudau@arm.com,
 vulab@iscas.ac.cn, suraj.kandpal@intel.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH] fix: drm/display: drm_dp_mst_topology_mgr_set_mst: error path
 after DPCD write failure leaks MST branch device reference
Date: Fri, 26 Jun 2026 20:51:17 +0800
Message-Id: <20260626125117.37153-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABHntHHdT5qTwJpFQ--.42803S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urWrXw43AFWkWFyfWw4DArb_yoW8JFy3pr
 42kry2yryvyanFyr4UZF18WFWDGa97Aa4fGF4UWw43Ww1UAr10ga48KFyagF17ArWjkF1f
 t39rCFy8CFyqk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
 n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
 kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
 67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
 CI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
 CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
 sGvfC2KfnxnUUI43ZEXa7VUbzpBDUUUUU==
X-Originating-IP: [117.182.75.66]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ4KA2o+TZN13gABsu
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

drm_dp_add_mst_branch_device initializes mstb with refcount 1, and
  drm_dp_mst_topology_get_mstb increments it to 2. When
  drm_dp_dpcd_write_byte fails, out_unlock performs only one
  drm_dp_mst_topology_put_mstb, leaving the other reference stored in
  mgr->mst_primary. Since MST was not successfully enabled, no disable path
  will clean it up.

Cc: stable@vger.kernel.org
Fixes: 7a3cbf590e63 ("drm/mst: Some style improvements in drm_dp_mst_topology_mgr_set_mst()")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 8757972e8e24..db9441c80cd5 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -3679,8 +3679,10 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 					     DP_MST_EN |
 					     DP_UP_REQ_EN |
 					     DP_UPSTREAM_IS_SRC);
-		if (ret < 0)
+		if (ret < 0) {
+			mgr->mst_primary = NULL;
 			goto out_unlock;
+		}
 
 		/* Write reset payload */
 		drm_dp_dpcd_clear_payload(mgr->aux);
-- 
2.39.5 (Apple Git-154)

