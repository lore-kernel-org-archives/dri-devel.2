Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4287606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UwSeRmgt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IpolgdBi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B112112D42;
	Fri, 23 Oct 2026 23:26:26 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A7B4112D47
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:26:01 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLwAl92965145
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Vr9bnjvssuxLuebxRpgYzgVNkR8qsjc3gztXQ+KxGZk=; b=UwSeRmgtwNOqjfVO
 GiR+S6sh4hZp+84uwuxNbQYyvZzqMT4kAdKt0mHjRSgUkrGImKNRujhBnVf9vXwR
 Y2usPVwMYa3iuFraoIz7IO9oqwfszcLRfRuLnUDbKOFjQs92FhtyXxH3t0vg883g
 8L3y6QHoAMsfvpBNTcwS7X9EhDwf5raG+9yppbLZTfTdecd0izOaTLf5up6T3yci
 q6OpNUaX14UkTAtogijoBrH6NwMeM0q+G6Jhh3XRAmqPYkiVXW9C7FsQVzC4d3Hc
 XJDu+66j06XcbQ03z5sHmMxEO/umMT1SxQTq0ZnsoDTMICuaMppfWRscWH0QxXtv
 5klpNA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgatc9cqu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e49a1d3b1so325517185a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797959; x=1793402759;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vr9bnjvssuxLuebxRpgYzgVNkR8qsjc3gztXQ+KxGZk=;
 b=IpolgdBiiRU2GHmjoEAwvFpvD7weixbZnYwLOOUQ6UdvHbBeXgHDMr2NXUHzHvulgt
 CSe1zyIz5M/kRvyIEeWwSs26IgfLYopUanVEni1KR0cBiNx/28xuQtwU6ZnpMlqaFa9M
 vXW/jn9PPCAuFeBPKYlzo9UT9yH4MiQesBJFl70Fk7edDanMzFSeWc1N/1mur3lfahaT
 OabLXMDxsu+FqlX5l+4Dvk+p7qnQ/GcPSVaHoDMA5VGnDhZ3WHSDiaiTCTl/CmWD0GoN
 cyYTTnTt9S6tlMR85271M0AEdjd+J1rNBvbSMZ0gZoq6gj5QjjGKamZgo3M7etH8UYsY
 IY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797959; x=1793402759;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vr9bnjvssuxLuebxRpgYzgVNkR8qsjc3gztXQ+KxGZk=;
 b=kcaot7eH8vT5NuPj0biF6OuBJ3J3XSGO5bpWs7XVT56b4b62bo613IV3h//7WVANdy
 Y5d2xpRF2AeKF7YaDFfPu2fkIM5ZqXQxR/ytiYsfvd286LXljnmeMrn/MYGw84P9DRXc
 pi8ntaweeXIMk4aPRRiJiyQ/jdVZkgEB8y6JaGoW2UAOIdixnpSvPRcSj9IFi96mBCQq
 vFWk+xZHbIz/VCwBqe++tFHQZ00X7ebFm77/iL7RcyABnBFbggguU1QFxdDSXQ54PF0k
 zdiSlB+0B+WiQaLjCIhynkFPSjoSithBw9NDEDXdFQ5BPJ2zsCIu0Yip9LIEd57iHxqr
 zXlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOPZ53E27O4ilJAdSFhi7Z69l/BADSyroMJI5uWjoF25chQeiM3dmxSBsPUUFES0thN54FUQz2NpA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIFZpmzqRorvVugAkRYkyd8+akWUjfer6MhIzycQgQvSNmg1Jrc
 tvD+Kj3G518NBQuXB1DB8F/u9EHzPY8mFvHi17ywGNn3ANvDfaNYrBCRBumyTtcQZxGuLzv4OsR
 bWOiiQkrxWkXiP2t8vz3hEJUQnouUWF8GGmoGBvvVuWxEqpaEQRwQpk7O3boEbMiTIsPPPLc=
X-Gm-Gg: AYBFou2Mc7oLgN0oUGJS6KOgP/dca3vIrSvlWUOhfO6Zm3vtdVh+gk2kWrvlBlv8cpE
 YgIblGSLGXx11M3vTo5lViq9jrieSCIsDo5a5up9aD0OisZ7P6QjwC5HziouBVbjGHarjuqBIba
 G/NJ8IHTkSYS7gH/He/1GAJaouQH+QgL9ttbX6cr9K5sNlZJkYAfERIo5nToq1C1xSiQgrzdjzT
 EOCQoM6vFIIV6oTaFKBlbAPQLspesCd4hehq0yx5KqWJHRbIjIZPrD62TJjyJe2eMv4JmzKhoUr
 JozgT2DXP35nFYLmAiORH931VkaNSTPQShtGFfAxWr0Nup7e+uJCfxtPNct7Yx8eYVt06x+BK2s
 2WZ1oubhANTx2g12Y0rw6x02Il4QlN4XZkbTSOqlYQTYlwKKA2TAdL8MeaIyeHh7tSR7vlJZmCk
 ziYSuGw12QXRQa
