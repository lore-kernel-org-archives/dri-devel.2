Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08676C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 22:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45C5510E5B6;
	Wed, 19 Aug 2026 22:45:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="vyLiRtPG";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-200.mta1.migadu.com [95.215.58.200])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C91710E5B6
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 22:45:39 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=cCM4dqxxxgwvGuY+m85yjvrUusQ28w5OHOp+TBmLYBs=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787179537; v=1; x=1787784337;
 b=vyLiRtPG4j/euKeKpitN/hYCjA4FxIXx1fclRo2V4aUd5L2N8MtCLvcU8Fj3vneL0xSfBLjO
 jseYJaiEHGl+SNz7oLXdsqprhBnyXp+hJpfzFaZS/zcwzfTSPa/gbZyqTdrwSli3gQSm1hN7o9s
 JKfBkUNFemcR4/WFzyTjUBea3FDm7afqdNRyGi3RQfBk/mLkAfSf72cv/Qr0xCDY4P6UyH43jZp
 9iwpjRrw0sGH44vJWHGebSZvJTkIKSkPD2RBxdBc+See5c7XV8JxMK2ycusLksi2cRki/z65/9x
 aPNJJfY2I6c+3l+3mLSql3ZD2r5cbOug9GloJ+NHT/Owg==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.111.69)
 by smtp.migadu.com with ESMTPS id 97be99e65c86ef62;
 Wed, 19 Aug 2026 22:45:37 +0000
X-Mizu-Trace-ID: 97be99e65c86ef62
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
Subject: [PATCH v5 5/5] accel/amdxdna: do not fail a sync for a BO with no
 debug context
Date: Thu, 20 Aug 2026 01:44:58 +0300
Message-ID: <20260819224458.257346-6-taimuraz@kaitmazov.com>
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

amdxdna_drm_sync_bo_ioctl() calls amdxdna_hwctx_sync_debug_bo() for every
FROM_DEVICE sync, which answers -EINVAL when the BO's assigned_hwctx names
no context. Only a BO attached with ATTACH_DEBUG_BO is ever given one, so
an ordinary read-back sync reports failure after its flush has already run.

Ask for the debug sync only when the BO has a context. An unattached BO
carries AMDXDNA_INVALID_CTX_HANDLE and hwctx ids are allocated above it, so
the test is exact, -EINVAL keeps meaning that the named context is gone,
and the handle is not resolved twice. The field is written under dev_lock
and read here without it; the context is still resolved under that lock, so
a racing attach only decides whether this sync sees the buffer.

Suggested-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 4be5298d1062..2613c94dd842 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -1319,7 +1319,8 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
 	XDNA_DBG(xdna, "Sync bo %d offset 0x%llx, size 0x%llx\n",
 		 args->handle, args->offset, args->size);
 
-	if (args->direction == SYNC_DIRECT_FROM_DEVICE)
+	if (abo->assigned_hwctx != AMDXDNA_INVALID_CTX_HANDLE &&
+	    args->direction == SYNC_DIRECT_FROM_DEVICE)
 		ret = amdxdna_hwctx_sync_debug_bo(client, args->handle);
 
 put_obj:
-- 
2.55.0

