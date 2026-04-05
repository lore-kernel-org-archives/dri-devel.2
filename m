Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AED4E9D801
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 14:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EAAE10E24B;
	Sun,  5 Apr 2026 14:34:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BblqL1CQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VsJPhqTa";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E9B210E165
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 14:34:11 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 634NLnNw2410468
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Apr 2026 14:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=F6QtTYepW7Zf0tKDTJyL20
 HOsHE22oFxxA7+qowz6Qk=; b=BblqL1CQ6uS+3EpQdtMjo8u7krLxTxxHl9bYDV
 gruvNHeLqZBfgLnf3dhIz600HAmdUbrmOM5c2nXalMfB79QKBeDwCkL1j8NLvO2H
 cJCznP/VmymxXrh0/2Zv1dSBsosopPVmN60CVxXObifwIFvkrS1QA4E1nAse+8dM
 vLJmsOvGJlokm20Z+KefyM5NRmfhlNA5a5spmA1UT9/AmfsZvqHqJhCez/aliaLF
 NTA5/+hN2TUaYQ9f/BGcZjXnXu42Ec22w/T6qQ3moXgkIZJAAyzwH7GQkA4vBxr5
 8ZSrQlQ5ERnOruDcZM8YHwOPRW625yHmQY5L3rFAOXOKfHJg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4daskrjrhy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 14:34:10 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89ffce20deaso155506546d6.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 07:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775399650; x=1776004450;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F6QtTYepW7Zf0tKDTJyL20HOsHE22oFxxA7+qowz6Qk=;
 b=VsJPhqTaFN5Hi2NjtUglpT44+ORI9qY0fva3zjrTr5DNa0W4ucm7/NpGteutOLhYNJ
 nDFvxsRmt5jh2PrOA4/xazKJixj0iKoYC2w+pf+mJwcECq3aCqkMBIjI32Uf2LcsCMAO
 76xwYpD8ZHkMDPKD7RuPx2LRrbpMKbQPlaGLdErp7aV6G5qTY0yGP/ccsuqXjwgS2+Sw
 O1I46y8Myws6/jnHQeotdp8LSSJSm3v+G1EBvOEdhW1qM4jjfr1LCQPi86ZwshrFw0uk
 cY7ZwYvlpSpOZYhTsTzVtLDa71shh9sznY/r8da8dwcWgPsOOwnoduSKHHg5UGMGD6Mx
 H3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775399650; x=1776004450;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F6QtTYepW7Zf0tKDTJyL20HOsHE22oFxxA7+qowz6Qk=;
 b=qv/R4oHbRbSMTfDD+ygqUuaSJz768dbMMoI0pWeBt+Eys1w0R4Nz9bGY/14YK6cOc2
 By2mXvfrcgQ1Y6Ayk9mSZo5q4pbR7FTDrVucmjdsDi6TkpKUTm0eqhMsnqjHIIMlQkoG
 lMHFwq/s0uWuLUn4ZuH5583rJS1V/7EJIMv4fipElPEP1r1Q6mWaaoyYpI1hatn/DbZY
 8leTYqxJaC0Czf8fp8gSNaGCP9xzbAMrNIKWogX6GuZgj1jApO1HdagGXvmgrvrZnzwm
 Oz+mjP7E6yjWt73mL5ZF4ai/2yYlCWXFahiV2/RQ59aFvFWUUosawYNFEeHUPAUcnZGO
 mvnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRJOiYtg27elEoXPxc465KEll0JqTbb9UZAyp7IRHggzO4qplwLjMlVs5n/ayI3Gzv0VRUWdbgL+8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwOq+bVubQ/H1dNYZfIRKWSVR0SE28MhRdRqhGiPTzAOA4z/gA/
 3ZRZD/vTNUbdCexQvXC79IJx6JnDRSe40jcqdGgKP0aIkquHLKS82LClAczUh6k+CYS32oUwZh+
 GEgirSR/rJysxXQN8zXJUy/yNcTq2A3s2rBLuYBkHYlIRvVrcd1EITegQrjuhHujDUHh7Btc=
