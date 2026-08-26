Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C1AC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0286310E136;
	Wed, 26 Aug 2026 14:30:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="hTy+0Pwo";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-207.mta0.migadu.com [91.218.175.207])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE5A010E136
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 14:30:55 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=TlpUpUwPm9Up6HJJQ67i8ZqdAMUqi4WUm3wRXe3c2QY=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787754653; v=1; x=1788359453;
 b=hTy+0PwoEO7b7vvX7PNCPnyr4yY/cUNWllhGWmeQD2+6OZshvUd8hGSxH6kNSWat6tn8OiwK
 0xg+PEGPEkPwHxIg9T8fkceaGyNuvq0SrP06ulDMsDq96xz8xNIkmZv7NLGlBMSVaItBZaz0/1l
 30qUnl60eGmO6mQBLAEAU7jbMKcGo4ZMNb7rduRR1pbSKx12BiaKjiBDIXw36pJ8DK7MmXrRZsN
 B7pOP3UlK89s71fLT7LYbABHPFz54DNw5Phlq6cGgTr8OjebMp9i1t3c6gBL79ndJ/lsd3ltnZW
 AtGMNKv+9XmKcMWyxI+UBtkSMvSulG70qXhHgVZ7uJI+Q==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.110.63)
 by smtp.migadu.com with ESMTPS id 108117da66e90bb2;
 Wed, 26 Aug 2026 14:30:53 +0000
X-Mizu-Trace-ID: 108117da66e90bb2
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: taimuraz@kaitmazov.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] accel/amdxdna: check the command chain payload before
 using it
Date: Wed, 26 Aug 2026 17:30:35 +0300
Message-ID: <20260826143036.100089-2-taimuraz@kaitmazov.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826143036.100089-1-taimuraz@kaitmazov.com>
References: <20260826143036.100089-1-taimuraz@kaitmazov.com>
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

amdxdna_cmd_get_payload() only bounds-checks the payload when a size
pointer is passed, so its two callers get different guarantees from one
function. amdxdna_cmd_set_error() takes the unchecked form and then reads
cc->command_count and cc->data[0], neither of which has been shown to
lie inside the BO.

Make the size mandatory and add amdxdna_cmd_get_chain(), which returns
the chain only once the declared command count is known to fit.

Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
 drivers/accel/amdxdna/amdxdna_ctx.c | 51 ++++++++++++++++++++++-------
 drivers/accel/amdxdna/amdxdna_ctx.h |  2 ++
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 855da8c79a1c..143cbbbf4b31 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -125,20 +125,42 @@ void *amdxdna_cmd_get_payload(struct amdxdna_gem_obj *abo, u32 *size)
 	else
 		num_masks = 1 + FIELD_GET(AMDXDNA_CMD_EXTRA_CU_MASK, cmd->header);
 
-	if (size) {
-		count = FIELD_GET(AMDXDNA_CMD_COUNT, cmd->header);
-		if (unlikely(count <= num_masks ||
-			     count * sizeof(u32) +
-			     offsetof(struct amdxdna_cmd, data[0]) >
-			     abo->mem.size)) {
-			*size = 0;
-			return NULL;
-		}
-		*size = (count - num_masks) * sizeof(u32);
+	count = FIELD_GET(AMDXDNA_CMD_COUNT, cmd->header);
+	if (unlikely(count <= num_masks ||
+		     count * sizeof(u32) +
+		     offsetof(struct amdxdna_cmd, data[0]) >
+		     abo->mem.size)) {
+		*size = 0;
+		return NULL;
 	}
+	*size = (count - num_masks) * sizeof(u32);
+
 	return &cmd->data[num_masks];
 }
 
+/*
+ * Returns the chain payload of @abo, with @count set to a command count that
+ * has been checked to fit. The chain fields live in a BO user space keeps
+ * mapped, so nothing may read them without going through here.
+ */
+struct amdxdna_cmd_chain *
+amdxdna_cmd_get_chain(struct amdxdna_gem_obj *abo, u32 *count)
+{
+	struct amdxdna_cmd_chain *cc;
+	u32 len, ccnt;
+
+	cc = amdxdna_cmd_get_payload(abo, &len);
+	if (!cc || len < sizeof(*cc))
+		return NULL;
+
+	ccnt = cc->command_count;
+	if (len < struct_size(cc, data, ccnt))
+		return NULL;
+
+	*count = ccnt;
+	return cc;
+}
+
 u32 amdxdna_cmd_get_cu_idx(struct amdxdna_gem_obj *abo)
 {
 	struct amdxdna_cmd *cmd = amdxdna_gem_vmap(abo);
@@ -177,8 +199,13 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
 	cmd->header |= FIELD_PREP(AMDXDNA_CMD_STATE, error_state);
 
 	if (amdxdna_cmd_get_op(abo) == ERT_CMD_CHAIN) {
-		cc = amdxdna_cmd_get_payload(abo, NULL);
-		cc->error_index = (cmd_idx < cc->command_count) ? cmd_idx : 0;
+		u32 ccnt;
+
+		cc = amdxdna_cmd_get_chain(abo, &ccnt);
+		if (!cc || !ccnt)
+			return -EINVAL;
+
+		cc->error_index = (cmd_idx < ccnt) ? cmd_idx : 0;
 		abo = amdxdna_gem_get_obj(client, cc->data[0], AMDXDNA_BO_SHARE);
 		if (!abo)
 			return -EINVAL;
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
index b6bef3af7dab..f6529d512217 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.h
+++ b/drivers/accel/amdxdna/amdxdna_ctx.h
@@ -196,6 +196,8 @@ amdxdna_cmd_get_state(struct amdxdna_gem_obj *abo)
 }
 
 void *amdxdna_cmd_get_payload(struct amdxdna_gem_obj *abo, u32 *size);
+struct amdxdna_cmd_chain *
+amdxdna_cmd_get_chain(struct amdxdna_gem_obj *abo, u32 *count);
 u32 amdxdna_cmd_get_cu_idx(struct amdxdna_gem_obj *abo);
 int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
 			  struct amdxdna_sched_job *job, u32 cmd_idx,
-- 
2.55.0

