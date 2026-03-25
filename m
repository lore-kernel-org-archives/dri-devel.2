Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5677106B50B
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2045410E8AE;
	Wed, 25 Mar 2026 12:17:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="X7iBbXB4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WU5uMXG9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FC1010E8AC
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:10 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PBG2fP3090924
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y7BLAw/RmPfAo/iwjgYNldkWRcpIWvYAH7e6n55Gsx4=; b=X7iBbXB4iSmXvLLe
 VMujAx5UQUu26NMfnTh0Zla7xAYDAmq/OC94dcYG/UiJi92gURqmkV/+qb2BVBQo
 PZTPQc6YDym72ReWjkGOuwC+NLJLtp1zTM6/GrugbdpF12p2GliohN006uD/Gy4o
 GKs6Ua3KHW6u+ngCOyHv/rRdoW84soiZWqxzTi1hZ2hqwMZByfMIC/PNbRHz2jd4
 3j+ZMFN6BoPUchyTvA7djRlHGkvQEVjqYzNNSLxtA9YQp6VqhpN4H9LxwUETy4A1
 sr6vYundwKOSvjhYuXKtbPUR4V0rfO4jlpgkDvJVYBcbK7zzKr85EtgWBtl77m7s
 TKeRHA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4dmprfk4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:09 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5090e08dcfcso120890801cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 05:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774441029; x=1775045829;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y7BLAw/RmPfAo/iwjgYNldkWRcpIWvYAH7e6n55Gsx4=;
 b=WU5uMXG9i5ZLqasmNOCZG3I5rjVQ145gWOUeB2nrrCaqUx/qltViJraJgvnEyXuuRr
 f493tzwtegxLnmB9l4m4ZFyKSmll99S4S2UPHJgAgj7eHenUgRuU2nyhHoyTnxw1Zud1
 Mo0f7SMQywW1w8PxhgOjhJz5sGXPSQIocZfsEF1ond6hMgt/Wa4ZIgouA8rctSrEu63o
 ZWRrqIQZNBtzPMGcHZ8Bb6jYtgMizRENbqXi5nWQjEad8QNTLyEwxM9yQp2yKaAyFDxk
 8nweEaY1xuHnszzAAbsQXt2m/1UV+nZtOiGsyDMF1bjzpEMtVqj0sXwbw5c9dX89nZwr
 2boA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774441029; x=1775045829;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y7BLAw/RmPfAo/iwjgYNldkWRcpIWvYAH7e6n55Gsx4=;
 b=GV8+Hg+XsdF2x9ZDSeD24B5nQKcbkVN61cuOuTv65/Mt5Z8LGyw+g4YSQxHgIMvWAk
 04OTbGXLzHBcJsxickP1G5gFSV8o690ZGd92buYkHHG2sEvI+82FKrdWDO+ygdOTWbt/
 n0u/XKSRmi1DBj3lg5tgB3fcwSuVIA3VREaehDMddsi6fgvPsVJxBSSIDO7SQ4J5F0an
 eYzrnhoxYrR8uCIEX5FLqgn9mf8v8y7zifFisL0rqoOBNI3S4Aqe604BQ/+3xxWLElLF
 pPMq55Tjmin6vnVi0x9175jTQ6VC+WfsSUZZRbmPy2R6+xs2MeS8UWZUjg9vl7hr+RAt
 Q6Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW28M6zYvrxZ+SzYsEHLsdQQhGabbdeCI1VnWH3sMCRV9VU0k5B7tyYAMwTmtwOLpUIjtO5GuA+vDA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyS/Oj0jyrugjX83B7C28n9WvDo7uDsH/31SH6QkUODkQ5LCpjW
 CB12dG5CSBP0tLrM8vvMJ4MkHgR3TItL51t6oEX0ju2dE/QA/r43xuPzODCgiUPz0IYtoebKIvm
 pUSidMEz/X483exSp1eRccKd7qp82xZlbP5E7zu2dr1da2eKIQSRe+fkvhWl5JZ/lVr5MevI=
X-Gm-Gg: ATEYQzw5Wb06+DMqHdapi0iDJIH/EHi8xtbS1ndEVtlvyfzSg0Mcn+iEmq6lZ9kxNSj
 8vfbSYQ+/kNmwdgfyI0bfAQ3gL74rAu3/0gR5v541xu1k+51lmQo5NBmmEKMAQWKm7nC/cKbv9g
 I18scOV5cRBHA0PaitArlRpDlmvYCozt22SakXZnYuDJaBaUjU5evP9PwKt0v0X8fF5FJqgtUms
 0Y/DGd6XSEjzkV/aBIHMaywL6Mv1slbbV0Ml3V6tJMW+yDBnIUBiZRRkcyToEHJPG7sxfob46Dg
 SA5eyD/kyGOaDDybzArMXTwQ8wUK3cCnx5qRHa3xbLxJBdnMrzM914bRl/7Be1bjZPqCm1LTq+C
 cCtkhf2CoysC+njcdEx2MeAAMUMKAgsPuY83y69kpEMwu
X-Received: by 2002:ac8:7402:0:b0:4ed:b0f9:767f with SMTP id
 d75a77b69052e-50b80efe33dmr31549481cf.70.1774441028637; 
 Wed, 25 Mar 2026 05:17:08 -0700 (PDT)
