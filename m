Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76496C61DC6
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D66D10ECE1;
	Wed, 26 Aug 2026 18:45:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="jLPww5vI";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-46.mta1.migadu.com [95.215.58.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 364F910ECE1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 18:45:20 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=jiyZvNfn4pNvesC36BaCfY1JxjiSSyLRz7poWms0EEE=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787769918; v=1; x=1788374718;
 b=jLPww5vInEI+CJbvO9PApsjgO327Uj2UpV/u7mWYl/jZ0CwWlE8Lc9CDodYE2R5ZQk0AHvTF
 zit/3l2Jpey4Z3oxkbxO/P0ZVRKc54SWwHvMoc8yH3KZIKJDd5CPraG6rnqf6qKvlOHN0O1RZGA
 N0gagLO/iIxZYbjyH4zhqDi7HS1r3W8AFWe9oaN0rSBUHCDUku35cE8kCIQ0MmHykwkLjGbqCtP
 pFH4i0uPdRtEO+rkoOuuYOpf5+zQIbDIc+4qE9YC41KrSISFeQknfWfHL9D19XwzwOjvfW0FYcJ
 5vL5ZrbfaEb8VNXzHReZm2/mURHMRwVX39H9SoVGEV48g==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.110.63)
 by smtp.migadu.com with ESMTPS id 29cdaf55c397b179;
 Wed, 26 Aug 2026 18:45:11 +0000
X-Mizu-Trace-ID: 29cdaf55c397b179
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: taimuraz@kaitmazov.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] accel/amdxdna: make the debug BO command wait interruptible
Date: Wed, 26 Aug 2026 21:45:03 +0300
Message-ID: <20260826184503.282106-1-taimuraz@kaitmazov.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <b7e8caf7-18de-fcbb-ee42-1b49b67b5eef@amd.com>
References: <b7e8caf7-18de-fcbb-ee42-1b49b67b5eef@amd.com>
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

aie2_cmd_wait() waits uninterruptibly and without a timeout. Commit
c8d2530791cb ("accel/amdxdna: Fix deadlock on debug BO command timeout")
drops dev_lock around that wait, but the callers still hold client_lock,
and that one is device wide. So while a debug BO command is outstanding,
nobody can open the device, nobody can close their DRM file and exit, and
the module cannot be unloaded.

Normally the scheduler timeout ends it: tdr_timeout_ms defaults to 2000.
But with tdr_timeout_ms=0 there is no scheduler timeout at all, the wait
never ends, and since it is uninterruptible you cannot even kill the
stuck task to get client_lock back.

So wait interruptibly and pass the result up. I return -EINTR and not
-ERESTARTSYS on purpose: the command is still in flight, and a restarted
ioctl would just submit a second one.

If the wait is interrupted we do not know what firmware did, so
aie2_hwctx_cfg_debug_bo() cannot tell whether the BO got attached. It
records it as attached, because DETACH is refused for a BO that is not
assigned to the context, and the other way round would leave a BO
attached in firmware with no way to detach it. aie2_hwctx_sync_debug_bo()
does not touch that state, so it needs nothing here.

Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
v2:
- Rebased onto drm-misc-fixes, as you asked. v1 was against
  drm-misc-next, which does not carry that commit, so the deadlock
  reasoning in its message is gone. Please also disregard my follow-up
  question on the v1 thread: it asked which of two shapes you would
  prefer, and one of them was what you had already done.
- Return -EINTR instead of -ERESTARTSYS.
- Record the debug BO as attached when the wait is interrupted.
- Leave the !out_fence path returning success as before, so this patch
  changes only the wait.

 drivers/accel/amdxdna/aie2_ctx.c | 33 +++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index b713a57b3a3b..175fceea5c8f 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -908,20 +908,30 @@ static int aie2_hwctx_cu_config(struct amdxdna_hwctx *hwctx, void *buf, u32 size
 	return ret;
 }
 
-static void aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
+static int aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
 {
 	struct dma_fence *out_fence = aie2_cmd_get_out_fence(hwctx, seq);
 	struct amdxdna_dev *xdna = hwctx->client->xdna;
+	long ret;
 
 	if (!out_fence) {
 		XDNA_ERR(xdna, "Failed to get fence");
-		return;
+		return 0;
 	}
 
 	mutex_unlock(&xdna->dev_lock);
-	dma_fence_wait_timeout(out_fence, false, MAX_SCHEDULE_TIMEOUT);
+	ret = dma_fence_wait_timeout(out_fence, true, MAX_SCHEDULE_TIMEOUT);
 	mutex_lock(&xdna->dev_lock);
 	dma_fence_put(out_fence);
+
+	/*
+	 * The command is still in flight. If the ioctl were restarted it
+	 * would submit a second one.
+	 */
+	if (ret == -ERESTARTSYS)
+		return -EINTR;
+
+	return ret < 0 ? ret : 0;
 }
 
 static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hwctx *hwctx, u32 bo_hdl,
@@ -968,7 +978,17 @@ static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hwctx *hwctx, u32 bo_hdl,
 		goto put_cmd;
 	}
 
-	aie2_cmd_wait(hwctx, seq);
+	ret = aie2_cmd_wait(hwctx, seq);
+	if (ret) {
+		/*
+		 * The command may still attach the BO. Record it as attached,
+		 * or DETACH will refuse it and there is no way back.
+		 */
+		if (attach)
+			abo->assigned_hwctx = hwctx->id;
+		goto put_cmd;
+	}
+
 	if (cmd->result) {
 		XDNA_ERR(xdna, "Response failure 0x%x", cmd->result);
 		ret = -EINVAL;
@@ -1028,7 +1048,10 @@ int aie2_hwctx_sync_debug_bo(struct amdxdna_hwctx *hwctx, u32 debug_bo_hdl)
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

