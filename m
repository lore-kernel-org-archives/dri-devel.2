Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E494DC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:36:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5CCD10E478;
	Thu,  2 Jul 2026 09:36:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OxUu7gSV";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A774410E478
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 09:36:13 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-493c83474ddso1176575e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 02:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782984972; x=1783589772; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9HUfqngMBQW9dvZQFJVLsp9jSRJVUMPZ8Pdu5MoNLpU=;
 b=OxUu7gSVfeiovkpoUxoCLyzctvP2QBnZql3O24F+EHk9zp652UqCNSRiHSruKddYBd
 yQlYTJBdDYw9jHECRoJ0Yi8WO1eJc2gttgSe6Mql9djEHx3Qmcvl56nNe9SS6IyUZqtU
 E4atTnGDSYgEqEhJ3kSeEWMXtfxue6Ft9asUnaVjA7eY0m6mmOS4lTvcQnOix8h72NV6
 /e1QlQJbyUv8CNGZZ6h5+mhvFKt6YBK0Mb/IzE9M4mlT2z+pGecXjL+hIgM1XnjbZmUd
 Z3V7JzYMddm5GYOKGQL84bZRWqCR/WdXJ3cZbEhfweaE+/No/ypcFZb3/l6Of/S1iKCq
 b6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782984972; x=1783589772;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9HUfqngMBQW9dvZQFJVLsp9jSRJVUMPZ8Pdu5MoNLpU=;
 b=FK/Bj6CO7TCRoE1XNVpxzL8UJa2BLtdluJGXFunuSChAzMUfNIBryhbESp2R1Izi7z
 Or1pmaHbiJtWbfeLFSevkCnwQk3MFDH6aZzc5Q3NFT5JLyYGGaxKQUrldrE20dAQLaXY
 IV8BUx6UeGeGS29D98LEerFtiQrhhY9DErPV3r+nwnAE+MVf4Jr/jVFnCBrHX8OEw9qo
 G6xaWScEG89RdhQcmzt/BUZcaUE6vhT+CK2tHokeCA8quBtyMKiJjJKBDpawwB0Wpokf
 ijDAB5MHePbWwZzo6UPYjurNhEmKwG2SeB0vY1jv63wLC2ZuGN13QqGtNzSqURtPmQnX
 6mRA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+MAmG2YJ8pajtOTucDisob1gmMS/9LonHJCfMNZPhp/9OKU+lgOvy3l4Fmk422YBSSGdIPOuGPMTk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywu7ZPR+DCLdj808g/yuOZlUY7mG8Kz61MOGlsH0aycz4Q+nGlF
 sQ9ezSPPFA+agqqcGNxi5jLxaO4+qjc2QJZDsJg0wR8u0Xuur5zXJuglTuQIPCv/Sb8=
X-Gm-Gg: AfdE7clePff0V1x6fAaVyFlhTTQAJgF0r+Q/OenomvbKqlfytGbTEAuDlyrjw627PpM
 A07AGy3y7toDj5PmXAUy+gYHAngkJpGUCbvmHMDjTKzwSKouIh8KuFZtg2KwGuCIef+7xxtP5LJ
 wfTphgVqucRu86iavf/GpTlimKx7419hdUm+Hr8mCOxdyYFYOcNXrEwA1+5SySfnXlOzEOc6MoM
 0KaTu1neCpn/JNJwkHz9iJpy85FXktfAHJplZ17ZdTSOyJUq2ZC8QvACParEcQ2n38oD4sE3YYU
 sDDuWMwiEVYF5SLjWNcvj4C4rgcN6ZyAbzwYryjdmwIMWhEoMleS3PR3EF4e1QWYPNYLZzpREdy
 pLXqmXfnIrynVu/P9OOZpEK/Dj4ZadLWAUMUiVEanPyxfe/Q6e+vi526otzaUML8rbtSVAhfVaX
 S7VPVIlxwMuhHP+ZcUybc0NTsBBF6qMJK0tQ==
X-Received: by 2002:a05:600c:a4b:b0:493:bef8:ba8 with SMTP id
 5b1f17b1804b1-493c3dfc635mr57777245e9.39.1782984971906; 
 Thu, 02 Jul 2026 02:36:11 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bf11eba5sm80524765e9.0.2026.07.02.02.36.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 02:36:11 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/2] drm/panel: couple of visionox vtdr6140 driver
 enhancements
