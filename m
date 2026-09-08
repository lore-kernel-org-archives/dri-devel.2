Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB48C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E30D10ECA1;
	Tue,  8 Sep 2026 15:24:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lbRKsWQL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f1Wkd86j";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1EBF10ECAF
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 15:24:25 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688F1KBA3320440
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 15:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U8Le9HTbvX+Njx4HmZDZ+JWS3P6BGRgoiPUFcnspqrw=; b=lbRKsWQLJP+EUBo3
 ipXSqVpvXN3TNSa+WSKcrq7wc6O1K2ET7ONS/9Ucsy5NFt2IjXisrif/irXtXyZF
 35/juPKlrrCvdXQFsgxVRBbyn/PjfEuJSlZ6AFd1nsvw4Wdayrw4nlZdxq6wdMR5
 lU1G6kGyNdQUUafQeIaIyCgCBnWj12rfRysIuX7R9M8N2TUpSiiHp0ln5sN6JyeZ
 u6NxuqCKUc5HuCH9wCrMwAqJ9E35tPY7MO2sBAtsRg+153r1x9Lz91jpTFBjT0ox
 sg5U/jh9y0IXMxGIp1YSdDGlybhN45FIHUklCjBZuhFM3//8GmRBcuQHv+H2txWo
 kpOTdw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj1rwm8jy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 15:24:24 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-738627c7908so1002482137.2
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 08:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788881064; x=1789485864;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U8Le9HTbvX+Njx4HmZDZ+JWS3P6BGRgoiPUFcnspqrw=;
 b=f1Wkd86jwjhJ5+S2cbB+RYqrYWTF/DU2QPTX13OtAn253yG0+vNrJLSD67mNynPCUf
 8C3Ta/8Cm3fKMT4VDuaLToeSrLqzx7wS0V+9jUsLugxN82M0dpSrdhyGj3uDLVctzNj3
 2tdO/uB45fSHxHC12obdAeBX/NbkY8t+FQSJa7j1dQ7arRmkTTLAFyMNzXGKqxbAaES+
 ePdJbbEXOxsJWTQiVVl1l7glZKg94eO0QaBCm0uaoTmlu1OZ7bIsOMI1SRxIsileN4JX
 1AJ4nIoNYDuNfK4SuC2kbZPzSCIFuvLCWlPe2xoCKLs4ekvI0hTTtB9VIi5YL2o2jKid
 cQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788881064; x=1789485864;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U8Le9HTbvX+Njx4HmZDZ+JWS3P6BGRgoiPUFcnspqrw=;
 b=sa3gLaIEMJCzuJYjmiv852ZgZm7d1YqhGU9FfdFmYXPbT2nSuBWIZFCfxae3UeqRGU
 W6KwwOYcGk3NfylYoQifwqRdhIu4sRRxQB+RNZukexOVPuaYG6MjOC9o0/ru132L2Ysr
 muaq9han3Na+1gAjCH1MPZxYe/P3iDqMWRgTs2IGpG8jKxPSgGYP7BfskZiOJbsqqfN/
 uKVh5k/pJVPT++Mx14IvE6jRaZLPdNA291YYre16ORuuM3LdwRk9/6tMSELo4i/cudQJ
 /kHjY9gP8NDgZjQH4J9Al3yfPmS1ZwewWQ86mtF6sZ1Uz8MgQTTO1kVK6+sMoWBt5Voa
 bDyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhSnj6OmPkhmnZ7gs+/DllhtnfBmfVgx27VBUTaOPI01M6noUPOunaqdxgxSC21SDuFfswzm1UkWw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mPti8Nn4Cuvfv5RknpnqJmmbYO5YyUD1zr9KpcUhgZWqiCcvoc
 Rf6Yk4rBmUXo7K2/OFPjuw1wc6GEXb5bkIee4EXx1SK4/F2sSMbg6E9JAB7lsLGit9wjmYss/aw
 wL0EPdPjwbIWWmHDPM8Nuver6HmzlLOznMGCKnptHD+OW3L1umbMsRmxt7nWsah3/HVh+b0E=
