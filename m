Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC576C5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 04:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A3B10E634;
	Mon, 17 Aug 2026 04:49:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZrOK7LfC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jKhoCWZG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E588610E634
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:49:49 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLDB101386175
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FrfL64kJYZh5HPEZI2wdda+/4ACO5iqKRMp1ZpUe38w=; b=ZrOK7LfC2DoNZY0d
 w0XFNKL7PHwKV80Td233SPNTE4lWdz90ByuMH5eN68gXLZPd/Lp0Tbu7IhkvSI+6
 k9/KbSIvIFmX1Cal7b7/523qVZHoDDoDqt0EnheD95ZEdlGIVqCVkWxC4ENzfadr
 Jubgbpr/wp5aMQEom4be3AT4b7FQ9rslsLyXcTYhv4n8w8DzWOX9aajQqRcXvUmc
 aW2gxCqbHntt6t8z5spjiMtgtFA56rpITeHLe/pqCtHqWG4g2pE3+dvN+m7Nw6JY
 rFKdFEu/F6SIDOOjlDfM8A+4TFfK2xLRBe2rC7DEOZb/LEf97gLMiGkNdJJSZBFh
 Meibeg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3mx4rujj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:49:49 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84865f326efso3044952b3a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 21:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786942188; x=1787546988;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FrfL64kJYZh5HPEZI2wdda+/4ACO5iqKRMp1ZpUe38w=;
 b=jKhoCWZGi2Qu0WwpTjuyQxjAWb+j0UoWZk5zi5kdPPJAXgZpnIhf54cyMEECx5uxZ4
 McsWn4jn27LCdHFBkDHj+DgXeJPDxmxl5AC4QKjhRsNrN5qC+AelMjpuQS7Q3572f4DN
 QBCzb60bhIBC+VSx2ICVSh3GxMnq/2e79dsjQaNUhs9NhuZUnrEW82rwyn/3uF9JcHYL
 3TNukyvYUQatBGTc0ip7L3voceAGLtcFVTfwNvpwO9Ny3rpb4igHuXB+WXmVcXC2a77T
 v30JifdF9jtWa6bGla3HToAhWRqyNCeWfuduBlMehtCa4cLDqg5tj4csluLZru2DRo2i
 u5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786942188; x=1787546988;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FrfL64kJYZh5HPEZI2wdda+/4ACO5iqKRMp1ZpUe38w=;
 b=BimBiI/m6TUTaURGELnojKAdibMEwfiRP2iZbMu8CZ62PcinzVCbZ6Z31pkqOE0oWf
 zq42TfUapGUgOYQ0usvDKvlm8sxMWt/DVO57ZY9WwaorZ/RJGt/ZH3mO0Ax8IESoCMII
 4DZNQvoMANreARCphuPtQ0UF4A4+FeN4fcmvwLH2NlDfZfeaJOOutg/0KvMp+nlePJLa
 TjzuPS8wPS0yj0Dp2KYfDQ4moJZOMGNIXbaJHyg6PLGfaDicjNFne7sYjCteEnbq2X1l
 ztem6NvaMM+kvL5zG1FTZT8qitpiI1JQX9ifQ9jL5Tq+vAJ7ViJph0qZwEygAsOrAPX1
 FnQw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpkViGnQ41YlUhaGTz3BzYYjBMds+zX9BJTkCDeUbNXbm+7/SHjtluVTw17ml2TfgAB3kF481HqxoE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRsGv6dBru0ZEzJyjdO2VER0tolDY1B1WH1X/49yJCpDAzghsc
 Trk7FOgm4WXAmWOsqaXSF/3Nv30Ba1vRm8NzBhce1F/MPEaOUaHoquyEgWDRZjvTdnewyDBS+ai
 +E0u7B4bcfpgO9Y3Iz0Xca9tva31AwvMssRMt9aB0T2Xp1fFi1Ol7ks4fQmSJYvhbVKfJx0w=
