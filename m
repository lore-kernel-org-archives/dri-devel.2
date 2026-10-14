Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44DECC6B27
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:20:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F6C10FE85;
	Wed, 14 Oct 2026 16:19:57 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0A9110FE7A
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:19:46 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEabKt500266
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cK9XIjoJkCr9hVq/5NleYDwc98kzEkgjzgNbxN/oBho=; b=ZZyOJRqIYjFAd7S9
 dr/0WglLBWaRAH8j+8R5jKtyzsdd0bstAetyP4LOuG/xgaQ9mbi1VhfZdf2+tYET
 HUjHSOFOkMD+09dIX2ftCeM3clRebEU5t0FB81gFpOk9XnaFIy7T9tMobUT4aXqO
 1lvHtuix28sn6JEUKinpqGdjr3vjQZxHJsQXG4XrEgv0YvJG9m57BpmpgIDIPn/5
 PW6TtUdR7Jlewbdy21yz7Y7R4jz7n3esc2iLQEJsh5o4maLwrwHrA36GMNVhNzi6
 1jrK1bZOYyk54T05VpIv1C1wxUKOLn8EnmetzChmL6VZX5rRSFyFzhWsHseBFdXy
 UmOnjQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haagf0r5x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:19:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e82060977so235961485a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791994785; x=1792599585;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cK9XIjoJkCr9hVq/5NleYDwc98kzEkgjzgNbxN/oBho=;
 b=K2cNKSMSCUfsXjNMWVQAzyp7OX67miFe6nj/nYaizgSNPdlIebrOsyNWL6ZJrPPs0L
 ZCXZWq36qHyEhD8KEvOxpRKj8dFeffOE4BjqcnmfOBTlUxPM9krL9RM82Dm3HU/z82iS
 /ndkeltq9NZEdZVmoyK215lev9Frrup/HGz3fiDAZSwaov2tRo6pIfKn/0D/g6NMupc3
 VKvMA0/htiTx0LcA3LY3ugJTTkL5Vq7kEP/j/HZC02m/3qT34S+z3M0eF7d5VX8R7+7N
 JRPuZc4gUoHxeQZa6efiGCtyn28LCwrPU8FR1MtvbtDMAQkUxBzIlngtaJb9PcXGYMKX
 3Ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791994785; x=1792599585;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cK9XIjoJkCr9hVq/5NleYDwc98kzEkgjzgNbxN/oBho=;
 b=0PBnNdiPSeT7fuVD+FMANatLUa1LPvAKDli50LMVqo2W487hLCgE56yiKsHHQormfe
 +AC4W1Qkrl7JowgJuDN0qJ5TX5xK8QxeUMjYNSISBcKqavEQHzUR1BY5hWt3e5ahzLu2
 9D1RUJ3pVwrM8Y4jDiJMYG4LKF/gf4KY9KDk6DXI/ueKP/EwFp7870hVwewKMEnWajzb
 JHGXB0iVN+oJe7WIlnAfyPB3SJVp8ojpN5pMSK+1r2vJdpU1pvMEhhoouKP1ncNLCqSU
 3Gvl2m1rLLh7tdfnmEg4ymBMpWoUPtru6Zwa8e20UrLrOGVv1hxi8fHR9wwilIa4tHAQ
 FNSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzESWngxLIkSuPxGetd2p0gdlnf7Dm7iXETZstqs5sGK8FvTK9cayYXqUe/GLmW+8R4H5nDVlzCTc4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJZa8D9Y+/rmDBRVoCYnrz+dQbRNpLwZ6XKMa4IY3OOCjFOxka9
 v+5REOg6u6GS49pRMeiB0xeQqrPN5Cz6yxrAeOl2pEDkPWBn+TMCxa4RHvyhaFfZLPknuvP0QX1
 Gacjc6TVbHWyQEZG9lUtBgNEw88Bna2XjTktX6+nWvqvigHx0sVwZyQlMfNR/dEYa7PzzIpc=
X-Gm-Gg: AYBFou3+0gUuhRZvzT/aA1vqOZyMiuQvZdUEARS1Xll1QNyZeYgSUa9Nig01dbGgb+D
 CdQg+lval3IZ/VtE46LE9hnj3y/aGv1vftF5xTSRMr+YXSGeAZcZJLosHDa3E1/mra5D5Gav+yr
 tsepvd3Ee3cgXXXodnZS4EMO5I1ajsXisFvRItvVTCaQoy/SEo6KBI/4sHf0JGe/Twegy/dfVxn
 1ADCIpb4itdjPnK7HQLKdf3pikO/8jTrmSrUubNIM6Gm39/fPQehRKP2VvXAgLp/iKU0MyW4ezT
 uiviDa2ncQ1Y+HbzCslLiEWwXblebQ6OPzFX9XTUNDU507tcOp4IdpjyqBez/LLNehhuiS8mY6s
 o2Rf31fLZOJ+zPuWXzZ528/6vhnxu3Darqyx+LrgHdLtwlnkVr+TGdtVv+ImPpKxMQYiEJvcwxN
 8mtdocVA49TEYv
