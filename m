Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08A6CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 366C510F682;
	Thu,  1 Oct 2026 13:40:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q1pXbXnf";
	dkim-atps=neutral
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 242F210F6AB
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 13:40:00 +0000 (UTC)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc4d04d73b8so2568977a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 06:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790861999; x=1791466799; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RMOf9/GogbibFylj3xpGTq6kKy08fEk3RcF0K8Q5mJc=;
 b=q1pXbXnfFl2EEV02D4aZOzq9ioYS9qKkgT+hEhnaIfeyQKXqcO7t75WC438iqA1G7a
 loaci+0XkcK13UvvhCGNqKPAt/A1ygm0ZXUERmhKFLKqv1kBZ87E1XoANVgpls0nqBd9
 mUjO1WoGOs1DrtZNiq9xV/EFuYcsambhcZtvSq6wQyaXaySrMfKz/X3GEzHSHal6b/sS
 klbRUnekEBIVmFsCtTyTqa1kH4n+f9CdmTjHN+7Gm467pMjaDlnYsoZ2bGXhYw2Pd7wT
 CTzu/iIsKyuGY+OseWjIWchynYyU5BGptTm3K15iGahsHQZ0cxG5WKAlvHl3ygkXP5vd
 pdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790861999; x=1791466799;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RMOf9/GogbibFylj3xpGTq6kKy08fEk3RcF0K8Q5mJc=;
 b=E8Elu+OBx3+AYaFH0G/EvZQNTvU0q0N67gM32APa1YbX7F/OMYgvHxQ1zZFTkpCNp4
 NjjW0ngAOCDky7qQsPTgARE+v4VNtlepw8I7q1FUDvMq3v+ZfkwwpJOCXelGOK7TqjIY
 0XVba4XgIcv3yGu3REDaKq66/kNkcPZye3UdXRJDAmu+gs5I7IC3GedjcKdbTk1Lv6ud
 zlAOah02ioNU5iEcbC65vOjNHY9iugcOxX/iNkVJb2eydz+sTAPDi5ZPWivP7zGwA8VH
 6Lrk5YJzh2jYg//p24loQ+ZDn1PyT4nOjOdWzi/3/fgd+KC1gzvGVe6y+28qJyF12thQ
 T/yw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSw39EcTDbxezAT1EfsTA5MDU8yoQD1gM7DnQZ/smkTwOqbFQbF/KhmsvZV69w34G9Y0w8SgT+Ewk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIwERxl7LD3MbW2M+2/cAc2faoO5MwUa37CB4jcpLbNst5BjZu3
 SbEVREyjWgRHa36nyUe9qti8WjO4/MO81Mb4fqEgq81T8RRz6O+pc6VG
X-Gm-Gg: AYBFou1vk5jnNG/RJ1gCHr/eqTeExN7bOglacG2iKglWVFInQSYhhB347PVCxrJ3FPY
 me3J7HthC5+HN2b00OB8mK+pUMWdP+s3phUyahBJeLTvWEEQhsUrvOGPEhD3ZRtChcibeNbKpAF
 BHmuItuZUjPTtgalKmCOuTx+To+x7gXN031/IaVVR66NYRtbHjQaTWrdhT75YILni5e6Asa9l59
 aBW39jYxhBTBI26uFyEuaVZidJ3aOXfsr9hgGvqcysdjS9Nboxw407r5CQTjG4tMcERlccmfxeG
 ioAeJoy45e3gjikBC95ueUGWdbYKMAm0B2O25Hv4tq2cd60dkmt/8x2NLhM0I2IElRczd9YO8oX
 ahZsiY7m4Ppe6ESi6u3frGnKz+dcsAi70/RWqwvstvXmBu2g8vMY7kb/9J/ZQtLOwD109Gf0Np+
 n4LdgfPpVHKlkCHwTjk/vN3boKjlimjKk0vgiBgaG9Zpxbwwhp16B+3qsmM9SgkOc=
