Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A718D107BCF1
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 05:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E693510E0B9;
	Sat, 14 Mar 2026 05:06:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mtx/wY2Y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JYk4awEr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1A8210E0B9
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 05:06:35 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62E3nACK2537650
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 05:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=uRmdk1ifzAXT+4aK/1/vkT
 qfkWelFGrIyVShhIr/5Zk=; b=mtx/wY2YYEb+n1VBg+RmNyAfervdRuoBNqnAnD
 48+EdTZZYYFC9t5NP44WzumeAjiK5jqA22GNInBE0v/vKKeBRRT463mQ27de38eX
 Iai8WXBlcUu6rfyykzfj809lhR4KgkU2rpniNAYKBvGp4rlPrEiBbB3zVTGPKGty
 yZ6sYUVhKEA+VsnbeurFLCu2/a6cv4ukksYDPS1TaCjHq1rA1U35mjrhx2/tx5NL
 jlCqs42BPUFhpvl6fCd7L8DaxKazmrdLw9I4CVMOqQiKfhPIk9xqBnogeLIpeuY/
 Z4/QKfXWYyTVzzVedZfNVxYUKhtcWRtYSzf+2jEZ2vUph2wA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw03qg3kx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 05:06:34 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-509044f54aaso208431301cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 22:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773464794; x=1774069594;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uRmdk1ifzAXT+4aK/1/vkTqfkWelFGrIyVShhIr/5Zk=;
 b=JYk4awErCQ1wt4mc8xa2NdZCa2U6XWRMuw7H+2ltVsAHCYu41Yk1iYSVf+anPFNGqy
 CDxNdGarmG0U8Uy58aE3Px80EjM0eNQbkSYFqSLfpD/RYDWWUpOlp3qhzMcxgy/nUB9y
 7T6bV8DDrSJyDqWlm/71X/7SUszQop2pzTE0d0vZh4DrpgjUr+7usMMgMoP2nUB4rQiM
 tNQUckEnqbFYANU0RhiIrnf7Eo1Y845Rqb6Q/2kRuVbpENZbRY1WjmUYYAnebCuMnCB4
 L50eJk8BKnRVaGn+zHQEC19BeZzVJzH7vhE4M5bj/LOB5THtRVo6s3AQNXdKqd5hJM7q
 tBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773464794; x=1774069594;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uRmdk1ifzAXT+4aK/1/vkTqfkWelFGrIyVShhIr/5Zk=;
 b=gDRLtvVgCVgB6KfQAXegsJVB3nhzCWsbMxCklLyDCpiebHWFL9fY4zBVd7F0GS0GbZ
 x2chaOUE9mMVV5wIQJPykX9HsofXYcacxPBtvgEx3NUsM8AcL8SkQ8tw9hFzOUqwZBgS
 BkE+B05ZdPWaNCk8+qRJP3M9dNiRPmrP2OW8Mt730ICON9hFsit1OudfDjetTYvsU1yd
 Ltz5qSH23I3Z1/pUsfhCKeNXQgI6tkoMInqICWgxDtS+AYaeNO9CxI8cxgjEz/B9RIR/
 RS6o7GMs90AfpTTcTSIO/wK35zNOVsGhYJzcTTWG0U/c26lFXPFsEMVWO+O8FM1sMc48
 DEsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJWFO9I1Ll7oBW+2Hpive2OsBtW4e34uOPI8hMUxsD8NIY7Nfe0R7Fl/pzMqhrQyKPvpJLDMXewu4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLvirZbMfw542jsHagqPApy+em9TvO5O35ELuYCLdfwiO+UVdW
 5uvhYPv7hgvINeu/opewZ0PAjuPlIw6fNEb7eDT4pZnH0a5YXKoVqvqpG7t3HRChNMal1pC4Z4F
 PYMeRCTOB0wiln1Zo3RaY0M377yFc/aV9z/r+Whv8/86b6FopXPgHXbhkIpo20DBOto0LWsQ=
X-Gm-Gg: ATEYQzx/rv8eDZgYB2HeYkXhpmBq5k4Asjr9FFyHCvHRYRD9fOkmt4qir5Rl5nRz5QN
 TbjWRHOIcysxTX/dBn9d9Eel0T0sKtyWG7U2t1KTn1GR13zgJ66yE6SRTJA6nUD4dTgtEpB9G3f
 1cmY4SlZoZllGtupXmNBbneF4EzbjJ/9OeEag1vI5w6rKNvoNnNHinUvZQi1g8L0BnFYj4XYSyr
 NdarRFCTQGYGsPfNuOInsGkNMCfBD4buAKu1e9DoABkCu9GN5I96JNYqU+KNW9TX/IA7Rrj97+U
 hvc9o1xd0d+ACG3rb/CZuF0CNhdhUgOm+nkqjeDvsTyUhnaX/NOS+onKc35QQtCzIpgHnKsoKTb
 9r3j/MJZgYZg+QUFl3qNPpyY2rRJluw7SQzE8rxBfd0wYjKeLvN3kTQmAjp59tI+MBzDM6xJu83
 uzfHw9mZ0DdyysV+yvSaahBBDtFAgGN5bn7co=
