Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD84FF885A
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 07:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EACC510E512;
	Fri,  1 May 2026 07:15:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="gWqPj1mi";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70F3010E512
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 07:15:30 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso9012145e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 00:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1777619729; x=1778224529; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W2t17h10rSE2WAVFCSqROPUo3RCLB72K5unwgCexayM=;
 b=gWqPj1mi6P1gsyfXYXKoC0o8HmEebGJLPKdJNAgl+zu36X/QMyVS8gi7Zs7YpXRXWr
 n4QTIQ8trePcCG0Itskr9Mq1p3HORjfwSV2TKQAadbmjzB3PsuxYx98Eh19FMZQ+pz4d
 IM9/PNw4hPD+I98zQRAhiZqpv/po0mBOx2YXJ0KHWgOUOU98RGB4/ZAhfdq03dudadM9
 3g/esANqnQgrFeb/p0Pyy9jTBuSMHFxYq4752vvK83NTzEBs8XRkEmyfIczI/NYw0TP9
 Vr6q+j6+Dva4cTsCoF8VCUIsBF5ivDnkqcYro6cM2Ky+kgig/WzHUusafjEFT/MBv/wJ
 OOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777619729; x=1778224529;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W2t17h10rSE2WAVFCSqROPUo3RCLB72K5unwgCexayM=;
 b=TpSee3qmwBVsDjrIH2RLBnS7YnYh8E7w4LOV00CQWwegFy2BNw/p+3m4dczHT4O9/v
 q+JE0ey4uOu6luVlo/7UZFXN7hgoZ12NPCNwRTvqQ+7dK9hF9DtZQTbXUF3zOA7aRM/i
 hFLJQAB3aXAlFWNcZ2waxBQymfkLW7kTMW18N1Y3kNQjWyQXx+v7qeYDgbPctljhyE9w
 b4OKorbBsyGQnRCq04fhFA9fI0sPaoO1CETVTz2U4XUoio3Ulcuy7MpgQtF5C1PLiYqv
 M+9gl2U5A1evkKhGxD70HkySsC88KY6jWYjdDd+ItWUnyqmXHJkVcLKfOzg1p4qn1BxV
 m5mw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8TRxeYNC0emtR6+o7kO9L/rIJehVe3u/YhonKsAvaVhgCIpvHRJ2HnwAAM56BBxpGYBZtAu9rogPg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvK3wC1hhOgFIhrynlmF7uWgHVYsfmNgllvuSEN75lxmGjrHbR
 uZkCx6eyAu75l4BxgFrdAsMAzxnDmatIMBu8VThNpYWThVhegQOei0K+l45FxLjQ47o=
X-Gm-Gg: AeBDiesDKkx5toPDbLEwTArDVrqUVp9n1/0fGnv72XmKkmaTUG5A2LwQDN3d8S2Nk29
 +gbaBVYflsYZXSsbME8UW45n0NMPS5vZt10QAGoTf2/7y/DllvpVOX4UVFYl4D6gi0pN7Pct29r
 vSPgX0nuQn0HqVjYO/ItC7joHQ4+wajVFGs9M7LT5aud+uyLok24EB4tLLgfhCRGYEWyBKqWfPZ
 mzOfEmnoH9tvt1Sa2jiZrS9sU2RISzKyDSwwjdhzvdDO9m7NzF2LxU6E5j4Tq84aAYg0owBmHGs
 ET3DQhH94FDzqrs1112+Qa+UYjmico4vLbZhasTIsnbtjddo5BVfvp7sRihXMYhgbsnk90XkhyX
 NB7N3NBGYISpu5rITBoKMMmyYhGc8TJ/ppwghCjutBNlnvLzuoBjvz6ByOHGsPcXlBbQBji+yQr
 eIooHvIa5y63QZPw+NIhjg+TkPYr8auo1wcl72PKdsM4tk9anrCfb9M54fYtDjGZBq4ZRl32Av6
 7JY1sXS
X-Received: by 2002:a05:600c:350d:b0:48a:57e1:d8cc with SMTP id
 5b1f17b1804b1-48a83e7055bmr103427505e9.9.1777619728957; 
 Fri, 01 May 2026 00:15:28 -0700 (PDT)
Received: from [192.168.178.36] (046124199213.public.t-mobile.at.
 [46.124.199.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eba8487sm29668085e9.11.2026.05.01.00.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 00:15:28 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 01 May 2026 09:14:45 +0200
Subject: [PATCH v3 3/9] dt-bindings: display: msm: document the Milos DPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-milos-mdss-v3-3-58bfc58c0e13@fairphone.com>
References: <20260501-milos-mdss-v3-0-58bfc58c0e13@fairphone.com>
In-Reply-To: <20260501-milos-mdss-v3-0-58bfc58c0e13@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Marek <jonathan@marek.ca>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexander Koskovich <akoskovich@pm.me>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777619720; l=875;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=eqkvnjw06SSJ1hiPbfLlBQP+odbRhP/MaR7qzy/itWM=;
 b=rxEwrApcvMvNoaJkEGaACXpYfW+GvR1w9019BHl9gaSDxAV0SGk6cXAI935/LGMJtkXSV6sb9
 X+aYeFpdrx8BSgEphHNPQRJeb80NpybMurDmMFS7XQl9vQp4fzepGAJ
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
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

Document the DPU Display Controller on the Milos Platform.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
index dccac525d202..9da981639ddb 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
@@ -18,6 +18,7 @@ properties:
           - qcom,eliza-dpu
           - qcom,glymur-dpu
           - qcom,kaanapali-dpu
+          - qcom,milos-dpu
           - qcom,sa8775p-dpu
           - qcom,sm8650-dpu
           - qcom,sm8750-dpu

-- 
2.54.0

