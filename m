Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBE7CD4F48
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 07:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 567DB10E2EF;
	Mon, 18 May 2026 07:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=freedesktop.org;
	s=20240201; t=1779090097;
	bh=/L/b1kb2A0aLZQKgM8N0427hYFHPpG1CPzZpXsCaM00=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=R8tQa8tdxVzMXeFmY8/xvzN3q9y9lR7BOXD2dhfbKuZBvBEAsveO29+fVTKkBSyPK
	 GPmS6GTvmw0x9yyKignGlcVbzC+qSF7ynZdm7sdy3vOW+sSaTvQn+Y5zNyh00rkDcU
	 Ifb1eoG96S5gCHEIhl3IVfPwt9d1HCjJQX6wE88Cc5x2RhuR186etPV2HMrUVYBo8a
	 agf4Inec+H/7JsI/nhOVkDvKlr0exG0BqPO+HOj3KS7rGaTY3ZeSODj9Ay5t7cWZBr
	 6qGujJlj0/gbBys9NwrtzFskfNyWcHnCDhR0QcqLehfaF7ta6fpZ+XQabDLYrSmNtV
	 V+OFxzFFyDBcw==
X-Greylist: delayed 499 seconds by postgrey-1.36 at gabe;
 Sat, 16 May 2026 02:04:47 UTC
Authentication-Results: gabe.freedesktop.org;
 dkim=permerror (bad message/signature format)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com
 [91.218.175.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5016E10E064
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 02:04:47 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: sunliming@freedesktop.org
To: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
 simona@ffwll.ch, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com
Cc: louisalexis.eyraud@collabora.com, ck.hu@mediatek.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 sunliming <sunliming@kylinos.cn>, kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/mediatek: make mtk_hdmi_ddc_v2_driver static
Date: Sat, 16 May 2026 09:55:07 +0800
Message-ID: <20260516015507.132866-1-sunliming>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Mon, 18 May 2026 07:41:36 +0000
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

From: sunliming <sunliming@kylinos.cn>

Fix below sparse warnings:
drivers/gpu/drm/mediatek/mtk_hdmi_ddc_v2.c:384:24: sparse: sparse: symbol
'mtk_hdmi_ddc_v2_driver' was not declared. Should it be static?

Fixes: 8d0f79886273 ("drm/mediatek: Introduce HDMI/DDC v2 for MT8195/MT8188")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
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
2.43.0

