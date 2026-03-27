Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F361F10AB82D
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 00:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6219210E20C;
	Fri, 27 Mar 2026 00:15:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="H8Uz+LSZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gn0IlQdW";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4EEC10EB0D
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:14 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62R0BgkJ790018
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CpT/EooedCDv5+FigI376so7QARJ90o8abqnkH5Y1Ho=; b=H8Uz+LSZ0hFcCP2C
 wcjvhzYB2tQguhvM31D7SyMDslS/aX4YB/8VJ7G7tFCRJiKANeHPpwA8n72MLn2L
 wJc6lFu+DvBUr4w4uLk/QlR9pv5IzNvEPfC7UZt/jeW37mr6eG+6mdkgw/4HsTVp
 bZN8mW/RwCNKqyqvl0cOOc3ZcrZByPgPTAGdHOKkhtE1g+aOS0Ux+ruqxnsnD3Mk
 ScqlAzyoUoxxL1g7gH3NqKuQmSk4AErjxC/UxHBWl737UpY4qhuAbLhX2SiEVAav
 DiGQpZE7td/jHu510cA9BBzfh7XJvdNAcyAeHREVU8kebf0mAXP1qhLZrJYLGOdd
 aABLvQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d53eqjhnu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:14 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35c10c2d890so2254259a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774570514; x=1775175314;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CpT/EooedCDv5+FigI376so7QARJ90o8abqnkH5Y1Ho=;
 b=Gn0IlQdWGJ+Jra4jqh/UkRbdAa9PHHhBXFkO7xBrxyi3i4AtEIs/Ljc+YueD6s13Qi
 LEchOHfM4bmUwCqZOzYG+LndYAbWCX3q8K8+s4jeeMXGqZvanayuAuwzqec3hCZ7GJXc
 NJ58vVforbv9WxtPN+nTH9GpoSQCMcr1kujf0Kp3mB3FgCumX8KUu5cB1sS8ZvyuhIEq
 gstmqxgVGmKJ1uy9cvDX3PbmhWCB29X4HpWwDMJJ4usPWAMkHG0MfA2Cfgp0viVmSGsZ
 3Kb78rWirRlRHRqBSwr/eM3BuuW+rcVxu8sxf3sCIrUHBgvtiACuZE74cPUwiXgY4Az6
 H4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774570514; x=1775175314;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CpT/EooedCDv5+FigI376so7QARJ90o8abqnkH5Y1Ho=;
 b=Ph8HK3qPO43Wr1FHi+AdiNTX+buSdVhGn2HlIkW5EasJSlkKYLPhSFMzmAchwt+p3v
 8GG6QRYRFLbPCPrkk2VPoNXIAwBBXZKJnauQwH4aun7+Qf+Z/OJAADWxJsXTYV08jYfz
 JuWPgCL/f/AgnwsOf0d3oDf0TFf6HQpmfFGMt3IoVmoJJ1C848FSCPS07VhFcmChVeOb
 0NX3Ohp3lzcv2720PXin7XCijJGIkv1AzGff0U/DV1A3WlSfjjgC4jVXeww9j/zSCVRJ
 hkMOyQP2oqGI8yMZ8wPLziAA6w/4rjulKLvz90DCCGsb7+zDeJVGi1ItIxXw/mMKxVj+
 Ct2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAQtw1PzlqcqmgWUZMaSxVfzVs5fSLSrXL6oxCzyZ39nY3w5g2f94Tii0OhTAdL960WenEpRoeRa0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTe8LYadflqwUOYSFiiWgLKLgGiDqfIMXCe3Sx3l9vs/rGwKad
 MmKRfw2RHhD2nm5MUm1ZpClnGpedUMGwaYz8S3pVYN7epzgr6DuQ4U9gkT7GQ1J6SO3O8IDTF96
 QLQkS6n4RNb3qkQaglQybukJXk1VtGxcEWwRUd1/sGECCGEmjfzivskJdkFAulZmyFNXur7I=
X-Gm-Gg: ATEYQzwSVrDFIKKIMaK6dgkVI/7jGInQ0N1zcdHkmwxlp+p5O2ETfHMwM9AafpOFsJe
 zAKWBmg2lM4JHbeP2bmFT9OWAzlsraphzfTwwHrfpHXO5cd6lRv3FTtBrT2YayUZ3+4X9imncFr
 SNrmN+6FHpdk9LrIBbmhfkoPMar+eWky3fw4T/FYTYLr9W0eAFSWR1sFrTtK0z36Up1RjJRlMDK
 JQrw95oMwJ3aonLtX4ljzJqenLa8RGJ0/1AKN1VWuZIi8MwDnbIvjmWLhMqTIgwPqTTJd9vlIwx
 FZ++8vv5awLmkuCTOpNdnZLzfDiZaULQbzsHytyU3D21rs+u9yn2a4oyfY0SR2nrdLme+GTf0C5
 m4+zeZ8fLdgcyjg6AS8Hgon8pqoX5d6JEMJL+vwnABzK4SA==
