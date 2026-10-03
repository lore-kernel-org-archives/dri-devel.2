Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A61CA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:30:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88B0910FA6A;
	Sat,  3 Oct 2026 00:30:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GN+OwRrX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J1UuKMey";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AFF710FA65
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:30:28 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692Ne0FV3883846
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GzYthhdeMcdRou8ifqNIfMhlH/HIK3Ow9DgwfN8Um40=; b=GN+OwRrXxk498Wnz
 gfcLrBnA92FPmIxgDDtVkweU4gCFp/+AxQFK78kI70x6MFqjlZkz/EjwciS/q4im
 otLorehqhxSE81pyWdv6QToWKkCuEzYMDqq5NuFpGx4yaPp5Nt7eIYceZvH0Z1tN
 5cHGdVYxHJzXRZmDY9HwAQ6w70IyNGuGjl9naNfjCnZySWi6RaZryIBgpOdyHuG3
 U0ydJN4JGqlp2MGKGxBBBJHE4HNAM946eRHb2c0xcDnqri7Qb9X065SBG3nXziec
 iDHjxmIpQuPBZwNunUtQaiwsfiXnLXeLJ893QzeDjDPLy1ZNAAMa2dKZ9IlBmMxA
 SNuc8A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h26bp40vy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:30:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cbf2fd504so20253685a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790987427; x=1791592227;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GzYthhdeMcdRou8ifqNIfMhlH/HIK3Ow9DgwfN8Um40=;
 b=J1UuKMeyO0l5GNM22bLRgFs9tkypuvVfHV4cQ2g152C5A0J7Uqu8ajfiIhUxX/ZSGx
 72avVHwxJQoFp6FvwX81gCr/Mr9pDW28lMRacCOD2WwD+QrZwZewhIQ1fSDpFcvo7kTl
 qfDxBtR90m4APdVI2KFdFJA1ivQJ/IRAT9U67N7NZ5tZsmzPXy2rviAtxrJHyjpGyS52
 ZkFUcjtGHj4OowWONeAXuY74Zk1RlwWO54biWmZpmMsH3yc9N1y+xHk9K1uE76TsVP3Z
 netXA96+8E4y5qwleC0W1MvJ4CUDn29B90oAhzQABlSe2DMlC0aLSkWVZpPJv3hcNO8/
 Ej+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790987427; x=1791592227;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GzYthhdeMcdRou8ifqNIfMhlH/HIK3Ow9DgwfN8Um40=;
 b=p7ixexxT3AwM2EataTiUiRyknK1sJEfpDS0OEBpf+gz6+sNVxtSvQzr5kGY7ggt8Rj
 qdf/peoUrZbH4k8gu5g+oo2HFG3K1+jPK5a0LhGIhZAH3VzY96maXnTJ3h+1Xc6W89wK
 n2p6Q+7McnI3HwIYtBBLAQxvgaUMIzdYyvm72Tq0VBsKIB+EYTBzANj61ge0TRXmDhiu
 YDOwwwpGfXB0nO050oCFfK953CI0LUC8u2QpKdJIRUo+dLZwg/CNGGwBHZBM6XIlk22R
 E9f3CNa7REx5FKPABXnFH25ydM2wDCmswzX2F+pD3yt2xHkFUNnz4ht2vOIfYpOsFcfO
 GC2A==
X-Forwarded-Encrypted: i=1;
 AKwUvByU7uEcmFoPUnr9bbXB8DW2fOjTptEMFAWnYKIP+LG0YPdKG9YTpjTjRBR4oXEAScl1Gym9R3hki0I=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k7Dywmk2cVpnQsfSE+sG+Pp43Ey7CR6c2Eb+yoYOFVANwhXRuC
 TaoOkATUHyDupeBZtcHArbfxKzAAU874Wefq6542OOuZI8pKfm0EnYQA4Cv1rtZuQyvl1ygO0aT
 Irxg2Pm/xvnFpTEac32qf0BxwryYIerg7HzFgG+pQTSNk/pimtjSfmYFq40FjAyFlWHqTWmI=
