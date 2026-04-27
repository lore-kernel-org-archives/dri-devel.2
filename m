Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD351FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3648D10E155;
	Mon, 27 Apr 2026 06:39:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="X9B+0pN5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RNhLhgA8";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D20C710E155
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:39:09 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R645Uu2582740
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=61k0S6Aru9OHZyh04vEK3H
 Mf3snwaPzlYNIyU6zJurQ=; b=X9B+0pN5/64cUbBlhfNBDKS+5fVivKX5cGvTIE
 2I+HyyyDJHgNwQuDPq63k9xH5I06Lmcy4nAykLXuyUbR9PN3icJoMg0pZF1mld0P
 74GuBvt8vkDchInMD4rtAcrQ2IOvdLUdk6u/70z2NEYBmu/biHqPS0DlE29P/Jvk
 wGqX6Q43oqupWJMVSXOih26ALA+p3gE185P5yUun6W3rLXCc8krYGm0elw4+xYgn
 VYud7ar7430mjn8ZcbR3lRlr2oQz1VGBjJ3UadnipZSys6QC55/FLqA4MS4lZHpy
 cDDXbfL5oGsBShA2qOlt0wVQ9e6TxS8fEwtO2/QMI8oWTJZw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt26xg3uu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:39:08 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-354bc535546so10056087a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 23:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777271948; x=1777876748;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=61k0S6Aru9OHZyh04vEK3HMf3snwaPzlYNIyU6zJurQ=;
 b=RNhLhgA8ImIjWGZyv532w6ZFILdgUa0zFpacNou1FGvwDMSZ2Ev+AUa8pCDPcKcpA0
 NoYKgYub4eg26JsA2MLSFTaNfU9Vg0eASfKU9y3kRRZHzhFK94IKCAs44Nvq7EuWpAkP
 lyGIqZ7a9bZiHg3C6fQ1/JV1NNpatRjiN+rQNGyAxbwFDAlt5rjFuPn28Cx+llJXMm0T
 CP5DT1qBEtYID+3f7LkWnHINowf+hiZIV74RIaNmwuRS7ZiMSi3AAuWIJA2FgtgH1uLd
 ACph/1en18PVAO4igdC3EuBguthU8DRjo9WbCAdil8nV77yfD68aprKmZWZo6TZrfC7f
 A6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777271948; x=1777876748;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=61k0S6Aru9OHZyh04vEK3HMf3snwaPzlYNIyU6zJurQ=;
 b=OmMjqoejYrXE+BPe0vY6r39Cc7jo4N1DhKFCqRkVii8P0DxT7S/rnq+YTP7cP8+/Ar
 8CGw97vewRwegAraNlmVDAJfvzXpDGRGAvPColZ1VH8LVde60XYawcYFEITVhkrUAOno
 Mb4LM8q6uibSoyZRkOQ8o2OtgHzq8CKX9WFuRzpcRLF7AoRgLBaR5I2/XSe29W6JTF++
 Hfvi7oXtEVxQvQduDyFlLg1RDnoYtTVkVifoYxK7eGJtOmdYe46N7NGO7VPod7PAefMG
 5QK4v9r4ZSHkTiKfuRqFm9g4ThOkAtkTXyDwGN8xNCMH7h6HdF+454nhpv3AImZncUgP
 0lMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+kVCnDV8ywj5j/PIaIkraQY85eZMm0PXUrXSxqt8YhYdITNquzKTII2oiH4QXCLLvgcrQLbkJnMGc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxAgS5CCe6tlfdS4Q/ZgjhQu2I0leQPZAySDrMkyA6WVrsXGuvd
 r/PXHnZmlVpqhjVPIgzwS/Qgchrn5mjM4Zt+DQKIDZGPEvYGwBqZ0N+GIrwQ7jIQymjuosd70yV
 DjDT5W2pQvlMBArIkp8toImpT65AFLrAtHYNJh9quXWEaPH+7xDO2hsRE8oCa6aQLIAidlLs=
X-Gm-Gg: AeBDietOfbtKJeYgF8kvWNCOvGbtOwi7G5W7gukn7/pSi2EKnogj6s0TfDkw4kr30Fg
 /nzRvT4IH/2UqaGX8m5MEDc8Rsuz9zqSHgMPEWqlQqc9mrmnyt8InfDXGGfiTfA8etCD9LQU6z3
 2SfXnV6wku0NrRNsVjNooXgvM/wkQ7iNFI1O0NT9QwTZlIX67alcOIx93FUBiq45Xbv+9QjnGdm
 jcZjb0UEBvi3/fEHLfmx0kUA6HAldrCxIFgYJAVi+l/63xgN8qtS2JleEMC1AwTRmmOgiGgg4y9
 QT5G1EBK4zYNO4Qxc/ERNEDUGcLnkn27hPQo0Lmtx1PaByaqe7ogFfUDGB1XUEzAfLP99m0ZVem
 RdsbYhONhEI3GK/saVKSM4NrRQXYAZom80UZ4aGVQCvIvZ/IbVEq9dI+3