X-Received: by 2002:a05:620a:4010:b0:93e:e1f9:4c2e with SMTP id
 af79cd13be357-93ee1f94f88mr1408418785a.5.1791994784902; 
 Wed, 14 Oct 2026 09:19:44 -0700 (PDT)
X-Received: by 2002:a05:620a:4010:b0:93e:e1f9:4c2e with SMTP id
 af79cd13be357-93ee1f94f88mr1408413885a.5.1791994784400; 
 Wed, 14 Oct 2026 09:19:44 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be33d7d0f6sm740187e87.38.2026.10.14.09.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:19:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 19:19:18 +0300
Subject: [PATCH v2 3/5] dt-bindings: arm: qcom: add Qualcomm SDM845 HDK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-sdm845-hdk-v2-3-6d0b4b42f267@oss.qualcomm.com>
References: <20261014-sdm845-hdk-v2-0-6d0b4b42f267@oss.qualcomm.com>
In-Reply-To: <20261014-sdm845-hdk-v2-0-6d0b4b42f267@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Abel Vesa <abelvesa@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=843;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=BF6415btVpAVudmuKDsPZH7SQiNfH+6JB5g0CaPUoN0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqz6uHJJ7m6faoZhSn2B4QgkaU3xA4uixppdDOo
 qz9u9klJLOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCas+rhwAKCRCLPIo+Aiko
 1TX4B/9Zj+v7JOjDrwahfYekeT1LMY5X+HCPT314urp97pY7q1yWMbNC8QLpJv5rirx7PMkd0cw
 w5HlO9Ujt4PvUxWm1x1TpEZuRwsz7s/RfKP7/Ckoi6CrfSgMn12t3o5OmPi2XUhRLHlaDM5p+el
 EBClZ0ZMOIGO/N4aXP/hIJEAX2YXX+pkXWGU9gE5lU0H1oV8QgxWKuBwETEUSRJKubpkQbSst8+
 g+mHxx2pnPgRqVvVCMjqXwwsT5HjM6QNQ8hVpHxdWLV7+QEH8QKU6+Lix8zmBEq6MtmKUrX9Vou
 1Sk7e/bhS+l2qvWOZu1nMEmfUMR0GoUPMtTS98n2LHeY/i8O
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NSBTYWx0ZWRfX8nTDc11NrSVE
 NhTojau5t1rIMuUhnmfdbVPQeMy2oVRPeemJA4zxdX79f6CfQyHXo6vzsY7xQXPTUo+vF8RQiBC
 EJSYrdKHtavypJqo49yTdQuk486GIrcVPQqNH3B3AVR+3q9HZEv3kL8R6juU1+tyKMtnaLMYXfa
 P8rN3BR+d++bRbZNGH9LZgxbTMLKOZ5moLrm4auxq8HWpe/lCfjwRcsjkwvU43M7/Hwq0faPDv2
 d1JNifoUVoZWW6A4zj6fLekyOsHxfH89uMpRZKU2MzZ7xfY3JtFXmGe4lRXA1KYdgLDVJEoMwEk
 jdF86LsFKcUbsGAPSmSw722SdIOfsDnMUEwK8ZwOfXrFINeTZD1sx4mN+eI8IYWUfiP0xCaKREk
 rst1bePkTb4H7yADjpnHCjh/WXfz9YSTziBUv/ONenSJf/ySof7vjzrO8T+FaqHzPay4k9Rt653
 t9+Ha80fejeNACIjNRw==
X-Proofpoint-GUID: _65VlwFK50ZQTg71OMF5dJre7FSfMEvI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NSBTYWx0ZWRfX9l7JLlaVDmmz
 N6OBuHc/LYMO9zBBkLpY+Z0hoxCvv4DiXNrbVXyy746t77xy7BaHq8YwOy5EWoFIIc2OxjfZVay
 gPgyvoNqTzAAfD4XpXPWBiBaxGvjfgU=
X-Proofpoint-ORIG-GUID: _65VlwFK50ZQTg71OMF5dJre7FSfMEvI
X-Authority-Analysis: v=2.4 cv=V/noQuni c=1 sm=1 tr=0 ts=6acfaba1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=9nMZPvWkDyzw5AdY2PIA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140065
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

Document the mobile HDK for the Qualcomm SDM845 platform.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 121ca557ce1e..dec58f8818df 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1003,6 +1003,7 @@ properties:
               - lg,judyp
               - oneplus,enchilada
               - oneplus,fajita
+              - qcom,sdm845-hdk
               - qcom,sdm845-mtp
               - shift,axolotl
               - samsung,starqltechn

-- 
2.47.3

