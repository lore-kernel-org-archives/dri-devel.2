Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD52C9832A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 23:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C2210E09F;
	Sat, 26 Sep 2026 23:20:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dLfwSxz7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z4pfkojO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2D5010E197
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 23:20:20 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxeoX718444
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 23:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VOZvv3gRAV4Yfr/2IAD8LT6d/JrOTz4oDcixnCJZyHI=; b=dLfwSxz7ICtXvSMz
 NFA/ODbMW9WL2BKDvJe3w7jOwWNJiiGYEEI3xgcadwxNcqOnlf6ciukuz2MpmwgH
 t9eO5n9cLXDqGYghC3jeEW0/X525VB4yTLo0P+o6wo8lBBqvzuYk6lECe+gDUNxi
 HLpraP76CJnlLRJz8Ie2wwr7VtKB2z4xx9AwXU1ZUw2QCsFnxMs8LDef1tMrm7IZ
 mLItYM9nR2EjkRcN47acUT6Q3H9CveyRiEeXXY0odlew9/lQfFX+n+chegwLY8wR
 px+dIkVqDtJtvhUlFdPmChMEzRJB8JJOpolhQUNS+xxaJL75ywg2w0TxBTux7Z1p
 XWfT2g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx526j169-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 23:20:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-530f5e827c6so46659461cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 16:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790464819; x=1791069619;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VOZvv3gRAV4Yfr/2IAD8LT6d/JrOTz4oDcixnCJZyHI=;
 b=Z4pfkojOZLY/ksgApSPZ274NMsl7tcuRdLftWiyCqIDl3R2NSiir7cg5FpeQ6m0art
 qQtCHkX+2+VOfoHey8YZOLDF0koWg/bj02CY9okCEHTcB9cJO7WmhD5+a9ImejAELW2q
 T8gHTAf+qgoISvdgBrFVLElUnarqVtw+Y8vFQ4JnDnzpuov24qRrOlAWOSR+vNvQdOVv
 7W4BtTBcDv1TpUJZKWNq9unFiNiutvg0t/OSZIvgwK8loEgn66C2CI+dJFrtauc0IfCp
 4qBf5pKdKsUWEXc4HZD5hfyX9zjEQR2bzVrw7TDa+Te/5U9PqeVYcgZT6hYdcAnGIxJk
 4j6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790464819; x=1791069619;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VOZvv3gRAV4Yfr/2IAD8LT6d/JrOTz4oDcixnCJZyHI=;
 b=BRRNPMc9g6mO+ytdiHD3B1JdmgwHYbN4KPEUj6HqaWlX2ECmILX07RlZR3bXGnd8cC
 kDFagAgJX7TVxsbTCeEVHLJ/4ZjAcVMGIsRIg05VYFDticxW+i8sr+0e3PEQ0FPUX9eX
 1t2HeOX5jQYGDgqonbxnr0qTNfNoo50NX9dLEAE8aZu39Gg4TyaFm4TKV3MwlRmLYInv
 NQO03Av31wvzxk94e72vqb2RcsqrSAF2LU6Gc1joCL4T8A624GHRoog8GB20REYzQCTt
 L2m5cdGlpWB/BZ4ax9ZXdyABzO5VghV8S/i11czDhuXXd6RgR02ojJgleqy99jLvv+O9
 Hj3g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFQ1Xz8XtJx4IcnHl3KwvE8eT+zFeT5iJOfUaagdpbrYk3BnpzBFZN85J0pSEJWMZos03Mc+brhqM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k8XkVdfc5t8fd0LBd5RRrNf80TaumzEf11zr2BoGzA1f8Kily4
 n/l2Lvoe/0S/GOuZ520wW43iXmzvIXCwW9mV6yR0qyRAnxvJA0zxgGOveB/dyTPkx/rtvrqJn6g
 1X0eUY7kbxeR+w4CPXxCSfTVl6iasgTvx/7pO6J1HbaOMM3guyRiQA0z1+n5UH2nnqKI/ZOo=
