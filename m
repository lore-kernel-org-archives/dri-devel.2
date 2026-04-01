Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171D510F9318
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 03:39:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78AD510EBFD;
	Wed,  1 Apr 2026 03:38:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KIajPlXa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fNKt41ye";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C7AD10EBF4
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 03:38:58 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6312J3Hb1006368
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 03:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=2kLHLuUfXgHXpsnoBEtKL3
 EbLPGLR7YyXYBSSpUL4Y8=; b=KIajPlXaOqbrPumBeZFSb1bDHNe3AUdj7ar/hK
 2HuAw/O3irC7TMfxmt5HIm/KvsRIju7HS+4BM/LHD9wQ5kVVjoPePn3puuDzIyzm
 eeE5xegfWf9I1Pz3NQH4ldu8Zs4WHgLqEdu5SIL30EfeEez0AHZw2RBfE2dJSj0w
 Z75daWoL33yRBW5tvOs9ATtxLNOIzX6Ob6lwX/pZ2KzzEpyq39hDrC9PfBg0DfmD
 P9Umtn+cBfMCLnmzIh8VmibWUEGjmnZkdx2puW+OI83lYw342D9lZ42ECoIJYsCd
 /KA5PZiD52Lieba80Ligh75cmDUxCrcna9VMK6fi/Aj9JLqA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8tfjg8ja-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 03:38:57 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b2cbe7223so209541501cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 20:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775014736; x=1775619536;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2kLHLuUfXgHXpsnoBEtKL3EbLPGLR7YyXYBSSpUL4Y8=;
 b=fNKt41ye1et8BlGBM1qxV2eU3kqKohHKWQbBSIF5fVDZL+N6AhJISxcpB2hv94lcqX
 f9D1jul37RfXIQ9s1eR6fgycbwgCeaLGPc6pMdDGW3bx5uT433AT9s7+xUpKk00HxSdF
 WKPaP1RaHnfTYbBAuxVkn6wJw2JiM0Bdyea0KJxCOdI5pkYnSjKXdgsKzynKriIj7CEe
 MsrPxV66Dz6ldevUVpLksqR/lhfsro88eXD8FeLBRTqf8iiHciZAutFD3fKqWcH1IJvq
 r7OIvi88sUe7veU/L/8jhJXE+xPOhqDfMgaFF6TgULVV5dQgLRl1OBTA6qu3Nje5nRdb
 +HIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775014736; x=1775619536;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2kLHLuUfXgHXpsnoBEtKL3EbLPGLR7YyXYBSSpUL4Y8=;
 b=JUZh2jpr5XXSua41At7ykIq88+t+Fm3wFYCs3kqKLQmkII6FzGi0cgcn+9F7N0sxGa
 GXkPbs8WD8Igd+6FnxgEK2rw38vgL5XmwzS9Bn/zKkF3whxfmEDyLwBX7/fbhMwlnKhJ
 e2ULrXETBjdzecq8C9qZZ4ozmvai0ak0FjlAOFu5Qna6p6d7c6z9nkeszzn471lCtruU
 0OkAy5NGkXAwamUQ1gB2g04sHgdwlTGJh8gX7axBQ+hkRe1QWNkcK2VMTh58aZsQMmBI
 qjCY40OnEoiYIsJd48K//8/P8FgL/S6OwdmrUT3wCGeA/P8KC2A3AeO+A1VJ6k0mj6Z1
 /4dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5b6rmJuPKGMWVIkuI03VtecIDAq2yuF/7yCijt5FHkhDLZ1GwqnCbD4JekH5a7mMcvmBwvbblyl8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNeVDnMOFni1Dqign3AqrBjcqzx2knl+nrD2lv8yzJ6i2aijmV
 g3Un3KH3BV0dU904ecd//YBkeaSuZ/6Kqu26vXqPV//JhMja4OFG8Uvh2ug24NNU8FXiu8JtpjO
 MOEakLR9uL+gMev9PWSyZkdoBNLeiY1k5WzRHM6cQmsr2+irnLnxApw9jlw+TNwvxJRVyD1M=
X-Gm-Gg: ATEYQzw8K/WR5VUmCBAitaaVY72TwC4jmHXigYZj6pOfv9a+CRJJt4FwwfM4YzSE4fQ
 YtnqIlLBxDOqPayZdQc9anM4lcy5br2STs/2sxZiz3H7u7FVhQbDSX6YbgtaR6KHyXFQAQndVXj
 Ue6WDjxDcy14abIyAczybtum7LrUKA3MVYzkHEq1O54D6bpTXzSbTnEc0Lj3LNWNBhWlgiyL8TS
 iqAuDZWkqWRvMpHZVwfEUAAcowXby1lxKFFVaaSUqjGAZhhncMoy7derA403wTErgryShY2IX16
 YK3N3AXN/d5V2gL1mVxSJcg1IOFQM28yNdlGvYdizVCWQccRnY06Xgf9YAgB3dF9TEL36aO/gaR
 Qkuukq9sEVAd0ZamaZKI4/FjwwgRiUYWw8GuiHt19LJ604giLMH39nJnmoY1ilcmUqLbkm+aQWS
 gUdxZLdekp361Q+rnBHU+jEgfnjf07skVJKRY=
