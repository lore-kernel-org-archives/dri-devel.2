Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A337DC55838
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 06:52:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B830010F0DD;
	Thu,  6 Aug 2026 06:52:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=xbow.com header.i=@xbow.com header.b="YUUfvwXh";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C72F810ED60
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 08:01:52 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-38e041ea211so788186a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 01:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xbow.com; s=google; t=1785916912; x=1786521712; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AUz5eQQY4ZXKNBZLMrPCzNtvBb314GGu8HHfd2z4ufg=;
 b=YUUfvwXhVqhdvigyBqxTZ8HcRpZRwqESUMyclD1BCKfauXsfOGJFRrLSOapnbqezRW
 Mc5s+ezr4IrJTEcOdJHmWHiWgf8Td6Vbl+VHC9SfM2/ILu2xW+1KiIYCiuuyC/DYjULi
 T1gzwSRCj12A273cpf2fz0S9riCHoJHrsy1/VIzUR3br2Xyd9o+07NO4cgu6FEeMXViV
 Vuc4DMkLDvhww8BMozrxuk9dOZzbGaSA96wXEGMfhxt38Ol6NTCUoX7sgJUipHQqPFYt
 NVuANiKulYdoQ2nSZCW8/PmiiU9kyWWmzKuYuYyUcB1urvHHdkzQ7K3aJIwlZetZyZsL
 yrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785916912; x=1786521712;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AUz5eQQY4ZXKNBZLMrPCzNtvBb314GGu8HHfd2z4ufg=;
 b=EMB2DP60Dhsnc88c7k0MvO4VMowjP3w14s0zo9To6nSOeN2i//n8Ma9eHsPz0he0kL
 DR7pDqRaQMiUyJrjSmVND14YdZVHqmM/M5d1FsAZlHBuSHX7K/1bOiCH+djh/D/09PZY
 zAXelbpADcze/ji7vljG7b3sk2IKCmkeFpXdE0RNz5hLALVlUM4HZLGxHp0wVXTxH4ia
 FQ+UUlRsKXmJXd4VrFL2m8vfyqmH0+1RruAaCkOGa24OQJy9DTYyKWaVQuX/tqoYn7jY
 ieIUVFLIUw+bz4qJn/4ixv94bXACB9EWZyrOvcHBvDIPzdPBuOW+qDMUzjJNS29sm7c5
 TC3g==
X-Gm-Message-State: AOJu0YxeAvCJ2zG+AQ4qgqFvnMLJTICm/080PxWwd837MkGlofKvJ8sI
 EDYcgxL8YxB7CjPkZcLxud7F8gphYvsldfnvl35lR7QL1Q1JFPbFFOirtmxN8E6EAuo=
X-Gm-Gg: AR+sD11bZwnCHaYYKGHWAEZWATAgKxsYFGqjFX0DlmDn+18OhhQYg6pvhw4fIrA02LR
 MWj9wvVr6ZvkR89H/tWkd6TrzIeky20KsWFre7LxLNoI6qAKb/ELiiOj9dyVKqcyWfZGiqiWckG
 mHpv8QC1gotQ34ZQdOr1EOTKox5dIQlg3+D3mzZm7owEdriYYm27nPz72br55iCfNMO6YnE7SDa
 c8YCtFPJk0C10SXyK5sucPEdnO9C9cIWsW1sC5Yvc/Ow412Hb9EUMI/iqWgrq187ViAz1HSs5FU
 4Nd8UOrTaXdB182PNqohrOWcgOE7HsY1jxJO5PMrKvR4dyqDwodhPaQ6Qs7jCVg/rfwZ3kt5Hbb
 2RN+qyGseJfx6X/oOHaN33EXHAfVSI99vgfJVPCtqEdcRzNS7O9XkFQrBgemjPqUmO18J7OWZM/
 /osEtXTPTo8MSjBGrAPHUMS/MSY1z8wpTsuv+spSS8zp9T1Dx97lhpudECXIOtf+D7d7xZxf3Ey
 sjeCfy62YkR6RwJ5ReeECvb89m5
