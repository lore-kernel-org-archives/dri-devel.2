Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E13FC982CC
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5169610E3D3;
	Wed, 16 Sep 2026 15:36:44 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC5FC10E3D3
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 15:36:42 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowACXATyDt6pq6e5sCA--.21128S2;
 Wed, 16 Sep 2026 23:36:35 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, itoral@igalia.com,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mcanal@igalia.com, mripard@kernel.org, mwen@igalia.com, simona@ffwll.ch,
 tzimmermann@suse.de, Wentao Liang <vulab@iscas.ac.cn>,
 stable@vger.kernel.org
Subject: [PATCH] drm/v3d: Fix indirect GEM object reference leak in
 v3d_get_cpu_indirect_csd_params()
Date: Wed, 16 Sep 2026 15:36:07 +0000
Message-Id: <20260916153607.2048140-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACXATyDt6pq6e5sCA--.21128S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr47Ww4fJrW3Gw48Xr18Xwb_yoW8CrWDpF
 sxW34akry3Ar4Ig39rAF4kAFyfG34avayrWFZ7C393Zr1FkF45Xry5KasrZr47AF1rGFy2
 qr1DtayFgryjyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
 Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
 0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
 zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
 4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
 CwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcS
 sGvfC2KfnxnUUI43ZEXa7VUb_gA7UUUUU==
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwcMA2qqpVgwiQAAsL
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

If v3d_setup_csd_jobs_and_bos() fails, the reference taken by
drm_gem_object_lookup() on info->indirect is never dropped: the caller
only cleans up via v3d_job_cleanup(), but the CPU job refcount is not
initialized until v3d_job_init() runs after the extensions succeed, so
v3d_cpu_job_free() never fires.

Release the GEM reference and clear the pointer when setting up the
CSD jobs fails.

Fixes: 18b8413b25b7 ("drm/v3d: Create a CPU job extension for a indirect CSD job")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 3ddd53b6f437..f021ab9a69b1 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -465,6 +465,7 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
 	struct v3d_dev *v3d = v3d_priv->v3d;
 	struct drm_v3d_indirect_csd indirect_csd;
 	struct v3d_indirect_csd_info *info = &job->indirect_csd;
+	int ret;
 
 	if (!v3d_validate_cpu_job(file_priv, job))
 		return -EINVAL;
@@ -485,9 +486,15 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
 
 	info->indirect = drm_gem_object_lookup(file_priv, indirect_csd.indirect);
 
-	return v3d_setup_csd_jobs_and_bos(file_priv, v3d, &indirect_csd.submit,
-					  &info->job, &info->clean_job,
-					  NULL, &info->acquire_ctx);
+	ret = v3d_setup_csd_jobs_and_bos(file_priv, v3d, &indirect_csd.submit,
+					 &info->job, &info->clean_job,
+					 NULL, &info->acquire_ctx);
+	if (ret) {
+		drm_gem_object_put(info->indirect);
+		info->indirect = NULL;
+	}
+
+	return ret;
 }
 
 /* Get data for the query timestamp job submission. */
-- 
2.34.1

