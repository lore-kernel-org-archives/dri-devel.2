Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB5DCD342F
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 06:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E372610F374;
	Fri,  8 May 2026 06:57:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=quora.org header.i=@quora.org header.b="Fg148Ifz";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B6E210F369
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 06:57:30 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2ba928852a5so11130975ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 23:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quora.org; s=google; t=1778223450; x=1778828250; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TetnCK6YoCpHxJceDDOD/QB+oKi7cDlyFmiU7j9vyl4=;
 b=Fg148Ifz4z82MpRZspkofvPaR5ppXVugAHpVhEEyMQ0W2HG/X9qbj5roP6TGy6cjYR
 f11vbEJdojEnDwHc7bXo7gW87e7EbCXSs/fvZtKz8qJbnuP0qrAeuu8NCnxvyUdShpEa
 0G8hI/MXL81jquvhMBR5Wx/mUcnmMEu4Uzh7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778223450; x=1778828250;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TetnCK6YoCpHxJceDDOD/QB+oKi7cDlyFmiU7j9vyl4=;
 b=a51+q+icNW0d7K+Q5Hnc//Zrx969VF40xMbMS14WnB9CsmLO+p9+tRYZ+in0gvk7ms
 O8SredP9nhmPwffbdXX2BSntPIU14H24bXfSLl0VIGs3B8gXYI/Lxvojz4lVtXelA3gv
 eK5BYlCWczw7hMlLenRYt6KFNEdHyDiTAtLws9rLHVKQVHaDxZUlWr8iwcwxSA5p6jox
 pnnHf1x9H/etJKTkz/xe6Kw4qBwYUwexF8Bgx71/RDqn+PD+ZlEYUo3rlyqFIzthSAjn
 AT9qf29dlr4jP276Rld3TWhnxKrg1RtCGfcnPZRLVNFzOz1EpIpCHh9dLoniAAP67dVz
 Te+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/PDtz/6b+LFOcO/fBEG7j/taZsCSqcn5uE1tONE4LaOw5AYpLvs2tleoLkWZzPvwSu4je43gXr36c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4qogwB/wXqSbnnjVBBjEyY4q0uX7HHHH4phG6XpgeYy48fwWf
 pq/Yv0kRsH14f2xMfmPJQvygzAA54ccWLfdr8c1A9wEAqY3TqF7kSCGE94nMepw+0KQ=
X-Gm-Gg: Acq92OHz/GU+bmpcL0ogGLq5NBzuCFMtZMOBGB/q+CRXBPGwVJ/kFPvYV/d5ZLOVm5z
 l5N3QnAAMg2v+VeMyC8NhaoHGkbVbBtHGGIFKw2nyi0oev367XfBUzJOKCloH0dwVVwg5aFBuVz
 c8av22jgXSZK/S1KA5Kcp/Mttey1VO0w/DQJp8EJq2DoPIKP3Iy8aM/LMbgoR8ol54WlAhzFpFr
 FwFYdeBDYngz2uci8yIGt6CK4nn+y+bkzeFgZ57j6Owzq+gd9dlp2gj+K/JV5zp6F6KaWx4ICth
 k5d38cmJsgXO6LeqnXVoK2rYkDvW3WPXh4l15WA6i9swvDpmNKm2B+48Pt3LZbA84quVVO51Lgs
 IHLC+EUnx2QaFCNGDMhcvsnEE3dRfG2wEFa/+8zct0iH6D+ytbf2M1FcIGgam/u1cO/2HEROkp7
 5qrqgX1IS0dnvS69Y4FTNaRz4LHBnZmWqiKtXfAYvnD/eonJaTdG8MwF9BWkpWhbq1l5Kge9992
 kCXz79GiUgAIwrQg2izJ2wVHBzavP6GmjDaipj5R8P1AwHukOUAtpeUwSHMUqstoUIT6/wQrVnR
 Qw5ZynFc299VVCgHH94xxiUSxsq/AFa1U9RVgQQBi4t3EULUSKkAuzccb1uRAqq+
