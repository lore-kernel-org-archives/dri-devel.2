Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48ABC531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AD9B10E64C;
	Fri, 24 Jul 2026 07:59:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jfEYV8j1";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8658410E64C
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 07:59:25 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso108266a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784879965; x=1785484765; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=60gePLlXQJ2FLj3Sfms6m0pXBaiWjvamSHFgVRwWfTA=;
 b=jfEYV8j1DTeUY0UO2/Fej5UcQN8mQDngcH7+T+S4x5ilxUOQnSUFZogQ5G3y85OwUU
 wP2ZLnryvulbVvT9Lb1GIyZXoVmRBe5KetNwpOkhcJmTdzTwt3mzL5je790eza9SaFok
 5U9NWuyevEBfj0gTIkg8EJOZmKmjJRQzIiF+qIKGXV41Oz/aTnZg0m4kZc+DXZfGBgfj
 5uqxxR5HNcumsOuWl2ZUVnWuzEGBp5YnSki+cYaBcEpG5Di9QmUl+MPKLBrODXh+AHTk
 /RROU5Th9yeaO2DNytvNZLCsOUUi9Q+hwE57tASs8rJJX+bSlE+a6gDly//A8V5fnbX1
 fcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784879965; x=1785484765;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=60gePLlXQJ2FLj3Sfms6m0pXBaiWjvamSHFgVRwWfTA=;
 b=rqj5D8MuKZAcP4VIizCkWI4kHbzJlLRZiOSyVZlSF/lSRWWnGFPGskD5Ao92rWkaZc
 00Bj0eQIeI2PpzP4NoWbdCBZidg8KJy5TWD890JrAR27EOVr8M++eH2YTI1FzaZyue70
 poZ9Gs9Nh9VtAPqouc8MgFJSQHZh3o5Fsh5Jh/uUgR5N30LIN227+FMmamt2/MRwIC9d
 wYve5npjo3XQ6a6p+y50cExMJmLXt4XHjDgfTSk1zINHVTBI8ZzoHuTHYOF6neaYGeHo
 Ll6LKZ+lFVgt5RmdMYx2Hwif5lIIZTs6iAnV8K2xIL3ISrcbgiQzZcgPs2H3xZUCMQ8W
 3mGw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqQ2f9MY9vgVlfOp6G6tptrY+BcR1I1iEYn4hdRQbu86JlReCDQaMCLS7g1IBJgL7pDhJzZfXoQeRQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNcxAyucYyJpSpxin/0yxNV8p2yB9fsYJtoZC9p+TVPIX43kQA
 LEbFN0Tv5OropgbAiwy82Kt7sgceo6IDni5ug0qMRE+qlxCLMv9atC0OBu7RQ5okFEU=
X-Gm-Gg: AR+sD11r/S43szQw520Sqzp5bJ9QVr+mJucNreapUJhtBY9KelZ65bUEIaHcv2Ld8j5
 855kIGMlc4UiOC42iTLOYWk2QG6C+NAwyLP2cdq9XLOaZ4nU3UiDNcCMEFaxXe3wZFUgS+2HtEd
 rZbIPSxHj+p+CXtyjwV2JPgZ6WHqBuXAnMRpfmhRuP4YjfeEv/1Li5fPrmQx5SHl7FgYwOdWu+8
 eAr9MLG6RsicWOg0S8VdeGmw37Yq9GILSkNis/4AyvGSx5BK8atJfdWGfOwiPjsNgiUrhOs34/U
 qrTinVFGeY2O48G9FcI+vXy9vWhSr1aokDVcE6+nI+vEwbliRSTVIPAh5E5Y1fjQ9K9dFWX+IXr
 GXdpZmlpQf0qrmEIculGsV5T9q8q2pPMIWr7uJF4+gxbuOhwPoP0eyJQ84a7/bxOurbXmmFLbJB
 26gdnlANxG9FJpBjFfElfrohsBF89TpRVv9G/Pq0yW0/Mr/Y8hV1vDPc24YPAX3yvMBvVtZcU2p
 vEIWGDfrjFmeT9uTRkT0fsJ+JL9eh5AnD6+28qE6eR6Ug==
X-Received: by 2002:a17:90b:1f90:b0:38d:f096:a1dc with SMTP id
 98e67ed59e1d1-38ec6575a01mr6454628a91.11.1784879965030; 
 Fri, 24 Jul 2026 00:59:25 -0700 (PDT)
Received: from bass-virtual-machine.. ([114.247.65.140])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f03c20dbdsm1047727a91.13.2026.07.24.00.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 00:59:24 -0700 (PDT)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net
Cc: chris@chris-wilson.co.uk, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH] drm/i915: Use acquire when checking software fence completion
Date: Fri, 24 Jul 2026 15:59:19 +0800
Message-Id: <20260724075919.2262539-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.34.1
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

__i915_sw_fence_wake_up_all() publishes completion with
atomic_set_release(). Pair it with atomic_read_acquire() in
i915_sw_fence_done().

Without acquire ordering, a waiter can observe the completed state while
still reading stale data written before completion, such as fence->error.
This can prevent errors from completed dependencies from being propagated.

i915_sw_fence_signaled() also accepts the state before the completion
callback finishes, and its callers do not consume completion data. It does
not need acquire ordering.

Fixes: e68a139f6bf3 ("drm/i915: Add a sw fence for collecting up dma fences")
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
Found by auditing atomic operations used for synchronization.
A similar fix can be found in 6df8e84aa6b5.
---
 drivers/gpu/drm/i915/i915_sw_fence.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_sw_fence.h b/drivers/gpu/drm/i915/i915_sw_fence.h
index f752bfc7c6e1..16563c66c984 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence.h
+++ b/drivers/gpu/drm/i915/i915_sw_fence.h
@@ -105,7 +105,7 @@ static inline bool i915_sw_fence_signaled(const struct i915_sw_fence *fence)
 
 static inline bool i915_sw_fence_done(const struct i915_sw_fence *fence)
 {
-	return atomic_read(&fence->pending) < 0;
+	return atomic_read_acquire(&fence->pending) < 0;
 }
 
 static inline void i915_sw_fence_wait(struct i915_sw_fence *fence)
-- 
2.34.1

