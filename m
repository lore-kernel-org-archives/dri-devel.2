Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7660CA6009
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 23:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 398C210F852;
	Wed,  7 Oct 2026 23:44:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="E0wTNBum";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65E2A10F844
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 23:43:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791416634; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Rrf43TwJk9tzlfg+OSJdzptjRVMlqPT+8YMMKUDriv7WyNWHSxZEOpg0dB/m+Qk2/KPZK6guKPM8Sj7jZmuCmtoCt9bPvmjzNcUk1wYH2Gul9tyGs1YjCda85jYMQVeYz7AfHMaynILgkk32vph1TXcYCpkD3pjo+l1dqMmgZMo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791416634;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1ZKPGzGFIKzRpgJ8bQvtWgmP876BGVh5STCt3ZGycg8=; 
 b=fFylI5RFAxxIrYiktNKoFVE9PfyNPWGt7BmKduQVmTCtxlRcO6XznVhhHBmjWaJ1jUmaeRhX62wQrvkT7Q4ig6Dh/OfbRgAh9U5u0lhpS/90y+K34d2xqN1odq0gotB0USJ4nrDERyRAEOlKtJ3G7/B6+nwfvDh1Qc/Ih31mHIY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791416634; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=1ZKPGzGFIKzRpgJ8bQvtWgmP876BGVh5STCt3ZGycg8=;
 b=E0wTNBumhjswqJorI8bMxAOUkjYlN2wnd81vTNTEWiXCuIYAkD57YxHC8gjG3n00
 1qqbrPVgRqkx139u2lu234r8jDxtOcmqlp2Wyf3FxeBUZwY9QmeF4sRrmrMNH++lxgA
 dAHCeoxj3VIsepjwfcCTHvTLZWFoqTOC56QMzsvI=
Received: by smtp.zohomail.com with SMTPS id 1791416632545991.1149379443405;
 Wed, 7 Oct 2026 16:43:52 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Thu, 08 Oct 2026 00:42:52 +0100
Subject: [PATCH v13 09/15] drm/panfrost: Warn of RPM get failure at device
 remove time
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261008-claude-fixes-v13-9-d6a493185860@collabora.com>
References: <20261008-claude-fixes-v13-0-d6a493185860@collabora.com>
In-Reply-To: <20261008-claude-fixes-v13-0-d6a493185860@collabora.com>
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
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqxtj71OoGF8OuakUpeQxIzW2OMuPM6Z/7Uwuzs
 Z0iJgb1+8OJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCasbY+wAKCRAOJn5M7lND
 PYXKC/9ecOYnmjNBVcWv9KgDkMaBAXbIOQ3C4ebR+jDWEjATgJLNTqHMEWyXkVq4YdxHx0AoDJE
 2eufoacWtTi14lAuSqLTYIY/AFeMcrPWo4coj9XhuGn8MuVLQ02l2Sbi2/rj2AjXqYmhHPgIBMQ
 Gak16qCnIDbof2t0HMDoTalv+W4Ezh+b6VdZ5nkiuL9q1Mbvnv56JP7p6XRTOFOIiLMmbif6Ob4
 WM+KYj/jBvKr8jf6uJ/ZVGHj8RJVE9bibigl+OgVDr2lx3k+7Y6RueGdTYCsBsbiO1bYtBG8aOq
 Vlon20h+PfpNOdjUZdDF0KvF01gmszxAx/8BR4w9EcF9WiHvDJcQhtuoG2zmsQnkJpiVUpzyBdD
 mGa/Km2EfF2GB4kGJt62C14sttTE4DkUsLmSL8hnXZ+kl6I+HgUZRgWcjmdCQ+W0MkIwRcsqAgJ
 KzOqi3xg6gDtCNFGgQRaCb4W+CxFjXgKvqmQ0UwBylwuLkaQ37Fx/fXLKE0inl8yj8rMk=
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

