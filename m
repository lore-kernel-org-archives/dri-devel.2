Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BD8606A323
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j7MGnNVx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TE0FMMVd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FDE8112A09;
	Fri, 30 Oct 2026 21:21:05 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13803112A09
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:20:24 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULBc4L248815
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bXITc4r/k3g
 IKO9tsd9AinmWdIi6qZi1pki5UqGvEcE=; b=j7MGnNVx5qgAes3sEili6ubx7eE
 RbdJJv51DdjFEZ1WnQseudWzQIe1inlPBOwSFrjZvSXO8r/izuWRlsa93Od4lfRu
 De7TFeYIotWIs0tGLtjdmpBfHmeWSYUk/rMjxU/nGVfJQPOufXVLv14z23BKRlAh
 Kl3dJ4TWGfnTOGSOXO5h1T5XAOd2o46ZYptBcdjds91cnuqbu9B+YnjrgDodxfLl
 j3m2fr1NZkBfoaU2H2yJVDZYHGmHGocEvcpwzfSQ/N7YchbN46sGScpMZk62YWNx
 lpz/UnvnSp9H3a4RMrGiqCOSpD2l/qA+xnAFgx7MxVzpEUQrqRtbBfRixVQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x0g1fw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:20:23 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ab7f1efe5dso1989375a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395222; x=1794000022;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bXITc4r/k3gIKO9tsd9AinmWdIi6qZi1pki5UqGvEcE=;
 b=TE0FMMVdudLefAbVfdNaEBT/xFBdMBOncRsihhjoj9gk9I8QxWJFwsFq12ohBOnhzK
 KQedQCJC/l+flxhdKjhrdGr1FkIfEleoDgq0ioonBIjbS9iFCGg5iA2bMRwYRbpffTay
 SjeV6WCKd8T05Ba4ehWUBVir7tk+K53vV0UfTdpZnwXES5AldhAGh2b3IxGLEg7SU4Kk
 7/xUICaOBeIQDJaXzyMEqQWzQPPFwMioWTCi2L5niBSivuq2k1KlaXVBngxJ/zaD9p4v
 TzzEEUlB6qt+CgMwtkh6k4UDaJmt1V8KDdFj6i/RX1moCffwsm6W30Z2oS/rCOdfONDg
 Y+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395222; x=1794000022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bXITc4r/k3gIKO9tsd9AinmWdIi6qZi1pki5UqGvEcE=;
 b=cRFpiX/i/IPukhzlflrrGeaWkFi3T5jIOmN1xB23WeP8ULMmGibJougHoFEn7C4zgL
 0p9gUvxdSwK1yQmxWX4ez7ilF4pKo74RRDVIazbwmNt98fgtEDPB8X74phL3IcnxF/Hh
 5GTWXsoi3CSN6xoJYl0ksacBK6WaMfMjzJ0OgOrA9a67lqKNNdH4HHZAdKDWZ0viJ7C0
 4BxyqtNzywa9YAs11dLsH14yK6r1SyulhG2Ku9EQbR0qxlxxKOfmi4xXhTLnNyNQZ7Oa
 CrP0kSr80fDZbYLAY8r1y5orO+m78k5jKTzPLrCdXh5ubbkg/EBU8IqH+SCwphB/H3SL
 fVAA==
X-Gm-Message-State: AFq9FYKAo7ZFd+npM8PqfDQwHN97UNkbVOIrsIX/MumRsjbzXZiJ+wFK
 7JaqQM69tP9sRnGVYNubs2DUbJ1TeiirRHtvB2rEvCMzd1zf3/NVNUBqNAqpJ8FoyCb4KzCV2Dn
 HzUQkkhr4hdIHyuOO+w/RRfo5OLcuDnHMvN8Luj+h9mzHphwMQhIDhbfYF907J+A2u+y5YUzPVZ
 K9cLY=
X-Gm-Gg: AYBFou0AoA2hDNDd1WhHvyNmEP4DY6+DQBE4swaS4NCNJlssCCn+tETYTJuQNaWDC0S
 y5ApK8DUoO8Jfpd1WTdgxbXYR+Zkn9i6GrrMmbXrvtlgNAd4vMzuhFG+l7Uia4G+5zoJImyI31R
 IEl/vDg0XurF2tA+XIev9six/0DXf6rjwmQxpK2E4MLrsW7cbuxmaqWAJfUZFDrxbey4pQzZI4C
 Yrv6iLCxKLgr5smjhZLnV8ULlUpouXS+ZaAi1R66ZSq2CHdW16MmP3rRuvcB35TMWPh5X2kQgIS
 R+UFMgiWnH9aytlRiDdyfVynnGim9jkLk+plVeQKbeSZi0kzUGTZ+wOZTnbMTunBdkm4zZhxTWn
 WIVwdf4BsoT18xZSu6btbkT+2dv4E8yBbylY8xEByoSndQR3c+eBv1w+2dcXlHUwQ9PK5PYWxAg
 NsiCHmBGxJmg8XO4EdJ3m68g==
X-Received: by 2002:a17:90b:5703:b0:3ac:aa8d:19ee with SMTP id
 98e67ed59e1d1-3ae8977c3f1mr2933018a91.38.1793395221588; 
 Fri, 30 Oct 2026 14:20:21 -0700 (PDT)
X-Received: by 2002:a17:90b:5703:b0:3ac:aa8d:19ee with SMTP id
 98e67ed59e1d1-3ae8977c3f1mr2932972a91.38.1793395220325; 
 Fri, 30 Oct 2026 14:20:20 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e9583c1sm10518231a91.10.2026.10.30.14.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:20:19 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 15/19] drm/msm/a8xx: devcoredump state capture support
Date: Fri, 30 Oct 2026 14:18:17 -0700
Message-ID: <20261030211928.45761-16-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
References: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2dEmq2eJM_zClGp792lkvMCq9PEujNG_
X-Authority-Analysis: v=2.4 cv=No9E4MdJ c=1 sm=1 tr=0 ts=6ae50a17 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=R6_R1F-nLbiv8mM3OOcA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX2NoXupedAYF/
 MUyizvnxeBsDkTh2kyTULhwJKmuKJOQm5tp79QbtaFN1mcphkEFet3truzJiDLWmNZmNhu1uQCf
 lPb0U/HvD3OLWQwPbTfh74SPcFcTfTZVYKSBLH84qi6oZxIUcZ9ZLh9GLvTNs7ZUyQOBsLRuqso
 W2ikmxpvRXAI0xtmqwtfR648Kbfn+nKSYymKxKq29pWN/+k2MqmQdisS6pNu7oc0D5gICRgA74i
 ljUlnvR6Bsl02HF6PuhZfzdtlcGRaMp5XoG4hGWtu4xuJxl0pqM+OVc9Pt/JwEdDUBie2vYK/VS
 elZndfVW0r59wiif551AreEAsVPV/FIfNfEIDtsdd3ftv5wUooEtQLi1mD98z0cH1t7e23Cs1nz
 lMWzamJ/lhtBlUSpV4RmALHytPokiQ==
X-Proofpoint-ORIG-GUID: 2dEmq2eJM_zClGp792lkvMCq9PEujNG_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX2VL3B8bUYtwV
 IvdPLId1M8+lTRZz6DKJK/9v9eZCQkA6u/K4TC/CqzdXZO1NqmRc5Hstl3lMqd1bYo1dmc1JFMf
 jIwH0ASIimXqIXP56ga8YmHgkjWPNH8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610300000 definitions=main-2610300085
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

This attempts to make it easier to compare to kgsl, the downstream
driver, to make it easier to spot bugs or missing things.  Such as
re-using function names, etc.

Co-developed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Makefile                  |    4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |    7 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h         |    5 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c   | 1401 +++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_snapshot.h  |  209 +++
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml |    4 +
 6 files changed, 1629 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 6196a325b6f1..042fd8fd3f57 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -31,7 +31,9 @@ adreno-y := \
 
 adreno-$(CONFIG_DEBUG_FS) += adreno/a5xx_debugfs.o \
 
-adreno-$(CONFIG_DRM_MSM_GPU_STATE)	+= adreno/a6xx_gpu_state.o
+adreno-$(CONFIG_DRM_MSM_GPU_STATE) += \
+	adreno/a6xx_gpu_state.o \
+	adreno/a8xx_gpu_state.o \
 
 msm-display-$(CONFIG_DRM_MSM_HDMI) += \
 	hdmi/hdmi.o \
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 70c0024bdef4..cfe9ef7ae652 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2946,9 +2946,16 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
 		.active_ring = a6xx_active_ring,
 		.irq = a8xx_irq,
 		.destroy = a6xx_destroy,
+#if defined(CONFIG_DRM_MSM_GPU_STATE)
+		.show = a8xx_show,
+#endif
 		.gpu_busy = a8xx_gpu_busy,
 		.gpu_get_freq = a6xx_gmu_get_freq,
 		.gpu_set_freq = a6xx_gpu_set_freq,
+#if defined(CONFIG_DRM_MSM_GPU_STATE)
+		.gpu_state_get = a8xx_gpu_state_get,
+		.gpu_state_put = a8xx_gpu_state_put,
+#endif
 		.create_vm = a6xx_create_vm,
 		.create_private_vm = a6xx_create_private_vm,
 		.get_rptr = a6xx_get_rptr,
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 639e63c29f4b..18656ac339a9 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -369,4 +369,9 @@ void a8xx_preempt_irq(struct msm_gpu *gpu);
 bool a8xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 void a8xx_perfcntr_flush(struct msm_gpu *gpu);
 void a8xx_recover(struct msm_gpu *gpu);
