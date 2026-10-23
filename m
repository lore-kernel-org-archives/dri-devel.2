Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97D8606A320
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K2nWi4wb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LSdAvWYl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13182112A0C;
	Fri, 23 Oct 2026 08:13:43 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BD32112A04
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:13:31 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7FLCs1552351
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=XzpZDTY98X35K0p7w7mx3U
 sWiWF/bbvb8wtCEElzp6A=; b=K2nWi4wbmZRzuQqhcotLCc2T3ytyfGTPtAqhrA
 Cu3D82gtUqlIFSJHNgZD3efyjgNIJ4mEv0PQQhybf8OzJFAQzIJZ5B2QKbt7P1r8
 p/lNKuXR/b1nWU2xM27CDjcP70GCqXxDYDmJG4HpHbABn1JZ0lWCt3BftRrJ754u
 QuzGFeOkx1Qq0HhFE62Y/zEsy47T0P1c1L0zMN/WubBTQF4Sm77DfAx5tNsiWFW3
 yy7M2vKGKiv69lamTaVbCwG5iwAFn428oEugTVvb+Vz9Cm5CBRRDKQ9GeBKc87Nk
 TX5vbUbEiZogrHHnuoWEQaLvUaeQMMP1UKCDfEF7XjnrHfUA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmttnc0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:13:30 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-917a2de2cc1so8710446d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 01:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792743210; x=1793348010;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XzpZDTY98X35K0p7w7mx3UsWiWF/bbvb8wtCEElzp6A=;
 b=LSdAvWYlkhyXUMWHC653Q19XeZj+mRDF8xjE5bIMvggVom/HZxR6dqxan8BBEov+Rs
 nKmby/dDXm4FGqmPdC9AaGy7BXt9s/FfofSVlg9ZeI4rvcnY9VvPqiMuT4ox/Vmd+wCv
 8q28n1+TZxKM9W1kUJ8A3VIoYw+kcOv+Iw+5pX3YNYHeRqpf3oSyp6NXFivF+bRZRL3Y
 V+8SwWr0C/2z84J0VBUbf8VoubXnXsiRGsAirVaUodZblSd+JqLduqAW1a6bSMqGBq1n
 ZdFhzHKBWg6aSlu1dDz6sQj2Nb8z/SsfgR7WDp+vXbdXnCS03U27Mt/P5/pQ4zoaQShg
 hDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792743210; x=1793348010;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XzpZDTY98X35K0p7w7mx3UsWiWF/bbvb8wtCEElzp6A=;
 b=M+ZSU2Hfn9DZ4QG8v1alImsRYHd1w/Hjg7Sya/6JDxC4d6tGhuSLL/1s3PZF96LnlF
 WxkP7ex/oJKGtRdfXwg5qjUPOATrh7rKzqGvxLK7IVvwaSTiMYAboiXZPxF/akkywTGQ
 0bIKirss64EogJgK5Qv668u5b7wYSarNYumgwB/k6h4V+suDjhBdmjCgGWdxSwhr/4/w
 YJa9sL7gebwhZp72icuiOw/WoidDvUP+7XoOW68Bv/SEmsGON4helYJeF+89DvzG62XU
 MfK9leQvt3XafhtYCa1O/4q+p3kXBRfp/wK+JAkE8IPXyuyDCEnpxYjdg5r17QaJeG28
 wO2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWXtW6vIKcXQAVbKcageRu9Bz/3N61LtJdOdkZFVzHXjH914J061taLrANYSEfew72rZSxSFTwiSA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLKe/re7ZyQykGaicw8/2qqjh7Uhaf2tPjbxjbmSD3dBkQzVZ2z
 Fcbab6tO7h9A0TM78rKQP9yB7rcahQV2v8Bp+1+63FuQA1H7NOT/m0cOsWVpX52pEpLzbllXw3N
 08v6Ixht0KWiuLyDZWo40J6CtShF5YwKyGjzGXx15BPP7dRWMcr+hE0qwDk/yMfhC63IY2N8=
