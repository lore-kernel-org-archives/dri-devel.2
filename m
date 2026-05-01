Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFDDFF8864
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 07:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92B7610E50C;
	Fri,  1 May 2026 07:15:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="CeUo1klY";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 780A010E50C
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 07:15:28 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso12121985e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 00:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1777619727; x=1778224527; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L9cBOyPysOTRVWivLRI31LjBpVlIJ+dTPcG0HTJLV48=;
 b=CeUo1klY2qKQ9WXSKP4vTt/uWXX/dF+1ZzV5p6X8Etgkhf6OQCbIzpfa+W9cbCeiUb
 CISo/3+aJBR9na1/1y5V/x5xZm55kpOQiokSs07xV4srDTPrJzWAk5UjHe7M78hW0hvx
 9mpImFL4HK5OppzxXvOh/bc2+/yH6PseC2zfEFV2w89Njc5JR8mMJtBzITvNtuw/b6px
 uCGDXHaDfwLbswKUE1tLqvMLTtYAXa09XBCQ8gKQUarxjKaQqTF8Xon8HIZoMzMqGnnG
 lZSRMRHUftO9xMcaufVrM+O+LUlPDSQMeHdRr3xV3Iz1PVEkuzuHNowgBgaPitVmCGrE
 Wucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777619727; x=1778224527;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L9cBOyPysOTRVWivLRI31LjBpVlIJ+dTPcG0HTJLV48=;
 b=WriFO7J5x9PCbm8+IveaiafOcDSYMR/bfNqOwhe0+3z6GoTv9nS+uWIAV15D6/aliB
 9niUX7zspOCfRKNNctv4qAr0bzSxs/NNt/O2LKCDbXeSVdjvo6bf8oI39SH2lKd504L8
 pQPXKYM5+UMajCl4LImMatPN2pfQo+oqxrREFla0YOxL7GBb4lLexsaaM0fJqcoQIcW/
 t2ZkPrgvHDvIrT9YRc6FpAwlGN0Vf/B/dCGB5+aHzJZ/1PC1ycLAuFlZRr+5nZoM2gQe
 0E1SKCr5urWKtcWjBVC3TuSYIoZnAVb5V/eynn0avpF0qi7q/h40iO3LJnHcpFwYyZtC
 MFyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+e3RoMISxe3zq60EhM5P83HsetEEZoQMt6YCHBWQJ2VGIWQSiggJIjjc9hze+2kygEJPtHBPmDy9w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyvDqeN1FpRdC8Y1vGaAkGCUBurQxgZ1RMMDfWDMR1XDiiNhbR1
 vo6tWBNMdyiivOSnGCzeL2z7tt7EgVMoHAasKdtsSwqua+QznAGrx4j7J4ShXW/XpFY=
X-Gm-Gg: AeBDiesE4kFRhfUucoljsuTIvIY/xA4OAvYj+ea94X79/s1K4gN9pEp6DJGRkqsGpJv
 mLmHCmL6biRUEHRTHLbBvyzbZtlEYfe1PpDweJpYiX0fn0I3I2iWzqZz2XkA7qI37uDgXT07cOI
 SCBrqU0sJ4ktzm7i5DLgymfH1RPGa+qRKrJ+T8TSVL7oLnBzSQsNQAbY97TOju2Fyht9WQnM+fy
 Yn6EOloQpw5aZelCs6Gs0/ZtzhHjPAvriGtoSV15EsAjecqUQUsziGbeWmV8TZcQgnekZdG3B/A
 Tg++pRxBQwAcPmHbgiQlpckRq5ih3jMyWnQgkmUouVcLAR2N2W9AZ3I3n5ZJJUAh2l3sdZq36cK
 kJBAx6hx8HiUD30leuxvjV+tKg/SyxYNQrEHg8732H74ACZWJ3/SPE6ETX4Fs2XNk4R3wb946ys
 Nbzonybfuc54Zj+NX/rJhnwt7Vzq973jEevXKdTJlvhdMB7gB2xQe2p3pQzheiCE9TO1sCrIF/J
 PFP0DCn7m8plrez0oE=
X-Received: by 2002:a05:600c:8708:b0:48a:5970:2003 with SMTP id
 5b1f17b1804b1-48a844e4a83mr97816475e9.3.1777619726960; 
 Fri, 01 May 2026 00:15:26 -0700 (PDT)
Received: from [192.168.178.36] (046124199213.public.t-mobile.at.
 [46.124.199.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eba8487sm29668085e9.11.2026.05.01.00.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 00:15:26 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 01 May 2026 09:14:44 +0200
Subject: [PATCH v3 2/9] dt-bindings: display: msm-dsi-controller-main:
 document the Milos DSI Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-milos-mdss-v3-2-58bfc58c0e13@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777619720; l=1188;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=BCj2FLTcOJgjzO48MJefQIMPqJBsSoeL9qxaR0JSpFI=;
 b=aX1/waVjF+hvivOAF3HL0UFE6nbkla3myKttlbuQHoweT7fKoatB5FZR6ILx8LPMNgVvk1SLI
 ENhaEJDidHzBHLymIm0/WL8AWCn/emn650yUZt9JQQroA8ZM/bzUE83
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

Document the DSI Controller on the Milos Platform.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index a24fcb914418..dbc0613e427e 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -16,6 +16,7 @@ properties:
           - enum:
               - qcom,apq8064-dsi-ctrl
               - qcom,kaanapali-dsi-ctrl
+              - qcom,milos-dsi-ctrl
               - qcom,msm8226-dsi-ctrl
               - qcom,msm8916-dsi-ctrl
               - qcom,msm8953-dsi-ctrl
@@ -339,6 +340,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,milos-dsi-ctrl
               - qcom,msm8998-dsi-ctrl
               - qcom,sa8775p-dsi-ctrl
               - qcom,sar2130p-dsi-ctrl

-- 
2.54.0

