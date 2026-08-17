Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6883C5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 04:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B21710E630;
	Mon, 17 Aug 2026 04:49:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TL3zGvRk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fgH7e9Va";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43D1310E630
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:49:42 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLCgjh343000
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EelcHbrMk4t4hxuoaT5ipMx8vAXXXCtq/Ty/eqBecnw=; b=TL3zGvRkdkrvGIQQ
 cSdVEvpr9HSSl6ThiepFCzY3nH42sgR8lfImscZllMbbL+Bipf16srtqIKHT/Igg
 D5GM5mLhBjCrAAPsrtyZq71Qf++3s2aV9Oz2i+5ZH7JUBBFQVB8xccFtm4fKgLhg
 kitnrU9wxGdMRDqsV7U+Wl06z6frfhpgv7FvnWouq6wiY/2Gh8YE7wIQWU5vC/Xt
 f6BcQZegiYdHTbvMEiu7YPspMfx5bTyDUVIdL6XTT/WXiQVwWeYS+N7YMDPXBt53
 FkAONB+NiK9FI+0+5epBP4KFxNOe2p5QEGbG5lmrB7XrztImYq4mzJ7vt66d3GUE
 GsKXFQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghenaag-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:49:41 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84a251c2e3eso4481366b3a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 21:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786942180; x=1787546980;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EelcHbrMk4t4hxuoaT5ipMx8vAXXXCtq/Ty/eqBecnw=;
 b=fgH7e9Vaaaoj6UuFJMJd47f0xIwAYga979ClIxI+uE+4+s36wyUJQkEdcIASvfGaga
 EA7MVKutU4arqp95NGYrJjn+pIyXvf+z+vrLQinMyg7CUDtS6KSbpuw7ys2tdpIroQzg
 FZIcnaBZmc0e/hucc4INgqa15a15Ld5oTg9hxfyP13ImNqQzqt8U3J3vM9SCA4jIX6WY
 3/bezDfC5q/1V4K4ppojxqs5mN8eULSSIUG7jcHQCeG+U13gecwlX2OUqh4Qr4IHUn3E
 gy3Yez3sFGopCxMVO4BHAheGoZyPkCm7Ymny0dtBy45EmObL7x93DjMeMZq20+C7x6in
 +h/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786942180; x=1787546980;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EelcHbrMk4t4hxuoaT5ipMx8vAXXXCtq/Ty/eqBecnw=;
 b=sV58g6cVVhDxeBu/reMY+l15tiz4NjgL4h/9fT2x6PVszhFKKI7gGp8a4CIid+VrGC
 PiWb+AQU/uq48Qhm5QgNPVDc4YG9H+GhBr6Gnh5OHxm4U6BOaCfwvtV/gddRAKGuN/Dm
 mQYWMYUth+DdFF7odLbyqavHaR5b6X+bg+H4fV2CsOjen9cgH4WubspCdiu1RsjB3jvj
 W3yiwCsWiy1e4U0BRjsEqnts4lSE9s2V6Zcvlpwnl6p69idr5S6Z2Qu+u0Ng8mq16FvN
 e1TlGf0uCa/A/DMqOMEAQ2E4VsSKxp7PnNY247kOLw7o1YRk7DxhF9JQpA6Hw8khxaow
 ExvQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVlD33kOR8De9bsU3f7x8XyxbXYvOkkGKTdbx61y4qCsPxCqiJ07RsNYCExiEeuAExdWbFyLAeO34=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzptyiFefk6dby2hiEWAlIhYSY/GpmD0m1Gi3I5nPpVIrLH9JzV
 /5hBv/U7+EAifGeDARDYwUushxC6XxfpllpwRNdWqeIDRi632Dv6k8QFss5GLJPawK0CZekTl8O
 Cpn/s3EjgBnMnRC/eD5QH81xNF5JcUVTXxGtq0GTN+shtvH81D/97d7HS/2CJzORCLslvb94=
