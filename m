Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321DFCD5BC7
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 06:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC3810E3F8;
	Mon, 25 May 2026 06:20:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TnizGh9q";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0620E10E303
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 14:27:19 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-c736261ee8dso3860081a12.1
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 07:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779546438; x=1780151238; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mzFTxVPO2bV5wPss4Z0njUQ82fwBRkchQ0evEohJCFc=;
 b=TnizGh9qSUupuiq/OrfRcThb61tLXPUKJl47v9sWOajpEmNKq8in3Wy3ZKPFQN2uFB
 BRLY79+5jFGZk76WUH64oGL7rm2S8Ay1JKcCW2ArEMFwjPgzpeuJASGN3gk2syvU5E05
 5YW33p61NA55xQGzfrZWBTZOoelRFZoZwXBQy2NH4QJJPGek2MHJp7fXaMXwyiA1DlQ4
 MYaFb6Y+R90mQnA8YjDc5F9AsKxRWkdht+ZYm+g+71bQTc+7x2VeBXNNAtn6km5S4Yv2
 B+GVC1wGZ52C3n+IAnokyPni97Cexn0Tf89bKauto8gD9Va7XPlqiGoguQi786BzpMif
 H4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779546438; x=1780151238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mzFTxVPO2bV5wPss4Z0njUQ82fwBRkchQ0evEohJCFc=;
 b=bmVJGFd4QzX4nvFjMV05GMImBKB5aeFPhkdcByCyFdYV3QvRlCDKuS9iJpWDbTpfYM
 6pQFEfjso9ySHtUULWb2WTH7nGJDgrhRc/2Xm+98gJP+L9c6rWNdTK+1Uztj9ROHl2C/
 RWXFJppq3+Lqeu3AmMrkjOj0kD3Y2Xlw50uiGfMHCdIT2yBp9gVn5cirxDbzWHKqsMfq
 MPUSc34/MBT9ec0jTJKuM7nsQr2oTtVA+zEsbPVeAdXyJ3UzKm5gUZqqWcKs7X/mKe6h
 1u+NQees4e5kdMW3nLBoDRY2ZF88U6BUwxFuKDRQpJiMWXP+qHkzfmZWIepojZm0tCWQ
 fzuA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8YYkqY0cJ8Wfzh2uiwt7D76vRji1a2p5J6vlpr8jaL8gOHcVZ2NfWpcYF78VZVULQUiar0DDMnLbo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJt3zEjYuz0tNDDLnBBBa1kBvRGkW4BhRXlt8XPXR0uAJ/Oww0
 Tn/2M+Z1UXJpXhuV8mt8qCXT/hWIzAEGatK875SNaq4+TEAcRhnvO6bTSfTCRM6fubBdKJA6
X-Gm-Gg: Acq92OHl+ejIwkUznj3epexvfM+f1b8k3x664v8GN5RX4ENPo9Wezqb2iqn3+JbF7bd
 0yEktkQnbpuaIUYF0UcKaSk5kWQH0OzYDJJH7uHvfMaBitjyLCt0aDwg49Q7aY9q+bQgZIUZvCZ
 kPULERyfmA3xJOLPQswtkcVYCXyZ72C5agYIqPN4PQyX1qWuAWfZEX/L36ymormSgXk0tFWv+Lk
 IyTVKNXKmzBgf5ATwj/DjlHQZ5owMTXBIKSOmLhTJSZfCmm0LTqaZKyvikMqj7h0SEu0rdfP5R/
 CmRyW7aKPAVYn4KhfG7+LanyWsiNIkZ5sfqkJ4hJ3F8gJdS/TV9eaao8X0jYQdLCrVCjXaYu5Ti
 D3dVXAda3GUAvKlTKjORKm4MJMptNHp6SVKUj2i4xuTymXpLxmvuKmTG9BVlC/hcaZfm5ERXaWF
 7rwNBmXqYPH5iyaL1mOe1t5TQGccFWIi/L9Adr0sneMEBiGrMzcNfB8WSDVLsWcM4y6QYqyaE2p
 3h5eTu33xK5xd4RszUA35OzoKtrADEbuPrT7lLgvRmjggKqGeGioDGR/wghPN8Nyk5FZHiMf3F8
 x3nz9lxzzFe+krBELUQ5ZPwooQ==
X-Received: by 2002:a05:6a21:32a0:b0:3b3:216b:274c with SMTP id
 adf61e73a8af0-3b328cc44f3mr8711006637.22.1779546438447; 
 Sat, 23 May 2026 07:27:18 -0700 (PDT)
Received: from
 codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net
 ([4.240.39.192]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164afe2dasm4875597b3a.19.2026.05.23.07.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 07:27:18 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Felix.Kuehling@amd.com
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] drm/amdkfd: fix integer overflow in get_queue_ids()
Date: Sat, 23 May 2026 14:26:45 +0000
Message-ID: <20260523142645.39102-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 May 2026 06:20:29 +0000
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

get_queue_ids() computes the allocation size as:

    size_t array_size = num_queues * sizeof(uint32_t);

num_queues is a user-controlled u32 copied directly from the ioctl
argument (args.suspend_queues.num_queues or args.resume_queues.num_queues)
via kfd_ioctl_set_debug_trap() with no prior validation or clamping.

On 32-bit kernels, size_t is 32 bits wide.  A caller supplying
num_queues = 0x40000001 causes the multiplication to silently wrap:

    0x40000001 * 4 = 0x100000004  ->  truncated to 0x4

memdup_user() then allocates only 4 bytes.  q_array_invalidate() is
called immediately after with the original num_queues value and
iterates 0x40000001 times writing KFD_DBG_QUEUE_INVALID_MASK into the
4-byte buffer, producing an unbounded heap buffer overflow.
q_array_get_index() in both callers walks the same buffer using the
same unchecked count.

Both call sites are affected:
- suspend_queues() calls get_queue_ids() unconditionally
- resume_queues() calls it only when usr_queue_id_array is non-NULL

Both callers already propagate IS_ERR() returns to userspace, so
returning ERR_PTR(-EINVAL) on overflow requires no new error handling.

The copy_to_user() calls at the tail of both functions also compute
num_queues * sizeof(uint32_t), but are only reachable after a
successful get_queue_ids() return, so they are safe once the
allocation is correctly bounded.

Fix by replacing the unchecked multiplication with check_mul_overflow().
Cast num_queues to size_t so all three arguments match the destination
type, avoiding implicit type mismatch on compilers that implement the
macro with typeof() rather than __builtin_mul_overflow() directly.
Add an explicit #include <linux/overflow.h> rather than relying on the
transitive pull through linux/slab.h.

Fixes: a70a93fa568b ("drm/amdkfd: add debug suspend and resume process queues operation")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e0a31e11f0ff..c08ad718dbd7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -25,6 +25,7 @@
 #include <linux/ratelimit.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
+#include <linux/overflow.h>
 #include <linux/list.h>
 #include <linux/types.h>
 #include <linux/bitops.h>
@@ -3308,11 +3309,14 @@ static void copy_context_work_handler(struct work_struct *work)
 
 static uint32_t *get_queue_ids(uint32_t num_queues, uint32_t *usr_queue_id_array)
 {
-	size_t array_size = num_queues * sizeof(uint32_t);
+	size_t array_size;
 
 	if (!usr_queue_id_array)
 		return NULL;
 
+	if (check_mul_overflow((size_t)num_queues, sizeof(uint32_t), &array_size))
+		return ERR_PTR(-EINVAL);
+
 	return memdup_user(usr_queue_id_array, array_size);
 }
 
-- 
2.53.0

