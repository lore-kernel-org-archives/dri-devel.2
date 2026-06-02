Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586C2CD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEB6710EDB5;
	Tue,  2 Jun 2026 09:12:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eBhbMY4a";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h86+3FZg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D860410EDC2
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 09:12:32 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65262coo2688347
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 09:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4GLG60vKqqPhXSK9u7LFSK5eRlVCZiWpAvGD6R5I4zI=; b=eBhbMY4aeciroODC
 ciMEQgeG4o3hgcWsdrGbIzXENThOO9YJVvnDQqAo0ezoGf8S8Md1UWnacr/w4jWo
 JQTJG5So91z1K7YR3Vgp+J2wmP5KYffqRPQ9OYOoRJh8tkaFU7+O/TYNKA0ENib4
 h47hzLobhlqUw3xR0nKc3kxqKTaEubVPNhtXQifhskY/Pb2K/gI7kh9dDYZ35Bxe
 kCnIuaKO4xU0ItxsSVquH5ISRmr0s5yxht8bpVDsBxrKvNetcYiZqohwLECJaDpd
 +1XbNTeZMysXuCR9qCeoUdpVpbaH/YCgJCOuPYSzPWXG4dotl7znhhivOiMCtGQF
 sfEz1w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsja8rp1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 09:12:31 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ccd51bc2f5so123846456d6.2
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 02:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780391551; x=1780996351;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4GLG60vKqqPhXSK9u7LFSK5eRlVCZiWpAvGD6R5I4zI=;
 b=h86+3FZgoFnkCASQJ2MbdV/2UQ8I7tHAPuv9kjhCofZhk4S/GkwL5Jj4dfFaVack2/
 gljEvPPipbRmGKz5K5RYG4jdI3WVksWTWVJl4DVIzh6wK7zFBAKYzpYdbKeyvpjbCjoQ
 t4D4GQ0j0x/cS+zYBIxBjxByz/ekMkkKmlWYI4nxJFIjh/8j6zzX7nVBRqM3fRx1eLCG
 d4PuOJMvzaBdiu4YrgCMk4lCxP4SMqyY2iKv7PLNpK+Ei7E8mFnx4oOizpLyKr0YafQ3
 U7+PR7WWclhVHPWVn1fAVQJ/hTClI6upAegwhxyA62n4Dl1fvGmEHC7tn4N2CiNNEL2q
 0ihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780391551; x=1780996351;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4GLG60vKqqPhXSK9u7LFSK5eRlVCZiWpAvGD6R5I4zI=;
 b=qMJdlfFPBVdR5eSlr4zVWUItJvOW5MFQsbbDwqw1S0rJxQ/xFQnJ+jJ/VeUKgkAO2O
 JdypbFlLpdqIRUPt59kL6Wcv2afY3nubToihmKlHnpOW921n9R2iJW+bwV0jcwAFEYVR
 8pf+HhwgNexiryM0SUhSOUrhUEPulngNASxJ9cOaEQakYhkkahvoTAAHx61G/+Pvf6VX
 LGDcSXYMoWjv4otphFswgOOvPFCnZMRNC7KWkbkG9jtxcR5lqF1il+rL8BKDHZND/5Jp
 8kfZR5eMIIrq4G9JLvO95sow7F4bOiYJMXxLzhwJrKqdl0uwwZpvNIZYqZAotrS5HwNh
 nGmQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ90S6LCVjiBz/7rnnXgdKuTY/eicWOxZ/XJqb5oqDq4sUtrqhHpMl3IQ1jTMm4Z6CaT6YCKS9TdSqk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy3pg+BzMlYXrHm/iTvicwTjoOw8l40fjaIPCPmewvzGkEd9H1k
 TJdHxl70O0xZqxeUjT5Qih5UfaTgAfssKt071pLugHLn7EzZYY2bhC9icZUudY+V+FGzdg3NtqC
 cg1BpPrK8vGyhcURvyr9MAtH8OLGaTvhDbkQNbRW2FubT8cI+TdkXG4wzCRknRRgJWR4TKBY=
