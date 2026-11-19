Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B02606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pp1J00u9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DV9ouuJf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EF3711216D;
	Thu, 19 Nov 2026 08:26:44 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBD50112160
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:18 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6vRpo2671956
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4eVE8ncFYWRc1l8YtvIlOlgRd2mH+LH7ZL0TkktaXXE=; b=Pp1J00u9fA8SJCDx
 ggblVMUXKNxb8ybWFKYkzggI3UNVukysf7YCkcnJ08vZezSGm/6NVqp/6+tBbjAQ
 uAK65K+9mhHzt1a9weB5fjp/OvaOtcFIMKHdQMJeU9lMA+6MEXWY1A1HoJQwN2C/
 ODnMrlRQnm43kGsHZsemrWT4d7hLHnXKom1JhlR7Ljsas86yllhP4LkDwDJHiQqq
 BlFdunlRFLXbFzoyz1mVpT8mMLfZGcsnB025N5NLwkr6XHVQNO9gJrNT1dGiMIxE
 kOA8FLxZxA9qkSPHkmJDBYvcsCzHGCrZi7LnIurlzMA/0YDXTgbAuzGkY28ix6ce
 9YMjrw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1g9p3fwg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9496ff065bcso294041185a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076777; x=1795681577;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4eVE8ncFYWRc1l8YtvIlOlgRd2mH+LH7ZL0TkktaXXE=;
 b=DV9ouuJfUjYq/Nv2kgdwozew6AoEACsIm2C5qgAE1xzL9gmMiAmkO/+QejCk7mK+7F
 plYi+Ep+7qEh8ceIg5ki5qqlzjkiFFJybocTW3uW+Fo/q+Kipc7kvSRGEAwgzOTyGMCg
 KEyr35YPm0c6BF3ceDHQZZDwDw09syg/6ULxw41lIlcosTaVNrJ3/28RnWH+uh4FVkrI
 lIb4n3PvMrnWw5PuKI1E9OznmhWUTHs52JYgY2cCi7Q50Lm4NqFetqXALNuSK2Zs/pIx
 q0m1YoYbBAuGN79Hn0P4ER5r9ERwXO+lfsKaiuFNBsnVHsgav9W4pNZrpktIwh3w3Zr/
 0GxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076777; x=1795681577;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4eVE8ncFYWRc1l8YtvIlOlgRd2mH+LH7ZL0TkktaXXE=;
 b=2fkG8yIZF9VMxSzzi/TDau3euli0pHZc4w1CTgNWGtlcOdZSdHkv5M/FnSMq/tU1qN
 s9mypOKTkUQPqNTiFV29kuTgEF0URBbdXzXSlYZrnxWOnZMhYeVncEDP6zpNVvRD7ONI
 ViPV1q9cwPA9h4mmS/0clqMlDBsKqsAPDXyw6Nno73yCm87Na2DwWu+CAxHDVngGqYZp
 oBh1sfUgAEkAINV/FhFJY1qkqIk4IJxbZFCL1gOcnLQ9OVsQZg0Jg+tv4QnP/5if155B
 M1Ov0XWZi8cDAV3IKcfAwHLW72KZhpL+Aljv6GoSSMw3n7PVetUAR2CnRGMCGv6bCyEt
 +D9g==
X-Forwarded-Encrypted: i=1;
 AL+hErFYh+TKbSXV9wlqrEI7XRquw6K+eGEa/GlGxut7V2iKfMQvqSA5u6eH+DawSoDX9xkBd7Okff2kSZY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z89zVwV/m6lqdaFQpLNaZf93hWGRySAjGrE+4H7aZCkm2m95BHS
 npeIEsf+PEsSjaRNTGrq/WhtAwVK771nBcTMiQSgTsLx0itpx6KPVsAYiiuLItcMq/UG3RXavig
 SYvt7h3X3Cs7BMv8Rf9Z5Xw4jSmWTQZH3pLxP6ndaVHO7XvXoAsSXCgO06DFGP3HFvXqL/s4=
