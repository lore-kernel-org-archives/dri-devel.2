Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB43606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i8OFDJef;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B0X8/Wn7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF03410E24D;
	Sat, 31 Oct 2026 16:12:27 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8937A10E259
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 16:12:15 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69VD00pY2202668
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 16:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JjGzml6CP74rYN0xa4cDI3KFc9rpRn/MizTXsFxSRL4=; b=i8OFDJefNojLBJ5Y
 s4/Xl2d2/qcXvNPe7KwVRWKy9uRvr5fP5ottuYG0cgOenfKIC2rcshedRembaCwL
 A3jcm0djMdiAQqHYq01HOz/3CCHYcUjaPTXwYkY4bKwbEFzFPPH5goZZR8tqaUmg
 B97arNOYD4mWcFHWJc1tnuDndUwLrN3FFcS8ojZOOC8UkCnS9YPSQh0QM2OvelGC
 iHk8TOVl2Wr+BVKEFD1hYF9Yfw357IuA2y/vCYKxGpPCBQJgGgbktO9OIO8DHxpp
 XM/4LIaFACcfvzSor0IDX7aj7HO2se9uj0S9APbaA9uIzsiDoxLPHeODNQAl2QXc
 zQ3FFw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn5pkhunj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 16:12:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f20addba1so319034085a.1
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 09:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793463134; x=1794067934;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JjGzml6CP74rYN0xa4cDI3KFc9rpRn/MizTXsFxSRL4=;
 b=B0X8/Wn7OYTyd/b5jBa7VgSdpKMX/heswXobFQnXw5ik5G+0jYaGKwB64q3raXxs1Z
 z0YstKFh9EQYTh+iSuXQscTQv0oTAbrO1ShBfllVqFf5beabfX+6aZXhfnXt/kY6mT4J
 MZon6LiYhbxap5H1QmUW9/ZsE4FAmem+22665mnx4Rfzwo6yWQ2RrNVv92wtPjU33dCL
 k+YcGMedrvnmyQF3nqQL0uG6khWTOOKjYkvwF8thsJ21Lfr6BxUcBnILe0GtPQ5zVpIu
 kLz2J09UMcWB9Jfyb+rd1Al1Rv8HN6/u/FJByTKKp1xW1gdSiRLqulIeaBRX8No62DyR
 CLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793463134; x=1794067934;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JjGzml6CP74rYN0xa4cDI3KFc9rpRn/MizTXsFxSRL4=;
 b=SsxeUAjK68qGleL4RlR8vXiSOXAPTQkpFfczPT9fywaWMo7MwAO2XvHptXPvnngRij
 XMCY/5c0DjHeEeCIz4sdiv9chD7PrxabcErCs98vJIvadp5yI3L6e2/rB+ohL7EpO7Zj
 LDNAJCEBmrn+yNEifZpUMaLDsUFQa0QNPklJcLiBHjGfrZ2QXuYL7MQCBcVRKiOG0Lrj
 drZ2U1MikkcSqwh9qoCCb0I9NGULPgmsX9+vHEB9NOyvUfhkLUfwJFmrnRHrgHPeO7OG
 yxhxuE1vaTySZ/et1ybM5wXbfpVBxWGf5+6ZXaeOyLCDXNCReefuxryPotj3XpPdjyk3
 /1uQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcURdJnO0k5ds41xF45z+5Xfsv0BsjO5Luls/NjCZGXKEFQaf7CCfTbodDhObNDD1E8LB002bvsrc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLaGXUdEN6mSWRnTYSRSijrsi9u0b+NHsEOW4MG72ognywb256I
 VKu5R/eVwxiDW3tgCWwcBro/C0VtUnuRM7F37H6IhnKEeWHrtbYFyya74gvGgZ0C7cQmixdNrod
 pJGzRUY9uV/5oR811LnJ5+sNe721osKGqdFNgOwdxvMyYm51qMjZ9ZVXMACJvSLdfOhBpm9o=
