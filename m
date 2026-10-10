Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD33FCA9EBD
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 02:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 209F210E558;
	Sat, 10 Oct 2026 02:20:18 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EB2710E558;
 Sat, 10 Oct 2026 02:20:15 +0000 (UTC)
X-UUID: 1e4b8fdac45111f19a56ed5b684f684d-20261010
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:7ba970b6-21d7-47f7-8d78-4a268cef4054, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:25
X-CID-META: VersionHash:7db8b62, CLOUDID:11d5f0bd31c19bf17d04c2dc1443c1ac,
 BulkI
 D:nil,BulkQuantity:0,SF:81|82|102|136|865|898,TC:nil,Content:0|15|50|99,ED
 M:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
 OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1e4b8fdac45111f19a56ed5b684f684d-20261010
X-User: liupeng01@kylinos.cn
Received: from t14 [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <liupeng01@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1682849758; Sat, 10 Oct 2026 10:20:10 +0800
From: liupeng <liupeng01@kylinos.cn>
To: lyude@redhat.com,
	dakr@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, linux@roeck-us.net,
 nouveau@karolherbst.de, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, stable@vger.kernel.org,
 liupeng <liupeng01@kylinos.cn>
Subject: [PATCH v4 1/2] drm/nouveau: Fix memory leak in debugfs init error path
Date: Sat, 10 Oct 2026 10:20:05 +0800
Message-ID: <20261010022006.28263-1-liupeng01@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <b4cd38b48d85298a7a99cf30fbd8cbbdb34a347f.camel@redhat.com>
References: <b4cd38b48d85298a7a99cf30fbd8cbbdb34a347f.camel@redhat.com>
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

In nouveau_debugfs_init(), if nvif_object_ctor() fails, the previously
allocated drm->debugfs is leaked because the function returns the
error code directly.

Fix this by freeing the allocated memory and clearing the pointer on
the error path.

Fixes: b126a200e9db ("drm/nouveau/debugfs: we need a ctrl object for debugfs")
Cc: stable@vger.kernel.org
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: liupeng <liupeng01@kylinos.cn>
---
Changes in v4:
- Split the debugfs and hwmon fixes into two separate patches as
  requested by Danilo, since they are unrelated fixes with different
  Fixes: tags. No functional change to this fix.

 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index 47d5579c568d..338421e52f69 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -295,13 +295,21 @@ nouveau_drm_debugfs_init(struct drm_minor *minor)
 int
 nouveau_debugfs_init(struct nouveau_drm *drm)
 {
+	int ret;
+
 	drm->debugfs = kzalloc_obj(*drm->debugfs);
 	if (!drm->debugfs)
 		return -ENOMEM;
 
-	return nvif_object_ctor(&drm->client.device.object, "debugfsCtrl", 0,
-				NVIF_CLASS_CONTROL, NULL, 0,
-				&drm->debugfs->ctrl);
+	ret = nvif_object_ctor(&drm->client.device.object, "debugfsCtrl", 0,
+			       NVIF_CLASS_CONTROL, NULL, 0,
+			       &drm->debugfs->ctrl);
+	if (ret) {
+		kfree(drm->debugfs);
+		drm->debugfs = NULL;
+	}
+
+	return ret;
 }
 
 void
-- 
2.53.0