X-Gm-Gg: AR+sD13KnEujrUoJB/OPUTddrLYi6t82Qbnjfj+B6PYrQS3vrlmRus+71tAgdT1gS2S
 /O6AQ2fe+ZSbgwIkMT3sgLWAM64V5/ToqLwCBIE5yelR3NVPaBg3w/KTXLaEGIwO9gHNCamzoyj
 EWM/kTwzyA8KOcrPTJnNGXZW7/5P5v+h20vNBoGwtQxBWwl9KdNBEFzi6rJj+in7Yt+VFn3M3XU
 DfZtcr7+hLaMAtwE+BLSFvojhC5fitlU/G5AHZ6QjaeRS36aAqcDIJkYJiq/w+9Dgq3V+2FH/N/
 gq1s3U+jEWLAbV+GIkAPFZN5XwbPqJtSL/IiImKF8ELUdQASuwOU7jytW6c1boqGTXSVpzAQcfB
 43XqEmEFhSUwJGdd6L+aUTHVRo3uCn6DH
X-Received: by 2002:a05:6a00:ae18:b0:851:8394:1696 with SMTP id
 d2e1a72fcca58-851839417c1mr13339192b3a.12.1786942188322; 
 Sun, 16 Aug 2026 21:49:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:ae18:b0:851:8394:1696 with SMTP id
 d2e1a72fcca58-851839417c1mr13339146b3a.12.1786942187714; 
 Sun, 16 Aug 2026 21:49:47 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8517d046638sm2149250b3a.27.2026.08.16.21.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 21:49:47 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 10:17:49 +0530
Subject: [PATCH v2 14/15] accel/qda: Add remote memory mapping to DSP
 address space
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-qda-v2-v2-14-69a02e9090d4@oss.qualcomm.com>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
In-Reply-To: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
To: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com,
 dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786942058; l=19115;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=bgw14BFHPFIoY5A7ZS7MaQSGYbj2NkI30v3H5TVFLLA=;
 b=V1b32EUKKC8BwxWObwp2qu61W5BHdE1eTpwT2d6KuzlV9gwIRnSTUm8/CiTbTWsq+QrEvTR9z
 KFqlF36+FoIALZDWDvjWev114dOrMj9oGL1HiLIKGzDOdT9SIRMKpdZ
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-ORIG-GUID: s_XudzF7zhLpCm18wn34-5uGvls0wPcL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfX1M1REOIA3mSj
 RXLHBBrUTxDxZUXppd39RN8zVtoNogjZQ5edmkh4sYGDFhO1GpnJ3TF6fhN04kXqnT6VM2m57g/
 cPuGngBDqRgt0/WbRknz1JjNXjbEqV0=
X-Proofpoint-GUID: s_XudzF7zhLpCm18wn34-5uGvls0wPcL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfXxHlCRPsuZLUV
 NlzgGkUbHjaKrWWvwhqTAW548SxzwHF9ec2FGSq7phOkawzazoVk64X+Vn+dTd24MZkGIZvZLQt
 JX2MO4r2tbOTrsYdiRKV9kHNIzsyUeJAx1kiUOE3gVMQeI/Lb0bWWR5avb8CLpiLtQ9ucPpPDDQ
 BKo5fOxXgkZHXPkNNxw20DYwf0Et84tzdYbewyXAL3UTaWwrqfXMRfTBMJVoVQVi6pMGEEfeMHG
 lO+b+n9l6LMm7Pb0J2hgajCZPxrXNHsIDDm8uHFdBXNh4L79S/jeNgkv3cmPZpMFJfxNFuLLZJx
 KxodK3ss2iBm2qWoonm7D1/12k/40FSKc++kjzXMmF10SKjXj5qgTH2BHPyjP5wZ8YznRVaK1LS
 DMbh6j7KA9ncEiy/eiO66sIhwqIfLysSzbRI7nN9fBd+hMPW2FvzjMNjJEVogX2du/YxSapzJ4h
 bsPlKeHjKjumZcaZg2w==
X-Authority-Analysis: v=2.4 cv=Y6XIdBeN c=1 sm=1 tr=0 ts=6a8292ed cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=PW8XSVTZ-sbVurbGbLUA:9 a=za0tUL9sr70ECSv5:21
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170033
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

