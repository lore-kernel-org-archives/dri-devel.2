Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C56C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 02:54:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4963510E63C;
	Wed, 29 Jul 2026 02:54:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="MSo2hTQv";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17AB010E63C
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 02:54:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785293667; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Pp/9oUWPM2Oc0O6315AxDEK91+vaxZfRZJcfm8nE5eLl3tJHe/7LcwnkD4DoonEMszrBmJD86N/oflbmev0JwNtWkA8ESoMtvo1tc3ImbDtV3+r3fuvcNs9th1cKvKur+LZdE25cbjnM9ik2cXWNGEBlsd3sbPMS0wPZ7dPt3qo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785293667;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=nzqJgETVkBIGkNjZS88+/BocleoPmjMybUJQH20vWSY=; 
 b=bzRlebd4PSH1Q36Upx6GMYEqN0VnXPQ/eAPN7FpIYkkBap4YPwQl2FMwrZt8/nfZY0q1/ijHEpl3KeHJYVWFGO0I1RWVw+/Ej+TB2L6BJRoLt0VwLlhO8m5Te4rm0d/IJ6M9IL4zfAeqbCG9npKFmybpBNWyt387ELHppulFsKk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785293667; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=nzqJgETVkBIGkNjZS88+/BocleoPmjMybUJQH20vWSY=;
 b=MSo2hTQvZP8pQlBAe0sRjnucTQwetwKHqekcxPuAnC0ekjeOmWlW6B0w7FNxdIVV
 3EtZzLRMjafpGIQqY7HZQJRCclfHAk5v3UrpGOpwh0aoVaoFpRnvSvLUwFT9UCvMAKA
 lcf0j3Hu99le21YCG/Okc7JDDTt97SIM1e+w1D7c=
Received: by mx.zohomail.com with SMTPS id 1785293666122926.5285301459401;
 Tue, 28 Jul 2026 19:54:26 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Wed, 29 Jul 2026 03:54:13 +0100
Subject: [PATCH v4 01/13] drm/panfrost: Check another bo field for cache
 option query
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260729-claude-fixes-v4-1-01968f2ec77a@collabora.com>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
In-Reply-To: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
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
 Neil Armstrong <neil.armstrong@linaro.org>, Claude <noreply@anthropic.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=s+TFqnBLyffcvvRdt+XgtQK5ewLRucmgSP4lvTByoVM=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqaWtWN0HLlHGL0CkAzPddR428TrvtNMifhrHr9
 nHjsljOntaJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCamlrVgAKCRAOJn5M7lND
 PcOkC/9+xOPwZ/ZSZ0yQcXzzXv0RsoMjZv0OBoKV4XnpQkBku8jqjjFIcJLgsMa0VfsjGVru45p
 1VTwJqFjkH+w8caanMdfYWMwlRp63CeoukgjtLtUinG9QdFLUGM48uNvXH3tk4kz8xSQlYXGFUr
 uq2Jhkjwuv8vLLt5MKrvF8Eds2M5YW5a54EoAYGu5v38x1Q0iiauVw6BZhP9QJBAtqK88qyMoAA
 JFi/rRNGr3qfO++kjwANYbY0JEqsXmvyPzWZDHlnUA2BSO41pxDt57FCuKYXrQP9OCdB+MH6cW1
 zddRZL9IpTyCa3GO5nHfI5wj0XK975GvIB3UPOl+k9Cz5rcnofYEi/vMsKd0w0X2d6AlVp1Rsc9
 HGHZ99ve5PpGyiFKz3/eMNs0ipY15A78JU1GFcgICznxl+ZLQi5mVtP6ZlNYTZwUWkjXk90UxNt
 pX01VOc1yzvHEs/D+wNvA3PLJB8RCRgFknvgL8d8B87Lj55eFHl3XfFxHzE9VkTV1Iibw=
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
index 784e36d72c2b..2e931fa90da0 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -661,7 +661,7 @@ static int panfrost_ioctl_query_bo_info(struct drm_device *dev, void *data,
 		if (bo->is_heap)
 			args->create_flags |= PANFROST_BO_HEAP;
 
-		if (!bo->base.map_wc)
+		if (bo->wb_mmap)
 			args->create_flags |= PANFROST_BO_WB_MMAP;
 	}
 

-- 
2.55.0

