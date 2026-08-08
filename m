Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBA0C5AC67
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 14:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D55A310E04F;
	Sat,  8 Aug 2026 14:08:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="r8F3hBhp";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D43C910E04F
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 14:08:37 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2cea3004256so5857345ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 07:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786198117; x=1786802917; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xpXkiS1syNfL3SE9V9W6WDFdug7+uucLTLZ+bvyu9mM=;
 b=r8F3hBhp9cgYy3xRmoEYnZSWx10TCk37+B93LMJRwOhaNFyR8r32kSGP9B8e0WMvwh
 QrHOkgnordAZ6Z0OS4HisN0bYwbP3i4cn8XTKGzkRqVlhyTreV/IuUuCbyAGxIpILmDV
 5F1f6IMBT0P4IlNcLVrhiaB60AQ21lWYXdgxShYXW843CG+gBFtkJWiIMr8O37JuIMoZ
 8FwBTIc3MwylFxwm2jKWJ7m12aYvvFmmJcIn8/El19j1aR589wXyh9dewojGoBtSMgAT
 JCD0fcOqChTnwDd7c8G1QJrATNEQQ3qeT2IUr1wERaWIGMuvx+bTMI+r08KztaohLq7L
 Bbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786198117; x=1786802917;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xpXkiS1syNfL3SE9V9W6WDFdug7+uucLTLZ+bvyu9mM=;
 b=DkxwY9tbd3c338zAUQEdkK7pTed9uh3ECITSQ1NV0Rms3FqroOZF9taR/GJRqV7BK9
 rHEkLjht8mzdhSIq1AQ7MjJ3NAOhwDJ1QbN4pZEnpxn4POwopxtTkmUSj4PRkqtajhm2
 VoihMK5xAUMfEihnrG6WkF5a9J9bJXdhnfjFWtXChGP83YwOQQgdNHNl4A5+Zh2lHKsv
 +il3SRhmfDYKtvR4zC/gtVk8DqjMU9R0P9HxXJe9docXVPs0jlZtqDdMPx8UJFAofJYP
 BaDqETxEM+jiFHSiR8eEVbLFE+gJnkQQ8UKqk19EJAYsPyZgnRaNiv9BvXXdFE0M2mti
 nFZg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpsXxazmUm4N8noZSCFOtlG9XR0VmmfBCGGqsgaCTO5LAb3TFGGQ7FNs96U4ftTosp5TDxfXla075s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8BdrY1gJMV3ysull1VmMg0HvIj/UXnPm10GuWH/EkiDVUftss
 33TeZ9p3YwRm7YK2pDsmc1VwQ4jDHcTfX225w3Xn+gtzfMbaMQG6bqdZ
X-Gm-Gg: AR+sD11VvJUrAdx9lRFzU7bJVgYq2sZhdYdNbTdUtz/Up2S1SDZnqpLi+cFTCUyB+E2
 EMjFZFlBtew9KeVJmQZgELVX+FtIWyaffSaklAOZeQR3OVFNS1Ql+gDgI84/Wwz+qW13LiO5eTV
 quMyotZixqpKMqQaX9O3TfHj66ZCZned34z7DtGsDfxXNxRentZdLRmFInPbk74OLjUeLlV5bCh
 ygVXPrgC4y0T2lPoiQSrNu2r1C114Vfj5yFIFVXWkpqAUqbnu1izP4GB93S63mQk+Aip1dn0jOv
 c0TVKAMnynYaOtyBdKsaxXKKfl+GePWQ48K8X04OVMf6aYKmkefzcmXKEMVdICl1+3oyeata6ez
 N1eMbMQTVSJEbLou/oGl4AqBToYvnHtepAP3FelBlKAmMvPGO9mG8M6OIqpv7NvFXUwc4DzRoNR
 1KgG4WjVeTgrDjD+775vGVKrivPyLZbBa3Nm9D8jlXa/o=
X-Received: by 2002:a05:6a21:7007:b0:3b4:870e:6f44 with SMTP id
 adf61e73a8af0-3cb85ffca47mr41360296637.35.1786198117342; 
 Sat, 08 Aug 2026 07:08:37 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f1af992sm1913171a12.14.2026.08.08.07.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 07:08:36 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/tegra: gr2d: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 22:06:22 +0800
Message-ID: <20260808140622.2887873-1-lgs201920130244@gmail.com>
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

gr2d_probe() calls pm_runtime_use_autosuspend(), but gr2d_remove()
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

Fixes: ace01e2af387 ("drm/tegra: gr2d/gr3d: Contain PM in the gr*d_probe/gr*d_remove")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/tegra/gr2d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
index 892e3450b281..95e8a14a9648 100644
--- a/drivers/gpu/drm/tegra/gr2d.c
+++ b/drivers/gpu/drm/tegra/gr2d.c
@@ -296,6 +296,7 @@ static void gr2d_remove(struct platform_device *pdev)
 {
 	struct gr2d *gr2d = platform_get_drvdata(pdev);
 
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	host1x_client_unregister(&gr2d->client.base);
 }
-- 
2.43.0

