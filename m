Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6ADC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 20:17:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18DB810E8FE;
	Mon,  7 Sep 2026 20:17:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="ivwPVqYJ";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECB2910E8F9
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 20:17:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788812259; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GMtUKTtttRh63fjJaZYpIPxB6MJ1JebYp5J1i6B6OvOZqW47MV3FriI7QVtJIjoGK9K0FpMPusuxi82SS1rHsts6e2u7mAEvDzcpVjbArVgdY0oQ+qs+Z1NfPTA1jipPVqCatbHnMGWW5RiKgeUl14geYY1+d0rrmJJv7Qg8z/c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788812259;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=3zLgjT3JfLXHkpzJh4PbWNTcLr4FUqsFF57+vQ+BFbA=; 
 b=GAVTaR+TnJp+1P0+qw03vBEnP3vG6DwrGj8NvYFoy5rvawMgnjNPEPU4WtQ4sF0Xsf9iV3p05z+DkOxsZ9+xxapqX/2olcKqyDQlY+ptjYpg8dVS09VR/2Ba5spZQfk/J9FoIjcz3mUqEO2j6Ei10lGzbrtmVYwY67l19Nw3vlY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788812259; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=3zLgjT3JfLXHkpzJh4PbWNTcLr4FUqsFF57+vQ+BFbA=;
 b=ivwPVqYJnSTj3y3GmkSv6ZJT3pdt7kCeBDaKfqfXkSM/3JuCS40Oyhmm4d2fjry9
 xr/fTf/uCjNYGgMqmFrtTXLITOM7Yj+4o1Mq0owVcO5DUFFNh35eP1UvwB29v/G4IOp
 04+YO/X8fWuWICSM4FLZcw92JMPsEl3Tjlg7zyrQ=
Received: by mx.zohomail.com with SMTPS id 178881225815759.26404361009304;
 Mon, 7 Sep 2026 13:17:38 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 07 Sep 2026 21:16:20 +0100
Subject: [PATCH v8 11/16] drm/panfrost: Move perfcnt GPU disable sequence
 into a helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-claude-fixes-v8-11-c2bcb5e82184@collabora.com>
References: <20260907-claude-fixes-v8-0-c2bcb5e82184@collabora.com>
In-Reply-To: <20260907-claude-fixes-v8-0-c2bcb5e82184@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2775;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=1NC6JbP9YeSjejJ7XZFftPMwKC3c1jXoMn6zNAHeTm0=;
 b=owEB7AET/pANAwAKAQ4mfkzuU0M9AcsmYgBqnxuMiTt2d+wImlyKxEtoe6rsa7dwdgxK+Jjf0
 b+M7/B32i+JAbIEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCap8bjAAKCRAOJn5M7lND
 PRvAC/ikslosiDkvd42qK1SUtPBJLBi/k6/w9QMrP+9yTSsv8/ZwsuV1W8JtinLe4z+5IX4bQ4K
 uXjJBr3Rjq143VWs2sAqUWPYArt3n4bkfGoZrvear+6CG2eX2tKjxBeaDzza+Eyn0FgedBwXcWr
 CxDHqYuyYHVgMxQf6lhKxJZf7ISQj+v7/CnhmkFrtYX384uDIGKmFHntTorjYEH0vN6ZvVvL9U/
 tgv1/116Kbj8zoAVyATjvM1nwj60PukhpvrCc8MkzwL5sehDfT8nmfghCI6fGWJjHPXFtMVY2+w
 ZOlFYJNRW6/HjWR+OAd1SdvAnlECoY3LkIkYBzDcJyWs48iEj5RFBvYCa3TewOFgWmka3tO/rLh
 oFZgX1wFhDYHiDLwH1jzCcAwH4EXEiRZEA7S91YvdOBmT/qV/olU1QQE2Suokxt1yNWR+PLcK70
 soebv0OSaNALZV+1vekPdzAZ2gfSy+PHSKRX6LteHbIYL0wpiDwLzwpOqG1ZHEiEdfYA==
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

Just for the sake of avoiding repetition.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 31 ++++++++++++-----------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index 7020c0192e18..f71534e741b6 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -35,6 +35,16 @@ struct panfrost_perfcnt {
 	struct completion dump_comp;
 };
 
+static void panfrost_perfcnt_hw_disable(struct panfrost_device *pfdev)
+{
+	gpu_write(pfdev, GPU_PERFCNT_CFG,
+		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
+	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0x0);
+	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0x0);
+	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0x0);
+	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
+}
+
 void panfrost_perfcnt_clean_cache_done(struct panfrost_device *pfdev)
 {
 	complete(&pfdev->perfcnt->dump_comp);
@@ -193,12 +203,7 @@ static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
 	if (user != perfcnt->user)
 		return -EINVAL;
 
-	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0x0);
-	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0x0);
-	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0x0);
-	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
-	gpu_write(pfdev, GPU_PERFCNT_CFG,
-		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
+	panfrost_perfcnt_hw_disable(pfdev);
 
 	perfcnt->user = NULL;
 	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);
@@ -327,12 +332,7 @@ int panfrost_perfcnt_init(struct panfrost_device *pfdev)
 	perfcnt->bosize = size;
 
 	/* Start with everything disabled. */
-	gpu_write(pfdev, GPU_PERFCNT_CFG,
-		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
-	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0);
-	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0);
-	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0);
-	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
+	panfrost_perfcnt_hw_disable(pfdev);
 
 	init_completion(&perfcnt->dump_comp);
 	mutex_init(&perfcnt->lock);
@@ -344,10 +344,5 @@ int panfrost_perfcnt_init(struct panfrost_device *pfdev)
 void panfrost_perfcnt_fini(struct panfrost_device *pfdev)
 {
 	/* Disable everything before leaving. */
-	gpu_write(pfdev, GPU_PERFCNT_CFG,
-		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
-	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0);
-	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0);
-	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0);
-	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
+	panfrost_perfcnt_hw_disable(pfdev);
 }

-- 
2.55.0

