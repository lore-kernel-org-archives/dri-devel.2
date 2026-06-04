Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8EBCD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16E4E10E1F2;
	Thu,  4 Jun 2026 20:10:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mn4RYwo3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IHHFsZa9";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A13910E3BF
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:10:07 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654G6t2s1957545
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 20:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=5a1rPumWL5TM1aoArxsrWg
 V7GTojVDnL8YPP4sQcz2M=; b=mn4RYwo37zG2OiPFUmCzdI6DmQKTLKyB7b5qtY
 rvFnPYTrCxwRJy86VwEjYs6lShjMeeiHUJlvSPklxdqb5sH5/6kG4ryLbHnKO57Q
 3bF3/9e5z8quIl1zTT3d3aoDxYB9ctDFv2M4eDgFhLljZ7p3T5DBj0DsVmzpzqGX
 dtJXjxY4xkYb5CVGzLmxOrkjAtKc7ItswxBf3YfEj1PmByIubvTCuGM9mdsKYPOn
 gRhz99+rMZ0zoiwPzGz07hmkU9PR1ogGxbuWWxapY3t1IeR9t/o5G0+VppMSEDUE
 6rEnQWgkWEDGsjxavC1U2UILAAV/JzXyI+1MvLhKxXng+/aw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekckps5dc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 20:10:06 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-842692bf60aso1639566b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 13:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780603805; x=1781208605;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5a1rPumWL5TM1aoArxsrWgV7GTojVDnL8YPP4sQcz2M=;
 b=IHHFsZa9mJ3KsO3mWO6wpJ2F09Mx+SQUwbO5UwZkKnkx54Z2+xXi/YJSlMKy+6vZku
 rpQZ+DcB31+uMTLIap8brP0lk6Y4bwAngwjpPtvUEsGMiN9Mpkt5sxHqzNpxIUOWacVc
 /PEo1wWzp8TXZir7D4cT3oG8xbHIP3lCBsDkgfybX2Z7Kf+JcNy//a0x12Ed3W3HG/R1
 3IJNTnNbF8wHpl4miCAHPeRS2kPYFCoidCj359sObcfMCi0YVtQLiso0NMN4HUiukhr2
 GTIAu6DjYH5+sCMbaLTKcnuO5xbtC5lAf3Xbi15tgsjoPJ6UKBVeY6hoQUVwGWupBVHH
 E/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780603805; x=1781208605;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5a1rPumWL5TM1aoArxsrWgV7GTojVDnL8YPP4sQcz2M=;
 b=qL875OT9Xh4qU1rkg6UfxqsFAv/ZyVGFS5w82O9yUNSnK8ZMJVt9e9eGg3VGB4oPb8
 eEH3RG+UKUtAIZf0YIRYNQtbriZdXKHdmN9YCnPV8PHaFqQJNX06w+rEX914HykGdxXx
 I73+9AexYqp+PgU6lteGEHFritM0tTARzYEKxZjG85Vn7IzWUyC58IZzbfJF2sgENKhw
 pr/WwbWgXUFLC+aMelG5kWaduKiNWAEGZuetyFcxwHrx35sr/z0zqTMHTXFuLTt2XOzl
 UnBISTo3OR7aCwB9D3+uzEScjukQS0YoLFgBghopnGMwcg6unso0M8m0VdfK8rI0cXjo
 pRZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Ey9Cth/xgGhZIbA+dTGG85elZW/DLCKHTC5kzGYH54u2QtOtaewDBn/lEabnmouAerjrWRTQpFsU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwTI4sArNls0Os75aH7BgNyh55KbRNB1URlNC4tXCrPDJLpoZTV
 l/ml2qAYWVLos+XBnsZQQbMLRFaareWQ7JDZmg+N5vl9XUAV+VYWxOPGHGLvs9rXcDIQHvaDS+I
 HUokhaURFQT5r02o2nvAdkH1OAy7GGc7Lv3dGH7hdW6rsrP7Fx1Ozd0CXFjcRc/VbXK8kLto=
X-Gm-Gg: Acq92OE4NmQQIQYbn1GqW6v/8039dMrsho7ZBf0eC2S/aVpzE9SMi68hESEdWQXS70d
 iLWkFjJEhMSw1Vmpvy6QqK+Pqcj+MwkStps9I3FbuxZK3w4sSa12zIxPnfouns7kMQDjTjrQrt/
 vVcfCaKrI6HTTvggDo/mClm7xOnq8RhubL7rXfEE/olIXhvFmuWXge5RTS2O8I4zFj7jlS5nASY
 4AQyZqEHNqyAr9JVUshwga7lBYLEEjuscFoRPfObhS6tW53DqbbiV9VU3/Pu9cC6/cdyxtAnRVN
 NLO5wVN4fZtR9Pwk7NPEqCnGZTfNJnqWE9pkeiHxgfbBnlV64Vd5VgngSBdSalON3XZDPLT3fBW
 u63dKxZVAGc/mc5S0I0rQ2MDwuGO0QuqSL+CGa94If+4Am2AFIBnxP+U5
