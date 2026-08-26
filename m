Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65392C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90FC510E2DF;
	Wed, 26 Aug 2026 15:07:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="BNRBKiRj";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-161.mta0.migadu.com [91.218.175.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97F8410E2DF
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 15:07:42 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=hMYc94G1gA6v4L38UFT6OG1ZsXBh/2ngQgNipPBJ1y0=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787756860; v=1; x=1788361660;
 b=BNRBKiRj+bItcxH+upYog37d6EPmKfH472hEKvWAB/yZwG/xQeajkkTvGNbSToPhzzqcep7T
 kt7LN/nVmQxYCBtvoTi+oIWwAJ0g8/l/GPAmcJM7cgnCByq/bUJyaExDBv5MhUvQkd92nxHYPGT
 CKC+Kjb4CMY3+Dep8TwgwdPmBzjeVmVWRohMG3agWV2s6HymJzSR4ZF4s4Mn1zHumrtLZOsNoVw
 M1uu86RQcnvPFsFi5rpSgZMykQ0Z+oNnZRlu0Nk60eNM1nYK/B0EP1++Y8UUlSgZPiE8B24UCPF
 xm63LCiFk41TkbLjORjdfulaAvqKwyTKXt9FEOcoFBOwA==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.110.63)
 by smtp.migadu.com with ESMTPS id bf99d0a8afec3d51;
 Wed, 26 Aug 2026 15:07:30 +0000
X-Mizu-Trace-ID: bf99d0a8afec3d51
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: taimuraz@kaitmazov.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] accel/amdxdna: make the debug BO command wait interruptible
Date: Wed, 26 Aug 2026 18:07:26 +0300
Message-ID: <20260826150726.126296-1-taimuraz@kaitmazov.com>
X-Mailer: git-send-email 2.55.0
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

aie2_cmd_wait() waits with dma_fence_wait_timeout(..., false,
MAX_SCHEDULE_TIMEOUT): uninterruptible and unbounded. Both callers reach
it from an ioctl holding xdna->dev_lock, and the only thing that can
signal the fence when firmware does not answer is
aie2_sched_job_timedout(), which takes that same lock. A debug BO command
that never completes therefore blocks the ioctl forever, leaves the task
unkillable, and stalls every other ioctl on the device behind dev_lock.

Wait interruptibly and propagate the result. This does not remove the
lock dependency, it makes it survivable.

Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
 drivers/accel/amdxdna/aie2_ctx.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 54486960cbf5..1f910ee4941c 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -897,17 +897,20 @@ static int aie2_hwctx_cu_config(struct amdxdna_hwctx *hwctx, void *buf, u32 size
 	return ret;
 }
 
-static void aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
+static int aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
 {
 	struct dma_fence *out_fence = aie2_cmd_get_out_fence(hwctx, seq);
+	long ret;
 
 	if (!out_fence) {
 		XDNA_ERR(hwctx->client->xdna, "Failed to get fence");
-		return;
+		return -EINVAL;
 	}
 
-	dma_fence_wait_timeout(out_fence, false, MAX_SCHEDULE_TIMEOUT);
+	ret = dma_fence_wait_timeout(out_fence, true, MAX_SCHEDULE_TIMEOUT);
 	dma_fence_put(out_fence);
+
+	return ret < 0 ? ret : 0;
 }
 
 static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hwctx *hwctx, u32 bo_hdl,
@@ -954,7 +957,10 @@ static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hwctx *hwctx, u32 bo_hdl,
 		goto put_cmd;
 	}
 
-	aie2_cmd_wait(hwctx, seq);
+	ret = aie2_cmd_wait(hwctx, seq);
+	if (ret)
+		goto put_cmd;
+
 	if (cmd->result) {
 		XDNA_ERR(xdna, "Response failure 0x%x", cmd->result);
 		ret = -EINVAL;
@@ -1014,7 +1020,10 @@ int aie2_hwctx_sync_debug_bo(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl)
 		goto put_cmd;
 	}
 
-	aie2_cmd_wait(hwctx, seq);
+	ret = aie2_cmd_wait(hwctx, seq);
+	if (ret)
+		goto put_cmd;
+
 	if (cmd->result) {
 		XDNA_ERR(xdna, "Response failure 0x%x", cmd->result);
 		ret = -EINVAL;
-- 
2.55.0

