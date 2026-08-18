Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64D6C5B572
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 00:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B60D710E35D;
	Tue, 18 Aug 2026 00:25:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="vx3MsWTx";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-223.mta0.migadu.com [91.218.175.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6CFB10E35D
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 00:25:17 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=8K8dMgk2NbNEbRYKKtw5Zyi/B6uIgdliRfHQzzunMPQ=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787012715; v=1; x=1787617515;
 b=vx3MsWTxPWWOY2wEIa4+YUQUeDc7E0cO7Xr2H5QFKWZ679DLOpBtoe849hWHHMZX7FdjPkiU
 NAbAzw+rlpRXT59jxIOdh3sHZjcs1M6BlhWrbgZxueLn8bQ3Jxemt1a4y4zm6GbLXk1hFeOLSdb
 sZDi6iYf9vCxGAwxoVxvJk6v2Zf8wOwemv5YlClxSrx3Wy+Sj+uxLLFZittMd8WLooKjHlvozRS
 5+fJdaGhWC2jWfJFzVcWDuj5DRvJlSDyfYNOdjKgdyBPOVeMArqXZEo+SHh0QF9rTqVsBXCSfyx
 gnJZLuxfRHQWIBjNaWco6q8N6+UzojXU/rhg0Jl/LpZLw==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.111.69)
 by smtp.migadu.com with ESMTPS id 04c42f14d49d2633;
 Tue, 18 Aug 2026 00:25:05 +0000
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: lizhi.hou@amd.com,
	mamin506@gmail.com,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Subject: [PATCH] accel/amdxdna: check the command payload before using it
Date: Tue, 18 Aug 2026 03:24:59 +0300
Message-ID: <20260818002459.377641-1-taimuraz@kaitmazov.com>
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

amdxdna_cmd_get_payload() answers NULL when the command BO cannot be
mapped, and on that path it returns before writing *size, so the caller's
length keeps whatever the stack held. Its eight callers in aie2_message.c
use both without checking either:

	cmd = amdxdna_cmd_get_payload(cmd_bo, &cmd_len);
	if (cmd_len > sizeof(cu_req->payload))
		return -EINVAL;
	...
	memcpy(cu_req->payload, cmd, cmd_len);

so an uninitialised length decides the bounds check and then a NULL
source is copied from. The mapping fails under vmalloc pressure today,
and any future reason for amdxdna_gem_vmap() to refuse widens it.

Check the pointer, and clear the length before the early return so a
caller that ignores the pointer still reads a defined value.

Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
 drivers/accel/amdxdna/aie2_message.c | 16 ++++++++++++++++
 drivers/accel/amdxdna/amdxdna_ctx.c  |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index dfe0fbdf066d..6f258206d508 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -555,6 +555,8 @@ static int aie2_init_exec_cu_req(struct amdxdna_gem_obj *cmd_bo, void *req,
 	void *cmd;
 
 	cmd = amdxdna_cmd_get_payload(cmd_bo, &cmd_len);
+	if (!cmd)
+		return -EINVAL;
 	if (cmd_len > sizeof(cu_req->payload))
 		return -EINVAL;
 
@@ -577,6 +579,8 @@ static int aie2_init_exec_dpu_req(struct amdxdna_gem_obj *cmd_bo, void *req,
 	u32 cmd_len;
 
 	sn = amdxdna_cmd_get_payload(cmd_bo, &cmd_len);
+	if (!sn)
+		return -EINVAL;
 	if (cmd_len - sizeof(*sn) > sizeof(dpu_req->payload))
 		return -EINVAL;
 
@@ -622,6 +626,8 @@ aie2_cmdlist_fill_cf(struct amdxdna_gem_obj *cmd_bo, void *slot, size_t *size)
 	void *cmd;
 
 	cmd = amdxdna_cmd_get_payload(cmd_bo, &cmd_len);
+	if (!cmd)
+		return -EINVAL;
 	if (*size < sizeof(*cf_slot) + cmd_len)
 		return -EINVAL;
 
@@ -645,6 +651,8 @@ aie2_cmdlist_fill_dpu(struct amdxdna_gem_obj *cmd_bo, void *slot, size_t *size)
 	u32 arg_sz;
 
 	sn = amdxdna_cmd_get_payload(cmd_bo, &cmd_len);
+	if (!sn)
+		return -EINVAL;
 	arg_sz = cmd_len - sizeof(*sn);
 	if (cmd_len < sizeof(*sn) || arg_sz > MAX_DPU_ARGS_SIZE)
 		return -EINVAL;
@@ -705,6 +713,8 @@ aie2_cmdlist_fill_npu_cf(struct amdxdna_gem_obj *cmd_bo, void *slot, size_t *siz
 	void *cmd;
 
 	cmd = amdxdna_cmd_get_payload(cmd_bo, &cmd_len);
+	if (!cmd)
+		return -EINVAL;
 	if (*size < sizeof(*npu_slot) + cmd_len)
 		return -EINVAL;
 
@@ -730,6 +740,8 @@ aie2_cmdlist_fill_npu_dpu(struct amdxdna_gem_obj *cmd_bo, void *slot, size_t *si
 	u32 arg_sz;
 
 	sn = amdxdna_cmd_get_payload(cmd_bo, &cmd_len);
+	if (!sn)
+		return -EINVAL;
 	arg_sz = cmd_len - sizeof(*sn);
 	if (cmd_len < sizeof(*sn) || arg_sz > MAX_NPU_ARGS_SIZE)
 		return -EINVAL;
@@ -762,6 +774,8 @@ aie2_cmdlist_fill_npu_preempt(struct amdxdna_gem_obj *cmd_bo, void *slot, size_t
 	u32 arg_sz;
 
 	pd = amdxdna_cmd_get_payload(cmd_bo, &cmd_len);
+	if (!pd)
+		return -EINVAL;
 	arg_sz = cmd_len - sizeof(*pd);
 	if (cmd_len < sizeof(*pd) || arg_sz > MAX_NPU_ARGS_SIZE)
 		return -EINVAL;
@@ -798,6 +812,8 @@ aie2_cmdlist_fill_npu_elf(struct amdxdna_gem_obj *cmd_bo, void *slot, size_t *si
 	u32 arg_sz;
 
 	pd = amdxdna_cmd_get_payload(cmd_bo, &cmd_len);
+	if (!pd)
+		return -EINVAL;
 	arg_sz = cmd_len - sizeof(*pd);
 	if (cmd_len < sizeof(*pd) || arg_sz > MAX_NPU_ARGS_SIZE)
 		return -EINVAL;
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 31a414c3f0d9..505c249e142e 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -117,6 +117,9 @@ void *amdxdna_cmd_get_payload(struct amdxdna_gem_obj *abo, u32 *size)
 	struct amdxdna_cmd *cmd = amdxdna_gem_vmap(abo);
 	u32 num_masks, count;
 
+	if (size)
+		*size = 0;
+
 	if (!cmd)
 		return NULL;
 
-- 
2.55.0