X-Gm-Gg: AYBFou3tyOZo/SRyzctj60FLRfxHJ5YyzV3X94+8A4I22lGIkla0ly5/zp0hhR+5iM+
 19C5dOLdO+AEJZ4GeDHuU6RBFJ3v9Tw9ZLRq6Pg/3XUv4ftbto9j7/pqo1ezjHf8ae6ByuFWiVn
 ++0StSvuBWo/lgEpLdFKctCUQMwkwjzlQVk5LoDNs425NkVDView1jjPz1D4jMdOKVywdTp7hVx
 dBj5WM4DXEuPG2KUX/9L5CvyR1cJ3bypnMMpb32WH/7mIyakykgjuCnh698KZFQCyHSJTiikw/K
 FiO4GzK3MqI5e1AG/mCFYsSLFLUcHafNG7eO/xcnEFuMkgehrU1Pog+0cQI0bOKMG44GXTkF0+Q
 wkvyvSrMOVw3DHUALQ9Z8z/BQhAEDj/of4cNajJ7Dvalf5W6+aXm6l3ITW4bNTQ==
X-Received: by 2002:a05:6214:509c:b0:91b:8d12:bac9 with SMTP id
 6a1803df08f44-91c3a4bd85fmr20158946d6.0.1792743209351; 
 Fri, 23 Oct 2026 01:13:29 -0700 (PDT)
X-Received: by 2002:a05:6214:509c:b0:91b:8d12:bac9 with SMTP id
 6a1803df08f44-91c3a4bd85fmr20158466d6.0.1792743208830; 
 Fri, 23 Oct 2026 01:13:28 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c396af493sm14345626d6.9.2026.10.23.01.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 01:13:28 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v4 0/3] drm/msm/dpu: Add INT2 GDSC power domain support for
 Kaanapali
Date: Fri, 23 Oct 2026 16:13:10 +0800
Message-Id: <20261023-msm_gdsc2-v4-0-40b6a71d4e3f@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABYX22oC/3XOzWrDMAwH8FcJPs/Flj1/9LT3GKNYttIalma10
 9BR8u5zU9h66C6CvyR+0pVVKpkq23ZXVmjONY/HFvRLx+IhHPfEc2qZgQAjLAg+1GG3TzUCj+h
 BCQE2QGJt/6tQny+r9f5xz4VO50ZO9ybDUInHcRjytO0wSYqIRoae+miCQ2dNjBiVJA/gUGvyF
 JDdrEOu01i+1zdnuWJPPpolF1wbZ50xyUQUb2Otm9M5fN6OblpZsRn+AC9fHwFoQGtZUBadcvA
 PoH4BKaR+BFQDeknJ+DbQ0jwBlmX5AQ9mWcN3AQAA
X-Change-ID: 20260720-msm_gdsc2-cb9230027a2d
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
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792743200; l=2960;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=koeKof9lWoQPr70R0/9p9MqB8DhS+MvQ9mfyxhhF+0A=;
 b=XLJfrEMwU+3J+WogPu+bHoi36ooB/UzDIKQa2JXlYZTZgXEVBANULaLAq0jC7jeBoVJtYtxFf
 ZSufFq7g7GrCcfZfuzKEVvFi19S384tSpwdx4MGqrEucd1bawPSbiLo
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adb172a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cXFZYRxNi65dCB_EMakA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: c0_5xR02uXNITvpXS4rbLAmHopHKBdhv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfXzWphbfcUlMwR
 nZVMJxDTIZYQS2B/GfXgbI5LfGt4O3XA2GqJq2HCGDReMi9DFUP45tJJqhtGoaArzT370rrwGeu
 /KWI3ROjBtq8AYsbCXgmg5KTvPekPtBnpmBYATUXObigmgIA2qMuAsa2oM47ou/j/vBz8EReJjN
 tnpzciKomYBtbpi+CW537NZlmCzn3GMKh8QPcH4PNoDDLgac1q/YmZ920WmY/NiSGlTvrzjHehK
 1FshoEEGy1iSiDxVNBO7Jr+yFAWJQSAxcV47VwaP2znwsgyOyhm/64cxKzr1kUExLUgjFU7qTFc
 csIvrZm8qyVwKVQUnAIUfUPr8F/zTUFbNCThgOzRVkFCW/NRBqfR16ElBZhQcjsfejMYwUZk3R0
 C+C5ccfqfFDfhdqFAxAEQ0GL56+0+HL/+If5oHdaYquP7gF8IUY8YnzE9oDiqBWn+ajtkEavM1K
 GL1DWZMpDXWKhCPHj0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfXz7QJeKGx/M6b
 G7vKHKxsHCeI250unYYZHAaFfNDmEMNOAQhixN6EIvZ0stWQzDXI6SFvgL4mNz3aB8qwbwry1wR
 MYVxKOyW/ptDrlJtfL3+BIfosaDiZyk=
