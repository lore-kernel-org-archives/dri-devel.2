Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD7EC44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FAC510E869;
	Mon,  6 Jul 2026 10:09:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.b="kATjUqnK";
	dkim-atps=neutral
Received: from 5.mo533.mail-out.ovh.net (5.mo533.mail-out.ovh.net
 [54.36.140.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F8AE10E867
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 10:09:00 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4gv0SV4sZBz66ZF;
 Mon,  6 Jul 2026 10:08:58 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.deucher@amd.com>; Mon,  6 Jul 2026 10:08:58 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.118.90])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gv0SV3YcQz7tLG; Mon,  6 Jul 2026 10:08:58 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.11])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 750D78E1901; 
 Mon,  6 Jul 2026 10:08:56 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R0055796c633-823e-421a-8789-d7c0475bcf91,
 F224CF1D020274B13B21E639C91833BCDAC0997A) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
From: Natalie Vock <nat@pixelcluster.dev>
Date: Mon, 06 Jul 2026 12:07:52 +0200
Subject: [PATCH v2 10/10] drm/amdgpu: use drm_exec during BO validation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260706-ttm_2_drm_exec-v2-10-4bf6bfc0d320@pixelcluster.dev>
References: <20260706-ttm_2_drm_exec-v2-0-4bf6bfc0d320@pixelcluster.dev>
In-Reply-To: <20260706-ttm_2_drm_exec-v2-0-4bf6bfc0d320@pixelcluster.dev>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.15.2
x-ovh-tracer-id: 9131611196327616828
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGrlNJ8ShesFc0BsmoWFi51A7F15j2IaCkSK7BVZBg/BM8MBdGhyqLZmkbZMHw/TdptOPm8sgahQti1Nc9RjBh0KMZiGtpja+p6qhts3jrWUso58aRKRrx2DXtHoeXDd8faKpktnEASA9l57md6lmCqaecpmqLv9KOaMd5Cxk2fFcLRCf7Y1jiwLpKZwWHOg5MLCHSu/c85HhHBD+9tK6DpmR22NTjUbN0dGZJB9cmuuQPGLboQ0v7ZPGbXkip9C+NIKd694im0qBCyEcUf/DwxdiDWy9o5iBQA1zQlg0Y75Jpr3La1ocQctyDO3tKJ1UAaq83N/bdymi3oIi31d22YoBwaV6S4+7wx+MgMCAkshuFAYAtz/AfGr6I3hor+Y7lZW7dEb1uLDV2wbmKC3QD1fMvDma6KWvllxG6QQDWBlDqIVrDcFFPuio1GdZ3KW7GxpPlQt0Mq53xKhocm+4eKKPYWbi7eWEEkS1NeGn8v2GCU3Sg0RVcJQHWuksUNdHOIWBJA/QqtrZd5SxJRN2sf19r6oXE3YCMZSqbGT0e7oKdKXtGuXR8JCtQGwX+CZwliBAGiPLDqEQt69J0xNj8qwWaL3h+2nLwCsiBkQXYKUQzxwkmBqMuOkqhukP4mGtBliFdmjLt6B/H6xnmJ4kx51oPKJXcDigWABKY3Wn2Y6g
DKIM-Signature: a=rsa-sha256; bh=pbTL1gLxQx0BxNCVq/hEgyFIwea3jgeRxwgqZhg0jzU=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1783332539; v=1;
 b=kATjUqnK7pryV6J5UaqojO9SZ9jUV+uYS8x/i2SKKUiGU2y0OqN6au/5znYjEB+OJBHybkVU
 0BhghqWu17XmZAgQZoxFwmQbmHNfWnsa2GzBD5QVgGSRjayYYAnkA2yPszW9oT5aG4hvRG8mppF
 pYz76DzGOOi0jecrRrmbSRO0+lzj1SnR1InHt1Wr2LcgePtB3qzL+B0sXKGOXyEQbf3JkLQr/Us
 Oar30eGu23sFRJ6ABxQ9e/hXYqqXj0+xPG7Cu7A2Pbey56uvT6+d9UKQHB7CL1jFBa8lxsIV7Ae
 vqyvsBgBBYDE2TQK8YNWIzRJOtG0yXcGkzFStIEE+6x8w==
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

This allows to detect deadlocks happening because of resource
constraints.

Especially submissions which want to use all of GDS doesn't result in
sporadic -ENOMEM any more.

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 80 ++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index c2e6495a28bc5..052d41013f7a0 100644
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
@@ -845,7 +845,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 				union drm_amdgpu_cs *cs)
 {
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
-	struct ttm_operation_ctx ctx = { true, false };
+	struct ttm_operation_ctx ctx = { .interruptible = true,
+					 .exec = &p->exec };
 	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_list_entry *e;
 	struct drm_gem_object *obj;
@@ -922,47 +923,53 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 			if (unlikely(r))
 				goto out_free_user_pages;
 		}
-	}
-
-	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
-		struct mm_struct *usermm;
 
-		usermm = amdgpu_ttm_tt_get_usermm(e->bo->tbo.ttm);
-		if (usermm && usermm != current->mm) {
-			r = -EPERM;
-			goto out_free_user_pages;
-		}
+		amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
+			struct mm_struct *usermm;
 
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
-
-	r = amdgpu_vm_validate(p->adev, &fpriv->vm, NULL,
-			       amdgpu_cs_bo_validate, p);
-	if (r) {
-		drm_err(adev_to_drm(p->adev), "amdgpu_vm_validate() failed.\n");
-		goto out_free_user_pages;
-	}
+		amdgpu_cs_get_threshold_for_moves(p->adev, &p->bytes_moved_threshold,
+						  &p->bytes_moved_vis_threshold);
+		p->bytes_moved = 0;
+		p->bytes_moved_vis = 0;
 
-	drm_exec_for_each_locked_object(&p->exec, obj) {
-		r = amdgpu_cs_bo_validate(p, gem_to_amdgpu_bo(obj));
-		if (unlikely(r))
+		r = amdgpu_vm_validate(p->adev, &fpriv->vm, NULL,
+				       amdgpu_cs_bo_validate, p);
+		drm_exec_retry_on_contention(&p->exec);
+		if (r) {
+			drm_err(adev_to_drm(p->adev), "amdgpu_vm_validate() failed.\n");
 			goto out_free_user_pages;
+		}
+
+		drm_exec_for_each_locked_object(&p->exec, obj) {
+			r = amdgpu_cs_bo_validate(p, gem_to_amdgpu_bo(obj));
+			drm_exec_retry_on_contention(&p->exec);
+			if (unlikely(r))
+				goto out_free_user_pages;
+		}
+
+		amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
+					     p->bytes_moved_vis);
 	}
 
 	if (p->uf_bo) {
@@ -973,9 +980,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		p->gang_leader->uf_addr += amdgpu_bo_gpu_offset(p->uf_bo);
 	}
 
-	amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
-				     p->bytes_moved_vis);
-
 	for (i = 0; i < p->gang_size; ++i)
 		amdgpu_job_set_resources(p->jobs[i], p->bo_list->gds_obj,
 					 p->bo_list->gws_obj,

-- 
2.55.0

