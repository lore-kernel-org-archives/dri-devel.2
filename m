Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA92CD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 18:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DD5410EFFD;
	Wed, 13 May 2026 18:14:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YLYQC72s";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kgz9bNce";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4CE10EFE9
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:14:09 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DF4qeF2887823
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=+5YP0QOKpbphYDgLRVZVQZ
 pcwDOr8t0VL/ATQqa7Tmw=; b=YLYQC72syw3caPf+4dU9R138TxtZPBD8Y6O0Fr
 TUV84VyPdV6XYwBTyHNoo+Hxo8bZn6sZKAYMxlMVRn+kfPCPLBSsEkjBqzX4p7+R
 y4iAeGrYOdHU0f9hqJbi0iJvjKsXZ1X026deoKIMJbASlBFyaKsQCtl2S75Viw3R
 M/fF68OppKTSZfgCW/+SfbuJeM1YlGB+4yJD4rHuFQP4xqxfmoX2H8p/roY1pXLR
 PTngClyo65nCtt/YB2tVDnB3mv+hT/fRYCNk6rUBMHhdoLDuAJvNHtKreWd+PG7Y
 6Y4CnfsYP86oLN5SntyPqus5zCJvGcSgizmE0dqudcxbn0qQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p4gj8ja-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:14:08 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-95f8863e500so2447120241.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778696048; x=1779300848;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+5YP0QOKpbphYDgLRVZVQZpcwDOr8t0VL/ATQqa7Tmw=;
 b=kgz9bNcem+qEEzg/KWMThHTxxxygLakOT9qohRmdR6qijMc5R/oFfGMBFQfIhyYAjP
 yFtJjRUKy1J8HoJwK7zTmQCRPvxWg5kwyRCAw67rbCypT3NJOutW4e+jquo0+5QvlRvD
 GI/VJiHD1BLJap5EQUTm/RP/HOsqBqnD0xYYvkAFn9qVzwo0uG48LZ8k0eb/F4dstGUi
 NMxGOpie60YDYFuPu0ZlNhAGgn1Dtbvh6RSTDt3S8dRSpmXM9rvl0OFFhjyFmw8k4PFd
 WLlLMkYJd0q3g52tR5DDiHGt0PTD+61pKRaiywUPsdsDeAwNqPJjkh1QwZS5cQdO+a4M
 LWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778696048; x=1779300848;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5YP0QOKpbphYDgLRVZVQZpcwDOr8t0VL/ATQqa7Tmw=;
 b=Q8/EaubVqQtKtmpF6ZmhEPralesKX4Z5p2+yBn6QOLY2sLwHGKbAEu+nSOk4NB5pkD
 zwNTMCrUS7umphArKpE33gM8XV/M35tmt8p8og12AQSd10TWBteqN4rzSegFM12cJJmc
 O7FGsa9zvH/yDhzRmUcVoWh57D17psDGssBe0rVntuECHXxAa+kJtcOGkB5738hTbKae
 B0CcnnBzFaXMwtTuXSzxt3bE22HX138OnJMU7nVEj8w1QxPjI6YYDAjrPEtb28P03ijK
 GF3ER1BU61JuwvVG5og+PQLuzUI5XBIPyHlJYydZFwuK28yaxdaCbrCJZJi57cFk/abP
 T8tQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/VF3PTWCM1Wnbe6AhqNszxSw/AxS59/EJ8MLJjlUHATizWpOWUtyFXc4S6Ld8Zs8inn36ACTICZr8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx32vqzN5TfxLC6GAJhEh8YiwRHpseH/7ML5q0hlNqgNy+wsSaZ
 mXL5H/H8uaMgSBtQr3LdciYJ1Jg9qSU8UIILEjE/ST5u4ej00hfwgNNKu7wdfowJMRJ35KA0xlq
 6548M3SzuHIQir6VuxxR2KnwR/SAqGyCEWvLFAV54XLMw4t0TrBL+io4G9FyUivXC4y534Ig=
