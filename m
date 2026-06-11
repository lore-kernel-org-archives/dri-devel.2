Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BC4CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 13:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 847A810EF0C;
	Thu, 11 Jun 2026 13:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W2gtE65Z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12BD710EEF9;
 Thu, 11 Jun 2026 13:02:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EE047443D7;
 Thu, 11 Jun 2026 13:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633081F0089C;
 Thu, 11 Jun 2026 13:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781182965;
 bh=LaunKh9fq8CcYIKd3nFETlqAjeP/HHTp66QUxPtcxXI=;
 h=From:To:Cc:Subject:Date;
 b=W2gtE65ZxuXJt0Y6NB3AMdDKp/h7quuqkCyq6s16JY+us2X6m349Jk1RquS7Ybgb8
 fLMWdNhu726eIABMj4Gpw9cTSB7wleaJAb297g4+PxVAR2m0QRhJD5rLdbmdMEmSPL
 x+EoTf4IROJpclbqL7KKYgvV0C0YDunCY+Te36R66NgSPe11wSPfXos5tai6QXUZDq
 xleU9fNmDhIX7s7AhW5OQ+YWwoj0MayBE/3EopNztqjLuK/IEyK4nLs6ZkkE0uHN9I
 kV1Y95Glpd0E+mFfByqSDNZN0jJTrcyR1FOdiDWTdMLJb84r2ZcnyXfCvVUf7PzNde
 qUc9q0hiDDp5Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] amdgpu: lockdep: move temporary mutexes off stack
Date: Thu, 11 Jun 2026 15:02:33 +0200
Message-Id: <20260611130240.3388318-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
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

From: Arnd Bergmann <arnd@arndb.de>

In randconfig builds, the newly added function frequently exceeds
the limit for stack frames, like:

drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c:84:5: error: stack frame size (1312) exceeds limit (1280) in 'amdgpu_lockdep_init' [-Werror,-Wframe-larger-than]

Change this to use static allocation for the locks to reduce
this at the expense of a slightly larger driver binary.

Fixes: 1d0f5838b126 ("drm/amdgpu: Add lockdep annotations for lock ordering validation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c | 24 ++++++---------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
index d5d71fd7c70d..cf723c9f9216 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
@@ -85,13 +85,13 @@ int amdgpu_lockdep_init(void)
 {
 	struct amdgpu_reset_domain *reset_domain = NULL;
 	struct amdgpu_reset_control reset_ctl;
-	struct mutex userq_sch_mutex;
-	struct mutex userq_mutex;
-	struct mutex notifier_lock;
-	struct mutex vram_lock;
-	struct mutex srbm_mutex;
-	struct mutex grbm_idx_mutex;
-	spinlock_t mmio_idx_lock;
+	static DEFINE_MUTEX(userq_sch_mutex);
+	static DEFINE_MUTEX(userq_mutex);
+	static DEFINE_MUTEX(notifier_lock);
+	static DEFINE_MUTEX(vram_lock);
+	static DEFINE_MUTEX(srbm_mutex);
+	static DEFINE_MUTEX(grbm_idx_mutex);
+	static DEFINE_SPINLOCK(mmio_idx_lock);
 	unsigned long flags;
 
 	/*
@@ -102,16 +102,6 @@ int amdgpu_lockdep_init(void)
 	if (!reset_domain)
 		return -ENOMEM;
 
-	/* Initialize dummy locks */
-	mutex_init(&userq_sch_mutex);
-	mutex_init(&userq_mutex);
-	mutex_init(&notifier_lock);
-	mutex_init(&vram_lock);
-	mutex_init(&reset_ctl.reset_lock);
-	mutex_init(&srbm_mutex);
-	mutex_init(&grbm_idx_mutex);
-	spin_lock_init(&mmio_idx_lock);
-
 	/*
 	 * Associate dummy locks with the same class keys used for real
 	 * driver locks. This ensures lockdep connects the ordering learned
-- 
2.39.5

