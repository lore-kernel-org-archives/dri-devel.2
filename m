Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5193C5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B3F710E5EA;
	Thu, 20 Aug 2026 14:05:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="THnq/iTN";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E6C610E5EA
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 14:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787234699; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=n9h+BMFjUYQ5AyIND3sl6gtPVO7/LDeh7z3shNa6SzpbrXhpiPbRWj1W+H4RDRI+i1fRtflJPNA70M57srIQpLljWVsoTFsWGLGjIFNGQmBXVaqeTkb8FzIJ+SCB6L1aRdUmDyrH0HdysoVEX5gz23d9wM04czw9G0q3H04sgUg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787234699;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=vBB1ZiWeZecSr/dlfY0N1e6IuAZvR5xx85FQqKa0jQk=; 
 b=VH/O42geb1ZfIUTisqJO22ddNxShN5w3P6W6dVZl3BbElPXnFJg5c6+aFTPkwFseE1CApacG5goeRWYDiNhoombxauk/x9xeeyNI0m+C74T2F2ObFQNh5WiY3uKoQ0iVFtGo8PM16X2/b2vgJcnZRJkKnnDwxW4xtlM628ANu7A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787234699; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=vBB1ZiWeZecSr/dlfY0N1e6IuAZvR5xx85FQqKa0jQk=;
 b=THnq/iTNrKnkgKo9GkiIldlfy74XYYRsM5Q1Ku+5Y97OX5EK81yVTdfxw/CBFLSm
 FQ8DIdA+kGcAxy3ODsbsSZCfZ68J8o4JZJySudpd7zrBQPTaqhL70etToMnN/a9XEPi
 ONWziu7bv/sBIAYZomR4VLlp1wN+hiPnNKyKCWvU=
Received: by mx.zohomail.com with SMTPS id 1787234698306658.686336615282;
 Thu, 20 Aug 2026 07:04:58 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Thu, 20 Aug 2026 15:04:47 +0100
Subject: [PATCH 1/3] drm/panfrost: Check another bo field for cache option
 query
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260820-b4-panfrost-fixes-v1-1-1b2c2376f4bc@collabora.com>
References: <20260820-b4-panfrost-fixes-v1-0-1b2c2376f4bc@collabora.com>
In-Reply-To: <20260820-b4-panfrost-fixes-v1-0-1b2c2376f4bc@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, Eric Anholt <eric@anholt.net>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Claude <noreply@anthropic.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=ZBprAyeUpKUs/H+B8Flbv4e4xFt+EiXg+8q3SMXleiE=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqhwmAzORxeceggBezj9eXsR2KOiVSDjFJT6agJ
 hHfjRtcJACJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaocJgAAKCRAOJn5M7lND
 PVTWC/wPz40PTSmN7FTAd0sQj08iC0MIPQOipJqZmOtFWKOUyJjPxHQ6bT7Gy3TKsYcPBxAFOf7
 9q5w5+rNH0km/2sAVKad+Vddcb8SnH8o7pN7YdAheYGprH1cSgtMfDBg1I5GJIqMk3QMYmmK0ta
 EQsnzBQX0cTtYPOu/AGZXs2PdS6jZalbwAL3K38XqlscAycp7wOHrk9CutRhjy5UUizY4hSdwI1
 craOBU1VHmf1GGd2/tbD35UvM1qx08tZ1THSxQUW44pZ2qvxrAihq0qkifYYCgI9Pxojff0rMHp
 WapolPvuBBuYuoFfmPSojiy9bzi/Dz4NW31OCTIlP1g742GIfA6qtepuefPUqaPD3+F6Z/MzYiZ
 SVTF5XoF6LrzgD9yagfzWYxSIo6Ff4QkhDSwqi98PAWi9QD+YMZBV01+M5ITOsbF+M96sKSyImN
 A/PuRshvey6//RLFHbAWIwfUea37Ok87JY6b0/8PKaDU7xqGRI6eFBkg0v1GobYMKnXc4=
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

When querying the properties of a BO, whether it was created in
Writeback caching mode for userspace mappings, is recorded in a Panfrost
BO's wb_mmap field.

Reported-by: Claude <noreply@anthropic.com>
Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/88
Fixes: 62eedf1ccba5 ("drm/panfrost: Add flag to map GEM object Write-Back Cacheable")
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 36cc2e67a308..96a66d673ba6 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -662,7 +662,7 @@ static int panfrost_ioctl_query_bo_info(struct drm_device *dev, void *data,
 		if (bo->is_heap)
 			args->create_flags |= PANFROST_BO_HEAP;
 
-		if (!bo->base.map_wc)
+		if (bo->wb_mmap)
 			args->create_flags |= PANFROST_BO_WB_MMAP;
 	}
 

-- 
2.55.0