Date: Thu, 02 Jul 2026 11:36:08 +0200
Message-Id: <20260702-topic-sm8x50-vtdr6130-dsc-v3-0-db881a3fc026@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAgxRmoC/42NwQ6CMBAFf8X0bM22SBFP/ofxANst1CglLTYYw
 r9b8KIX43GS92YmFshbCuy4mZinaIN1XYJsu2HYVl1D3OrETIJUoGDPB9db5OF+GHPgcdBeiQy
 4DsiFwkKVRaXyCln6956MHVf3+fLm8KivhMMiXBatDYPzzzUexbL7pxMFBw5ljVpoY4SpTzfbV
 d7tnG/YEoryQyXzXyqZVKizIicDBEhfqnmeX0D9COEgAQAA
X-Change-ID: 20260604-topic-sm8x50-vtdr6130-dsc-16c7697a65ac
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Doug Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=998;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=+BGqyMkhsvPCIxm+Pd1uTzBv97PM0s5l73BkbYxqyu8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqRjEJvIrmMcTuljS878F6U5MiTQpKjAYNGGGfYC9k
 xogetNOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCakYxCQAKCRB33NvayMhJ0dX8EA
 C6gIlKaKpO+SPkbFfMhEc/efvcW975yOq5yJc6HdPYBpOoMgzru92OiBwnyC7rCrNDSCQ8d68hiI4E
 CrwrE79855PhP7MBzXU0JjrefO2pNcBEnS9Q3JOjGbmfopuZsPif9Z28Vbh4NWn6K8k0ARmx+9DGzg
 zfhdLHYfNbanZ7b/xZ6Fg+nHAm8mrxfpuLiGRyBSRKerbxgjqmFXYVPIj1+hfKxnlrj9ZwAGMXnmiC
 BUA5QF2U2rD4/cClb/JuGd15vVoXNvsa65zaWTgmXfJ832Ie2u3nsv2FgToECh5Hc4MEwuYATs9fum
 +mc74Vd//xWYx50ogX/oIPyPjHtSMFB3+ONADM0KEo+53j9/XyeSv35oDrpUydsBPOQvaGEpCUAtUR
 AOT1bo1xbsGuV3k7/MpI1kf8BMLsKo7/iLCGglh+XWDoNkAC0wONVCanCh7thGKZoE85QvdQM/u6SR
 uNjJxiQlSo8UZ+ip6mY4UOhvAjo4jusWDnoRO++SDsP8fuWQotAwpqtoDO9PRuJXIVSeC7PCd0juMP
 uIX+1zA9ChHGf+jEQ7PRB6UzXOo7obzNpAAbuFJriAEfkx/505merMpW+MePRZ+UGKif409OmJWfm1
 NAXquH/lHvhXfUANkple3Ffbde5KFtGdttuM4g6WhaOVQ6JHKtq6d6aDs1bw==
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

Enable DSC and switch to devm_calls in probe.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- add missing CONFIG_DRM_DISPLAY_HELPER
- Link to v2: https://patch.msgid.link/20260625-topic-sm8x50-vtdr6130-dsc-v2-0-cd375ef0e0ce@linaro.org

Changes in v2:
- select CONFIG_DRM_DISPLAY_DSC_HELPER
- Link to v1: https://patch.msgid.link/20260604-topic-sm8x50-vtdr6130-dsc-v1-0-09bcd1dff1fb@linaro.org

---
Jun Nie (1):
      drm/panel: Enable DSC for Visionox VTDR6130 panel

Neil Armstrong (1):
      drm/panel: visionox-vtdr6130: switch to devm panel calls and drop remove

 drivers/gpu/drm/panel/Kconfig                   |  2 ++
 drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 42 ++++++++++++-------------
 2 files changed, 23 insertions(+), 21 deletions(-)
---
base-commit: cdeb2ccd993ed8647adbbda2c3b103aa717fd6f7
change-id: 20260604-topic-sm8x50-vtdr6130-dsc-16c7697a65ac

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

