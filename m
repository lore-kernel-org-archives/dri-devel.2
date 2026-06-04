Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE27CD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 17:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C078A10E3B1;
	Thu,  4 Jun 2026 17:51:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="b9ZZnDEF";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD5F10E3B1
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 17:51:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780594572; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bTo9sola0Q9EasoFvNlehSYbmharspgEMnkoZ2/pXdqeAnocBurydmr9VSZ3tLgg4hoRU9tWnIeXYo148a+QLZl9S5XZcW/hHNiuFlHNJc+YtQC9sWitDiyUcfbP1+ND98lWuzjSvnDTG5J4796c7grcWIAvoweqfWKUoLYfb54=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780594572;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=HPNTjEe/m5SGoAr+PENY+66BzrLFIi72Iy8Y57gshzs=; 
 b=VT3cSC2TJB4p/p9ZFpTkuQAG+wjF7hZXrjZB4qtvYOMIPtPJkyDx5XguxXY6RwtViWEDriAc5XKqVLZ1Min48u28pY4whcEe35ef+10EKxgCKg8xnblNSrLkf13d4rIK9doV9XX3t40ywwGTtQJVQemKUk4dL/sTwyAhowJ8X/c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780594572; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=HPNTjEe/m5SGoAr+PENY+66BzrLFIi72Iy8Y57gshzs=;
 b=b9ZZnDEFcGYen1JXI6JRkzUF6vlx7DhtvBSc2VNRUOjR3z4u4p0EKiEKvJcic5M8
 prSVZiNCrB9RTqjzKn8DlE0LqiHIovM9oQE3Qki3tm/Ys6rG4GSqV2V453/H/G0B+RB
 aJh3m+CIYzCxpqRK88iUuQceCwOrk3xAyzj7azxU=
Received: by mx.zohomail.com with SMTPS id 1780594569939499.8673373915145;
 Thu, 4 Jun 2026 10:36:09 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Thu, 04 Jun 2026 18:35:21 +0100
Subject: [PATCH v2 2/7] drm/panfrost: Prevent division by 0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-claude-fixes-v2-2-57c6bd4c1655@collabora.com>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
In-Reply-To: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Claude <noreply@anthropic.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=nzasDqf1ZeVklLh/1HHStVgG7z6hFgrLTXP4S199BT8=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqIbd8WxvU2W8rxwyJOhXrt+oHBJji+sfAjSlwT
 GxBZNE5ZK6JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaiG3fAAKCRAOJn5M7lND
 PXeeC/9vrzMpvViX3v0IeGUnIFh5Uial38bhIF3uoGomEtqsM3SLAlp/YISXTg/XhYPqepLUZVo
 o0prfUxW3hRMd5Ss4QlewY/7vwKVYFaraQluI5XcR3m62nq/XhD6j/KhAnmQ07Re5+4EeH7U5/G
 wWqI70NXJfawMC2BXtP2H4fginhJxta8ImxNytl4BCNNHOEpln9UHXCLFGUrqXaPu6X5+IBxQMg
 uj4hjGB67miAWin/y780Rmanym//Hq8FUBWPAdf0gFzs6mDld3L+3QfMN9aBN5m+Vh+P6hLYMRl
 +/kjauv2BHaXLqTzblsBgvnPKSQwMIl1VHDv8XOzHN9ZPaAUGHdcuZKlhVUZWlHnTMmCmO9qy5L
 Ci9SfcXTq7zC1LT7aXjw7PsBAZy52bV0jYld0HwDl4oYj4oX1j8Wmc9LmcRuRTRPksmJGdfXZzv
 t2IGM7N3GvYcmnPyce+TBN77392gICojxUuLeIxLJFsYo1CsNLYvZQLBV51nusrQoXql4=
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
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index b51c30778811..e34de47bf43b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -78,7 +78,8 @@ static int panfrost_devfreq_get_dev_status(struct device *dev,
 
 	dev_dbg(pfdev->base.dev, "busy %lu total %lu %lu %% freq %lu MHz\n",
 		status->busy_time, status->total_time,
-		status->busy_time / (status->total_time / 100),
+		status->total_time >= 100 ?
+			status->busy_time / (status->total_time / 100) : 0,
 		status->current_frequency / 1000 / 1000);
 
 	return 0;

-- 
2.53.0

