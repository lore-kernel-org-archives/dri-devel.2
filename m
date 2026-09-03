Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACC5C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80A7B10F5CB;
	Thu,  3 Sep 2026 13:23:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DSeFF5xj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jMRkDLkD";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B42310F5B5
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:23:49 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683DAjj3707880
 for <dri-devel@lists.freedesktop.org>; Thu, 3 Sep 2026 13:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2ODQalE8aYnls1DBAwuyEuvsSahcbelFuNFDbTbCw2s=; b=DSeFF5xjVITpd6KR
 qGla/M/M3mqIvocaCUK5LwRnF2u6+K+9Xoz4DpJrp8oR8yER86u0mkkh5C3cTywO
 vHrnJUotcfJPyWuJNDINLVzzWf/IJr/OaNpTUw1lV12r5QIJuP2NvesEtVzXrHG8
 VkwGtVlJRfPX8E36/qdKOHNKWwTmWD271fuzUNz/ObRQd06MTIBCihv5hGgOrWy7
 1ddHknDTuj+EoJUIcPrzKIkVDO8vpEs79gS1AERTotcR5iiKGUP050vfGoEaeozy
 sToUYmTGpdWVrK979+VlEwmD4PV+/oE9xyKfPSa8OABVZgMOctB0QakEUYaxw+HY
 YSIvhg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf4ekheg2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 13:23:48 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-73850dfc198so416998137.2
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 06:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788441828; x=1789046628;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2ODQalE8aYnls1DBAwuyEuvsSahcbelFuNFDbTbCw2s=;
 b=jMRkDLkDL1a+7Q0W3a+fLfoovBH22Dsj0Ecceck2TQmA6gclcp9sDFu536W2RPODvV
 WHwKQiIQi98jNZ0EAWIM5/VSGmpR+E/t9hrb6Cd8HmPSFB9nrv0+FGXZMIZj97fzHLpq
 G9OFZ8kY3fPHj9f+eEOP7YdCAEFSUzW4aYVf3yChkABuZ79aQxeBboly9wgzDP1UmtbT
 ymFxKjnpMyxZJHih7YoJHzE0EC89FUgxoKxdPt46YeBDNFRqyGTMYrbuuDYnDbgaSJ3P
 3ASbIP2937LZrez3UNMgpqe+YMTNX+hicDGqkkHngfCv3Zn6laWDzjgfALNrnIOjf6Sz
 GAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788441828; x=1789046628;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2ODQalE8aYnls1DBAwuyEuvsSahcbelFuNFDbTbCw2s=;
 b=RjYvJH/G6puKdKOecvpKpqelxsQyE9RjoFXJTubBVgqefv9hHMAFLELHZgPujIfWAs
 9hy/H/zy34qSl64FdMeqslQvBiKYoqi122b8U8MgrTMc4ZF2wUh0cLWUmCJI0k/hNwZn
 Z5AN5p++LHngTl0XmH0DxsSAKmd4WdqDcGVCx6L8FU0uPPEW8hZMTv9fSf9et4khCAO6
 xIN9NV1PnB2UVFbl4DJrBQXIVU5MepVAxQq+ixLmu/a269zTLQdQpV8pu7yuOZiUy509
 YrpHQi6E0ZRYHevF3h7YleVuWXcgSxfXKqIEyQBERxQzbRA/8boVZoXfgUOcmdh41lK3
 XHPg==
X-Forwarded-Encrypted: i=1;
 AKwUvByiQkc9kfPgq6GxHa7nvnavSgGFUpzJOL8IzzzvbXo0IQ6P15pMqtDavIFpkyPGZPd8MFIX7FVOfLc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k9uaAeUUnM3vUk1WdGlH0jEQfPg29HGw80WZTknfQ9/BQpmjMc
 IgA3GGdsmXvvaVtszKIREIi1fGS9z44gdF9tlbCFP2ZVjHaxrYQT3ZmiHsNhL0nn7YFJBeRq4Cs
 pptDngIEvnjbD6gVnHe1a2LgxqbikKFRbyJ3SgSTFAiz+C4vtsr7fl5jBgTkQH+F2/REECQkP8z
 SmXXs=
