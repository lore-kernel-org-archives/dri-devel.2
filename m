Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576E0C79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A814810E4D2;
	Sat, 12 Sep 2026 12:48:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hfMEWa69";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X3Ip0TVP";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA8FE10E4D2
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:29 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CBdeL93273271
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r8zAn/guR7xH19vvVnJFNiMrsIee98EJBNEAzw4/qBE=; b=hfMEWa697HLp2ZKw
 aA+Nz3thc1sl8jU4pjn2fuM5N9p4zMWU0EVC9bHm7gv0guz0JI4VdMEJPfmpWrSZ
 I0X8rBEiQRBSIwstA7WskrWKk/FssntFjpQNQqiIBZGkkap4BDCRgf86xdeCD2Ey
 kV1pdjjlIxQVYb/xpvKZfzyHBYV23hCqe8lC4ZgS953MAM53AX9fzWFLGNSmTibW
 xuCEa04FGXRWRGVMU0AN48/UGCfT0fV9ieY7ixRwQT3TJXfHeubHxhFP57ZPicqA
 tzARAfUOaC3ONKbaPTIuZ37pJc0FuDnD9ZkT2pFfkA1cBMDEQ7EMSDPs11CqX94H
 oWabyQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dgysp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:28 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-980c3b71002so1349308241.3
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 05:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789217308; x=1789822108;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r8zAn/guR7xH19vvVnJFNiMrsIee98EJBNEAzw4/qBE=;
 b=X3Ip0TVPjmDgQ69jdu8kOv7BDOyWSF1tY4lv5INOuHXBfcTIvHeMpOEz0X48j3XMef
 Igt1Lh8CCtgs+tMSx3M1wu08txACFT/M/BrzGwtT2wLG6atiqSiWkKgCPq2fCM63DguH
 1L2SyaTgERqPt3zU96rvXT71PjjvnYHfmjUVs8VNxqNXxUWSufV30ykBmg9OpJcN5BdC
 TxqbCyUcoWZ2eU5C2MPQtCA7upjwKSuDk2ZI23aCg9DLyzs0RX3EwYWBQupvVHsVnwBn
 bGsTdN92H5odtUbFJJOngL7sL8G7HDsI/y6IaTXVnbcdhOWIlMzY24aLeg8ee5gUfeaA
 QNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789217308; x=1789822108;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r8zAn/guR7xH19vvVnJFNiMrsIee98EJBNEAzw4/qBE=;
 b=ZhGwsEwM+nMgzRbwgXxyo7d11+T9keuSnNvXvPH8v0+zjjzkD2lVGlOS3a/FG1wzN9
 FnAzuvAY1rXH6/NIc9+9Vog0cqe1T1LspDIfCFyZLieC5Jym/q4of1e+aXg2Bgcyhi+f
 XdwcFp4MiC/BG79mPvKes7PJ+gE2mjv/fJzWfDOE7GEt8bE9iWloEf6YnXELvmfrwf6Z
 yYcC/zce4Jmi7H/qbM3AzuNhGaZbfJhRvcZ3MT2Pxe/4eWGMx4dBOl96s2Awee+wSEms
 QkevOAsulL0rejgMy23Pu2a1DbOSsyrZULjub7+n7owLa74dUL7g6D4Dn388PUFelT6H
 G8hg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxScZcLZL8JNyD7QMWWLdTxKZl4Hg1k0jCdKt+/iRVqqXrYLvoRm79GlKtuc2v4kt3eYL4gDO5tHSw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l1IZ0npE4Ijf1cZw/3J/bCPr7NFdgVi8ek7Nq/EURU5JRToZd2
 ofxJCErMuWOT2oCBtwfFmv+dfqbm4ejZX/5+83T+oit2qZk/Ch9pNOnXjN4S9o4XRIP/tIwSr4q
 2ilKltMXeYfs7qph7So6su6QPss6YEsrdROCjW7EH2OtkAAXpV7oLqnWfBTRewNALZnpA2Xw=
