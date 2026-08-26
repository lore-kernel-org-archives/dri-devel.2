Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6EAC61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:31:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC07110E2D4;
	Wed, 26 Aug 2026 15:31:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="EVkI7kuh";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-219.mta0.migadu.com [91.218.175.219])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27EE610E2C8
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 15:31:38 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=rKP9Q8YeQ1EszJaUpHBszkuQ34E/nM62+nafjXCYxMU=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787758296; v=1; x=1788363096;
 b=EVkI7kuhXNsojdKrSSxYTqIQa4oHVlxZppyHmtIAO0mtc5AAfRnlxujbghTAwbX/Loq8pYhW
 i3LDqVuduYz2IpPHwiWDbwGgXO5Misje68lpHTt8a+/37xe66u+IdNpz+xIrBKRtiYWVeerE2ha
 0AXIIaROC3mNnumqMwh66wv+0fzIacJLBa7HqGwAFR7kfo3JXqKALsRBCPjWIv5xQtgOMqT78GQ
 hCGkcwNtIkyMQr3Jq+jpsELjRXOrCxKGzlidLpL1NOOk2FzjokCZCyJtpHZm738B6ZYx5CezXVU
 DnCnOVgKdU6k1YBm9zEbojaEdbA8DAE0pr/mHD5vk+Ktw==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.110.63)
 by smtp.migadu.com with ESMTPS id ff243b0cbe837d9b;
 Wed, 26 Aug 2026 15:31:36 +0000
X-Mizu-Trace-ID: ff243b0cbe837d9b
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: taimuraz@kaitmazov.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] accel/amdxdna: use READ_ONCE/WRITE_ONCE on the command
 header
Date: Wed, 26 Aug 2026 18:31:21 +0300
Message-ID: <20260826153121.133507-3-taimuraz@kaitmazov.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826153121.133507-1-taimuraz@kaitmazov.com>
References: <20260826143036.100089-1-taimuraz@kaitmazov.com>
 <20260826153121.133507-1-taimuraz@kaitmazov.com>
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

struct amdxdna_cmd::header packs STATE, OPCODE, COUNT and EXTRA_CU_MASK
into one u32 that lives in a BO user space keeps mapped. The driver
re-reads it on every accessor call and read-modify-writes STATE in place,
with plain accesses that let the compiler split or refetch either side.

Annotate them, as the UMQ ring indices already are. This does not make
the update atomic against user space, it only stops the compiler from
making it worse.

Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
 drivers/accel/amdxdna/amdxdna_ctx.c | 14 +++++++++-----
 drivers/accel/amdxdna/amdxdna_ctx.h | 11 +++++++----
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 9f44e3918bc1..148ae51db0f1 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -123,9 +123,10 @@ void *amdxdna_cmd_get_payload(struct amdxdna_gem_obj *abo, u32 *size)
 	if (amdxdna_cmd_get_op(abo) == ERT_CMD_CHAIN)
 		num_masks = 0;
 	else
-		num_masks = 1 + FIELD_GET(AMDXDNA_CMD_EXTRA_CU_MASK, cmd->header);
+		num_masks = 1 + FIELD_GET(AMDXDNA_CMD_EXTRA_CU_MASK,
+					  READ_ONCE(cmd->header));
 
-	count = FIELD_GET(AMDXDNA_CMD_COUNT, cmd->header);
+	count = FIELD_GET(AMDXDNA_CMD_COUNT, READ_ONCE(cmd->header));
 	if (unlikely(count <= num_masks ||
 		     count * sizeof(u32) +
 		     offsetof(struct amdxdna_cmd, data[0]) >
@@ -173,7 +174,7 @@ u32 amdxdna_cmd_get_cu_idx(struct amdxdna_gem_obj *abo)
 	if (amdxdna_cmd_get_op(abo) == ERT_CMD_CHAIN)
 		return INVALID_CU_IDX;
 
-	num_masks = 1 + FIELD_GET(AMDXDNA_CMD_EXTRA_CU_MASK, cmd->header);
+	num_masks = 1 + FIELD_GET(AMDXDNA_CMD_EXTRA_CU_MASK, READ_ONCE(cmd->header));
 	cu_mask = cmd->data;
 	for (i = 0; i < num_masks; i++) {
 		if (cu_mask[i])
@@ -191,12 +192,15 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
 	struct amdxdna_client *client = job->hwctx->client;
 	struct amdxdna_cmd *cmd = amdxdna_gem_vmap(abo);
 	struct amdxdna_cmd_chain *cc = NULL;
+	u32 header;
 
 	if (!cmd)
 		return -ENOMEM;
 
-	cmd->header &= ~AMDXDNA_CMD_STATE;
-	cmd->header |= FIELD_PREP(AMDXDNA_CMD_STATE, error_state);
+	header = READ_ONCE(cmd->header);
+	header &= ~AMDXDNA_CMD_STATE;
+	header |= FIELD_PREP(AMDXDNA_CMD_STATE, error_state);
+	WRITE_ONCE(cmd->header, header);
 
 	if (amdxdna_cmd_get_op(abo) == ERT_CMD_CHAIN) {
 		u32 ccnt;
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
index f6529d512217..48e1fcfd818f 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.h
+++ b/drivers/accel/amdxdna/amdxdna_ctx.h
@@ -169,19 +169,22 @@ amdxdna_cmd_get_op(struct amdxdna_gem_obj *abo)
 	if (!cmd)
 		return ERT_INVALID_CMD;
 
-	return FIELD_GET(AMDXDNA_CMD_OPCODE, cmd->header);
+	return FIELD_GET(AMDXDNA_CMD_OPCODE, READ_ONCE(cmd->header));
 }
 
 static inline void
 amdxdna_cmd_set_state(struct amdxdna_gem_obj *abo, enum ert_cmd_state s)
 {
 	struct amdxdna_cmd *cmd = amdxdna_gem_vmap(abo);
+	u32 header;
 
 	if (!cmd)
 		return;
 
-	cmd->header &= ~AMDXDNA_CMD_STATE;
-	cmd->header |= FIELD_PREP(AMDXDNA_CMD_STATE, s);
+	header = READ_ONCE(cmd->header);
+	header &= ~AMDXDNA_CMD_STATE;
+	header |= FIELD_PREP(AMDXDNA_CMD_STATE, s);
+	WRITE_ONCE(cmd->header, header);
 }
 
 static inline enum ert_cmd_state
@@ -192,7 +195,7 @@ amdxdna_cmd_get_state(struct amdxdna_gem_obj *abo)
 	if (!cmd)
 		return ERT_CMD_STATE_INVALID;
 
-	return FIELD_GET(AMDXDNA_CMD_STATE, cmd->header);
+	return FIELD_GET(AMDXDNA_CMD_STATE, READ_ONCE(cmd->header));
 }
 
 void *amdxdna_cmd_get_payload(struct amdxdna_gem_obj *abo, u32 *size);
-- 
2.55.0

