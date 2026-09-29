Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEEDCA5FAC
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24FBF10ECAC;
	Tue, 29 Sep 2026 04:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="T5sqpYqq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BKQi0mbc";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C99EB10ECAA
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:50 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47jJJ4053026
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cOU7YLI3VILYFBBKCNNR9aX4zGt/Kw79u/VQXU5slgs=; b=T5sqpYqqq2htlhbG
 ylVc8MruvmxWui2c8rrwekTAxFVrhrdsMecQIjNcelIeUmuSZXyOnX337el9f8jb
 aCT7z8Fq6IHR1W0VeZuNJU4f5JRrLbkgOnRbHyM0XEI87rINtrt9qHfUrMDbKGR4
 hFVxUrY3SY0AWxTDpPVHNhWo8Y+gqVcr+V55Z3zOBfjXU2gfvl0V4MeIHKzs3+Ed
 j31v9hKttvpnJZ8szJAMFITjRWFyC6RI74Epj3d2D6P+ml2vUlQ2Rwu0EA4WeIJA
 wMxCwX+/aIAPKSXz0ly7iBCsvweboMTRN1CpKbOpFbFomhb6xmNp4f7ClrBJyrxw
 kihcig==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h05yxg2dp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5332e744789so56789411cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656069; x=1791260869;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cOU7YLI3VILYFBBKCNNR9aX4zGt/Kw79u/VQXU5slgs=;
 b=BKQi0mbc+CQW7V/A1TsYDlGWF1ZAZ5g09BGZx9Hwm1bo9lnA6dsqUvQVHI+WVPyAKF
 oxXr9TtWvqkfmY93pKOoxwpzOT+Ge7mIyMUADWOcN5UhK+U68AG9tRFdLMGI1IF9eOhQ
 kv8xY1vo9ydyU95rswIpz3tmrcL/mvO1F47tPpA/DafMWDfFiw6AnySLts9VJAPDIdIc
 AJjMOP6eTidQdYNEZ+xhyyAVyQi0qTWY6WK9PDt20fYqsxvH09894WWk3wmA9WbYZlyt
 L+7xhRE7BQ+5h+hQmxY6LLgGJ8qWUGukVr6DvHTzpDM+GnmIAWmqf/M+QwR9C3z5IiS4
 6HqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656069; x=1791260869;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cOU7YLI3VILYFBBKCNNR9aX4zGt/Kw79u/VQXU5slgs=;
 b=Sx7PiRrpVLd/N5KG5Z0yHfOUQDWXHAQ39JiiWjD47sKYVHjM2ZQAs80cZ/Ul27BIcA
 5+oonCohP5n2XaZvkMsfDxQ6Zbm8Ft0fHdedLDmEjAgrWNvA5jZaYr9PDWg2H9oZIq3S
 QLX8Ucynp5gFzkWdTrKlN4rui+JhN4WQ4arBLUTyKxoLO7ySIWzTaMmt6Fkms1zu+C0w
 7sMzj9NW1K8Kf+3rWwMvdgxIR3qnTji9h6Hgz2Ogcio1cmnjbhvTgOVupvGvzT1jTXhr
 MnIOKRGeKV2qDeEpjAUC+MMlfR96N9liZ2SgHCnvqJ9z49Qq3xHhyseX1lEjX0AyELbO
 IHmg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy33oQmmBnshq7CIKVckEpLuBhR46mghq2tFx8jldVEfsxtG972Bj+1BP8UAwyM0uPHs8BscqoVM9s=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m+FkY7gEsIAtihBBX6a33InrpKQmUY9ht/n7ud7roZhkR/iU8f
 y0M3FSkY+nuer5m8fn21ng6fJI1thE0OrW12VcH++oM299H6W1fNXG98XHlxPrO9lE1JwxkjoxB
 jLUuAPEGDc8n3huD2HJ6lAqRee9Mv+g/jqDcCW5mS1AUBKVgUQiI+lbR1RvMHLdXCeqqtaBk=
X-Gm-Gg: AYBFou2hjLkpyUWXhwpgnCNNqhme8c5WFOQ7OtcsrFbvExHWCb+6h+FfAG7s70ywMvO
 h+LCUM4CQEsMUFreA2GevukADfFP/7+MatKn4SyaFGRDhVCFer6/G0gTPeVbN4Tg5xbVi3SrJ40
 bvo9ahdif5qkxitK6DrUiPswiLZ8E7dkc9DylB7kEOFGe/5X29wxi3/mzEvzjHU9y6ARRlogkc1
 MK09RNSeyjFxh225eQil2zfRofUNewOuNOO2xF60q0gF7Oi/kqyWOMopK3fobE02oJq/4vGhSJK
 A6y8ASctr+S8Hfp9pOaGaZruyGmnyX6e3EOXb+snO0jo1GuEsP1DYbEYl1qFAzVgc8KVyEIhDsT
 Jg7+uBlYfE5Z/xj8Rms2fKOHw3lK4CYb/6zvIdQxYtVwCjAxjLuYhyYh049CbH60=
X-Received: by 2002:ac8:5982:0:b0:533:3911:f502 with SMTP id
 d75a77b69052e-5333911f992mr131782531cf.57.1790656068973; 
 Mon, 28 Sep 2026 21:27:48 -0700 (PDT)
X-Received: by 2002:ac8:5982:0:b0:533:3911:f502 with SMTP id
 d75a77b69052e-5333911f992mr131782171cf.57.1790656068423; 
 Mon, 28 Sep 2026 21:27:48 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:27:48 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:41 +0800
