Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809D160A2637
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VAMUadzW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YUlcB4Ag
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D923E112D44;
	Fri, 23 Oct 2026 23:25:53 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 905BA112D24
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:41 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLuuUw885823
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GzYthhdeMcdRou8ifqNIfMhlH/HIK3Ow9DgwfN8Um40=; b=VAMUadzW8QYqrGu9
 7KnooXbqalCmP3vcFXzD/4gl0+5Ne261n64gcBT2WC1Rf3gnHzn7egpyYCnHPdFr
 ITPMIQvlNPLWb8K/SDtZh8cvpY+MizbVFBXuQG77I/WTnHGji7qysQIaK28ObyTl
 JdrqLGozTY7gwGOZel6YnoEWk4cewM6QS1djafInqcws9RQyVfw/+ilqm32ZGfz8
 gLGONR7HK94qqJDz4zxq6U4ySoocqKXM4olF+79Lr05M0s97Wes+HuvaMKNW4Sg6
 X/uMvW++GS7f4rYHrfeaaMfMJIRvscUMHOawC8jpbwgyRUJ/6wsvazh8bEHx/56v
 OA0KkQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7bw28yh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:40 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c25513b2aso30385836d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797940; x=1793402740;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GzYthhdeMcdRou8ifqNIfMhlH/HIK3Ow9DgwfN8Um40=;
 b=YUlcB4AgumwfWqMt/9NErI1RB3U2ILP9q4ybSsGdwlQM0Rvh6dQkafD1Bbm4rIySLl
 S86tcVjomuiO8o7bCXShfAFbxm6MYv+o/gP5R6h7yna0PdKAJvoHUC0ygTse1VH4zF3r
 w+xAALVqY95o+Di4ws1UqjcXR+LvIqJrVEd6W30Ji0nGm1y66Pxy33y8rTTHiyRhj4hK
 svRI1L+P0zPv5a12vXjlk49m0Jjpri9iA9er9W+0hPcy+qzE0NBzB3huCqswvLoAtmWq
 UCYMEBxfslE5hBN3H7ERBM2znmIOYY7Zg3609c2bqTqRJHdI8QyVSCHZuzEMjPnTrF5/
 PgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797940; x=1793402740;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GzYthhdeMcdRou8ifqNIfMhlH/HIK3Ow9DgwfN8Um40=;
 b=Ln74DUKRY0JvHzSad2w4TQm0PHPtXjR6ZgIcq1fVASVJsE5ZMJbs6AVXF7yg4nJ0Fu
 E4c13Ys+syqVNPpV8EKqjCXF5Ewe5I7EWaaoiFGJDtavoEqotoJU6Hw/kXxRC7zwZpox
 n2C+45hG2M5chQP0ID8yvhakJQRhj7FMYfX8sP+zAQuZdd1SOcQtrSLjKBjuVIixDIgm
 +TMX3pbsb3NwnR+3/EicgOVSEu+f2PdyFo9LKWjo5vaqpOYk6xQFdwJX2KZe9Ut528iZ
 qJ2mJjoG+MzrtHhIvkexOlb/mPerm9hUAojHsQ9/1Iomb4uEirY/NAAPUQUPpne+OvmV
 wv6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbv0MqdH9Kgzdmfq6TDgOaeIHe+MXGVECwC/DaU52+oebGzeqNg4rZpFXCK3rrH5Q3O0gUkbg/QeA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIXocIOZVglZEKzh1iN0VBjjezJvvrw07oXA5VggAYQi+EDI+Jt
 rWIKX4Zj6brvBa0QRvTZSfnbK21FaDXnTL1SMoe9xHirzAZEAUg1OOwZtw7ELcstyfFJgLSmRd8
 6TNLC184rugwHMj2ceU7XoKbt4WNDt7n0PRbDEV+DzVAIp+ZNrvqVvC20VQAKQWMYTLdbPNc=
