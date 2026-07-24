Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149B4C531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 535A810E197;
	Fri, 24 Jul 2026 09:44:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="MIGZ/FED";
	dkim-atps=neutral
X-Greylist: delayed 381 seconds by postgrey-1.36 at gabe;
 Fri, 24 Jul 2026 09:44:48 UTC
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EADB710E197
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 09:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nP
 yECosMUNKk8ZjviMyMGnMwlq3c6hyLwVXHO9BnoaE=; b=MIGZ/FEDSgnGEsat4b
 k6JckbCtP9dHZU9llgya4WMLHspBwMQQOpvX2zK/AGHCnvQ6tpr8LUKXWGqWEqN1
 EeJqXaWI+Tu5P7+d8K+wnQYIMaOBW/wKxFYNmkwScZ/k9QjfM56bxPuPU2r+BUq5
 q1ys2RBmUUJJR4zLUvrcaqSC0=
Received: from localhost.localdomain (unknown [])
 by gzsmtp2 (Coremail) with SMTP id PSgvCgCnrOWJMmNqMRRwIA--.23923S3;
 Fri, 24 Jul 2026 17:38:20 +0800 (CST)
From: oushixiong1025@163.com
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH 2/2] drm/udl: Use iosys_map getter for virtual address
Date: Fri, 24 Jul 2026 17:38:08 +0800
Message-Id: <20260724093808.776138-2-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260724093808.776138-1-oushixiong1025@163.com>
References: <20260724093808.776138-1-oushixiong1025@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PSgvCgCnrOWJMmNqMRRwIA--.23923S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWDXw1fWF4DXw15Gw4kJFb_yoWkArg_Ca
 4UKrn7WrWkGa4kuF45ur43uFyjkwsY9F40gFn7tas3tr95Jr1DZ34xZr9Fvw1xGa4xAF95
 KaykXrnxArn7GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8QAw7UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4gwjMmpjMoy8OgAA3O
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

From: Shixiong Ou <oushixiong@kylinos.cn>

Replace direct access to map->vaddr with the new iosys_map_get_vaddr()
helper function. This properly uses the iosys_map abstraction layer
instead of directly accessing structure members.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/udl/udl_modeset.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index 289711035b67..06a3a4d149b9 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -207,12 +207,16 @@ static int udl_handle_damage(struct drm_framebuffer *fb,
 {
 	struct drm_device *dev = fb->dev;
 	struct udl_device *udl = to_udl(dev);
-	void *vaddr = map->vaddr; /* TODO: Use mapping abstraction properly */
+	void *vaddr;
 	int i, ret;
 	char *cmd;
 	struct urb *urb;
 	int log_bpp;
 
+	vaddr = iosys_map_get_vaddr(map);
+	if (!vaddr)
+		return -EFAULT;
+
 	ret = udl_log_cpp(fb->format->cpp[0]);
 	if (ret < 0)
 		return ret;
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

