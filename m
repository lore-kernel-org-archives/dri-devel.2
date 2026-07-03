Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A4FC44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:35:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDF4F10F655;
	Fri,  3 Jul 2026 06:35:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="o8bBTGXU";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3A8E10F653
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 06:35:29 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso95034f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 23:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783060528; x=1783665328; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lxw0sZE8zYQCTbLC1/Q9+xASb7RO0ly66mDkJEuqY88=;
 b=o8bBTGXUXop69mHPRuDL7kVbET6yP2NOgwGHzKvPREiiWPdjJof8M/fZgmXNDer5bc
 eWwHQuTSaui4HabhkutOAa4Qrxqzac8R9w3fME2A2Ff7IVp/HZTxh/q5qAKlRSQCaN1t
 4YPcMbhbbt7wPKanUGQJivdjcaLlyzWtM3qroqa4fnBVu8mM9ppUtJvM1s6uPxuM+ERw
 0xZDgpyRAGfiJ67jroSfOGgEPuFz9/A3uWT5qU0eE3s0H4n60ptO8tNKCIYwQuwbWj+v
 suhrOpMkGRedU61djLh5r0B//Pj5sfyIPBLR6uDhVvx1rtlHRwHKSOgDNarER6dUwvp6
 nzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783060528; x=1783665328;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lxw0sZE8zYQCTbLC1/Q9+xASb7RO0ly66mDkJEuqY88=;
 b=eFAhsdIGPyJv7NibQFvn2RVeNdFAzibIRwmBkHVGYq8Cq2OnkSI3Vxid2aHH94n0fG
 PIeDCFVUtSiJZTIr/EkJP/txH6RTzG+WufB0NalyyORBTf1SiypRMkAGWRbam/AzTkDj
 YjO+cvw8l5Iw1ns3oPMHfU+CWUzVOhQkSPGxEnzZ/hKMHmwirag3QJlWFDbYbXHhdGzb
 lJte5Dr1dvXHXFrHZdR3JFtYNv+e7TsHDV4G+8gO94AeDRcSdmA10XBZ/lV9djQ8Ebct
 qaD4gbSeWigORbejjl1mdbK+8u4oqvtJc59QGQoutC23PEnwi/RfF73kRrh1PUZTLf/L
 RKPg==
X-Gm-Message-State: AOJu0YyHeVOxKdXi5hNljPlRK9S5Z0zXvgqO1F+8B184+fnMQwRntqTy
 CLtV68uqq0LbQdgV/ji2hHnCg1SAzHnygyz3ZO9pNf9GkAIHG4tok2m0dyO1mg==
X-Gm-Gg: AfdE7ckYJRw9Wc7qpUgfdz4spY30oE6PjJ6uOQOF5MhWZpcQQLAQwXRRVvORnwWa8dB
 3gcpwRVWhdqMargeHBlAp0UWOGnBZ9IguP9uaBLx7VUYpyZr2areI4NgUyx/g8RO4VLcj4l0IXL
 McvTk/RuZ9LBw6ypQ1CEXIJYtxXHK7JLVivol38WlccDgX/rc6FJJwZHzyPwrsWM0AaL6eyvWYL
 2mDnSW7IYRKtkJ4gJbSmGKUA/Zn3oDoS5VkQ2sjqfDcSyKDenmv/xfSBL3MIIeGa155uYmTQ4U9
 aXhGllFcaSgBUEyjKevdkMvnG0nHFr4Vin/U+IcN9mYhljdtoXE14kCS1/s65hTcgkE4VMhHCyA
 3F0ZmEZSguRtwRLPF3hGa3NRprGertkr90Eafz8vvsnOA+oUMo4gGIbj1pGz5FtUirsukalG/cy
 OmeqGgYr5d0+g=
X-Received: by 2002:a05:6000:27c9:20b0:460:70ff:fe14 with SMTP id
 ffacd0b85a97d-47759754d50mr9348420f8f.42.1783060527935; 
 Thu, 02 Jul 2026 23:35:27 -0700 (PDT)
Received: from fedora ([94.73.45.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dba3csm14687656f8f.3.2026.07.02.23.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 23:35:27 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, boris.brezillon@collabora.com, kees@kernel.org,
 =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito@redhat.com>
Subject: [PATCH 2/2] drm/tests: shmem: Set DMA mask to 64-bit in
 drm_gem_shmem_test_purge
Date: Fri,  3 Jul 2026 08:34:27 +0200
Message-ID: <20260703063517.6346-3-jose.exposito89@gmail.com>
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

drm_gem_shmem_test_purge intermittently fails on ppc64le and s390x CI
systems with a DMA address overflow: [1]

  DMA addr 0x0000000100307000+4096 overflow (mask ffffffff, bus limit 0)
  WARNING: kernel/dma/direct.h:114 dma_direct_map_sg+0x778/0x920

  drm_gem_shmem_test_purge: ASSERTION FAILED at
    drivers/gpu/drm/tests/drm_gem_shmem_test.c:330
    Expected sgt is not error, but is: -5

The call chain leading to the failure is:

  drm_gem_shmem_test_purge()
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

[1] https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/2643976103/test_s390x/15128551935/artifacts/jobwatch/logs/recipes/21561049/tasks/220716793/results/1014626315/logs/dmesg.log

Fixes: 93032ae634d4 ("drm/test: add a test suite for GEM objects backed by shmem")
Closes: https://datawarehouse.cki-project.org/issue/5345
Assisted-by: Claude:claude-4.6-opus
Signed-off-by: José Expósito <jose.exposito@redhat.com>
---
 drivers/gpu/drm/tests/drm_gem_shmem_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
index c217a9ec7240..66dea51ac456 100644
--- a/drivers/gpu/drm/tests/drm_gem_shmem_test.c
+++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
@@ -325,6 +325,9 @@ static void drm_gem_shmem_test_purge(struct kunit *test)
 	struct sg_table *sgt;
 	int ret;
 
+	ret = dma_set_mask(drm_dev->dev, DMA_BIT_MASK(64));
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	shmem = drm_gem_shmem_create(drm_dev, TEST_SIZE);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
 
-- 
2.54.0

