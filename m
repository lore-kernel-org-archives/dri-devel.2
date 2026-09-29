Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72468C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA3C310EC98;
	Tue, 29 Sep 2026 04:28:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lc+w9zQH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="STxRYGsx";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A36410ECB0
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:46 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47i5K4052976
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Hiy+4MSFHQi0b8MUudXcZS5aUdLcyy1D41z/sf1hcaI=; b=Lc+w9zQHGoHQYcav
 biKQMZEH8n0+BlB+dyjh1O7dhR3e0XMndIGNdEn4M+BOrfM3FaHuKuVz3mFCE2OQ
 2yR7WXE2twBLTL6a4mNYj96ZtvhP6A/RYKtbvjU37wqzOAk/pMxmCyFEUKsCXByB
 oRnU+a3bkv2Nv5EU3Td4XQPT7YzfI5RIgIR7HtTYtYKDU0WjpNUv/A0L8YdAiBDD
 6vVuGGkIphEC1GXeBzfAaVRWI1TAq8+lEH5KWUVcRgwGr5LDm2eeros5HSejKGck
 fNSp8vdpsRtrevL1+SB8PwVIEO79SACbD/g7y0ftiKRAgAeT6CJJIhNLsc8SFL/I
 agHsYg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h05yxg2dc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:45 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5333a1b634bso47293441cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656064; x=1791260864;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hiy+4MSFHQi0b8MUudXcZS5aUdLcyy1D41z/sf1hcaI=;
 b=STxRYGsxThG5uvfC3CZoG47lAYnpojqZMfOLG4SlKheHH0P5EODNPXU5LxAHb/Tc2i
 zQ/CcsrpFSi+9KsofrJs0B/OAAyeOPwJ0NhlSjCJ5Nwdp2xaF8k5IEoIFtUHtji4/bqP
 XSzNqDYlAA+SAAAWK24f8DWNC3TdtHKgUvx3SXc45rIv63Vf5P7h5XfntrDxHEKGMKSc
 jFrtYzSWCO7DVZuvMPA+ldSEjltXMYKg9+2pq6hzFAyEngUnSQLkw3x98g3CgFDRPhLv
 hA7dZW9IqwZiDqQhXnNeuIZOGDrOHAtwxTeV3zUr8Jw3bOOcDuqMsH/Pxf9j2O4N9Ieh
 ezpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656064; x=1791260864;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hiy+4MSFHQi0b8MUudXcZS5aUdLcyy1D41z/sf1hcaI=;
 b=eqc31gcIlQSuwdDv8BVjVNtF4pG5AGdue7uSEw/x3YgSSfAzNIlcDg+Hbq3Xn1zTo7
 wlLnaRH+bX6Cwq7CG20NXDsji15PQdKeBqNPM4C/Yp9iACO84fePuae6P+Vlu9ljp+En
 UZNbJzc5wrruqWIiIXcuNBBWqlyucasK9EaSx18NEPsQLrBVfHemj+k5lbp8QlTtMtFt
 Hdy1pha5hvZ/Jknen2SETuMLyoj/hPfMuYyrjAMvz9PXZ9yM6eso8da6M/tdHJNCtkjK
 tdsWLe7GrALhyIx9jKbj/RdGOGBCk/SciFfWjmaM541i/VsZWRQbLVMLnUlZCOgZ1+y0
 b+VQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlpeq2YbGBh8Vo6eUZ27VsCG65a34VMpC4mqEHSRSWTyFFxgcACMxl/xoEHGxDvE7X7ppB8yr+g5M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lRjeoJYkm4KxJqGN43EBMSmXr48Ac39hMjSf/UKVtU1zdUr1Jg
 gYogda5x6uFxU6cmbhM/8xDbppMkZiKb5MXJovp8vv0FsAZhLvDKug3TaTh3zb3vMPnvMDZlQPZ
 DspB5s34ktfIh97hmx3sg/Iv5OQ0fF+qdebs9UzeFjV8MHlRh8dT/HO4rBvTqn2qXwxNQq3c=
X-Gm-Gg: AYBFou3RnWib8jILO2r7cm1lcnG+KAWPRBYEKu6r/V4/sqftEkWwS4XvINmUAgoX7o3
 CxOfccYjt8eAQ7Q2PCBJ9ZwOG6V5lQFKKJQuaqcL0W+hmkthxIcip2U8UxExy6y9K/7cidKiTFN
 Y7ecrQmXFUstsz3OVEh4CEwj0T39EuZ0icxiNb/Jh7pOHEYHnAXhy8bQCpIGX+1z57qBsQdTj08
 JX7UbYBhm7U+dTXdSScXkfI06hzluEXZuupKEgdp0YPH902kBgVQLmG1m0Kd9cGmpGyyRV8N/L2
 auqWre3YT7+9tvP+B0GCpsYRQtCpIh8UDkjJddK6pPdwzzN/22Uv+ux5mxZYMCiSTxtcEyb9gCl
 rfUxHjATqxwOr7GnSrDGet7pUQWqjGRgckFJwjZwnq6l+mt6+oIxZAiMQuz/1jp0=
X-Received: by 2002:a05:6214:488d:b0:914:4e89:131e with SMTP id
 6a1803df08f44-9144e8919fdmr170215976d6.28.1790656064275; 
 Mon, 28 Sep 2026 21:27:44 -0700 (PDT)
