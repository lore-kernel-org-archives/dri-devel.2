Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17524CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 12:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75AC2112102;
	Fri,  9 Oct 2026 12:35:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="jZx046r4";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FBA7112106
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 12:35:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791549313; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ShplFDoY7nfVV1adudbhlXPu/gIA2HEx1NmXrGFV2QsbbofVhFYycfe3d1zfasCgUkuFSGCzgjWQG5PJx8WHsC+n/fajrv5pshBQPjKAlnAIDZ9ZU4ZjUUtp28GVlfWYNeMz0+DWDTZIdACdAoj4OuSOsEJrv0VcyTa86jozlGU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791549313;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=n7LLmX7fwJoNAhkMWdIEr6M9fWaQ3kE6c5cMXkSE36Y=; 
 b=EUHWJXiy4NqbIP7OAHj9YcZoEWCw12FCFy4HwqpAwtsRA3v/TlPau9EKJRzPjDGEp8dvAME5zQ3OGWwkoO0Z/6OLRFUwz3WzzOcg11I5HQ2QOdszLAbcj+jUHjPiSCAimHfKDCulvq/Wbi+o7YywJk1NGzBUuUBUnzNrA5ssDKk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791549313; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=n7LLmX7fwJoNAhkMWdIEr6M9fWaQ3kE6c5cMXkSE36Y=;
 b=jZx046r4SuLmS4dcAj/HodLVmgrThiA0GCrKRJw6TjE2qxkFPZdi+UojkjVQF3nx
 MeoNQ7VWb6anRfh6Fv1V/h55cKotK4p+AHzJcpZA1xOx7NNJqd95QMEMOiJvOAMqmdB
 2Qkilstwx8jfiaXr+ES42zsFoAje/EMVBgqAwOFc=
Received: by smtp.zohomail.com with SMTPS id 1791549312696379.3766326351831;
 Fri, 9 Oct 2026 05:35:12 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 09 Oct 2026 13:34:00 +0100
Subject: [PATCH v14 13/15] drm/panfrost: Avoid cache flush after perfcnt
 sample in fully coherent systems
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261009-claude-fixes-v14-13-cb743b3b973b@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1138;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=n0Xb7x+5EOLF5WqM4LToZmyqgsrYoh+WYeTYPUQjIWU=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqyN8vrETuuJy2W1OhPWRZCITy67Hx9giocPJUf
 KN9MjKgAdeJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCasjfLwAKCRAOJn5M7lND
 PT20DACF4V9mKccFGk/hMOqlqlNkZ0dznvW3CeJAnJ2jN4TGH7lS1PGdwYieU6KX6KqNaztr2/3
 0EVQ/ApRn2FFWBUa9Ifnbmh0uUUZqBy8dNz/8lvn4YN0cWuPXlLvOUp/ZuC+3q6H9jrSp+yFw6B
 giaWlzFFv42+SqqrNytD8Rc0S9S+QPHWPuh4LqTk/IhnfNhC6lv9Ssm/W5OXeFjAetgciodWLi0
 xQvsPWhriW+lWlYuYZ1ePIluAE+DUTSdBXxPzKNpYF8FoGfRxK/eKN2Ns8mEbUVRnTcJ+lwfnE5
 +wAvwuFUL48ZoderZmltEik8gLi0uG+QFXZfL/Z2U6rjx3j28Qzdyg3YBVN2pALXfn1mLJNwb2s
 SNNJI01z5fF/wsdSXjsODXAxZxT8nT5RJKCxAfX5Rs0qv8EY1j8xXIzMiud3Szh+k/6mQStUjk9
 rVt7P0iLqOh/y0fDFDi4KV5nQpjDE2D6Bh3il22wWTfOAOl9tLJjWroQlQ8nVdWiuzhus=
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
Reviewed-by: Steven Price <steven.price@arm.com>
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

