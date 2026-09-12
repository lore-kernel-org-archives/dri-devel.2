Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA0EC79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF8B410E70B;
	Sat, 12 Sep 2026 12:48:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dhv5NRsY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DkYnNSG5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D19F10E70E
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:35 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CBdUDj3757886
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GiVDCLl0reXlySiT/FZha5lLtYbEsu35SLw+Ov/UGf0=; b=Dhv5NRsY4wS20N/+
 G520p0q0D+7z1Zi6UTyXQ3wLi/auon8Gby8viSy/8PcImT0VYXvXo8Hozr03Tus5
 ViuuLimyew8iNpCL7AXXFg1aAMRSP34GEfMQwSYsmrsovwYfDPxZAMZTS/E0+pd0
 QDl6rGRCl6DuOI6OAL0SRQlSzgWUe4vgUXHVZDYmAsZm71KGeXdCUv0lVgMYc4n7
 mMcPtCnR4wzizmPcOlAN2ZLguSFTGcaVBen5pjAeF7bjJY2aJGCcNaPZe8hJeNuL
 /1zjnmJ6fA+1RIA0aH1kGh/CeUGEd2Bo7pJ3yBJSJ97iZ7ouQ6DP2UXnKCEgezpU
 JeYI3A==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9c8ybt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:34 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-78a686d205cso1380212137.0
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 05:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789217313; x=1789822113;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GiVDCLl0reXlySiT/FZha5lLtYbEsu35SLw+Ov/UGf0=;
 b=DkYnNSG5mrDUuxV52eNznDGbyeiPLxOC115UABVl+0nKIcbn20LpDdJqJvEtt4oKZU
 gBG4LI+OX/mFvxwTuqejQNKCQTTCxfmEvHfnvmc87jT3L7Qj2XQhAhd5D7Uw8zwyWbja
 yJ8RsdQInznRqb2GdNFhJwxtVhgd4mq5erDHVwTQbwZj/WJpsCjv8XPx1uPlZmbLCDMr
 criVjFtILKppqfjktlTwo6SHyhVwH3U3JIphsvV+vrPtxGnTkcSt5yRCzzhdeaAkLtgB
 QM/vYFGmazr93SNPUBv0zfmNjKC3EI2du6d4t6vKnOLuqWp9S5ZWy5wlL8EofHRAbJg7
 bong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789217313; x=1789822113;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GiVDCLl0reXlySiT/FZha5lLtYbEsu35SLw+Ov/UGf0=;
 b=cy/aygPeVO14ueUmEI/JW+sEwImgv0NY35wAgXvIT3r82zucXzd9QmXGTS0GHRrYuw
 Fh58yVnNuzSpuXlIpYRNYsPKqrc/66q++ASkKrnjfDfbRxJ78WX26pKjzq9eKU9jIFck
 DoqZT8uA9CWaRKAtTHB48PZI5pSS1NO4lmU7NnA+3EG/H0BL0OiBgwpGH2b+mmG3/EP5
 M9h9XKLQx7fXBJhvi4Sz4DQuT9dc2M3NhFP0z8Al0XY9yWe0Xwmec3ub17xey5gS67UQ
 LEpbGIz9kMxqCYhw6KOk6N67oflDApJnBoCCH051SY0Yt+nbJO2rKNHVt8DbOOmAh7lq
 +1Qw==
X-Forwarded-Encrypted: i=1;
 AKwUvBys2dy6qGYmxfA21FskqHDCZpOPDviTmmT75n0bysAf3NuLOOYF5O33pIS1raMrqFCu93l0CcKBo48=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lovk6TlpcKas9yFB//CVACqeg4af/NpwwOPNxCW9BO3k47D1ud
 SAQ/nKaWX0G7Mryoa124D36fx3YVctbV/Uh4eJP0x3Xsi51DVEQdh4uuJs7ur7FL+zxmgIWExUZ
 UlF/pFD2qN7cbAQjEGTmey4WTfKYBocdSwVkyaIfIKcSbx1z+Cd3ezDMgqmPzisg+VEPRuro=
