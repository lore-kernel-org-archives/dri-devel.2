Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E420C5DF66
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C02510E347;
	Sun, 16 Aug 2026 19:43:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qF4JfDYy";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86DCB10E34B
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 19:43:19 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-38ea87caafeso2020607a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786909399; x=1787514199; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vQV907MxENOHehwyCp9rz0FCgUqiCVS0Fmif7CccKAA=;
 b=qF4JfDYynQ3uVY2hXB/FHFzSU8IkQdf1efAktgCg4BEWMWwmweUX4j6zGI7WIdRTk4
 mMuO0lhHzJ0y/80mXqIwocDQKVjiQao0cMdpP8AJ0c3a9EYMa3wKtgrukueTn8YBa1C2
 g6DUO+8LxEvxRIfcsO6/64f1oFUg1Ls/+je0+nv8wp3IFkUZgG3jczfKzkj0Uh71QcoE
 5LUGvsIkQdCjewWi93khbO38/a89wujwJqI2ORdrdiJXZeC3JX+iei7nGeOmrLJRUvxv
 wvblCIjP2XGxj8eQybgjgdLim6oGkpSfiX5vwakxVFgcsLuW51kMAKLQiaBzM8HI780D
 64NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786909399; x=1787514199;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vQV907MxENOHehwyCp9rz0FCgUqiCVS0Fmif7CccKAA=;
 b=HQskgrNGz1TkpWzm2nB1V6ZzUmQ4USVCcl+oZsw7MRiwvCX/6Qh7MEwkpIdyrluxbQ
 fuoH0U2NCatNGKzXoEL4Krqrzf1b6fIxXkjZgIdY743nCd/rOaYBPro6iEpE0DkQ24zU
 +wsi1PDN6848iVC2pYMk2MLfMDFZBS1iRjP8+GKsqb630rbGnrUfWrfcNZhw3oXnqn24
 cIrB5yzn1HUd9wpRRXkLhoD9/DoSBNu1ZYRyYtebcRYNWGGTDwfJqn6gA9CikPqAqLSI
 CmA4GOZyJp02Xn6P3BHU6e75TWt4J5Oo+d0lL0o4e6zogNuONoVw+7WNGGrHsV64hUcJ
 kbHA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9hpHPm8jdr+zaV8TepcvRM56abH8q+AsHhyDJsLdE3IBx/UV7qEeTv7Cy0JrXoQD9kopvFc0xtWU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcjnRmX3zi00qJs72OD26q5VQoFhCjwnx6Tshv4K4lWScnvu2M
 aE7z3tjH56T7MZ0N9GCpgeRXDt3uwsiJh90RtcC08FPZBMVU/4ojKcls
X-Gm-Gg: AR+sD11PH1QYLzg+pRr+R3RXCoplngfUIh6H0C2EfL4U+FRhux0ioBc6Nkw/hLeFMlr
 KLKeXoc5s14Z9si++LBtiDH+RBzcI+dDxsaqdLWlMLwwPiCsPGlL3xwJHzA4StHII6TTp0WiuBH
 pAv4TOPwzsbybC4ERCi9HorQIGUbHdgSUTm7caP7z57jlKScVdj+lHTZN5PoF9l6MOAwcygH4+L
 wTbU6tCirAuSPcPZ9X+G35at0cNqIQmJX6dTjOIpJjLB5CvAxQjc7mlLhS6fdPmoQOMItljiHNp
 4ZwQp6usQh6DwjP00DvXWm2pOfYFnRlWo+ETzVL6aRLLcY49bSjFhY2lujqKinv7cfBZHmhXZ5H
 rSjQZZ/s+5zDKJbKhXFvk2vkTLAQ2JFWjquX4YnVZPPT05ar08P89+Gi14infXOXUXKGL3cMFod
 qGXTHSYDWoZSaTrRXTymlD+i5+gZO2d/6I9YT6c+nv1tD5I6CIZNfsDA==
X-Received: by 2002:a17:90b:5606:b0:381:25ce:bcc2 with SMTP id
 98e67ed59e1d1-3933b78b698mr21706032a91.6.1786909398914; 
 Sun, 16 Aug 2026 12:43:18 -0700 (PDT)
Received: from [127.0.1.1] ([1.243.227.27]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395320229f4sm2141310a91.15.2026.08.16.12.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 12:43:18 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
Date: Mon, 17 Aug 2026 04:42:08 +0900
Subject: [PATCH 1/4] drm/imagination: Fix the vm_bo split mappings are
 linked to
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-pvr-vm-bind-v1-1-0a0f21be7d38@gmail.com>
References: <20260817-pvr-vm-bind-v1-0-0a0f21be7d38@gmail.com>
In-Reply-To: <20260817-pvr-vm-bind-v1-0-0a0f21be7d38@gmail.com>
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matt Coster <opensource@mtcoster.net>, 
 Donald Robson <donald.robson@imgtec.com>, 
 Sarah Walker <sarah.walker@imgtec.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Gyeyoung Baek <gye976@gmail.com>
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

A remap does not map anything new. It splits an existing mapping and
re-creates the parts the request did not cover, and that mapping is handed
to the callback in op->remap.unmap->va, carrying the &drm_gpuvm_bo those
parts belong to.

However, pvr_vm_gpuva_remap() linked the parts to
pvr_vm_bind_op::gpuvm_bo, which belongs to the object the request maps
rather than the object the parts came from.

Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_vm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index 396d349fb6c..608e8c0467d 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -418,6 +418,8 @@ pvr_vm_gpuva_unmap(struct drm_gpuva_op *op, void *op_ctx)
 static int
 pvr_vm_gpuva_remap(struct drm_gpuva_op *op, void *op_ctx)
 {
+	struct drm_gpuva *unmap_va = op->remap.unmap->va;
+	struct drm_gpuvm_bo *vm_bo = unmap_va->vm_bo;
 	struct pvr_vm_bind_op *ctx = op_ctx;
 	u64 va_start = 0, va_range = 0;
 	int err;
@@ -434,18 +436,18 @@ pvr_vm_gpuva_remap(struct drm_gpuva_op *op, void *op_ctx)
 
 	if (op->remap.prev) {
 		pvr_gem_object_get(gem_to_pvr_gem(ctx->prev_va->base.gem.obj));
-		drm_gpuva_link(&ctx->prev_va->base, ctx->gpuvm_bo);
+		drm_gpuva_link(&ctx->prev_va->base, vm_bo);
 		ctx->prev_va = NULL;
 	}
 
 	if (op->remap.next) {
 		pvr_gem_object_get(gem_to_pvr_gem(ctx->next_va->base.gem.obj));
-		drm_gpuva_link(&ctx->next_va->base, ctx->gpuvm_bo);
+		drm_gpuva_link(&ctx->next_va->base, vm_bo);
 		ctx->next_va = NULL;
 	}
 
-	drm_gpuva_unlink(op->remap.unmap->va);
-	kfree(to_pvr_vm_gpuva(op->remap.unmap->va));
+	drm_gpuva_unlink(unmap_va);
+	kfree(to_pvr_vm_gpuva(unmap_va));
 
 	return 0;
 }

-- 
2.43.0

