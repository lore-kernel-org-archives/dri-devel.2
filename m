Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA2EC88E45
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B11A610F72A;
	Fri, 11 Sep 2026 23:29:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="AH64ocd6";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB26510F723
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 23:29:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789169349; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TPMelJTUG810JK3sbBYolGvyfnyA651d/BNyZC5Qu9ujabShuDJWTGgOebATsCSKDHILhyHse55nc2twqc5zBzFcl6Kk4vEK0Gu3zztPIgXQt8a9kvSO1nwAoijhbAHnFEXhXaE24gHvbNUm+uyPw4ZonXnDigVvV2mo0H8SzdE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789169349;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=nWV812BLSXmGL2bwlh63A8Rlix0yVVzCrVgfDvlUkzI=; 
 b=W8P6BRKfcjyRlPmS+ppyz8guiDQYbwbHKaewlfe6rdNIQTtbDUUAqsu7SBeYcTmkpkyjYWsLhkS/cXRjz95r3KdFS2aLnZTqfClxnPi1OuFfwYxpx9E3bVFzY49GmazpQKqftmMzQYKm5zaM7+oXjFYov+FP5z8zriLff+hkfCs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789169349; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=nWV812BLSXmGL2bwlh63A8Rlix0yVVzCrVgfDvlUkzI=;
 b=AH64ocd6ltkFvFkVITmHKwRf6b9HazelGEHDSxGNqJ9EmJTA5HdjQLf/sgmkqRNC
 jakPEZT5yPbTM63fqtMZiB48lv5XApAxU0lR2F9H0uaM+a+owjYzsXsddExJbFSJsHI
 cti6BJbIPwn2hSMxFyU+OoHPbra6Xn08WYy8zeJc=
Received: by mx.zohomail.com with SMTPS id 1789169349704614.5595874503224;
 Fri, 11 Sep 2026 16:29:09 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Sat, 12 Sep 2026 00:28:13 +0100
Subject: [PATCH v9 12/16] drm/panfrost: Skip cache flush/invalidate when
 enabling perfcnt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260912-claude-fixes-v9-12-e588feaa61ef@collabora.com>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
In-Reply-To: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1654;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=F0RVJv4zmQDLG69ZrU/+60HS5v7NarQ+E2qnB8Iq9Pg=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqpI6EfMjxbPaH06sgCd7D/dLWfIwUp47yPv9Of
 1VpqDZXvmqJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaqSOhAAKCRAOJn5M7lND
 PfSqC/wMkl+L0YzsSbNxDSiEj2yC+MXjiQ2n9vix0fDgQFGczKslb1LT+KDoIvK+TI0hQCV9wZw
 dur7bHbwEmEDIJNjCtHA6bSV4r/15dvNlXJcybxMpoGPee6IqltYyaQERTIZRS99aKpiwnGvQgD
 1rhSSxRBWo2qgyIIPgtXDzkkPtkEFsNam5LbXblw2vajDC5sZGs+acoAOx5+m9xGbB4FvFQDpeC
 MbdlFWdb7uoH67fLLe2UvdrmzP4S6TDTP8fee/oXHRlEhbiu8RiK2luBZ9IlxJyeTqq5Rac3bOb
 bWWN4lwK8s8SwBmBhLlWBDd0a4V5v272NlBqsGuf0onVsRo/MdbW0O7pxtcIVEuvLNM7pe38VWU
 4oEWqWozFimHEYpS20VvdPA5RwU2eHo9Hw0cie/G7gTMlNfst8yu5elXtzeLJhKjcw442TtHg4K
 XN4JN1MUwMFctjjBEju4MaKUR2V3kiIPyrEVFahZfxg66mubKA9EG1kuSnWSGOTkIQRAc=
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

