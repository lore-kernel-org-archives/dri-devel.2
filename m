Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE04CD6E68
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 07:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8102113D15;
	Thu,  4 Jun 2026 07:12:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="mkDIeNHV";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE8A113D15
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 07:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hi
 UR13d5dBzF8Im0U4deIlQbQWkcyNiC9aoy5hCFBUg=; b=mkDIeNHVQy4O7w4t/S
 XA37GGo2LzrOq9wfN4voJbwLzOnnqDMzey1xTKHNsJ0f231DEDxlhD2iArJZIa9l
 m/pr4Mht8f4zINLYhtcSV6ar7aOH75QfPlG+dg2w5Hp/3m+CBl5BlrKcuB9yMnh8
 CXP/xIEpOk/TTLBcJDSyoj1ws=
Received: from neo-TianYi510Pro-15ICK.. (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wD3kWdLJSFq_opjBQ--.18375S2; 
 Thu, 04 Jun 2026 15:12:12 +0800 (CST)
From: liuqiangneo@163.com
To: airlied@redhat.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Qiang Liu <liuqiang@kylinos.cn>
Subject: [PATCH] drm/virtgpu: Use ERR_PTR for fb_create callback error return
Date: Thu,  4 Jun 2026 15:11:58 +0800
Message-ID: <20260604071202.138235-1-liuqiangneo@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3kWdLJSFq_opjBQ--.18375S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr4kKryxWrykKrWfGw4UArb_yoWfGrc_Gr
 1UXr9rXryakF1v93yUAa1rXryIvas8CFs7Z343tr93tw1DAwn7X3srZr4xX3W5Wr4UKFZx
 Aa1rWFn7Aan3KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8a9aDUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 5olx1xxdqj0vrr6rljoofrz/xtbC4Aw-oGohJUwXVgAA3Q
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

From: Qiang Liu <liuqiang@kylinos.cn>

The fb_create callback returns an error code encoded with ERR_PTR()
on failure. This lets the caller see the actual error code instead of
just a generic failure.

Signed-off-by: Qiang Liu <liuqiang@kylinos.cn>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 44ffffec550f..85ea252c658e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -344,7 +344,7 @@ virtio_gpu_user_framebuffer_create(struct drm_device *dev,
 	if (ret) {
 		kfree(virtio_gpu_fb);
 		drm_gem_object_put(obj);
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
 	return &virtio_gpu_fb->base;
-- 
2.43.0

