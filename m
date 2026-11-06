Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42500606EEA1
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tzq6u5mM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FFYTOK0c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4344D112D97;
	Fri,  6 Nov 2026 13:45:02 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26D03112DA2
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:44:50 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6APNC2114837
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 13:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cMGWArbInFfU56ZSuyy57z76nw1Q/B0mKQVzCGj4gek=; b=Tzq6u5mMsJ9yzKJx
 10rfn7hWFlrl+4uV5O7yRbkf5OFW1QMdWTQcnAiBpTUCIVj2aH95BFJMGli27USs
 E0JqDVuUhWw3NYWH90IEGLBRblSKSoCB2GTDiPabFQvSA8pRny74HAQ8/nLhukDx
 FkRKe2881SuQrtuQDn4NlXLOeli0wp/JXjObNnkkvTJXmY36WwsAq93r6EYa94Xj
 HLhn0CYjFQdl3sM+dSxMIk0AO6GAgfUNQpV1yrqxI7RCuUi4X2ubhrhy8z5aGcHe
 k0dpAUU8DLGDQXB9myTxKBuK3hkQfjFNERTjfssf2HCaXMXeOZSVAWj9ata1r3Q6
 7Nie9w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3patywd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 13:44:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f33438950so150233585a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 05:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793972688; x=1794577488;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cMGWArbInFfU56ZSuyy57z76nw1Q/B0mKQVzCGj4gek=;
 b=FFYTOK0cILgxJHO+q7itk2nzQg8EbbGcrNc+YIPLKrAx7tU1lq1sgSH/sDp2AZsBJr
 oS9UZ8zm3lAOvIpGvJg81kD2aBbwEGojTgWzpWh/4tpZxA87XQAgrtX8QOzlMAFplBaR
 tixPzHaDeu8lHqYSWa/i+k3fflcPgU9GSnYTylWhhZJ2z4cCu0xag7F7dBwz7mr6YpOh
 9QHx1QReYefEyctQTB6YAAtvq4grPzOWKe5e1pv//zzrXVZfF32tuUsqGiwgbbHkrDND
 guWb9HH0RwMKNql2KemGmsEbo/mQfO0w/J45DftMOIP7ZEkIo1rWNv7PwVVepiPpntod
 40kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793972688; x=1794577488;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cMGWArbInFfU56ZSuyy57z76nw1Q/B0mKQVzCGj4gek=;
 b=1GjdCBNeYvXJ/4bo2otNPlaQQiHlmxLTs7pUj1t1zK+3w7Lcz4uguAYPANBp61GuTW
 R/MxK3ZDPMf1GITU9g9BinjxJY24MlUyL6NZ4QsWsepysD/lBq1HDxIeQIcfKJNKN/uQ
 mwKMYGnADFF6IVOanGCHsdzRBB5yH41o/2MzYAI7n7COJddLGR5vl7/j2p2Z0iplUOtH
 0YwcTCWRhXckCk6WjwZ7Zo7YR6ZdzD22dOsbpDFCA8G3NSZcz0eeSrNoe6D9z9INWI3P
 fB5ir9wsu/evPJ6JOuV5IWckR5Xg2YX+s2+whjG4gt3Uqr++aNqmnquwBVYy3PJXUHk7
 j46A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnNL9+OStcmMWYkKc5WUvKX4ongADqMT5KzUGQ7rgY0rYqo8A6vB1q+33LL28XIzyoDqcgu9Nj7zE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/P4Bwqj2J1DXZUCdegQp/wXo2tKRSdQJv858DcbCE4DaFWl5eJ
 GvF8M/zbgWTFeiKk79QOJQez5D+9imXU1dgMhMi7g5FCsXwH2aRdo/lbzYgRyhZp3PLnPulQXca
 Z6ZHyw/+laWGeS1XsnYYE/OwPFiCInlDHjTPa4sbzrMbi3/budbFxWRW4nkLxHnVilCy0q70=
X-Gm-Gg: AYBFou31IGCu3+I1HBL4q98yOp4tADcFAYlbnJF3xLuRub6mjUkYmqEFxPzH2kGvt58
 nWn9w97IyBDpVxVxofWBrsNzrTf9mxAKTtSw8Al4sKw08CEVuZeo6Jk0aSoeJDXkCwR7HZkaKun
 tCMD+XCLbq00dGL22HLGtqV5TqwzpnTU32m2eEujCRt9kiI5g7FCRHPhFGcO4sLo7t9xdPCIGng
 a3WgId+jHPgjfY+sSNXN5NEEDiaC2VeyQ/Ld0NtY1edBKvAuHhrAYi0ooEJ0yIGHnxxKkSbx9MX
 5PV39XRB/uBqKpZm5Yt/ggIcd6fXtHovnRrRj2+/Q2oJKWiFIwJMFnAtBndEW/w0oyltNuzuUER
 6YeBgPuBm8OXowmqvCBKPJF4aNp/QtsEmcCKh5NZ67CQgGWwRB8vMhEw3oNkhtmWv4JbX/EMUDU
 xHjtTsMJQpCfpCcZkxIEb21OHM6jyC/fh3blaWVJhwOAcTyv7L8HYVFKCnrzHK1w==
