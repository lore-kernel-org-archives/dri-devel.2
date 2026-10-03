Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645FFCA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:30:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7CBD10FA67;
	Sat,  3 Oct 2026 00:30:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QNJGTYJq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X8uwlbEr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3646810FA71
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:30:54 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692NfO5B2504039
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TKSzVpF9Y5u9f1YmazNZW9NP4SNsefNUw/+8xaOI3ao=; b=QNJGTYJqYbva8TwF
 BeM3Umn0WIG+tM6NsEM14V0TP8J9qt0lfoFkNpcHD/rN1qMQT9jFWEdBEwf6Ji1+
 gdHc/I2Uf7MCT/AxVT83+UE+X4zbzDMi9ehVGqLg7i0jwhPillfFi9UAMMr7EDM3
 miuJzD/eflCilqXQjmbgpb26JRKGYL5Vgyd1qeT8Wp3dYsLp+omeyvTHrW+DzbeS
 dXjQ6sBvv8c21YSlekTYWmWc8Z7CyyZFZFgiWQyEBniBIJx2gy+PoZHOfoJGwyxa
 8A5pO6KAyuOMwlpQwRihd2gAnUcUIP2+TYi5ZnD5P4xevlzfJthaYfnOEThozHD9
 GVcvvQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2ft8ss35-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:30:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934963b2bc0so18135385a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790987452; x=1791592252;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TKSzVpF9Y5u9f1YmazNZW9NP4SNsefNUw/+8xaOI3ao=;
 b=X8uwlbErb9kyog4sYZxRtCLvL27xzVBhZJdWaVJPN5YvS+ZpmSBwOmqxS4l5QwoOQT
 VmEcKW9dA/NevXlst/Gx4gqHrLtdi6V7Y97rHpjLCwRtJYITdCjSATgj9yDMBDxzLMtv
 JnwJn7Nixe1GwmSGR0FLxE0cGCkbtfIbXodLksW3sa/9nvDnSX6oMmK5FyscT24C0Z8g
 0O38x2cH5iCTegG0Nlb1fnYMkOzvba30wJi7Q74m8jiubO+MFGaEyAHXhUe7wLLssMzE
 DyQrE/D3LykecBOoCNJMKOY7zijtimGM0FZapbFzQdX1oxOROMzv0yrHhoLV4dVo8MlJ
 tS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790987452; x=1791592252;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TKSzVpF9Y5u9f1YmazNZW9NP4SNsefNUw/+8xaOI3ao=;
 b=H4tqTZDw6G50vjv+vnzproL24RoC/KPXQop8+0RqsX1n8o5fmIAiAfeDYyowjyxTBp
 lrr5yKWOjhDZ7cOrnJhafiYFOmmaC58bOIJx5rybizNR/yWJ51Z6ZXTEmd3EuQJNHh+Y
 siszy+Ao9LSumbjssCeo5urtmKrhGwtAChS1RY8ImcdmA10AS07XCVBoeR3QyBAw2621
 vDwiz2ybNbMennhvnRE1BeErg85clJ8+59ClMREaBZeJ73wtKQHMtV/21tjMmZnQ7BoJ
 ywNzHCCXKihnWF0O8WkYIQaIJQ4Qtq7MrMUNXNWV2BTHY3Qq5QEoybtl2zVgjmWhODLA
 Hv5g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxyNcqpVnyPTz4aaJI3QnDqYskQ6l3qJzrUr/Go1ewkdBIdLbHF64TQG//UIhz9HAOs4XCARP0JdxA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nqNm8YdpycwEqzscJgxRLQeGo5ql83ZR0Dr/Xrw485EIeZj2wj
 GN8juL+SU8zuK7WYZTzN835NvoZhgld5f3GppqVtlIuJN5sq2WHCx4670jtlFYNS/EeYBbRQKNq
 2WHuQukjhFypxwWBYiFqlx4dkI9/lzmVO1Tt8+Ui/5JgDMkTU0JV3CrnZHqdrd48g1merD6U=
X-Gm-Gg: AYBFou0HkHSO2ZyiEw5WEi2we+aNp7fHpEF2yKSH1z1NWP3UGMnyo0QhHkT0r+x/42q
 H/JAaGNwMMH+4vazVKcWGBGw/2hokI8rymHrUt7/PgDiwgJ7DvclNNx7UwYJmLV5SkNCT8iMlwb
 jElAITffmd1zOeHOsCGc0NfDz/qOQHF85RLiqo3es7ZJqMaWD1Ct9bgJV4BODAjDgOtcLPRRx6E
 nwMIfcTCwZpwgXwI6fOXdXcZDRiBcXHGXiMeg2ccWRNk64/E5o+q43Fg8kHUGhDUDMrIqbGG9It
 xxbDgzjD/pIoQ1gaIWD5rwEvhcTxVaz7Yo2tCtzkUyUNjlVuQTjt4E19t66uMmcNJScZc2+iJYk
 aVxHEyVh+xq3f5VaIYLwWC5dYXti1gpNqwVV0p6kMM/sPdi6aHPRkHGiLHtZJOiwrJensfEKcu0
 6Viq7aBYxu6O2M
