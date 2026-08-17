Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3BBC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 23:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58FCB10E993;
	Mon, 17 Aug 2026 23:07:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="sEJAzfj9";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-164.mta1.migadu.com [95.215.58.164])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17EE110E993
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 23:07:38 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=5QbJHpgr3CucyvDdde4t/tI31dZ4ej321OlRqjTskz8=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787008057; v=1; x=1787612857;
 b=sEJAzfj9xjmX+S0vN3hqNgeSp+jHa8mFsVC/Gt8vPm8pQodQ1P4BUFSR/rpr+TWQmtamjCjf
 xvdB89kXfrgyTGz2ah2WiPoVApautJdXr6dgVuUAfieBqdOQJWfEzLD12GPex+tNlJocGLu63wt
 c+LCupzVigsQJUy8SJF2+BSNJPMbQ4eZ5rYrC7W9W387LBAVlGrPJOWdrlL6zFl4ulMHfuhE/NM
 lAbDOi8criIUQ7Xk4aIM7d2oouIdcX2eCnALZ/NK/6U5mJroLCQNBWaHVJZPFMrNlR4OwHJs8Q6
 g2RY0Y4NL0WTiYfWCJm8J0BZo8WIouNVhiv/M95gexBkg==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.111.69)
 by smtp.migadu.com with ESMTPS id 22df3830b9a1a881;
 Mon, 17 Aug 2026 23:07:37 +0000
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: lizhi.hou@amd.com,
	mamin506@gmail.com,
	ogabbay@kernel.org
Cc: christian.koenig@amd.com, sumit.semwal@linaro.org, alexdeucher@gmail.com,
 max.zhen@amd.com, sonal.santan@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Subject: [PATCH v4 2/5] accel/amdxdna: check the sync range for overflow on a
 device BO
Date: Tue, 18 Aug 2026 02:07:04 +0300
Message-ID: <20260817230707.356828-3-taimuraz@kaitmazov.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817230707.356828-1-taimuraz@kaitmazov.com>
References: <20260817230707.356828-1-taimuraz@kaitmazov.com>
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
index f88b5349cd4b..77a9493cd7ba 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -1274,8 +1274,13 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
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

