Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142CBC79FAF
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 933A510ECA7;
	Tue,  8 Sep 2026 15:24:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BzepljCO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C8dKoRm0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0C7010ECA4
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 15:24:21 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688F1Mbr273484
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 15:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 joxSGp71NqHpTiDTXwA5ERzRLisW6LBVbzHWeJ3xwZo=; b=BzepljCObvIz7jmS
 +/QtxTXQFLV1pgrc1Do30UR0dv3kXuYP4RHWv8jhp15oCoplLmIOibaMgMSd0iYI
 s7C7ZBvgyuBC9XRgn7GGxrvvNTtjl9CDTNXu98KtCi1H2xLDfn8FJv1vbaV34e54
 vKf6ha1uf3rVUvoUoHGikhlkJ9sAOiTn2LTLXQsiiz9Cc0rW2w0aqsjnvTT5wH4B
 5ZVljvfGGTU9c9w1RqoV00jT8k04U4EWi0aI+4kc8YT3R80hFVlwPSTMz3fBRPB4
 eMYQX+3jRS6eHBr9NOf6PZfPcLALM3l4ojdg+Ggk4In8p3Y6STNdUKCrhenEewSt
 y2oy2Q==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjb0paqvq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 15:24:21 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-738627c7908so1002464137.2
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788881060; x=1789485860;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=joxSGp71NqHpTiDTXwA5ERzRLisW6LBVbzHWeJ3xwZo=;
 b=C8dKoRm05P9veYR0+npqn096ydkzXqJocgNVAS+vKKMicx9KlGFu9ZSnw8jUWlRXJ9
 wq7d8Us5pAeThPZpPlbAb/6OweMt1aDDxh3NCzvKlTJTQEZqnYPxbLSCctkb5MYZ765i
 XFAnpYxTwllCARKop39YbiJiJvZd1ykz5QAnCIGAt5p+Im32NuKnA6wT5vg3vgZylB2i
 zn0z0KPAp8kbtFFm13gQsXxIxMbCZIfRKosC95k3jPZxC+IehTUgCe+ncjhrZIoei7l+
 EnBIqsyTnBzZP2DF2cL/YYELKgdZSS/jWGyj3k/eH5hmU5g3SaU7ahVYTPeeg49E2fMM
 ZmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788881060; x=1789485860;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=joxSGp71NqHpTiDTXwA5ERzRLisW6LBVbzHWeJ3xwZo=;
 b=bhDIwFS/CS1lzv8ImVzdT+iWYVLjvm7xhVXg89NyYxfExyYEuZSwit2SHrNQxDW0b2
 3gTvP0gUPgddlEJfk7CDjA2+GDazMyVzhc4245lyxLikwyAnh4Kw8apyKEe2raq1zpjA
 +G+pkN0DoDi2aymMMKM335uBuHU5XoRdtnkgA6rCxKz/7QYa0XHWZ+3/9s+WBuguyQQN
 Iz6C8ZKUhOTlUQofSmz7KNJwtfIevoOv3tAPX/b5WwXydRf+lUF6Tz0PB+2u8TjCBRrj
 FAqsHmfFjxQ1ng0PsL2tnQwv9Z9G+ThRmf6/l5mj5KP6o+GU4yevxcy57pgtViLY+qSp
 Mg1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0s3PhXPv+R0gfjJ0lU0u5Iqn3W3GT3S5Lemaf5cIRfPK4fty+Y+vIe+aI423gk8QBFohErC6f81c=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n8kN8HLq4kCZeDsmU/WqkQ+UoHAwiY6lLY6Pvrz/cgl9WO24Vh
 APdr6JDAiGfO+cq++hOtliyEEXMePM0iFqKQygKaRIYzFaa2Kr2IBji0EKmw5P+go41/HA+3crN
 0zkL7rvKpkUcRkOm+iDDsMeT1IKK3pbJEzEciMEHeSJEmpntJs7Cg2Sr1CUSxltnc3CQvFZY=
