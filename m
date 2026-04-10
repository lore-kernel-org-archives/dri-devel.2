Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E05E99062
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CDF310E92F;
	Fri, 10 Apr 2026 09:37:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UO+o8HGk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DOwLhyVe";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FB4D10E928
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:59 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A5LbOn2698378
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fDWaKe5f+7e99KJw/bpieQonEcTMeQipveQM7zWE+/o=; b=UO+o8HGkRbkrRVJz
 xCoeE4wBPBbZJm7xsZns7FnygjkL7xZDBblSf1sfJNZDKM7xU1yoqfOLhygpb7Tk
 w4KxYmGfhfzsQRSSpn798ghmDUA3Xp6NY9G1Kj5ihoVWqFjGPjdkicIoWpuwqYqk
 q7P6z3cN6Il4XoAjLljv1pkJcynmPxU8Vyk/0DljFn0Xpgd/oph7bUcdjKVanG4y
 HuCGqymyJjkud+L5fw36NNh1D8NO6k4clKo0jy0vnrQ44XwcF+8I6pFaH9MGHKgX
 hiizxKg29mjj6mOjo4uDtRzonWDxp3wen14uWtK0OLIYshcaTUDvSJr11vXH3fR1
 8Y7fTA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4degt9tjsq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:58 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8abb82c27e2so57445906d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813818; x=1776418618;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fDWaKe5f+7e99KJw/bpieQonEcTMeQipveQM7zWE+/o=;
 b=DOwLhyVevyA6h9YpLY3xvEyleqb7ZE5yyZuqeKJlmDmeX2oxGpv9d1yrHLAwEVUeLW
 AJnwWS85kd41Ijz1CPJNL4VZYrSePgyu4Yyj3vmo4OQHlj86TiMDk45efHNKJxlEQ12a
 Bc+cAdieRU/G901qwpMCBvs2YFFDAOIemPAMiy4wqDnIL56PorELa7XDlQsLa7ANVRcR
 EwnqPyiLZyilDD0m29m/XMAP0bVOiX1tZyxRvIWl4azKayQdpEvjK2vDl6fHCrBRhDYS
 k+Ikq11TjAMnlDZ/at4XbfZsKxcP59fuKi6b5akqH0PzI3zGu0icswDvR1IOab5J2e33
 rYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813818; x=1776418618;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fDWaKe5f+7e99KJw/bpieQonEcTMeQipveQM7zWE+/o=;
 b=hDso5sMTsjtYneOhOP2K+1+e1YgjCOHK52xZ8BjcVDG3JzQmw+7nDJt9mfJPj5CVK0
 5Qwfl0zsF/SIBha8tITdh08yPkspajBmZdaEasfmtwHkreHzCAnUneH5pTbTU9hLWxpv
 8D3PEJjHNVc7FARrMPJozCfy73des+TnGiAQX7ewxPkryKEWRQiIy0Ka3xnL7J0Cmk+F
 oj2GlY4jhySfwXNaGU7GX2/JNQtgissKL7KbeJjmakAr68xp8tcf7vMc9ESm55luOd3Y
 gGdgQNxc/N81+4uWiAbNCinCzjq0F9qlpysEiQdKM8abmKLwxPf/nNmBblh9h8+EX/7f
 CDHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAsNCfoP8J1rwyfL6U3iHs19eoMOy3a3xS0wMLzMgDyquhDIDuwtKa2/bxmcJsl7jnKUzd9eRYqSA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzVeU/RpSC5XpoCq3MVJkRyXPnfFNWZ+cfidkqt4jxKiY4/j8hg
 QoOiVowc0Q5EIewG+yySe5afPUa/XEJh38C8+3KipTiD8vbWdp0BdWGEs2fFQIsnNF8NZzSb6CR
 wWxIGTm7WgF6N5O/3aeBNL2yekiwVR+nDKIHv6WW0cG2/kkh4uWO+ZkuQKGeMAbxyqPdBtxg=
