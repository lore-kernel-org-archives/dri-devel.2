Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546BBC61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B81910E37A;
	Wed, 26 Aug 2026 21:19:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="U4IR34ZG";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2CCB10E37A
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 21:19:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787779174; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dzDf/A6gDYd86QvQ/MfLWanWD7A+YpKvRu9KMVTjihz86R+0C+3EtsDT1Nc2eyE8sQSw5cumOMRxTr0nUQsfZ7EVrRZNLm9Mm64Cw6lQc9w6dj1hBpd7vhCgDkmU66RiE9U3TFQrwbUp/fIxxiLlKF2hSdW+EwD4cupcZ/KA9PE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787779174;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=g1FXZ9snXF2f2DkW+ebuDO+prz5XwthtDAwYa3OAmL8=; 
 b=K8HSN45vLxShZtS3+gFRmgcLap1dW/smpGitQ4Ps3f/F+doyVb6hlkg/iLc04wrIp6asewG2BvTU2Ou998Z9AMhoEbl3qL+6iv+ohX9Agl2yQ42eAVlArnQR19PdVGpMKAYwrOQ/bRMLcYThBMN0cwSkeS7cgvB6XuRiyClvm+w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787779174; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=g1FXZ9snXF2f2DkW+ebuDO+prz5XwthtDAwYa3OAmL8=;
 b=U4IR34ZGyI1N6ji44y0jXPyikPvzwifLqkPIpWoguLDYX/Lveygh+TWhHVTA+fcC
 392cU31brC4wKSf2JkdDHHSNYjAix3P9jCondFUXny7auH4RXGuWX/gif7ft2ZES2AE
 y2QC+caMgiv6J2tofla5CKcd8ZCSqvd1L7yC1h5M=
Received: by mx.zohomail.com with SMTPS id 1787779173167251.50782691295262;
 Wed, 26 Aug 2026 14:19:33 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Wed, 26 Aug 2026 22:18:15 +0100
Subject: [PATCH v6 13/16] drm/panfrost: Avoid cache flush after perfcnt
 sample in fully coherent systems
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260826-claude-fixes-v6-13-78119af409e7@collabora.com>
References: <20260826-claude-fixes-v6-0-78119af409e7@collabora.com>
In-Reply-To: <20260826-claude-fixes-v6-0-78119af409e7@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1026;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=1ViKXn5Z9t7QEwpx1D0niBppUD0kk1O7SjFsLfT8ejE=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqj1gMFuKz+mvU4LI9nY4ViyhJBxWl2EU90niSf
 c4MKUbik7aJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCao9YDAAKCRAOJn5M7lND
 PVx7C/sFykCT6g1swxOYk9LHjDxyph/jMYbWnrTYe3T5+1MkpIlR8XhlQL1xaU3b7cnIYoG+5e7
 SeDEKC87AAdLYU84hLOuQ9qqUEeBXhy/QyTSxDOboHhYY+81ZzDRFf5WY0a2krry0IB07JyFhJx
 CJGPrquxkP5G7TWMPPQT125j5yIsqN3QKInwu8C3Qa5W8DBeJOzZ4XmghUJp5VaVIyxG+5E/6lF
 dQG15pT7lC3y3R5nh2TpZxKfyZl7NOd8Et+4CwCialQGaTEU42/jchDF6fR3F9jRlMjr9YNdbEI
 GFLde6oPZtdaVaeqS6eRFBWz1fALoXwcxe+RFwIieRJjH2dktI45YlbBrQnznrP2mDldehCX5Gu
 1DRIUmJqdO2GBPPJobxyfOyCWD7+r69UpF+WkoICLJoq7FqMBS80/fXR5FzbxNNlwowe98/6ktO
 qjr64XHv7zyX0ShyC7gEiiju0YpK474Q8ZU+DHBvtrEJzkF07Fz6OnZ7417o0/lROcGbs=
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

