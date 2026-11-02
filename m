Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB54606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E82C10EC3C;
	Mon,  2 Nov 2026 08:48:48 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net
 (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
 by gabe.freedesktop.org (Postfix) with ESMTP id 2764C10EC4F
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 08:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-Id:MIME-Version:Content-Transfer-Encoding; bh=IIx5Id2p6U
 omVqlMJQwLEL9OVFN79ieEtDwmL+E+5vU=; b=KgD+QsZscNImx7W3n75tF1czX/
 xJhP1n8O1H9J24c9FSUVuUgKVbe/xAph5NLNdDqebMCkzmbJ7DTT1HO+3EWFNQPX
 tz80HEdVmXQmC6Ki2YibeE9W/25BMEFzoHZ8wDWUKO3vRtav7nSh0UitIAldoxGn
 lPzOi4TjSRHVguCkE=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.55])
 by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id
 BLQMCkBGjwReTuhqAMkYAQ--.27848S2; 
 Mon, 02 Nov 2026 16:48:31 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Helge Deller <deller@gmx.de>,
 Steve Glendinning <steve.glendinning@shawell.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] fbdev: smscufx: don't free registered framebuffer on probe
 error
Date: Mon,  2 Nov 2026 16:48:30 +0800
Message-Id: <20261102084830.9890-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: BLQMCkBGjwReTuhqAMkYAQ--.27848S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF17Xw4rKF45uFyUJFW7XFb_yoW5Xryfpa
 n5Kas0qr15trWfXr47C3W0vFyrtF1xZryFkFW7t343C3W3Cry5XryxKFyjgayDJFn7JF1j
 gF1Yg3y8uFWDWFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
 0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15Mc
 Ij6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
 c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026x
 CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
 JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
 1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
 Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
 UvcSsGvfC2KfnxnUUI43ZEXa7IU5CiiPUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUFD2rnVdSL8QAAs4
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

register_framebuffer() can return an error after the framebuffer has
already been installed: do_register_framebuffer() bumps info->count,
creates /dev/fbN and stores the fb_info in registered_fb[] before it
returns the result of the console takeover, and that takeover may fail.
ufx_usb_probe() treats any error as "nothing was registered" and unwinds
through reset_active, which releases the fb_info and drops both
references to struct ufx_data, freeing @dev.

The framebuffer stays registered and can still be opened, so the next
open() of /dev/fbN reaches ufx_ops_open() with info->par pointing at
freed memory:

  refcount_t: addition on 0; use-after-free.
  WARNING: lib/refcount.c:25 at refcount_warn_saturate
  Call Trace:
   kref_get
   ufx_ops_open    drivers/video/fbdev/smscufx.c:1033
   fb_open         drivers/video/fbdev/core/fb_chrdev.c:351
   chrdev_open
   ...
  refcount_t: underflow; use-after-free.
  WARNING: lib/refcount.c:28 at refcount_warn_saturate
  Call Trace:
   ufx_ops_release drivers/video/fbdev/smscufx.c:1135
   fb_release       drivers/video/fbdev/core/fb_chrdev.c:378
   __fput

Reuse the "has this fb_info been registered" test that ufx_setup_modes()
already uses: take the error path only when refcount_read(&info->count)
says the core did not register the framebuffer.  A failed console
takeover is not fatal for the driver, so report it and keep the
framebuffer registered; the disconnect callback will unregister it
normally.

Fixes: 3c8a63e22a08 ("Add support for SMSC UFX6000/7000 USB display adapters")
Cc: stable@vger.kernel.org
---
 drivers/video/fbdev/smscufx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index 5704f60e1741..2aa001d58aaa 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -1697,8 +1697,16 @@ static int ufx_usb_probe(struct usb_interface *interface,
 	dev_dbg(dev->gdev, "registering framebuffer");
 	retval = register_framebuffer(info);
 	if (retval < 0) {
-		dev_err(dev->gdev, "error %d register_framebuffer", retval);
-		goto reset_active;
+		/*
+		 * info is installed before the takeover can fail; freeing @dev
+		 * here would leave registered_fb[] and /dev/fbN pointing at
+		 * freed memory.
+		 */
+		if (!refcount_read(&info->count)) { /* not registered */
+			dev_err(dev->gdev, "error %d register_framebuffer", retval);
+			goto reset_active;
+		}
+		dev_warn(dev->gdev, "console takeover failed: %d\n", retval);
 	}
 
 	dev_info(dev->gdev, "SMSC UDX USB device /dev/fb%d attached. %dx%d resolution."
-- 
2.34.1

