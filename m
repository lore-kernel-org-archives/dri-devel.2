Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3704CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F4F410F18A;
	Mon, 12 Oct 2026 14:49:01 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E53310E5D1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 14:48:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791816530; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VWfcLbsOi4B39gH9aqmIUn1YAx4fs67w4cEsAhxbMCGxg9bM5PdZPVCiQD1U67NAE1QIbTaFbjTpfxKLPwjhefM9Nm5HgrCrLnrof3IS6B23jFQnjsmjr/N7FOzgNiys4MFyiI6xUeU0CshYPLqtxQgu7DiabymE1tkchUC+Wv8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791816530;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=2nQ1TX+5x9cuc2w92LZrFtQlD1LLotYmanIFBBwFcIM=; 
 b=ekbF9U2SOqSH4uLYgKC/mDrCaIYe69aCUrbnaMG0FT+F4CTfGAoQYw9zVw/Std1/HOpY9C5hIj5+6hqNuzH1C9M0xSToMLqjzAN4eeltqxF5l4zgap/FodAIE4z6mNuU7sCo/eNrqrB2cX+yyabOLdprmTaHfkABoOsWs0FFZYs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791816530; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=2nQ1TX+5x9cuc2w92LZrFtQlD1LLotYmanIFBBwFcIM=;
 b=j52znOYiE5tRqrYRzp9MKJUACWH2QyKdx3ZIPB/C4YspQ0tC4unTJeRVuBCiCUF7
 g5l/u5QX1XBEsPbDPhJCLjh18NwUVnHS+8nYIMLk+ehpQ4PgwRPxtV3b8GSWTKaAMrJ
 o0FIwqX63dN+OnKIdQlUbJ02YJyBtpb3QBuZtLp8=
Received: by smtp.zohomail.com with SMTPS id 1791816529194709.4607257124592;
 Mon, 12 Oct 2026 07:48:49 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 12 Oct 2026 15:48:01 +0100
Subject: [PATCH v15 09/15] drm/panfrost: Warn of RPM get failure at device
 remove time
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-claude-fixes-v15-9-bc0a6c498553@collabora.com>
References: <20261012-claude-fixes-v15-0-bc0a6c498553@collabora.com>
In-Reply-To: <20261012-claude-fixes-v15-0-bc0a6c498553@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=ibqQrytkwD4dZGH6qzBtr8PizCkzDsq89TU6EwA853g=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqzPMa2BsSvslULVxkJ/r0QxpZGiBeyYlrG9g4f
 Wz8YTbPWQ+JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaszzGgAKCRAOJn5M7lND
 PYwlC/oD7QfjG0brIQ49qFvx2tc+8h75rFTi0CTI5TcxkzUcgtPzvOdOCiKUO/YwYCL/jMcGyL1
 dE5du+WW0Z92h1iR0WpTuhkEs7P0lg07xB4Vvpg5CM+GE1qOuNbRfL5lrXQLjX4ApvGtV5Tn1hx
 qt3kp+NFyV78xykGwfnEO2yv0TPPSAWUIeny1C0BNTC72ttIrD+YgFweyIUhHZMbpgJ9sOkvzAn
 qHWLaWVOiU07exnlRn+G/3TEbgd4Mr3m3qs+2HGBHnWJQpg9rjjqIjNSPX5jG0LQfmhCauBStJ9
 ZQM6dByIujHaCYfwvKToECCtkz0H5qIHbEZ2kMKxmsxMuIgzkJmuwTWN2TkG57Ys0mfL+zmdjQA
 c1qoNraucQTCMO7z1BDB4/HcW72K++1gqwUi+QTR773sCENL7ZFv2ddASgRFSiVzuL1V5f+tr0p
 WvT6yw2lb3N/5PtD1VBiTY7sMCLnuWnxDlmPZ5kQ5UoGUUMzggy/1lUKI8bhgsbBR9sDk=
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
Reviewed-by: Steven Price <steven.price@arm.com>
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