X-Received: by 2002:a05:6a00:3e05:b0:842:54e8:bdd with SMTP id
 d2e1a72fcca58-842b0fb4de6mr200551b3a.40.1780603805382; 
 Thu, 04 Jun 2026 13:10:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e05:b0:842:54e8:bdd with SMTP id
 d2e1a72fcca58-842b0fb4de6mr200530b3a.40.1780603804935; 
 Thu, 04 Jun 2026 13:10:04 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428290067dsm6721425b3a.53.2026.06.04.13.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 13:10:04 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH 0/6] drm/msm: Assorted fixes - June/26
Date: Fri, 05 Jun 2026 01:38:16 +0530
Message-Id: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADHbIWoC/yWNwQ6CMBBEf4Xs2U0KYhV+xXCodNGatNXdYkgI/
 +4qxzeTN7OCEAcS6KsVmD5BQk4K9aGC8eHSnTB4ZWhMY401J3QimQt5nMJCgs85Edq6a83Ftq4
 7T6Dmi+nfqngddmZ6zzpe9hBuTgjHHGMofeU5YpSIiZaCvyPUn6OBYdu+YJ5IIaAAAAA=
X-Change-ID: 20260605-assorted-fixes-june-61940864a97f
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
 Jie Zhang <quic_jiezh@quicinc.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Shivam Rawat <shivrawa@qti.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780603799; l=1112;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=mW3/AYYOxPahGK1I/u4/xLMfbTUSvBOizXao0/KjA5Q=;
 b=x/KV7wrpPJrdG7YhLxlqebwuNBYoQhC66TqMxQoH+PBy9pXzAmv8gmWDcLPJIGRCBTtIVZnHn
 dcVdLiec1NjCb7XY63lkxUvXjUvedRZratO/IeuWNqdIa8C4V3ZFQSJ
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: aN5Q6b8pR5VfhGzX3Zeuz9YVhRT80A6r
X-Proofpoint-ORIG-GUID: aN5Q6b8pR5VfhGzX3Zeuz9YVhRT80A6r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE5NyBTYWx0ZWRfX6fKOJxCKZaP1
 qDo9k/T40R7xwIGISlhIp5+O1k61DmejNpDwIFqRjNDVS0l4H3X1aZytuL107AhzfWUN9aRD/pJ
 bSCIxDAmecP0TL5MCjWdw0CzShC324jK6G/SRs8WQIacT87t1Ncx/DrEg8iLPE+un3FSIkArZwu
 uNOxUM/TWLOocQsEjPxO34oWCCw5/1UY+FRiK0HpKiVj0rYF69KJIEd++X45gWISfpm9O8gpowj
 4SySth/FMwj2c8ociDb9feIbYDoZ9fNBJEmJt03vinKshXzCDFflaKrZWPCvAyRite3sZSeq7xP
 LTXKp8I2GbivrUnnUsnvb5VHgROdaoUpRd9T+CXn9gwCr5ZCyzAXL8e4N/q4OX6bjWBvDulNkIs
 njXDZGY6M905OeRrH4OYrCvTJw4oYy0PgPVTWFh/S3d06YUvkNjD63nhTUIzC3VVcm+kIWe2WXz
 dy88BdKzwP2DmXs7BhA==
X-Authority-Analysis: v=2.4 cv=H9jrBeYi c=1 sm=1 tr=0 ts=6a21db9e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=5WLGAYDQTmdPK9MYQf4A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040197
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

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Jie Zhang (5):
      drm/msm: Recover HW before retire hung submit
      drm/msm/a6xx: Fix A663 GPUCC register list for state capture
      drm/msm/a6xx: Fix A621 GPUCC register list for state capture
      drm/msm/a6xx: Fix IRQ storm during msm_recovery test
      drm/msm: Fix task_struct reference leak in recover_worker

Shivam Rawat (1):
      drm/msm/a6xx: Fix stale rpmh votes after suspend

 drivers/gpu/drm/msm/adreno/a5xx_gpu.c       |  5 +++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c       |  5 ++++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c       |  5 ++++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |  5 ++++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h | 12 ++++++++++++
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c       |  5 ++++-
 drivers/gpu/drm/msm/msm_gpu.c               |  8 ++++++--
 7 files changed, 39 insertions(+), 6 deletions(-)
---
base-commit: ef8274b9c19a4b614e10ce95553d0d363dc1c1f8
change-id: 20260605-assorted-fixes-june-61940864a97f

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

