Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC7DC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 08:01:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3668110E148;
	Sun,  5 Jul 2026 08:01:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FawQpZ4f";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MqFms3la";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D503D10E148
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 08:00:59 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664NSwKQ064300
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 08:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VzQCh286Vg0S8d0fqoIRZWO4vh9rmDpADQm1Ym6AjIk=; b=FawQpZ4fFI+jiPuK
 vx9c5ybAs1WcfqZtTaPGNDX6Akk81RRfV13sdz6DILVqBgDHkBzM8jTBXDvfDWOw
 4A3yUw7iTUqXUtdYCPY2wXwGxp/8gdPGxAmyR1t0Wez7Bg3Z+0SR+/9NO/RIxPKt
 NEsJebZGJN3l4oOuAWSOklB7ZlFlNV9WEQU+m9/mZ9ZWGHCZVGr/60rGhupFLusB
 F0KGFgTZJGea+9UBdjgKoOlx60c6jkQdfqDXDq3qwf3yRUX7GEdUs0rzWNp3RjtR
 IvV6neX6pnWlD6BpRsLhOeviczNpkzxDf1zL7qOfsewArvRB6OIBzzgRI4Qv49Wt
 4OT3Aw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qhnjm7v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 08:00:58 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3840994b0d2so1319500a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 01:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783238458; x=1783843258;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VzQCh286Vg0S8d0fqoIRZWO4vh9rmDpADQm1Ym6AjIk=;
 b=MqFms3laKlxIEMNjz2fCi4qFSiFSZ2SPfOxEzxrqoeciiKPYbvUxcDPAqlB369hlXF
 Dl9wKc7m/kYZkV7jg0EP25tkW6F8fdWbjzXDdF6unuyGE8j1HGz0CwnlvvsXIlS3aG8F
 sq1G+ivJZwvVBnYPkGDo9C1Pj7Gt0c/DVZJQtw/NfiI0eCKwap2zDolzkdopA9K4B9Jy
 uDXuEjQI2LAwfOwmhe8W78eJwH/thN7bLe1pUzIHln9W/0ePfe1/6yV8sJ7AVspmArFn
 Ybm0WOeOXAtrmK8GnU6NJj0j19goLvXbXxdfJfm7qGu9bcrPgcrC4w5dia6MpEYRMc83
 OZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783238458; x=1783843258;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VzQCh286Vg0S8d0fqoIRZWO4vh9rmDpADQm1Ym6AjIk=;
 b=MAhJ/QoyBn/4ISoGPrjOhwQUGunZx8Wo57XPssFoG5hMaeihEWps0zjwJLKL6QYEs0
 IzAXkIGTI2IZAzRionFdIO0jFyZA7CKQqouvu3kUaOxKKimLq2s5OdKIWHnF9grV8VS8
 MGcPJnbp8cV13bHa7HQEyhI70iMXQBUX8tQuNuyWpXq0baklZSQbkUwo6Z90LVpRzTdt
 opCxMdav5BbgucQVsVo42Da3o99RuKWzj1Zxf3PK2Uyp6cniKrsTzumgmtFsERr7o/J6
 RdU+4ET/atKxKXSPn2WD1hxwXayHUQEUCeceudi/ARAEynRD88rq+SC1GI4QZgI//yn+
 KwuA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFmH45HMKXVqurQtMrov4m7iOC1t6tbkCYwprW/qg1q/E7w/iNgDL9yP2Rd+IZ/nK/dNHUTqD2F/o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgndnZLtXGd4maxm2UjWQG6ikEkOXyKamJ3IHNpyyUEx0rkVnx
 4bzPUypkWm55DnhEuHTxjUNEib9NOTDbuPvfa8/RkCaKG/cXDKIEKMpf3AqUnSRN8UXXeNXdfY+
 5SeGUtiyCt+FD72HuAZ58njbfDZ9p4KWI0+YBsX/VOBM5DVfrDVFn5sNvJam2UAaUsGNp0Js=
X-Gm-Gg: AfdE7clyrM70PJXd5LIqgs5Gav5Q0On/830XqjnQB/7YuE41pPg+kB45C4PHilUcUkE
 EcK6znz/JaPusKHdCCpb1HpA0bUW3Xm+PxtYGrHzt2DBIppAMuaaVyGtU1bhN1D1Ug9FRO/5WzF
 SKiS8m7wPIEMArMeSqYEIcX+NKJ1PMwzAdJZ+5IdiQkZFqSk7Q8JzhfGQernzVj6xY+H8j2fKM7
 ew5iHVNKdgDuW1+hbw+oxIgwkcp2vc+DRWkBoyDS6WlGFoV6HSXKxxXNsSzypgNbUEBq5StBTpk
 XH59PX9itaL9Pn9M9eFPOKxRsLkNnYw71p+8DVtNbICiXx1xbzb1otpL67fWXNrQJDmCx6aW7U/
 XrxPl/JrzefAVm8mxDNkPnwgWTV0DzCrYCUI=
X-Received: by 2002:a17:90b:4ecd:b0:380:86d8:8162 with SMTP id
 98e67ed59e1d1-3811238f60fmr10862389a91.18.1783238457616; 
 Sun, 05 Jul 2026 01:00:57 -0700 (PDT)
