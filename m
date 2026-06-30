Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DCDC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 01:19:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EF7210E129;
	Tue, 30 Jun 2026 01:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jRoQoixk";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8916A10E12E
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 01:19:10 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-8478cc93299so850984b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 18:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782782350; x=1783387150; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CG9x15SuRzEgw1/5hGhYCaNcFyGZnCDooTbzdFZHAVE=;
 b=jRoQoixkfHPr7/ujYjppR/gxroDe/mUv2CiqbCjq0AQxDTI81xoI8eEMWaX5Oji/7W
 3UXmMNifd//+UXYmnukgrQEzxQANfjrYqq+1WzTX5F8dohTSs1SNgYKpA+TyyUFei+WX
 hrwueVQl9x8N7gQH1Nsw/q2Omv2YB2/TkpsN8HWnmBRFvPVbbY7eOCqyZ2QW78Ri+TMe
 W3C+QCyJf49beP6LnnEp98DL41BEqHh653tACwxAgIW7Eno9CITzt+CQvLyyj+4bmo02
 3bqvji2iRul0ss0mPKoEsliPzva0nTjn0KFJyhIMgFcfD3hwxEr61rF5ZoI14VAc5dKV
 Xu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782782350; x=1783387150;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CG9x15SuRzEgw1/5hGhYCaNcFyGZnCDooTbzdFZHAVE=;
 b=NQwuneIi4T07K5EwWTML2opqYO3soXZbnvt7J8Eh7fHcOa4bBKQlFDQzmitl3h68lL
 qwyYRyFr/bFdXtXMYGB3kHL9EdehKpr3+RvSgsyBbd4YIqPTwQiMLdWXSdvc5X3Azu/v
 Q6K0FBPn35/CsGEY+Yfp2lxUa9NBeEEvqnMEDfiShwsYurZEIKikz3IynXBe4EFMv6o4
 EYXyUxiJ+qnD1U8gBAihFr7ubTXb/InjuvoAeMkn8dSrRhNWs6Cg5i7fCU72RdTVciFL
 eeCt6JI8qH+VHfr879JRTvzfmEQaIyBbZ8hILIpRuNf14DgRk2fC2Lld66IndEyoEoUj
 hneg==
X-Gm-Message-State: AOJu0Yyvpi1IQtHVOQpuLZVLTyn0ErEpqjoUPClej8Q5tC3yYFDoO6/x
 pEr0/ncEcUHFN+br39hR4NYzpVkNuWE3ei8wic/E0t+iU2L7x4ndqoiONISBvNrc
X-Gm-Gg: AfdE7cmvWHrGj2fmxrEcNq8iwptppp2YoU0HqocmmKhLstrPhHW7TyiBZQlh+/qaNbu
 4xqZpN+I3nFunGTaBvTV7edFG3X2IhLqaQhHBf6cTGDCcb4iNHbQTXVWPksStHTZxT9uNNL3eJI
 rOuUmzaoHUfam2G9C9MYC0GvHAxlPupli6nblAf/HzJg3oWSLNiXApvpEjbS37dzKzwU0g618ho
 YYl1eCsTxRyETKw2JqxPQPR+koupTE7MJ5TUOijjoiLw8v6LIw8IXXX0rrMJjt3MlqBKZH82KtP
 aBRYp8JiTIeKGKebQ0wqbKXPxwx54btDqB0l+U+wR38MBB/NSaqv9HTD6x7PhC6uuc6zJ8NWig2
 QFZxw7yxqT8By2z/5FPghxOyb4X8oqMEaxNWRcQ813b02hN2RwEtTMx1St+rNRpH/ohctXhdO2x
 LkNbJyFoKWY5mNOVF10i1XwxfG7eTcsFEiP2NRjvVm80B9heWTBHVYW+JiNUPL4SuoLgJt+IHTN
 Gfcm5fElAb1n1O8CK9g
X-Received: by 2002:a05:6a00:84c:b0:842:708f:39be with SMTP id
 d2e1a72fcca58-8479ee9207emr1344406b3a.5.1782782349946; 
 Mon, 29 Jun 2026 18:19:09 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8479ff8f959sm692014b3a.3.2026.06.29.18.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 18:19:09 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 intel-gfx@lists.freedesktop.org (open list:INTEL DRM I915 DRIVER (Meteor Lake,
 DG2 and old...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm: i915: use kzalloc_flex
Date: Mon, 29 Jun 2026 18:19:07 -0700
Message-ID: <20260630011907.1453253-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Simplifies allocations by using a flexible array member in this struct.
No need to free separately.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/i915/gt/intel_gtt.h   |  2 +-
 drivers/gpu/drm/i915/gt/intel_ppgtt.c | 15 +--------------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gtt.h b/drivers/gpu/drm/i915/gt/intel_gtt.h
index f6f223090760..49b2d2d24fd8 100644
--- a/drivers/gpu/drm/i915/gt/intel_gtt.h
+++ b/drivers/gpu/drm/i915/gt/intel_gtt.h
@@ -187,7 +187,7 @@ struct i915_page_table {
 struct i915_page_directory {
 	struct i915_page_table pt;
 	spinlock_t lock;
-	void **entry;
+	void *entry[];
 };
 
 #define __px_choose_expr(x, type, expr, other) \
diff --git a/drivers/gpu/drm/i915/gt/intel_ppgtt.c b/drivers/gpu/drm/i915/gt/intel_ppgtt.c
index 72d8473a448b..20cc59a005c9 100644
--- a/drivers/gpu/drm/i915/gt/intel_ppgtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_ppgtt.c
@@ -36,16 +36,10 @@ struct i915_page_directory *__alloc_pd(int count)
 {
 	struct i915_page_directory *pd;
 
-	pd = kzalloc_obj(*pd, I915_GFP_ALLOW_FAIL);
+	pd = kzalloc_flex(*pd, entry, count, I915_GFP_ALLOW_FAIL);
 	if (unlikely(!pd))
 		return NULL;
 
-	pd->entry = kzalloc_objs(*pd->entry, count, I915_GFP_ALLOW_FAIL);
-	if (unlikely(!pd->entry)) {
-		kfree(pd);
-		return NULL;
-	}
-
 	spin_lock_init(&pd->lock);
 	return pd;
 }
@@ -60,7 +54,6 @@ struct i915_page_directory *alloc_pd(struct i915_address_space *vm)
 
 	pd->pt.base = vm->alloc_pt_dma(vm, I915_GTT_PAGE_SIZE_4K);
 	if (IS_ERR(pd->pt.base)) {
-		kfree(pd->entry);
 		kfree(pd);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -72,12 +65,6 @@ void free_px(struct i915_address_space *vm, struct i915_page_table *pt, int lvl)
 {
 	BUILD_BUG_ON(offsetof(struct i915_page_directory, pt));
 
-	if (lvl) {
-		struct i915_page_directory *pd =
-			container_of(pt, typeof(*pd), pt);
-		kfree(pd->entry);
-	}
-
 	if (pt->base)
 		i915_gem_object_put(pt->base);
 
-- 
2.54.0

