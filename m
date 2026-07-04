Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE30C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 17:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5945B10E0BC;
	Sat,  4 Jul 2026 17:44:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sjcU2hC8";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13F6910E0BC
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 17:44:34 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2cac59f8b64so17832225ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 10:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783187073; x=1783791873; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z6ud/EPfqlMZplwdn/5Y4rUm6oDx99RAJ6/NlqJ75W8=;
 b=sjcU2hC8bL5Oj7aS67kwEXkPECmGKOttv7gvCvwq3uqTjIysUB6X/Kk3rr+NCtwKxa
 Ch7evoAkAfgUtUx7kppkfhxMAI0SzV2Z95kVfeAxHje+zFOY2oGGDQKEyW1/5keGYSg1
 FCYxbvh50MFc5NigGLBQSPEEzrl4BrWr2i6ktz52gJDak7Cwof6FeEbWQJPU7Td0IH0C
 0GOaqorcboxtuRgwgAZVgFkREXdLc35M1Wgc9RjWfHmWaZ0yem18kyfAlKGoEA6bV56F
 kZdiZg0vv8WHTJNVidbwSheMKF0vo6z5mingudKKdFf2yLiVeGhdQtqESg6trmTWmQOc
 kYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783187073; x=1783791873;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z6ud/EPfqlMZplwdn/5Y4rUm6oDx99RAJ6/NlqJ75W8=;
 b=obqtJO/lcGNOgg/j7eeMAEQtnKPOSXLf8shi8al3NZjFJMiUqb+0oI3OYrIqDgfB35
 yk6y6OzD7/8+i40gnaLiv7RRzT06yfNB3boKrOFrnTowakVSdOgM3FvUIKEbhGoOLGqV
 /MpsBgmmjzqy4L2XJalEPaKWMU7pyMyEOQ9zeqKXg0nLzedeCc4iAO7qJHJH/UtuAjCP
 NU52jff38bhx0Sj8b1hCCrwndZoEUOCLUR4pS6HPkD+ydppsu9gI8EUQo8gbMEHsLmQ5
 xbHDeQtSdNjokrWzg6y2r13YEgqMbaLFYrr3E6yLQhfavk/4rt97kdZlZB07gcYjkI0C
 VYiw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpw9l25eIbaidvNjCPLxSAgKrt8nZPCX3VUjuAcirXf1Q/sClMa96HMMpxz8PTVGjovz7wY+0l5ZxE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxooILu1Znh8JJEVnMtuxCQpETaS8eOv9cIORCzvL1U6vHupNWb
 s72i1lxn6HodV64rHCHqUnz/mNzJ+zRJrds7UCwYTZCHbQDlV/IwVnoB
X-Gm-Gg: AfdE7cmIqTFSlYUeLiZQ1tSYfCuonpMgx5mkRKM8xlRvNaYI7pB/4P8viv5v5aWwKBh
 7ogbWIupWIoa5GmeSE7N+MpbT6WsvROSfoWF/K06gl1oOAdZsqZu4OofOY1474PZ8r4nFNz/BSt
 WnfzCmyQITIGYEjkavaYSecf50lGKghbgNrDXVHiUE/t8Kq6UaX1yEZ8vk2s+PjdooN67mKDjWI
 bjnYnSWl1fzRTtT6xCtw25gCrNqJN3ebxbENlDG4zHkPfyQe9fIkt6AXNMoTM40Dj/3bf/WZ1p6
 ZESibCCDZjyeyvpPWjAGsNJ9pHqRRIAKLYrWjI3q9D6BObLwvf6IPff+SFa8xQW8nflbE8GAtSB
 uAEiKr3L7uQT1wQyfD2IAZ7a2VyocVCL/aQ4DQ+jytmV3j1g5MzGLKvI575rWGhUQ876rJkU=
X-Received: by 2002:a17:903:32cb:b0:2c9:b01a:fbd4 with SMTP id
 d9443c01a7336-2cbb7511bd4mr37563465ad.16.1783187073499; 
 Sat, 04 Jul 2026 10:44:33 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad78a3e76sm24836105ad.82.2026.07.04.10.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 10:44:33 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] drm/mediatek: mtk_hdmi: Fix DDC adapter double put in v2
Date: Sun,  5 Jul 2026 01:41:13 +0800
Message-ID: <20260704174113.255485-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

mtk_hdmi_common_probe() gets the DDC adapter with
of_find_i2c_adapter_by_node() and registers a devm action to release the
adapter device reference with put_device().

The HDMI v2 remove callback also calls i2c_put_adapter() on the same DDC
adapter. This is not paired with the find helper and it drops the adapter
device reference before the devm action drops it again.

Remove the extra i2c_put_adapter() call from the HDMI v2 remove callback
and let the common devm action release the adapter device reference.

Fixes: 9545bae5c8ac ("drm/mediatek: mtk_hdmi: Fix probe device leaks")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
index 7bbf463056c9..e668506daf67 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
@@ -1501,9 +1501,6 @@ static int mtk_hdmi_v2_probe(struct platform_device *pdev)
 
 static void mtk_hdmi_v2_remove(struct platform_device *pdev)
 {
-	struct mtk_hdmi *hdmi = platform_get_drvdata(pdev);
-
-	i2c_put_adapter(hdmi->ddc_adpt);
 }
 
 static const struct of_device_id mtk_drm_hdmi_v2_of_ids[] = {
-- 
2.43.0