X-Gm-Gg: AYBFou3Rdbxr5ubWt0gbvdOnL6JgSxlj6+Ewdo12vSSKOEBfhLDm4SndVPqXo3xjtIW
 nzs130w4GXzMlecT93T2lCGNzECqPwM4WaNq50kpGylDMGcgts6jMKIdxDMQjfM+EP7WJnGUf23
 XqZQIK/tHnVpm6gOYmjaQUm1xwQC+OTACmMJbvtBaObXeMu5404UoRMcztEpmFe2NwgiHb3Fi3A
 I8Yj6SFN6lF49rV9vk/Spcs/bKGtcfWzoAku1BXAuWqLqPEunsFmasCaRdUSVT6fa2AqEtDfOOQ
 r4j8h/txwcLptStQkbetm7IA+gRC5dlCMRXVcJPJkggibs/lGt3LVNJD+yT2Dio2H77amFh31JF
 q+WNusObifQFRx+9GlmPyLeFzad9ZXlDsrlfPMtvi9W0vJh2JNgug1/0ARuG+q6TMqGWaSJSJHe
 UmjG2kyslSq2ot
X-Received: by 2002:a05:6102:2c83:b0:784:b6e7:cee0 with SMTP id
 ada2fe7eead31-78f7380dab6mr15302137.3.1788881060053; 
 Tue, 08 Sep 2026 08:24:20 -0700 (PDT)
X-Received: by 2002:a05:6102:2c83:b0:784:b6e7:cee0 with SMTP id
 ada2fe7eead31-78f7380dab6mr15263137.3.1788881059489; 
 Tue, 08 Sep 2026 08:24:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b6166fe10asm3103722e87.47.2026.09.08.08.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 08:24:18 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 18:24:11 +0300
Subject: [PATCH v2 3/6] drm/msm: release scanout framebuffers only after a
 vblank
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-fd-kms-fix-smmu-v2-3-9391815742a8@oss.qualcomm.com>
References: <20260908-fd-kms-fix-smmu-v2-0-9391815742a8@oss.qualcomm.com>
In-Reply-To: <20260908-fd-kms-fix-smmu-v2-0-9391815742a8@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13562;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=q+fO5m7eAy+1m48VzFsMMlA7XqYIVW9i8e3Q0vq0fp0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqoCiaI+MAJtUJxHuMn7DBolJi2LGhknUQ4Qp67
 bPAyAZDcJGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaqAomgAKCRCLPIo+Aiko
 1W9BCACzejZ/yZbQXkwvJ+cbZZxDU5PAapQqkK83UF6GT4VZb50/E+LXVM3fDZ1bAxh9rYKIshq
 3g+Zm0YsRMmHVJPZENSLnfKbwxY3U0Uk8fufu60BdERFT7XJUhRnegDbK6+JzxO22QTmL+4sPcY
 ilrMHIG3+KaYhLNkrV6QtUHdsg8aPP24ezWrF5BZ5zZm3pdcUU4TQuQfjpqbvSvX0BXaUiseA0u
 9LOW37SX4Bkjm4dKtp6zZBR4dZN89LzagWDIjn0uSRCzcMWJZRkZGbnrLsWhALB07xOeL1acSnA
 bZ1qwrAQf4MTJeIv4EkFfKaPRiFbwuBeSZdDx+NgTuM7ZQIC
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: evgCGahprcD9d1UyhWTTfsQNdul-EC3S
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2NiBTYWx0ZWRfX0l1rQtF9vZ9Y
 mrz+QKmmBY3dFnb/CeWPkjyqWefLQ5hFTu4kcqmBleNvyLZHwi3znv1qxH7/DdEhvyoF8xZJuEy
 /qj9bZFzIDeFoll1CD8Z/eGCLDL+VhQ=