X-Gm-Gg: AYBFou3IYDOW8Udz/KrtuinF8EkgDfaAh7WT31bw5mtb+iXAB8fAWJGsGb8AKiwVyvV
 Y5JB4TXz9wpNPeeabYC+ySM68mrpuTNZqicf94m3Bf6mXJlXb1Y8MV8XEDMSYUYLoAbUDqvvLBs
 FcQrHO5iqjZjwk+uy7FIQ0eUbs5apqudCI7XoAhSX96W3KK+TCbHyGCz/japZmeQ8WYyac/8iL8
 gO8qDITBOoD77QpJ/WfDIwyuNL8MYUR7ZGf0VOzvSYMX8jzsL1w2VTaIfsKQUBJX2P5T9oZJOZQ
 g+VIR6t8CNmMYvh9OpBmzPC0aqQcyiv4tEG+if1Ei5/qqtxvN7y8WlaR/GV/va4k4KVHmC0R1tw
 43Il5PfxeCO6zJCY1nqfQg01ihtR4+a6GQbdUKckdszQVPzrKOxD0mZjR8Z+AZm7hGnq/LinVPO
 hG0uoXdl+lLGxdBXB0pDGiSbeNbdhQY56xAnKXmQBZPPG5+bb4A+LqndZB04J3wQ==
X-Received: by 2002:a05:620a:460f:b0:93f:22af:cce7 with SMTP id
 af79cd13be357-94421585456mr894490785a.12.1793463133603; 
 Sat, 31 Oct 2026 09:12:13 -0700 (PDT)
X-Received: by 2002:a05:620a:460f:b0:93f:22af:cce7 with SMTP id
 af79cd13be357-94421585456mr894485185a.12.1793463132921; 
 Sat, 31 Oct 2026 09:12:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe0720e3csm666666e87.28.2026.10.31.09.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 09:12:11 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 18:11:52 +0200
Subject: [PATCH v2 2/4] drm/msm/adreno: add a timestamp offset for counters
 that restart
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-b4-adreno-timestamp-v2-2-0836856b228f@oss.qualcomm.com>
References: <20261031-b4-adreno-timestamp-v2-0-0836856b228f@oss.qualcomm.com>
In-Reply-To: <20261031-b4-adreno-timestamp-v2-0-0836856b228f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6447;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=pgt0edGfcerXO7fdC4IZjk994ujodfRoNGPFKDlJzNU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq5hNQfNyiirMtKyxGYRZr4lea+TqW6fLQuZdHU
 3ae5kqCsq6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCauYTUAAKCRCLPIo+Aiko
 1Va/B/0RYec27l6YHQswUMqvdClNOpO3EVfW6L3XHWtMBkYb6kTm2R7/ykZXPtKKb4247BwJggU
 zasUkwGqdGzmZ68r2xD2VOEFoeIbXU7bNwzte+X9bzwrsfPU+0ZU88nTRxwRwIbI+gSpeK0JgyR
 7fQIiJ8rIVC5xmDxGmtRgDCuiKTRLwirEaz+RqxUmpRQVokg7kJS24VZvKKO04XrsxIgS9hHsUV
 wGXiX+SRLK998PDFpy1hKl7HggKhaM72TymUt6H/JrCKbrvWj1kfpjwR1Uer5UN0enKOmvpcyZJ
 MUDUlr8GFz5zE5XTAXmOHSBVTYdf7exH7TGMBkKdewGODs9D
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: T6J6v559I4j8dXdDIX6a7MO9HJmOszz-
X-Authority-Analysis: v=2.4 cv=Z4F5j3RA c=1 sm=1 tr=0 ts=6ae6135e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=0rTI16qmik2F_lPQQP8A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA2MyBTYWx0ZWRfX92Frdi9fYwBj
 lYM5cBbDwfEw0FweMbY3B5XglFT6EZY7taeTu7q94k4q4P7QuzM9C26rIHvpNBOLayYEwwOOU+z
 SNGRG65pEMsbqVOBvCAIRI1XuJpYwYI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA2MyBTYWx0ZWRfX+ssZllPMkERE
 iR7goWPn/B9Yeg9VJ1Ne2R6fYLau1XclvgVsN6fSwuC4micfO94gEVeQb12pS7Y9AhmWYr4mtVr
 yCL2xLEU6wyhh4NJGC6isfrHEwLzTAQZDL1jWjPNIA5FiOltrStmT/8psP0gGjBza3qaECnlM9y
 Pb0qH9ok/N2amkkTN7dlUvDNWq69AOkqV3aRFagJDCDRjkrh5mvSaPDlqCdA8DrWVnAnfnsQ912
 buyBJruVNGqfcecsU16p/J5f8HLJCqkoUgiQWOWyrwjfpPRG3cswl91ak7oF8ZAx2A6swwXlc8Q
 te7iNP76KLM3MlgPoeIqUfBkz4UqhQANsxVmtetkO/gpCp2/+QrSKbjS1u/mTklZSLY0Vbx/E2m
 BtPBSH9/xVG6sZALzWX77M1yYh+MEkalO9KbrLJAXPyo0bp/DkO8bp5hwjocYOCFXDIVI61OjiZ
 sD3A89Upwy29nbvCNHg==