Add DRM_IOCTL_QDA_REMOTE_MAP, which maps a GEM buffer into the DSP
address space of the calling process so the DSP can access it directly
during a remote invocation.

The DSP exposes two mapping operations, both reachable through this
IOCTL and selected by the request field of struct drm_qda_mem_map:

  QDA_REQUEST_MMAP maps a whole buffer, optionally at a caller-supplied
  address hint. It uses the handle, flags, vaddrin and size fields.

  QDA_REQUEST_MEM_MAP maps a region of a buffer with caller-specified
  SMMU attributes, and additionally carries a DSP-side buffer
  identifier. It uses all fields, including attrs and offset.

In both cases the buffer is identified by a GEM handle; user space
imports any DMA-BUF fd to a GEM handle before mapping it. The driver
resolves the handle to its context bank address, describes it to the DSP
as a physical page descriptor, and returns the resulting DSP virtual
address in vaddrout.

The requested length is validated against the size of the backing GEM
object. The offset is validated by the DSP against the region it maps,
since it only ever resolves within the context bank assigned to the
calling process.

qda_fastrpc.c gains a prepare_args builder per request type, each
documented with the packed argument layout the DSP expects, and the
response handler stores the DSP-returned address back into the caller's
argument structure.

Assisted-by: Claude:claude-4-6-sonnet
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/accel/qda/qda_drv.c     |   1 +
 drivers/accel/qda/qda_fastrpc.c | 243 ++++++++++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_fastrpc.h |  56 +++++++++
 drivers/accel/qda/qda_ioctl.c   |  23 ++++
 drivers/accel/qda/qda_ioctl.h   |   1 +
 include/uapi/drm/qda_accel.h    |  45 +++++++-
 6 files changed, 368 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index 4c3a37cbf49e..a29037bf8d63 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -61,6 +61,7 @@ static const struct drm_ioctl_desc qda_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(QDA_GEM_CREATE, qda_ioctl_gem_create, 0),
 	DRM_IOCTL_DEF_DRV(QDA_GEM_MMAP_OFFSET, qda_ioctl_gem_mmap_offset, 0),
 	DRM_IOCTL_DEF_DRV(QDA_REMOTE_SESSION_CREATE, qda_ioctl_init_create, 0),
+	DRM_IOCTL_DEF_DRV(QDA_REMOTE_MAP, qda_ioctl_mmap, 0),
 	DRM_IOCTL_DEF_DRV(QDA_REMOTE_INVOKE, qda_ioctl_invoke, 0),
 };
 
diff --git a/drivers/accel/qda/qda_fastrpc.c b/drivers/accel/qda/qda_fastrpc.c
index 2c72f86130aa..6bd706b9dad2 100644
--- a/drivers/accel/qda/qda_fastrpc.c
+++ b/drivers/accel/qda/qda_fastrpc.c
@@ -410,6 +410,70 @@ int qda_fastrpc_invoke_pack(struct qda_fastrpc_invoke_ctx *ctx, struct qda_msg *
 	return 0;
 }
 
