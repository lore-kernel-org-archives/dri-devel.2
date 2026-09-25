Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C07BC98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 18:46:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9277810FC12;
	Fri, 25 Sep 2026 18:46:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="HMMIiT+K";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 751B410FC13
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 18:46:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790362008; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IHBN+csVUTg+279zawL3cDeSj3I+h42I8zWI9kaGITyxdWn4+cv1rTSQbVbluH61s1MFC6NdkIjhydjkJs3plN3O357J3vooVKP2YpA7nLLMLcHMb0COkAndsW0hO7Z8gZF2r+ZnNUIxhLYsrH0tZK+SGiSPugTBRrCbHFiJ/ns=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790362008;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=rne2vTyla1RUI4gVDThBMRFsSeWjoijKTX5hYO0ZMA0=; 
 b=AfgsyxHVwiQc0jlp5sarzRtiMBTck5vruXW8BLi+Tlt4B1LUy638nLH9w2SLWkCZrgiNoSZpeX04BrtctjFsfI2H549C1i6g3wCKuF2FB424X5kKiu8/sHRJwgf+6nyUhEQBZjZlSELZDccy0fe/jEg21Kwgt73+WBeU3Oe7JdU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790362008; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=rne2vTyla1RUI4gVDThBMRFsSeWjoijKTX5hYO0ZMA0=;
 b=HMMIiT+KAeVfd7YnNqQC+6YvzJYbNvd5JYO9aCA+JN6v0UFwZX4R+5efmMLwP3gG
 QipkuJFqFmrljhcYnTano1mIDldr2gjaP9pXRmcdBBq2+ZwDZwaNoyr764z4a9kOR2F
 apcMuUQfXB8H5736eYq6l8rnuYgvlXurFB6kEs1Q=
Received: by smtp.zohomail.com with SMTPS id 1790362006274552.8530406652147;
 Fri, 25 Sep 2026 11:46:46 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 25 Sep 2026 19:45:34 +0100
Subject: [PATCH v11 13/15] drm/panfrost: Avoid cache flush after perfcnt
 sample in fully coherent systems
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260925-claude-fixes-v11-13-0dbf5a58e7ce@collabora.com>
References: <20260925-claude-fixes-v11-0-0dbf5a58e7ce@collabora.com>
In-Reply-To: <20260925-claude-fixes-v11-0-0dbf5a58e7ce@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=ylClgdA4qjN8YjgAXTrojrPeuTeRxcjN/yXHiltT8+A=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqtsFEAvavFHQhpg2ui1rPxkirqK1B1MSHIvD+Y
 QpvGaqA2NKJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCarbBRAAKCRAOJn5M7lND
 PeJzC/4+J5fRPwiul01r9JmRKJ5FWp+l0n9rLaXujhXp1BGHlcJdhPh2gXBXY9qZ10TlQbnCJN4
 wctGmkmzvZZr7Q8uVOLbsPFTVWah81LA2auQN4NP4xM2muAl5SNp3vJYDvZQruoi/9Xy8290rTz
 6Hc/KK3udAv5IWp+EOoeeZqLWHJQmKZEyPbior738UcqY79l+xwsjmsBhBYmJm5vB3p8JHyWeAs
 nbLAMtI/dcxdp8lO8y1sTRbU1AYIh2e5ZU04XEI4xG07ZJOQEjUxNNfb4JaKweDLsikKVpB1vyp
 LPe3wYI27TCplW2o7kKi8p5EDM3qx3Xsh1t5e3VC3GcpH72ekUUFnVJrqGo3oqPMVOi36C2tM2n
 fDIPPyWWCR7yugcxnpShE6WRj5IRI8a5zOGh6uNUpGkCKT9qfF45F9D+VpVUaIYGg9XVJ3bYOda
 eE5AUaX9W/7nYzXx64s/vm8H2R5LbCu1IPs7f8C8RiC1wK0GR8CXItHQV1WRdY4U7wlmo=
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

If the GPU and CPU are fully coherent, then there's no need to flush the
GPU caches after a perfcnt sample is made available.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index ffc77121070e..b3f71d7fd82a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -52,7 +52,10 @@ void panfrost_perfcnt_clean_cache_done(struct panfrost_device *pfdev)
 
 void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
 {
-	gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
+	if (pfdev->features.selected_coherency != COHERENCY_ACE)
+		gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
+	else
+		complete(&pfdev->perfcnt->dump_comp);
 }
 
 static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)

-- 
2.55.0