+void a8xx_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
+		struct drm_printer *p);
+struct msm_gpu_state *a8xx_gpu_state_get(struct msm_gpu *gpu);
+int a8xx_gpu_state_put(struct msm_gpu_state *state);
+
 #endif /* __A6XX_GPU_H__ */
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c
new file mode 100644
index 000000000000..3c696244cd66
--- /dev/null
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c
@@ -0,0 +1,1401 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include "msm_gem.h"
+#include "a6xx_gpu.h"
+#include "a6xx_gmu.h"
+#include "adreno_snapshot.h"
+#include "adreno_gen8_snapshot.h"
+
+#define NUM_SLICES(gpu)  (hweight32((gpu)->slice_mask))
+
+static inline int next_slice(int slice, u32 slice_mask)
+{
+	for (; slice < fls(slice_mask); slice++)
+		if (BIT(slice) & slice_mask)
+			return slice;
+
+	return slice;
+}
+
+#define NEXT_SLICE(_slice, _region, _slice_mask) \
+	((_region == UNSLICE) ? fls(_slice_mask) : next_slice(_slice, _slice_mask))
+
+#define FIRST_SLICE(_region, _slice_mask) \
+	((_region == UNSLICE) ? 0 : NEXT_SLICE(0, _region, _slice_mask))
+
+#define FOR_EACH_SLICE(_slice, _region, _slice_mask) \
+	for (_slice = FIRST_SLICE(_region, _slice_mask); \
+	     _slice < fls(_slice_mask); \
+	     _slice = NEXT_SLICE(++(_slice), _region, _slice_mask))
+
+/* Use SLICE_ID to access the region (0 for unsliced) */
+#define SLICE_ID(region, j) ((region == SLICE) ? j : 0)
+
+/*
+ * Use HEADER_SLICE_ID to specify the slice in the section header (UINT_MAX for unsliced).
+ * This allows snapshot parsers to differentiate between slice ID 0 and unsliced regions.
+ */
+#define HEADER_SLICE_ID(region, j) ((region == SLICE) ? j : UINT_MAX)
+
+#define GEN8_CP_APERTURE_REG_VAL_NS(_sliceid, _pipe, _cluster, _context) ( \
+		A8XX_CP_APERTURE_CNTL_HOST_SLICEID(_sliceid) |		\
+		A8XX_CP_APERTURE_CNTL_HOST_PIPEID(_pipe) |		\
+		A8XX_CP_APERTURE_CNTL_HOST_CLUSTERID(_cluster) |	\
+		A8XX_CP_APERTURE_CNTL_HOST_CONTEXTID3D(_context) |	\
+		0)
+
+#define GEN8_CP_APERTURE_REG_VAL(_sliceid, _pipe, _cluster, _context) (	\
+		A8XX_CP_APERTURE_CNTL_HOST_USESLICEID |			\
+		GEN8_CP_APERTURE_REG_VAL_NS(_sliceid, _pipe, _cluster, _context))
+
+#define GEN8_SP_READ_SEL_VAL(_contextid, _sliceid, _location, _pipe, _statetype, _usptp, _sptp) ( \
+		A7XX_SP_READ_SEL_CONTEXT(_contextid) |			\
+		A7XX_SP_READ_SEL_SLICE(_sliceid) |			\
+		A7XX_SP_READ_SEL_LOCATION(_location) |			\
+		A7XX_SP_READ_SEL_PIPE(_pipe) |				\
+		A7XX_SP_READ_SEL_STATETYPE(_statetype) |		\
+		A7XX_SP_READ_SEL_USPTP(_usptp) |			\
+		A7XX_SP_READ_SEL_SPTP(_sptp) |				\
+		0)
+
+/*
+ * Allocate 4MB for the crashdumper scratch region - 2MB for the script and
+ * the rest for the data.
+ *
+ * Note gen8_snapshot_indexed_registers() is worst case, needing separate
+ * CD_WRITE + CD_READ per reg, 0xa000 times (so script is ~1.2MB)
+ *
+ * TODO we could perhaps be clever and fill in the out addrs in a 2nd pass
+ * to accomodate invocations that need larger script and smaller data, like
+ * indexed regs.
+ */
+#define A8XX_CD_SIZE        SZ_4M
+#define A8XX_CD_DATA_OFFSET (2 * SZ_1M)
+#define A8XX_CD_DATA_SIZE   (A8XX_CD_SIZE - A8XX_CD_DATA_OFFSET)
+
+static int a8xx_crashdumper_init(struct msm_gpu *gpu,
+				 struct adreno_crashdumper *dumper)
+{
+	dumper->ptr = msm_gem_kernel_new(gpu->dev,
+		A8XX_CD_SIZE, MSM_BO_WC, gpu->vm,
+		&dumper->bo, &dumper->iova);
+
+	if (!IS_ERR(dumper->ptr)) {
+		msm_gem_object_set_name(dumper->bo, "crashdump");
+		dumper->data_offset = A8XX_CD_DATA_OFFSET;
+	}
+
+	return PTR_ERR_OR_ZERO(dumper->ptr);
+}
+
+static inline int __cd_run(struct msm_gpu *gpu, struct adreno_crashdumper *dumper)
+{
+	u32 val;
+	int ret;
+
+	if (IS_ERR_OR_NULL(dumper->ptr))
+		return -EINVAL;
+
+	/* Make sure all pending memory writes are posted */
+	wmb();
+
+	gpu_write64(gpu, REG_A8XX_CP_CRASH_DUMP_SCRIPT_BASE, dumper->iova);
+
+	gpu_write(gpu, REG_A8XX_CP_CRASH_DUMP_CNTL, 1);
+
+	/* NOTE: kgsl uses 500ms timeout */
+	ret = gpu_poll_timeout(gpu, REG_A8XX_CP_CRASH_DUMP_STATUS, val,
+			       val & 0x02, 100, 100000);
+
+	gpu_write(gpu, REG_A8XX_CP_CRASH_DUMP_CNTL, 0);
+
+	drm_WARN_ONCE(gpu->dev, ret, "crashdumper timed out: status=%08x (%d)\n", val, ret);
+
+	return ret;
+}
+
+static inline bool __cd_check_overflow(struct cd_script *p)
+{
+	if (WARN_ON_ONCE(p->in > (u64 *)(p->dumper->ptr + A8XX_CD_DATA_OFFSET)))
+		return false;
+	if (WARN_ON_ONCE(p->out > p->dumper->iova + A8XX_CD_SIZE))
+		return false;
+	return true;
+}
+
+static const struct gen8_snapshot_block_list *
+block_list(struct msm_gpu *gpu)
+{
+	return to_adreno_gpu(gpu)->info->snapshot_block_list;
+}
+
+/* The GMU is ioremapped separately, matching how it is described in dt.
+ * However the snapshot tables generated from hw spec do not take into
+ * account dt, and consider it as yet another sub-block of the GPU.  This
+ * helper helps to bridge the worlds.
+ */
+static uint32_t reg_read(struct msm_gpu *gpu, uint32_t reg)
+{
+	struct a6xx_gmu *gmu = &to_a6xx_gpu(to_adreno_gpu(gpu))->gmu;
+	if ((reg << 2) >= gmu->mmio_offset)
+		return gmu_read(gmu, reg);
+	return gpu_read(gpu, reg);
+}
+
+static void adreno_snapshot_registers_v2(struct msm_gpu *gpu,
+					 struct adreno_gpu_state *state,
+					 const u32 *ptr)
+{
+	int k, count;
+
+	/* Figure out how many registers we are going to dump */
+	count = adreno_snapshot_regs_count(ptr);
+
+	snapshot_sect (state, REGS_V2, 4 * count, {}) {
+		for (; ptr[0] != UINT_MAX; ptr += 2) {
+			u32 cnt = REG_COUNT(ptr);
+
+			if (cnt == 1) {
+				snapshot_sect_u32(&sect, BIT(31) | ptr[0]);
+			} else {
+				snapshot_sect_u32(&sect, ptr[0]);
+				snapshot_sect_u32(&sect, cnt);
+			}
+
+			for (k = ptr[0]; k <= ptr[1]; k++) {
+				snapshot_sect_u32(&sect, reg_read(gpu, k));
+			}
+		}
+	}
+}
+
+static void snapshot_mvc_regs_v3_subheader(struct adreno_snapshot_sect *sect, const u32 *ptr)
+{
+	/*
+	 * Note this might look like adreno_snapshot_registers_v2(),
+	 * but looks are deceiving.  The meaning of b31 is inverted
+	 * and the 2nd dword is end-offset instead of count.
+	 */
+	if (REG_COUNT(ptr) == 1) {
+		snapshot_sect_u32(sect, ptr[0]);
+	} else {
+		snapshot_sect_u32(sect, BIT(31) | ptr[0]);
+		snapshot_sect_u32(sect, ptr[1]);
+	}
+}
+
+static void gen8_legacy_snapshot_registers(struct msm_gpu *gpu,
+					   struct adreno_gpu_state *state,
+					   const struct gen8_reg_list *regs,
+					   u32 slice_id)
+{
+	int count;
+
+	/* Figure out how many registers we are going to dump */
+	count = adreno_snapshot_regs_count(regs->regs);
+
+	snapshot_sect (state, MVC_V3, 4 * count, {
+		.ctxt_id = 0,
+		.cluster_id = CLUSTER_NONE,
+		.pipe_id = PIPE_NONE,
+		.location_id = UINT_MAX,
+		.sp_id = UINT_MAX,
+		.usptp_id = UINT_MAX,
+		.slice_id = HEADER_SLICE_ID(regs->slice_region, slice_id),
+	}) {
+		unsigned long flags;
+
+		if (regs->sel)
+			gpu_write(gpu, regs->sel->host_reg, regs->sel->val);
+
+		if (regs->slice_region) {
+			u32 val = GEN8_CP_APERTURE_REG_VAL(slice_id, 0, 0, 0);
+			a8xx_aperture_acquire_raw(gpu, val, &flags);
+		}
+
+		/* Make sure the previous writes are posted before reading */
+		mb();
+
+		for (const u32 *ptr = regs->regs; ptr[0] != UINT_MAX; ptr += 2) {
+			snapshot_mvc_regs_v3_subheader(&sect, ptr);
+
+			for (int k = ptr[0]; k <= ptr[1]; k++) {
+				snapshot_sect_u32(&sect, reg_read(gpu, k));
+			}
+		}
+
+		if (regs->slice_region)
+			a8xx_aperture_release(gpu, flags);
+	}
+}
+
+static bool gen8_reglist_snapshot(struct msm_gpu *gpu, struct adreno_gpu_state *state,
+				  struct adreno_crashdumper *dumper)
+{
+	const struct gen8_snapshot_block_list *b = block_list(gpu);
+	u32 slice_mask = to_a6xx_gpu(to_adreno_gpu(gpu))->slice_mask;
+
+	if (!dumper) {
+		for (u32 i = 0; i < b->num_reg_list; i++) {
+			const struct gen8_reg_list *regs = &b->reg_list[i];
+			u32 j;
+
+			FOR_EACH_SLICE (j, regs->slice_region, slice_mask) {
+				u32 slice_id = SLICE_ID(regs->slice_region, j);
+				gen8_legacy_snapshot_registers(gpu, state, regs, slice_id);
+			}
+
+			/*
+			 * The downstream reglist contains registers in other memory regions
+			 * (cx_misc/cx_mem and cx_dbgc) and we need to plumb through their
+			 * offsets and map them to read them on the CPU. For now only read the
+			 * first two regions.
+			 */
+			if (i == 1)
+				break;
+		}
+		return true;
+	}
+
+	for (u32 i = 0; i < b->num_reg_list; i++) {
+		const struct gen8_reg_list *regs = &b->reg_list[i];
+		u32 j;
+
+		FOR_EACH_SLICE (j, regs->slice_region, slice_mask) {
+			u32 slice_id = SLICE_ID(regs->slice_region, j);
+			struct cd_script p = CD_INIT(dumper);
+
+			CD_WRITE(&p, REG_A8XX_CP_APERTURE_CNTL_CD,
+				 GEN8_CP_APERTURE_REG_VAL(j, 0, 0, 0));
+
+			/* Program the SEL_CNTL_CD register appropriately */
+			if (regs->sel)
+				CD_WRITE(&p, regs->sel->cd_reg, regs->sel->val);
+
+			for (const u32 *ptr = regs->regs; ptr[0] != UINT_MAX; ptr += 2) {
+				u32 count = REG_COUNT(ptr);
+
+				CD_READ(&p, ptr[0], count);
+			}
+
+			/* Marker for end of script */
+			CD_FINISH(&p);
+
+			/* Try to run the crash dumper and bail if it times out */
+			if (CD_RUN(&p, gpu))
+				return false;
+
+			u32 count = adreno_snapshot_regs_count(regs->regs);
+			snapshot_sect (state, MVC_V3, 4 * count, {
+				.ctxt_id = 0,
+				.cluster_id = CLUSTER_NONE,
+				.pipe_id = PIPE_NONE,
+				.location_id = UINT_MAX,
+				.sp_id = UINT_MAX,
+				.usptp_id = UINT_MAX,
+				.slice_id = HEADER_SLICE_ID(regs->slice_region, slice_id),
+			}) {
+				const u32 *src = dumper->ptr + A8XX_CD_DATA_OFFSET;
+
+				for (const u32 *ptr = regs->regs; ptr[0] != UINT_MAX; ptr += 2) {
+					u32 count = REG_COUNT(ptr);
+
+					snapshot_mvc_regs_v3_subheader(&sect, ptr);
+					snapshot_sect_data(&sect, src, count * sizeof(u32));
+
+					src += count;
+				}
+			}
+		}
+	}
+
+	return true;
+}
+
+static bool gen8_snapshot_indexed_registers(
+	struct msm_gpu *gpu, struct adreno_gpu_state *state, struct adreno_crashdumper *dumper,
+	u32 index, u32 data, u32 start, u32 count, u32 pipe_id, u32 slice_id)
+{
+	struct adreno_snapshot_indexed_regs_v2 hdr = {
+		.index_reg = index,
+		.data_reg = data,
+		.count = count,
+		.start = start,
+		.pipe_id = pipe_id,
+		.slice_id = slice_id,
+	};
+	u32 s = (slice_id == UINT_MAX) ? 0 : slice_id;
+
+	if (!dumper) {
+		snapshot_sect (state, INDEXED_REGS_V2, count * sizeof(u32), hdr) {
+			unsigned long flags;
+
+			u32 val = GEN8_CP_APERTURE_REG_VAL(s, pipe_id, 0, 0);
+			a8xx_aperture_acquire_raw(gpu, val, &flags);
+
+			for (int i = 0; i < count; i++) {
+				/* Write the address register */
+				gpu_write(gpu, index, start + i);
+
+				/* Make sure the write finishes */
+				wmb();
+
+				snapshot_sect_u32(&sect, reg_read(gpu, data));
+
+				/* Make sure the read finishes */
+				rmb();
+			}
+
+			a8xx_aperture_release(gpu, flags);
+		}
+
+		return true;
+	}
+
+	struct cd_script p = CD_INIT(dumper);
+
+	CD_WRITE(&p, REG_A8XX_CP_APERTURE_CNTL_CD,
+		 GEN8_CP_APERTURE_REG_VAL(s, pipe_id, 0, 0));
+
+	for (int i = 0; i < count; i++) {
+		/* Write the address register */
+		CD_WRITE(&p, index, start + i);
+		CD_READ(&p, data, 1);
+	}
+
+	/* Marker for end of script */
+	CD_FINISH(&p);
+
+	/* Try to run the crash dumper and bail if it times out */
+	if (CD_RUN(&p, gpu))
+		return false;
+
+	snapshot_sect (state, INDEXED_REGS_V2, count * sizeof(u32), hdr) {
+		const u32 *src = dumper->ptr + A8XX_CD_DATA_OFFSET;
+		snapshot_sect_data(&sect, src, count * sizeof(u32));
+	}
+
+	return true;
+}
+
+static bool gen8_snapshot_cp_indexed_regs(struct msm_gpu *gpu,
+					  struct adreno_gpu_state *state,
+					  struct adreno_crashdumper *dumper)
+{
+	const struct gen8_snapshot_block_list *b = block_list(gpu);
+
+	for (int i = 0; i < b->index_registers_len; i++) {
+		bool ret = gen8_snapshot_indexed_registers(gpu, state, dumper,
+			b->index_registers[i].addr,
+			b->index_registers[i].data, 0,
+			b->index_registers[i].size,
+			b->index_registers[i].pipe_id, UINT_MAX);
+		if (!ret)
+			return false;
+	}
+
+	return true;
+}
+
+static bool gen8_snapshot_mempool(struct msm_gpu *gpu,
+				  struct adreno_gpu_state *state,
+				  struct adreno_crashdumper *dumper)
+{
+	const struct gen8_snapshot_block_list *b = block_list(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(to_adreno_gpu(gpu));
+	u32 slice_mask = a6xx_gpu->slice_mask;
+	u32 first_slice = a8xx_get_first_slice(a6xx_gpu);
+	bool ret = true;
+
+	for (int i = 0; i < b->mempool_index_registers_len && ret; i++) {
+		const struct gen8_cp_indexed_reg *cp_indexed_reg =
+			&b->mempool_index_registers[i];
+		unsigned long flags;
+		u32 j;
+
+		FOR_EACH_SLICE (j, cp_indexed_reg->slice_region, slice_mask) {
+			u32 pipe_id = cp_indexed_reg->pipe_id;
+
+			/* Set CP_CHICKEN_DBG[StabilizeMVC] to stabilize it while dumping */
+			a8xx_aperture_acquire_raw(gpu,
+				GEN8_CP_APERTURE_REG_VAL_NS(first_slice, pipe_id, 0, 0),
+				&flags);
+			gpu_rmw(gpu, REG_A8XX_CP_CHICKEN_DBG_PIPE, BIT(2), BIT(2));
+			a8xx_aperture_release(gpu, flags);
+
+			a8xx_aperture_acquire_raw(gpu,
+				GEN8_CP_APERTURE_REG_VAL(j, pipe_id, 0, 0),
+				&flags);
+			gpu_rmw(gpu, REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE, BIT(2), BIT(2));
+			a8xx_aperture_release(gpu, flags);
+
+			ret = gen8_snapshot_indexed_registers(gpu, state, dumper,
+				cp_indexed_reg->addr,
+				cp_indexed_reg->data, 0,
+				cp_indexed_reg->size,
+				cp_indexed_reg->pipe_id,
+				HEADER_SLICE_ID(cp_indexed_reg->slice_region, j));
+
+			/* Reset CP_CHICKEN_DBG[StabilizeMVC] once we are done */
+			a8xx_aperture_acquire_raw(gpu,
+				GEN8_CP_APERTURE_REG_VAL_NS(first_slice, pipe_id, 0, 0),
+				&flags);
+			gpu_rmw(gpu, REG_A8XX_CP_CHICKEN_DBG_PIPE, BIT(2), 0);
+			a8xx_aperture_release(gpu, flags);
+
+			a8xx_aperture_acquire_raw(gpu,
+				GEN8_CP_APERTURE_REG_VAL(j, pipe_id, 0, 0),
+				&flags);
+			gpu_rmw(gpu, REG_A8XX_CP_SLICE_CHICKEN_DBG_PIPE, BIT(2), 0);
+			a8xx_aperture_release(gpu, flags);
+
+			if (!ret)
+				break;
+		}
+	}
+
+	/* Clear aperture register */
+	a8xx_aperture_clear(gpu);
+
+	return ret;
+}
+
+static void gen8_legacy_snapshot_mvc(struct msm_gpu *gpu,
+				     struct adreno_gpu_state *state,
+				     const struct gen8_cluster_registers *cluster,
+				     u32 slice_id)
+{
+	int count;
+
+	/* Figure out how many registers we are going to dump */
+	count = adreno_snapshot_regs_count(cluster->regs);
+
+	snapshot_sect (state, MVC_V3, 4 * count, {
+		.ctxt_id = (cluster->context_id == STATE_FORCE_CTXT_1) ? 1 : 0,
+		.cluster_id = cluster->cluster_id,
+		.pipe_id = cluster->pipe_id,
+		.location_id = UINT_MAX,
+		.sp_id = UINT_MAX,
+		.usptp_id = UINT_MAX,
+		.slice_id = HEADER_SLICE_ID(cluster->slice_region, slice_id),
+	}) {
+		unsigned long flags;
+
+		/*
+		 * Set the AHB control for the Host to read from the
+		 * cluster/context for this iteration.
+		 */
+		u32 val = GEN8_CP_APERTURE_REG_VAL(
+			slice_id, cluster->pipe_id,
+			cluster->cluster_id, cluster->context_id);
+		a8xx_aperture_acquire_raw(gpu, val, &flags);
+
+		if (cluster->sel)
+			gpu_write(gpu, cluster->sel->host_reg, cluster->sel->val);
+
+		/* Make sure the previous writes are posted before reading */
+		mb();
+
+		for (const u32 *ptr = cluster->regs; ptr[0] != UINT_MAX; ptr += 2) {
+			snapshot_mvc_regs_v3_subheader(&sect, ptr);
+
+			for (int k = ptr[0]; k <= ptr[1]; k++) {
+				snapshot_sect_u32(&sect, reg_read(gpu, k));
+			}
+		}
+
+		a8xx_aperture_release(gpu, flags);
+	}
+}
+
+static bool gen8_snapshot_mvc_regs(
+	struct msm_gpu *gpu, struct adreno_gpu_state *state, struct adreno_crashdumper *dumper,
+	const struct gen8_cluster_registers *clusters, size_t num_cluster)
+{
+	u32 slice_mask = to_a6xx_gpu(to_adreno_gpu(gpu))->slice_mask;
+
+	if (!dumper) {
+		for (int i = 0; i < num_cluster; i++) {
+			const struct gen8_cluster_registers *cluster = &clusters[i];
+			u32 j;
+
+			FOR_EACH_SLICE (j, cluster->slice_region, slice_mask) {
+				u32 slice_id = SLICE_ID(cluster->slice_region, j);
+				gen8_legacy_snapshot_mvc(gpu, state, cluster, slice_id);
+			}
+		}
+		return true;
+	}
+
+	for (int i = 0; i < num_cluster; i++) {
+		const struct gen8_cluster_registers *cluster = &clusters[i];
+		u32 j;
+
+		FOR_EACH_SLICE (j, cluster->slice_region, slice_mask) {
+			u32 slice_id = SLICE_ID(cluster->slice_region, j);
+			struct cd_script p = CD_INIT(dumper);
+
+			CD_WRITE(&p, REG_A8XX_CP_APERTURE_CNTL_CD,
+				 GEN8_CP_APERTURE_REG_VAL(j, cluster->pipe_id,
+							  cluster->cluster_id,
+							  cluster->context_id));
+
+			if (cluster->sel)
+				CD_WRITE(&p, cluster->sel->cd_reg, cluster->sel->val);
+
+			for (const u32 *ptr = cluster->regs; ptr[0] != UINT_MAX; ptr += 2) {
+				CD_READ(&p, ptr[0], REG_COUNT(ptr));
+			}
+
+			/* Marker for end of script */
+			CD_FINISH(&p);
+
+			/* Try to run the crash dumper and bail if it times out */
+			if (CD_RUN(&p, gpu))
+				return false;
+
+			u32 count = adreno_snapshot_regs_count(cluster->regs);
+
+			snapshot_sect (state, MVC_V3, 4 * count, {
+				.ctxt_id = (cluster->context_id == STATE_FORCE_CTXT_1) ? 1 : 0,
+				.cluster_id = cluster->cluster_id,
+				.pipe_id = cluster->pipe_id,
+				.location_id = UINT_MAX,
+				.sp_id = UINT_MAX,
+				.usptp_id = UINT_MAX,
+				.slice_id = HEADER_SLICE_ID(cluster->slice_region, slice_id),
+			}) {
+				const u32 *src = dumper->ptr + A8XX_CD_DATA_OFFSET;
+
+				for (const u32 *ptr = cluster->regs; ptr[0] != UINT_MAX; ptr += 2) {
+					u32 count = REG_COUNT(ptr);
+
+					snapshot_mvc_regs_v3_subheader(&sect, ptr);
+					snapshot_sect_data(&sect, src, count * sizeof(u32));
+
+					src += count;
+				}
+			}
+		}
+	}
+	return true;
+}
+
+static u32 gen8_read_dbgahb(struct msm_gpu *gpu, u32 regbase, u32 reg)
+{
+	return gpu_read(gpu, REG_A7XX_SP_AHB_READ_APERTURE + reg - regbase);
+}
+
+static void gen8_legacy_snapshot_cluster_dbgahb(
+	struct msm_gpu *gpu, struct adreno_gpu_state *state,
+	const struct gen8_sptp_cluster_registers *cluster,
+	u32 sp, u32 usptp, u32 slice_id)
+{
+	int count;
+
+	/* Figure out how many registers we are going to dump */
+	count = adreno_snapshot_regs_count(cluster->regs);
+
+	snapshot_sect (state, MVC_V3, 4 * count, {
+		.ctxt_id = cluster->context_id,
+		.cluster_id = cluster->cluster_id,
+		.pipe_id = cluster->pipe_id,
+		.location_id = cluster->location_id,
+		.sp_id = sp,
+		.usptp_id = usptp,
+		.slice_id = HEADER_SLICE_ID(cluster->slice_region, slice_id),
+	}) {
+		u32 read_sel = GEN8_SP_READ_SEL_VAL(
+			cluster->context_id, slice_id, cluster->location_id,
+			cluster->pipe_id, cluster->statetype, usptp, sp);
+
+		gpu_write(gpu, REG_A7XX_SP_READ_SEL, read_sel);
+
+		/*
+		 * An explicit barrier is needed so that reads do not happen before
+		 * the register write.
+		 */
+		mb();
+
+		for (const u32 *ptr = cluster->regs; ptr[0] != UINT_MAX; ptr += 2) {
+			snapshot_mvc_regs_v3_subheader(&sect, ptr);
+
+			for (int k = ptr[0]; k <= ptr[1]; k++) {
+				u32 val = gen8_read_dbgahb(gpu, cluster->regbase, k);
+				snapshot_sect_u32(&sect, val);
+			}
+		}
+	}
+}
+
+static bool gen8_snapshot_dbgahb_regs(struct msm_gpu *gpu,
+				      struct adreno_gpu_state *state,
+				      struct adreno_crashdumper *dumper)
+{
+	const struct gen8_snapshot_block_list *b = block_list(gpu);
+	u32 slice_mask = to_a6xx_gpu(to_adreno_gpu(gpu))->slice_mask;
+
+	if (!dumper) {
+		for (int i = 0; i < b->num_sptp_clusters; i++) {
+			const struct gen8_sptp_cluster_registers *cluster =
+				&b->sptp_clusters[i];
+
+			for (u32 sp = 0; sp < cluster->num_sps; sp++) {
+				for (u32 usptp = 0; usptp < cluster->num_usptps; usptp++) {
+					u32 j;
+
+					FOR_EACH_SLICE (j, cluster->slice_region, slice_mask) {
+						u32 slice_id = SLICE_ID(cluster->slice_region, j);
+
+						gen8_legacy_snapshot_cluster_dbgahb(
+							gpu, state, cluster,
+							sp, usptp, slice_id);
+					}
+				}
+			}
+		}
+
+		return true;
+	}
+
+	for (int i = 0; i < b->num_sptp_clusters; i++) {
+		const struct gen8_sptp_cluster_registers *cluster =
+			&b->sptp_clusters[i];
+
+		for (u32 sp = 0; sp < cluster->num_sps; sp++) {
+			for (u32 usptp = 0; usptp < cluster->num_usptps; usptp++) {
+				u32 j;
+
+				FOR_EACH_SLICE (j, cluster->slice_region, slice_mask) {
+					u32 slice_id = SLICE_ID(cluster->slice_region, j);
+
+					/* Build the crash script */
+					struct cd_script p = CD_INIT(dumper);
+
+					u32 read_sel = GEN8_SP_READ_SEL_VAL(
+						cluster->context_id, slice_id,
+						cluster->location_id, cluster->pipe_id,
+						cluster->statetype, usptp, sp);
+
+					/* Program the aperture */
+					CD_WRITE(&p, REG_A7XX_SP_READ_SEL, read_sel);
+
+					for (const u32 *ptr = cluster->regs; ptr[0] != UINT_MAX; ptr += 2) {
+						u32 count = REG_COUNT(ptr);
+						u32 reg = REG_A7XX_SP_AHB_READ_APERTURE + ptr[0] - cluster->regbase;
+
+						CD_READ(&p, reg, count);
+					}
+
+					/* Marker for end of script */
+					CD_FINISH(&p);
+
+					/* Try to run the crash dumper and bail if it times out */
+					if (CD_RUN(&p, gpu))
+						return false;
+
+					u32 count = adreno_snapshot_regs_count(cluster->regs);
+					snapshot_sect (state, MVC_V3, 4 * count, {
+						.ctxt_id = cluster->context_id,
+						.cluster_id = cluster->cluster_id,
+						.pipe_id = cluster->pipe_id,
+						.location_id = cluster->location_id,
+						.sp_id = sp,
+						.usptp_id = usptp,
+						.slice_id = HEADER_SLICE_ID(cluster->slice_region, slice_id),
+					}) {
+						const u32 *src = dumper->ptr + A8XX_CD_DATA_OFFSET;
+
+						for (const u32 *ptr = cluster->regs; ptr[0] != UINT_MAX; ptr += 2) {
+							u32 count = REG_COUNT(ptr);
+
+							snapshot_mvc_regs_v3_subheader(&sect, ptr);
+							snapshot_sect_data(&sect, src, count * sizeof(u32));
+
+							src += count;
+						}
+					}
+				}
+			}
+		}
+	}
+
+	return true;
+}
+
+static void gen8_legacy_snapshot_shader(struct msm_gpu *gpu, struct adreno_gpu_state *state,
+					const struct gen8_shader_block *block,
+					u32 sp, u32 ctxt, u32 slice_id)
+{
+	snapshot_sect (state, SHADER_V3, block->size * sizeof(u32), {
+		.type = block->statetype,
+		.slice_id = HEADER_SLICE_ID(block->slice_region, slice_id),
+		.sp_index = sp,
+		.usptp = block->usptp_id,
+		.pipe_id = block->pipeid,
+		.location = block->location,
+		.ctxt_id = ctxt,
+		.size = block->size,
+	}) {
+		u32 read_sel = GEN8_SP_READ_SEL_VAL(
+			ctxt, slice_id, block->location, block->pipeid,
+			block->statetype, block->usptp_id, sp);
+
+		gpu_write(gpu, REG_A7XX_SP_READ_SEL, read_sel);
+
+		/*
+		 * An explicit barrier is needed so that reads do not happen before
+		 * the register write.
+		 */
+		mb();
+
+		for (int i = 0; i < block->size; i++) {
+			u32 val = gpu_read(gpu, REG_A7XX_SP_AHB_READ_APERTURE + i);
+			snapshot_sect_u32(&sect, val);
+		}
+	}
+}
+
+static bool gen8_snapshot_shader(struct msm_gpu *gpu,
+				 struct adreno_gpu_state *state,
+				 struct adreno_crashdumper *dumper)
+{
+	const struct gen8_snapshot_block_list *b = block_list(gpu);
+	u32 slice_mask = to_a6xx_gpu(to_adreno_gpu(gpu))->slice_mask;
+
+	if (!dumper) {
+		for (int i = 0; i < b->num_shader_blocks; i++) {
+			const struct gen8_shader_block *block = &b->shader_blocks[i];
+			u32 j;
+
+			FOR_EACH_SLICE (j, block->slice_region, slice_mask) {
+				u32 slice_id = SLICE_ID(block->slice_region, j);
+
+				for (u32 sp = 0; sp < block->num_sps; sp++) {
+					for (u32 ctxt = 0; ctxt < block->num_ctx; ctxt++) {
+						gen8_legacy_snapshot_shader(
+							gpu, state, block, sp, ctxt, slice_id);
+					}
+				}
+			}
+		}
+
+		return true;
+	}
+
+	for (int i = 0; i < b->num_shader_blocks; i++) {
+		const struct gen8_shader_block *block = &b->shader_blocks[i];
+		u32 j;
+
+		FOR_EACH_SLICE (j, block->slice_region, slice_mask) {
+			u32 slice_id = SLICE_ID(block->slice_region, j);
+
+			for (u32 sp = 0; sp < block->num_sps; sp++) {
+				for (u32 ctxt = 0; ctxt < block->num_ctx; ctxt++) {
+					/* Build the crash script */
+					struct cd_script p = CD_INIT(dumper);
+
+					u32 read_sel = GEN8_SP_READ_SEL_VAL(
+						ctxt, slice_id, block->location, block->pipeid,
+						block->statetype, block->usptp_id, sp);
+
+					/* Program the aperture */
+					CD_WRITE(&p, REG_A7XX_SP_READ_SEL, read_sel);
+
+					/* Read all the data in one chunk */
+					CD_READ(&p, REG_A7XX_SP_AHB_READ_APERTURE, block->size);
+
+					/* Marker for end of script */
+					CD_FINISH(&p);
+
+					/* Try to run the crash dumper and bail if it times out */
+					if (CD_RUN(&p, gpu))
+						return false;
+
+					snapshot_sect (state, SHADER_V3, block->size * sizeof(u32), {
+						.type = block->statetype,
+						.slice_id = HEADER_SLICE_ID(block->slice_region, slice_id),
+						.sp_index = sp,
+						.usptp = block->usptp_id,
+						.pipe_id = block->pipeid,
+						.location = block->location,
+						.ctxt_id = ctxt,
+						.size = block->size,
+					}) {
+						const u32 *src = dumper->ptr + A8XX_CD_DATA_OFFSET;
+						snapshot_sect_data(&sect, src, block->size * sizeof(u32));
+					}
+				}
+			}
+		}
+	}
+
+	return true;
+}
+
+static void a8xx_snapshot_gmu_bo(struct adreno_gpu_state *state,
+				 struct a6xx_gmu_bo *bo,
+				 unsigned type)
+{
+	snapshot_sect (state, GMU_MEMORY, bo->size, {
+		.type = type,
+		.gmuaddr = bo->iova,
+	}) {
+		snapshot_sect_data(&sect, bo->virt, bo->size);
+	}
+}
+
+static void a8xx_snapshot_gpu_bo(struct adreno_gpu_state *state,
+				 struct drm_gem_object *bo,
+				 uint64_t iova)
+{
+	if (!IS_ERR_OR_NULL(bo))
+		return;
+
+	snapshot_sect (state, GPU_OBJECT_V2, bo->size, {
+		.type = SNAPSHOT_GPU_OBJECT_GLOBAL,
+		.gpuaddr = iova,
+		.size = bo->size / 4,  /* dwords */
+	}) {
+		void *ptr = msm_gem_get_vaddr(bo);
+		snapshot_sect_data(&sect, ptr, bo->size);
+		msm_gem_put_vaddr(bo);
+	}
+}
+
+static void a8xx_snapshot_gmu_hfi_history(struct msm_gpu *gpu,
+					  struct adreno_gpu_state *state)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
+	unsigned i, j;
+
+	BUILD_BUG_ON(ARRAY_SIZE(gmu->queues) != ARRAY_SIZE(state->hfi_queue_history));
+
+	for (i = 0; i < ARRAY_SIZE(gmu->queues); i++) {
+		struct a6xx_hfi_queue *queue = &gmu->queues[i];
+		for (j = 0; j < HFI_HISTORY_SZ; j++) {
+			unsigned idx = (j + queue->history_idx) % HFI_HISTORY_SZ;
+			state->hfi_queue_history[i][j] = queue->history[idx];
+		}
+	}
+}
+
+#define GEN8_DEBUGBUS_BLOCK_SIZE 0x100
+
+#define GEN8_DEBUGBUS_BLOCK_IDX_1 128
+#define GEN8_DEBUGBUS_BLOCK_IDX_2 192
+
+static void gen8_dbgc_debugbus_select(struct msm_gpu *gpu, u32 block_id, u32 index)
+{
+	u32 reg;
+
+	reg = A7XX_DBGC_CFG_DBGBUS_SEL_D_PING_INDEX(index) |
+		A7XX_DBGC_CFG_DBGBUS_SEL_D_PING_BLK_SEL(block_id);
+
+	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_SEL_A, reg);
+	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_SEL_B, reg);
+	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_SEL_C, reg);
+	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_SEL_D, reg);
+
+	/*
+	 * There needs to be a delay of 1 us to ensure enough time for correct
+	 * data is funneled into the trace buffer
+	 */
+	udelay(1);
+}
+
+static void gen8_dbgc_side_debug_bus_read(struct msm_gpu *gpu,
+	u32 block_id, u32 index, struct adreno_snapshot_sect *sect)
+{
+	u32 reg, side_data;
+
+	gen8_dbgc_debugbus_select(gpu, block_id, index);
+
+	reg = gpu_read(gpu, REG_A6XX_DBGC_CFG_DBGBUS_OVER);
+	side_data = FIELD_GET(GENMASK(27, 24), reg);
+
+	snapshot_sect_u32(sect, side_data);
+}
+
+static void gen8_snapshot_dbgc_side_debugbus_block(
+	struct msm_gpu *gpu, uint32_t block_id, size_t count,
+	struct adreno_snapshot_sect *sect)
+{
+	for (int i = 0; i < count; i++)
+		gen8_dbgc_side_debug_bus_read(gpu, block_id, i, sect);
+}
+
+static void gen8_dbgc_debug_bus_read(struct msm_gpu *gpu,
+	u32 block_id, u32 index, struct adreno_snapshot_sect *sect)
+{
+	gen8_dbgc_debugbus_select(gpu, block_id, index);
+
+	snapshot_sect_u32(sect, gpu_read(gpu, REG_A6XX_DBGC_CFG_DBGBUS_TRACE_BUF2));
+	snapshot_sect_u32(sect, gpu_read(gpu, REG_A6XX_DBGC_CFG_DBGBUS_TRACE_BUF1));
+}
+
+static void gen8_snapshot_dbgc_debugbus_block(
+	struct msm_gpu *gpu, uint32_t block_id, size_t count,
+	struct adreno_snapshot_sect *sect)
+{
+	for (int i = 0; i < count; i++)
+		gen8_dbgc_debug_bus_read(gpu, block_id, i, sect);
+}
+
+static void gen8_snapshot_debugbus(struct msm_gpu *gpu, struct adreno_gpu_state *state)
+{
+	const struct gen8_snapshot_block_list *b = block_list(gpu);
+
+	/* Set up the GX debug bus */
+
+	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_CNTLT,
+		A6XX_DBGC_CFG_DBGBUS_CNTLT_SEGT(0xf));
+
+	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_CNTLM,
+		A6XX_DBGC_CFG_DBGBUS_CNTLM_ENABLE(0xf));
+
+	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_IVTL_0, 0);
+	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_IVTL_1, 0);
+	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_IVTL_2, 0);
+	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_IVTL_3, 0);
+
+	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_BYTEL_0, 0x76543210);
+	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_BYTEL_1, 0xFEDCBA98);
+
+	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_MASKL_0, 0);
+	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_MASKL_1, 0);
+	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_MASKL_2, 0);
+	gpu_write(gpu, REG_A6XX_DBGC_CFG_DBGBUS_MASKL_3, 0);
+
+	/* Read the blocks: */
+
+	for (int i = 0; i < b->debugbus_blocks_len; i++) {
+		size_t count = GEN8_DEBUGBUS_BLOCK_SIZE;
+		uint32_t block_id = b->debugbus_blocks[i];
+
+		snapshot_sect (state, DEBUGBUS, 4 * 2 * count, {
+			/* debugbus section hdr: */
+			.id = block_id,
+			.count = count * 2,
+		}) {
+			gen8_snapshot_dbgc_debugbus_block(gpu, block_id, count, &sect);
+		}
+
+		snapshot_sect (state, SIDE_DEBUGBUS, 4 * count, {
+			/* side_debugbus section hdr: */
+			.id = block_id,
+			.size = count,
+			.valid_data = 0x4,
+		}) {
+			gen8_snapshot_dbgc_side_debugbus_block(gpu, block_id, count, &sect);
+		}
+	}
+
+	for (int i = 0; i < b->gbif_debugbus_blocks_len; i++) {
+		size_t count = GEN8_DEBUGBUS_BLOCK_SIZE;
+		uint32_t block_id = b->gbif_debugbus_blocks[i];
+
+		snapshot_sect (state, DEBUGBUS, 4 * 2 * count, {
+			/* debugbus section hdr: */
+			.id = block_id,
+			.count = count * 2,
+		}) {
+			gen8_snapshot_dbgc_debugbus_block(gpu, block_id, count, &sect);
+		}
+
+		snapshot_sect (state, SIDE_DEBUGBUS, 4 * count, {
+			/* side_debugbus section hdr: */
+			.id = block_id,
+			.size = count,
+			.valid_data = 0x4,
+		}) {
+			gen8_snapshot_dbgc_side_debugbus_block(gpu, block_id, count, &sect);
+		}
+	}
+}
+
+#define cxdbg_write(gpu, offset, val) \
+	gpu_write((gpu), (offset) + 0x18400, (val))
+
+#define cxdbg_read(gpu, offset) \
+	gpu_read((gpu), (offset) + 0x18400)
+
+static void gen8_cx_dbgc_debugbus_select(struct msm_gpu *gpu, u32 block_id, u32 index)
+{
+	u32 reg;
+
+	reg = A7XX_CX_DBGC_CFG_DBGBUS_SEL_A_PING_INDEX(index) |
+		A7XX_CX_DBGC_CFG_DBGBUS_SEL_A_PING_BLK_SEL(block_id);
+
+	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_SEL_A, reg);
+	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_SEL_B, reg);
+	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_SEL_C, reg);
+	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_SEL_D, reg);
+
+	/*
+	 * There needs to be a delay of 1 us to ensure enough time for correct
+	 * data is funneled into the trace buffer
+	 */
+	udelay(1);
+}
+
+static void gen8_debugbus_internal_read_setup(struct msm_gpu *gpu)
+{
+	/* Clear the DBGC logic/events */
+	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_CNTLM, 0x70000000);
+
+	/* Enable the internal buffer mode and program to tail mode */
+	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_OPL, 0x28000000);
+
+	/* Program the logic unit 0 to high when the side data is 1 */
+	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_BYTEL_0, 0x0000000c);
+	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_MASKL_0, 0x000000f0);
+
+	/* Enable the DBGC logic/events */
+	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_CNTLM, 0x07000000);
+}
+
+static void gen8_cx_gc_us_i_0_debugbus_read(
+	struct msm_gpu *gpu, u32 block_id, u32 index, u32 data[2])
+{
+	gen8_cx_dbgc_debugbus_select(gpu, block_id, index);
+
+	/*
+	 * Select lower 32 bits of internal buffer data for internal mux[1:0]
+	 * DBGC_CFG_DBGBUS_IDX.internalIndex0 = 24 (0x18)
+	 * DBGC_CFG_DBGBUS_IDX.internalIndex1 = 25 (0x19)
+	 */
+	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_IDX, 0x00001918);
+	udelay(1);
+
+	data[0] = cxdbg_read(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_TRACE_BUF3);
+
+	/*
+	 * Select upper 32 bits of internal buffer data for internal mux[1:0]
+	 * DBGC_CFG_DBGBUS_IDX.internalIndex0 = 26 (0x1a)
+	 * DBGC_CFG_DBGBUS_IDX.internalIndex1 = 27 (0x1b)
+	 */
+	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_IDX, 0x00001a1b);
+	udelay(1);
+
+	data[1] = cxdbg_read(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_TRACE_BUF3);
+}
+
+/* gen8_cx_dbgc_debug_bus_read() - Read data from trace bus */
+static void gen8_cx_debug_bus_read(
+	struct msm_gpu *gpu, u32 block_id, u32 index, u32 data[2])
+{
+	gen8_cx_dbgc_debugbus_select(gpu, block_id, index);
+
+	data[0] = cxdbg_read(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_TRACE_BUF2);
+	data[1] = cxdbg_read(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_TRACE_BUF1);
+}
+
+static void gen8_snapshot_cx_dbgc_debugbus_block(
+	struct msm_gpu *gpu, uint32_t block_id, size_t count,
+	struct adreno_snapshot_sect *sect)
+{
+	/* This block requires an out of order access due to a HW limitation.
+	 * (QCTDD12240539)
+	 */
+	if (block_id == DEBUGBUS_CX_GC_US_I_0) {
+		static u32 data[GEN8_DEBUGBUS_BLOCK_SIZE * 2];
+		gen8_debugbus_internal_read_setup(gpu);
+		for (int i = 0; i < GEN8_DEBUGBUS_BLOCK_IDX_1; i++)
+			gen8_cx_gc_us_i_0_debugbus_read(gpu, block_id, i, &data[i * 2]);
+		for (int i = GEN8_DEBUGBUS_BLOCK_IDX_2; i < GEN8_DEBUGBUS_BLOCK_SIZE; i++)
+			gen8_cx_gc_us_i_0_debugbus_read(gpu, block_id, i, &data[i * 2]);
+		for (int i = GEN8_DEBUGBUS_BLOCK_IDX_1; i < GEN8_DEBUGBUS_BLOCK_IDX_2; i++)
+			gen8_cx_gc_us_i_0_debugbus_read(gpu, block_id, i, &data[i * 2]);
+		snapshot_sect_arr(sect, data);
+	} else {
+		for (int i = 0; i < count; i++) {
+			u32 data[2];
+			gen8_cx_debug_bus_read(gpu, block_id, i, data);
+			snapshot_sect_arr(sect, data);
+		}
+	}
+}
+
+
+/* gen8_cx_side_dbgc_debug_bus_read() - Read data from trace bus */
+static void gen8_cx_side_debug_bus_read(
+	struct msm_gpu *gpu, u32 block_id, u32 index, struct adreno_snapshot_sect *sect)
+{
+	u32 reg, side_data;
+
+	gen8_cx_dbgc_debugbus_select(gpu, block_id, index);
+
+	reg = cxdbg_read(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_OVER);
+	side_data = FIELD_GET(GENMASK(27, 24), reg);
+
+	snapshot_sect_u32(sect, side_data);
+
+}
+
+static void gen8_snapshot_cx_side_dbgc_debugbus_block(
+	struct msm_gpu *gpu, uint32_t block_id, size_t count,
+	struct adreno_snapshot_sect *sect)
+{
+	for (int i = 0; i < count; i++)
+		gen8_cx_side_debug_bus_read(gpu, block_id, i, sect);
+}
+
+static void gen8_snapshot_cx_debugbus(struct msm_gpu *gpu, struct adreno_gpu_state *state)
+{
+	const struct gen8_snapshot_block_list *b = block_list(gpu);
+
+	/* Set up the CX debug bus */
+
+	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_CNTLT,
+		A6XX_DBGC_CFG_DBGBUS_CNTLT_SEGT(0xf));
+
+	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_CNTLM,
+		A6XX_DBGC_CFG_DBGBUS_CNTLM_ENABLE(0xf));
+
+	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_IVTL_0, 0);
+	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_IVTL_1, 0);
+	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_IVTL_2, 0);
+	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_IVTL_3, 0);
+
+	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_BYTEL_0, 0x76543210);
+	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_BYTEL_1, 0xFEDCBA98);
+
+	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_MASKL_0, 0);
+	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_MASKL_1, 0);
+	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_MASKL_2, 0);
+	cxdbg_write(gpu, REG_A6XX_CX_DBGC_CFG_DBGBUS_MASKL_3, 0);
+
+	/* Read the blocks: */
+
+	for (int i = 0; i < b->cx_debugbus_blocks_len; i++) {
+		size_t count = GEN8_DEBUGBUS_BLOCK_SIZE;
+		uint32_t block_id = b->cx_debugbus_blocks[i];
+
+		snapshot_sect (state, DEBUGBUS, 4 * 2 * count, {
+			/* debugbus section hdr: */
+			.id = block_id,
+			.count = count * 2,
+		}) {
+			gen8_snapshot_cx_dbgc_debugbus_block(gpu, block_id, count, &sect);
+		}
+
+		snapshot_sect (state, SIDE_DEBUGBUS, 4 * count, {
+			/* side_debugbus section hdr: */
+			.id = block_id,
+			.size = count,
+			.valid_data = 0x4,
+		}) {
+			gen8_snapshot_cx_side_dbgc_debugbus_block(gpu, block_id, count, &sect);
+		}
+	}
+}
+
+struct msm_gpu_state *a8xx_gpu_state_get(struct msm_gpu *gpu)
+{
+	const struct gen8_snapshot_block_list *b = block_list(gpu);
+	struct adreno_crashdumper _dumper = { 0 }, *dumper = NULL;
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	struct adreno_gpu_state *state;
+
+	/*
+	 * GPU state snapshot is inherently single threaded.  All paths
+	 * are serialized on gpu->lock.  Make that clear, and prevent
+	 * future bugs:
+	 */
+	WARN_ON_ONCE(!mutex_is_locked(&gpu->lock));
+
+	if (!b)
+		return NULL;
+
+	state = kzalloc_obj(*state);
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&state->objs);
+
+	/* Get the generic state from the adreno core */
+	adreno_gpu_state_get(gpu, &state->base);
+
+	adreno_snapshot_registers_v2(gpu, state, b->gmu_cx_unsliced_regs);
+
+	a8xx_snapshot_gmu_bo(state, &a6xx_gpu->gmu.log, SNAPSHOT_GMU_MEM_LOG);
+	a8xx_snapshot_gmu_bo(state, &a6xx_gpu->gmu.hfi, SNAPSHOT_GMU_MEM_HFI);
+	a8xx_snapshot_gmu_bo(state, &a6xx_gpu->gmu.debug, SNAPSHOT_GMU_MEM_DEBUG);
+
+	a8xx_snapshot_gmu_hfi_history(gpu, state);
+
+	snapshot_sect (state, DEBUG, 4, {
+		.type = SNAPSHOT_DEBUG_SLICE_MASK,
+		.size = 1,
+	}) {
+		snapshot_sect_u32(&sect, a6xx_gpu->slice_mask);
+	}
+	gen8_snapshot_cx_debugbus(gpu, state);
+
+	/* If GX isn't on the rest of the data isn't going to be accessible */
+	if (!a6xx_gmu_gx_is_on(adreno_gpu))
+		return &state->base;
+
+	gen8_snapshot_debugbus(gpu, state);
+
+	/*
+	 * Try to initialize the crashdumper, if we are not dumping state
+	 * with the SMMU stalled.  The crashdumper needs memory access to
+	 * write out GPU state, so we need to skip this when the SMMU is
+	 * stalled in response to an iova fault
+	 */
+	bool stalled = !!(gpu_read(gpu, REG_A8XX_RBBM_MISC_STATUS) &
+			A8XX_RBBM_MISC_STATUS_SMMU_STALLED_ON_FAULT);
+	if (!stalled && !gpu->needs_hw_init &&
+	    !a8xx_crashdumper_init(gpu, &_dumper)) {
+		dumper = &_dumper;
+	}
+
+	/* Clear aperture register */
+	a8xx_aperture_clear(gpu);
+
+	/*
+	 * Assert the isStatic bit before triggering snapshot.
+	 * BIT(0): GPU activity during snapshot dump
+	 * BIT(1): GPU UNSLICE activity during snapshot dump
+	 * Similarly, BIT(4) for slice-0, BIT(5) for slice-1 and so on.
+	 */
+	gpu_write(gpu, REG_A8XX_RBBM_SNAPSHOT_STATUS, BIT(0) | BIT(1) |
+			FIELD_PREP(GENMASK(7, 4), a6xx_gpu->slice_mask));
+
+	/* Dump the registers which get affected by crash dumper trigger */
+	for (int i = 0; i < b->num_pre_crashdumper_regs; i++) {
+		const struct gen8_reg_list *regs = &b->pre_crashdumper_regs[i];
+		u32 j;
+
+		FOR_EACH_SLICE (j, regs->slice_region, a6xx_gpu->slice_mask) {
+			u32 slice_id = SLICE_ID(regs->slice_region, j);
+			gen8_legacy_snapshot_registers(gpu, state, regs, slice_id);
+		}
+	}
+
+	/*
+	 * If crashdumper timed out while dumping this section skip everything
+	 * since even AHB acceses to the GPU might cause NoC errors.
+	 */
+	if (!gen8_reglist_snapshot(gpu, state, dumper))
+		goto out;
+
+	/* CP indexed regs data */
+	if (!gen8_snapshot_cp_indexed_regs(gpu, state, dumper))
+		goto out;
+
+	/* Mempool debug data */
+	if (!gen8_snapshot_mempool(gpu, state, dumper))
+		goto out;
+
+	/*
+	 * CP MVC register section
+	 * If crashdumper timed out while dumping any section below skip everything
+	 * since even AHB acceses to the GPU might cause NoC errors.
+	 */
+	if (!gen8_snapshot_mvc_regs(gpu, state, dumper, b->cp_clusters, b->num_cp_clusters))
+		goto out;
+
+	/* MVC register section */
+	if (!gen8_snapshot_mvc_regs(gpu, state, dumper, b->clusters, b->num_clusters))
+		goto out;
+
+	/* registers dumped through DBG AHB */
+	if (!gen8_snapshot_dbgahb_regs(gpu, state, dumper))
+		goto out;
+
+	/* Shader memory */
+	if (!gen8_snapshot_shader(gpu, state, dumper))
+		goto out;
+
+	/*
+	 * Capture preempt records after cp_clusters, to make this easier
+	 * to decode (ie. so we already know CP_CONTEXT_SWITCH_SMMU_INFO and
+	 * CP_CONTEXT_SWITCH_PRIV_NON_SECURE_RESTORE_ADDR) when crashdec sees
+	 * the logged GPU objs)
+	 */
+	for (unsigned i = 0; i < gpu->nr_rings; i++) {
+		a8xx_snapshot_gpu_bo(state, a6xx_gpu->preempt_bo[i],
+				     a6xx_gpu->preempt_iova[i]);
+		a8xx_snapshot_gpu_bo(state, a6xx_gpu->preempt_smmu_bo[i],
+				     a6xx_gpu->preempt_smmu_iova[i]);
+	}
+
+out:
+	gpu_write(gpu, REG_A8XX_RBBM_SNAPSHOT_STATUS, 0x0);
+
+	if (dumper)
+		msm_gem_kernel_put(dumper->bo, gpu->vm);
+
+	state->gpu_initialized = !gpu->needs_hw_init;
+
+	return  &state->base;
+}
+
+static void a8xx_gpu_state_destroy(struct kref *kref)
+{
+	struct adreno_state_memobj *obj, *tmp;
+	struct msm_gpu_state *state = container_of(kref,
+			struct msm_gpu_state, ref);
+	struct adreno_gpu_state *adreno_state = container_of(state,
+			struct adreno_gpu_state, base);
+
+	list_for_each_entry_safe (obj, tmp, &adreno_state->objs, node) {
+		list_del(&obj->node);
+		kvfree(obj->ptr);
+		kfree(obj);
+	}
+
+	adreno_gpu_state_destroy(state);
+	kfree(adreno_state);
+}
+
+int a8xx_gpu_state_put(struct msm_gpu_state *state)
+{
+	if (IS_ERR_OR_NULL(state))
+		return 1;
+
+	return kref_put(&state->ref, a8xx_gpu_state_destroy);
+}
+
+void a8xx_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
+		struct drm_printer *p)
+{
+	struct adreno_gpu_state *adreno_state = container_of(state,
+			struct adreno_gpu_state, base);
+	struct adreno_state_memobj *obj;
+
+	if (IS_ERR_OR_NULL(state))
+		return;
+
+	drm_printf(p, "gpu-initialized: %d\n", adreno_state->gpu_initialized);
+
+	adreno_show(gpu, state, p);
+
+	drm_puts(p, "gmu-hfi:\n");
+	for (int i = 0; i < ARRAY_SIZE(adreno_state->hfi_queue_history); i++) {
+		drm_printf(p, "    queue-history[%u]:", i);
+		for (int j = 0; j < HFI_HISTORY_SZ; j++) {
+			drm_printf(p, " %d", adreno_state->hfi_queue_history[i][j]);
+		}
+		drm_printf(p, "\n");
+	}
+
+	/*
+	 * Parsing note: do not assume each snapshot obj is only a single
+	 * section, assume sub-allocation.
+	 */
+	drm_puts(p, "snapshot:\n");
+	list_for_each_entry (obj, &adreno_state->objs, node) {
+		drm_printf(p, "    size: %zu\n", obj->size);
+		adreno_show_object(p, &obj->ptr, obj->size, &obj->encoded);
+	}
+}
diff --git a/drivers/gpu/drm/msm/adreno/adreno_snapshot.h b/drivers/gpu/drm/msm/adreno/adreno_snapshot.h
index f9956e0bc1d5..1c56be7249f7 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_snapshot.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_snapshot.h
@@ -7,6 +7,8 @@
 
 #include <linux/types.h>
 
