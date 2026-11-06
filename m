Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147F5606EE97
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EeQM/4kW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ceHyJc/i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6EF1112DA2;
	Fri,  6 Nov 2026 13:45:01 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0EC1112D9D
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:44:47 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6APOGQ2076370
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 13:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T1R6BuIc6DXQGz75sImpTyNUbfCE2LnmujKp5A9+yb4=; b=EeQM/4kWhFmOJuwe
 PcaNygUpWGunYh1Mf9T4qVZvMW/qajo+zbGNycZemiUV+mb2LW/W92nVqxyNzi4S
 +q8Q++hDwx3V7UcsJ5+yRX+iWA1MXrB4Ey4m3GNoDB1p/a0gJRnAhLpaN3q02Bkn
 iZed9h2i4K/C7bLJvI3upAb40DuZL9Gq9JTWEYbn0H9PiXtWg5h8k+GpIdCUmNiZ
 118LSYTGGWXuTfYHB9JMHvHUOwk0IBAD2iygGw4PNIYKe7RgpeMbApj+hEoSF4BV
 m/OYzV7nV06BbQtRwzlZkJsD9P9P6uFRflxNYDydoZQYNa2HuCbngaeIaFhTyyRf
 Oa6ipg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pcaycw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 13:44:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb98809caso120318285a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 05:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793972686; x=1794577486;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T1R6BuIc6DXQGz75sImpTyNUbfCE2LnmujKp5A9+yb4=;
 b=ceHyJc/i0wM2aGC9C0XiIPmmvvVsIM34lCwKNCKms9yB8pEs3DdIhirUAmUB04GeBQ
 DYUrzFreFH9piUMP0El3hbThkYUcPdX7K8L4o+09krMGEfbMgd/6ksn86sPOJh9shQ63
 rnIRi36ihxvQdRWvyi26qOVE59U/xGTbIIKDOH4paSz9pnkKvwKQ8QHsju/uDSl99e5J
 Sqxx4vhb0CILhI/kqZW7cjPJiLb21Px5sbryKNRW/fPy8DtyEO4Ch1zwM2ODKz7OXkDa
 yW4pDGfRE9nN87w+lRopbjUOXmb7AT/u7ho+IZUN9LO5BHl9Lp+bpcajPBYsRW6eV983
 d19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793972686; x=1794577486;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T1R6BuIc6DXQGz75sImpTyNUbfCE2LnmujKp5A9+yb4=;
 b=gP9xpxs5a0Mtf5xOyVv7+ecuS6Sal6qGTzMR0n3PmstnUqfx1ep7iTDQYqd9QWKMkk
 YOXdunb4BGKQOHX7Pnr52UEZT69mj4GsaWmvct5OprKpM+xfWQguy/u86HpZe24qIogj
 /xrohege1fjfvVGTnAxrldVo8twF2wy93P/MU8XTQ68jjDmcSx3O4BzIRz1nPqzdzrKv
 LaZ2Q28zLeccE2tDabQ+s+2rc46PIvO30eiqkAMOywHg41qqTXeYpTe5K8J09H0C8UNz
 ivVwz+jIkbMxvEmSvMbJtrsKr7J+oDNPRKv98xpSibAUWaMDOJRSC/5YlAUTwZvaCbOB
 A2Wg==
X-Forwarded-Encrypted: i=1;
 AKwUvByhqKbZmdEEsvrRGCACFjyVl/Dog9dMCVS4KHkUILhaScd+p5wspFJtR3TQIV410mlMXekHaulaU/g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/bfKC4O1WLpAN3/RFUKliO1Op6G/esRFjK/+YWTY8LMdshbY3O
 Hcs4H+QWJlnwFTC6FZ9gytPBwyCzNDKgVbTTExvpEUNNjhO92fv7+7B6QJVqBgScUIHZOxJpSJx
 Mtuwt56wLkND+cMtQk7r9gGjxXr7Di7KBlBq8awAzrzXHxaUUVLjM19SaLwWfiqSXhJcfHpM=
