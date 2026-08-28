Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE18CC624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E4F10E697;
	Mon, 31 Aug 2026 07:00:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V6QS1ABw";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2D3C10E656
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 22:16:46 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47fecbb7000so541792f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 15:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787955405; x=1788560205; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I+NVBt2+YV7TdDLoFYczsvx72Y9+mslXywiFQEZGZJM=;
 b=V6QS1ABwgdB15332deQccVaYXrdVb5G1vmtgNUsVinLNKPRZs+doxRFSun6ULANqlC
 vMVvJ80VFRBvGIO78RoT/ebnQD5Y+ACEjzJ2ilQ9fdkKm8t7D/82g0vp+0KfQrHeWnna
 gMGkgvTsMAU2pK0mcy2cKpaF4MDIZLm6iJI24+1LeoDsOnVLz2V1hOA5qwaD9b5YsBjS
 4GznEwMCdEP1FkqGZnvfY1nNF336WSz1Scqn9I0Pd5/pCGrhUxenLhlMvXgA29uAb3MI
 0pFDVXYjLCLNLGOVr5ZGRXN9k++ETG6+z/CJ5BxMcw1ZoySN90mx38JoFV+FmpYbt/C3
 jshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787955405; x=1788560205;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I+NVBt2+YV7TdDLoFYczsvx72Y9+mslXywiFQEZGZJM=;
 b=FiXmHTNF7GDWCGU7wYLU7vVDap9j5voX04CKggFK3JQ5VsgGPFdhaX7JLQOGRta0Ut
 teHI5PkrH1wcTv77uz5QfIeWSge5tw0LJ9SLtYal+E4LcAmlD8o60UdXvJSx49lePJVe
 kLH5YJiAHbI84o/cccgZem/sqk+CuY2ZlHy5sS1yLeeD8bKqTZz2C4xoESy/HgkspF07
 nRn0/mGUHYkuUMQN0E3xM0OFmMbO4udjAfmfXwGmQI/Mwg6HaQbnpB4rA+rtZkGnifUf
 wa5hH+fZOrmdyJGn23v2DX3cTZr1PCjQw7uPMpTd39Tc51c+PW7Vb2Sp1DiLrCw7nylm
 +2Xg==
X-Gm-Message-State: AFuF++kAn8x2dlna839dSjJY7T7pCN5bgPLmvUxiGNwJElsIwMNNVlsM
 Sk122vNwJCAYF0zLYuDz8DefX5Iqy2ZybsUXini6BJDKWE3pCJC/7rB8
X-Gm-Gg: AYBFou1FAOPFOInWD5c7T5wZos2dMIxmkXB3Se0ADvUAjyAo9EAC6JbqLAZ9vAK3YsF
 EvY5OePriZ9eUz44jDG4J7SzpU7GcNolv7wdUUNNTZfLJMSiKGxFPUYoEbSDAhzaHYSnFIkqKLt
 1y++V5qYP/bBg1e9XN2WzFZC6E++SgZdqtdQjqR/3PRjAFVKaZsz2WC+x2HZBH/hDcFQMYHzw2K
 ruSPQEiAtr0FlOyP/R/dMvmWbTpa3yi5psvrrIQfss+eVRj3xIdmb1ZGzHoeCqsv7HSBwzfC/tv
 C895CbD+4/P6YJX5ZNTQ4JUPffgSQiYnMozVH6/0K1amy/IIn1RuuE6AAf3JAELlLPf3p7GVlOf
 IwOVLjYZkbbimj9tPiYhCgQnG/0TJF48rRnIghDpO6Adul9/o/WSjCm3TUZVlzxhGxzd/bq2bSl
 mpARSREcM/a3mmzgHUe4YQG5cQUnMVCtHlR3l8lvrWVdPJPidtjC+p6KQOI0/aWgiAhxwHMHZQJ
 980SmztNxe8hQHET+0To9LvFJoSiDZx4457FIDY6IdJYsQqnvy9PC4BwaSoJOmqOx4cgJAo
