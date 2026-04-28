Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A75FF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 14:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C93EC10E0D7;
	Tue, 28 Apr 2026 14:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bumDd9O6";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95FAB10E0D7
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 14:05:51 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-446fea16729so432726f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777385150; x=1777989950; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bRQEHJ1gmgZAbyT1I/zyFm8qCQLY2gss42m4vu095n0=;
 b=bumDd9O63xbP4z3MsL9o7TjYaMWVP0lGBNc310O773Vup0IljVvRvDu5HAr+2f+G4t
 yfG8wMZ2BJyyeIzJ83/gwFI4jFRmVUXI0cTsFscyatqaAB2TW1ych2RACy9H36PSMIsl
 c9ZnSiwHH3ULtmZk14ijHfwfhM/i+I+USZ2J6d0WWvr7kfiTWdX5oYFQIjrHqfznnyFF
 CCMOIYJTZr7tUJ5HykWbcFH0uQ4RmMmGDCRdIA5ilcP3zNDbIW9xPiMR4o8KwADKSQYX
 Y/rrhReOuPbKJoCZS6IImJIVjuDKBgObdxsTM+0q+JEUaoBwGYt0mtUOljqBOea9ESjM
 w/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777385150; x=1777989950;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bRQEHJ1gmgZAbyT1I/zyFm8qCQLY2gss42m4vu095n0=;
 b=UHPlA8kbcg/sMUqpabxO/0HXp/PUtJOb0ODJ9Zs7YaRDJFd/w5Ef+IvUg1+HLaHwq5
 n66BMop5NVpMaqkdjOa1vFTRdrzj94yItfHHJZgkxqgHqNRrF2Gn67NwJJh+gppDLisA
 NgsViBA12QN1SuoDan7PNmluYTBjmK9nt5x+ty/xJKJDWjYxwoxGj85Fj3dy/VwHW0Hp
 10e1IftoexJYKqNket2PeSecdIWn70b6UB2aktsKKcL39UV22RhqTV7CN+QxBfF0Plc1
 m88HN09ju4OlonqbPCfAQPoRLmt4/LnAogxnG76OgysNL3TEFf2w5A2m1PfzM9MsKZ/V
 mTMw==
X-Gm-Message-State: AOJu0YzYmBqBTPjtUrABwbops9ESmP7fT58FNhfa2/TReD2p+YOqspOc
 Q13iO/pKzi/BmwJbjdVuHMnVkFapMmKBg9LWKA0B/W0TrVfTSjQA8blppN+eEk3UtxM=
X-Gm-Gg: AeBDievkdlMbrOo4fW4sARI16sPxnqa2fg5MeNOyX7+LDkrdVHhV7vUgELrs+e0ZjeF
 9NNWaFvknbR4eoZ5JzlTMNxHYqHjLVK5mC5kS3YiSs+B3ub/SHWTxdFGP7qpRyI/GNSwDOZbQty
 CMmo+plHmsqfNgDdz0/liq1Md+W3fIVUMDn7H2Em5A6mD/kSlElgbQSszdlpfsTEoVBDrD8D8d4
 620PH7WSbfiSS57SQdk1xqahrhto0RLKy6EyhvFBOT7RjF+a4Regeiljb1hjNjidZ2C/6GDycLM
 16lWI5L2xAYN2ZoGTg21bxEwp0K/RV6yX3IQyRsZsqBgoHYSv7cTGdjEWdK5KGYVRGFw5ca1GVG
 q/DsQEW5YF4z/6Iz5Za8POvseP/Kfso0EaPrsiG/30b4Gy9Fcw0LMfBFBXt/7TZWnJa36Prl6L8
 oCK3MXbOpeR/5dR798+SE2FsoWGe3u3EAwY9Xe0Qgsqps5pB7fS8NJZr4=
