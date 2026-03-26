Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BC6106F313
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:43:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F394410EA7C;
	Thu, 26 Mar 2026 09:43:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YckpSQVh";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F04210EA7C
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 09:43:26 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-c70fb6aa323so344085a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 02:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774518206; x=1775123006;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Tnye1hFVkDQbpAqnmBxIM5Wp/Kh6grPEcXAIeFfMKE=;
 b=YckpSQVhcQAiVPuJbPYXcrzyy0o5EGM/Y4QHRx+7YiaB3Y2m78BztJ8MYhCufai33U
 wnJt0jEYZo4txMaZcHY5e2faqEuK5BP1drm4laxPlbHxN+mKU0c5MKtyq5wV3A8XkeQh
 95Zlhvvc2YsnKx1j4JAquAhZZ/oT9WSajEv44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774518206; x=1775123006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7Tnye1hFVkDQbpAqnmBxIM5Wp/Kh6grPEcXAIeFfMKE=;
 b=jbI2eSj2uXB1FhIN8/FIV6BmVxOOhExhmbKqPaMtMezyptDzRd6xZBlJJtJPNws8YJ
 BWm+bomYZ464qQPAdi/Qbb4nxJjHwNrZ84Q/9YSLDJdanDaR74UEpRANo2mmBnL+/GuA
 6E0ccNdJ6G50olVbT8pvOjOgMsaUOtPBqHC+5jALOFRjvFtTwA+ya30msUZYZMS/VuF2
 n73Kww2l7wZYCicWVdUb/3RuGQhgOX8Yh6ERUKNFASMPqmSjpb9w+9Hc+XsUnj3Dhcwq
 YV4X8vStL794yVywr7iGoKxeyX4Z3H3E2nVI/TXipFJwpHxU34GwnJun53Uo3yLIJuMV
 EgKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKoD8jGhm0XXxU3YCdefuV+K0vVZLekaO2Jbg15Ra6fe3J6dGu24DCMo6VN4CRe/2Q6S+K6tpEaqs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzqxzmZvQRkLaFwQ2/1OYzCsj+TJks/1x9VLmv+9IJuIbvxUTXd
 N8clgR/ToU+u65t8j3NSWTbsZd3T0i4HTnYAhuIoyY6bZw4jYpR/NdZ0Kwm7pEHGPA==
X-Gm-Gg: ATEYQzyVvzDi4DfnrQtvQvqrPXxD9JX3cinx1W43ginA8wv5roIkuy9MEHFj53HpibN
 IsnhgsWS1Jp0jWwm1zMy9+GQcHWjHYtpAHAski0hdUIqROEsETtxChUn8y/Uv+TlnUauCPdVsZI
 hQzqxem8EIffLErtpJ0KB43OlJQQIvX8llwuAJyqoE157VcTqbOzpiWH8iFFvyx4KsAhLdl2BmB
 BwOnYT6N0xTlL6Ugv9KSFvjN3wZ/I2jqNJkq4j8sXd76w9GNp+TRbr48MSkyOwF5CttH4RTdU2u
 ZPjr7bucJiyzn/bwgqwRSBUcmwrYnCF+lETMmBe199JG4goMRVkXCF26bdvmF5Ha1/v35umyb9U
 lfQmtZlIA9hsT432dfORl2bO2FhMXFW/b2IgDbFtSYy1X+Lfy+Pfv9T41BELL+z+zOPJC8k20ku
 NxhPiVwXe4XzajQMjAZ9+fm5+ApXIsm3o0K3bUjoKi3b59M+IGrisVaMr5xkQSyMYxWP+XQFFBj
 rh4esZ/kfg7DfywpZE=
X-Received: by 2002:a05:6a20:7f99:b0:39c:39de:3cd2 with SMTP id
 adf61e73a8af0-39c4ab9159fmr7150534637.22.1774518205761; 
 Thu, 26 Mar 2026 02:43:25 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:3ed5:7e63:b37c:a7d7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76737f28fasm1673312a12.7.2026.03.26.02.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 02:43:25 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/exynos: Drop exynos_drm_gem.size field
Date: Thu, 26 Mar 2026 17:43:05 +0800
Message-ID: <20260326094308.1161335-4-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260326094308.1161335-1-wenst@chromium.org>
References: <20260326094308.1161335-1-wenst@chromium.org>
MIME-Version: 1.0
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

A size field is already included in the base GEM object, and is
initialized through drm_gem_object_init() with the same value.

Drop the field in the subclass to save some space. More changes to
make exynos_drm_gem a subclass of drm_gem_dma_object will follow.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/exynos/exynos_drm_fb.c  |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.c | 17 ++++++++---------
 drivers/gpu/drm/exynos/exynos_drm_gem.h |  3 ---
 drivers/gpu/drm/exynos/exynos_drm_ipp.c |  2 +-
 5 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.c b/drivers/gpu/drm/exynos/exynos_drm_fb.c
index ab0e0c74ec47..125b87adfdc4 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fb.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fb.c
@@ -119,7 +119,7 @@ exynos_user_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 			goto err;
 		}
 
