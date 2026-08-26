Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FFFC61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA98B10EDD4;
	Wed, 26 Aug 2026 19:58:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="mFFspuO0";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-108.mta1.migadu.com [95.215.58.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC01B10EDD4
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 19:57:59 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=XmPHKK2gtlVDMOVoUoV871D8i4tPENx255PwqXAIRdo=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787774278; v=1; x=1788379078;
 b=mFFspuO0/d22NkardeDQnOdIOdAiadgtqLwEqUiDaSZq7tUQ7eYB3PSzwv0xkwFzU+dqLjWh
 8N+GDHrqRtbT/s3yBAgkEJkC50s1aPcld3ogaG9FV7eNJ2E9gaWFQG/1OG9zxrI6ksIULuTY5rP
 9so9zSIo1IxOfZKtWnrIWRPODz7+rYlCUWwgYuZcuUTIw5+8sTeP8ea9cQrNnfYay+YXMjTlr/9
 4qD2oIVNcnNhvvJBiYmAZmdT2VeCIGl8hZ42GUUHonTfbZutUvpTgA2OhS1T3vLYB/KXaGE555a
 jL/P8/yx14Yg33fzg/hLRIW9mXFCKIcbm84w05cPpDSsQ==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.110.63)
 by smtp.migadu.com with ESMTPS id 749e70c873f72b70;
 Wed, 26 Aug 2026 19:57:58 +0000
X-Mizu-Trace-ID: 749e70c873f72b70
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: taimuraz@kaitmazov.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] accel/amdxdna: make the debug BO command wait interruptible
Date: Wed, 26 Aug 2026 22:57:51 +0300
Message-ID: <20260826195751.358629-1-taimuraz@kaitmazov.com>
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
drops dev_lock across it, but the callers still hold client_lock, which is
device wide: while a debug BO command is outstanding nobody can open the
device, close their DRM file, or unload the module. tdr_timeout_ms=0 makes
that unbounded, and the task cannot be killed to release the lock.

Wait interruptibly. Return -EINTR, not -ERESTARTSYS: the command stays in
flight and a restarted ioctl would submit a second one. An interrupted
ATTACH leaves the outcome unknown, so record the BO as attached, since
DETACH is refused otherwise.

Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
v2:
- Rebased onto drm-misc-fixes, as you asked; the deadlock reasoning in v1
  is gone with it. Please also disregard my follow-up question on the v1
  thread, it asked about a shape you had already taken.
- Added the Fixes: tag c8d2530791cb carries for this function.
- Return -EINTR instead of -ERESTARTSYS.
- Record the debug BO as attached when the wait is interrupted.
- Leave the !out_fence path returning success, so only the wait changes.

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