X-Received: by 2002:ac8:5a87:0:b0:509:1b01:8929 with SMTP id
 d75a77b69052e-50957cf5250mr79097441cf.3.1773464794305; 
 Fri, 13 Mar 2026 22:06:34 -0700 (PDT)
X-Received: by 2002:ac8:5a87:0:b0:509:1b01:8929 with SMTP id
 d75a77b69052e-50957cf5250mr79097241cf.3.1773464793816; 
 Fri, 13 Mar 2026 22:06:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a15636206bsm1982771e87.67.2026.03.13.22.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 22:06:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v5 0/4] drm/msm/hdmi & phy: use generic PHY framework
Date: Sat, 14 Mar 2026 07:06:18 +0200
Message-Id: <20260314-fd-hdmi-phy-v5-0-58122ae96d3b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMrstGkC/1XOQQ6CMBAF0KuYrp2mU1oQV97DuCil2EahOkUiM
 dzdQuLCzSR/kv/yPyw5Ci6x4+7DyE0hhTjkoPc7Zr0Zrg5CmzOTQiqBooauBd/2AR5+BqWaQ4F
 111hbsdx4kOvCe9POl5w7ij2Mnpz5GYWo5QERy0JwlFgprAEheyPNvDE0J3+L0+keBkORR7qur
 A9pjDRvGye14iulhZbib86kID9sY0yppWkrfYop8efL3G3se54PuyzL8gU6+GMi9AAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4083;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=dpVL6xHiAyTcRZvdVTUxyACDfNacks8+MDrD7qZtgII=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBptOzVFzbufK/Pv/ssbcuMRW6VJ3TLt05H6aH7U
 W/uoIwvBW6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCabTs1QAKCRCLPIo+Aiko
 1Zd0B/0WSzvf4ZiWaezOqFchqErUFw8lThh2cUGjBEL1kB7F1c1TwENIyYeltHt9bglOH5j+Zos
 kpr6aLYMOpgP0eYEmhl8WAriX+woGYntlzeVYxmD66mlIvnCMqdmRMaCftjg5KH/KdzPJXUDRsx
 cyy7ixuVv20jpLMabU4iprDhO80cZKMC9Le8U3lbGLtrzjl6xU0tClreKVuzgaukADmvkw4VRyI
 7sX5IKeRs3vxtfgTeefva/zDDsFPBtwYj5q9Y+LWHXybWjvpU+GQNafnJhPWdCoKlsfrDmSes7n
 T6aNwNuhSwhIvzh6XqV3IxsJiAvzVXKSajYmUCheiXRrWF0y
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: fvjoJzqs5nE0HeBe5AZDCLr2dkh_mxOF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDAzNyBTYWx0ZWRfX6r074q/TPNL1
 XxTyT5r1OYq9SmTaH+HxgzIvKkfEidnE0yTLL8cHaE1zBBNln1MWgRnonUAlFcTuu6LSJjtG1w9
 Ad5iaQ5nWA7ltUy84kXtOiNwlKk2pnZlaW3XxfkkZP1Xbpo+rVHaez5YR8goN1Tq9VM3V9G6mMD
 EdtC8ybrmt7/dJx88K92OLWnC2mSOa+Pad0IWroTA3EZUHrsXvzTORIl/0Z9WLie2v/ZtAcLUwa
 trbAXayNT6WjMTn5uM5BLv6HjBzbaNMVAV6YluKfoLrzt+HTpuHda3uGaZZ0x2ODipY+uKcPUtR
 m4aGgy0P6AO1i30BxG9bKBpw3W/Oss9JCOovaZIrffG3eAQK1Tz/q/IcVPZlZ0hQBDXfyZ6g1Hd
 oMP+X8K9OE6U+xbRkuaModijgL7x3NLXBa1Ya6hDwEZO5O9Wzg25LRBrVsOjdMaTX7q0QeUTkk+
 GYg5MIjnN0ZI9JuAvSA==
X-Proofpoint-ORIG-GUID: fvjoJzqs5nE0HeBe5AZDCLr2dkh_mxOF
X-Authority-Analysis: v=2.4 cv=ZbQQ98VA c=1 sm=1 tr=0 ts=69b4ecda cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=sCsn4_Ng67BVsxP_3UQA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603140037
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
 drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c       | 332 ++++++++++
 drivers/phy/qualcomm/phy-qcom-hdmi-28lpm.c       | 444 +++++++++++++
 drivers/phy/qualcomm/phy-qcom-hdmi-45nm.c        | 186 ++++++
 drivers/phy/qualcomm/phy-qcom-hdmi-preqmp.c      | 212 +++++++
 drivers/phy/qualcomm/phy-qcom-hdmi-preqmp.h      |  81 +++
 drivers/phy/qualcomm/phy-qcom-qmp-hdmi-base.c    | 185 ++++++
 drivers/phy/qualcomm/phy-qcom-qmp-hdmi-msm8996.c | 443 +++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-hdmi-msm8998.c | 496 +++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-hdmi.h         |  77 +++
 drivers/phy/qualcomm/phy-qcom-uniphy.h           |  65 ++
 25 files changed, 2603 insertions(+), 3188 deletions(-)
---
base-commit: 6d67f372c3bb68e62b609d0929808c9567df7209
change-id: 20240109-fd-hdmi-phy-44b8319fbcc7

Best regards,
-- 
With best wishes
Dmitry