X-Received: by 2002:a17:90b:3504:b0:35f:bb33:d727 with SMTP id
 98e67ed59e1d1-36140478be0mr40995963a91.20.1777271947668; 
 Sun, 26 Apr 2026 23:39:07 -0700 (PDT)
X-Received: by 2002:a17:90b:3504:b0:35f:bb33:d727 with SMTP id
 98e67ed59e1d1-36140478be0mr40995916a91.20.1777271947140; 
 Sun, 26 Apr 2026 23:39:07 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410a7ab7sm38628234a91.10.2026.04.26.23.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 23:39:06 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Subject: [PATCH v2 0/6] qcom: Refactor GPU GX GDSC handling and IFPC
 behavior on A8x GPUs
Date: Mon, 27 Apr 2026 12:08:54 +0530
Message-Id: <20260427-gfx-clk-fixes-v2-0-797e54b3d464@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH4E72kC/12Myw6CMBREf4XctZeU2oe68j8Mi7YWaASqvUowh
 H+3krhxM8mZyZwFyKfgCU7FAslPgUIcM/BdAa4zY+sxXDMDZ1wxwRS2zYyuv2ETZk/IhRFHbq1
 WWkH+3JPfhny51Jm7QM+Y3pt+qr7tz6T/TFOFDIW1Uh72RjIpzpGofLxM7+IwlDmgXtf1A+za+
 Z2xAAAA
X-Change-ID: 20260406-gfx-clk-fixes-24a492bb7676
To: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Taniya Das <taniya.das@oss.qualcomm.com>,
 Pengyu Luo <mitltlatltl@gmail.com>, Alexander Koskovich <akoskovich@pm.me>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-GUID: mboWn3Qxg29w3fmLeTNyv4gVBMh01_UW
X-Proofpoint-ORIG-GUID: mboWn3Qxg29w3fmLeTNyv4gVBMh01_UW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA2OCBTYWx0ZWRfX5KUeLXy0cUo3
 PXXH0FZYpUAHxollYQTazfHoYRjXO5xE3RjTnSUHDHWawVn4YSYv61JRFKTVsSbJQj8/jyHSpeK
 15Uo5nO3u4Do4zZCIcUy8CLviDO5SA2o2B06IGHMk32LZ9IetZ2b3hLwILTzgw5YwYeS7ZDnutj
 Rc+8XXEb9QxMri4Tts0EWvu4LQzqdHFNJhA2kEJAkcwIGJMPuHh6nrvurY/JX6dvFqBocg0pjsK
 J3/3xGKughPvClbC4RheALp7wFP2Y/Vk88VEXdF1ApxI8SrWHvgwBIYDYiTTtDoqSdLtSf6TJiO
 7BdT4W8ZOQsKw6j9vx0dHhCH/Z2E4P9AoRZRioI0WQ9NWl8OVzn8osCNmiPAGBh/mPzYAFnvjXc
 UEjwWCzF8yCLgTNzPYQM0/vWcVdhLlsPiErNYKBwCoqVdrEeAMk+AQMUmXrQBtnAq6j89gwaXYJ
 QZwRl80UUF+nArIIRMQ==
X-Authority-Analysis: v=2.4 cv=FM8rAeos c=1 sm=1 tr=0 ts=69ef048c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=zYEJGWroTao7pyO8AgkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270068
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

This series fixes two closely related issues around GX GDSC ownership and
rail control on A8x GPUs, where recent hardware changes and runtime PM
interactions violate GMU and IFPC(Inter Frame Power Collapse) architectural
expectations.

Problem statement 1: Incorrect GX GDSC disable by OS
----------------------------------------------------
GX GDSC is a special GPU power domain that must be exclusively controlled
by GMU firmware during normal operation. The OS is expected to force‑
disable GX GDSC only during GPU/GMU recovery.

However, when GX GDSC is managed through the generic GenPD runtime PM
framework, it can be unintentionally disabled by the OS during system
resume (resume_noirq/complete phases) or runtime PM suspend paths. This
can race with GMU firmware usage and result in warnings such as:

  gx_clkctl_gx_gdsc status stuck at 'on'