X-Gm-Gg: AYBFou1HqxuuFTrvfJqIB0U+nnXO5F/R9MyYqRY5LVC0LevI4vI6L0U4FQJtpdp+THS
 7VdSx/fkMSvi3q42hc6GWJ6x1Oi4EALLn5Wde1bSRRO5f/lZ5TYkS1uUoRzzZJLdDJWViR9y58B
 VqnQODZgcz5duvnTI7r7tUWJHHtXvj7yz7zm0gV6E0o6swFEKYiV08HfYKSPj0iWiAYBI1VnMpW
 SqBGqDSuOggNxyxl9LhM4o6bqxfCG+Cbu+H2kkeQNyHe1KAFeLSbHUmcADPfecZie4CoHqza7l0
 eGJ6+P0XDFebH4P7IQwyS+jntbBo2n6g7Ex25h6x09ievG2r6fUfcKNTBt30AjTymBAOj2a8T11
 LQWXrLMDtXDkvqhWGD+OJ0Yll7zWc7ewWosGO51gs4jXaTTUe0/sncc0YNXdFEP1j8xiWNLaSMm
 3DMFGIEcsis7/l
X-Received: by 2002:a67:e701:0:b0:796:9525:ac4c with SMTP id
 ada2fe7eead31-7969525ad02mr849212137.8.1789217313392; 
 Sat, 12 Sep 2026 05:48:33 -0700 (PDT)
X-Received: by 2002:a67:e701:0:b0:796:9525:ac4c with SMTP id
 ada2fe7eead31-7969525ad02mr849191137.8.1789217312910; 
 Sat, 12 Sep 2026 05:48:32 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5af37a4eesm8825701fa.34.2026.09.12.05.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:48:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 12 Sep 2026 15:48:24 +0300
Subject: [PATCH v3 4/8] drm/msm: release scanout framebuffers only after a
 vblank
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-fd-kms-fix-smmu-v3-4-a7ddc6fe2032@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13833;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=/hawr8iz5q5bAzG8GdPBkIKEhcAghMeRAWIQTsyIGrA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqpUoXIlUgpAVIvf7MpAsis0bo9n+vSuNGfYg6v
 F81lrH6GqaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaqVKFwAKCRCLPIo+Aiko
 1WaMB/9BzjvVSg78NYDCp/XBO6qraRrq/blkiuff90NRMpHt0PIHP61WJosK8XtceX2aKxVitE8
 PQqAOj8yjQOiTOlCICSU3zkjG7oTH3Q1jrG5QYHT6oru7hvkiZEa2WJbyIky2WEPY0Hc7705dH5
 PssPGsJj7s57nNAI0ubb3mVzFWHJvVaot3L8rdEZJJappwP6HaY8VSOdMe5ZldCOeKw2b/oUOHM
 8qSmq2CrJrBrTw5GhYDDPqzgCanleAY4f1Jba/89GZRwjaQQo2J/b2lIrUXYCm52ckekN0KtjZc
 I3fn5kQeLNtE64UA+KkbvK1R8yB8oeVqn8jmKrqfOrRKUlx+
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE4NCBTYWx0ZWRfXyzTF39pUeL2P
 6KfPNcp9mGfQ38XEMLtfpPHAhVvHjniOOEiC4RYgVCLyTUwwp6x7qQryZWVrGHVhYWUKzapOBHI
 1CwGflv2e9x52tM9UQQJy87/f/5fJ14=