X-Gm-Gg: AYBFou1KLIczRrxIQs0zI6+A9lDAX0K9HaodsZ4c3THq1NS5vgBG+1DOB8oCTo7y0+C
 bVGEtQPcLtHc89Cbujc6nIUTCTOF0P73ByMc83zf3ILNpJGAk60WUmEakqs959pqJOGPA6CKN7s
 f4Puyoi2TNFUsiqllxCBYRzNWuZVFKRc6SdC0SNDHsulyD3VgYie7pt0Bsj1iuy31u6BZlo7Bxi
 KgpHh3KIur6pVdjKvbGclmeKAb4EOwnpMB+17wUJFrUYoYi840MvQPxLxEKWkxuQ3EkbVEIZ24x
 P63rXh4ZVFXTM47xt9qk8TWKgyAAZtQoCtaLAqX8tPODWXqWKSKFEHEeh9Npk6q6H9rWSFlU7uP
 BleVVLuk4jfkbT2EY6hj+2hlFsCVS9pKfGeFSVYmvgsFbpNOyx11FwH6QG/EYAn6Ag2G04aQYhG
 NI2X2PKNagJN9E
X-Received: by 2002:a05:6102:8607:20b0:783:79ac:9db2 with SMTP id
 ada2fe7eead31-792a47f5970mr4006962137.3.1789217307694; 
 Sat, 12 Sep 2026 05:48:27 -0700 (PDT)
X-Received: by 2002:a05:6102:8607:20b0:783:79ac:9db2 with SMTP id
 ada2fe7eead31-792a47f5970mr4006948137.3.1789217307256; 
 Sat, 12 Sep 2026 05:48:27 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5af37a4eesm8825701fa.34.2026.09.12.05.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:48:26 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 12 Sep 2026 15:48:21 +0300
Subject: [PATCH v3 1/8] drm/msm: serialise framebuffer pin state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-fd-kms-fix-smmu-v3-1-a7ddc6fe2032@oss.qualcomm.com>
References: <20260912-fd-kms-fix-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com>
In-Reply-To: <20260912-fd-kms-fix-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4844;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=4uipgtNRIs5qYNUtyZUsdJb0hErPAZce83PVI4j94so=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqpUoWhRUgj92XA1t8cgUikty59wtzwlwc/cc+g
 LvGItd1o8yJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaqVKFgAKCRCLPIo+Aiko
 1SVBB/wIDj2hNjtFS94Dq2NKOqOACF7g4dlURrxlnTY7k/i770eR0iBP1RzHD2/nzFAvRvR2TEL
 NzrHxZi9Delu7Dkie+3Rw/EOmBjD4QKi/6ZUOJ5BnKuGwV4to8DwMyTl/xBRwFHbcobHO7cJngj
 qRRah3PqgGm0KiKbMGa1OO64bVfGEMH7fZRY4UI65B7mCHv6GGlHcY+gBu+bKIPv6wuOpur/hov
 x7G3mDN3MdAn/eaj/VCQdaTsF7671HLgQJvjW3i8r6RncMxqBGoQDu+11fJlIxjeE8mTGEpc8HW
 1YMcQQeI4lQmBAYmten0N/y63HDQBuzc5zyz4BIyKyESYWy9
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE4NCBTYWx0ZWRfX+JTt2rz2203W
 3CLg8riV7XKZNuaPS+W3xfJ+5nQZzGWevsYON6GhGku7n1E8oO7TxVhRxCOx89AyyKSsrNNmCB9
 jRikU3V6Sa80zGDi6lgzgvafqNmVcn73qovpgU9pCjy2+92l69hs2IMA7GWaiRdUq4ZG0Uy0NGy
 wqsl6Z4gc4Bv1RQ7muIjb7zdt3F8Ik6HkPI+iZgeewiixZ7CSA/TgMH16y86EfNk6+WDQmcjS4u
 j4lRuNcsnI3OYveg+5QcQIJGiGW+bf78hdIeXcNawDjmSX81LbeoaCn/iXHoaafwr7xOa8AaLW/
 nuHO9xyr3/08Gfjxbqva9BoKzmEQasOR9MDdC8dbPGrqJP/rE8GE6Vl+/tLfgkL8+YjYXDG3rtT
 vxz0biJu/u0i5A4DM7ibho/MQRw59TneAOw225DxQKZic2SRpe6UISOkRVB/qmevfP7AhmzCZYo
 AEBpxow8k9zQWxqR4cw==