X-Received: by 2002:a17:903:3c2b:b0:2b9:ea53:4cfc with SMTP id
 d9443c01a7336-2ba794b8118mr117896365ad.19.1778223450102; 
 Thu, 07 May 2026 23:57:30 -0700 (PDT)
Received: from aegis ([2001:fd8:4d01:3602:5317:86f3:5298:5270])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1ead938sm10650785ad.73.2026.05.07.23.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 23:57:29 -0700 (PDT)
From: Daniel J Blueman <daniel@quora.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: Daniel J Blueman <daniel@quora.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] drm/msm: Fix shrinker deadlock
Date: Fri,  8 May 2026 14:57:21 +0800
Message-ID: <20260508065722.18785-1-daniel@quora.org>
X-Mailer: git-send-email 2.53.0
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

With PROVE_LOCKING on an Snapdragon X1 and VM reclaim pressure, we see:

"""
kswapd0/121 is trying to acquire lock:
ffff800080ed3800 (reservation_ww_class_acquire){+.+.}-{0:0}, at:
  msm_gem_shrinker_scan (drivers/gpu/drm/msm/msm_gem_shrinker.c:189)

but task is already holding lock:
ffffbf4ddb44ca40 (fs_reclaim){+.+.}-{0:0}, at:
  balance_pgdat (mm/vmscan.c:7236 (discriminator 2))

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (fs_reclaim){+.+.}-{0:0}:
lock_acquire (kernel/locking/lockdep.c:5868 kernel/locking/lockdep.c:5825)
fs_reclaim_acquire (mm/page_alloc.c:4325 mm/page_alloc.c:4339)
dma_resv_lockdep (drivers/dma-buf/dma-resv.c:798)
do_one_initcall (init/main.c:1392)
kernel_init_freeable (init/main.c:1454 (discriminator 1) init/main.c:1470
  (discriminator 1) init/main.c:1490 (discriminator 1) init/main.c:1703
  (discriminator 1))
kernel_init (init/main.c:1593)
ret_from_fork (arch/arm64/kernel/entry.S:858)

-> #1 (reservation_ww_class_mutex){+.+.}-{4:4}:
lock_acquire (kernel/locking/lockdep.c:5868 kernel/locking/lockdep.c:5825)
dma_resv_lockdep (./include/linux/ww_mutex.h:164 (discriminator 1)
  drivers/dma-buf/dma-resv.c:791 (discriminator 1))
do_one_initcall (init/main.c:1392)
kernel_init_freeable (init/main.c:1454 (discriminator 1) init/main.c:1470
  (discriminator 1) init/main.c:1490 (discriminator 1) init/main.c:1703
  (discriminator 1))
kernel_init (init/main.c:1593)
ret_from_fork (arch/arm64/kernel/entry.S:858)

-> #0 (reservation_ww_class_acquire){+.+.}-{0:0}:
check_prev_add (kernel/locking/lockdep.c:3165)
__lock_acquire (kernel/locking/lockdep.c:3284
  kernel/locking/lockdep.c:3908 kernel/locking/lockdep.c:5237)
lock_acquire (kernel/locking/lockdep.c:5868 kernel/locking/lockdep.c:5825)
drm_gem_lru_scan (./include/linux/ww_mutex.h:163 (discriminator 1)
  drivers/gpu/drm/drm_gem.c:1681 (discriminator 1))
msm_gem_shrinker_scan (drivers/gpu/drm/msm/msm_gem_shrinker.c:189)
do_shrink_slab (mm/shrinker.c:436)
shrink_slab (mm/shrinker.c:667)
shrink_one (mm/vmscan.c:5071)
shrink_node (mm/vmscan.c:5132 mm/vmscan.c:5210 mm/vmscan.c:6198)
balance_pgdat (mm/vmscan.c:7052 mm/vmscan.c:7228)
kswapd (mm/vmscan.c:7501)
kthread (kernel/kthread.c:436)
ret_from_fork (arch/arm64/kernel/entry.S:858)

other info that might help us debug this:

Chain exists of:
reservation_ww_class_acquire --> reservation_ww_class_mutex --> fs_reclaim
"""