X-Gm-Gg: Acq92OGAefECIXrABC95YtT/AspfzAq75mCKJ6f2subm7P9dQSGw5D0EQSR4yXyNJ6q
 wyDacXnjIW6xCE9Z/zClp6H7Av6c9sEnBwFsgwrZOvdkoCkARpHkhK2O/Er3QrnUFWoWKdlZwwV
 gkZQeyyCA7Z1RESWCUWAxPkktP0RNfjfG4Yz2j5jPPogVKVfR25NN7ps/1OfPoxxPBgTW9abomQ
 6rIybZMczaio2xI+kgfAiVdMTdNALy+Su2NvYzJBtwn/9a3Dx7fuKlGQD1Km3CcEb5kjCtRaYKF
 TdITQDRSkoL3RpbaV49wZjCqLUoZacDjFmmru6j6C5FjJ42N0v0LvwtNLd1zcP37gR02EGbyoBT
 7s34VaSHUTLbeB1RDGbDW4MbISrwF4/1hH1F2qfDdsYKXTOjRdi800/f2qlQs3OzAIK4wOV5a0P
 Vqd9EUc5Skk4MG+aACXccJ0yk2uVqMD1XUVy4=
X-Received: by 2002:a05:6102:945:b0:632:29a5:2b24 with SMTP id
 ada2fe7eead31-637a6c2fad0mr2435854137.3.1778696047658; 
 Wed, 13 May 2026 11:14:07 -0700 (PDT)
X-Received: by 2002:a05:6102:945:b0:632:29a5:2b24 with SMTP id
 ada2fe7eead31-637a6c2fad0mr2435842137.3.1778696047257; 
 Wed, 13 May 2026 11:14:07 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8bd7d8974sm3174770e87.64.2026.05.13.11.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 11:14:06 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v9 0/5] drm/msm/hdmi & phy: use generic PHY framework
Date: Wed, 13 May 2026 21:14:03 +0300
Message-Id: <20260513-fd-hdmi-phy-v9-0-ca98c72f1f9f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGu/BGoC/3XRy2rDMBAF0F8JWldGI+vZVf6jdKGXY9HYSiXX1
 AT/e+VAaFyajeAKdLgzuqIScgwFvR6uKIc5lpjGGvTLAbnejKeAo68ZUUIZAaJx53Hvh4gv/YI
 Zs6oF3VnnJKovLjl08fumvb3X3OU04KnPwdyNlmiqAEC0pAEKkoHGgKs35aWxJi+l/0jz8RxHk
 1OT8mlj+1imlJdbx5lt+EZxwinZ1ZkZrhfOGiM4NV7yYyql+fwyZ5eGoakH2lrN/E4I0gLbE7w
 SXAGlJmjhW/uEEI/EfimzqIQLnSPKcM4keULIB4L+aSErYRl4H5RXrVVPCPVL1M/ZE2obBCwJW
 gXfCfcPsa7rD9FxG04AAgAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5467;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=mqLUBTI2S2Voxvu3yvM6wDaQbTBkg1ZFVIhIqHpLXg0=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQxbL/px7MZlGkzPWN8gLJcXH1iyZ8OmYXl+P6aK11pPTs
 0Q/LZLqZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBEFjNxMDTq+s+dKzlpS2SL
 c9j3VruZ2muExKqXFfl4NiseCV5zsC2aXYPR/IhNYz5zclTLmWTe1A8vcrXO52tP3KzH6HvErkS
 yLfeK758FzOez6zJmKdceLF1ZvVrMQGGL3gRbHlGBetvFRtMfSd1oar5hsqWy38dYosL6isNU5r
 s5/093X3KqtNX4baV/rvVJjGLPHJ3HWe37X9c/zXvw+d1asynrsmP1FRX+6sUfrfh9Q3zWH3b79
 28f3p71hs/f6eF26VUzJpnLVyb4Liv1tkxO7emwO6K1onHe9PmLGnx47qWG9m9MXef2h+ufZ2ZV
 /H2hFt+1S257f7ovvd4ytqlsnqW70qswg4DeBrdksxgA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: j_6iPGP_nb3hX_Go13JguBNnRoWf8I_6