X-Proofpoint-GUID: eiJg0d1UwgiQhRUSFhe3tNfi481Pha6h
X-Authority-Analysis: v=2.4 cv=BdZNQbt2 c=1 sm=1 tr=0 ts=6aa54a22 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=jA6VukbCxrIAGvfWCOIA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: eiJg0d1UwgiQhRUSFhe3tNfi481Pha6h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE4NCBTYWx0ZWRfXyuxhNPJ5xxXm
 FNmV0XkTKyjepN+kbRHe5AwuASsPSbqiSDe1ocPYHfDe8w9fuj3uK0RQ0CM41df1PiScISmN/3j
 QoiJaHar+DqtKcAXuitkcam+ZODVfDWLXfnHlh4lRDCC6P9UYbgOAtMayVJ/fbyEWKhNw/3Yi33
 axeGSNK0IEYQiI/5/i+yjwfkmzcdXePA3uqtSY6o3nJhNmrEdo2L6TDoDb0Q337t5/2Uz6qzNl3
 KsWkpq+FBjalI3Y1wk+Xj2nTl07migZcXDKCEmlu/r5pOnIRuNz2SrjseP6k24U6Ekl9x8PR4+J
 JayDYLV4DFOSQ+SXV+xy8Ti5nvMzqI5Szy1iflaWSPZxnhpHY8Uy1n3i3YLUhwc1XyQedLAWSHi
 BXiAi2OIPiZYmxhrl3xVs0WZH9HAF3asezRPdyEMrHdpBJ+AHSCDI5fAkn5vwB5LkuLtBaC6Xhd
 JG3z0DD24q5M0fdAfXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_04,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
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

msm_framebuffer_cleanup() releases a framebuffer as soon as
drm_atomic_helper_cleanup_planes() runs.  msm_atomic_commit_tail() waits
only for ->wait_flush() before that, which for video mode waits for
CTL_FLUSH to read back zero, ie. for the new configuration to be latched;
the frame in flight with the old one is still being fetched.  Since
commit 111fdd2198e6 ("drm/msm: drm_gpuvm conversion") the unpin also
detaches the vma, so the display is left reading unmapped memory:

  arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402,
      iova=0x007eb100, fsynr=0x3f0023, cbfrsynra=0xc20, cb=27

Hand the retired framebuffer to the crtc instead and drop the pin and the
vma reference from a drm_vblank_work, as i915 does for its cursor
framebuffers.  The work holds a reference on the framebuffer, and
drm_vblank_work_schedule() holds a vblank reference until it runs.

The pin count is dropped by the deferred work rather than by
->cleanup_fb(), so a framebuffer scanned out by several crtcs stays pinned
until the last of them has passed a vblank, not until the last one has
retired it.  Deferring here also covers the async plane update path, which
has no commit tail at all: drm_atomic_helper_async_commit() programs the
hardware and drm_atomic_helper_unprepare_planes() releases the old
framebuffer straight away.

An inactive crtc is not fetching and has no vblank to defer to, and
drm_crtc_vblank_off() sets vblank->inmodeset so drm_vblank_work_schedule()
does not fail there, so key that off the crtc state and release directly.
A crtc which is being switched off stops fetching as well, and its
interface has already been disabled by the time the helpers get to it, so
no further vblank arrives to run the pending works: keep them on a list
per crtc and release them there by hand rather than waiting.

Fixes: 111fdd2198e6 ("drm/msm: drm_gpuvm conversion")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |   2 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |   3 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c          |   2 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c         |   2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          |   2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |   2 +-
 drivers/gpu/drm/msm/msm_drv.h                      |   4 +-
 drivers/gpu/drm/msm/msm_fb.c                       |  19 +++-
 drivers/gpu/drm/msm/msm_kms.c                      | 115 +++++++++++++++++++++
 drivers/gpu/drm/msm/msm_kms.h                      |  16 +++
 11 files changed, 157 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 42d0a529b4d5..bf593020e8e4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1213,7 +1213,7 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
 	}
 
 	/* Disable/save vblank irq handling */
