Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AED3CD6E79
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:47:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D32AB10E1EE;
	Tue,  9 Jun 2026 09:47:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jwbWXG4Q";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SFEOHNSB";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2512510E1EE
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 09:47:51 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6597rJGo1585639
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 09:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4GLG60vKqqPhXSK9u7LFSK5eRlVCZiWpAvGD6R5I4zI=; b=jwbWXG4QsCbakz1T
 QRLIlyesxqjVyud+B6kdO3KTVGd2Mq7yA5+UGl2mW/8DWMSXeA+s0fbD7oMBIET5
 +BIPMv8iMosABtSfnTGVIkEsmSpMXUpj1/sPN2uQ/zlsK1D1Ht64x2Sn74ri6aqy
 +S2aluypkX3MUWGc851kcx62+wdrmiCZBEY6n2i2pbvI3vYqmpDQDl4qid6T8hmT
 E5WklZp7rrat3Wa+h1Wotow9I2Fx4YEO64WwtDmD6rjKkQMnxrmtK3Emj1Jhm/zi
 frMJMRofXiQbas17ZcMtNUG88c1JBR1tA3hEE/ZZ3rmUJch1WqtcczJPWuvMX/Us
 McnjLw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeqgggtf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 09:47:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-915d1d4fc5aso384097685a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 02:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780998469; x=1781603269;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4GLG60vKqqPhXSK9u7LFSK5eRlVCZiWpAvGD6R5I4zI=;
 b=SFEOHNSB9F/m/CW9DtW0jYhM5pDO1LBU5E5DaAP47CIjjui5v4IX9qyM9Or9rD4gWc
 F9qMxO2UB739qwHHc1odZ8+aIrpdpR0V39VuvvoMZwWCWOI3jYyQWxDFWLhYnwQ4BeEq
 16mFoTPGDeE+M+zgvxXFhn3ommpZO3YSmbFfL35/01FDuvC191WmMI+0XUqG6LKv7RB0
 VRdAw3SXMrvHyi4W0zvEifz/klOozgtBRivrl+CMj+FfAlftvTfsC//7ZIr0prtZ4hkW
 QD9SPm9pJ29virSXgwxc0OfLcheIfcxbb79iG5jbH6U9vWCrL9MXruJxDPIiFJUI5P3u
 Osuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780998469; x=1781603269;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4GLG60vKqqPhXSK9u7LFSK5eRlVCZiWpAvGD6R5I4zI=;
 b=WM7NoXYIvwdqk6JAV2vEqGahZ8v0pj5ZV4IQ2c0W0V7b6+OO8pdhalFPp1E60upsav
 PiyPm4sM+mtbTxa0ngbB5kABt4hUe3C9ZcrPxjNceCGbxrFNrq91eL9fJYbzHkFcp6MM
 nvksyw6RRr+SdorTjggqpj47IL7xbg4KDmrJg0qpeHr13H9k/wkDFuszkAV42XHBnKzP
 EfM0akIRQfjecmDZdzvEZkKNztv4iCoRJBiA+QIIaizLIp2vmYebDv9B0dEUWUSJCeuo
 9nBx950v2IN3j0qTn6aEVSnYbYQFbGudBsiCwxXU5SHUW8shM56Kl2KRBM9pvYNcTQ3H
 OG/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Pbykk6bmv9oWYNfNQ+i15cFskKWBH8qVitmcc9A9CcqJkZXEXO98i+wyPin5PvyazNwfZOZsnmgI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYr3RMVdy3N7KYTCTfnsCiRguCu8c4scUtGksfJkKwwQ0LjTJt
 Pe4QWS6A/VLIgBU3kufaREQyNZKfjYTCMeaj2tCndksTetH8WBQQlDwtxaf6Gxbsu8UQnRaHcDx
 /BZBOOOH3bO0z1HO1IenhD18uO4qMJuAMV33bhbFfCrtodtEZmPQRYFuaEobHhHpt2ANavS4=
