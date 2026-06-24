Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C6FCDE002
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5842810EEEF;
	Wed, 24 Jun 2026 12:29:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AiEjuCh0";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00AA710EEEC
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 12:29:27 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-490ac357c55so8846685e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 05:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782304166; x=1782908966; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CTDR2FGDDMlL0SKna41UWrjV6rjHoFlolha4zevYi4s=;
 b=AiEjuCh0jlUdxLLHTrBeLUt/p7MJ8RnDcTxlO3tG+/YKPAcy2G/du4QPgDUSshUxg0
 Ge+/UpFl81lO+ZCxhBsYwqdrulkJILU9tKaI/XI7tXVO4uN6SdY4MP11KnTH37B4/I0V
 jgGb0owSxBxAlhM59t5Tj7KvRRuuvQhtHq2zhDwhpWPya+cV30yWC1XVji2bNvHl6KK9
 nvwTpcYMU623jaoXB+PW4CE7xE0w+MzNYvqLFZsorLAYbCqscwzRE8+Tv4bdpxzFfVCf
 Z+ycEzp9ooHd+YIf4t4RS4/1u545Dq2aDoBsoqAqA+ENpPMpcCYGcbKMpuzMwBEOlQG+
 rZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782304166; x=1782908966;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CTDR2FGDDMlL0SKna41UWrjV6rjHoFlolha4zevYi4s=;
 b=FCfkEnwmmsmLsps27wIEUsF6r7Vmc3fNFn0epVVHKYxmvoGfM4G+28FQoyopq4Ij8j
 t4qhrgV+q62AiChrYm/RH4DaWNfztpRzYeWvJVDvZ7odldcBsSEV+yNOiXIyX/qQMgYG
 IpWKcf+0lDoP1C0wAWP1XBxLqNC+0WgNMuonQgHyxmbluth0uYn90uIYj8ja3QVVZaBE
 Up1uqHmymYqBwrc9sYkq7+YjyjY+RBCVML1NTnoj1xCoYBDRICXrJcsL3eMvVKFMf1/I
 ldwZCeQwesqE40zmAVdvJYY34Zsk0rUhhvUVKuqEsurNDz5tDf2uK06cWN6FUG7LIuwD
 P0pA==
X-Gm-Message-State: AOJu0YyhRx7Z3hevirm0SN5pBM22zqFE1gtE6olySuxFGm4KU27po0ml
 4CiWCdd6DKfLoYPW//4Fja4/xzzdU5SPnL/mhZqww21AM1S8jLz6QSDk
X-Gm-Gg: AfdE7clf9SDkD6aSd7RuToGFzKRcn4YVLQfzB4SO3AiEHzbcxpIRdR4YcEBgui1TbgB
 b4XCWrwNwX9QMl8MT8uRdBSvZbUsPJlRkk5hW7Ezjv7/3OBqggsjX7062WGoUJY30KpIp94rZDr
 /OdJA+xmzn+XsMl/JTBQ5gjk3lu1FgtY7QoRaPnsnaC140daQb2bgRSBiL/IuhCEOGmka2ujLF+
 v50/LejPWpt7VWLHV1+GI6QPuy79RANLukzVGBbVNIkJ50Zflr3NTEd+5RrUbLDVu6D4fKMXnUp
 hMFn3KIjX/g/wyxIhlCCV3QvlB2hKxjuUCMfhr+L8yvbweddaCIG6r+3VZwjvBli0AigMfb4k+F
 Udm0W31IbX1WCcbqvoBlPm47OgO28Jy4wm+FvAhX5VDtTkss8jVyWgnFr7PpVtR9HyGGPsUDyBS
 dzmHP9t/brSTnGeqW11OfWcvh8AG819ZChblRc
X-Received: by 2002:a05:600c:ac8:b0:490:b7e6:bd1d with SMTP id
 5b1f17b1804b1-4926084d209mr36077205e9.16.1782304166289; 
 Wed, 24 Jun 2026 05:29:26 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:157e:3500:2be7:1a89:41c5:9239])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c9787dddbsm3896530f8f.3.2026.06.24.05.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 05:29:25 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@kernel.org, simona@ffwll.ch, sumit.semwal@linaro.org,
 tvrtko.ursulin@igalia.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH 07/10] dma-buf: remove dma_fence_is_signaled_locked()
Date: Wed, 24 Jun 2026 13:13:31 +0200
Message-ID: <20260624122917.2483-8-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624122917.2483-1-christian.koenig@amd.com>
References: <20260624122917.2483-1-christian.koenig@amd.com>
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

Finally remove one of the biggest trouble makers in the dma_fence
handling.

The signaled callback is now consistently called without holding the
dma_fence lock.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 include/linux/dma-fence.h | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 803e10ca76e3..ad69acbea218 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -493,40 +493,6 @@ dma_fence_test_signaled_flag(struct dma_fence *fence)
 	return test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
 }
 
-/**
- * dma_fence_is_signaled_locked - Return an indication if the fence
- *                                is signaled yet.
- * @fence: the fence to check
- *
- * Returns true if the fence was already signaled, false if not. Since this
- * function doesn't enable signaling, it is not guaranteed to ever return
- * true if dma_fence_add_callback(), dma_fence_wait() or
- * dma_fence_enable_sw_signaling() haven't been called before.
- *
- * This function requires &dma_fence.lock to be held.
- *
- * See also dma_fence_is_signaled().
- */
-static inline bool
-dma_fence_is_signaled_locked(struct dma_fence *fence)
-{
-	const struct dma_fence_ops *ops;
-
-	if (dma_fence_test_signaled_flag(fence))
-		return true;
-
-	rcu_read_lock();
-	ops = rcu_dereference(fence->ops);
-	if (ops && ops->signaled && ops->signaled(fence)) {
-		rcu_read_unlock();
-		dma_fence_signal_locked(fence);
-		return true;
-	}
-	rcu_read_unlock();
-
-	return false;
-}
-
 /**
  * dma_fence_is_signaled - Return an indication if the fence is signaled yet.
  * @fence: the fence to check
@@ -540,8 +506,6 @@ dma_fence_is_signaled_locked(struct dma_fence *fence)
  * operation is complete, it makes it possible to prevent issues from
  * wraparound between time of issue and time of use by checking the return
  * value of this function before calling hardware-specific wait instructions.
- *
- * See also dma_fence_is_signaled_locked().
  */
 static inline bool
 dma_fence_is_signaled(struct dma_fence *fence)
-- 
2.43.0

