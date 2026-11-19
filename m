Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A687606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m96NYnez;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PMjOPQLa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CCBC112154;
	Thu, 19 Nov 2026 08:25:59 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62CF7112133
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:24 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6vQAa2671922
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2NQQJCUCKgk3YATCqxgYTShGgTKSy0xN+5ygLCnYwnw=; b=m96NYnez1sZID3NH
 owVsgQARhDZexVeTLT7jeEuE2hQUUD0tRJ1kG07Nwg+WKankeYhQgESHj3dP6NwJ
 Rh3GkOZcC4UBoco7VD3WWUiacuUDx2G2NIwW91TGjK/f9YtHWuJWTTS+/JCJlth0
 23cSpBb3ZxaDuixuISNGRVua6GWeGP5gjJqM3gIfctib8R2qSLdAG0DPyrMdOEro
 u0FP4yJBD3QN8UFO1/SLDqWFDTLW3DXOwY72Eo0az6FC/A6w0AnY3+xKvuklHLFO
 pYjjeJ6gvoBKhbp5ch0JgAjKz0ysdiBxfWm8fm3zjlglOCVx6Jx35YllLz+t5A/N
 EESYvQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1g9p3frh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:23 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9495dd0f07eso393205385a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076722; x=1795681522;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2NQQJCUCKgk3YATCqxgYTShGgTKSy0xN+5ygLCnYwnw=;
 b=PMjOPQLai69lrnY4L5Q+XHpveLfebWWk9qN2sCKfsnWDIa5CGhN0Z0SRVUhAuer/T5
 NWVZmzE4pjLL4zO4jQ3M+xzDFwaa82P8KFts2RU4a/GigasvQKmWyZ+ZGQU6Ck6DL9dA
 NO7/lJ1ZoB6SeCHOHnYGoO1u3tVmJHnZxpa4VPNxddTutSOaYbdnS+2LDBZzQJur69su
 p6GnDOiNo9HFAGscseBaBHLaQzFk9c6L+4hvZjA8kTmrKovmhAed2nOwaRgP8NUVpDyv
 H4nJbJTRQhH/QuSBh34M7uMNdzjLfs1wDNny/ADLjzAF4UGJ2fxbehSVjJ6aFpkglu6Y
 QP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076722; x=1795681522;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2NQQJCUCKgk3YATCqxgYTShGgTKSy0xN+5ygLCnYwnw=;
 b=G61V92bz/Q1uVp0jBxDq2eRRS2PeqkE6DAZlweTbcmAxXmpny2MilPFgCAc+9q4QP7
 oeQYDeGvPjT+I9edvPNMVXRx3kQKoB4XtArSf+4kPE/ZCq1hYwYGIxcwGKgdRxPT/07Y
 IB0jJDYQAZf+FSnWIf9BReyIPb7SAif9n3VghSd0ECzAOa39SpfDkiAf9wbL0suRsyDe
 lG7CrKHC/AyhrPLf+EnOpcZvYJ1WRY66nhJDciIRWuv35suuFFuvbf8GsH7RlEk7ZDsk
 H0XHBSRhIve1ZDT1/sulFs2diB/3hJB0Okpzkv+PdB6TaLUyNf0/E5y/kx9FjAAOT2XF
 rQsw==
X-Forwarded-Encrypted: i=1;
 AL+hErGx/r1dk4PVebZtWNmuLN0/QKS5t+TYCyIvIqsImKXZGG+kUfxM2n9uW8LLBKjTeCCI3+QG3RSuDgE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/t9Rcvy+uSNh8G5dvS3wiaxUAWCrLXbqGXT76ZHAIr0QrjqJba
 +GPPLTVMqWwMZzGfWz4wANRBef0ZAhdZyglP9SSTuk/epVGjeZPNiS4TscNUJep2bytqIWwG0kP
 WArd9aIHwXneQz+9MfT3lguuPBWjjyhBMV1pZJcfSR+7eCbc1An1P3smSIS9fINInNPWPBHq9YN
 L9TO2Jxw==
