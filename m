Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57000C61DC4
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 22:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ADEB10E9A8;
	Wed, 26 Aug 2026 22:13:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="K+Km41VZ";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-92.mta0.migadu.com [91.218.175.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E20A210E9A8
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 22:13:43 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=7e06RSY5nY8Gw6424Ho6Ajl161TN5ZxFf2Rb/mGlW6I=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787782421; v=1; x=1788387221;
 b=K+Km41VZXnRFAbKmQkGK5SRcfzKWA/24Rd3njDLoYelcDioZc/An1PDag1h+/w6vlphjM/1q
 0J7olGq/LC7cJfUk9us0OGrB6l2PDX6R6shj241CtvHDyo/iw9K/ZAK6pNYt2Zs0zbOecBOFQPE
 IorFRFehnoPo7CHid5qlNi8M4aK17Qcbd3yg5DjlVeZvAw5PZ51+o5w0qWgrVHi2lssB53SPQX4
 Oa4rD35TbKclBwPC/18WSkHEWs27kgsUnvy39F27BXxRxM78kXMr19XMXzIC1UaEDSUbrGRxGkb
 e+cEPJ5jYU/2C71Ws5cAnjS+iwFau+508XwCCROvcNBVw==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.110.63)
 by smtp.migadu.com with ESMTPS id 2744820636e34e79;
 Wed, 26 Aug 2026 22:13:41 +0000
X-Mizu-Trace-ID: 2744820636e34e79
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: taimuraz@kaitmazov.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3] accel/amdxdna: use READ_ONCE/WRITE_ONCE on the command
 header
Date: Thu, 27 Aug 2026 01:13:34 +0300
Message-ID: <20260826221334.625974-1-taimuraz@kaitmazov.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <a203be1c-d28d-c33e-0a94-da725ec2d5aa@amd.com>
References: <a203be1c-d28d-c33e-0a94-da725ec2d5aa@amd.com>
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

amdxdna_cmd::header packs the state, the opcode, the CU mask count and
the payload count into one u32 that lives in a BO user space keeps
mapped. The driver reads it with plain accesses, and reads it more than
once per function: amdxdna_cmd_get_payload() takes num_masks and count
from it separately, so the compiler is free to load it twice and the two
fields can come from different values.

amdxdna_cmd_set_error() and amdxdna_cmd_set_state() also read, modify and
write it in place, which lets the compiler split the store.

Read it once into a local with READ_ONCE() and write it back with
WRITE_ONCE().

Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
v3:
- Dropped 1/2. You are right, EXTRA_CU_MASK is 2 bits, so the payload
  starts at most 16 bytes in and both reads land well inside a page
  granular BO.
- This patch never depended on it, so it goes standalone.

 drivers/accel/amdxdna/amdxdna_ctx.c | 14 +++++++++-----
 drivers/accel/amdxdna/amdxdna_ctx.h | 11 +++++++----
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 888e857ec558..02027522210d 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -123,10 +123,11 @@ void *amdxdna_cmd_get_payload(struct amdxdna_gem_obj *abo, u32 *size)
 	if (amdxdna_cmd_get_op(abo) == ERT_CMD_CHAIN)
 		num_masks = 0;
 	else
-		num_masks = 1 + FIELD_GET(AMDXDNA_CMD_EXTRA_CU_MASK, cmd->header);
+		num_masks = 1 + FIELD_GET(AMDXDNA_CMD_EXTRA_CU_MASK,
+					  READ_ONCE(cmd->header));
 
 	if (size) {
-		count = FIELD_GET(AMDXDNA_CMD_COUNT, cmd->header);
+		count = FIELD_GET(AMDXDNA_CMD_COUNT, READ_ONCE(cmd->header));
 		if (unlikely(count <= num_masks ||
 			     count * sizeof(u32) +
 			     offsetof(struct amdxdna_cmd, data[0]) >
@@ -151,7 +152,7 @@ u32 amdxdna_cmd_get_cu_idx(struct amdxdna_gem_obj *abo)
 	if (amdxdna_cmd_get_op(abo) == ERT_CMD_CHAIN)
 		return INVALID_CU_IDX;
 
-	num_masks = 1 + FIELD_GET(AMDXDNA_CMD_EXTRA_CU_MASK, cmd->header);
+	num_masks = 1 + FIELD_GET(AMDXDNA_CMD_EXTRA_CU_MASK, READ_ONCE(cmd->header));
 	cu_mask = cmd->data;
 	for (i = 0; i < num_masks; i++) {
 		if (cu_mask[i])
@@ -169,12 +170,15 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
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
 		cc = amdxdna_cmd_get_payload(abo, NULL);
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
index 6e78bab8a02c..fb440a0e2c54 100644
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

