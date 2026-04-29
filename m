Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5049FF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 09:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAFA710EF0C;
	Wed, 29 Apr 2026 09:59:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ZjkxoXqk";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6914B10EF0C
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 09:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777456760;
 bh=WUlL1O/45PQI6YKuEzmypF/5DpmvpKtJakBpcNDoaiI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ZjkxoXqktEVbE0bhJKqDg0CDtE1hvDgwqLe0pebXFaT9jV1aWFyMlcVj40dA0owVX
 KGlvw7QzYqNQo0VxWuVzf7Z89OoURQDbFKwnW7TIlaXyxWliNYrmN1jXoprst1RB00
 EAharlZ8lS1Hfzp/XBGzlphyvGmFpxITEsItAIrwfG7hFqdmy6p0To2pTLXp2MpG3N
 DJHBfUg921py4QXic2hj4fpr04oK2EcDHuVJ78qN222+GUFTxVuZWbs+C1UoanLGfh
 tJ4yYOy2igaH/XM5he4IGIu29dzIHmAW/qw4OTHPdZwY7TBr07aUDeTWsDeQ3xlf0k
 7KSXWXtSvaemg==
Received: from yukiji.home (unknown [100.64.0.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laeyraud)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4297B17E1525;
 Wed, 29 Apr 2026 11:59:19 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 29 Apr 2026 11:59:01 +0200
Subject: [PATCH 3/4] drm/mediatek: mtk_cec: Fix non-static global variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-mediatek-drm-fix-sparse-warnings-v1-3-d95c4d118b83@collabora.com>
References: <20260429-mediatek-drm-fix-sparse-warnings-v1-0-d95c4d118b83@collabora.com>
In-Reply-To: <20260429-mediatek-drm-fix-sparse-warnings-v1-0-d95c4d118b83@collabora.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 CK Hu <ck.hu@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777456755; l=1036;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=WUlL1O/45PQI6YKuEzmypF/5DpmvpKtJakBpcNDoaiI=;
 b=iIaunPXI8/mSHHSEdzvELTQBbAki1NTo21lTLhSQyH3syWWXZU8L2UXh0M7PxCJonDtE4B2Ew
 FqP+UdB/Rc3CVDgbJj6leEDGI9abojfHiwDdeMYGOvxkC50vmbZnV7p
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=
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

The struct 'mtk_cec_driver' is not used outside of the
mtk_cec.c file, so make it static to silence sparse warning:
```
drivers/gpu/drm/mediatek/mtk_cec.c:243:24: sparse: warning: symbol
'mtk_cec_driver' was not declared. Should it be static?
```

Fixes: 1e914a89ab7e ("drm/mediatek: mtk_cec: Switch to register as module_platform_driver")
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_cec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_cec.c b/drivers/gpu/drm/mediatek/mtk_cec.c
index c7be530ca041..b8ccd6e55bed 100644
--- a/drivers/gpu/drm/mediatek/mtk_cec.c
+++ b/drivers/gpu/drm/mediatek/mtk_cec.c
@@ -240,7 +240,7 @@ static const struct of_device_id mtk_cec_of_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mtk_cec_of_ids);
 
-struct platform_driver mtk_cec_driver = {
+static struct platform_driver mtk_cec_driver = {
 	.probe = mtk_cec_probe,
 	.remove = mtk_cec_remove,
 	.driver = {

-- 
2.54.0

