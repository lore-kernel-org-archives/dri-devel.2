Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD283CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 09:24:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CF4310EBCC;
	Tue, 19 May 2026 09:24:36 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2856510EBDA
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 09:24:34 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.150])
 by APP-01 (Coremail) with SMTP id qwCowAAnzGdFLAxqTtTAEA--.55S2;
 Tue, 19 May 2026 17:24:22 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <uwu@icenowy.me>, Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 stable@vger.kernel.org
Subject: [PATCH] drm/client: check whether CRTC is active before waiting for
 vblank
Date: Tue, 19 May 2026 17:24:20 +0800
Message-ID: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAnzGdFLAxqTtTAEA--.55S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1rXry3JFWkCw4rXFyfXrb_yoW8ur17pF
 43GryYyFWktFZxKanrZa4xZF1FgayrJFWxGry7Kwnxu3Z0vwnFyryFyr9FgFW7Jr9xXay7
 Xr4UtFy5uF1UCF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
 n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
 AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
 17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
 IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
 IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
 C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-Originating-IP: [112.94.102.150]
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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

Currently the implementaion of drm_client_modeset_wait_for_vblank()
assumes drm_vblank_get() will fail when the CRTC isn't active. However
it seems that this is not true, and running fbcon on a device with the
first CRTC inactive will lead to kernel warning in some cases (which
could be reproduced with the loongson driver).

Change the implementation to add a check for the active state (atomic) /
enabled state (non-atomic) before calling drm_vblank_get(). As the
assumption of drm_vblank_get() failing for inactive CRTC isn't met, the
error status of drm_vblank_get() can now be exported too.

Cc: stable@vger.kernel.org
Fixes: d8c4bddcd8bc ("drm/fb-helper: Synchronize dirty worker with vblank")
Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 drivers/gpu/drm/drm_client_modeset.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index bb49b8361271a..1b03bf351256e 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -1310,7 +1310,7 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
 {
 	struct drm_device *dev = client->dev;
 	struct drm_crtc *crtc;
-	int ret;
+	int ret = 0;
 
 	/*
 	 * Rate-limit update frequency to vblank. If there's a DRM master
@@ -1326,15 +1326,24 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
 	 * Only wait for a vblank event if the CRTC is enabled, otherwise
 	 * just don't do anything, not even report an error.
 	 */
+	if (drm_drv_uses_atomic_modeset(dev)) {
+		if (!crtc->state || !crtc->state->active)
+			goto out;
+	} else {
+		if (!crtc->enabled)
+			goto out;
+	}
+
 	ret = drm_crtc_vblank_get(crtc);
 	if (!ret) {
 		drm_crtc_wait_one_vblank(crtc);
 		drm_crtc_vblank_put(crtc);
 	}
 
+out:
 	drm_master_internal_release(dev);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(drm_client_modeset_wait_for_vblank);
 
-- 
2.52.0