X-Received: by 2002:a05:620a:a2cb:20b0:93c:9edd:7e6b with SMTP id
 af79cd13be357-93cf170bfbamr599120385a.29.1790987452196; 
 Fri, 02 Oct 2026 17:30:52 -0700 (PDT)
X-Received: by 2002:a05:620a:a2cb:20b0:93c:9edd:7e6b with SMTP id
 af79cd13be357-93cf170bfbamr599116685a.29.1790987451614; 
 Fri, 02 Oct 2026 17:30:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c7957d0sm1133979e87.31.2026.10.02.17.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:30:50 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 03 Oct 2026 03:30:24 +0300
Subject: [PATCH v4 09/10] drm/msm/dpu: only reassign resources when the
 encoder is reprogrammed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-fd-kms-fix-smmu-v4-9-2a44d4d8ac77@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4595;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=9SDSxKOaGPLQHPgJJ/MJ9sA9C1jx4gbbbbOh77Pqu4g=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwEyed8IZzZGwq30zWZitw+ph3kFy0hD5iced0
 HynY3ZqVieJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasBMngAKCRCLPIo+Aiko
 1VklCACNn7rkJtTd/eFXEXonWfW2YKR7qyLoPYl6sZPBfDd1NWWakc7215rba5CUGoGIuvVLhJ4
 atIHIm5wUuK/xGLzKdzARtyWbqBXAFbPafHGGEMdg8qv0xZATS8iOe8Ir4plnULmOxM1ZBvfKg1
 JbG9E7qIRP/KbjFp2eLEjHwsb2R0nNr+frfn3fNbW5AW+ATyhfQYdyeoij1oqCoY1z90Yw6IEae
 2K3+kMc3/0evFg6DuWGYLQw5pIQmDKOMVpeDcKcexT/eaDMzCR987ictRMLtEgG1t4qrZqzz5Gv
 Tu05Efwh020EvGg5jTmHx6Ejj9dVzbBrOflPo2i5JhaBTUJE
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 0Hb1azByXlqnVClvmRpvFf7Pe_NpXbn4
X-Proofpoint-GUID: 0Hb1azByXlqnVClvmRpvFf7Pe_NpXbn4
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6ac04cbd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=A1gMwnIAOo8MrSanVxoA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX/xpenJNoqkQk
 xavhW+zSftA+3MmuDdqxOyiDPHpNqE7xhtpwhMndlo30rnuocjt1m6MUhF9AIlgkCvtMld/as1S
 giGil4Mj+odLf+U4WbrVv3iW4FZQ9BM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX1G/dztz3CtTz
 vFhzU6mvXuhcNwJ78t0KTJ9OcpHa4WC5iwwhwuqZ58Ihcj/TpOd7NRUo/4qz8nOQ4DYGQOYsdet
 eYogEIvWff/N+yMg1/nNfSR5MvzfXFg5f0RI6Q+zAP+YwIRi8zrgkeTOynqU+XzXHONLpaz47WT
 z/IeBemQ5pu8EMn04mU9sgAbheJrtaZPIhaMT0aD6TEP8nJ+4mHj46Bcbq4xzS6lf2MWpdfCzF5
 Vp25eyOySphMCjAG0eo4YE/ilEXWGPSZkfhBwAdVXu9XJD0i8Ny1XihQBoFG8p7m32rhJZiUXGO
 18Yj8UXvCO+ul0BaztDF2ttC1eNSPOOVt7N92W5rTdVoWtqljhF160PEPRaBYOdEGGVoiZiTNEG
 BA3i2vXDcFr/yFCyH/Xe5UNAbAEsuoCEitCyOl/nfMPjsMqHeKZAdXiJTfiU0T+/4bEXalN3Bjr
 7qcT1DEke3Ks8yoqCRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
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

Running kms_plane@pixel-format-source-clamping causes SMMU faults
(fsr=0x402, iova=0x0001fb00): it sets a CTM, after which the display stops
updating, so the test times out waiting for a CRC and the pipe is still
fetching the framebuffers released when the runner kills it.

dpu_crtc_atomic_check() reassigns resources whenever color_mgmt_changed is
set, but crtc_set_mode() only calls ->atomic_mode_set() for mode_changed or
connectors_changed.  A colour management update therefore re-reserves and
can get a different CTL: cstate->mixers[].lm_ctl points at the new one
while phys->hw_ctl still points at the old, so the flush mask is
accumulated on one and triggered on the other.  CTL_FLUSH is written with
zero, so the pipe is not reprogrammed again until the next modeset.

Reassign only when the encoder is reprogrammed too.  Enabling colour
management still needs a modeset, as that is when DSPPs join the topology,
so ask for one in dpu_crtc_check_mode_changed() and only there.  Drop the
msm_atomic_check() hack, which forced a modeset both ways, ignored
GAMMA_LUT and overrode allow_modeset behind userspace's back.

Fixes: 39a750ff5fc9 ("drm/msm/dpu: Add DSPP GC driver to provide GAMMA_LUT DRM property")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 28 ++++++++++++++++++++++++++--
 drivers/gpu/drm/msm/msm_atomic.c         | 17 +----------------
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 2ff0dab33710..b1aea5769777 100644
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

