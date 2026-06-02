Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBEECD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C50010EDBD;
	Tue,  2 Jun 2026 09:12:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fc1CDxdd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jFzrmMyB";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9707D10EDBE
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 09:12:37 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6526MVeo2767170
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 09:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CnGOml6KRNLCf8LNyNsT22xgMpxrnwiDol3PAO0B0Jw=; b=Fc1CDxddIHANP11x
 cRrB39iSWkuTIMR6zfUHAGGw4SrivL1gbg7MXGwYB9lWcSTyngO38iFuTZxKrhJL
 5FSpCRhIIpJTN2k8v6J9266YJGA2uPEHImiBO2N3GnIvMxJiLAD4qcPYXpqcfBTd
 dXwhgvvYdCHe1lxgTnUAa5qmTauzhTPTPSxuEI5qLaIOvEelcrD31ADv9AfKQPhx
 02OaSNPJ68clP+exldURvgZHYjx/w1iz7KrkLZi0GieEGIj19sgRx91XM3W20LVi
 OK2+aXg64y7DKgbO/O4j/TlzlRTNPKyvDh9fg2ovvSPaM4Vb6DynK9y0zOs7SLFr
 VnG8mQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsus0ptu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 09:12:37 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-516e0846095so49554381cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 02:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780391556; x=1780996356;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CnGOml6KRNLCf8LNyNsT22xgMpxrnwiDol3PAO0B0Jw=;
 b=jFzrmMyBlZjwp0N1tYSHEKMnBLNeBqzVQxTLw3Dh+Vj8xC/3MB/T22bBUmbZoLWWyV
 dAKpND5AevbFf4MMTGBn0LZtSuSG5L+82uU+S6sOZc8UphQBFBHqV93ZA72Mep9kQGqa
 BvLrHLWFO4GoNT+P3x9ka+ABAZgpBFufiGv00LV/8rPrtvcTZXoRedPhgA7RVgnOOelU
 +BIqQDEXOtk2TqyQZsGImF8YNse1OafcbXhIoRyHC+Uj2qN6Z+nMwJf6uPaENrNNLZ4C
 EdZi8cTOeNZNtZHAOK+x9zsEgnpdfQEovT2NUlXBRvexZtR0wejn6bkZ1YbIS6dKUApc
 V6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780391556; x=1780996356;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CnGOml6KRNLCf8LNyNsT22xgMpxrnwiDol3PAO0B0Jw=;
 b=hV/KqfNyoWaNi28NZcusBN0oeqRmRwdJGzWl9qfEPdDEDhV7ACl0BrJJMbEzxU03W/
 VIvOrpCbPJGDMaNfC2a6X9hFSvELHcy2gTQdDVGZcZZ7XhEtOCCFlTu0uGxWatWT+KPh
 GBjLAWX3ZTM4nG0wpobaIWhijyl1MCfcLt93/pI0KsX8MktUpGoAW+ke52zk0n5fkL0R
 LD21Imnz+WcrHqf71cfapgB4QscMe8NtBWyBMMx3V5mHU437rfkS6l8xcCYJwdx+Kd67
 BqKsQZeH1KUfYFW/TmRp48dr5NA1Xa50OiCx3VOff4BTXE38X4FSjMcF1u9cWmxnJevN
 JE2A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ksDMoURNQZ51sKKtP8hmpkBXREEB5arDwd8Oll8giQ2I49pUKTsgonUmGCZaS6sraxLXJq94mtFA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5gWbuJLI6229iw3iRnEvQrfyM+6YnImKbzZdswMOwg0l6m0/3
 ZmMuDZtrwtj9noj6MzFucVnWyE5X8vUF8cm4BsftJD4F0ec0XNOoekp8d7r9lZlyvlJIJDQi3Zy
 ndU4zC0SElSHgPMt1k0mTcQzIr5DTf7rYqTZrdwQwtWRJpqL4pE7SNP2XW4RHKbMx37vzlyiBkI
 dLZlFmtg==
X-Gm-Gg: Acq92OFIv8Ft1yElapUuagKGwyFEAb3uFew8vssXHNcbmnqHouicYLzpGdJIpvWlJ6Z
 Mujyl5ZtIguZWUZFFy1l9XrdNsixTTJ4d1NrpgHBegNgO0YlTAAxII2ja0Zvj+06DEz0HrQ9J9U
 dR+hluYwE8sTwv1JQCOoW09KO8iv8oNYRX5Rhc62lnupcMj6cr0UabGskfsQ0ik4lc69VR/xP2E
 VqkREZlHOsDu5hDSXwRBtAABbOui4STEsTMx6Fd3vVTwaGFPdrCCIcwkwLPvOMXP1DPdizIKFmj
 7KmZL2i9qRbW1jGb4Ed5xGoSpsj4rl/cpYDeDZsggvlHfNlyUlpuplnvr2aUW/J0GA5/D2PDxWW
 +RhOVXCjnSBq2ztyOgc6604VFUFsx2fI6cwwNJPf7bON0LzglfJq5/IaQx237aEfglg1uYGTM9H
 z10xb1QMnvhxzBhcmJow==
