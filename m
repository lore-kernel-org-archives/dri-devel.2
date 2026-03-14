Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53785107BCEE
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 01:09:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABD3610ECE4;
	Sat, 14 Mar 2026 01:09:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JUC8pgl4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e7S6o8OM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D35E910ECE4
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:45 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DJnq8c2528208
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2UrDrn2pfKZTOmcACEWoN/bHKLN3H9Y3BpTX9LllKAY=; b=JUC8pgl4FCzZ7KRs
 nw87nrW3tkrEMfv7lc+oUnPQ0qzlwdJ7nFBtSyqvlRqk4gApfDmFJs+XQh0Oy4qf
 eoGyNm/DMZWESe7QsSp6IgPNIKp+WVilqxb+hSQzMR4Y8XN79TqVSVZ2269QBs/T
 ly237lzgPgAvgBnGQJmDXjRa4qAhe0IdFxSj6y5+ntSIzXHgD/1dkiFHLdlOUyE4
 C1UwYGXQ4wBwJGkoMXpec3LjkK7pFQ32hdWcQsvTOTw+jYek016ETCNp4n1H2qrQ
 8qnj9rl1aYJRdt3gZh5i9bXyYVEi14EpHUVt43wGi4GiGISqfOB5ixrEuKV+2VqL
 RuVncQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvdnt3csp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:45 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cd781c0d90so2066347485a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 18:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773450584; x=1774055384;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2UrDrn2pfKZTOmcACEWoN/bHKLN3H9Y3BpTX9LllKAY=;
 b=e7S6o8OMle9J9BGO5A18S2DhrZl9afaoqo3ylxZ4IB0/YgvSwAS2H8E8bmYR8BX8JM
 ILLhAXnDgwEMayTKrgj/Nfr8sJnpoddntlQE2gCusebmjrW9XBbaK3jwsXm5Ht/Jegwy
 LKqvtaSWPP8xaoyM4H2k2UDXi1IDcGGPZsUaOGtZmdO7kOePlDRvJEG9DqQCmechW9ZN
 pIze8I6ls1cJ0oUkU0UW1Tc27rLfN8DHDnVqQ7EaYAe/wHQDp0Tt7dA2g9SxsA2z43ii
 AwmcFP/1XEKbtpu2IRYMvc1sMdsQzSBTuj39TmXkUo1ilQYhYcRjD9BfmxHBNpI64F4j
 b1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773450584; x=1774055384;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2UrDrn2pfKZTOmcACEWoN/bHKLN3H9Y3BpTX9LllKAY=;
 b=qK/wmrw90ukKfLbhyN3gKDJXrGiaJD0IuAB3WL6Kx5vgr1tOhQ1WY4uBKkZpqT6IMx
 X+6RPDTC+/EK5q0fckgkI+wftCQJKy1pYsDie8bhmyQGkOXsNMDzW36HvdCLwirJklLP
 nRrYJsN0GzEVk5JgLoGSWXcqYrObEorGcLkFfweBmluHEJJUiioDmapjAFTX2EWICfeD
 fcDOy0bNOoqfipOsZx5dkW79U+7UFUYvxI4T70jFBhNf5pnhSCP/1zKT/HsvALkv82v6
 P6+Lbe3ebFKjolorGpbFXzoPPlHu7Qhg2z6x7oQfkPkUyqD5LFTI1F/xVDOAPoMsSEC6
 bZRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRVb7T9KGnfVsJ+klHpvnnJ88x/ggyhj4dDZkF8v2/5QPydM++Ov8xQvrnMCdSPWnrVxdjn2OE7cU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzi4Ks9ErYy9BeezTJMe40GAAkKyJye3a6K+5ypCR3Tse5xz+Vc
 I8oOQNE9eihR3jG6K/HkLaJeFG3iKThoXkAaSMmDubg7fJqDrb6wsPbjOBhPqcsOYEFDiQVbSHw
 FAwEdOpzT6vDR43QG0xw4PiB2x1DGt7+P2rG1KTW+PYCvQRXP+vGSv6AV4jUgcT2OemPWY5I=
