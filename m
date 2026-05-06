Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84846CD342F
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 00:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C528810E487;
	Wed,  6 May 2026 00:51:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="byFPnbQJ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1015110E487
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 00:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778028658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vdyTB1Bnm4PocyZ2yzoZbA1lY3Pfiu6QGknE0aPv4gU=;
 b=byFPnbQJYHIXjdVk1Xx6UsflWGHYrycvFN90R5H/Ns1IvjgzEEirLRf+NKozi4FDTBjJLN
 CVY/RPpZ5Qn8HlIrE+uZVvEEVW4eC3Q/PF47bF92zUT07yeareG7muHIrIQbZ59LPeKjKX
 T4fIVp9fU+okbwFXBUNC/AeHddTI+Yk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-KAPTrcaJNMOZZ_hxs1_nMw-1; Tue, 05 May 2026 20:50:57 -0400
X-MC-Unique: KAPTrcaJNMOZZ_hxs1_nMw-1
X-Mimecast-MFC-AGG-ID: KAPTrcaJNMOZZ_hxs1_nMw_1778028656
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8e8950b3ee1so1769505485a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 17:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778028656; x=1778633456;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vdyTB1Bnm4PocyZ2yzoZbA1lY3Pfiu6QGknE0aPv4gU=;
 b=FYzK9RDvsGQE/HVcNTcpEiLOC7EJo0zNO0hKpuSPSdwraln+FWr2NaBQhBixAknKr8
 p8jerbVF/0khGhR7itgT9SY0aWYMoD9VXa5V6P9b7Fi2uwKsQfbcNx5YAUJcVbwZTaUR
 vfHt4temJGY05W9Fu3dMYZY5Zo7WPH1pWVLPq4bR+bpDtWyUugI3lfRvg51fqoVSb4RW
 QwhsFuEKvRtAzxWQor8Hg15uSSquNPTKvKTVq3LuJ4DFgbOHuuKXTIkmWdw5JdhQ+c1x
 Y+Qfd+HiHKXxI0HHcDhOyGf2IyvlF8mn3WADkxF5TcvAzD2VI4F/BgQEkRLvEPYMDN5O
 ytcw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9P36neLZKdsHj4pgnAGNaiFnx16ME40foOFtQi55wtF1HAdIujhh9ztxPLWtkpwlKu1sNWaohRvg8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3a/3HqG9msSGdHpTt1bfGTX7g5uSEL+v37FRzvjJuu5orFN0+
 qYxL3okc3U2Am1CKU/JKrlJa7XoFG5j3mQ7Y1liKjVWJhuQkBa8zOTytUp0amowWYrOIFL9GSFa
 yteWcIrR1ZEgtvEIaFV6zV8TITiSmmVgHxU1O8ZSSQQNN0XPObyj/LznGq1lSHqL91rsv1A==
X-Gm-Gg: AeBDieuvZUe+GL/We7anD1PK+zajutVZb/j1e7KD+J0tpX2wSNFqYbD2wwM/NYRHElN
 +tE9NCQFUqvyXZsKiRuOHP7A6jLf8xBEuEOwJSOk25T6mNHnAhmfsqI44r0RkT3tbRZ7Sa3X+si
 esaYIHSiv/9qSOdorT9bM6OXmmpUUnITPHicBzRnS8WLNJ5WDIxT+di7k+8wkX2w+WsNAO8UIKF
 oMDBetyv3oMzlxwEdllJa6UbXA+B9a0nYFQkMipQKv4/pwips57ZdzvstMbxquEdDVrPQSUvViS
 RbONcjdk9i40U1U8Xa9D71PBQBTzkuMCKhv0VktXlyCi5X3fmH3JVYMsj+jxyLmjh0JjXUCwKTp
 59mJdSEMTwY99btNy/LZdPVYtkVj8fle25zIgR6WpW8/jG2/wullc0lvB8yowSxIAN6oSbK8M
X-Received: by 2002:a05:620a:25c6:b0:8fb:1acb:ccdc with SMTP id
 af79cd13be357-904d63e78b9mr222382485a.34.1778028656501; 
 Tue, 05 May 2026 17:50:56 -0700 (PDT)
X-Received: by 2002:a05:620a:25c6:b0:8fb:1acb:ccdc with SMTP id
 af79cd13be357-904d63e78b9mr222380485a.34.1778028656127; 
 Tue, 05 May 2026 17:50:56 -0700 (PDT)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net.
 [73.183.52.120]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fc2c91fb3bsm1464933385a.41.2026.05.05.17.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 17:50:54 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Tue, 05 May 2026 20:49:09 -0400
Subject: [PATCH v3 13/15] phy: mediatek: phy-mtk-hdmi-mt2701: use
 clk_determine_rate_noop()
MIME-Version: 1.0
Message-Id: <20260505-clk-determine-rate-noop-v3-13-f3f829fbacdf@redhat.com>
References: <20260505-clk-determine-rate-noop-v3-0-f3f829fbacdf@redhat.com>
In-Reply-To: <20260505-clk-determine-rate-noop-v3-0-f3f829fbacdf@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-phy@lists.infradead.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1910; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=5KLGvHQlEx3HE68FkoUz+5ZZ08i2Z1EHZbkA0AZsL14=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJ/TfB1aTIvCTNPe8TLm3/hGP9D9n6D3amfYvtPcJjkr
 riR/PZdRykLgxgXg6yYIsuSXKOCiNRVtvfuaLLAzGFlAhnCwMUpABP59p6R4aV4g7mhfH3Mhwzb
 Hf2bsn+/DQ761rkr/csdu8XbuHvjpzP8z9H3ZLl1srR7ccoTl3XGsUUZl/W3CIisyCwKOXhSlJe
 VHQA=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2HrlDzFzkckRe20QaMWZYJu14xww5c9xyd_dXJPIjpI_1778028656
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Drop the driver-specific empty determine_rate() function and use the new
shared clk_determine_rate_noop() helper.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Vinod Koul <vkoul@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Brian Masney <bmasney@redhat.com>
Cc: linux-clk@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-phy@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
index b0b6497e7eed..c9a1f20e939b 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
@@ -90,12 +90,6 @@ static void mtk_hdmi_pll_unprepare(struct clk_hw *hw)
 	usleep_range(80, 100);
 }
 
-static int mtk_hdmi_pll_determine_rate(struct clk_hw *hw,
-				       struct clk_rate_request *req)
-{
-	return 0;
-}
-
 static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 				 unsigned long parent_rate)
 {
@@ -170,7 +164,7 @@ static const struct clk_ops mtk_hdmi_phy_pll_ops = {
 	.prepare = mtk_hdmi_pll_prepare,
 	.unprepare = mtk_hdmi_pll_unprepare,
 	.set_rate = mtk_hdmi_pll_set_rate,
-	.determine_rate = mtk_hdmi_pll_determine_rate,
+	.determine_rate = clk_determine_rate_noop,
 	.recalc_rate = mtk_hdmi_pll_recalc_rate,
 };
 

-- 
2.54.0