X-Gm-Gg: AYBFou1QZAYV+kvwChRKROxB00PY1zgeeNnCO9oPqmwKEUOV4XXxxsctG0qpOa/5le3
 qa/3mFWqT5uuCgFeOezOEEnLUTYfmh3bIttLJ8t3WqXyOs2giG7xxqg4zVxXlZBSGGXHM5jCQw6
 kz8JTeVGx25AA4eXJkR8/tyfsx0+pnAzFib0LsoTe6j+m1roKLkPXakFSW5/6hxIafDVQBT0F+a
 H2bDvWVIKToy8R/Yp3TQdQzcHVw/536tpil0TV1mYL6YOD2Sl4E6Bk1lUj6iSGr+qxzeoW6H6F6
 CLsyQGZqOHRvKPQ5NW096qQO+FARzfMw4Z9LSi8smvfPlLSCh1ZGOFcla2n0djtbMdxeBhFxP/9
 zR2Sj+7bj+n1h70myt5g7vLbHsZ0fO4jLr2RoDvFVG9CYpEpflj9KyaL99Q4ArOE9OQXJ7YAX6Z
 w+1PXGvKN47GMpDm8VQXuE2m5VMnFG9YWsFLys0vTwGI+yvbLH1SlE8Q/CvPZISA==
X-Received: by 2002:a05:620a:4397:b0:93f:2941:6b8d with SMTP id
 af79cd13be357-945f33aa172mr297780985a.6.1793972686134; 
 Fri, 06 Nov 2026 05:44:46 -0800 (PST)
X-Received: by 2002:a05:620a:4397:b0:93f:2941:6b8d with SMTP id
 af79cd13be357-945f33aa172mr297777385a.6.1793972685536; 
 Fri, 06 Nov 2026 05:44:45 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c003055a5csm382747e87.13.2026.11.06.05.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 05:44:44 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 15:44:11 +0200
Subject: [PATCH v2 5/8] drm/fourcc: describe the Qualcomm UBWC layout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-ubwc-format-docs-v2-5-82949f88f030@oss.qualcomm.com>
References: <20261106-ubwc-format-docs-v2-0-82949f88f030@oss.qualcomm.com>
In-Reply-To: <20261106-ubwc-format-docs-v2-0-82949f88f030@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Bryan O'Donoghue <bod@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-media@vger.kernel.org,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Robert Mader <robert.mader@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5526;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=PBEbayVdH87klbKtk5JOaPGn9vN61SzfT+b4Hydj4Zc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq7dm4K3gdV0YxTzrffH3VlVj75NZoqa3yzqEaQ
 a9GxW2OtPqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCau3ZuAAKCRCLPIo+Aiko
 1TvCCACZKz5loZofq82owJSku5llc757ammPyLgmm0rXElo0OADaT0aD3SruDuNtNJpWCQroA8y
 oHrCGBz2fJjxdCrxIhQEA1qMZ/yoeRfRMShwqLN/d+8MdRtNuhpWhlhToB2KmVvBRmi7uDNSDqp
 WT6I4JhhR6edEeW+sOuTxWgMoYResv+ZDakPhqmr/YzkvcmTNLQOujrlIySARsCbT35Pu65si8L
 uZqcNf4Fj+eES6fIKRtEsRbpMlYRGU9L63hcX7w6DUEeVUR/ZZlsRfVNQcv9N9qznrMooNv1Sf6
 BUozs0duG3j+G3ppFiKX2a8fjlsE/ZDAxmy5ypJLz/eDs+yW
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: OoQgg7LKsCleovxq8_7o4H1Y15hcYzzX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NCBTYWx0ZWRfXzPKnXsmBL7YL
 QtphE8jtbv3XTtspVNMnBk02i4JSzXlvyhSVlKDk6cxPjfGNaF20zHpzx4aNmZljQxh6F/9871W
 lwbXwEfa/0Hbcnafde65CZtSvPXTDXu0LZgo4Y+tkEBMlZs5q7yNQZrTCZBhL6lOWxVDK7MnPXE
 U4hefE327eNkRuHIg6dXaYXyaYUDNzI8LkmpSi/KaJiniakQQ87tC0iEiARso9u7Lyx0M9om1PK
 1bxmxqBCFCEOYK77oXDpmH0Wp5NjM1bxOTTMjbE/c0FWWwunVQT6fJ7iftERpl/fdKYqlbe5I/R
 r24XpzrvBMOIOG2SXxQyhDy0AWVp0rQzhgFj2bVIDwkTCpxVxj3NRRAVF245eIl0UJHuFnmdHQb
 8DfNIc1Hg04H4nHp68BEOpbfuBMAP2MCSt9s/vZzuN5ibUUO79aGlV8kjYUGrd1rabUAQtyton1
 odf+pI6IaJbq1Cq78gg==
