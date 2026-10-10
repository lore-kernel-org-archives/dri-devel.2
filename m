Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D049BCA9EBE
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 13:38:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFE9C10E5AA;
	Sat, 10 Oct 2026 13:38:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="O56HNSyE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CbpNhtJZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8176510E267
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 13:38:32 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ACVJfk606897
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 13:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=kXeit6qoeff5Pm79BGKCnh
 U5l8BDS7L4aPTjGtWaCVM=; b=O56HNSyEDVnUnwvKi5erEg9n+U/2ywhqZgCjuO
 FcOfBL7a3zbeEdTgR+78ipRciP+pEpJ5UvSgAo6OP+ucMzVjJXiTnZaKsLs45n81
 LCXGwSdiw1F4NZUkjZSZr/1RuH1FgZ611yWJqqS66C/dGp2NmZUUQi/K7Xonz1W6
 O8HQJoKQyRWq++LLQlaSGoO+nKU5RnNJffGlcHgilp9K9mZqY05S2OyVPaQG7Zwv
 zR9b32nLFyLBqkv7O4tGk98JVw0gcWaNnH8a3W4JEfIMIii51HmTQg9aUk/ivN+X
 h/INrmSh2IpI8NtgeoUOLRi9YjUQOw9xUIDgyYbQjJ50Nvig==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7deuh34y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 13:38:31 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so1249188eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 06:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791639510; x=1792244310;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kXeit6qoeff5Pm79BGKCnhU5l8BDS7L4aPTjGtWaCVM=;
 b=CbpNhtJZbXCQJGYpiTNsRAYRoI24Z5tSi+hUJjovkG/vBG59zWHig/kqcHqH88UFGO
 qkbG1l10utxjENxMUdTfXYlEPNLCVTIO2zaNlMXQjKaTXcPocisqjuYM/+1NRkN6ghDm
 1GDIRgMysxze3aToIEAEMzkvQRzLDlYC3gtMnEVL0V8WG9CEd6L5JvPnjwmhuQWVg+g8
 9zugDCaMmwEt36Y7noPZjLzyylgeqqNiJ46ZV/C06eFoI+2l0dK6pMMZ5F9kl0CxrLnj
 /np5Gl7eTrOcKfVGzPbs9209x1NrCI1fdbfvABO9CHej3YDq2J7fbr5Ssdo+PrTMLDgd
 p4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791639510; x=1792244310;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kXeit6qoeff5Pm79BGKCnhU5l8BDS7L4aPTjGtWaCVM=;
 b=xd1AdMTsI3R3+Mz64yKvZ7lFfJIL2anLhDr2+1mKcV/jlTbllNrr4LVvAUxgr9Kxah
 imabsYNnCa07J6+b2A+CTpsJXAFeb+mhIE0DwqFQxP2l1wIvBZjXHa4EKAk9XqCnWnV+
 CGZh2xoDSwXnifC9c2R3J8BSt+rz/yzjeCBQisDq1QIlbu0SL5AqhblyqoebMQS5t/zu
 Fg+0xiRN1+6nIWsJ6k2tplcaMzQRYK4x06zHr2ZMjMw3ULzwxmyMa2k6+oi8ptCWHwLn
 aqAoqrM63Zll/FU19FymnQbu16hJF2+OY3ZGXK1tPTxV1ELQ2AP0YcWy+su8NPHg/Mw2
 MQ0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzA0a4cBbRY5PZ5rSOXDWjsyXLDGv+CSp7+WavIbamQ3dhJ6I2ztjY79kK9TKUQKM2OtYHm958QZUs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL1v+goMqsQYpP3zO+R/uoSTug7iavjfyMPlvoZUB+ob78EBUwa
 ZihUve2Snm6lO40OgBFm4P2M8NTmS9yPcgMuwGvrBCbxCXfEaXo40lRcbvnwbYCL4XiI+zd0W8k
 8605qk+vr7Aw6tiBTjAch93Y/FF5sgsS1/siRhkzEgHsuEFogdWA2W062cDO0RSG1wQS7eRPiuD
 spuWY=
X-Gm-Gg: AYBFou1a/z3Aiwdsb0LzouTzXBhVT6xF/iYh+47c7q+PS2pOF3Uk7neIJlzDSaa1pAh
 p6kGielIC5HTIxSWUoyozVhZhHxhu2Z6NAr3HJxy3DCNrLqm/DM27Y0mRl7qim2FNilswtnE5+o
 ADYbyTk1NyfGYe+fPdhwH1lSGpUl6J6cQ6OwqEmLj7TXOQ8MgozTavn+iRQSUQM95Llz1J8y8ie
 eurkVT3G9YL5/lKHYT/TehV3aSz6tG0f53KRH/DMouJ79Xfy9pz0UA/AhsbAHckyolWf3SMfHDG
 6kGeWg9g+ea2ii2Beuoag7be/3lnJekD76vcD8d7bvKJQ4S8zPMheV2/tR5B0wGf+iTlDWxgri8
 MBVoSH0l0YcrjiwXLw8fqMrp42A==
