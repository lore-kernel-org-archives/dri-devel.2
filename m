Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF70FFF8862
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0051210E291;
	Mon, 27 Apr 2026 07:59:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AULYAMDG";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2D4710E0E5
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:59:19 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so8947358f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 00:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777276758; x=1777881558; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QbqtPYwCKpsoZO65V2/Zjei16diYD3VChr6pC5XBI0Q=;
 b=AULYAMDGbb2ZOJ2dla1bPxL3i6m9ej/cw3bW55C4OoUSFX5Y222dpEszwSQr91zNGV
 nCkwc6vGeClL4NSIFVu0gSUJaj1Hsh3+jVxLPl1/oPuDy5rHo7Sa7iHM70MZRldUPiqc
 YCsWxNWM0jsniuoujF/yGFB7tW80LlZZf0PrFbNY+doT9veu6pUfWnyLtT4RzLvlXhAU
 ihG19jxHMDg58O3pOsbdXYxZR4Aso1BtUjAOXlcmZWR0WBGKagKwOXuVzhjSSgPgvraY
 hjCHEMnbQH00EdZkQlVkn5yQAmtU5VtsylRaAUVX8HsSGmH5FKYBbT/pCiVW7eNWMZ9V
 fyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777276758; x=1777881558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QbqtPYwCKpsoZO65V2/Zjei16diYD3VChr6pC5XBI0Q=;
 b=CtmUVMQpkEnrAL+rRc4Dw25nDMMsADez7vEwHux2nKdV24nmGHncS/sjk0kl4FAf23
 5ioSGXPmU1Gv5SBI+LprWm9YCN3ZWMNOVkJn1wOYw7hYaSGPD906P5dyTSC85VddwHy+
 0lx8uKYzYCRwgGVcQ1PTDwz3oZ5IuhMXw3Zl2GOimLM9S6mEWvDxNnnE73fSaddM3Abb
 BcrOI0q0zFVN3wA1q6SsVzWc8+Pyn1qudPVJzxRAB2K5UxBV9s1zS/eoUZtYnFNsuXac
 QuhoZEQWHzAo+vrH5Mi/4bI0/vRsRsqAW+k63iYZuNaK0MjjcA8MpXVnQwvNYDuAxPmp
 p22Q==
X-Gm-Message-State: AOJu0Yzzq+3nBQATy3Uw7JhCPpqOsnegm8Yq9I1ps9/FSFMuXQl96gZc
 paNaKFbuAQTut23wGOatl5vzXsPokAEqNTeE63VIn/s3ixvsPUwmSStMnv0VQ05L
X-Gm-Gg: AeBDievnTNcgV/IhKKOzD41h1JuS8kPIBuyBgI/l42OKMY/ZSv5fJGCZj6IIT+90GJ0
 NCycPeXJaxmTkWs+P2rEtK2CJF75lPeX2E57+qMVhqBIb9teihh+chAcPhxEIUWN+wNBU+LGToP
 FuJhG9f7giI9qyFd9AEHfHZMsAgHeSqT1atzm5bGxz4Oz8/TIPWm4VBs6zp6Zga+enZObpcrDRH
 tsDQLkXRhkP5/AN6AN1Cm02gu2DJ/qOXKjYBB87221DxPxsqz5f3cOIOjOtFGCi7Y47cZ1+RDH9
 qYfSApSDm4uqJEe0540fCNefFD78iakAXmaLbERvoIdiVLVG9KEJNR6XTAz64zK+jNu5hLF6M2c
 LFX4Mwha+9YLVcuU/3O7ARud7qMnVE/Sox6AKImaeAG8h20OlotWjLoEpSQPFlPs4DSVhUuF6cq
 mOhAXh9gVZkTizdNBB1IU3g/8=
X-Received: by 2002:a05:6000:24ca:b0:43e:a70d:7632 with SMTP id
 ffacd0b85a97d-43fe3e0b463mr65931197f8f.25.1777276758054; 
 Mon, 27 Apr 2026 00:59:18 -0700 (PDT)
Received: from xeon ([188.163.112.56]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb11b4sm79918386f8f.2.2026.04.27.00.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 00:59:17 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] drm/tegra: gr2d/gr3d: Move pm_runtime_enable to
 gr*d_probe
Date: Mon, 27 Apr 2026 10:58:56 +0300
Message-ID: <20260427075856.85208-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260427075856.85208-1-clamor95@gmail.com>
References: <20260427075856.85208-1-clamor95@gmail.com>
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

From: Ion Agorria <ion@agorria.com>

The gr*d_remove() has pm_runtime_disable, this indicates it should be
paired with pm_runtime_enable in the probe instead of being inside
gr*d_runtime_resume().

Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/tegra/gr2d.c | 8 ++++----
 drivers/gpu/drm/tegra/gr3d.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
index 21f4dd0fa6af..71f092d59d65 100644
--- a/drivers/gpu/drm/tegra/gr2d.c
+++ b/drivers/gpu/drm/tegra/gr2d.c
@@ -286,6 +286,10 @@ static int gr2d_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(gr2d_addr_regs); i++)
 		set_bit(gr2d_addr_regs[i], gr2d->addr_regs);
 
+	pm_runtime_enable(dev);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_autosuspend_delay(dev, 500);
+
 	return 0;
 }
 
@@ -367,10 +371,6 @@ static int __maybe_unused gr2d_runtime_resume(struct device *dev)
 		goto disable_clk;
 	}
 
-	pm_runtime_enable(dev);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_set_autosuspend_delay(dev, 500);
-
 	return 0;
 
 disable_clk:
diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 42e9656ab80c..33e88ca4d4c5 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -517,6 +517,10 @@ static int gr3d_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(gr3d_addr_regs); i++)
 		set_bit(gr3d_addr_regs[i], gr3d->addr_regs);
 
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
+
 	return 0;
 }
 
@@ -578,10 +582,6 @@ static int __maybe_unused gr3d_runtime_resume(struct device *dev)
 		goto disable_clk;
 	}
 
-	pm_runtime_enable(dev);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_set_autosuspend_delay(dev, 500);
-
 	return 0;
 
 disable_clk:
-- 
2.51.0