X-Gm-Gg: AYBFou0vpmEqXFLwXyDHF0FoPPVaILgSTFkVaSXOQP0Dn+IfXwuaOW9hwc4GKsc8GHc
 qD1ul6ZEK6j6/th6Fnna9xnBw38IRttt6/ih+InHw1YEu0oUhEV2wxpC8HI2gyKOT3pDSZXFgzY
 7lJQ0WZ1eIKAUFQotnkoj+FDdsgaOOt3lRouW5VZnS8WkV0m81wmvBjSIsv0N7BY31/M9Z0wGra
 HFj3EZFYm7mLzfO3Fzc5dda7VIVhF7b4k8TsBNopGzIXeYn79xLnVGhMTo7truNQXSmpKu3Nrki
 A2satG/rqAtTYiezUdJKwtxqBv2zGJ6U9M3b6IBYwpf92F8B7Mmp+9hAT60BiuQdbkAKKdTqpha
 kcaeoBiRoK5NljL1dT2Hr4tNMWP6e37oIwlPWGXIzhEn6jvLeuQ484kDZPVsUKsM+v5nrQmXL3C
 +jA7Sksy5YVuZRPpuO+vLTE7nc6R3xYenMFI52
X-Received: by 2002:a05:620a:4110:b0:93e:e425:22b3 with SMTP id
 af79cd13be357-9499965853fmr934791985a.82.1795076777158; 
 Thu, 19 Nov 2026 00:26:17 -0800 (PST)
X-Received: by 2002:a05:620a:4110:b0:93e:e425:22b3 with SMTP id
 af79cd13be357-9499965853fmr934789985a.82.1795076776624; 
 Thu, 19 Nov 2026 00:26:16 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:26:16 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:23 +0800
Subject: [PATCH v9 21/29] drm/msm/dp: add HPD callback for dp MST
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-21-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
In-Reply-To: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=6603;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=JfZ1P2UeAniFbd+VES9wo/hKrnJLS0BWlRsQ//HuhC8=;
 b=ychOUgCzF83lMbRTysKJ5BunX/yDYM7zPWhrIhx/lngZLovadmrVpwMhmJ1tXkQqHtvbq9vjR
 bsf5eFIZ9ygDcW0X6NNJhNiTqg14usueO7O2oL5ntKzLV061KNf3xc8
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: yZSfMVIC8ZHY8YlkZ7jygL2y0ZAmt7fc
X-Authority-Analysis: v=2.4 cv=LooHWXdc c=1 sm=1 tr=0 ts=6afeb2a9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=TC7KtrVTTV83HWuqwI4A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX1tD47EF4OMpn
 WBJqFvF1+mRFeDzTGrWT6VAdHUtjFf6D9lpoAMvmbHoiQozbal1+VuLf2yW3UEYHeMMEh+kEFGx
 +HTWYJMJuwfqb/SdYegdIqHxGtD968HpkgdMGkO7T4b7Uxl5ByHT5BsuZUoF7/hv5NKl3qvX0Vv
 OdLfkUaZID3cSZVJMKmxi1fWa+pIsMOaCP+6osIFpfKC70+a8WSjhrK2Zwv/YbbVKmNPYVbA6lM
 IiQ13Ff8Q0HNkpCceNHp0KyRa1KLNoodMu1DwjkXBIrtxBrQ/qPaXnUJwACqdO522osynpaWmSZ
 MO6lVQGs6Y8U7sqNzryjt9xnOMTe3twEFnL8c67wxZ3doYzp9aS/+HfDSxkLQLXy3RWMrsdI7Wn
 3Klnpr4A8qRjWDtMY0T7ZMBchE02UJQ8PCVPhbIvX2WkVIbkY4TGyob9TuPkIAy0grZshdBwPRy
 ek976dyIRP4zyhoqSzQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX0De3O+VFs6fi
 UNRn/EDoVZIrOgBUZuc24zRxp+GrC5KcQM7plkjlJ1nWvr5lEQYciljlCOGQ+wQrL6lBW9jgWLA
 7g+o3PV8nY8q4oJdtk0Jwux9LTT5JBM=
X-Proofpoint-GUID: yZSfMVIC8ZHY8YlkZ7jygL2y0ZAmt7fc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190033
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
index 7bf24cd2bae2..75eaf739b86f 100644
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

