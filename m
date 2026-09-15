Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC2EC88E7B
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 04:17:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E141C10E0FB;
	Tue, 15 Sep 2026 04:17:38 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 090EE10E0FB
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 04:17:37 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAD3y++lxahq4zYICA--.49861S2;
 Tue, 15 Sep 2026 12:12:21 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: dri-devel@lists.freedesktop.org
Cc: jeff.hugo@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 ogabbay@kernel.org, tomeu@tomeuvizoso.net, lkml@vger.kernel.org,
 Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: [PATCH 3/4] accel/rocket: fix iommu domain leak in
 rocket_ioctl_create_bo() error path
Date: Tue, 15 Sep 2026 04:11:52 +0000
Message-Id: <20260915041152.1725014-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAD3y++lxahq4zYICA--.49861S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFy7Wr1fGryxAFW3Wr43GFg_yoWkKFb_ua
 4fXF93WasYgrs8u3Wak3ySvrWkK3ZFgrnaqrWkK34fCayqqFW2vrZ3Zrn7Jr1xZr18GF90
 yw1UJr1fXrnrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
 AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
 v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
 c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUAPEfUUU
 UU=
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAALA2qowzMK1wAAsr
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

If creating a BO fails after the GEM handle was created (e.g. the pages
or the iommu mapping cannot be set up), the error path calls
drm_gem_shmem_object_free() directly.  That bypasses the driver's
rocket_gem_bo_free() GEM free callback, so rocket_iommu_domain_put() is
never called and the reference taken with rocket_iommu_domain_get()
earlier in the function is leaked.

Drop the iommu domain reference before freeing the shmem object in the
error path.

Fixes: 658ebeac3351 ("accel/rocket: Add IOCTL for BO creation")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/accel/rocket/rocket_gem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/rocket_gem.c
index c8084719208a..91095d1b3066 100644
--- a/drivers/accel/rocket/rocket_gem.c
+++ b/drivers/accel/rocket/rocket_gem.c
@@ -120,6 +120,7 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 	mutex_unlock(&rocket_priv->mm_lock);
 
 err:
+	rocket_iommu_domain_put(rkt_obj->domain);
 	drm_gem_shmem_object_free(gem_obj);
 
 	return ret;
-- 
2.34.1