X-Gm-Gg: ATEYQzx8HzrXmwDMxkji445C6FXYbke7/TPQeJnKWh7CVNzjG/1IMhuvSadlft9N7eg
 bf3wGolnCoz83ycK0T4S+S/3Cm493dsyhw4BNq3h2nYPeSUSzSZ9OPZ6yUsblOqOzHQu4Bvvj5r
 v26rJWv8czCxY2LXvjbSjN8K+nfynmpyBxXSRoLC8DpYdJ2BjVItxN8Tu7Dw1OJJmUTX1alq2DS
 Zb2NOTbkuV19CFWe1cNI3EqjnnteL5nvHxTToPXXT1+XX3OYZdBb7X3U7uyDP/w9cdQ9WDVcmpZ
 xjIPAbwiKsygeTf/YDLp4H2xvQKjtK/yCm7zZBGlb/usoUwCqVbqKk6viLkUnI+52vLAt38v1tu
 bXYvn9VrHNnFsDqVFTlw0JsVH9cMPGgvnSLS5cL7ixRxIYqlDd5EybYOTt5f7f3zANDbf3FkF9/
 K6E+DkR0K8tO3GiQApVlwi3MKfWKzs+H+vwns=
X-Received: by 2002:a05:620a:1711:b0:8cd:9584:632a with SMTP id
 af79cd13be357-8cdaa8ab027mr1119964385a.41.1773450584130; 
 Fri, 13 Mar 2026 18:09:44 -0700 (PDT)
X-Received: by 2002:a05:620a:1711:b0:8cd:9584:632a with SMTP id
 af79cd13be357-8cdaa8ab027mr1119961685a.41.1773450583636; 
 Fri, 13 Mar 2026 18:09:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a156366b22sm1806805e87.77.2026.03.13.18.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 18:09:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 14 Mar 2026 03:09:13 +0200
Subject: [PATCH v5 09/10] drm/msm/dp: turn link_ready into plugged
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-hpd-refactor-v5-9-0c8450737d64@oss.qualcomm.com>
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
In-Reply-To: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11248;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=MDe7U9RsDHXV+2bJl632vfxF4W9rCCfL29yWTM6+O4w=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBptLU0RN/GdnZPPip1huXxiqgajf+0Hi/LOyBCs
 /hfcNeUNDGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCabS1NAAKCRCLPIo+Aiko
 1cRHCACsHIr/u4TXPlaZL/jz67bawo9+vJfuBxm1A5HZl2NfQiHH7zSFdcEi4BmLhiYIf7nta4+
 f4cdD4Mkn2AXDws1fe7ZQ4MbM5mJIWOUy6ic1Z7wjyn+9DTvp2w2vH7SQd90lu5KIoz2ouiHTKY
 NG6IMK9GU7zcR2twfvMxnEm3GTlpbbsRv9EpkPFy9aQ/XD4tRSUp54ko2YFlTDQFp8CBbj1A/JB
 2k5nAyn9tyyA4dHUfpnChWDAPNHM16w61inIY/xrHUDHlEZ0l4wnZ8Y1B3yC4eDunJyKsdQKq7o
 /DOKTXym0amNnJRf/tX+OshsmQfKxdbX6bBbel/R9PABwHI5
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=KZrfcAYD c=1 sm=1 tr=0 ts=69b4b559 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=n7_vWGaP1GUJy7dh50EA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: TZjS9b4y63ZGy1dT9GDCKcc8M0Nqhjtx
X-Proofpoint-ORIG-GUID: TZjS9b4y63ZGy1dT9GDCKcc8M0Nqhjtx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDAwNiBTYWx0ZWRfX3jUNxJ0znQda
 qTHzPtQ+5pZqB20JOKdTPKBjZnYQEHXNc+PA0UUJOXXBgJT2cgWSrAOkYVZa55rdGhVibzdsM7Z
 u9120xKV6SBJL4vZ/auSGJ3KwCXQjxS+vtMQOTmCvEDYD13Q1LSq5bOX4rxKXFmwmEVLJY5Tgxd
 T8v/NhH4qs8cbiYCCe4Y4CRCy4IQ/firmW9PDU6WYCQdkPXCFTEq+6wxKiY9rmlgiVX+u1gEYGM
 4/iYyIF1EZsGLPCWw1kRnUQPmvlxYUjDM3k5PQJ0zTX4BW5VqBfNEBffAKXO+TSnI9fCBZ+beks
 NrTyuVnInjs5h1OVl7QbHeMTEYareOSG36aHO6JXX1cdjOUcQWg+KhRhWkyL6AXXMe+mfOSDXiY
 DP0o8z7anCfipS9nRzFrPORMtOzL7jJlmzHPys5fwtwGvRiFlcBdGVO9hfRAtGiP/jRdPfXasa3
 C7kH37kJ3pxv6XHPjxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_05,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603140006
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

