Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB72606D828
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m56zB3s/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=StFFqlPj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B55410FD43;
	Wed,  4 Nov 2026 16:36:53 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 738D810FD43
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 16:36:38 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FirtJ3272841
 for <dri-devel@lists.freedesktop.org>; Wed, 4 Nov 2026 16:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hmnctkQOqSlcJNDZpI/f3GW8bFHAo86SA9tyubOGVL4=; b=m56zB3s/GIp3aK0n
 HaOL6N2dPtpScSklVRfq9cXQe975Jw+9JBLeOADAB/o6/nr9F6EJTopuRgBAPjCe
 tdkz3U0smPlO22yX/+m4I6JhV4B0cS4fkfqZhuzA3wgSvvCK2zGCEQL4Rjs4gMj8
 jlL49/lEn9HIbmPJtRqUgb06IOm51xD2F7YPgp00E7AOqHhKzuKDfNraC59xwzA+
 4jLg/U9mAoDV0jhnc3lb1UhLdF4G2j5hlboqFB8WIb6orMaTyOGopcNTKdFCl5vg
 /eOv7WhMjImyRztmxOd5Xx26P9xoSOpSGTxrFe76rfffZccFsje2m+Ra+poM9tCV
 ykdizA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bngjer-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 16:36:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f37c94ceeso353716585a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 08:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793810197; x=1794414997;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hmnctkQOqSlcJNDZpI/f3GW8bFHAo86SA9tyubOGVL4=;
 b=StFFqlPjIowfLRrq++9MP/Tp78rBcg96aGurZR+IEszZPfd6EU9/NxbnXfPlZ9AZSF
 kGKb9/3SwwRgNyz4+CBDtcnaYaGXUNnzjmGZM0QoVWo3fwHsvmiRGV9Lq7gvhH2289uH
 1hQT3p1pRbWxWkK1HRQqeQH4YDDSRizeKWaBu8saYJsMs3WFLneANpeJD4uSemNvBOCu
 pGlpU9altdT8GCQryI3Vnbnpr/kZVqTTMr2TpX/17s3HYXRPGl9uQlJhRyeXbzN6AmaG
 VOHJxbmwbDbXYOZISGCgvCEZ8m/9R1IPpUEQpbf1GpcXR9ApylLCcDQYNU1FMMUeSC03
 hwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810197; x=1794414997;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hmnctkQOqSlcJNDZpI/f3GW8bFHAo86SA9tyubOGVL4=;
 b=FlWToTfrpaRMryGkcl6Ngp8PPwOPqTxhfGKJZKkpMQl2yjYy5eu1ufVojfH/7J9ubH
 FzFhJt+BcVHQajxq9qlOG9SezTdb58Sg6TNmOm5ZnCEFOZIiYJYWho1s+7xtcJWZsFWm
 0qO5+WTfcd+J/aC5AWvgJczKBRJmamo2QE5aD2/x0orU8xvGDwnWNnHRO9PJKbpY39h/
 HtUlu8jhMAGo/gW8hohKHMk76ILon8fg7RdZ4trnNi7vycMz6cqEN6d7C0ytHrLtWaR3
 I2gLiOf7qa8ttmp3yUxtlwdY+gwpdDz/fu0fOfZWhR2t6QCVk98mYmPpgX2K6t2s+nNq
 quBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxH1p6SsALKUM1mB/5yZerQKiO+6NfyWmqdX7X2ql/I9zCY75UvGVFrlMhbB8/w2YGA1qjzMNzZ8+c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9CPKvpf0wCObMMcvtjmM9lJoQ5WfA9S33pAMZuqVtpMEstNro4
 q7X764h+7MhuBtDU4PDL4ZEqyafJ7vLzp52vwaKimVvEFF5MKhFr9iIV2Q6A48T/RnCJ1dqrkrP
 gvug4y3qOc7168yeA5e3naZTljILpbgHAhUBF4sP7EOcjn7e8wGmA3xvtZ5mVYz5zGAnl89s=
X-Gm-Gg: AYBFou2Ef2PytQ1HmPZ4F6liE9oMEDrHct7vwEkKEQHXht3+cVcnhc5AFrGid/DUN93
 3yeWYU1tT51aWWRNHjZ5tPlO9AGexnfSQil4rYAhfF0Oi/MmIQvZyPTcfS0u58CjHGUHb1X/110
 2k3Us6M4COs8d3+IO9J4ldHeFSWLPmUpvQAP6dXb6exs1Uk+0Qu29ZHOlQp+Aa425nKuLO7Ndsc
 4mllMAzfgjPIXRMSw8AID8hwE3iRi9V4a3rNcgnywULk+u3vYMxDgmEJBrgkIXtohYjDctgxrpH
 rQH7qeN5rIdJ+UC7ijiDUs4ega9N7vXZeiWe6xlxVA9uL2s8AEIjCFKNB3p9viJFrEIWOzrCc8s
 vu4Tc+qUEnRJpS3QTTdluqD/iX+gljgutu5JlOMtRBol/gUHZs/EkywAKE+upo6asNhbap2DGLQ
 P4Qz2vzjJ13yBmT1uNz8EdTHK50QH05NJfr+4oF+NLK66UvXmYBr739WryCR4EzA==
