Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E232C55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B5F510E362;
	Sat,  8 Aug 2026 13:16:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A8CaqbQG";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 288BC10E037
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 13:16:50 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso460840a91.3
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 06:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786195010; x=1786799810; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ScR2OWx8A6oqcrYtXEp2YggGcFi1+8jFkpl9OoPWy+g=;
 b=A8CaqbQGBoAQvAB79DizPEaD1QCXKnc8EOX+dtb1EO/AZXZGk0R1oApg9nR/pYZuuc
 uTl6QeRm7A49XE3N5eHo8yLEKFTORUAJb/1+BveI53Lqc087OMKuTAUpOPkDVSJbCMJU
 l+O6gn58BCSIQhB90M9AJelBjpSfecxoKiDWKG8JEmNZT+gRb4C2HcGRn9vu3BbvN6iU
 f3BCs33IZzZQjNzFMvmzrZAlR1yTASBo3Ggjd3etaARII8c/feWLoMOKdbCoPornVLuJ
 HBvbOeEtggGGYO88VTjrYC2Ug26mR6HoX4jU0ot+shodj3r94fdRjcaGjr+oRefhpwBf
 Hvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786195010; x=1786799810;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ScR2OWx8A6oqcrYtXEp2YggGcFi1+8jFkpl9OoPWy+g=;
 b=neJ6k3xArQOl4jiRb3uhuScDuyk5T5BDaLQhD+5ttdpYh5QlE55xaCW+v4mtaprVCb
 IAtzcxwp7zmrVGfMmgMriNNKiojO9hbU0IDroKstczHbbQtLr428bciTVukCZrom9IjJ
 3uD9FzWmrcszE0sTOvzPTeMf/zUsKqGXaSQdna06pYxLIjGlm+OWtg5ft5wCZ5SJ4m9N
 tmvEPWPLw3mNuloeQ5Av2J/Z9Fz8EM8x7G5U08EPl3P64cnay8kQ0EX3SVnXyULaQ/Gk
 hffm5Xd8C3RrvMh5/GBT1hbHtn8UA49EB6o3onHKxOSBGtCX/34U6t6aBgRolOdpTdNl
 Yuww==
X-Forwarded-Encrypted: i=1;
 AHgh+RoylHs0ndh+TLmLUUAMkVyizxVmEaVREZe57dETZUZUJIVsyQBoXMoHWH5o+IUiei14XfiSNkXQ3i8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxkNrmcKb53qnlYCw8xAs1/j3VpkgreHt3MmwyuRt+n2eAx0B05
 35oDsXi/RTFeIEyKZ0O6CcCTIRnWG+T3PNxE9HdD9Z6Re62b8osEOkCV
X-Gm-Gg: AR+sD12ZMM7LjJT3mtUMT2ahYqg+4qOfY0Ce3V8fB+vj/GuTUjkvNshxyg4nNK+3TFK
 YgswNjxQiTrWq3s1/+3k33/NAP0JuHCuQPW4kRbvF/0mjwGFEoAs7ZIvThIiFZTYCjQZ4J1XrGf
 T8dO6EjVz7YglGesDWlMCxAp2GCnF17QFq+5XPGr2HSLOOb6xUgOVatV/gLeQuNaT99T4f0qM7Z
 c+qSRGEvqL4sLetEAjn9LosQYantUkuBmmXkd6ShGv1OEQBmsKlFGyKXNmQGfonQ3fcCXIZy6Pl
 DbOs/jAbJmBEXBVjABDCBZ6oixsqkZabA0k83p2XG+xxkB9rOzRNkQCErXzkFLDN4oPwtWPZunR
 qkjppxnLwRNtrM+BRBNWQOxJCY4z9CM0TGgWL8yrTeObQ3U9NDgy50y/TE3Y0O0S6YNq1Ig5YCU
 3nHNqada4AnBO223Pi9AujiyjjSgdkDbkHz36xP2YwEohEj0K+1A==
X-Received: by 2002:a17:90b:288d:b0:38f:26c7:165e with SMTP id
 98e67ed59e1d1-39261ff3945mr13138690a91.9.1786195009547; 
 Sat, 08 Aug 2026 06:16:49 -0700 (PDT)
Received: from lgs.. ([118.193.33.13]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3925fd95c40sm6170661a91.8.2026.08.08.06.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 06:16:49 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/msm/adreno: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 21:16:24 +0800
Message-ID: <20260808131624.2854412-1-lgs201920130244@gmail.com>
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

adreno_gpu_init() calls pm_runtime_use_autosuspend(), but
adreno_gpu_cleanup() does not call the matching
pm_runtime_dont_use_autosuspend() during teardown.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to
adreno_gpu_cleanup().

This issue was found by manual code inspection.

Fixes: eeb754746b14 ("drm/msm/gpu: use pm-runtime")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index c62c45bb0ddb..29c59899fdef 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -1252,6 +1252,8 @@ void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
 	for (i = 0; i < ARRAY_SIZE(adreno_gpu->info->fw); i++)
 		release_firmware(adreno_gpu->fw[i]);
 
+	pm_runtime_dont_use_autosuspend(&gpu->pdev->dev);
+
 	if (priv && pm_runtime_enabled(&priv->gpu_pdev->dev))
 		pm_runtime_disable(&priv->gpu_pdev->dev);
 
-- 
2.43.0

