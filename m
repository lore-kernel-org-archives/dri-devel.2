Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925BD606A333
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD51D10E59E;
	Mon,  2 Nov 2026 09:29:40 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net
 (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
 by gabe.freedesktop.org (Postfix) with ESMTP id E8EDD10EC5F
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 09:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-Id:MIME-Version:Content-Transfer-Encoding; bh=SokQ9ZXvf9
 1S67MDPneJhsSwDRmkfnKSHkpvgNhOdcw=; b=eED5RygvPVs/gqNk5Yargo6uhR
 B5hkv1K7DKIltHnjvdewGWtI8SgxQyUJmLxMEYaiq57853ymvS3yBhV9kZMa2/jm
 R4NScoLp8jTg4CQ+8f0AipPGM/SUlRfuIMCZSB424UoGG8/VujRpa1K7A34HzcMl
 AWD6tpajwTRkKNVsw=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.55])
 by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id
 BrQMCkAWNvz2V+hqNicZAQ--.18472S2; 
 Mon, 02 Nov 2026 17:29:27 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Helge Deller <deller@gmx.de>,
 Steve Glendinning <steve.glendinning@shawell.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] fbdev: smscufx: allocate the size advertised in smem_len
Date: Mon,  2 Nov 2026 17:29:25 +0800
Message-Id: <20261102092925.18027-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: BrQMCkAWNvz2V+hqNicZAQ--.18472S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr45WryrCF1ktr4DJFWrZrb_yoW8AryxpF
 4Yka4qyrs8tr4UZwnrK3WFkFyFvan3uryjkrW3t34F9F15Zry5uFy8CryIgr98AFWxXFnF
 qw45ta47uFyUu3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
 0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
 Ij6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
 c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026x
 CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
 JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
 1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
 Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
 UvcSsGvfC2KfnxnUUI43ZEXa7IU5R6zUUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUFD2rnWEKRUAAAsb
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
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ufx_realloc_framebuffer() allocates line_length * yres bytes but records
PAGE_ALIGN(line_length * yres) in info->fix.smem_len.  ufx_ops_set_par()
clears the framebuffer by writing smem_len bytes, so the write runs past
the end of the vmalloc() allocation whenever the mode size is not page
aligned:

  BUG: KASAN: vmalloc-out-of-bounds in ufx_ops_set_par
  Write of size 2 at addr ffffc90005518600
  Call Trace:
   ufx_ops_set_par
   ufx_usb_probe
   usb_probe_interface

This runs from the probe path, before any client can open the device: with
the fallback mode of 800x600 at 16 bpp the framebuffer is 960000 bytes and
PAGE_ALIGN() adds 2560 bytes that were never allocated.

Allocate the page aligned size that is published in smem_len instead, so
the buffer covers every byte the driver and the framebuffer core can reach
through smem_start and smem_len.

Fixes: 3c8a63e22a08 ("Add support for SMSC UFX6000/7000 USB display adapters")
Cc: stable@vger.kernel.org
---
 drivers/video/fbdev/smscufx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index 5704f60e1741..d5b9802ea94f 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -1277,9 +1277,10 @@ static int ufx_realloc_framebuffer(struct ufx_data *dev, struct fb_info *info)
 
 	if (PAGE_ALIGN(new_len) > old_len) {
 		/*
-		 * Alloc system memory for virtual framebuffer
+		 * Alloc system memory for virtual framebuffer.  smem_len is
+		 * rounded up to a page, so allocate that much as well.
 		 */
-		new_fb = vmalloc(new_len);
+		new_fb = vmalloc(PAGE_ALIGN(new_len));
 		if (!new_fb)
 			return -ENOMEM;
 
-- 
2.34.1