+/**
+ * qda_fastrpc_return_result() - Propagate invocation results to the ioctl data
+ * @ctx: FastRPC invocation context
+ * @argp: Kernel-side ioctl argument buffer owned by the DRM core
+ *
+ * Every buffer argument is GEM backed, so the DSP writes its results straight
+ * into DMA-coherent memory that both sides can see and no copy back is needed.
+ * Only the mapping calls have to surface a value from the response buffer.
+ */
+void qda_fastrpc_return_result(struct qda_fastrpc_invoke_ctx *ctx, void *argp)
+{
+	struct fastrpc_map_rsp_msg *rsp_msg;
+	struct drm_qda_mem_map *margs;
+
+	switch (ctx->type) {
+	case FASTRPC_RMID_INIT_MMAP:
+	case FASTRPC_RMID_INIT_MEM_MAP:
+		rsp_msg = ctx->rsp;
+		margs = argp;
+		margs->vaddrout = rsp_msg->vaddrout;
+		break;
+	default:
+		break;
+	}
+}
+
+/*
+ * Fill in a physical page descriptor from a GEM handle.  The reference taken
+ * by the lookup is dropped again here; the handle table keeps the object alive
+ * for the duration of the invocation.
+ */
+static int setup_mmap_pages(struct qda_fastrpc_invoke_ctx *ctx, u32 gem_handle,
+			    u64 len, struct fastrpc_phy_page *pages)
+{
+	struct drm_gem_object *gem_obj;
+	struct qda_gem_obj *qda_gem_obj;
+	int err;
+
+	if (!gem_handle) {
+		pages->addr = 0;
+		pages->size = 0;
+		return 0;
+	}
+
+	err = get_gem_obj_from_handle(ctx, gem_handle, &gem_obj);
+	if (err)
+		return err;
+
+	qda_gem_obj = to_qda_gem_obj(gem_obj);
+
+	/* The requested region must fit within the backing GEM object */
+	if (len > qda_gem_obj->size) {
+		drm_gem_object_put(gem_obj);
+		return -EINVAL;
+	}
+
+	pages->addr = qda_gem_obj->dma_addr;
+	pages->size = len ? len : qda_gem_obj->size;
+
+	drm_gem_object_put(gem_obj);
+
+	return 0;
+}
+
 /*
  * INIT_RELEASE packed layout:
  *   [0] remote_session_id	sizeof(int)	IN
@@ -573,6 +637,179 @@ static int qda_fastrpc_prepare_args_init_create(struct qda_fastrpc_invoke_ctx *c
 	return err;
 }
 
+/*
+ * INIT_MMAP packed layout:
+ *   [0] req_msg		sizeof(fastrpc_map_req_msg)	IN
+ *   [1] input_pages	sizeof(fastrpc_phy_page)	IN
+ *   [2] rsp_msg	sizeof(fastrpc_map_rsp_msg)	OUT
+ */
+static int qda_fastrpc_prepare_args_map(struct qda_fastrpc_invoke_ctx *ctx, void *argp)
+{
+	struct fastrpc_map_req_msg *req_msg;
+	struct fastrpc_map_rsp_msg *rsp_msg;
+	struct drm_qda_fastrpc_invoke_args *args;
+	struct drm_qda_mem_map *margs = argp;
+	struct qda_gem_obj *kernel_gem;
+	u32 nscalars;
+	int err;
+	u8 *gv;
+
+	const size_t off_req = 0;
+	const size_t off_pages = off_req + sizeof(*req_msg);
+	const size_t off_rsp = off_pages + sizeof(struct fastrpc_phy_page);
+	const size_t total_size = off_rsp + sizeof(*rsp_msg);
+
+	ctx->sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MMAP, 2, 1);
+	ctx->handle = FASTRPC_INIT_HANDLE;
+	nscalars = REMOTE_SCALARS_LENGTH(ctx->sc);
+
+	args = kzalloc_objs(*args, nscalars);
+	if (!args)
+		return -ENOMEM;
+
+	ctx->gem_objs = kzalloc_objs(*ctx->gem_objs, nscalars);
+	if (!ctx->gem_objs) {
+		err = -ENOMEM;
+		goto err_free_args;
+	}
+
+	kernel_gem = alloc_kernel_gem(ctx, total_size);
+	if (IS_ERR(kernel_gem)) {
+		err = PTR_ERR(kernel_gem);
+		goto err_free_gem_objs;
+	}
+	gv = kernel_gem->virt;
+
+	req_msg = (struct fastrpc_map_req_msg *)(gv + off_req);
+	req_msg->remote_session_id = ctx->remote_session_id;
+	req_msg->flags = margs->flags;
+	req_msg->vaddr = margs->vaddrin;
+	req_msg->num = sizeof(struct fastrpc_phy_page);
+
+	ctx->input_pages = (struct fastrpc_phy_page *)(gv + off_pages);
+	err = setup_mmap_pages(ctx, margs->handle, margs->size, ctx->input_pages);
+	if (err)
+		goto err_free_kernel_gem;
+
+	/* Already zeroed; the DSP writes vaddrout here */
+	rsp_msg = (struct fastrpc_map_rsp_msg *)(gv + off_rsp);
+
+	assign_kernel_gem_arg(args, ctx->gem_objs, 0, kernel_gem,
+			      gv + off_req, sizeof(*req_msg));
+	assign_kernel_gem_arg(args, ctx->gem_objs, 1, kernel_gem,
+			      gv + off_pages, sizeof(struct fastrpc_phy_page));
+	assign_kernel_gem_arg(args, ctx->gem_objs, 2, kernel_gem,
+			      gv + off_rsp, sizeof(*rsp_msg));
+
+	drm_gem_object_put(&kernel_gem->base);
+
+	ctx->args = args;
+	ctx->req = req_msg;
+	ctx->rsp = rsp_msg;
+
+	return 0;
+
+err_free_kernel_gem:
+	drm_gem_object_put(&kernel_gem->base);
+err_free_gem_objs:
+	kfree(ctx->gem_objs);
+	ctx->gem_objs = NULL;
+err_free_args:
+	kfree(args);
+
+	return err;
+}
+
+/*
+ * INIT_MEM_MAP packed layout:
+ *   [0] req_msg		sizeof(fastrpc_mem_map_req_msg)	IN
+ *   [1] input_pages	sizeof(fastrpc_phy_page)	IN
+ *   [2] zero-length	0 bytes, required by the DSP	IN
+ *   [3] rsp_msg	sizeof(fastrpc_map_rsp_msg)	OUT
+ */
+static int qda_fastrpc_prepare_args_mem_map_attr(struct qda_fastrpc_invoke_ctx *ctx, void *argp)
+{
+	struct fastrpc_mem_map_req_msg *req_msg;
+	struct fastrpc_map_rsp_msg *rsp_msg;
+	struct drm_qda_fastrpc_invoke_args *args;
+	struct drm_qda_mem_map *margs = argp;
+	struct qda_gem_obj *kernel_gem;
+	u32 nscalars;
+	int err;
+	u8 *gv;
+
+	const size_t off_req = 0;
+	const size_t off_pages = off_req + sizeof(*req_msg);
+	const size_t off_rsp = off_pages + sizeof(struct fastrpc_phy_page);
+	const size_t total_size = off_rsp + sizeof(*rsp_msg);
+
+	ctx->sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_MAP, 3, 1);
+	ctx->handle = FASTRPC_INIT_HANDLE;
+	nscalars = REMOTE_SCALARS_LENGTH(ctx->sc);
+
+	args = kzalloc_objs(*args, nscalars);
+	if (!args)
+		return -ENOMEM;
+
+	ctx->gem_objs = kzalloc_objs(*ctx->gem_objs, nscalars);
+	if (!ctx->gem_objs) {
+		err = -ENOMEM;
+		goto err_free_args;
+	}
+
+	kernel_gem = alloc_kernel_gem(ctx, total_size);
+	if (IS_ERR(kernel_gem)) {
+		err = PTR_ERR(kernel_gem);
+		goto err_free_gem_objs;
+	}
+	gv = kernel_gem->virt;
+
+	req_msg = (struct fastrpc_mem_map_req_msg *)(gv + off_req);
+	req_msg->remote_session_id = ctx->remote_session_id;
+	req_msg->handle = margs->dsp_handle;
+	req_msg->offset = margs->offset;
+	req_msg->flags = margs->flags;
+	req_msg->vaddrin = margs->vaddrin;
+	req_msg->num = sizeof(struct fastrpc_phy_page);
+	req_msg->data_len = 0;
+
+	ctx->input_pages = (struct fastrpc_phy_page *)(gv + off_pages);
+	err = setup_mmap_pages(ctx, margs->handle, margs->size, ctx->input_pages);
+	if (err)
+		goto err_free_kernel_gem;
+
+	/* Already zeroed; the DSP writes vaddrout here */
+	rsp_msg = (struct fastrpc_map_rsp_msg *)(gv + off_rsp);
+
+	assign_kernel_gem_arg(args, ctx->gem_objs, 0, kernel_gem,
+			      gv + off_req, sizeof(*req_msg));
+	assign_kernel_gem_arg(args, ctx->gem_objs, 1, kernel_gem,
+			      gv + off_pages, sizeof(struct fastrpc_phy_page));
+	/* Zero-length entry required by the DSP protocol */
+	assign_kernel_gem_arg(args, ctx->gem_objs, 2, kernel_gem,
+			      gv + off_pages, 0);
+	assign_kernel_gem_arg(args, ctx->gem_objs, 3, kernel_gem,
+			      gv + off_rsp, sizeof(*rsp_msg));
+
+	drm_gem_object_put(&kernel_gem->base);
+
+	ctx->args = args;
+	ctx->req = req_msg;
+	ctx->rsp = rsp_msg;
+
+	return 0;
+
+err_free_kernel_gem:
+	drm_gem_object_put(&kernel_gem->base);
+err_free_gem_objs:
+	kfree(ctx->gem_objs);
+	ctx->gem_objs = NULL;
+err_free_args:
+	kfree(args);
+
+	return err;
+}
+
 /*
  * INVOKE_DYNAMIC: the argument descriptors are supplied by user space, which
  * is also responsible for having imported every buffer to a GEM handle.
@@ -625,6 +862,12 @@ int qda_fastrpc_prepare_args(struct qda_fastrpc_invoke_ctx *ctx, void *argp)
 		ctx->pd = QDA_USER_PD;
 		err = qda_fastrpc_prepare_args_init_create(ctx, argp);
 		break;
+	case FASTRPC_RMID_INIT_MMAP:
+		err = qda_fastrpc_prepare_args_map(ctx, argp);
+		break;
+	case FASTRPC_RMID_INIT_MEM_MAP:
+		err = qda_fastrpc_prepare_args_mem_map_attr(ctx, argp);
+		break;
 	case FASTRPC_RMID_INVOKE_DYNAMIC:
 		err = qda_fastrpc_prepare_args_invoke(ctx, argp);
 		break;
diff --git a/drivers/accel/qda/qda_fastrpc.h b/drivers/accel/qda/qda_fastrpc.h
index 6beaa9538983..0c1264380085 100644
--- a/drivers/accel/qda/qda_fastrpc.h
+++ b/drivers/accel/qda/qda_fastrpc.h
@@ -250,8 +250,10 @@ struct qda_msg {
 
 /* Remote Method ID table - identifies initialization and control operations */
 #define FASTRPC_RMID_INIT_RELEASE	1	/* Release DSP process */
