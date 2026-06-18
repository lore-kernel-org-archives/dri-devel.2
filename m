Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B194FCD98F5
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 05:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C88C710F174;
	Thu, 18 Jun 2026 05:52:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nHm+NOfF";
	dkim-atps=neutral
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23C1B10F174
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 05:52:43 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-5ad4f1cf3cdso324027e87.1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 22:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781761961; x=1782366761; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lUW7N1WdM4gjkll3SORybiTywWoSQednVL16A3MVWc4=;
 b=nHm+NOfF0It/6+K5AKoBRdrjC+xbXrVtO+3F7e1/hKxMkE4l44NFVNHF9VoXgTbY36
 JJ6KVPKPPAjZ6CN9BCAKoMfdGJ35hHgABFKD6fyBvr4SQP7xdFtLVVrnNAfJfftDCdRk
 hjn9NEDp2M8G6wh9c/BCiBUlpvU4funSPH6xDQzxggT6R3Eb6Yul3uanzBciMKJfoX39
 3hvNMYSG3CXQcsYv+g1G/PO3a0xqNqBQ+AB3HahqCVGwStK9hsAaj8kk8Aw1u3nUbJPI
 gx3EcTK/0l4/w8gwNEsxSeCcBUcqFM6JGlGjirs5D2tOGNjcI70QlOzX0Z6meWZPJk11
 /PZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781761961; x=1782366761;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lUW7N1WdM4gjkll3SORybiTywWoSQednVL16A3MVWc4=;
 b=L8bXZKHBStsh3mjh93ZxA5gyum9hKuEJ+JAmxC3F+8eu+qyg/14Q2xoJjnXY8XoOBX
 0w1C3unXTAukqbtXiKu/HeG2fVbqOQP2jKQboH7cLtzNF3XmUgU0yiUFMZpJYiW9OaIc
 K1/ceYKl2x0aLV++rNpKT7B+rqMk3wpLyFj0HKuJ6uPSM3Zj/cve8d+Fpixe2XYOAqzk
 znn/yMwkmo7J67ERyZTWQOe909odFXZLRG44/Kf14Bpi6nCJyG9f/PSvEik8556LX6iq
 D3hLjGdA9eNMdxZtRcohvluTUYeB0mJJ/2tigx1UB6SH4W5rjDXUst9EfRUZCaL4gqAy
 MB7Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jLuQp1hA9pkJ+OcexSEma3gaKq25ORdbVCEAXZ2v7DZr/ecLqBedXOKRsW7ic4CKKhXpERjXsJ2s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMvQCBF+2+7kFYfpgGQyxf7foyDmN2pI8UlbCqv7VyEbQEidP0
 hmIj0RChksJATCxkBX7FeghslJxFspUkwshYnV/qvDEDDRGAfJoZXXH+
X-Gm-Gg: AfdE7cmqwQrjBnj2GIotmfZdPzCXTMDRGLUolsLlQKIw3fcRZSOnrQhuGkv4UwgaAiH
 cLA9y3FlKl98JBan8a7CpCPlymKS2TzKwmy7UJPJrC7UyoKwMUHOSK3ugPBY61B58lxX7mTkWlz
 4ALp+1f9Lx5Rg+nP8LgkUguN6jH+2iDhmcKoKpuinEBGsBC56qzSWWZcufUFr9l1/OYf8IrHbOL
 oGSWdPGpt+M2JxFGRqrrjhFeWsb95hYsYDA1ahCOFNdhOG1ZgiRl+Ht0W3aPDpZABb3xgg9mHhq
 Id/usdhRv7a2F+K7P4HNdxO8ypg5st/9lSH51g4jXY9NBmildiMcebLKJ2VVmS7C6n7gRtP1CpX
 YHzYqaCG7yXbbzlO5E0g4X59GkDBKS7sreabvYR8s+orvjQsfTs8V4LeN/JmxsgDjWQVutgW7kW
 iAF/9d3KQypd3wqlSX6780jQ==
X-Received: by 2002:a05:6512:6381:b0:5ad:4a8d:cf29 with SMTP id
 2adb3069b0e04-5ad4d650fdamr502051e87.12.1781761961132; 
 Wed, 17 Jun 2026 22:52:41 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161ee7sm5031554e87.13.2026.06.17.22.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 22:52:39 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] drm/amdgpu: do not enter fs_reclaim under notifier_lock in
 lockdep training
Date: Thu, 18 Jun 2026 10:52:16 +0500
Message-ID: <20260618055216.56191-1-mikhail.v.gavrilov@gmail.com>
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

amdgpu_lockdep_init() trains lockdep on the driver lock ordering by
taking a chain of dummy locks in order and calling fs_reclaim_acquire()
in the middle of it. The fs_reclaim_acquire()/fs_reclaim_release() pair
is placed while notifier_lock (amdgpu_notifier_lock_key) is held, which
teaches lockdep that it is legal to enter memory reclaim with the MMU
notifier lock held:

  notifier_lock -> vram_lock -> reset_domain->sem -> reset_lock ->
  fs_reclaim

notifier_lock is, however, acquired from the MMU notifier invalidate
callback amdgpu_hmm_invalidate_gfx(), which mm/ runs from inside memory
reclaim via __mmu_notifier_invalidate_range_start(). That establishes
the mandatory reverse ordering:

  fs_reclaim -> mmu_notifier_invalidate_range_start -> notifier_lock

The two together form a cycle. It stays dormant until reclaim first
unmaps a page covered by an amdgpu userptr interval notifier, at which
point kswapd closes the loop and lockdep reports a false circular
locking dependency:

  WARNING: possible circular locking dependency detected
  kswapd0/268 is trying to acquire lock:
   (&amdgpu_notifier_lock_key){+.+.}, at: amdgpu_hmm_invalidate_gfx
  but task is already holding lock:
   (mmu_notifier_invalidate_range_start){+.+.}, at: try_to_unmap_one

A lock that is taken inside an MMU notifier callback must never be held
across a reclaiming allocation, so the fs_reclaim annotation does not
belong inside the notifier_lock region. Drop it. The remaining chain
still teaches the intended lock nesting.

Fixes: 1d0f5838b126 ("drm/amdgpu: Add lockdep annotations for lock ordering validation")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
index d5d71fd7c70d..eeb3b5007f80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
@@ -150,12 +150,6 @@ int amdgpu_lockdep_init(void)
 	/* Level 6: Reset control lock */
 	mutex_lock(&reset_ctl.reset_lock);
 
-	/*
-	 * Mark potential memory reclaim boundary.
-	 * GPU operations might trigger memory allocation/reclaim.
-	 */
-	fs_reclaim_acquire(GFP_KERNEL);
-
 	/* Level 7: SRBM register access */
 	mutex_lock(&srbm_mutex);
 
@@ -175,8 +169,6 @@ int amdgpu_lockdep_init(void)
 	mutex_unlock(&grbm_idx_mutex);
 	mutex_unlock(&srbm_mutex);
 
-	fs_reclaim_release(GFP_KERNEL);
-
 	mutex_unlock(&reset_ctl.reset_lock);
 	up_read(&reset_domain->sem);
 	mutex_unlock(&vram_lock);
-- 
2.54.0