Tracking when the DP link is ready isn't that useful from the driver
point of view. It doesn't provide a direct information if the device
should be suspended, etc. Replace it with the 'plugged' boolean, which
is set when the driver knows that there is DPRX plugged.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 94 ++++++++++++++++++++++---------------
 drivers/gpu/drm/msm/dp/dp_display.h |  1 -
 drivers/gpu/drm/msm/dp/dp_drm.c     | 41 ++--------------
 3 files changed, 61 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index b4deeea0ec59..0a38957ea901 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -53,6 +53,9 @@ struct msm_dp_display_private {
 	bool phy_initialized;
 	bool audio_supported;
 
+	struct mutex plugged_lock;
+	bool plugged;
+
 	struct drm_device *drm_dev;
 
 	struct drm_dp_aux *aux;
@@ -284,8 +287,6 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 						 dp->panel->dpcd,
 						 dp->panel->downstream_ports);
 
-	dp->msm_dp_display.link_ready = true;
-
 	dp->msm_dp_display.psr_supported = dp->panel->psr_cap.version && psr_enabled;
 
 	dp->audio_supported = info->has_audio;
@@ -303,7 +304,7 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	return rc;
 }
 
-static void msm_dp_display_host_phy_init(struct msm_dp_display_private *dp)
+static bool msm_dp_display_host_phy_init(struct msm_dp_display_private *dp)
 {
 	drm_dbg_dp(dp->drm_dev, "type=%d core_init=%d phy_init=%d\n",
 		dp->msm_dp_display.connector_type, dp->core_initialized,
@@ -312,7 +313,10 @@ static void msm_dp_display_host_phy_init(struct msm_dp_display_private *dp)
 	if (!dp->phy_initialized) {
 		msm_dp_ctrl_phy_init(dp->ctrl);
 		dp->phy_initialized = true;
+		return true;
 	}
+
+	return false;
 }
 
 static void msm_dp_display_host_phy_exit(struct msm_dp_display_private *dp)
@@ -366,14 +370,6 @@ static int msm_dp_display_handle_irq_hpd(struct msm_dp_display_private *dp)
 	u32 sink_request = dp->link->sink_request;
 
 	drm_dbg_dp(dp->drm_dev, "%d\n", sink_request);
-	if (!dp->msm_dp_display.link_ready) {
-		if (sink_request & DP_LINK_STATUS_UPDATED) {
-			drm_dbg_dp(dp->drm_dev, "Disconnected sink_request: %d\n",
-							sink_request);
-			DRM_ERROR("Disconnected, no DP_LINK_STATUS_UPDATED\n");
-			return -EINVAL;
-		}
-	}
 
 	msm_dp_ctrl_handle_sink_request(dp->ctrl);
 
@@ -392,11 +388,11 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
 
-	if (dp->msm_dp_display.link_ready)
-		return 0;
+	mutex_lock(&dp->plugged_lock);
 
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret) {
+		mutex_unlock(&dp->plugged_lock);
 		DRM_ERROR("failed to pm_runtime_resume\n");
 		return ret;
 	}
@@ -406,18 +402,16 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 	msm_dp_display_host_phy_init(dp);
 
 	ret = msm_dp_display_process_hpd_high(dp);
-	if (ret) {	/* link train failed */
-		dp->msm_dp_display.link_ready = false;
-		msm_dp_aux_enable_xfers(dp->aux, false);
-		pm_runtime_put_sync(&pdev->dev);
-	}
 
 	drm_dbg_dp(dp->drm_dev, "After, type=%d sink_count=%d\n",
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
 
-	/* uevent will complete connection part */
-	return 0;
+	dp->plugged = true;
+
+	mutex_unlock(&dp->plugged_lock);
+
+	return ret;
 };
 
 static void msm_dp_display_handle_plugged_change(struct msm_dp *msm_dp_display,
@@ -446,8 +440,12 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
 
-	if (!dp->msm_dp_display.link_ready)
+	mutex_lock(&dp->plugged_lock);
+	if (!dp->plugged) {
+		mutex_unlock(&dp->plugged_lock);
+
 		return 0;
+	}
 
 	/* triggered by irq_hdp with sink_count = 0 */
 	if (dp->link->sink_count == 0)
@@ -463,8 +461,6 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 						 dp->panel->dpcd,
 						 dp->panel->downstream_ports);
 
