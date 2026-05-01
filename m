Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D8AFF8864
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 07:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0E9B10E2A8;
	Fri,  1 May 2026 07:15:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="jwH8GrDH";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C693F10E385
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 07:15:26 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so16320145e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 00:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1777619725; x=1778224525; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Uq9Fg7O2OJrY+/g1EvTIvGirgkQPf+eg+wmXlLWm4ec=;
 b=jwH8GrDHnt7mhiZT9R7Uj2lgL7cstylAP4Nh+9Lc/mQIHSL9QgC4kGI7WP5a4r8oxF
 Y80tbfkpD3W+z2Iz0PADNbMaJ9khfvmp6FAnAEhq3VGNPBXOeLKIcr3q8jRZ5bBHK4J5
 HpAWlVtTw5FkJ7rIzHW13TczbLbfW38ndfFL0e+mj7M7qJrFYIbBz8aV7EUmKHHGDf4J
 CVdRJarWxsix4hWTyO2yhxvts6O6b0Nd3vl0RyPY4Krnfe+H+F4fDqIX7eWOk18dsh45
 OutGuKVnvDwM8zKmgGvC9Felr3n8LYAMQ+wpeiQBjBUUII7oQlInvcjYvg/yoRHkkFTT
 DIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777619725; x=1778224525;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Uq9Fg7O2OJrY+/g1EvTIvGirgkQPf+eg+wmXlLWm4ec=;
 b=XBmS8z4S4VHeVbp7acAg3Id604ocYFx6MGh1ZVdrwBZSeM8v5pHn/ayX2at+rjTQtT
 LXAG4gg3v1qbbwiFg6CvEuq+RVY0vr66HAzQ17C4wmCsaOVO6liYO1LVajg0a6HcODTb
 5kFYAOhwk6iRvZQw7fb0ddZpRtI5T0F0utBVXNSnDVFZv+NKzzFElK1m9k9yqOcjcORg
 moiDzbjL64QJiihvSoZiZgLvfQOHnC7bnWDVGTgMfw2HOspAA56t5d208MqK2bora9cz
 KMikvdGxT64XU/4aWJyo0WoY3aR04GgiAxJ/oCwcIXu6ozp16bAigFjtM4KA/7ayc3d6
 lQmA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8EkMW7xbfoarNjEgV3cpnfZY6QyZj+CgF97qkn3cCmn+DEgLD+pfyZNXPS2dE8+jY9yhhZwa+3oi4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0MFwlgNEKYmNUQT+Bmj8vrNAX+I8WHTSsw+boKS0KAVcOiWXc
 TrtKpV1K3ejx+kbeO40zsC6IW+JcUUUbu1CS6x1YgstJMSjEFp8nxAzH7WQQh01Ves4=
X-Gm-Gg: AeBDiesJpUpHkbSkFyQV5rvCYnc97ncQHt8BBtOupxJhsUxDDBCEf+XbaVxurZ9hEsW
 5RX8ofK8XCguq23Lzr657eDW7Ok3bppR5Y42GcozdADMEs/VO1g0QcBZn17Rkr6sx3FRVUuJXEA
 Pk8ZNmFVnv2DikrFG6wi82JpgPF7EffF99ZDFD4LF6lIRhQsNT1if5O3hEHlk+HgoLPe3k4goOd
 PZNnOi6U7DLNNx5RVdpt62Z3O6uweXcxHxdKLIRcsZJxlHQM+h+zeLb4lUCF0dYVynNk60dXD7I
 q5YkvPoS+zFDXJhTvbNEq6ckZluRv8QUPnRKCqZkZJfQJQHBLr7/2Z9F63joVgBABH/2N+uOwMf
 oin59KYkDeUmB0hxS6LWdf1DvrzGkJuqermvOsOCiNih8xIRTI/o/4vrszeEPQv9rBGcHB38SmL
 xXPhvJy4HmUSw4ch2/F2cu0A+mEs0PEdduoA9f1QZ/nxRubvjZAunn3AtTe5950bpnE7VCyQQ4m
 p0zMavcybytOt1lilA=
X-Received: by 2002:a05:600c:8483:b0:487:2671:fb8f with SMTP id
 5b1f17b1804b1-48a83d73324mr100806395e9.8.1777619724709; 
 Fri, 01 May 2026 00:15:24 -0700 (PDT)
Received: from [192.168.178.36] (046124199213.public.t-mobile.at.
 [46.124.199.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eba8487sm29668085e9.11.2026.05.01.00.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 00:15:24 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 01 May 2026 09:14:43 +0200
Subject: [PATCH v3 1/9] dt-bindings: display: msm-dsi-phy-7nm: document the
 Milos DSI PHY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-milos-mdss-v3-1-58bfc58c0e13@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777619720; l=903;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=tlOAtlzfL1F+UAY6923+63QtzSr69t1x2DwkX2ImYg8=;
 b=laQULaAfc8EYK86r34quun+1G5b0TcaS4cM1GnEOiCb5Pdj9nYQBetdc5qYDEZ2hKy4ccSmM0
 tNuCVFDpAklCmj6toTgXK7Z2vsTawUWdb7/wVXasdTc+WvdDau5oM9c
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

Document the DSI PHY on the Milos Platform.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/phy/qcom,dsi-phy-7nm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,dsi-phy-7nm.yaml b/Documentation/devicetree/bindings/phy/qcom,dsi-phy-7nm.yaml
index 966c70d746aa..f397ba3fa84a 100644
--- a/Documentation/devicetree/bindings/phy/qcom,dsi-phy-7nm.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,dsi-phy-7nm.yaml
@@ -20,6 +20,7 @@ properties:
               - qcom,dsi-phy-7nm
               - qcom,dsi-phy-7nm-8150
               - qcom,kaanapali-dsi-phy-3nm
+              - qcom,milos-dsi-phy-4nm
               - qcom,sa8775p-dsi-phy-5nm
               - qcom,sar2130p-dsi-phy-5nm
               - qcom,sc7280-dsi-phy-7nm

-- 
2.54.0

