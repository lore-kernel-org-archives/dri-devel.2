Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBEF606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 07:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CC0E10EB74;
	Mon,  2 Nov 2026 07:21:36 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net
 (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
 by gabe.freedesktop.org (Postfix) with ESMTP id A793A10EB78
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 07:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-Id:MIME-Version:Content-Transfer-Encoding; bh=vOm77Ol81N
 HVwbT3TF1koHcO7lNXXEKWGGU10cmiIbo=; b=JE1+CGZHHOyym2NaxWLNlgKGQg
 hM+RYo1MydRPNh0H0pdPEjlOml67/UxP6wDdhRANX5WDQhffI47kxMsK1WAfxsb5
 zVT047KomgfvX3UIaTreW+nr3dsLkwUKx32L8edfjvdsuLJhjz4MPIWWk0zJgP3z
 gCfIjW+3HhJF/JeJY=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.55])
 by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id
 BrQMCkDG5PrwOehqKrgYAQ--.18497S2; 
 Mon, 02 Nov 2026 15:21:21 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Helge Deller <deller@gmx.de>,
 Steve Glendinning <steve.glendinning@shawell.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] fbdev: smscufx: bail out of ufx_set_vid_mode() when the
 device is gone
Date: Mon,  2 Nov 2026 15:21:20 +0800
Message-Id: <20261102072120.3022-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: BrQMCkDG5PrwOehqKrgYAQ--.18497S2
X-Coremail-Antispam: 1UD129KBjvJXoWxArW8Wr4kAw48uFW8AFWkJFb_yoW5Wr13pF
 W5CFW5KrZ5JFWjka1DGw429a4Yv3ZxAay7Gr9rKw13uFn8u3yfurykCF9FgF98Jry7Zw4U
 Ja4Ut3yj9ayUuaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
 8E87Iv6xkF7I0E14v26F4UJVW0owAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
 82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGw
 Av7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
 MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxV
 CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
 6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
 WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG
 6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_Gr
 UvcSsGvfC2KfnxnUUI43ZEXa7IU8HrW5UUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUFD2rnWEJ54wAAsA
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ufx_usb_disconnect() marks the device as virtualized and clears
usb_active, but the fbdev entry points that program the controller are
not serialized against it.  ufx_handle_damage(), ufx_dpy_deferred_io()
and ufx_ops_ioctl() all return early while usb_active is clear;
ufx_set_vid_mode() does not, so a mode set or a blank request that
races with the disconnect keeps issuing control transfers through
dev->udev.

The usb_device is released once the disconnect callback returns, while
dev->udev is left pointing at it, so those transfers dereference a
stale pointer and fault in __create_pipe():

  general protection fault, probably for non-canonical address
  0xdffffc0000000006: 0000 [#1] SMP
  KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
  RIP: 0010:__create_pipe include/linux/usb.h:2031
  Call Trace:
   ufx_set_vid_mode
   ufx_ops_set_par
   fb_set_var
   fb_set_var_from_user
   store_rotate

Return -ENODEV from ufx_set_vid_mode() when the device is no longer
active, matching the check the other transmit paths already use.  Both
callers, ufx_ops_set_par() and ufx_ops_blank(), handle the error: the
former skips the greenscreen fill and keeps the previous mode, the
latter already ignores the result.

The guard cannot live in ufx_reg_write()/ufx_reg_read() instead, since
probe programs the controller through ufx_config_ddr2(),
ufx_i2c_init(), ufx_setup_modes() and ufx_reg_set_bits() before it sets
usb_active.

Fixes: 3c8a63e22a08 ("Add support for SMSC UFX6000/7000 USB display adapters")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/video/fbdev/smscufx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index 5704f60e1741..f1b640a5d712 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -661,8 +661,12 @@ static int ufx_set_vid_mode(struct ufx_data *dev, struct fb_var_screeninfo *var)
 	u32 temp;
 	u16 h_total, h_active, h_blank_start, h_blank_end, h_sync_start, h_sync_end;
 	u16 v_total, v_active, v_blank_start, v_blank_end, v_sync_start, v_sync_end;
+	int status;
+
+	if (!atomic_read(&dev->usb_active))
+		return -ENODEV;
 
-	int status = ufx_reg_write(dev, 0x8028, 0);
+	status = ufx_reg_write(dev, 0x8028, 0);
 	check_warn_return(status, "ufx_set_vid_mode error disabling RGB pad");
 
 	status = ufx_reg_write(dev, 0x8024, 0);
-- 
2.34.1

