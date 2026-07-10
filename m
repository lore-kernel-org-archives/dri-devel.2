Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B59C4450E
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 19:08:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E9F910F970;
	Fri, 10 Jul 2026 19:08:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Le8KTyLI";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06CD310F965
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 19:08:08 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493c52cde9eso10887635e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 12:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783710486; x=1784315286; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IOmjbtLYRqKMFq3vRWGT3hOtZz67iXQHbJfJ46cKOMg=;
 b=Le8KTyLIGLaA6v8sZadV65LV/7w46D5ggqmcWAgLzSW2OUnj8mjDM6Fc2t1goVxJ/E
 7IBCR0VO+upogSVpwBCkF4J5qvGP/uommSjsMKz55Qxsg2luoS/dlo5F5fMGVmebv1g4
 LFiymyno3MZpYcGiOD6FAOLYwWIFiDqTsJSiy3L4HzGDCVxhE/wagJoZAJrL4J7fJcsc
 JcTWPmNU/pdwvOeUbObxvhNj5Cg7Suv9EUadr53olIU3ASOI5TAWbk3jK+PnwptTzD5J
 cMj6aoQ1eKKW2aUqQ/sJqDksdCXvyENC2uGLomZdLnnOB7n3TcOh9Fvm145wijPtaDLo
 1qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783710486; x=1784315286;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IOmjbtLYRqKMFq3vRWGT3hOtZz67iXQHbJfJ46cKOMg=;
 b=OPJ0o3sVOBUADfHp/TVlEvRc2SrvbP3Qt2mxNyA+9Qml+KNwZ6YradczDdt41a44im
 Re2CZ7xtI+X7o2wG2l2NXs2uCXgT0I5ShY8sfWJuHcZDKvdiUszQpvod9i1SQxmn1Lzo
 4Ij7AP50yBRekhOJ5HGhXVwLx/N+m+qXZIuVJgvkRYh2Y6MuPtqXS8iSoC7xWJukptGq
 Z/92wkW2x4bu6nI6S3Eii+eiDpAImNh4+BOkKQbjx8QGKBiOEkkd1c0cIBh76isrQIGS
 eLSu8P6OMl3rSIiflGGP6M4wIKp2NsrjMd8wGLZM8u0wYE2vdezivLZPXWrSJwo+1m00
 cbUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpKCmPLgwOm9tZDpJ40y91X65sxxa+GH668aUIc7DtPJOnm/YnN6EoZu9YU+oCjS98kG/Mr7HQoHSg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzWJ4xl7+ArLIXiqrE2aTSaRW4vYbuIFM+nM4B+xIRAaZY4R9BS
 Cwr7MUCpWun3ou3WuHTiUbb5V/FgqUITnZ5Kv8aQDYi5uujYUa4TDu55
X-Gm-Gg: AfdE7cn7My+/lc7bPSfghM5bKsLpjNBK8NvsHsXTNOQTm97PCnk+g3m1aoc5qktpv6N
 pmDTmSI6TNgyaEHbkLBhh/LffjlHjVP+9nPL9t23ymQzccw8goEwv63KBLDNKIlbOBr00DiHAKB
 vmr12HpIe6ryVKdMGtF4VpFwSbI4GF/CDiC0/PDn1O0AIkszsCbGWm3tJqjBaVEpKpqWBjMYyKq
 yRApjQc5eYWP9yEzi/Obcs9NY8tyTu17qXlqgBeZupBlv/bBrwbPQyk2T2Q142Wb0aXx6gLcrHS
 gcGVv1nHflv2jsULeTboF18cZw3V4dwXsOBCPqcU6M//C0sxXSWIUnlExRzrDbztbas3z0+n6+s
 Nimn+i1BReBnYFL+CQpZXtvVZoElPydxVklyUktRsSwmcSRCiTnIxQmzgJl4X6Sa4uZMnIZUOYK
 x4wGlenzZSm+LuTJfYOV0nWAMXgg==
X-Received: by 2002:a05:600c:5849:b0:493:b55f:bca2 with SMTP id
 5b1f17b1804b1-493f88389cemr678085e9.34.1783710486348; 
 Fri, 10 Jul 2026 12:08:06 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:154f:ec00:aa08:de24:db33:4496])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f567eadfsm55000755e9.6.2026.07.10.12.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 12:08:05 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 simona@ffwll.ch, matthew.brost@intel.com, nat@pixelcluster.dev,
 airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/12] drm/amdgpu: use drm_exec during BO validation
Date: Fri, 10 Jul 2026 20:52:52 +0200
Message-ID: <20260710190752.2355-13-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710190752.2355-1-christian.koenig@amd.com>
References: <20260710190752.2355-1-christian.koenig@amd.com>
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
Reply-To: christian.koenig@amd.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

This allows to detect deadlocks happening because of resource
constraints.