X-Gm-Gg: AYBFou33m34/+GpqAWNGgaVrAU91Ug5RLhzeyr1aStKX3q6yaSQcTc9vsML10SpXUFS
 ERvwE2zs6d0QQhY7HAbT14S9aZJvEXFwWuRaSveBMFZuVEgL9DjM2xnrBYaG4YmKTe78YZnHNvo
 C2J3DcmlqHYIC+bWEoB83yLp1bdxr/Spbo2iDfTmuhd41gjKUlWZregYtDbLS+OiGJoDkq0UcOi
 AH7K0friJQtPDNA/xBRMhbHYseeT/DSO3hDtKVWKQgRlIDNU37ky3Y0i9Jg/nWHamgSmJlYYmXC
 UhzC2v47U/uJh/oiIOxC7FDF+3ln4EhzlMk69alYp+igK6z7IZi9uin6xIxYO8gVPggv5QYcyY1
 nr+JctpmlvY0vzM6Kk69Z4L/qNW/f6ZjWDaxU6jKWZv8LWbVbrT4vvYw4liG7vDg9EH5WP2X1ZC
 MoCxw2nA9zaMnT
X-Received: by 2002:a05:620a:45a7:b0:93c:6e1d:96af with SMTP id
 af79cd13be357-940ef96e35fmr83467685a.49.1792797939761; 
 Fri, 23 Oct 2026 16:25:39 -0700 (PDT)
X-Received: by 2002:a05:620a:45a7:b0:93c:6e1d:96af with SMTP id
 af79cd13be357-940ef96e35fmr83463285a.49.1792797939152; 
 Fri, 23 Oct 2026 16:25:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a9ea71sm60217e87.81.2026.10.23.16.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:25:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 02:25:22 +0300
Subject: [PATCH v5 01/10] drm/msm: serialise framebuffer pin state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-fd-kms-fix-smmu-v5-1-a5b0b284aead@oss.qualcomm.com>
References: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
In-Reply-To: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3800;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=pamYy0cN7nsNt1AdJwY6+IG+Gt3DwvWS5HicK2xuXmI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+zlx5d+BC4E/Dn58V2ZAbiHRmaYLqNSXz+YP
 6gqgHdn6W+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvs5QAKCRCLPIo+Aiko
 1daPB/9opOYYqJncg0k4w6fjr/EYYKDQfIYLXhPJ4RaR7SSBnrC1r8P6mu+1aUaGbnzB5cTuWRG
 nI2f/05zRx2rqqKiyABRqxOh+HxRDgi55dZqQe+GIwWRuls/ZY4avwoz+UzwBgOb2jPA80pqjHq
 WMevVMtnVznsFQsO68WMAug+GjEMcX6QWIa8YVZuY0NmjeiUZmY+cj1RWWQCIIW8cI7nHMawLYb
 uSKjw0peTf3L362ITK7PyV1rcJ0U7iARC28m6KMOez587EJkqjTgvWhstDwd49L8qmWKO4Wr77Q
 DGsF5g/kzyQqyVcCUTuZ6W7sAkZTvNmJJPeB2jRCEIqvvs++
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: WfSQdxEE33boOVczFIAZj2Jq4xpOrFUB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfXzUgPRA+2dJQl
 ZuYn1ldj74kN4quKOxsYKCnXP1AZukHvSPKlq1nGp8LmyNbYmkRzH9jWFpVwzrQIxjj16x1clo8
 WW/Sk2Hxwg7VWjj0P/mkE7FVwxY7yrE=
X-Authority-Analysis: v=2.4 cv=QdTzLcbv c=1 sm=1 tr=0 ts=6adbecf4 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=xgb_odkXjkZCwJ4aViYA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: WfSQdxEE33boOVczFIAZj2Jq4xpOrFUB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfXxFebJaclcBuf
 zneEaJJZu1zjLl7WhZKU0RsjqjH2QflLYfgcGZzuQLWlDl5QHw0Rt06B5AcotEgwK2bQM4xsxrU
 4C8dG5YM6jYPclA3C2xBsxU2PZyOL+e6ScT7Qi9AfYkfelNYCOre28zmMOrM3bnGLe4BXoFeEF3
 wlrB9x/9DnmB1SzncdrMOnqVq/PJymVgG8Z3pdFmJzO7fGfJIes4Amu136MG86YMNvPvEK3n4RW
 hsEb4B83pNfano1c3ZXh0VER05xTub+W8OpPnmNz0qzqKyFHvNNbU6eDmSuCkMFWlD6br2dEYKp
 2LpjDfffwsj2KsX956R3cczHP9vz2fs6sN3hydRm1CwhPlr6dfCRjNKpZiM3lT18qsDnJeaj9Wv
 fKcTktHDXqMCP7s/JfUimEAO9+YqUxNl5gfz7AVaCf3XBYGsGOVcRaPNbjoNLCRdaiWbJgnWh/4
 yJOt7fDNg8TXB2ktzdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230092
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

