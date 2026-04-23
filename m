Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858ABFDEE47
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 20:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E60FC10F205;
	Thu, 23 Apr 2026 20:06:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Eh3djtHz";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AEE810F205
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 20:06:36 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-48374014a77so92442485e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776974795; x=1777579595; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=miy/V1Ssd8oZVcXvrSSNRZJTWkLzXKYl4wR7b24pcBU=;
 b=Eh3djtHzAPVNY+wJKuag6anfUEEOcfF0VdCL39ICwzV+Tqww98iFZs8bafH/mMUdLN
 8leluSHX1Fhsj7GXJkcihfIFDNCtlaeWeM1/2/MmklUDBihka9nzug+q2r6aH/PmsCdd
 uRtHjUyMs3wUG3W24zkvPJqrz0lAu8wp37/1jW+R0z/oT85W5iAjRE6fSc4zetEeMIgC
 rxONtFTKerSETIE6IHke9Z8oltD/VXYYYHqAWymsQ04OFlV4+qaZnbtDqDDOippOnkN5
 VaHHC2FGImR6MOH5F4rXcgnGWXpFLovTBueuG4P0OpHReH/zz/PRNraBOKWGbSXdb2rN
 nqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776974795; x=1777579595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=miy/V1Ssd8oZVcXvrSSNRZJTWkLzXKYl4wR7b24pcBU=;
 b=pV4Zc16Ow6JR2v8tgAK4h3vyA9QdHxVjcIkr89ch1u4X3cWhE4sv8uvPbF8eKlBnIM
 dO2ioH2sHFdxBYOybpab5w8GWwpftWYohZqG0rEqRgBpoerN7BjeUE/Z2NwnDQUHsAE1
 /YgAsy7ZMhGB+sePyZp0kqsy1mh0oIaC1Ws/SFLYbiblKWz2/z+wbgmd61E73bbB2q3B
 qB8hGpOamxzCAcU8Mtx75InaQjdaNsF6KxYVOj0N+daPgElQLGVM1iV3Q1N98lawW4lb
 NTPfbw78xDm0hnQhn9e6ycR3X3I6UZFPEfjK7qC1EOXK9sTelXdiIAuAPLl67rRI6ChN
 1PAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/5HHY2xFroTMwgghvb3BSqpPNWilNzCmLBwucD00y8JQ5VAcuhRJ00P0pEmRE5rB4mC2kOqvSql7o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtnZYqWxVv3O7qenevmxHjj6AukQXEGPjyqjfMlBJ3u/VXNLIJ
 UQSVl/9DXAkAIG78R35bM9qoa01mDUJgkOoNT1Nbw06E5DeaKjF6FyCM
X-Gm-Gg: AeBDiet8YW3ZrHRPPorR1bU9tnKO961J0a5eWYb1kEzkMpcAKzFcjUXleYSeY7OL1iL
 nmq4yDSrJnsaMmWjDAXeYDWUf39DKwyryCVqd/U6DxkxP+RpAevBeva52LacgV4pi4LquCBlvJb
 Fjh2vKsJmwe+AquNxY4mEXBGw7zH4RNNKmWX5/cA3hiKgL/psbEJLL0Cxm5/+zwtkXAyIGAxzHx
 lt+BUTmlwNZGBGXUmJT8/iNe8oxMq8u94fbiHtJ0hB4lXrakbo1zEM5bGut9usjqC4qBAuUtnfA
 i5166HIEmIy6f2PNPAjVvHctovvs6OI7Q5ZTAY2fgeEH9OA4aAlliPsmlOEBz0A2Cj2c0C8H0bc
 vQ+BjZCKIWXWy63bj9fKlosl+JXXhZciHOR9gGzf//n0PMIQhij4Qmk0QTgm7fZDz0b/BVjoBlE
 WajLT2S2oidGbYxHSVJtR8ycpHNGjy7ENq7nQiW0D16rn2C8q/4MDRoFFNu1ZZ5YrikZwK9H4=
X-Received: by 2002:a05:600c:468c:b0:48a:56d5:16f2 with SMTP id
 5b1f17b1804b1-48a56d5179amr182114795e9.7.1776974794828; 
 Thu, 23 Apr 2026 13:06:34 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:5f44:38d2:bccf:b54f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb75ab25sm167658815e9.11.2026.04.23.13.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 13:06:34 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Hoegeun Kwon <hoegeun.kwon@samsung.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/3] drm/exynos: remove bridge when component_add fails
Date: Thu, 23 Apr 2026 22:06:20 +0200
Message-ID: <20260423200622.325076-2-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423200622.325076-1-osama.abdelkader@gmail.com>
References: <20260423200622.325076-1-osama.abdelkader@gmail.com>
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

Use devm_drm_bridge_add() so the bridge is released if probe fails after
registration, and drop the manual drm_bridge_remove() in remove().

Check the return value of devm_drm_bridge_add().

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Fixes: 576d72fbfb45 ("drm/exynos: mic: add a bridge at probe")
Cc: stable@vger.kernel.org
---
v3: add Fixes and Cc tags
v2: devm_drm_bridge_add instead of drm_bridge_add + goto remove_bridge
---
 drivers/gpu/drm/exynos/exynos_drm_mic.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_mic.c b/drivers/gpu/drm/exynos/exynos_drm_mic.c
index 29a8366513fa..e68c954ec3e6 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_mic.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_mic.c
@@ -423,7 +423,9 @@ static int exynos_mic_probe(struct platform_device *pdev)
 
 	mic->bridge.of_node = dev->of_node;
 
-	drm_bridge_add(&mic->bridge);
+	ret = devm_drm_bridge_add(dev, &mic->bridge);
+	if (ret)
+		goto err;
 
 	pm_runtime_enable(dev);
 
@@ -443,12 +445,8 @@ static int exynos_mic_probe(struct platform_device *pdev)
 
 static void exynos_mic_remove(struct platform_device *pdev)
 {
-	struct exynos_mic *mic = platform_get_drvdata(pdev);
-
 	component_del(&pdev->dev, &exynos_mic_component_ops);
 	pm_runtime_disable(&pdev->dev);
-
-	drm_bridge_remove(&mic->bridge);
 }
 
 static const struct of_device_id exynos_mic_of_match[] = {
-- 
2.43.0

