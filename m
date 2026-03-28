Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88A910D1485
	for <dri-devel@archiver.kernel.org>; Sat, 28 Mar 2026 21:39:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD98510E083;
	Sat, 28 Mar 2026 21:39:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rMzqlMDu";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 226D510E11A
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 21:39:07 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-66bb66db39dso84956a12.0
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 14:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774733945; x=1775338745; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kXnSrL1nik3JfElYjJrrOZj+38qywDMZ4t7LJjjm5fU=;
 b=rMzqlMDufg8m8KuP4UKMMCdVpUqWT3ToeqnVoR72vQEIrD2JGArek3zpOEq2eIQ/B6
 9yBVzMb/zABJ6JTCIKRmKvIIrXKEUroCB9gXe1R3hF2A3URY3tRlEZnlQD6IhZ66SGiy
 tlvCRdLSM7RQJMNBF0GqlRsT8HeHC5T+pyU7ZQMf28HvHDAF7QO8glokwpqbSB/JVxLx
 XqXmSJQs4KI+oZGGRVEeTHz4FPICL8BssBA9BVZN05tEy0+Ct4xVJcBUf6Xa1fMFgfPx
 N+CtLvKSiACePgKRtBZpCEyWY8LD1nRYZILR8FEq+fcZehNjlncGPwPRONGVz44Gr6q7
 seCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774733945; x=1775338745;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXnSrL1nik3JfElYjJrrOZj+38qywDMZ4t7LJjjm5fU=;
 b=ZdcY5fkujVmttlXrCKcdc8TfMl1MWKlDBcFdJ/TElyOGs0PgAU8edjhrlbpQMhUMQS
 /ozuCrgn6bDhEZrOt1x9PQArb+fss7gqhRjR3gxI1MqOl4UnETWk/lh/vsCJyBnNXXUZ
 ivbdHI4U2CmXlha/MTMsw4gSXxGYH0IrSCbfaFFSoO18+7x/e05btfbFXzwIC3zwl/ED
 Na4dAIKsTNMpsbfvPzCRJUR2t5Qf/l9rlH83PA+YJ7hIZe/Sj6tKORSTUyCiccsDyJhg
 ZOz1oPbLkV02M9ft3FkabDNxfKFrC7U/+s9IPGVZpvDDIWY9QJcFGYveSHBtHJGYWg68
 IIdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOWrP0L+NzLSOBR2f37nbCUs4bzIYVBN3WNj7Ou0G0/iLNVv/gFhDfOH9pgHLD3uqMdYE6DyJWMis=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx4Tet3zbOQuavgr5lvNLAdk4HNJt2K4hri/6X0py1LLRKqspc4
 sUmhUermv83AYbIw1GPANVSy9DDnswpzzYNQXw+OVWkGDv5HQw88H+8u
X-Gm-Gg: ATEYQzzMSSb8MR54Zke87PswjBrBZFZYpTcGBumP0TftvLNFgBfQcTmLBx4Xurvnyt0
 toRmjHNw9L/nzlpLZvsSCthZdwigtHfrF4Yy9/FCxeMtRBDlq6vfhhdo8pae1WBcvGTWbJptOLz
 CcWwu0Sbf7euY1zoxIdInc93vuqCMelQZSs0d6G2aq4Us8jtgofdQt7Y7lYw5pzrMeWiqUsCwoh
 3aPWhmThiBXxz2SsZ+0WPZ3cT96xFWUg2kdOPehssjreM6Lsz4gh/2qJ3cxjoTTutg/THLKR7jR
 DwJqdmoKs45JoHFOKZZg+ZIi5acdlSgrEIQHc6TYUJ9e9GhVY+x1fVGhaupREFhVo5CwAgOI4YN
 Ulb3EfYCaVzdIg95Z1gKxFAb2OoW9kSPPE+BdrmC+JTcy9jT7bbwsH2kJsJc4/AqeYdYjvVqp04
 AN4Htyn1SXsq47FQMu58CSGsWxsNWeD7co
X-Received: by 2002:a05:6402:4618:b0:665:e9f:9021 with SMTP id
 4fb4d7f45d1cf-66b2855f8d5mr3612343a12.9.1774733945154; 
 Sat, 28 Mar 2026 14:39:05 -0700 (PDT)
Received: from localhost ([178.214.243.78]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66b75f84708sm909093a12.21.2026.03.28.14.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 14:39:04 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Eric Huang <jinhuieric.huang@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] drm/amdgpu: fix sleeping allocation under spinlock in PASID
 IDR
Date: Sun, 29 Mar 2026 02:39:00 +0500
Message-ID: <20260328213900.19255-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Commit 14b81abe7bdc ("drm/amdgpu: prevent immediate PASID reuse case")
switched from ida to idr_alloc_cyclic() protected by a spinlock, but
passes GFP_KERNEL to the allocator.  idr_alloc_cyclic() may need to
allocate radix-tree nodes, which with GFP_KERNEL can sleep — illegal
under a spinlock that disables preemption.  With CONFIG_PREEMPT or
lockdep enabled this triggers:

  BUG: sleeping function called from invalid context at
       ./include/linux/sched/mm.h:323
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 570
  ...
  #1: ffffffffc2cd24f8 (amdgpu_pasid_idr_lock){+.+.}-{3:3},
      at: amdgpu_pasid_alloc+0x24/0x210 [amdgpu]
  ...
  kmem_cache_alloc_noprof+0x41d/0x780
  radix_tree_node_alloc.constprop.0+0x56/0x3a0
  idr_get_free+0x330/0x830
  idr_alloc_u32+0x14a/0x2e0
  idr_alloc_cyclic+0xd3/0x1d0
  amdgpu_pasid_alloc+0x51/0x210 [amdgpu]

A mutex is not an option because amdgpu_pasid_free() is reachable from
dma-fence callbacks (amdgpu_pasid_free_cb) which may run in IRQ context.

Use idr_preload(GFP_KERNEL) before taking the spinlock to pre-allocate
radix-tree nodes, then pass GFP_NOWAIT inside the critical section so
the allocator draws from the preloaded pool and never sleeps.  This is
the standard kernel pattern for IDR allocation under a spinlock.

Fixes: 14b81abe7bdc ("drm/amdgpu: prevent immediate PASID reuse case")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index d88523568b62..515775eab2ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -67,10 +67,12 @@ int amdgpu_pasid_alloc(unsigned int bits)
 	if (bits == 0)
 		return -EINVAL;
 
+	idr_preload(GFP_KERNEL);
 	spin_lock(&amdgpu_pasid_idr_lock);
 	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
-				 1U << bits, GFP_KERNEL);
+				 1U << bits, GFP_NOWAIT);
 	spin_unlock(&amdgpu_pasid_idr_lock);
+	idr_preload_end();
 
 	if (pasid >= 0)
 		trace_amdgpu_pasid_allocated(pasid);
-- 
2.53.0

