Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8510CC55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 14:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFD6510E00D;
	Sat,  8 Aug 2026 14:28:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rM+Q2wff";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 515F110E00D
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 14:28:12 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-8485ef63b68so932809b3a.1
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 07:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786199292; x=1786804092; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JR3/zjA3xajDjkF0BbKi6bxrnqpn1dXC1eeAaooz27M=;
 b=rM+Q2wffJgeDtdmXICQOeTLm2/6Qz1WwTBAX7dXHrXMJMbBeZbiT85yr43MoXZW2bW
 aKcqWq8YoQdVvIY/jKTOoPIFWOWflhQTOuwmnbwWuXPifoGiq4X96rCJCDR4Q/FRTu57
 wDpRjy0D7gULruU15JYWpHkBmMap8qwQ4DNSRebnclKuV5hVyUrFTPsqwHFXr3qJdg+4
 ykVcnX2QZDJurxzZq3Xic3vgdyigCnviqfOhe6/LShkpVKzv4WIxvSzpxFmgWgxPV8qF
 oY0bhO4FYX8fz30m4KZOsBUEk4pyjDM/LLI+IkUREET5G3zEXyFf8JSPEkLMvABAGumU
 XKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786199292; x=1786804092;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JR3/zjA3xajDjkF0BbKi6bxrnqpn1dXC1eeAaooz27M=;
 b=gSqvqwoTZV7BxtUjCEbhSdty6yWLqES+B15d7PMs3DeWnqxdWJppjUMk65O7vsoygk
 H++zUkGfHTouuWx14Fkr+pTWWrft9d1kteVJZ7LxuQaA+z8qPdvmw94U3o9u++hS6GsH
 wNlFUosUTRg8vntgplngveCQlqyFHipNGAEu3MR6RORiOZo5gTJdWHLMoYafYrd/VK9C
 H9cb3cL6KJbXN6a5UU02m0HvVIDO7kXaK+HsygwOvMq6AqJxnaamMPv1d6h4RpwdGmlz
 oRQfnL//+MZPHyQmj6kYDFLmsLtZgK2cpJwaInYFJculbuZRSL+RQLs5wGj4Cc5WeIQ0
 07SQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RraaILGKshjDELHCmfTszcXCdnvX+xhgc2jjzBqjP47katTZkHONNVarWczZf2W21Y61Vb2Qcs1ydM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyYM1Td6JqYIkVrpp1zOTepDkvIcQsFd8B79YEJW9CcSuVRb4qz
 yZadUgjEL/XjPsylHbGVWtoykerY1Vw9upogyyu/wTW5k1eCAPmgz8xw
X-Gm-Gg: AR+sD13ko2mgsRK0l2T+lTKfDii89WOa/5SzoSIc8M0ETHDBtm/hXkx/R997i2PQ765
 UgFBjoOb3Pr62mLGN7ZNeIbCyfHTKTfY0ea1XAzGEnGzwmQq/qoELLIbnTSrerHkn03XOiL0Ai4
 4KpdXaTxaDsjJvc1xc5BEmOwh+U/7EpPzRxswrSzBSUKISa11FMofkBe0pF9lm66yQJ4qtF8vFL
 3qcpI+dhzBXcG2Bcgne0ZXNiFsiUUp6EkOmThB9XKljih5e0Unq5kQGCNnWVjueDKDB6T6DK/dU
 F9svxccYBUTZW4SMBcQ8YS9GR2FZh6/8R2/CmDyI674YhOvl5MpciDXEUTtAaSr5V1XWbeTaHp1
 74DCFVeAou8sBh7WBb+5VUJgvf7gAal6YtZfN9xcn+bnkzi8T6aPRKOEJU7UrRZwUo31D2BE1D8
 /yRVpSY/g/v4D9FKI33zSTqwaxfs6pNRoaQ7tV/5POUMRvPsqRyOjNO06F1g==
X-Received: by 2002:a05:6a00:240a:b0:84e:538:476e with SMTP id
 d2e1a72fcca58-84f2e0ed7fdmr30329697b3a.32.1786199291788; 
 Sat, 08 Aug 2026 07:28:11 -0700 (PDT)
Received: from lgs.. ([101.76.249.46]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f5a51e9fcsm2177867b3a.36.2026.08.08.07.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 07:28:10 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/tegra: nvdec: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 22:27:56 +0800
Message-ID: <20260808142756.2898271-1-lgs201920130244@gmail.com>
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

nvdec_probe() calls pm_runtime_use_autosuspend(), but nvdec_remove()
does not call the matching pm_runtime_dont_use_autosuspend() during
teardown.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the driver
remove path.

This issue was found by manual code inspection.

Fixes: 62fa0a985e2c ("drm/tegra: Enable runtime PM during probe")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/tegra/nvdec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tegra/nvdec.c b/drivers/gpu/drm/tegra/nvdec.c
index 7a38664e890e..cb52459b2d79 100644
--- a/drivers/gpu/drm/tegra/nvdec.c
+++ b/drivers/gpu/drm/tegra/nvdec.c
@@ -546,6 +546,7 @@ static void nvdec_remove(struct platform_device *pdev)
 {
 	struct nvdec *nvdec = platform_get_drvdata(pdev);
 
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	host1x_client_unregister(&nvdec->client.base);
 	falcon_exit(&nvdec->falcon);
-- 
2.43.0

