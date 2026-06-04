Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AEFCD6E77
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 17:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E119710E235;
	Thu,  4 Jun 2026 17:51:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Gx2C930r";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F32D10E235
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 17:51:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780594568; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WFEkvNJhWr8OA5A9eHrnWX1HyloaYBuJlg1jV1rAGItcaTA+C0LfBiLw9q43IeKkSHJDRtg/P6dPyl7YGE94oJKmDiBNL4fsWMVp+Z5l4mTEBA5wSSPW4cLW433QDmBsUhCPHNcKelPZMU3zvSySl7qbkusTDAns/OGej/NoVXI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780594568;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=SVx3YSeGNoK9OFNCVBZgsenk/LFwrUPD+yeW9XL5ug8=; 
 b=QCcvjUslDbqANJWKMNo9s1oQKOsCvgE8/ts7P9v/Qd1QiQmaQEeXeflm5OhOjJyhJV2fRmYYIZ5yn8QmNuFFt/8YotkFWLnGTXzmODLGdvf/kN+UnYS2dTDHIxUeD9n+G/VKGplcRQMxKVwr9FB3334kLFGZ7OqUoNQ72lZ3eho=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780594568; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=SVx3YSeGNoK9OFNCVBZgsenk/LFwrUPD+yeW9XL5ug8=;
 b=Gx2C930rXI0rdGHzzG/yo//Fk5W47g8/dAuWgRgYlO5e74HLrv5tNSzHImdn0o9b
 o1HFcEuE58nCdPScwg2QSnd9HFyUPHWtykBN2XCvforrIs4wESqwMTvILG0qWpvFD8P
 iyAJhFTRjuEl8Vu2Gr87z8hhggxuoGL9fmcA8syM=
Received: by mx.zohomail.com with SMTPS id 1780594565741374.28508656291683;
 Thu, 4 Jun 2026 10:36:05 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Thu, 04 Jun 2026 18:35:20 +0100
Subject: [PATCH v2 1/7] drm/panfrost: Check another bo field for cache
 option query
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-claude-fixes-v2-1-57c6bd4c1655@collabora.com>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
In-Reply-To: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Claude <noreply@anthropic.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1047;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=9+0Lng7EnO833AXhZvezEZ5bQLD345Soj/z4WXi6s74=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqIbd8zKU1kC0Okbhr/hPphCNr3wp5Hj1bSElm1
 yxpAGE+NXaJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaiG3fAAKCRAOJn5M7lND
 PSXMC/9/XMI4UgzgWJ5n+K2HbfxVCSZmrE2pCLux8UH1aHTbGRWIx+xI5zi4sNAGdOZ/y707q0u
 GYpBAeUWmBzWgz2XJNYBpVIDNYNQcx1mAGUBMoGkNeGtbec0evopcU81V9ozBrDxjKN8nwP4Hx3
 BYgwQPsvl5hD7GgxwljMssJD+ty2smf01l+/Hx4I5f7okg5ia5mfoAk35NEeB0Sqj6vBpZ0G2gn
 ssGY4Es8JSH2Z4O/9st6KaLUnAGV+1Z4Q96BTSOsW4SLgYZ0iUXiBeXPSy4OfCqT20BAA4iX7Wm
 dYhHt/PlkqZz5Or6UKb+YD+MfLQBoySY/EB15AbS+OEe56qMQnaC4KRmczG6jmBoAwzPJJwrXhR
 ZKO1EtNIlDHNkEzObwe10lENnzmZuojzOcJNwh4/J1toUls6e/r72L78uHP1FYWj57BWM/ueY8S
 EbFtWD2VLQaNVFzC3EFtZ/XCSj3bn5QNRmNRdysO72NZonq4yja8gybsYIsTSrttaVSRU=
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
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Fixes: 62eedf1ccba5 ("drm/panfrost: Add flag to map GEM object Write-Back Cacheable")
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 3d0bdba2a474..cb8e5015847f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -659,7 +659,7 @@ static int panfrost_ioctl_query_bo_info(struct drm_device *dev, void *data,
 		if (bo->is_heap)
 			args->create_flags |= PANFROST_BO_HEAP;
 
-		if (!bo->base.map_wc)
+		if (bo->wb_mmap)
 			args->create_flags |= PANFROST_BO_WB_MMAP;
 	}
 

-- 
2.53.0

