Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AE3106B50C
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA3EE10E8AC;
	Wed, 25 Mar 2026 12:17:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hedlNCHL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rfbyw9on";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE96D10E8AB
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:07 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PBGaIQ876370
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PMrpbBdlyE2XeeyO82dhVGX9eOY8ec9Iakf8KN3jnbs=; b=hedlNCHLeleO004B
 57n31liYydxdUIRHXh5sRG3u/qpGzpVpaTohO/c74r1U7WcMO2YVC+EFBa88YjjS
 LX2vg2cx0if6TzJGkD09nXh+xDn7vLzhQ+6iTyoeC4aMQ9cgHDFNbYteRMkA+fo+
 OCAEmymvzBA19FHZTzj+SwPf9H6T7d6YES4B9K7Wvo7byhGIDJaM71Tigm5kK/Lz
 1f9OLMsnMYaSioRz3ByCHmDk7O1B4BwaY8tM/aU5cDhKmx8lq1TXYFpudISRRbjR
 8PZcnpXGfvuZRDXx2Q2nDXYsjtC7aPeLeRzj2LQnCuQy98p8vaGuirzoyThm2/+p
 ZuuCmA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d40f4k43u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b274f94f8so29416111cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 05:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774441026; x=1775045826;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PMrpbBdlyE2XeeyO82dhVGX9eOY8ec9Iakf8KN3jnbs=;
 b=Rfbyw9ondEPcz5ucAbEleq3QHe6ZclZqSFT7taBHV0dFyLesliTRkB9T+M/cEyyeNW
 3iEHXyLyk1UsSF4SazxpCBdhMHpIetaez4AODR4BbUttzwwC5pC7bp3Jx+zg5vsOfFtV
 FU2sj6K5W0p+HfN0RXgEsBxdRuLs4oVx30LB+T81N9qyKJR+y71d5zbv9DMIP2JJs8Q2
 wj0RUfI1rOFoWcHNKrHgNR1I4hLztaHFHs7c5pbgdHAsc8WnXknE96B80vd4ExzoHUwW
 VYg5ii/UsoBY2sN/75HKF2PBr8rEtBLtm4SboWPXOJ+dQCj3zH6YyLbE8dnbmlvEgAkH
 xOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774441026; x=1775045826;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PMrpbBdlyE2XeeyO82dhVGX9eOY8ec9Iakf8KN3jnbs=;
 b=HHZlx6KC5xUtRSBr3OVqvBO/on8mkny0XLvVnUoL25NPQVqeU8/05mdCPmfvn9h109
 /UpMMMc8lU+dt1l+HTHn0M7t3sQ3JmVkhAFJ7vGmN82HA/tOlKxbyGyI0HQ4t+NfGIHJ
 d00FbchE1pc5V1Uf6+cZKJXHHfylmUgrli33joW76gZfmmYNSgawstNPA+48+6wnWGz5
 4daMWFI32Ks32DJVxarQZpwXJTnIykg6X7BupFJell8jFGTcSvIxqqIc9uJ9opcVJmI5
 TO1uqVXhY8i5Ew6J+l77pOvRz32xbrjvqKJPj9RkA0OGF4Gkrf3p+2IeVYzafVl2VFx5
 c2Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXGJSJi1xDH9fdOLL/dK/hJxWyiphVFWzvZmmJdu1+jHXQevej/fZuQPEuQI2oI/LtxnG7+zD9iv0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxAlM9Ay3X+lKclbpUoDuVYuSbK/aowODYmF4G/GthyvF99aLIg
 hmhoylIqSCT+sXT+iz+4I9zvyK+g/Foc+5TgVPmGXYAkRjtfjpDVJztfD5jPAKu3b00ACr2uWSt
 65aP/f+faW9V9ysKF7TgEOngXI+uO8XEFWdGsP/Z8UkdPlqLxXTOnmsvPHT8hgJEhOWihwX4=
X-Gm-Gg: ATEYQzydZ/dpP5+pbDFXxPmbocFuwMJGPx/7Dltfkq7d1Exi34clnoFAjoXQKzwYO5M
 OB15N8u/ba0C1cgYbMLLKZLQruzr58sxYOyi56sORPdw6J5u6ZHfOzmzt9bXL6kuD9ZU44LjLmh
 yd7IxPnKfRnwfVi/8fjEt1aIj30skMlfqjzVh6Iu3+XtguVZYDG2RNkPoXp39Sd/3KYW7UYAL9k
 2vfMwvg37vpI21VcKhZnxAtIxJ4v/9j6MZrTOFGI/KXYNTr4JgMd6ylabHmfTgtg4qELq1SvAad
 Ffwx30Cen8DNKmJrNmQ9IMY7UG9vLsFkXYwwn0hX/Q8uahxB9uXbkHO1ZK5++XZWLEJWeo5pWf6
 ySC3lRuENukUGReedffEdVwY5/1J71VfYwa2SPvDUnhLb