X-Gm-Gg: AYBFou3fLIYufKSGzRRdeCx8lPlY1JRl3phxxTUPio+KsWxXGLR6TcgHldiTXwNgWu3
 tSfNNzyGrUmiB/UsBUc84h6yWoGuXCFBPl7Gi2520DZkcI8C1rkfC5w5vsrVYp2Ft+QlvSejjS3
 8UhXW2h7dvH9Wksk9k2Vo3yUJwLeCmcm7Eak0taHvuAp5eGDV9lHoQzzgFNu44SC5n+ywlJWPOs
 Nf0XielJriRTtZHLHTufedgSc7z81AWeN66d4v6z0UfW/Q+UC0G8c4bZ4Dv3tKGdMi4gCDIaqnF
 uVoDH2L0r9on7ArHcXJeFS4pas72AVDOpnNfg9HEnyd9bbugNR6u/onDXFHkZCkVcra1NfUpu1h
 ervN2PDD6PhWNPGaXjYRkVCc7DXvsGg2GaK7iob9X6QESTS/8AvLTDRzEEJ0227DmNssowm9YsU
 hU98/RLLbrJJ5n
X-Received: by 2002:a05:6102:50ac:b0:785:c643:a415 with SMTP id
 ada2fe7eead31-78a1f3c8040mr3997211137.12.1788441827484; 
 Thu, 03 Sep 2026 06:23:47 -0700 (PDT)
X-Received: by 2002:a05:6102:50ac:b0:785:c643:a415 with SMTP id
 ada2fe7eead31-78a1f3c8040mr3997188137.12.1788441826959; 
 Thu, 03 Sep 2026 06:23:46 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b606da57e9sm1296480e87.83.2026.09.03.06.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:23:45 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 03 Sep 2026 16:23:41 +0300
Subject: [PATCH 2/2] drm/msm: release scanout framebuffers only after a vblank
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-fd-kms-fix-smmu-v1-2-608d02491666@oss.qualcomm.com>
References: <20260903-fd-kms-fix-smmu-v1-0-608d02491666@oss.qualcomm.com>
In-Reply-To: <20260903-fd-kms-fix-smmu-v1-0-608d02491666@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13031;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=nedhLPNAX4zaxCzJ0ErxJCYfQ9+VkBKgj+h/rOmABcs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqmXTeI5I0tevhDqkaESaRxGEHzA2ppgupgBujd
 pPN7LWZ5pqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCapl03gAKCRCLPIo+Aiko
 1UGFB/9wse2uxkXco0AbEL0MaeYKRjevzAxkQw05LGfcQyhXbd/PJqlLikti/ZuqI3b3pNQIhgG
 A1WRs9akt6pniotgje/gav1J4DgbYCfPWblxh2WzrnhchNd8LOftYfpRGgDI9TDb95GlMomtV2n
 bO7sPuA7sk2VlNVJZYbiw4KxJ1h/+tG8/lA7MqTw9HmIcjcqjzkYkFOdSyZ2Owrv4pJ4VpLB/JL
 CXkwjk32Mkghy6BPsgqSKIKxmeirshaIkETiv59m69FHG75nMt1Xm2bvROQoiK4oUPi6kScqNjE
 kio+7fsfZA2+pWYID4OC+1lFiUY5Q9S7/td6YGvsZotjUFBT
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 0ssfEcZiW2Xpky8xVwPEsBOMSorSFMt2
X-Proofpoint-GUID: 0ssfEcZiW2Xpky8xVwPEsBOMSorSFMt2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDExNiBTYWx0ZWRfX1XMYyq1O8WHc
 /7HkROTzQHnTBaDzSKazktP9ru6IsK0cXSGjx6DR5zKCqdpwqj8miDet9HaqslFuspzRq1xcdOL
 xsJhOyZ4l1PNROy0WRDiMo2x3DkrP/8ePqcY+tV9PhdynIlHn6vKtTRIwWnbxgdnsmDEbHNBpId
 oUqtXxn1MwSBfETXmRUlI5hCxoFIxAcpk2YD25uWNJ3mwiPEgIIonSaUsCWLXeAimuaBbgiPEoi
 aeEZ5scd/O3jZrLW3Q+1aXsB3xl6wjTaeIclLzNBkLIupgNxibb5Blhv3IfN59f5rrQrI3NJyxg
 Xf42zPp9AQjWv9t1O8zKuT0qKvYmHUoRGqR3bp5xmn9DQ+hIOpwbou7FcOrEMoxYcE1wJ8CQ0f4
 Jua/elV99fAKdonn6O3Bc1M3D3HP0lXixqFjERDWEpS2jev8tS14EiX4nKKGqtVZaApBlzLoBHZ
 Hj7WyMsZLUctlIJPOiA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDExNiBTYWx0ZWRfX4NlbUxX5BRJm
 H1RTqZ+1owHLfPxgHMejm331hWbtX0Aj9acHW9kK231Ue867UUf2Ai5MGozvMg/pnaWcQVWl6Pd
 8CXwxCgD8L2FBrXV+VcgmLnYD56VEc0=
