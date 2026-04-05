Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068EAE9D803
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 14:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6133410E0BB;
	Sun,  5 Apr 2026 14:34:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BlIZf8Rg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OixduYpj";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DBF910E1A1
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 14:34:21 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 635E06ja037216
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Apr 2026 14:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 09A3PZL5W90G3YcBWGWFC9iLo2x5tKxQK4Q/L2pjHfs=; b=BlIZf8RgfOFPdHsl
 KtSIZceFaKmMm8lD3qeOP3O+zOMBDOx/avCrtf2MYamKAUyMa9fwWc6LijNKgIrD
 iv7eHJUphPCQ8WpO0C/2OeN8l6kD4f1IuVY7/vIbY4KbXDS0hR36hqS8Mrz7CLDi
 mzootK6AqDNi6KkaWs1JEkYEb8aABHTq84IKpwypVT/bSWfnW3qAwweYJ8ApZBkR
 lbfcJmwXbPdZSq5OwiCO5W7cL+d7WzHvBiE8Vi2u+sF993aR/Hu1njO8X7KuQ/ZC
 b+dWUN5H2iQhnndJoKGElLM5hOhBS2K5/4IHPtTnAh/oTnQet+A0Ls2wvSyg7jR+
 pG1FuQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dasn5tr14-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 14:34:21 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d63962d83so70528181cf.2
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 07:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775399660; x=1776004460;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=09A3PZL5W90G3YcBWGWFC9iLo2x5tKxQK4Q/L2pjHfs=;
 b=OixduYpj67r9MJxeMbOTTPsp6hjrEd2f2wJEUCUYmSBlwMcOyOSu0FrTAHNxpObee7
 Rdr4Hlp8yRbZE84DsmukGENtM6HUNCwJavzHGzOXcuKbZSYq8QqewpHOviFrm4Cknp4b
 CZ6QFBUKLhXriOy7yAvUmsYNDe205RrgGJVOfoKBVLktnfqnet3isA/gHA3WAPp3SphH
 MGaiKK0sxDmqNOj4Aw4CrGdU6HS6tTUfkfAA3MAB+qI+/wdixsPtNwgjX4U8YkA+SUO7
 wumdUAZwAauP4YuIpg0xu3NpbNdKaOPnvd8mJHWO1hAJr8K84WufrvZVAQ11HoiyiAJw
 thsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775399660; x=1776004460;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=09A3PZL5W90G3YcBWGWFC9iLo2x5tKxQK4Q/L2pjHfs=;
 b=EneYtjuNi9HIjE7BqtCfJirurf+gJiltIlr9ed0OY2k40H+Wa6P2O3DBe8U/Vx56Hb
 9ngzDrWMkt0NsEYWFRj7Th/wEvyJ4unuEXauZdl8IHdFTVAa/iPJwKDOfCsSqcAM/hJx
 m2+btTA78NP0sLXsH1+rAmwvzFVjQ/Cz7JrP/Rrikl6v12KsxJLffZ/r1D17L7DKUzd/
 BSz+Tgn3o2zzRNqfCxp+slJypkxb1Ktl4lhEA9t4oh8u9/LIxAOs+2SkrrLtLtfiLu2F
 feLklafiFROyiE4Aq8UBKJMbPcjo5taMbDgbeB6p/OIttA5UpCjQryNIXSiO/5/xRrzP
 ncRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUytaVHOOFgXfGn0bWD9bdwvUvuTjwbocPOcrc/XAzDlTsctfvJ1iyejMcRbmSkcZelOxBrgZiM0FY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCE6DM6Czdj7EV9K74sHo/eeWmxanrpuMMhHC2Xu4RXhQoVsJW
 zgsr9IF8ayxqNkSJ8sPbYnP05YsQVXPfGcpZEUO0Prr4PwCcxPZhUslruAvLfrU7oSEKalnnkhD
 Jzp4lxDn8PqcDttCPCJtyY9AdJFNoiLa7vKyh0KFwYoUn5ny6R2zWwGmOpUrkFA1LnIoMWYAw7X
 7IqME=
