Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E032C606A334
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cFi+GMAT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NzE4Aj+c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E59810FD3B;
	Wed,  4 Nov 2026 16:36:50 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF90110FD3F
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 16:36:36 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4GUYTZ763877
 for <dri-devel@lists.freedesktop.org>; Wed, 4 Nov 2026 16:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iimt5F36G44tPNYEFxjnFuU3no1lGzf4ouTx45FX12k=; b=cFi+GMATdZpiLZQ+
 ESk+1+NNVpPg8fSXYpI33gSwGJrZZFg047bQ9eo52P61uKZuXhfBPl+MGofxZrEE
 X34fMtLJ4MJFRpBddLB9lVJ/N8zXNfBotRltZCCFnA4FVsYI0BQpmVNg7cfS5m9s
 k7jAeL7i+frt04nIaaQkuv/8s38X4Z/CP/kk1yKlKtWBzCkGdrMDjkja4vmbFudU
 khTEdls1f4giQbAlFmAMpRn5vm2iCrlJX3zerrSEJzpHwwBRxOO7OoqOw0a9cBJZ
 1sa1XrkMSbsG2hgCj/go6zGUHIEYIqtLBOcMnJwGNkLeB0nH8Dwug6DOkEG6f3YC
 oa9TMg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr89sr187-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 16:36:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f2005ce21so161251085a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 08:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793810195; x=1794414995;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iimt5F36G44tPNYEFxjnFuU3no1lGzf4ouTx45FX12k=;
 b=NzE4Aj+c0q1nuy0iiwjQjLBPcGtfaKr+Y36xQzoY+e9kGIPDET+13kLX/tm0KWqQ52
 kRSFa0mbRSct2DMscV0cmxQt4pI1YzVZa/DkBxUhngrnPBKk2uSdbPPOjP5T5TkVlill
 xL3d1QuTv0i8prnoK0c7zDU1w/FwVu1gNL2yX6y3U7pIJw/H5H7QsU0p7QGsK8nzUCvj
 j2VumjRUdltoDdkRBxM5VdLpI1iwXfeh5n3xHVkQSpgfAAw6YVzlrhzEBaHLo//wjl0h
 6YZgBPtBr8Ak1IZSnxjbuKEgYYLSEpaIkh7MQIVOxAYZSm+MgNBjlEJCzoCsPMLKExPK
 7Xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810195; x=1794414995;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iimt5F36G44tPNYEFxjnFuU3no1lGzf4ouTx45FX12k=;
 b=UcpKKlfffG7n/SjiWIgfoDc1cOKk77A1o6jVzItYOvoX2LDB6khl5NSgjE+mUHlYTj
 +3izX+u/OrZzPd38x8D7qfX9TNAYFVYr5l4vLrjvLKA29S0bRNbHUEuc+IINrp8BifO9
 oVQEZ9DCUn70LoDi8Z24E1BdS4f2UQ9+914HfQPdtCE5BoOE8BU3YIvO4g9REiRmrWy9
 p3CQB+W7UKGNHUoC/UbrqH5tDHXQfMnqalCzoo3M9EnxVcmvM1v0GM93waa1holYoJTC
 3SlmDPICJEULLlHyDU2yXZMAvBwBJ5lV+/7uWRSqZJJqqTvo2PtyLrrTNZLbO1ASRiV8
 rFfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCabXq75FJ8shUMBei7kA4134/DRuY9l/7ynsYfSrFdR3u3et4RmLy9DqwEnnq9GH7HfGUrDybbTc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/gSuT7Qmls2UXVDbHpu3KaXgWBJvR+XS+YQXoNCa6X6eHdBfEs
 QBwc0CDm5Y8P/iAlO31Gw9FS5rWKCJ4LdzDGlYe8S01hIg1PYY57fdm9G86tnIRcKnWGkoVksnq
 uGUve46xwQhMh6qVXZ+mpJuNRSPGD4jo6PQISBLZMg0GbtTDtoOtHlmxOOKQNYvqqt3NLYpg=
X-Gm-Gg: AYBFou0MMCbZL/IUH1nUu+l74So9CsWF7bxCbFA4ZQxSRG0syHq9PCZfyS/55Y3rLtC
 PkDVm0cMLNAuzXh5glcFhZaVTUQiyorY24AbY7+wN6If3WVfR6z6idZYTGSvhavXR8XjhJvGaQ6
 E8CBg2pXfo4Gta529tJW5mpUnSOIaurF/LrRfLaD/QjeyCAbaRqR8w2ATF7vS+Zn9q6x7Y7YBrP
 lhQvzTCKYmdtttX3O3R9pIsD441/OKx73NPbCRU1/h+0PLgn6JOuGUvKm0whN/tvyYgwaIRhUAR
 g4suH10/gYyr0eVBX2wOu8Id8nhLo5qb2kqezV7yy/rYnOWh6eQ4xqNhPLQALR8XAKXO5QAn9pC
 B1+y9n/NgSaXRB2megwB5rqMERAgWJ+sujSmOi2qADxr0O+xK0Y8XcqXatuK9ENLIAtMICRE9VJ
 gv9OVIo+dybM6ECdH60273UtouDmM5qe5I5nrxlRVkLuKrWBesAzMRlNktjUTl+g==
