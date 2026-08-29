Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9032C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3884910E68A;
	Mon, 31 Aug 2026 07:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fsr7UE9O";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB2D410E0C7
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 07:53:08 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so13748985e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 00:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787989987; x=1788594787; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+jbQ6QwM5+BlZ7cOazrDoJ7hDb3esvgCSdcu8xIlmJE=;
 b=Fsr7UE9OtYUa/89XmYk97KMYit3PQtnKZa9GI2tiw3of/QJL410qn6qfQ5uqPmmlEb
 ZU0amsM0vFzaFM62xzw1d0+7dSD+g0z1J2hewBQMgDSa+ZUq5IQR9LPtsrCkY6NNQpdN
 j/bp2NHzgXwUduD8ZCV3b6wL/ahq3UtBgGv92PhtlkNH2iQ4WWI8Ol7/++N6UEnRhBFt
 1mjli0GMNUg4qvqwsf2/YWBBSry/fP6FzD7lFFUI51iVcSvNkzDNU4iszAGB/WwbWBSI
 Jj4DeIDiclEEcVof6A6f4qtYlQECZD5vj36GDrXW6TaN3JfJwvHgg1g1yMLnO0anJeSV
 Khog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787989987; x=1788594787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+jbQ6QwM5+BlZ7cOazrDoJ7hDb3esvgCSdcu8xIlmJE=;
 b=hgFIvh45e2lifSZ/uSk+Xpk7GQPsMtD5QOT7Ylu3xlKUG2BQtnPUbj/Ozs25Ktg0Zq
 6Xk5N9e6if1nr8GMkzvplGKlKR1CrGKWEK4hq3kTt/mJdR9FCcITGYrP0bz/BCdym2l+
 LlnT7M2xxHqeRL4QQXLrUpzTcyeCy38SQKMXysMlCtIjhbJdZD51zHzOcUcJQ3g68ccy
 q/vAJa/wR88pHS4eQ9ZfSyPzovxwNVBC3oaZWFy9h3J1i/A2T4RW5kY3pST6MaAbpqQY
 B7uod7u1a4Lfza/bPJnPpwtK3AeXctsGy1v+nHsIFbRSTEDYf/Yj8xbqg/92LC0hfqo7
 RzPw==
X-Gm-Message-State: AFuF++neM3mUUjw5rSmxPVDSadmykwtHci8+CdkVbqxGwoIma/O7cHfB
 avGA2UhBcXvwqyjPYO5MkTys+LHuO4SMwb3e/3gZb9clANekkEdCDeSr
X-Gm-Gg: AR+sD108Mc0ZQQfT4QphbvpCl7QA9SDr6FRrW7Q91rVcrJJhGUW6eSlJnfCz8o6mFJs
 2ZIMgo7fm6g3ug+DZzU0O3/fsK+1MPWTmqZZlkEWoIgSMF4BWf7nKR+A0j2W7mEvXqZHrCG2SEQ
 6doNuLloWFmG+/ZPGiknajgo6ZcCwFT+rZ9TfRFwL3+4gBLGR9Xzq6kRYZppbHueubCrx39su+t
 DupxgvTfZoExrXfBjDG6XeLxYyJzyj7L3e0+SbYAWRmP/k8+u+fQhtYG4AzYMXt8PJWjHD3ot7O
 fX0/s1jA6rHmS8yk73fnfkEG4Nq67PMb/IyeBJRTCoV9EVDLd4he6z2AO4E7S2REdN5NvunhBwE
 +wPVDEeMoXT7SDhNzvyAfDzS/YIpKZ+qtaxcJN25H8MUpUOEnbp8oFHufb0LDVEeCib36xmFDma
 WM9PY5O9xkBbvDBv1UM7NwgmfqSTrJFVdHlTyQI1ALOURLYILesIiEb0+o/lRhOQR7KThxjM81i
 C26lBj4fGbL+CWzm5dXQyHNJxXvbkpX0o1v/sj2BlexjkJVc9mACFyANrnzkw==
X-Received: by 2002:a05:600c:1c0a:b0:493:bd2a:93be with SMTP id
 5b1f17b1804b1-49b91c276efmr191294575e9.6.1787989986916; 
 Sat, 29 Aug 2026 00:53:06 -0700 (PDT)
Received: from drago.hgw.local ([2a00:1d34:e90c:f900:e29d:3a79:ac40:9edd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb2794dsm9017193f8f.25.2026.08.29.00.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 00:53:06 -0700 (PDT)
From: Deniz Aydogan <denizaydogan1902@gmail.com>
To: lizhi.hou@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Deniz Aydogan <denizaydogan1902@gmail.com>
Subject: [PATCH v2] accel/amdxdna: fix race condition in mailbox send path
Date: Sat, 29 Aug 2026 10:53:03 +0300
Message-ID: <20260829075303.7457-1-denizaydogan1902@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828221641.10034-1-denizaydogan1902@gmail.com>
References: <20260828221641.10034-1-denizaydogan1902@gmail.com>
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

mailbox_send_msg() reads and updates x2i_tail without any
synchronization. The DRM scheduler and ioctl paths can call
xdna_mailbox_send_msg() concurrently on the same channel, which
allows two threads to read the same tail value and corrupt the
hardware ring buffer.

Add a mutex to serialize the entire send path. A mutex is used
rather than a spinlock because the existing code calls
read_poll_timeout() with a non-zero sleep, which can reschedule.

Fixes: 3ba13f5e7180 ("Merge tag 'devicetree-fixes-for-7.3-1'")
Signed-off-by: Deniz Aydogan <denizaydogan1902@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_mailbox.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
index 271617347..8338f03bd 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox.c
+++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/xarray.h>
 
@@ -60,6 +61,7 @@ struct mailbox_channel {
 	struct xarray			chan_xa;
 	u32				next_msgid;
 	u32				x2i_tail;
+	struct mutex			lock;
 
 	/* Received msg related fields */
 	struct workqueue_struct		*work_q;
@@ -205,6 +207,7 @@ mailbox_send_msg(struct mailbox_channel *mb_chann, struct mailbox_msg *mb_msg)
 	u32 tmp_tail;
 	int ret;
 
+	mutex_lock(&mb_chann->lock);
 	head = mailbox_get_headptr(mb_chann, CHAN_RES_X2I);
 	tail = mb_chann->x2i_tail;
 	ringbuf_size = mailbox_get_ringbuf_size(mb_chann, CHAN_RES_X2I) - sizeof(u32);
@@ -225,8 +228,10 @@ mailbox_send_msg(struct mailbox_channel *mb_chann, struct mailbox_msg *mb_msg)
 		ret = read_poll_timeout(mailbox_get_headptr, head,
 					tmp_tail < head || tail >= head,
 					1, 100, false, mb_chann, CHAN_RES_X2I);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&mb_chann->lock);
 			return ret;
+		}
 
 		if (tail >= head)
 			goto check_again;
@@ -240,6 +245,7 @@ mailbox_send_msg(struct mailbox_channel *mb_chann, struct mailbox_msg *mb_msg)
 			    mb_msg->pkg.header.opcode,
 			    mb_msg->pkg.header.id);
 
+	mutex_unlock(&mb_chann->lock);
 	return 0;
 }
 
@@ -487,6 +493,7 @@ struct mailbox_channel *xdna_mailbox_alloc_channel(struct mailbox *mb)
 		goto free_chann;
 	}
 	mb_chann->mb = mb;
+	mutex_init(&mb_chann->lock);
 
 	return mb_chann;
 
-- 
2.55.0

