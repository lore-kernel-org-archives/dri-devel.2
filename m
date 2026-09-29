Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE58C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 03:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7331C10EC87;
	Tue, 29 Sep 2026 03:46:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="EgXv3KQ1";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AE1010EC7C
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 03:46:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790653560; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ky4GCNUO4J5851+oVeG/DeOslxYw8eE9xl6sbiuX8muaxjsgExYFSsyFVsqKssb9/MBMAEJIRW4SfTq+Xiesr8j9Mg8nQBa1uwWD4/ZN6TdSffJZllIr++qNU/fB+x/Co83VaB9idoi6QDu8L+glL1KrJi/nQlNNzsEgZePjhaA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790653560;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Z6RRS3cshQwsXc3rA/U7BvQ2XdAR4lAqGHrehoKydrQ=; 
 b=RF5E/lKnS6QcsVSz+nqqZL6krOD61pNhzu5pCEA6UZ2sDSZwzjnoPXuU6ZDdQOIQ6tkB7Nr/kpJhLkrMwdKrlMz8xuy3Vp0961wPdVdqerW7q8G5VdBcmspqUAZqI/0L1/gmze+RejddA5qLn4U+Xra5F9f88i/ae6F/Jct7Z5Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790653560; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Z6RRS3cshQwsXc3rA/U7BvQ2XdAR4lAqGHrehoKydrQ=;
 b=EgXv3KQ1meWQrd1GNJqWg/JLbm4+5GMKynLlHBmFJPSR8ejqXyZVo+LsEmOlN6p+
 4us9UhcyyNqprjqfBCqWPRmI7R7aRTOFWg0B9vX/042BjWFCOohc+1zQIDHamUVgs21
 EkXxou2R7HGtix3iShV9T/JBz9CBzTW57OkXF0XY=
Received: by smtp.zohomail.com with SMTPS id 1790653560565778.2981140572697;
 Mon, 28 Sep 2026 20:46:00 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 29 Sep 2026 04:44:46 +0100
Subject: [PATCH v12 12/15] drm/panfrost: Skip cache flush/invalidate when
 enabling perfcnt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260929-claude-fixes-v12-12-62beb08de207@collabora.com>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
In-Reply-To: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1716;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=t0pKAbH0SA2araO3s4z8ycC80JiA92CZd/FQ3/v+S5g=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBquzQu3mOhp5nT7B01MR760fkEsdIPNesrG46lw
 M3ba4BJ5kCJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCars0LgAKCRAOJn5M7lND
 PZvqC/98swrtH/HiTTyUrJPI2x6crLZJUVuVy1SKjSZs1nk7PA3ORhxZuPQI3Ft0VqTvtNmw2BP
 IO2Ox1AFehFpdbuHa2a7COuWoDFPxoBhIzPPy52T7o+6pcFI/qvffOHFWXcFh4HxJgMYkzTBcpW
 peRuaDCCcD2eBGWJVc6uLTuA9ASO1Kx9FLHUDxvzZOi14g+Ijts7YaKmNUmMqAHcJREsqzPSBr+
 eaamQd6DIL2+qcpCB28KrRDMtSDjVdXh4cLO5MsJWuy3HxSyBBjl7nXDj2BT3dZQKZtIpq1cot0
 bBp+HIe/4EhMmmfIKh5ATW/+5gzgdMgdPDLTqoSnbJ57oxWPzB0z+TwMeXEk1xUZ55io6LeZBhO
 vXMtBOmlSSfsdAnyTltD9BBJPRl5A8L4STrwiZGB19kALlMot3qUO0MteFIlW3aP0CMBZnkWC1k
 cJW2UFp/lloNqzVuf9IYYyG4rVM5vbrgH8PshN0y2YxjY4xilcoAQewap/yXY8RPoU9Q4=
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

The GPU cache flush/invalidate operation is unnecessary. First off, the
GPU doesn't read off the perfcnt sample buffer, only writes into it, so
an invalidate doesn't make a difference. Then flushing GPU caches after
each sample has been written is enough for the CPU to see updated values.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index f71534e741b6..ffc77121070e 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -124,21 +124,10 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 	panfrost_gem_internal_set_label(&bo->base, "Perfcnt sample buffer");
 
 	/*
-	 * Invalidate the cache and clear the counters to start from a fresh
-	 * state.
+	 * Clear the counters to start from a fresh state.
 	 */
-	reinit_completion(&pfdev->perfcnt->dump_comp);
-	gpu_write(pfdev, GPU_INT_CLEAR,
-		  GPU_IRQ_CLEAN_CACHES_COMPLETED |
-		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
+	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
 	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
-	gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_INV_CACHES);
-	ret = wait_for_completion_timeout(&pfdev->perfcnt->dump_comp,
-					  msecs_to_jiffies(1000));
-	if (!ret) {
-		ret = -ETIMEDOUT;
-		goto err_vunmap;
-	}
 
 	ret = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
 	if (ret < 0)

-- 
2.55.0

