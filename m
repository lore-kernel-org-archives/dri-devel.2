Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E605ACDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C27F10F1D6;
	Thu, 25 Jun 2026 09:33:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BcSGYqVx";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62D2010F1D4
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:33:53 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-490aaeabdb4so12884315e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 02:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782380032; x=1782984832; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ge/rwCOewCCLtHUHCkPUnCRHv0yvV8W887eaylgnW0I=;
 b=BcSGYqVxqFuTOYC60WyEyDWVJ7/C6QFiI115SqZmwQgSYw8A5mamDValUFS/WksFVK
 zkuj0if5RTf/rVBtyHbEK3fiOCLixA21uPxengSqSwgVpStyhMLYN1bvapJauy0ZtuW2
 UaNzc7OWZDFPJThtHcTqmRhnbii/vwU2+Uhqa0AK4qDSub98ufQtPTG4ZKSdluwIEH0C
 2KRglqkhMAZC2ka53Tz0K96lEaW5eYqgUbc832ixwHHDUu2XFPimRuYnk+hYSVJsEMlG
 qlirimCZPkmw9YuXCJ+8iFEJJtO9QfM9jQyQf6h9pW8mt85z5t3A5V1eKwVdMZShRH0A
 qdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782380032; x=1782984832;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ge/rwCOewCCLtHUHCkPUnCRHv0yvV8W887eaylgnW0I=;
 b=KWpQg8jjCdjcI7YVUNoWLxmkFVZB6LtYsFG2xgQD82zsXHjYZT7OwBGBxzJW8Lg+p2
 ZQzCEZ1joh7BuurDyDnUjf111B0ammIE2Z+GkBSI0GVOw60KqqnuNwUmlc6+1sAngd8t
 JB6Jv3s35cXnQo76ZF2EMWfcDK5p4aBGiMK1dRTcT1pQsKAiylRSUDbXyuGdnRdJM0X6
 jojyqpz8dUvzobZWVg200G8+gsk0qoSdFgPxmk0J6WS2ZR4Sw9/dlEW5JkLeId6+ijwY
 TO650+NI4FKjRBYukguT1CBvKU8irRCyOMp2JC/nw6XBOz+FqBD2Vcchh/EjqZKAImIy
 P/uA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9L4S57glVsvM0asqy/THZ+m+Ce5/EZOC3m6/zrqZ9oWyMfJ/8OO83LDVz+n2kUxx/RUEz0Ffi4BS4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXslneMp59w+SW2wXhWCaWEPe1iE31iCDWoI9M/BjWqtnm63Mn
 M3XJLIpSY78fbIMaWsHl918xhjZxULXPzYmKOrRLSzO9RfY7QB36NR1w8om6Z/nSfZo=
X-Gm-Gg: AfdE7ckfxEXdVoba533PYUEbuCU+Rn5se3QGwmpKPZq1ZKxUBbTVJJCpu/fhp0sSERP
 TKwPoEP7AbCshbCr/qxOdgkQ4RMXZYSQ82ouaX2RSB7pGOXmU1VCg50igJG6aVwkiWvhUGmZjp3
 wD0HKFsOw8v8aIEvMMeEIvT1PZfXNtr+2ap9BeyKSw4lCS21P8F2ihJuaI+RDSzA/Ii4+YBYfAe
 J7YVmyUFYaNGapdhBn8bnNqy48Hxn5IqCvEO5sAKcyJGHxBIIm9MvMfylWgASuTdMejAK8TN6Q4
 xPR3LfH1ltPJyKVA+K4V7HXj29BgEKyZP6IqzrMUHNYwg5zkeBcf0PkB6KuUvsKWVQ1Gox9E52z
 Gz1f+vMdu+AtyYtDwy0sRWluXvsZyTPW4YGYhNlaPgMpaFYffZ0pqNpSiH3FPQOWE7Kp1Dj1blF
 WBh5FgU9RNZCMCGURdQyV8UP9irY3UWzHxQFFxBFBOE8Dg
