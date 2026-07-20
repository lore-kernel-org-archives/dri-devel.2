Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A4CC44530
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 19:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C15F10E111;
	Mon, 20 Jul 2026 19:03:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="wRhRoWgX";
	dkim-atps=neutral
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net
 (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
 by gabe.freedesktop.org (Postfix) with ESMTP id 1EE0D88284
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 13:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-Id:MIME-Version:Content-Transfer-Encoding; bh=2DX0IGdpE5
 v2MDecZAGaKeD6g+xf+olxBRMjdHPEnYA=; b=wRhRoWgXLUf2cRITzDDeH4dESY
 CcVFYWflYmuQ6nC8ZJXhh5IaiejuFTGRLNplQFmYxlqJ7LRf7bsGQq9gKwmXCI6r
 cAASkNw4SLPIeg2TOb0rJM2oyGT1c3zpr3Tt8a8Jq7P9mzb/ELZP5qIvU+rM3eAk
 HnUB3s+Z2uPI5UDAc=
Received: from wmy.localdomain (unknown [115.53.184.36])
 by hzbj-edu-front-4.icoremail.net (Coremail) with SMTP id
 BrQMCkAGKxHXKF5qGFg9AQ--.7751S2; 
 Mon, 20 Jul 2026 21:55:38 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: simona@ffwll.ch,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH] fbdev: core: Clamp total_size to smem_len in fb_io_read/write
Date: Mon, 20 Jul 2026 21:55:34 +0800
Message-Id: <20260720135534.103599-1-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: BrQMCkAGKxHXKF5qGFg9AQ--.7751S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CryDCrW5JF4xKFyfZr1DWrg_yoW8Cw13pF
 48uF93Jry5JF1xGFn2k3W3Way5ta1kCr98K343X34ayrsxArsI934xJa4akFW8A398Xr1f
 JrykJryxuFyDCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9j14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
 1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
 W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
 0VAGYxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
 AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
 17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
 IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
 IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
 C2KfnxnUUI43ZEXa7VUjJ3vUUUUUU==
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUAEWpc6mud3wABsh
X-Mailman-Approved-At: Mon, 20 Jul 2026 19:03:49 +0000
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

Some legacy fbdev drivers may incorrectly set info->screen_size to a
value larger than the actual mapped framebuffer size (info->fix.smem_len)
during mode switches. This could allow out-of-bounds I/O accesses in
fb_io_read() and fb_io_write().

Prevent this by clamping total_size to smem_len when smem_len is non-zero.
Virtual framebuffers (smem_len == 0) are unaffected.

This is a hardening measure; no specific crash is fixed by this patch.

Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/video/fbdev/core/fb_io_fops.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/video/fbdev/core/fb_io_fops.c b/drivers/video/fbdev/core/fb_io_fops.c
index 6ab60fcd0050..335f16d2cc23 100644
--- a/drivers/video/fbdev/core/fb_io_fops.c
+++ b/drivers/video/fbdev/core/fb_io_fops.c
@@ -24,6 +24,14 @@ ssize_t fb_io_read(struct fb_info *info, char __user *buf, size_t count, loff_t
 	if (total_size == 0)
 		total_size = info->fix.smem_len;
 
+	/*
+	 * Security Hardening: Defend against buggy legacy drivers that may
+	 * calculate a malformed screen_size. Clamp total_size to the actual
+	 * hardware mapped memory limit (smem_len) to prevent OOB access.
+	 */
+	if (info->fix.smem_len && total_size > info->fix.smem_len)
+		total_size = info->fix.smem_len;
+
 	if (p >= total_size)
 		return 0;
 
@@ -88,6 +96,14 @@ ssize_t fb_io_write(struct fb_info *info, const char __user *buf, size_t count,
 	if (total_size == 0)
 		total_size = info->fix.smem_len;
 
+	/*
+	 * Security Hardening: Defend against buggy legacy drivers that may
+	 * calculate a malformed screen_size. Clamp total_size to the actual
+	 * hardware mapped memory limit (smem_len) to prevent OOB access.
+	 */
+	if (info->fix.smem_len && total_size > info->fix.smem_len)
+		total_size = info->fix.smem_len;
+
 	if (p > total_size)
 		return -EFBIG;
 
-- 
2.34.1

