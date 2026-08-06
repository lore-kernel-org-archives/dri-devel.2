Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8301AC55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 09:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C631810E2EC;
	Thu,  6 Aug 2026 09:33:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="f+emjOnu";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C126910E2EC
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 09:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ue
 +q1bRSZugXSbIbu2jD2eZp8o3DnJ4ICvQW0KfCwQ0=; b=f+emjOnu5lHNY1HYWI
 CB6g4PNm7e9CGYXhS0u5MwOpw2p/Ie1Q5rBwavF1bzbpv1YNeEWP7EH5lu7YHHfi
 hZLua1zNJBYUPYLvAVcY6qJ6XsXqrpHqkc+nl9dDQh/JWbe0jcz+Iu3/P4HTGFbK
 CL/OsFge72EQlYimvS0DFecmI=
Received: from localhost.localdomain (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PygvCgCHYCTdVHRqfC7yKw--.6034S2;
 Thu, 06 Aug 2026 17:33:18 +0800 (CST)
From: oushixiong1025@163.com
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] drm: reset dev->registered on drm_dev_register() error path
Date: Thu,  6 Aug 2026 17:33:15 +0800
Message-Id: <20260806093315.594335-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgCHYCTdVHRqfC7yKw--.6034S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFyUJFy8CF18tFWxCFyrCrg_yoW8Jw47pF
 W3Ga4YkrW0vF4aqrWUAFWxCFy3J3W2qa18uryjqw13W3Z8CryDtrW5JFyUJa47tw18AF1S
 q3Z8A3yxuF4jkF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UAcTdUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4h4EE2p0VN5HGwAA3j
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

drm_dev_register() sets dev->registered = true before calling
drm_modeset_register_all(), but the error path does not reset it.
This triggers a spurious WARN_ON in drm_mode_object_unregister()
during teardown of drmm-managed resources after a failed probe.

Observed on hibmc-drm where drm_modeset_register_all() fails with
-ENOENT from connector registration, producing:
 
   hibmc-drm 0000:22:00.0: [drm] *ERROR* failed to register drv
       for userspace access: -2
   WARNING: CPU: 32 PID: 2887 at drm_mode_object_unregister+0x9c/0xb0

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/drm_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 1ff0bf7cba6a..4497af8c9d1c 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -1120,6 +1120,7 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
 	if (dev->driver->unload)
 		dev->driver->unload(dev);
 err_minors:
+	dev->registered = false;
 	remove_compat_control_link(dev);
 	drm_minor_unregister(dev, DRM_MINOR_ACCEL);
 	drm_minor_unregister(dev, DRM_MINOR_PRIMARY);
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