X-Proofpoint-ORIG-GUID: T6J6v559I4j8dXdDIX6a7MO9HJmOszz-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310063
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Before a750, the always-on counter behind MSM_PARAM_TIMESTAMP, which the
GPU also writes for its own timestamps, restarts whenever the GPU powers
up, so timestamps go backwards across a runtime suspend. The counter
can't be written back, and adding an offset to MSM_PARAM_TIMESTAMP alone
breaks its match with the timestamps the GPU writes.

Keep an offset that makes the counter continuous, advancing it by the
CLOCK_MONOTONIC time the counter was stopped, and publish it in the
vdso page so that shaders can add it to the timestamps the GPU writes.
Report the counter with the offset added as the new
MSM_PARAM_TIMESTAMP_MONOTONIC, read under gpu->lock so that recovery
can't move the offset in between. MSM_PARAM_TIMESTAMP stays raw for the
existing userspace. On GPUs where the counter doesn't restart the offset
stays zero, so userspace can take the same path everywhere.

Nothing calls the save and restore yet, so the offset stays zero.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 63 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 10 ++++++
 include/uapi/drm/msm_drm.h              | 16 +++++++++
 3 files changed, 89 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 0adf56fb9563..f13e54e75dc1 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -226,6 +226,50 @@ adreno_iommu_create_vm(struct msm_gpu *gpu,
 	return vm;
 }
 
+/* The always-on counters tick at 19.2 MHz */
+static u64 adreno_ns_to_ticks(u64 ns)
+{
+	return mul_u64_u32_div(ns, 12, 625);
+}
+
+/* For a GPU whose always-on counter restarts when it powers up */
+void adreno_timestamp_init(struct msm_gpu *gpu)
+{
+	to_adreno_gpu(gpu)->timestamp_restarts = true;
+}
+
+/* Call with the GPU powered, before anything that may restart the counter */
+void adreno_timestamp_save(struct msm_gpu *gpu)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+
+	if (!adreno_gpu->timestamp_restarts || adreno_gpu->timestamp_stopped)
+		return;
+
+	adreno_gpu->timestamp_saved = adreno_gpu->funcs->get_timestamp(gpu);
+	adreno_gpu->timestamp_saved_ns = ktime_get_ns();
+	adreno_gpu->timestamp_stopped = true;
+}
+
+/* Call with the GPU powered, before it runs anything */
+void adreno_timestamp_restore(struct msm_gpu *gpu)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	u64 now, gap;
+
+	if (!adreno_gpu->timestamp_stopped)
+		return;
+
+	now = adreno_gpu->funcs->get_timestamp(gpu);
+	gap = adreno_ns_to_ticks(ktime_get_ns() - adreno_gpu->timestamp_saved_ns);
+	adreno_gpu->timestamp_offset += adreno_gpu->timestamp_saved + gap - now;
+
+	gpu->vdso->timestamp_offset = adreno_gpu->timestamp_offset;
+	wmb();
+
+	adreno_gpu->timestamp_stopped = false;
+}
+
 u64 adreno_private_vm_size(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
@@ -404,6 +448,25 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 			return 0;
 		}
 		return -EINVAL;
