Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C249FF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 09:59:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59B7310E7B1;
	Wed, 29 Apr 2026 09:59:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="bLHucGOs";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C726F10E7B1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 09:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777456761;
 bh=W6kBXnqL1ax3ZXzyT8a/jimZTefvz3wCNS2vOEoao0c=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=bLHucGOsAMzcf07WCEu6l2ilT1ZcTG8BPcfwgcGhZekBD1RqpTilpOl5uB7J+MWjY
 JSaGZGMtdNx3DB7LzFdJO4t0aORFYMjWhitnmIR1CkFWzn82QLPre8CtOQSk3a1VtY
 eRm/zb3AYTx/siPKJAeD7UEs3OlVquHL55whnHhsuF+BS4/PI1Dmasp+/eAprUQLYd
 WbRJQi1Nh/CxN1o86ofniYQm/h9+JO/DRmjULfL0trRDJHrlB1s2lMCL1o2PAfRe+H
 0pE86CTxBYMu8ZNEkrWc+3BORYnHfQ90aWZVU7aHAxES0o+Q4BGpkuSmm0RnpRKF9C
 RzUdwJd/KmFpg==
Received: from yukiji.home (unknown [100.64.0.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laeyraud)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 6877E17E1537;
 Wed, 29 Apr 2026 11:59:20 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 29 Apr 2026 11:59:02 +0200
Subject: [PATCH 4/4] drm/mediatek: mtk_hdmi_ddc: Fix non-static global variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-mediatek-drm-fix-sparse-warnings-v1-4-d95c4d118b83@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777456755; l=1116;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=W6kBXnqL1ax3ZXzyT8a/jimZTefvz3wCNS2vOEoao0c=;
 b=aJkw3nLCwNRHWjwPpuDlzNgOZNC+o8lbUYKcBJxa5S2+TdYA1QQZTNiekWWBqcD9aprylOGss
 7cv6zEJbPGiDt5mURutqePiG3PH3+eba+4B+/leeNmPcIdvBsU4eX8p
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

The struct 'mtk_hdmi_ddc_driver' is not used outside of the
mtk_hdmi_ddc.c file, so make it static to silence sparse warning:
```
drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c:331:24: sparse: warning: symbol
  'mtk_hdmi_ddc_driver' was not declared. Should it be static?
```

Fixes: c241118b6216 ("drm/mediatek: mtk_hdmi_ddc: Switch to register as module_platform_driver")
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
index 6358e1af69b4..2acbdb025d89 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
@@ -328,7 +328,7 @@ static const struct of_device_id mtk_hdmi_ddc_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mtk_hdmi_ddc_match);
 
-struct platform_driver mtk_hdmi_ddc_driver = {
+static struct platform_driver mtk_hdmi_ddc_driver = {
 	.probe = mtk_hdmi_ddc_probe,
 	.remove = mtk_hdmi_ddc_remove,
 	.driver = {

-- 
2.54.0

