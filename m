Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E0DC5CFC1
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 890EB10E398;
	Tue, 11 Aug 2026 21:42:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Pi6QukWN";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A164D10E398
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:42:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786484551; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OGRjR0mKgOlJD35gXStSzB73enRnuhvzBIK3rTzPi+l5fwbvpurHQd2kX1mDroYTYfbf0I0AHPu8foHdtZQPxQWIZHHxX6ixS/sc6niEjzITrTqjBdhlYjEzqWVoOxUNDuRQHXrp5Bs9Po433UdUBF3vmCU3iD5WD+VpiRpWV4Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786484551;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=czRVsGoDhUYjh47WNCfN5jXfKsBYe+ZKrefmwoTVP38=; 
 b=EffMh7Pvm10N9EnVcZtGxZo5+6bMEBle/2MUMArSoQVsishIrsm1d0nX8wfUqswaO3TLn0w26Vg1/R2nlox7CtjJgoYFT5h1whmkpONAt9/0wcHJF1BP9CE9IUR9fclhlrwd+zFfkxpd0vBt39nkev5770+Vcl2MnuHGIIDQSW4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786484551; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=czRVsGoDhUYjh47WNCfN5jXfKsBYe+ZKrefmwoTVP38=;
 b=Pi6QukWNikwNaQ2dQl2qzVbdETMXSNwykgG4BUOTOOc01AuYzDdliTaHFH2+6ogI
 Yac/lI5YbyuuAL4Ti60FVI9iZ3DFZlQcStFGodIFHzvOt/lFmj6t49LDpWxynOofwuY
 qB04tlZCA2SLHQ4WPybciIOauzBLibTsOXf8FP9A=
Received: by mx.zohomail.com with SMTPS id 1786484549674128.65685693522425;
 Tue, 11 Aug 2026 14:42:29 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 11 Aug 2026 22:42:11 +0100
Subject: [PATCH v5 02/11] drm/panfrost: Prevent division by 0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260811-claude-fixes-v5-2-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
In-Reply-To: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1249;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=kl4fy4ui72Fh+RD+K3B6m4ExNC9Qrv3fOS3tpchSf74=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqe5czDhlrwpmjftleSK3KG4Wtw5rS5iDVls7Th
 GA7xwqEMlOJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCanuXMwAKCRAOJn5M7lND
 PZCFDACiG0rgthHEXzxUU8F0SKf03NisGG292ffPvOFWoghY6bLFVdWlfnlWwU/QKt2kRX9ExdI
 q74oeLOJoSoTEYyQEWGHtghY4O8nJxOwNjlbqgbKi6ARq5ZMqNnI2ry1L45+8KEZbJ9hLba8NJB
 DOH6ard97nAr1Tb7VXzqnWUW0RlOLIjfr/vmqRiXFRXqFUcWCVYzq6SzFXWs7pf1XKwAYNgxW3e
 NHBKMoLaqPuAryyx+nDbPECUyDeA4JC7+cxIexv9tRM3HLVqxtLmCge4eFSEF3s51fhT+P8eI79
 SwYN0cPXu54duPg0g9OD94NOhO4zryHW2cdcpHhsdsS0BYqdgX29V2xtxJoa5guGQ4SmN08Fup/
 U9BnyNM/erHKMeQyCIHAnQNsO6PECCfpLykGi2Tjf64pig0Qcug5qPlP/UtePpV23hVYzRDfl5L
 LDcAcPmUm4DBQoyxabhYywCiwCq9A2oV8ue4r+WvH2Rj/lXmUPXC0DDUcXWZiSDWc3+zc=
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

When updating and debug-printing devfreq stats, in the very unlikely
off-chance that total device time is less than 100 ns, division by 0
would happen. Fix the divisor when relevant and rearrange operands.

Reported-by: Claude <noreply@anthropic.com>
Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/88
Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index b51c30778811..0fe81d259274 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -78,7 +78,7 @@ static int panfrost_devfreq_get_dev_status(struct device *dev,
 
 	dev_dbg(pfdev->base.dev, "busy %lu total %lu %lu %% freq %lu MHz\n",
 		status->busy_time, status->total_time,
-		status->busy_time / (status->total_time / 100),
+		status->busy_time * 100 / MAX(status->total_time, 1),
 		status->current_frequency / 1000 / 1000);
 
 	return 0;

-- 
2.55.0

