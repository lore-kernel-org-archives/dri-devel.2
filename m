Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16121CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CD38112284;
	Thu, 15 Oct 2026 09:55:29 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 893D6112278
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:55:17 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9kRsU2999386
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gvh+Pd3D3uvOpYm33562JNzfr/Hgc20K0knnG1EMfRc=; b=cbog5p3NFk6uvDvW
 RCQxAiR7P4oDuwK22erMzrpGhvtgAC/0kEK7esX3pjgny8LJDieORWgTGyW4/bAQ
 vPN6ysB1ZaelBGPIjXrqHlKw6fc4iAPhyBkGIr71yn+EqMK1+oTbrCl4DHeVFEYQ
 uSAZWoz7FsaMUXkWCAH6Y0x8M+BfqCMCfUdmZINFHbUsA9s79cQkXinqDkQbTNgm
 1ncqS/lyi5VIlftYc+c2bBYUkUvyAHbFhn+59fhrUeLGwQW8n7LygMKuqO1VrwM2
 IdndfGqIcAwn4GmYZUo/ixYcfbAKQbbKFXtcm4RHE6WVSehm2ffc8YYrBLZXgYoV
 A4QUIw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hausm09gf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:55:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39de4e72b33so2787023a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 02:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792058116; x=1792662916;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gvh+Pd3D3uvOpYm33562JNzfr/Hgc20K0knnG1EMfRc=;
 b=jAScmB/ehg8ijTSk7UHx148dwN3LcUSzBU1EpO8vggXhESkwJXiGOXXuqGCnhkAgPW
 zzKKioleMWBVU9d4yo7m03/MWS2umm/L1Cfu4jeI6Zy+mLAd5G3pjixpeRPz957gOLIK
 wHJogS56NcpVQDGB1RsbaJ4fVlt+2qlCY/d+X6SYDG5sEglmNrOgl3QPzWbj3O1WXkBK
 aEoznSX+kU5CWNHJT6lBcDxHIYuBFAyVLkVe307E/hNgMqn4nUZL8y3s8pf6dShTKWn0
 pI8+R5PQtlSMprcNCL4myeU74x7p/3JeqsUhuQINCT+LD8w+zraqpxLMrxLhrKV/bNym
 Glqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792058116; x=1792662916;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gvh+Pd3D3uvOpYm33562JNzfr/Hgc20K0knnG1EMfRc=;
 b=Cpp69qugk/LOPGRRSeDomRDB4Dh8ef/qz+wt8nAJ9JMURGZzXewSdm5YvPwC2zSoXs
 sb62C17LwYlcQ0pt8h9B7frQn1423onGTp1e9veInRvyzyX3YWfThiyLo060ssMdmGVy
 wyOS6YySLWibe2T9h9JOLzDIwmvlgJ2oi290IDXdqvgvojvnQvO8C41s+CvlL8bENZS5
 tU+kegFyMPtkEa5IXwySjf/E0DHVQDd/Zr+5dOd8AP0LqIvHBbrppPDjP9+4FKE3pM0S
 UM8XVTIRSSD7CO75J+K/RzKc7iWXkBrdA8HluCAq8iXFarq2LVHF0RaJlA21X8LuCFwI
 PFEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBypwYPnMK/DGDLSnrl/8PYaraPIjjUbxmlbepKAy7ml9rqgoK649drtl43xS6tIfTBK7MSjYBSS3kM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLKrVXaqT81ky+nMnfCMnzIQWNAkWaLBH1wgSq1oSvUXAFGgf4O
 IhuwQSKSNetmNoTgBEQC9dBFB8JGrPTV/gVfeq4JOwB3YWCgCSz7yO0uUqFPTeUdYDJzeQVb+mv
 +fiUoUJsdtj6RqWA3miWNXHDfZBwxhHTLlQX+BidE9KWWFBC2PhY0+IDCCvdIKkbUTPInUR0=
X-Gm-Gg: AYBFou01g+yK/PENDMYFUIXBM5fi9loJyPm0iOcpqj0BSS6w1BiQchJ89x0hElroJ14
 3OteO8mTcaeswY4QMIklmyNibEo7PnNdXUoxaj2CvqLP353ED2FtbB7iX2zHVbfTJhkfaV/u41B
 1RA371jx2MS2qzXnHiX2/w0oYo5azYTLsfWLd4PlW6Q3fNvRnXaPX5jiatzuagf3MGOIPZgnOYh
 5afZAg8XVGxT2TVOxIUbL7YBtBDo2ouytzvAnzxUITRsfwvOEizFLqJm+HiCho+Z9PPGsSvLsrt
 8sOL+6zDtEEtgBRFIR2A4hS1TWLL+j49wv7GcWSKIEzE4j6fZsuE1/WqZ4ou2xABr2J7cOef/7J
 5dTwgatx5wabpLuCDHCXvXC79Sl4iaaus7HJ5
X-Received: by 2002:a17:90b:1c04:b0:3ac:9176:e83c with SMTP id
 98e67ed59e1d1-3ac9176f205mr2470048a91.12.1792058116311; 
 Thu, 15 Oct 2026 02:55:16 -0700 (PDT)
