Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8AECD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F00C410EDA9;
	Tue,  2 Jun 2026 09:11:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IZ1PcfUf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kVJW8+0+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBBB110EDA9
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 09:11:32 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6528VKpf3429831
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 09:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Duf46m0jTOVOH0fYjqS+1d3N2OndiCBozOdXn5npkR4=; b=IZ1PcfUf1rl4SRr4
 0rrKO0ahjDhHtkN4zmWWZNwz2Hh8hzBIPGJrMd3/vrFgYtefoDwwWuzc7q4YPcSk
 MlwnHnirbmvQpxgWv4E6bZ0xPkcoa3Ys4bvCviaH97lmv2vgS/a21g1GPhSo8lh/
 78deG6a495TavcqK74fKfY2r8+ZBSG02bP1xdV9LEf1Sh/afoVYtqi8Tgnbc2X9h
 VbZ5cvnHJ9JlFF0APRMfW447B9jlfKdPLshHtcP7JtIDiP18kQubcqSEk//ibDLK
 iDCQjbs0ZR0NfrssWWX7WlvtZXCG7h67B9cU9tjDhpSg+ANxeYzovFQsVHRZpLiW
 mZGLPA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehn8mhq1r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 09:11:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-516d1a8a6c8so160818061cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 02:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780391491; x=1780996291;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Duf46m0jTOVOH0fYjqS+1d3N2OndiCBozOdXn5npkR4=;
 b=kVJW8+0+xJYNkvJzwfEissjWtLaJAD+7hmj08xLYrXxhR8j6WV8K0u8oJkvkZBnCRs
 TjHJvp1FMNVi4AIOlxIvsgsnvzcSXjWaN73DEEhVLEcS6b1izU6XPKagmQtyneTkFDbw
 41KwiMoHriE1Dpf/dUh/sUlR9TjvzrpUPDpKcI9TTtVQU4r+valgCssPulRcP8jPOq65
 vQnM8TS6nB2DD7OaGqsmeIyWFK4VbwsHT/p+HAHs6ne9FXax5TacAlEQ+4thYhWQ9sVC
 QYy03pYMF/zlDwyUl3FghV2YSuP1cxE6jimmTI/lpFv2grO4btGjbloWVc69v/CuSk6V
 CmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780391491; x=1780996291;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Duf46m0jTOVOH0fYjqS+1d3N2OndiCBozOdXn5npkR4=;
 b=M4X+4S/P7MxuwzQjlZmsaf94l14ZGZdJ1m8JacDa3aPts73u5IG6fCOx2KfawQ7HPl
 sHt8bBs0kK/pzhyPljdVbPnyC+9ZgGqkSm1by6JW8YoImTWTFJ0omTqgQFd7Vlsk5nNZ
 FqUc67KuUiwD/TsAABpicAhkUiAsBQ/yCP01mWIL6rldcvk9q4T/9d+29cfr8CYZH6FH
 RxedwBGjqhmDgPVyo3VWKuc+SBR5FHQusIL9YnkmVyRE6Xk+D4sTwM/L2qiiyc5FYK8T
 De5iNijPIJbYF7Eiu8tPlT0htKL287+Om8H2Va5OneXsj+yRWbtwzjhw1zF/QaHHINAf
 IClA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8P++vRi2ojeHtSTo3W7vvWWHWHgz97zoal7g74TwvsOgC4cjvi5jEma5jLnFxl+KzzUKr7xqLFVIQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsknWkEymKDMRGQ6nXi/dAGb5TKC4/Ltx7ozDdVF7aQ9rwLTRk
 LDSDUcGYogRpCFpTxMi9IyIr2ajjF7kqSEufXDeeKS4mfryCxnsNkpF8RjbE6zSqhJ+VZXew0Js
 0skwPChFJQvXARroEzOafwvgsmMuRmPsfqx3oEe0X6GqoyKcQvR9qJmoAUXLyl+Z8nJ8W80o=