X-Gm-Gg: AeBDietudA0z/K8YLAkVmClTxga5gkZL3E30aXx5s/NFeuILOj3CSs8nVMfce568jng
 lqMJoJ00kRpQNXfdWZ/TysyIh+3JPJthP1d784MR7DxckU66OfvuW1YlG8aMkQlxYfAN4K0JRph
 P/YWuQEPMd1Evo9WP81ja1IptAFpXy0+P8Ix7pzpm5kec7mvcDNEZXq2Vti1Kf+PvYthYNF+rNq
 oozqRP0Kc+uo+wNa7A77wGM3zD1OIcuYH7faOB0ZbpHvpvt44sUtuD1EoAehYQTDfew0xlX7rIX
 lLo6RFTUm9ICtVe2yF4k20Ak4gSeyN0Uf25N1QsgloRggcpEAdvqZqgV+t/jw5dAK6kzTg0mtjj
 2VgWkXGIpn9afzUB5EhKRs/IPs0eK8nHr9o2Dlb7KHdirgK4Beg/FUjLntGazf3knC2A+72bHPE
 vuCvhZaRo=
X-Received: by 2002:a0c:f40b:0:b0:89f:48d0:4c9 with SMTP id
 6a1803df08f44-8ac862ddf3fmr33949876d6.46.1775813817700; 
 Fri, 10 Apr 2026 02:36:57 -0700 (PDT)
X-Received: by 2002:a0c:f40b:0:b0:89f:48d0:4c9 with SMTP id
 6a1803df08f44-8ac862ddf3fmr33949476d6.46.1775813817280; 
 Fri, 10 Apr 2026 02:36:57 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:36:56 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:34:12 +0800
Subject: [PATCH v4 37/39] drm/msm/dp: add HPD callback for dp MST
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-37-b20518dea8de@oss.qualcomm.com>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
In-Reply-To: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=4601;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=5coIwZZglfoV4uKoF/vpQgfWA6y2lt7z+E6eTPu5qE8=;
 b=BxuBV3kygu9oP7RA0Au5CFMzw2KFdoHVQD1nNAWyfy72By1F/uQ6s2PCbKae+UvVcA95edjo4
 izutmyS3bCNCamWqs4Hisq/pUMJtIprSElgAAYNbu9vMtSZhMkMEaPn
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OSBTYWx0ZWRfX6PMp9OZzCRaP
 q+gulKc+Nxo4PFVemMFK9BMSw8nSfiqF/zG934VHc6ts8aVCyKaa5erAgo/5SZ2LsI5hxY/Osp4
 xaVCHc+80Myc8JrAM3VySDycoeHMogIDebgj+szvg7CaWpkYgTVBmu/d7NtdoL6ip90gJFY+bO6
 ZOPNDhm0vu986gB1cflJZpm8RHFO6/ZLHgtuY4C3zHxAqSQ3tlRM1o1ZAQVGpV6pk6rLlw7sOBp
 EFvA7hmPjI5lO5QRTNkz8w7kDAI1ZH7VWv/tWI5u4WMIrVj5i5g0ugJHINtRYlYx3qu9ji+am/+
 eJNsmYhUMnUuRsnHKHXIgN1jQ9jt8ZqFHL9Sd8RkX2l/PQgxRoaqUu21iF8fiycJqGqjhqgR/8Z
 OyDVcpPOG+n4IA/Dc4fXm26GIfF5MUy6Q1iMkyIslsAud83vu6yQl6EDDNJUcN/7Xw04+es1Fzy
 iMcJJIpDU4HVJ5Znmzw==
X-Proofpoint-ORIG-GUID: sQlf8PJ_iJas6qCs12EFVlkadGdpt79Z
X-Proofpoint-GUID: sQlf8PJ_iJas6qCs12EFVlkadGdpt79Z
X-Authority-Analysis: v=2.4 cv=BJyDalQG c=1 sm=1 tr=0 ts=69d8c4ba cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=EulU2RYtZUHqnRkH09YA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100089
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

