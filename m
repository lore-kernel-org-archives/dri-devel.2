Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B962C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66E5010ED9E;
	Tue, 11 Aug 2026 21:43:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="hnzyvL/G";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98BC810ED9E
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:43:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786484583; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ed5yR3u5II2vqmvBubBu/NMJNZLngZE7vutYK/ivc4bRfeJ/DZg9IyoPk/4jZskO9bflypPJ+JIKi4IxM6YIXzYLKRFNxJkGyKJKnQk3Q3oKNphLgwQ7w1PFJ1a03jDsW1NmtIVIN1hr7LLJ3IZwow033b8LfwfkX3ezBGwUObo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786484583;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=BP5/wAbs63zBetMW8skc22XV1Xey5EptZ2k+GBHOSS4=; 
 b=Hg8e1CFEQfdN/kzlNKq8GirNedhyirK9aSm1g+KDC0LvMKh02dwY/9mOMkwLAsRuseAG37VpVt4YCt5LszqSi+JyPKKjmipqUh89xr1PLthjcURo+bCufrKrm3muUg2RowYolAKuFDYv6fXm0tsCCc0buk3VT9hGIzAk0BiiPwQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786484583; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=BP5/wAbs63zBetMW8skc22XV1Xey5EptZ2k+GBHOSS4=;
 b=hnzyvL/G/E8Uni1Upd60g6O9BZ+0aHHvRLSDjrLfawWy8bHuuVwZpZcNfXqEF3ZY
 fsY4nQiuwgzgDMOYvIGxfQcBFPpoGJJ2MX8fn8B8tlJ7KivLtsLLFzGESqI5j2iFBkx
 dh+B7CInO1KFmELVZzywjaFek3AgostAcYdLjBwo=
Received: by mx.zohomail.com with SMTPS id 1786484582339924.592413227084;
 Tue, 11 Aug 2026 14:43:02 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 11 Aug 2026 22:42:17 +0100
Subject: [PATCH v5 08/11] drm/panfrost: Move perfcnt GPU disable sequence
 into a helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260811-claude-fixes-v5-8-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
In-Reply-To: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2779;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=4tGiJGWiK+TDM+P28WpbzF6ffBP1X3E56TrK7Eumeb4=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqe5czuIqa0ef3PWXJjZNDgQd8Dey54R+0oMmew
 EpwCKc1kLaJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCanuXMwAKCRAOJn5M7lND
 PSbhC/946iwnv3BPDbKotWayfvoASDTh6O5zbGM6TQbe3w+mvT8wR0dphJ4hc06byz5jfuLvR8y
 RHr6AgIQkihJP5ST2E0rEQe9ihONR/rgp/mS8EDCm0IS3ecmcxUJGfYFv61Q7GhopGaiwBvXg6+
 xG7DmRv7i6EP+iSwxeOV7wO+NjepR6bgmG6pZWuTasobP1RIo0FdpXVzTSTVohpoZWqFpGOKT0c
 ZDXRzwjyRaU9Yd3pSyr7PM0nB5qHiTte1ukEzkIYjeYL42XM2jx85F80h6pcGXFg51RIB6sbW61
 B6oZi+G/OVA7LJyyOoXcGmfDdliEQknhxfD4gkvS/7Lwgl/UcaBwdYuQ6hWXCon7M69TUx9cLWX
 yu1Wkte/LKUvKVHoE7jGa8VPorQcN+I21nbccyNiqc6O8ll0O9Bp7YW5y6WwxCxVBq9p/Si0E4H
 B9K5TbO5pUGPqE6o9DF+iiO1sELimG+Y1g/QlkCgyqhV4fhQSQecIEufsYGu9kW74qyxI=
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
index 7020c0192e18..ad1156678e91 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -35,6 +35,16 @@ struct panfrost_perfcnt {
 	struct completion dump_comp;
 };
 
+static void panfrost_perfcnt_gpu_disable(struct panfrost_device *pfdev)
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
+	panfrost_perfcnt_gpu_disable(pfdev);
 
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
+	panfrost_perfcnt_gpu_disable(pfdev);
 
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
+	panfrost_perfcnt_gpu_disable(pfdev);
 }

-- 
2.55.0