-	drm_crtc_vblank_off(crtc);
+	msm_crtc_vblank_off(crtc);
 
 	drm_for_each_encoder_mask(encoder, crtc->dev,
 				  old_crtc_state->encoder_mask) {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
index 22433bfbea1e..5db33e49c345 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
@@ -615,7 +615,7 @@ static void dpu_encoder_phys_wb_cleanup_wb_job(struct dpu_encoder_phys *phys_enc
 	if (!job->fb)
 		return;
 
-	msm_framebuffer_cleanup(job->fb, false);
+	msm_framebuffer_cleanup(job->fb, NULL, false);
 	wb_enc->wb_job = NULL;
 	wb_enc->wb_conn = NULL;
 }
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 7b92082d35a6..0e986b533bf0 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -684,7 +684,8 @@ static void dpu_plane_cleanup_fb(struct drm_plane *plane,
 
 	DPU_DEBUG_PLANE(pdpu, "FB[%u]\n", old_state->fb->base.id);
 
-	msm_framebuffer_cleanup(old_state->fb, old_pstate->needs_dirtyfb);
+	msm_framebuffer_cleanup(old_state->fb, old_state->crtc,
+				old_pstate->needs_dirtyfb);
 }
 
 static int dpu_plane_check_inline_rotation(struct dpu_plane *pdpu,
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
index 57dfce58450b..195ee6b4a0c6 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
@@ -267,7 +267,7 @@ static void mdp4_crtc_atomic_disable(struct drm_crtc *crtc,
 		return;
 
 	/* Disable/save vblank irq handling before power is disabled */
-	drm_crtc_vblank_off(crtc);
+	msm_crtc_vblank_off(crtc);
 
 	mdp_irq_unregister(&mdp4_kms->base, &mdp4_crtc->err);
 	mdp4_disable(mdp4_kms);
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c
index 9459f70ce0ba..5f669a02d798 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c
@@ -97,7 +97,7 @@ static void mdp4_plane_cleanup_fb(struct drm_plane *plane,
 		return;
 
 	DBG("%s: cleanup: FB[%u]", mdp4_plane->name, fb->base.id);
-	msm_framebuffer_cleanup(fb, false);
+	msm_framebuffer_cleanup(fb, old_state->crtc, false);
 }
 
 
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
index 4c4a897fc1ee..547f6fdb83d5 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
@@ -499,7 +499,7 @@ static void mdp5_crtc_atomic_disable(struct drm_crtc *crtc,
 		return;
 
 	/* Disable/save vblank irq handling before power is disabled */
-	drm_crtc_vblank_off(crtc);
+	msm_crtc_vblank_off(crtc);
 
 	if (mdp5_cstate->cmd_mode)
 		mdp_irq_unregister(&mdp5_kms->base, &mdp5_crtc->pp_done);
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
index 841f444a8d68..dacb387d9bb6 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
@@ -155,7 +155,7 @@ static void mdp5_plane_cleanup_fb(struct drm_plane *plane,
 		return;
 
 	DBG("%s: cleanup: FB[%u]", plane->name, fb->base.id);
-	msm_framebuffer_cleanup(fb, needed_dirtyfb);
+	msm_framebuffer_cleanup(fb, old_state->crtc, needed_dirtyfb);
 }
 
 static int mdp5_plane_atomic_check_with_state(struct drm_crtc_state *crtc_state,
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index eb4bbae8557b..dc279a99e257 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -254,7 +254,9 @@ int msm_gem_prime_pin(struct drm_gem_object *obj);
 void msm_gem_prime_unpin(struct drm_gem_object *obj);
 
 int msm_framebuffer_prepare(struct drm_framebuffer *fb, bool needs_dirtyfb);
-void msm_framebuffer_cleanup(struct drm_framebuffer *fb, bool needed_dirtyfb);
+void msm_framebuffer_cleanup(struct drm_framebuffer *fb, struct drm_crtc *crtc,
+			     bool needed_dirtyfb);
+void msm_framebuffer_unpin(struct drm_framebuffer *fb);
 uint32_t msm_framebuffer_iova(struct drm_framebuffer *fb, int plane);
 struct drm_gem_object *msm_framebuffer_bo(struct drm_framebuffer *fb, int plane);
 const struct msm_format *msm_framebuffer_format(struct drm_framebuffer *fb);
diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index 552ca5cf0745..5ae8ce3bc370 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -127,16 +127,13 @@ int msm_framebuffer_prepare(struct drm_framebuffer *fb, bool needs_dirtyfb)
 	return ret;
 }
 
-void msm_framebuffer_cleanup(struct drm_framebuffer *fb, bool needed_dirtyfb)
+void msm_framebuffer_unpin(struct drm_framebuffer *fb)
 {
 	struct msm_drm_private *priv = fb->dev->dev_private;
 	struct drm_gpuvm *vm = priv->kms->vm;
 	struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
 	int i, n = fb->format->num_planes;
 
-	if (needed_dirtyfb)
-		refcount_dec(&msm_fb->dirtyfb);
-
 	mutex_lock(&msm_fb->lock);
 
 	if (--msm_fb->prepare_count)
@@ -153,6 +150,20 @@ void msm_framebuffer_cleanup(struct drm_framebuffer *fb, bool needed_dirtyfb)
 	mutex_unlock(&msm_fb->lock);
 }
 
+void msm_framebuffer_cleanup(struct drm_framebuffer *fb, struct drm_crtc *crtc,
+			     bool needed_dirtyfb)
+{
+	struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
+
+	if (needed_dirtyfb)
+		refcount_dec(&msm_fb->dirtyfb);
+
+	if (crtc && msm_crtc_queue_fb_unpin(crtc, fb))
+		return;
+
+	msm_framebuffer_unpin(fb);
+}
+
 uint32_t msm_framebuffer_iova(struct drm_framebuffer *fb, int plane)
 {
 	struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index f3e39c3907a9..4582ba040f6f 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -11,8 +11,10 @@
 #include <uapi/linux/sched/types.h>
 
 #include <drm/drm_drv.h>
+#include <drm/drm_framebuffer.h>
 #include <drm/drm_mode_config.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_vblank_work.h>
 #include <drm/clients/drm_client_setup.h>
 
 #include "disp/msm_disp_snapshot.h"
@@ -165,6 +167,119 @@ void msm_crtc_disable_vblank(struct drm_crtc *crtc)
 	vblank_ctrl_queue_work(priv, crtc, false);
 }
 
+struct msm_fb_unpin_work {
+	struct drm_vblank_work base;
+	struct list_head node;
+	struct msm_kms_fb_unpin *pending;
+	struct drm_framebuffer *fb;
+};
+
+static void msm_kms_fb_unpin_release(struct msm_fb_unpin_work *unpin)
+{
+	msm_framebuffer_unpin(unpin->fb);
+	drm_framebuffer_put(unpin->fb);
+	kfree(unpin);
+}
+
+static void msm_kms_fb_unpin_work(struct kthread_work *work)
+{
+	struct msm_fb_unpin_work *unpin =
+		container_of(to_drm_vblank_work(work), struct msm_fb_unpin_work,
+			     base);
+	struct msm_kms_fb_unpin *pending = unpin->pending;
+
+	spin_lock(&pending->lock);
+	if (list_empty(&unpin->node)) {
+		spin_unlock(&pending->lock);
+		return;
+	}
+	list_del_init(&unpin->node);
+	spin_unlock(&pending->lock);
+
+	msm_kms_fb_unpin_release(unpin);
+}
+
+void msm_crtc_vblank_off(struct drm_crtc *crtc)
+{
+	struct msm_drm_private *priv = crtc->dev->dev_private;
+	struct msm_kms *kms = priv->kms;
+	unsigned int idx = drm_crtc_index(crtc);
+	struct msm_kms_fb_unpin *pending;
+	struct msm_fb_unpin_work *unpin;
+
+	if (!kms || idx >= ARRAY_SIZE(kms->fb_unpin))
+		goto out;
+
+	pending = &kms->fb_unpin[idx];
+
+	/*
+	 * The crtc stops fetching here, and with it the vblanks the pending
+	 * works are waiting for, so release the framebuffers directly.
+	 */
+	for (;;) {
+		spin_lock(&pending->lock);
+		unpin = list_first_entry_or_null(&pending->fbs, typeof(*unpin),
+						 node);
+		if (unpin)
+			list_del_init(&unpin->node);
+		spin_unlock(&pending->lock);
+
+		if (!unpin)
+			break;
+
+		drm_vblank_work_cancel_sync(&unpin->base);
+		msm_kms_fb_unpin_release(unpin);
+	}
+
+out:
+	drm_crtc_vblank_off(crtc);
+}
+
+bool msm_crtc_queue_fb_unpin(struct drm_crtc *crtc, struct drm_framebuffer *fb)
+{
+	struct msm_drm_private *priv = crtc->dev->dev_private;
+	struct msm_kms *kms = priv->kms;
+	unsigned int idx = drm_crtc_index(crtc);
+	struct msm_kms_fb_unpin *pending;
+	struct msm_fb_unpin_work *unpin;
+
+	if (!kms || idx >= ARRAY_SIZE(kms->fb_unpin))
+		return false;
+
+	if (!crtc->state->active)
+		return false;
+
+	pending = &kms->fb_unpin[idx];
+
+	unpin = kzalloc_obj(*unpin);
+	if (!unpin)
+		return false;
+
+	unpin->fb = fb;
+	unpin->pending = pending;
+	drm_framebuffer_get(fb);
+
+	drm_vblank_work_init(&unpin->base, crtc, msm_kms_fb_unpin_work);
+
+	spin_lock(&pending->lock);
+	list_add_tail(&unpin->node, &pending->fbs);
+	spin_unlock(&pending->lock);
+
+	if (drm_vblank_work_schedule(&unpin->base,
+				     drm_crtc_vblank_count(crtc) + 1, true) != 1) {
+		spin_lock(&pending->lock);
+		list_del_init(&unpin->node);
+		spin_unlock(&pending->lock);
+
+		drm_framebuffer_put(fb);
+		kfree(unpin);
+
+		return false;
+	}
+
+	return true;
+}
+
 static int msm_kms_fault_handler(void *arg, unsigned long iova, int flags, void *data)
 {
 	struct msm_kms *kms = arg;
diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
index f25b31e502d2..6f305b4409ea 100644
--- a/drivers/gpu/drm/msm/msm_kms.h
+++ b/drivers/gpu/drm/msm/msm_kms.h
@@ -135,6 +135,12 @@ struct msm_drm_thread {
 	struct kthread_worker *worker;
 };
 
+struct msm_kms_fb_unpin {
+	/* protects the list of framebuffers waiting for a vblank: */
+	spinlock_t lock;
+	struct list_head fbs;
+};
+
 struct msm_kms {
 	const struct msm_kms_funcs *funcs;
 	struct drm_device *dev;
@@ -170,8 +176,13 @@ struct msm_kms {
 
 	struct workqueue_struct *wq;
 	struct msm_drm_thread event_thread[MAX_CRTCS];
+
+	struct msm_kms_fb_unpin fb_unpin[MAX_CRTCS];
 };
 
+bool msm_crtc_queue_fb_unpin(struct drm_crtc *crtc, struct drm_framebuffer *fb);
+void msm_crtc_vblank_off(struct drm_crtc *crtc);
+
 static inline int msm_kms_init(struct msm_kms *kms,
 		const struct msm_kms_funcs *funcs)
 {
@@ -180,6 +191,11 @@ static inline int msm_kms_init(struct msm_kms *kms,
 	for (i = 0; i < ARRAY_SIZE(kms->commit_lock); i++)
 		mutex_init(&kms->commit_lock[i]);
 
+	for (i = 0; i < ARRAY_SIZE(kms->fb_unpin); i++) {
+		spin_lock_init(&kms->fb_unpin[i].lock);
+		INIT_LIST_HEAD(&kms->fb_unpin[i].fbs);
+	}
+
 	kms->funcs = funcs;
 
 	kms->wq = alloc_ordered_workqueue("msm", 0);

-- 
2.47.3

