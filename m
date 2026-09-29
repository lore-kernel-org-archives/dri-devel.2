Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28A5CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C488D10ECCD;
	Tue, 29 Sep 2026 04:29:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YiEo1fYg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N5T6k4f0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A92410ECCC
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:29:12 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47BZY3643064
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kGmOSxaugPIJYRGrz5sk5TBB1f5tCohgbLSqz9Wr2Ns=; b=YiEo1fYggdE2ThvX
 Y/LhG9Xr8VhFGMc8tRWjJPR6/JCnbBarLTDP5XyeJMXQzTcgSfL+UNtJAuWSTfPZ
 IhGXHry15WDn3FrOtCPAFqj78QE3Q6COklwwzkVuKnzkS6UexK6+GSZ8m6lL6YTN
 Jy5Tey71XyE92HJB1Pfr4+RelASISh1BExUUsHssDGVtq6pqNoTEXF1aDj2/KvNK
 8oSau+eA2J0HIg1Zribowm0O5Fae8LWayzRhj6+aNIunTxxZSJneZQSV7WmN01kp
 wotPo8jsvqMllzdfrhcLSU/mHKbJd0Q/kvK2X2H0TKYC78DExKOu+bzk72kjnJB2
 Ujfa+w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h00s4s4kj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:29:11 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91454ecbd2fso61255546d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656151; x=1791260951;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kGmOSxaugPIJYRGrz5sk5TBB1f5tCohgbLSqz9Wr2Ns=;
 b=N5T6k4f0B0LrsV3kOid9HdyMpNWtOKeCDLwqyv5Ntynu388WI1/1vjd7HWVuWA3tOn
 4EF9ssBWqXlNpIjeRXvJnuJZDYuljt21y/av+7mLIbcMQ+zt+oxv4LG7UnJmV3qBHkv2
 HXDxsWHLw5nfxdzboPdJ1Icqe80BakBohdu8TkwNPCOeG8kdBJ76j5/gVnJW1VwOzunA
 MYk3l9g1ykad37HWaHLheitX2O0uHAIHugakVxg1tO0cxUposWaq7m4as8ux3AOiDgqx
 e9Silvqs4IcpepU1Mlv3g+JBfkc6W65lbfaOYUi8x0vw+VRJKld0+nNgbcAJGxDXZFw/
 gOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656151; x=1791260951;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kGmOSxaugPIJYRGrz5sk5TBB1f5tCohgbLSqz9Wr2Ns=;
 b=YQlaccVmQs3kBFk1Y0d5MLlAd/k/b/gEPZzbYk6JCv8c3UWNXlJWOWbs/7H6r8QuWb
 O1V9t7pp1VFCbKqBBs6AOQR3/PJrEv6EtVUwq6jumSuUd/37BUG2Hmerdwgq7+UN1Lov
 Q7Yvy5xxRCEvZxUbOOALKR043IUN4d1BLvnVl0Hj/0Oj0dk59vJPtmkX74GtWYIDd5X5
 NcFOkmh6mxAvIhtGRylrxLXjkP7YPjgT/EWf52gKtnackH2al7Nu0ZsKC8CvQGCOBFJw
 1z/G+vhz3YTGp6wSovHyYdcy00ub7tOgTKvOK0P/BTkuUS2pI2FoV+jfZtK/tni82V4/
 8LBg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCqLRwIYnDJg1jPxx9XR7p3XvuLa6GA3oJVVRpj9rCACswhOobg8kMlE400mDIlT2CIl5x2a/QmM8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK+4jAj7vulohE+GYopT8e6RhVD+rfKT6dYilr6+WbX94MjYMYw
 lt5dX4ify7HI6t1yd35/4Zwf6yaXzqG9fChzrmLF+HnuSEOqDurt1hkGQ7t5jxQVMEQtz4yt887
 0r+04wMoL4rjdhIkySDkjaqY1tHufVNHD9bLhBLCqQVPuuIBTWKkrNtfUQCu9RJ+6XwJ6fsI=
