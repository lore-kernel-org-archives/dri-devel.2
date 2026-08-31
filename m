Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9DDC61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0620610E72B;
	Mon, 31 Aug 2026 08:19:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lq9t5lQD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AfKBe1ES";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE1A10E72B
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:05 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xmPF2824646
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ijqdpdqd4fOklmbBbFbJhuoyH/PigwN1E1PBP7ePCFw=; b=Lq9t5lQDFqSkLzMV
 puYPO3u+TyycIReAIIwXDV/k0U3k3b+r2Cb5+rPX4Ynl5ifeBQlmB3WCPu+Udiq0
 ARnSjJ62WiPF1wGkCzpCriUUxBzw1qwM5Pu8DtqXxYpdUaapgTsbawU+guW6KWKr
 GhIEXx4leRAhocNACrr3Tb3TbjQENLs/ZxkqULRl0fRfn9eJPWRaI/scs9jELah9
 7EHCAHbvZvAfEJQevMHOQq4V4MRXBD209T8HYRnMXI/LyhFrYoRN4vQyGsz6iQfm
 2Bt5uIg2ba8wCvhMb9gbAfafolV66tc/wVXHCt0z4jLcoMgzGocWcgjRf0ICarVz
 Es+Ijw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqe2ddbr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92ec3146553so772634485a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 01:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788164344; x=1788769144;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ijqdpdqd4fOklmbBbFbJhuoyH/PigwN1E1PBP7ePCFw=;
 b=AfKBe1ES5fGi/3Zcea25akGmr8xNWrZEidkE1w5yqwdeyxpQ1Yo8Swp92hga/Ywnmo
 VbmMkPMQezp+6UIN/8iJjEn7Y6thYKMrLSSc2IMA1tHArArSQILlqBcssCNW4b+WGGzZ
 8Dqj7C3RuT13dBkBKf9WpS+0n9z4mtvFibJ7bTwF76UwDQ8qP5t7ZPJjB7c1KLnLQmS0
 0ndl2xQ25yFbzyBbZHlCoiUK2kGBByAzRHVs4eGdC3zYDWV6OkEqcd90xA79RsDKQpsR
 PEB9rZEQs6ZerPJxVjkIz+QeiU2KnQeYMPilzdjgNd/RdBYD+YFWWzX+rwmNnFkqwhIP
 gurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164344; x=1788769144;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ijqdpdqd4fOklmbBbFbJhuoyH/PigwN1E1PBP7ePCFw=;
 b=qBb11OITtb9MTz9m1ag9S8XOZWnspEuudSJ17r3aSIHEhnCaVUY/BUzAnF/UGTXZFI
 zZMUalG+ZGW2mbwqyVt5uoL0SExXcxlu/kV+mimKl2BMCn64z19aogcaYPLCzTFKYYva
 LdZY22fbv6okfvN78ZJDYtG7N/LlAtTpx6yZ6YMxxY77t8Tma7B16X+t/3v1AfYDx0s9
 tLxqBdCjgMKa2xUGfqYGQOebbf8M8EKn6xO6M9wpHiDidsUVM8g6Ej0Cy5vq60C/Lpj5
 vdO3n7yPWOW5U8GIg23tf6vcujkg9Qw6U84LJDvpYbRRsZyGdKOWHbMnAbX2LPJxAkcD
 QUXw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rppm8e3+wEPPbjcdkcYW34hJLsMAL+RCMaagSwjyuh+ZUE6WLk572LyRF0B85Yk9+UvpgEJHrLxsXo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k/tAF9PjCRJQX4ZnhSkws629W8lk9cy1dWmMjvvkqi8i8ivCo9
 3VkL6zawpVJbn6W6EDZnKBzcp9XdXPlfNPMyKod0mZgT313iWNmBXPcQaAGWUXvq74ayy+E6glW
 zUPdRrHdzgpf09EqgQq35NacaVdr63h36rAunZeOlPN0mT88TqnFftCjbKe1EiQfDLbrvD1E=