X-Received: by 2002:a05:622a:124f:b0:50b:352d:6b5c with SMTP id
 d75a77b69052e-50d3bdbc16emr28859451cf.64.1775014736437; 
 Tue, 31 Mar 2026 20:38:56 -0700 (PDT)
X-Received: by 2002:a05:622a:124f:b0:50b:352d:6b5c with SMTP id
 d75a77b69052e-50d3bdbc16emr28859141cf.64.1775014735943; 
 Tue, 31 Mar 2026 20:38:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c83730f7csm24404851fa.16.2026.03.31.20.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 20:38:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v8 0/4] drm/msm/hdmi & phy: use generic PHY framework
Date: Wed, 01 Apr 2026 06:38:45 +0300
Message-Id: <20260401-fd-hdmi-phy-v8-0-51b0e98edf6c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEWTzGkC/3XQy2rDMBAF0F8JWldGb8lZ5T9KF3o5Eo2tVHJFT
 fC/Vw4E4tJsBu7AHC5zA8Xn6As4Hm4g+xpLTFML6u0AbNDT2cPoWgYEEYYw6uHgYHBjhNewQMa
 MorgfjLUStItr9kP8uWvvHy0POY1wDtnrh0FRTxTGWFDUYYIlwz3EsHlzXjqj81LCZ6qnS5x0T
 l3K540NscwpL/eOlW34RnHECdrVqQy2hTVaC060k/yUSum+vvXFpnHs2gBbq8ofhEAUsz3BG8E
 VJkT7XjhqXhDimdg/pYpGWD9YpDTnTKIXhHwiyJ8WshGGYee8cooa9Q+xrusvdkUgj70BAAA=
X-Change-ID: 20240109-fd-hdmi-phy-44b8319fbcc7
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-phy@lists.infradead.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5065;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=S7FOJT4ts1TJI/oFCfRdpPixtPPnf4IHzaUtEo2nS7M=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpzJNLqjDU53LfSbxFzBYYoWsug4MURgItWCpMd
 B4klOZbf0SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacyTSwAKCRCLPIo+Aiko
 1R5dCACzqqBGYmeUXNgyEYFHuAylviYldq0HtOXm/NeMZB4urlL5dJwY+4G/3FUC/j6yvI+M8Rv
 NdOoVotFKBamjaW41b9W536ZhWh7EP9VYPTo5hIbPL7UTWpSOhZIXZl7DMV+Fo5/r1WxieAfqxM
 lYi1N8U28SHxBPDLkkq+m4f+0PsiWHYRGHgC/BWaxlq3REgQ7GqKGlwwDgen0fq+9nnFVUIP/tQ
 gWo/gQrvpeLFBGd6U90tStkBTZQ8Xux+utWrKL3VWExMCZ5ANJ8jVJSI90KatraN1TYLr1Y+4Dm
 5QNUq3qUrc1BbvPs2XFUwSfwuEeU6Qlax3OkvMlMK9lMWYm8
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: X_N1DUfUwpuOs7hkZIvg1YygqU5G4apA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDAyNiBTYWx0ZWRfX/x601NaN+ju8
 Jkl2U04Kf/e2a8PYI6DXmco+c0t/66FjjiTG9fUEqZdnKhDBW1B1qQS7EDu5xvya7OPOeDvgRUu
 wWlgOijPinw0F2KXAL4LHBAvl+FXbovNLXmTZAr8j5NefouB8QcD0GJ1nu+qVotZXrhktqesJcG
 PAcV8MqfralanpF95QpH50D4sdULz8w+rNH0fDB5dohsw8hFQeR81tDhpyiKB7krsypB6+4legO
 vxmOFdocwhNqF+3dnR2RIe7RfA6UpkaVw1WlIrYlYcUz0J7mIiX/5BbNPi/UZ0d7MsrqxBbCGCt
 oQEKxhfKUcdXteclNjMGJz44+oyparYi46JGUNzV7CXC8rL5qwQYklRR2hMHh6wBq9hFzx2UEAy
 XCEB7v1H8EWd2RV52Pf1iUms3LZ0HafW/uJ+wznfnkF1bIYur9UQtcjp+4GXp1bxa0ztr8hXSCZ
 rPN9msydxF9zRTaH5yg==
X-Authority-Analysis: v=2.4 cv=fJc0HJae c=1 sm=1 tr=0 ts=69cc9351 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=aG6DWvB8Nz23F0sxf60A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: X_N1DUfUwpuOs7hkZIvg1YygqU5G4apA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_01,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010026
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

The MSM HDMI PHYs have been using the ad-hoc approach / API instead of
using the generic API framework. Move MSM HDMI PHY drivers to
drivers/phy/qualcomm and rework them to use generic PHY framework. This
way all the QMP-related code is kept at the same place.
Also MSM8974 HDMI PHY, 28nm DSI PHY and apq8964 SATA PHY now can use
common helpers for the UNI PLL.

