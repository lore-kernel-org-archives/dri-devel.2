Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6084C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:28:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3B1A10F70B;
	Fri, 11 Sep 2026 23:28:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="e6zSvpln";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 804F410F70B
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 23:28:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789169309; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Hl9X56XFA4xpbeOGoB63SUq03U5F+Z8XkpLiENp/R0FS0pzc82tk4WG0Or9ZTdz10rgTlP1l6S6vQz2q0ouMNerJhYHI1GBbv4NxY3eu6vzlN6eve4gabFJSJ+QzLsJUgpwFmZNK8eNhr5DPGRMdwdBcEIo8FKKlQdu+gGsl/YQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789169309;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5tcaP2IVkF4SV3ksstD6wFI9LNYjrG0cIcTQTiq6ocI=; 
 b=bR7kFggb64+CRvdcNYGc8l1nCK0Iw3WL+A4zd2YicIR2q2l9EC+ND5PIM2TLr0APXe82F3jk1rS1n3deYJH7F6cMFyAkCwr8Hln5pul/qb3arXTFqWF+baUeSh4Uz+PhnMzqd9IOjnCaUQQrn1sp4irdQnzUwrLjei45qTOeGbI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789169309; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=5tcaP2IVkF4SV3ksstD6wFI9LNYjrG0cIcTQTiq6ocI=;
 b=e6zSvplnTz3wvjd3RDch1LccOkMyvMwvFSU3yh+8ggjKCobFN5DOcF4KeZKrl9aH
 DY2OYZvGbojf7Xa49DIdeVL8cpAyvJTLS1OJ6FOyq6LRlxYfUC8L46XHKXpcayLrS8+
 GGyhzRdWV2HIyiJSqNrSdJkxpnHUweFu79zbcz7w=
Received: by mx.zohomail.com with SMTPS id 1789169309363168.90670944563954;
 Fri, 11 Sep 2026 16:28:29 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Sat, 12 Sep 2026 00:28:05 +0100
Subject: [PATCH v9 04/16] drm/panfrost: Skip NULL checks for clock
 enable/disabling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260912-claude-fixes-v9-4-e588feaa61ef@collabora.com>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
In-Reply-To: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
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
 b=kA0DAAoBDiZ+TO5TQz0ByyZiAGqkjoOg1n+UAnsfidnU79r2s/+taL2zJOUS9PK8onuxeOL3Y
 okBswQAAQoAHRYhBDJAMOjABRdd+TcHpA4mfkzuU0M9BQJqpI6DAAoJEA4mfkzuU0M9CjcL/ROA
 0JqYyVlRe8Ew2uOeXQ7BRYFz26BOhfFpqtwF7kz5+rR9oAe3H3aiZDeXAiafNi2TnzBsI+0fnGV
 r70AS+InRRRK8RgfOqm3nCi7Ak1SnGEw6ltHV2HXIVgki2rC4wbGTU4fSRu+pLmvprq7R9+aJtQ
 8W6Wpg8Z+ae0fpZN0/YY3eqlxXH+4QXdIBTf0j4aZVIo80KsBzi/3j8QrWBkpyeb7kgAGDqtcHU
 o2uXB/XdJzEsZbJX0ibWFCTRlMxyz2jA9S4HJbIfkn2N0GrLJIOSvE2sf1FHKqknCZG44x9hmkn
 H69JwqO7gwRhsBNTvciPa8d6XwwiczNLD9J9f+ZNSsugh639EGYER8ZTR07zwB7CCmPlCz4+TBX
 GB2NCLdMzqvenQSNvTlvho/qjdbaTuHbz+acppE5iCFgjjkm50s4bvg8tra0oXCN55e53NqaHIC
 mhEjwIBcwczrJ1DQ6hpR6Oc/IJNX/qgQiKaUuI682XlNG+uUM91K8un6nrkQ==
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