X-Authority-Analysis: v=2.4 cv=HL3z0Itv c=1 sm=1 tr=0 ts=6aa028a5 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=t2uh1nQYAVaQfnDpEX4A:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: evgCGahprcD9d1UyhWTTfsQNdul-EC3S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2NiBTYWx0ZWRfX+lhlAvIs9Nqj
 dzzzYx9dfpSHIPcS1SNuRzhA6wNuKx414gL4RQtkobIcm4LLfPLgz3EWZGTR8lrGpSE7FTATRm6
 1i6whuCs+A8HjfuWnubsd6GU5P29Vt8ep+9uIRRCozVzO5SZIGqYE0k35JKSBe6+zhP+aYLhiuL
 sKIyFIHHv+QziIpCGzBonOBXwhJiBAKqnrH53Mpk8PRHO3jCeyVN1Hdo22PCOYq1QomjFDi6S7U
 +qilfPCUe/kmorg+H2d/er9cFPQUmky8dRXIzTAnPhn2Ucu6xflBdui9PcaryIX+XF+a08sG2cB
 tZSE4p3Xxo5uNRvCqEJW52Y8FhP9UOOldchbSbm/Qxvq5CxQ7yYlPZ6ukePiGevWIBBzsFlLQsl
 3RGNHn1G86zMihmGr9p0qD/rv0x+/9r7Lt2kOyBvxyzxZnTyHBn45phi7lm4EeSP9laOemxUSAv
 SAZrkMl30mA1LjI2tYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080166
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

Defer the release: hand the retired framebuffer to the crtc and drop the
pin and the vma reference from a drm_flip_work committed from the vblank
irq, as mdp4 and mdp5 already do for their LM cursor buffers.  A vblank
reference is held while work is outstanding.

An inactive crtc is not fetching and has no vblank to defer to, and
drm_crtc_vblank_off() sets vblank->inmodeset so drm_vblank_work_schedule()
does not fail there, so key that off the crtc state and release directly.
Outstanding work is flushed from msm_drm_kms_uninit(), which still runs
before the driver drops kms->vm.

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
 drivers/gpu/drm/msm/msm_drv.h                      |   3 +-
 drivers/gpu/drm/msm/msm_fb.c                       |   6 +-
 drivers/gpu/drm/msm/msm_kms.c                      | 103 +++++++++++++++++++++
 drivers/gpu/drm/msm/msm_kms.h                      |  27 ++++++
 11 files changed, 145 insertions(+), 9 deletions(-)

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
index eb4bbae8557b..18a9728838fd 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -254,7 +254,8 @@ int msm_gem_prime_pin(struct drm_gem_object *obj);
 void msm_gem_prime_unpin(struct drm_gem_object *obj);
 
 int msm_framebuffer_prepare(struct drm_framebuffer *fb, bool needs_dirtyfb);
-void msm_framebuffer_cleanup(struct drm_framebuffer *fb, bool needed_dirtyfb);
+void msm_framebuffer_cleanup(struct drm_framebuffer *fb, struct drm_crtc *crtc,
+			     bool needed_dirtyfb);
 uint32_t msm_framebuffer_iova(struct drm_framebuffer *fb, int plane);
 struct drm_gem_object *msm_framebuffer_bo(struct drm_framebuffer *fb, int plane);
 const struct msm_format *msm_framebuffer_format(struct drm_framebuffer *fb);
diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index dfe040d5260b..2e317bec9fbb 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -127,7 +127,8 @@ int msm_framebuffer_prepare(struct drm_framebuffer *fb, bool needs_dirtyfb)
 	return ret;
 }
 
