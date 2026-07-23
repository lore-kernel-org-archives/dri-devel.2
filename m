Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E1AC531D0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D8FC10E54C;
	Fri, 24 Jul 2026 00:00:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="MkrcdJ87";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A87110E54C
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:00:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784851231; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=aVdmUokBGxcrHA3WLqFTkLTySdgObEu/cJWaXwfQpSWGs6E13CjVM72lgvKRIsHSrp95mb7N6zkoehOK2i+i1G9KPoDMHjTehOZxb9nQT4HKKqsBUoUg/dE3WL6fo3YXLqVtkZQr9BtgmvbxXN+IGCJDToxzgudaRRyy4wEWYTU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784851231;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=w6HUpQIpSHs/rjyl1FLJmSgGlfWFvp+jq2d+LIKIZOg=; 
 b=lgr4d+DO6z8XFutUZtLb3Jxtu9lBCYpOruqcg0rkNbGQ3gjRnLw9Pf+srOwmXi4vBSBEdZ4AowQodgDfL1ObXVlRwK6uRH2lVZ/ajzLWIjjEkvdrJ68Qi/MNTZXiprqbwKTbiRRz+mq8PTRLZey7ofN5DevcL9wd41zA/dSPZgA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784851231; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=w6HUpQIpSHs/rjyl1FLJmSgGlfWFvp+jq2d+LIKIZOg=;
 b=MkrcdJ87rY1ZPBmNEI59qOPa0JRuSvSmiKOhom9Lh013pxKNA/8QY8EnEYUc8/+D
 dTOoxDBAO2bQdMTH8SirjS/N806hHskQJpTLPQBlhaoUoSmxpHBSd80X/aDNRAu0hIi
 yybQwoY8kC3TSuIPKjLPwDuoK+cBrBHxWjLETSyM=
Received: by mx.zohomail.com with SMTPS id 1784851229375543.1774978345184;
 Thu, 23 Jul 2026 17:00:29 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 24 Jul 2026 00:59:00 +0100
Subject: [PATCH v3 07/13] drm/panfrost: Sync with IRQ before MMU disable
 and reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-claude-fixes-v3-7-542af61abd0f@collabora.com>
References: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
In-Reply-To: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1704;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=rWSC1BF93/IHhqkvT/dZCfFzeAV6q1QvBTnPFkEVQIc=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqYqroAu7bSqptnLlQwSV2LVtPrWFlRntXWxxKx
 3fb3Npuqu+JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCamKq6AAKCRAOJn5M7lND
 PTDfC/9Yu4ILLJZBxdAO4nZpjG+9zSzH2sVdJSTYZHAOcE70a4b4t5Yq+Q+OF6fzpDIkMYUnot9
 izcAUFp77eLarLm5qhypGg6GDXETIyQuCmq/RtgE7XYej8MtyrAA97ollarCWGL+oa82MpSHbAU
 m+3s9FLEcy7SqirTRC8X7JsM0Nn39fcirECX0lrVcrAXxXbOu+g0BwfQleG/njxP5tG8qFTljeg
 1oKxBRuKo8TJop95vEODbpE6ZqeBUz5kuErjIjbhG7HfaS7uzIjcvTHHVvUNP8q5/WchpdmbNOy
 5b8kIBJTja9CC8MRnAUB6D95TObMekAYwC0B/QWJBM3LfuKeAB2uFckIcRoDUfiU6DJrhQMwXul
 BnxD0yZfhzZ2YWnvqGsF0E3MWYAdxIDKYFIdknu+Ih7kBLqF4/80ozrtpiDqE+n74SojBekv9GX
 p1wF8XhJYc7OKGODTTUFV20AXHMqKxcM1bObCyiBSjIKm6QUbnxR7cF0Zg/QbNmoIzu+M=
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

There was a pitfall of the MMU threaded IRQ handler accessing HW
registers after a spurious interrupt at the same time the device is
being premature taking down because of a failed probe sequence.

Let's make sure MMU IRQ's are marked suspended and synchronised with
before unwinding further.

Also, during a device reset, make sure we also sync with the MMU IRQ
handler so that AS aren't clobbered while a map operation is ongoing.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index bb6c1614964b..f067bcd360a8 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -347,6 +347,7 @@ void panfrost_mmu_reset(struct panfrost_device *pfdev)
 	struct panfrost_mmu *mmu, *mmu_tmp;
 
 	clear_bit(PANFROST_COMP_BIT_MMU, pfdev->is_suspended);
+	synchronize_irq(pfdev->mmu_irq);
 
 	spin_lock(&pfdev->as_lock);
 
@@ -980,11 +981,6 @@ int panfrost_mmu_init(struct panfrost_device *pfdev)
 	return 0;
 }
 
-void panfrost_mmu_fini(struct panfrost_device *pfdev)
-{
-	mmu_write(pfdev, MMU_INT_MASK, 0);
-}
-
 void panfrost_mmu_suspend_irq(struct panfrost_device *pfdev)
 {
 	set_bit(PANFROST_COMP_BIT_MMU, pfdev->is_suspended);
@@ -992,3 +988,8 @@ void panfrost_mmu_suspend_irq(struct panfrost_device *pfdev)
 	mmu_write(pfdev, MMU_INT_MASK, 0);
 	synchronize_irq(pfdev->mmu_irq);
 }
+
+void panfrost_mmu_fini(struct panfrost_device *pfdev)
+{
+	panfrost_mmu_suspend_irq(pfdev);
+}

-- 
2.55.0