X-Gm-Gg: AR+sD11jbVENm9yhY7LwB1M7ZKChuxVR7KIF9liIPsY/xopOd0RkrevQzKumc7LSKV/
 LEU03J84HLBHStrxort5DpqFgNLdboH8j//Tru9PGUWdGiLjYyMXR3fyAu3qqqAbc3UHOiVr/GF
 avpG8URFTwJsv0YVf0w2yJgGRVz5G2tR5+5wYvi7npAkSqopIwXZpqRXAxTqRPr0Pc8K8AAJuKa
 vqFHsGiYKX8d16oh3m19Z5+FZZ0o8qVDkdQTugd5r2r0NtWWNSb+BgfffGqJLsA3X0IlG74Tk5a
 bPefwz56Ct2FEICbeNqOHLEu0fey7wGDtpJoHKw3JRAZBxw9D2wx6QHZVDPOvMa8MgZAMkZpNq3
 Jy/5JNaUQojLR7vx3EHYdKpCXefVyFBfu
X-Received: by 2002:a05:6a00:4f96:b0:84e:c851:a058 with SMTP id
 d2e1a72fcca58-84fc7c1d1e1mr26336060b3a.10.1786942179692; 
 Sun, 16 Aug 2026 21:49:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:4f96:b0:84e:c851:a058 with SMTP id
 d2e1a72fcca58-84fc7c1d1e1mr26336021b3a.10.1786942179087; 
 Sun, 16 Aug 2026 21:49:39 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8517d046638sm2149250b3a.27.2026.08.16.21.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 21:49:38 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 10:17:48 +0530
Subject: [PATCH v2 13/15] accel/qda: Add DSP process creation and release
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-qda-v2-v2-13-69a02e9090d4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786942058; l=21446;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=NldMkuy73LLnkLPBXuTsIGnZv9EVThGY8v60jDP9NrA=;
 b=pRu2HYsbAdCG53NU+X8s68ivP9CH0zC9PX7MDu+nT2g0Mq54DTZNmkwRoGktBAmOxymSKNBqZ
 f5DRFhqY3ncCOb7fjRT1HHoAePhlrd8k4ZAWoPHFICLpP0aaFqmd4bi
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Authority-Analysis: v=2.4 cv=EKc2FVZC c=1 sm=1 tr=0 ts=6a8292e5 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=8eApmlP4N-50VBB0dCUA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfXxa93ETk5VNlb
 ZLCJ6kMq6sEYPjrpkctuYgbtd3UttNVRRvI3i1qw9pxT7xgkbBMOHz2hXKo4HvrwB6i9yhCCV3b
 cJHyOnspGDCPn3jrWvT3Y+Kd/QEP5Bg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAzMyBTYWx0ZWRfX6o1ddckBP6O9
 DpAxfUy+FC8r5gDjFD8N1AabymBWj6cMgEsGfcINzUBf/GdsgUm1WVMxktS/ES6+DHaLCq5z5UH
 owb97iJefOMQJgD/IZMij9IV0MBJPBh4dPPh2x6IwJu+8v7/LoORCBqJ3XU06au4619M/+NFLgA
 RjVkpzWrEu4hQ56fcPIRLGncZ8Swz+EFfRQ6rGEzTb3WNN4bJXV8EdAFmU8MiTuQYQIadTopYmr
 f5B6V6Ut0chCXubKZcGkIx+qpWVg3MzqmCBMV5eFEUOyPPyMJ9wSLQN4WNgwsLCu2qkSGNcn7DA
 w5+n71r+tQSiKi//pGB6+LQ4bhcaVF9gqnaXw0THOWlSJS4opzyTu/f+tOrWWEbfY//ECZ8zKr/
 ach7/jAqwfQULx05SPKkRX3cW86Gc2olSI2G2/vhzaY4fOvgoRLhEWe5czWGbDWjDv1vMH4y+ns
 g7WbgZu6OieoVIqkiRA==
X-Proofpoint-GUID: u4qH26dfp4h8tWm75SRf8GmvKzs4Fxvu
X-Proofpoint-ORIG-GUID: u4qH26dfp4h8tWm75SRf8GmvKzs4Fxvu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
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

Implement the REMOTE_SESSION_CREATE and INIT_RELEASE FastRPC operations,
which establish and tear down a user process on the DSP.