+#include "msm_gpu.h"
+
 /* Snapshot header */
 
 /* High word is static, low word is snapshot version ID */
@@ -150,6 +152,7 @@ struct adreno_snapshot_gmu_mem {
 	uint64_t gmuaddr;
 	uint64_t gpuaddr;
 } __packed;
+#define STRUCT_GMU_MEMORY adreno_snapshot_gmu_mem
 
 /* Register sub-section header */
 struct adreno_snapshot_regs {
@@ -172,6 +175,7 @@ struct adreno_snapshot_indexed_regs_v2 {
 	u32 pipe_id;	/* Id of pipe, BV, Br etc */
 	u32 slice_id;	/* Slice ID to be dumped */
 } __packed;
+#define STRUCT_INDEXED_REGS_V2 adreno_snapshot_indexed_regs_v2
 
 /* MVC register sub-section header */
 struct adreno_snapshot_mvc_regs {
@@ -195,6 +199,7 @@ struct adreno_snapshot_mvc_regs_v3 {
 	u32 sp_id;
 	u32 usptp_id;
 } __packed;
+#define STRUCT_MVC_V3 adreno_snapshot_mvc_regs_v3
 
 /* Debug data sub-section header */
 
@@ -222,17 +227,20 @@ struct adreno_snapshot_debug {
 	int type;    /* Type identifier for the attached tata */
 	int size;   /* Size of the section in dwords */
 } __packed;
+#define STRUCT_DEBUG adreno_snapshot_debug
 
 struct adreno_snapshot_debugbus {
 	int id;	   /* Debug bus ID */
 	int count; /* Number of dwords in the dump */
 } __packed;
+#define STRUCT_DEBUGBUS adreno_snapshot_debugbus
 
 struct adreno_snapshot_side_debugbus {
 	int id;   /* Debug bus ID */
 	int size; /* Number of dwords in the dump */
 	int valid_data;  /* Mask of valid bits of the side debugbus */
 } __packed;
+#define STRUCT_SIDE_DEBUGBUS adreno_snapshot_side_debugbus
 
 struct adreno_snapshot_shader {
 	int type;  /* SP/TP statetype */
@@ -259,6 +267,7 @@ struct adreno_snapshot_shader_v3 {
 	u32 ctxt_id; /* Context ID */
 	u32 size;  /* Number of dwords in the dump */
 } __packed;
+#define STRUCT_SHADER_V3 adreno_snapshot_shader_v3
 
 #define TRACE_BUF_NUM_SIG 4
 
@@ -302,6 +311,7 @@ struct adreno_snapshot_gpu_object_v2 {
 	__u64 ptbase;  /* Base for the pagetable the GPU address is valid in */
 	__u64 size;    /* Size of the object (in dwords) */
 } __packed;
+#define STRUCT_GPU_OBJECT_V2 adreno_snapshot_gpu_object_v2
 
 struct adreno_snapshot_eventlog {
 	/** @type: Type of the event log buffer */
@@ -319,3 +329,202 @@ struct adreno_snapshot_gmu_version {
 	u32 value;
 } __packed;
 
+struct adreno_snapshot_empty_header { u8 dummy; };
+#define STRUCT_REGS_V2 adreno_snapshot_debugbus
+
+#define REG_COUNT(_ptr) ((_ptr[1] - _ptr[0]) + 1)
+
+static int adreno_snapshot_regs_count(const u32 *ptr)
+{
+	unsigned int count = 0;
+	unsigned int group_count;
+
+	for ( ; ptr[0] != UINT_MAX; ptr += 2) {
+		group_count = REG_COUNT(ptr);
+		if (group_count == 1)
+			count += group_count + 1;
+		else
+			count += group_count + 2;
+	}
+	return count;
+}
+
+struct adreno_gpu_state {
+	struct msm_gpu_state base;
+
+	s32 hfi_queue_history[HFI_MAX_QUEUES][HFI_HISTORY_SZ];
+
+	/* list of struct adreno_state_memobj */
+	struct list_head objs;
+
+	bool gpu_initialized;
+};
+
+struct adreno_state_memobj {
+	struct list_head node;
+	void *ptr;	/* replaced by ascii85 encoded string in adreno_show_object() */
+	bool encoded;
+	size_t size;
+};
+
+/**
+ * A on-stack helper to build snapshot sections setting the size field when the
+ * helper goes out of scope, to simplify constructing snapshot sections, but
+ * without resorting to the callback approach that kgsl uses.
+ */
+struct adreno_snapshot_sect {
+	struct adreno_state_memobj *obj;
+	void *cur, *end;
+};
+
+static void __snapshot_sect_fini(struct adreno_snapshot_sect *s)
+{
+	if (!s->obj)
+		return;
+	struct adreno_snapshot_section_header *hdr = (void *)s->obj->ptr;
+	hdr->size = s->obj->size = ((u8 *)s->cur - (u8 *)s->obj->ptr);
+}
+
+DEFINE_FREE(sect_fini, struct adreno_snapshot_sect, __snapshot_sect_fini(&_T));
+
+static struct adreno_snapshot_sect
+__snapshot_sect_init(struct adreno_gpu_state *state, uint16_t id, size_t extra_sz,
+		     void *sect_hdr, size_t sect_hdr_sz, const char *func, int line)
+{
+	/* A few section types have no section header: */
+	switch (id) {
+	case ADRENO_SNAPSHOT_SECTION_REGS_V2:
+		sect_hdr_sz = 0;
+		break;
+	default:
+		break;
+	}
+
+	pr_debug("%s:%d: snapshot_sect(id=%04x, extra_sz=%zu, sect_hdr_sz=%zu)\n",
+		 func, line, id, extra_sz, sect_hdr_sz);
+
+	size_t sz = sizeof(struct adreno_snapshot_section_header) + sect_hdr_sz + extra_sz;
+	struct adreno_state_memobj *obj = kzalloc_obj(*obj);
+	void *ptr = kvzalloc(sz, GFP_KERNEL);
+
+	if (!obj || !ptr) {
+		kfree(obj);
+		kvfree(ptr);
+		return (struct adreno_snapshot_sect){};
+	}
+
+	obj->ptr = ptr;
+
+	list_add_tail(&obj->node, &state->objs);
+
+	/* Common snapshot section header: */
+	struct adreno_snapshot_section_header *hdr = ptr;
+	hdr->magic = SNAPSHOT_SECTION_MAGIC;
+	hdr->id = id;
+	/* size filled out in __snapshot_sect_fini() */
+	ptr += sizeof(*hdr);
+
+	/* Section type header: */
+	memcpy(ptr, sect_hdr, sect_hdr_sz);
+	ptr += sect_hdr_sz;
+
+	return (struct adreno_snapshot_sect) {
+		.obj = obj,
+		.cur = ptr,
+		.end = ptr + extra_sz,
+	};
+}
+
+static void
+snapshot_sect_data(struct adreno_snapshot_sect *s, const void *data, size_t sz)
+{
+	/* overflow check: */
+	if (WARN_ON_ONCE(s->cur + sz > s->end))
+		return;
+
+	memcpy(s->cur, data, sz);
+	s->cur += sz;
+}
+
+#define snapshot_sect_arr(_s, _d) snapshot_sect_data(_s, _d, sizeof(_d))
+
+static void
+snapshot_sect_u32(struct adreno_snapshot_sect *s, u32 val)
+{
+	snapshot_sect_data(s, &val, sizeof(val));
+}
+
+#define __snapshot_sect(_label, _state, _id, _extra_sz, ...)		\
+	for (struct adreno_snapshot_sect sect __free(sect_fini) = ({	\
+		struct STRUCT_ ## _id sect_hdr = __VA_ARGS__;		\
+		__snapshot_sect_init(_state, ADRENO_SNAPSHOT_SECTION_ ## _id,	\
+				     _extra_sz, &sect_hdr, 		\
+				     sizeof(sect_hdr), 			\
+				     __func__, __LINE__); });		\
+	     sect.obj; ({ goto _label; }))				\
+		if (false) {						\
+_label:									\
+			break;						\
+		} else
+
+#define snapshot_sect(_id, _extra_sz, ...) \
+	__snapshot_sect(__UNIQUE_ID(label), _id, _extra_sz, __VA_ARGS__)
+
+struct adreno_crashdumper {
+	void *ptr;
+	size_t data_offset;
+	struct drm_gem_object *bo;
+	u64 iova;
+};
+
+/**
+ * On-stack object to represent a single crashdumper invocation, tracking
+ * in/out ptrs and checking for overflow.
+ */
+struct cd_script {
+	struct adreno_crashdumper *dumper;
+	u64 *in;
+	u64 out;
+};
+
+/* These should be implemented by the gen specific backend: */
+static inline int __cd_run(struct msm_gpu *gpu, struct adreno_crashdumper *dumper);
+static inline bool __cd_check_overflow(struct cd_script *p);
+
+static inline struct cd_script CD_INIT(struct adreno_crashdumper *dumper)
+{
+	return (struct cd_script) {
+		.dumper = dumper,
+		.in = dumper->ptr,
+		.out = dumper->iova + dumper->data_offset,
+	};
+}
+
+static inline void CD_WRITE(struct cd_script *p, u32 reg, u32 val)
+{
+	*(p->in++) = val;
+	*(p->in++) = FIELD_PREP(GENMASK_U64(63, 44), reg) | BIT(21) | BIT(0);
+	__cd_check_overflow(p);
+}
+
+static inline void CD_READ(struct cd_script *p, u32 reg, u32 dwords)
+{
+	*(p->in++) = p->out;
+	*(p->in++) = FIELD_PREP(GENMASK_U64(63, 44), reg) | dwords;
+	p->out += sizeof(u32) * dwords;
+	__cd_check_overflow(p);
+}
+
+static void CD_FINISH(struct cd_script *p)
+{
+	*(p->in++) = 0;
+	*(p->in++) = 0;
+	__cd_check_overflow(p);
+}
+
+static int CD_RUN(struct cd_script *p, struct msm_gpu *gpu)
+{
+	if (!__cd_check_overflow(p))
+		return -ENOSPC;
+	return __cd_run(gpu, p->dumper);
+}
diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
index cf2fb20203b7..aa639de60ace 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
@@ -5086,6 +5086,7 @@ by a particular renderpass/blit.
 	<reg32 offset="0x0005" name="CFG_DBGBUS_CNTLM">
 		<bitfield high="27" low="24" name="ENABLE"/>
 	</reg32>
+	<reg32 offset="0x0006" name="CFG_DBGBUS_OPL"/>
 	<reg32 offset="0x0008" name="CFG_DBGBUS_IVTL_0"/>
 	<reg32 offset="0x0009" name="CFG_DBGBUS_IVTL_1"/>
 	<reg32 offset="0x000a" name="CFG_DBGBUS_IVTL_2"/>
@@ -5115,8 +5116,11 @@ by a particular renderpass/blit.
 		<bitfield high="31" low="28" name="BYTEL15"/>
 	</reg32>
 
+	<reg32 offset="0x001e" name="CFG_DBGBUS_IDX"/>
+	<reg32 offset="0x0026" name="CFG_DBGBUS_OVER"/>
 	<reg32 offset="0x002f" name="CFG_DBGBUS_TRACE_BUF1"/>
 	<reg32 offset="0x0030" name="CFG_DBGBUS_TRACE_BUF2"/>
+	<reg32 offset="0x0031" name="CFG_DBGBUS_TRACE_BUF3"/>
 </domain>
 
 <domain name="A7XX_CX_DBGC" width="32" varset="chip">
-- 
2.56.0

