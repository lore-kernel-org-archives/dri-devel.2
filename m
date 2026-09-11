Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3612C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:37:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D5A010E3F7;
	Fri, 11 Sep 2026 15:37:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZibVUb4h";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kSpKXZHr";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B34510E3F7
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:37:22 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEm0vO1370329
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w+NzFK+jhrEXQEV8A8yfqvHMoGUTclgm+A97KLRt7cM=; b=ZibVUb4hLzrmkptS
 yEVl8/W0rQMrssXkNynIdHAE4bkAZEQVm839IwZoYIOD07J01SKW8l44GERW7vIt
 ojVC5+6m9Qd9sA5qUzzaHjMEGtDpME8c8iX43+fMwqhJzMaPCXUpXbYoxduAU6ON
 OD16TN1B4t0hXdAwXNO/XtTP3ZdhLi6h3uP1DkPHKW/YrrApOo8gaHniBt2AMiRm
 5yN/X5qWf6zSn79/hk+9TcNGRghr5WjClVzZDm7BWHvVKgnlGjS6LYT1zt+ygnL0
 +K7POVwh4IiEJuNAMHW465IKJbuOFx6WVlzE2rquvJyn+c+iOcqZzb2tjNV8zAz2
 IvO1uw==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbf8jhvk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:37:21 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-6bdc0e8af81so991705eaf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789141041; x=1789745841;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w+NzFK+jhrEXQEV8A8yfqvHMoGUTclgm+A97KLRt7cM=;
 b=kSpKXZHr9IOa7nDY2RWNQJhF/E7F5LIr6x3TkPtFhTPf0sQ6n80FX7Kt9Jo3B+Rv/M
 VBiFJ9VWo9aj96y7I5ppblXEVGMsvp+jTbXQiVuP1hm0bQmY42y0bsxMAGkl5smzBhNY
 DBZ9abb/86TRhtqhXCHixR5a6Rm5ia7cA6qFbNK9WM51NosV9L+ipu79S5niqgz/LkRz
 SdMmd3q1Ol3G7JAycgksJVgV32iBEtZrlpByD8gYwtZvIRi3LCxJg3NR4h8P6Byh6CV5
 39r/3sLQlqvn/+VBWTacKEPGjUlfupI5zQs32YBwHSe4MAS0jeK7IhUi979KhA91Zsxb
 FBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141041; x=1789745841;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w+NzFK+jhrEXQEV8A8yfqvHMoGUTclgm+A97KLRt7cM=;
 b=hWiqVIKq+Fug9SruUaiphDbCNeRUkbNHAzZqLGFI5+hNt9OBtrlNMR0Y8tR+tQzCHd
 0P3KX4/RZKxkOKMy8WH6vgu4CWnIlcwCI1QfyPQQzS6YlfoErgVyQOa25pgtg3GCCI59
 m4t+K5zNtanF9q/sQnIX2RQk6bf8Ks7oKl4xPQy7fA2Pchx3QeIphRjsg6drNUWvLQkP
 95dAk8EMmuw17UUQL5gI4ZHx2h4cUVBQ/Ob1/X8Az/NDE//7hvV180AJbSsb0xwbTh2/
 7AgNwmV+HT5zNWXJXB1cY+jKULr93F848FpHrJE7ra+LIu1po4ucMxLeFWbBn7DsXFO7
 4MlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBznJAzeawibx1q/JOZo/ZpJLygyaNowe/S/iHJBhwvLnpVh6D3I2OUwd4MNdtrbGN13hLRo7GHg0GU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nMTn5JytJo38fUoLnNC++ya9n6KCUbY9/qmnxUsWcZ113W62xb
 fHBvbzMFJ5AM8roWqgbOr7h37umsQeZVFq0JZb4Lf5sHraXcPllD0JnHFxmntTpPojcvjRz5MeT
 f84vXd/4uuC19JJ9p62ies0csB6oK94DKq3OYCvSVdFQigr6v6zT26gRxs6MO6/T2/uuRkpk=
