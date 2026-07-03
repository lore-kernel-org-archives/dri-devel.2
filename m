Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D18FC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 14:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 123FD10F84F;
	Fri,  3 Jul 2026 14:28:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A+riaA4z";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F76B10E609
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 14:27:58 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-46ed4f66256so578681f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 07:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783088877; x=1783693677; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kv5yKiNtIV+UqN4ctXabi1ct/jkVoHU5ZKLfAIDfR8w=;
 b=A+riaA4zszd0yl4Jhk3iKrI+zQQcs32JbAWFrxNPqcHLfhmeQjv8hq9t2mjQA39EOy
 YaX1n3wEhtIX+/Rf2U7LgpebKVWTAS8Avv6MgN25A/NdVqK3CF4FtoPY0w1H2SaP1kDW
 NmOrVncVmnsUEsux4pzpLiP7o0JhiCrLV/0KDHAiYaULGuTu7jrkbqcnpD9HSq7MGr8Q
 Gn+VpBEXK6jCE3fdW8x09VBkKrgIJL107zFBVOZHSHoX7czQIDfhU2unXBaIMZZJUkes
 9l83evSuDclO4QSC0E99m7WSChF+sK8AGMDQqFgl3VJUglvimND/n+lk4ChsS1AJef1M
 nQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783088877; x=1783693677;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kv5yKiNtIV+UqN4ctXabi1ct/jkVoHU5ZKLfAIDfR8w=;
 b=NJ1MdfuV5FJMN61WkAqQ/FrtYmPlwNlwifTbHfnJCK6BaXZks7az9V44fBjS+dV1wC
 aRInl1Qm3chrAFHEQCJ7mMPOdWpQDGhF+WvHgV9DlWUk3iwmYqmzoF+QIRreYRl/velO
 BK/A8YOqGEn8yaAMkc7B2/t+s+D1STbsDglQ33WujThH2ANe+ZnbIVjNQNlvCU5JF+k/
 SJcnaxi+W2Lb9naoO2U2Y3jr8uJ5l/K40o/T+Q+63nFaS1/CIWe6TPED65rDGVdCB5BP
 54Kpo1zvpvXPAt02GqDuE+ZvCifIC+i2DebVlaJb0x4+BL806mx8x4XZ2MJ15GBuqOWr
 jf1Q==
X-Gm-Message-State: AOJu0YyF3vll2raTz0vRW03I0/urjDbgbBoWXWEn6wp6M2cIfi1Uf/c9
 g2kpUo4NytBWb9o3cD7smHauXu1oiVOjTSeg59RkML8iE9BYyQKmv2MIgYZhYA==
X-Gm-Gg: AfdE7cmV/doNpHVXVwIskPrcZsPBdY8NZP4qDkFzoOBvO4tXkkqATDGYF5snqdkd0L2
 BTy1FIFkjpb0V0S8TWcLJ9A3638+ZooZ4Bs8O3pqXJsy15UsDUt4weZEVYEXnZk2zd63GcCWPtt
 +zk1N3PylFVuorFCweSy+teTICcGhijB9etAMOUspS+Ji932ai5eVEnMqDOWbyEVDcWZiqzEGJJ
 gWlSRoG9UcOlwSxwWAZQ/IALTgFBJRV2sCturmCEIXCXUIo9EdvORdaYRB+U8RAjIyUSPiGb056
 hd+B0IOzSiMLhMWqnJXE83OTne6STSdUaBR5ygH7XGqtUePjegu+0FLkH6/x6O7UdFRri6NoPn1
 Be8tkh4nPf+ovpcZOWXhr3qz0Z9v4CaVZ1MfutTCGYwZnGYwNiJ9DNGf1PL9lKBMj0ixLYabr2/
 2FNPwFkFS9EHE=
X-Received: by 2002:a05:6000:430b:b0:472:22b4:fd6c with SMTP id
 ffacd0b85a97d-47759c268dcmr15656605f8f.8.1783088876733; 
 Fri, 03 Jul 2026 07:27:56 -0700 (PDT)
