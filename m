Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72B2FD875A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:18:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BBEC10E623;
	Tue, 17 Mar 2026 12:18:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oCrdV9kC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6084510E623
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 12:18:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0E1E54324A;
 Tue, 17 Mar 2026 12:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689C1C4CEF7;
 Tue, 17 Mar 2026 12:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1773749937;
 bh=OIjCRjYtXl1XNA+iUL8vhY3vsna7MPuDUF9TjdXS7eM=;
 h=Subject:To:Cc:From:Date:From;
 b=oCrdV9kCGpgEmJd9rvNMKmMl0bhSxcDmFhFWx53rwh7nJxLaoRoIzWJJNG9z1giSC
 DcbGbExWoQWGgsWxVgx+k5GBIqFCA6rd7/J4JngAEN4o4mJgODJqY2uxNDCM2I/mk3
 MbbKJR2VJhn4vvNFzGFJXJhj1xglCkJATWK5nrvw=
Subject: Patch "drm/ttm: Fix ttm_pool_beneficial_order() return type" has been
 added to the 6.19-stable tree
To: cascardo@igalia.com, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
 tursulin@ursulin.net, tvrtko.ursulin@igalia.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 13:12:17 +0100
Message-ID: <2026031717-gothic-humorist-09f8@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
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


This is a note to let you know that I've just added the patch titled

    drm/ttm: Fix ttm_pool_beneficial_order() return type

to the 6.19-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     drm-ttm-fix-ttm_pool_beneficial_order-return-type.patch
and it can be found in the queue-6.19 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 6e3f4514e3b432871ac81717d24f56b441857f77 Mon Sep 17 00:00:00 2001
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Date: Fri, 27 Feb 2026 12:49:01 +0000
Subject: drm/ttm: Fix ttm_pool_beneficial_order() return type
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

commit 6e3f4514e3b432871ac81717d24f56b441857f77 upstream.

Fix a nasty copy and paste bug, where the incorrect boolean return type of
the ttm_pool_beneficial_order() helper had a consequence of avoiding
direct reclaim too eagerly for drivers which use this feature (currently
amdgpu).

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: 7e9c548d3709 ("drm/ttm: Allow drivers to specify maximum beneficial TTM pool size")
Cc: Christian König <christian.koenig@amd.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.19+
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
Link: https://lore.kernel.org/r/20260227124901.3177-1-tvrtko.ursulin@igalia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/ttm/ttm_pool_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool_internal.h b/drivers/gpu/drm/ttm/ttm_pool_internal.h
index 82c4b7e56a99..24c179fd69d1 100644
--- a/drivers/gpu/drm/ttm/ttm_pool_internal.h
+++ b/drivers/gpu/drm/ttm/ttm_pool_internal.h
@@ -17,7 +17,7 @@ static inline bool ttm_pool_uses_dma32(struct ttm_pool *pool)
 	return pool->alloc_flags & TTM_ALLOCATION_POOL_USE_DMA32;
 }
 
-static inline bool ttm_pool_beneficial_order(struct ttm_pool *pool)
+static inline unsigned int ttm_pool_beneficial_order(struct ttm_pool *pool)
 {
 	return pool->alloc_flags & 0xff;
 }
-- 
2.53.0



Patches currently in stable-queue which might be from tvrtko.ursulin@igalia.com are

queue-6.19/drm-ttm-fix-ttm_pool_beneficial_order-return-type.patch
queue-6.19/drm-amdgpu-userq-fix-reference-leak-in-amdgpu_userq_wait_ioctl.patch