X-Gm-Gg: AYBFou1aKR/HSBeTMXMyaKwl3ebXToMicc4s26z7dc0+cbBgs9nkHvydVBTEav8/uUm
 OrFGbYe0wYAanmOxuJeS9bYW1pfxwobAk8S5BocAiYQPhM1X9RqX/ym4YwjOVZzo87EaqkxjQUy
 YOdaFIABaPGOa+LUGsfqzi6oicKtX6tEXIxxFnIWC4zn/HgLUw6nx9PZoeL476D3DB/L/9guqzM
 Edz74r+ACMQy6QYnKVZ7Wt+kE+KT3bYkI4Y6prnwWwtb6a5DNqCxRDI79nX8BkHsom7TSq3IXqx
 Re04Wo3bNfa1OMoObUps73s6Z+10EceYV1i8vT3O8PB8ITVm7ASjBunzdT2TAm4dEa1p3v70Cre
 dRZlc+91lbC6nReNVJN+cbTaGohux1q33j9vqwRd1pG8E0Y3AB2vyBQ0UeD1aZXY0iRwdErr8dJ
 Xbl7Xc7DhDzhqastXOCmQMJKQRc+wqezNEu0d5
X-Received: by 2002:a05:620a:6301:10b0:949:ad9a:c076 with SMTP id
 af79cd13be357-949ad9ac1demr127396385a.82.1795076722501; 
 Thu, 19 Nov 2026 00:25:22 -0800 (PST)
X-Received: by 2002:a05:620a:6301:10b0:949:ad9a:c076 with SMTP id
 af79cd13be357-949ad9ac1demr127394785a.82.1795076721924; 
 Thu, 19 Nov 2026 00:25:21 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:25:21 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:12 +0800
Subject: [PATCH v9 10/29] drm/msm/dp: add link_ready to manage link-level
 operations
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-10-ca61be4edfc3@oss.qualcomm.com>
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
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=4145;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=lHXbJUjnv0+TY2wsZf5fppD8DzUXiA1zsh8PozRg+aE=;
 b=IbmTIzgusdeBavxDHQ2ePQOSARduXUVYH8ZH+82pZ1ZU0eN6CEwr6b3Y1FTJtCMNv/sFlag0B
 /MHt6gFNVvODvCZrZ+jftuNd5Y1hYVtHu97/OVIxNod5oZAyhcl4hpW
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: Lp-REFiTLKhiuT6T858HlkTccMWe42R0
X-Authority-Analysis: v=2.4 cv=LooHWXdc c=1 sm=1 tr=0 ts=6afeb273 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=EJHzXNQmAnllz_DQdb0A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX793Oz4mtohqp
 eXAzBFuhRK0hsTSqLPXBVf7diVAAnDai+o76Yx36GfuuuiCsCpUaZ2QUeO0pg5FduJV9LM00wgK
 X4IXTg+kOtbDkuT1pXPV7t24kTO262GaHi1zwZsVeP1ZnLSdAR7BRTApVwY47dr5LwPX5pfsnhS
 UiQx/ouLSazehzSuR5hZ+sowSUg9PHIv06METNhaJ/SjStKNBaOkGEGyfk95lIn2vl00WqTO8Pi
 OxxMdflYkywv5GDf1q5g6DAH6mSLz/UJ7O2xOllV+GlR+j0TRV+5JLi78xfdbrKV3ffXp2L24r3
 0mvbsZ/GXD7Hu36fcTOMlQxDWKtNmeWMr0MtULVi3J+Shh1JAVbjv40jt7akKjgsJbSqEEaGcnP
 pahQZRcw6VnOC70t1dR0vy3E4TAyPC9YGZBjPoVB2fjpvQC4IhazGQQQpqPFGCuOjGuYQsVicby
 1ehDxQ9ArUdEycGy6tA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX7rxbbHoD2GXZ
 bmodyagu9+t99n+jzl3v5bn00EAS4QQFkSYaiB6M5kuNeBKzS9Zo1PtGaRIZISZLXJw5g+7NwIl
 NuH9KM83PkeJhCsmqWSbwO0sxtH+9zk=