+	case MSM_PARAM_TIMESTAMP_MONOTONIC:
+		if (adreno_gpu->funcs->get_timestamp) {
+			int ret;
+
+			/* recovery moves the offset under gpu->lock */
+			ret = mutex_lock_interruptible(&gpu->lock);
+			if (ret)
+				return ret;
+
+			pm_runtime_get_sync(&gpu->pdev->dev);
+			*value = adreno_gpu->timestamp_offset +
+				 adreno_gpu->funcs->get_timestamp(gpu);
+			pm_runtime_put_autosuspend(&gpu->pdev->dev);
+
+			mutex_unlock(&gpu->lock);
+
+			return 0;
+		}
+		return -EINVAL;
 	case MSM_PARAM_VDSO_IOVA:
 		*value = gpu->vdso_iova;
 		return 0;
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 4b2156825bdf..51ef57b536ed 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -209,6 +209,13 @@ struct adreno_gpu {
 	uint16_t speedbin;
 	const struct adreno_gpu_funcs *funcs;
 
+	/* offset that keeps a restarting always-on counter continuous: */
+	bool timestamp_restarts;
+	u64 timestamp_offset;
+	u64 timestamp_saved;
+	u64 timestamp_saved_ns;
+	bool timestamp_stopped;
+
 	struct completion fault_coredump_done;
 
 	/* interesting register offsets to dump: */
@@ -641,6 +648,9 @@ static inline int adreno_is_a850_family(struct adreno_gpu *gpu)
 /* Put vm_start above 32b to catch issues with not setting xyz_BASE_HI */
 #define ADRENO_VM_START 0x100000000ULL
 u64 adreno_private_vm_size(struct msm_gpu *gpu);
+void adreno_timestamp_init(struct msm_gpu *gpu);
+void adreno_timestamp_save(struct msm_gpu *gpu);
+void adreno_timestamp_restore(struct msm_gpu *gpu);
 int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		     uint32_t param, uint64_t *value, uint32_t *len);
 int adreno_set_param(struct msm_gpu *gpu, struct msm_context *ctx,
diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index f8bf48fdc339..2fd185f0ffcc 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -120,6 +120,16 @@ struct drm_msm_timespec {
 #define MSM_PARAM_AQE	     0x17  /* RO */
 #define MSM_PARAM_VDSO_IOVA  0x18  /* RO: GPU address of struct drm_msm_vdso */
 
+/* On GPUs before A750 the always-on counter behind MSM_PARAM_TIMESTAMP
+ * restarts whenever the GPU powers down. The GPU writes the same value as a
+ * timestamp.  MSM_PARAM_TIMESTAMP_MONOTONIC returns the counter with
+ * drm_msm_vdso::timestamp_offset added, resulting in a monotonic timestamp
+ * that most uAPIs require. Shaders can add the same to the timestamps
+ * the GPU writes when required, ending up with the stable counter values.
+ */
+
+#define MSM_PARAM_TIMESTAMP_MONOTONIC 0x19  /* RO */
+
 /* For backwards compat.  The original support for preemption was based on
  * a single ring per priority level so # of priority levels equals the #
  * of rings.  With drm/scheduler providing additional levels of priority,
@@ -134,6 +144,12 @@ struct drm_msm_timespec {
  */
 struct drm_msm_vdso {
 	__u64 flags;
+	/*
+	 * Value added to produce MSM_PARAM_TIMESTAMP_MONOTONIC.
+	 * The offset doesn't change while the GPU executes a submit, and stays
+	 * zero where the counter doesn't restart.
+	 */
+	__u64 timestamp_offset;
 };
 
 struct drm_msm_param {

-- 
2.47.3