This also causes some design changes. Currently on MSM8996 the HDMI PLL
implements clock's set_rate(), while other HDMI PHY drivers used the
ad-hoc PHY API for setting the PLL rate (this includes in-tree MSM8960
driver and posted, but not merged, MSM8974 driver). This might result in
the PLL being set to one rate, while the rest of the PHY being tuned to
work at another rate. Adopt the latter idea and always use
phy_configure() to tune the PHY and set the PLL rate.

Merge strategy: Merge the first patch (either through drm/msm or through
the PHY tree), merge the rest of the patches in the next cycle.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v8:
- Rebased on linux-next, fixing conflicts
- Added missing ids for APQ8084 and MSM8998 (Sashiko)
- Switched to pm_runtime_put() (Sashiko)
- Fixed several missed *1000 after pixclk -> tmds_char_rate conversion
  (Sashiko)
- Fixed several math overflows (Sashiko)
- Link to v7: https://patch.msgid.link/20260324-fd-hdmi-phy-v7-0-b41dde8d83b8@oss.qualcomm.com

Changes in v7:
- Fixed the build issue between msm8974 patches.
- Dropped even more writel / readl wrappers (now from QMP PHYs)
- Link to v6: https://lore.kernel.org/r/20260319-fd-hdmi-phy-v6-0-cefc08a55470@oss.qualcomm.com

Changes in v6:
- Changed MSM8974 HDMI PHY driver to use FIELD_PREP / FIELD_GET (Konrad)
- Fixed rate recalculation for MSM8974 HDMI PHY (Konrad)
- Dropped register read/write wrappers
- Link to v5: https://lore.kernel.org/r/20260314-fd-hdmi-phy-v5-0-58122ae96d3b@oss.qualcomm.com

Changes in v5:
- Kept only a single place which handles extp clk (after PHY power on,
  before PHY power off) (Neil)
- Inlined pm_runtime calls in the HDMI TX driver, replaced
  pm_runtime_resume_and_get() with pm_runtime_get_sync(), since
  atomic_pre_enable() can not fail.
- Renamed registers defines to drop the REG_ prefix.
- Link to v4: https://lore.kernel.org/r/20250520-fd-hdmi-phy-v4-0-fcbaa652ad75@oss.qualcomm.com

Changes in v3-v4:
- Rebased on top of linux-next, solving conflicts
- Squashed add-and-remove patches into a single git mv patch
- Dropped HDMI PHY header patch (merged upstream)

Changes in v2:
- Changed msm8960 / apq8064 to calculate register data instead of using
  fixed tables. This extends the list of supported modes.
  (Implementation is based on mdss-hdmi-pll-28lpm.c from msm-4.14).

- Fixed the reprogramming of PLL rate on apq8064.

- Merged all non-QMP HDMI PHY drivers into a common PHY_QCOM_HDMI
  driver (suggested by Rob Clark)

---
Dmitry Baryshkov (4):
      drm/msm/hdmi: switch to generic PHY subsystem
      phy: qcom: apq8064-sata: extract UNI PLL register defines
      phy: qcom-uniphy: add more registers from display PHYs
      phy: qualcomm: add MSM8974 HDMI PHY support

 drivers/gpu/drm/msm/Makefile                     |   7 -
 drivers/gpu/drm/msm/hdmi/hdmi.c                  |  59 +-
 drivers/gpu/drm/msm/hdmi/hdmi.h                  |  80 +--
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c           |  80 ++-
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c              | 226 -------
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8960.c         |  51 --
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c         | 761 ----------------------
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c         | 765 -----------------------
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8x60.c         | 141 -----
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8x74.c         |  44 --
 drivers/gpu/drm/msm/hdmi/hdmi_pll_8960.c         | 460 --------------
 drivers/gpu/drm/msm/registers/display/hdmi.xml   | 537 ----------------
 drivers/phy/qualcomm/Kconfig                     |  24 +
 drivers/phy/qualcomm/Makefile                    |  14 +
 drivers/phy/qualcomm/phy-qcom-apq8064-sata.c     |  23 +-
 drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c       | 353 +++++++++++
 drivers/phy/qualcomm/phy-qcom-hdmi-28lpm.c       | 478 ++++++++++++++
 drivers/phy/qualcomm/phy-qcom-hdmi-45nm.c        | 186 ++++++
 drivers/phy/qualcomm/phy-qcom-hdmi-preqmp.c      | 213 +++++++
 drivers/phy/qualcomm/phy-qcom-hdmi-preqmp.h      |  59 ++
 drivers/phy/qualcomm/phy-qcom-qmp-hdmi-base.c    | 187 ++++++
 drivers/phy/qualcomm/phy-qcom-qmp-hdmi-msm8996.c | 440 +++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-hdmi-msm8998.c | 489 +++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-hdmi.h         |  49 ++
 drivers/phy/qualcomm/phy-qcom-uniphy.h           |  74 +++
 25 files changed, 2611 insertions(+), 3189 deletions(-)
---
base-commit: d894dddf2a144f0e1d1cd7a8225c744dc906cdd5
change-id: 20240109-fd-hdmi-phy-44b8319fbcc7

Best regards,
--  
With best wishes
Dmitry

