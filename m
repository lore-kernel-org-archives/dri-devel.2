Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73861E9D802
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 14:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1715E10E24E;
	Sun,  5 Apr 2026 14:34:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o+RyREqT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YDgUF/Hp";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0DDF10E24E
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 14:34:13 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 634NwcV9552157
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Apr 2026 14:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mEgiRRNXVBNBCFK41iccbVB+NEAUjWWt1W4xiJ6K27c=; b=o+RyREqTDr2HCPa6
 e3vUYlyXBeZPxh9bR6fTb6GF3/cMw5NSSYzz43PChpV00l2M+HyT+n7o5lnBfb9J
 1dJkB6l5/teNpKtS2DI5CsAl7I7J57ceCPi44MCQbauPQZrATTpF1qUDRbDk9MpB
 X2wAA/4IcqA9Md7JhykuvGEBZY7W0cUAuxqmm8eX8XZ3F2cVWXFnfMRywPOybVS7
 ZSk7s1AHlH4w/5Zcby6DoPD3PUcZXJhR1RTT7MMh7VdPCc1HfvtnjwPPq1qn2lvg
 R5jbDRhaGmxKwRY/gQbHXOqQ3aZAZ0sLNgwArggjDHDF+LnljRg28uo69WizfY04
 kshuAg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dat7uany4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 14:34:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d831e8083so17879681cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 07:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775399652; x=1776004452;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mEgiRRNXVBNBCFK41iccbVB+NEAUjWWt1W4xiJ6K27c=;
 b=YDgUF/HpdZ52VsC39rQEMXOvzBqCe6dPJKLEJdIhll7jauSjEp7eqXtslH+t1GFvAd
 9+jWUH5x6evaUYo9vg6+0yqg9eFM/3UNTgaoSOYSkbtvN7HNBmC5m3VrfH4PEjlq/Ys+
 XnykhJKxBFkUKs563hR5GgTX8JTggl+0uYk+alv6zqqtRBnHDrvCB5XAkSJP9Z1ZcLfo
 RHVB7xfo4/BKIXn4XiGm3H+fpo5w8piBi48w8EnZVp/P4I00x/adWd3n/yjV2w94sBxx
 FEabCNq61XCQML2OPpGEYtbj+Hh+EaEtD0ANZjQKZ6yZRjhyfPSyBLMzj9KZ1E2+WmPn
 6Clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775399652; x=1776004452;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mEgiRRNXVBNBCFK41iccbVB+NEAUjWWt1W4xiJ6K27c=;
 b=AxPR6Th8v4zOJh8dUeICC5ZLIJVudHp8RlCYxCzS0LMFrJjwxizG9znBfDbvtIh8u3
 GX6WCUjAXJrDfseYJQPbgADd0ZbIeMbraN+mVC1rqYqLBqNzlM+js2CsJT24LA0G1we1
 Vw2ocK8MZOZfol0EdfDrAMIpoYaMmqWdK+Fdt0PwRn9uXMCihS66tuHkeQ0RELH9zhDt
 lFjerUwcegvpptgfWmsnKq3ivdqQdyIKh7doRjW3uYJAj54iaX8zlHI3XU0t9lrXL3iV
 ZCCAt3tL6/f+jnqJmZKaw4ChbzAuURl091bdIvZsgv2F4RwyX1KK3EJBIcV+D+IXXqTz
 lpiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiJjx6way8VX24ivgPbgR5zK+i83pICzdrBmWHlKmkEvHQrfPqzIrAcDZh1/I6HQsEKw9IMBUTFMo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCCVJQaAEAP7s30cCaZOPBKrWdpKGPjWwIHaUZa/hbAopVL/YV
 VVlwvc1pnrFYRDmqxuRufAcKQhYPq9Arqa5voYD0eY65expbzfbramINiiNjw2xymoQLsomkau7
 KJqP4dDMujslR8xDx4QJ9QESI9dU6PT07RHN2qhh33Jh6TQccW4cZ5Nn09nHBaS7ARsQVOW9dv4
 2HETA=
X-Gm-Gg: AeBDiet26AI+my0HIh7Uj1dhj//si2sxteeZemTocckMZ7UEOqbj3ZauumnIFLCfZyW
 y32pv76dDPawcDzkri8tPcS+6K6I0WI6f10ree23mS5BY+xssRei4tGTOOV9q/VrI+h8eq56duD
 Zeiv4D9O9MoVrwffb5GRk/zVtU0IuJeeUxg5vIi6kQK/lR3HT8rwWR1sm/ArWbAl+jaecGrGNXf
 RjjN93FFTcG5GAYbmX31rleMFbAKMZD2MO3ryJN3VGCiF2RPwVuXxio4yWASe7WhwHEYzVgahfT
 8uR3TxZR8AU22ES71Owa4IcjdLZsPqYM3g/PSf15WfO55Y9PC5tow238QMCTZAtC6EXAK21adbM
 GS0z7TVDz7cG2hJnNxKTZP5KQ7QGLvEF7zCFvibmNrwTs
X-Received: by 2002:a05:622a:228d:b0:50b:4e4e:1a20 with SMTP id
 d75a77b69052e-50d62e5409fmr153503831cf.59.1775399651850; 
 Sun, 05 Apr 2026 07:34:11 -0700 (PDT)