X-Received: by 2002:ac8:5fc8:0:b0:517:7277:9362 with SMTP id
 d75a77b69052e-51772779863mr836991cf.48.1780391556010; 
 Tue, 02 Jun 2026 02:12:36 -0700 (PDT)
X-Received: by 2002:ac8:5fc8:0:b0:517:7277:9362 with SMTP id
 d75a77b69052e-51772779863mr836571cf.48.1780391555611; 
 Tue, 02 Jun 2026 02:12:35 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51768c76e53sm12480851cf.4.2026.06.02.02.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 02:12:35 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 02 Jun 2026 17:11:27 +0800
Subject: [PATCH v6 15/15] drm/msm/dp: pass panel to display enable/disable
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dp_mstclean-v6-15-2c17ff40a9b2@oss.qualcomm.com>
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780391476; l=3118;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=VMCb+gh78a5tyRp4ocOtlXR3WU+MH0tKL5IrymVyK/Y=;
 b=+MxUWsyBnARoL5Z62MZhRAt4ecZNYa9xBG7vgztbTLl60v1elrbRh/WmVoBaLvyQOPEGYmlxT
 oJC7G1JLVSwC58blLYJYerJpyqtOgCMZPtAfv7p4fQtZmrgohyS1pj1
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: 7jUAxrEgUsWJxQMTmo_SjObbRdI_xjbq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA4NiBTYWx0ZWRfXxSeVhbT8CF4q
 OE8oQ27WNe2L7Sc2pm5wCk0BXm1Cs9+z1w2SlPie0dnrXFiz1jOEFjF290MjQLOZiK7aGXH2338
 /pls0Ik7lIhPMZ6W4WlpgjIDuQRHSVQE+gT2m5zcDCuQaturuzIn0JweoVVV6jxq7fhmTCrBm8Z
 0/YVA+rSemodqv8z5JxqK8sAOi3vpN8hOcsOKlFOh8z0uxTY1xqD7X+43Y7oDApDFCtRmkFI+gk
 92SKMNmDw5rfEmRPDyAbVVkGEic7WPO4vfG722py8X7pAFoT0+USsQVdGlwkmKjYEOL9whLo13q
 34U7FvN7EheIqElQPyM2CMmN+0gsL0gFYh8TsQL8wkWvqEWyY5rGWhnN6roWXPD+NiaXspcVvQW
 78Eqk+hTtx5zxCzDuduKWrgkRLw+AgLPGj+Y1drl2Ytqsbh780kypyaYRdU0jZRCpbYuB+n/S/k
 ZXfH2rqHDQThFILO+CQ==
X-Authority-Analysis: v=2.4 cv=ZYAt8MVA c=1 sm=1 tr=0 ts=6a1e9e85 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=wgkWW237A_BUGFCT6doA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 7jUAxrEgUsWJxQMTmo_SjObbRdI_xjbq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
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

Pass struct msm_dp_panel to the display enable/disable helpers to make
them easier to reuse for MST stream handling.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index cd1f2899b733..bea5bfb22967 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -650,7 +650,8 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
 }
 
-static int msm_dp_display_enable(struct msm_dp_display_private *dp)
+static int msm_dp_display_enable(struct msm_dp_display_private *dp,
+				 struct msm_dp_panel *msm_dp_panel)
 {
 	int rc = 0;
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
@@ -661,7 +662,7 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp)
 		return 0;
 	}
 
-	rc = msm_dp_ctrl_on_stream(dp->ctrl, dp->panel);
+	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel);
 	if (!rc)
 		msm_dp_display->power_on = true;
 
@@ -707,20 +708,21 @@ static void msm_dp_display_audio_notify_disable(struct msm_dp_display_private *d
 	msm_dp_display->audio_enabled = false;
 }
 
-static int msm_dp_display_disable(struct msm_dp_display_private *dp)
+static int msm_dp_display_disable(struct msm_dp_display_private *dp,
+				  struct msm_dp_panel *msm_dp_panel)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
 	if (!msm_dp_display->power_on)
 		return 0;
 
-	msm_dp_panel_disable_vsc_sdp(dp->panel);
+	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
 
 	msm_dp_ctrl_off_pixel_clk(dp->ctrl);
 
 	/* dongle is still connected but sinks are disconnected */
 	if (dp->link->sink_count == 0)
-		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
+		msm_dp_link_psm_config(dp->link, &msm_dp_panel->link_info, true);
 
 	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
 
@@ -1437,14 +1439,14 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	rc = msm_dp_display_enable(dp);
+	rc = msm_dp_display_enable(dp, dp->panel);
 	if (rc)
 		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
 
 	rc = msm_dp_display_post_enable(msm_dp_display);
 	if (rc) {
 		DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
-		msm_dp_display_disable(dp);
+		msm_dp_display_disable(dp, dp->panel);
 	}
 
 	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
@@ -1479,7 +1481,7 @@ void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
 
 	msm_dp_display_audio_notify_disable(msm_dp_display);
 
-	msm_dp_display_disable(msm_dp_display);
+	msm_dp_display_disable(msm_dp_display, msm_dp_display->panel);
 
 	msm_dp_display_unprepare(msm_dp_display);
 }

-- 
2.43.0