and failures in gdsc_toggle_logic(), leading to broken GPU suspend/resume
behaviour.

Solution:
Introduce a custom disable callback for GX GDSC that prevents the OS from
touching GX GDSC hardware during normal runtime PM and system PM flows.
The callback relies on GenPD’s synced_poweroff flag, which is asserted by
the GMU driver only during recovery, explicitly allowing GX GDSC to be
disabled by the OS in that case.

This ensures strict GX GDSC ownership by GMU while still supporting
recovery use cases.

Problem statement 2: Unintended GX/GMxC rail votes from APPS RSC
--------------------------------------------------------------
On A8x platforms, GX GDSC has been moved to a dedicated GXCLKCTL block
under the GX power domain. Due to the current runtime PM device links
between supplier and consumer, when GMU device is moved to RPM_ACTIVE
state, GXCLKCTL device will also be moved to RPM_ACTIVE and result in
GX/GMxC rail votes from the OS.

This behavior conflicts with IFPC and Adreno architecture requirements,
which mandate that GMU firmware must be the sole voter of these
collapsible rails on behalf of the GPU. Linux is expected to intervene
only during GPU/GMU recovery.

Solution:
The runtime PM of GXCLKCTL can be disabled post the GX CLKCTL is runtime
suspended in probe, so the runtime PM requests of GMU device are not propagated
to its supplier GXCLKCTL.  To avoid incomplete runtime suspend during probe on
clock controllers using runtime PM, ensure pm_runtime_put_sync() is used so that
runtime PM suspend completes before returning from probe.

This along with GMU driver change to vote on GX GDSC only during GMU recovery will
prevent the votes on GX/GMXC rails from APPS RSC during normal GMU operation.

Patch overview:
--------------
1. clk: qcom: gdsc: Add custom disable callback for GX GDSC
   - Prevents unintended GX GDSC disable outside recovery.

2. clk: qcom: gxclkctl: Use custom disable callback for gx_gdsc
   - Applies the custom behavior to GXCLKCTL and fixes runtime PM warnings.

3. clk: qcom: common: ensure runtime PM suspend completes on probe
   - Guarantees synchronous runtime suspend during probe.

4. clk: qcom: gxclkctl: Remove GX/GMxC rail votes to align with IFPC
   - Eliminates unintended APPS RSC rail votes, restoring GMU ownership.

5. drm/msm/a8xx: Make a8xx_recover IFPC safe
   - Makes the A8xx recovery path IFPC‑aware by checking GX power‑domain
   state before accessing GX MMIO, matching a6xx behavior.

6. drm/msm/a6xx: Limit GXPD votes to recovery in A8x
   - Removes GXPD voting from normal GMU runtime PM and restricts it to
   recovery using the synced_poweroff mechanism.

Together, these changes restore strict GMU ownership of GX GDSC and GPU
rails, align Linux behavior with IFPC architecture, resolves reported
runtime warnings and failures, and enable correct power collapse of
GX/GMxC on A8x GPUs.

Changes in v2:
- Update commit text for patchset#3 [Konrad]
- Add RB-by tag for patch #2, #5 from v1 [Konrad]
- Link to v1: https://lore.kernel.org/r/20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
Akhil P Oommen (2):
      drm/msm/a8xx: Make a8xx_recover IFPC safe
      drm/msm/a6xx: Limit GXPD votes to recovery in A8x

Jagadeesh Kona (1):
      clk: qcom: gdsc: Add custom disable callback for GX GDSC

Taniya Das (3):
      clk: qcom: gxclkctl: Use custom disable callback for gx_gdsc
      clk: qcom: common: ensure runtime PM suspend completes on probe
      clk: qcom: gxclkctl: Remove GX/GMxC rail votes to align with IFPC

 drivers/clk/qcom/common.c             |  2 +-
 drivers/clk/qcom/gdsc.c               | 22 ++++++++++++
 drivers/clk/qcom/gdsc.h               |  1 +
 drivers/clk/qcom/gxclkctl-kaanapali.c | 12 ++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 64 +++++++++++++++++++++++++++++------
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 15 +++++---
 6 files changed, 99 insertions(+), 17 deletions(-)
---
base-commit: 2febe6e6ee6e34c7754eff3c4d81aa7b0dcb7979
change-id: 20260406-gfx-clk-fixes-24a492bb7676

Best regards,
-- 
Taniya Das <taniya.das@oss.qualcomm.com>

