Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C82810F284B
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A759F10EF16;
	Fri, 27 Mar 2026 16:12:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="T82A1FM3";
	dkim-atps=neutral
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDF2610EF10
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:12:35 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso425038766b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 09:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1774627954; x=1775232754; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yxZRmJAlZG7wXtvJLfbzMriOZdXFHi1O+JuWwAIE8qE=;
 b=T82A1FM3wpoehsqnQsABtE7/leAsfto5qh4pS7g0Oq3lwNmPJkPXWLyvW3ENRTDd/6
 Xx4ZtN1aiYlf+CqRzXlm1bjQ8CSSSzxZUGjTKXJS4NMMlrULocv+uHfzsE52DkQkRofG
 N+Sb6tiiBpmnV777T8boC2q4dlIUhTLrZxHxcXtip4xgzqoGeE3oNr+EV9HR2Xtk0cfE
 eU3/49KUdj2yhelNVQN+aAtMwKk2dXOHnDzt7Yjfon6F4ozdidwXL/FV1gqR0qEvxAkT
 EEHv2kjJbxa4znlKizwXhkC8NJ8YVgSTj93X+HNm5Xnbz/t/LFC1y8QvZr49Ik9skkbV
 bkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774627954; x=1775232754;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yxZRmJAlZG7wXtvJLfbzMriOZdXFHi1O+JuWwAIE8qE=;
 b=dItcRLEQhlpcc1H/gvhRkKXAC788AnykOLGFFWR0RG0mVUppITnwZXhPaxhRdzCXCY
 aJLuOOgx0F8ruev/TYkjLL/grQAZX5uav07/HdQc6XHXm5Drhd9Rg6mpBBAA3+aZ98ba
 Q5oy+GFVFSgiCGi3MdnnaOKG9NFxzYG5DU39Hbj8FoLkfJCEbnIYi8yeS84YtRnzf76y
 bDWNk+xY7vht9XS/bMbOLccPbx86gBsksRooRjspPe6Gh+0iNxNadRRxMR5WYcKlmiKU
 EDjn/wTO61IPZlJCKjEnS/Zq3y//zMZJU/xjRoZijzzQIjSFOu1ZbSkfVmqn9BkA0Ay8
 oo0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZqZfKwgMh0RCIXVAM+VPo+6q45lb8u84F6l0XK6DxHpj92aLZNSWk68HCfMSHfZvL5R23eiStO7c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyvJjgc64rRfE3UjRF7o7V6dWNah3D7dHpapzT+yynUDQgAC8K
 K5B1bXDqwDDWJRX5vYewF37xXECcShQquQ+4uTvus7LV5PyN2YwbQbBQfmYAG7BQD94=
X-Gm-Gg: ATEYQzyjbVTow0O+VUkYgYAnCvS18JOF14kLo5x1CbjFmOCSXDw6W66Y96aM1ui+8fl
 g1lLWQE2hkzMiPDhWT8HWZEk57raGNm6vlVPdgt2UHnaMzHwkJuHKhEadJb4xLnv14Qi6WJ+P4A
 sHb6Fd286YI17V2qz9zF4TvAIvwoHKmdIslYXPmdE+aOzr/Ftbw//ss0X0xaVYcKJCZKcV4jljO
 7Aitl/4LQqoPtbwvBZB8+XIs4vZDLXLF8tth1Apf73hRn5ygpagudPW6rAQqCTs+iHrkljEwOR9
 zTdEgDNtboSATt6SdZ+fb1FEiwDJwK+92y6Ai91Rt/p+wh7yvQlWLTO2cZ+b26Hvh/dUqXlpMam
 fVPsLmo4RALlj/Xbhsy3xaOrJgun/oyYCvH9RqpreXNUGSG3Q7lJlxx3rEgRd03p+9yXdplyQ1I
 5cZvNNgzeQP0FR3YoCYaefRaE8ed6Jt45dac7WCyUQrfjC+VQh5/cShKuGAW98J8AS3g6AttzrR
 fZMIQ==
X-Received: by 2002:a17:907:e104:b0:b9b:686e:6f93 with SMTP id
 a640c23a62f3a-b9b686e6fc8mr66703966b.26.1774627954248; 
 Fri, 27 Mar 2026 09:12:34 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b20265cc0sm273518366b.15.2026.03.27.09.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:12:33 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 27 Mar 2026 17:12:22 +0100
Subject: [PATCH v2 3/9] dt-bindings: display: msm: document the Milos DPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-milos-mdss-v2-3-bc586683f5ca@fairphone.com>
References: <20260327-milos-mdss-v2-0-bc586683f5ca@fairphone.com>
In-Reply-To: <20260327-milos-mdss-v2-0-bc586683f5ca@fairphone.com>
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
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774627949; l=828;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=yE1RpxPh/DRnOKswaQ1ncodoGzX/nyTiO4Mb1VhMZX0=;
 b=EYH8l9XFu+gIk60JnlaqajCRZQpuvOuOmZnYT8nK9pzda5muZaL+zADWmYOwKH0sUZP4AMJMP
 Tac1oRxXtEcDOTjLOraL5q/iEyjayk4BVM175OuZ0oHeWn2DBaq6/GG
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
2.53.0