X-Gm-Gg: AYBFou0apjdeANeydEK52+jdX03mbpSTClgZPBbRRn/sR8cfSThi7AEEyq+5Dq8hVlU
 EWzAyqBh6sYbXKUNRwOy65cO6SF6xy7wNQl5IB3G1LMSDESmP39rNbWe+Vn9NcRqlqYuQtjGtEz
 jYjG+GvqGGrMWEmDZSgtahVr4bzizTHyMxuDOAu5R/TK08hmIXkmA6w5i7xjSGduKRjFdu1B1K0
 wTBcmHuUI9Er6QNnfwxN53qIroH2NQR01s2Z3vaU1wEWgiuKNiRLR9LqvQwoBhm2F19JYfJRPnK
 DE8alAmcIPJkwriE+iccNpH8kJsmJ6TQhvckjCr+wmV42MDJEku3X0RY3p5QDU5sDkHeiR7YcvJ
 LHf2V1+rOzZgiBhIAYmZeLm5U5aPQv/XA6IiRkXJ95Nv3Ujtofr5bxmBPIAsFDiU=
X-Received: by 2002:a05:6214:2528:b0:914:4c57:510e with SMTP id
 6a1803df08f44-9144c577f72mr168219256d6.19.1790656150719; 
 Mon, 28 Sep 2026 21:29:10 -0700 (PDT)
X-Received: by 2002:a05:6214:2528:b0:914:4c57:510e with SMTP id
 6a1803df08f44-9144c577f72mr168218996d6.19.1790656150286; 
 Mon, 28 Sep 2026 21:29:10 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:29:10 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:59 +0800
Subject: [PATCH v7 35/35] soc: qcom: pmic-glink-altmode: skip retimer reset
 on DP IRQ
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-35-4b81473185e7@oss.qualcomm.com>
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
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=4115;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=6r0ejZlAtNiiuitmrFYzWgKZtKiCeBVKShHo1hB4+8c=;
 b=UtJF5iVXVfQmOgSJr+NOadAJ3joackPYqRg1XJ71aS+LX/cOB+k/B4cYH2gpRTQaGVj6o3g2k
 S1JaNrh5jUEA978B10/jOwfccfpA2xnvNFUaL84QUkLrt/vE0odsEYD
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX4u8wjK6dzFdd
 XvkMqGyE7VbKukk0a8kYHSIrjGhYAbrhmYWPCjiBWks22/RGgnHDfsbsKnoubFQSS2oJLhLPC7B
 YsDdqoqLb+qqefy/RuoXlnlDoemvKVg=
X-Authority-Analysis: v=2.4 cv=ALbfqNVA c=1 sm=1 tr=0 ts=6abb3e97 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=rzLW7fUJNTnmvIt_Je4A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX0fBDgFOjkPwt
 hnp3oM0QNLE2/yQWpTe7H8jHlDLluVpRNzxeadByDzWFKrXENuO9BQpq273RfYvPpse754y9vtj
 5I/61bSjt8EjXc2w+HKX4hR4GELwh4I/7tbUmcnn1KXpxGmW4xxNAKV3Cs0aU7h4fW++webOv7Y
 ywTuYD76oul+VKl9lW1aeG/Xo1Jix+YteoBWFXN1lJvnvhiedzmUVE+8fAKeO1vCTtsmL3PG1re
 ntfoeyVE9SriD6Cubplxv2TssSFRgeK95UycZY5HUMUwWqdKXNOwTc3Humh8f4YG/RH4owYT1nc
 hjPcY5ghnaRZBWpEWPRoy//caPMwtCowEuPQIWb51PUqrwoIkA3tJEqLZvJk84o5q/xdC4RhoOE
 MLFzoy+nRB/mPxKBGpGETQaZO8tQbWmKPYk2ktL/5gsBeakLhlOIFYrZqX6XZtBuyagRczoMRS1
 ebNgaWWJ6xO+bSZeZjw==
X-Proofpoint-GUID: P5hi-WLjm8yapgpBZSWQVd5wGHzKs7AA
X-Proofpoint-ORIG-GUID: P5hi-WLjm8yapgpBZSWQVd5wGHzKs7AA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
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

A DP HPD IRQ reports a sink-side event and does not imply a Type-C
routing change. Reprogramming the retimer for every IRQ can reset or
disturb its datapath while link training or video transmission is in
progress, causing intermittent DisplayPort link failures.

