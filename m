Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97FB60A2626
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g67J4S00;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FvJ0tMiB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C033B10EDAD;
	Tue, 10 Nov 2026 04:55:38 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04B8810EDA2
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:26 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4ABr51957780
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 21sbXEvtNaLwvZgAtYlqYJiHWlnEstcuCjSCkQvUWdc=; b=g67J4S00QJlqdhfQ
 Cu1XGNJkQJwYFz5fZpPGOHJrP5jikUWHKB0GIE1xHd8Doj7gXDtL3UPd6UfMh4no
 DoPSMM4vA/RrVP6qRWdgL08yzCDsynDKD8t8RexmrAJH4wKaSNj9G6ZGLlZug5GJ
 QgJa4tulu1qQBbvwVE26bWMtj6+CtlEZZd3WzHqcabwYiuappL2cbMNbe7qsnGIN
 WuoNJNdwXjXwZNF+HXKakL21DFeURiSGALzqDpu2NNb6Dd1a6SYU9aQ8wfE77eYn
 APlQk9e0zTVollGop/Tx6Go+U/NShMR6OMsnBDGDeJXnrT9g41Qop/vZW7J2jcKc
 vwAAkA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucydknh6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:25 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f13c143c8so309761185a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286525; x=1794891325;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=21sbXEvtNaLwvZgAtYlqYJiHWlnEstcuCjSCkQvUWdc=;
 b=FvJ0tMiBsWaX+jjJmZ9vrYmv36YcmLZFey5CCLXNbmx+O5WqRKPvbSg8xzYFR5fy4Z
 7PEEhAskXHwpNvSAleam+CrHx4itrkPo3nqQWjdy7izpoZx1ES9NniT/RlWCszFw73Qz
 yOJHIMPzm3ndXhT6XcAspoadLGwapYKEJA5xDLh+n+UEdk3j4x2IbHbe4P+ZFGlj/3gU
 eJk+CxYIfgngC6/TPDDKtAc8n3ExewhXeYa4cTCq035Aly1CR13iZts8fAM+9AmmMIzm
 pBNWLdct44Ew67ZWgkRfA9qW8bhyWw4zLlRCs8IcQuZ1NsxKoT7D4Oa3sKsvt3JrXdOS
 5M8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286525; x=1794891325;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=21sbXEvtNaLwvZgAtYlqYJiHWlnEstcuCjSCkQvUWdc=;
 b=PGjD10BFs1zLiV8vkMz+7BqW1Aqu8uW889olxL7X/Fw7cncFdNG3fkO3X7tVEM8s3D
 SdG7jhimgrPK3LoG6j3AuJ9aWlVkw5a5lOPANMhI5pz121c9styKe/k1A2/2lI62G36g
 1uWgh9lnggMQHXS8xctwBYApPFYF4BMJDrFu50Ga5m5YNABBhp2MY4wN68NEltoMkBdZ
 tddTAvxUhfxUy/1TGkXjhZgUVz+1P6I10QYze4nt66g+5awq8yzKiZ6eraOKNpmEqVsr
 urbTDKClSUNoleaRwJ3GyKZ5Muyfk4myonvDDW0WRxNIwIqi1qtsZ0ZVdxuNU/N4FhjL
 B5mA==
X-Forwarded-Encrypted: i=1;
 AL+hErFqMhcEfxfyrHLhy+9FzQMb5qfBivxXNE+BVu6rtHJ7tJXyEAU5Mpt2B/UHEXeMeJktgBW8OedzRK0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+FYDblMASIgOtZxDS54RwzbvkJau3Gkk06Xt/Tq4awe9OUuIV+
 7ofd+ZRC4locoH1niGZYVN1D4M+8AQs84ZMgIuV1rlgzRu36RZs5Vn9ytettawHvD2WxhZHm2EQ
 aOJehrEn5GbpywjZIHtt2fcxrOVail+RJY2pSrzwhA9pVsQ3bDGysXEqfKtgz3L9S5ZfWNfI=
