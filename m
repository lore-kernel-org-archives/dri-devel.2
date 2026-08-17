Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61045C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 05:09:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56D8810E3BA;
	Mon, 17 Aug 2026 05:08:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="O4HqHOh5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gX8ograC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE64A10E3BA
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:08:58 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLF1bi249582
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JZyIM72BvmHpdiGWF5re/dgNfhX2AIKFxQm2KtvKiUk=; b=O4HqHOh578QoO/ND
 s74m/W3yfArvyRX6Zj7JsxF0E50tyaf2dPAuwjb8X5sC9+lvihwkoN+tgSZL1DGX
 r+5jPAGjDBvGhANQ8Wdb6rVJKIs6Y1dJyq/vOD99Ff8SXeglqe6Nz7bRpqsd36S8
 /ne38hXhG1ziepCxbM/E7hNSVjrfUrlACE/sgBDQSA5HwqTPktz9B2VYCnUYsTk9
 NlwE6XSKHfHWTa+0A/uOr917NvZe/mmzAVuCnZQht2aPCAFYSMP4B77TZzdo/jD4
 VLcODkiKP97WBLSTp61SxxBlPogkajvcv+K7wPOhi5fpGmgfrwf1kM4QZ0sET/y3
 MNiwGw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghf584b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:08:57 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbe77d6864dso5287289a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 22:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786943336; x=1787548136;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JZyIM72BvmHpdiGWF5re/dgNfhX2AIKFxQm2KtvKiUk=;
 b=gX8ograCt1+WGdW5MkfEtvrFRNTBRMlYUHSAnbCoKlp9cd04FwvygDm1yFNd5tEOKm
 j0Kpx5gZvEpVR8b+oTQZ/SrSyZvElOvkiI1u236YXb5xwd6YhAIlnQ/hVlfpFnHrZ4xn
 msKdYaCHamIL3NopTsWGReithAtzFgiGlgrwj78+JqpiNRQOrMthuEjgujSp4zGTxeaX
 IJtXZmch/OfDoye3XOeAiT9BgeH1y05a1GLBLBWH5z4aTwCW6HiOC5hBPKLSIvETFw9h
 VfF6hqb7guC2Ss+KKCldBsllYeL+bl/EHrsVcMtorJidsrR/f0dqkZrlaP4UwRVmbJ++
 QZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786943336; x=1787548136;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JZyIM72BvmHpdiGWF5re/dgNfhX2AIKFxQm2KtvKiUk=;
 b=a0LWYjyl/GRyfjvw1V+2AaZu/og79OWHCrkmgBx46NSceR84GeRgMfd/VWQSP5v1LN
 tJWBBxZXKy/85oXXFicyRslhzCp+G1nnwQQagJSob2i/aFAeT4HDpw3Z1xJEZnMWoDCk
 DSryExtZucFWygKvZNnm+LYsQ3mT2Nhz7M4SDY0ikGZpaYtPq6g/KJ8DJTWHcOM8Bcsw
 Qe5LJwbRAJQ9IJYbSAauufZwn3TdKaHQQFJWlCKa4czDMn6XuXnxMU/PAt+WGrxPscqC
 7pgpftRG6PjKAKOLaz2XsKrLoKzdGhnyZkON7WDdOItxhfXoH8ER65gGygGbA7BUcJqc
 3bLg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqREmMgz+BzgCYtJ7OVsHQ668Q87aFia2amLbM97ZGrl+gUiPK0mlVIYEfaLCRMdPRtecEYwz8Ke3M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy0ESgeJVQ4+d5DRq5tK8dJPa/T2HAfawCmEFOceKRRYwomYog6
 NXb9c5N3bYxmN+qO6SXbbcokAd6SJ0aewyTj/Evi/guCnU1LcPkaC0o9xuysgPordfFWv0/eqp0
 5mSUEiqbhxaGSW3OSu1hZHbo6APzCYxhqIbj1DmErkNpbti2hQOspjv0YrrJkhj3RQ5Cxnp4=