DRM_IOCTL_QDA_REMOTE_SESSION_CREATE (drm_qda_init_create)
  Creates a new process on the DSP by sending an INIT_CREATE message via
  the FastRPC INIT_HANDLE. The caller provides the ELF image as a GEM
  handle along with optional process attributes. A GEM buffer is
  allocated per session to hold the DSP process image; it is cached in
  qda_file_priv and reused for the lifetime of the session.

  If attrs is non-zero the INIT_CREATE_ATTR message is used instead of
  INIT_CREATE. Both create the protection domain and load the process
  image; INIT_CREATE_ATTR additionally carries the process attributes
  and signature length, which the DSP applies to the domain it creates.

  Issuing INIT_CREATE again on the same file without an intervening
  INIT_RELEASE replaces the process image, so the initialisation memory
  cached for the previous attempt is released first.

INIT_RELEASE
  Tears the DSP process down. It is issued from qda_release_dsp_process()
  on postclose, guarded by drm_dev_enter() so the message is only sent
  while the device is still accessible. Once the DSP has torn down the
  protection domain the initialisation memory is released.

The initialisation memory is referenced both by the invocation context
and by the file private data that caches it across invocations, so each
takes a reference of its own and drops it independently.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
Changes in v2:
- Explain how INIT_CREATE_ATTR differs from INIT_CREATE
  (Dmitry Baryshkov)
- Take a separate reference on the process initialisation memory for the
  file private data and the invocation context, so it is no longer
  leaked when process creation fails
- Document why a second INIT_CREATE releases the previous initialisation
  memory
---
 drivers/accel/qda/qda_drv.c     |  12 +++
 drivers/accel/qda/qda_drv.h     |   5 +
 drivers/accel/qda/qda_fastrpc.c | 213 ++++++++++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_fastrpc.h |  35 +++++++
 drivers/accel/qda/qda_ioctl.c   |  77 +++++++++++++++
 drivers/accel/qda/qda_ioctl.h   |   1 +
 include/uapi/drm/qda_accel.h    |  31 +++++-
 7 files changed, 373 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index f925bbcfa6e9..4c3a37cbf49e 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -12,6 +12,7 @@
 #include <drm/qda_accel.h>
 
 #include "qda_drv.h"
+#include "qda_gem.h"
 #include "qda_ioctl.h"
 #include "qda_prime.h"
 
@@ -35,6 +36,16 @@ static int qda_open(struct drm_device *dev, struct drm_file *file)
 static void qda_postclose(struct drm_device *dev, struct drm_file *file)
 {
 	struct qda_file_priv *qda_file_priv = file->driver_priv;
+	int idx;
+
+	/* Only send the DSP release message while the device is accessible */
+	if (drm_dev_enter(dev, &idx)) {
+		qda_release_dsp_process(qda_file_priv->qda_dev, file);
+		drm_dev_exit(idx);
+	}
+
+	if (qda_file_priv->init_mem_gem_obj)
+		drm_gem_object_put(&qda_file_priv->init_mem_gem_obj->base);
 
 	if (qda_file_priv->assigned_iommu_dev)
 		qda_memory_manager_release_device(qda_file_priv->assigned_iommu_dev);
@@ -49,6 +60,7 @@ static const struct drm_ioctl_desc qda_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(QDA_QUERY, qda_ioctl_query, 0),
 	DRM_IOCTL_DEF_DRV(QDA_GEM_CREATE, qda_ioctl_gem_create, 0),
 	DRM_IOCTL_DEF_DRV(QDA_GEM_MMAP_OFFSET, qda_ioctl_gem_mmap_offset, 0),
+	DRM_IOCTL_DEF_DRV(QDA_REMOTE_SESSION_CREATE, qda_ioctl_init_create, 0),
 	DRM_IOCTL_DEF_DRV(QDA_REMOTE_INVOKE, qda_ioctl_invoke, 0),
 };
 
diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
index 8332108c362f..4337894ff22d 100644
--- a/drivers/accel/qda/qda_drv.h
+++ b/drivers/accel/qda/qda_drv.h
@@ -28,6 +28,8 @@ struct qda_file_priv {
 	struct qda_dev *qda_dev;
 	/** @assigned_iommu_dev: IOMMU device assigned to this process */
 	struct qda_iommu_device *assigned_iommu_dev;
+	/** @init_mem_gem_obj: GEM object for PD initialization memory */
+	struct qda_gem_obj *init_mem_gem_obj;
 	/** @pid: Process ID for tracking */
 	pid_t pid;
 	/** @remote_session_id: Unique session identifier */
@@ -82,4 +84,7 @@ int qda_init_device(struct qda_dev *qdev, int num_cbs);
 void qda_deinit_device(struct qda_dev *qdev);
 int qda_register_device(struct qda_dev *qdev);
 
+/* DSP process / protection domain management */
+int qda_release_dsp_process(struct qda_dev *qdev, struct drm_file *file_priv);
+
 #endif /* __QDA_DRV_H__ */
diff --git a/drivers/accel/qda/qda_fastrpc.c b/drivers/accel/qda/qda_fastrpc.c
index 3c0ce5040500..2c72f86130aa 100644
--- a/drivers/accel/qda/qda_fastrpc.c
+++ b/drivers/accel/qda/qda_fastrpc.c
@@ -130,6 +130,9 @@ void qda_fastrpc_context_free(struct kref *ref)
 	if (ctx->msg_gem_obj)
 		drm_gem_object_put(&ctx->msg_gem_obj->base);
 
+	if (ctx->init_mem_gem_obj)
+		drm_gem_object_put(&ctx->init_mem_gem_obj->base);
+
 	kfree(ctx->args);
 	kfree(ctx);
 }
@@ -192,6 +195,45 @@ struct qda_fastrpc_invoke_ctx *qda_fastrpc_context_alloc(struct qda_dev *qdev)
 	return ctx;
 }
 