X-Received: by 2002:a17:90b:4b0d:b0:3a0:ddd6:896c with SMTP id
 98e67ed59e1d1-3a6c2276bcfmr375685a91.17.1790861999525; 
 Thu, 01 Oct 2026 06:39:59 -0700 (PDT)
Received: from [127.0.1.1] ([1.243.227.27]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f47cb357sm4673435a91.17.2026.10.01.06.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 06:39:58 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
Date: Thu, 01 Oct 2026 22:39:12 +0900
Subject: [PATCH v2 1/2] drm/imagination: Fix reference and vm_bo handling
 in remap()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-pvr-fixes-a-v2-1-f58254e5dfb8@gmail.com>
References: <20261001-pvr-fixes-a-v2-0-f58254e5dfb8@gmail.com>
In-Reply-To: <20261001-pvr-fixes-a-v2-0-f58254e5dfb8@gmail.com>
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexandru Dadu <alexandru.dadu@imgtec.com>, 
 Brajesh Gupta <brajesh.gupta@imgtec.com>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Gyeyoung Baek <gye976@gmail.com>
X-Mailer: b4 0.15.1
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

When a map overlaps part of an existing mapping, pvr_vm_gpuva_remap()
splits the mapping into prev/next parts covering what the request did
not take, instead of creating something new. It gets two things wrong.

- A GEM reference is taken for each part but it's never needed and never
  dropped, so it leaks one reference per split (remap-next-in-2m in
  tests/imagination/pvr_vm_map.c):

    CRITICAL: 33558528 bytes of shmem still held after close

- The parts still belong to the original object being split, but
  pvr_vm_gpuva_remap() links them to ctx->gpuvm_bo, the new object's
  vm_bo:

    prev_va --obj--> BO_A          BO_B <--obj-- vm_bo (ctx->gpuvm_bo)
            \___________link___________/  (mismatch: BO_A != BO_B)

  drm_gpuva_link() catches the mismatch:

    WARNING: drivers/gpu/drm/drm_gpuvm.c:2108 at drm_gpuva_link+0x2ec/0x310
      drm_WARN_ON(obj != vm_bo->obj)
    Call trace:
     drm_gpuva_link
     pvr_vm_gpuva_remap
     __drm_gpuvm_sm_map
     pvr_vm_map
     pvr_ioctl_vm_map

  Link them to op->remap.unmap->va->vm_bo instead.

The locking of the GPUVA lists of the other objects touched by a split is
not addressed here; it is handled by switching the GPUVM to immediate
mode.

Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
Reviewed-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_vm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index 55cc999f370..cbdd15ed74f 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -418,6 +418,8 @@ pvr_vm_gpuva_unmap(struct drm_gpuva_op *op, void *op_ctx)
 static int
 pvr_vm_gpuva_remap(struct drm_gpuva_op *op, void *op_ctx)
 {
+	/* The split parts belong to the object of the mapping being split. */
+	struct drm_gpuvm_bo *vm_bo = op->remap.unmap->va->vm_bo;
 	struct pvr_vm_bind_op *ctx = op_ctx;
 	u64 va_start = 0, va_range = 0;
 	int err;
@@ -433,14 +435,12 @@ pvr_vm_gpuva_remap(struct drm_gpuva_op *op, void *op_ctx)
 	drm_gpuva_remap(&ctx->prev_va->base, &ctx->next_va->base, &op->remap);
 
 	if (op->remap.prev) {
-		pvr_gem_object_get(gem_to_pvr_gem(ctx->prev_va->base.gem.obj));
-		drm_gpuva_link(&ctx->prev_va->base, ctx->gpuvm_bo);
+		drm_gpuva_link(&ctx->prev_va->base, vm_bo);
 		ctx->prev_va = NULL;
 	}
 
 	if (op->remap.next) {
-		pvr_gem_object_get(gem_to_pvr_gem(ctx->next_va->base.gem.obj));
-		drm_gpuva_link(&ctx->next_va->base, ctx->gpuvm_bo);
+		drm_gpuva_link(&ctx->next_va->base, vm_bo);
 		ctx->next_va = NULL;
 	}
 

-- 
2.43.0

