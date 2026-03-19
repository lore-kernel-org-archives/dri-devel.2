Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD3B1088E70
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 03:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D806B10E872;
	Thu, 19 Mar 2026 03:48:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QKdWofyw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QHX/Lvck";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B840D10E872
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 03:48:23 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J0mNka914295
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 03:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=JX6V7P6bsRPeotKtiH7RJ9
 N7+4pq9ewOSYm/l2L69q8=; b=QKdWofywVfC8mLqUB1djykNVRCqNJ4ytFYOYsG
 /KtKWI5O+WHdjewmYRcN8l2ftdjgz2OcQgkoZFO4ZV6dzlsTLA6BiQ0+/Ie1ZIyA
 1QC3UnyJdguaRDBn42y8Og9AzfxsxIVaE1oNbtydb0XDq7Yjxyi3zCKi3wUWESfg
 kN9vkZjY2zCNRoFk7F9jLdq+HnNW385cWuZTXaOiGd0JZCWs9Luy3M5ZcYOwMHot
 8nD7/BJuwXG3GhO4Ds72zomPIh4nmIyUJzqxlXPSorNSTWPfYLh4Cwo2x1P956Am
 Rx2pi0zE2MABMqJbgKTRvNOk7r98BNNeWRdU28eVB3rk6Y4w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cytxytye3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 03:48:22 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5093787e2fdso71008771cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 20:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773892102; x=1774496902;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JX6V7P6bsRPeotKtiH7RJ9N7+4pq9ewOSYm/l2L69q8=;
 b=QHX/Lvck9DxqoRGT7jzRh4dILyaOwvxgwHeEZLM42Ftu+z/kURg30kUvhSN0qKlGJI
 c02rEjDEFcl5VY8eaDgTZswxF1q8zM20QFVWRiTxWg8iu7TffVPKG86LK77d7fOj2cNh
 2NQTHFXqu+fsjWkGlyA3hI+UWBncTqAwJZgcKJfivmnCdCqEHvXHKYjS5moAJPtY4uxb
 GIeSefJb6oOK5TH+jyeKJvLNvGrWGZY0Meo5iTSOF8+FFaH/p6e6kHV4O68XwDDdPShU
 0LygFLIINNd9ppUjTryk61wqG5J0/n25MJ4RUBL9wwbPMOhArEbmAgT/otBzwlj1qw0r
 oRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773892102; x=1774496902;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JX6V7P6bsRPeotKtiH7RJ9N7+4pq9ewOSYm/l2L69q8=;
 b=JfQSPoU3yX4oBU/848ffF564lToOLulEPv8GLvLgSLjv4adhTNp+1MMz0kI5tHIqha
 RTgv9bZJ3IjWhArIiqVIGmwsO/JOejuMZNS4TYgf50htgRJi2o3g+8eByL0N4LQ7+mWy
 WqNyUh6XCxtpgtby6pa00VhwRreumNaswxGeVVGeFg6lTXT0+zhiAp1XNLUuaLz919SF
 iywO4r9we88iQIvnEqm8K6BE3GRmvBuV+19SBqK4CUnIo+ughYgMK0fjND90nO2O0s+z
 lIuwtfOfXTs8oBUXhecq2TKy6QVi+BLoBNub4IP7XLz7qgyDv4n2dGYc+R28+mTWncJw
 MEXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQva5xvzWLE8U/ng8ThWcMh2508JP/wSLLZI1iLw1nQny1AW/I1RTJ4dlCQPWFAPJjpLnn0b86Nzg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzcfh9etucab8xZrP1ol3UqkUsvAfg0sEdLMjMJZxzknaE8AT3R
 stBvnXda1eL1mUAGGEJE8vN6ovyFnoxFu4vxglOf3Eg8Nhw425CNnyNwgUvA7O0r9QDed3Y1M9f
 UB2TUpSpmw0KjfK6lztas7qFKHdOs2YReDIS+hoXXgq1OvsNIo7Nf+d0Wfk3mPxX18SdxKlU=
X-Gm-Gg: ATEYQzx/iv+877NzqWW6idLwgByrEWSAvWS32kwn0uKVHxqc4GBvIZ1Rebldi2yxc4+
 XZX0nFZoOCs6UNaau+1z3UV8DUR/SgVKQ66xoDJtH8XwiUSdE+f6Fiy43rLlEXZlTSEcswTl+aY
 ofmxVN7ciLy6WQKYAiRjkgpet4vdWHEKmdBFry6nlA1eGIm1gRVb7ACQcEGof0LPrWEm4GYwgCR
 /rv9lII6TpYF6oJexjoQAXByXtgJnV30+nq7b6nFs+choR0+WAMKP5FMcTJoz2ryTOnkEKFB7ct
 ifeb4l8bguHhA/aQRE6Klir+MPixRpMn1KZywrUwgt6Xj2PFGZYAMPnArMjKx/9/LP8qdiqEIPm
 XJfoVAdm29pJXeAVPcVd6KxWwBXHs/1MCdJHCvl6QPItSx+sY6PxFTdgeCtJMTFBOX9gCUXp5W7
 bz7WHWsIwn3G3LDISfxooI0rIU8OlrMkz3z10=
X-Received: by 2002:ac8:7f04:0:b0:50b:2e8c:6ad8 with SMTP id
 d75a77b69052e-50b2e8c6cadmr226551cf.34.1773892101686; 
 Wed, 18 Mar 2026 20:48:21 -0700 (PDT)
