Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11EDC43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:18:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B62110E8D3;
	Mon, 29 Jun 2026 13:18:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fBJO8k5B";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N821hsSQ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B79910E8D2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:18:36 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TB5Fh82728575
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 h/u6JPc641J8wBzj5j0oNFgP8pVVYegd9kCes0Z3CLU=; b=fBJO8k5BBmPm8Kh1
 imQYBPiDiJzRnst395bSM+c59ua2JcQxAOrKjmm+GivMXUGx1s0mHKaZ3yhqA50Q
 F6dqBX7RJQakKkpPDh5yWCFdWd9HWy9QIWLnCLeNSDdgmMA3/imYW/Vk5yYO4Qah
 ETfZmv1r5xx6UZNP6L5mTgSl/7fyUZagxeYfYY2ltB79gop3UYNu8lYaVKuX+r7Y
 iWKrmEuqsQtpAMAr33mnPjd6JQ8j02qZylWAffiBVzUw4I7K8P2G3sY0ewK7FMgm
 3kiGJKJ8tYugA10qjGEwLXnS4RpkDqksJ+kFPtWhlDWTFnGOfDWY+WEdMJ1ug5Ym
 wmnhFA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3qha8fsg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:18:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92229624a71so621258185a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782739115; x=1783343915;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h/u6JPc641J8wBzj5j0oNFgP8pVVYegd9kCes0Z3CLU=;
 b=N821hsSQSlSqCUSOQ5AGZ2z2e9onAuYSQILDubBLJV603b0kG7qS/m+uWmOT636Ghv
 cLrLzHVShKEfm9zRtBFqP/YHtoPUGetg54ljDltijWUfVjuwjBQarsahBOrYzhnyw01U
 OIaqA7iwAKY5SVl30/ZLXUIhBYLDGWBdYSpo9ulKv1Lx5ZCcaaMY6ekUlQD0ZZkn/osg
 PvUw+E1nlLHbKUe5zDdhUupt5hXdZUporWrZX49WQpWqxSncADRhgTI3yrlJXAvR1DoO
 62CBfpzNX7UILgJwiCv1ZpxedFPA4T9ihvkE8Qud1CVOJnK38dE7YYsjUjPPiuLq9J0e
 zP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782739115; x=1783343915;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=h/u6JPc641J8wBzj5j0oNFgP8pVVYegd9kCes0Z3CLU=;
 b=O1kW+rfgmBnIiwPF123M8Uk7A4pHa2LrdfX/jE7yUCC5EgRN+WTwnFoMMKX56kHRQp
 mxhY/E6L+ptOdmaTfQdvwWLXP8ECovs3gMhOrzKeEMUhI43RZBrzhu/m1wIUJsc3BVp3
 0ajO32DydxCWBbwVXs0Hxm+X44U7gkBhPCwCh9yC5xlvklEKOZSHSt0UTlxb0TUsTvzY
 fLLsU0gwbyLS3is5Yl4v1UmSYrBDDdABnEqnieJ790WTxln1xBlljOtF7OsND6ETwkBo
 evHK5A+tJ3Fj9T9obw8dPzQXlG2SjHhi5shSPRYBWvTMuqyGfKmy3pukUBX3GZI4Ju7+
 JWYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/AQa6leekEXFXrueluZHdKiJBg/sXGh67K87+M+GoO/95jVQgGkvyLoHbXCrmRIx7aRBh6zBrycCs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdaEeN+FqOGRXSauIY30fO96sqrjqRq69NZ0SuNtMxCZKoFPD4
 TdSMizw0oCWj1e9m7ZypLg7dLbLb/9dnmUtge0WhEm/1WUjy8lv/a2z9YHXnQAxgJstI6GBTKdS
 bJPrkqEISDT7owmM0tM0oWlrm+/n8KBC/zZkoUvPm3IQpiSmUBnRvACo/ETsiSzOrIGzY8xiTbG
 foGABnLg==
X-Gm-Gg: AfdE7cn2hqRRehc10zomATW2oniSd+J5hL0bkGfaFvoeqKkYYjTP5rQxgexDJDpo6f7
 O+niznLvKvS+fpLSI3X9Cb3dNCjTr3yKa6GNAajKyC/IXZR46n7yqm1CCg9ZVe1sxsN+X/xHmEX
 tKM6WpXxd68f5J03Mwar8YOn3mud1OqkfaP8nzFrKspXG3I9NYncihNpw2WiABfJsR//ggJv6Dm
 pQ5erKE1IIX/WfK/vo4YUENYlsvs84fq+4XdNKgjSBO2TOA3/cRN2GQ9Lr4ZybpLsfn22wYzzuk
 T2p3TdUPuH1iIzAjXSjoL4mlOYfHDcJr2p9x0gxUHGwDR/Irx0K9/JW7YKxQZcvHxLpyfDZffMA
 kjogxlkiT88DxPI3Y3dsP/XiaLou8evmvdKYf1T9WNAoU0X/LZcLvTN6utu/+fpHOQpMfroWJLQ
 ==
X-Received: by 2002:ac8:5a0a:0:b0:517:642c:8196 with SMTP id
 d75a77b69052e-51a727a4b1emr225934711cf.12.1782739115002; 
 Mon, 29 Jun 2026 06:18:35 -0700 (PDT)
X-Received: by 2002:ac8:5a0a:0:b0:517:642c:8196 with SMTP id
 d75a77b69052e-51a727a4b1emr225934301cf.12.1782739114581; 
 Mon, 29 Jun 2026 06:18:34 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ef0f2b9df0sm56744616d6.13.2026.06.29.06.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:18:34 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 21:16:43 +0800
