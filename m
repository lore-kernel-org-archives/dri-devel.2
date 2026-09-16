Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC72C982CC
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:31:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64BF410ED48;
	Wed, 16 Sep 2026 18:31:35 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87FE010ED48
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 18:31:33 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowACXADuA4Kpq55RvCA--.23779S2;
 Thu, 17 Sep 2026 02:31:28 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: cgmeiner@igalia.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mcanal@igalia.com, mripard@kernel.org, mwen@igalia.com, simona@ffwll.ch,
 tzimmermann@suse.de, Wentao Liang <vulab@iscas.ac.cn>,
 stable@vger.kernel.org
Subject: [PATCH] drm/v3d: Fix perfmon reference leak in
 v3d_perfmon_set_global_ioctl()
Date: Wed, 16 Sep 2026 18:31:00 +0000
Message-Id: <20260916183100.2092174-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACXADuA4Kpq55RvCA--.23779S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1fZryxWr1xAw1fXF1fWFg_yoW8GF43pw
 4fCryUKw1ftF929w17trWkWFyavw1fJFWkWFyqvwsxXr4Svr4DJry0kr9Yqr15Gr1fKF12
 qr1DCa1fWF1UCrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9q14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
 W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
 xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
 kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
 WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JF
 I_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG
 6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJV
 W0obIYCTnIWIevJa73UjIFyTuYvjfUw5l8UUUUU
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAIMA2qqpO9+ogABsX
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

v3d_perfmon_find() takes a reference to the perfmon which the ioctl
transfers to the global pointer on success.  The error paths are
missing this transfer: clearing the global perfmon while none is set,
and setting a global perfmon when one is already configured both
return without dropping the reference.  Release it on both paths.

Fixes: c6eabbab359c ("drm/v3d: Add DRM_IOCTL_V3D_PERFMON_SET_GLOBAL")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/v3d/v3d_perfmon.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
index 8e0249580bba..12bb1b087fa9 100644
--- a/drivers/gpu/drm/v3d/v3d_perfmon.c
+++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
@@ -461,16 +461,20 @@ int v3d_perfmon_set_global_ioctl(struct drm_device *dev, void *data,
 
 	/* If the request is to clear the global performance monitor */
 	if (req->flags & DRM_V3D_PERFMON_CLEAR_GLOBAL) {
-		if (!v3d->global_perfmon)
+		if (!v3d->global_perfmon) {
+			v3d_perfmon_put(perfmon);
 			return -EINVAL;
+		}
 
 		xchg(&v3d->global_perfmon, NULL);
 
 		return 0;
 	}
 
-	if (cmpxchg(&v3d->global_perfmon, NULL, perfmon))
+	if (cmpxchg(&v3d->global_perfmon, NULL, perfmon)) {
+		v3d_perfmon_put(perfmon);
 		return -EBUSY;
+	}
 
 	return 0;
 }
-- 
2.34.1