X-Received: by 2002:a17:90b:3f4f:b0:35b:e844:3bd with SMTP id
 98e67ed59e1d1-35c30124eb5mr454884a91.31.1774570513660; 
 Thu, 26 Mar 2026 17:15:13 -0700 (PDT)
X-Received: by 2002:a17:90b:3f4f:b0:35b:e844:3bd with SMTP id
 98e67ed59e1d1-35c30124eb5mr454842a91.31.1774570513061; 
 Thu, 26 Mar 2026 17:15:13 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c2ec799eesm163155a91.10.2026.03.26.17.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 17:15:12 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 05:43:56 +0530
Subject: [PATCH v2 07/17] drm/msm/a6xx: Add support for Debug HFI Q
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-a8xx-gpu-batch2-v2-7-2b53c38d2101@oss.qualcomm.com>
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
In-Reply-To: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774570466; l=3294;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=sxPn3k2wukfo2f3i1QdTe9EbnZ53Hjix+2O94acfs2A=;
 b=YeKnM2v6ry4IWiNiIn1nn8ghwud3UWgHQjMKvhrWwokL4jfoJRlC8nUGt5hPGARhXjSx+b1uQ
 Qbu1f5ZunewAI12ln09UT5rw81I7vli0/ZaW9iPsY0dHjcJSWssPf9O
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAwMCBTYWx0ZWRfX52v4WvVQNlE2
 krXlTXnUE560RktiS1CpGf9bjXJlClqXkmD5BhC36kdqoOT9D7iNeksVdIczrgMFvBWaxA+OUON
 iGTaR0wNOAWca0S2Nf1gGwxwrJLEDijgB8PF0sZWvCpXPCJFEY3MfpsOBuUqubX0hozAa0X871K
 K7+TCQ7RDSvGXumlB9/FxEQ/x6vUF6gqSIoyrJN2Ah2buVnsSELf022EPXC+aDVP8SSxCgtesac
 cTaiyqk87fhDgoCa89iWQ6qz+ZT08Gn14M00Yx1aMAV7RwvKzP4Im8pLOxi9lHcSbGPavYVcM3X
 ldtOvS0pYHGGxyhTnKS3KQjzKk60y2CGf5q8+0aQE5eqEBD7y7eyLBAssj9ByGpZ/k26ikLEVmg
 5XScSKzG0/JzA6F1wk7/0MN4Xbjdq/6YZG4P0+5dHffa0UsbQ2CKnR1O20UsEhb7BPcIO1Afbza
 TtQcOzZBFCHWlOnF4Rg==
X-Proofpoint-GUID: SnTopiQak5k_OWBxhzxJR0TnIucXqhYO
X-Authority-Analysis: v=2.4 cv=S4bUAYsP c=1 sm=1 tr=0 ts=69c5cc12 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=a1WYpzXZzT6O6UdPSaAA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: SnTopiQak5k_OWBxhzxJR0TnIucXqhYO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270000
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
index 0cd8ae1b4f5c..3f96b10b5f61 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -111,7 +111,7 @@ struct a6xx_gmu {
 
 	unsigned long freq;
 
-	struct a6xx_hfi_queue queues[2];
+	struct a6xx_hfi_queue queues[HFI_MAX_QUEUES];
 
 	bool initialized;
 	bool hung;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 7bec4e509d2c..c0b9661131e8 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -57,7 +57,7 @@ struct a6xx_gpu_state {
 	struct msm_gpu_state_bo *gmu_hfi;
 	struct msm_gpu_state_bo *gmu_debug;
 
-	s32 hfi_queue_history[2][HFI_HISTORY_SZ];
+	s32 hfi_queue_history[HFI_MAX_QUEUES][HFI_HISTORY_SZ];
 
 	struct list_head objs;
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index 4f5dbf46132b..09b6bc464b47 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -1062,8 +1062,8 @@ void a6xx_hfi_init(struct a6xx_gmu *gmu)
 	struct a6xx_gmu_bo *hfi = &gmu->hfi;
 	struct a6xx_hfi_queue_table_header *table = hfi->virt;
 	struct a6xx_hfi_queue_header *headers = hfi->virt + sizeof(*table);
+	int table_size, idx;
 	u64 offset;
-	int table_size;
 
 	/*
 	 * The table size is the size of the table header plus all of the queue
@@ -1082,12 +1082,22 @@ void a6xx_hfi_init(struct a6xx_gmu *gmu)
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

