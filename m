Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD61CC43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 13:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EF9A89D99;
	Sun, 28 Jun 2026 13:34:21 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D765789D99
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 13:34:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [117.182.74.7])
 by APP-05 (Coremail) with SMTP id zQCowADXYQXOIkFqHpPGFQ--.24670S2;
 Sun, 28 Jun 2026 21:34:07 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: kees@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 tomi.valkeinen@ideasonboard.com, mcanal@igalia.com, vulab@iscas.ac.cn,
 suraj.kandpal@intel.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
 stable@vger.kernel.org
Subject: [PATCH v2] drm/display: fix MST branch device refcount leak on DPCD
 write failure
Date: Sun, 28 Jun 2026 21:33:44 +0800
Message-Id: <20260628133344.46188-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADXYQXOIkFqHpPGFQ--.24670S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urWrXw43AFWkWFy5Zw4DXFb_yoW8GFy3pr
 W2kry2vr97AanFyr4UZF18WFWDGa9rAa4fCF4UWw43Ww1UAr10ga48KFyagF17ArWIkF1f
 twsrCFy8CF9Fk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
 n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
 AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
 17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
 IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
 IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
 VFxhVjvjDU0xZFpf9x0JUQZ2fUUUUU=
X-Originating-IP: [117.182.74.7]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgcMA2pBHYgILgAAsW
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

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Fixes: 7a3cbf590e63 ("drm/mst: Some style improvements in drm_dp_mst_topology_mgr_set_mst()")
Cc: stable@vger.kernel.org
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Fix patch format based on reviewer feedback
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