X-Proofpoint-GUID: OoQgg7LKsCleovxq8_7o4H1Y15hcYzzX
X-Authority-Analysis: v=2.4 cv=TI3Q2Fla c=1 sm=1 tr=0 ts=6aedd9cf cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=U_HTlJNxgaGUaFeKA3EA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NCBTYWx0ZWRfX1BYEPKLotj2i
 6oNEoB8n2zxoTllpYp4Tkxx/S7Mx8tW81yIeaLlOFAQFSoHeMbMy3aWCvntZQwUQK3SUOl2g7mj
 mgDTptx7HLvIGiseWgHsq379BxXb5yE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060054
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

The DRM_FORMAT_MOD_QCOM_COMPRESSED description talks about macrotiles
but does not say where the metadata is, what the pitch refers to or how
large the planes are. The msm driver derives all of that from the width
and the height, and the GPU drivers and video decoders allocate buffers
to match, so the layout is uAPI whether it is written down or not.

Document it for the formats the display controller supports: the
metadata before the data in each plane, the tile sizes and alignments,
and the CbCr plane following the Y plane in the first buffer. The
display controller has always fetched it from there, ignoring
offsets[1] and pitches[1], and existing userspace depends on it: turnip
reports offset 0 for both planes. V4L2_PIX_FMT_QC08C and
V4L2_PIX_FMT_QC10C are the same layouts for NV12 and P030.