Add HPD callback for the MST module which shall be invoked from the
dp_display's HPD handler to perform MST specific operations in case
of HPD. In MST case, route the HPD messages to MST module.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 23 +++++++++++++++++++----
 drivers/gpu/drm/msm/dp/dp_mst_drm.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_mst_drm.h |  1 +
 3 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 919767945ba5..ca89e20b7563 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -454,6 +454,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
 
+	if (dp->plugged)
+		return 0;
+
 	mutex_lock(&dp->plugged_lock);
 
 	ret = pm_runtime_resume_and_get(&pdev->dev);
@@ -556,12 +559,19 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
 {
 	u32 sink_request;
 	int rc = 0;
+	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
 	/* irq_hpd can happen at either connected or disconnected state */
 	drm_dbg_dp(dp->drm_dev, "Before, type=%d, sink_count=%d\n",
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
 
+	if (msm_dp_display->mst_active) {
+		if (msm_dp_aux_is_link_connected(dp->aux) != ISR_DISCONNECTED)
+			msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);
+		return 0;
+	}
+
 	/* check for any test request issued by sink */
 	rc = msm_dp_link_process_request(dp->link);
 	if (!rc) {
@@ -1125,9 +1135,13 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
 				      connector_status_connected);
 
 	/* Send HPD as connected and distinguish it in the notifier */
-	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
-		drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
-				      connector_status_connected);
+	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
+		if (dp->msm_dp_display.mst_active)
+			msm_dp_irq_hpd_handle(dp);
+		else
+			drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
+					      connector_status_connected);
+	}
 
 	ret = IRQ_HANDLED;
 
@@ -1793,7 +1807,8 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 			msm_dp_hpd_plug_handle(dp);
 		}
 	} else {
-		msm_dp_hpd_unplug_handle(dp);
+		if (hpd_link_status == ISR_DISCONNECTED)
+			msm_dp_hpd_unplug_handle(dp);
 	}
 
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
index bb3898b1f6b1..71d3f63973e6 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -490,6 +490,40 @@ int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
 	return rc;
 }
 
+/* DP MST HPD IRQ callback */
+void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display)
+{
+	int rc;
+	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
+	u8 ack[8] = {};
+	u8 esi[4];
+	unsigned int esi_res = DP_SINK_COUNT_ESI + 1;
+	bool handled;
+
+	rc = drm_dp_dpcd_read_data(mst->dp_aux, DP_SINK_COUNT_ESI, esi, 4);
+	if (rc < 0) {
+		DRM_ERROR("DPCD sink status read failed, rlen=%d\n", rc);
+		return;
+	}
+
+	drm_dbg_dp(dp_display->drm_dev, "MST irq: esi1[0x%x] esi2[0x%x] esi3[%x]\n",
+		   esi[1], esi[2], esi[3]);
+
+	rc = drm_dp_mst_hpd_irq_handle_event(&mst->mst_mgr, esi, ack, &handled);
+
+	/* ack the request */
+	if (handled) {
+		rc = drm_dp_dpcd_write_byte(mst->dp_aux, esi_res, ack[1]);
+		if (rc < 0) {
+			DRM_ERROR("DPCD esi_res failed. rc=%d\n", rc);
+			return;
+		}
+
+		drm_dp_mst_hpd_irq_send_new_request(&mst->mst_mgr);
+	}
+	drm_dbg_dp(dp_display->drm_dev, "MST display hpd_irq handled:%d rc:%d\n", handled, rc);
+}
+
 /* DP MST Connector OPs */
 static int
 msm_dp_mst_connector_detect(struct drm_connector *connector,
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
index 5d411529f681..08e145399cfc 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
@@ -9,5 +9,6 @@
 
 int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux);
 int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state);
+void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display);
 
 #endif /* _DP_MST_DRM_H_ */

-- 
2.43.0

