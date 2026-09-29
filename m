Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D77ACA5FAE
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 03:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4475A10EC7C;
	Tue, 29 Sep 2026 03:46:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="ByVSowkG";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC4F510EC7C
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 03:45:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790653544; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MIwuizdpNvAwPqKs4y2/EAXjfXJ+zC1f4JMr0cjRv2vosAvGp17uRLYIFfhXjfyYe17A4QOgXJUlV9OWqzryD0tTkUMf0WLR/Y0CNQoZGmUhnIFJw+tLVkjdZ47ASWidSIeieJuUDqFB5T7loR2XTAJmIC+hddKfJcdyA69/NL8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790653544;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=mNxJxy2SiSufH0bn/vRhZOAvlJ5kVJf8B1ZEKhnZWHw=; 
 b=V1OtQwdm0kTDUwvBWNVHcf5rEnAtg7p2uUk/gu/sD3CfiGVE8KwnXq80ZxKvkwRryzXUqZ7EYmzS05RKqHPXUs8oe82XBhvFZjJdC5nhoxZYztiCnVRRLNlvnYIWQhYlFv6oZL2DZ0gA8meIl2Wl8EvPNNfnjZPbbrscskLn0zE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790653544; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=mNxJxy2SiSufH0bn/vRhZOAvlJ5kVJf8B1ZEKhnZWHw=;
 b=ByVSowkGZtkoMa7wpAHghFEkLELFu22pmJXxZhmstxcuF/gF6laSTBAjXVAB7T4a
 IWXEOR+a26l30TprYyh+Eoa+wWubd+AB/8kXsLSWmRmO6QINOw+M3aZPXVBkfNYgnG0
 r2HdNL/VmqtGEuP+rw35KPjP55P6YhH5IgRxM4r4=
Received: by smtp.zohomail.com with SMTPS id 1790653542695170.05616378754496; 
 Mon, 28 Sep 2026 20:45:42 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 29 Sep 2026 04:44:43 +0100
Subject: [PATCH v12 09/15] drm/panfrost: Add warning messages to fatal
 error conditions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260929-claude-fixes-v12-9-62beb08de207@collabora.com>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
In-Reply-To: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1571;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=lA6x9qSUxtgT2vTBUbfDtwSj/JWblIzbdLpsN/oZ9es=;
 b=kA0DAAoBDiZ+TO5TQz0ByyZiAGq7NC6gZvYepyv+JY6Sx1avrsXDq+zAicGRrI14yW+cUfUbq
 IkBswQAAQoAHRYhBDJAMOjABRdd+TcHpA4mfkzuU0M9BQJquzQuAAoJEA4mfkzuU0M98PkL/iUS
 Oa/siqC6p1WfIzKShRoCaqp77bLELvx/az3ZNg3qfLxoA650OVI62l1OLHHA40J/CYvnTE82znw
 +j9Q2aCwc5joMyrNwkrFqaQhyw2t3OyJJcnMdFyjHMp67GezESfCry02JTqupP/SinGhuMwDpGq
 Z40FmZQxnxuE0x9qEgsPDx7MsYLsMbqL+s52dzey5C1rJAf/4pBN3va9SZERJ2aJvJEWai7Kx4a
 zWUySd4w3UETGjVfAmNEIpncWYUtQN/wkwjvN59ke3TohzW6thDrsKqtFqUriKqi0ORrKVpZPja
 UP7Kjl4EMSVo0H4mQWv2cYzCGr9nepEbVHbJvuRmgq6pfj1a30E4+lB4M419YS6FIHWWgqU7aMt
 eEGCvrJGvy7uLgWoKu7cpERIS3TbTPt9wYPQGLT2OZ+X66xzI5G3j9cQ6AucvTzYNTYUL7JB2Mb
 MJIMqzyRZ830t7gVi1YOarf87CgJLhdIw57OuUTmAOMTYconc1zibzNjMfxQ==
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

Rather than just failing silently, let's warn the user of device remove not
being able to take an PM reference or the PM suspend path still reporting
inflight jobs. Neither situation should ever happen.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index c6bf3d0663df..09a5752a3f40 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -9,6 +9,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_print.h>
 
 #include "panfrost_device.h"
 #include "panfrost_devfreq.h"
@@ -357,7 +358,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 
 void panfrost_device_fini(struct panfrost_device *pfdev)
 {
-	pm_runtime_get_sync(pfdev->base.dev);
+	drm_WARN_ON(&pfdev->base, pm_runtime_get_sync(pfdev->base.dev) < 0);
 
 	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
@@ -516,7 +517,7 @@ static int panfrost_device_runtime_suspend(struct device *dev)
 {
 	struct panfrost_device *pfdev = dev_get_drvdata(dev);
 
-	if (!panfrost_jm_is_idle(pfdev))
+	if (drm_WARN_ON(&pfdev->base, !panfrost_jm_is_idle(pfdev)))
 		return -EBUSY;
 
 	panfrost_devfreq_suspend(pfdev);

-- 
2.55.0