X-Gm-Gg: AR+sD11/L0PIeE1BFTvG/gGkPHeIeWbq6pq7vo91+mg/I+h5xk9zXX0F2ss936cvq+o
 agFtgNa62Yts5ewnV97krG5xqoQ9Q2n9ytCEGvWZtQ1k4RWaeZ4xJjeGTDScui7O7VKH3xrWX3Q
 xzV9RzAJrVc8su5TfAEG4XCTt96rKaQL7w7k06do1xlQw2ACx6zVR0mWpsjjDN0AWMuvcxz7zpS
 FgkADhoPIr7TS1pd9WY5/YctivgvLD/yzxBcAV0ABovHqjSGvUZGphzBnY2Bh7fpm32ddkatCo9
 naglfqcdoyTppDgJYKg89yILOt1U5/5Bs3LsDwU2kHtb6V9SAAMXUpMN4jieiSD4KDJm6nypxtr
 NL+4Km3H2UJneJees7jWnLWEoYeC3Zd14
X-Received: by 2002:a05:6a21:350f:b0:3c3:724d:ae7a with SMTP id
 adf61e73a8af0-3cc71a2975amr27578747637.9.1786943336483; 
 Sun, 16 Aug 2026 22:08:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:350f:b0:3c3:724d:ae7a with SMTP id
 adf61e73a8af0-3cc71a2975amr27578665637.9.1786943336001; 
 Sun, 16 Aug 2026 22:08:56 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc13c00d84asm105225a12.19.2026.08.16.22.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 22:08:55 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
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
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH v2 15/15] accel/qda: Add remote memory unmap from DSP address
 space
Date: Mon, 17 Aug 2026 10:38:45 +0530
Message-Id: <20260817-qda-v2-v2-15-757ab8ed2f64@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260817-qda-v2-v2-0-757ab8ed2f64@oss.qualcomm.com>
References: <20260817-qda-v2-v2-0-757ab8ed2f64@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786943212; l=12490;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=+objfCu1IrV7x2GSKLVFWQgGjFXztmZ2/TXy0Lr8dhI=;
 b=M1K45p7ZwZT3GRGaTBC79Kd4nxj6hXtLY8ZEnFFcuuJD/UVADCi1sk4LtHYTv9Zw4jzvchxME
 ooLSJWdoXAGAFSYyFia/47gSDK8PlQGL2d0p8MLbILR1vUdtsXBeUz6
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QsVuG1yd c=1 sm=1 tr=0 ts=6a829769 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=GDcW5iUI_5bVhr0LsogA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: b5HeqEu-LdmAKDPPXt5KgJXDH4Oo2l9Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAzNiBTYWx0ZWRfX39Zsi7nreLd1
 +w9uGpgCqkn+8YHBUzhVPyU+GNT/jPqHpA4LTaHRsNx3idDFHZ+XFhsMdTCVdW0Qkj5DVkyGuNL
 jckdYUUceN9e7CYlp2ojTzcIc53TsesJnQqeoRZZ2R6m5M5tIQ1mT2aF2/gxx5kGiaeApzQKF6q
 RX9dlfEYHMWfU9yooLGPeb9AleK+Yw97B7aSqplwVOThEAu0EASNIiBhUBD4QKX/XogTvs7yYQG
 yx1gpJoxPsTDxF2dD4Vs0Az0F6RFF14h4JN5XPIx1rawrjJH5tLLIHO0zLYIrW/TGVhBozc95r1
 7bGilFZvDCPnMigKVlZxXNdEMn5XebtN78wdeYUlxHG7JD+UcAQUZDup3D6SbY5/Exb0kRniRaY
 AOmRrLCJ6eDm/bYKnrPzUPu7B7cvrT4FV4HBS9umTkyzGqLJAAuehkYRGiyv0RtnnPEBXSLl1/w
 G4INxpib9WBCfaHM2zQ==