X-Gm-Gg: AYBFou171/091JB1LQHFy15QM/SU36Tl2TKfTnbq5Rp8ZOEXqTCVtqVZt74/MdJ3oJh
 zYKl3g5X7xUYCv369ir5m9k8nZTFXJjabrw1GTE3UGlwQ0UOgCj/p/wKKuzBIGFqmR0wA0yaXSj
 HUSX1IQPdMvrZHxVrI3qIP/q9F6knFsSsLMhYbd6PT1f/ehJPGHX2//sbv2efRimKJD2UXcjGm1
 ASKmtKkbgCBkR4+5INJ/Y8PZVuO1e4uTPdf5nBKXefzzGU8llSpcyVBYKM5DDaY3sT3UbziA0E6
 14YsZQSskg34p4DD6YZRWMvJTsTb6uoyLM/EEzCvn2Bp+Fw2wqr6OEsgeuqP5BqLCgEWkJWhfd+
 cBpWbHkGulZ/U0jbnWwGCzy+p4x8cqgb/rzjFMiHe/g6fB3mbBA6iQJE44SVZTSx5YOzmxbNOGJ
 SmMcoUrZIpRo5J
X-Received: by 2002:a05:622a:352:b0:533:2fd7:f08d with SMTP id
 d75a77b69052e-5332fd8038bmr37214571cf.0.1790464818877; 
 Sat, 26 Sep 2026 16:20:18 -0700 (PDT)
X-Received: by 2002:a05:622a:352:b0:533:2fd7:f08d with SMTP id
 d75a77b69052e-5332fd8038bmr37214131cf.0.1790464818446; 
 Sat, 26 Sep 2026 16:20:18 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a64c3274fdsm17676311fa.38.2026.09.26.16.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 16:20:17 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 02:20:08 +0300
Subject: [PATCH 2/2] drm/msm/a5xx: Add hangcheck progress detection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-adreno-progress-v1-2-f0bbbd6a4ac7@oss.qualcomm.com>
References: <20260927-adreno-progress-v1-0-f0bbbd6a4ac7@oss.qualcomm.com>
In-Reply-To: <20260927-adreno-progress-v1-0-f0bbbd6a4ac7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3387;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=5j7e0HkNKk1PCIDPhYgV70i6SghClNSTMPq1qNiKRnY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBquFMq6zURkg8gkftwA3fh/O9DpzaJNwAu7ctDQ
 KfsBOGwbTqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCarhTKgAKCRCLPIo+Aiko
 1ctBB/9SAoqcHxYByDESAHVT1UiBYxzjcx3uQ74nj3TTpFbnfxaXnyihzq1bPsDWUVJUjm7A9BP
 heco26xZAdtJ5yHL+Lk0zahDA3sN+LJBpvlq7Qkx1q+EaqTHhHBmOWTt68+nlRDYGZHhhlgpcIR
 DAgpsn6h/4/tPaVuhdSOF+7aqVSf4isjoC9259Qysxgm5zeNmukNllM0IQredB0sUU/lvWFAqLu
 y3P/2hR7gEjviizA1Qa+Rs+VicZA/NiSz5O+PO/pYC46NEdwDlkqyV5bxMT667orp2GNIvUm7vf
 nsgFYyhcqSRgSBa5m5AUYaiYrdf5YI4ZMNVMs7wOWRhavmoi
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=VvS2kO2n c=1 sm=1 tr=0 ts=6ab85333 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=8wNfRxjPmpLGpMwT6toA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: ybTOj4WWxTdfbwvAOzourimCSUoCbOQP
X-Proofpoint-ORIG-GUID: ybTOj4WWxTdfbwvAOzourimCSUoCbOQP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA5MyBTYWx0ZWRfXzZKZKkLAt9ig
 EmX+lrStJ7TUtxkkJp3jhvBzBL6shAAKuDeksd98T1x2FbAPzulXH/m522dErZHXS8LRawvFbJT
 qKJPyoYfysOwIoDjFq9cNkK3X1UZ51av9wcsynQYd61JQ2wtMExgyTu3kMQn0T7tboMB6bF98U/
 mb/boOyxQG8YqZjccuZjRaD1tUbqhVB2zXInSfxP7RDx3MTrcgxNWyFqJ5267HdN4HJXO3mpPY5
 2kamw3LT7XxJd29NUwwjgPd5OVcp+GIhT7Mti2oOX+W3dLFhlFP0O/XXSU41OkokUNJslTmbuPw
 By5pWDIRkT5D3TjSfVqlK8Rt6VKO/3q33LQTra7ewkAPc+7gwLP4xXoRyF33ORpJ9vADNzRAMtP
 UWhYqJPxMf9NO4xPxmBN0k0Eumrrg8qCNNmE2rhy8uUcr4kD+H9Y1xaLERYj9PpcPqkYzrvSHRK
 MAn9lF0XP6r9RHjm0lA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA5MyBTYWx0ZWRfX1C3sr3pjzoyj
 KgEPwy8Y5tkjgTtHmKEVEDbmqBnDScIkLLypRTx2aq9Gx7OEZQN+BhChuEJJ9iQlpnzXD4In/oJ
 Kpo66tj3A+uSEV1edrn7e/rDbaDxMrg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260093
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

