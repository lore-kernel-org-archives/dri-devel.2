Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF9E107BCEE
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 01:09:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC67C10EC70;
	Sat, 14 Mar 2026 01:09:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IywVHW35";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fTOsEnhZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AA8710EC70
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:25 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DJC6Sa525628
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pzVpX0vOq62SAEgnYrHTEusxqWZeEyyGEwRMXWbZKk0=; b=IywVHW35D64eBKqG
 BeOFZTrqkA5iVDTNsPer29OPudwL98ljqgD1eHAgkV9NbKltw36SGsQ3qK6QnlxG
 Hn1cM/F5e1tTwV0G4FB3h149z621eZ5dE536ngDc5GuXkSt1xpVRJDER2FKLPk5C
 tYpntrKrtFkI0uS6m5iwy08Efg3UCGabyhS2quixuKvUnQY8frSa1zLFazPNJCx0
 Cj9PM7qNMbwF0/n9yVODjQOpTxtCno19EEn7ZXLS5tjIP7CHi+4NYXzHCE9y3TzL
 ueB7XjQk9bNI6NL1rotvjwB3+24vk1ib0brCAapv3woMJLDCkEUdEjaBbj/4HXQ8
 j0bYVw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvh84th7v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:23 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8950562d351so57273576d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 18:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773450563; x=1774055363;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pzVpX0vOq62SAEgnYrHTEusxqWZeEyyGEwRMXWbZKk0=;
 b=fTOsEnhZNCrkbezPtoQf9nSCu4rCmKZHMdQ8nlAFgH2s+8oyP2o66gDp7q/W8PuCNn
 byt/0WuiFTjtnG4NA4dpzDAxV5p8gZ5Qv5Ej56Jt72YAF9M7CLovSo/u7xws1XayBsiC
 GX837GcGyEhliDWiYr/UxV7AVHmIAhshraExpq6Y02ojQ5+t4XsK97zSI1S59sMC/yMR
 bAeILDYiE0R74aXQthBmXuWBh/BZ245ZCX/oX7rM8g27gF7UJGgjJ+8R0Gdcyk79YP7k
 iPcdVplkltrhJy5tNe3XQirDlb7P4lpN3gmfxjVc1R+Uzf30Q7pGfhz6yjRjWz521SWl
 94+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773450563; x=1774055363;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pzVpX0vOq62SAEgnYrHTEusxqWZeEyyGEwRMXWbZKk0=;
 b=hI2NyJuzffV9ve1oEy2jtkTi5eb6cY/n0N6n03E+wk93aZyBZ6wti4t4vFB/iW7Avf
 hYxSFmpSkGqVOY2QmEVMSnuKFA4stnapRmSdH1ox0cEnQHAnD4BDONfvkVUvb8NmUrFZ
 LFdzug0L+25okeuEfwU8Fix43ugPnKxPDeLuxUacvTFNgfhCwNkqQ+0fJscu0TnvmFfy
 JZnO41Hh6bUFPfSWJn6EictlHyYFqUHoXFFMJ8U1TDHTjqlIVq75Lom7q4XVu5KjlkNJ
 yuY7vSd08On+OLLXFPfD7NM6xMg5RyBb4mRD8Z49pgPAE25wyzZR89pozw7c+hfzOKr0
 ddzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfIq5mgDplOkUgacfqPQ6dBIejKDrdOx6iIjX7b4gW/XXwEBdOJyYQJH9mos7QKTtu4E8AVODg3Zw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQDGI1IM019juXiUmJ+P0ySiIk4/asTetU4PUzIQZPc2dhody6
 ORhuIish7/MWbu7blg4IqRvdOqtwmNc0DOKPltyOTrgrGsQ0tJUPVe8QPcJ/STvrR9TmT2XqQYp
 rouKSLoEtr3X+zLSNo3ed2BrQXxhoP/s02PHle1MzACx5GaI4+6+wKTn4Rqj9v2EWMLFCDaw=