X-Gm-Gg: AYBFou2K3rDuRh8JqQAmcNSJLmyxZzuWOQee7OcRT/9nI+YHz20bsYzlPuEXZVQwQ1m
 m3L392a4GYhkY1hlQXdrWrNB3+9vhxgAxD+ZCxe8Lm94Nr/ioqX1LxvFmUC/yI+uk6L9Wk9Ba6d
 w7XVfWIWX+es+IP/GkTGUkwtsa41l586+foVJATQrsWpJ+vKDjDKZNbChIfIadHoNSjEWq1mApY
 /nYQ7v8J6DRt2cGgEMZxsTf00ak6XQj1mTFM29NrClk4QB5kawjfSHKEt2YTObsbd4Aw6AFBBkb
 27U3G4KM9DrjcZ7rUMjx0x2SuA2XUu7AslikunMPKcr6yjesXr2qhio6XWkkqj+EKF0FfH73HMB
 xT9dqqXE81/6Z+RJU7FEusq3/LORkqhRM66pTFf02RwSfxiVNKJZZY2/FabSX64aPgO+uPslqek
 at0vy0qnhHscxh
X-Received: by 2002:a05:6102:c10:b0:785:bfc7:26f5 with SMTP id
 ada2fe7eead31-78a4a90fcd5mr9832289137.12.1788881063540; 
 Tue, 08 Sep 2026 08:24:23 -0700 (PDT)
X-Received: by 2002:a05:6102:c10:b0:785:bfc7:26f5 with SMTP id
 ada2fe7eead31-78a4a90fcd5mr9832259137.12.1788881063022; 
 Tue, 08 Sep 2026 08:24:23 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b6166fe10asm3103722e87.47.2026.09.08.08.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 08:24:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 18:24:13 +0300
Subject: [PATCH v2 5/6] drm/msm/dpu: only reassign resources when the
 encoder is reprogrammed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-fd-kms-fix-smmu-v2-5-9391815742a8@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4595;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=mqhM4B8gnWC0chv2JmS2nzeA441LZsa3HAirQn66G6Q=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqoCibQ4v+3xz6gXgMM67Lj25TN381/8vr2dV3L
 TPNijYSX6GJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaqAomwAKCRCLPIo+Aiko
 1ZhjB/9YWAtK+tNC0VwfytRlQokdPcSIkOyZ6UViPCWNaIec8JdeF4Z1JCL6+sRD5ZpGB+MnvB9
 0SzQHxLMVfZTryBEAho+16UeAi9knWrxO6mJ73XshB/5D5Y8kzMXe+ChjW5Ni5OXePTrWUC1xa5
 GoCisPecJg2z2PCmaZvx3TtdWzc0DcfuU5TiIfT5baCHJmdMeSXvFNSUkfZ9cW/Lzjg/nIDNKxH
 hYaDwQiHkV0oatMvUcqJuJz4Vy5kRddHzUTx4iw4tPzLJEpjNVuAM4PIlMU5FVcsvjr0yHdhwLO
 EzaGPaG32UCQoff79bwTuMGVtiA1JBE0N1+jR/nsDa0CbbjV
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Ga8nWwXL c=1 sm=1 tr=0 ts=6aa028a8 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=lVXjEyyklXRvgn5FDE4A:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2NiBTYWx0ZWRfX7uJiUgJF1Qdm
 uLDUho0w+A4LBQ84rU5LgB+uG4K5BociFIDIVF88gj0FYd1NDio7rtHyhq2YtVVp5hM1LvfjVa1
 c2tU/Cdb5YBRjyWH9bnJykEMyiZX95Kll21cY7950myoWovPM6iAcu357AQFiSgtFUzd29UqVxe
 4uS27e/dlyTBvT4p4xwI0U31RFCF+w0CrOuKWUcyK/H10/dhEby9jMlNzKNREalVfMMYkw+HT9b
 sSaKkx+02jN7e5s7w5gMuthIAK1vvmJvBguvO83YUvaaDRvZe6hnB9W25FvIvN+N8wocGOndLsP
 e3qOEHlZpltUr7DhG9lZQs/DxCjmxkfT97PcyXqWU4ydZT0DTftQ1RHzc8jhzg0HEFa8WRca+p4
 apFDGTg/eVs7RUxnpN2QHZvURRKrMcz0tcJVfzWj9AzkgSFgwzwZOfcUfYsOH4i6XeQ0dzIGzHe
 zlpsIt635lTTRQf8djw==
X-Proofpoint-ORIG-GUID: 2zLjuGvzZhO5jLSojJvo5J2eMv_3o1TN
X-Proofpoint-GUID: 2zLjuGvzZhO5jLSojJvo5J2eMv_3o1TN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2NiBTYWx0ZWRfX3//XSg3Wz1D8
 ZvdlOBaVn5etgWG8XKZXmWnMcGXkrz/iBsClTLwuNkd1Pkba3z8cpofKuYAVPoA2B4peMQGaUpu
 tRoylcIXy7mhSe172C50E8ppfBG7wP8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080166
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

