Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D1CC5B572
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 00:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E9F810E0FA;
	Tue, 18 Aug 2026 00:00:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="yePPjarF";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-130.mta1.migadu.com [95.215.58.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A34D110E0FA
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 00:00:26 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=9YTviN0pQkyHB9pt4A8hcNvUD8A4QhCACtCOAH1E4VE=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787011224; v=1; x=1787616024;
 b=yePPjarFfrDmbI0eYq4KVcCLD1K69SN9LpMYybTg/Y+PCwcd/bKWuaaVBl5yCJ15Uy9RK68l
 v8tP/7t8moj0gGTdcwbcjjvIAhya6PNr50XnnWNhlgpogtZAfgmH5BLt7mFFQ9Bx4Cy2UVr5vmq
 vVAeUb736Z3wDNi8z2wYFiRIRIpA4733ZpQP/O8oYmB45aPgaOMooKRF58aymaWaT7DFpKbOrep
 ahIjx192MaqAf7pr5lVzQ3Qt5ourEEAv5NDxLnEsja3eH91J91rr1uqAZMOY7lHWTpsWQr/od5q
 LG5Sf/MMX+eDkkmItk5LVZ/MWYXGZpMpQ2hakMADQwkUw==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.111.69)
 by smtp.migadu.com with ESMTPS id 4045d3407932a546;
 Tue, 18 Aug 2026 00:00:24 +0000
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: lizhi.hou@amd.com,
	mamin506@gmail.com,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Subject: [PATCH] accel/amdxdna: reject a command chain that carries no commands
Date: Tue, 18 Aug 2026 03:00:19 +0300
Message-ID: <20260818000019.369366-1-taimuraz@kaitmazov.com>
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

A chain whose command_count is zero passes the payload length check,
because struct_size(payload, data, 0) is just the header. The fill loop
then does not run, so offset stays zero and the request is submitted with
a zero-length buffer.

On firmware without AIE2_NPU_COMMAND that ends at the opcode check, since
op is still ERT_INVALID_CMD and aie2_get_chain_msg_op() answers
MSG_OP_MAX_OPCODE. aie2_get_npu_chain_msg_op() answers
MSG_OP_CHAIN_EXEC_NPU whatever it is given, so there the submission
continues to drm_clflush_virt_range(cmd_buf, 0), which reads the byte
before the buffer and faults on the vmap guard page. EXEC_CMD is
reachable by any process that can open the render node.

Reject the request instead.

Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
drm_clflush_virt_range() faulting on an empty range is a core problem, and a
patch for it is on the list separately. This rejects the request in the driver
regardless, since a chain carrying no commands is not something to submit.

 drivers/accel/amdxdna/aie2_message.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index dfe0fbdf066d..b4c49259a1a2 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -994,7 +994,7 @@ int aie2_cmdlist_multi_execbuf(struct amdxdna_hwctx *hwctx,
 	}
 
 	ccnt = payload->command_count;
-	if (payload_len < struct_size(payload, data, ccnt)) {
+	if (!ccnt || payload_len < struct_size(payload, data, ccnt)) {
 		XDNA_DBG(xdna, "Invalid command count %d", ccnt);
 		return -EINVAL;
 	}
-- 
2.55.0