X-Received: by 2002:a05:7301:1442:b0:351:7ebf:210b with SMTP id
 5a478bee46e88-3537e08b08bmr5879787eec.17.1791639509878; 
 Sat, 10 Oct 2026 06:38:29 -0700 (PDT)
X-Received: by 2002:a05:7301:1442:b0:351:7ebf:210b with SMTP id
 5a478bee46e88-3537e08b08bmr5879745eec.17.1791639509052; 
 Sat, 10 Oct 2026 06:38:29 -0700 (PDT)
Received: from hu-mahap-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841579sm15232827eec.4.2026.10.10.06.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 06:38:28 -0700 (PDT)
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: [PATCH 0/4] drm/msm/dpu: fix pipe ordering for source-split planes
Date: Sat, 10 Oct 2026 19:08:20 +0530
Message-Id: <20261010-pipe_order-v1-0-9d8bd29fd78a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMw/ymoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAwNL3YLMgtT4/KKU1CJdC/NEC2NzQ/PEZJNkJaCGgqLUtMwKsGHRsbW
 1APYTD25cAAAA
X-Change-ID: 20261009-pipe_order-87a83717ac4c
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791639504; l=1510;
 i=mahadevan.p@oss.qualcomm.com; s=20250923; h=from:subject:message-id;
 bh=+/FOiGAdA0/Ch5DAKflPF64XRT4LzaHU3EryfBCxt7c=;
 b=eAovf+M6Z/mGAQY0MPkZVpqdKdse630wZTZRfk/l2ybq5iki0zN4kJaWAgzhbiY34bix8HspX
 7NfzCPS73l0CANTCF9V02OpH5SqIt5OmZP8sFY4dREx8f/G8Et+Mf2M
X-Developer-Key: i=mahadevan.p@oss.qualcomm.com; a=ed25519;
 pk=wed9wuAek0VbCYfkANx7ujIG4VY0XfCYrffFKPN2p0Y=
X-Proofpoint-GUID: _4UZzGfUuN7R-jP313Q67swmk_tZkF0k
X-Authority-Analysis: v=2.4 cv=Aud7T+9P c=1 sm=1 tr=0 ts=6aca3fd7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=56ZRaVNax5G-77lkfSYA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA1NCBTYWx0ZWRfXwEOYjPTHkCCx
 EyP7WJrbZxllD1hRg4veUz5smimOPZPfgsEV4JOUEKU4JuSr/ws7cawMKQg8sIi68+CErPD0xCU
 SH69RrMinQmLp2In06l5G4pXJYRJAn8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA1NCBTYWx0ZWRfX+JMqvijNrCjW
 Hc35L+oLLo8pt/TWiY6z8N/qM3CQum6cFrMcD6mtZA+kROAmakBEk5GJ+SBGputVXY3Rmf4lVR8
 XkrYohQJSnud9YwMV1HdiYYDxIN2z61BUxfnvJDoMDbUtc6iuFlmvikqWzq0YJNy4NoryRojEP7
 KiA8DGVH/MMo0r/0dCNvOvWouIyRQb+vW3E+uFLAYqNGB9y48hEEDteCg+lFJ6hnatWJzRdXCDW
 yElBNXZogbiPM67Fa1UEwNnVpAVwwT7iuvtUC+XXsNDDiE7vTi1QhPZhNCIfX4hYrg32Bt0PK4+
 KdlUHbxnuxagU0rK+dGVyO+q1CxGyUL/9Cfqegd4m+zL1zB7fvTk5ldL0SvnLNCyS4l6h5iXe55
 6zVxCTw9MHiM3t3DjwnNJfmLOZEWU1dbp1PZIHBBeYVou2BVP/0G4CTu9b2jaxeO267tYNvq8tS
 et1+WJfS83fpf6mEXNw==
X-Proofpoint-ORIG-GUID: _4UZzGfUuN7R-jP313Q67swmk_tZkF0k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-10_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610100054
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

Virtual planes can use two SSPPs when a plane exceeds the single-pipe
width or clock limit and parallel multirect cannot be used. The pair
can contain different SSPP types, depending on resource availability.

This series handles source split ordering for those pairs:

1. Keep the higher priority SSPP on the left before DPU 5.0.
2. Add the SRC_SPLIT_ORDER operation for DPU 5.0 through 12.x.
3. Program the order from the destination X positions, clearing the bit
   for the left source and sources without a sibling.
4. Add the operation for the DPU 13.x SSPP rectangle banks.

Assisted-by: LLM
Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
---
Mahadevan P (4):
      drm/msm/dpu: keep SSPP priority order for split planes on DPU < 5.0
      drm/msm/dpu: add SSPP op to program the source split order
      drm/msm/dpu: program the source split order for split planes
      drm/msm/dpu: add source split order op for DPU 13.x

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c        | 19 ++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c     | 35 +++++++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h     | 11 ++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp_v13.c | 14 ++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c       |  4 +++
 5 files changed, 83 insertions(+)
---
base-commit: aac26bee2287c88af5be5a5ff96d783b19a28790
change-id: 20261009-pipe_order-87a83717ac4c

Best regards,
-- 
Mahadevan P <mahadevan.p@oss.qualcomm.com>

