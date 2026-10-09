Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB1CCA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 12:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7AB61120F7;
	Fri,  9 Oct 2026 12:35:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="K4EVIYrZ";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FDE71120F7
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 12:35:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791549291; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=T1eexLbQfbVurJXZQAe96D7vR8LPZ1oyj5/wT5FhC1j6xviLXMsTqxxVJRHl3ryv4foWFYiK/wJCSTAxBiTuFvayc9qu08BJeJjCoYJEaN5FRUkldYfiCMLRa7DfiR0OFevt9jGxDxJJOAtcT+65oyzxiLcODF6lI6BOLJC4tKc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791549291;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1ZKPGzGFIKzRpgJ8bQvtWgmP876BGVh5STCt3ZGycg8=; 
 b=UKKFo6MwqbabJfrYHVOxE/DAqhLjTB5m535DjqniNsn2DaWMNNNftuoPjd7D1Ldd+uHBjMPX+frAwHwIRnh6IJ4ZA8l4+cu8gW5WLxR0Pm7zcaxu017AXIDx4QNpmp8i7hlfl9/oPQDZzIgyk/f2vwYWKXw0ZRXdqytMXq7tAvU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791549291; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=1ZKPGzGFIKzRpgJ8bQvtWgmP876BGVh5STCt3ZGycg8=;
 b=K4EVIYrZC+O8M+BPCSuzTG/jxIRMst9ofip5SWQdpc40aIqLadrzHtSkxc8vv9YW
 istR3h9PtcmQBKSlYYCXdN+cKt3cmVd3DwZcFa9QZJLGMZ8q9zU4iTZDqodHCnZaiKO
 kS8XReQXgTH94hfiZ1EHig1YAluTvDgnneDgjLD0=
Received: by smtp.zohomail.com with SMTPS id 1791549290385458.0726644044772;
 Fri, 9 Oct 2026 05:34:50 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 09 Oct 2026 13:33:56 +0100
Subject: [PATCH v14 09/15] drm/panfrost: Warn of RPM get failure at device
 remove time
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261009-claude-fixes-v14-9-cb743b3b973b@collabora.com>
References: <20261009-claude-fixes-v14-0-cb743b3b973b@collabora.com>
In-Reply-To: <20261009-claude-fixes-v14-0-cb743b3b973b@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1207;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=C+aZNX7+BnRco3oE1Uwz3UD02CNIOs99szgIunWDsWQ=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqyN8vj4T44WlQrip0z29FE6NTOK1rptXAEdxRk
 R88gh/+PmCJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCasjfLwAKCRAOJn5M7lND
 PSyWDACmx30nvVAS4jyHIAXZrDhvp/agXcEp1ju6Ixdqi6aNkr9MZ5DYqU8KX2/pF181mUtNds3
 ENkJJnesF0TR6fyIG2SXW3SqiTJ9ARtlM5bvXiDaY51RDyB0x6Glha30QDy1obMf6HtIk1ZDTSN
 KiC47E6SNxO4uZmDWf2DthUQSZJKVKdfXRrFjRHaHi0qrzK3l6Tr2gjgJ5qmrtqRTM85nSRewmb
 IsufMPyqRcrHsJUjtXiG/v+7aw6qcywfnM4fJgLVMqb+VPnxhDRIncaSl7iN/qS95okgaXfTt64
 iHxPstMYjWJNvIitMc6+Y79KaY5W/JoJbhdadV9RT37j3hpe8osaC7UkMF0p819JT7PBIKGf/jF
 YZFCogczCWdz8LXXg9WOIuc9jKMxuMidubrP4w1kn7t+ySyeAJ3kSBkenNxpkFp7I2f903nsUVp
 Vb/tcIsL8V5E+amSe+6WXuAcYHmlLZ48dA3RJZRQ6jIm/8easLt1R/XZsfYgpbv1QnWzc=
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

Rather than just failing silently, let's warn the user of device removal
not being able to take a PM reference, because it should be seen as fatal.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index a6deabb39fd2..687230225743 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -9,6 +9,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_print.h>
 
 #include "panfrost_device.h"
 #include "panfrost_devfreq.h"
@@ -385,7 +386,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 
 void panfrost_device_fini(struct panfrost_device *pfdev)
 {
-	pm_runtime_get_sync(pfdev->base.dev);
+	drm_WARN_ON(&pfdev->base, pm_runtime_get_sync(pfdev->base.dev) < 0);
 
 	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);

-- 
2.55.0

