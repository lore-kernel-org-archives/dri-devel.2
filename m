Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D527160A6F43
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MBB5LUTx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GovDZtEr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20D2310EDBA;
	Tue, 10 Nov 2026 04:56:30 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 027BC10EDBA
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:17 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4A5Mi2275468
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gcJuLk0l3ec0GmBsp4PXj2UGdG/pl7qEEqNuXIeXQ28=; b=MBB5LUTxDSpMGfFt
 bhAhq3ZXNGAjYsd8Evh7dk8mzCnoMqkQNbHS3jbyd+QpiXfjW7Pddv8EjTYv08S8
 lia1DnQBOw89cjcOBClz6+lOk/PBfFrjykHYjxq3fGRqIKuHwhhM5oUnv3T6XDj1
 TVjgG61ZjJdW3Ho8lBuXtx5OB+alqifQ3/DdoCymhDI8ZwEPX1HIJ9nD8B+PjSHV
 dSZRTeJiEt7LgBF0/tpdcBVOp9j20wpLqy7u8yTlqrVb3ElFVSCX3KwEVXW6jHbY
 OV5N0PHuuzM4Bdgi/T476yAdDOcBqpyzSdlBYIrX/PFcONpoNBbh1p91gT8xbXrZ
 whbuYQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudf5bh0p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb93c874bso344545885a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286576; x=1794891376;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gcJuLk0l3ec0GmBsp4PXj2UGdG/pl7qEEqNuXIeXQ28=;
 b=GovDZtEr8fKbJOca/Wy/LGdSuIG/3OaI7rU6JOoGoO+Zc5bHYT97e2OpdKdVKkArgN
 ERbmCw/6x+gsFWMuWiWGslw9vRK1+J/B2ziAWWFYL1yXsKqXS3flCxSZSZM7S97WcmFd
 O8xwwRKxZR2dyCvAg/v+Gdg/QGEU20zCHWpMN36wZg4HjakWbWV1Fy49RdLPg+7eX4xC
 jXsQvQUZkACHpBbrTFERuL2vXIEqmEKhL9YZDeAGUEiPX6Jopt01K5I2t+4cst0veLFs
 HIyQjs28oj098qDEMmtQkrRwsURTMS2QxYVO3WyLWOQoTu1f7xMgGPAJbI+exvKDxlr/
 ZPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286576; x=1794891376;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gcJuLk0l3ec0GmBsp4PXj2UGdG/pl7qEEqNuXIeXQ28=;
 b=KS198DxQSkGsH5Qf1/ZA/a5J76MAEc8cUeeOlW6uyEg2kFkXSyGl1w0pvnbRxoRWVj
 YqAXrhuVumuS6v5+T6S+eMK4e6hzpB/ipT0vwpDxj3SG7iL6jYC7FYYfI8uESGlX1i1v
 +f6SziCFtjBcq6tk7fVOF3QbYcQIf8vBQbekIEhvfE+ODM3Llpb038Wdza+sPgrTi8XQ
 qqVIEcOVa5fq1AWL7Rq6Vpj7nSqyNhvfdN2mO3Usp3nyDj4kB74weDBW3HXyz/D/e/Zl
 B4T2btfZhuxLQTToc+VejuMknexCQ5Qzd/p3bZWOKtBptzDlX5plSgbXvNlRvg02hk0x
 sZ6g==
X-Forwarded-Encrypted: i=1;
 AL+hErHM5G5t7RskGEsdE7fHiZuHxOj8UepzaGi8Pryn19Reu1m7O7TPEv5MtYkKCc/IoFtfGQ+pYDDEOJw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+7QHTf6+BP3Qy7my8khS9uJCzECHjJFTgkbQiOrNmsnJUZWzZr
 WPjg7/R3tU4Y14EsgThu0d1qAePYSyxhL3vSMmG3zA8/DRrZ+5TA+x+RJsZQ+Fy65tmG45Wo1Jo
 sarM5hV94L9hTXZ/ji88TFd8bEyUSL+A1bjZd97XIX+1Bv8jqtnA4HccnkDJBIoaHkuxFxt8=
X-Gm-Gg: AYBFou2qUy+yo6U/IAsl6s2oxjTOwzUn/JP/mksTnED+LYAooLHmrnMJALI9nhrSJkq
 P1tG/ICzGo2xtC5UYNDQ0BDzPuUGQ4hZSn3DGa0lraw3uloH4J5adjhTMxrEBHD08oI5JWO1LPL
 bmgnXsqD7QRin9b25AQ5y6ejnm77u861WU5PfuJDyfPOXUhwPnnqyjPc/0kUYdigjUz28NZGDV8
 Isvhkp8e/KT/M483/Dg8q1sPzNYsdxNou9qL1AgMBzYrCt6qwrnU8JndYoVQ6M7nVHT4sNhUe9q
 l/uRtEWHepYAcucT3meKoDiOBWIdnS0qev3Pik6Amrp+BYyBgkZuiXMp0FqL+hY7aLTNg1sVHwG
 2h0LtMKEGe+5J6NQEtI+1w3vR3aJ23WFnHr0Hu/4ejtYK0VKd8AtbVejVQFxmtMTej1vXWjKxkr
 7q9e/vjyIyy1nMxgpfVAglJr85D0bvUIywa2Ot