Subject: [PATCH v7 17/35] drm/msm/dp: add msm_dp_display_get_panel() to
 initialize DP panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-17-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=3826;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=G2aKfBzlYxNF8QcaqaWZAefzV8hquGjEQW8gg4WREL0=;
 b=0h5DH5Kq9vGjYe4rmlO73scb/MuumoRApov3eD9HnYmyhkzFJ/nQYdAILreQAFCwKpwctVgAz
 /RDTvW9szHKDzFOPEweVW5kl74esdVO6Iw26Sh6/oCg1FUAEksdWitf
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX6ygLJALhIEJe
 WOqYo31zF65lcA5WVJfDPC8gkt1LGPixDR1ugEkCifsqGW1CqMWd/OYZ3B61nr82uOw6UsjVGdr
 VW2WCy+aTWdz8zNEF3L9V3VF2brdlCg=
X-Proofpoint-GUID: 8xksNGnjalXwb9HXeOjonJ8jW5HB7Omn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX6MLYaRf19MIq
 OQq23+xEOblO0cii1BUfe9lLC9cqzT7sccSYrYOc0nZMoQdFpPkfRcNVHjyKaYzNQJIVDBnihXd
 OdCjFgWmCTqKQZbRqc+b8ni987pe8q0hcSWJrWAsc57GsNohvIIl254dE00Ih2ozAg6QFh5l62T
 hEQPgnILR1WZ71CZtxMRn6OpFZHoBIKrk6QedNk55oGX/7Sj7n4VSkRWBdNgbcZ0giACUgG3bet
 U8GFc61qyZC2CzymxNJ4uxdNqnMhf2R6whfsRA+nuSN4fwpaEwyXGQlbKEYg4jhCuTwQ/Xx8b8a
 lQQdoZzY+wE0/18RmDNjYgh1NoocJxhFKp8UFZumUpYx34e0V6znzCO9rptKPGe2ybng4O/r5Ck
 x9unhC/H3ydm/MIV+wxhkEUEMzMnfAeOmOMXHEJXGExJks3T8IqXtJZADVy7VIRZItw+sApcbMn
 u5puIfVWTXgljoRD9ew==
X-Proofpoint-ORIG-GUID: 8xksNGnjalXwb9HXeOjonJ8jW5HB7Omn
X-Authority-Analysis: v=2.4 cv=SaFi5fRu c=1 sm=1 tr=0 ts=6abb3e45 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=kCKOgzAXqFYlHSlaV6AA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290017
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Add an API msm_dp_display_get_panel() to initialize and return a DP
panel to be used by DP MST module. Since some of the fields of
DP panel are private, dp_display module needs to initialize these
parts and return the panel back.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    |  9 +++++++++
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  1 +
 drivers/gpu/drm/msm/dp/dp_display.c | 27 +++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
 4 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 02732bd4efa1..d6f39cc3bc66 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -3159,6 +3159,15 @@ bool msm_dp_ctrl_stream_clks_on(struct msm_dp_ctrl *msm_dp_ctrl,
 	return ctrl->stream_clks_on[stream_id];
 }
 
+int msm_dp_ctrl_get_stream_cnt(struct msm_dp_ctrl *msm_dp_ctrl)
+{
+	struct msm_dp_ctrl_private *ctrl;
+
+	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
+
+	return ctrl->num_pixel_clks;
+}
+
 struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link,
 			struct drm_dp_aux *aux,
 			struct phy *phy,
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index e8b445c552f7..111300784edd 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -61,6 +61,7 @@ void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl);
 bool msm_dp_ctrl_stream_clks_on(struct msm_dp_ctrl *dp_ctrl,
 				enum msm_dp_stream_id stream_id);
+int msm_dp_ctrl_get_stream_cnt(struct msm_dp_ctrl *dp_ctrl);
 int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl,
 			     struct msm_dp_panel *panel);
 void msm_dp_ctrl_mst_timeslot_setup(struct msm_dp_ctrl *msm_dp_ctrl);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 487c76e0f990..1d1fb45024c6 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -529,6 +529,33 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
 	return rc;
 }
 
+struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
+					      enum msm_dp_stream_id stream_id)
+{
+	struct msm_dp_display_private *dp;
+	struct msm_dp_panel *dp_panel;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	if (stream_id >= msm_dp_ctrl_get_stream_cnt(dp->ctrl)) {
+		DRM_ERROR("invalid stream_id %d\n", stream_id);
+		return NULL;
+	}
+
+	dp_panel = msm_dp_panel_get(&dp->msm_dp_display.pdev->dev, dp->aux, dp->link,
+				    dp->link_base, dp->mst2link_base, dp->mst3link_base,
+				    dp->pixel_base[stream_id]);
+
+	if (IS_ERR(dp_panel)) {
+		DRM_ERROR("failed to initialize panel\n");
+		return NULL;
+	}
+
+	dp_panel->stream_id = stream_id;
+
+	return dp_panel;
+}
+
 static void msm_dp_display_deinit_sub_modules(struct msm_dp_display_private *dp)
 {
 	msm_dp_audio_put(dp->audio);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 51eace1d1346..4d4349068c2f 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -59,4 +59,6 @@ int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
 int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display);
 void msm_dp_display_unprepare(struct msm_dp *dp);
 
+struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
+					      enum msm_dp_stream_id stream_id);
 #endif /* _DP_DISPLAY_H_ */

-- 
2.43.0