X-Proofpoint-GUID: Lp-REFiTLKhiuT6T858HlkTccMWe42R0
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

In MST mode, multiple streams share the same DP link. Track a link_ready
state so msm_dp_display_prepare_link() runs only once per link and
repeated calls are skipped.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 48 +++++++++++++++++++++++++++----------
 drivers/gpu/drm/msm/dp/dp_display.h |  1 +
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 471085744c7c..544b76e2c6f6 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -645,15 +645,19 @@ int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display)
 	if (msm_dp_display->is_edp)
 		msm_dp_hpd_plug_handle(dp);
 
+	/* Serialized by modeset lock or mst_lock. */
+	if (msm_dp_display->link_ready)
+		return 0;
+
+	if (dp->link->sink_count == 0)
+		return -ENOTCONN;
+
 	rc = pm_runtime_resume_and_get(&msm_dp_display->pdev->dev);
 	if (rc) {
 		DRM_ERROR("failed to pm_runtime_resume\n");
 		return rc;
 	}
 
-	if (dp->link->sink_count == 0)
-		return -ENOTCONN;
-
 	if (!msm_dp_display->active_stream_mask) {
 		msm_dp_display_host_phy_init(dp);
 		force_link_train = true;
@@ -662,11 +666,22 @@ int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display)
 		if (rc) {
 			DRM_ERROR("Failed link training (rc=%d)\n", rc);
 			// TODO: schedule drm_connector_set_link_status_property()
-			return rc;
+			goto err_pm_put;
 		}
 	}
 
-	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
+	rc = msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
+	if (rc)
+		goto err_pm_put;
+
+	msm_dp_display->link_ready = true;
+
+	return 0;
+
+err_pm_put:
+	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
+
+	return rc;
 }
 
 static int msm_dp_display_enable(struct msm_dp_display_private *dp,
@@ -1504,14 +1519,16 @@ void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display,
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	rc = msm_dp_display_enable(dp, msm_dp_panel, slots);
-	if (rc)
-		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
+	if (msm_dp_display->link_ready) {
+		rc = msm_dp_display_enable(dp, msm_dp_panel, slots);
+		if (rc)
+			DRM_ERROR("DP display enable failed, rc=%d\n", rc);
 
-	rc = msm_dp_display_post_enable(msm_dp_display);
-	if (rc) {
-		DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
-		msm_dp_display_disable(dp, msm_dp_panel);
+		rc = msm_dp_display_post_enable(msm_dp_display);
+		if (rc) {
+			DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
+			msm_dp_display_disable(dp, msm_dp_panel);
+		}
 	}
 
 	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
@@ -1570,6 +1587,11 @@ void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
+	if (!msm_dp_display->link_ready) {
+		drm_dbg_dp(dp->drm_dev, "Link already disabled, return\n");
+		return;
+	}
+
 	if (msm_dp_display->active_stream_mask) {
 		drm_dbg_dp(dp->drm_dev, "stream still active, return\n");
 		return;
@@ -1588,6 +1610,8 @@ void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
 		msm_dp_display_host_phy_exit(dp);
 
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
+
+	msm_dp_display->link_ready = false;
 }
 
 void msm_dp_display_atomic_post_disable_helper(struct msm_dp *dp, struct msm_dp_panel *msm_dp_panel)
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index f6ebb3d409cf..b0b7570cb16c 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -20,6 +20,7 @@ struct msm_dp {
 	bool audio_enabled;
 	u32 active_stream_mask;
 	bool mst_active;
+	bool link_ready;
 	unsigned int connector_type;
 	bool is_edp;
 

-- 
2.43.0

