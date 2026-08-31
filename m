Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CE9C61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:18:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9811810E726;
	Mon, 31 Aug 2026 08:18:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UZFMoDSl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jeM3WLcL";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9CA610E725
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:18:52 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xGA32332502
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CtHvW97i03ymOEo484vp1OVXCSWAzJDybaxPrTlBrk0=; b=UZFMoDSl9+ekXDl5
 9ko/19Yi4kYsfhvA4UlWQjbjx37HMoIxoBm7142ogWnd+fCSulECHaOYqfrpktn+
 KnaU1buC6NeRz6vII9A1j1uuNceu80MY5p+tds34deUgFnGqtFCetLxSZfjjt+wW
 a1adTiQKEKk33neFYuQYNiyPx/UdF10LBXzmxYksugFsB5p3nEI6JP2VcjBkPPv7
 l+strtGSb6ph3v7i/vkfo+LrViEKZHRkRWRJz/LSZQ/9qCKATjKPG7mbhL9h5Cib
 hodrTH6IDXkPEXJOxhM7LjZlCZ9gP65gyzVOx73cET5aYyouLGbdbnxp2CzGdWML
 Z6Yfbw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbrq856x1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:18:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1d30035dso33199061cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 01:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788164331; x=1788769131;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CtHvW97i03ymOEo484vp1OVXCSWAzJDybaxPrTlBrk0=;
 b=jeM3WLcLqBLVEwxxMlaeWKIhhETjJiHJTE275yvvaIeXgGz4WyplYrJSREY8Crx6kz
 hi+IIrBrzBxPymZ2tybMxDaOXXzuTL2utCPJxNacPID5Im6Yteb77jOU0ghCYsKp6AqM
 rL3aJCni6PtodYsOaPkzvkC8igebyW9rwH/9R1EC8vrpC7Co7AlsNQYLKJzz3Odo7QtO
 T5xPUOaVLSe849NIQAadJvqLbWvJixfC1XlPszzuPboCRVsJZzTMuul56hrTgS0k4Nkz
 9nXIyBl5up7g0EzF83vNP6f/D+2EoBAv/77pky2OUmV18MefPLni+cAXgWe7XS/tUtiV
 552g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164331; x=1788769131;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CtHvW97i03ymOEo484vp1OVXCSWAzJDybaxPrTlBrk0=;
 b=onJ/sIziX301SxKWTDHRM4ce6jBESZKwJ3FHx/32BbVEBuGv0aUykYtyxxF5m5Fj4I
 PM5FPNWSTFa7II926DvPHmn31qdEvZMP6aZ1ABlUcFgKn52m0yacLIy8xkrpU8Zkb03B
 PcSN8qXic8CCxPnFw5E3wacYFlnhCk06k0Yj3A4TgbZwzJz3mYCs55nMpU/5kSEP9P9A
 KaTmg2ybyGd4V2LUva9EiP8CT0qxT8OHEUP5oyBt+iQdvl4LzkSXQyqblbgZY8kye6cE
 SjYJyzC2B9HoINglJRGIHh7QcJMWuZnbb9J3+EfijS/HgjDJzcXPWMCUriO1KVfk0GbK
 Rn6A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpojj/eguuxVJuB6WR36qkOtk5H/n8Tv+S32xzYxDq/+2xf6cW0aNc/DpLmEXFpFqmIPCuEDnSS3pw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mAdC/lB5IuoU2IDhejdae97kElf3vkVTezE+wygnR5azO7jVh/
 5w9Tz1p6miVOxenLT2ek/41ehTHGGsfKjm6x+Tf/GbdoE1rfJbp40Py0Na+3StDVbc6qxJ9pf1D
 Vuv23feJ5MfI8A76ao3hCAh8XLYSBI7J7DPV1qfDdfj8BVP18MOpseMDRi1fjfj2SOkv9B80=
