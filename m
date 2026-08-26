Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA15C61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 22:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F2EE10E631;
	Wed, 26 Aug 2026 22:27:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="x/IV4MIp";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-157.mta1.migadu.com [95.215.58.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D38510E332
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 22:27:42 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=3g5uXE6CHMdBeWY9m6C7BvFgKE1qywzXziiQvHgfTyI=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787783260; v=1; x=1788388060;
 b=x/IV4MIpeHwT2PWfPQiMdK0DffWCsIN8GpNLVhum4MXQhgVRUS9EumdROj1bnTcazOJWS7KH
 hGRU5ba+qT4G5ySjGicXFajXvp65KyKM3ZY65DuMgtCKeL5d0x1yLrw937OdEg0A9XK38BnqZqX
 MaUhfMwyY47qyTbGsvNK/WulCkIr7RArkp3jCfldyk72dKRbg+rnjsOwKqRtQX2HVjg4YKYES8H
 4pnlnCirPQEIjTmyT92ZiP+ox3avlDA8Z6ebHUrNmrT4j0vlkxlXEBFXVq5VkrIzMmUocNa9osL
 EfJydKGPey9G629bst3HYAiO2UNXb/N9H3F7uOArdXeJA==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.110.63)
 by smtp.migadu.com with ESMTPS id ab49d0e9be535785;
 Wed, 26 Aug 2026 22:27:40 +0000
X-Mizu-Trace-ID: ab49d0e9be535785
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: taimuraz@kaitmazov.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] accel/amdxdna: Invalidate the payload of the command that
 failed
Date: Thu, 27 Aug 2026 01:27:35 +0300
Message-ID: <20260826222735.672227-1-taimuraz@kaitmazov.com>
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

amdxdna_cmd_set_error() computes the failing command's index into
cc->error_index and then looks up cc->data[0], so the 0xff fill and the
err_data land on the first command of the chain no matter which one failed.
Commit 89ff45359abb ("accel/amdxdna: Fill invalid payload for failed
command") added the index and that lookup together, and describes the fill
as being for the failed command.

So a chain that fails at a later index leaves that command's payload
untouched, which is what the fill exists to prevent, and overwrites the
payload of one that completed. XRT reads the failing command by
error_index, so on the timeout path the err_data lands where it does not
look.

Use the index for the lookup. Keep it in a local: the chain lives in a BO
user space keeps mapped and can rewrite between the store and the load.
The index itself is firmware supplied and bounded by the command count
aie2_cmdlist_multi_execbuf() validated at submit.

Fixes: 89ff45359abb ("accel/amdxdna: Fill invalid payload for failed command")
Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
 drivers/accel/amdxdna/amdxdna_ctx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 888e857ec558..976c1ad864d7 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -177,9 +177,12 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
 	cmd->header |= FIELD_PREP(AMDXDNA_CMD_STATE, error_state);
 
 	if (amdxdna_cmd_get_op(abo) == ERT_CMD_CHAIN) {
+		u32 err_idx;
+
 		cc = amdxdna_cmd_get_payload(abo, NULL);
-		cc->error_index = (cmd_idx < cc->command_count) ? cmd_idx : 0;
-		abo = amdxdna_gem_get_obj(client, cc->data[0], AMDXDNA_BO_SHARE);
+		err_idx = (cmd_idx < cc->command_count) ? cmd_idx : 0;
+		cc->error_index = err_idx;
+		abo = amdxdna_gem_get_obj(client, cc->data[err_idx], AMDXDNA_BO_SHARE);
 		if (!abo)
 			return -EINVAL;
 		cmd = amdxdna_gem_vmap(abo);
-- 
2.55.0