-	dp->msm_dp_display.link_ready = false;
-
 	/* signal the disconnect event early to ensure proper teardown */
 	msm_dp_display_handle_plugged_change(&dp->msm_dp_display, false);
 
@@ -472,8 +468,12 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
 
-	/* uevent will complete disconnection part */
-	pm_runtime_put_sync(&pdev->dev);
+	if (dp->plugged) {
+		pm_runtime_put_sync(&pdev->dev);
+		dp->plugged = false;
+	}
+	mutex_unlock(&dp->plugged_lock);
+
 	return 0;
 }
 
@@ -820,41 +820,49 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 	int status = connector_status_disconnected;
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
 	struct drm_dp_desc desc;
+	bool phy_deinit;
 
 	dp = to_dp_bridge(bridge)->msm_dp_display;
 
 	priv = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
-	if (!dp->link_ready)
-		return status;
-
+	mutex_lock(&priv->plugged_lock);
 	ret = pm_runtime_resume_and_get(&dp->pdev->dev);
 	if (ret) {
 		DRM_ERROR("failed to pm_runtime_resume\n");
+		mutex_unlock(&priv->plugged_lock);
 		return status;
 	}
 
+	phy_deinit = msm_dp_display_host_phy_init(priv);
+
 	msm_dp_aux_enable_xfers(priv->aux, true);
 
 	ret = msm_dp_aux_is_link_connected(priv->aux);
-	if (!ret) {
+	DRM_DEBUG_DP("aux link status: %x\n", ret);
+	if (!priv->plugged && !ret) {
 		DRM_DEBUG_DP("aux not connected\n");
+		priv->plugged = false;
 		goto end;
 	}
 
 	ret = drm_dp_read_dpcd_caps(priv->aux, dpcd);
 	if (ret) {
 		DRM_DEBUG_DP("failed to read caps\n");
+		priv->plugged = false;
 		goto end;
 	}
 
 	ret = drm_dp_read_desc(priv->aux, &desc, drm_dp_is_branch(dpcd));
 	if (ret) {
 		DRM_DEBUG_DP("failed to read desc\n");
+		priv->plugged = false;
 		goto end;
 	}
 
 	status = connector_status_connected;
+	priv->plugged = true;
+
 	if (drm_dp_read_sink_count_cap(connector, dpcd, &desc)) {
 		int sink_count = drm_dp_read_sink_count(priv->aux);
 
@@ -865,7 +873,21 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 	}
 
 end:
-	pm_runtime_put_sync(&dp->pdev->dev);
+	/*
+	 * If we detected the DPRX, leave the controller on so that it doesn't
+	 * loose the state.
+	 */
+	if (!priv->plugged) {
+		if (phy_deinit) {
+			msm_dp_aux_enable_xfers(priv->aux, false);
+			msm_dp_display_host_phy_exit(priv);
+		}
+
+		pm_runtime_put_sync(&dp->pdev->dev);
+	}
+
+	mutex_unlock(&priv->plugged_lock);
+
 	return status;
 }
 
@@ -1123,6 +1145,8 @@ static int msm_dp_display_probe(struct platform_device *pdev)
 		(dp->msm_dp_display.connector_type == DRM_MODE_CONNECTOR_eDP);
 	dp->hpd_isr_status = 0;
 
+	mutex_init(&dp->plugged_lock);
+
 	rc = msm_dp_display_get_io(dp);
 	if (rc)
 		return rc;
@@ -1353,7 +1377,7 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 		return;
 	}
 