X-Received: by 2002:ac8:7402:0:b0:4ed:b0f9:767f with SMTP id
 d75a77b69052e-50b80efe33dmr31548981cf.70.1774441028038; 
 Wed, 25 Mar 2026 05:17:08 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b8a106339sm6480356f8f.36.2026.03.25.05.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 05:17:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 13:16:45 +0100
Subject: [PATCH v3 4/8] dt-bindings: display/msm: qcom,sm8650-dpu: Add
 Eliza SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-drm-display-eliza-v3-4-dc2b2f0c74a2@oss.qualcomm.com>
References: <20260325-drm-display-eliza-v3-0-dc2b2f0c74a2@oss.qualcomm.com>
In-Reply-To: <20260325-drm-display-eliza-v3-0-dc2b2f0c74a2@oss.qualcomm.com>
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
 Jonathan Marek <jonathan@marek.ca>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=mcweX3+xVT2T3dVpuYVKey0ZWpqhWMQNP+vmeo0s1nY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpw9IyV+PYXVL8EBB0Cu2p+oc+uWpMYSdHsmu9o
 R4dFQkLoCWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCacPSMgAKCRDBN2bmhouD
 1yoRD/96S6BZthEozMJyE2gdq+wvOCZf5zfzRlQUwhzWkYiuSLauvhm4ChuA/XJ7ifv2/IJT8l3
 fu/sMfHS8zpHMiXfNoA6ysYh39epnVGPznC3UaonCkNjpaB+HfBTXuik/dp93+hnIBNOXRAlPrk
 jQesbEjES8gE3w92EsCApI29eKvbwP53tHbJF2h8PL/n7CDRnAsJ/b40w4ezp4niZRM0p0stSsu
 JosBBBV3v+c8TPpv+B5CxjqV729JIjOOUagtGrNY6LGHFlkAdrnTtXvTOLaInAW0PqCNUsg/Af1
 LPVTqgfZjo8UAZYqlx6hb+H8+2qQ6zBc9IMJX4cAOXvJzKtb+hMiJRXcqyfX3dG6SLSV5SDvoh+
 JAYNq5rgwUzeqtF8MFfNydkVNAiHpk+EP41iKQYHbNospGhjlmAFw1MPTW0REbi5yunxesn5H8d
 Jqtz4g73qPJv4opiWebLeG1P3uT2IgFStG8Z1AbIAz25Vlt0r0dg/+q6Lm/xyZnmBA7S0ikIFVY
 mXKA/S8/6Dvw5RqH23khPhpdByK5vNPi39ll3M+DjuK8wdPteOWV3ilhXAvPnlypL8i05ByE2Qi
 G38oAc2G8qgU/VgQuWJ1JdpjLOx2+DygSn0BCtdZX4tPNdQALdsPY9hYM3L0YvfKtanZskDRtqW
 7UwChX0VwbzuBjw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA4NyBTYWx0ZWRfX0HPA086YAihY
 A3VxOPLkb4hUa5EHJwk4wFOWIzA/y+v1i0QEBHxmREFjVyeRRvHPRYWTZ0pScezrPAr2GskDopz
 XDpFvVFDcioJTEKuB/77VT4ZboC2YJsbC8yAC2twUi3h0R2RWijrtb2TfPo5ZcdUZhYOacCp2Rw
 dijr36HbnUHMQGVTibs3JJpPTSTg6jWGOFTBG0JSY6pGLYwTmcVr2ppGGBBOegz0bp55KF0yK8F
 GtxqAKi0Fol3IDuCGQnjk3mOGCX7rmUjbamMj8ubp0sqRUXpnLXYIxWCsAH03uCPG43tRaoPCPV
 hRjGs8QZS/LgggyXhvCFBb29pxXs0pKtf9ekpl5IPWRsnTJZl+DqKapw7y/FnAHknVURhI+DK8e
 y0/hszX7r85LPXiPl5N+1zODdBi34UJpXqDuEJrb0ADHECaHfF+XZsburQdhMQK4MBMaV2Zqnl7
 VpIvNSiiXI2DUkQzd4g==
X-Proofpoint-GUID: G7MnGYF3ASLF10Rkl_ZG-n_SAF06hYPg
X-Proofpoint-ORIG-GUID: G7MnGYF3ASLF10Rkl_ZG-n_SAF06hYPg
X-Authority-Analysis: v=2.4 cv=O7w0fR9W c=1 sm=1 tr=0 ts=69c3d245 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=GoUmjBwbbK472THZ6osA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250087
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

Add DPU (v12.4) for Qualcomm Eliza SoC which has noticeable differences
against SM8750 (v12.0) of mostly removing blocks:

 - INTF_3 paired with INTF_0 (no DP1),
 - Removed CTL4-5 blocks,
 - Removed VIG2-3 and DMA4-5,
 - Removed LM4-7, DSPP3, PINGPONG4-7, MERGE4-5 and several DSC blocks,
 - Added HDMI interface.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
index e29c4687c3a2..dccac525d202 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
@@ -15,6 +15,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,eliza-dpu
           - qcom,glymur-dpu
           - qcom,kaanapali-dpu
           - qcom,sa8775p-dpu

-- 
2.51.0