X-Proofpoint-ORIG-GUID: b5HeqEu-LdmAKDPPXt5KgJXDH4Oo2l9Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAzNiBTYWx0ZWRfX1AtXHfii63ot
 E5bafOnOdADx7ng3exJ1NuZ0pN6F1lu9FRBO1DM2XR91+thWa2HfEFhP+2ZjAm/RVeEHEQLqzTW
 bauMqpgVyEpNPzMqFaQE0RK7HCJYJD4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170036
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

Add DRM_IOCTL_QDA_REMOTE_MUNMAP, which removes a mapping previously
established with DRM_IOCTL_QDA_REMOTE_MAP from the DSP address space of
the calling process.

Mirroring the map path, the DSP exposes two unmap operations, both
reachable through this IOCTL and selected by the request field of
struct drm_qda_mem_unmap:

  QDA_REQUEST_MUNMAP unmaps a region by the DSP address that the
  corresponding map call returned. It uses the vaddrout and size fields.

  QDA_REQUEST_MEM_UNMAP unmaps a region by buffer identity, using the
  GEM handle, the DSP virtual address and the size.

Each request type has its own argument builder in qda_fastrpc.c,
documented with the packed argument layout the DSP expects. Unknown
request types are rejected with -EINVAL.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/accel/qda/qda_drv.c     |   1 +
 drivers/accel/qda/qda_fastrpc.c | 119 ++++++++++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_fastrpc.h |  34 ++++++++++++
 drivers/accel/qda/qda_ioctl.c   |  22 ++++++++
 drivers/accel/qda/qda_ioctl.h   |   1 +
 include/uapi/drm/qda_accel.h    |  39 ++++++++++++-
 6 files changed, 215 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
index a29037bf8d63..17afe648cd15 100644
--- a/drivers/accel/qda/qda_drv.c
+++ b/drivers/accel/qda/qda_drv.c
@@ -62,6 +62,7 @@ static const struct drm_ioctl_desc qda_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(QDA_GEM_MMAP_OFFSET, qda_ioctl_gem_mmap_offset, 0),
 	DRM_IOCTL_DEF_DRV(QDA_REMOTE_SESSION_CREATE, qda_ioctl_init_create, 0),
 	DRM_IOCTL_DEF_DRV(QDA_REMOTE_MAP, qda_ioctl_mmap, 0),
+	DRM_IOCTL_DEF_DRV(QDA_REMOTE_MUNMAP, qda_ioctl_munmap, 0),
 	DRM_IOCTL_DEF_DRV(QDA_REMOTE_INVOKE, qda_ioctl_invoke, 0),
 };
 
diff --git a/drivers/accel/qda/qda_fastrpc.c b/drivers/accel/qda/qda_fastrpc.c
index 6bd706b9dad2..d105726330e4 100644
--- a/drivers/accel/qda/qda_fastrpc.c
+++ b/drivers/accel/qda/qda_fastrpc.c
@@ -810,6 +810,119 @@ static int qda_fastrpc_prepare_args_mem_map_attr(struct qda_fastrpc_invoke_ctx *
 	return err;
 }
 
