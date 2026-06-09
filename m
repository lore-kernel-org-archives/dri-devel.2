Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB394CD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EE6710E20B;
	Tue,  9 Jun 2026 09:47:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o3YRE2cH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b0RlmhnV";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69ABA10E20C
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 09:47:55 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6597rbGG2034617
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 09:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CnGOml6KRNLCf8LNyNsT22xgMpxrnwiDol3PAO0B0Jw=; b=o3YRE2cHhsh/ltE9
 50OL9hBRBuBBVS1pnxeManKhzKUZLAh/iEPA571FCXXrzImF89yRpIs7GVt/VMBE
 5QhAJd1uBUE5hAvvF7bnwCLxYtYfHnvx9mkM62WkmqrfkPdvmcz+6EPJ2apSyuOq
 TmTHE32n+9dwNg7xRCfhM4LETbFHaK4voZPv5hdZG11QOIYXCrSc0b8Zz9sROe67
 59peK1FkodcsSVOJGH+8vwAUBWAPvq55DQ8m0xfNafwPjvKe9fpS3sW5ouOCpf8b
 dApkV3j80UFZ2ftbTgAQp1fLmfcwb1p9YQRlm4YnbcxIUzhk6wF0bz6K6grzF2Vo
 a1scXg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeearjq4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 09:47:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-915b6b63056so772043785a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 02:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780998474; x=1781603274;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CnGOml6KRNLCf8LNyNsT22xgMpxrnwiDol3PAO0B0Jw=;
 b=b0RlmhnV0mJ1dn1GSq+1yUtCuuMhFqjlvyTwOqh+zXj1ztDsU0oj3INQvomj1iHXtW
 XsgNDgiG+X0072Rc6jcwm0akMryuqzNPpTbfd37DaHT681aRdGw7euGCJo/p1ZXk4nxU
 00P9a22wF0cgzbI2MkXb8njfdz3h4H4RrEhou4lN8iGDHEiL9GPFbmX98p3VhDpkNQuq
 uWSork7J47Im+i80MHsthOYnWN99uRPossKziCToDOMgdaXibzShUY+hBoTFvJv/xoPB
 WajPXASWE8Fkt/LhwhhGdJROlJ3KnH1pU9m6AHzUupA7XSOMdTMQzpl9RTFt/wDuPVsP
 sH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780998474; x=1781603274;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CnGOml6KRNLCf8LNyNsT22xgMpxrnwiDol3PAO0B0Jw=;
 b=F1+4KZmuYq71n0n6FSFegYk1iuySpK54EoQ2WJznmEOtswDNodDSJzKAjRgOCvtgwa
 GPmP2lynTcQgfUUl2ieonn9qHlLOWIuJxV7HZE9nKs36QNDfzgv/7Yfqpq6yjbHFH3lx
 7mLxBFzHFVvtyOdVTOBpekKfIq6hedL2kNKeR8hhwyMv4QuawC2D95GtbxBM03PfLx3M
 mP3bhbeMgFM6UdziFo/PpVPCK3VwOWGyrKqA9ZkoVJ5fQj/mFY++u7LWhYXcvJ/ZR1tU
 gquINFrEDq9AoRdcc6P+W9lXCC+pDCDDbMaMgYf7dpGNHYBCYp1QLgZk2lgR6usBixAl
 W4fg==
X-Forwarded-Encrypted: i=1;
 AFNElJ86zaRzD44gYrcPxRiwgVkJeeft+Ae6FBjKSeTAAZ0ZVBmsITp+3r5uAvPWgMTSUY3J9XRmtEk5aS8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKM6MnnTlIXxM9hSBgvOVTddtAJZcTWExqvZbubdgwtZlr/2f/
 miyeHL8PDpjKlN0ewlKQkKv3oVFRX4jSnBegVUNQO/7u2vKRuzhSHztTS+TfrCp6KrkTzcWEuG7
 stOHKIbGoScw1Z3buMDI1HaU+h4aMyHyumWG5mI/lWEjED7XFzAQcPg8SQ7e2CNJULnvtzNs=
X-Gm-Gg: Acq92OHH2zLd0wK2Fj3QgAwvkfhqwV+wWa5/JBbodeJBxPzw/UfBZFF8OYAG08ZmWMM
 /tVRfAmWQ7WjZYPJVhqDPUtyDPy2oL82ef9t1aw3ZvYo8wvts1FFPtVJm0Av2HmIs6kXtQCPSwd
 JCbEiRW7SAm3qqDACi4TnLEWOFe8WfpDlRGe8YK3YprESxwB55kKnamotKSu3+p+LfjkSB+QZLG
 qHYwifpjCguMz8bKeGw5A+VQs4EWweWAZ1od5VyW5GIaMMtbaUn4SUj22lw+BfRPrOa8nHsVRwS
 f2zd/230jd5SdqNwAg10MKwYH4GPDclLxc4j6uRei0ttKhFgA1vLdr+FCwb+zDJgf5Txsahd6bj
 Sr9k1LKNqYOooPCm1j4yYBxYemkeWciOpgaMOuoFD9YBeF9M/lIegxFCkzk3rst1ViEpf9JUffJ
 b1PtfP7yQUVqsXWkTpeQ==