X-Received: by 2002:a05:620a:410f:b0:93e:53db:d59e with SMTP id
 af79cd13be357-9441338b4cfmr3099621185a.23.1793810196574; 
 Wed, 04 Nov 2026 08:36:36 -0800 (PST)
X-Received: by 2002:a05:620a:410f:b0:93e:53db:d59e with SMTP id
 af79cd13be357-9441338b4cfmr3099612885a.23.1793810196023; 
 Wed, 04 Nov 2026 08:36:36 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3acdc6bed64sm5267191fa.7.2026.11.04.08.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:36:34 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 18:36:09 +0200
Subject: [PATCH 5/7] media: docs: pixfmt-reserved: describe the QC08C and
 QC10C layout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-ubwc-format-docs-v1-5-389044012b4e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5263;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=1OfyeKpg9SI28jpOvwv81zI2qbKFoyNRZrDSfeIXOIQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq618FUrwLTtJam1l5ngbz7ZqLghcNF67hlfAGQ
 LmaO//9uzCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCautfBQAKCRCLPIo+Aiko
 1SqdB/48JOwOXGgB6EFrl/RBSNn5kwXfc2kHX+HSIMrob0xEG2LypCY5LwWmH9Uo7hJqHSk9Aj3
 QsRKbRqbqKuCM6z1nu03b7x+L7lj5Yi2uhYzFhQQF60hLQZya5qkEzUImUCXCQCzc17cT6yGpa1
 SU1yDT65cBLQ9YV1qFJ2J3mN2ruVM8wMjItAjpXGxFGXKTVnENuvgnH7VQpL5sltFYpuER2A2iW
 wwx79ASinjlez0l+Ev5y2ZCFlzT7uGzSc63iuJVMVxmXCxoDSXi3lPbrqRwep85zsYY085f6jkA
 ONgoRUTxdwBGgJzKLTP1Ar7z7G1QBIvrkv0OsB57uZqrbyiy
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX9eFeKOwuJmaL
 hgp4Grr5jcX/dUpti1GIPFHlW9Noeq7BnDwTcesMdBkZ1rznGXiROgUXYYkIN3areskT0kNgw//
 6tdsY8HPK3W/N0FBGgIDL5ELXO/pQy2DhEbet76VuRcQnSXDcGV6385tJN62fV/4Du0jVGtiDlt
 MthY2uiIvChvvyFbo2OaZ5QdeB6P1Jm5ECxy1hFjrbPEIX5RHJqggkAsO0Ei2k1pk/Bfopcb32f
 BtlkjfIuoCzplE0Xqgy9D7tJ3D5DplxV2NzGBTLGPmdts6gLUL0HNH6v7EXKogUg1YiPqQ6lONx
 MvpizlS4hbL0F+S0LLmj1jw5KoNuxCThwS0WaZFehHOUd+0P/ufWpcvp/grP9DPNTk0XZvLa8L+
 uuVH6MhnTQtu+bWhvr0quLyJMNJW13gY4L+HaBMos7DbSnQQ5EhFYXdAI2ShHV8o8NERwF3Cjma
 Gcd9WxRgzbXi5JjwFfQ==
X-Authority-Analysis: v=2.4 cv=KLLPn1Fo c=1 sm=1 tr=0 ts=6aeb5f15 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=Eh1Ucz_HWyYK4_jupWgA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: Xrrd-S1nraSL8R_yHExdD2lamruEkhbd
X-Proofpoint-GUID: Xrrd-S1nraSL8R_yHExdD2lamruEkhbd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX2YQ6C/jFlBxF
 HtPkYqhzwapYCoMG5/Inv5vcR5d7Zvstbqi7kWuNJo0NFo6FPsp1b5k5EB00pg86VDumFqJI7ZQ
 b5ivI9jxsnHVBBe+3x+AC6/4Y/pakoU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040066
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

QC08C and QC10C are documented as opaque formats with four planes, or
eight for interlaced video. Neither is true for the drivers: Venus and
Iris use a single memory plane, nothing produces interlaced buffers, and
the display controller and the GPU import these buffers, so the layout
is part of the contract between them.

Describe the sections of the buffer, their order, strides, line counts
and alignment. The compressed contents stay opaque, they depend on the
UBWC configuration of the platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../userspace-api/media/v4l/pixfmt-reserved.rst    | 63 ++++++++++++++++++----
 1 file changed, 54 insertions(+), 9 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