X-Gm-Gg: AeBDieuLcqa4ljruJv3gENd1BWPA4S3zbLaZppLuIDVfg5MpS9IkVai49F4z6Ce6IYq
 QzR225tkg8KgbudNjsOdqQHnC9/TppE7NhA26e+W6K4IkiCux9qbfQyJ1JGZaHB8dzuIJXfdCm5
 WHqTQ8zl0Scvqr3WltcOwnnGk0QpYTIMjsf2s4nMXQFM+j6UrWvUhI0DYNa7GPoGYWRH36Rhr4E
 fuTVjvDsasIaaLHvlQhjaBnW15eR5+X3vplZh03VtpSK5XBTvCMjwrQy8bkF7LikFzRRCa83qhm
 IoFNfsFiuBZbjwTFspwhChwGsK0HCb5aSy8DznSrtdkgL6eVa5tbJEiS0ElfO+50hXZCDudofPo
 UL7kZE48nGoiId7sTDKslZD4J25O/xfixPkYjgJERxYI3
X-Received: by 2002:ac8:578c:0:b0:50d:6ab3:1acb with SMTP id
 d75a77b69052e-50d6ab31ba5mr124019411cf.41.1775399660394; 
 Sun, 05 Apr 2026 07:34:20 -0700 (PDT)
X-Received: by 2002:ac8:578c:0:b0:50d:6ab3:1acb with SMTP id
 d75a77b69052e-50d6ab31ba5mr124019031cf.41.1775399659990; 
 Sun, 05 Apr 2026 07:34:19 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e80a616sm713934755e9.2.2026.04.05.07.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 07:34:19 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 05 Apr 2026 16:34:01 +0200
Subject: [PATCH v2 5/8] dt-bindings: display/msm: qcom,eliza-mdss: Correct
 DPU and DP ranges in example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-dts-qcom-display-regs-v2-5-34f4024c65dc@oss.qualcomm.com>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2681;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=EOkEtNOT+8aXcaxks3bgxHBrXFY/OidYwxMibsB6Zws=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp0nLbM2AewbgW90eMtXRPYcZk00euiw0da6sNM
 mVWufQLjLyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCadJy2wAKCRDBN2bmhouD
 1+CgD/4pzOmY205An+ABBRTwsCBfJKqPrdxefVHALEWnCfKmZkhKJcThpQ6jSXzXTg7dh9f5xnD
 Ta4jGfx8N55HbLg6mBMMGC59noBcvqHi3cf+Cq4Z3+evIHfyUkGVw/JnuXCM1DUwpaoFr73Yv4C
 eROoW+pgjNC6jkGqSSzziamysKbT+z4RZcoXLc64tP8F/kGx6W1IV4eVC/DJ9DuMrD+++eCes5r
 m40ecwVTJRKIWYrns0TM08fsjKxZvej99CQWCT4Bqb3owNekF7ZSpqsFtg4fh9OZZGCurXqo874
 a97kDj6gcSkLfm6B7HdwWYol2Od31jdS2oMWt+HKSwbJl/KhXoUAoSOnDQOqHkB7M1q9aF3rdne
 66GqGR8FNbhCvanucssLTXSHM7Sqi8nPpnUy2PmG/8zj8M3kuHGbOqGl9h+Y7SHrnw0nHdGlc8s
 dQEKaZfh7p5FRo2faXNzVetot4cfgNarv3+1agGqnvGwOl+N2VFD4Qq6VPUZxKQQMrAgVtLKAWK
 HsoiV3JooAd9NGFA6hS85k9eA+p7GlmRmA23HmEevj6b2KDKotlOMx9ds0Tt0DkJDzuK+NYeX7W
 mySY98pU5SWL7JZMdGciP/x9CwJj9S0s8wRUom2WWrjny6RFjPNNgcjV8E77qt7ucBXY4Frvgs5
 ax0Jeh+JWKZp2hA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDE1MSBTYWx0ZWRfX8MC4e7ifRSXV
 W6XA52OMj79+LFZQXyJTd287LTG61qQCjfhWmWre8yd8SaRSPH+qJQSRrMD3AI+T+Uwbz6/4oya
 QoBA2geUuXeMiCuiEgWWL1zRfdZ+AEpwQr+9QdPOvDT7mN4gcFLD18wIrNEatGJm2wO29Rh28lE
 H5XISv1h4fOIkDPQ+y1l2vFmxU+RzBtaP/n3q0RWg6z5KtsYq7SbRvwmR6lFQuLgoQYv5Kavr8A
 OzdbYia3F/T3nbQzzOapt6mxaqbDPQ7mwgQEmLjEPiaAKgwjZpbOF6uM/XINqOFFtHoBGgqwadJ
 lF1Jpq+wI3kGktGwToMaOQF8hlZF3JfJ2azfj8p3+dAMJyFoIAGjWiBmlPDvZMmxonjoC9z5ijL
 6Tf+eWzx68ct8rSCe2/bdKWRMu4U2szZxrKKHBYUMXbq/cBI1CfeMHpQzlwDk8f4psUXnoL2czf
 eDDbNxxT10fIy+TqsVw==