X-Received: by 2002:a05:620a:40cf:b0:915:79c8:ec9c with SMTP id
 af79cd13be357-915a9da96ecmr3113621385a.35.1780998473885; 
 Tue, 09 Jun 2026 02:47:53 -0700 (PDT)
X-Received: by 2002:a05:620a:40cf:b0:915:79c8:ec9c with SMTP id
 af79cd13be357-915a9da96ecmr3113617985a.35.1780998473462; 
 Tue, 09 Jun 2026 02:47:53 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a00afafsm2047489485a.2.2026.06.09.02.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 02:47:53 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 17:46:37 +0800
Subject: [PATCH v7 15/15] drm/msm/dp: pass panel to display enable/disable
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-dp_mstclean-v7-15-ea04113e8233@oss.qualcomm.com>
References: <20260609-dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com>
In-Reply-To: <20260609-dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780998393; l=3118;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=VMCb+gh78a5tyRp4ocOtlXR3WU+MH0tKL5IrymVyK/Y=;
 b=/bqYPwe+BT8wRDn37HT0g7sYFYdExLZp0AYNmLazK1zbmjMz62sd7TCVmyuOCWbG2FJSdIBCi
 nv2MEP7UAp4AK3aejuq8vXcpP63dyQNtdlsQFAfYzSKoPTnz4Xi703l
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: JnHsNrpB9q4PHXMPfZhUM02Tbon-MFGc
X-Authority-Analysis: v=2.4 cv=Iey3n2qa c=1 sm=1 tr=0 ts=6a27e14a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=wgkWW237A_BUGFCT6doA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5MCBTYWx0ZWRfXwC987jvjVx4g
 9t6vTaoEVkm1qLDxJdAAIV+ONMYAqJX2uoiTVWG4wAD/eRJhR4dGofi5TennFewyJHXwZQr6iP2
 rvtsMqdyzuP3hGBUYYwWh0m3itbYZK0Udi/+7/sdVczxkmNNadlR7kH/5BSTuJTZ7HNe5sVTrEy
 5D+A4GPFzCgcKr7KDA/oeTcliSNylGQIl5aOaQPDvKeTEtUmVMwk6ocMbr+em7aFR/ny4pZ+tzi
 UEdGs3CldjGwfnBDTjTdyUAO42sZNGVuJaeJBjZguv2LVn3O9sam6xZv1YybWASvYPZnN2cr5U5
 OKOMoJ2Z5LyrIXYtNonzeTWH6REnstrhcVa8cx7Tm3NCwIuoGHJiyU/uUmWZRymSpIMHhF4PUHj
 I4ciQ0UchRqNAeamiTw/Ql3W2XSofReugttPUEQREFxA32rY1Zcpn3qxMWIqlArJy2gA8gaYz3T
 ZVEK3BHDuvoZTz5dNPw==
X-Proofpoint-GUID: JnHsNrpB9q4PHXMPfZhUM02Tbon-MFGc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090090
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

Pass struct msm_dp_panel to the display enable/disable helpers to make
them easier to reuse for MST stream handling.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index cd1f2899b733..bea5bfb22967 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -650,7 +650,8 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
 }
 
-static int msm_dp_display_enable(struct msm_dp_display_private *dp)
+static int msm_dp_display_enable(struct msm_dp_display_private *dp,
+				 struct msm_dp_panel *msm_dp_panel)
 {
 	int rc = 0;
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
@@ -661,7 +662,7 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp)
 		return 0;
 	}
 
-	rc = msm_dp_ctrl_on_stream(dp->ctrl, dp->panel);
+	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel);
 	if (!rc)
 		msm_dp_display->power_on = true;
 
@@ -707,20 +708,21 @@ static void msm_dp_display_audio_notify_disable(struct msm_dp_display_private *d
 	msm_dp_display->audio_enabled = false;
 }
 
-static int msm_dp_display_disable(struct msm_dp_display_private *dp)
+static int msm_dp_display_disable(struct msm_dp_display_private *dp,
+				  struct msm_dp_panel *msm_dp_panel)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
 	if (!msm_dp_display->power_on)
 		return 0;
 
-	msm_dp_panel_disable_vsc_sdp(dp->panel);
+	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
 
 	msm_dp_ctrl_off_pixel_clk(dp->ctrl);
 
 	/* dongle is still connected but sinks are disconnected */
 	if (dp->link->sink_count == 0)
-		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
+		msm_dp_link_psm_config(dp->link, &msm_dp_panel->link_info, true);
 
 	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
 
@@ -1437,14 +1439,14 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	rc = msm_dp_display_enable(dp);
+	rc = msm_dp_display_enable(dp, dp->panel);
 	if (rc)
 		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
 
 	rc = msm_dp_display_post_enable(msm_dp_display);
 	if (rc) {
 		DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
-		msm_dp_display_disable(dp);
+		msm_dp_display_disable(dp, dp->panel);
 	}
 
 	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
@@ -1479,7 +1481,7 @@ void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
 
 	msm_dp_display_audio_notify_disable(msm_dp_display);
 
-	msm_dp_display_disable(msm_dp_display);
+	msm_dp_display_disable(msm_dp_display, msm_dp_display->panel);
 
 	msm_dp_display_unprepare(msm_dp_display);
 }

-- 
2.43.0