X-Gm-Gg: AR+sD13NzoyljHWdhRDjH1NW8mJhpQ2pykMStrx+Ak0T/I4sUqMlHJBT7tk8mHH+4GI
 YSmlg4SG1d/WKmj4l2vcZBI2JeZcPqFuNx7CrFJrtddIjN1yHuX9iGKqXUDASrkIoaqSgH0jd3B
 jx2PuZdh26yWhj+Cj0SHhDLDRWml6nFvKxAfQ/gfuYXE49Ho8m8je0T/rqn3EXw0Ezdk4d4G67s
 cagK3Tf/gyTmtzSQfg+9jzCXonAtFvn55hKVo2FWx/yFAqa/Cr55L0dk5Sa2j2XkqMcf3W4M+c0
 vOLlH2BoyrpSOleJlL80G4qL2Q7NBNuwgriE45w7JFwjeLgz1vURkdfK76ENNaUoR0ypAwDaogJ
 YlCiVq1RTNPN3EfeGUozmqKTA6onzowWys1Ygc2N6ipgN+u751/ND9CWHqd52a/Q=
X-Received: by 2002:a05:620a:6988:b0:939:1c6:38ef with SMTP id
 af79cd13be357-9391374de9fmr2727779285a.6.1788164331245; 
 Mon, 31 Aug 2026 01:18:51 -0700 (PDT)
X-Received: by 2002:a05:620a:6988:b0:939:1c6:38ef with SMTP id
 af79cd13be357-9391374de9fmr2727776285a.6.1788164330773; 
 Mon, 31 Aug 2026 01:18:50 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917236b86sm735974285a.13.2026.08.31.01.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:18:50 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:17:31 +0800
Subject: [PATCH v6 14/29] drm/msm/dp: replace power_on with active_stream_cnt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-msm-dp-mst-v6-14-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
In-Reply-To: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788164246; l=5066;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=GJl85rX2L2niNbZCL3wSxiXdb4cNZLP4ul7aPSHeeOA=;
 b=+2hL6IQ3VElIQ/yZhfXkp9lmDPPVrFdPBO2Y5nH0HquFxi9q4TGI0Ti25+gLW/4tGHIuzugxD
 VWttT4J9ihwBfICdYCr66++KIdtbGWaZKjLSoANI8MXOSzCAJhLQ0DX
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: JvJ5zAs9AThkAk7dvi5WNLsHdHLmiSni
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfXyjVA6SDPNRg1
 tbfGOzHE1f8/kyntENz9I4EGSI/BX4a5bk3DNKGg+QxyQ9Dz22lGt8fT6giU3AlEtOfhPsPgLxg
 8FkSiltDXIjjUr5cslTHMqSNUC8Y+Hk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfXz9ZPlbR3Ylop
 jcV227rSn1rq4hIbmcl5p1xp2AnE9unhhtejffmw6oqSER+34F+lm5AuLEJZSI/o7Zu+1ERGwiN
 emxYI2DakS5nP6eUznQUDmEl7Y5+xR9rwhjE7gqOzzuqhjEtKIsMH5mVOGm9v2ju6DYWwWH67LJ
 d2ao8fmYErmFbAMUdxWm1NQZ54Wuwxn0cIDaXDgcAVP4yU83Gc3a+L46naCRiNdx4FrbrevLfPI
 e35RsiGcwDXZDrkLBZGYt3wc/AeaTuyTHdeQrBTgsWQHjcbxIrjdlXjk8i9ajGN943FuqhwD8wr
 46kmTLX+hKQD6U0E4LhEB4vuyzc3rc8vbRo8qBi8a/1QZ+2AOvvViDqOPlffWckVQQGbH98adb6
 3WlEhs+BUbJ0AwFFQ/Q0a3Fr+DMwxWcaPwBdCenTEzkO+ffiJ6BfqInSrtEEaVIjJ6jKcGYcuSw
 HKZ3OW/dvT/RxBKNlkA==
X-Authority-Analysis: v=2.4 cv=ZOPnX37b c=1 sm=1 tr=0 ts=6a9538ec cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pA7EhmVi1NdrnwtGoTUA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: JvJ5zAs9AThkAk7dvi5WNLsHdHLmiSni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310070
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

