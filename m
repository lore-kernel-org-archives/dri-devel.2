Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56792EBFD34
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 10:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8B3310E3AC;
	Mon, 13 Apr 2026 10:05:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="qMLoNjzA";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DF5D10E3AC
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 10:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RsHj3B+OHfm/0FRZ3o5Q5eWOIOGRkA4Ykl526vZrTs0=; b=qMLoNjzAqopvjCtxlFMYuP/Hz2
 t6ZAVxtyYMv/vny4PSumehPJzXDDF8ccx8TozMbf5DmXho+/vWcMKr5hqF02Pz3RuYrkZsYKrFAnP
 1px/nTz1u5x9vkWxiGAchq2JS/qP/8SBu9omHGQa7ijaLjDOJkMVfQxpu/XB7eCCtdyGMNGQAG7z9
 po0e5RbDGYmsJdv/YVZ64cnBDqOlzQP73GEfFNwr6g9XqQzEoUfFU7+/rbbfyTbzx3+Ld+kqDJjQ1
 60N9JKobQfzFpNGkcO9AlM7bTRmtb8v3k3rfdfMaHA6tSwT+loe8fsJh3m2NX/21uvJDEZyZ+XWcq
 mzNssAyw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wCEAx-00FL6K-9m; Mon, 13 Apr 2026 12:05:51 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 3/3] dma-fence: Init and enable signalling can use the fast
 path tracepoint
Date: Mon, 13 Apr 2026 11:05:26 +0100
Message-ID: <20260413100526.15729-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413100526.15729-1-tvrtko.ursulin@igalia.com>
References: <20260413100526.15729-1-tvrtko.ursulin@igalia.com>
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

From dma_fence_init (cannot signal yet) and dma_fence_enable_signaling
(fence->lock and rcu_read_lock held, ops checked manually), it is safe to
use the marginally faster tracepoint class.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
---
 include/trace/events/dma_fence.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/dma_fence.h b/include/trace/events/dma_fence.h
index 220bf71446e8..9e0cb9ce2388 100644
--- a/include/trace/events/dma_fence.h
+++ b/include/trace/events/dma_fence.h
@@ -71,7 +71,7 @@ DEFINE_EVENT(dma_fence, dma_fence_emit,
 	TP_ARGS(fence)
 );
 
-DEFINE_EVENT(dma_fence, dma_fence_init,
+DEFINE_EVENT(dma_fence_ops, dma_fence_init,
 
 	TP_PROTO(struct dma_fence *fence),
 
@@ -85,7 +85,7 @@ DEFINE_EVENT(dma_fence, dma_fence_destroy,
 	TP_ARGS(fence)
 );
 
-DEFINE_EVENT(dma_fence, dma_fence_enable_signal,
+DEFINE_EVENT(dma_fence_ops, dma_fence_enable_signal,
 
 	TP_PROTO(struct dma_fence *fence),
 
-- 
2.52.0

