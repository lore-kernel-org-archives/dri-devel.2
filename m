Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8734DCD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 10:41:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAFDE10EFE5;
	Thu, 28 May 2026 10:41:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="n1WR8qZt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R/wmKS9l";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34D8110EFEA
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:06 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8vcOo566560
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7wI6jvNGSR98bo2DUVRgJiWXmNW0I3KbQXB15AxathA=; b=n1WR8qZtX+7708X6
 U9e/PjhbdIZgeerGiCZpRpWQ522uL+jlqznwgZBVknNkCcs7D5gWddWppH6tHtgS
 IsZ4sDRhjCO8oitoX6yJeQ8Q7Mh6yluCyu7PxW8B+9bJEfX4up39rGsXAaLmMTve
 dlgnmxJ2cgDQwX4i10BfZHr92kJMfysMa+QpEDMScIGnSlFMIieWYT1DPBiKMtDw
 XRh5Y4V8XLws99eLf07IpDhOnOi4nHOU188TN08aZUs6zJ2OobUoyyAW/W5DUr4J
 K4GKIVHrpVaRC/9nmkgDmPJ+fAmzwXJYK//EC+XZ6Wr5CUBNe8NX2TYhbHGkvyYQ
 fmfP6w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ynjd8g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-914b11441aeso1026500185a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 03:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779964865; x=1780569665;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7wI6jvNGSR98bo2DUVRgJiWXmNW0I3KbQXB15AxathA=;
 b=R/wmKS9l5P0rFya4/pmNA+US/8jnpHmWH+y2/A1na1d43Ou9XoPqZbHqcewppBNMu1
 +1pTEn4twiM8M7EblyDebKc5O6RLyrhu/13SpnTLiCnaKnOBMm/ClWSBhbibrh/8fTjv
 1VvzB+T3VxKgSISuEuic0ToOEQsO3rOMGpC/n5lOBz3WpCO4iBZVn/pOCi8me1QyWMQe
 3VFEc3yrgChzoMYSKuU2bOEGftSNg/XKQNYak7KtfCIvJ0eZj5GaXZfy3VjIJLkwOIxY
 z8VgQuX710752vkR5e4xmQRXv5Vtuds9UueWxqasUJFeRgYGDVywzK9sv0CAq++4wN5e
 iFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779964865; x=1780569665;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7wI6jvNGSR98bo2DUVRgJiWXmNW0I3KbQXB15AxathA=;
 b=AFixJ0a7T9fX5LIV2hAL3FnhSCwai7PSdBE0fXnk//LmZZuZZw98kSkvVl/mDLGTRQ
 4gZpAX0meS2OQxvSX6jXCxeNa5bMe4rkay12niZ0awf3H+Sq8bcmRYDUmrbbMvFpMkHf
 agStj16aegFqYWYX2qMWlw5zVoldVY/+LNruZWGFfxYQJEwu7Tpro6OHFO2zP2DpegBU
 w3joKv/VLTXyQ8CZI3UeEhwTArUDn/oOQTiA/G8VhHQEGTxiTD1Umm3ELsKl9znHUjc0
 mXUP7Fx0lhbMKbIbLbamEX9nOIoeOf7stWuA2x6MKUR8PuYoBwGNKQfSVCZyT5M2lWU0
 d8zg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+18zBTb/lvXJaYa75LYXavp4L646U2QHCf9/Wi5OPXVKTXfGTeHaU2T7sWS4+UifB1FvXKMjSQnM4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyiTDV98ojdqFBzvQwwglD+w73eEQvgYwRzvqJ4T799BpLOrmtC
 7e5AsP83PHZxpVcDCXxbOXiR8ducC7QutU8MdFYfnR+UfBIbnXdxH0NNdaN4DYAaWE/KWIjCggJ
 E+/3Dsp4WwbCOGSfzKxEBmWFU8k+H0RyPgRS1ykqLKyjsPCuOiMouEod1hNZi8m1XuwrFeBk=
X-Gm-Gg: Acq92OFy60/S0o/eyWOQZXP2H95esd+PQ3aeXo/BHftpb7/mYax1lrp2d1zVpS+940W
 jfZXfZcWnj4tfQydAxt1WVfnvzkmabK1FN+SEv/QgU+HBOLdPiWkzraAW4gvkd6O/BnK3iBxyLq
 4pT7wRLUWsj9h4ZbOHmGQAMyt1tcUXNJtqyqX0hC0j9gCtEInxyqAQnKN06x9F139W3aTVhqfqw
 QxnqL6LZRQgKdLYStAGjzNpRnNVkbeXGd+QSOw3/q4MOJdPXUsiFa/nsXvrVr1FjgovcnXIsXMW
 IKFJ2uQZCfzmgFZShYjaxQzMD+zCs3wFjUy0MKFqRRKSBnM69MhKULGN313JMgLn/CsRbASxAA1
 k5g8r9H/id/3NUseU+yGdAJScZFTSJmmoW1h2wtm+PL+GnpdW7nX5rmNwGALaqf2i4G0ON4Pxql
 iVpi7Il8314a8OV+XDhw==