Received: from fedora ([94.73.45.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbb01sm18601702f8f.1.2026.07.03.07.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 07:27:56 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, boris.brezillon@collabora.com, kees@kernel.org,
 =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito@redhat.com>
Subject: [PATCH v2] drm/tests: shmem: Set DMA mask to 64-bit in drm_gem_shmem
Date: Fri,  3 Jul 2026 16:27:23 +0200
Message-ID: <20260703142749.4099-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: José Expósito <jose.exposito@redhat.com>

drm_gem_shmem_test_purge [1] and drm_gem_shmem_test_get_pages_sgt [2]
intermittently fail on ppc64le and s390x CI systems with a DMA address
overflow:

  DMA addr 0x0000000100307000+4096 overflow (mask ffffffff, bus limit 0)
  WARNING: kernel/dma/direct.h:114 dma_direct_map_sg+0x778/0x920

  drm_gem_shmem_test_purge: ASSERTION FAILED at
    drivers/gpu/drm/tests/drm_gem_shmem_test.c:330
    Expected sgt is not error, but is: -5

The call chain leading to the failure is:

  drm_gem_shmem_test_purge() / drm_gem_shmem_test_get_pages_sgt()
    drm_gem_shmem_get_pages_sgt()
      drm_gem_shmem_get_pages_sgt_locked() [drm_gem_shmem_helper.c]
        dma_map_sgtable()                  [mapping.c]
          __dma_map_sg_attrs()
            dma_direct_map_sg()            [direct.c]
              dma_direct_map_phys()        [kernel/dma/direct.h]
                dma_capable()              Checks addr against DMA mask
                  -> FAILS: addr > 0xFFFFFFFF

The root cause is that KUnit devices are initialized with a 32-bit DMA
mask (DMA_BIT_MASK(32)) in lib/kunit/device.c. On ppc64le and s390x
systems with physical memory above 4GB, page allocations can land at
addresses that exceed this mask. When drm_gem_shmem_get_pages_sgt()
attempts to DMA-map these pages via dma_map_sgtable(), the DMA layer
rejects the mapping because the physical address overflows the 32-bit
mask.

The failure is intermittent because pages may or may not be allocated
above 4GB on any given run depend on memory pressure.

Fix by setting a 64-bit DMA mask on the device before calling
drm_gem_shmem_get_pages_sgt() for all tests, following the same pattern
already used in drm_gem_shmem_test_obj_create_private().

[1] https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/2643976103/test_s390x/15128551935/artifacts/jobwatch/logs/recipes/21561049/tasks/220716793/results/1014626315/logs/dmesg.log
[2] https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/2643976103/test_ppc64le/15128551933/artifacts/jobwatch/logs/recipes/21561041/tasks/220716705/results/1014628163/logs/dmesg.log

Fixes: 93032ae634d4 ("drm/test: add a test suite for GEM objects backed by shmem")
Closes: https://datawarehouse.cki-project.org/issue/5345
Closes: https://datawarehouse.cki-project.org/issue/3184
Assisted-by: Claude:claude-4.6-opus
Signed-off-by: José Expósito <jose.exposito@redhat.com>

---

v2:

  - Move fix to drm_gem_shmem_test_init() (Thomas Zimmermann)
  - Link to v1: https://lore.kernel.org/dri-devel/20260703063517.6346-1-jose.exposito89@gmail.com/
---
 drivers/gpu/drm/tests/drm_gem_shmem_test.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
index 44a190109249..6e6b4f4902c2 100644
--- a/drivers/gpu/drm/tests/drm_gem_shmem_test.c
+++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
@@ -94,14 +94,6 @@ static void drm_gem_shmem_test_obj_create_private(struct kunit *test)
 
 	sg_init_one(sgt->sgl, buf, TEST_SIZE);
 
-	/*
-	 * Set the DMA mask to 64-bits and map the sgtables
-	 * otherwise drm_gem_shmem_free will cause a warning
-	 * on debug kernels.
-	 */
-	ret = dma_set_mask(drm_dev->dev, DMA_BIT_MASK(64));
-	KUNIT_ASSERT_EQ(test, ret, 0);
-
 	ret = dma_map_sgtable(drm_dev->dev, sgt, DMA_BIDIRECTIONAL, 0);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -352,11 +344,20 @@ static int drm_gem_shmem_test_init(struct kunit *test)
 {
 	struct device *dev;
 	struct drm_device *drm_dev;
+	int ret;
 
 	/* Allocate a parent device */
 	dev = drm_kunit_helper_alloc_device(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 
+	/*
+	 * Set the DMA mask to 64-bits and map the sgtables
+	 * otherwise drm_gem_shmem_free will cause a warning
+	 * on debug kernels.
+	 */
+	ret = dma_set_mask(dev, DMA_BIT_MASK(64));
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	/*
 	 * The DRM core will automatically initialize the GEM core and create
 	 * a DRM Memory Manager object which provides an address space pool
-- 
2.54.0

