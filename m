Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F7FCD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 07:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B358D10E6DB;
	Mon, 18 May 2026 07:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=freedesktop.org;
	s=20240201; t=1779090103;
	bh=CalwLlXFzDUjXmYiE7ivxnx47CVxlR4tYNfZkN0ojGU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iPpbLoIVhayxw4e8eARkP1WzCXLRZu37EEqLZXBLjoMvyyvfvYknWnpq41McGDJ8i
	 sGEedN355Lm+C2iyxxlXQ9YFkZE3OuDfhHFGI5OFaKY1k+syIFWFSfd/I3JzzYSo7O
	 A5qctbQA+ddXYfsLlfkcwLmDlbdZKeY3XGkkoLEXVgE1bW44dCOQ03vVbjqX4hTE3Y
	 L8TM4aKhuuO+wJysQ7y37FleKJcTyUCp4Ky1F4AMp3C6SxmYChuPp1HQA9YP1w28k/
	 v1C/HI524JVmgt4Sgz22/4fs3l8jPiFixj0XNun69tn1vHuhpDIxetnpDISbDlvX+i
	 SygfEHoer1ZlA==
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com
 [95.215.58.186])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA95A10E064
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 02:30:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
 dkim=permerror (bad message/signature format)
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
Subject: [PATCH] drm/mediatek: make mtk_hdmi_v2_clk_names static
Date: Sat, 16 May 2026 10:28:59 +0800
Message-ID: <20260516022859.187887-1-sunliming>
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
drivers/gpu/drm/mediatek/mtk_hdmi_v2.c:53:12: sparse: sparse: symbol
'mtk_hdmi_v2_clk_names' was not declared. Should it be static?

Fixes: 8d0f79886273 ("drm/mediatek: Introduce HDMI/DDC v2 for MT8195/MT8188")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
index b5c738380dc2..a8eb6fd0908b 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
@@ -50,7 +50,7 @@ enum mtk_hdmi_v2_clk_id {
 	MTK_HDMI_V2_CLK_COUNT,
 };
 
-const char *const mtk_hdmi_v2_clk_names[MTK_HDMI_V2_CLK_COUNT] = {
+static const char *const mtk_hdmi_v2_clk_names[MTK_HDMI_V2_CLK_COUNT] = {
 	[MTK_HDMI_V2_CLK_HDMI_APB_SEL] = "bus",
 	[MTK_HDMI_V2_CLK_HDCP_SEL] = "hdcp",
 	[MTK_HDMI_V2_CLK_HDCP_24M_SEL] = "hdcp24m",
-- 
2.43.0

