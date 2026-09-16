Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAAEC982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 17:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F45F10E2FF;
	Wed, 16 Sep 2026 17:20:11 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28F8210E2FF
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 17:20:07 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowAD3J0LCz6pq0H5uCA--.23150S2;
 Thu, 17 Sep 2026 01:20:03 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: andi.shyti@linux.intel.com, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, linux-kernel@vger.kernel.org,
 matthew.d.roper@intel.com, rodrigo.vivi@intel.com, simona@ffwll.ch,
 sujaritha.sundaresan@intel.com, tursulin@ursulin.net,
 Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: [PATCH] drm/i915: Fix vm reference leak in mock_gem_device()
Date: Wed, 16 Sep 2026 17:19:35 +0000
Message-Id: <20260916171935.2087305-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAD3J0LCz6pq0H5uCA--.23150S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1ftw43uF18ZF43tw4Utwb_yoW8Ar48pF
 4rJFW5KFW5JF1Ig3ZrZF1DZFyfCan0y3WrGw17Aw1a9r15Aa4DGa4F9ayUtrWjyrZ7X3yf
 A347KF1I9r1jk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9S14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
 4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
 xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
 kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
 WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JF
 I_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_
 Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr
 1UYxBIdaVFxhVjvjDU0xZFpf9x0JUDOz3UUUUU=
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQMA2qqozVoJQAAsJ
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

mock_gem_device() takes a reference on the GGTT vm for gt->vm, but
neither mock_device_release() nor the setup error paths drop it, unlike
the real teardown where intel_gt_driver_release() releases gt->vm.
Drop the reference before mock_fini_ggtt() and on the error paths.

Fixes: cdeea858d8df ("drm/i915: Remove unused i915->ggtt")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/i915/selftests/mock_gem_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/i915/selftests/mock_gem_device.c b/drivers/gpu/drm/i915/selftests/mock_gem_device.c
index 27dc0e40a8d7..12cd252d9250 100644
--- a/drivers/gpu/drm/i915/selftests/mock_gem_device.c
+++ b/drivers/gpu/drm/i915/selftests/mock_gem_device.c
@@ -71,6 +71,7 @@ static void mock_device_release(struct drm_device *dev)
 
 	i915_gem_drain_workqueue(i915);
 
+	i915_vm_put(fetch_and_zero(&to_gt(i915)->vm));
 	mock_fini_ggtt(to_gt(i915)->ggtt);
 	destroy_workqueue(i915->unordered_wq);
 	destroy_workqueue(i915->wq);
@@ -145,6 +146,7 @@ struct drm_i915_private *mock_gem_device(void)
 #endif
 	struct drm_i915_private *i915;
 	struct intel_display *display;
+	struct i915_address_space *vm;
 	struct pci_dev *pdev;
 	int ret;
 
@@ -263,6 +265,9 @@ struct drm_i915_private *mock_gem_device(void)
 err_drv:
 	intel_region_ttm_device_fini(i915);
 err_ttm:
+	vm = fetch_and_zero(&to_gt(i915)->vm);
+	if (vm)
+		i915_vm_put(vm);
 	intel_gt_driver_late_release_all(i915);
 	intel_memory_regions_driver_release(i915);
 	drm_mode_config_cleanup(&i915->drm);
-- 
2.34.1