-void msm_framebuffer_cleanup(struct drm_framebuffer *fb, bool needed_dirtyfb)
+void msm_framebuffer_cleanup(struct drm_framebuffer *fb, struct drm_crtc *crtc,
+			     bool needed_dirtyfb)
 {
 	struct msm_drm_private *priv = fb->dev->dev_private;
 	struct drm_gpuvm *vm = priv->kms->vm;
@@ -144,6 +145,9 @@ void msm_framebuffer_cleanup(struct drm_framebuffer *fb, bool needed_dirtyfb)
 
 	memset(msm_fb->iova, 0, sizeof(msm_fb->iova));
 
+	if (crtc && msm_crtc_queue_fb_unpin(crtc, fb))
+		goto out;
+
 	for (i = 0; i < n; i++) {
 		msm_gem_unpin_iova(fb->obj[i], vm);
 		msm_gem_vma_put(fb->obj[i]);
diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index e5d0ea629448..6a857ad3464c 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -11,6 +11,7 @@
 #include <uapi/linux/sched/types.h>
 
 #include <drm/drm_drv.h>
+#include <drm/drm_framebuffer.h>
 #include <drm/drm_mode_config.h>
 #include <drm/drm_vblank.h>
 #include <drm/clients/drm_client_setup.h>
@@ -165,6 +166,102 @@ void msm_crtc_disable_vblank(struct drm_crtc *crtc)
 	vblank_ctrl_queue_work(priv, crtc, false);
 }
 
+void msm_kms_fb_unpin_worker(struct drm_flip_work *work, void *val)
+{
+	struct drm_framebuffer *fb = val;
+	struct msm_drm_private *priv = fb->dev->dev_private;
+	struct drm_gpuvm *vm = priv->kms->vm;
+	int i, n = fb->format->num_planes;
+
+	for (i = 0; i < n; i++) {
+		msm_gem_unpin_iova(fb->obj[i], vm);
+		msm_gem_vma_put(fb->obj[i]);
+	}
+
+	drm_framebuffer_put(fb);
+}
+
+static void msm_kms_fb_unpin_vblank(struct kthread_work *work)
+{
+	struct msm_kms_fb_unpin *fb_unpin =
+		container_of(to_drm_vblank_work(work), struct msm_kms_fb_unpin,
+			     vblank_work);
+
+	drm_flip_work_commit(&fb_unpin->work, fb_unpin->kms->wq);
+}
+
+int msm_kms_init_fb_unpin(struct drm_device *dev)
+{
+	struct msm_drm_private *priv = dev->dev_private;
+	struct msm_kms *kms = priv->kms;
+	struct drm_crtc *crtc;
+
+	drm_for_each_crtc(crtc, dev) {
+		unsigned int idx = drm_crtc_index(crtc);
+
+		if (idx >= ARRAY_SIZE(kms->fb_unpin))
+			return -EINVAL;
+
+		drm_vblank_work_init(&kms->fb_unpin[idx].vblank_work, crtc,
+				     msm_kms_fb_unpin_vblank);
+	}
+
+	return 0;
+}
+
+void msm_kms_fini_fb_unpin(struct drm_device *dev)
+{
+	struct msm_drm_private *priv = dev->dev_private;
+	struct msm_kms *kms = priv->kms;
+	struct drm_crtc *crtc;
+
+	drm_for_each_crtc(crtc, dev) {
+		unsigned int idx = drm_crtc_index(crtc);
+
+		if (idx >= ARRAY_SIZE(kms->fb_unpin))
+			continue;
+
+		drm_vblank_work_cancel_sync(&kms->fb_unpin[idx].vblank_work);
+		drm_flip_work_commit(&kms->fb_unpin[idx].work, kms->wq);
+	}
+}
+
+void msm_crtc_vblank_off(struct drm_crtc *crtc)
+{
+	struct msm_drm_private *priv = crtc->dev->dev_private;
+	struct msm_kms *kms = priv->kms;
+	unsigned int idx = drm_crtc_index(crtc);
+
+	if (kms && idx < ARRAY_SIZE(kms->fb_unpin)) {
+		drm_vblank_work_cancel_sync(&kms->fb_unpin[idx].vblank_work);
+		drm_flip_work_commit(&kms->fb_unpin[idx].work, kms->wq);
+	}
+
+	drm_crtc_vblank_off(crtc);
+}
+
+bool msm_crtc_queue_fb_unpin(struct drm_crtc *crtc, struct drm_framebuffer *fb)
+{
+	struct msm_drm_private *priv = crtc->dev->dev_private;
+	struct msm_kms *kms = priv->kms;
+	unsigned int idx = drm_crtc_index(crtc);
+
+	if (!kms || idx >= ARRAY_SIZE(kms->fb_unpin))
+		return false;
+
+	if (!crtc->state->active)
+		return false;
+
+	drm_framebuffer_get(fb);
+	drm_flip_work_queue(&kms->fb_unpin[idx].work, fb);
+
+	if (drm_vblank_work_schedule(&kms->fb_unpin[idx].vblank_work,
+				     drm_crtc_vblank_count(crtc) + 1, true) < 0)
+		drm_flip_work_commit(&kms->fb_unpin[idx].work, kms->wq);
+
+	return true;
+}
+
 static int msm_kms_fault_handler(void *arg, unsigned long iova, int flags, void *data)
 {
 	struct msm_kms *kms = arg;
@@ -240,6 +337,8 @@ void msm_drm_kms_uninit(struct device *dev)
 	 * irq after uninstall has disabled it.
 	 */
 
+	msm_kms_fini_fb_unpin(ddev);
+
 	flush_workqueue(kms->wq);
 
 	/* clean up event worker threads */
@@ -323,6 +422,10 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 		goto err_msm_uninit;
 	}
 
+	ret = msm_kms_init_fb_unpin(ddev);
+	if (ret)
+		goto err_msm_uninit;
+
 	pm_runtime_get_sync(dev);
 	ret = msm_irq_install(ddev, kms->irq);
 	pm_runtime_put_sync(dev);
diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
index f25b31e502d2..8d95457cb8de 100644
--- a/drivers/gpu/drm/msm/msm_kms.h
+++ b/drivers/gpu/drm/msm/msm_kms.h
@@ -11,6 +11,9 @@
 #include <linux/clk.h>
 #include <linux/regulator/consumer.h>
 
+#include <drm/drm_flip_work.h>
+#include <drm/drm_vblank_work.h>
+
 #include "msm_drv.h"
 
 #ifdef CONFIG_DRM_MSM_KMS
@@ -135,6 +138,16 @@ struct msm_drm_thread {
 	struct kthread_worker *worker;
 };
 
+struct msm_kms_fb_unpin {
+	struct drm_flip_work work;
+	struct drm_vblank_work vblank_work;
+	struct msm_kms *kms;
+};
+
+void msm_kms_fb_unpin_worker(struct drm_flip_work *work, void *val);
+int msm_kms_init_fb_unpin(struct drm_device *dev);
+void msm_kms_fini_fb_unpin(struct drm_device *dev);
+
 struct msm_kms {
 	const struct msm_kms_funcs *funcs;
 	struct drm_device *dev;
@@ -170,8 +183,13 @@ struct msm_kms {
 
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
@@ -193,6 +211,12 @@ static inline int msm_kms_init(struct msm_kms *kms,
 		}
 	}
 
+	for (i = 0; i < ARRAY_SIZE(kms->fb_unpin); i++) {
+		kms->fb_unpin[i].kms = kms;
+		drm_flip_work_init(&kms->fb_unpin[i].work, "fb unpin",
+				   msm_kms_fb_unpin_worker);
+	}
+
 	return 0;
 }
 
@@ -204,6 +228,9 @@ static inline void msm_kms_destroy(struct msm_kms *kms)
 		msm_atomic_destroy_pending_timer(&kms->pending_timers[i]);
 
 	destroy_workqueue(kms->wq);
+
+	for (i = 0; i < ARRAY_SIZE(kms->fb_unpin); i++)
+		drm_flip_work_cleanup(&kms->fb_unpin[i].work);
 }
 
 #define for_each_crtc_mask(dev, crtc, crtc_mask) \

-- 
2.47.3

