Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840F8CD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 10:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E60ED10EFF4;
	Thu, 28 May 2026 10:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dc3ZTpNg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X/ya/Sm3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D980A10EFF5
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:45 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8vUNQ3203255
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4GLG60vKqqPhXSK9u7LFSK5eRlVCZiWpAvGD6R5I4zI=; b=dc3ZTpNgc1bGQzBj
 fBceIuLclGs2lQim5PFenS2kNss/UODOsqFCMgpUZ51ldg9nb6Sg5iz7MWeHY2DV
 F/TyC705LorPh6QKm5jkP4k5no7PTIq0H/ljtCd57Hu+ZkU9a7z2yo4MHO+eLpwa
 7J9a2FP6zNRKWk1OzwSmvpWuquhpvTOT1OU3kLWVG/yPuAPRooVbXMmvtCl2lbxB
 K9y7ZeNZYJlfGURFkC6LE9Gffbi/y3i7h5IoWIAkbUYVK3+161Raw/woUfUrsjyY
 HyQqw9ByxIQcycgW6vOTc0KO/GOg6aiBl5ynSH2zNQ5rkOo3ouydrPmJIe0RwFKE
 yuABCg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ynje7m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-914f037b7dfso584127885a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 03:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779964904; x=1780569704;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4GLG60vKqqPhXSK9u7LFSK5eRlVCZiWpAvGD6R5I4zI=;
 b=X/ya/Sm3aGqYY9DKGxa81tEyy2sLB4TMzUoRyLsOCcyEdM0gL/FCfVmXLy173fC7iq
 7xE5S9CGLbMkC7SE7aUhP/FkMPz1HMuNexayyYMbNiK3wMxcXeSu5lCzS2R7IbnOrq8q
 SZzI1IA951Q9Z2i9dowH/EPzx9nowEWcFPj+5p1noAWk3ZDpkFJdOeZghUT6rcik0dBp
 TN4dg7NubIxWbTdQE/1lkfeUqwTD3xUhuo/izTAb8372xKLzb1+aYvdjyLr7KrVz3oKh
 enpjTO4AkRUeEkACymWvNASz7IqRV5/ep3cQjhbwv3Mz5jV4S3CoYFO9dfjb7h/q3uLX
 aqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779964904; x=1780569704;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4GLG60vKqqPhXSK9u7LFSK5eRlVCZiWpAvGD6R5I4zI=;
 b=k7uvzB+6C5MDPXJBh9lyuuE/XPVxRJdy4a9jp4V/sLaWGCS3/ZBvQfjJLL2Plwymfb
 v+Wc4PsgeArljq4YOisnXwsah7J2U9UJiFmPd/05rAj0Y1eO+lSa2YasTggQx800raOz
 2Y0btt32PWYDtsRWrfz3mToqBSx17zCSZReEryUbr152Sqq6Nby3+FwHzqfsLuq4Rywx
 TUwEfCXs7CP5lS1CUubYVx9xivafiCPZH4mRkmTOaNzhTt33awPzmGF1fODvEA0wID4E
 H8QMFlqwEU+7Nj6/gdtN+3jzot6+DyG7WHlgohplEgeK4YoA06VSlqdN5ys1uP2vO3LA
 JguA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8CVWjoDJke+CQDne61JCqAUOhtDm1NuRC/UkPl/of9XjT55+RfzJ3isRpzN+xLrDKXUxKcQdHCRos=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZlWIQsttkXJS0+uE6ceJH7wd3ozBaR4NBO1DECG41nDaMfbAD
 kDuqfjmeZFf9XfFQmCJKMItSCRDCZai6d6nGvGzr0ksr3np9DDPVB+FNzUdTf5JSJp9eAcY9eeB
 JPffY28fIst4n28DqpYOhct5PMUFKMacTNzVeklD3zDi6l34YKM+BpZZUmQpn4Wc6Zl/cyaQ=
X-Gm-Gg: Acq92OGdeBWz/OgNNdAERzkxX0KFXgoC/tYWBuqJoIiVaYUY045R5keLrGMBpbPiFZ4
 xECflvst023MttygsUwsqfZsOgZlgpP0nPh53QcnP8IeS83vkcoyJ3J4BdGFx4etj0FiYpX+Gbx
 xA7l0fxPSXkMGy+dRS7Yiyf8v6Ow7HjeTKHYTSHcQyHdePp3G7FlAbgbRlfWXV8Hlf8nGE0GsgE
 1hjWtQi2RnURGx+A7Q9HBAcc1il8/h0LWcGreJSG8gu22YJM2sNOPHOcON1zBUfngyztxOSwoMN
 EtDGQAZDNjm5SWJAQIpZav2Ts+Hh4ayM6j2fib04c3uaZ0/0btaDmlJ8MFEuytphZOxuGm9FOEa
 VmIpb0OEHm9EoOSe3VXSv55Aurrx0pbwcues3U03Fn5gbNwbCPW0F/59ybdZeLS+YV6nDi0CRgn
 8Y3+VCcgQduwCJ79aQsg==
X-Received: by 2002:a05:620a:2989:b0:8ed:11b9:1edc with SMTP id
 af79cd13be357-914b48d1d5fmr3948319585a.14.1779964904434; 
 Thu, 28 May 2026 03:41:44 -0700 (PDT)