+/*
+ * Allocate a single DMA-coherent GEM object holding all kernel-internal
+ * buffers of one invocation, so the total DMA footprint is
+ * PAGE_ALIGN(sum of sizes) - typically a single page.
+ *
+ * The caller wires each argument slot with assign_kernel_gem_arg(), which
+ * takes a reference per slot, then drops the initial reference returned here.
+ */
+static struct qda_gem_obj *alloc_kernel_gem(struct qda_fastrpc_invoke_ctx *ctx,
+					    size_t total_size)
+{
+	struct qda_file_priv *qda_priv = ctx->file_priv->driver_priv;
+	struct qda_dev *qdev = qda_priv->qda_dev;
+	struct qda_gem_obj *qda_gem_obj;
+	struct drm_gem_object *gem_obj;
+
+	gem_obj = qda_gem_create_object(&qdev->drm_dev, qdev->iommu_mgr,
+					total_size, ctx->file_priv);
+	if (IS_ERR(gem_obj))
+		return ERR_CAST(gem_obj);
+
+	qda_gem_obj = to_qda_gem_obj(gem_obj);
+	/* Zero-initialise so OUT slots start clean */
+	memset(qda_gem_obj->virt, 0, qda_gem_obj->size);
+
+	return qda_gem_obj;
+}
+
+static void assign_kernel_gem_arg(struct drm_qda_fastrpc_invoke_args *args,
+				  struct drm_gem_object **gem_objs, int idx,
+				  struct qda_gem_obj *kernel_gem, void *ptr, size_t len)
+{
+	args[idx].ptr = (u64)(uintptr_t)ptr;
+	args[idx].length = len;
+	args[idx].handle = 0;
+	drm_gem_object_get(&kernel_gem->base);
+	gem_objs[idx] = &kernel_gem->base;
+}
+
 /*
  * Resolve the physical address of an in/out buffer argument.  The buffer is
  * backed either by a kernel-owned GEM object already recorded in
@@ -368,6 +410,169 @@ int qda_fastrpc_invoke_pack(struct qda_fastrpc_invoke_ctx *ctx, struct qda_msg *
 	return 0;
 }
 
+/*
+ * INIT_RELEASE packed layout:
+ *   [0] remote_session_id	sizeof(int)	IN
+ */
+static int qda_fastrpc_prepare_args_release_process(struct qda_fastrpc_invoke_ctx *ctx)
+{
+	struct drm_qda_fastrpc_invoke_args *args;
+	struct qda_gem_obj *kernel_gem;
+	u32 nscalars;
+	int err;
+
+	ctx->sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_RELEASE, 1, 0);
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
+	kernel_gem = alloc_kernel_gem(ctx, sizeof(ctx->remote_session_id));
+	if (IS_ERR(kernel_gem)) {
+		err = PTR_ERR(kernel_gem);
+		goto err_free_gem_objs;
+	}
+
+	memcpy(kernel_gem->virt, &ctx->remote_session_id,
+	       sizeof(ctx->remote_session_id));
+
+	assign_kernel_gem_arg(args, ctx->gem_objs, 0, kernel_gem, kernel_gem->virt,
+			      sizeof(ctx->remote_session_id));
+	drm_gem_object_put(&kernel_gem->base);
+
+	ctx->args = args;
+
+	return 0;
+
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
+ * INIT_CREATE / INIT_CREATE_ATTR packed layout:
+ *   [0] inbuf	sizeof(fastrpc_create_process_inbuf)	IN
+ *   [1] comm	TASK_COMM_LEN				IN
+ *   [2] ELF	user-supplied GEM handle, not packed	IN
+ *   [3] pages	sizeof(fastrpc_phy_page)		IN
+ *   [4] attrs	sizeof(u32)				IN
+ *   [5] siglen	sizeof(u32)				IN
+ */
+static int qda_fastrpc_prepare_args_init_create(struct qda_fastrpc_invoke_ctx *ctx, void *argp)
+{
+	struct drm_qda_init_create *init = argp;
+	struct fastrpc_create_process_inbuf *inbuf;
+	struct drm_qda_fastrpc_invoke_args *args;
+	struct qda_gem_obj *kernel_gem;
+	u32 nscalars;
+	int err;
+	u8 *gv;
+
+	const size_t off_inbuf = 0;
+	const size_t off_comm = off_inbuf + sizeof(*inbuf);
+	const size_t off_pages = off_comm + TASK_COMM_LEN;
+	const size_t off_attrs = off_pages + sizeof(struct fastrpc_phy_page);
+	const size_t off_siglen = off_attrs + sizeof(u32);
+	const size_t total_size = off_siglen + sizeof(u32);
+
+	if (init->filelen > FASTRPC_INIT_FILELEN_MAX)
+		return -EINVAL;
+
+	/* Reject an unusable ELF handle before involving the DSP */
+	if (init->filelen && init->filehandle) {
+		struct drm_gem_object *file_gem_obj;
+
+		err = get_gem_obj_from_handle(ctx, init->filehandle, &file_gem_obj);
+		if (err)
+			return err;
+		drm_gem_object_put(file_gem_obj);
+	}
+
+	ctx->sc = init->attrs ? FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_ATTR, 4, 0)
+			      : FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE, 4, 0);
+	ctx->handle = FASTRPC_INIT_HANDLE;
+	nscalars = REMOTE_SCALARS_LENGTH(ctx->sc);
+
+	args = kzalloc_objs(*args, FASTRPC_CREATE_PROCESS_NARGS);
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
+	inbuf = (struct fastrpc_create_process_inbuf *)(gv + off_inbuf);
+	inbuf->remote_session_id = ctx->remote_session_id;
+	inbuf->namelen = strlen(current->comm) + 1;
+	inbuf->filelen = init->filelen;
+	inbuf->pageslen = 1;
+	inbuf->attrs = init->attrs;
+	inbuf->siglen = init->siglen;
+
+	memcpy(gv + off_comm, current->comm, inbuf->namelen);
+
+	ctx->input_pages = (struct fastrpc_phy_page *)(gv + off_pages);
+	setup_pages_from_gem_obj(ctx->init_mem_gem_obj, ctx->input_pages);
+
+	*(u32 *)(gv + off_attrs) = inbuf->attrs;
+	*(u32 *)(gv + off_siglen) = inbuf->siglen;
+
+	/*
+	 * ctx->sc encodes 4 inbufs, so gem_objs[] only has 4 slots.  args[4]
+	 * and args[5] are packed for the DSP but must not be registered there,
+	 * and are never walked because the argument loops stop at nscalars.
+	 */
+	assign_kernel_gem_arg(args, ctx->gem_objs, 0, kernel_gem,
+			      gv + off_inbuf, sizeof(*inbuf));
+	assign_kernel_gem_arg(args, ctx->gem_objs, 1, kernel_gem,
+			      gv + off_comm, inbuf->namelen);
+	args[2].ptr = init->file;
+	args[2].length = inbuf->filelen;
+	args[2].handle = init->filehandle;
+	assign_kernel_gem_arg(args, ctx->gem_objs, 3, kernel_gem,
+			      gv + off_pages, sizeof(struct fastrpc_phy_page));
+	args[4].ptr = (u64)(uintptr_t)(gv + off_attrs);
+	args[4].length = sizeof(u32);
+	args[5].ptr = (u64)(uintptr_t)(gv + off_siglen);
+	args[5].length = sizeof(u32);
+
+	drm_gem_object_put(&kernel_gem->base);
+
+	ctx->args = args;
+	ctx->inbuf = inbuf;
+
+	return 0;
+
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
@@ -412,6 +617,14 @@ int qda_fastrpc_prepare_args(struct qda_fastrpc_invoke_ctx *ctx, void *argp)
 	int err;
 
 	switch (ctx->type) {
+	case FASTRPC_RMID_INIT_RELEASE:
+		err = qda_fastrpc_prepare_args_release_process(ctx);
+		break;
+	case FASTRPC_RMID_INIT_CREATE:
+	case FASTRPC_RMID_INIT_CREATE_ATTR:
+		ctx->pd = QDA_USER_PD;
+		err = qda_fastrpc_prepare_args_init_create(ctx, argp);
+		break;
 	case FASTRPC_RMID_INVOKE_DYNAMIC:
 		err = qda_fastrpc_prepare_args_invoke(ctx, argp);
 		break;
diff --git a/drivers/accel/qda/qda_fastrpc.h b/drivers/accel/qda/qda_fastrpc.h
index a25818923a6e..6beaa9538983 100644
--- a/drivers/accel/qda/qda_fastrpc.h
+++ b/drivers/accel/qda/qda_fastrpc.h
@@ -107,6 +107,27 @@ struct fastrpc_invoke_buf {
 	u32 pgidx;
 };
 
+/**
+ * struct fastrpc_create_process_inbuf - Input buffer for process creation
+ *
+ * This structure defines the input buffer format for creating a new
+ * process on the remote DSP.
+ */
+struct fastrpc_create_process_inbuf {
+	/** @remote_session_id: Client identifier for the session */
+	int remote_session_id;
+	/** @namelen: Length of the process name string including NUL terminator */
+	u32 namelen;
+	/** @filelen: Length of the ELF shell file in bytes */
+	u32 filelen;
+	/** @pageslen: Number of physical page descriptors */
+	u32 pageslen;
+	/** @attrs: Process attribute flags */
+	u32 attrs;
+	/** @siglen: Length of the signature data in bytes */
+	u32 siglen;
+};
+
 /**
  * struct fastrpc_msg - FastRPC wire message for remote invocations
  *
@@ -192,6 +213,8 @@ struct qda_fastrpc_invoke_ctx {
 	struct qda_gem_obj *msg_gem_obj;
 	/** @file_priv: DRM file private data */
 	struct drm_file *file_priv;
+	/** @init_mem_gem_obj: GEM object for PD initialization memory */
+	struct qda_gem_obj *init_mem_gem_obj;
 	/**
 	 * @req: Request buffer for the internal init/map/unmap calls.  Points
 	 * into a kernel-owned GEM mapping tracked by @gem_objs, so it must
@@ -226,11 +249,23 @@ struct qda_msg {
 };
 
 /* Remote Method ID table - identifies initialization and control operations */
+#define FASTRPC_RMID_INIT_RELEASE	1	/* Release DSP process */
+#define FASTRPC_RMID_INIT_CREATE	6	/* Create DSP process */
+#define FASTRPC_RMID_INIT_CREATE_ATTR	7	/* Create DSP process with attributes */
 #define FASTRPC_RMID_INVOKE_DYNAMIC	0xFFFFFFFFU	/* Dynamic method invocation */
 
 /* Common handle for initialization operations */
 #define FASTRPC_INIT_HANDLE		0x1
 
+/* Protection Domain (PD) identifiers */
+#define QDA_ROOT_PD		(0)
+#define QDA_USER_PD		(1)
+
+/* Number of arguments for process creation */
+#define FASTRPC_CREATE_PROCESS_NARGS	6
+/* Maximum initialization file size (4 MB) */
+#define FASTRPC_INIT_FILELEN_MAX	(4 * 1024 * 1024)
+
 void qda_fastrpc_context_free(struct kref *ref);
 void qda_fastrpc_cleanup_handlelist(struct qda_fastrpc_invoke_ctx *ctx);
 void qda_fastrpc_flush_pending(struct qda_dev *qdev);
diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
index b7ee4899ba74..34b71b82a020 100644
--- a/drivers/accel/qda/qda_ioctl.c
+++ b/drivers/accel/qda/qda_ioctl.c
@@ -106,6 +106,40 @@ static int qda_fastrpc_invoke(u32 type, struct drm_device *dev, void *data,
 	ctx->file_priv = file_priv;
 	ctx->remote_session_id = qda_file_priv->remote_session_id;
 
+	if (type == FASTRPC_RMID_INIT_CREATE) {
+		/*
+		 * A second INIT_CREATE on the same file without an intervening
+		 * INIT_RELEASE replaces the process image, so drop the
+		 * initialisation memory cached for the previous attempt.
+		 */
+		if (qda_file_priv->init_mem_gem_obj) {
+			drm_gem_object_put(&qda_file_priv->init_mem_gem_obj->base);
+			qda_file_priv->init_mem_gem_obj = NULL;
+		}
+
+		gem_obj = qda_gem_create_object(dev, qdev->iommu_mgr,
+						FASTRPC_INIT_FILELEN_MAX, file_priv);
+		if (IS_ERR(gem_obj)) {
+			err = PTR_ERR(gem_obj);
+			goto err_context_free;
+		}
+
+		ctx->init_mem_gem_obj = to_qda_gem_obj(gem_obj);
+
+		/*
+		 * The file private data caches the initialisation memory for
+		 * the lifetime of the DSP process, so it holds a reference of
+		 * its own; the context drops the one taken here when it is
+		 * released.
+		 */
+		drm_gem_object_get(gem_obj);
+		qda_file_priv->init_mem_gem_obj = ctx->init_mem_gem_obj;
+	} else if (type == FASTRPC_RMID_INIT_RELEASE) {
+		ctx->init_mem_gem_obj = qda_file_priv->init_mem_gem_obj;
+		if (ctx->init_mem_gem_obj)
+			drm_gem_object_get(&ctx->init_mem_gem_obj->base);
+	}
+
 	err = qda_fastrpc_prepare_args(ctx, data);
 	if (err)
 		goto err_context_free;
@@ -144,16 +178,59 @@ static int qda_fastrpc_invoke(u32 type, struct drm_device *dev, void *data,
 
 	qda_fastrpc_cleanup_handlelist(ctx);
 
+	/*
+	 * The DSP has torn down the protection domain, so the initialisation
+	 * memory can be released now.
+	 */
+	if (type == FASTRPC_RMID_INIT_RELEASE && qda_file_priv->init_mem_gem_obj) {
+		drm_gem_object_put(&qda_file_priv->init_mem_gem_obj->base);
+		qda_file_priv->init_mem_gem_obj = NULL;
+	}
+
 	kref_put(&ctx->refcount, qda_fastrpc_context_free);
 
 	return 0;
 
 err_context_free:
+	/*
+	 * Process creation failed, so release the initialisation memory cached
+	 * in the file private data; the context drops its own reference below.
+	 */
+	if (type == FASTRPC_RMID_INIT_CREATE && qda_file_priv->init_mem_gem_obj) {
+		drm_gem_object_put(&qda_file_priv->init_mem_gem_obj->base);
+		qda_file_priv->init_mem_gem_obj = NULL;
+	}
+
 	kref_put(&ctx->refcount, qda_fastrpc_context_free);
 
 	return err;
 }
 
+/**
+ * qda_ioctl_init_create() - Create a DSP process
+ * @dev: DRM device structure
+ * @data: User-space data (struct drm_qda_init_create)
+ * @file_priv: DRM file private data
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_ioctl_init_create(struct drm_device *dev, void *data, struct drm_file *file_priv)
+{
+	return qda_fastrpc_invoke(FASTRPC_RMID_INIT_CREATE, dev, data, file_priv);
+}
+
+/**
+ * qda_release_dsp_process() - Release DSP process resources for a file
+ * @qdev: QDA device structure
+ * @file_priv: DRM file private data
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_release_dsp_process(struct qda_dev *qdev, struct drm_file *file_priv)
+{
+	return qda_fastrpc_invoke(FASTRPC_RMID_INIT_RELEASE, &qdev->drm_dev, NULL, file_priv);
+}
+
 /**
  * qda_ioctl_invoke() - Perform a dynamic FastRPC method invocation
  * @dev: DRM device structure
diff --git a/drivers/accel/qda/qda_ioctl.h b/drivers/accel/qda/qda_ioctl.h
index 3bb9cfd98370..192565434363 100644
--- a/drivers/accel/qda/qda_ioctl.h
+++ b/drivers/accel/qda/qda_ioctl.h
@@ -9,6 +9,7 @@
 #include "qda_drv.h"
 
 int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_priv);
+int qda_ioctl_init_create(struct drm_device *dev, void *data, struct drm_file *file_priv);
 int qda_ioctl_gem_create(struct drm_device *dev, void *data, struct drm_file *file_priv);
 int qda_ioctl_gem_mmap_offset(struct drm_device *dev, void *data, struct drm_file *file_priv);
 int qda_ioctl_invoke(struct drm_device *dev, void *data, struct drm_file *file_priv);
diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
index 5cf0fec1d91c..d12b8dc44fdd 100644
--- a/include/uapi/drm/qda_accel.h
+++ b/include/uapi/drm/qda_accel.h
@@ -21,7 +21,8 @@ extern "C" {
 #define DRM_QDA_QUERY		0x00
 #define DRM_QDA_GEM_CREATE		0x01
 #define DRM_QDA_GEM_MMAP_OFFSET	0x02
-/* Command numbers 0x03-0x06 reserved for INIT_ATTACH, INIT_CREATE, MAP, MUNMAP */
+/* Command number 0x03 reserved for INIT_ATTACH; 0x05-0x06 reserved for MAP, MUNMAP */
+#define DRM_QDA_REMOTE_SESSION_CREATE		0x04
 #define DRM_QDA_REMOTE_INVOKE			0x07
 
 /*
@@ -37,6 +38,9 @@ extern "C" {
 					  struct drm_qda_gem_create)
 #define DRM_IOCTL_QDA_GEM_MMAP_OFFSET	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_GEM_MMAP_OFFSET, \
 					  struct drm_qda_gem_mmap_offset)
+#define DRM_IOCTL_QDA_REMOTE_SESSION_CREATE					\
+	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_REMOTE_SESSION_CREATE,		\
+		 struct drm_qda_init_create)
 #define DRM_IOCTL_QDA_REMOTE_INVOKE	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_REMOTE_INVOKE, \
 					  struct drm_qda_invoke_args)
 
@@ -126,6 +130,31 @@ struct drm_qda_invoke_args {
 	__u64 args;
 };
 
+/**
+ * struct drm_qda_init_create - Accelerator process initialization parameters
+ * @filelen: Length of the ELF file in bytes
+ * @filehandle: GEM handle for the buffer containing the ELF file; 0 if using
+ *              the direct file pointer instead
+ * @attrs: Process attributes flags
+ * @siglen: Length of signature data in bytes
+ * @file: Pointer to ELF file data if not using filehandle
+ *
+ * This structure is used with DRM_IOCTL_QDA_INIT_CREATE to initialize
+ * a new process on the accelerator. The process code is provided either
+ * via a GEM handle (filehandle) or a direct pointer (file).
+ * Set file to 0 if using filehandle.
+ *
+ * The attrs field contains bit flags for debug mode, privileged execution,
+ * and other process attributes.
+ */
+struct drm_qda_init_create {
+	__u32 filelen;
+	__u32 filehandle;
+	__u32 attrs;
+	__u32 siglen;
+	__u64 file;
+};
+
 #if defined(__cplusplus)
 }
 #endif

-- 
2.34.1

