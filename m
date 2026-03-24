Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65718D58CCA
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:12:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D922110E63E;
	Tue, 24 Mar 2026 09:12:23 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4FC210E27B
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 01:45:03 +0000 (UTC)
Received: from localhost.localdomain (unknown [111.196.245.197])
 by APP-05 (Coremail) with SMTP id zQCowAA3zRCb7MFpzq5JCw--.35583S2;
 Tue, 24 Mar 2026 09:44:59 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: [PATCH] misc: fastrpc: keep copied arguments inside the invoke buffer
Date: Tue, 24 Mar 2026 09:44:59 +0800
Message-ID: <20260324014459.93364-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAA3zRCb7MFpzq5JCw--.35583S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw18Ar4xWFy3CFW5WrW3ZFb_yoW8uw13pF
 45Ka1ruF45Xw47GF1vyFnrWryfJws3J34UGrZ3G34S9w1aqFy0gFyqkFyj9a40krZ2vry0
 krs8taya9a17JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
 0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
 JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
 AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
 rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
 v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
 JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUecTmDU
 UUU
X-Originating-IP: [111.196.245.197]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Mailman-Approved-At: Tue, 24 Mar 2026 09:12:22 +0000
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

fastrpc_get_args() derives rpra[i].buf.pv from the overlap offset that
was computed from user-controlled argument pointers and lengths. The
resulting destination pointer is then used for copy_from_user() without
first checking that it still falls inside the allocated invoke buffer.

Validate the overlap-derived destination range before storing it in
rpra[i].buf.pv and before copying inline arguments into the invoke
buffer.
---
 drivers/misc/fastrpc.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 47356a5d5804..d7f53300b899 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -993,6 +993,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	u64 len, rlen, pkt_size;
 	u64 pg_start, pg_end;
 	uintptr_t args;
+	uintptr_t buf_start, buf_end;
 	int metalen;
 
 	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
@@ -1016,6 +1017,8 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	rpra = ctx->buf->virt;
 	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
 	pages = fastrpc_phy_page_start(list, ctx->nscalars);
+	buf_start = (uintptr_t)ctx->buf->virt;
+	buf_end = buf_start + pkt_size;
 	args = (uintptr_t)ctx->buf->virt + metalen;
 	rlen = pkt_size - metalen;
 	ctx->rpra = rpra;
@@ -1053,6 +1056,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 			pages[i].size = (pg_end - pg_start + 1) * PAGE_SIZE;
 
 		} else {
+			uintptr_t dst;
 
 			if (ctx->olaps[oix].offset == 0) {
 				rlen -= ALIGN(args, FASTRPC_ALIGN) - args;
@@ -1064,7 +1068,18 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 			if (rlen < mlen)
 				goto bail;
 
-			rpra[i].buf.pv = args - ctx->olaps[oix].offset;
+			if (ctx->olaps[oix].offset > args - buf_start) {
+				err = -EINVAL;
+				goto bail;
+			}
+
+			dst = args - ctx->olaps[oix].offset;
+			if (len > buf_end - dst) {
+				err = -EINVAL;
+				goto bail;
+			}
+			rpra[i].buf.pv = dst;
+
 			pages[i].addr = ctx->buf->dma_addr -
 					ctx->olaps[oix].offset +
 					(pkt_size - rlen);
-- 
2.50.1 (Apple Git-155)