+/*
+ * INIT_MUNMAP packed layout:
+ *   [0] req_msg	sizeof(fastrpc_munmap_req_msg)	IN
+ */
+static int qda_fastrpc_prepare_args_munmap(struct qda_fastrpc_invoke_ctx *ctx, void *argp)
+{
+	struct fastrpc_munmap_req_msg *req_msg;
+	struct drm_qda_fastrpc_invoke_args *args;
+	struct drm_qda_mem_unmap *uargs = argp;
+	struct qda_gem_obj *kernel_gem;
+	u32 nscalars;
+	int err;
+
+	ctx->sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MUNMAP, 1, 0);
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
+	kernel_gem = alloc_kernel_gem(ctx, sizeof(*req_msg));
+	if (IS_ERR(kernel_gem)) {
+		err = PTR_ERR(kernel_gem);
+		goto err_free_gem_objs;
+	}
+
+	req_msg = kernel_gem->virt;
+	req_msg->remote_session_id = ctx->remote_session_id;
+	req_msg->vaddr = uargs->vaddrout;
+	req_msg->size = uargs->size;
+
+	assign_kernel_gem_arg(args, ctx->gem_objs, 0, kernel_gem,
+			      kernel_gem->virt, sizeof(*req_msg));
+	drm_gem_object_put(&kernel_gem->base);
+
+	ctx->args = args;
+	ctx->req = req_msg;
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
+ * INIT_MEM_UNMAP packed layout:
+ *   [0] req_msg	sizeof(fastrpc_mem_unmap_req_msg)	IN
+ */
+static int qda_fastrpc_prepare_args_mem_unmap_attr(struct qda_fastrpc_invoke_ctx *ctx, void *argp)
+{
+	struct fastrpc_mem_unmap_req_msg *req_msg;
+	struct drm_qda_fastrpc_invoke_args *args;
+	struct drm_qda_mem_unmap *uargs = argp;
+	struct qda_gem_obj *kernel_gem;
+	u32 nscalars;
+	int err;
+
+	ctx->sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_UNMAP, 1, 0);
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
+	kernel_gem = alloc_kernel_gem(ctx, sizeof(*req_msg));
+	if (IS_ERR(kernel_gem)) {
+		err = PTR_ERR(kernel_gem);
+		goto err_free_gem_objs;
+	}
+
+	req_msg = kernel_gem->virt;
+	req_msg->remote_session_id = ctx->remote_session_id;
+	req_msg->handle = uargs->dsp_handle;
+	req_msg->vaddrin = uargs->vaddr;
+	req_msg->len = uargs->size;
+
+	assign_kernel_gem_arg(args, ctx->gem_objs, 0, kernel_gem,
+			      kernel_gem->virt, sizeof(*req_msg));
+	drm_gem_object_put(&kernel_gem->base);
+
+	ctx->args = args;
+	ctx->req = req_msg;
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
@@ -868,6 +981,12 @@ int qda_fastrpc_prepare_args(struct qda_fastrpc_invoke_ctx *ctx, void *argp)
 	case FASTRPC_RMID_INIT_MEM_MAP:
 		err = qda_fastrpc_prepare_args_mem_map_attr(ctx, argp);
 		break;
+	case FASTRPC_RMID_INIT_MUNMAP:
+		err = qda_fastrpc_prepare_args_munmap(ctx, argp);
+		break;
+	case FASTRPC_RMID_INIT_MEM_UNMAP:
+		err = qda_fastrpc_prepare_args_mem_unmap_attr(ctx, argp);
+		break;
 	case FASTRPC_RMID_INVOKE_DYNAMIC:
 		err = qda_fastrpc_prepare_args_invoke(ctx, argp);
 		break;