X-Received: by 2002:a17:90a:ec8b:b0:38f:aab1:5148 with SMTP id
 98e67ed59e1d1-3903c5d313bmr5059257a91.13.1785916912122; 
 Wed, 05 Aug 2026 01:01:52 -0700 (PDT)
Received: from Mac.lan ([125.128.148.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38febfdae62sm3922263a91.1.2026.08.05.01.01.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Aug 2026 01:01:51 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 federico.kirschbaum@xbow.com, stable@vger.kernel.org,
 Baul Lee <baul.lee@xbow.com>
Subject: [PATCH] drm/gem-dma: bound the mmap against the object size
Date: Wed,  5 Aug 2026 17:01:47 +0900
Message-ID: <20260805080147.12564-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 06:52:41 +0000
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

drm_gem_dma_mmap() passes the caller's request, not the object, as the
size of the buffer being mapped:

	ret = dma_mmap_wc(drm_dev_dma_dev(dma_obj->base.dev), vma,
			  dma_obj->vaddr, dma_obj->dma_addr,
			  vma->vm_end - vma->vm_start);

dma_direct_mmap() derives its page count from that size, so count and
user_count are the same number and the bounds test degenerates into
"vm_pgoff must be zero":

	unsigned long user_count = vma_pages(vma);
	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
	...
	if (vma->vm_pgoff >= count || user_count > count - vma->vm_pgoff)
		return -ENXIO;

remap_pfn_range() then installs writable PTEs for every frame the caller
asked for, starting at the object and running past its end.

On the DRM node that is unreachable: drm_gem_mmap_obj() rejects a VMA
larger than the object before the object's mmap function runs.  The fbdev
emulation does not go through it.  drm_fbdev_dma_fb_mmap() calls
drm_gem_prime_mmap(), which invokes obj->funcs->mmap() directly, so
/dev/fb0 accepts a length that /dev/dri/card0 refuses for the same object.

The framebuffer is contiguous CMA inside system DRAM, so the excess
mapping covers kernel-owned RAM, readable and writable, at an offset the
caller picks.  On arm64 a 1 GiB mapping of an 8294400-byte framebuffer
object was accepted, and writes through it landed in the private memory
of another unprivileged process.  Nothing is logged: every access comes
from userspace through a PTE the kernel installed.  open() and mmap() on
/dev/fb0 are enough, so any member of group video reaches it.

Pass the object size to the DMA layer, which makes the dma_direct_mmap()
test meaningful, and check the VMA length the way drm_gem_mmap_obj() does
so both nodes reject the same request.

Fixes: b79fe9abd58b ("drm/fbdev-dma: Implement fbdev emulation for GEM DMA helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 drivers/gpu/drm/drm_gem_dma_helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem_dma_helper.c
--- a/drivers/gpu/drm/drm_gem_dma_helper.c
+++ b/drivers/gpu/drm/drm_gem_dma_helper.c
@@ -531,6 +531,9 @@ int drm_gem_dma_mmap(struct drm_gem_dma_object *dma_obj, struct vm_area_struct *
 	struct drm_gem_object *obj = &dma_obj->base;
 	int ret;

+	if (obj->size < vma->vm_end - vma->vm_start)
+		return -EINVAL;
+
 	/*
 	 * Clear the VM_PFNMAP flag that was set by drm_gem_mmap(), and set the
 	 * vm_pgoff (used as a fake buffer offset by DRM) to 0 as we want to map
@@ -543,12 +546,12 @@ int drm_gem_dma_mmap(struct drm_gem_dma_object *dma_obj, struct vm_area_struct *
 		vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);

 		ret = dma_mmap_pages(drm_dev_dma_dev(dma_obj->base.dev),
-				     vma, vma->vm_end - vma->vm_start,
+				     vma, obj->size,
 				     virt_to_page(dma_obj->vaddr));
 	} else {
 		ret = dma_mmap_wc(drm_dev_dma_dev(dma_obj->base.dev), vma,
 				  dma_obj->vaddr, dma_obj->dma_addr,
-				  vma->vm_end - vma->vm_start);
+				  obj->size);
 	}
 	if (ret)
 		drm_gem_vm_close(vma);
-- 
2.50.1 (Apple Git-155)