X-Received: by 2002:a05:622a:d17:b0:50b:8c01:210b with SMTP id
 d75a77b69052e-50b8c01272dmr10153711cf.31.1774441025986; 
 Wed, 25 Mar 2026 05:17:05 -0700 (PDT)
X-Received: by 2002:a05:622a:d17:b0:50b:8c01:210b with SMTP id
 d75a77b69052e-50b8c01272dmr10153151cf.31.1774441025421; 
 Wed, 25 Mar 2026 05:17:05 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b8a106339sm6480356f8f.36.2026.03.25.05.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 05:17:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 13:16:44 +0100
Subject: [PATCH v3 3/8] dt-bindings: display/msm: dsi-controller-main: Add
 Eliza SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-drm-display-eliza-v3-3-dc2b2f0c74a2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=d/okUxTNaM/IDldvLB6GVpWxMWbJO4kMfCR0JuadaFY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpw9Ix+0ehZQmyCFCLUtJAq1ccOum22GeVUzY6n
 I08Yx9lOcOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCacPSMQAKCRDBN2bmhouD
 1/X6D/0ZPLgw6eKyTv3UdmXt03oTKH5HsS+wvm/rjriwlGD3UUHcL1MOC73u3hlooVXO5zUHeN+
 ex0o1ZZL5EYr8U88fzSPbIHAwSRVEgadOTqIf75FLND9UFeVNAuYsQFHut34CuY+Mj9PRdNyOsi
 NBzrB+JohE94HVIoEFC3WT4zkOXq/GA1rVQLSyyVQx+QeKNltLCe1yDdhbfqnJwdoA6Xe4bdeJj
 ZVvkhrpieuQGD1TzbMtmxwtgD8NaSEeTwkPJep9+seWsZKK5L559ilY0vkYedg2JG/cK+84D7Pd
 IL2rC5YxQtEB5Y0nhfEGFbzLkDfngkSY4lSWawht5P9aUdwofwwkfAJ78gn1og+QZyp/tqWUriU
 bMIT/7gROiau9Dv8t/+fbKoWuwL7BUb6aUNznOWP/nqH/FX0zUNDxYbphTCHWJFskj5hxXuvy56
 12hKTo6dnFvLSD0jECQsxX3tsR8Owm5Qfo1u5VNJVeJOQWfCpwBea2C4ldyPA3zT7Zvu7vMLg8f
 S5QYysi3PZzRPG8TDed0wGirnQLXrim2JLr/D8xIuhepSFfdaaO7Wlo43qvYL8smBuCCvAPUfQt
 URPMDaTYXxbaL9N68yZXlAr6AKTo7MpWhuQiUnTKQOzM46JRHcEMYqxOaPh4nxeYpP5+KkzszdW
 /2dhLjkWVCF+2lA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA4NyBTYWx0ZWRfXyaXgLtEjVcMj
 Vif/QmuqoQNuRlGQRWtxK0gMFkvPDn1XMy97ehbJgVqACmHa8/Ose1UkT07eyFpckkNFCApCh8r
 BKxCSljFacFbAUbp+zAiGPbWk2n+Z0MCDArI2nVcwtwMJ2Ff3B+zSNy+WVFadT7YtgauObyGQqf
 9a6XCqToVZCW3Bo3H+4Nw44I/KENFWFTYfcHk60unuluUd+3Ai7lZdcNlO72HpyNV3Fwgz1ataS
 MNskvbSeMii6AdURUjBT/z4x82GRubnUyCSN5/plF5frPO3B1Kpyfbaa1sIdzVIZeiFFq7L8UFj
 Gkw8nEHgtEnJe5zpKjF+ZTOtJZFoesFPskST0yv+tP9L2s41bTkhD2wFwtUQllvfAByLC7MhQYB
 Xz02LESVKmElw23VWPBuhepxtpSSJgELU6GkNKzCtsyXmKkuZZ6gIpngw38dejdT8HwVSbuapnb
 N9UZ51IcCrTQhq/fG1w==
X-Proofpoint-ORIG-GUID: r_g6FWOoK-f02XXlQxYCQwlp0XaFTB2i
X-Authority-Analysis: v=2.4 cv=Cd8FJbrl c=1 sm=1 tr=0 ts=69c3d242 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=o3bpWG-eKcXMc0DUatEA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: r_g6FWOoK-f02XXlQxYCQwlp0XaFTB2i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
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

Add DSI controller Qualcomm Eliza SoC using exactly the same block as
SM8750.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/dsi-controller-main.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index eb6d38dabb08..49b8b6db45f1 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -51,6 +51,10 @@ properties:
               - qcom,qcs8300-dsi-ctrl
           - const: qcom,sa8775p-dsi-ctrl
           - const: qcom,mdss-dsi-ctrl
+      - items:
+          - const: qcom,eliza-dsi-ctrl
+          - const: qcom,sm8750-dsi-ctrl
+          - const: qcom,mdss-dsi-ctrl
       - enum:
           - qcom,dsi-ctrl-6g-qcm2290
           - qcom,mdss-dsi-ctrl # This should always come with an SoC-specific compatible

-- 
2.51.0