X-Gm-Gg: AYBFou1X889C8Vx3eKpJnDj50BfCVBfJwtsO1oI3jkhbL6nLMxjC4fPXyRfdzNYmRre
 N12/8beeS+nQ1TrwJvdqIyHmKYqRIeQQ6Ds1kvqCfXKT3NzvOlKa/C1n7Z+XLdM2WA4RvLfgmRo
 bBsUl3jAEz0zH7iXBtRHfn2S9HIJtCMyDDoxVA9D7GfB/aeenlzrwLWSI1FYmAlLYef0cYP56dG
 98/PqN9CoSvS/7/Qstb0iebBRCjnbHA/3zMk/84GY1afngArTO00QS6I2n86BWdH572p0ASvNJC
 jNVuKcFlAD5A+1F5wI3ARb23L3TuwusJGz0YE9LOaAi+2yPJ1ZOSCI4grBL5pCzli2aTcCqM4zD
 x/z4SIwNJRTmOK70BGspQpAu3gt8=
X-Received: by 2002:a05:6820:60b:b0:6b7:318d:85d with SMTP id
 006d021491bc7-6c0bcdaf0a0mr5142136eaf.25.1789141041166; 
 Fri, 11 Sep 2026 08:37:21 -0700 (PDT)
X-Received: by 2002:a05:6820:60b:b0:6b7:318d:85d with SMTP id
 006d021491bc7-6c0bcdaf0a0mr5142085eaf.25.1789141040730; 
 Fri, 11 Sep 2026 08:37:20 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df90ff148sm1882160fac.14.2026.09.11.08.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:37:20 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 21:06:33 +0530
Subject: [PATCH 02/17] dt-bindings: display/msm: dp-controller: Document
 Nord DP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-nord-drv-dt-v1-2-e25c073cf1b6@oss.qualcomm.com>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
In-Reply-To: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789141012; l=867;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=gx2h1808ankOTjgTieRYw6/x4F3FIMSxugTAd8F756U=;
 b=dAb+YZjbbu9LpS4+5dUjqKfYUwH+FxUIFOY0Mq9r8rTaAJC2hRMCTEmggfaxBaVErFbObwkrx
 XzNXvVcThRZATbMI6pwrFEiMRG1Dd3bqlRSfRGDX82mo/JcoxGZ7I1a
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-GUID: hfOPtM3jXbxhc5DE4S7JBFxBAlGAsSRq
X-Proofpoint-ORIG-GUID: hfOPtM3jXbxhc5DE4S7JBFxBAlGAsSRq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfXx6DI6H7h1b96
 ukF4QKNEE27840cRDY1ZFRxJmV4QM5qV31AGvDC3vXLmiJdwAGwl5qRlMTrQ4RyeCnR8/RFfcxC
 n7RSOj+2pM4UbPVUDmu26IUl2qL/lKDAA4POB/sZCDmHBHNuA5v/AaaxeFQI+tHGk87K1881lCq
 FDibbJM7EM/beJHv292GDdRwX9MUmmfk/cip71YpUqOaNiSeIeaEJzEm6P3ktjrhPCrWUI48J8r
 +zH/H781LHRVjrUo5mZMyeb5BzdKX6qwS8JE4SFDKcmZRfcr73Tj1V1Gwh6KV4wfRU6YNI0N7Su
 vyxUSFtvJpoAIFRwJDnLImF7A1wSPhhdqMS8gIXr3RGr3ODYO7E0EceJChH3lIxk1JcpC2FbfM0
 KP0z2ycaPR+IiwqLqdkouELaPlRRofUwbLUTq6LrbEWsM0yKn6Vr3JWXCbYuskGUJB5nT0Hd8It
 Re0vbMD7XLmWGI/3Zfg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfXxdd+3W8J8w58
 pdxDDOToa3XA+egk0IyStu2nGbBz71mILQhsvzYz979s/bDW0oHcBJWBv1SQniQZ3EI1TdAAtgf
 Gb9YVhTOJOiuUEr6e07gLwSvxPKGUX8=
X-Authority-Analysis: v=2.4 cv=UJFIjyfy c=1 sm=1 tr=0 ts=6aa42031 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=lCWEfuFUYIIHy-HYLagA:9 a=QEXdDO2ut3YA:10
 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110218
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

From: Mahadevan P <mahadevan.p@oss.qualcomm.com>

Add the compatible for the DisplayPort controller found on the
Qualcomm Nord SoC.

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 094a6383bb77..8d980acb1a16 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -19,6 +19,7 @@ properties:
     oneOf:
       - enum:
           - qcom,glymur-dp
+          - qcom,nord-dp
           - qcom,sa8775p-dp
           - qcom,sc7180-dp
           - qcom,sc7280-dp

-- 
2.34.1