The power_on boolean cannot represent DP MST, where multiple streams
share a single link and its associated resources.

Replace power_on with active_stream_cnt and use it to track the lifetime
of the shared link. Link initialization is performed when enabling the
first stream, while link teardown is deferred until the last stream is
disabled.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_audio.c   |  2 +-
 drivers/gpu/drm/msm/dp/dp_display.c | 38 ++++++++++++++++++-------------------
 drivers/gpu/drm/msm/dp/dp_display.h |  2 +-
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
index df222943ae57..8118130a3220 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.c
+++ b/drivers/gpu/drm/msm/dp/dp_audio.c
@@ -284,7 +284,7 @@ int msm_dp_audio_prepare(struct drm_bridge *bridge,
 	 * such cases check for connection status and bail out if not
 	 * connected.
 	 */
-	if (!msm_dp_display->power_on)
+	if (!msm_dp_display->active_stream_cnt)
 		goto end;
 
 	audio = msm_dp_audio_get_data(msm_dp_display);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 6f79328c8b79..9c5563dcb856 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -645,16 +645,16 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 	if (dp->link->sink_count == 0)
 		return -ENOTCONN;
 
-	if (!msm_dp_display->power_on) {
+	if (!msm_dp_display->active_stream_cnt) {
 		msm_dp_display_host_phy_init(dp);
 		force_link_train = true;
-	}
 
-	rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
-	if (rc) {
-		DRM_ERROR("Failed link training (rc=%d)\n", rc);
-		// TODO: schedule drm_connector_set_link_status_property()
-		return rc;
+		rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
+		if (rc) {
+			DRM_ERROR("Failed link training (rc=%d)\n", rc);
+			// TODO: schedule drm_connector_set_link_status_property()
+			return rc;
+		}
 	}
 
 	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
@@ -667,14 +667,10 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp,
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
 	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
-	if (msm_dp_display->power_on) {
-		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
-		return 0;
-	}
 
 	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel, msm_dp_display->mst_active);
-	if (!rc)
-		msm_dp_display->power_on = true;
+
+	msm_dp_display->active_stream_cnt++;
 
 	return rc;
 }
@@ -723,13 +719,12 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp,
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
-	if (!msm_dp_display->power_on)
-		return 0;
-
 	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
 
 	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);
 
+	msm_dp_display->active_stream_cnt--;
+
 	drm_dbg_dp(dp->drm_dev, "sink count: %d\n", dp->link->sink_count);
 	return 0;
 }
@@ -851,10 +846,10 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
 	 * if we are reading registers we need the link clocks to be on
 	 * however till DP cable is connected this will not happen as we
 	 * do not know the resolution to power up with. Hence check the
-	 * power_on status before dumping DP registers to avoid crash due
+	 * active_stream_cnt status before dumping DP registers to avoid crash due
 	 * to unclocked access
 	 */
-	if (!dp->power_on)
+	if (!dp->active_stream_cnt)
 		return;
 
 	msm_disp_snapshot_add_block(disp_state, msm_dp_display->ahb_len,
@@ -1517,6 +1512,11 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
+	if (msm_dp_display->active_stream_cnt) {
+		drm_dbg_dp(dp->drm_dev, "stream still active, return\n");
+		return;
+	}
+
 	/* dongle is still connected but sinks are disconnected */
 	if (dp->link->sink_count == 0)
 		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
@@ -1529,8 +1529,6 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
 	else
 		msm_dp_display_host_phy_exit(dp);
 
-	msm_dp_display->power_on = false;
-
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
 
 	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 317c19b809ec..7bd510cecb44 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -18,7 +18,7 @@ struct msm_dp {
 	struct drm_bridge *next_bridge;
 	struct drm_bridge *bridge;
 	bool audio_enabled;
-	bool power_on;
+	u32 active_stream_cnt;
 	bool mst_active;
 	unsigned int connector_type;
 	bool is_edp;

-- 
2.43.0