X-Received: by 2002:a5d:5f54:0:b0:43f:ea25:20ff with SMTP id
 ffacd0b85a97d-4464a1685e0mr5748911f8f.29.1777385149896; 
 Tue, 28 Apr 2026 07:05:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4464004ed80sm7143264f8f.34.2026.04.28.07.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 07:05:49 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] drm: panel: support the R63419 based dual-DSI video
 mode Display Panels
Date: Tue, 28 Apr 2026 16:05:45 +0200
Message-Id: <20260428-topic-sm8650-ayaneo-pocket-s2-r63419-v1-0-981eb5ab5a51@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALm+8GkC/yXNMQ7CMAxA0atUnrGUmpAWroIY0tQFg2iiOCBQ1
 bsTYHzL/wsoZ2GFQ7NA5qeoxLmi3TQQLn4+M8pYDWTIGUs9lpgkoN57tzPo337miCmGGxdUwuy
 2tt0jd2RdxzQOZoKaSpknef02x9Pf+hiuHMq3Dev6AauhPEeIAAAA
X-Change-ID: 20260428-topic-sm8650-ayaneo-pocket-s2-r63419-e72467e2db0f
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 KancyJoe <kancy2333@outlook.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=910;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=88pgZhsc8E1YwM4QVADZ+eYx9jSwGydBUbXrq3neU5Y=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBp8L67GKe5ofqeuJ8rIeXlAFfbCbEimZSktcmLWvLR
 D/De/gKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCafC+uwAKCRB33NvayMhJ0XEED/
 9TvNeA+di5MIBpxZOFwW2ddOJGqL9cu9ZgKv3w4xNlVpaHUT8LbdEOIlMdap8lo5IqfjLNWPRncIUQ
 2Ysxv57Wbaun6wt6puSjABTBM9Mwvy2mUSakseGinNp/H5MLiWA1KEeGiuTRYFxPcR/3k0jGL7zA5C
 7SQXTAB8gaWht1BEncZATE0aRWC7hAFpUI0JSFGt55DsT0QlBn6gn9rcPtyfyOG+tx1SrlN7Rbj5wu
 X7+Gqn879GevK01/3ya/ZYUCqYBCiWtwEVrsYYFQkgwWDFakW0j0P22pyO0I9B4vOXoGPGTJ0wD1wM
 5rTGVDjbyiSz0ekhf/GdoTuyfmAyvLYxVs6ReDyJBFQEF1CxuLi7SDCYYx8iSFYodwim39AIo+PQHA
 LiNbIjs6jzeOFKPL5eg0qnfyagytd/oN3+asZ32kz8I9MNdgefR/bcAdW0bRdX1qSX9Wly0lEdJW9v
 qLC4MFho2/9M4LMvXI5RJNIwG4brTBJPFsaIi3A8DHjkkuGpIu7orqW10CBc5byuxsje9aSR4Lj7/e
 R0mgURJOPoHxURxjUELThRgvvUv50RogkbXyMvhKnSPBtUNMP3QvWNmqEWDe8SrQ5YkhV3zNy2rVqf
 DvPzltxQ6MqwjP3ff4LHpLBIDj/PKtYktZ2V5BELAqnzArsj1IxhhfXhrbyg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Add support for the Renesas 63419 based dual-DSI video mode
Display Panels found in the Ayaneo gaming handled devices.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
KancyJoe (1):
      drm: panel: add support for the R63419 based dual-DSI video mode Display Panels

Neil Armstrong (1):
      dt-bindings: regulator: document the R63419 based dual-DSI video mode Display Panels

 .../bindings/display/panel/renesas,r63419.yaml     |  92 ++++++
 drivers/gpu/drm/panel/Kconfig                      |  12 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-renesas-r63419.c       | 356 +++++++++++++++++++++
 4 files changed, 461 insertions(+)
---
base-commit: 39704f00f747aba3144289870b5fd8ac230a9aaf
change-id: 20260428-topic-sm8650-ayaneo-pocket-s2-r63419-e72467e2db0f

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