X-Gm-Gg: ATEYQzxucnYZ9bOUHEwCiZncaAZWQVBfkAVK91g10kMfSMkYfZ3wCh8IocOIqk6kjab
 lvDQv/5HHo9mZiX2a7ljkmThVBLPmwaGJQRyVXIzW0KEYVqGL+gjXl5hEyVHr6CF/ZwUoJq35sn
 jY3j0m92Jx+i6B1VEQ1CqslG6aLPWChs4pAqZs7lYnxbhumgd9lIgOhuOEVgaJVEKPAnP7rm0p9
 PqANtbJBjOEsuuazrGWq+0j23UJrDe7zJIH3zT/E3xdbvKM3htBRdvZUuDgkL4n6Gweteg1+0Tg
 +WnQVOT0+KeuIAG3q2eRVKz1+5AG4+iZLcQ35ZIvglKpz+dO3Z6Vccv32ELHZs1HwKkeO4Gm4z0
 g6I96IWOqk4yePzwrXU9sLIvU4f5Q3CPZgqU/Muo4eJIHwOI8jyESMVE7tSgObbg+S+AeT3T52a
 aZ+m/mQ5uA842QRxSxsBH/8t5qgmZN29m5/es=
X-Received: by 2002:a05:620a:3195:b0:8c6:b247:4c with SMTP id
 af79cd13be357-8cdb59ff4aemr800776785a.2.1773450563361; 
 Fri, 13 Mar 2026 18:09:23 -0700 (PDT)
X-Received: by 2002:a05:620a:3195:b0:8c6:b247:4c with SMTP id
 af79cd13be357-8cdb59ff4aemr800774585a.2.1773450562940; 
 Fri, 13 Mar 2026 18:09:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a156366b22sm1806805e87.77.2026.03.13.18.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 18:09:20 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 14 Mar 2026 03:09:07 +0200
Subject: [PATCH v5 03/10] drm/msm/dp: Read DPCD and sink count in bridge
 detect()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-hpd-refactor-v5-3-0c8450737d64@oss.qualcomm.com>
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
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4422;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Fflo70A3oSMP6LkHXNPuDEYg6XV8ot0GBkcmgzq2Sd4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBptLUzSX0Yvt+mbPHdcgYX/8JV/EIlm8oX59QLb
 v7OgZfSiEmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCabS1MwAKCRCLPIo+Aiko
 1XqFB/9wKZJq9LxL11bSOqiNpbCmdspf5rAtBMF7Lh/1flH7eirIkNkwtuSh1f1lOZmHQod13v5
 6SiTzPdY8EHcz9CEe/qvUi5t6qroB83+AjUz7D3BNy3whNHMYkfRdRkX8zcu9V2CD2EG5JzmtRE
 QALNFS74iW8+b6A4VekcaL9OsCajS3FphsdP+n+i5U3pr1dB8U4gH64SrBBwavuLt6Y7tnP+fJh
 qNnEfLmfE4yP7Ij/pwJgb2BPxkd9Oag40r8dPnqzwJrpH9GaRzlO6xKeT23k4ZflqtnwuTcrR7a
 GIUPfSUx5TY5HznvwPHI/oQmPBzcsfftHTDf6N961rqB8DBE
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=OMoqHCaB c=1 sm=1 tr=0 ts=69b4b544 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=jcEwYMPARZwhhGfK5pwA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDAwNiBTYWx0ZWRfX31JHKfF4GKC2
 2FenXLd3RkRTHVTQcIYY+6sWJUN49cfu9oCRzysM5sfLW9+iXUuE1/PzaETqjc514e4zlzEn50V
 2bTyd33ar0PdwCS5M0fOc1tEaH1HuuFOR76ot58M6tm2wW8mlUaGAXcEZ9G2kIt7btkFAPCNQpd
 Crgl2Ab4CzXqYj0o5Gqd5Z0SIwjDrjf3JrT3JPSAI4XyhLyqG+kDRA+TdiGKaRV7qqZjVdkDjC8
 v7rqKGfnEOlF/7UZLhaY6FFaZGYZ1ybH3Jnfz0m4/bMa/O2fuU/xXep3Yrzl6h1FwPLXzUcvbQ4
 OAMz13pPoCSBgKg0Ek6zK/IS2p+gQ5514JCG6PyInAQxi/DmTB8pGoyggnfD0pYUWkWTQLPgKxk
 ODVkVZJ5OwTyXbXC21qYeU1HS0C0N5TEbdBqCx5szWDiFJO/6ojuhMvlBYsm6tDM/kzPR0Ec4Bp
 bwiHerZ15981k+fO8YQ==