X-Received: by 2002:a05:620a:640d:b0:93e:95ce:5394 with SMTP id
 af79cd13be357-9479f315948mr221650885a.2.1794286576344; 
 Mon, 09 Nov 2026 20:56:16 -0800 (PST)
X-Received: by 2002:a05:620a:640d:b0:93e:95ce:5394 with SMTP id
 af79cd13be357-9479f315948mr221648685a.2.1794286575881; 
 Mon, 09 Nov 2026 20:56:15 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:56:15 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:42 +0800
Subject: [PATCH v8 21/29] drm/msm/dp: add HPD callback for dp MST
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-21-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
In-Reply-To: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=6603;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=ajtVF3560HpCRMYYVeGWs70pSZiQqv0MSipxC58fLeM=;
 b=9R22Jtrw/AVyh/2i2/V+LyBwNBPy/SylEqC5wtvEeUtlcJjgqotClGKLkDnzMct2Df0kxSHm4
 cGnPxjPv0BiBU6MJCOz9CIykj77EQwe//Q8oUFXKHf8tfStcP8rcXTB
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: xr8vRPEgkaQhPpU9X3Qp4rBW8WrZ4WJo
X-Proofpoint-GUID: xr8vRPEgkaQhPpU9X3Qp4rBW8WrZ4WJo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX4lE43UhgKsZJ
 nVJu8XHsN37v18GW8m7bxZ/IUBUqbHPlRJndcD45JQgf/uNbs36qoPA1a7FfFaFH3VBDgtYqR76
 vth1qMHepNXykAPWqVsbRkwE6h0ZBMw=
X-Authority-Analysis: v=2.4 cv=bar+w+PB c=1 sm=1 tr=0 ts=6af2a3f0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=TC7KtrVTTV83HWuqwI4A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX7TUqXWZjotuo
 cfHjwvMo20uHkV87SIXWtHAxTDVP7VEJMiT5DV3L0KnZ2/quvNoMkCduyHiW4fxoUfKlXmEkZWH
 EGoCQjoGPJ4pixposPRgfb1qq7bUfHLYIIGsG6cPwGkZqay8DTu/ltFVTL+aGrdl5YMdZqLMDB8
 NwGA4WkjsKNG7DZXnYnyg9RojNDQ7Nb8/R7VwoKbIYVsbJALEug786WskVW8CLzAqj20Hh5DAOb
 QE7b+YNuAp1Bwyq9rTp0dz6WVtTbw0opz5jbYfqcrl0cYDKtDrfjuJ4Wej/w7dpzQ1ZtuicZIZb
 pAAB3RiMaPHGItGRHXEAP7CXEDHFt9XTTQH/jy2/6FxDtABAZ1kmULGG/2KcO4jMoPRVqaCHXtS
 bsPHW24+aSAimrEd0eXG+ofhbAVRNYzNSL4iJ7KpsX8YoRr7Lcy2LRdaGH8gu5zxaVGpUeZnq/p
 Scc7r/LsGsrPCD7Zhag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100019
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Add HPD callback for the MST module which shall be invoked from the
dp_display's HPD handler to perform MST specific operations in case
of HPD. In MST case, route the HPD messages to MST module.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 21 ++++++++++++----
 drivers/gpu/drm/msm/dp/dp_mst_drm.c | 48 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_mst_drm.h |  1 +
 3 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index af8d22fd4fc5..b4e788d1f611 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -529,6 +529,11 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
 
+	if (dp->msm_dp_display.mst_active) {
+		msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);
+		return 0;
+	}
+
 	/* check for any test request issued by sink */
 	rc = msm_dp_link_process_request(dp->link);
 	if (!rc) {
@@ -1078,10 +1083,10 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
 		drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
 				      connector_status_connected);
 
-	/* Send HPD as connected and distinguish it in the notifier */
 	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
-		drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
-				      connector_status_connected);
+		drm_bridge_hpd_notify_extra(dp->msm_dp_display.bridge,
+					    connector_status_connected,
+					    DRM_CONNECTOR_DP_IRQ_HPD);
 
 	ret = IRQ_HANDLED;
 
@@ -1318,9 +1323,15 @@ int msm_dp_mst_register(struct msm_dp *msm_dp_display)
 
 void msm_dp_mst_unregister(struct msm_dp *msm_dp_display)
 {
+	struct msm_dp_display_private *dp;
+
 	if (!msm_dp_display->msm_dp_mst)
 		return;
 
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	/* HPD is disabled by drm_kms_helper_poll_fini() before KMS teardown. */
+	synchronize_irq(dp->irq);
 	msm_dp_mst_mgr_destroy(msm_dp_display);
 }
 
