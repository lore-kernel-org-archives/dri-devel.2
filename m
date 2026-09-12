Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95816C79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E912610E714;
	Sat, 12 Sep 2026 12:48:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MbI3N4na";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b195v7Dc";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60E6410E70F
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:40 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CBe2ak2240362
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U8Le9HTbvX+Njx4HmZDZ+JWS3P6BGRgoiPUFcnspqrw=; b=MbI3N4naxVD7krbv
 Ii4/SAgQPW/AXaLtTqnOBDU83JbY7HA2eWQTjhVmqC7Gi5cHkF3va87Rt4b6fuEy
 FcGy351S8KkFJF+ZmGxuetXyru1AIgdj83q+2SgBLab6F1AJl8MNigCZrjliQRnS
 QuVvZoR2dTutzGBP7m/6ViTuiVtQL33WEpdvKgID+J3L4QFCmqlgKpNfm/1RZ47r
 UDbtzxrlAhFAy1MBPDcefJi9bDTGGM6SvaGedCgYk7Gz+W+fAfkln9anEL9VmvZU
 cpXbAkl9eWfn6f6jT8wyq9oGX8gOYbaAiQNFe7/XrbOM7zHUBzO0jFonoifOYZJv
 KlhKgA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9c8xar-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:48:38 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-97cb18cfa04so1399667241.0
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 05:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789217318; x=1789822118;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U8Le9HTbvX+Njx4HmZDZ+JWS3P6BGRgoiPUFcnspqrw=;
 b=b195v7DcLS2s7lkTKul+zqz/C/gfVYFkBPxb5meD7+0DunqmCdO8xf9q90pGLziL0H
 55uVvWm1lQ5LJKD3V43PsJ4X+PIFoJI3oH9NigGhPiXvaPn3Jx3bl43kFqv3YnOB+8N7
 2Ai0bMyImUbLovmLrwNg8L9M9AIhFykvdstu+OALL33J5rinnn2cK7VSPJ2l0BEHWjoF
 zItAIUjQr9cGKtiwjJZ9j0ck8OVjw3cMu/yoBFwVOGNN5XOwj4LDICFm8VuqAtwCReRs
 OYluk10UULeoRbhgu+cU7aclMeOo3l02jl7dylY5QDs7opMdc9crlTJYxWityxg7BQzJ
 vX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789217318; x=1789822118;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U8Le9HTbvX+Njx4HmZDZ+JWS3P6BGRgoiPUFcnspqrw=;
 b=LEPRliP+6HnVDQswWDjNfRp91AERmCHFVapBSjorjQf3ihOXrWlhfC8bPhd6b8mHIo
 TmZe8tabqp8qZeVdcup14Wu+HF9GKVIJsnn4/wKk9UDwBl8KV2nTnt5qQuKHdOEHm10T
 mzHaqS4y7dtivbfeJil/2S8NDwhbhyp0UEQEPxb91cyVsXhE2aokbtceLZTW53K2JwSS
 DIBPGATWe5X/gvfdI6SpEQ1DhT0prn4NcMN0HZmsA6jcUybqrudYKlMJ3AgAW4Up/2qF
 Ds3xySuZGlCAuZDGAej20kzgb1jUQjV2YOyowXQ5wjqyVXClJseRn5Uif0NEkdXb8gVD
 0sZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDF7C/kEJQ/jXv+Hvg3Gfc6+XdLvpepvnoV+E6m1YMmFQl6mXqshBR9nyDLA+kLu724/F6bTFfPC8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++maR4upIx5DrMbwL3ThoXTXXoLuFev7m+gsi5Hy6XqrjuukGhxO
 RDtQhx5Vv2UEhWv934Xz8LeXBX/u7v8N5w06aRdKy0RJgT8556owjoFNEeaXa1RZM2Ma4PlQH46
 AEKXmmPoZ82K3NCNgipXkHvuTjupETs3POENqQiCBdUFpa1XtQSSdIBWiPi8uJzpYLXXOFl4=