X-Gm-Gg: Acq92OFOBtO4wxvFBcEsJMkne5vmDI+hn87fRfdIbk+gfcSIY0CYp1BNs/HBKLbhN9e
 r9lK4BZWClae3+YBDqAPbxUS6SWBGGW/kCAcuguF0ZWlZX/qgbhX6jckYoNCoi62cgZ4X0LtE3s
 6knGzV0QaV+0uj92Q9TeRrf+bUsglybfa30m6mAYOC1PkX+Ouwaqebd2UvKAss2yAgjy6F0Nluf
 6S/V6ruJbXsXjMxvUFMbKEqtLcHxg+mJZJb34ncZeOHvzbeA4NPIr1Ze55pP05MFXpnBBVC5WAG
 cWojCY0gLAS6RLWRkhvWHlI17ZwIs3rrZ8ugNFW8l1S6Rd3kQFklkRjGW1S1xs0/Us3ST4ppqdu
 4yMVxh5unVPvopXGT4CJkTisXnI02GuieAy/O30uTG8EaMiHFuv7KY7eQLTPfXQ8q4Kwnb673YA
 HGa56ZRSiAJ94jzZw7cg==
X-Received: by 2002:a05:622a:284:b0:517:6ef7:f6ea with SMTP id
 d75a77b69052e-5176ef7fb5fmr10989101cf.11.1780391491175; 
 Tue, 02 Jun 2026 02:11:31 -0700 (PDT)
X-Received: by 2002:a05:622a:284:b0:517:6ef7:f6ea with SMTP id
 d75a77b69052e-5176ef7fb5fmr10988731cf.11.1780391490741; 
 Tue, 02 Jun 2026 02:11:30 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51768c76e53sm12480851cf.4.2026.06.02.02.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 02:11:30 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 02 Jun 2026 17:11:14 +0800
Subject: [PATCH v6 02/15] drm/msm/dp: drop deprecated .mode_set() and use
 .atomic_enable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dp_mstclean-v6-2-2c17ff40a9b2@oss.qualcomm.com>
References: <20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com>
In-Reply-To: <20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780391476; l=8155;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=HuWHEfgETeqeFInaSeDlkVr7MomHzKqKAmZIdQ6wMSs=;
 b=M69pZb0hXor2OgwRt9PIzLikRSelckTn7Ng1DDuYG7f7f/Lg6xBo4UBuvTKsw1Z4oTMeB9wT7
 Kp42JM4BCdGDqLlk4eDsjSgkqlc0A3YhqxTW3kIZ7iebQa6reK19O/2
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA4NiBTYWx0ZWRfX1VbL/1o5k0Hx
 Ih3QOSDgxR9wKmGakHX26Ofwog6DY+tzLMdGwZGJO3PIgrquofRyJ/9vQqcEIDOfIkaRapfEXcR
 8MHH1kQ2syWDQ9JKMRSq57eJwYDYyJtZig7gu+kZiBfdg1/kPV8WtwRFpzNEGAid3BhjMXz+bdW
 tCsDW+nJnQDecio/n3GwCklpAJLCryhyZ7/8CuWQP45WVR7zwPBL34TTBbBlvXkWXX3zuO11vPK
 wN+qNkK9j+z6qqzjO/gObFAQPf2duimO2rfW8OEwjaUWPIZQvhb7ENvcwOh+YNdzM0F0B1hUtyx
 /CAHXjleOFGOjNDRC6Q7vDHHmAzlfJaATcTcBNY4E+kc0H37l6alMv4m+3ZbdZq18Egpw8s260Y
 cA0+4hf/4+IIgngONJSYD6oeUmSBBSzbSJ/z/Ox4uU34r0T6rCMwN2Zw5xyKb/E6geGGj+otCTg
 twLqAyiVvJ6LF2Q8aCw==
X-Authority-Analysis: v=2.4 cv=d5nFDxjE c=1 sm=1 tr=0 ts=6a1e9e44 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ohAeICWEHyx3i1rom8gA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: WEzYcGGqs8dPHdePPuvvn7ulArhKSwXI
X-Proofpoint-GUID: WEzYcGGqs8dPHdePPuvvn7ulArhKSwXI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020086
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

The bridge .mode_set() callback is deprecated. Remove it and move all
mode setup logic to .atomic_enable(), where the adjusted_mode is
available from the atomic CRTC state.

