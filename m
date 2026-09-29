Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB09CA5FAD
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 03:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 629A410EC79;
	Tue, 29 Sep 2026 03:45:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="LFrZXxg1";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E402910EC78
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 03:45:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790653516; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=McN0KEJKc1mHILO0s18WuqpjMYnlNcZjXdjeXRZnC3seXhuPJX3hsep91nC86kQYAQuB3/UUaWMaQy6AD7S3JZl3Uhw+Cp4rzV7sgDnvTJWI9AGv2zMGwMtU5rWzximEMg+6CVz5ZkxM3729JyxAocgXNoj8mhGPmGWrzlZsz7Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790653516;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5tcaP2IVkF4SV3ksstD6wFI9LNYjrG0cIcTQTiq6ocI=; 
 b=QZ2NSd811D5SITVrAYnMP4XE6VVzB+46EceOC/Xz7cphkqFYkX2aw4v9NNYjBAvqGmWNdMvBqfSRv950szNCcYg0OrXKwy7lyTNYS9PpFWcp8UwgdvxnGL6ZzOZ7upNs2iigoG+oNPyRcwPvezvYKC+FfeK7Jez7gEhLB3guTWk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790653516; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=5tcaP2IVkF4SV3ksstD6wFI9LNYjrG0cIcTQTiq6ocI=;
 b=LFrZXxg1vOzteoNfZNflnnpMur6TzbFc+RXSyK4vJyua8zogRLvErWsPBUvyP0GS
 g8xkCeBEj8Z/tw2975NeflkNd+ClIPiW8mooNBDyTib0MFYASqOAd6d1m/+GNVvrxg6
 kAeuo8p2nphfbbJB3srCEzygCxq7tDo9NFqoTbs4=
Received: by smtp.zohomail.com with SMTPS id 1790653514977790.2997644814461;
 Mon, 28 Sep 2026 20:45:14 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 29 Sep 2026 04:44:38 +0100
Subject: [PATCH v12 04/15] drm/panfrost: Skip NULL checks for clock
 enable/disabling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260929-claude-fixes-v12-4-62beb08de207@collabora.com>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
In-Reply-To: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1586;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=ZbKj/0+gldpyeLSSMbRlmpp9mm9nCUYXI4PymrPfLzQ=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBquzQtNO+6PaQHqOSMADaQhp8RqicqwjSfET07T
 4B5vp4EiSeJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCars0LQAKCRAOJn5M7lND
 PSWJDAC4vDIxkSNAQwmwTYRCwXmUKHDoAeMh0Vp/CTWD0EQjB3jA6034FD+hfvBONEHjnT6T6A5
 8vrS/I/LdTSgHvMskWB62CMwQdUaXop0npzktB7Lomqcemg175R0UkABzlckKJIUI01UVVBaf04
 1LR+SmylnwY/66mb4dMOsmeNXaxY3rEek5t5fDXlPLpzTKAJPXR+s0yo424caKqIYYeQ3XZMEW+
 TW0bsqO9CAP2PTuo2Qdw+8mCp647s/SIv6gHf9A8Yx+zgClHOqVgjvfPyZ4q/RK8gjiA1SqhSd4
 akeAI9SOCKk7dNG9Fmee/9dSG072UxnZB1B3Fl/QxAWJL4TNy+T0fMtr5KgbPU1ly5Gzcm7FvZz
 GprVtqY6ezvtGxAFaC6rQP3ButZGvASChQRQETocmTFrYnqmDPNKTHISGDyDczweYoSBFjXa47Z
 TUeOsJibT/tF0PriYqtLKFS2WGzfdsOWb48SyXYLN27x8faWVaLtrIimpEo+OGBTtHJB4=
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

