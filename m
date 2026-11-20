Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C954606A331
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iQQdJRHw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F1FD112BC4;
	Fri, 20 Nov 2026 16:17:44 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64A7610E05E
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 03:11:57 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-93f20c3aaa5so45825085a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 19:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795144316; x=1795749116; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PfLDjrfdwYTniLwtWaqO0Y6QOqwiPoyn88w0QJPjNII=;
 b=iQQdJRHwttfk0XE3rncJxcIdJgzWr9MDqxC0dJdmPwiv9MPhQ+fz6JgHDpOLWRPked
 YpL+DOehqeDjiAmbe4xO5f6O9czOLeYKmir/18dZbvaXSFUZ2loDt0eochYnsBT7kGVt
 5V1IVZzstNBj5zQz/zIWTSDkhlYBo+o1fpOIVdkpqnUFChndDXeXp0MR+eso1P+gbNDv
 Ue3H6xirXH+6G1TcomXPDGX0kNJIizMgIQUk6Dqn6NL7Qf4YESK5QzQB/RZNveNgueA5
 1suG5we4jn5kuqKlPAYnM8El7tZtpg1L2xXIfZQxA42VWM7suRijzPCTNDjhqOjAnxU3
 RqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795144316; x=1795749116;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PfLDjrfdwYTniLwtWaqO0Y6QOqwiPoyn88w0QJPjNII=;
 b=d6IIbm5GJSp+pq48vXI9nx3VImYXo4Ahx8sdo45QS7Gb4KDYajzI7XV+3ZnrWMy3M0
 XviLO9VYrLVkHYi34twHtKs2NSlShSXahu7xCauWzudw9iX3E+7ZonEJW0yLlZ6rtKPp
 AdnBTLdXpkSQzrSKunYQVTLTTmpuFLngMK15umZZw0juKQQJta3HV5V6fGiSakAEDOxl
 CESNxjJhD60Wv9YZ325CGZEc+VKd4C6w0bl51KZOtC2qk67n3MzfIm/zP300VQTI+c5d
 uF8t9jwjzLc/vOnVsX8gD1IXR2FWNADMPoXy9QmhbKkw4JHPjPSndbjhsYYEow4+UyeE
 Pi8A==
X-Forwarded-Encrypted: i=1;
 AL+hErG7whd9OlFPEl7nccsFhtb9UOZPUnj+s6HN8IBZLjCoK0yaPZi+mtpEEjKB9AxmeaAC8vFTFmFvzuA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9UR65uWVi9nEnqfOcHR+FlkDH/2p3ZVrCmlF0zTLlUs0XnVofb
 zb/UFec99GhaAWj6dJgQ+8qLl2CvaTtFISfyKa8Z/sUUv4odCbzMjYya
X-Gm-Gg: AYBFou2XsSd+rg9UmnceGM4HVx6cfCIgzlXGVXoIP1rWakSxOc6QdLyzZX0RPB5Q1qM
 SIjdUMn9O+Hguc8Dhc74on7FkQRjH8skH9Uaumi0dJjSyuMn4bM0X6wvieaEIWnGlNnWVyF4PbK
 aHqepEr6rRpUdUbgmxLZzzb6XCHT+aCpFWXzqZgZ8oSjc3t8gC1mNsgIoBqpQYRg42ZQXIKGdYo
 6Jg3S5aRe6iGQKhaPMuSRGdqrzxYhEl66VV2brTrUejoQajD3hvKvVYMRsYkPzVgnleko2KRORN
 tjCimu86qSPOfJHy1XcfxbPRSU+j8YaLiKKF2d3NoS8QW0C9yYcBh9C5sKnxGgP/hFyYwEcxY0K
 yEaiATAFUnDK22fHccLkyVcyT0enrbJqLZP9a6KfVsPAIY39+PdCGfrI/1b6aRT01L1Xe3p352q
 OO+460rBkJbkYTkXoErX+x0DJLRtCEunqJZrvbmR1Rxez6ovyhPma4wHbMiJ+ImC/8e4/vd+04/
 /YGPZ004u0YOO91hy+n05FLISGWNUJ5iPw+m/T8z7bFnVL813VpVweBdXscL/DS/kQmEz4wgPr+
 /iksab1OBCiAbivCa5WG3GUSOR+aHHS1onTGlZyI5TlL8SdMtsu8+z/Oy7FaeGmhi4r8LMETWmV
 c8Fal+3fIyyrjk4KFs9ng
X-Received: by 2002:a05:620a:2996:b0:93e:6620:bde7 with SMTP id
 af79cd13be357-949ba9b71admr305091385a.20.1795144316405; 
 Thu, 19 Nov 2026 19:11:56 -0800 (PST)
Received: from linux.. ([8.34.174.240]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb38319asm100211885a.16.2026.11.19.19.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 19:11:56 -0800 (PST)
From: Changyul Lee <lcy8047@gmail.com>
To: Zack Rusin <zack.rusin@broadcom.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, 
 Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
 Martin Krastev <martin.krastev@broadcom.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH] drm/vmwgfx: Reserve the buffer during surface lookup
Date: Thu, 19 Nov 2026 22:11:52 -0500
Message-ID: <20261120031152.1696587-1-lcy8047@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 16:17:37 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A GEM reference keeps the buffer alive, but it does not keep its
surfaces alive. vmw_bo_surface() walks the buffer's resource tree
without holding the buffer reservation. A concurrent surface release
can remove and free a surface while the lookup is still using its
tree node. The caller enters its RCU read-side critical section only
after the walk.

Reserve the buffer before calling vmw_bo_surface() and keep it
reserved until the lookup has tried to take a surface reference.
The reservation prevents the surface from being detached during
the lookup, and kref_get_unless_zero() rejects a surface whose
reference count has already reached zero. Assert that the caller
holds the reservation in vmw_bo_surface().

Fixes: d6667f0ddf46 ("drm/vmwgfx: Fix handling of dumb buffers")
Signed-off-by: Changyul Lee <lcy8047@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c      | 2 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index a6d7156e4281..625c4b33daa2 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -864,6 +864,8 @@ struct vmw_surface *vmw_bo_surface(struct vmw_bo *vbo)
 	struct vmw_surface *surf = NULL;
 	struct rb_node *rb_itr = vbo->res_tree.rb_node;
 
+	dma_resv_assert_held(vbo->tbo.base.resv);
+
 	if (vbo->is_dumb && vbo->dumb_surface) {
 		res = &vbo->dumb_surface->res;
 		goto out;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index 3064a2a960e1..13548fdfa84c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -877,6 +877,7 @@ vmw_lookup_user_surface_for_buffer(struct vmw_private *vmw, struct vmw_bo *bo,
 	struct vmw_surface *surf;
 	struct ttm_base_object *base;
 
+	ttm_bo_reserve(&bo->tbo, false, false, NULL);
 	surf = vmw_bo_surface(bo);
 	if (surf) {
 		rcu_read_lock();
@@ -891,6 +892,7 @@ vmw_lookup_user_surface_for_buffer(struct vmw_private *vmw, struct vmw_bo *bo,
 		}
 		rcu_read_unlock();
 	}
+	ttm_bo_unreserve(&bo->tbo);
 
 	return user_srf;
 }

base-commit: af1cf92e8617a7f7aa24b415596cbf64b76a12e7
-- 
2.43.0