@@ -1755,7 +1766,7 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(bridge);
 	struct msm_dp *msm_dp_display = msm_dp_bridge->msm_dp_display;
 	struct msm_dp_display_private *dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
-	u32 hpd_link_status = 0;
+	u32 hpd_link_status;
 
 	if (pm_runtime_resume_and_get(&msm_dp_display->pdev->dev)) {
 		DRM_ERROR("failed to pm_runtime_resume\n");
@@ -1778,7 +1789,7 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 		if (hpd_link_status == ISR_IRQ_HPD_PULSE_COUNT ||
 		    event == DRM_CONNECTOR_DP_IRQ_HPD)
 			msm_dp_irq_hpd_handle(dp);
-	} else {
+	} else if (status == connector_status_disconnected) {
 		msm_dp_hpd_unplug_handle(dp);
 	}
 
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
index eae82e857c84..15405080107f 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -15,6 +15,8 @@
 #define to_dp_mst_connector(x) \
 		container_of((x), struct msm_dp_mst_connector, connector)
 
+#define MSM_DP_MST_HPD_IRQ_MAX_TRIES 30
+
 struct msm_dp_mst_connector {
 	struct drm_connector connector;
 	struct drm_dp_mst_port *mst_port;
@@ -36,6 +38,8 @@ struct msm_dp_mst {
 	u32 max_streams;
 	/* Serializes concurrent stream link-state access across streams. */
 	struct mutex mst_lock;
+	/* Serializes HPD IRQ handling between IRQ handler and poll_hpd_irq. */
+	struct mutex hpd_irq_lock;
 };
 
 static void dp_mst_connector_destroy(struct drm_connector *connector)
@@ -358,6 +362,40 @@ int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, unsigned int stream_id,
 	return 0;
 }
 
+void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display)
+{
+	int rc;
+	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
+	unsigned int esi_res = DP_SINK_COUNT_ESI + 1;
+	int i;
+
+	guard(mutex)(&mst->hpd_irq_lock);
+
+	for (i = 0; i < MSM_DP_MST_HPD_IRQ_MAX_TRIES; i++) {
+		u8 ack[8] = {};
+		u8 esi[4];
+		bool handled;
+
+		rc = drm_dp_dpcd_read_data(mst->dp_aux, DP_SINK_COUNT_ESI, esi, 4);
+		if (rc < 0) {
+			DRM_ERROR("DPCD sink status read failed, rlen=%d\n", rc);
+			return;
+		}
+
+		rc = drm_dp_mst_hpd_irq_handle_event(&mst->mst_mgr, esi, ack, &handled);
+		if (!handled)
+			break;
+
+		rc = drm_dp_dpcd_write_byte(mst->dp_aux, esi_res, ack[1]);
+		if (rc < 0) {
+			DRM_ERROR("DPCD esi_res failed. rc=%d\n", rc);
+			return;
+		}
+
+		drm_dp_mst_hpd_irq_send_new_request(&mst->mst_mgr);
+	}
+}
+
 static struct drm_encoder *
 msm_dp_mst_atomic_best_encoder(struct drm_connector *connector, struct drm_atomic_commit *state)
 {
@@ -473,8 +511,16 @@ msm_dp_mst_add_connector(struct drm_dp_mst_topology_mgr *mgr,
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
 
 int msm_dp_mst_mgr_init(struct msm_dp *dp_display, struct msm_dp_link *link,
@@ -506,6 +552,7 @@ int msm_dp_mst_mgr_init(struct msm_dp *dp_display, struct msm_dp_link *link,
 	}
 
 	mutex_init(&mst->mst_lock);
+	mutex_init(&mst->hpd_irq_lock);
 	dp_display->msm_dp_mst = mst;
 	return 0;
 }
@@ -518,6 +565,7 @@ void msm_dp_mst_mgr_destroy(struct msm_dp *dp_display)
 		return;
 
 	drm_dp_mst_topology_mgr_destroy(&mst->mst_mgr);
+	mutex_destroy(&mst->hpd_irq_lock);
 	mutex_destroy(&mst->mst_lock);
 	dp_display->msm_dp_mst = NULL;
 	kfree(mst);
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
index 822d34cd6ff5..3bd3e66b4eac 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
@@ -12,5 +12,6 @@ int msm_dp_mst_mgr_init(struct msm_dp *dp_display, struct msm_dp_link *link,
 void msm_dp_mst_mgr_destroy(struct msm_dp *dp_display);
 int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, unsigned int stream_id,
 			      struct drm_encoder *encoder);
+void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display);
 
 #endif /* _DP_MST_DRM_H_ */

-- 
2.43.0