+#define FASTRPC_RMID_INIT_MMAP		4	/* Map memory region to DSP */
 #define FASTRPC_RMID_INIT_CREATE	6	/* Create DSP process */
 #define FASTRPC_RMID_INIT_CREATE_ATTR	7	/* Create DSP process with attributes */
+#define FASTRPC_RMID_INIT_MEM_MAP	10	/* Map DMA buffer with attributes to DSP */
 #define FASTRPC_RMID_INVOKE_DYNAMIC	0xFFFFFFFFU	/* Dynamic method invocation */
 
 /* Common handle for initialization operations */
@@ -266,6 +268,59 @@ struct qda_msg {
 /* Maximum initialization file size (4 MB) */
 #define FASTRPC_INIT_FILELEN_MAX	(4 * 1024 * 1024)
 
+/* Message structures for internal FastRPC calls */
+
+/**
+ * struct fastrpc_mem_map_req_msg - Memory map request message with attributes
+ *
+ * This message structure is sent to the DSP to request mapping
+ * of a DMA buffer with custom attributes (ATTR request).
+ */
+struct fastrpc_mem_map_req_msg {
+	/** @remote_session_id: Client identifier for the session */
+	s32 remote_session_id;
+	/** @handle: Handle of the buffer to map */
+	s32 handle;
+	/** @offset: Byte offset within the buffer */
+	s32 offset;
+	/** @flags: Mapping flags (cache attributes, permissions) */
+	u32 flags;
+	/** @vaddrin: Virtual address hint for the DSP mapping */
+	u64 vaddrin;
+	/** @num: Size of the physical page descriptor array in bytes */
+	s32 num;
+	/** @data_len: Length of additional inline data */
+	s32 data_len;
+};
+
+/**
+ * struct fastrpc_map_req_msg - Legacy memory map request message
+ *
+ * This message structure is sent to the DSP to request mapping
+ * of a DMA buffer into the DSP's virtual address space.
+ */
+struct fastrpc_map_req_msg {
+	/** @remote_session_id: Client identifier for the session */
+	s32 remote_session_id;
+	/** @flags: Mapping flags (cache attributes, permissions) */
+	u32 flags;
+	/** @vaddr: Virtual address hint for the DSP mapping */
+	u64 vaddr;
+	/** @num: Size of the physical page descriptor array in bytes */
+	s32 num;
+};
+
+/**
+ * struct fastrpc_map_rsp_msg - Memory map response message
+ *
+ * This message structure is returned by the DSP after successfully
+ * mapping a buffer, providing the virtual address for future access.
+ */
+struct fastrpc_map_rsp_msg {
+	/** @vaddrout: DSP virtual address assigned to the mapped buffer */
+	u64 vaddrout;
+};
+
 void qda_fastrpc_context_free(struct kref *ref);
 void qda_fastrpc_cleanup_handlelist(struct qda_fastrpc_invoke_ctx *ctx);
 void qda_fastrpc_flush_pending(struct qda_dev *qdev);
@@ -273,5 +328,6 @@ struct qda_fastrpc_invoke_ctx *qda_fastrpc_context_alloc(struct qda_dev *qdev);
 int qda_fastrpc_prepare_args(struct qda_fastrpc_invoke_ctx *ctx, void *argp);
 size_t qda_fastrpc_get_header_size(struct qda_fastrpc_invoke_ctx *ctx);
 int qda_fastrpc_invoke_pack(struct qda_fastrpc_invoke_ctx *ctx, struct qda_msg *msg);
+void qda_fastrpc_return_result(struct qda_fastrpc_invoke_ctx *ctx, void *argp);
 
 #endif /* __QDA_FASTRPC_H__ */
diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
index 34b71b82a020..3ff6b598ee78 100644
--- a/drivers/accel/qda/qda_ioctl.c
+++ b/drivers/accel/qda/qda_ioctl.c
@@ -177,6 +177,7 @@ static int qda_fastrpc_invoke(u32 type, struct drm_device *dev, void *data,
 	}
 
 	qda_fastrpc_cleanup_handlelist(ctx);
+	qda_fastrpc_return_result(ctx, data);
 
 	/*
 	 * The DSP has torn down the protection domain, so the initialisation
@@ -231,6 +232,28 @@ int qda_release_dsp_process(struct qda_dev *qdev, struct drm_file *file_priv)
 	return qda_fastrpc_invoke(FASTRPC_RMID_INIT_RELEASE, &qdev->drm_dev, NULL, file_priv);
 }
 
+/**
+ * qda_ioctl_mmap() - Map memory to DSP address space
+ * @dev: DRM device structure
+ * @data: User-space data (struct drm_qda_mem_map)
+ * @file_priv: DRM file private data
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_ioctl_mmap(struct drm_device *dev, void *data, struct drm_file *file_priv)
+{
+	struct drm_qda_mem_map *map_req = data;
+
+	switch (map_req->request) {
+	case QDA_REQUEST_MMAP:
+		return qda_fastrpc_invoke(FASTRPC_RMID_INIT_MMAP, dev, data, file_priv);
+	case QDA_REQUEST_MEM_MAP:
+		return qda_fastrpc_invoke(FASTRPC_RMID_INIT_MEM_MAP, dev, data, file_priv);
+	default:
+		return -EINVAL;
+	}
+}
+
 /**
  * qda_ioctl_invoke() - Perform a dynamic FastRPC method invocation
  * @dev: DRM device structure
diff --git a/drivers/accel/qda/qda_ioctl.h b/drivers/accel/qda/qda_ioctl.h
index 192565434363..457ceccede08 100644
--- a/drivers/accel/qda/qda_ioctl.h
+++ b/drivers/accel/qda/qda_ioctl.h
@@ -13,5 +13,6 @@ int qda_ioctl_init_create(struct drm_device *dev, void *data, struct drm_file *f
 int qda_ioctl_gem_create(struct drm_device *dev, void *data, struct drm_file *file_priv);
 int qda_ioctl_gem_mmap_offset(struct drm_device *dev, void *data, struct drm_file *file_priv);
 int qda_ioctl_invoke(struct drm_device *dev, void *data, struct drm_file *file_priv);
+int qda_ioctl_mmap(struct drm_device *dev, void *data, struct drm_file *file_priv);
 
 #endif /* __QDA_IOCTL_H__ */
diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
index d12b8dc44fdd..046a1ef1872d 100644
--- a/include/uapi/drm/qda_accel.h
+++ b/include/uapi/drm/qda_accel.h
@@ -21,8 +21,9 @@ extern "C" {
 #define DRM_QDA_QUERY		0x00
 #define DRM_QDA_GEM_CREATE		0x01
 #define DRM_QDA_GEM_MMAP_OFFSET	0x02
-/* Command number 0x03 reserved for INIT_ATTACH; 0x05-0x06 reserved for MAP, MUNMAP */
+/* Command number 0x03 reserved for INIT_ATTACH; 0x06 reserved for MUNMAP */
 #define DRM_QDA_REMOTE_SESSION_CREATE		0x04
+#define DRM_QDA_REMOTE_MAP			0x05
 #define DRM_QDA_REMOTE_INVOKE			0x07
 
 /*
@@ -41,9 +42,15 @@ extern "C" {
 #define DRM_IOCTL_QDA_REMOTE_SESSION_CREATE					\
 	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_REMOTE_SESSION_CREATE,		\
 		 struct drm_qda_init_create)
+#define DRM_IOCTL_QDA_REMOTE_MAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_REMOTE_MAP, \
+					  struct drm_qda_mem_map)
 #define DRM_IOCTL_QDA_REMOTE_INVOKE	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_REMOTE_INVOKE, \
 					  struct drm_qda_invoke_args)
 
+/* Request type definitions for qda_mem_map */
+#define QDA_REQUEST_MMAP	1  /* MMAP operation */
+#define QDA_REQUEST_MEM_MAP	2  /* Handle-based MEM_MAP operation with attributes */
+
 /* Query type definitions for drm_qda_query */
 #define QDA_QUERY_DSP_NAME	1
 
@@ -155,6 +162,42 @@ struct drm_qda_init_create {
 	__u64 file;
 };
 
+/**
+ * struct drm_qda_mem_map - Memory mapping request structure
+ * @request: Request type (QDA_REQUEST_MMAP or QDA_REQUEST_MEM_MAP)
+ * @flags: Mapping flags for DSP (cache attributes, permissions)
+ * @handle: GEM handle of the buffer to map (used for kernel buffer lookup)
+ * @attrs: Mapping attributes (used for ATTR request)
+ * @offset: Offset within buffer (used for ATTR request)
+ * @dsp_handle: Handle forwarded to DSP as the buffer identifier
+ * @vaddrin: Optional virtual address hint for mapping
+ * @size: Size of the memory region to map in bytes
+ * @vaddrout: Output DSP virtual address after successful mapping
+ *
+ * This structure is used to request mapping of a GEM buffer into the
+ * DSP's virtual address space. The DSP will map the buffer according
+ * to the specified flags and return the virtual address in vaddrout.
+ *
+ * For QDA_REQUEST_MMAP (value 1):
+ *   - Uses fields: handle, flags, vaddrin, size, vaddrout
+ *   - Legacy MMAP operation for backward compatibility
+ *
+ * For QDA_REQUEST_MEM_MAP (value 2):
+ *   - Uses all fields including attrs and offset
+ *   - Handle-based MEM_MAP operation with custom SMMU attributes
+ */
+struct drm_qda_mem_map {
+	__u32 request;
+	__u32 flags;
+	__u32 handle;
+	__u32 attrs;
+	__u32 offset;
+	__s32 dsp_handle;
+	__u64 vaddrin;
+	__u64 size;
+	__u64 vaddrout;
+};
+
 #if defined(__cplusplus)
 }
 #endif

-- 
2.34.1