X-Authority-Analysis: v=2.4 cv=PKc/P/qC c=1 sm=1 tr=0 ts=6a9974e4 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=wGqaUCltirg6dY4VYU0A:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030116
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
reference is held while work is outstanding; a crtc with no vblank is not
fetching, so it releases immediately.

Fixes: 111fdd2198e6 ("drm/msm: drm_gpuvm conversion")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |  2 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |  3 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c          |  2 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c         |  2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          |  2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |  2 +-
 drivers/gpu/drm/msm/msm_drv.h                      |  3 +-
 drivers/gpu/drm/msm/msm_fb.c                       |  6 +-
 drivers/gpu/drm/msm/msm_kms.c                      | 88 ++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_kms.h                      | 29 +++++++
 11 files changed, 132 insertions(+), 9 deletions(-)

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
index 934337202afd..0865ecce77de 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -112,7 +112,8 @@ int msm_framebuffer_prepare(struct drm_framebuffer *fb, bool needs_dirtyfb)
 	return ret;
 }
 
-void msm_framebuffer_cleanup(struct drm_framebuffer *fb, bool needed_dirtyfb)
+void msm_framebuffer_cleanup(struct drm_framebuffer *fb, struct drm_crtc *crtc,
+			     bool needed_dirtyfb)
 {
 	struct msm_drm_private *priv = fb->dev->dev_private;
 	struct drm_gpuvm *vm = priv->kms->vm;
@@ -127,6 +128,9 @@ void msm_framebuffer_cleanup(struct drm_framebuffer *fb, bool needed_dirtyfb)
 
 	memset(msm_fb->iova, 0, sizeof(msm_fb->iova));
 
+	if (crtc && msm_crtc_queue_fb_unpin(crtc, fb))
+		return;
+
 	for (i = 0; i < n; i++) {
 		msm_gem_unpin_iova(fb->obj[i], vm);
 		msm_gem_vma_put(fb->obj[i]);
diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index e5d0ea629448..bf56fbe99a34 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -11,6 +11,7 @@
 #include <uapi/linux/sched/types.h>
 
 #include <drm/drm_drv.h>
+#include <drm/drm_framebuffer.h>
 #include <drm/drm_mode_config.h>
 #include <drm/drm_vblank.h>
 #include <drm/clients/drm_client_setup.h>
@@ -165,6 +166,89 @@ void msm_crtc_disable_vblank(struct drm_crtc *crtc)
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
+/*
+ * drm_crtc_vblank_off() drops pending vblank works without running them, so
+ * flush the retired framebuffers first.  The encoder is disabled before the
+ * crtc, so the hardware has already stopped fetching by this point.
+ */
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
+/* Returns false if the caller should release @fb itself */
+bool msm_crtc_queue_fb_unpin(struct drm_crtc *crtc, struct drm_framebuffer *fb)
+{
+	struct msm_drm_private *priv = crtc->dev->dev_private;
+	struct msm_kms *kms = priv->kms;
+	unsigned int idx = drm_crtc_index(crtc);
+
+	if (!kms || idx >= ARRAY_SIZE(kms->fb_unpin))
+		return false;
+
+	drm_framebuffer_get(fb);
+	drm_flip_work_queue(&kms->fb_unpin[idx].work, fb);
+
+	/* no vblank to wait for: the crtc is off, so it is not fetching */
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
@@ -323,6 +407,10 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
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
index f25b31e502d2..4b73132b5f6e 100644
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
 
+/* Retired scanout framebuffers, released after the crtc's next vblank */
+struct msm_kms_fb_unpin {
+	struct drm_flip_work work;
+	struct drm_vblank_work vblank_work;
+	struct msm_kms *kms;
+};
+
+void msm_kms_fb_unpin_worker(struct drm_flip_work *work, void *val);
+int msm_kms_init_fb_unpin(struct drm_device *dev);
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
 
@@ -203,6 +227,11 @@ static inline void msm_kms_destroy(struct msm_kms *kms)
 	for (i = 0; i < ARRAY_SIZE(kms->pending_timers); i++)
 		msm_atomic_destroy_pending_timer(&kms->pending_timers[i]);
 
+	for (i = 0; i < ARRAY_SIZE(kms->fb_unpin); i++) {
+		drm_vblank_work_cancel_sync(&kms->fb_unpin[i].vblank_work);
+		drm_flip_work_cleanup(&kms->fb_unpin[i].work);
+	}
+
 	destroy_workqueue(kms->wq);
 }
 

-- 
2.47.3