X-Received: by 2002:a05:600c:3e07:b0:492:46c2:f5b4 with SMTP id
 5b1f17b1804b1-4926688bbb5mr21692755e9.32.1782380031689; 
 Thu, 25 Jun 2026 02:33:51 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492660a32ddsm40154745e9.1.2026.06.25.02.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 02:33:51 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] drm/panel: couple of visionox vtdr6140 driver
 enhancements
Date: Thu, 25 Jun 2026 11:33:47 +0200
Message-Id: <20260625-topic-sm8x50-vtdr6130-dsc-v2-0-cd375ef0e0ce@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPv1PGoC/42NQQ6CMBBFr0K6dkyLUsSV9zAsyrSFMdqStjYYw
 t0FvIDLl7z//syiCWQiuxYzCyZTJO9WKA8Fw0G53gDplVnJS8klP0PyIyHE12WqOOSkgxQnDjo
 iCIm1bGolK4Vs3Y/BWJr29r39cXx3D4NpC27GQDH58NnPs9i8f36yAA686VALba2w3e1JTgV/9
 KFn7bIsX8tATQnVAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=834;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=nDIvo4GKRxlC/yboZ3VPIj7FCh1BNCNokdcUSVuLaNE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqPPX9viQvvDuetrzBOwx3mcb1pazHDDHULGzInWxD
 3S2zubiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCajz1/QAKCRB33NvayMhJ0YOeD/
 9qGnoLevc9oQuvgYPOgovP9rjAhvRz0YifhJFaM2mLWeGH6ECdDfXEgKwegfkhcNWLyTwpHVMfmNoi
 e5yaIC/tiGIdDt018gGiOcUzWIzEPA4cwWsu8exqzpidIVvlYCASCYzfb8vkmpCNQBqilotWzumKxF
 GuRmyPZdYc0M48s+UMiQe1RVA/521x/6LEfWzUK9DL9w0IYflXzsQOoHLeXmFkR8KM7Z4ZdlnVQg9X
 w2Q4lKZi8oKWFYkq6Hf8mu8W9pmrYun0yYfkZPc/eBlUpP410jZxcf6QJJgcoIksz1v7ro+vtmfCg0
 5NWejo5/THL/50JCF9csvk02ixfJtf+2dobWmQJjkhjs7n+yplPHwcZ27t3YRAqTj5DcGLFqaW9mcY
 ga/UveHVRbp2ZnNO44FdbCQMXUDz0ZHuhxwbySRawPMc5sLxGNUZANDWH385bm9+m+Zc7SsAE3ldlE
 UMY7y+l7RnYT72WYbfBsWXo4pdrcEVAolGe9uez97tsyE20sgFy9vAtGDYoSavlphvQYtEqWHgn+mK
 HVxwjzV1w1m1Lr8Jx+7m5GzxVDkRM9u49LrAZUuInT5PdpH5uMbyyWiq8Y/7VRuB/gC4IoUk7SKp4F
 ghuNQXISN7b/U9giUog0spk9vPIIgf62VDGfdGsxYVEv3zyzu7r72r5hA3iA==
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
Changes in v2:
- select CONFIG_DRM_DISPLAY_DSC_HELPER
- Link to v1: https://patch.msgid.link/20260604-topic-sm8x50-vtdr6130-dsc-v1-0-09bcd1dff1fb@linaro.org

---
Jun Nie (1):
      drm/panel: Enable DSC for Visionox VTDR6130 panel

Neil Armstrong (1):
      drm/panel: visionox-vtdr6130: switch to devm panel calls and drop remove

 drivers/gpu/drm/panel/Kconfig                   |  1 +
 drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 42 ++++++++++++-------------
 2 files changed, 22 insertions(+), 21 deletions(-)
---
base-commit: cdeb2ccd993ed8647adbbda2c3b103aa717fd6f7
change-id: 20260604-topic-sm8x50-vtdr6130-dsc-16c7697a65ac

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

