Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244B7EDB7DC
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 09:31:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E74A10E382;
	Tue,  7 Apr 2026 09:31:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fj7GuhKT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IMDz3WbH";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEEBB10E382
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 09:31:24 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376Wjcs3402384
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 09:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=no6GmN1FeKv2TMsDqdpgcy
 RTsovznCVnpZx+ew88y/c=; b=fj7GuhKTzcP1FSYoJcErC/suupVPGRtLzj8gsn
 HMU0u/rFXc/2XD9X79GwxqXZdLP2zKDdOlmYf3lM5UTE0KCVhHBTuJbPukxSaC1G
 vtj0xzke5eCUwZDr6iZUyT9+dWQa/My3MsNM2FzmazeM3BbVPU5tenxGKue8e/Fr
 VeTPtEekoJrE9BM2NfH+Vg8ts4DrUrw3SXcUkMAQmRjAC7XncGCcuPemOTD4x24j
 1josFXQOHrcqD5KGxcwLdFj4zDJjOOz8//eCdERVNTV6Jh0Qy6FPG7/GrUUXhB7i
 ca1df1kYN3FXShIpZNWAMnvQuSkYASPifB1dyEfy6iMyREQQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrht1vs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 09:31:23 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b0c30b51bfso105697715ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775554283; x=1776159083;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=no6GmN1FeKv2TMsDqdpgcyRTsovznCVnpZx+ew88y/c=;
 b=IMDz3WbHZsI2ax1pKDpZa3qYp8hFxxqjytAnxXxoLUXhZkX2S1zL+bCqCqeWFTIhBd
 jYtFudtIxYdQTMg/VjibUB7aE5D41580TvvCx3GOetFG28v7lPeghKvgvODhMP4QzJl1
 qvaW+HtGDXfa6E2ofebunXPAn1TB3gxxvADTYipMIlaCiZArIb6dbqeGf52gG9Wi+BnL
 hz+aBOYtDhz6hjBI8LVMeKk8FIXpri64T7dhYqnXTWDNdgnB98mfKJKsgUbDsiExr+kY
 P6r4NUgfRk6zixoMDr1QQcFzojIG6lwDM9N8zNG+WAOeQf29nnSBMaBj2eqwqU1wWsRm
 Btcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775554283; x=1776159083;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=no6GmN1FeKv2TMsDqdpgcyRTsovznCVnpZx+ew88y/c=;
 b=AqIt+AVfsttSq0hxqUGfj2xwzRz+WDX5rLdYlkfJrqcaqwnRebOLxMSfCDLcMiXxjl
 5QOT0iK64Er+DPGHg6E2EZQVXVCy+PT2gb/ZX6/8nxQE1HkmI6kIvV3yII8XJPNjeKoI
 jvFgxAhW8fqQxzMk2rTYaRh3xyGVASaHz4EK/scbpSD+Rx2HjDRK2x3bAvC6AmwMfol5
 cP9uT+vBCHGIHaJG7dfIrKsTVWcPa8nIzjCt5YSiP4HucujC1XS/fyYTKckYB7BCpW3Y
 p5nSF13N8x51d4hk22RmMWqAXMrTzgmgluMZEBmq3EIStARqFB2qCd+RT34K5CPxDCSj
 Sxqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2Zz3Va6gmmZxuXLAIisDpqkLFyDF0N0HCvlAeGVZ02LDnybIBZ/CDAR5wxKqxIyLkF5Y+84wxtNk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRRLm0qtasBwbBTzMo4RMm1gSAiUo9NOOvIWWE0jXqknrk2jrv
 ccUqw+6ZfBhMWioLuCONzHcQGaE+xzM1W/TP9vgQidl5CYuVYd9XFfdIZpsAYvUpcrlQAsmRHZ4
 gQCzXC957937IdksJERA5bLzOzp1x6217Y5z1FCRwSwUwI1MAvLFjR701P8ixcISbM8AERow=
X-Gm-Gg: AeBDiev/wumsKNpeO4469YqrYAZzGaicETDekU4+7PcQBfIoGnvn0fiWaSZ9zBowaTl
 e9gjko1Dxyh8e+Ce0HvmB5FMjgFXbNWKXiarz0HHM+36etIkCHq202ljenAFFslFDYAhyTg07z6
 cCS8yyUr/uOWcTcu1bziOFcN2sGOt0rsbaUrCZiDrTUCSKkaiqRKMQbExlxFde2R3guFRnRpnJ7
 umrsAZcjDk3bSP9mg2ikcLd/wQ4GGYXrg6s8KbsifRcr3tysEkuiECtaDRm8K3Kje9osE0ZeRXe
 bUNJ+QsUQYLelDSk28pC0Fe546ENj7YhuhovmUNV2RXqHAxHGMnWgbUZq7ATKeqifyOZPQ2ppHY
 V4jQcNgmZAadNwz+DwWuLV72df+5y8gqIUiYKJ51kdaty6g==
X-Received: by 2002:a17:903:3508:b0:2b2:50e1:f104 with SMTP id
 d9443c01a7336-2b281706efbmr176573405ad.3.1775554282627; 
 Tue, 07 Apr 2026 02:31:22 -0700 (PDT)
X-Received: by 2002:a17:903:3508:b0:2b2:50e1:f104 with SMTP id
 d9443c01a7336-2b281706efbmr176572955ad.3.1775554282039; 
 Tue, 07 Apr 2026 02:31:22 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478bc96sm172888365ad.33.2026.04.07.02.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 02:31:21 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Subject: [PATCH 0/6] qcom: Refactor GPU GX GDSC handling and IFPC behavior
 on A8x GPUs
Date: Tue, 07 Apr 2026 15:00:50 +0530
Message-Id: <20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMrO1GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwMz3fS0Ct3knGzdtMyK1GJdI5NEE0ujpCRzM3MzJaCegqJUsARQS3R
 sbS0AQqIcQV8AAAA=
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA4NyBTYWx0ZWRfX3tU+qFxQK6xu
 2NSyHK3WerBqKSe5gviZuv3qiy7nLkwuuwJOMfwozgh/0J2pW+IVtcGkBmgqPmRYmt51K2sDLg0
 tNTzDnN4wYOLV4wZCj3IWjTFJtk9gqPyEB/9hVEhq/nAc+NmRfMd9r50IBl3qjNVln9A7zQw16t
 bznpRciSwd9eO9Cx5Ajvy60winbOadnVLIf2iLxuNehETbsFDZgt7PTBagSCF+CW+DrAtK9pQAh
 IZI6PgB6BLRYnZOrOgsl13NXDjJDrTrrmYg/vGXHKvgbXbd7uwngZ5/20XUx5+V+BS25Y/Q5svM
 jm04nlzw+41b+numpSoqzfscjPQ80CzjbytHMmHeJTSIv46csplfvD+yEWq5hLBx3CsXopdyYq2
 Ljz4Fj1UHrFhJIkQ94yMESfem9H8szcMh4xHDUSblEVElchuxHaKIT/6Aulk+3Ptooq23uXCeI6
 nDp4XydK5fg7lL6mM3g==
X-Proofpoint-GUID: dv5qmGjCXzPH-lO36HcJI3LsBgLH9mMC
X-Authority-Analysis: v=2.4 cv=XPUAjwhE c=1 sm=1 tr=0 ts=69d4ceeb cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=zYEJGWroTao7pyO8AgkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: dv5qmGjCXzPH-lO36HcJI3LsBgLH9mMC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1011 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070087
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