X-Gm-Gg: AYBFou3ZRbzivWCIUOaHcAKRRP2bUytojcVD+Rr2lTOdulnsGeWV6H8dPCKC4eoMXee
 7dk38b76KvINtdztYBW6IlFW+fKlSnJo7U2sKYOqaQQ/PDb3TiY9phz7akk+T76HzSzuQAPRWF0
 hw6goFjoknWpBsnSr7tFpz/YtOM2S/kVSUG8SfX10S1i0t8gzyJQl+TBdB1UeehMXUrB1TNLw0i
 frg90qLaLuFst9Duw6Kw4qnnil4PfC1TSvbw2omR0Zl+0P4s+nXky89inTzSKEFiJYYmB2XyVP3
 XJGrCBB6wreVbm8A5O5KGjba2cQ1K9lXp29hGAnl2wa+yWKDLghKKp0Wul+tkBH4VmqDirHOr72
 DAC/ruB3PNq5jWVrOI4RENHaNonNt75RlMnM6JNugwQTES5rRksRZAJTIIGYoJ8F0zDe6Pvz+zv
 6ncwQLXtlNijvU
X-Received: by 2002:a05:620a:17a6:b0:93b:d7a3:45d5 with SMTP id
 af79cd13be357-93e510cc967mr218482585a.62.1790987426506; 
 Fri, 02 Oct 2026 17:30:26 -0700 (PDT)
X-Received: by 2002:a05:620a:17a6:b0:93b:d7a3:45d5 with SMTP id
 af79cd13be357-93e510cc967mr218475985a.62.1790987425946; 
 Fri, 02 Oct 2026 17:30:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c7957d0sm1133979e87.31.2026.10.02.17.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:30:24 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 03 Oct 2026 03:30:16 +0300
Subject: [PATCH v4 01/10] drm/msm: serialise framebuffer pin state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-fd-kms-fix-smmu-v4-1-2a44d4d8ac77@oss.qualcomm.com>
References: <20261003-fd-kms-fix-smmu-v4-0-2a44d4d8ac77@oss.qualcomm.com>
In-Reply-To: <20261003-fd-kms-fix-smmu-v4-0-2a44d4d8ac77@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3800;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=pamYy0cN7nsNt1AdJwY6+IG+Gt3DwvWS5HicK2xuXmI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwEydh38e1ya8IeVWBJAR7nUWee28PPvIEtLbt
 QRrLyI/U/yJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasBMnQAKCRCLPIo+Aiko
 1V8/CACMXl/985QA0z9gjWaI2sG6kw28wSkEYyFAmM0lJyNOAgW3ykJJiD4ef1f0IjJJPnuZgrh
 EZh5YPwjJRvPbIwPlqsBS1VgboDv2y28VoXhPRu/HaNUGpVSH2uYFz45nUa+gcoRSne4XnLf75O
 6h5Uvrkol4OXns5rWF68Mfq1vQ4B/pRJaXmAkFTbz7+f5/Lus18eQ9bx9wUqPEFjyAC9PEhxbI3
 y8RAqgru8W+JId9bBh7flpDwTf/8ml+2+t6HL4fbYolIzZ+aAH410z74X7ZuAA9tJ1zpWCFtTc8
 Eis05fxkGAJAFQWnZrarKdEmkhWJjm07dV+DwKuToTAYUloX
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=OMqyTiaB c=1 sm=1 tr=0 ts=6ac04ca3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=xgb_odkXjkZCwJ4aViYA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: wz2mAncH9kbq4-F1JrCATQkpwqlcBIc3
X-Proofpoint-ORIG-GUID: wz2mAncH9kbq4-F1JrCATQkpwqlcBIc3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX1tnhFdEBasq9
 xNOsKUdh3qrcUly3XyNnSu9sYdnpSrVlF++17MB8TOal8XRFPioLAwwJqJLNG0dPWtmcDUqm8Bw
 nZ5OPOGPY3zmIdQjVm9U0Ee9bwgqm+4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX9tgeOo9ILRUU
 YfXg9WHwyEYMyhBu1pHhDppdDbTEGaoSkb1MU+J0WBXPNGA868RvUuzMwL+48kQZFR0XwjOoWZy
 vNxVp+b/MaO8xzUhKhk/kSIrpA3MyuUs6zznqOdNzk38iB+U5Gre75806qMc4rYl/2MWkGFSXjF
 7+lEeRmwdtPHaN31GE44x6FGIiocvx7w6iQnFIY6Rs/EKexJQKEmsGzaMQDVbbqiveWCr/TOsIQ
 ZmIvRwYrczvtFEYvS90FhbE5peesXHa0Mpqs6F/uoxa0NwQdCoreco66RFzLHmFwHdnFhqj0U4x
 kxgmJWGY5M/yfxWnQUROeSd6mCzCIueMeJT4PEp5zHVgEJOq4XE83v++7sxLT2ee1RELsFV343+
 97t4geqOsmn9WjQbYu8eNbm1UyPBbgNc3eUrTuMuGbQjBX/+326eHk038RXZhGtddsfeZZuW6b9
 IvpeP5rP2X4sNNftO0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030001
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

