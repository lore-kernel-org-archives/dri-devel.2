Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E789560A2638
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J6o+1KH0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kQYafnor
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2245911201C;
	Fri, 13 Nov 2026 08:29:15 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4F1D112096
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:29:03 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD5akuf3147308
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=QS2hi/XTSeELagHP7SsSG1
 Dumxaen+rqGEqvdL4ons8=; b=J6o+1KH0WfgYs1UHibV90VpMXOBx978hOaFe7L
 FDLSI1IqM7dmXWyJx5Yc05cBPwlMKXqvBZ+IHlTU9lAg/TrD7rh4vLblxy0np9z6
 htxTEmwkF1sdLherLCO+N4gYkh/F4bDOTOK2WMD3Ls3sfN8nB53t6udstfiFzHrD
 NC0XJ6l663ilyCmOVcVj5VGcvcLAew6N5SNi4xoyaLCC8wd0GqojFxQyf/fAH7yO
 VtRbn7IMcAEUHhUZmBllpGcSj5qvo7Wt3udwu+YbTc6bkDqkdwtKTehNg9yVAmha
 NeDjElT1OJEmhFE59K8p7vCHHdRueW0Gvx9a9U9nPM1tWpjw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwvja8j6k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:29:03 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934963b2bc0so151099985a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 00:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794558542; x=1795163342;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QS2hi/XTSeELagHP7SsSG1Dumxaen+rqGEqvdL4ons8=;
 b=kQYafnor+0rxpWPriBcA2+wZ/rV5Gqx+xl7PQejZ1g1WYf5FRiWOpaIBhO/OHpYkxs
 wuR4jvcxk4YM9m1mcVSQZd1CmfzqTjd72cY7Q6wFUm7Kwy05viDVdWFW45bWBJq3U0Ih
 wd6QAtXxp4gTKFbSMWOx8pm+ogsaoNtdVjK0kxzEVlUl5gyGl9fIrEPUkKcttqmq3Zyo
 C/L7BkvmHUDUqMOie3DPiIDgirwnjZQoCXNu1eW7ElyWA7/g6eaeM1zCHyLgsBnkVnut
 hpeMhQiLZ50KZqRiFQIqsfKEftXBjwm4mhpGbWRvmbZDD7RsQqBzLeFW36q55ny48z+H
 GXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794558542; x=1795163342;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QS2hi/XTSeELagHP7SsSG1Dumxaen+rqGEqvdL4ons8=;
 b=rYHSdyw6GCVC3KCG4eMTG7g1UqX45M0YWGpZg3Rdn9n0O/Tsnq0iwI4tiQoGxOzbGL
 hpbfJUOM8nppUTmqD6Ndf6XBQg3H/fPa88b4y0pj9HonbZfMU34iQkNJWZN20utx5CSg
 BBmv4+8sdVWRmkGNp6J4DpAfPAs8uzc8c0cu8ioBvZVUl05PvLjCVp9eE25z456TW9hB
 oEPYh7F0R6jW0i2PndJOL0UK95ENBwek0CNm/Wvc6iA9P19r5LYa/BlCff1K8cmbSbDI
 wq2RyFnsOMk54CfBngJBkFCbyu+v/4Vz9b7hp3Hp6LP8vveYVO+l5sIeyt2j/36qp8pO
 IvKQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEF3o/dMlwboXQ+MXm+ErgFOCFtr6sbvCb/oKB1jovq0qOAjfMKj2UkV9OSB8Ve2UcYDYEzNro06CE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+VARwJwA4vWg/RiDZ2AdhWizZ2PM3r+P26FyZazNWAwyBganOU
 qgSMF+CX2TV3bgNm6Nh57nvR8nxHcxcjbK3gi7Xn1GJrpXPbBve6zxD647ugOvxOI4iofiy8OT/
 CU3hDcTRJujm8JtI/d3dRc6fkIMHjLV3mY3hoR53WXpLHqL42e2qAFjkv/fo/bTE/gQ/SQaQ=
X-Gm-Gg: AYBFou1QLI2bOYc36dSiA0u5itPomDnRk80rup8k6vke7RU7MWcc+v1Q+/Gp0bGilb3
 5uwDzn45+V0+VSFLvyD0Wh6OOcYFT1uTt2wwvugcPBfx+By6BxK23pXWej2Ky0JuQK5jED3+Tpj
 o8Dy/hCTfRwfDn6bpe13oZV/2UbSwksAL4+1YvwsO/kw214iyutuWxmVEl1RIR8RBqt98W+S/wv
 pBNrsktuDMP87OiGeY/oxsXAB/9oABk8Por1zHRbPQDRZEY3v1Z/dpP/gPDzcU2BWEOVUXR5IZe
 4E0eU7KGREse+T03bisIRmMAKoOhp4SiBPO19n3f7aZg5bm7o6kJJOVUCqRa7xDLmXSZLSPq79e
 74WXbPIkr+0eH+JKqyJ53QV5O8yPSJ34SRoHzvOC+Pls9cKLCNZYwXKnPel3W+8GRTpKSqy89Vc
 2pGJb1VorHkY/jICUlhtryI/vJxbNhY/iH319E
X-Received: by 2002:a05:620a:17a2:b0:93f:2493:bef3 with SMTP id
 af79cd13be357-9494ba4af39mr281717185a.10.1794558542197; 
 Fri, 13 Nov 2026 00:29:02 -0800 (PST)
