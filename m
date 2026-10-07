Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C0DCA6009
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 23:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DB3910F853;
	Wed,  7 Oct 2026 23:44:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="VwH87YPV";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A29E10F856
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 23:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791416650; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mdqc0DGAvmwr++B8TNemVMswmPXdDWiXFhTsUWxWrvKHQmvGtrdv+RaGoFOl4YNrkzQln1vPV/b+B6KmF10qmWjgL9KaiBKlQoWEDwaMKACuJsYSlz67tTq5VokjGQa+PcKbSETPHcIZrdfSY6n2/1ElvM+hHRk7//cQvkdUhpI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791416650;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=dDjMh1GirSnCP3cCmJwz3WFUErTlegEWrnDqmZwHstQ=; 
 b=ZrcsFtI6lRExPWNrYoXtIlg7RDgkRyJ16i38fJ3Qz9SGKxTuU1ooIxL6TyLNr5xUl9RAZYVRYKzXi+gQ35O+kKAy7X9b5+PqcLwvYrSGUJoVNZitemS3ZS1UgkLv0fGLLeUBAlhgV+RxfpFYrZZT01OzhKZQnBzzK5L/WiCD0SA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791416650; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=dDjMh1GirSnCP3cCmJwz3WFUErTlegEWrnDqmZwHstQ=;
 b=VwH87YPV9gxb+OwfUm7V0Ai+3DJOvSFJ6ru3Kp8cG9OhsTLY2vak6pXjh3GDZPE0
 4ZVepiwrvzD3xuxiVwQhqWyaCZyY93Tvr/YNPMeF1QF+9s2132Uf/IBLLSKDREBBrAj
 sGirbynrx6ppjlCOrY3DA+s30ImCUciGOjTpJRJQ=
Received: by smtp.zohomail.com with SMTPS id 1791416650058182.62940927185343; 
 Wed, 7 Oct 2026 16:44:10 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Thu, 08 Oct 2026 00:42:55 +0100
Subject: [PATCH v13 12/15] drm/panfrost: Skip cache flush/invalidate when
 enabling perfcnt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261008-claude-fixes-v13-12-d6a493185860@collabora.com>
References: <20261008-claude-fixes-v13-0-d6a493185860@collabora.com>
In-Reply-To: <20261008-claude-fixes-v13-0-d6a493185860@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2207;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=zj6ByHcx9EXAkKLvo7VN9yTxNWqqlfy+DFuHpA3MNsY=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqxtj7qxaHMkMdY/KzxtZEZxOdYCcJmAOR/q5BX
 8mcssEIe7OJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCasbY+wAKCRAOJn5M7lND
 PUzMDAC3nuzfcWSy9SJb7SrOkJx1exy4B2yKwCCHfQw3UqlSrim4nYCFyLcev/DUGpsEgKGToPg
 lpKfyL/lDoARDfrqfHafNMzWtcOTgym6P6RTeHCSGDtcI/IeoXXd5T/emCtkDCjprvG9Ll4pxWB
 FTf5BpaefumUMdcaSo/r7hw+pyxJUaNagjGvggtIuPmYsm81IACtDA0OB150YqV5uMSb0ZXj8/c
 /otpyMgpO11e6oGSXz8T8FddeQi2YGLDOSFEPEgs/Fooi0cd7ZY3Osu3KFXaMZOXqCioBUfsGbm
 +MQMynZDG+8DTF0x83RvHrt1VyzVBTtcvz5y9GOGIpWBOmEX8Pci4sF3VLj2TE7vvC3HTsplXbY
 cXQxYxMktX6tnfUmCOfiqSoCphbTAlyWWTJb6colGVDLQV4tmgfnABukHSRse7mx68qvbaR0UjO
 73VZdeuybzGo/Bgi6v5gI4UDJol0gCWnev2yXelD72HPL9I0clIBuHW0WWP773ZjX1qO4=
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

The GPU cache flush/invalidate operation is unnecessary. In the usual case,
before a perfcnt dump is requested, there will be no stale lines in GPU
caches for the sample BO's physmem pages, since their memory had not
recently been addressed by the GPU.

However, in the off-chance that the sample BO reuses memory that the GPU
had recently addressed and for which it contains stale lines in its caches,
there already was a FLUSH_PT command being issued as part of the buffer GPU
mapping procedure, so by the time panfrost_gem_open() comes back at perfcnt
session enable, stale GPU cache lines should've already been evicted.

In either case, forcing a GPU cache clean when enabling a new session makes
no difference, and removing it simplifies handling of the error path.

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

