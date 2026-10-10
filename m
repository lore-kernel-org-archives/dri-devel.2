Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106DBCA9EBE
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 11:56:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F13B10E6E0;
	Sat, 10 Oct 2026 11:56:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BV4/hlDz";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C385D10E5C2
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 11:56:10 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48afe0081a6so327517f8f.2
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 04:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791633369; x=1792238169; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7cQlWEs7vG4qRpaZiwY4RuZzcs0XsJM2mV6rRYet5I8=;
 b=BV4/hlDzk8H8183PCGIrYn1X9lkKlM1bGdAnDKWCnTjXpPOcFb86YYE8FZquLkpkL5
 1R2XhUVzX21GmF3u5OW+uutnf7I52IubBMb9zxmEU9gAxECWABokZEOVa/vo8+dO6OZW
 1Yxa6JzNwZQMWmQ9G8R6Bqk7sgXw49MiFFANf0H73E3uL8OtdVPyy5teIyD7IYF6Xyzo
 20dVnXH72cgzsJKBzM0rjlLvRAAtkJcDjJeFx9wkyGtc4uIwT8bdlGxMdmp5RVkiZ148
 Os4m7fboStCaf3BmLhm9kH1QfjtNJF9ZXA2O1TXyx62nm1NLVk4Br9m5lgZ7dkkzQk/i
 4Zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791633369; x=1792238169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7cQlWEs7vG4qRpaZiwY4RuZzcs0XsJM2mV6rRYet5I8=;
 b=d74OSCqb0jfi9+RTNFw4cuL7vLsYfvFS31aUolgjMhXZhw/hwVf3KLt2W0h1m5RvlL
 tqoCd+RX1ZcYPfsfvSkPb4DBIgdRa2fWeRxqULsej+BQ40+pIEqURMbxIeUc358/f+5H
 w4D189/LE6tugEvxMixI+xzjA8h8FuF+O7UQqeqxM7lS47ukW/eXqTk1IIG6DRu+gaIv
 5+LtQfsGJTAuxK7YJTzB/NFePic31dvQcQZPErFePDHdCEtIIJax9nYC2k9FuSFnkDpM
 OVDc3yzMtvsaT25cZ9B40Uftyqps7aaYSQk6mtyOdGSSN6U98OdORODtM010bkQJA1Gu
 AoGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPbJ6xydxjc7kCZGkAiKQbzyYKl64DO+8Hz0lYKNF9TWsqf0832OWlRHTNaPZYWRhyCKuUFd7KeZ0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKEuBT9RiWjHP0MvNFfMGZHp9Zb7tl2HglZNjxy81BkB3LOa+5e
 Tut2UWfqIWeQ08vBWeCZcW4Enbym/1JdhxdVmZ4PWpfIZR8aXQXwc0F4
X-Gm-Gg: AYBFou30TNeYHeNoomGAelIWLW/q40oP8nog1EM2c+d1JqrdeoNgPl6nSSwxAfC9ZTR
 zGxOT5efYSTEnucm2Up+23M6FH8jUHMr//X6L+BldzK/Tn0tf6/OPKttR5h6DtmKBLLzQZLj19n
 dfw8M3lwNbuncWAKcYmvyUeWeAZXfmZoBREcoMSawN5NS3bi97v4gO+bD/Wq624sVq46vfqk8M3
 HrBtecp/c6ht290F6msiw+DghtobYriVCftFduHJ1Ylcl6q9cDCwTAq53VJZYpTO3rZQCYP9fe0
 uYnSdaHIFS01U2PiCTDORBY7y0ZW2h6lVlhhGxNAqhwV0xt7NGIOq4lSPwG0TYXsnKVE2GjS0hj
 WgHiQcD5OgFS+6UVDNRr9oNLi8If30btAsNVzxTfpowPReH3O7ynqme2UBf1IZp0YbNa6O9mcH2
 IfuGz4BphkR/Qkn5UyfWnIwY+ta0Qoi1U68izHsZm4pxzGznjKEi5SZpH0+LvztG0M3A==
X-Received: by 2002:a5d:5d09:0:b0:48c:6a6b:69b2 with SMTP id
 ffacd0b85a97d-48dbaae7028mr6208118f8f.27.1791633369101; 
 Sat, 10 Oct 2026 04:56:09 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9aca657sm8746340f8f.43.2026.10.10.04.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 04:56:08 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Fabien Parent <fparent@baylibre.com>,
 CK Hu <ck.hu@mediatek.com>, chunhui dai <chunhui.dai@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 5/7] drm/mediatek: mtk_hdmi: Set tz_disabled for mt8167
Date: Sat, 10 Oct 2026 13:54:05 +0200
Message-ID: <20261010115539.9237-6-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010115539.9237-1-l.scorcia@gmail.com>
References: <20261010115539.9237-1-l.scorcia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Just like mt2701, MediaTek mt8167 does not require an ARM supervisor mode
call to toggle HDMI output.

Fixes: 511cf7d12331 ("drm/mediatek: hdmi: Add MT8167 configuration")
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 738090a47176..9896eaf81e7e 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1214,6 +1214,7 @@ static const struct mtk_hdmi_conf mtk_hdmi_conf_mt2701 = {
 };
 
 static const struct mtk_hdmi_conf mtk_hdmi_conf_mt8167 = {
+	.tz_disabled = true,
 	.cea_modes_only = true,
 	.max_mode_clock = 148500,
 	.ver_conf = &mtk_hdmi_v1_ver_conf
-- 
2.43.0