X-Proofpoint-ORIG-GUID: c0_5xR02uXNITvpXS4rbLAmHopHKBdhv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230032
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Kaanapali (SM8850) has an additional INT2 GDSC that powers a
subset of DPU source pipes (VIG2/VIG3/DMA5). Without enabling
it, those pipes remain inaccessible.

This series describes CORE and INT2 as the DPU power domains,
updates the DT bindings accordingly, and explicitly attaches both
domains in the DPU driver. DPU performance-state votes on CORE
are propagated through the genpd hierarchy to MMCX.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
Changes in v4:
- Keep the widest power-domain constraint in the common schema (Krzysztof)
- Link to v3: https://lore.kernel.org/r/20261014-msm_gdsc2-v3-0-f1ed69014416@oss.qualcomm.com

Changes in v3:
- Replaced MMCX with CORE as the DPU power domain, keeping INT2 as the second domain
  (Dmitry)
- Used generic "core" and "int2" power-domain names (Dmitry)
- Propagated DPU OPP votes from CORE to its parent MMCX domain
- Updated the Kaanapali MDSS example and fixed issues reported by dt_binding_check
- Link to v2: https://lore.kernel.org/r/20260915-msm_gdsc2-v2-0-9157237b8382@oss.qualcomm.com

Changes in v2:
- Moved INT2 GDSC from MDSS to DPU, as it only powers DPU-local source pipes (Dmitry)
- Dropped Glymur — only Kaanapali actually needs INT2 GDSC
- Used if/then in DT binding to restrict second power domain to Kaanapali compatible only (Dmitry, Krzysztof)
- Dropped PD_FLAG_NO_DEV_LINK, let device link auto-attach handle INT2 as runtime-PM supplier (Dmitry)
- Link to v1: https://lore.kernel.org/r/20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com

---
Yongxing Mou (3):
      dt-bindings: display: msm: Add INT2 GDSC to Kaanapali DPU
      drm/msm/dpu: Attach CORE and INT2 power domains on Kaanapali
      arm64: dts: qcom: Add INT2 GDSC to Kaanapali DPU

 .../bindings/display/msm/dpu-common.yaml           |  3 +-
 .../bindings/display/msm/qcom,kaanapali-mdss.yaml  |  4 ++-
 .../bindings/display/msm/qcom,msm8998-dpu.yaml     |  3 ++
 .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  3 ++
 .../bindings/display/msm/qcom,sc7180-dpu.yaml      |  3 ++
 .../bindings/display/msm/qcom,sc7280-dpu.yaml      |  3 ++
 .../bindings/display/msm/qcom,sc8180x-dpu.yaml     |  3 ++
 .../bindings/display/msm/qcom,sdm845-dpu.yaml      |  3 ++
 .../bindings/display/msm/qcom,sm6115-dpu.yaml      |  3 ++
 .../bindings/display/msm/qcom,sm6150-dpu.yaml      |  3 ++
 .../bindings/display/msm/qcom,sm7150-dpu.yaml      |  3 ++
 .../bindings/display/msm/qcom,sm8150-dpu.yaml      |  3 ++
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      | 26 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/kaanapali.dtsi            |  4 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            | 32 ++++++++++++++++++++++
 15 files changed, 96 insertions(+), 3 deletions(-)
---
base-commit: bd1ecbb61afefc6a8b876ccbc31e9228b44e9eab
change-id: 20260720-msm_gdsc2-cb9230027a2d

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>

