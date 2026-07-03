Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E00C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 15:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DA1510F82D;
	Fri,  3 Jul 2026 15:08:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UB4/nLNM";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73DD110F82D
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 15:08:18 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493b779003fso3184805e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 08:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783091297; x=1783696097; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KO+r/wNoYbU1sjvYFpHZJ/Ol+Vzi+WjeZ3CRuNPxCww=;
 b=UB4/nLNMQ8lQr7dJgnye4XNE1Nvd1qN50f+zjVwb+gFHICDFBkU8ajIpBIqUiR409K
 ZVYqdjTRVPpn7gdXUgJQEcPwH2DUadBj7SsUtu8SxplsfvndqbNk4h7cF1ZsqPO5Ko47
 kVngyJ+fHtslBjHUC4vZBUZKgmLpoFtX+mD47rF2IVevrf4KRU/z5Mkp2tw77xcDkI72
 CQwbZehwvDmTkdavPOdhf0JNh0+4ZjJub+IdUBNi4HTZPEfIvl1/SbEr1VEONYdqhT1O
 oY8ZsrgGyu6bjDGhuIwy8u3vy4bC3x5QdlGFeO7WYqAor8UAqWL+8hgNHSo4+vfwuUNw
 X2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783091297; x=1783696097;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KO+r/wNoYbU1sjvYFpHZJ/Ol+Vzi+WjeZ3CRuNPxCww=;
 b=UFUsQ1HX7dJBE5/bScf2ypS7icZneWIKavhuBD9Fv2y/KXNh8B8un7q9lDXluUlUKA
 oIJSPfPvwW6dYmKWrEH4iX3oHPeGrR8KijDIHLrW2bHVQVxg+JfCmYodo7lZZUhAaIQL
 d2+NuFhHWlsdYQDc9H1AHGCljt/fAqGgEJUaQl6qQCoFyi+gbfHVIa3KToM53TZPanJm
 N6fWTeHV8FzkhDxZua1S2xOHr+bIMYIkQlBhAkXur3EuPZqgMBK3j2mDV6ljiOBivLIB
 yeX1tg2cfznCFjdB6g80PXp8UYcx5VfMZRwXo+8MStRftA6Vl6eAUyIFQMPhYIZG2b55
 BkSg==
X-Gm-Message-State: AOJu0YyicGdnn+xvW95fEfCpFr9L4EXLe9Yty5vaHUBCSw2TgkqxC0QO
 8myllnTJG3V3nzrRz3K/B+6Ao+EWZlJl3hiAckRX1F7KrGFOz25gzqQt2gBwPw==
X-Gm-Gg: AfdE7cktigTfTxTo4Dnb2Mb/HWTzkvBxBoOurV+veYbIQHL3g93A/0n3K30t1tvFZhN
 +qYtxLjpeZGXxU/IWBp2GT8wjyxGU1sG/LjhQ9Eg8qBl0/VGvrfmCsACqGNrp7dMiI6PBxLAv0W
 ffPDvp2Ehloyk09EEVviigxOKgpDDWLKFvQKqawUzznxBRwio90p5W2ugzO3bgn00uPwUWDA3Oq
 Rg/XGGnU4WXtxrzDdEWGQEvliNZ35ykVxk1X62ayLUvVUJSslK3DezEtNKvfRZLzhcYOolI4OlW
 pH04qZ6mhUs+PqTeNAbav1lE158F9pwJeKe1fPzxoxrGiBfEzQPjGgJs5ISXlSyv6zL1KiIWoAs
 I5i8cQogGD/R+HYwPYrbFlCiMC/cGT1msYFbXQc/K8ZUyQucNMjoXN8GbvPpq4jzlls4nqetVj8
 5UmTPbyuMupGH+td5PQW0nNw==
X-Received: by 2002:a05:600d:8649:10b0:493:b7a6:3dac with SMTP id
 5b1f17b1804b1-493d0f3c959mr2267395e9.33.1783091296588; 
 Fri, 03 Jul 2026 08:08:16 -0700 (PDT)
Received: from fedora ([94.73.45.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63172fesm240585665e9.0.2026.07.03.08.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 08:08:16 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, boris.brezillon@collabora.com, kees@kernel.org,
 =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito@redhat.com>
Subject: [PATCH v3] drm/tests: shmem: Set DMA mask to 64-bit in drm_gem_shmem
Date: Fri,  3 Jul 2026 17:07:43 +0200
Message-ID: <20260703150808.3832-1-jose.exposito89@gmail.com>
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
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: José Expósito <jose.exposito@redhat.com>

---

v2:

  - Move fix to drm_gem_shmem_test_init() (Thomas Zimmermann)
  - Link to v1: https://lore.kernel.org/dri-devel/20260703063517.6346-1-jose.exposito89@gmail.com/

v3:

  - Improve comments (Sashiko Bot)
  - Link to v2: https://lore.kernel.org/dri-devel/20260703142749.4099-1-jose.exposito89@gmail.com/
---
 drivers/gpu/drm/tests/drm_gem_shmem_test.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
index 44a190109249..5e69ff1d1ad6 100644
--- a/drivers/gpu/drm/tests/drm_gem_shmem_test.c
+++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
@@ -95,13 +95,9 @@ static void drm_gem_shmem_test_obj_create_private(struct kunit *test)
 	sg_init_one(sgt->sgl, buf, TEST_SIZE);
 
 	/*
-	 * Set the DMA mask to 64-bits and map the sgtables
-	 * otherwise drm_gem_shmem_free will cause a warning
-	 * on debug kernels.
+	 * Map the sgtables otherwise drm_gem_shmem_free will cause a warning on
+	 * debug kernels.
 	 */
-	ret = dma_set_mask(drm_dev->dev, DMA_BIT_MASK(64));
-	KUNIT_ASSERT_EQ(test, ret, 0);
-
 	ret = dma_map_sgtable(drm_dev->dev, sgt, DMA_BIDIRECTIONAL, 0);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
@@ -352,11 +348,19 @@ static int drm_gem_shmem_test_init(struct kunit *test)
 {
 	struct device *dev;
 	struct drm_device *drm_dev;
+	int ret;
 
 	/* Allocate a parent device */
 	dev = drm_kunit_helper_alloc_device(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 
+	/*
+	 * Set the DMA mask to 64-bits to avoid intermittent failures calling
+	 * drm_gem_shmem_get_pages_sgt().
+	 */
+	ret = dma_set_mask(dev, DMA_BIT_MASK(64));
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	/*
 	 * The DRM core will automatically initialize the GEM core and create
 	 * a DRM Memory Manager object which provides an address space pool
-- 
2.54.0

