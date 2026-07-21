Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296ACC4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3E1E10E309;
	Tue, 21 Jul 2026 22:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="SJP0ZZDi";
	dkim-atps=neutral
X-Greylist: delayed 613 seconds by postgrey-1.36 at gabe;
 Tue, 21 Jul 2026 13:45:25 UTC
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 905A310E336
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=pf
 OgrWrw+CxcXmXOj4xrBkAviJ9rw4ZDWJLuC83Q2kQ=; b=SJP0ZZDi4CAaG6J0aI
 cVNpMOndqM2YdZtKWK4Jhon9ibMBK5qM3/D4lK/xhbuGlERlrvM8X7L2AluEti7d
 8xwgeSgjLMRYegd5rsw+H8o5PA8ucg2ol32S/XXfcp10opvHbJmnSwxcWyJ4EmcP
 QDb5rwAhVIUitTonk34BfuX2c=
Received: from lwj.localdomain (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PygvCgCHLyvWdF9qsel_IQ--.46483S2;
 Tue, 21 Jul 2026 21:32:07 +0800 (CST)
From: Xuan Tang <x14786623579@163.com>
To: patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Xuan Tang <x14786623579@163.com>, stable@vger.kernel.org
Subject: [PATCH] drm/gma500: Handle zero-length GMBUS writes
Date: Tue, 21 Jul 2026 21:32:00 +0800
Message-Id: <20260721133200.844629-1-x14786623579@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgCHLyvWdF9qsel_IQ--.46483S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF1fJF47ZF1fur4rKF4xtFb_yoW8GrW8pF
 sIgF4UKrZxJF42y343Ca17AFWrC3W7Xa43GF4kKw15u3W3XFy5JFW5Wa4aqryrGrnavrZa
 qr1rKFyrWr17JF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRwSdkUUUUU=
X-Originating-IP: [113.200.174.121]
X-CM-SenderInfo: j0rulmywwsjkixz6il2tof0z/xtbCzhfEtGpfdNeVUQAA37
X-Mailman-Approved-At: Tue, 21 Jul 2026 22:11:24 +0000
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

gmbus_xfer() uses a do-while loop to preload the first bytes of a
write message into GMBUS3. The loop accesses the message buffer
before checking whether any bytes remain.

For a zero-length write, the loop therefore dereferences the buffer
once. Decrementing the unsigned length from zero also wraps it to
65535, which may lead to further out-of-bounds accesses.

Check the remaining length before accessing the buffer. This keeps
the existing GMBUS transaction flow unchanged and preserves the
behavior of all non-zero-length writes.

Fixes: 5c0c1d50d7ba ("gma500: Add support for Intel GMBUS")
Cc: stable@vger.kernel.org
Signed-off-by: Xuan Tang <x14786623579@163.com>
---
 drivers/gpu/drm/gma500/intel_gmbus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gma500/intel_gmbus.c b/drivers/gpu/drm/gma500/intel_gmbus.c
index 5933ae04a6aa..bf060a62b3b7 100644
--- a/drivers/gpu/drm/gma500/intel_gmbus.c
+++ b/drivers/gpu/drm/gma500/intel_gmbus.c
@@ -294,9 +294,10 @@ gmbus_xfer(struct i2c_adapter *adapter,
 			u32 val, loop;
 
 			val = loop = 0;
-			do {
-				val |= *buf++ << (8 * loop);
-			} while (--len && ++loop < 4);
+			while (len & loop < 4) {
+				val |= *buf++ << (8 * loop++);
+				len -= 1;
+			}
 
 			GMBUS_REG_WRITE(GMBUS3 + reg_offset, val);
 			GMBUS_REG_WRITE(GMBUS1 + reg_offset,
-- 
2.34.1