X-Received: by 2002:a05:620a:2989:b0:8ed:11b9:1edc with SMTP id
 af79cd13be357-914b48d1d5fmr3948314785a.14.1779964903987; 
 Thu, 28 May 2026 03:41:43 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f86fffddsm755148485a.12.2026.05.28.03.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 03:41:43 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 28 May 2026 18:40:35 +0800
Subject: [PATCH v5 14/15] drm/msm/dp: separate dp_display_prepare() into
 its own API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-dp_mstclean-v5-14-a9221c1f1f3b@oss.qualcomm.com>
References: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
In-Reply-To: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779964831; l=3743;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=PejPis5lPUmTa0t10X2rGcGnHfGkWszn1oUEuwhLLv0=;
 b=XAghNErOj5Q8+qQKxC2vyn/619TeztHoHxIqNc9crazWw1iU4EdyZh0ib+n4zg356QVgcl4GW
 KX+FfcvqeHTCfqvEMi1mP5ezwrB/wPUykqMuc8XD7kHLA6Wl5Q2FScK
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEwOCBTYWx0ZWRfX3lzpP6DKxtcC
 5P/S2ghelnsxQw7CQdCKajFqrHrnJzr1F39WYmRI0k/BmUdEdg/RQx/tDt0DWEAwF7xamz1/uIA
 LekyDpkgz+6AkGWBebFrX8xnK+TPTFOl8NZXJFhosNQW7HO3dPPq0oQOLBFTLPv43iZlYnDhnbI
 77kmC9Em3/M+8zmiohc2OmXbqpG0oWT0O6XhTWNEEHGqx6+5zoTqP04RxdWszH/oGOjaRcZsNLN
 0v6aUZ/1eHZuH4ZMY+jdF5s6tm20/8LWqBZmBcAcSHtkuBMqEpuS3UokNrkgBKAUNC829Txusu/
 JeHvUmtNQQg4/LWHiUpNVEoyRBxwFddorCF+qsGod/DButV4ULNxHl9gBHFbu4BQebf71eLFe6t
 hXHUkgxX18hGHWCL6FvzZM4FPMOfkRkVQjYDDgC3fRG5b2i3VGl+W5KiJwexjbEh4YBHfjWWIMw
 3x5fFbn1c+PGR5QXuQA==
X-Proofpoint-ORIG-GUID: zngmfHC6N2slQ0CyJpl1lzMYuaWKmdPN
X-Proofpoint-GUID: zngmfHC6N2slQ0CyJpl1lzMYuaWKmdPN
X-Authority-Analysis: v=2.4 cv=EdL4hvmC c=1 sm=1 tr=0 ts=6a181be9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=rHTcTV9uYuKpyGuOXCsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280108
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

For MST, the link setup should only be done once when multiple sinks are
enabled, while stream setup may run multiple times for each sink. Split
the link-related preparation out of msm_dp_display_atomic_enable() so it
can be called separately before the per-stream enable path.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 16 +++++++++++-----
 drivers/gpu/drm/msm/dp/dp_display.h |  5 +++--
 drivers/gpu/drm/msm/dp/dp_drm.c     |  6 ++++--
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 2d5ef087648c..cd1f2899b733 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1403,8 +1403,8 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 	return 0;
 }
 
-void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
-				  struct drm_atomic_commit *state)
+void msm_dp_display_atomic_prepare(struct msm_dp *msm_dp_display,
+				   struct drm_atomic_commit *state)
 {
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
@@ -1426,10 +1426,16 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
 	}
 
 	rc = msm_dp_display_prepare_link(dp);
-	if (rc) {
+	if (rc)
 		DRM_ERROR("DP display prepare failed, rc=%d\n", rc);
-		return;
-	}
+}
+
+void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+	int rc = 0;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
 	rc = msm_dp_display_enable(dp);
 	if (rc)
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 5116f7bbbd02..43ed79093e24 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -35,8 +35,9 @@ void msm_dp_display_set_psr(struct msm_dp *dp, bool enter);
 void msm_dp_display_debugfs_init(struct msm_dp *msm_dp_display, struct dentry *dentry, bool is_edp);
 void msm_dp_display_atomic_post_disable(struct msm_dp *dp_display);
 void msm_dp_display_atomic_disable(struct msm_dp *dp_display);
-void msm_dp_display_atomic_enable(struct msm_dp *dp_display,
-				  struct drm_atomic_commit *state);
+void msm_dp_display_atomic_prepare(struct msm_dp *dp_display,
+				   struct drm_atomic_commit *state);
+void msm_dp_display_atomic_enable(struct msm_dp *dp_display);
 enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
 					       const struct drm_display_info *info,
 					       const struct drm_display_mode *mode);
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 6b8923d9dff4..4bf1a5b7c3f9 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -55,7 +55,8 @@ static void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
 	struct msm_dp *dp = dp_bridge->msm_dp_display;
 
-	msm_dp_display_atomic_enable(dp, state);
+	msm_dp_display_atomic_prepare(dp, state);
+	msm_dp_display_atomic_enable(dp);
 }
 
 static void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
@@ -152,7 +153,8 @@ static void msm_edp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 		return;
 	}
 
-	msm_dp_display_atomic_enable(dp, state);
+	msm_dp_display_atomic_prepare(dp, state);
+	msm_dp_display_atomic_enable(dp);
 }
 
 static void msm_edp_bridge_atomic_disable(struct drm_bridge *drm_bridge,

-- 
2.43.0

