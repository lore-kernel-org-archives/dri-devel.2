Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545DFC79F99
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 20:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9487810E4FF;
	Mon,  7 Sep 2026 20:16:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="aStQ3//W";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65FB010E4FF
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 20:16:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788812204; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Lk1VyW1RduOYr/votXjGTKoZv3ApuXi1MoTxSlkOIPBKwNiLXxOLqPJcT7nhuFwOhfS3OD0gBmus2Gv4YTalo5YyHaYnW9ulm7AQRbunpn+lc0A/ZBtUnb89sJq+BfAkVYhMEvKtegFe6q0QopXs7PsFSQuCkLgJ5kxElf+zadg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788812204;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5tcaP2IVkF4SV3ksstD6wFI9LNYjrG0cIcTQTiq6ocI=; 
 b=kxmU8N/EsvLrbz3kx0wYuBrCuYrLKp4Wf1TcMqX/tbkJIKEp8XDiLbx0ZTD3OklRSXeD0WkQvIoQwictsvm7Mv1/U9Le0Ty+amMOOBUL0QdhDTTvVd+JqWFyVlXcNzV4SN6tM7xxPSOGLLjdL9aomwo0yXYECXUt1Y3bIUDu/nc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788812204; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=5tcaP2IVkF4SV3ksstD6wFI9LNYjrG0cIcTQTiq6ocI=;
 b=aStQ3//WutN4gDYL+K+jRQh2U5IDbnIbnImb/Nd/9BVSMis92eW2heZlcDHv5qVT
 oFzRmVshCaH+ORsic0Vgv6bnMyzrOIFTBPcgvnR+yjt1fdTR6rBFWrQ0fN7eVdG7SVe
 f7xFXIgiBTN6Z6o1alZxQmSNj5bprz0T8/OPp5Cw=
Received: by mx.zohomail.com with SMTPS id 1788812203105323.20898422512926;
 Mon, 7 Sep 2026 13:16:43 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 07 Sep 2026 21:16:13 +0100
Subject: [PATCH v8 04/16] drm/panfrost: Skip NULL checks for clock
 enable/disabling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-claude-fixes-v8-4-c2bcb5e82184@collabora.com>
References: <20260907-claude-fixes-v8-0-c2bcb5e82184@collabora.com>
In-Reply-To: <20260907-claude-fixes-v8-0-c2bcb5e82184@collabora.com>
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
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqnxuLFQB3kuAe2s4OLXRbm2QA8UQZJmdiu6KlS
 pSPzhjo0Z+JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCap8biwAKCRAOJn5M7lND
 PfdEC/9z8a+i28SOR38Gf8e0Q/MKS09Pp9Ibpl/lrQSNQKa21zdl2Jj9MVMcBysXwG4avHH1Qcf
 p4En5+6xxg4O4e35NnevUqDOOyHP0I+mXhqpPagrhGdxsYb3H6l6UVimyx2RKLGCk7BkV3YDqTM
 TIwsSPbveF1IoUItEa5v3ql0dNGZ660wsBxNbOc5ck2Pr0CZRIydpKp4UiFmkb+W3QbJE7TPrG3
 VyuaJ83muGw5NcaLNQ8HN928tIwkgruJR4Qf3BL3N5p2pFMSWAMn0Qy0dLLM5fC75hxAvjbzfo9
 ufwuA2PiekAkVTM6VZcBKxp7frIwwK1LnCGLC06hCHf0iK96QGPHA8zpxeIyJvl9HQHd6uy/r7e
 TyJr5G9dVWHB9/evd6Y3rBbxHhOLuHSQ7ymp/LrHeVNQN4Re54TrPGb52c3w7Ph+sSMYWbyLjml
 OytbI6nKkYN3gDOMPZ2ReE4mEy/Aw4nBweFcVK3yDhQOCoX+3Esg+5SOhAVzd6nmBO5Iw=
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