-	if (dp->link_ready && !dp->power_on) {
+	if (!dp->power_on) {
 		msm_dp_display_host_phy_init(msm_dp_display);
 		force_link_train = true;
 	}
@@ -1398,9 +1422,6 @@ void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
 	if (dp->is_edp)
 		msm_dp_hpd_unplug_handle(msm_dp_display);
 
-	if (!dp->link_ready)
-		drm_dbg_dp(dp->drm_dev, "type=%d is disconnected\n", dp->connector_type);
-
 	msm_dp_display_disable(msm_dp_display);
 
 	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", dp->connector_type);
@@ -1498,9 +1519,8 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 
 	hpd_link_status = msm_dp_aux_is_link_connected(dp->aux);
 
-	drm_dbg_dp(dp->drm_dev, "type=%d link hpd_link_status=0x%x, link_ready=%d, status=%d\n",
-		   msm_dp_display->connector_type, hpd_link_status,
-		   msm_dp_display->link_ready, status);
+	drm_dbg_dp(dp->drm_dev, "type=%d link hpd_link_status=0x%x, status=%d\n",
+		   msm_dp_display->connector_type, hpd_link_status, status);
 
 	if (status == connector_status_connected) {
 		if (hpd_link_status == ISR_HPD_REPLUG_COUNT) {
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index d2d3d61eb0b0..0b65e16c790d 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -17,7 +17,6 @@ struct msm_dp {
 	struct drm_connector *connector;
 	struct drm_bridge *next_bridge;
 	struct drm_bridge *bridge;
-	bool link_ready;
 	bool audio_enabled;
 	bool power_on;
 	unsigned int connector_type;
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index f935093c4df4..8dc0dabd275c 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -15,36 +15,6 @@
 #include "dp_audio.h"
 #include "dp_drm.h"
 
-static int msm_dp_bridge_atomic_check(struct drm_bridge *bridge,
-			    struct drm_bridge_state *bridge_state,
-			    struct drm_crtc_state *crtc_state,
-			    struct drm_connector_state *conn_state)
-{
-	struct msm_dp *dp;
-
-	dp = to_dp_bridge(bridge)->msm_dp_display;
-
-	drm_dbg_dp(dp->drm_dev, "link_ready = %s\n",
-		str_true_false(dp->link_ready));
-
-	/*
-	 * There is no protection in the DRM framework to check if the display
-	 * pipeline has been already disabled before trying to disable it again.
-	 * Hence if the sink is unplugged, the pipeline gets disabled, but the
-	 * crtc->active is still true. Any attempt to set the mode or manually
-	 * disable this encoder will result in the crash.
-	 *
-	 * TODO: add support for telling the DRM subsystem that the pipeline is
-	 * disabled by the hardware and thus all access to it should be forbidden.
-	 * After that this piece of code can be removed.
-	 */
-	if (bridge->ops & DRM_BRIDGE_OP_HPD)
-		return (dp->link_ready) ? 0 : -ENOTCONN;
-
-	return 0;
-}
-
-
 /**
  * msm_dp_bridge_get_modes - callback to add drm modes via drm_mode_probed_add()
  * @bridge: Poiner to drm bridge
@@ -62,12 +32,10 @@ static int msm_dp_bridge_get_modes(struct drm_bridge *bridge, struct drm_connect
 	dp = to_dp_bridge(bridge)->msm_dp_display;
 
 	/* pluggable case assumes EDID is read when HPD */
-	if (dp->link_ready) {
-		rc = msm_dp_display_get_modes(dp);
-		if (rc <= 0) {
-			DRM_ERROR("failed to get DP sink modes, rc=%d\n", rc);
-			return rc;
-		}
+	rc = msm_dp_display_get_modes(dp);
+	if (rc <= 0) {
+		DRM_ERROR("failed to get DP sink modes, rc=%d\n", rc);
+		return rc;
 	} else {
 		drm_dbg_dp(connector->dev, "No sink connected\n");
 	}
@@ -92,7 +60,6 @@ static const struct drm_bridge_funcs msm_dp_bridge_ops = {
 	.mode_valid   = msm_dp_bridge_mode_valid,
 	.get_modes    = msm_dp_bridge_get_modes,
 	.detect       = msm_dp_bridge_detect,
-	.atomic_check = msm_dp_bridge_atomic_check,
 	.hpd_enable   = msm_dp_bridge_hpd_enable,
 	.hpd_disable  = msm_dp_bridge_hpd_disable,
 	.hpd_notify   = msm_dp_bridge_hpd_notify,

-- 
2.47.3