Cache the successfully programmed DP retimer mode, HPD level, and
orientation. When an IRQ arrives with the same state, leave the retimer
untouched while continuing to notify DRM so MST sink IRQ handling is
preserved. Invalidate the cache on non-DP modes and after a failed retimer
update so later DP transitions are always configured.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/soc/qcom/pmic_glink_altmode.c | 38 ++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index e903d4910e9c..5ae554dc01d9 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -121,6 +121,12 @@ struct pmic_glink_altmode_port {
 	u8 hpd_state;
 	u8 hpd_irq;
 	u8 mux_ctrl;
+
+	/* Last DP state successfully programmed into the retimer. */
+	bool retimer_dp_valid;
+	u8 retimer_dp_mode;
+	bool retimer_dp_hpd_state;
+	enum typec_orientation retimer_dp_orientation;
 };
 
 #define work_to_altmode(w) container_of((w), struct pmic_glink_altmode, enable_work)
@@ -180,6 +186,7 @@ static void pmic_glink_altmode_enable_dp(struct pmic_glink_altmode *altmode,
 					 bool hpd_irq)
 {
 	struct typec_displayport_data dp_data = {};
+	bool retimer_state_unchanged;
 	int ret;
 
 	dp_data.status = DP_STATUS_ENABLED;
@@ -200,10 +207,31 @@ static void pmic_glink_altmode_enable_dp(struct pmic_glink_altmode *altmode,
 	port->retimer_state.alt = &port->dp_alt;
 	port->retimer_state.data = &dp_data;
 	port->retimer_state.mode = TYPEC_MODAL_STATE(mode);
+	retimer_state_unchanged = port->retimer_dp_valid &&
+		port->retimer_dp_mode == mode &&
+		port->retimer_dp_hpd_state == hpd_state &&
+		port->retimer_dp_orientation == port->orientation;
+
+	/*
+	 * An HPD IRQ is a sink-side DP interrupt, not a Type-C routing change.
+	 * Avoid rewriting an already configured retimer while DP link training or
+	 * video transmission is in progress. The DRM HPD IRQ notification below
+	 * is deliberately still delivered.
+	 */
+	if (hpd_irq && retimer_state_unchanged)
+		return;
 
 	ret = typec_retimer_set(port->typec_retimer, &port->retimer_state);
-	if (ret)
+	if (ret) {
+		/* A failed write may have left the retimer only partly configured. */
+		port->retimer_dp_valid = false;
 		dev_err(altmode->dev, "failed to setup retimer to DP: %d\n", ret);
+	} else {
+		port->retimer_dp_valid = true;
+		port->retimer_dp_mode = mode;
+		port->retimer_dp_hpd_state = hpd_state;
+		port->retimer_dp_orientation = port->orientation;
+	}
 }
 
 static void pmic_glink_altmode_enable_tbt(struct pmic_glink_altmode *altmode,
@@ -214,6 +242,8 @@ static void pmic_glink_altmode_enable_tbt(struct pmic_glink_altmode *altmode,
 	u32 cable_speed;
 	int ret;
 
+	port->retimer_dp_valid = false;
+
 	/* Device Discover Mode VDO */
 	tbt_data.device_mode = TBT_MODE;
 	tbt_data.device_mode |= TBT_SET_ADAPTER(TBT_ADAPTER_TBT3);
@@ -271,6 +301,8 @@ static void pmic_glink_altmode_enable_usb4(struct pmic_glink_altmode *altmode,
 	struct enter_usb_data data = {};
 	int ret;
 
+	port->retimer_dp_valid = false;
+
 	data.eudo = FIELD_PREP(EUDO_USB_MODE_MASK, EUDO_USB_MODE_USB4);
 
 	if (tbt->usb_speed == 0) {
@@ -307,6 +339,8 @@ static void pmic_glink_altmode_enable_usb(struct pmic_glink_altmode *altmode,
 {
 	int ret;
 
+	port->retimer_dp_valid = false;
+
 	port->state.alt = NULL;
 	port->state.data = NULL;
 	port->state.mode = TYPEC_STATE_USB;
@@ -329,6 +363,8 @@ static void pmic_glink_altmode_safe(struct pmic_glink_altmode *altmode,
 {
 	int ret;
 
+	port->retimer_dp_valid = false;
+
 	port->state.alt = NULL;
 	port->state.data = NULL;
 	port->state.mode = TYPEC_STATE_SAFE;

-- 
2.43.0