X-Authority-Analysis: v=2.4 cv=DOS/JSNb c=1 sm=1 tr=0 ts=6a04bf70 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=0ODQC-He88dBTbE4dnsA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: j_6iPGP_nb3hX_Go13JguBNnRoWf8I_6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4MiBTYWx0ZWRfXxcPUQWVSoo3e
 x7ydz29A3Y58xvxr6M+N3AbDKV1+GwWjHWZb/5SzPdQexq8EBXhpEtBHpBiHCCX5RM72D7ATZFj
 0wit61ZIZ9D8aqJWdQXyp8ItBfgXOQ1DRzKLx895oihOp8/s5G7zoCdVKCsNdPRlGN2NcoFR4Sw
 ZwcmjyZJUtW6iImhvRn4E58hG97b71rN8bpHgpkhoTzsLs0Q9NznSQV+DrXqx6dzwhP7WSkP/NY
 8tBBp5aX+3mToZJmKtZh4Ab4SE0M7i1GSy+79/UHZVl5l2Hg321QTKOxZ0Ohw1dKL4kb2qgGnvx
 TlRd/BE5EcfyNPCR3KXw/PHDLI/0CxglBhXNIrUt4fut4kzaJb4CYGprYHN4H6eL7fiHnnXgpZg
 JVmUmEHsCsyPZOOdmdBoNMXRaF3qTodmS2vIRDFUD0pGtzs8iqpQpB8DaLxV8lMpFoN1NqbwjAe
 Rs77m5VtiHUzqJ3iIsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130182
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
Changes in v9:
- Split 28lpm changes to a separate patch (Sashiko)
- Reworked PHY power up /down sequences in hdmi_bridge.c (Sashiko)
- Switched to pm_runtime_put_sync() (Sashiko)
- Link to v8: https://patch.msgid.link/20260401-fd-hdmi-phy-v8-0-51b0e98edf6c@oss.qualcomm.com

Changes in v8:
- Rebased on linux-next, fixing conflicts
- Added missing ids for APQ8084 and MSM8998 (Sashiko)
- Switched to pm_runtime_put() (Sashiko)
- Fixed several missed *1000 after pixclk -> tmds_char_rate conversion
  (Sashiko)
- Fixed several math overflows (Sashiko)
- Moved UNIPHY_PLL_LOCK to the common header (Sashiko)
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
Dmitry Baryshkov (5):
      drm/msm/hdmi: switch to generic PHY subsystem
      phy: qualcomm: hdmi-28lpm: provide dynamic configuration
      phy: qcom: apq8064-sata: extract UNI PLL register defines
      phy: qcom-uniphy: add more registers from display PHYs
      phy: qualcomm: add MSM8974 HDMI PHY support

 drivers/gpu/drm/msm/Makefile                     |   7 -
 drivers/gpu/drm/msm/hdmi/hdmi.c                  |  59 +-
 drivers/gpu/drm/msm/hdmi/hdmi.h                  |  83 +--
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c           |  88 ++-
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
 drivers/phy/qualcomm/phy-qcom-apq8064-sata.c     |  24 +-
 drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c       | 353 +++++++++++
 drivers/phy/qualcomm/phy-qcom-hdmi-28lpm.c       | 477 ++++++++++++++
 drivers/phy/qualcomm/phy-qcom-hdmi-45nm.c        | 186 ++++++
 drivers/phy/qualcomm/phy-qcom-hdmi-preqmp.c      | 211 +++++++
 drivers/phy/qualcomm/phy-qcom-hdmi-preqmp.h      |  59 ++
 drivers/phy/qualcomm/phy-qcom-qmp-hdmi-base.c    | 185 ++++++
 drivers/phy/qualcomm/phy-qcom-qmp-hdmi-msm8996.c | 440 +++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-hdmi-msm8998.c | 489 +++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-hdmi.h         |  49 ++
 drivers/phy/qualcomm/phy-qcom-uniphy.h           |  76 +++
 25 files changed, 2617 insertions(+), 3192 deletions(-)
---
base-commit: e6e0eed7a4199442ad9be37daafafa4503c3f436
change-id: 20240109-fd-hdmi-phy-44b8319fbcc7

Best regards,
--  
With best wishes
Dmitry