X-Gm-Gg: AYBFou1WQbUiZ5q5+u/5bnqNyDFf6VEVPefARpCsX4GrPKq6EaoNxoTgs77PkTF6GQS
 NPCIT60HvNAlc+Kj1a9LQjL67VQqKE1Fjczu916JLmv97FYGcbdOr4l0JeHmSN54KG5DmacccoL
 1DCOMNNolQ0oGIRWj8lEPl4rDtUqxIZ8fpJbsz5cYEhJEKO+w18R0bQEUd633kVGy/xDYoAwZ6c
 Bun43aMdq1/1Gp4xl60WtG9qlWs4bLQk8Hp05aU5wHYxeIl067YfQyO5uha6uTrOhL3XFDiNSeE
 fd+n4vS7Fcsdn5RlMIhj9vvyF/elsFnrtV2zyxY27U1ZcsxGR95tJY6DN/ipvLuI7pT4hQK2wvF
 lBnE9QBfjQw1fkjuRwsGrnb4wlkYx6sr0lKfuq6ECN6vBAecuoyCY3RjQ0DpIw27jVo/bIcMpp0
 IEUKe/c/1EFC3I
X-Received: by 2002:a05:6102:3e85:b0:785:1a50:3f56 with SMTP id
 ada2fe7eead31-792aced9446mr9612194137.12.1789217318105; 
 Sat, 12 Sep 2026 05:48:38 -0700 (PDT)
X-Received: by 2002:a05:6102:3e85:b0:785:1a50:3f56 with SMTP id
 ada2fe7eead31-792aced9446mr9612168137.12.1789217317647; 
 Sat, 12 Sep 2026 05:48:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5af37a4eesm8825701fa.34.2026.09.12.05.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:48:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 12 Sep 2026 15:48:27 +0300
Subject: [PATCH v3 7/8] drm/msm/dpu: only reassign resources when the
 encoder is reprogrammed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-fd-kms-fix-smmu-v3-7-a7ddc6fe2032@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4595;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=mqhM4B8gnWC0chv2JmS2nzeA441LZsa3HAirQn66G6Q=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqpUoXjZHbyY1qpDjCgFI1oVlXrQOqcqHE9Tt9j
 TcW/w3KWyGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaqVKFwAKCRCLPIo+Aiko
 1QxLCACE0Pz82vSK6bzDBX0Vx+h6hP5HznaervgNVP0xo1/I1gS3Iv+z5qhjdqLysLV9HOOzwLA
 8qT7EafIyEjxOo2B3l7aPBy7opitSEtx5ABhKXaVpWM6koXklGEsk35VmVz6oHHVsYnqvYIZiw/
 g8PXmOB2VKc5DN8wN5i0xh2dpKTgfT3Ac17sIjrA7wUTlHmfanLWpdtlcMdXWBDX3ienGxQFGdo
 b3rYdEBJ1uwcGNbsKo62ckVbh4V15GwKVAaI/2UDVXc5TyGLUc7ThdUPACr5Ie578A4LX9hnqjv
 U1Tp744kT+E8BA+VCHm4ylzfJrhOmHS7Q/SBH03kylU4Bhi9
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: U_87dlhbC927-_k8g2mHBlFSAZeegOVl
X-Authority-Analysis: v=2.4 cv=Pv4G/AM3 c=1 sm=1 tr=0 ts=6aa54a26 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=lVXjEyyklXRvgn5FDE4A:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE4NCBTYWx0ZWRfX+8yiySu/nYgY
 ztl0K514HqXi5Ql58WJfn/MOkPOkfLBKRa4cObdYqW1Efv2nplHfQ/QpEcIRBuQe/SIL3kvuON0
 dOv/oMITVOwY5Glm/Pc/lHi35UwoXmY=
X-Proofpoint-ORIG-GUID: U_87dlhbC927-_k8g2mHBlFSAZeegOVl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE4NCBTYWx0ZWRfX1VkBGk/996cI
 Tf8ZjQHNk9vKZ00L0anhx4U6y+xtk47Tvg16JcuWd2zhp5bGqfOicREVFfEC2pFtQ+YX50Ylz2t
 34uOItsMsBi32mrVPqnlkU2g7hvT1fnmkUy9a8o0fgXe2RZUCwfXsGFDkYiIfoJiL+psptzNVyh
 49pGisg7myPVtGuT2/OS/LPDoe2jCQjXShHTL1pP+3adhZaaANAmr62SRMKqJlmb53p6I2EuOW4
 /NtHR8+K9KteVjvD6sEfURz0CqfNDejwVKHK9MdkbrcySAvq/uooHepXS0FRih8auyHCQa8I+ez
 OmyNc8pFFXEcfbfOE7Aav8W49as3D6ezhq8JaUrvRe7pt2Hq6K2yCST4kwpf1wwxYnwpfITP3hw
 +WV6mb/z/I+cOtBudJivrpOzFSQ9I/nMCzmMYmfHhEhNtebyHRwNTlufxe89jMbHR96Ln/3fsPU
 ZCzFoMMZ+fV+JQBp3jA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_04,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609120184
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