-		if (size > exynos_gem[i]->size) {
+		if (size > exynos_gem[i]->base.size) {
 			i++;
 			ret = -EINVAL;
 			goto err;
diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index 85a3a247dfca..e92a4d872c41 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -720,7 +720,7 @@ static int g2d_map_cmdlist_gem(struct g2d_data *g2d,
 			}
 
 			if (!g2d_check_buf_desc_is_valid(g2d, buf_desc,
-							 reg_type, exynos_gem->size)) {
+							 reg_type, exynos_gem->base.size)) {
 				exynos_drm_gem_put(exynos_gem);
 				ret = -EFAULT;
 				goto err;
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
index 9ec76163609f..d9d42809a1a9 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
@@ -55,7 +55,7 @@ static int exynos_drm_alloc_buf(struct exynos_drm_gem *exynos_gem, bool kvmap)
 		attr |= DMA_ATTR_NO_KERNEL_MAPPING;
 
 	exynos_gem->dma_attrs = attr;
-	exynos_gem->cookie = dma_alloc_attrs(drm_dev_dma_dev(dev), exynos_gem->size,
+	exynos_gem->cookie = dma_alloc_attrs(drm_dev_dma_dev(dev), exynos_gem->base.size,
 					     &exynos_gem->dma_addr, GFP_KERNEL,
 					     exynos_gem->dma_attrs);
 	if (!exynos_gem->cookie) {
@@ -67,7 +67,7 @@ static int exynos_drm_alloc_buf(struct exynos_drm_gem *exynos_gem, bool kvmap)
 		exynos_gem->kvaddr = exynos_gem->cookie;
 
 	DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(0x%lx), size(0x%lx)\n",
-			(unsigned long)exynos_gem->dma_addr, exynos_gem->size);
+			(unsigned long)exynos_gem->dma_addr, exynos_gem->base.size);
 	return 0;
 }
 
@@ -81,9 +81,9 @@ static void exynos_drm_free_buf(struct exynos_drm_gem *exynos_gem)
 	}
 
 	DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%lx)\n",
-			(unsigned long)exynos_gem->dma_addr, exynos_gem->size);
+			(unsigned long)exynos_gem->dma_addr, exynos_gem->base.size);
 
-	dma_free_attrs(drm_dev_dma_dev(dev), exynos_gem->size, exynos_gem->cookie,
+	dma_free_attrs(drm_dev_dma_dev(dev), exynos_gem->base.size, exynos_gem->cookie,
 			(dma_addr_t)exynos_gem->dma_addr,
 			exynos_gem->dma_attrs);
 }
@@ -162,7 +162,6 @@ static struct exynos_drm_gem *exynos_drm_gem_init(struct drm_device *dev,
 	if (!exynos_gem)
 		return ERR_PTR(-ENOMEM);
 
-	exynos_gem->size = size;
 	obj = &exynos_gem->base;
 
 	obj->funcs = &exynos_drm_gem_object_funcs;
@@ -287,11 +286,11 @@ static int exynos_drm_gem_mmap_buffer(struct exynos_drm_gem *exynos_gem,
 	vm_size = vma->vm_end - vma->vm_start;
 
 	/* check if user-requested size is valid. */
-	if (vm_size > exynos_gem->size)
+	if (vm_size > exynos_gem->base.size)
 		return -EINVAL;
 
 	ret = dma_mmap_attrs(drm_dev_dma_dev(drm_dev), vma, exynos_gem->cookie,
-			     exynos_gem->dma_addr, exynos_gem->size,
+			     exynos_gem->dma_addr, exynos_gem->base.size,
 			     exynos_gem->dma_attrs);
 	if (ret < 0) {
 		DRM_ERROR("failed to mmap.\n");
@@ -317,7 +316,7 @@ int exynos_drm_gem_get_ioctl(struct drm_device *dev, void *data,
 	exynos_gem = to_exynos_gem(obj);
 
 	args->flags = exynos_gem->flags;
-	args->size = exynos_gem->size;
+	args->size = obj->size;
 
 	drm_gem_object_put(obj);
 
@@ -411,7 +410,7 @@ struct sg_table *exynos_drm_gem_prime_get_sg_table(struct drm_gem_object *obj)
 		return ERR_PTR(-ENOMEM);
 
 	ret = dma_get_sgtable_attrs(drm_dev_dma_dev(drm_dev), sgt, exynos_gem->cookie,
-				    exynos_gem->dma_addr, exynos_gem->size,
+				    exynos_gem->dma_addr, obj->size,
 				    exynos_gem->dma_attrs);
 	if (ret) {
 		DRM_ERROR("failed to get sgtable, %d\n", ret);
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.h b/drivers/gpu/drm/exynos/exynos_drm_gem.h
index b6785f1136ab..3ff9fa9955ea 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.h
@@ -22,8 +22,6 @@
  *	- a new handle to this gem object would be created
  *	by drm_gem_handle_create().
  * @flags: indicate memory type to allocated buffer and cache attruibute.
- * @size: size requested from user, in bytes and this size is aligned
- *	in page unit.
  * @cookie: cookie returned by dma_alloc_attrs
  * @kvaddr: kernel virtual address to allocated memory region (for fbdev)
  * @dma_addr: bus address(accessed by dma) to allocated memory region.
@@ -38,7 +36,6 @@
 struct exynos_drm_gem {
 	struct drm_gem_object	base;
 	unsigned int		flags;
-	unsigned long		size;
 	void			*cookie;
 	void			*kvaddr;
 	dma_addr_t		dma_addr;
diff --git a/drivers/gpu/drm/exynos/exynos_drm_ipp.c b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
index ee3d61345a66..43bc4f63bb84 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_ipp.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_ipp.c
@@ -364,7 +364,7 @@ static int exynos_drm_ipp_task_setup_buffer(struct exynos_drm_ipp_buffer *buf,
 		}
 		buf->exynos_gem[i] = gem;
 
-		if (size + buf->buf.offset[i] > buf->exynos_gem[i]->size) {
+		if (size + buf->buf.offset[i] > buf->exynos_gem[i]->base.size) {
 			i++;
 			ret = -EINVAL;
 			goto gem_free;
-- 
2.53.0.1018.g2bb0e51243-goog