A5xx has no progress callback, so any submit still running when the
hangcheck timer expires is declared hung, and long compute dispatches
such as KHR-GLES31.core.compute_shader.simple-compute-shared_context are
reset on A530 while still making progress.

Comparing the CP IB1/IB2 state, as a3xx and a6xx do, is not enough: during
a long dispatch the CP has fetched the whole IB and waits in one packet.
Also count ALU working cycles on SP performance counter 0, which Mesa
leaves to the kernel (and the kernel hasn't been using up to now).

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 27 +++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 5d96b8f63156..9f4a97195cde 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -748,6 +748,9 @@ static int a5xx_hw_init(struct msm_gpu *gpu)
 	/* Select RBBM0 to countable 6 to get the busy status for devfreq */
 	gpu_write(gpu, REG_A5XX_RBBM_PERFCTR_RBBM_SEL_0, 6);
 
+	/* Select SP0 to count ALU cycles for hangcheck progress detection */
+	gpu_write(gpu, REG_A5XX_SP_PERFCTR_SP_SEL_0, PERF_SP_ALU_WORKING_CYCLES);
+
 	/* Increase VFD cache access so LRZ and other data gets evicted less */
 	gpu_write(gpu, REG_A5XX_UCHE_CACHE_WAYS, 0x02);
 
@@ -1687,6 +1690,29 @@ static uint32_t a5xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	return ring->memptrs->rptr = gpu_read(gpu, REG_A5XX_CP_RB_RPTR);
 }
 
+static bool a5xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a5xx_gpu *a5xx_gpu = to_a5xx_gpu(adreno_gpu);
+	struct msm_cp_state cp_state = {
+		.ib1_base = gpu_read64(gpu, REG_A5XX_CP_IB1_BASE),
+		.ib2_base = gpu_read64(gpu, REG_A5XX_CP_IB2_BASE),
+		.ib1_rem  = gpu_read(gpu, REG_A5XX_CP_IB1_BUFSZ),
+		.ib2_rem  = gpu_read(gpu, REG_A5XX_CP_IB2_BUFSZ),
+	};
+	u64 alu_cycles = gpu_read64(gpu, REG_A5XX_RBBM_PERFCTR_SP_0_LO);
+	bool progress;
+
+	/* The CP can stall on one packet while shaders keep running */
+	progress = !!memcmp(&cp_state, &ring->last_cp_state, sizeof(cp_state)) ||
+		   alu_cycles != a5xx_gpu->last_alu_cycles;
+
+	ring->last_cp_state = cp_state;
+	a5xx_gpu->last_alu_cycles = alu_cycles;
+
+	return progress;
+}
+
 static void check_speed_bin(struct device *dev)
 {
 	struct nvmem_cell *cell;
@@ -1800,6 +1826,7 @@ const struct adreno_gpu_funcs a5xx_gpu_funcs = {
 		.gpu_state_put = a5xx_gpu_state_put,
 		.create_vm = adreno_create_vm,
 		.get_rptr = a5xx_get_rptr,
+		.progress = a5xx_progress,
 	},
 	.init = a5xx_gpu_init,
 	.get_timestamp = a5xx_get_timestamp,
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.h b/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
index 407bb950d350..fb05f1ca3e81 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
@@ -36,6 +36,8 @@ struct a5xx_gpu {
 	uint64_t preempt_iova[MSM_GPU_MAX_RINGS];
 	uint32_t last_seqno[MSM_GPU_MAX_RINGS];
 
+	uint64_t last_alu_cycles;
+
 	atomic_t preempt_state;
 	spinlock_t preempt_start_lock;
 	struct timer_list preempt_timer;

-- 
2.47.3

