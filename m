Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B21C79FBB
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4882F10F0B4;
	Thu, 10 Sep 2026 22:38:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bDeNH1TL";
	dkim-atps=neutral
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com
 [74.125.230.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A62D10F0B4
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 22:38:14 +0000 (UTC)
Received: by mail-qk2-f12.google.com with SMTP id
 af79cd13be357-93910ca5aa8so26825185a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 15:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789079893; x=1789684693; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lw0J18o8NMgLkUQr/yomujhpoAzqRd78S+D2/pgaPdk=;
 b=bDeNH1TL8osxd0mo7c6fiu3VUYK4iG3qyszAeYdxkQyv0uvUq4W1OnT+NYi1p6rOsu
 d2D80ZuIxMwPsShwavPGgBhAy+QYrlz+dvKSwb7LRKZJY8QD3dELkBt84+7VPJvWAqaT
 iw+2lL0KAwDhGBhs4nOGEHiwWIIIcxGWKYsVUqi4AxbNwSa7nou6gLtoApeqi7nIcawr
 +f3tYg4p8SqGDUxLKlOsxPzE95BfYPQWlCpRTLubVbygPWt2p5Cu4XinkO4UWPWsMHXf
 91/wOV+lIP3wtV0/I/c3XXjnVnBMOmESdwFfy16TxIHTz1mSVSvf/d+euis+DCi3rorf
 AYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789079893; x=1789684693;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lw0J18o8NMgLkUQr/yomujhpoAzqRd78S+D2/pgaPdk=;
 b=YMVNu21vEoJlto23ieVlaJJZGwJxf7x9gaaXCXVO/TMSQ/oi+9tFITo/TnbgP6H1Xb
 ISZeWMJda9XjW758nWcTJhskarU+luLrTTQkPrRufY+0HDXH3ZfuhRDAhL9ohcE1/J1Z
 ZWh2oIQ6BAhA4/4z055bgJzyfWQdlf5DFUqYYOGP2Yaim2eMjHqwLZfKUaKi+Rcj6fZ2
 ibwpjSHjAqA9jpcLwoG8xGbYqtCbr+j4/lXQ569GXPj38/tg2IZd2FQYGlhxnW8wXnrV
 yUHAGQpkoRSLwKF5nFLuGi3w2XaNMRwR1XSXuNj0PmDA+7+19rfNPQiqZrYymUo0E2ul
 jkAw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNFjyiHPGPniCQUnLLFj5sQ66qMqNFw68tYeXre6VaSkdmktXGSzjvdsQnLJBdvsGjPuFSt6fvlek=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nzFm1siQLMtSvqnkkWeyD/1PQkkAuYc6sT4CuvlsUN9sC4RGex
 gRg1xq1LI4a7h7tDb9LnWBczskBbZR8LGy4ysHjnqjJNiyP88pY9m5o=
X-Gm-Gg: AYBFou195VYO+F+iyzxJ9qh+PK04m7HaQP7FewyXIlxblMi1t+HUmZHUFjz/NSgtB/i
 w11xMN7+Bx+7L12HvO3DvGJpZTzZkeIpB5cA8U9C6bz98eXnivZxZjaZe2Ky7RbtnDXulO9QwVh
 4SnVNBM6beYf7mmNrJk+17XTv+muZg4Ig4cOAlpaPz/sS4lqlYP1SMCxD2xDVh8HM4bn5UH7039
 c4b19B7FwaCjnUwhVbbCSKjtvz5V9RVCdior+/oVCTcvyg/Q2+Go8VG4z9TRA7L0C7GFl14MXtf
 LKXcBxyP1ahc7zb6clMfho6t23dMdn9RQt+BkQ/tsixdt0IbUH9WTPsxlOkTSG/6s7s1oWp0/vn
 DaezMLDj68cuMO/0YcgkKVlfNri/zuHB2uL0vZfPqa28OfThxJeHjPTe8/LfHHy/u9dnbIKkgJ1
 ePi0crivEFgB0C6yBCX+D6wbHIQbGffJJQ/+oGtHNV7tadSqbENDCX2RhW83xLSg4tJQ/LkmEiV
 YfVrFpo4cidTHh6YIFmEoZghiJJaoNMvH7zmn7PYsWynn35eCT3JP1KpdO38JoWLj94QSarMjV/
 Sct72FH1cUXKRt9LyBWnfGHITF3KNY4fsw==
X-Received: by 2002:a05:620a:28c4:b0:939:518d:7f6e with SMTP id
 af79cd13be357-939ea137501mr198587685a.22.1789079893180; 
 Thu, 10 Sep 2026 15:38:13 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939e803dc90sm90487685a.17.2026.09.10.15.38.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 10 Sep 2026 15:38:12 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Thierry Reding <treding@nvidia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/panel: simple: Clean up resources on DSI attach failure
Date: Thu, 10 Sep 2026 18:38:03 -0400
Message-ID: <20260910223803.8552-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
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

If mipi_dsi_attach() fails after panel_simple_probe() succeeds, only the
panel registration is undone, leaving runtime PM enabled and an optional
DDC adapter reference unreleased.

Call panel_simple_remove() to unwind the common probe resources as well.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 210fcd9d9cf1 ("drm/panel: Add support for Panasonic VVX10F004B0")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index c95964ba25a9..767068de6816 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -6552,11 +6552,8 @@ static int panel_simple_dsi_probe(struct mipi_dsi_device *dsi)
 	dsi->lanes = desc->lanes;
 
 	err = mipi_dsi_attach(dsi);
-	if (err) {
-		struct panel_simple *panel = mipi_dsi_get_drvdata(dsi);
-
-		drm_panel_remove(&panel->base);
-	}
+	if (err)
+		panel_simple_remove(&dsi->dev);
 
 	return err;
 }
-- 
2.50.1
