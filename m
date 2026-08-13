Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807A8C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5F8610F33E;
	Fri, 14 Aug 2026 07:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="QH59kRUU";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-198.mta0.migadu.com [91.218.175.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A55B110E4E5
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 16:47:21 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=efoA0vsdIRPewXg6qgP6CN+7DQNH8fk10g7pmHX5WFE=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786639639; v=1; x=1787244439;
 b=QH59kRUUHIHzcVuWt1twSvGLAELTlB7Tc5qTkznkkgUe7xao2uBhQyJJWwS78W9/1ylC46Pz
 wOoNu43ZXCDWAVN/4jnITMlR7p2RD4QxZEli1SlwCElWLTSb+HYPPhdwUwKgMfRe8BoiYW9GKP8
 mDQ7Dl2udWLkbA99Y2d/pfIq6R4Ec3uYPoxjUvscIVB0DiUcwiyeFe9HVTlMOJ37c8FY4+UtNM3
 X6vp/tK9Uj/ug3ddDJ8gk2mj5uYisj9fb7GXOAkGlYi2Wl/pbRRXlOYJ+q8Mr0cSNTCAZ7XtrSA
 9tv2n05zmcorktFT/kJXIAjW8RhzQemtFt2uGnwxW9JSQ==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.111.69)
 by smtp.migadu.com with ESMTPS id 26322eae1a0e6d4e;
 Thu, 13 Aug 2026 16:47:19 +0000
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Max Zhen <max.zhen@amd.com>,
 Sonal Santan <sonal.santan@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH v3 3/3] accel/amdxdna: check the sync range for overflow on a
 device BO
Date: Thu, 13 Aug 2026 19:47:00 +0300
Message-ID: <20260813164700.43960-4-taimuraz@kaitmazov.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813164700.43960-1-taimuraz@kaitmazov.com>
References: <20260813164700.43960-1-taimuraz@kaitmazov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 14 Aug 2026 07:04:05 +0000
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
Message-ID: <20260813164700.QSdRN18RdRQaB61Piqb0ZWQy8_6QmYoBgAPy9JVvsJY@z>

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
index 813b212a53f..85ce709a366 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -1275,8 +1275,13 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
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