kswapd0 holding fs_reclaim calls the MSM shrinker, which calls
dma_resv_lock. This in turn acquires fs_reclaim.

Fix this deadlock by using dma_resv_trylock() instead, dropping the
subsequently unused passed wait-wound lock 'ticket'.

Cc: stable@vger.kernel.org
Signed-off-by: Daniel J Blueman <daniel@quora.org>
Fixes: fe4952b5f27c ("drm/msm: Convert vm locking")
---
 drivers/gpu/drm/msm/msm_gem_shrinker.c | 34 ++++++++++----------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index 31fa51a44f86..5320ef57dd90 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -43,8 +43,7 @@ msm_gem_shrinker_count(struct shrinker *shrinker, struct shrink_control *sc)
 }
 
 static bool
-with_vm_locks(struct ww_acquire_ctx *ticket,
-	      void (*fn)(struct drm_gem_object *obj),
+with_vm_locks(void (*fn)(struct drm_gem_object *obj),
 	      struct drm_gem_object *obj)
 {
 	/*
@@ -52,7 +51,7 @@ with_vm_locks(struct ww_acquire_ctx *ticket,
 	 * success paths
 	 */
 	struct drm_gpuvm_bo *vm_bo, *last_locked = NULL;
-	int ret = 0;
+	bool locked = true;
 
 	drm_gem_for_each_gpuvm_bo (vm_bo, obj) {
 		struct dma_resv *resv = drm_gpuvm_resv(vm_bo->vm);
@@ -60,23 +59,14 @@ with_vm_locks(struct ww_acquire_ctx *ticket,
 		if (resv == obj->resv)
 			continue;
 
-		ret = dma_resv_lock(resv, ticket);
-
 		/*
-		 * Since we already skip the case when the VM and obj
-		 * share a resv (ie. _NO_SHARE objs), we don't expect
-		 * to hit a double-locking scenario... which the lock
-		 * unwinding cannot really cope with.
+		 * dma_resv_lock can't be used due to acquiring 'ticket' before the
+		 * fs_reclaim lock, which is held in shrinker context
 		 */
-		WARN_ON(ret == -EALREADY);
-
-		/*
-		 * Don't bother with slow-lock / backoff / retry sequence,
-		 * if we can't get the lock just give up and move on to
-		 * the next object.
-		 */
-		if (ret)
+		if (!dma_resv_trylock(resv)) {
+			locked = false;
 			goto out_unlock;
+		}
 
 		/*
 		 * Hold a ref to prevent the vm_bo from being freed
@@ -108,7 +98,7 @@ with_vm_locks(struct ww_acquire_ctx *ticket,
 		}
 	}
 
-	return ret == 0;
+	return locked;
 }
 
 static bool
@@ -120,7 +110,7 @@ purge(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket)
 	if (msm_gem_active(obj))
 		return false;
 
-	return with_vm_locks(ticket, msm_gem_purge, obj);
+	return with_vm_locks(msm_gem_purge, obj);
 }
 
 static bool
@@ -164,7 +154,6 @@ static unsigned long
 msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
 {
 	struct msm_drm_private *priv = shrinker->private_data;
-	struct ww_acquire_ctx ticket;
 	struct {
 		struct drm_gem_lru *lru;
 		bool (*shrink)(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket);
@@ -185,11 +174,14 @@ msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
 	for (unsigned i = 0; (nr > 0) && (i < ARRAY_SIZE(stages)); i++) {
 		if (!stages[i].cond)
 			continue;
+		/*
+		 * 'ticket' not needed on trylock paths
+		 */
 		stages[i].freed =
 			drm_gem_lru_scan(stages[i].lru, nr,
 					 &stages[i].remaining,
 					 stages[i].shrink,
-					 &ticket);
+					 NULL);
 		nr -= stages[i].freed;
 		freed += stages[i].freed;
 		remaining += stages[i].remaining;
-- 
2.53.0

