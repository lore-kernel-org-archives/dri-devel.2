Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841BD60A2604
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nvrGHNlS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ED8B112671;
	Thu, 19 Nov 2026 17:07:28 +0000 (UTC)
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C4D0112670
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:07:21 +0000 (UTC)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso3040016eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795108041; x=1795712841;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UznqD1ivej2QYO7rN4puPEMrUhaWQ4TH3qb1l1RtxYo=;
 b=nvrGHNlS6R9ZVh96hDDIODPe7hhVpS5OZreTSGUJjg9kFYplD3DylReZeP7F0Zt2q9
 XH1io/cQOFKJPSG4bXv9LhJUPJ9RiesDmkCAnOyFNJr1HuGjnMDZQmecwfKucNZ30bQ7
 Vkvwd0aNaasNI5dxVdUgl6hzXCNgrrWCPLAFNhgNQE+qmIIxooEBbNYm0fb+jgt6V5El
 nGs/wmHEmcKLc9fT3KK/Yh00aPHsEMIumDAMGctaBXETym4QAjUvHH+leTGKw+Zxm+hq
 za2Vgsq7Fn0btM/Um1NDLsLgoL+0myZLfJmPiQpCJ6uoQx1MaZ+aMV0sLjfYzgYOwq6+
 S24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795108041; x=1795712841;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UznqD1ivej2QYO7rN4puPEMrUhaWQ4TH3qb1l1RtxYo=;
 b=JizFzHCRNeu1up8E2FT4zte5omdxBSYLufjY7gkJAqGuh3FWnJXrKQbCgmMZyk5gfa
 WJ0sq2eyS2tTos6nZiUDycrGpTViXF5zLWZNCtLA22h8NPKQEGwM5weT1RxXmu6Cui9R
 E4WZaO92o1Hr77cYkqV6ILh5BCUzGo/dYNnPdrnAwr6ERRIhAzqQc+vRd/fIxkftgriT
 mu3iNzIjXrrw8oHVwPry3PpImq9+FPoBLqAzfvCxQ1ETz4Ku+ToficlM6j66CX3dnDf/
 WPuqWx6d0cD2RtmO03wS1ZvUDYBf0RIuKhbv/Xq8yQs/kWl9hhW+wpnRWSviVVQnv8ef
 8ONg==
X-Forwarded-Encrypted: i=1;
 AL+hErEAjz6bH2XMFAJuh6msQzDdCQVYd5DYT6iz1JF3tOJPtAsJ63aNWSC986/ODq2/7UAwsksV4nRZqBY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z//QpItSjAknQJugLJplQwZu8yOLCnZG1flKlclMesrqWy/CIMv
 T5yVieYeaQVYwwyPIrx84oH1fdpv8YotequZvRPwCJVy7MWjn07ddQgDFkLi+KnMZfrtmxf3xwC
 Ismtwh3ebRw==
X-Received: from dyaw1-n1.prod.google.com
 ([2002:a05:693c:4141:10b0:37a:8a0f:3aba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:dc05:b0:381:6ecf:5389
 with SMTP id 5a478bee46e88-38281cf6a20mr8681249eec.41.1795108040312; Thu, 19
 Nov 2026 09:07:20 -0800 (PST)
Date: Thu, 19 Nov 2026 09:07:16 -0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119170716.1523667-1-irogers@google.com>
Subject: [PATCH] drm/xe/svm: Initialize xpagemap to NULL in
 xe_svm_get_pagemaps()
From: Ian Rogers <irogers@google.com>
To: Matthew Brost <matthew.brost@intel.com>, 
 "=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Elkin Cruz <elkin@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On integrated Intel Xe GPUs (!IS_DGFX), xe->info.mem_region_mask has no
per-tile VRAM bits set, so every iteration of for_each_tile() in
xe_svm_get_pagemaps() hits 'continue' without assigning 'xpagemap'. The
post-loop IS_ERR(xpagemap) check then evaluates an uninitialized stack
pointer on every fault/SVM VM creation.

Initialize 'xpagemap' to NULL so IS_ERR(xpagemap) evaluates false when no
VRAM regions exist.

Found via an x86_64 LLVM=1 (Clang 21.1.8) allyesconfig audit with
-Wconditional-uninitialized enabled; fix and changelog drafted with an AI
coding assistant. Build-tested under LLVM=1 W=1 (-Werror) and
-Wconditional-uninitialized; not runtime-tested on Intel Xe hardware.

Fixes: 8a52f4d9b1ef ("drm/xe: Use the drm_pagemap cache and shrinker")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/gpu/drm/xe/xe_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index bc6902b5bf57..22cc7ed19d8a 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -2055,7 +2055,7 @@ xe_pagemap_find_or_create(struct xe_device *xe, struct drm_pagemap_cache *cache,
 static int xe_svm_get_pagemaps(struct xe_vm *vm)
 {
 	struct xe_device *xe = vm->xe;
-	struct xe_pagemap *xpagemap;
+	struct xe_pagemap *xpagemap = NULL;
 	struct xe_tile *tile;
 	int id;
 
-- 
2.56.1.708.g77570a6a1d-goog

