Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CEEC88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 728E210E0EB;
	Mon, 14 Sep 2026 18:27:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OyH+teWK";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC1B910E0EB
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 18:27:44 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f633cd80so1033509f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 11:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789410463; x=1790015263; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QtinZDaa2vVKSqBwDg7kga2GKJXc4vSPzazNjm4AtY4=;
 b=OyH+teWKqrM+xzQdXlD2jUcmC3xTkL6ByCcEeAOHmcn0h/AJJRng7j07cHGM7uORIh
 cdd3yWTSiohRV8cQn/FA6KDhsijzHLLKkDWl1s3LScfUQnUudPNGStMihk8WqfM7TRQA
 2q5Xxr1B+gmy9piYHw7hV9wGtYQJZ8usI7f77m3e9lQGwJp0phQ17j6p7VLGotMdEF3L
 l4tRCOuOH51fUCFMY44aL/uYKBMWhXv/XIqMle2e83x2z0kXdVtaPRWLume77VegnUjZ
 MG5yhZC4CwN9k/z87tvgXnx33/Pk1P/048OyMaym1+GZOZRkKLdb8KURH56zzdV5KaR3
 b2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789410463; x=1790015263;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QtinZDaa2vVKSqBwDg7kga2GKJXc4vSPzazNjm4AtY4=;
 b=fjzOplbLBCtAqGN9BRLoU9WW36SCTe1oWD3VS+EXEzYaIvQ8Hg3DXJLchPW7ffCDLn
 x6TlyN/R2IZPAwWyD8BhLxMuuus1xfnZ9rwJ+SScUVep/20WVnEYu6hpXqKcO/C02TVH
 dY9ghYlAXdXxxopmGjv0LLFps/GdcZqtOVUOcCrS3sf6oAt9WhTqsB+H15E9/yWy6+dd
 +7g5Xx2JxomGRSyNIxSFOWtkXXJ4OoSXfkSXXbDNRG2bFdjkmQj769y3ajxHAh264s4b
 /2rMa+RNJFRkiSGNv0ZRovcuP2QZBPTqeAB+ySpBktlt166l7DeZ1iMxPC2lG1FEZ9L7
 B2aQ==
X-Gm-Message-State: AFuF++mr2B1Pyl3lZGkfqmqNa3/EHLr/LekjEqi7v+qKPwiVzUUO14Z7
 6A56Xc44jqtfm+Rk4ANHOo7xoGXJTFSG7tbQgCpY+Lps7dga9L+/7Xhk
X-Gm-Gg: AYBFou3bOD4u4yz7J6HhDMlA88H1Ph4jQAe6G0fTVT2Zn8g+WzwBehDj1PNk9LoRUvj
 blcBphCsr51ouO7UpxJ/+bzg30zRQ1jpqouB+0W/qyVlrgd8IoIaBL0Qfx1mQrhxjSy3cIxtKW9
 y5I6DGUlWbyuT78MZ2EW6l7xy6pK7v62LS/MCLn5iEx9sfg0uBj5RIBgxzQFzlaH8vhF+0zIcfi
 2pKzP6mvMnYNWFqW0mXEOKjjFXk7w2I1s5CYZZX0e/teXFN1Kx/FIYm1PHFzyXQc6QZNB9yzfIR
 hxgUpDWxMWW6iP+IbDrb8Lg2JF37HPC+Ya48HOXUATwmmOXNbnMGqvB95x4dAhFexF3S4EOgfzP
 EOVBktLy/ohMWo3pNbL5Myu1uR07lkBqw0/v287S3x+f1ILQCjjOkoQ45iBZgngZVqCHOwE1g7f
 xUju745HyyHfc1OgrwcQtr8gZGVSdVJLzX0VR8AZjgKCuJOopH8JVKfKE5SuVfWcFvzC6by2HLn
 UL6lrmuQ4kdQyuXv2Z6bA==
X-Received: by 2002:a05:6000:46c6:b0:487:342:d141 with SMTP id
 ffacd0b85a97d-4870342d1a0mr2948031f8f.23.1789410462767; 
 Mon, 14 Sep 2026 11:27:42 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15de:500:7152:15ad:a382:94fc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486f0403125sm25397683f8f.8.2026.09.14.11.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 11:27:42 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@kernel.org, malhyuk97@gmail.com, tursulin@ursulin.net,
 matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com
Subject: [PATCH 1/2] dma-buf/dma-fence: fix checking signaling bit for
 timeline and driver name v2
Date: Mon, 14 Sep 2026 20:27:39 +0200
Message-ID: <20260914182740.1587-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
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

The patch "dma-buf: dma-fence: Fix potential NULL pointer dereference"
changed the check to test for the ops pointer instead of the signaled
bit to avoid a potential NULL dereference when the ops pointer has been
cleared.

The problem is now that the ops pointer is cleared only when neither the
release nor the wait callback is implemented and this isn't true for a lot
of dma_fence implementations yet. So those implementations lost the RCU
protection after signaling of the returned string resulting in potential
use after free.

Add the signaling check additional to the ops pointer check so that we
have both the protection against NULL dereference as well as the RCU
protection after signaling for the returned string.

v2: improve comments to note RCU protection and explain why we check
    both signaling state and ops pointer

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: 035219a760ed ("dma-buf: dma-fence: Fix potential NULL pointer dereference")
CC: stable@vger.kernel.org # 7.2+
Reported-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
Tested-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
---
 drivers/dma-buf/dma-fence.c | 16 ++++++++++++++--
 include/linux/dma-fence.h   |  6 ++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 05090fb0fd5ae..f52675f3ba03a 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -1170,7 +1170,13 @@ const char __rcu *dma_fence_driver_name(struct dma_fence *fence)
 
 	/* RCU protection is required for safe access to returned string */
 	ops = rcu_dereference(fence->ops);
-	if (ops)
+
+	/*
+	 * Check both signaled state and ops pointer, we don't know which one is
+	 * loaded first and ops pointer is only set to NULL on newer
+	 * implementations.
+	 */
+	if (!dma_fence_test_signaled_flag(fence) && ops)
 		return (const char __rcu *)ops->get_driver_name(fence);
 	else
 		return (const char __rcu *)"detached-driver";
@@ -1203,7 +1209,13 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence)
 
 	/* RCU protection is required for safe access to returned string */
 	ops = rcu_dereference(fence->ops);
-	if (ops)
+
+	/*
+	 * Check both signaled state and ops pointer, we don't know which one is
+	 * loaded first and ops pointer is only set to NULL on newer
+	 * implementations.
+	 */
+	if (!dma_fence_test_signaled_flag(fence) && ops)
 		return (const char __rcu *)ops->get_timeline_name(fence);
 	else
 		return (const char __rcu *)"signaled-timeline";
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 158cd609f1036..ffa99b930843e 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -141,6 +141,9 @@ struct dma_fence_ops {
 	 * compute the name at runtime, without having it to store permanently
 	 * for each fence, or build a cache of some sort.
 	 *
+	 * The returned string is RCU protected and can be freed after the fence
+	 * signaled and a RCU grace period passed.
+	 *
 	 * This callback is mandatory.
 	 */
 	const char * (*get_driver_name)(struct dma_fence *fence);
@@ -153,6 +156,9 @@ struct dma_fence_ops {
 	 * having it to store permanently for each fence, or build a cache of
 	 * some sort.
 	 *
+	 * The returned string is RCU protected and can be freed after the fence
+	 * signaled and a RCU grace period passed.
+	 *
 	 * This callback is mandatory.
 	 */
 	const char * (*get_timeline_name)(struct dma_fence *fence);
-- 
2.43.0