X-Received: by 2002:a17:90b:4ecd:b0:380:86d8:8162 with SMTP id
 98e67ed59e1d1-3811238f60fmr10862324a91.18.1783238456864; 
 Sun, 05 Jul 2026 01:00:56 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3113c88041fsm7759179eec.15.2026.07.05.01.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 01:00:56 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:30:05 +0530
Subject: [PATCH v2 1/8] drm/msm/a6xx: Increase HFI GX perf level limit to
 24
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-kaana-gpu-dt-v2-1-6ac53de56314@oss.qualcomm.com>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
In-Reply-To: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783238440; l=1999;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=3Byd2iwGy8nbSKXVCEt6BL7u6F87e2rKPSvibHz74Wg=;
 b=tw/H1MbksYZS+PlUsCOdhIVPmvoITEFmuWZhx/fspqQLWZq2Uz+hdMwK37lq55MF8qglQRsta
 7jMqHdoWGJLBZrYt67Ukusw7TuMk9Jvgcz0QFBu7VPGvZi2gEF1f0ry
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfX9T1RTXTUI1iT
 ywwG2M554h5J9vxX3GJPDna+xXcEIQm6B4VMf0GsavilmawpnCbmjy7HLg+TNp/8sR3CC//bDGi
 8glxX/BillGzQJU2AldSCMDz9zRT4xA=
X-Proofpoint-ORIG-GUID: RyrVPYYeY6uzSqQ4Suh64pn5ATBjctiz
X-Authority-Analysis: v=2.4 cv=J+yaKgnS c=1 sm=1 tr=0 ts=6a4a0f3a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=bjN1K8ZYlNTK_pBii84A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfX1l+/HCk0N6Zj
 nscc3w50VbfbL+U9kSaGyl39r/T7bU4yzB8WBO0H9X15iI3xy+ZNebWTehIqFMTdiJuewhgag0h
 shdcaZYj7WCwEi8/zzkd/U+HUnqdiF4cWvggdlN45InA2ArDJBca/JYWdqPaPvD2dEKwQ3J9QDb
 kpf+gNKzqver4nKRG/gktFgV1jjI+OuT2YL2Qe4m4PXjAe8HdydQl2BIYCFGba8Ndva9HygIWkx
 KzIjyx2rrBO7Sh/h1CoKQ9muEvdBZHdCqNL9V7URqqHFcDtTwlsIYrOY4+TdXuL5igN0hoMuZCV
 i0Vlx2EWROkwQlp45joLANGIx0b4LqQCXUozh2QfnUTfLJaDM4JEcLMQq1+b4va73g2vn2B3a1F
 LBUOHiPVDsCeDwa566SkTM9xHo4o/Czkk91xb7V4S7Y/rJyyJn9vgezSgMip2lQJkshvATlrkBM
 puYFiZhFjYsAB0ScXuQ==
X-Proofpoint-GUID: RyrVPYYeY6uzSqQ4Suh64pn5ATBjctiz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050081
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

Newer Adreno GPUs expose more than 16 GX frequency levels. Introduce
HFI_MAX_GX_LEVELS and use it to size the perf-table and bandwidth-table
GX vote arrays, and to derive GMU_MAX_GX_FREQS, so these levels are not
truncated.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h | 2 +-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index 3f96b10b5f61..62e3fb230cd3 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -20,7 +20,7 @@ struct a6xx_gmu_bo {
 	u64 iova;
 };
 
-#define GMU_MAX_GX_FREQS	32
+#define GMU_MAX_GX_FREQS	HFI_MAX_GX_LEVELS
 #define GMU_MAX_CX_FREQS	6
 #define GMU_MAX_BCMS		3
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
index e10d32ce93e0..f4da73a555c6 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
@@ -5,6 +5,7 @@
 #define _A6XX_HFI_H_
 
 #define HFI_MAX_QUEUES 3
+#define HFI_MAX_GX_LEVELS 24
 
 struct a6xx_hfi_queue_table_header {
 	u32 version;
@@ -119,7 +120,7 @@ struct a6xx_hfi_msg_perf_table_v1 {
 	u32 num_gpu_levels;
 	u32 num_gmu_levels;
 
-	struct perf_level gx_votes[16];
+	struct perf_level gx_votes[HFI_MAX_GX_LEVELS];
 	struct perf_level cx_votes[4];
 } __packed;
 
@@ -128,7 +129,7 @@ struct a6xx_hfi_msg_perf_table {
 	u32 num_gpu_levels;
 	u32 num_gmu_levels;
 
-	struct perf_gx_level gx_votes[16];
+	struct perf_gx_level gx_votes[HFI_MAX_GX_LEVELS];
 	struct perf_level cx_votes[4];
 } __packed;
 
@@ -144,7 +145,7 @@ struct a6xx_hfi_msg_bw_table {
 	u32 cnoc_cmds_addrs[6];
 	u32 cnoc_cmds_data[2][6];
 	u32 ddr_cmds_addrs[8];
-	u32 ddr_cmds_data[16][8];
+	u32 ddr_cmds_data[HFI_MAX_GX_LEVELS][8];
 } __packed;
 
 #define HFI_H2F_MSG_TEST 5

-- 
2.54.0

