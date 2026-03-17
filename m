Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B79FD877F
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 608F610E498;
	Tue, 17 Mar 2026 14:48:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jHDVnHEF";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FB8C10E498
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 14:48:29 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-439c6fc2910so4429876f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 07:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773758907; x=1774363707; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M8gYAozgCWDOAMG74D+3BY6ig21lwzb2NHNogEZp2oE=;
 b=jHDVnHEF7LraBn7VbgRa9p49sv7S0YPdkU+ft+HJi6GfRuRC1q/OxqXg9CZN5xPBI0
 +91JpuQ7ryzag7iCX6Y7S/B9LpQ9tmt4AgtGOrqbpAu7dqEYS/cLa84dYcuUyYqsLGvi
 Q6P7qJ2PcnZhbBGS4siZuYY+GUt6IlwuzwuLvMqPR6Q9EV0a0c8s7JHLq7sCw4c0ti2k
 xdo0CfCgViuba/5HZUwmG4lZInB6V3P7Q5wJUc2EbUzUZmCmOXvSJGtFylHRmTjEr9aU
 UEKpyzgTfMPsjDAdIht5MXgDCN+qgfa5T3Z+1x7RjkEwso/4JXpwxantXquqpQmLfJxi
 HZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773758907; x=1774363707;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8gYAozgCWDOAMG74D+3BY6ig21lwzb2NHNogEZp2oE=;
 b=P7KcjCSTWAKQ48PUy2+cdEIJQn5pW6eORuM9Mel0nA0EXFMINtqq0Pdtw3Crb4jF72
 WkdvLa4T/3JCMjy6djjctSPfAU2S29ko0xuUjaASncpcYdu9POm8ITHR2rGwDLAJG3KQ
 qTjszlmg3uK94yMlAeEfna6eXaOOtbHkrlpZCk1xWbE6p/4lLfgh3GARZ4WNEC14CwmG
 o+kMHzQWVE6BzVeg87xfZUUKXyc108UWqBohb2vqoFqZMnybtCR/5ksnWy8FjcqgTpHl
 /b+iRBFisOBBgO8LClxLxLl8NyCiWw+s4Jf/7Uj8mz+xS/frKH4uCZZeFVGrqvJeg2T3
 NrQw==
X-Gm-Message-State: AOJu0YzTZnq6S63436RMjRmL2vkuGboNDgG90XOm7ZhwhRh3eKCCdy5A
 l5ceeesYkT1OPmcMmpTudFCky8TvwxWj4+VCsY9YH2D47FnX1poHTgqZ
X-Gm-Gg: ATEYQzyUv+ILUThEqqZcFdDj14nhICFqJFf++2klc0k7Bede0+V8WcXhF0rxqxWGY9Y
 gaM9FvxYGv5oVZ7C/7dlUkujYhTYvManWqMlgfF4U3G1RZrhzzVSari1OBO9oUl6UAs6LsHjgXL
 nWRQmZ3zbDpDI3SzRQ9c8rL5OmHoee5mqRO8fIHN++q51rHV0BuA61riU7EHjhJucqiYDOCleIm
 i2grFFjrTMbEo1eIqHsuHeDqv5JN2comoxrVKiGYMxqhVFxnICgqzjNXggvE7rWEfVgxrd2vWBG
 vwJQaMc9CUhWKVZY1+Smw7BBrLizpdQklZ+bLgyml/ohYFz2FkU3JfEJF16oag63F6p99lYXKT3
 V61vb4j5jmDgdMyq/L/rDlFHT9kAn+qBVGaWW3MVzGnWlTV2Xt9edHJxfj5jRnRhYAZXHjNldd7
 8fznexE1M85wJpC6OO7FnyK1sB9alE6QjM5Wg63wfR/CtuiQ==
X-Received: by 2002:a05:6000:2601:b0:43b:48e3:fbee with SMTP id
 ffacd0b85a97d-43b48e3fc39mr8977145f8f.37.1773758907211; 
 Tue, 17 Mar 2026 07:48:27 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1570:2300:d8a4:3e2d:eba7:95e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe2186e3sm57302132f8f.26.2026.03.17.07.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 07:48:26 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, aliceryhl@google.com, boris.brezillon@collabora.com,
 gary@garyguo.net, lossin@kernel.org, daniel.almeida@collabora.com,
 joelagnelf@nvidia.com, sumit.semwal@linaro.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH] dma-buf/dma_fence: be more defensive in dma_fence_release
Date: Tue, 17 Mar 2026 15:48:25 +0100
Message-ID: <20260317144825.2318-1-christian.koenig@amd.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

In case of a refcounting bug dma_fence_release() can be called before the
fence was even signaled.

Previously the dma_fence framework then force signaled the fence to make
sure to unblock waiters, but that can potentially lead to random memory
corruption when the DMA operation continues. So be more defensive here and
pick the lesser evil.

Instead of force signaling the fence set an error code on the fence,
re-initialize the refcount to something large and taint the kernel.

This will leak memory and eventually can cause a deadlock when the fence
is never signaled, but at least we won't run into an use after free or
random memory corruption.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-fence.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 1826ba73094c..8bf07685a053 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -593,14 +593,24 @@ void dma_fence_release(struct kref *kref)
 		/*
 		 * Failed to signal before release, likely a refcounting issue.
 		 *
-		 * This should never happen, but if it does make sure that we
-		 * don't leave chains dangling. We set the error flag first
-		 * so that the callbacks know this signal is due to an error.
+		 * This should never happen, but if try to be defensive and take
+		 * the lesser evil. Initialize the refcount to something large,
+		 * but not so large that it can overflow.
+		 *
+		 * That will leak memory and could deadlock if the fence never
+		 * signals, but at least it doesn't cause an use after free or
+		 * random memory corruption.
+		 *
+		 * Also taint the kernel to note that it is rather unreliable to
+		 * continue.
 		 */
 		dma_fence_lock_irqsave(fence, flags);
 		fence->error = -EDEADLK;
-		dma_fence_signal_locked(fence);
+		refcount_set(&fence->refcount.refcount, INT_MAX);
 		dma_fence_unlock_irqrestore(fence, flags);
+		rcu_read_unlock();
+		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
+		return;
 	}
 
 	ops = rcu_dereference(fence->ops);
-- 
2.43.0

