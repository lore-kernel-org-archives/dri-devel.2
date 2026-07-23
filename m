Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909C2C531CC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A04FA10E577;
	Fri, 24 Jul 2026 00:00:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="RX2xW2LY";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B855F10E54C
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784851201; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nC7OGDAbB5qjsoIH4DF8tYh0uLm0zZ2acfnEKej5VaAMyQZKyFpTPQXu4l4QoAMg/11Qph2r0GewGeChoJs6tf50pfFyevbz8W94qIC18eMhjNrTRTG8Ei6lbRy0friJMb1aJS+hLY7VCubIRsP8jm5StkRJ26Q37uYcnPCBdH4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784851201;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=cBB3KVYTzBRWfE/3wJyq/uXFT6n9iMLLFB45XO/sSoI=; 
 b=gzE+UCf5vknSLvcuo5g7pflOWXAkmNVjNnRlFhOfzyfQS/I1LGZj88TIE+sDOM5SOSwrbHymPR5F0EnAykFyZlnGtppgqxfiM4VRQiffGAypc58VRzUp/buyG0StdqawLqYYCooqL39BpQ8qeU5zgyicusM+GxFv0WMV/SV6DYg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784851201; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=cBB3KVYTzBRWfE/3wJyq/uXFT6n9iMLLFB45XO/sSoI=;
 b=RX2xW2LYgwUhSHhC+kB0zks/qPSVMayN1jqg/M3hCjDj7DRA1NhHJU5KbnHrry4d
 IAj9wypxwjAFRMwHjtKodXw6gRU9iX7gBTEf+iVY03i31WLRsLQ+u06pzB5UqLJ3Zi2
 FpRhiOhspAyOm0LfeNlCy28h097uls+/Q6iFebzo=
Received: by mx.zohomail.com with SMTPS id 1784851198922516.7538518502511;
 Thu, 23 Jul 2026 16:59:58 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 24 Jul 2026 00:58:55 +0100
Subject: [PATCH v3 02/13] drm/panfrost: Prevent division by 0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-claude-fixes-v3-2-542af61abd0f@collabora.com>
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
 Neil Armstrong <neil.armstrong@linaro.org>, Claude <noreply@anthropic.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=KmSX2xO2oMOAg8fuJcOMeaL/KBIEeQEl8siBGL1Okqs=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqYqro/UpJ98pK0vSK69sC4NIi1EtoRTIfKWpuz
 04NissK2vCJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCamKq6AAKCRAOJn5M7lND
 PXX8C/9+BpLQcUnw123Qj4HVCpmkgUay8i6Q6P/c5h4hkqbkfqBxt3EUb/wqsS6IPC1Xg1gnNqL
 EAIErjbF6YrYSSA79d6umZDx8v7eb1+/0kppx4xUrmYj+ACrVHgSrDQFCM1zj4HBOBf9woknNj9
 CmEZnxib+oLzfQYuME6E6Gc3UfmFKzOSwYH2xFnz3Sb3ckkQnjEuiLMTEpWZkLSE35qxTlOJCW2
 kqvCaPUpuZ21lYekzEx/p6vNLnFPbiXySrdmLnQHjRqICLJe9nVnVCPAHLWNnJnIlTmARBuuZnk
 wF0eNIURS/6UIOxxhxU85CLXlx5vjrXHcdhj7+bKQWp2qNVGtp0DlK+pvRfkgJLPk3J2ENhtuXG
 tg+52kYkQMXuAd00vl4B//PhU08Yc+x8Xp5iF+GI7GsxnD4nePQtIEqBPFeLz49/6ItCro08lGW
 AX2SPUnNneDPE4lQkSFTZq8Sl3tzH6l/w7pCA0O0/Fr7YCcgKDeWsr6oNF3iuqYKwEkac=
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
offchance that total device time is less than 100 ns, clamp it to 0 to
avoid division by 0.

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