X-Proofpoint-ORIG-GUID: y2lB6IyYIaeTw8qXMMZS7wHem6q_QsUA
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE4NCBTYWx0ZWRfX/ShKQtHuFlA3
 kGe03a+QkK57vaQXanBKes1iAWw/5c/Wuul5TNV2FGnUsUOC/5UuMYFH+6qa8e7nyviUnqeEPaS
 XsyvbGP6zWORxUu0dqvKbwg+NvXaiPo=
X-Authority-Analysis: v=2.4 cv=Y6htIReN c=1 sm=1 tr=0 ts=6aa54a1c cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=-SLBVWGn-DbGgWclMpAA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: y2lB6IyYIaeTw8qXMMZS7wHem6q_QsUA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_04,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120184
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
 drivers/gpu/drm/msm/msm_fb.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index 60c108d35d2a..77415302e6d8 100644
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
 
@@ -76,13 +87,15 @@ int msm_framebuffer_prepare(struct drm_framebuffer *fb, bool needs_dirtyfb)
 	struct msm_drm_private *priv = fb->dev->dev_private;
 	struct drm_gpuvm *vm = priv->kms->vm;
 	struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
-	int ret, i, n = fb->format->num_planes;
+	int ret = 0, i, n = fb->format->num_planes;
 
 	if (needs_dirtyfb)
 		refcount_inc(&msm_fb->dirtyfb);
 
-	if (atomic_inc_return(&msm_fb->prepare_count) > 1)
-		return 0;
+	mutex_lock(&msm_fb->lock);
+
+	if (msm_fb->prepare_count++)
+		goto out;
 
 	for (i = 0; i < n; i++) {
 		msm_gem_vma_get(fb->obj[i]);
@@ -90,10 +103,13 @@ int msm_framebuffer_prepare(struct drm_framebuffer *fb, bool needs_dirtyfb)
 		drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)\n",
 			      fb->base.id, i, msm_fb->iova[i], ret);
 		if (ret)
-			return ret;
+			break;
 	}
 
-	return 0;
+out:
+	mutex_unlock(&msm_fb->lock);
+
+	return ret;
 }
 
 void msm_framebuffer_cleanup(struct drm_framebuffer *fb, bool needed_dirtyfb)
@@ -106,8 +122,10 @@ void msm_framebuffer_cleanup(struct drm_framebuffer *fb, bool needed_dirtyfb)
 	if (needed_dirtyfb)
 		refcount_dec(&msm_fb->dirtyfb);
 
-	if (atomic_dec_return(&msm_fb->prepare_count))
-		return;
+	mutex_lock(&msm_fb->lock);
+
+	if (--msm_fb->prepare_count)
+		goto out;
 
 	memset(msm_fb->iova, 0, sizeof(msm_fb->iova));
 
@@ -115,6 +133,9 @@ void msm_framebuffer_cleanup(struct drm_framebuffer *fb, bool needed_dirtyfb)
 		msm_gem_unpin_iova(fb->obj[i], vm);
 		msm_gem_vma_put(fb->obj[i]);
 	}
+
+out:
+	mutex_unlock(&msm_fb->lock);
 }
 
 uint32_t msm_framebuffer_iova(struct drm_framebuffer *fb, int plane)
@@ -199,14 +220,15 @@ msm_framebuffer_init(struct drm_device *dev, const struct drm_format_info *info,
 
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