prepare_count, iova[] and the pins they describe are updated locklessly,
but drm_atomic_helper_commit() prepares a new state in parallel with the
completion of the previous one -- stall_checks() only stalls on the second
previous commit.  Commit N+1's ->prepare_fb() thus runs while commit N is
in ->cleanup_fb(), and for a double-buffered flip that is the same
framebuffer:

  cleanup: prepare_count 1 -> 0
  prepare: prepare_count 0 -> 1, pins, stores iova[]
  cleanup: memset(iova, 0)

leaving the plane programmed with a NULL base address:

  arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402,
      iova=0x00000100, fsynr=0x3e0023, cbfrsynra=0x1c00, cb=11

The opposite order is broken too since commit 8ac37c88f991 ("drm/msm:
Refcount framebuffer pins"): a prepare which finds the count non-zero
returns at once, assuming iova[] is populated.

Both callbacks may sleep, so a mutex will do.  drm_framebuffer_init()
adds the framebuffer to the object idr, from where userspace can reach it
before msm_framebuffer_init() returns, so take the private state out of
its way and initialise it first.

Fixes: 8ac37c88f991 ("drm/msm: Refcount framebuffer pins")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_fb.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index 60c108d35d2a..a38e5b3a1d1e 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -22,9 +22,12 @@ struct msm_framebuffer {
 	/* Count of # of attached planes which need dirtyfb: */
 	refcount_t dirtyfb;
 
+	/* Protects the pin state below: */
+	struct mutex lock;
+
 	/* Framebuffer per-plane address, if pinned, else zero: */
 	uint64_t iova[DRM_FORMAT_MAX_PLANES];
-	atomic_t prepare_count;
+	unsigned int prepare_count;
 };
 #define to_msm_framebuffer(x) container_of(x, struct msm_framebuffer, base)
 
@@ -45,9 +48,17 @@ static int msm_framebuffer_dirtyfb(struct drm_framebuffer *fb,
 					 clips, num_clips);
 }
 
+static void msm_framebuffer_destroy(struct drm_framebuffer *fb)
+{
+	struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
+
+	mutex_destroy(&msm_fb->lock);
+	drm_gem_fb_destroy(fb);
+}
+
 static const struct drm_framebuffer_funcs msm_framebuffer_funcs = {
 	.create_handle = drm_gem_fb_create_handle,
-	.destroy = drm_gem_fb_destroy,
+	.destroy = msm_framebuffer_destroy,
 	.dirty = msm_framebuffer_dirtyfb,
 };
 
@@ -81,7 +92,9 @@ int msm_framebuffer_prepare(struct drm_framebuffer *fb, bool needs_dirtyfb)
 	if (needs_dirtyfb)
 		refcount_inc(&msm_fb->dirtyfb);
 
-	if (atomic_inc_return(&msm_fb->prepare_count) > 1)
+	guard(mutex)(&msm_fb->lock);
+
+	if (msm_fb->prepare_count++)
 		return 0;
 
 	for (i = 0; i < n; i++) {
@@ -106,7 +119,9 @@ void msm_framebuffer_cleanup(struct drm_framebuffer *fb, bool needed_dirtyfb)
 	if (needed_dirtyfb)
 		refcount_dec(&msm_fb->dirtyfb);
 
-	if (atomic_dec_return(&msm_fb->prepare_count))
+	guard(mutex)(&msm_fb->lock);
+
+	if (--msm_fb->prepare_count)
 		return;
 
 	memset(msm_fb->iova, 0, sizeof(msm_fb->iova));
@@ -199,14 +214,15 @@ msm_framebuffer_init(struct drm_device *dev, const struct drm_format_info *info,
 
 	drm_helper_mode_fill_fb_struct(dev, fb, info, mode_cmd);
 
+	refcount_set(&msm_fb->dirtyfb, 1);
+	mutex_init(&msm_fb->lock);
+
 	ret = drm_framebuffer_init(dev, fb, &msm_framebuffer_funcs);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "framebuffer init failed: %d\n", ret);
 		goto fail;
 	}
 
-	refcount_set(&msm_fb->dirtyfb, 1);
-
 	drm_dbg_state(dev, "create: FB ID: %d (%p)\n", fb->base.id, fb);
 
 	return fb;

-- 
2.47.3