X-Received: by 2002:a05:620a:1a05:b0:93f:654e:ddb9 with SMTP id
 af79cd13be357-940ef8c8221mr79126685a.33.1792797959081; 
 Fri, 23 Oct 2026 16:25:59 -0700 (PDT)
X-Received: by 2002:a05:620a:1a05:b0:93f:654e:ddb9 with SMTP id
 af79cd13be357-940ef8c8221mr79123785a.33.1792797958612; 
 Fri, 23 Oct 2026 16:25:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a9ea71sm60217e87.81.2026.10.23.16.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:25:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 02:25:30 +0300
Subject: [PATCH v5 09/10] drm/msm/dpu: only reassign resources when the
 encoder is reprogrammed
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-fd-kms-fix-smmu-v5-9-a5b0b284aead@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4525;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=qmmDSBsrWozVVAMrvE0HZ4zhksCA/ZTlUzPFojWOt4M=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+zs7aVMXMNMacRC3La7G4bkZNjPurn4a0QHh
 Q2bqXB584WJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvs7AAKCRCLPIo+Aiko
 1QhLB/47Zr7O4aS6TGk/MYk7J9s9T6XTg7p9uMYvN0PlI+TPqwO3Y3R8qgn8tT9S0MnhKBgt5e2
 6QGTcsa+Wce/jlM7XXbW9gwHRrBlPJjm/OcTEtsaJHErJrKEG46c/vSa6SrK6noN8AJYvTBJ0+L
 YWHW864NrVy6qtMrZ/0Hr/XBni3jJLIVUxOc/axT3fpUSX35oor0L3ySoh+aHOrRLxEuoRcura1
 F90iDK2swsRdeGinoDFJ7//QUSIJDldBK/COucy+pCKKfJ4zf2+5P1GIGAExaehjJm/06cFPhCQ
 8juZQG7ZFTZpcfB4N8i70xvxuF1P7kClhXrx3jIlKvnzxv+J
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX0TYQhYi7O7Fg
 nUPX9Zs0Wr8qhsEOMfeXRXsyOuBvOdKdCtbbrBk0GwPN1xi6m014EFaAeen0WpLgk/IfT9S/+Eu
 dfdtvjdIgDkROMUbC8KpTPyu+8EMknJQiHYlC+TksK+mCgsHUt0FXZgaH6jjBTbVKVG5UsG9dXj
 BtPZ5UQKB9Qt3dNzAqKNuvkl8SgOoJ9g0Ya6FpuRjPvth0q2KkM+eLaN/ka+S+FBkDI7Rg15aq/
 O1cn1YSnGXNG8LQDRbcfAaAs7FnfqjpUUemaRMCPFijo82dSj4i3p+Pdpdmv9rx2DOZ5arDSE7f
 UGgAckn0Db9+JbHRkO9+8h9CJ8hqr8T2UppNgDIDGMmDtlEVG8vACTKogPyYpyDV4AVNegDRnSd
 PGuDMCbKRgsThB8zyAJz/nUtr5DbwEgx23Xypvol7oBJdLCTxQrzL1DR57eOCbGM3Kt6gjrjoks
 2CX0S7PiLAc/yDgtl2g==
X-Proofpoint-GUID: fRFqcLTC0npyY7brsKTvUaPWcTgMTqpB
X-Authority-Analysis: v=2.4 cv=Scxi5fRu c=1 sm=1 tr=0 ts=6adbed07 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=A1gMwnIAOo8MrSanVxoA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: fRFqcLTC0npyY7brsKTvUaPWcTgMTqpB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfXxrmoaafL3MPr
 SLfgRMybNHE5kHEUvoKPdpr1Q8BKb0b5QFf/Uk9z8pYY/hu8xFntdwfhvPtVAPoEjb1l9sDbEl+
 iBULyFtOjsF/s29x2XFeCD+loSh/pN0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230092
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
index 2ff0dab33710..048800227ad3 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1489,6 +1489,26 @@ static int dpu_crtc_assign_resources(struct drm_crtc *crtc,
 	return 0;
 }
 
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
 /**
  * dpu_crtc_check_mode_changed: check if full modeset is required
  * @old_crtc_state:	Previous CRTC state
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
index c26b0c7acdfa..db583cee7f98 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -186,22 +186,7 @@ int msm_atomic_check(struct drm_device *dev, struct drm_atomic_commit *state)
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