X-Received: by 2002:a05:620a:17a2:b0:93f:2493:bef3 with SMTP id
 af79cd13be357-9494ba4af39mr281714585a.10.1794558541667; 
 Fri, 13 Nov 2026 00:29:01 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55ad1b13917sm13524491cf.29.2026.11.13.00.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 00:29:01 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v6 0/3] drm/msm/dpu: Add INT2 GDSC power domain support for
 Kaanapali
Date: Fri, 13 Nov 2026 16:28:50 +0800
Message-Id: <20261113-msm_gdsc2-v6-0-17adbce47220@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAELK9moC/3XPS2rDMBAG4KsErasgjd5d9R6lFD1GiaCOG8sxL
 cF3r+xA40WyGfhH4puZK6k4FKzkdXclA06llv7Ugn7ZkXj0pwPSklomwEAzA4x2tfs8pBqBxuB
 AMAbGQyLt//eAufys1vvHLQ94vjRyvDVJ8BVp7LuujG1EUhaSsdknlyxYVEZFz2KKOVv00nhjA
 Fggi3UsdeyH33XNia/Yg40mThmV2hqrddIxsLe+1v354r+WoftWVmyCO+C42gLQgNYyIEywwsI
 TQPwDnHG5BUQDMsekXXuQXD8B5AYAsQXkcgIL2hueJIr8BFB3gDO3BdQCeMGVCwplsA+AeZ7/A
 Kjtbkz5AQAA
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
 Konrad Dybcio <konradybcio@kernel.org>,
 Del Regno <angelogioacchino.delregno@somainline.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Danila Tikhonov <danila@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794558532; l=3516;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=JkP9GYdpP92zM+mAnzx7C2m68bPFerI79Z8OioofOIc=;
 b=Hz8s5npmEjIHMKaUJWlwsdM/wWurUAwpKPjleEmjxJlKdOYEmlCTEOIuH6ZbaDE5LP7cvdZD1
 G1XKJdDY6frDn9orAMuL/Nkemz6XsaXSFwjbnMC7ysgNqkVBMgWy/kM
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: mHDBjPMrCv8wy4bQrRxp77MmXZUG8I5P
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzMyBTYWx0ZWRfX8ZqGTbNNNUCL
 zh1wvGbYN4OZYZqDi3fpmQKm7T0C2ji6RQZMCSyrIWxkLLcfbVGwrQR7utczW9VTA/kyKMUio+C
 uKCS0s/VP0JyQDWq5rmFzdA5RuaO7Cs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzMyBTYWx0ZWRfX3NonJWTkqFdI
 lbNQt2Nl5vAYPa38QaXKi1ohPSK2Dhdj4h5wZKxhJCmdO/3qwW2gImKsNtypgAecbh8LD7Wt66R
 /PbypJr3cyf0dn8JZD9b75B8Uo1KqlLnHVJgnbDL90UnMnLPWJ7K8iiqku/rhBABlghjrcAr96H
 C2X1/+6qCiQsUkpd3RT4sVwvKmtP+E1EE1bYrGCdqizZhEF2PouHjKcvUwzsXeoct8yW/mXL4D7
 6GOnGpudCGMdgCFWzXqV4ciYbtF/1NLwE/wHiQzwIrwZUQ8khvWCMo9teYjtjxyj4TDQk3+orTz
 GN2KMbE74C1yZl5XwkTlUg56YpcrsqfqrtD0xZ2qQ4AjZfaU7Oz0rZPHfZuKNvZ6bWEPcsCa1/H
 NCi8zv38jf3HKE2TxkYoyjdctJ3KKAUJw2tLoytkH28slmNr2ARCDeCQLlEYqVvY0LyGGtx8vpS
 fgdByxM7PWpK+c48DkA==
X-Proofpoint-ORIG-GUID: mHDBjPMrCv8wy4bQrRxp77MmXZUG8I5P
X-Authority-Analysis: v=2.4 cv=AoN7T+9P c=1 sm=1 tr=0 ts=6af6ca4f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=d2OlSeRB4JJFOaS-wp4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130033
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
Changes in v6:
- Drop Tested-by tags (Krzysztof)
- Move power-domain-names to dpu-common.yaml and drop the redundant
  'required: compatible' (Krzysztof)
- Link to v5: https://lore.kernel.org/r/20261109-msm_gdsc2-v5-0-4a3159b5e4b8@oss.qualcomm.com

Changes in v5:
- Use 'contains:' for compatible matching in the if-condition (Krzysztof)
- Move power-domain-names items to top-level properties; only constrain
  minItems in then-block (Krzysztof)
- Link to v4: https://lore.kernel.org/r/20261023-msm_gdsc2-v4-0-40b6a71d4e3f@oss.qualcomm.com

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

 .../bindings/display/msm/dpu-common.yaml           |  9 +++++-
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
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      | 23 ++++++++++++++++
 arch/arm64/boot/dts/qcom/kaanapali.dtsi            |  4 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            | 32 ++++++++++++++++++++++
 15 files changed, 99 insertions(+), 3 deletions(-)
---
base-commit: 6d582d78fad9d828e575ca0cdcff8ea47a77220b
change-id: 20260720-msm_gdsc2-cb9230027a2d

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>