Running kms_plane@pixel-format-source-clamping causes SMMU faults
(fsr=0x402, iova=0x0001fb00): it sets a CTM, after which the display stops
updating, so the test times out waiting for a CRC and the pipe is still
fetching the framebuffers released when the runner kills it.

dpu_crtc_atomic_check() reassigns resources whenever color_mgmt_changed is
set, but crtc_set_mode() only calls ->atomic_mode_set() for mode_changed or
connectors_changed.  A colour management update therefore re-reserves and can
get a different CTL: cstate->mixers[].lm_ctl points at the new one while
phys->hw_ctl still points at the old, so the flush mask is accumulated on one
and triggered on the other.  CTL_FLUSH is written with zero, so the pipe is
not reprogrammed again until the next modeset.

Reassign only when the encoder is reprogrammed too.  Enabling colour
management still needs a modeset, as that is when DSPPs join the topology, so
ask for one in dpu_crtc_check_mode_changed() and only there.  Drop the
msm_atomic_check() hack, which forced a modeset both ways, ignored GAMMA_LUT
and overrode allow_modeset behind userspace's back.

Fixes: 39a750ff5fc9 ("drm/msm/dpu: Add DSPP GC driver to provide GAMMA_LUT DRM property")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 28 ++++++++++++++++++++++++++--
 drivers/gpu/drm/msm/msm_atomic.c         | 17 +----------------
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 5dc0c9aeaa5d..a3b1d2d7669a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1496,6 +1496,26 @@ static int dpu_crtc_assign_resources(struct drm_crtc *crtc,
  *
  * Check if the changes in the object properties demand full mode set.
  */
+static bool dpu_crtc_needs_dspp(const struct drm_crtc_state *crtc_state)
+{
+	return crtc_state->ctm || crtc_state->gamma_lut;
+}
+
+static bool dpu_crtc_has_dspp(const struct drm_crtc_state *crtc_state)
+{
+	const struct dpu_crtc_state *cstate = to_dpu_crtc_state(crtc_state);
+	unsigned int i;
+
+	if (!cstate->num_mixers)
+		return false;
+
+	for (i = 0; i < cstate->num_mixers; i++)
+		if (!cstate->mixers[i].hw_dspp)
+			return false;
+
+	return true;
+}
+
 int dpu_crtc_check_mode_changed(struct drm_crtc_state *old_crtc_state,
 				struct drm_crtc_state *new_crtc_state)
 {
@@ -1506,6 +1526,11 @@ int dpu_crtc_check_mode_changed(struct drm_crtc_state *old_crtc_state,
 
 	DRM_DEBUG_ATOMIC("%d\n", crtc->base.id);
 
+	/* DSPPs are only reserved during a modeset */
+	if (dpu_crtc_needs_dspp(new_crtc_state) &&
+	    !dpu_crtc_has_dspp(old_crtc_state))
+		new_crtc_state->mode_changed = true;
+
 	/* there might be cases where encoder needs a modeset too */
 	drm_for_each_encoder_mask(drm_enc, crtc->dev, new_crtc_state->encoder_mask) {
 		if (dpu_encoder_needs_modeset(drm_enc, new_crtc_state->state))
@@ -1535,8 +1560,7 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
 	bool needs_dirtyfb = dpu_crtc_needs_dirtyfb(crtc_state);
 
 	/* don't reallocate resources if only ACTIVE has beeen changed */
-	if (crtc_state->mode_changed || crtc_state->connectors_changed ||
-	    crtc_state->color_mgmt_changed) {
+	if (crtc_state->mode_changed || crtc_state->connectors_changed) {
 		rc = dpu_crtc_assign_resources(crtc, crtc_state);
 		if (rc < 0)
 			return rc;
diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index a8babf1dbe0d..7b480981becc 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -185,22 +185,7 @@ int msm_atomic_check(struct drm_device *dev, struct drm_atomic_commit *state)
 {
 	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_kms *kms = priv->kms;
-	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
-	struct drm_crtc *crtc;
-	int i, ret = 0;
-
-	/*
-	 * FIXME: stop setting allow_modeset and move this check to the DPU
-	 * driver.
-	 */
-	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
-				      new_crtc_state, i) {
-		if ((old_crtc_state->ctm && !new_crtc_state->ctm) ||
-		    (!old_crtc_state->ctm && new_crtc_state->ctm)) {
-			new_crtc_state->mode_changed = true;
-			state->allow_modeset = true;
-		}
-	}
+	int ret = 0;
 
 	if (kms && kms->funcs && kms->funcs->check_mode_changed)
 		ret = kms->funcs->check_mode_changed(kms, state);

-- 
2.47.3

