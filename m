Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B637CD8C9D
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 02:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76CDD10E03E;
	Tue,  9 Jun 2026 02:25:16 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD78D10E03E
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 02:25:14 +0000 (UTC)
X-UUID: 6f37b89a63aa11f1aa26b74ffac11d73-20260609
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:62dfe53c-36ed-4508-9867-8fa6d2e427b6, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:25
X-CID-META: VersionHash:e7bac3a, CLOUDID:929f1ee21ebb0ae1bbd53a244d424031,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|123|136|850|865|898,TC:nil,Content:0
 |15|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
 I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6f37b89a63aa11f1aa26b74ffac11d73-20260609
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yaolu@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1752591753; Tue, 09 Jun 2026 10:25:08 +0800
From: yaolu@kylinos.cn
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Lu Yao <yaolu@kylinos.cn>
Subject: [PATCH] drm/gem: Fix resource leaks in drm_gem_huge_mnt_create()
 error paths
Date: Tue,  9 Jun 2026 10:25:04 +0800
Message-Id: <20260609022504.65722-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

From: Lu Yao <yaolu@kylinos.cn>

Fix two resource leaks in error handling paths:
- Release filesystem type reference obtained by get_fs_type()
- Release fs_context allocated by fs_context_for_mount()

Fixes: 6e0b1b82017b ("drm/gem: Add huge tmpfs mountpoint helpers")
Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
 drivers/gpu/drm/drm_gem.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 3b2448a3a9de..6568fbdc4641 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -122,19 +122,24 @@ int drm_gem_huge_mnt_create(struct drm_device *dev, const char *value)
 	if (unlikely(!type))
 		return -EOPNOTSUPP;
 	fc = fs_context_for_mount(type, SB_KERNMOUNT);
+	put_filesystem(type);
 	if (IS_ERR(fc))
 		return PTR_ERR(fc);
 	ret = vfs_parse_fs_string(fc, "source", "tmpfs");
 	if (unlikely(ret))
-		return -ENOPARAM;
+		goto err;
 	ret = vfs_parse_fs_string(fc, "huge", value);
 	if (unlikely(ret))
-		return -ENOPARAM;
+		goto err;
 
 	dev->huge_mnt = fc_mount_longterm(fc);
 	put_fs_context(fc);
 
 	return drmm_add_action_or_reset(dev, drm_gem_huge_mnt_free, NULL);
+
+err:
+	put_fs_context(fc);
+	return -ENOPARAM;
 }
 EXPORT_SYMBOL_GPL(drm_gem_huge_mnt_create);
 #endif
-- 
2.25.1