index 1cf6c59f4bc4..3ff6499970e1 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
@@ -245,20 +245,65 @@ please make a proposal on the linux-media mailing list.
       - ``V4L2_PIX_FMT_QC08C``
       - 'QC08C'
       - Compressed Macro-tile 8-Bit YUV420 format used by Qualcomm platforms.
-        It is an opaque intermediate format. The used compression is lossless
-        and it is used by various multimedia hardware blocks like GPU, display
-        controllers, ISP and video accelerators.
-        It contains four planes for progressive video and eight planes for
-        interlaced video.
+        This is NV12 compressed with Universal Bandwidth Compression (UBWC),
+        a lossless compression used by the video accelerators, GPU, display
+        controller and camera. The compressed contents depend on the UBWC
+        version and memory configuration of the platform and are only meant
+        to be accessed by the hardware; the layout of the buffer is defined
+        below.
+
+        The format uses a single memory plane that holds four sections in
+        this order: Y metadata, Y data, CbCr metadata and CbCr data. Each
+        section starts at the beginning of the previous section plus its
+        size, which is rounded up to a multiple of 4096 bytes. The metadata
+        holds one byte for each tile of the data. ``bytesperline`` is the
+        stride of the Y and CbCr data. For a ``width`` x ``height`` buffer,
+        with the CbCr plane being ``DIV_ROUND_UP(width, 2)`` x
+        ``DIV_ROUND_UP(height, 2)`` samples:
+
+        - Y data: stride ``ALIGN(width, 128)`` bytes,
+          ``ALIGN(height, 32)`` lines.
+        - CbCr data: stride ``ALIGN(width, 128)`` bytes,
+          ``ALIGN(DIV_ROUND_UP(height, 2), 32)`` lines.
+        - Y metadata: 32x8 pixel tiles, stride
+          ``ALIGN(DIV_ROUND_UP(width, 32), 64)`` bytes,
+          ``ALIGN(DIV_ROUND_UP(height, 8), 16)`` lines.
+        - CbCr metadata: 16x8 sample tiles, stride
+          ``ALIGN(DIV_ROUND_UP(DIV_ROUND_UP(width, 2), 16), 64)`` bytes,
+          ``ALIGN(DIV_ROUND_UP(DIV_ROUND_UP(height, 2), 8), 16)`` lines.
+
+        ``sizeimage`` may be larger than the sum of the sections.
+        The same layout is described by ``DRM_FORMAT_NV12`` with the
+        ``DRM_FORMAT_MOD_QCOM_COMPRESSED`` modifier, with both DRM planes
+        referring to the same buffer and the Y metadata at ``offsets[0]``.
     * .. _V4L2-PIX-FMT-QC10C:
 
       - ``V4L2_PIX_FMT_QC10C``
       - 'QC10C'
       - Compressed Macro-tile 10-Bit YUV420 format used by Qualcomm platforms.
-        It is an opaque intermediate format. The used compression is lossless
-        and it is used by various multimedia hardware blocks like GPU, display
-        controllers, ISP and video accelerators.
-        It contains four planes for progressive video.
+        This is the TP10 format, YUV420 with three 10-bit samples tightly
+        packed in each 32-bit word, in both the Y plane and the interleaved
+        CbCr plane, compressed with UBWC as described for
+        ``V4L2_PIX_FMT_QC08C``. Each 192 samples of a line take 256 bytes.
+
+        The format uses a single memory plane with the same four sections as
+        ``V4L2_PIX_FMT_QC08C``. ``bytesperline`` is the stride of the Y and
+        CbCr data. For a ``width`` x ``height`` buffer:
+
+        - Y data: stride ``DIV_ROUND_UP(width, 192) * 256`` bytes,
+          ``ALIGN(height, 16)`` lines.
+        - CbCr data: stride ``DIV_ROUND_UP(width, 192) * 256`` bytes,
+          ``ALIGN(DIV_ROUND_UP(height, 2), 16)`` lines.
+        - Y metadata: 48x4 pixel tiles, stride
+          ``ALIGN(DIV_ROUND_UP(width, 48), 64)`` bytes,
+          ``ALIGN(DIV_ROUND_UP(height, 4), 16)`` lines.
+        - CbCr metadata: 24x4 sample tiles, stride
+          ``ALIGN(DIV_ROUND_UP(DIV_ROUND_UP(width, 2), 24), 64)`` bytes,
+          ``ALIGN(DIV_ROUND_UP(DIV_ROUND_UP(height, 2), 4), 16)`` lines.
+
+        ``sizeimage`` may be larger than the sum of the sections. There is
+        no DRM equivalent: ``DRM_FORMAT_P010`` with the
+        ``DRM_FORMAT_MOD_QCOM_COMPRESSED`` modifier stores 16-bit samples.
     * .. _V4L2-PIX-FMT-AJPG:
 
       - ``V4L2_PIX_FMT_AJPG``

-- 
2.47.3