X-Proofpoint-ORIG-GUID: iQxbK9iI56KTxbpgBEmhvhbVEIfKr9wm
X-Authority-Analysis: v=2.4 cv=K9wv3iWI c=1 sm=1 tr=0 ts=69d272ed cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=2E8fMljBJZ0eQ63lGZAA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: iQxbK9iI56KTxbpgBEmhvhbVEIfKr9wm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604050151
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

VBIF register range is 0x3000 long.  DisplayPort block has few too short
ranges and misses four more address spaces.  Similarly first part of DSI
space should be 0x300 long.

No practical impact, except when existing code is being re-used in new
contributions.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/display/msm/qcom,eliza-mdss.yaml        | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,eliza-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,eliza-mdss.yaml
index 47938d13d1ca..bd4ba91a171f 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,eliza-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,eliza-mdss.yaml
@@ -119,7 +119,7 @@ examples:
         mdss_mdp: display-controller@ae01000 {
             compatible = "qcom,eliza-dpu";
             reg = <0x0ae01000 0x93000>,
-                  <0x0aeb0000 0x2008>;
+                  <0x0aeb0000 0x3000>;
             reg-names = "mdp",
                         "vbif";
 
@@ -304,7 +304,7 @@ examples:
         mdss_dsi0_phy: phy@ae95000 {
             compatible = "qcom,eliza-dsi-phy-4nm", "qcom,sm8650-dsi-phy-4nm";
             reg = <0x0ae95000 0x200>,
-                  <0x0ae95200 0x280>,
+                  <0x0ae95200 0x300>,
                   <0x0ae95500 0x400>;
             reg-names = "dsi_phy",
                         "dsi_phy_lane",
@@ -388,7 +388,7 @@ examples:
         mdss_dsi1_phy: phy@ae97000 {
             compatible = "qcom,eliza-dsi-phy-4nm", "qcom,sm8650-dsi-phy-4nm";
             reg = <0x0ae97000 0x200>,
-                  <0x0ae97200 0x280>,
+                  <0x0ae97200 0x300>,
                   <0x0ae97500 0x400>;
             reg-names = "dsi_phy",
                         "dsi_phy_lane",
@@ -407,11 +407,15 @@ examples:
 
         displayport-controller@af54000 {
             compatible = "qcom,eliza-dp", "qcom,sm8650-dp";
-            reg = <0xaf54000 0x104>,
-                  <0xaf54200 0xc0>,
-                  <0xaf55000 0x770>,
-                  <0xaf56000 0x9c>,
-                  <0xaf57000 0x9c>;
+            reg = <0x0af54000 0x200>,
+                  <0x0af54200 0x200>,
+                  <0x0af55000 0xc00>,
+                  <0x0af56000 0x400>,
+                  <0x0af57000 0x400>,
+                  <0x0af58000 0x400>,
+                  <0x0af59000 0x400>,
+                  <0x0af5a000 0x600>,
+                  <0x0af5b000 0x600>;
 
             interrupts-extended = <&mdss 12>;
 

-- 
2.51.0

