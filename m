Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78722C54FCD
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 02:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C190210E0D4;
	Thu, 30 Jul 2026 02:00:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="UVwVzDvr";
	dkim-atps=neutral
X-Greylist: delayed 56025 seconds by postgrey-1.36 at gabe;
 Thu, 30 Jul 2026 02:00:21 UTC
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com
 [162.62.57.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E03B10E0D4;
 Thu, 30 Jul 2026 02:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1785376817; bh=0xN53fSjIiBOOV5VjlYOGlcvd9RUyIldcYlRRvF6YIA=;
 h=From:To:Cc:Subject:Date;
 b=UVwVzDvrEkL6tNBLdFlJVt32ux6qZfwcmZUL3dm+jOmLvJPkL8tN/wn2OyT7w3REx
 6R7p8zmr92k/XmAE+QN+hM1lEUd+DHkZ4wz+2+oCTnXhb+gKc3UobzaK22kyST/YrX
 uxTgOeu1YHtQU6bZbRPY6juQCCtrPaWOO7ulMPGE=
Received: from localhost.localdomain ([116.128.244.169])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id E31396D1; Thu, 30 Jul 2026 09:56:49 +0800
X-QQ-mid: xmsmtpt1785376609tdjg2fwyo
Message-ID: <tencent_38CA3044B54F14EC7314032134C531AFA807@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLID7l6dEU+iPPLLen4FS6BfKQBu6XKCXI91xb+7Nf2IEAghXHBa
 9RT9JALecb1jUufloDkxH7keBRDbmdsmvgi7kDQDZMICDCQIL27vc8D0OOEkuF487GNxCCZkjcKk
 WI59nVClaQCu2LBno3AXBMAtvNxrEyUvhutx/Kh5gwnWNUG1Jzzwb5NNyApFTpLR59zPPk8Q5Dn1
 dGtIzZDRmpIrF89OQ1T6Nqy7wI/XzDcF5ysncc+YlefRROAG8kyd3WKfckfwfwjJb055RGQxyJAw
 Afz/8vpwOITjEITuzVzJKzSRjTfz+SuxAfMCjXok09oiBcYfImrfcOzJMowzX+4frSaQGQzp1GT2
 0EhqlsHgQ07tHvF08NZ0U4eVpl4s75Yeaphwjw9PCUT/Bu0CSzV5p91SodiR9VsTPFQNmykUQRM+
 Xx28upw9mRoW3JBU4a1pbBc8s5XBzkWXdd3WQQf80H1J7FLCLUNiqw0ft6nQcerWYNp40ANFtsxl
 0mAvsbvwO8FT7u6YmvPs8s9hsFjnRFW16tMApTUm2fr4csfmbIdxu6pkvXCvNn8xA+MthMtmJ9yf
 +ZzU7mUdtu04X89E+Nq4yeFjljcgKbfhyb2s0jjvdu/HbGtXUK6Y3Av34VyybPD6eIDdl+TMfChN
 W/meV58RnbiFNPkEuQ8AUnKkerN6KTTQ55LsIGvqRzQuYkBWz4vnE0L/ivnDG/OYnuIFgkZLi6pW
 7KGm3smuCzxlOICLxS+jiqGiNvIkrnotDvsQchRnPeFD/CNEnOMNyuGT+ATHtWHLr3oEPXtDm7TO
 PnUOHNUeMkEwqx/sZdtt9y1WZhegvqa1RRY7FnGZvTLL5Vv+dkczz7oOG4KWd8y6zL5LiyMWvpcn
 rIid83hnJ2772/Zm8N+3DP/uqrRWclVOikZjMIRE9EFBDEMxD912sWMWqjkSTkAzCkOyPldrX2mO
 s1yrrJjB4qE34CQnu7v1CqrTz+C+U9LlocKFz4vtTkcd/OXT0Crw7MNGMP3Wm0wGe4LdZ1yAPYWf
 vDN800NQ==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: 2564278112@qq.com
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 2564278112@qq.com,
 Wang Jiang <jiangwang@kylinos.cn>
Subject: [PATCH v2] drm/radeon: restore hardware polling in fence_is_signaled
 to fix performance regression
Date: Thu, 30 Jul 2026 09:56:47 +0800
X-OQ-MSGID: <20260730015647.106283-1-2564278112@qq.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Wang Jiang <jiangwang@kylinos.cn>

Commit 9eb00b5f5697b ("drm/radeon: delete radeon_fence_process in
is_signaled, no deadlock") removed the hardware status check from
radeon_fence_is_signaled() to fix a self-deadlock caused by
wake_up_all(&rdev->fence_queue) being called with the fence queue
lock held.

However, removing the hardware poll entirely causes significant
performance regression (e.g. glxgears FPS drop) because the signaled
check becomes purely passive — it only reads the cached last_seq
without probing the GPU, so completed GPU work is not detected in
time, causing unnecessary CPU stalls in sync-heavy workloads.

Fix this by calling radeon_fence_read() directly in
radeon_fence_is_signaled() to poll the hardware fence counter
without updating last_seq or calling wake_up_all(). This restores
timely fence detection while avoiding the original deadlock, since
last_seq update and waiter wakeup remain solely in the interrupt
handler's responsibility.

Fixes: 9eb00b5f5697b ("drm/radeon: delete radeon_fence_process in is_signaled, no deadlock")
Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>
---
 drivers/gpu/drm/radeon/radeon_fence.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
index 02a40e4750c7..047ec5a1d194 100644
--- a/drivers/gpu/drm/radeon/radeon_fence.c
+++ b/drivers/gpu/drm/radeon/radeon_fence.c
@@ -360,6 +360,18 @@ static bool radeon_fence_is_signaled(struct dma_fence *f)
 	if (atomic64_read(&rdev->fence_drv[ring].last_seq) >= seq)
 		return true;
 
+	/*
+	* Poll hardware directly without updating last_seq.
+	* This allows immediate detection of signaled fences (performance)
+	* while leaving last_seq update and wake_up_all() to the interrupt
+	* handler, avoiding:
+	* 1. Deadlock from calling wake_up_all() with fence lock held
+	* 2. Wake event stealing by advancing last_seq without waking waiters
+	* 3. rw_semaphore usage in atomic/irq context (unsafe on PREEMPT_RT)
+	*/
+	if (radeon_fence_read(rdev, ring) >= (u32)seq)
+			return true;
+
 	return false;
 }
 
-- 
2.25.1

