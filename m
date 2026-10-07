Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC964CA6009
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 23:43:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0076A10E700;
	Wed,  7 Oct 2026 23:43:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="jKbASDgJ";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59A7D10E700
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 23:43:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791416604; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eQsR4aCna3vwM5wtB1AeNwvmdoV7nVdopMDGgCiRhnJXC9kNXuizK8P7vBGWK6fc5qiimV7SCzfBge98b9YcP8LtzfRDGXWUY9lIe85LCyeL+hSRkEvvH+R91Y+c1hbFIVveXMtx4W4CLyKgvoIhxg/CdvcSxlqtUoW6jje41DQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791416604;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Cz7nlaO9ug15k4wyc2p1bB4V9NQP7yWcZzYPbXi+vXY=; 
 b=GXnZYWVDgx3rLek5nSc3Nuusdyn2atioqPxFMXMhDENkF6Wmxci+Yw0buRqaplR5FTTT3TK96W2Ic8JuKFRQTmsimZkVDQTAL+i6EELDz0NVBxyFu2+q0BaON5KN7YERnqATqv3OzCBUPDcfAO5kdpeLsztbOX5hCp6hxGN5McU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791416604; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Cz7nlaO9ug15k4wyc2p1bB4V9NQP7yWcZzYPbXi+vXY=;
 b=jKbASDgJECrUeMtTJILhOIKEG9VMN83bFhoN7yPg5zyVuHxJhC5Blx3JUd9aIo3a
 JfJFV+KcTvS49f9xen6Uh/2Gld6riiJ2tyJGA1U9icjJYUW3t6I5bF9FAeM1kPmhiwq
 JsDVcJv/lrE2VJjMzweJ9hMn5gWM8CGA4Nm5V2OY=
Received: by smtp.zohomail.com with SMTPS id 1791416603103998.754207716527;
 Wed, 7 Oct 2026 16:43:23 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Thu, 08 Oct 2026 00:42:47 +0100
Subject: [PATCH v13 04/15] drm/panfrost: Skip NULL checks for clock
 enable/disabling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261008-claude-fixes-v13-4-d6a493185860@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=lnZA3WBfFFBXieQiXa+jWZXXOpFpf8LSvl0zyNsSIDw=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqxtj7brPj8iPgSr8H0flxfnuNlFZ1/DExeiZ8y
 pUK4YCW6JSJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCasbY+wAKCRAOJn5M7lND
 Pc9jDACbAF0BBsY/GSKwJnazLbjEPd67QR6Z5muzGGzL49+V0QDJ7u7wlxvjKmwoiHezxQmlOmF
 KEUS9rhDw5+xYyMBOY7Y7j2CTw2dtEkERSmIaplrDDn8HR1DWg4kc1Qp5uYwSoO6mAPEeWU4+ux
 fPdx828q/ouIj9T2TTrhs4SuDKUCZN8QZ9gVbxMbuElXj0OPu0MMeZoSvmgkSFNq26t1bgOgPvL
 Wc6ssPxe4M8yXLnehfC9CRcxznZH5zgLltr6utxZGNjNTYLgQJiYSC5yjlfjRpZX+UC60Y1rH/n
 LJuEbuv8LR4SQlfy5dK4MYTvClcDhajPkUq32cgjBEg2PVcwOml/HTEA9U2qyRh1wMpuhp1VKcW
 qGq3ZpCj8vK814FShyRaUTiVy3cN9gMdb82QHZuOcPvPQaoGguRLdM9+AemQEdR6TIPIxcpqjgt
 RvuiQ5umXA4GNRlgJJ4Ph79UFnFMNaphM2REvucBMtlCgwbSrtj5v74AhpyiHSGMoF29k=
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