X-Gm-Gg: Acq92OGukWgEqu2URn7qlwNvgSYg0VKQbpe9es9D9vzfIkLR6yiruqbCO+QrI4ax2M4
 yXWI5zgeHWRoS2UiBKW4vdMhNXxcSS9t7bZyyKYWt0kTqGoBCNIRmMZkf9aRv3tSWY5gG7Ysrfb
 DkAMOlv84DdErRhg+AT/5YakMYXsRGkTBPPlmnDwo3O/XRAoLZxdnjgksXqgSJ52e6AA4flrLRM
 cfcLsRJUO4PNhHPaq7rpZw5GA9t4wdk5ntRntvsGajHVN3jrL+3Qa5RuTMAzLkI6JiUQkWdVq9W
 6OpXvZ186ns/rRvw9piC2uVGvuDbIQmCybIUljShPJHCQBe/5kzZbsqSach8fdXZq92RvQKHwPH
 Ig7BokIaTQaxPSk9xKiD8E/AsGYERVUZeOUMCdE2I9O4JFwjBq893ZxDA0DMRwq/XRp2FkcjjB4
 GvButNIbej7S0iETnzqg==
X-Received: by 2002:a05:622a:a6d5:b0:516:de98:b670 with SMTP id
 d75a77b69052e-5173a935333mr173922391cf.39.1780391551279; 
 Tue, 02 Jun 2026 02:12:31 -0700 (PDT)
X-Received: by 2002:a05:622a:a6d5:b0:516:de98:b670 with SMTP id
 d75a77b69052e-5173a935333mr173922081cf.39.1780391550806; 
 Tue, 02 Jun 2026 02:12:30 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51768c76e53sm12480851cf.4.2026.06.02.02.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 02:12:30 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 02 Jun 2026 17:11:26 +0800
Subject: [PATCH v6 14/15] drm/msm/dp: separate dp_display_prepare() into
 its own API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dp_mstclean-v6-14-2c17ff40a9b2@oss.qualcomm.com>
References: <20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com>
In-Reply-To: <20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780391476; l=3743;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=PejPis5lPUmTa0t10X2rGcGnHfGkWszn1oUEuwhLLv0=;
 b=I+18ZOiJ7T4ONemocEPsWLpHYt0H8WenXnbhVc6cN2xPFnXd5W9vUP4XU5Q4tlH8EdE14UKkY
 WrAY17QYSsIBRzi2C83dmPZfd1OI9JGrW1Z8NpFjKazrt8mnysyNXsD
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA4NiBTYWx0ZWRfX2BPbX/JAUsX9
 embILnk3+g1B7RWVvBpvevPo5cK6fN9X3KajzBoikbNk6lFpZPId96+RWW9/i7JxsGl4mNpb43q
 RGOd1Gp1E5TLc7suesUw2aknB3Dw4z1CLdoClrnZI4Jmfjol8up294Y0q86o9WVZb2e29EQ0sqK
 /UODIsRG/kLrq5Ow0nqvAyudjeKeHEl2xsY+DSZTZleA6rT9SwRVCTWdxFnkargP0EeS2I4TjW5
 sNBwTKxqAW8wziOcXb0FpRgip8+2PeXYszEiIEsLmGZLP3bd3fAlv3D/D9uZhaMOehG2Naq+74e
 S6Ltp5nAYBwf6KyZWt0VylLH4s8xD2u6KKvsKYjua9Ef2M0sPcbvuvEFT5vk6y0WEL66mHmYStd
 meGr5nXTt4053G8xLeAM1A3GghkmihZWU7CM4EEPQ20Rat3EqLlgu7fqHI+Q8xIfmoSabGYTGUm
 V5YB8uhL4xzXcU2+Vng==
X-Authority-Analysis: v=2.4 cv=Ld4MLDfi c=1 sm=1 tr=0 ts=6a1e9e7f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=rHTcTV9uYuKpyGuOXCsA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 4EHFlhbpQ7BtzDBrIAxiMpxbnQ30HPbZ
X-Proofpoint-ORIG-GUID: 4EHFlhbpQ7BtzDBrIAxiMpxbnQ30HPbZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020086
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

