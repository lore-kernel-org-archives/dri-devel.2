Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DC7C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1F1C10E2A0;
	Wed, 26 Aug 2026 14:20:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="Fwwj9NN/";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-80.mta0.migadu.com [91.218.175.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C93E10E2A0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 14:20:26 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=gY7LxnMigSCiuZHIBDJUTwN7peEI9ActDy79FC6nAzA=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787754024; v=1; x=1788358824;
 b=Fwwj9NN/PckHW89Jvs78XYpuMIdKtQY51hUDQL4qlSv5XDZ4BdQ2uxYcONmD6qrkf6mzJx5Q
 xw/AV2whiqi7+cuJL7uWWb+IlPvGOfNtbYqv36e2ZIcDLx7G1Fy1qSczfzGE72Nn4OI/NjffB26
 BrQkXKajGS+t/ORALxoHDK/LyvCx6TPtFc4e9Vge/rrNZy0ndhiwiGPLCm54LAAjt9tCN/y5gCn
 jjcmXxw9M7NcyjUQ5qOWrvHPMM27r0JBTF9okK/+IF5kC+A09TxTBMErwSflWILvzmiQINU7wkx
 Zet9rfiTCs46jDrxbMm3Ew4GTN+QeLzxfCS7k5fKoP2tA==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.110.63)
 by smtp.migadu.com with ESMTPS id 40af9f27cff9063b;
 Wed, 26 Aug 2026 14:20:24 +0000
X-Mizu-Trace-ID: 40af9f27cff9063b
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: taimuraz@kaitmazov.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] accel/amdxdna: spell out the ERT command state values
Date: Wed, 26 Aug 2026 17:20:16 +0300
Message-ID: <20260826142016.98903-1-taimuraz@kaitmazov.com>
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

enum ert_cmd_state has no explicit values, but the enumerators are written
into the command header that user space reads back from the shared command
BO, so they are ABI. Inserting a state would silently renumber every value
after it.

Assign them, as enum ert_cmd_opcode above already does.

Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
 drivers/accel/amdxdna/amdxdna_ctx.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
index b6bef3af7dab..ef49b0c8a9d5 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.h
+++ b/drivers/accel/amdxdna/amdxdna_ctx.h
@@ -22,17 +22,18 @@ enum ert_cmd_opcode {
 	ERT_INVALID_CMD	= ~0U,
 };
 
+/* Reported to user space in the command header, so the values are ABI. */
 enum ert_cmd_state {
-	ERT_CMD_STATE_INVALID,
-	ERT_CMD_STATE_NEW,
-	ERT_CMD_STATE_QUEUED,
-	ERT_CMD_STATE_RUNNING,
-	ERT_CMD_STATE_COMPLETED,
-	ERT_CMD_STATE_ERROR,
-	ERT_CMD_STATE_ABORT,
-	ERT_CMD_STATE_SUBMITTED,
-	ERT_CMD_STATE_TIMEOUT,
-	ERT_CMD_STATE_NORESPONSE,
+	ERT_CMD_STATE_INVALID = 0,
+	ERT_CMD_STATE_NEW = 1,
+	ERT_CMD_STATE_QUEUED = 2,
+	ERT_CMD_STATE_RUNNING = 3,
+	ERT_CMD_STATE_COMPLETED = 4,
+	ERT_CMD_STATE_ERROR = 5,
+	ERT_CMD_STATE_ABORT = 6,
+	ERT_CMD_STATE_SUBMITTED = 7,
+	ERT_CMD_STATE_TIMEOUT = 8,
+	ERT_CMD_STATE_NORESPONSE = 9,
 };
 
 /*
-- 
2.55.0

