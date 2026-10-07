Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6CDCA6009
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 23:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 990CC10F856;
	Wed,  7 Oct 2026 23:44:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Io22JLcj";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A1FB10F85D
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 23:44:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791416662; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KXaSXUMpSCnlBDjFD8CaoRQGxlilif+NdzqNThxLncA82gKxX0RiAq9hJEokm9QllapaY/KuG1CWj2yukxdm+gPoSg+6sZOWhJMuGR3RebIunOE1Mk6J63qDF6ScZDeps4UCeK36ImYSmI8yuf9CVzumz/7REy93CHRcoLgilL0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791416662;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=n7LLmX7fwJoNAhkMWdIEr6M9fWaQ3kE6c5cMXkSE36Y=; 
 b=VOoE+h46LZl6JiG2HnkG8TuMYJt8lJxNxKT8qdEBfSQoXmYIcUpMJqSpOo3jPWcRUorPBXIgMdHCmcx3FvtT9rN1hZYd9P+YG6WiECKbcvJdwEmbmMHbPOAL0vrbctDRDxkajkxSiHIKcZHCZ7RETGj+wL3PKmQ20gdRXymAOxQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791416662; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=n7LLmX7fwJoNAhkMWdIEr6M9fWaQ3kE6c5cMXkSE36Y=;
 b=Io22JLcjv8NPm91kqygkrOjAwh/A0WXfKRbVMhDC9ViWDw16nuB7ksEaA4eDBmSL
 FVVSjL3CfWcU8W8jZtqdfgNGnE0HAMFv8l0ALPPYbnQGmzz/yFz4TxDuv588MU+pP4f
 Wk9Ds44rnTYsCFIwm3VfMEKmKAbvHxvFEqWEuAmw=
Received: by smtp.zohomail.com with SMTPS id 1791416661857122.55679282811354; 
 Wed, 7 Oct 2026 16:44:21 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Thu, 08 Oct 2026 00:42:56 +0100
Subject: [PATCH v13 13/15] drm/panfrost: Avoid cache flush after perfcnt
 sample in fully coherent systems
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261008-claude-fixes-v13-13-d6a493185860@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1138;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=n0Xb7x+5EOLF5WqM4LToZmyqgsrYoh+WYeTYPUQjIWU=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqxtj7x9r5YwZlfb1lC1ekgh4V4OwmA19mKPAWS
 Wz1toGN0laJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCasbY+wAKCRAOJn5M7lND
 PVngDAC0EctluWOuihS+irzhEgqqKjWgBIS1Zbm/+OVlSL/2VYGHk+YMB/eaXrB1uS7DE7jBDQU
 nSVpV2y1l9+g/WG/nrkiekmVvRIJipHHmql4WV7jK/H3B7ah9JbKzVY6QUnVUhc3KjJ+GXTUq8M
 TrKscw34P7W6eLwFnTcB7Ekz9FXFYl12yTCDmIsYIRpjsPo79iPCQQlnf0vPtLZOlqhJT1HNsPG
 6f8qWWCBIfz5ZifL1yZMcWrWuSDeo0Tfs00+qvAved7EXW5PQ37rF2+lypl97bgHL6TF/+pbbFe
 m6WHQFaOqMicvJGh3KNSppxhV9JAcBi9jK9ZFOHCIrqliwPHftGrtO8DbIkpz+5off9yGMv8i7N
 Hntwm22PKpv2T82w30jCHWMSrnZJF9vclJTvPJJpX99WlZlzt3ODye/Uc3/muPRB2Ag4Eul95tu
 zLOZvcIfnEx3HI3oOYPU4MwirEeEP17a8RRmn39CVDMhHP++KJASZizAhDhn7PZ0qrYUM=
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