X-Gm-Gg: AeBDievmCaBogw+bb34IIjGX4W8m/090IdsIeSn9GnANEg9RzWk6MoR4b/vVVpMWwvE
 4nw04JVxAGTkhYeRU4CAga/gj+oYbLjKgdmflQjY1n6YKTTV+48ecjWiSc3OiZ4+WNo70HeseM9
 BDMpO1qEa51vvaF9P1ynoVa12YKGj8a3NhNlbNGEP6imFbKYdYXxzkrxn9QOvowQJdgaXWT3A3f
 hgHFRUNVs3tk2vOPoEevKBBvsptfYTqhiCMYfRAKOFtM4bkEXDk4K/eSDScOI+8ugaW+QRVTo1C
 jUVcggWJ1lBFLmvxrSST3u+rGHb2ITGbp5M9O1HZHg9veRFI1EHCT0wY/aPc/jM6rKUPRKqQCaz
 LUZmzpVTgIonIQJbd7Wjcz9vDhq1bJM0zNFuzcDCa3jYh
X-Received: by 2002:a05:622a:7290:b0:50d:5dac:f9d4 with SMTP id
 d75a77b69052e-50d628b91efmr108247321cf.29.1775399649853; 
 Sun, 05 Apr 2026 07:34:09 -0700 (PDT)
X-Received: by 2002:a05:622a:7290:b0:50d:5dac:f9d4 with SMTP id
 d75a77b69052e-50d628b91efmr108247071cf.29.1775399649474; 
 Sun, 05 Apr 2026 07:34:09 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e80a616sm713934755e9.2.2026.04.05.07.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 07:34:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 0/8] qcom: display / dts: Few corrections of address spaces.
Date: Sun, 05 Apr 2026 16:33:56 +0200
Message-Id: <20260405-dts-qcom-display-regs-v2-0-34f4024c65dc@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANRy0mkC/4WNQQ6CMBBFr0Jm7ZC2ViSuvIdhUegINWChA0RCu
 LsFD+DmJy95//8VmIIjhluyQqDZsfPvCOqUQNWYd03obGRQQmVCC4V2ZBwq36F13LdmwUA1o5Q
 2k7nMSF4VxG4f6Ok+x+6j+DFP5YuqcR/bjcbx6MNyHM9y9/59zBIFWmMu2pRa5+Z898zpMJk2q
 l0aA4pt275n10QW0wAAAA==