X-Received: by 2002:a05:6214:488d:b0:914:4e89:131e with SMTP id
 6a1803df08f44-9144e8919fdmr170215856d6.28.1790656063892; 
 Mon, 28 Sep 2026 21:27:43 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:27:43 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:40 +0800
Subject: [PATCH v7 16/35] drm/msm/dp: add link_ready to manage link-level
 operations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-16-4b81473185e7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=3521;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=C/o0ZCDpplNMSGFNccofcP0FNVSX5E147vDc2o0AxL4=;
 b=pUXU5DEn9FspX/uIKxuUa3h2Vd0pZ12m5jZssq9UMdQUTPtd14jVS7tdGQ14ufwGLAMA9CcxT
 wji2U832fCYDbDiMHklLX5A2B3U1+NWyeGMa7TS5wj5T2qidK+iwoEM
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX/m2I2BUnKDXq
 YH5vT44lNw8Tt3ZnLkSiJdqX2U6ToWYyXrdGcRhv7fj+kZFtS/zvC3L7jo/GCp1N/Ty61FzqQ2N
 F6eEFXbo7K9J19mGwRqqyzA2TCrmSRo=
X-Proofpoint-GUID: GDXQG_YIZP9JfZsVjC5T5xwvE7dBQoTr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX2+kn/+S4yN6q
 /O/igwZuHCZXMY6DAEwa4mA3qx5uvU50Uubfwn5FxmAvAHWYizeu448KDtaxt10U+28eWtg0N2K
 E/OZJgWyxirtyHt8DR7VIlI3Dx8WWnXNTFT9Vmef44A3zoaDnS6LAXKhAUzHHUAlJgR3bClOSgN
 +N7PQ9TOAJJC9suW4ClgVr9OQ+xWKRmRR4IhRH6dCd0G7wWC/2BDxjPhdRq0LlUbno8xH/AiIV0
 FEAUXKwBLB01ppWLfMTJtsibHSiJ5FvcJau082lWP5vNjlVKRMaPrfNDNg9A5vsvPAupsXBknjA
 ay9yi31bNJ+EktfdaOI7NpduEMwg+GG2AwxdjV6z/2wcjjBWTRi5NVliCjAVwGyuyuyQjISwwd7
 om4q/OBgMXDbfL2DLVPe8WEFD2Xtrkx0fSASTuHQSXbT7caCxxN2p/erz7TluHEAYDWi9I6gC4/
 bZkQ3LE50j6YepvgM0g==
X-Proofpoint-ORIG-GUID: GDXQG_YIZP9JfZsVjC5T5xwvE7dBQoTr
X-Authority-Analysis: v=2.4 cv=SaFi5fRu c=1 sm=1 tr=0 ts=6abb3e41 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=r0U9Mmpn2XdHegFmGjAA:9 a=QEXdDO2ut3YA:10
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

In MST mode, multiple streams share the same DP link. Track a link_ready
state so msm_dp_display_prepare_link() runs only once per link and
repeated calls are skipped.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 33 +++++++++++++++++++++++++--------
 drivers/gpu/drm/msm/dp/dp_display.h |  1 +
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 49a718f4e464..487c76e0f990 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -638,6 +638,10 @@ int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display)
 	if (msm_dp_display->is_edp)
 		msm_dp_hpd_plug_handle(dp);
 
+	/* Serialized by modeset lock or mst_lock. */
+	if (msm_dp_display->link_ready)
+		return 0;
+
 	rc = pm_runtime_resume_and_get(&msm_dp_display->pdev->dev);
 	if (rc) {
 		DRM_ERROR("failed to pm_runtime_resume\n");
@@ -659,7 +663,11 @@ int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display)
 		}
 	}
 
-	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
+	rc = msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
+	if (!rc)
+		msm_dp_display->link_ready = true;
+
+	return rc;
 }
 
 static int msm_dp_display_enable(struct msm_dp_display_private *dp,
@@ -1501,14 +1509,16 @@ void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display,
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	rc = msm_dp_display_enable(dp, msm_dp_panel);
-	if (rc)
-		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
+	if (msm_dp_display->link_ready) {
+		rc = msm_dp_display_enable(dp, msm_dp_panel);
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
@@ -1565,6 +1575,11 @@ void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
+	if (!msm_dp_display->link_ready) {
+		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
+		return;
+	}
+
 	if (msm_dp_display->active_stream_cnt) {
 		drm_dbg_dp(dp->drm_dev, "stream still active, return\n");
 		return;
@@ -1583,6 +1598,8 @@ void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
 		msm_dp_display_host_phy_exit(dp);
 
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
+
+	msm_dp_display->link_ready = false;
 }
 
 void msm_dp_display_atomic_post_disable_helper(struct msm_dp *dp, struct msm_dp_panel *msm_dp_panel)
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 9ecd5025fe4a..51eace1d1346 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -20,6 +20,7 @@ struct msm_dp {
 	bool audio_enabled;
 	u32 active_stream_cnt;
 	bool mst_active;
+	bool link_ready;
 	unsigned int connector_type;
 	bool is_edp;
 

-- 
2.43.0