X-Gm-Gg: AYBFou3BeWa1rL04lThzoPIWLIvr1lSOaNU70tUmI1Q98fgRLlVpyemMbASyAPv39xs
 m0AVqq5Ik83u84FnHpMC9l6+E6CyVhg5+f7/mvXzUEKhBNbLOU7FH/XZzKzqCGuSLnOBblCILpy
 FDJ6MAm815tfjmQMEIYs3Envki6/1PvShhcJeumU2/WY8dzeZ8aOv7PbnPx2czasA8MtFys1XoR
 Ae4cDwjWjI4XgaYoTil92DQeKEyoZu0XpNYY6bm6PlmNm+PSMK957AwDPNugTlfJRdMQWatkGSc
 MkbE2gfjaCc5Ty1sQPfmdZKMU0U6O+VcH5sOEaRqp3A4OmhPLAARoYzIdLici4aDeQeNP9vz0q1
 s309ZrMFoJ35fwHj3uh9RxDGd/N8oro8ML+hYZPPG7PgUjlg6SUQoBhW7PeU7HqwfvRQ8IWfeYH
 0iO9wMiGkZOFUqyaK5A3CANu+qklXQh4gfcoj0
X-Received: by 2002:a05:620a:c4d:b0:93e:c12c:4416 with SMTP id
 af79cd13be357-9479f42082dmr252883485a.82.1794286525362; 
 Mon, 09 Nov 2026 20:55:25 -0800 (PST)
X-Received: by 2002:a05:620a:c4d:b0:93e:c12c:4416 with SMTP id
 af79cd13be357-9479f42082dmr252882085a.82.1794286524985; 
 Mon, 09 Nov 2026 20:55:24 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:55:24 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:31 +0800
Subject: [PATCH v8 10/29] drm/msm/dp: add link_ready to manage link-level
 operations
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-10-d040fb33db5f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=4075;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=ntFGyV9B6QqY6KslrvlheiuWhIYtkbPc8mhAWBIq/aQ=;
 b=X9w307hVAVmYkzZxYYUUuZ2Nada4UXGgOHUYBTtqdC9dONvqC1Kybr7wTPE1jJj7JG/nLWY34
 GHT3osRX5ISBflTK5n6iKz44juGjCT2JM6ykTTd5IP7IAiyJMU6FJtf
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX3c/X/GhK0kYc
 VNCvhVBY9BPZOpQAe8OyGA6HwO+AnWEB+GcIrDXAfmPITCConXNu6plysOoU1MH+IF4vSXaUP4E
 80GMfil7ydGXvNNrCm1w0srYC3NIsbc=
X-Proofpoint-GUID: 2hDahU9ENUFnDRflLNOvkiXzX9kb5pMC
X-Proofpoint-ORIG-GUID: 2hDahU9ENUFnDRflLNOvkiXzX9kb5pMC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX3fP4SpqO/Mns
 BkBrufhqDox68sw1M36BVwugecnucmDCTb5PwOuYaBGN4F7yqPpPKDn76/oSUVwnzLn5jcIQ2I8
 RzSbLANTmS3j9PQ9V8JTNHQhA4rvZU+hW/MzJNHCoHyc9e6NfyrOUNMyesGPhOUsGPbWM3NM1Jp
 YY4x0i15LN5rVQEW2Munq2HCYrnotD1M8Y9wMPvTxwjyGn56ZPRqJp0380IepRSE/vws3Lio1jt
 WJ9CCTrclo6mE3sayYVL6FoAurD+/iATzNsASCSjVB7FHL4UFPjPV5vxeQuW1OzangRUJfmAIrC
 Ctykl/YtmBYamLgP5ctlmviFtwvQRvQ27yYK+c5mktsDHuEaYwgfmbx4GgqK5o3/6BHT2D0kByL
 MAEV1dzzOv864JA39r5sLg2HsGeWH0AzzSxR14A1yUo8PZwOKvSj/e2F2KzoTT9bRcWqippXkz2
 SX42i+TPv+VBP7uSyGQ==
X-Authority-Analysis: v=2.4 cv=XuRvqlF9 c=1 sm=1 tr=0 ts=6af2a3be cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=r0U9Mmpn2XdHegFmGjAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100019
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
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 48 +++++++++++++++++++++++++++----------
 drivers/gpu/drm/msm/dp/dp_display.h |  1 +
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 471085744c7c..6a522cc71a2a 100644
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
+		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
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

