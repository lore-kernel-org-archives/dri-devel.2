Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387C9F483F3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8543710E41A;
	Mon, 23 Mar 2026 20:13:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hb3eSMNd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qdbj0hjX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFF4F10E3D2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:02 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqXd72831820
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vuW6AnATRy0mNRNmrdAu80AS+AJJl14JYp6IvrFFHNQ=; b=hb3eSMNd5wSMQ6e+
 EqNiSySNyqMOI7bazhzRGQCNqSYl8WNOUBgNRs1BAxePQvqO0s6cMCGBVbJ/mOhL
 UR0VZGjVYzaFSseWhchzDnXfXPvkQF4k2rEKJAITTCYmuEhX9Rs5dLaf7qDBoEsN
 4YE7pg90XtHwufOTAnG384F6ZgC3Iv7MeLp0FZ9SPih6qECJmA0ymOuPjYn8tP8z
 /elByFWpjNkRiMX9JTCPccYnIYcBJx2/GFKAZpDcn4TTdWXi+tiSVR0p0dSeHPU5
 jKVVXvYP3RhXD305DTU0lxhiNTgMjbqd24heCr872QEJrq+skCy4Yce5r5/Gy0cX
 ZwYxgQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d364jsgkc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:02 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82c38b85ca2so1494141b3a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 13:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774296782; x=1774901582;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vuW6AnATRy0mNRNmrdAu80AS+AJJl14JYp6IvrFFHNQ=;
 b=Qdbj0hjX+yIHjTz0jEjulls1hS7qnok/aCvIosb8ICnRrtzOPTKuxKHwoJw6jgbTkN
 N9aQWB6KZIY7YuuyH13y4P3tioCX3IeAO1rg7K1O2kUZ601P96CPx7j/ITR5fNSn13N8
 vfx20D4bW+g1cHws7BpIZBCeT9bsCAoATdlFR3z50ZM7lV1Im3ILAtqxs+S9vguOx59t
 h+GB/kUHcx4/o+0Bue0au3OYLhheXkPYUTHHxEFTk0QwPErtWefwZ2KJlmGQzuSMyv9C
 Tuk/tvBifPksxmo1kc1TthNOfMGIQcweBiqRoTl/miXGI2FnTVouWuJIUW41MtCf/7kQ
 /kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774296782; x=1774901582;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vuW6AnATRy0mNRNmrdAu80AS+AJJl14JYp6IvrFFHNQ=;
 b=jLA6FSPMVG1xMBB73Pha8zIJZC78458Iw9HVGZeMTPjIi65kA1DGMFlSV2NVnY57fS
 gksCNSbrCGXCC1+4qW0sG2k52DQVqsp3a4jdLT/lbieehPgcxrUBlFKNORFg+Wo5ljyL
 rku1UxK3uU4zALc1XfUf+Dn3vM9gqC21ho346vRQT8MVJBd/NCZhjszvbXZM6cdT+6Wc
 T9ZsO/kEpy4eiWJiKSbsdQStpAxQ03GbC4SgyenTXHrJ4q8M90RUO8cD+aThzAwUvQ1/
 HNC3R1xfy4nIZV/2o5Fg10Li5pxz4sBsfYgA6FBlWlhLkbEHYONhuwO8k+O/xB5NhjX4
 1/fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURD3p0RyIVddhkiNJOJFdXBgPYyAxoadZPLTLM6p1T62GWZ7FQ7IYrA0/QFTo024Zwr+U3IwbJNYc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzImLAcZW1acBVSmJkG1f3NvwGfrwzN12ZrHqpeAF8F8kphT3e3
 4dQY2n+3mpFZcMoUHXngbmZYWXQ/p/JyhbMHcyxY5gnv66WyZs86endpZp9XIxoFtmrMD2aW9Tm
 o/pqHfV0Ei8A3G5CCXWFPNaZ9MgguiO3NF/xbPKnqkjpgLfe9OFgxlCyDs06BPgHJYc82H30=
X-Gm-Gg: ATEYQzznIGYiEbxVoZcx/BZvtKlN/EUE71p8fbwdWw39Yg346a8xBMUubYSbEEj0hk9
 zrXeW3U7ybqDjg1jEbH1+6fHT0/8L3ZsYp+Tz+SCC0BorGndt1JUlSOrvGMPYrZO+FEptiiEwUv
 KuzcGnhVy6foeWdGZRw/D9wBwQW0W824j49iw1wQ5k0Zh6L0g1yxbhYp7KxbeXt6pmiJl2RZ1lj
 7u2gysR8kbqjf4cbFVnTvGKpL7ln5JCKRhDYQrQiis8StFJPhw8cqSGFB8M49I2Mc+V4VY3wDSu
 kLbl8dsQtcxJ5wFf0fTGZlqNbKgRLtVzqZQElcDYTBV0AeZZqPgVqXQGWDGORWLi7kMob4gTSWX
 EOvOO12gxQxxMJKDHGjJDkHTdxpxtnXwtFsp1oxjiA66HQw==
X-Received: by 2002:a05:6a00:4288:b0:81e:7496:f826 with SMTP id
 d2e1a72fcca58-82a8c302094mr11008574b3a.31.1774296781764; 
 Mon, 23 Mar 2026 13:13:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:4288:b0:81e:7496:f826 with SMTP id
 d2e1a72fcca58-82a8c302094mr11008547b3a.31.1774296781278; 
 Mon, 23 Mar 2026 13:13:01 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0409d148sm9510738b3a.29.2026.03.23.13.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:13:00 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 01:42:16 +0530