X-Received: by 2002:a05:620a:608b:b0:943:f2ea:5ee7 with SMTP id
 af79cd13be357-94421659ddemr2603616085a.23.1793810194786; 
 Wed, 04 Nov 2026 08:36:34 -0800 (PST)
X-Received: by 2002:a05:620a:608b:b0:943:f2ea:5ee7 with SMTP id
 af79cd13be357-94421659ddemr2603606985a.23.1793810194196; 
 Wed, 04 Nov 2026 08:36:34 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3acdc6bed64sm5267191fa.7.2026.11.04.08.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:36:33 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 18:36:08 +0200
Subject: [PATCH 4/7] drm/fourcc: describe the Qualcomm UBWC layout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-ubwc-format-docs-v1-4-389044012b4e@oss.qualcomm.com>
References: <20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com>
In-Reply-To: <20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Bryan O'Donoghue <bod@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-media@vger.kernel.org,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Robert Mader <robert.mader@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4964;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=NEuVWpWw+ZvRtd/ph1qijykYD+geIIf1V4AoPskkiBs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq618DOnOCXWOdFy9DrR+HTZ+OufFZQnRzOL58j
 QhxFDE2o1iJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCautfAwAKCRCLPIo+Aiko
 1TkeB/9/YScH28RnzVapYiP/35zH7PBwopbsXbqYiu9NNpAg8E71VSwtVG2P0Ts7TpgVNvFIvl/
 6vdwSasVx1ubjKGzAn9YtmrTKVAHq3/wKmVSrwXHrIYFsz/JbjUU67Z+TgV8Es/pNifCDt/ppr/
 fcZjFclGlr0Uv83d871E2h34UvBGc4WSdwGhf6RDLea2csRitdQtZnQ2arZiQmlc3rYt93mazm7
 4LgxvpTxiIusG6cvXAaE3JPs7IVg14uFcPeIfRQY+XVN9YcUqCe6yFLsAQXcVh4eUc1C8hEggbi
 XD4tydgQPJdu8/ZImTv9xbJMRE2fgHPaQhjBVHw9W1O9sN+o
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: zwi_Jpg7cwGsJlWCfB84itTJ4jz7McsW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX3mTduhuDpTNk
 tPmQigNQyFsw1QVNPQ1PuN82hB0r2flQxTfaa3J2t5tl66+Uu5gJdV2aUo66HM7GhEQg94H6a2A
 SB/R5+sunZVM0b3uY7khEAtCXiuh3ZQIjSMTrkoS+73qjS+InnXSRSmSLEIKV4xMxIW51zHpVR5
 MJDtu4R1VF/XMHfesZVFRhxfMtLrWLO5dMUrTeolfuBJzNzWiGLb5CEhb0HSIPr6P0biUdwqhEE
 HCfOvNWZ2K86H87cUYqu+rBl5uNUL2dN/rbKMW91adjuTRx7xUgjQ/uCQkaoczwhJbPOREXcoZu
 +kEX2VcGzDUkqoSm3JmpAVKsYJBY3IA1HiGe0/909K9dLoa1AWw760/UnV1zhTzEK4ffe9mrXns
 bYH4xe2C4TC1d8HVgvMfNV6iO+EEurgknjch1SlhUReAnBCRfVrSxQp+vXCcRSKcn6LUVWpqKId
 oO9WNbLk7dNprm6CmAQ==
X-Authority-Analysis: v=2.4 cv=N628hG9B c=1 sm=1 tr=0 ts=6aeb5f14 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=TpXcIlR_JNNDu9J-qogA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: zwi_Jpg7cwGsJlWCfB84itTJ4jz7McsW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX1r7/j3+99Pmg
 ccePIxeZuSxBOW4Ocm+QbC8ZbDyo1pnpHINhXLX1N+8JlTSVWgnr/sJqm/G1HVCZ/tKpk3aTern
 A0CpBMwC9HlYtJOVUIrILZoBPcXHbww=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040066
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
reports offset 0 for both planes. Note that P010 stores 16-bit samples,
unlike the packed V4L2 QC10C format.

The layout is stricter than the display controller or the camera need,
as they can address the metadata and the data of each plane separately,
but other users depend on it. The video firmware takes a single address
per frame and places all four sections itself, and the Adreno texture
descriptor for multi-planar YUV has only one address per plane, finding
the data after the metadata. Buffers shared with these devices have
to follow it.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/uapi/drm/drm_fourcc.h | 54 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 0bb049f91524..4b6a4a827f6b 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -820,13 +820,53 @@ extern "C" {
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
+ * Two-plane images are allocated as a single buffer holding both planes,
+ * with the CbCr metadata following the Y data, so the CbCr plane starts at
+ * offsets[0] + Y metadata size + Y data size. handles[1] must refer to the
+ * same buffer as handles[0]; offsets[1] and pitches[1] are ignored, userspace
+ * should set them to the CbCr plane offset and the CbCr data stride.
  */
 #define DRM_FORMAT_MOD_QCOM_COMPRESSED	fourcc_mod_code(QCOM, 1)
 

-- 
2.47.3