Drop msm_dp_mode from msm_dp_display_private and store the mode directly
in the panel, as it was only used as a temporary cache. Both changes are
limited to msm_dp_display_set_mode and are kept in a single patch.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 81 ++++++++++++++-----------------------
 drivers/gpu/drm/msm/dp/dp_drm.c     |  2 -
 drivers/gpu/drm/msm/dp/dp_drm.h     |  3 --
 3 files changed, 31 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index e3682c4d6077..181d238addfc 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -63,7 +63,6 @@ struct msm_dp_display_private {
 	struct msm_dp_panel   *panel;
 	struct msm_dp_ctrl    *ctrl;
 
-	struct msm_dp_display_mode msm_dp_mode;
 	struct msm_dp msm_dp_display;
 
 	/* wait for audio signaling */
@@ -597,16 +596,33 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 }
 
 static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
-			       struct msm_dp_display_mode *mode)
+				   const struct drm_display_mode *adjusted_mode,
+				   struct msm_dp_panel *msm_dp_panel)
 {
 	struct msm_dp_display_private *dp;
+	u32 bpp;
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	drm_mode_copy(&dp->panel->msm_dp_mode.drm_mode, &mode->drm_mode);
-	dp->panel->msm_dp_mode.bpp = mode->bpp;
-	dp->panel->msm_dp_mode.out_fmt_is_yuv_420 = mode->out_fmt_is_yuv_420;
-	msm_dp_panel_init_panel_info(dp->panel);
+	drm_mode_copy(&msm_dp_panel->msm_dp_mode.drm_mode, adjusted_mode);
+	if (msm_dp_display_check_video_test(msm_dp_display))
+		bpp = msm_dp_display_get_test_bpp(msm_dp_display);
+	else
+		bpp = msm_dp_panel->connector->display_info.bpc * 3;
+
+	msm_dp_panel->msm_dp_mode.bpp = bpp ? bpp : 24; /* Default bpp */
+	msm_dp_panel->msm_dp_mode.v_active_low =
+		!!(adjusted_mode->flags & DRM_MODE_FLAG_NVSYNC);
+	msm_dp_panel->msm_dp_mode.h_active_low =
+		!!(adjusted_mode->flags & DRM_MODE_FLAG_NHSYNC);
+	msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 =
+		drm_mode_is_420_only(&msm_dp_panel->connector->display_info, adjusted_mode) &&
+		msm_dp_panel->vsc_sdp_supported;
+	msm_dp_panel_init_panel_info(msm_dp_panel);
+
+	/* populate wide_bus_support to different layers */
+	dp->ctrl->wide_bus_en =
+		msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 ? false : dp->wide_bus_supported;
 	return 0;
 }
 
@@ -1309,7 +1325,7 @@ bool msm_dp_wide_bus_available(const struct msm_dp *msm_dp_display)
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	if (dp->msm_dp_mode.out_fmt_is_yuv_420)
+	if (dp->panel->msm_dp_mode.out_fmt_is_yuv_420)
 		return false;
 
 	return dp->wide_bus_supported;