X-Received: by 2002:a05:622a:228d:b0:50b:4e4e:1a20 with SMTP id
 d75a77b69052e-50d62e5409fmr153503441cf.59.1775399651463; 
 Sun, 05 Apr 2026 07:34:11 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e80a616sm713934755e9.2.2026.04.05.07.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 07:34:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 05 Apr 2026 16:33:57 +0200
Subject: [PATCH v2 1/8] dt-bindings: display/msm: dp-controller: Correct
 SM8650 IO range
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-dts-qcom-display-regs-v2-1-34f4024c65dc@oss.qualcomm.com>
References: <20260405-dts-qcom-display-regs-v2-0-34f4024c65dc@oss.qualcomm.com>
In-Reply-To: <20260405-dts-qcom-display-regs-v2-0-34f4024c65dc@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1518;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=T6igVgCi17Y30yaXK03+ftYDUSOYqPbFkDI3RkUHhzc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp0nLXg4arhCnf29Y/cl21C0sPWg82UckPf01be
 pfCjsB15e+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCadJy1wAKCRDBN2bmhouD
 1xWFD/wJ9pCf5rqy3LgjmpkHPUsWmp9STdD6vWbwMf+kFVr9j/cYa47bH1dRMwF3/7jLK7X42/3
 /1U19KcW6V+c1hE/J5N8jdg1EW9r1x0sxN1XLwTt0D14i/qlQz3NWmGNfmhQZtANpLWlVnQzonv
 NkJeavpkAjPKxVOy21CB6wGY+CeecjLbNvBf6BWjeW7IowxZfmOEX9ZPWrYbY5DiOy+BccHzsdw
 nvE8dAKv9Sa+1POXq8q9rzy5L8evgPWyJMw/yraOBbR6kBOXtON5CU4uR/ZtmsWaYj5L/883ISU
 +PwFvdXWs9Kkm6np1Ky7Bf/5ZfzTKOuV8zZfqVLuq9DR+Uq8j/c40v4GAtZyW9phQdl/Vn0terH
 AbiDWATZ3fMboTDV78QeTSc1TDOli44NT/o8zKFL0sugCGHIZs9hDC+OSgqgNDv3HUzYn40Aw7f
 b7KGJsdOnriuaWpTqS9JTkJ1iS2MOxAYgypC6MRfXxwhwRkEJ6JvDoO7vqCi3Lxf7/ujGbkkCOi
 SjDRAiX6Cd4NgHVUnnMY6qZxbnyOxEpKdBB9QY1yzXo7Cd0zb1NG09xC4WiZ0CufuoPs15ZJj2w
 K0FNuf8P4b+KfqjMZVOah80G29PrnRPIGM2BHB1fyD7DJmeLagIv7w/1XUVHr+xxHXpxPBIx1wl
 c3qY/B3pZnTXU+w==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDE1MSBTYWx0ZWRfX90goJMSlvyX5
 oxzzyhJJHL1RXf6tzCpYI9gF+msk2BDRVcloRx2Qt8fd89WZXdPqNC4H2i3roCocz1VWQJ3v4ZP
 8DoCbKdlHG6WESKIKdZvKISEWbcjtTH64K0VVYBzJD0gxo8qmtueMAcNSU/YaABng0hFmOXaQa4
 449ovXQmpT5OEA67muc0N97h6m5PCr332B7WnwW19yoBW94EXalf3JouqWaSrXoT0RD3XRASvza
 dXzIgYhAqrd5WkBC1EU04l1iwN4muF4i0Du0HcxjbIqjyCUCgEXeV2k+OhLvCITKMs165T6uJ/i
 O7QYpTXmTgMKPXGvGd8Y4y+UQfT09kKgfI0N91cz62zB+v7vV+3MtB2HHuphMw4ZFlFBsd1eqm7
 RSHy2RJGnOpwbspqm5ArKJVEyySUfqj5nAh2fcFfdgzdTk2aTGiRC5+kl89YnFODVNN9891GhGE
 Y8563SKgbxhgcLLtrMA==
X-Proofpoint-GUID: kXRG0EerrYIyQTp6QL3aArG2jESLFDOt
X-Authority-Analysis: v=2.4 cv=RJ2+3oi+ c=1 sm=1 tr=0 ts=69d272e4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=LQzgrBLVQjxtG0neiToA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: kXRG0EerrYIyQTp6QL3aArG2jESLFDOt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604050151
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

DP on Qualcomm SM8650 come with nine address ranges, so describe the
remaining ones as optional to keep ABI backwards compatible.  Driver
also does not need them to operate correctly.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/display/msm/dp-controller.yaml           | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 8239adb7f7d3..e4f17d29343b 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -277,7 +277,6 @@ allOf:
               - qcom,sc8180x-dp
               - qcom,sdm845-dp
               - qcom,sm8350-dp
-              - qcom,sm8650-dp
     then:
       properties:
         reg:
@@ -290,6 +289,24 @@ allOf:
           minItems: 6
           maxItems: 6
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8650-dp
+    then:
+      properties:
+        reg:
+          minItems: 5
+          maxItems: 9
+        clocks:
+          minItems: 6
+          maxItems: 6
+        clocks-names:
+          minItems: 6
+          maxItems: 6
+
   - if:
       properties:
         compatible:

-- 
2.51.0

