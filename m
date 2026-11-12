Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DE5606A33E
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qTfOW6UI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 392A810EB5B;
	Thu, 12 Nov 2026 07:52:21 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 530E610EB5B
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:52:15 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-886e61fa30fso1753132b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 23:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794469935; x=1795074735; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+PFwRraLiMRDLMfi3y8YngO/QGo0JYSFg4Ky5k3Gocg=;
 b=qTfOW6UI1BUi06gQyJUwX3VzjCRKAhYjpsv7T2nCPplV1QiWF8wJzvpw2A0gmkiUFY
 VQODf0911+kfC7eKwPRD8fS9d3rq4YXSy3P6KektDCW5MKY+mmLU0sspEikEbcaLpinD
 2MifnDT3ylkmFoBh5se4K99l9J878dvRPj9qngvSswfTXABYkKlYb1+Fp07i4RTrceY0
 Texb+FIZ4zDaB2bodwnJsBQXSdbeTGov15NiZCV7RyVeLnSBAaJC+rUA6CiL7pZ8gpUO
 1WcDqIxKFTjq1ev47S9e7ywbRV2P4QgmmqJop82l2cFmmba+m6+M9OVi0kM/zpJnxlM7
 1nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794469935; x=1795074735;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+PFwRraLiMRDLMfi3y8YngO/QGo0JYSFg4Ky5k3Gocg=;
 b=YtDgHYEZtR55uvwdZdfVZt0FDnkKbdHXSHr8IhWrX2McyyB9N8vIwWObmdDbNC1dcY
 GbcmiIcHKhhTAvqK69O0zzvEqHXMCgkKJiXoE0qCOTFzJFLcZEtwwzAoolRvVqmR9kCF
 0MYqO4wLqDN3OTsCFsZUEDpugXKZc0YM0c5nVHYiUfc3DxDRKKpPSuGNqePmfPX0Xcrb
 8/vfwx5s3j4cdBHCMZ+cLlD3VgJk5OiBXTq11B03jqnqCqptMXP5+r2xG0lzyueAAG+2
 6VYB8NCDQ1/VwJGKepZVU+M5nNGLK7YbHeF4ruIR+9knxQW8Wuw3xha9fptOdQnPAQEq
 qDIg==
X-Forwarded-Encrypted: i=1;
 AL+hErGWI5xEySWWtawsSUFJf2tZ5ZChQl2KuC+9tz+UlEFHX/idBbno5TxdZZjeT4urPULZJSXRObnVKN0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/2jwDnEzBRrWMI2UUYLIsnaTiQ0OkZPSVFEsw+W8sleEwKGDSU
 4Jd2gpxdVNq5s/9Vq8qIe9VdCNnRw65V9q4h64Dc4psZxqG2vQ/NeY+e1MMqBrQbenE=
X-Gm-Gg: AYBFou2q1a42mu7atYkjFJRKLdg12bVF89rHDDRSDk5mdfYygCf3R8sXsRIwQp035p3
 wkMHnCDKZ8lX19psNrQDj26UD+3EnvBhqIpA+U3ueqbAx2PHIbQo24teVVT4ek1ni7aQigKcFyP
 EpToJfjtK/g5mp3yJODszJYmq0kvoCEP3PQl6X6eCPj62j5AEu3g9J5d69xylN0NxOke2pylCUR
 6eyV9D2PYpZdE4rhcAlyeffyRV/xJwJ4m0QYs8DLTV7t23EKEwTKVXi3e33gEhxyZfloRyJbmmE
 YfE7KPWQy2ivoWAP73VJdPIl7i26x2GHZr7OUg8N4mHpHN5W/oTx1pqvH+uHR0CH0uzTf9GcZVf
 AhF3wR0d1QRGYuV2+evDdQ1kqAunYvdgSYOPDSirhbRakg8t6qBX8aAgttPRN1GW0BPMGoFWXFS
 8Bk6wGWPCQlvLAi4dFn1LRERqwZ3Hg39mjKPUC+ZOiAZGGjP+5uj9/ZN84ry/MFc0aUMe15vRsm
 04uQuA+I54+Kk1CseHkKkZJZ5T55q/DOUpwAuk5sMc2xNfciO5Q5HQwnWGPT5cpZXPQ9Ir9ABO9
 9s7QKQAZByIvm+psqsr2uOS9CGVLUw==
X-Received: by 2002:a05:6a21:a46:b0:3dd:85a8:cad7 with SMTP id
 adf61e73a8af0-3f2fda8ea2bmr4128953637.46.1794469934715; 
 Wed, 11 Nov 2026 23:52:14 -0800 (PST)
Received: from [127.0.1.1] ([116.237.168.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baab5f3f99sm3131256b3a.51.2026.11.11.23.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 23:52:14 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH 0/8] drm/msm/dpu: Support dual writeback for quad-pipe case
Date: Thu, 12 Nov 2026 15:52:01 +0800
Message-Id: <20261112-cwb-upstream-v1-0-a6a88d928aa4@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Mj3eTyJN3SguKSotTEXF1Dc4tEQzPTNAtDs1QloJaCotS0zAqwcdG
 xtbUAWXjweF4AAAA=
X-Change-ID: 20261112-cwb-upstream-178a165f816e
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794469928; l=1932;
 i=jun.nie@linaro.org; h=from:subject:message-id;
 bh=LDQHNEWwvGp+XPmG1v3NAcjKHwFdOCIS9tVrnzczdd8=;
 b=ARmFWeiLPQROkAvRDrimtqZhEByB9Xs2LRthGXKNk7FplqMa8aDEP9C/QIRIxm74yD7K7XOcc
 nFMA2ISHiQ5DlK87dmHxhJ1Z8mjAS7C5MWbwV3RpCP1oli47mkQXsx4
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=O9aRQ3+xXWihQiRRgStCET+eFXx1EZs43Fh0Xh+8Bu4=
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Only single writeback interface is supported even some hardwares provide
two, such as SM8650. dual writeback and 4 CWB are required in quad-pipe
topology. This patch set expand CWB to quad-pipe and make writeback
interface allocatable. So that 4 CWB and 2 writeback interfaces can be
utilized in quad-pipe topology case.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
Jun Nie (8):
      drm/msm/dpu: support allocating multiple CWB pairs for quad-pipe
      drm/msm/dpu: do not use DSC merge_3d for writeback
      drm/msm/dpu: support mapping framebuffer to 2 physical WB
      drm/msm/dpu: expand CWB to 4 pipes
      drm/msm/dpu1: Support wider writeback width in dual-WB case
      drm/msm/dpu: Make writeback interface reallocatable
      drm/msm/dpu: ignore merge_3d flush bit for non-CWB INTF
      drm/msm/dpu: Add the all WB interfaces for sm8650

 .../drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h    |  10 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        | 157 ++++++++++++++++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h   |   4 +
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |  17 ++-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    |  37 ++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h          |  11 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |  45 +++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |  81 ++++++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h             |  25 ++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c      |  12 +-
 13 files changed, 358 insertions(+), 47 deletions(-)
---
base-commit: 0da2f36712caabba57bd8384fe6ecb066d251860
change-id: 20261112-cwb-upstream-178a165f816e

Best regards,
-- 
Jun Nie <jun.nie@linaro.org>

