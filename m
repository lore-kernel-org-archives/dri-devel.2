Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67B4C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 089B810E2A2;
	Wed, 29 Jul 2026 10:26:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="T4EwqiJZ";
	dkim-atps=neutral
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com
 [162.62.57.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33A1210E2A2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 10:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1785320792; bh=5aonJwU7NUvO+HaO8712QjB1i2KpssPyPphCGk0Bn4U=;
 h=From:To:Cc:Subject:Date;
 b=T4EwqiJZjJtz8EOALBAGHa++FEdtrh3zdrj9/VFNEFbVgiqP4M1IfDOykbMvfcPfo
 pJohl22c0CDBa7+LtNNO8vNOb/dZrni4U7pJDlc+qlRtiqRRt/QXgh7KIQxNmknFJs
 HNJr84Xu2rTOVjDKzQuwXAxBCqOg+fs6nAv7YaIU=
Received: from localhost.localdomain ([116.128.244.169])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id 69DBAAB1; Wed, 29 Jul 2026 18:26:29 +0800
X-QQ-mid: xmsmtpt1785320789typpnxj14
Message-ID: <tencent_BB2A7CAE632BA0AC08D9296E78A15786200A@qq.com>
X-QQ-XMAILINFO: MFkgsonL4eTuQmqQgWWwTzVIvBycrCHbnpGQ/JqJnWA9/Et7jX4EYP6jITPcP/
 8FoGL7//AbBbxF+Yq4k636+GLeSstIt/krsXfr/+krPuIptwGQUPyb4AoMTZYbhd8JVNpl4n0cYb
 zNKo/y4giLA9mM8ICQpEDD3nkLAdESsa2aAl0nlPV6AozZHEjuuVZ7bM5tmtoUEzuUnTruyUPJOw
 /3TZA1DRdMOZJRAr+1H1AW+AHgnxUmafn5IFEJvP5QxYSnyhB2X8sO5upOP1A09ZyGvmlNoE1/jV
 2W+HmO7fqWnd2QEJ69Og2DcwnV4YX/aOwBNlpc+oxtsfZw9u5jAbswKe010XdI69n+IAgmoluCSS
 iY6zFhu6t+UX21p86UuDXjrPDg5FPslvhftLoyo2B9uKRATugFLCg79N/dnf6frxmaqxcWZO+Szb
 jK6PgNYmJb190DKi4pgFqfZF+MulY5ToE+u9UFT7GL8x/RUKDueC5BH489P9BdxyQ34MUqQP6QOy
 +pYjO8Ev79TYPg2y6Lx6uYDKoxsUIQMt7/Wa7XeXtSNX6XktE6NHQIlPt48x4LAfXwo4hSl/8xDA
 C4UFpU2qWypmhrzyZLhFPYQoengJEhTCVU9VGVQ5FYXFmZ8VqdeHWTTiQc1YR6BgFm6u+ZuHGar2
 wyaSJ2qzPI4I72aamda4IhDQLKDD4k7W4oJ0RtWCRkB/p4HtKhFfLDzDjq0AMRm7+MYcVJ/X2L+5
 Nv7g70WA8DDhfXTxywPAq7AK9PUw6Rkrx9c3kAqU/aJs2eF13kRuNU3I8K6V27OVxNSTesCxFvtp
 wNwC5r+uh776h08SlLFJs4cnZJSsDTc/EATJ/7XUJqHCKp8U5QI5RIF7bRhhXg3DNBmtkQM4KEfG
 TnL9rHfVvKCnzaa4FRXiYXI75V0TWl2ovIS4ywi1oLLmFA0BW0d91axkaxrNk7mRbYK/qip4k+mH
 QlslNw0bUuN1SOYDI9qvuy4eY0VnMH5qYFWM04KmZUYokBjC32R7OiB0L/V3zNNztWsUxUnErw1y
 6UIyH2pTMFXYc65oIvx34XBKfXh/E=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: 2564278112@qq.com
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 2564278112@qq.com,
 Wang Jiang <jiangwang@kylinos.cn>
Subject: [PATCH] drm/radeon: restore hardware polling in fence_is_signaled to
 fix performance regression
Date: Wed, 29 Jul 2026 18:26:26 +0800
X-OQ-MSGID: <20260729102626.634363-1-2564278112@qq.com>
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
is_signaled, no deadlock") removed the hardware polling from
radeon_fence_is_signaled() to fix a self-deadlock caused by
wake_up_all(&rdev->fence_queue) being called with the fence queue
lock held.

However, removing the polling entirely causes significant performance
regression (e.g. glxgears FPS drop) because the fence signaled check
becomes purely passive — it only reads the cached last_seq without
probing the GPU, so completed GPU work is not detected in time,
causing unnecessary CPU stalls in sync-heavy workloads.

Fix this by calling radeon_fence_activity() directly instead of
radeon_fence_process(). radeon_fence_activity() reads the hardware
fence counter and updates last_seq via atomic ops without calling
wake_up_all(), thus avoiding the deadlock while restoring timely
fence detection.

Fixes: 9eb00b5f5697b ("drm/radeon: delete radeon_fence_process in is_signaled, no deadlock")
Signed-off-by: Wang Jiang <jiangwang@kylinos.cn>
---
 drivers/gpu/drm/radeon/radeon_fence.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
index 02a40e4750c7..299865569252 100644
--- a/drivers/gpu/drm/radeon/radeon_fence.c
+++ b/drivers/gpu/drm/radeon/radeon_fence.c
@@ -360,6 +360,13 @@ static bool radeon_fence_is_signaled(struct dma_fence *f)
 	if (atomic64_read(&rdev->fence_drv[ring].last_seq) >= seq)
 		return true;
 
+	if (down_read_trylock(&rdev->exclusive_lock)) {
+		radeon_fence_activity(rdev, ring);
+		up_read(&rdev->exclusive_lock);
+
+		if (atomic64_read(&rdev->fence_drv[ring].last_seq) >= seq)
+			return true;
+	}
 	return false;
 }
 
-- 
2.25.1