Especially submissions which want to use all of GDS doesn't result in
sporadic -ENOMEM any more.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 82 ++++++++++++++------------
 1 file changed, 44 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index c2e6495a28bc5..17223e295ff25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -793,7 +793,7 @@ static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
 	struct ttm_operation_ctx ctx = {
 		.interruptible = true,
 		.no_wait_gpu = false,
-		.resv = bo->tbo.base.resv
+		.exec = &p->exec,
 	};
 	uint32_t domain;
 	int r;
@@ -845,7 +845,10 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 				union drm_amdgpu_cs *cs)
 {
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
-	struct ttm_operation_ctx ctx = { true, false };
+	struct ttm_operation_ctx ctx = {
+		.interruptible =true,
+		.exec = &p->exec
+	};
 	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_list_entry *e;
 	struct drm_gem_object *obj;
@@ -899,6 +902,11 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		e->user_invalidated = userpage_invalidated;
 	}
 
+	amdgpu_cs_get_threshold_for_moves(p->adev, &p->bytes_moved_threshold,
+					  &p->bytes_moved_vis_threshold);
+	p->bytes_moved = 0;
+	p->bytes_moved_vis = 0;
+
 	drm_exec_until_all_locked(&p->exec) {
 		r = amdgpu_vm_lock_pd(&fpriv->vm, &p->exec, 1 + p->gang_size);
 		drm_exec_retry_on_contention(&p->exec);
@@ -922,47 +930,48 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 			if (unlikely(r))
 				goto out_free_user_pages;
 		}
-	}
 
-	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
-		struct mm_struct *usermm;
+		amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
+			struct mm_struct *usermm;
 
-		usermm = amdgpu_ttm_tt_get_usermm(e->bo->tbo.ttm);
-		if (usermm && usermm != current->mm) {
-			r = -EPERM;
-			goto out_free_user_pages;
-		}
-
-		if (amdgpu_ttm_tt_is_userptr(e->bo->tbo.ttm) &&
-		    e->user_invalidated) {
-			amdgpu_bo_placement_from_domain(e->bo,
-							AMDGPU_GEM_DOMAIN_CPU);
-			r = ttm_bo_validate(&e->bo->tbo, &e->bo->placement,
-					    &ctx);
-			if (r)
+			usermm = amdgpu_ttm_tt_get_usermm(e->bo->tbo.ttm);
+			if (usermm && usermm != current->mm) {
+				r = -EPERM;
 				goto out_free_user_pages;
+			}
 
-			amdgpu_ttm_tt_set_user_pages(e->bo->tbo.ttm,
-						     e->range);
+			if (amdgpu_ttm_tt_is_userptr(e->bo->tbo.ttm) &&
+			    e->user_invalidated) {
+				amdgpu_bo_placement_from_domain(e->bo,
+								AMDGPU_GEM_DOMAIN_CPU);
+				r = ttm_bo_validate(&e->bo->tbo, &e->bo->placement,
+						    &ctx);
+				drm_exec_retry_on_contention(&p->exec);
+				if (r)
+					goto out_free_user_pages;
+
+				amdgpu_ttm_tt_set_user_pages(e->bo->tbo.ttm,
+							     e->range);
+			}
 		}
-	}
 
-	amdgpu_cs_get_threshold_for_moves(p->adev, &p->bytes_moved_threshold,
-					  &p->bytes_moved_vis_threshold);
-	p->bytes_moved = 0;
-	p->bytes_moved_vis = 0;
+		r = amdgpu_vm_validate(p->adev, &fpriv->vm, NULL,
+				       amdgpu_cs_bo_validate, p);
+		drm_exec_retry_on_contention(&p->exec);
+		if (r) {
+			drm_err(adev_to_drm(p->adev), "amdgpu_vm_validate() failed.\n");
+			goto out_free_user_pages;
+		}
 
-	r = amdgpu_vm_validate(p->adev, &fpriv->vm, NULL,
-			       amdgpu_cs_bo_validate, p);
-	if (r) {
-		drm_err(adev_to_drm(p->adev), "amdgpu_vm_validate() failed.\n");
-		goto out_free_user_pages;
-	}
+		drm_exec_for_each_locked_object(&p->exec, obj) {
+			r = amdgpu_cs_bo_validate(p, gem_to_amdgpu_bo(obj));
+			drm_exec_retry_on_contention(&p->exec);
+			if (unlikely(r))
+				goto out_free_user_pages;
 
-	drm_exec_for_each_locked_object(&p->exec, obj) {
-		r = amdgpu_cs_bo_validate(p, gem_to_amdgpu_bo(obj));
-		if (unlikely(r))
-			goto out_free_user_pages;
+			amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
+						     p->bytes_moved_vis);
+		}
 	}
 
 	if (p->uf_bo) {
@@ -973,9 +982,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		p->gang_leader->uf_addr += amdgpu_bo_gpu_offset(p->uf_bo);
 	}
 
-	amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
-				     p->bytes_moved_vis);
-
 	for (i = 0; i < p->gang_size; ++i)
 		amdgpu_job_set_resources(p->jobs[i], p->bo_list->gds_obj,
 					 p->bo_list->gws_obj,
-- 
2.43.0