X-Change-ID: 20260402-dts-qcom-display-regs-11d61816e172
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1870;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=siwXtk6AIkGe6Aeia4fyjnEKYh2k/bm+OfF3gEyRIcQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp0nLXTEi7MjZVZHq+DxOR+aGWZTZWkvCzTTc3k
 SFIZ7pXcvWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCadJy1wAKCRDBN2bmhouD
 1/PvEACT/aPItrcEZaAM+XdnLlqNioGUm+gYcooMD5pW8nlzMsJnzQ0iPIw3RwYlFujKDtYk0uC
 f0ORngcfGqEpYkJRDzFM2ga19HpFwt4JvfP+aDjAmPKuSaaKC5eOfZRA3DNWg3k32LmtvWN/t8Z
 vFUSqwcRXMZwpJ6UHVJXOT55vcCKo4Jfm4s7+xyeQMUqhlXmkUjMwn0n4ozBgmESHpDS+6JYBJZ
 UUpWB3eX46iwSrKNVf1pHoFBXhxVK0Ei1f1jMMLvqtDDgIkxOzbpcYoh1HtNgmlU/hLf8mAfT64
 6KHo2E8oNaBMnj+BoP4Cc6YNkR9/qZaHv9iEMp4H9thegDs0CH1L5pWCeRgL2wFL5G2neStxldR
 BM7sJn+YgKwrvWrXpI7L/NNzHNCz0yBM0G9r8WyecCT2Ae+7+KOx+bDSOn/WtHYzSeMC4jK047W
 UM3DHk7ZV8PosRW08sa0It6q3PqPPO1FHT9uqINVAYffh7UmpBZshHW2P2EHvdDuU5tqArdpHoW
 p8ByaJQGB9xx8CzuB7TrWji5zVIGaOZQLxbYZE7QM+hHXSJodT1Dd97xGtRpmz4PZ3ANS1BB7R+
 I5aRH6Q+1Ojt2TxdgbRsf3iXQT2pk4cpOb/pZrwKa59A8QUStbAJhw8GKAnmmUkVbCTQO1up96z
 KBF3andsjdyelmA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=Xpv3+FF9 c=1 sm=1 tr=0 ts=69d272e2 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=-klF_pe9UpKp8yfWxysA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: iV7X73tOXzv5uhopE9eZtikhWhoRfc3c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDE1MSBTYWx0ZWRfXwyex9Dvy8gJi
 8Gm3YV39fICuyhZAfxygsRckyLoNTiuF7StDFitgZPgihknSJfSaFE/YuDQOM9fJsbFftGU6hJO
 /a9pPWTBZge8ZAEITtxDKrbMFhbgLKvx2lYvfAKaZg/pqP52LqvPSmxJSj8a4O5lWTSfj1fcB3Q
 qM5CwqV4m2PA9vHgOg1qLGt+lYFaY2aV5bLw5F0qp0TnuDdmBoH+XT4mjzFzW9sq9MrK7qdp1Dy
 3Jb8vcESWtKe+ez/pIywUeSvJwQF4z1tjMHA81SFTeFREVCcwk1aQNj7Cfy04wU7AgQLlf4prIW
 drWY5vMmWEH55e72aMcyjjghKAxe5LFrHIMIhIw3kUJ+G4Pj7x2HsI/ibtj9y/50RXETbhBRWcC
 xMNu5Ul77eWx0jROlUU32GWZZ0tC8hSQx+sfmFJdNhXjX9r1mL1FQapPEiF6kIQVZ3UEYPY4xVC
 jZC3udYxfRQhgaFOOkg==
X-Proofpoint-GUID: iV7X73tOXzv5uhopE9eZtikhWhoRfc3c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
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

Changes in v2:
- Patch #2: Add dai-common.yaml reference (Dmitry)
- Correct subject
- Rb tags
- Re-order Eliza bindings patch
- Link to v1: https://patch.msgid.link/20260402-dts-qcom-display-regs-v1-0-daa54ab448a3@oss.qualcomm.com

These do not have practical impact currently, but make hardware
description correct.

Patchset can go via separate trees, but DTS should wait for bindings to
avoid new dtbs_check warnings.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (8):
      dt-bindings: display/msm: dp-controller: Correct SM8650 IO range
      dt-bindings: display/msm: dp-controller: Allow DAI on SM8650 and others
      dt-bindings: display/msm: sm8650: Correct VBIF range in example
      dt-bindings: display/msm: sm8750-mdss: Correct DPU and DP ranges in example
      dt-bindings: display/msm: qcom,eliza-mdss: Correct DPU and DP ranges in example
      arm64: dts: qcom: sm8650: Correct and complete DP address spaces
      arm64: dts: qcom: sm8750: Correct and complete DP address spaces
      arm64: dts: qcom: sm8750: Correct DPU VBIF address space size

 .../bindings/display/msm/dp-controller.yaml          | 20 +++++++++++++++++++-
 .../bindings/display/msm/qcom,eliza-mdss.yaml        | 20 ++++++++++++--------
 .../bindings/display/msm/qcom,sm8650-dpu.yaml        |  2 +-
 .../bindings/display/msm/qcom,sm8650-mdss.yaml       |  2 +-
 .../bindings/display/msm/qcom,sm8750-mdss.yaml       | 16 ++++++++++------
 arch/arm64/boot/dts/qcom/sm8650.dtsi                 | 14 +++++++++-----
 arch/arm64/boot/dts/qcom/sm8750.dtsi                 | 16 ++++++++++------
 7 files changed, 62 insertions(+), 28 deletions(-)
---
base-commit: 36ece9697e89016181e5ae87510e40fb31d86f2b
change-id: 20260402-dts-qcom-display-regs-11d61816e172

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

