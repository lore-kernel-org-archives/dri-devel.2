Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4F5C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 22:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9FD510E598;
	Wed, 19 Aug 2026 22:45:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="WFfkvVeV";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D56CF10E59F
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 22:45:23 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=EmnqoB4DR5h413qwiU0c9AGvI5DpsrKaCGcmNkml1bw=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787179521; v=1; x=1787784321;
 b=WFfkvVeV8f3b8Xf5iPhXTVkIMyzgdC3TI1NaeJnu5zfihOEv8hNjqsSogJVZf+JHhtFDPfxZ
 6nstKVOOi9tVv3/HdIYKiBQizhgomEWlRk6+XyAiylEnTlGlnkeH1R5+JpKw7hITMD6hVg6wKcx
 Xx5Mx3fY0puGQNM5cufP3y3HdF1DCr1s9IoNrYGwBmFx+QmZG0onK9J+hEN/Mzct5RiGqeP/NkB
 CxrGr8boKV7dc+EcyNeeg1ZY+6M1MWPT+JNDbfIzGD2j3vroqYAb8krr5F1BqeYx0D3X8xS6I5J
 h6O56BbzG3Dxhe2VxyNrbfsqEVB0TxYXqBQkL2yr2kKwQ==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.111.69)
 by smtp.migadu.com with ESMTPS id 6ecc9499d6d705dd;
 Wed, 19 Aug 2026 22:45:21 +0000
X-Mizu-Trace-ID: 6ecc9499d6d705dd
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: taimuraz@kaitmazov.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Alex Deucher <alexdeucher@gmail.com>, Max Zhen <max.zhen@amd.com>,
 Sonal Santan <sonal.santan@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH v5 2/5] accel/amdxdna: check the sync range for overflow on a
 device BO
Date: Thu, 20 Aug 2026 01:44:55 +0300
Message-ID: <20260819224458.257346-3-taimuraz@kaitmazov.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819224458.257346-1-taimuraz@kaitmazov.com>
References: <20260819224458.257346-1-taimuraz@kaitmazov.com>
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
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
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

