Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C705EC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F2DD10EBE3;
	Tue,  8 Sep 2026 13:24:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SI1dUWb9";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E4F710E9FE
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 13:24:23 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49b8eeb3ff2so43848005e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 06:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788873861; x=1789478661; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6G1+mRZXQkoxNNx9BRw+gGVfxUdpfs+D6xhoh1wgQ4M=;
 b=SI1dUWb9KQyKDzmavDXw4xGV8TVSUWBxAyxq+ERNmE/iGIoHhKNKkhtmYyxdG1bIiW
 yzO7+AGOaJd4UPKBrkhI3yLln2KkOd+JF+/nfHZjDacbhym3S62OU9IG9GDg44DhcW/4
 xddrRyJwHfomsz948odzpnKwc0oL94UrO9NBvr59RLxqFKVRJdYy54vcXB13C5viGOCK
 J2gFkIkPUXteMIOLMdnS4jJixR7Vg4soCy6ddOyhSnMIP5sRguD5EuVn/cicfnFMmEjK
 l2r14Eh99layXW6QpUCQdp+LmP99NQhHr0Siumey+Yyn6NUAiHLY9n7prKarg2EQZNPQ
 LgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788873861; x=1789478661;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6G1+mRZXQkoxNNx9BRw+gGVfxUdpfs+D6xhoh1wgQ4M=;
 b=KleAzU9ByvpSQWCuCHp4zWa9rFM80vNKPu7OFBIbO0BLeE/xbyyhKievYwkLa8c26/
 FtzlPpm0iZT1oxp5m9li7L0n78y7YI3MpWjSidQC2ubPAHzIlm43T5JaJ4Ccta+BYs4T
 oH2P6bRuYLDmhh5sFraaTurPWvlrh/UDfI4BrrokdDXgHYL4mek6qf4lpwSUTrVzTiFg
 9itySWWcj40UW8WFDJS1SvD9Q8wUwg4rBCBU8wpspJ2l0bZ9b2jyFHQwztPCh+ZWF4HW
 IZUQ4p+M97tyT9GTIjqj/aiWr/lJupKHLQy9wI7LWqCni/flqlYDkXx2yt150s8RhpRi
 xB+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4YiSwlpZkYEc+M2W/2uAqOOnw2ggcX2bzJo4x+Mvxnudkb/c37SuNBi7TLNVCbbMm+5vm16vzNqw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lv7ZwdmcdgvI6CQAaxgjEH7gJzPQDh9KZ06i2UjUUN+L4aC94T
 p7RStqnjC8vdVBsClAr6x+biZZBQSugKrRnC3HBX3EAv20ZL62RuBcukjCTXnRlqgv8=
X-Gm-Gg: AYBFou3BtSEq9xhje/lxSG6rqfw96zR8GMgYYtRo9pWcMcL/tOlzq30A2MxBwzYKSoa
 1gFmGZEIOY4vXghSb4WenZDfy/cZr7YjjfKmHbMSTlvj0VHj0fvPJ7hTwsyh9oRafmpGBR9YLDV
 qVpSTRunqsUvuknPhYxpJIGFqpVVZ75NTSbawaNGabWpkLycm6meuFYLvQG7A5LNpuM5X1DRjJv
 TRdKGUQTQS/PSLOLGe91sYlriYhzAVZVWWKiu9uCbu/Ch3KvQz9K3XNLkSIZ4wgUCiUpW5L7PfN
 fQXET6YwlO5bXaMD0ti4lI2KY4NbYg1iEZI5B+hz0tMNpfDHNjmRaO+1cb54PH46yjJp4yzqUlI
 mMysVPYUvNE/w/PN/hWkVp9Oz4D8govlYcTeTWxSny/23YjiUgYCbJpNE7+ppA/rqk1RZ+SE9jX
 8mIEmkyhwAjtafyzyXXc9Y1zBINSFmlxsCAt8u94js2Yz6V/60a6LgU38FmVHeQlnNG2eOFk8rT
 Ry59SZU1Avddbk7ql4=