X-Received: by 2002:ac8:7f04:0:b0:50b:2e8c:6ad8 with SMTP id
 d75a77b69052e-50b2e8c6cadmr226291cf.34.1773892101202; 
 Wed, 18 Mar 2026 20:48:21 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a279c79442sm907649e87.70.2026.03.18.20.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 20:48:20 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v6 0/4] drm/msm/hdmi & phy: use generic PHY framework
Date: Thu, 19 Mar 2026 05:48:17 +0200
Message-Id: <20260319-fd-hdmi-phy-v6-0-cefc08a55470@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAFyu2kC/23Oy2rDMBAF0F8JWldCo5etrvIfpQu9HInGViq5o
 ib43ysHsgh0M3AH7uHeUQ0lhYreT3dUQks15aUH9XZCLprlEnDyPSNGmaBANZ48jn5O+BY3LIQ
 dOejJOjeg3riVMKXfh/bx2fNU8ozXWIJ5GpxqNgKA4pQAg0GAxoC7t5aNWFO2Gr9yO1/TYkomu
 VwONqa65rI9NjZx4AclqWT0ZU4TuD+cNUZJZvwgz7lW8v1jri7PM+kHHauafBKKchCvhOyEHIE
 xE7Ty3P5D7Pv+BwRCMEM3AQAA
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
 Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4372;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=GjT8hX4GoLE57pLmBQAVyLUFHndk0TADrBaKx6V+sLU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpu3ICJCKy3A19oDDChvBzxx7B9r5GPU+ihItK3
 ZBilBRuiYmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCabtyAgAKCRCLPIo+Aiko
 1VXFB/9LpajkYmQVIUq/d8ZFH142i2Gr/sXj5aitG99qq0vTEUO1esGql0jcvkWJvnYNPUoK1fk
 whb1q0odkeY4adRCYRXu6R5R6eXgsdMMeq9BQ1FpOHQhaW/Gn0A/hRNNFLMQGos/WnvTKXa1CDu
 72ISmg/zqatGwp/xsPYZ9HCCnk3BpPhTCC8itvG23j+XTc8UZkPWtPkCakjzmbjLaFRoG4RUCpR
 SXt4EgExHOw5PA/pTk+j4COVYr91kfPGmewrXnb7aVpK98cyzB9JpwewaIYu3NjRHo+NY8U32Su
 gw8MEdwvEqFIOE0nr3UeWEM9PFs1zGXH8uQOe6j0pX7K3r0N
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: YqI8DFbkta7ZYhuBk2Abp4xLpwCkGtRm
X-Authority-Analysis: v=2.4 cv=FKAWBuos c=1 sm=1 tr=0 ts=69bb7206 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=aG6DWvB8Nz23F0sxf60A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDAyNiBTYWx0ZWRfX266CLUlXsDRd
 yavZNFG5ymtVP8KSp9wzSj9NyMvswd4OEVv3YrIWInfweiGfn1+15bd8kayBAwA4ZHGcHJXC/RL
 Juo9LUVwHGJWMe3A5J+xIW+9n8toVVNRYMJTfxpZWS1thGRA5AlaAKjVtuER7fgFPsObUFzqgMX
 sYwxccC+mjYgONjHc24hg6+zfcy6QfU1xBWiypYTV03fComXT5fDmlARKhUWCh/YVXloLZG0TKp
 u0k/FQjQ659dKgjcwigQqps4oSaa3QQiGagfRDxnAP9B7Mcp4br+aJDxM11bgovE7ZKA23gRCNG
 kID59CldXIqf+CdGuxidCrSd+glMFEsBquell3iHsMam38cE9KJBW8JL8d3/AJsxPWNVZkzcV96
 t/HVMUK/OXtUH8JxKPWizMZoaGyGzB9CpUw6ZgoTRmitlG4e3dhC1o6RjvgLYep0IJ5F7DWpWke
 quwYbP5uOeHUYKuOo5g==
X-Proofpoint-ORIG-GUID: YqI8DFbkta7ZYhuBk2Abp4xLpwCkGtRm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_02,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190026
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

Merge strategy: cross-tree merge via the immutable tag.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
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
 drivers/gpu/drm/msm/hdmi/hdmi.c                  |  58 +-
 drivers/gpu/drm/msm/hdmi/hdmi.h                  |  80 +--
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c           |  80 ++-
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c              | 225 -------
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
 drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c       | 352 +++++++++++
 drivers/phy/qualcomm/phy-qcom-hdmi-28lpm.c       | 462 ++++++++++++++
 drivers/phy/qualcomm/phy-qcom-hdmi-45nm.c        | 186 ++++++
 drivers/phy/qualcomm/phy-qcom-hdmi-preqmp.c      | 212 +++++++
 drivers/phy/qualcomm/phy-qcom-hdmi-preqmp.h      |  59 ++
 drivers/phy/qualcomm/phy-qcom-qmp-hdmi-base.c    | 185 ++++++
 drivers/phy/qualcomm/phy-qcom-qmp-hdmi-msm8996.c | 443 +++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-hdmi-msm8998.c | 496 +++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-hdmi.h         |  77 +++
 drivers/phy/qualcomm/phy-qcom-uniphy.h           |  74 +++
 25 files changed, 2628 insertions(+), 3188 deletions(-)
---
base-commit: 95bcfacccdad8a76e02a8eaa92baaf09c879877e
change-id: 20240109-fd-hdmi-phy-44b8319fbcc7

Best regards,
-- 
With best wishes
Dmitry