Subject: [PATCH 04/16] drm/msm/a6xx: Add support for Debug HFI Q
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-a8xx-gpu-batch2-v1-4-fc95b8d9c017@oss.qualcomm.com>
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774296753; l=3294;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=sELChCEzxCGR2Lu27U9noN48qPqz/NrmLFJdIRsmNH8=;
 b=QRQiVhG4a4bfTyTLpWD25BEfUelIPhhcz/p6tq30dvKOuPYxKYBHwauVgKxvptrDrGtCNHFGA
 Pu3HSHbAmbHDjw+o2kFeXCyyLk1vAPhXYiw9VIaaOCacIhIu6dHRDSd
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: IzU4n4QlreMiAXHH-Q94GPc0ohHXqofr
X-Proofpoint-ORIG-GUID: IzU4n4QlreMiAXHH-Q94GPc0ohHXqofr
X-Authority-Analysis: v=2.4 cv=JcaxbEKV c=1 sm=1 tr=0 ts=69c19ece cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=a1WYpzXZzT6O6UdPSaAA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0OSBTYWx0ZWRfX53uhR2NTuu9J
 pi8uobTGlKC8gS0/xsT3jRxFeyEHElLYAtdnnw84q5D6NG/CITz6nxiLwShY0mEVBYx6O2hgfMX
 MnBuqUa8sxdurmSBeQrACru1MjAiX0XdDETwMNX3zRkN994yXH2YftGepmBLH+IFSNjOEZn8SpE
 x3UlS5ZWYUzRcqxOstAFYhUwgQPKLs7Tj53C3w8+uP7oMQ7BMYXqw3ZvNzeW9JSGmhfkxY2yvrk
 fEcAzbiQ7TMlPi5FRgx6xA7jHKswIB9m4JrgMGbTJVpq8VberFYbKs4fRilygi4N+XpNOVX3C8Z
 I7FN4Fw2eoE2ifPPBX5O227kx/8brKPcaDTegLsw5BYYu7qioWkATNALIA2gC35Uy3HA2bdGcFF
 Iy2gUUV2gBlpsysgSi+h9wMhmN3C3nQ0XoJazZczEPRUWf0GdUCOUQFrR7EN2UzoBTQ5rf7zG0Y
 YdOvJd/UwHmc/9RY4wA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230149
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

Add the Debug HFI Queue which contains the F2H messages posted from the
GMU firmware. Having this data in coredump is useful to debug firmware
issues.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h       |  2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |  2 +-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c       | 16 +++++++++++++---
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h       |  2 ++
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index 2af074c8e8cf..dd0614b19aac 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -110,7 +110,7 @@ struct a6xx_gmu {
 
 	unsigned long freq;
 
-	struct a6xx_hfi_queue queues[2];
+	struct a6xx_hfi_queue queues[HFI_MAX_QUEUES];
 
 	bool initialized;
 	bool hung;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index d2d6b2fd3cba..018c164ad980 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -57,7 +57,7 @@ struct a6xx_gpu_state {
 	struct msm_gpu_state_bo *gmu_hfi;
 	struct msm_gpu_state_bo *gmu_debug;
 
-	s32 hfi_queue_history[2][HFI_HISTORY_SZ];
+	s32 hfi_queue_history[HFI_MAX_QUEUES][HFI_HISTORY_SZ];
 
 	struct list_head objs;
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index 53cfdf4e6c34..2daaa340366d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -1056,8 +1056,8 @@ void a6xx_hfi_init(struct a6xx_gmu *gmu)
 	struct a6xx_gmu_bo *hfi = &gmu->hfi;
 	struct a6xx_hfi_queue_table_header *table = hfi->virt;
 	struct a6xx_hfi_queue_header *headers = hfi->virt + sizeof(*table);
+	int table_size, idx;
 	u64 offset;
-	int table_size;
 
 	/*
 	 * The table size is the size of the table header plus all of the queue
@@ -1076,12 +1076,22 @@ void a6xx_hfi_init(struct a6xx_gmu *gmu)
 	table->active_queues = ARRAY_SIZE(gmu->queues);
 
 	/* Command queue */
+	idx = 0;
 	offset = SZ_4K;
-	a6xx_hfi_queue_init(&gmu->queues[0], &headers[0], hfi->virt + offset,
+	a6xx_hfi_queue_init(&gmu->queues[idx], &headers[idx], hfi->virt + offset,
 		hfi->iova + offset, 0);
 
 	/* GMU response queue */
+	idx++;
 	offset += SZ_4K;
-	a6xx_hfi_queue_init(&gmu->queues[1], &headers[1], hfi->virt + offset,
+	a6xx_hfi_queue_init(&gmu->queues[idx], &headers[idx], hfi->virt + offset,
 		hfi->iova + offset, gmu->legacy ? 4 : 1);
+
+	/* GMU Debug queue */
+	idx++;
+	offset += SZ_4K;
+	a6xx_hfi_queue_init(&gmu->queues[idx], &headers[idx], hfi->virt + offset,
+		hfi->iova + offset, gmu->legacy ? 5 : 2);
+
+	WARN_ON(idx >= HFI_MAX_QUEUES);
 }
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
index 6f9f74a0bc85..19f6eca2c8c9 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
@@ -4,6 +4,8 @@
 #ifndef _A6XX_HFI_H_
 #define _A6XX_HFI_H_
 
+#define HFI_MAX_QUEUES 3
+
 struct a6xx_hfi_queue_table_header {
 	u32 version;
 	u32 size;		/* Size of the queue table in dwords */

-- 
2.51.0

