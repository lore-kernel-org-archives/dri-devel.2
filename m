Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA489CDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 17:08:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20EA410E22D;
	Thu, 25 Jun 2026 17:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Du76KRFq";
	dkim-atps=neutral
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com
 [209.85.216.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0047B10E22D
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 17:08:42 +0000 (UTC)
Received: by mail-pj1-f73.google.com with SMTP id
 98e67ed59e1d1-37d4eede8ccso46812a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782407322; x=1783012122;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lga7Yq072G4mYoR4ZYRzQRKAQbvBlbeEWBDVrXci4B0=;
 b=Du76KRFq+uRQT5E1LxFodUdbq7ho9zP83xx37VySuSx3DZhvhTWVNYWZEa/NLOOfDg
 yLTGhYBTU3hxzF2A0dgG3/MMNH+o0UoHy44N20uuB6fDMyjo6fm2lISLwqXceYCHo0Mr
 y5H534EnAZISy2T9wuolbL13iVJBWrejOBKpanr4XBbJembvAc9X3d+Omhy+Y+JB9VQo
 2ZnGdLKt7RpgMA1/VgQtJwkcTZM09Ip9NUyVWh/CndpP3VBYVuH5uXW61HyPTqzdTpbT
 7dBxbD5Ucmg5JvwiH1+kgAig5bFd6+wRid5BMGRj3Q8ZtT6BUSD1hySh3cOa5cLGS5B9
 jmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782407322; x=1783012122;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lga7Yq072G4mYoR4ZYRzQRKAQbvBlbeEWBDVrXci4B0=;
 b=olqwicrPwKotjVR9bi8Vg1Z4SKanyDh+2YTnYYeMn0PFdtteGLPVFgRRemtBtGFY90
 JHPnzsfHxanD23ux/c0fBGwobb2Wgcwi58yEo4lIMrgFJGKQRu2yMFYU4y1AdPrIewjS
 B9sYyloxI3xZm3Etd3Ho7Xn75CYGXG07oGlS0joHoB/5GxsPGNEbCDJmvxsPOJVPII5o
 0HF/xAJ4w5N0HMwnT5JsZI5hruVnMVBzWgIWu8UoJnHjxZWYxntk6WzPtCyufKw1KISV
 Bzmbrj5qpdTgNyKCcWTtk+p5LvM828Ho5DuneSe7M7DaZwD98zBl2Kj0DZFq+Kw9W2Ji
 VK9w==
X-Gm-Message-State: AOJu0YyjoimEDfNTkdz7fqf0Eb5upjdthSDcJMg+kgOwsslal4J42slI
 LbWfdjxUEQfL+5LdwaSwSzIYtsAwY768Sl1AzyZ8yaUUQY18s95lmvugLh66qohh9KommS99Kw8
 7Og==
X-Received: from pgbn20.prod.google.com ([2002:a63:5914:0:b0:c8b:1d37:c0f6])
 (user=natsu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:180b:b0:36d:ee3b:fcae
 with SMTP id 98e67ed59e1d1-37dfa1b664cmr3246028a91.6.1782407322191; Thu, 25
 Jun 2026 10:08:42 -0700 (PDT)
Date: Thu, 25 Jun 2026 10:08:28 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625170828.3335431-1-natsu@google.com>
Subject: [PATCH] drm/virtio: Don't detach GEM from a non-created context
From: Jason Macnak <natsu@google.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Jason Macnak <natsu@google.com>,
 stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Applies the same treatment as commit 7cf6dd467e87 ("drm/virtio:
Don't attach GEM to a non-created context in gem_object_open()")
to virtio_gpu_gem_object_close() to avoid trying to detach
a resource that was never attached due to a context
never being created when context_init is supported.

Fixes: 086b9f27f0ab ("drm/virtio: Don't create a context with default param if context_init is supported")
Cc: <stable@vger.kernel.org> # v6.14+
Signed-off-by: Jason Macnak <natsu@google.com>
---
 drivers/gpu/drm/virtio/virtgpu_gem.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 435d37d36034..66c3f6f74e9c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -139,13 +139,15 @@ void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
 	if (!vgdev->has_virgl_3d)
 		return;
 
-	objs = virtio_gpu_array_alloc(1);
-	if (!objs)
-		return;
-	virtio_gpu_array_add_obj(objs, obj);
+	if (vfpriv->context_created) {
+		objs = virtio_gpu_array_alloc(1);
+		if (!objs)
+			return;
+		virtio_gpu_array_add_obj(objs, obj);
 
-	virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx_id,
-					       objs);
+		virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx_id,
+						       objs);
+	}
 	virtio_gpu_notify(vgdev);
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

