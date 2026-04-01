Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62330D35153
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 993EF10EDD4;
	Wed,  1 Apr 2026 07:36:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bXNn8vX/";
	dkim-atps=neutral
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com
 [209.85.208.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 965F110EDD4
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 07:36:45 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-38c68e6b62cso46641441fa.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 00:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775029004; x=1775633804; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QcdqkcoFWcnZRoFYPOodBex3IYIVOtQ1sm2KoOI9YB0=;
 b=bXNn8vX/xmaS2XLddn+JuqGbwsjANMBJ1KjF4q2LUvi4ANsfqAshYz0CVAxaMDNDM9
 6YikUGH2spl5oBhQvPK2vdP92PTAf/4nElanpalFzCTpdMrr/eVrl4Kdf7JCts5FhiSa
 j75e6p95RizKQPvZ8Skhp96oJCcoF7hiMdikulKPN6W3tawosijyZz+OgVvC2x7alHgF
 wdYq4KKfBxufoAuATE/oDSlm5UACKBmLqW+j4dMdcOyMP4R3ExZ79HHyr3VwxMlXhCJX
 VPZ+w+iAlF+OxIwG+Pg7nfqoh7vF+IJA5pYQ4jR3V+sQYcn+ao1rGExotFPauNEDxd4y
 J1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775029004; x=1775633804;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QcdqkcoFWcnZRoFYPOodBex3IYIVOtQ1sm2KoOI9YB0=;
 b=UiEWZDtdXPG7wpvH5zLnRnFNdpYev6oJ+6mwj6O9ie0moS1pQFbNeIO+SOoiqFIkEr
 O3XqyvR+64BpC0rBd/3MeiQxcrSuTuxGMki6mYPgbZcDG486hKFXe2UGoq+l9b5nG0VE
 GMt7C2IQZv8fETvWub0C+yGMl+BGBYYYMay7rjkI0ibQNJJ8orLzo6/CiR68Oc8tkMwm
 cNsLlfmNWGUYrlfKJWZ08KAB4kfC6JJUfLeV+VtRJqWIPuGd4yiPV1qJU+nTq8FVgaX5
 tF4m09tyUZW2srlUgaZOntuv+KHlI4GG/ouu/GJMXpP8/I1j8AZnAc6VVO/3xxXIJw9m
 4qDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqlQPdc1gnVJanivGGmjB9J0o9rL36DAClrGrLHaUvWawrkRJZhTiSlxjJ11seOnVB1w6Fh9AKQZk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3XRBWozXfGj4LFlJyGoEcwvykDkeXXSBS2aC6zL8QhewhMhig
 1YT4hStnbtz71hZzVu+NXESYgEAKsAnOex5eAxCxJOOVqL4k1jqk0eWF
X-Gm-Gg: ATEYQzzgvQG+0Ydi4P5C+ffQfoAgFoLGBwZX6fg0Z7Yg49cby5pzH70dfSStq1eoRrB
 9y2Eihh5cVjQ5G99OOiFxctd17Cm4L0v7NejnNpoRe6PKfxsUxI8mUqksP9mGpIyilhDTJAvDRz
 QEoZj+G/FMOy9z244X0Zb18w1AA7BtTqmknxrb/5gThjCr6jicvhJKgTlPX6ZPPDWBYWcc5Q7ip
 tibkdCNfDfgo1BUZqiF0wKM8TOK+Up2BY4Kk9sotTdC6q19suoAMKxHzE4O4NKWfbWcQHjhD5tW
 /bGVPtDu0Xya8d8PEu0Hn8rP7h4ysQRZH2weqBmu93SVVjgEMH9P0A9n0HOjr/kGVlzh3H02LGO
 EC0o6A1Ec01KbQ0QBK2RYPSqqY9tNXtOTyXsxWpGBUCkarHLwXqRj2ZV0eKY4yFK0fKiiR2hGSn
 dIeVPVN5ht0BbYpXio+1wqhNjyEIDDbjK3Sg==
X-Received: by 2002:a05:6512:1152:b0:5a2:7d1a:4043 with SMTP id
 2adb3069b0e04-5a2c1f1972amr911388e87.20.1775029003339; 
 Wed, 01 Apr 2026 00:36:43 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b1443f23sm3230048e87.42.2026.04.01.00.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 00:36:42 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] drm/amdgpu: use IRQ-safe xarray API for PASID management
Date: Wed,  1 Apr 2026 12:36:32 +0500
Message-ID: <20260401073632.101796-1-mikhail.v.gavrilov@gmail.com>
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

xa_alloc_cyclic() and xa_erase() use plain xa_lock()/xa_unlock()
regardless of XA_FLAGS_LOCK_IRQ — the flag only affects lockdep
annotations, not runtime locking.

Switch to xa_alloc_cyclic_irq() and xa_erase_irq() which use
xa_lock_irq/xa_unlock_irq internally, fixing the IRQ safety issue
for amdgpu_pasid_free() called from hardirq via fence callbacks.

Fixes: a3c0ee978e16 ("drm/amdgpu: replace PASID IDR with XArray")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index a6ac3b4ce0df..64d0da28441f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -68,7 +68,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
 	if (bits == 0)
 		return -EINVAL;
 
-	r = xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
+	r = xa_alloc_cyclic_irq(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
 			    XA_LIMIT(1, (1U << bits) - 1),
 			    &amdgpu_pasid_xa_next, GFP_KERNEL);
 	if (r < 0)
@@ -85,7 +85,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
 void amdgpu_pasid_free(u32 pasid)
 {
 	trace_amdgpu_pasid_freed(pasid);
-	xa_erase(&amdgpu_pasid_xa, pasid);
+	xa_erase_irq(&amdgpu_pasid_xa, pasid);
 }
 
 static void amdgpu_pasid_free_cb(struct dma_fence *fence,
-- 
2.53.0

