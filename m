Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256A7C982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D94110E6B8;
	Wed, 23 Sep 2026 07:43:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n4iOmdvD";
	dkim-atps=neutral
Received: from mail-pj2-f29.google.com (mail-pj2-f29.google.com
 [74.125.227.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B07910E6DD
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 07:43:29 +0000 (UTC)
Received: by mail-pj2-f29.google.com with SMTP id
 d9443c01a7336-2dd4ef687f5so485775ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 00:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790149409; x=1790754209; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rEwYnSIhHf9oeFrDmCKSYOnbIRlltkd0nAWN7h+lPkw=;
 b=n4iOmdvDLIIpWscU7Wif9qvxcBPO6Vrg5Top+ahSNrT00Eepl8zUJCd6GAV78gQE2d
 dkg64N0u9SLbkkt4xwxpYwiN4yapGY0akhdHi6dK2mZTjL20PKFdrrML/BteePVlH/VM
 iGlK9OwsrefIrwdOiNO/I5XhVQnmFjsMWeI9KdOD9nsRFIPfLtWdU5PHBzr7diZhYjyG
 OErpG3MfAOztbMJpqRQpzjUr/n8GDQmG230dHwXYoJG3hSyPaH6oxsrLKxOqcSDy4mZg
 vi8phXhu/XcM/rr4GOhBmk3Tdm9Er/gqXgJA0Dcga7j9mf2RRRuf66e/6/3R0Yum2bVU
 6QEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790149409; x=1790754209;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rEwYnSIhHf9oeFrDmCKSYOnbIRlltkd0nAWN7h+lPkw=;
 b=nZgmkfZ3AvSGr7bGTPiIMch/L1zw6IA5UOnq+p+VI3nwc3PNwQpDQST8w6s3h/JSRi
 ublD23fx6xzN/SMh9tmDp6qSTdfiy6YAQim789OAkGkTXcisQ0WiimkMzsaXrL98/zje
 w8sEo26VQ05ourrkX0jkvH5sAXXZP4amNFQdCJMsIgxwTuB/Fjo5EqXRfxDaeOdrfJZ8
 Cy49JCZcsFlLL+SKIzzCxT3XBrXxvxHSmcUJjIdvd5CkaEFd0D8TBn6moi/+j757iQpi
 T3lepNp2231ulSKYj7QHNbcZqTAWNl3xE7gfc6B9Egw7S1K4l76td1/KijcwZBL1AuuZ
 aZug==
X-Gm-Message-State: AFuF++lMOeBHCfws+Gs10BpVuFR17uby3N0F3jevb5DvGw8NjqfxChVl
 zI26eS8ZPsnA9d4wYUUhho8WmTZrG43sxZwYjF74nlTYXP5wcERszNxPJ7WcbYk5
X-Gm-Gg: AYBFou1qgoz2P+149XO7Y30bf0rYEKgqT8fhJ73BS/tFpGOoHl469qT73mtzcm4+mX0
 YUM7+1O4wtWHFFkcagUTd80/41VO3Ie7l1myxuor/8XCMOeTGymVpQhj4tBc2b3HVtkd7MF2Xub
 ct5rS935d8jUqj4LpaY0GL9noJiA7U0HvA10TPuJyT+5fog7CKP8S5CObVMMUn8YLn7iWcphuuu
 DBxNQQuLZdN5ubzWO0BopM2uGxZkxhuN0REs//YJ4sYrsIVa/yic9T3XHaNvlcHLrYENf5mX2ZJ
 ALho2MTbzz26LVT0W69+8Fo99fpLKjt4unS1JdbsWz/i/kke2k3mQZb6itAsP7NEicR6dpsX3MW
 fYL+Yhc4CEhUi3YQ1kvjLkUOIQtF90eyblm+u6gdX9Y2J0NstqTxqYwBXID1kaBkBwQXRjRiWU7
 pAEaJwIudn6QJEaV5DQu9cjMbQteqd+W/Hjk8BllSQJ5qruyTOaudc012u86kLOUOAqu+I8WRoJ
 vAOFR0/CJwr6u9hpZesnURC
X-Received: by 2002:a17:903:286:b0:2d8:d29b:c1e5 with SMTP id
 d9443c01a7336-2df69bec023mr25035305ad.0.1790149408727; 
 Wed, 23 Sep 2026 00:43:28 -0700 (PDT)
Received: from jfliu-sfa1411.. ([129.227.183.200])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a5d9273sm6406785ad.50.2026.09.23.00.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 00:43:28 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>, freedreno@lists.freedesktop.org,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jianfeng Liu <liujianfeng1994@gmail.com>
Subject: [RFC PATCH v1 2/2] drm/msm: reject dma-buf imports without struct
 page info
Date: Wed, 23 Sep 2026 15:42:23 +0800
Message-ID: <20260923074256.9357-3-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923074256.9357-1-liujianfeng1994@gmail.com>
References: <20260923074256.9357-1-liujianfeng1994@gmail.com>
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

msm_gem_import() fills the GEM object's page array with the deprecated
drm_prime_sg_to_page_array() and stores the attachment sg_table for
later mapping into the GPU's own pagetables via iommu_map_sgtable().
Both need the struct page of the sg_table:

 - iommu_map_sg() maps sg_phys() of each entry, and
 - drm_prime_sg_to_page_array() iterates with for_each_sgtable_page,
   which walks sg->length.

When CONFIG_DMABUF_DEBUG=y, dma_buf_map_attachment() hands importers
a copy of the sg_table with the page pointers stripped and sg->length
zeroed.  In that case drm_prime_sg_to_page_array() "succeeds" while
filling zero entries, leaving msm_obj->pages uninitialized garbage
(kvmalloc_objs() does not zero).  The buffer is imported anyway, and
the first VM_BIND map of it fails asynchronously in the scheduler job
run - after userspace has already enqueued GPU work referencing the
mapping.  Userspace then observes arm-smmu translation faults from
UCHE, e.g. hardware video decode in clapper/chromium:

  gpu fault: ttbr0=000000088a889000 iova=000000010741c000 dir=READ
  type=TRANSLATION source=UCHE

Replace the deprecated helper with an explicit loop so that a missing
or short page list is detected at import time and rejected with
-EINVAL.  This turns the silent memory corruption into a clean import
error, letting userspace fall back instead of crashing the GPU.

Note that msm fundamentally cannot map a page-less sg_table into its
per-process GPU pagetables (it needs the physical addresses), so
imports of such buffers can never work until msm is converted to
build its GPU mappings from the attachment's DMA addresses.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>

---

 drivers/gpu/drm/msm/msm_gem.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index c4cff3d53d81b..0d5a91181d05b 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1307,7 +1307,8 @@ struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 	struct msm_gem_object *msm_obj;
 	struct drm_gem_object *obj;
 	struct dma_buf *dmabuf = attach->dmabuf;
-	size_t size, npages;
+	struct sg_page_iter piter;
+	size_t size, npages, filled = 0;
 	int ret;
 
 	size = PAGE_ALIGN(dmabuf->size);
@@ -1333,8 +1334,32 @@ struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 		goto fail;
 	}
 
-	ret = drm_prime_sg_to_page_array(sgt, msm_obj->pages, npages);
-	if (ret) {
+	/*
+	 * Fill the page array ourselves instead of using the deprecated
+	 * drm_prime_sg_to_page_array(), so that we can detect sg_tables
+	 * that carry no struct page at all.  Those must be rejected:
+	 * msm maps imported buffers into the GPU's own pagetables with
+	 * iommu_map_sgtable(), which needs the physical pages, so an
+	 * import without page information could never be mapped.  The
+	 * most prominent case is the page-stripping sg_table wrapper that
+	 * dma_buf_map_attachment() hands out when CONFIG_DMABUF_DEBUG=y.
+	 *
+	 * drm_prime_sg_to_page_array() would "succeed" with zero entries
+	 * filled in that case and leave msm_obj->pages uninitialized,
+	 * which later blows up as arm-smmu translation faults from UCHE.
+	 */
+	for_each_sgtable_page(sgt, &piter, 0) {
+		if (WARN_ON(filled >= npages)) {
+			ret = -EINVAL;
+			goto fail;
+		}
+		msm_obj->pages[filled++] = sg_page_iter_page(&piter);
+	}
+	if (filled != npages) {
+		DRM_DEV_ERROR(dev->dev,
+			      "import of dmabuf from '%s' rejected: sg_table has no/misaligned struct page info\n",
+			      dmabuf->exp_name ?: "?");
+		ret = -EINVAL;
 		goto fail;
 	}
 
-- 
2.47.3

