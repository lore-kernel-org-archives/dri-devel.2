Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062CBCA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 12:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 654D71120E6;
	Fri,  9 Oct 2026 12:34:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Mo4TXVS7";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BAFC1120E6
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 12:34:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791549263; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dt6bfDNGXEI9qeS2w2X4aUNrNj4HhDdUCMtZmW+r7XzDzhJGKlsJ1unL9PGRX0b1qEyziYdQujqDxprLrzEtPc7zkvmk8OW9b4KBJVxCXoCG9Jtq7Qd0iCgzU17NH4GfA3eFUfZxgzq5DPXMFBFGztqI5nIsG9y/Yv0tgiRjwVc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791549263;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Cz7nlaO9ug15k4wyc2p1bB4V9NQP7yWcZzYPbXi+vXY=; 
 b=FCU3vddsO/iUP8T7ExeX4ufzrToNAImLAMf+18791Ttu8WCYmkaeUVVe0+Xh3HDlBNzaaNkyy3siE4F+Sn3a2qIw7SzK+3HAm5eZib2nMW4TK/4AAFui9fObr1WuwqTEJCRpDtXrqwVWBxp6aCUxwXi8NNd1Pa6dFrzVYRTnqRE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791549263; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Cz7nlaO9ug15k4wyc2p1bB4V9NQP7yWcZzYPbXi+vXY=;
 b=Mo4TXVS7KU9AYU3wEL2b0msxNCwOK0f2ku1jvnchtdNILAMlHFKCWKctW3tplUvx
 HzgrcUCcS5ZzxH1rztvjJbipC4Z38USXEG50xnR7fPc7JNG92FATC0bUidyZxYWUo65
 5k9c89JOiMhJDDSvJ6qdFVE41xMshoXX8lxLrHmA=
Received: by smtp.zohomail.com with SMTPS id 1791549261164883.385078668964;
 Fri, 9 Oct 2026 05:34:21 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 09 Oct 2026 13:33:51 +0100
Subject: [PATCH v14 04/15] drm/panfrost: Skip NULL checks for clock
 enable/disabling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261009-claude-fixes-v14-4-cb743b3b973b@collabora.com>
References: <20261009-claude-fixes-v14-0-cb743b3b973b@collabora.com>
In-Reply-To: <20261009-claude-fixes-v14-0-cb743b3b973b@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=lnZA3WBfFFBXieQiXa+jWZXXOpFpf8LSvl0zyNsSIDw=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqyN8ubhTtFR3Y0PZnwDS/GGwVpsniWgYXWhUpN
 Nk3wNgZyO+JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCasjfLgAKCRAOJn5M7lND
 PYN0DACI3zjhdJQSW5smPXZsC849wm9gxqHFhOoD/xHK/CezCdngAv1jEewbmWcxqXkfU4Q7heb
 oJs0FreBft2pvyafR1BlNBXoGrauH6GFCtByTim5/9PQlFldRI/KD+oTrgQeqYvukttpGAgJNVl
 UKj+eHqkZw7dWrGnmJXhP9elwoELEup9xUpPJ46aBLhW2iJeDcGxkbP33BdWxKR9t3O7/Kud51J
 ORfM1S1OJOqb4GBHimrNRfZW4w52SP45ZEEGZHs1Fzg4JBtNYOC0ziWq7MTrxyR9I2w342lG6mH
 tzt0dht0xRNWtPqRrrM0bV41kphN4r4BQd1bSTFp2IsRY4Hrpx3eh1Az1x29kXEdQHg3ohnRmAn
 u/vnXEzhRHIweyWYl7ijpQpE+OduisWJOXfk39aBkFres30cOQ5+niEdOJkKwQkt2XxAehS78Zd
 ky/3+ul35wLb9+U5Ud5A8xKIy1+l303G1mY9OditIKTuJ+kuijPMPdyD/MgqLRDonOCGQ=
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
Reviewed-by: Steven Price <steven.price@arm.com>
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