Subject: [PATCH v5 25/25] drm/msm/dp: add HPD callback for dp MST
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-msm-dp-mst-v5-25-1d882d9012f4@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
In-Reply-To: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782738985; l=5643;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=b+G2f0mUuFh+XGa6ykrKQSB0dIdAdRaLzVWlRhztVIc=;
 b=/ysUftwlkwW5dnv+MlBLFQT1FhdJW9svWKYgi12frkvgEp5CBGM3rkp66n2df4Th/MQJz3BjB
 X05fRQyiCvCBHu0XA/rMNNTk7h8hIrddnXSP69psQzmmbz+PNZ5DKp+
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: B_b5NBqv7aCurr5zhVxW7iEZqhTg2-8b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX8EhduUlYi+61
 x/nm1Its2irDI3FV4zmJOlb9qqNFB+nbMcK6NSbZSiwQuND7YYjldhFv3nkcgxM5aQX7lY1u6p9
 W8aHQong3aU6QESepRhd9KqTgpnIfRa+NnTGk0+hk7+X29mSCN1kaFHDSM0tYwXOyWVD4WQgIuc
 b9norSA2YRGP9w/THSiTaBaAEVocFFBBCrkn9B7EwCPUSjuvzmrNg2D/hkHSw7MhvfWhbGsWqkQ
 mxyQlFVUhpvx18NXztTY4fefyYRVs5j+tlaPp5fbioL686enXjgUj0HXrEE36fNyysDm+wr+/T5
 tVMuT8liP96quf2td5dHaiuUZMK8f0Uc8U8FtPMQVoqWJ8Mn3yFMLkVkPH6iwgaIlWutcKwPioB
 13OgK4DFqAyHio1O4FD4chD21kgWrBz/BMr/15QXcE+xe0Ly+V/R6dTvSCBL4ScIHDxT8mEVYOy
 2ZuwljLX1CW0E+Dv57Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX/bN+0M9y34iV
 C+8rrZC2DYDLACG/qlZtPGpthrYy2FQFV38wL5ppZRWseev2G1DNt2kVXl+1I0a33TBv5+bSsuS
 8MGfLD0RRraINpa6oBZKhTg1GdMA6V8=
X-Authority-Analysis: v=2.4 cv=O9UJeh9W c=1 sm=1 tr=0 ts=6a4270ab cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=cF23hRJ9h-J1zlJA4xMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: B_b5NBqv7aCurr5zhVxW7iEZqhTg2-8b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
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
 drivers/gpu/drm/msm/dp/dp_display.c | 22 ++++++++++++++----
 drivers/gpu/drm/msm/dp/dp_mst_drm.c | 46 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_mst_drm.h |  1 +
 3 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 6eac390af2e0..49a7bc5e031e 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -455,6 +455,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
 
+	if (dp->plugged && dp->msm_dp_display.mst_active)
+		return 0;
+
 	guard(mutex)(&dp->plugged_lock);
 
 	ret = pm_runtime_resume_and_get(&pdev->dev);
@@ -550,12 +553,18 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
 {
 	u32 sink_request;
 	int rc = 0;
+	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
 	/* irq_hpd can happen at either connected or disconnected state */
 	drm_dbg_dp(dp->drm_dev, "Before, type=%d, sink_count=%d\n",
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
 
+	if (msm_dp_display->mst_active) {
+		msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);
+		return 0;
+	}
+
 	/* check for any test request issued by sink */
 	rc = msm_dp_link_process_request(dp->link);
 	if (!rc) {
@@ -1111,9 +1120,13 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
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
 
@@ -1776,7 +1789,8 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 			msm_dp_hpd_plug_handle(dp);
 		}
 	} else {
-		msm_dp_hpd_unplug_handle(dp);
+		if (hpd_link_status == ISR_DISCONNECTED)
+			msm_dp_hpd_unplug_handle(dp);
 	}
 
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
index 12b47a413793..56f7a84e77d1 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -36,6 +36,8 @@ struct msm_dp_mst {
 	struct drm_dp_aux *dp_aux;
 	u32 max_streams;
 	struct mutex mst_lock;
+	/* Serializes HPD IRQ handling between IRQ handler and poll_hpd_irq. */
+	struct mutex hpd_irq_lock;
 	struct msm_dp_link_info link_info;
 };
 
@@ -288,6 +290,41 @@ int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
 	return rc;
 }
 
+void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display)
+{
+	int rc;
+	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
+	u8 ack[8] = {};
+	u8 esi[4];
+	unsigned int esi_res = DP_SINK_COUNT_ESI + 1;
+	bool handled;
+
+	guard(mutex)(&mst->hpd_irq_lock);
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
@@ -502,8 +539,16 @@ msm_dp_mst_add_connector(struct drm_dp_mst_topology_mgr *mgr,
 	return NULL;
 }
 
+static void msm_dp_mst_poll_hpd_irq(struct drm_dp_mst_topology_mgr *mgr)
+{
+	struct msm_dp_mst *mst = container_of(mgr, struct msm_dp_mst, mst_mgr);
+
+	msm_dp_mst_display_hpd_irq(mst->msm_dp);
+}
+
 static const struct drm_dp_mst_topology_cbs msm_dp_mst_drm_cbs = {
 	.add_connector = msm_dp_mst_add_connector,
+	.poll_hpd_irq  = msm_dp_mst_poll_hpd_irq,
 };
 
 int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux)
@@ -532,6 +577,7 @@ int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_au
 	}
 
 	mutex_init(&mst->mst_lock);
+	mutex_init(&mst->hpd_irq_lock);
 	dp_display->msm_dp_mst = mst;
 	return 0;
 }
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

