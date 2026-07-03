Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D85C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:35:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB7B710F653;
	Fri,  3 Jul 2026 06:35:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lkyWMPl9";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D754410F653
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 06:35:28 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4703bc0a99aso96177f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 23:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783060527; x=1783665327; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FsAGjZEuvj01fAleqXTQH1lnFIMvSczKXGXAcZGsOZE=;
 b=lkyWMPl9ED5Z302MV9RX9U39kU3GdC8/WuVOKHAAyIkgp0xB8kdBr0e+7HqnsTkRmc
 gn+XrZY/xlZj8SfpyHhVOc9s3SEhDVuVvBFZAMHuV5YsgvFmXZGAqkVGCfC+d9xh7P6G
 GQiibdWzF8LzrNjd0+Ln4IMvwp99AB9DzkfMr0Is7hWnpRjPnU7dlx/zJ/Vy3bsjSI3B
 lksdtsRATcDE90GO/62BQaph5GyTHp0ryQGjUr80VEdfSsv9g2Br1Dyvhr5cjYL63Pau
 M6M8+oTIVE9rYEH5GPYJRB6SyqxwwlnRBzw5HeB1tVpBNxPuPiQF6aj7IfO/4tKlo0it
 FujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783060527; x=1783665327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FsAGjZEuvj01fAleqXTQH1lnFIMvSczKXGXAcZGsOZE=;
 b=cNvfIzw6ommxDUtYi+F4XKqKYlkyjqvshL+3SSpkeG1NfkaHrWrK1PiOQKddOLG2XZ
 am41g4lNfSD9SQRLWikEiFzFV0bh0Gwestl7bf8I2TMaGJ/WjKTPRnYrken4nSOkgKS+
 cCy4SN+vkcqo8ABjy1fU4hKYMtkvg6nyGnk4/z4/w0XLpcKOiiUg1jJbzsdn/LTMqend
 QOk4205rpE5ncsPjWLR2nhQTB5QQBQhs6glJZ+ZFB9+EvrGO7EXusPD+hm8yg1DBTdhi
 k49TEO00wvr93r2LdzGGuZGxW8mSnqrMzYRFRV1HIATJ4qCDSuUBcMirZrjOBKLSLm/8
 cmEg==
X-Gm-Message-State: AOJu0YyAWn9f2FjV47yn6KquCDn4cafnHsgrD47Gda7Uk0eN1As67fu7
 Xl82PtAzYxfNHvr4+q+NoJsH/HM7utFeYUER9wV6NXJoquDEMXNDCYH9/OLedg==
X-Gm-Gg: AfdE7cmzGHoZMPnVNPQEX9jfYzA/DDP5bkt6uGC2WH4t1QneWsNAjP6OoblD9y1F38w
 pQJIgUDjLtWAsxiMf+qQ4kXURFwF7QkZxhnxXoMuz/xFZT46dga2e7chtBg1k2ggXbJ58JGfnAH
 3VLd0iC9IG6YeBLQNopQd2zurDXgMbIPphRazr1zA+qN9Gs7Y0OJbBev8zx304S8bQEFe9FHlQ8
 IRFYd2Z4+DUHIWhqQ26kBF7abfydiIj1ar94uOfuN00DdL9HXg8WNxStfOl0fjrJpMM/ffcf2Ip
 RMtKZpoCca0u9WwsGvJagcRo+uzcmsc+De0dQUudMkNrN3cgPmaG6VHffKwjfQa/X50JBX1tZBV
 GTZ+0ibBWJer62qqPQkFD5qkUoycVjfs2A4mK1IiKtzQ6EOQwQUHG+a6WR39VFDEVd2e/P0SGze
 gfy9FQ8/6k9PY=
X-Received: by 2002:a05:6000:40c8:b0:475:f0f0:9f00 with SMTP id
 ffacd0b85a97d-47759f0fccamr13900667f8f.55.1783060527109; 
 Thu, 02 Jul 2026 23:35:27 -0700 (PDT)
Received: from fedora ([94.73.45.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dba3csm14687656f8f.3.2026.07.02.23.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 23:35:26 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, boris.brezillon@collabora.com, kees@kernel.org,
 =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito@redhat.com>
Subject: [PATCH 1/2] drm/tests: shmem: Set DMA mask to 64-bit in
 drm_gem_shmem_test_get_pages_sgt
Date: Fri,  3 Jul 2026 08:34:26 +0200
Message-ID: <20260703063517.6346-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703063517.6346-1-jose.exposito89@gmail.com>
References: <20260703063517.6346-1-jose.exposito89@gmail.com>
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

drm_gem_shmem_test_get_pages_sgt intermittently fails on ppc64le and
s390x CI systems with a DMA address overflow: [1]

  DMA addr 0x00000001b6110000+65536 overflow (mask ffffffff, bus limit 0)
  WARNING: kernel/dma/direct.h:114 dma_direct_map_phys+0x298/0x300

  drm_gem_shmem_test_get_pages_sgt: ASSERTION FAILED at
    drivers/gpu/drm/tests/drm_gem_shmem_test.c:255
    Expected sgt is not error, but is: -5

The call chain leading to the failure is:

  drm_gem_shmem_test_get_pages_sgt()
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
drm_gem_shmem_get_pages_sgt(), following the same pattern already used
in drm_gem_shmem_test_obj_create_private().

[1] https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/2643976103/test_ppc64le/15128551933/artifacts/jobwatch/logs/recipes/21561041/tasks/220716705/results/1014628163/logs/dmesg.log

Fixes: 93032ae634d4 ("drm/test: add a test suite for GEM objects backed by shmem")
Closes: https://datawarehouse.cki-project.org/issue/3184
Assisted-by: Claude:claude-4.6-opus
Signed-off-by: José Expósito <jose.exposito@redhat.com>
---
 drivers/gpu/drm/tests/drm_gem_shmem_test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
index 44a190109249..c217a9ec7240 100644
--- a/drivers/gpu/drm/tests/drm_gem_shmem_test.c
+++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
@@ -250,7 +250,11 @@ static void drm_gem_shmem_test_get_pages_sgt(struct kunit *test)
 	struct drm_gem_shmem_object *shmem;
 	struct sg_table *sgt;
 	struct scatterlist *sg;
-	unsigned int si, ret, len = 0;
+	unsigned int si, len = 0;
+	int ret;
+
+	ret = dma_set_mask(drm_dev->dev, DMA_BIT_MASK(64));
+	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	shmem = drm_gem_shmem_create(drm_dev, TEST_SIZE);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
-- 
2.54.0

