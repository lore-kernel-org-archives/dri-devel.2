Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F19CCCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 09:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C27FD10EF1E;
	Wed, 29 Apr 2026 09:59:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Sn1c1ARp";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CD8610EF0C
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 09:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777456757;
 bh=LyfP3fNgBZbx3Y7bMZIcMNk42pMyUhQMoz9M6xKuTBU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Sn1c1ARpDTFmUw6OvH8jUoV7ESk11yWm/zJ/tSePIlq2U2WEU9iV05grUeHDFt6YX
 +rtDQbWBh6QeNSOYpSM2Pb66Cl16nPZezJpJqqApzVpbPKLx88Ca2Okw/q5cHkUEzj
 3nQfaeAjUyUwde8AjBsGyNws+eHwRYEa0HksFAnmoPsrmYfcVYPBuxZ1EVGojpwb09
 u56b18ImAS51f1urLUN5e8lMSByF4AxHxmaHQZ5zOzn5VgfW4ei4X58baJJm3lAf3a
 9nwAR1KXaXqMSXF8AMRcbLD7l88WUcJWTqsszx/fGroUTSWx8UTBIk4hD5QDxeYAzM
 7dnYOPGEdnVvg==
Received: from yukiji.home (unknown [100.64.0.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laeyraud)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D514717E1502;
 Wed, 29 Apr 2026 11:59:16 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 29 Apr 2026 11:58:59 +0200
Subject: [PATCH 1/4] drm/mediatek: mtk_hdmi_ddc_v2: Fix non-static global
 variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-mediatek-drm-fix-sparse-warnings-v1-1-d95c4d118b83@collabora.com>
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
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777456755; l=1276;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=LyfP3fNgBZbx3Y7bMZIcMNk42pMyUhQMoz9M6xKuTBU=;
 b=BneHREU+huFw3thbhe7FS2zvw8FvXQGPmcNzalvbNjY2xpbm0QYcyQaHN8eLPMrkSBRDFKtAK
 fnKnQV1qajKAYGBCAB3bRtU7C3/2NLCzmOpIGO1w3sEpRrhpCepm+/o
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

The struct 'mtk_hdmi_ddc_v2_driver' is not used outside of the
mtk_hdmi_ddc_v2.c file, so make it static to silence sparse warning:
```
drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c:392:24: sparse: warning:
  symbol 'mtk_hdmi_ddc_v2_driver' was not declared. Should it be
  static?
```

Fixes: 8d0f79886273 ("drm/mediatek: Introduce HDMI/DDC v2 for MT8195/MT8188")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604132044.fcYjEcU8-lkp@intel.com/
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c
index d937219fdb7e..31e81a6de6d8 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c
@@ -389,7 +389,7 @@ static const struct of_device_id mtk_hdmi_ddc_v2_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mtk_hdmi_ddc_v2_match);
 
-struct platform_driver mtk_hdmi_ddc_v2_driver = {
+static struct platform_driver mtk_hdmi_ddc_v2_driver = {
 	.probe = mtk_hdmi_ddc_v2_probe,
 	.driver = {
 		.name = "mediatek-hdmi-ddc-v2",

-- 
2.54.0