X-Received: by 2002:a05:620a:271a:b0:93e:c12c:f12f with SMTP id
 af79cd13be357-945f3631799mr344952885a.74.1793972688293; 
 Fri, 06 Nov 2026 05:44:48 -0800 (PST)
X-Received: by 2002:a05:620a:271a:b0:93e:c12c:f12f with SMTP id
 af79cd13be357-945f3631799mr344947285a.74.1793972687619; 
 Fri, 06 Nov 2026 05:44:47 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c003055a5csm382747e87.13.2026.11.06.05.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 05:44:46 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 15:44:12 +0200
Subject: [PATCH v2 6/8] media: docs: pixfmt-reserved: describe the QC08C
 and QC10C layout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-ubwc-format-docs-v2-6-82949f88f030@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5342;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=oufDthB7YeDdLirPSwGJfiDiJMRXmbblsnYc5GIVcCM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq7dm6s+PXrSOIvYkMo0otYumwJstunDxuMg8An
 mz9B+Mnhd2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCau3ZugAKCRCLPIo+Aiko
 1c2QCACoHzDU8tM05kGPtQOJguY/awpHZnGl4M1B6ngb6r5IY6yedWDjfHCVdiWrKwpjHTReknn
 ZBZMYt7o0pTBEIFJC7FeB3iX5fGSR2auFc9/3WbG7RLc4H+s9651VWxPyniD/pjHIO1Y7MhCvk5
 2Xacpzuu90iX4Y0hQWDvgEJfZK5I8NpFR4ws0YpZ/q2V4EkputE8TyYD92q7/UVbuT7R0Pfbng3
 CSISTsDI8Ir5nVHpRJOywmK7ZAR8KY/lmH4g5pZZOIU9mUTk5LFhJragEjgxl/hfT0hln6wfHyt
 6p2qhXN20Uv3Vz80P9sPw0ZgB7suipVCTNBnGuzHE2bmQlk1
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NCBTYWx0ZWRfX/7X/7wVZHw01
 zWWWQ70wgKpuGKSh1z5jqMCIgifzMLfQ0qSV5tMPMnRiXmNvVZXDEkRqHenlTS59t3nw9+OIbHx
 VxmhaMLGXmtQQWdlSgoFzILBv4o6y2Lc/O0tOmEittNek1rip8uciJx3sZgrvduO2W0GTfLW99+
 fyYgF6P7/goQvhVa0ZEq5CnkX3+aSB9xbJu704e4YFuKgZ0rsu73MtWqu5SWvmeaaPE3aExUSuP
 iD2GSclyy2Ejzvn8w9MDQ3B5uo2lyQyTjQ6l1EFrdN6Qg4Kx98s0khlC42pSblxRYmzRlYMhkXI
 42tp/Iv7T4ZIe6x0OM+sjniA+/PxzabHsaySNI3guGdTNDste/20J6SXiS75lDREc0DMSdEzP5M
 sX7/PDdRe3pyGy2fpt7s1mu5QsDfdNs3MnfAlMcoPDcqmmOe93BumAmYTic+0Z5g97zcxszyrWB
 mLasb73O1r2lRPyh3tw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NCBTYWx0ZWRfXwdhtNlHd0qDU
 OrrI+lfyKNwoneOA3+S4Hsem0Dm6aXdMGHo55YRFwv88xCiGNLIjQOKn/TEPTfDYOm5DlF3PMmq
 lzc10DrDx537H9jLvHt9AtJzLXmu/5U=
X-Proofpoint-GUID: zDU3WlYlQp8wjyahVuE0wfOahsZfsxBG
X-Authority-Analysis: v=2.4 cv=P4ivFSAu c=1 sm=1 tr=0 ts=6aedd9d1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=Eh1Ucz_HWyYK4_jupWgA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: zDU3WlYlQp8wjyahVuE0wfOahsZfsxBG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060054
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
 .../userspace-api/media/v4l/pixfmt-reserved.rst    | 64 +++++++++++++++++++---
 1 file changed, 55 insertions(+), 9 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
index 1cf6c59f4bc4..ec67a1bd7743 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
@@ -245,20 +245,66 @@ please make a proposal on the linux-media mailing list.
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
+        This is the P030 (TP10) format, YUV420 with three 10-bit samples
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
+        ``sizeimage`` may be larger than the sum of the sections.
+        The same layout is described by ``DRM_FORMAT_P030`` with the
+        ``DRM_FORMAT_MOD_QCOM_COMPRESSED`` modifier, with both DRM planes
+        referring to the same buffer and the Y metadata at ``offsets[0]``.
     * .. _V4L2-PIX-FMT-AJPG:
 
       - ``V4L2_PIX_FMT_AJPG``

-- 
2.47.3