The layout is stricter than the display controller or the camera need,
as they can address the metadata and the data of each plane separately,
but other users depend on it. The video firmware takes a single address
per frame and places all four sections itself, and the Adreno texture
descriptor for multi-planar YUV has only one address per plane, finding
the data after the metadata. Buffers shared with these devices have
to follow it.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/uapi/drm/drm_fourcc.h | 64 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 7 deletions(-)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 0bb049f91524..2c9f56df64c0 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -820,13 +820,63 @@ extern "C" {
 /*
  * Qualcomm Compressed Format
  *
- * Refers to a compressed variant of the base format that is compressed.
- * Implementation may be platform and base-format specific.
- *
- * Each macrotile consists of m x n (mostly 4 x 4) tiles.
- * Pixel data pitch/stride is aligned with macrotile width.
- * Pixel data height is aligned with macrotile height.
- * Entire pixel data buffer is aligned with 4k(bytes).
+ * Universal Bandwidth Compression (UBWC), a lossless compression used by the
+ * GPU, display controller, video accelerators and camera. The compressed
+ * contents depend on the UBWC version and memory configuration of the
+ * platform and are only meant to be accessed by the hardware. The layout of
+ * the buffer depends only on the format and the size.
+ *
+ * Each plane consists of a metadata section followed by a data section, and
+ * the planes follow each other, all in the buffer referenced by handles[0],
+ * starting at offsets[0]. Each section starts on a 4096-byte boundary and its
+ * size is rounded up to a multiple of 4096 bytes. The metadata holds one byte
+ * for each tile of the data. pitches[0] is the stride of the first plane's
+ * data and must match the value below; all other strides and offsets are
+ * computed from the width and height of the framebuffer.
+ *
+ * For a width x height framebuffer, with subsampled planes being
+ * DIV_ROUND_UP(width, 2) x DIV_ROUND_UP(height, 2) samples:
+ *
+ * RGB formats with 2 or 4 bytes per pixel (cpp), one plane:
+ *   data: pitch ALIGN(width * cpp, 256), ALIGN(height, 16) lines
+ *   metadata: 16x4 pixel tiles, stride ALIGN(DIV_ROUND_UP(width, 16), 64),
+ *   ALIGN(DIV_ROUND_UP(height, 4), 16) lines
+ *
+ * DRM_FORMAT_NV12, two planes, Y then CbCr (V4L2_PIX_FMT_QC08C):
+ *   Y data: pitch ALIGN(width, 128), ALIGN(height, 32) lines
+ *   Y metadata: 32x8 pixel tiles, stride ALIGN(DIV_ROUND_UP(width, 32), 64),
+ *   ALIGN(DIV_ROUND_UP(height, 8), 16) lines
+ *   CbCr data: pitch ALIGN(width, 128),
+ *   ALIGN(DIV_ROUND_UP(height, 2), 32) lines
+ *   CbCr metadata: 16x8 sample tiles,
+ *   stride ALIGN(DIV_ROUND_UP(DIV_ROUND_UP(width, 2), 16), 64),
+ *   ALIGN(DIV_ROUND_UP(DIV_ROUND_UP(height, 2), 8), 16) lines
+ *
+ * DRM_FORMAT_P010, two planes, Y then CbCr, 16 bits per sample:
+ *   Y data: pitch ALIGN(width * 2, 256), ALIGN(height, 16) lines
+ *   Y metadata: 32x4 pixel tiles, stride ALIGN(DIV_ROUND_UP(width, 32), 64),
+ *   ALIGN(DIV_ROUND_UP(height, 4), 16) lines
+ *   CbCr data: pitch ALIGN(width * 2, 256),
+ *   ALIGN(DIV_ROUND_UP(height, 2), 16) lines
+ *   CbCr metadata: 16x4 sample tiles,
+ *   stride ALIGN(DIV_ROUND_UP(DIV_ROUND_UP(width, 2), 16), 64),
+ *   ALIGN(DIV_ROUND_UP(DIV_ROUND_UP(height, 2), 4), 16) lines
+ *
+ * DRM_FORMAT_P030, two planes, Y then CbCr (V4L2_PIX_FMT_QC10C):
+ *   Y data: pitch DIV_ROUND_UP(width, 192) * 256, ALIGN(height, 16) lines
+ *   Y metadata: 48x4 pixel tiles, stride ALIGN(DIV_ROUND_UP(width, 48), 64),
+ *   ALIGN(DIV_ROUND_UP(height, 4), 16) lines
+ *   CbCr data: pitch DIV_ROUND_UP(width, 192) * 256,
+ *   ALIGN(DIV_ROUND_UP(height, 2), 16) lines
+ *   CbCr metadata: 24x4 sample tiles,
+ *   stride ALIGN(DIV_ROUND_UP(DIV_ROUND_UP(width, 2), 24), 64),
+ *   ALIGN(DIV_ROUND_UP(DIV_ROUND_UP(height, 2), 4), 16) lines
+ *
+ * Two-plane images are allocated as a single buffer holding both planes,
+ * with the CbCr metadata following the Y data, so the CbCr plane starts at
+ * offsets[0] + Y metadata size + Y data size. handles[1] must refer to the
+ * same buffer as handles[0]; offsets[1] and pitches[1] are ignored, userspace
+ * should set them to the CbCr plane offset and the CbCr data stride.
  */
 #define DRM_FORMAT_MOD_QCOM_COMPRESSED	fourcc_mod_code(QCOM, 1)
 

-- 
2.47.3

