Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2336A606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21CD910E7EA;
	Thu, 29 Oct 2026 10:51:58 +0000 (UTC)
X-Greylist: delayed 2103 seconds by postgrey-1.36 at gabe;
 Thu, 29 Oct 2026 08:08:31 UTC
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net
 (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
 by gabe.freedesktop.org (Postfix) with ESMTP id 524E2112066
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Subject:Date:
 Message-Id:MIME-Version:Content-Transfer-Encoding; bh=n2h7Gd+pWS
 ukG0+ZHwnfidKQ4JBvdEMorny+52dhSJ4=; b=geLuo30iOzYGcjqqJ7EaPdySRp
 F2w5iYLW2zSGwl2a2dVDTOs+Wh6JMhYSavm2FUU14OJbWy2MpETrr97tB1FUBHsq
 xHxrx3wsKPOgsnMzQ8NRM+tpbBZQCaWqxYbA0r6A2LVOf9/VFL9p6BcY9ww2UZFW
 xTcdLL36oR24JdH8w=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.47])
 by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id
 BbQMCkAGC_7w_uJq9uv7AA--.61434S2; 
 Thu, 29 Oct 2026 16:08:17 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/gud: avoid divide error in gud_stats_debugfs
Date: Thu, 29 Oct 2026 16:08:16 +0800
Message-Id: <20261029080816.16800-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: BbQMCkAGC_7w_uJq9uv7AA--.61434S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw43KryDXF43ZF4fKr1fXrb_yoW8Zr4Upw
 43Ga4FyFW7X347Gw43AayIgFy5Za4kJFW8GrW8K34fuF45ZF1rua4YgFy0q34UJr1Iya9a
 qF1qgrZrCrW2yFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
 07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
 18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
 r41lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s
 026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
 JrI_JrWlx4CE17CEb7AF67AKxVWUJVWUXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
 v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
 j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
 W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0zwZ5UUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUBD2riEkGHTgAAsb
X-Mailman-Approved-At: Thu, 29 Oct 2026 10:51:56 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

gud_stats_debugfs() computes the compression ratio by dividing the
accumulated uncompressed length by stats_actual_length. That counter is
zero until the first framebuffer flush has completed, so reading the
stats debugfs file on a display which negotiates LZ4 compression raises
a divide error before any frame has been sent. The wrap-around reset in
gud_flush_rect() also clears the counter for a moment, which a
concurrent read can observe.

Copy the counter into a local variable and skip the ratio computation
when it is zero.

Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/gpu/drm/gud/gud_drv.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index 3a1b9e2a2eaa..85ddb302d2ba 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -329,10 +329,17 @@ static int gud_stats_debugfs(struct seq_file *m, void *data)
 	seq_puts(m, "\n");
 
 	if (gdrm->compression) {
+		u64 actual_length = gdrm->stats_actual_length;
 		u64 remainder;
-		u64 ratio = div64_u64_rem(gdrm->stats_length, gdrm->stats_actual_length,
-					  &remainder);
-		u64 ratio_frac = div64_u64(remainder * 10, gdrm->stats_actual_length);
+		u64 ratio, ratio_frac;
+
+		if (!actual_length) {
+			seq_puts(m, "Compression ratio: n/a\n");
+			return 0;
+		}
+
+		ratio = div64_u64_rem(gdrm->stats_length, actual_length, &remainder);
+		ratio_frac = div64_u64(remainder * 10, actual_length);
 
 		seq_printf(m, "Compression ratio: %llu.%llu\n", ratio, ratio_frac);
 	}
-- 
2.34.1