X-Received: by 2002:a17:90b:1c04:b0:3ac:9176:e83c with SMTP id
 98e67ed59e1d1-3ac9176f205mr2470023a91.12.1792058115786; 
 Thu, 15 Oct 2026 02:55:15 -0700 (PDT)
Received: from hu-bkalkond-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac943e1a11sm3612322a91.7.2026.10.15.02.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 02:55:15 -0700 (PDT)
From: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 15:24:32 +0530
Subject: [PATCH v2 1/5] dt-bindings: display/msm: dp-controller: Document
 Kaanapali
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-kaanapali_dp-v2-1-c15cb83d9140@oss.qualcomm.com>
References: <20261015-kaanapali_dp-v2-0-c15cb83d9140@oss.qualcomm.com>
In-Reply-To: <20261015-kaanapali_dp-v2-0-c15cb83d9140@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792058098; l=2211;
 i=balaji.kalkonda@oss.qualcomm.com; s=20261001; h=from:subject:message-id;
 bh=KUEHUBPe/fn8mPYYNLva7h/Xl1fyUiFTYnaelqktlMM=;
 b=jJjbWunLHnUWwxQDX4nnUy9L6muiboocim1vSEKrd2ADhoYhYivBvJirbOOzAj3UJQEb4qzvH
 wsiPzxH2MpGCoIjxMpZYx8VBep83kESwIa/R5dq4B7cgvfcSiT9tzjT
X-Developer-Key: i=balaji.kalkonda@oss.qualcomm.com; a=ed25519;
 pk=U+unGox551qPLS2mzIlN+b5cHksxTMGPnDwePd6KEnI=
X-Proofpoint-GUID: PwcH6wc2UZvdPBsSyNjhThjr1aszKdzu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzOSBTYWx0ZWRfX5ILuTMhrwO/3
 sUdadUIxoi32VAn9vltcGI8uh92VoukUbDs0XyQUzjdTKmuxwLxJsaoxksfXSiup6iAkoT6L4IP
 ONgpEuqyniuzf0GRiCEWJeACWIyD/9lRrcBS/+6gCmdO2bnjJnQ4ClUUg2kh6ozDw8amqPcA7iM
 jyw3w4URqp5LcIpgzz40zYFl3NyOZg0+ioTeigla5Iv0m2wBpY/6+JFsw5VoXp3/vpbQ2oPcPsw
 dEOZQjxK0+ek0rphPejJXUT/86HEZB80Kk1zF1EjvwUFVAHJIzzeA68LLS2pwxetetMQQElTwEL
 ldhkw/8JQnnpg96bfVKQ0APpPlzBOrPHciT4Uwr75zq2cW1LlFtGTQITVUK2RcPL0cA25im3g/2
 F7iakbfFhG15MvADcGuGJsLjmosdGoH+uJ9tQmyWx/L4EesUxQ6mpOL5kwQ0Dg2bHycxAJebj6m
 rMHyCMamPE0nno8huQQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzOSBTYWx0ZWRfXzff7jpIgBj77
 AerB9CK5njROPZn6g9z4v0S15IrorzmWfHPCGa8Vw+A7pHaQOJ9uRAjFsug/RUVfP9af7kSo7Dt
 iyNJhNTWUpB4yB8tLLS1ijY3vJM6c1w=
X-Authority-Analysis: v=2.4 cv=Eb5d0/mC c=1 sm=1 tr=0 ts=6ad0a305 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=V3dFujuFVO17DJ7hoKIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: PwcH6wc2UZvdPBsSyNjhThjr1aszKdzu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150039
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

Document the DisplayPort controller on Qualcomm Kaanapali.

Kaanapali uses its own DP compatible string and has a resource
layout with five register ranges and six clocks. Add SoC-specific
constraints for those resource counts.

Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
---
 .../bindings/display/msm/dp-controller.yaml           | 19 +++++++++++++++++++
 .../bindings/display/msm/qcom,kaanapali-mdss.yaml     |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 094a6383bb77..0240e3c1a6d9 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -19,6 +19,7 @@ properties:
     oneOf:
       - enum:
           - qcom,glymur-dp
+          - qcom,kaanapali-dp
           - qcom,sa8775p-dp
           - qcom,sc7180-dp
           - qcom,sc7280-dp
@@ -290,6 +291,24 @@ allOf:
           minItems: 6
           maxItems: 6
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,kaanapali-dp
+    then:
+      properties:
+        reg:
+          minItems: 5
+          maxItems: 5
+        clocks:
+          minItems: 6
+          maxItems: 6
+        clock-names:
+          minItems: 6
+          maxItems: 6
+
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
index 9f935defd6b1..83e3596ba0ed 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
@@ -48,6 +48,12 @@ patternProperties:
       compatible:
         const: qcom,kaanapali-dpu
 
+  "^displayport-controller@[0-9a-f]+$":
+    type: object
+    properties:
+      compatible:
+        const: qcom,kaanapali-dp
+
   "^dsi@[0-9a-f]+$":
     type: object
     additionalProperties: true

-- 
2.34.1