X-Received: by 2002:a05:620a:448e:b0:914:7b4f:cf6b with SMTP id
 af79cd13be357-914b49d868cmr3771422185a.44.1779964864629; 
 Thu, 28 May 2026 03:41:04 -0700 (PDT)
X-Received: by 2002:a05:620a:448e:b0:914:7b4f:cf6b with SMTP id
 af79cd13be357-914b49d868cmr3771419485a.44.1779964864203; 
 Thu, 28 May 2026 03:41:04 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f86fffddsm755148485a.12.2026.05.28.03.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 03:41:03 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 28 May 2026 18:40:27 +0800
Subject: [PATCH v5 06/15] drm/msm/dp: split link setup from source params
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-dp_mstclean-v5-6-a9221c1f1f3b@oss.qualcomm.com>
References: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
In-Reply-To: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779964831; l=1402;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=S+ko8gfgb1mb/Dv+kOg6axgerBOVHS4WNYhG4rO68xk=;
 b=nj8DZNQBAG8Yv1jLvE8uPR2T+66yfBe2XIg8TCJ0m7qaMRXMPXthbOtz8NdPcHoR5bBRo44OX
 FXMYyUE+l4qCi2Bi0FgC9yWHqP+bT3ujFg8MSoJZ1JdxEGNxFSHYrLa
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: 3I40LlHMrzCTdKB5kniG5NgMoAHPAtUF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEwNiBTYWx0ZWRfXwlKjYYCSN+FK
 zcSX6SYsLrc7WSKxixYjHZMvCX6k6X3R04HqNuXD4tHtsoVGp7x2BY2zv9SG1UFSy6zMvNKqj/W
 OK5WawhjkRo9fuEtSu7lSFRdspOvsyuLOWql1JD7dXSvrQdNiXU2StjkmfXpmvK5aUYop+FAkWC
 D1qSyu6QMVuxcd4QT1/c5jE7NHIAptqtJxM+jhgSIKPC3RYFuzYoIqoE1c8yo4W1f4KjeUKwauK
 FfnOic2CZaxFEZBiOWAI1vNVcr/zxHNEBA6LkzypJGZwkFmbgpLC8OgSUs3f3bMaA0uxG/QqFcg
 NnT4mAousaEYq1T4TUfp+9KnOk3EnIy1C0mbpx8VZK6GaGU/vsQU2qAz4LhyPQRKRd221fvgj6Q
 PegifMSiKBDC+FS7vBNU6/Dqrwq9uFdA1TYMlwFNQtdcqLe2Wi4Tuw2BxO9vhW49+5HHL+GqlF8
 GRQutFtL3yWQztYWIAg==
X-Proofpoint-ORIG-GUID: 3I40LlHMrzCTdKB5kniG5NgMoAHPAtUF
X-Authority-Analysis: v=2.4 cv=Eo7iaycA c=1 sm=1 tr=0 ts=6a181bc1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=saXSvH3Ee-fMY4W8qR0A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280106
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

msm_dp_ctrl_configure_source_params() should only handle stream-related
configuration. Move the link setup out of it so MST can program link and
stream settings separately.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index d4f48669541a..b22b3a0df313 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -483,10 +483,6 @@ static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
 
 static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
 {
-	msm_dp_ctrl_lane_mapping(ctrl);
-	msm_dp_setup_peripheral_flush(ctrl);
-
-	msm_dp_ctrl_config_ctrl_link(ctrl);
 	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
 
 	msm_dp_ctrl_config_misc1_misc0(ctrl, ctrl->panel);
@@ -2552,6 +2548,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
 	 */
 	reinit_completion(&ctrl->video_comp);
 
+	msm_dp_ctrl_lane_mapping(ctrl);
+	msm_dp_setup_peripheral_flush(ctrl);
+	msm_dp_ctrl_config_ctrl_link(ctrl);
+
 	msm_dp_ctrl_configure_source_params(ctrl);
 
 	msm_dp_ctrl_config_msa(ctrl,

-- 
2.43.0