X-Proofpoint-ORIG-GUID: sbY1m88oOE0k1rbglElWH4jmXPLwojnj
X-Proofpoint-GUID: sbY1m88oOE0k1rbglElWH4jmXPLwojnj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_05,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
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

From: Jessica Zhang <jesszhan0024@gmail.com>

Instead of relying on the link_ready flag to specify if DP is connected,
read the DPCD bits and get the sink count to accurately detect if DP is
connected.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 60 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_drm.c     | 20 -------------
 drivers/gpu/drm/msm/dp/dp_drm.h     |  2 ++
 3 files changed, 62 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 5997cd28ba11..a05144de3b93 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1151,6 +1151,66 @@ static int msm_dp_hpd_event_thread_start(struct msm_dp_display_private *msm_dp_p
 	return 0;
 }
 
+/**
+ * msm_dp_bridge_detect - callback to determine if connector is connected
+ * @bridge: Pointer to drm bridge structure
+ * @connector: Pointer to drm connector structure
+ * Returns: Bridge's 'is connected' status
+ */
+enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
+					       struct drm_connector *connector)
+{
+	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(bridge);
+	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
+	struct msm_dp_display_private *priv;
+	int ret = 0;
+	int status = connector_status_disconnected;
+	u8 dpcd[DP_RECEIVER_CAP_SIZE];
+	struct drm_dp_desc desc;
+
+	dp = to_dp_bridge(bridge)->msm_dp_display;
+
+	priv = container_of(dp, struct msm_dp_display_private, msm_dp_display);
+
+	if (!dp->link_ready)
+		return status;
+
+	msm_dp_aux_enable_xfers(priv->aux, true);
+
+	ret = pm_runtime_resume_and_get(&dp->pdev->dev);
+	if (ret) {
+		DRM_ERROR("failed to pm_runtime_resume\n");
+		msm_dp_aux_enable_xfers(priv->aux, false);
+		return status;
+	}
+
+	ret = msm_dp_aux_is_link_connected(priv->aux);
+	if (dp->internal_hpd && !ret)
+		goto end;
+
+	ret = drm_dp_read_dpcd_caps(priv->aux, dpcd);
+	if (ret)
+		goto end;
+
+	ret = drm_dp_read_desc(priv->aux, &desc, drm_dp_is_branch(dpcd));
+	if (ret)
+		goto end;
+
+	status = connector_status_connected;
+	if (drm_dp_read_sink_count_cap(connector, dpcd, &desc)) {
+		int sink_count = drm_dp_read_sink_count(priv->aux);
+
+		drm_dbg_dp(dp->drm_dev, "sink_count = %d\n", sink_count);
+
+		if (sink_count <= 0)
+			status = connector_status_disconnected;
+	}
+
+end:
+	pm_runtime_put_sync(&dp->pdev->dev);
+	return status;
+}
+
 static irqreturn_t msm_dp_display_irq_handler(int irq, void *dev_id)
 {
 	struct msm_dp_display_private *dp = dev_id;
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index fd6443d2b6ce..e4622c85fb66 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -15,26 +15,6 @@
 #include "dp_audio.h"
 #include "dp_drm.h"
 
-/**
- * msm_dp_bridge_detect - callback to determine if connector is connected
- * @bridge: Pointer to drm bridge structure
- * @connector: Pointer to drm connector structure
- * Returns: Bridge's 'is connected' status
- */
-static enum drm_connector_status
-msm_dp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
-{
-	struct msm_dp *dp;
-
-	dp = to_dp_bridge(bridge)->msm_dp_display;
-
-	drm_dbg_dp(dp->drm_dev, "link_ready = %s\n",
-		str_true_false(dp->link_ready));
-
-	return (dp->link_ready) ? connector_status_connected :
-					connector_status_disconnected;
-}
-
 static int msm_dp_bridge_atomic_check(struct drm_bridge *bridge,
 			    struct drm_bridge_state *bridge_state,
 			    struct drm_crtc_state *crtc_state,
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
index 9eb3431dd93a..6c0426803d78 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_drm.h
@@ -25,6 +25,8 @@ int msm_dp_bridge_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 		   struct drm_encoder *encoder,
 		   bool yuv_supported);
 
+enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
+					       struct drm_connector *connector);
 void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 				 struct drm_atomic_state *state);
 void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,

-- 
2.47.3

