Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89CE1C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 18:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCA1110FC0A;
	Fri, 25 Sep 2026 18:46:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="gAh/KK1m";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2152C10FC0A
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 18:45:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790361952; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LZrOrcedXR75hHWAKW+frLRM90noSuSvP4w6g0b1g4SOhYoYDRecB86fEFByBQtcR9DrLUmFiJSZot1VwzyMrX4H2m8khOlf4xq63mS5TNDemOz4VXgnYq+VaK9WfR6W74uzLpeBHJlBcg/PB1fmg5VfqEbt/u9qAUC0zT8mmak=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790361952;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5tcaP2IVkF4SV3ksstD6wFI9LNYjrG0cIcTQTiq6ocI=; 
 b=n+iwIDc4nc/ZJeCBV4Ei6e4qzMyw3Ke5FsV/RsFc1KkOuPhBg1fJDF6cNovXuCdqMvhOoGWDdimT7DLRwnwXrUNnLQG8WQ5R1QCPIGiW8YzeqDlLRD21BPHB0aql59wwNEv/78SajwaSDmUIaBJBra7a57+3FGL30ESHYAm42Gg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790361952; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=5tcaP2IVkF4SV3ksstD6wFI9LNYjrG0cIcTQTiq6ocI=;
 b=gAh/KK1m5CdZKr6Kj+yVRktz6Dj7erYGhzNJIxzdfzDjMmNZdhJm0KE2DEiQ/2xw
 wwgsmUFKsiGvvYFRcKq3Q79XaMhzfFJQrCx5YgNpUYqjguMzjwXGmu9esWrCrmCFHJ5
 vpfFxFoyso/lK52l1Ybso0XH4NH7qQeuzVL7d+C0=
Received: by smtp.zohomail.com with SMTPS id 1790361951195381.447267247186;
 Fri, 25 Sep 2026 11:45:51 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 25 Sep 2026 19:45:25 +0100
Subject: [PATCH v11 04/15] drm/panfrost: Skip NULL checks for clock
 enable/disabling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260925-claude-fixes-v11-4-0dbf5a58e7ce@collabora.com>
References: <20260925-claude-fixes-v11-0-0dbf5a58e7ce@collabora.com>
In-Reply-To: <20260925-claude-fixes-v11-0-0dbf5a58e7ce@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1586;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=ZbKj/0+gldpyeLSSMbRlmpp9mm9nCUYXI4PymrPfLzQ=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqtsFDB4nJ71qoK/li91o6Keb0e0zN9a50eeN8K
 L2BgOlgIkKJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCarbBQwAKCRAOJn5M7lND
 PbJyDACRB+42WPBKqIRzTRerVNrIYMJKBMOOFOKNAL1kAm96fzB2IvLiqHXyfVpycOqNPx1dqrC
 14WCAv4f3X4Zd6zygzTqhwZCav7b0yQ2Al9TGj9BgZfkHzlAbb+10CvqvqZdcabPIVWaq9LkkAT
 0pzZiC6l0m2hT3g858eMqJXZhgwGTvzYxTZJz/WzHhAj0Rv/999+R1ocul60MLkUWwc9ccBEPkd
 I4BFZ9y9h+hiKW0cJe0vm/n8TaX4rc9POi2SNA0qDDgAeko9kMAQ/Hk40ZKhv/PNtm5nd8j4kew
 rdyDdkg08UeGDp6ReWMOND87w7zSVJYmDzHTI/UuCAimfdtt6qQ1ccE0nzIY7iXaO4h7Qlen02o
 81kudoc0s1PWlDDpqyPRtvbvkfdFE0o2fe30Y+em1/CYlha7oThsdRED52U+9hCU2ZPqXkuASII
 sJY69t2TNY1Upw8x89Ry/P8MFXpMcU3wxv2Bb7yCX0q0nI9wS0aGkeaPecIbUBOd6ENqw=
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

The clk_* API can deal with NULL clock objects, so we can do away with NULL
checks in client code.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 5bf528f41278..b3a53504bd01 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -510,11 +510,9 @@ static int panfrost_device_resume(struct device *dev)
 		if (ret)
 			goto err_clk;
 
-		if (pfdev->bus_clock) {
-			ret = clk_enable(pfdev->bus_clock);
-			if (ret)
-				goto err_bus_clk;
-		}
+		ret = clk_enable(pfdev->bus_clock);
+		if (ret)
+			goto err_bus_clk;
 	}
 
 	ret = pm_runtime_force_resume(dev);
@@ -524,7 +522,7 @@ static int panfrost_device_resume(struct device *dev)
 	return 0;
 
 err_resume:
-	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS) && pfdev->bus_clock)
+	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
 		clk_disable(pfdev->bus_clock);
 err_bus_clk:
 	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
@@ -545,9 +543,7 @@ static int panfrost_device_suspend(struct device *dev)
 		return ret;
 
 	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
-		if (pfdev->bus_clock)
-			clk_disable(pfdev->bus_clock);
-
+		clk_disable(pfdev->bus_clock);
 		clk_disable(pfdev->clock);
 	}
 

-- 
2.55.0

