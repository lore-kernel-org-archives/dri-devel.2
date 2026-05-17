Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91871CD4F3D
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 09:15:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D872A10E1B5;
	Sun, 17 May 2026 09:15:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xiv3zaFf";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 211DB10E1B5
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 09:15:17 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-44c350a5b87so587561f8f.3
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 02:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779009316; x=1779614116; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VaCaJ0wOxTOll8aVdydgJ1rChHHJqX36x9WrjTxVV0A=;
 b=Xiv3zaFfRHW8CzzBtAXnL1oasH90W8rAeSGZIymFIh3Ob/IkX7ViMju6we2l+HXzAw
 NbDIHkNgjduuwQZPAAAeFnWM9y0q73o5eshc244vZ4bbXPO66AIk62JAKpqqKAbvqXCu
 Q5aBpLCTepQkIwnhpBN9p7HT/X8DdNfNZPUam3loAyTGtMuTMjOR1TpQgKwPUgBHMn9O
 n+dlUw4m7s9jjbqlhFzBbzPJOWWTKy3YTYI3NvBVDDv6eFImA5Upg3fT8roopMPiqQmR
 zpy5IU/oKcyxqhLaH3Tajl0El6YGopGDcfkH5jBBmXBJ9nE3Mt3XtLJHjFPKo/MRD+LR
 SxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779009316; x=1779614116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VaCaJ0wOxTOll8aVdydgJ1rChHHJqX36x9WrjTxVV0A=;
 b=HyrBi7LjE0BFwv1/rP96rF/6Tjyw1vUf5EqIQk8YdCLhz/+Owg05IjGiPSvHdRJxKE
 3Lo10bWKw51Z57NuBh10/0kWAqJKqvITEJpGeCwIGdMcgBbCdcIUETa2Qvn2fLZGSjll
 bjqCgoUgr68jDBEDBfngTDixQQvjDj2wxUJKRabx2HF4bvPzkLrTiZWN91AbHzvUj6Qs
 cCctMaTP56SbSMxAKL6DB5AfZpuBQA5v6qlozgpZlAgQIVIRVHU48Aqh1iLQIH6hANxF
 jJG+O3toLySj1GUhqRW6SjtSXBYHXgLI8j9MZJjLQ7QRA6b6xl6dJtZVsVAniv6SDT8c
 fPUw==
X-Gm-Message-State: AOJu0Yy0XOSZSHHZeiQhcChbgjXZd33PPvWCXkF6fUnwNgKZ3y3cP1/9
 oxSD44/lAawnqRDG0frFCncZcRKUKx8eenpxVJHx4DH7wfGygFedJ7ws
X-Gm-Gg: Acq92OFdhZ+hPutELcOo56JoqXLcaAPnf7soXOwy+X640FTFwV7P3Qorv6qLatgjVQI
 xUxbAL91ZF7vcGQ72/iGS61N9q9cYKyRW3oDne1N+KL8O3efo/INsSfDJVS319uFnMigSqqPl65
 eAzEqWuozQrrXRjO4ASW32gxH5ZNDacKqmsaUdYpBU3IAreWRxVJisFR5wR8kV9VfEk6bGffjw5
 72qRpyRIN5VHqnYsKp5bEPLdgYNneBFLHoJum2TZRh0aFLoYcCkkLl/S1MTszyIkKLf0N2qEAw+
 dM/nNcJsQ+qZ+8XnbINp2fFdfr1Pu9QzL1Be9MDJjQoQJ5qprve5uSNEfUPfP73yJuKvsTGjyGU
 BlfXgndd5uWASncJyPEqwLGMtbb3QcnmBz7hKDPVDiWpMyp/i7LyPc3VzdZPnmfy9C4iVXPILSm
 KC6296IXIfCTZ6
X-Received: by 2002:a05:6000:18c6:b0:45e:73a1:8db5 with SMTP id
 ffacd0b85a97d-45e73a18e91mr1859932f8f.40.1779009315567; 
 Sun, 17 May 2026 02:15:15 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a17a22sm29560235f8f.22.2026.05.17.02.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 02:15:14 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] drm/tegra: gr2d/gr3d: Contain PM in the
 gr*d_probe/gr*d_remove
Date: Sun, 17 May 2026 12:14:50 +0300
Message-ID: <20260517091450.46728-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260517091450.46728-1-clamor95@gmail.com>
References: <20260517091450.46728-1-clamor95@gmail.com>
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

The current power management configuration causes GR2G/GR3D to malfunction
after resume. Reconfigure all PM actions to be handled within the GR*D
probe and remove operations to address this.

Fixes: 62fa0a985e2c ("drm/tegra: Enable runtime PM during probe")
Acked-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/tegra/gr2d.c | 13 ++++++-------
 drivers/gpu/drm/tegra/gr3d.c | 13 ++++++-------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
index e4148b034af7..892e3450b281 100644
--- a/drivers/gpu/drm/tegra/gr2d.c
+++ b/drivers/gpu/drm/tegra/gr2d.c
@@ -100,9 +100,6 @@ static int gr2d_exit(struct host1x_client *client)
 	if (err < 0)
 		return err;
 
-	pm_runtime_dont_use_autosuspend(client->dev);
-	pm_runtime_force_suspend(client->dev);
-
 	host1x_client_iommu_detach(client);
 	host1x_syncpt_put(client->syncpts[0]);
 	host1x_channel_put(gr2d->channel);
@@ -280,12 +277,18 @@ static int gr2d_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(gr2d_addr_regs); i++)
 		set_bit(gr2d_addr_regs[i], gr2d->addr_regs);
 
+	pm_runtime_enable(dev);
+
 	err = host1x_client_register(&gr2d->client.base);
 	if (err < 0) {
+		pm_runtime_disable(dev);
 		dev_err(dev, "failed to register host1x client: %d\n", err);
 		return err;
 	}
 
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_autosuspend_delay(dev, 500);
+
 	return 0;
 }
 
@@ -367,10 +370,6 @@ static int __maybe_unused gr2d_runtime_resume(struct device *dev)
 		goto disable_clk;
 	}
 
-	pm_runtime_enable(dev);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_set_autosuspend_delay(dev, 500);
-
 	return 0;
 
 disable_clk:
diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 47b0c6c56bfd..388e47943d5e 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -109,9 +109,6 @@ static int gr3d_exit(struct host1x_client *client)
 	if (err < 0)
 		return err;
 
-	pm_runtime_dont_use_autosuspend(client->dev);
-	pm_runtime_force_suspend(client->dev);
-
 	host1x_client_iommu_detach(client);
 	host1x_syncpt_put(client->syncpts[0]);
 	host1x_channel_put(gr3d->channel);
@@ -510,13 +507,19 @@ static int gr3d_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(gr3d_addr_regs); i++)
 		set_bit(gr3d_addr_regs[i], gr3d->addr_regs);
 
+	pm_runtime_enable(&pdev->dev);
+
 	err = host1x_client_register(&gr3d->client.base);
 	if (err < 0) {
+		pm_runtime_disable(&pdev->dev);
 		dev_err(&pdev->dev, "failed to register host1x client: %d\n",
 			err);
 		return err;
 	}
 
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
+
 	return 0;
 }
 
@@ -578,10 +581,6 @@ static int __maybe_unused gr3d_runtime_resume(struct device *dev)
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

