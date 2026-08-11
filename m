Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4B4C5CFDB
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 23:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6CB810E3CE;
	Tue, 11 Aug 2026 23:22:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="v2hFxVxY";
	dkim-atps=neutral
Received: from out-171.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FC5F10E3CE
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 23:22:32 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaitmazov.com;
 s=key1; t=1786490070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Xg+sD5VmozrBU1PM63Ge/zRW7xVWQ0U5mvivvxbFX4=;
 b=v2hFxVxYxluLJ7lkacrpVqmF/bXySnjmIq2mYPcP+tB6UvsjAlZYU1DjaRF1hbRtor7KWe
 omPzXMhlyk/FIViVTVc1XVG6VJcsdXc9+xEcmOaeekNLsIM+WNJMW75DYnrtjQokMUoV5N
 Z1sa+HeTWXojGJmSRM+9tFLCHy42pDSz9cR5U0vlVB8mWAaCIJYt+K+K8yrvMM/l8/WnJK
 curHNA+tGhSgQK0HQkR3JBl5yqBWdPLyTgH29B2Coce8H+8dUovKR7GDs7F31b8g74g1xM
 29qxD2kWEfOBJGSW+3Gce202ZjnbsJSTVJSBBzDzPzoVbY/GdeiR/MFH+xP2Aw==
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: mamin506@gmail.com,
	lizhi.hou@amd.com,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Subject: [PATCH v2 4/5] accel/amdxdna: check the sync range for overflow on a
 device BO
Date: Wed, 12 Aug 2026 02:13:50 +0300
Message-ID: <20260811231351.1011244-5-taimuraz@kaitmazov.com>
In-Reply-To: <20260811231351.1011244-1-taimuraz@kaitmazov.com>
References: <20260811231351.1011244-1-taimuraz@kaitmazov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

amdxdna_drm_sync_bo_ioctl() forms the range for a device BO by adding the
caller's offset and size to the BO address without checking either, while
amdxdna_flush_bo() one call down guards the same arithmetic with
check_add_overflow().

A size that wraps flush_end leaves it below the heap it is clamped
against, so every heap fails the start >= end test, and a sync that asked
for more than the address space holds reports success having flushed
nothing. Reject it instead.

Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 7df4bbb16..d944f1b99 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -1287,8 +1287,13 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
 		struct amdxdna_gem_obj *heap;
 		unsigned long heap_id;
 		u64 bo_start = amdxdna_gem_dev_addr(abo);
-		u64 flush_start = bo_start + args->offset;
-		u64 flush_end = flush_start + args->size;
+		u64 flush_start, flush_end;
+
+		if (check_add_overflow(bo_start, args->offset, &flush_start) ||
+		    check_add_overflow(flush_start, args->size, &flush_end)) {
+			ret = -EINVAL;
+			goto put_obj;
+		}
 
 		xa_for_each_range(&client->dev_heap_xa, heap_id, heap,
 				  abo->heap_start_id, abo->heap_end_id) {
-- 
2.55.0