@@ -1365,15 +1381,19 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 {
 	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(drm_bridge);
 	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
 	int rc = 0;
 	struct msm_dp_display_private *msm_dp_display;
 	bool force_link_train = false;
 
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
-	if (!msm_dp_display->msm_dp_mode.drm_mode.clock) {
-		DRM_ERROR("invalid params\n");
+
+	crtc = drm_atomic_get_new_crtc_for_encoder(state,
+						   drm_bridge->encoder);
+	if (!crtc)
 		return;
-	}
+	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 
 	if (dp->is_edp)
 		msm_dp_hpd_plug_handle(msm_dp_display);
@@ -1386,7 +1406,7 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 	if (msm_dp_display->link->sink_count == 0)
 		return;
 
-	rc = msm_dp_display_set_mode(dp, &msm_dp_display->msm_dp_mode);
+	rc = msm_dp_display_set_mode(dp, &crtc_state->adjusted_mode, msm_dp_display->panel);
 	if (rc) {
 		DRM_ERROR("Failed to perform a mode set, rc=%d\n", rc);
 		return;
@@ -1446,45 +1466,6 @@ void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
 	pm_runtime_put_sync(&dp->pdev->dev);
 }
 
-void msm_dp_bridge_mode_set(struct drm_bridge *drm_bridge,
-			const struct drm_display_mode *mode,
-			const struct drm_display_mode *adjusted_mode)
-{
-	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(drm_bridge);
-	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
-	struct msm_dp_display_private *msm_dp_display;
-	struct msm_dp_panel *msm_dp_panel;
-
-	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
-	msm_dp_panel = msm_dp_display->panel;
-
-	memset(&msm_dp_display->msm_dp_mode, 0x0, sizeof(struct msm_dp_display_mode));
-
-	if (msm_dp_display_check_video_test(dp))
-		msm_dp_display->msm_dp_mode.bpp = msm_dp_display_get_test_bpp(dp);
-	else /* Default num_components per pixel = 3 */
-		msm_dp_display->msm_dp_mode.bpp = dp->connector->display_info.bpc * 3;
-
-	if (!msm_dp_display->msm_dp_mode.bpp)
-		msm_dp_display->msm_dp_mode.bpp = 24; /* Default bpp */
-
-	drm_mode_copy(&msm_dp_display->msm_dp_mode.drm_mode, adjusted_mode);
-
-	msm_dp_display->msm_dp_mode.v_active_low =
-		!!(msm_dp_display->msm_dp_mode.drm_mode.flags & DRM_MODE_FLAG_NVSYNC);
-
-	msm_dp_display->msm_dp_mode.h_active_low =
-		!!(msm_dp_display->msm_dp_mode.drm_mode.flags & DRM_MODE_FLAG_NHSYNC);
-
-	msm_dp_display->msm_dp_mode.out_fmt_is_yuv_420 =
-		drm_mode_is_420_only(&dp->connector->display_info, adjusted_mode) &&
-		msm_dp_panel->vsc_sdp_supported;
-
-	/* populate wide_bus_support to different layers */
-	msm_dp_display->ctrl->wide_bus_en =
-		msm_dp_display->msm_dp_mode.out_fmt_is_yuv_420 ? false : msm_dp_display->wide_bus_supported;
-}
-
 void msm_dp_bridge_hpd_enable(struct drm_bridge *bridge)
 {
 	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(bridge);
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index b659d22f5f28..6ac5bac903d9 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -56,7 +56,6 @@ static const struct drm_bridge_funcs msm_dp_bridge_ops = {
 	.atomic_enable          = msm_dp_bridge_atomic_enable,
 	.atomic_disable         = msm_dp_bridge_atomic_disable,
 	.atomic_post_disable    = msm_dp_bridge_atomic_post_disable,
-	.mode_set     = msm_dp_bridge_mode_set,
 	.mode_valid   = msm_dp_bridge_mode_valid,
 	.get_modes    = msm_dp_bridge_get_modes,
 	.detect       = msm_dp_bridge_detect,
@@ -233,7 +232,6 @@ static const struct drm_bridge_funcs msm_edp_bridge_ops = {
 	.atomic_enable = msm_edp_bridge_atomic_enable,
 	.atomic_disable = msm_edp_bridge_atomic_disable,
 	.atomic_post_disable = msm_edp_bridge_atomic_post_disable,
-	.mode_set = msm_dp_bridge_mode_set,
 	.mode_valid = msm_edp_bridge_mode_valid,
 	.atomic_reset = drm_atomic_helper_bridge_reset,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
index 041aa026ae2e..4bd788ea05d5 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_drm.h
@@ -36,9 +36,6 @@ void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
 enum drm_mode_status msm_dp_bridge_mode_valid(struct drm_bridge *bridge,
 					  const struct drm_display_info *info,
 					  const struct drm_display_mode *mode);
-void msm_dp_bridge_mode_set(struct drm_bridge *drm_bridge,
-			const struct drm_display_mode *mode,
-			const struct drm_display_mode *adjusted_mode);
 void msm_dp_bridge_hpd_enable(struct drm_bridge *bridge);
 void msm_dp_bridge_hpd_disable(struct drm_bridge *bridge);
 void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,

-- 
2.43.0