X-Received: by 2002:a05:6000:4a1e:b0:482:e658:bb8e with SMTP id
 ffacd0b85a97d-482f79bf4f4mr17244716f8f.12.1787955405089; 
 Fri, 28 Aug 2026 15:16:45 -0700 (PDT)
Received: from drago.hgw.local ([2a00:1d34:ebf3:5500:6828:ce36:77ad:ae8c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab3f16sm6361576f8f.1.2026.08.28.15.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:16:44 -0700 (PDT)
From: Deniz Aydogan <denizaydogan1902@gmail.com>
To: lizhi.hou@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Deniz Aydogan <denizaydogan1902@gmail.com>
Subject: [PATCH] accel/amdxdna: fix race condition in mailbox send path
Date: Sat, 29 Aug 2026 01:16:41 +0300
Message-ID: <20260828221641.10034-1-denizaydogan1902@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
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

xdna_mailbox_send_msg() reads and writes x2i_tail without holding any
lock. This is problematic because the DRM scheduler thread can submit
jobs via aie2_execbuf() while the ioctl thread concurrently configures
the same hardware context via aie2_config_cu().

Both paths eventually call xdna_mailbox_send_msg() which does:

    tail = mb_chann->x2i_tail;
    ...
    mailbox_set_tailptr(mb_chann, tail + mb_msg->pkg_size);

Without synchronization, concurrent writers can read the same tail value,
overwrite each other's messages in the ring buffer, and write conflicting
tail pointers to hardware.

Fix this by protecting the tail pointer manipulation with a spinlock
that is held for the entire duration of mailbox_send_msg(). The lock
is initialized in xdna_mailbox_alloc_channel() and acquired/released
around the critical section in mailbox_send_msg().

Fixes: 3ba13f5e7180 ("Merge tag 'devicetree-fixes-for-7.3-1'")
Signed-off-by: Deniz Aydogan <denizaydogan1902@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_mailbox.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
index 271617347..337f89113 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox.c
+++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
@@ -60,6 +60,7 @@ struct mailbox_channel {
 	struct xarray			chan_xa;
 	u32				next_msgid;
 	u32				x2i_tail;
+	spinlock_t			lock;
 
 	/* Received msg related fields */
 	struct workqueue_struct		*work_q;
@@ -203,8 +204,10 @@ mailbox_send_msg(struct mailbox_channel *mb_chann, struct mailbox_msg *mb_msg)
 	u32 head, tail;
 	u32 start_addr;
 	u32 tmp_tail;
+	unsigned long flags;
 	int ret;
 
+	spin_lock_irqsave(&mb_chann->lock, flags);
 	head = mailbox_get_headptr(mb_chann, CHAN_RES_X2I);
 	tail = mb_chann->x2i_tail;
 	ringbuf_size = mailbox_get_ringbuf_size(mb_chann, CHAN_RES_X2I) - sizeof(u32);
@@ -225,8 +228,10 @@ mailbox_send_msg(struct mailbox_channel *mb_chann, struct mailbox_msg *mb_msg)
 		ret = read_poll_timeout(mailbox_get_headptr, head,
 					tmp_tail < head || tail >= head,
 					1, 100, false, mb_chann, CHAN_RES_X2I);
-		if (ret)
+		if (ret) {
+			spin_unlock_irqrestore(&mb_chann->lock, flags);
 			return ret;
+		}
 
 		if (tail >= head)
 			goto check_again;
@@ -240,6 +245,7 @@ mailbox_send_msg(struct mailbox_channel *mb_chann, struct mailbox_msg *mb_msg)
 			    mb_msg->pkg.header.opcode,
 			    mb_msg->pkg.header.id);
 
+	spin_unlock_irqrestore(&mb_chann->lock, flags);
 	return 0;
 }
 
@@ -487,6 +493,7 @@ struct mailbox_channel *xdna_mailbox_alloc_channel(struct mailbox *mb)
 		goto free_chann;
 	}
 	mb_chann->mb = mb;
+	spin_lock_init(&mb_chann->lock);
 
 	return mb_chann;
 
-- 
2.55.0