X-Gm-Gg: Acq92OHUpLoPa43B6lTxaOW6YCDEeqwebsuXvebv87wPqHxBqZOZ91t84Vw41d5YB91
 41P82my8KXYD9NlixiEH9UEyo+kdGPBYkxix0LxwopVQ/AXwR3uflx4iYRjzTDQg8bdCK37kucH
 LMD8PLJOSYjrQT2nKbGNubD4rGOHqgDbMt+qmOAcrsVM3erJ8dPdbQjPBXhQy4MHnu/xk8w3cJq
 qnrD1BxknArvCWVTcDikb7KcCCZcXEgwtgwRRUIX4WOYgkiA9D8FqzkDxJGeZF+yy4MJSx05yok
 zH3Hl3DJFNlH3sYQ3ZiR4R7QCx03WQ/h8krRLaeJJyyo5MiUqsTq1T3TyLeupzwO4DwQaPaOT8Q
 fljLEAl1hyaO/EXJuWIumw4FWoWWZ6m7llGDqyi35hwRGadFgc6jj8RNHcQQGBIi+y0ek6OFOy2
 m+MLxldO6SUWQ2MqHPWg==
X-Received: by 2002:a05:620a:3186:b0:915:81ba:4071 with SMTP id
 af79cd13be357-915a9e098f5mr3148080185a.58.1780998469151; 
 Tue, 09 Jun 2026 02:47:49 -0700 (PDT)
X-Received: by 2002:a05:620a:3186:b0:915:81ba:4071 with SMTP id
 af79cd13be357-915a9e098f5mr3148074385a.58.1780998468486; 
 Tue, 09 Jun 2026 02:47:48 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a00afafsm2047489485a.2.2026.06.09.02.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 02:47:48 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 17:46:36 +0800
Subject: [PATCH v7 14/15] drm/msm/dp: separate dp_display_prepare() into
 its own API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-dp_mstclean-v7-14-ea04113e8233@oss.qualcomm.com>
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
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780998393; l=3743;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=PejPis5lPUmTa0t10X2rGcGnHfGkWszn1oUEuwhLLv0=;
 b=WijUeIalYja5wc6YJaju+YjwJ6B6aB82NXj1CgEZFrCY8AbHyt+izfR8DIFRPfig0Bqoys3x4
 y7AHTm4eyHgBXEL7+fh93uvaWTePL7GNPjc4Kv4y/u3RSoTm67i1j9W
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5MCBTYWx0ZWRfX4y9HPcJRTkc8
 EX9qC/Cpo+3N/yK6ZcavvzwXCeFJSW4zReXzEm4jaZWcru2vcfQzBrKunThR6w5OzxTuRIPh+0R
 HuDnOKQGihDMwlYWKjE5KCl6RptRtOef96+fgCsPQUM29AbMalivVe05AVsUHHzwt7wWXpoRqfl
 D2BTJAz3Yt0hRLClFTeH4WFuzM/LZn4LfhD9m0yEVWiJcwvusac1nI38tiFGkIUdK9XMq4qYahf
 aAL9z07ZdRDXbd6emKHIQgLm5eyud5+DSea9DpMEgI3rLFk2tccCjLn5XQArZK6B8he7tcLiqBM
 MUIXDcQyNechP5CvY3ae5MHE93fy9/ODigbMprSwVjPrcAc1OdZKuxycj3zQ6ZF8b5yifUSA5/L
 gLhKdpod1f8Zw42UDBQD1s7Y4+NebRlocdH/IPAfJbcM2uwtu9VQ81aKE9x3JvJ266vJV5znH5V
 eKxXm/IS/cNnTfROnXg==
X-Proofpoint-ORIG-GUID: CHM1NCXbUFugifdRFbbHClyOk_d0qQmj
X-Authority-Analysis: v=2.4 cv=KdHidwYD c=1 sm=1 tr=0 ts=6a27e146 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=rHTcTV9uYuKpyGuOXCsA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: CHM1NCXbUFugifdRFbbHClyOk_d0qQmj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
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