X-Gm-Gg: AR+sD11oiHoxYLpGdATaKcLxyME82HCsCzY+jEbVemrxDjW4tDkFL42ZztzEGPVlADZ
 wCvUxkwA293gIPRtW59/fkhtDIpg0l7tCCeXYFaSbAWIpPeTduS4+JXeH3INdGoKH03YFi9o2Mw
 ZPpFVM20SgMDVGHTYMCIoi71fOZvRRadjZWn0123ywRvmuwyRcGYtUiKG7i4L66NFnO/M3WQ/bi
 ksXWy3ncD1EQuNsQAnDXshD3UvgTMO5KXsy3YJXVkFRVP1uEUmxT3BheaLjLGeOTWkSCAGfnzqL
 G3PogCvB6m2BybeFttOaVWHn5oOTKCf6YGn6O280My9jZue0el61GF1Nz3hkdfYzz57kyy2+6Xh
 hDU+A+RsSTsQc/mgNndxfLCNkqupV6QNyTaoBNgqzMDe7FFn5pPRZ2F3gZtN97Ho=
X-Received: by 2002:a05:620a:8ec9:b0:939:492:20ce with SMTP id
 af79cd13be357-939137b3b66mr1631238785a.1.1788164343905; 
 Mon, 31 Aug 2026 01:19:03 -0700 (PDT)
X-Received: by 2002:a05:620a:8ec9:b0:939:492:20ce with SMTP id
 af79cd13be357-939137b3b66mr1631236185a.1.1788164343495; 
 Mon, 31 Aug 2026 01:19:03 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917236b86sm735974285a.13.2026.08.31.01.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:19:03 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:17:33 +0800
Subject: [PATCH v6 16/29] drm/msm/dp: add link_ready to manage link-level
 operations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-msm-dp-mst-v6-16-c91d35d6fb9e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788164246; l=3537;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=uuB/kWSqCnC2Anxq2zqCZAxFvPhs/LbiFjZoseT/nlk=;
 b=7Bp9XavBeVerBws9xUJYdFSv1wxDi6k5IvyNyqbT5GQqdmLhWm2kwqkxJfELrHz9CUWC5wdRD
 qMjk71yKkgGDUpfILjeooKLCrqQiNs129OUbc/9OoFMPRoVJFQU14qD
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=Iskutr/g c=1 sm=1 tr=0 ts=6a9538f8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=BYzu2gpcbUJpO-7lbgUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: fS4Gtu41jEg8KS2tIY-1FUjlTR0MoKau
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX/8poioV4gnDe
 zdFb5NWgP9ScrHUYTcrFChAR4iUalf8TytjSvFMURNhGcMu3sMfEv+pCcQj51qni43tYoj/LmnD
 mYBRj/ygtSgPVvRQMmdpOQO/Vdeom+AkZmWFIeG1DDH+zGE5bfOqYdrOixGEOCDC4GyLqMnhvDj
 G3ubho6MWI/8xeen2p1RAmMn3yXYCZMeJbdWjI9/5ezPHls/y285XSmyI5M0HOzXQh8gkWvHKW0
 oiJ9SEjI4x5yTJpNgM+maQtVqDs7t3poqG6FE+UsN2hZLvJ1s1Y6d3wR/HNQSzPFClnWKNrYRXU
 zQdrtaRPbLR49BzwFlgsHz0PzTB/UGhkLJ/RLEYKbZro7HSob+9bjA0QWrtnyt2WCJ+taWQY3kC
 nOlVnsXYjkPCqWeFPKJLA9guuoQFDPCV00lNQjqbeE2qGI+cxlS69cTbUOAu7/9Zac9Q71TDpu0
 yCaeI9ilyHVNOjlRuNg==
X-Proofpoint-ORIG-GUID: fS4Gtu41jEg8KS2tIY-1FUjlTR0MoKau
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfXxxus9B6QLFop
 tdKLOMOpyfW3g2eBW/vp2gjXoqwIMqmfeXPJ0dXfaGkUxPD9B2WAFmn5TmkOKhJ9GAV0+aW4hYc
 kVEyK6Cef7wA/LKP7pEMRCEXCKdEJmU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310070
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
index 6103fa67f3ee..90e3d2c4ef47 100644
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
@@ -1493,14 +1501,16 @@ void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display, struct msm_dp_p
 
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
@@ -1543,6 +1553,11 @@ void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
+	if (!msm_dp_display->link_ready) {
+		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
+		return;
+	}
+
 	if (msm_dp_display->active_stream_cnt) {
 		drm_dbg_dp(dp->drm_dev, "stream still active, return\n");
 		return;
@@ -1561,6 +1576,8 @@ void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
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