diff --git a/drivers/accel/qda/qda_fastrpc.h b/drivers/accel/qda/qda_fastrpc.h
index 0c1264380085..157f4c8e270c 100644
--- a/drivers/accel/qda/qda_fastrpc.h
+++ b/drivers/accel/qda/qda_fastrpc.h
@@ -251,9 +251,11 @@ struct qda_msg {
 /* Remote Method ID table - identifies initialization and control operations */
 #define FASTRPC_RMID_INIT_RELEASE	1	/* Release DSP process */
 #define FASTRPC_RMID_INIT_MMAP		4	/* Map memory region to DSP */
+#define FASTRPC_RMID_INIT_MUNMAP	5	/* Unmap DSP memory region */
 #define FASTRPC_RMID_INIT_CREATE	6	/* Create DSP process */
 #define FASTRPC_RMID_INIT_CREATE_ATTR	7	/* Create DSP process with attributes */
 #define FASTRPC_RMID_INIT_MEM_MAP	10	/* Map DMA buffer with attributes to DSP */
+#define FASTRPC_RMID_INIT_MEM_UNMAP	11	/* Unmap DMA buffer from DSP */
 #define FASTRPC_RMID_INVOKE_DYNAMIC	0xFFFFFFFFU	/* Dynamic method invocation */
 
 /* Common handle for initialization operations */
@@ -321,6 +323,38 @@ struct fastrpc_map_rsp_msg {
 	u64 vaddrout;
 };
 
+/**
+ * struct fastrpc_mem_unmap_req_msg - Memory unmap request message with attributes
+ *
+ * This message structure is sent to the DSP to request unmapping
+ * of a previously mapped memory region (ATTR request).
+ */
+struct fastrpc_mem_unmap_req_msg {
+	/** @remote_session_id: Client identifier for the session */
+	s32 remote_session_id;
+	/** @handle: Handle of the buffer to unmap */
+	s32 handle;
+	/** @vaddrin: DSP virtual address of the mapped region to unmap */
+	u64 vaddrin;
+	/** @len: Size of the region to unmap in bytes */
+	u64 len;
+};
+
+/**
+ * struct fastrpc_munmap_req_msg - Legacy memory unmap request message
+ *
+ * This message structure is sent to the DSP to request unmapping
+ * of a previously mapped memory region.
+ */
+struct fastrpc_munmap_req_msg {
+	/** @remote_session_id: Client identifier for the session */
+	s32 remote_session_id;
+	/** @vaddr: DSP virtual address of the mapped region to unmap */
+	u64 vaddr;
+	/** @size: Size of the region to unmap in bytes */
+	u64 size;
+};
+
 void qda_fastrpc_context_free(struct kref *ref);
 void qda_fastrpc_cleanup_handlelist(struct qda_fastrpc_invoke_ctx *ctx);
 void qda_fastrpc_flush_pending(struct qda_dev *qdev);
diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
index 3ff6b598ee78..b2ab3b7837ef 100644
--- a/drivers/accel/qda/qda_ioctl.c
+++ b/drivers/accel/qda/qda_ioctl.c
@@ -254,6 +254,28 @@ int qda_ioctl_mmap(struct drm_device *dev, void *data, struct drm_file *file_pri
 	}
 }
 
+/**
+ * qda_ioctl_munmap() - Unmap memory from DSP address space
+ * @dev: DRM device structure
+ * @data: User-space data (struct drm_qda_mem_unmap)
+ * @file_priv: DRM file private data
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qda_ioctl_munmap(struct drm_device *dev, void *data, struct drm_file *file_priv)
+{
+	struct drm_qda_mem_unmap *unmap_req = data;
+
+	switch (unmap_req->request) {
+	case QDA_REQUEST_MUNMAP:
+		return qda_fastrpc_invoke(FASTRPC_RMID_INIT_MUNMAP, dev, data, file_priv);
+	case QDA_REQUEST_MEM_UNMAP:
+		return qda_fastrpc_invoke(FASTRPC_RMID_INIT_MEM_UNMAP, dev, data, file_priv);
+	default:
+		return -EINVAL;
+	}
+}
+
 /**
  * qda_ioctl_invoke() - Perform a dynamic FastRPC method invocation
  * @dev: DRM device structure
diff --git a/drivers/accel/qda/qda_ioctl.h b/drivers/accel/qda/qda_ioctl.h
index 457ceccede08..e14a39050d09 100644
--- a/drivers/accel/qda/qda_ioctl.h
+++ b/drivers/accel/qda/qda_ioctl.h
@@ -14,5 +14,6 @@ int qda_ioctl_gem_create(struct drm_device *dev, void *data, struct drm_file *fi
 int qda_ioctl_gem_mmap_offset(struct drm_device *dev, void *data, struct drm_file *file_priv);
 int qda_ioctl_invoke(struct drm_device *dev, void *data, struct drm_file *file_priv);
 int qda_ioctl_mmap(struct drm_device *dev, void *data, struct drm_file *file_priv);
+int qda_ioctl_munmap(struct drm_device *dev, void *data, struct drm_file *file_priv);
 
 #endif /* __QDA_IOCTL_H__ */
diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
index 046a1ef1872d..99e6021be6a3 100644
--- a/include/uapi/drm/qda_accel.h
+++ b/include/uapi/drm/qda_accel.h
@@ -21,9 +21,10 @@ extern "C" {
 #define DRM_QDA_QUERY		0x00
 #define DRM_QDA_GEM_CREATE		0x01
 #define DRM_QDA_GEM_MMAP_OFFSET	0x02
-/* Command number 0x03 reserved for INIT_ATTACH; 0x06 reserved for MUNMAP */
+/* Command number 0x03 reserved for INIT_ATTACH */
 #define DRM_QDA_REMOTE_SESSION_CREATE		0x04
 #define DRM_QDA_REMOTE_MAP			0x05
+#define DRM_QDA_REMOTE_MUNMAP			0x06
 #define DRM_QDA_REMOTE_INVOKE			0x07
 
 /*
@@ -44,6 +45,8 @@ extern "C" {
 		 struct drm_qda_init_create)
 #define DRM_IOCTL_QDA_REMOTE_MAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_REMOTE_MAP, \
 					  struct drm_qda_mem_map)
+#define DRM_IOCTL_QDA_REMOTE_MUNMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_REMOTE_MUNMAP, \
+					  struct drm_qda_mem_unmap)
 #define DRM_IOCTL_QDA_REMOTE_INVOKE	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_REMOTE_INVOKE, \
 					  struct drm_qda_invoke_args)
 
@@ -51,6 +54,10 @@ extern "C" {
 #define QDA_REQUEST_MMAP	1  /* MMAP operation */
 #define QDA_REQUEST_MEM_MAP	2  /* Handle-based MEM_MAP operation with attributes */
 
+/* Request type definitions for qda_mem_unmap */
+#define QDA_REQUEST_MUNMAP		1  /* MUNMAP operation */
+#define QDA_REQUEST_MEM_UNMAP	2  /* Handle-based MEM_UNMAP operation */
+
 /* Query type definitions for drm_qda_query */
 #define QDA_QUERY_DSP_NAME	1
 
@@ -198,6 +205,36 @@ struct drm_qda_mem_map {
 	__u64 vaddrout;
 };
 
+/**
+ * struct drm_qda_mem_unmap - Memory unmapping request structure
+ * @request: Request type (QDA_REQUEST_MUNMAP or QDA_REQUEST_MEM_UNMAP)
+ * @handle: GEM handle for kernel buffer lookup (used for ATTR request)
+ * @dsp_handle: Handle forwarded to DSP as the buffer identifier
+ * @vaddr: Virtual address (used for ATTR request)
+ * @vaddrout: DSP virtual address (used for LEGACY request)
+ * @size: Size of the memory region to unmap in bytes
+ *
+ * This structure is used to request unmapping of a previously mapped
+ * memory region from the DSP's virtual address space.
+ *
+ * For QDA_REQUEST_MUNMAP (value 1):
+ *   - Uses fields: vaddrout, size
+ *   - Legacy MUNMAP operation for backward compatibility
+ *
+ * For QDA_REQUEST_MEM_UNMAP (value 2):
+ *   - Uses fields: handle, vaddr, size
+ *   - Handle-based MEM_UNMAP operation
+ */
+struct drm_qda_mem_unmap {
+	__u32 request;
+	__u32 handle;
+	__s32 dsp_handle;
+	__u32 pad;		/* Padding for alignment */
+	__u64 vaddr;
+	__u64 vaddrout;
+	__u64 size;
+};
+
 #if defined(__cplusplus)
 }
 #endif

-- 
2.34.1