X-Received: by 2002:a05:600c:3b99:b0:499:bf0e:95c8 with SMTP id
 5b1f17b1804b1-49cf81fb72amr306665585e9.1.1788873861249; 
 Tue, 08 Sep 2026 06:24:21 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d07b371afsm298959475e9.9.2026.09.08.06.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 06:24:19 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] drm/msm/a6xx: use correct timestamp counter on A750
 GPU
Date: Tue, 08 Sep 2026 15:24:12 +0200
Message-Id: <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-0-284880d6e68b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHwMoGoC/yXNQQrDIBCF4auEWXfACmrSq5QurJnaKZiIY0Ih5
 O6x6e59m/9tIFSYBG7dBoVWFp6nhuulg/D2UyTksRm00lYNqsc6Zw4oqbdGYUwLetdG5URSfcp
 YKKImZ5whq90wQivlQi/+ni/3x9+yPD8U6i8N+34A0GmWDYcAAAA=
X-Change-ID: 20260908-topic-sm8650-gmu-a750-timestamp-reg-2e7575e6279d
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=5i9UIVCMxH7Rf1YAYLFze1m/DXMlN3h6KBiETNgPf/0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqoAx/YenaoUcdB02S0+EiVQFN3+Cn5TVKagHczqri
 yd7HPweJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaqAMfwAKCRB33NvayMhJ0fFyEA
 CT6MZorhtSK+DxddSw8ZifeJms8srEumSB82m2rdioHDbaia2uNoBc9MNN6oGpwF7R0Fc4NPIORCrR
 6SRWedpN6l2BZsZerPeHkOc2x+pbfysSQ49Y2bLY87/VNl+jY1i+EmNvJ9OPrmbkzSdU/axL1BdaNX
 sF9seowpQEh8Kxp/6znKRtaGe32Cp/atWYGCWPlNSH4cAYMuleZXT2TVyTdlKzHeSKmgtAFg5oypEu
 vlpQDrGoxbbBP/hvLG3SFqkWKBSKw9hZfJw60Ps3zKXYTpCrihpn9yWsotfKZ3P/lRgmO8UAOXochr
 I2+6kEySMOJzT4MoUn5dxCTvYKFLohFtBDkp8zeZTwqPLE0gU8vW2y++euha8wka4raBj2w+ksFGpw
 ngE/g4CdlVH6uuW5rkQv8JN6GGoNzsxg6OhGK+fWJZBNxD/4irxJfqySKkI8JjDGHZXmZVQRrfdczh
 oPLU1gD4W0mOpO2yqr6tY1mF+FhyANHCkESqxfv1dUkl/PSIBEsF1zYU1qq7dlVMdhUwHxpQOAqhio
 QUG4Sy2qnksS0d0SqFr1CnnvGKAiQ/dKNFeL0lQU+RY32aXI+HfLQ0jhfypB431UX9fwRcqsyVmixw
 237oM1v96EF8VZ3JlS6uya6BgXtg3MRUoYejSVaB8tX/djNmgzAw9Y3d0jew==
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

The A750 uses a different counter register as used on the downstream
driver:

static u64 gen7_9_0_read_alwayson(struct adreno_device *adreno_dev)
{
...
	/* Always use the GMU AO counter when doing a AHB read */
	gmu_core_regread(device, GEN7_GMU_CX_AO_COUNTER_HI, &hi);
	gmu_core_regread(device, GEN7_GMU_CX_AO_COUNTER_LO, &lo);
...
}

gen7_reg.h:#define GEN7_GMU_CX_AO_COUNTER_LO		0x1f880
gen7_reg.h:#define GEN7_GMU_CX_AO_COUNTER_HI		0x1f881

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      drm/msm/a6xx: Add CX AO Counter registers used for a750 GPUs
      drm/msm/a6xx: Use CX AO Counter register for timestamp on a750 GPUs

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c             | 12 +++++++++---
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml |  2 ++
 2 files changed, 11 insertions(+), 3 deletions(-)
---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260908-topic-sm8650-gmu-a750-timestamp-reg-2e7575e6279d

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

