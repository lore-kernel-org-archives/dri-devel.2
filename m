Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57691606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YnTl3mhy;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Pj7vbyJw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACFC2112142;
	Thu, 19 Nov 2026 08:25:58 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2179F11208C
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:19 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6vO53052991
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XOHVnaPKkMDqdaS1cO+52v94uYEDVhjrO809duKaYuA=; b=YnTl3mhyjA+WWrmB
 b0TzpetdCrR3QHD7F06hokLbFKG3qHo0tsSRK62YREmLrjGtyuk9Y1NKwSGnTx9q
 CeIx2G154Lt0FvblJ50ZigNL2HbrZaD7C4zgvceNY7yxQ7+kZ7RmHidHo0eGOppj
 2sd3W1dPi2BQZgQ/nQM8OQSqbJRyRrFfxi5Zhmc2eDAaafln0e5qJpjqvmxO6Gmc
 2Qsv4hEp4M0UhjxPlCX12DcvNzoojBy4VLcTCJoe7iK5njUzQLmlrNAvntfDQM3X
 8he+I349RdjzJuPLDVWc6/qgPcFLRYOANKwevn2cvTG/+nrf7PjU/MilbUuHSpUl
 lpCtLg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1g3bbghu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-949b0d322fbso39324485a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076717; x=1795681517;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XOHVnaPKkMDqdaS1cO+52v94uYEDVhjrO809duKaYuA=;
 b=Pj7vbyJwASehFQ6aG9FHhhcYSSgYXWH+OG3spSrkxTC1h/lh5Ug05skKZLgMIBpszc
 eMmWdu411yjx2+FnHmrEnYMBSRRJkpaPCLYqm0uY03bd+XCBDiab/82SzHgXFM7iCe3x
 BliTdmeE0HFAYlfaO0nSDJFa1rwkcyip12/l5MbtM2iwNUcmhhSo0TWOLj6FVqZMqGv4
 zF0rO8SxNAUwCUnJQFKqTl6j/e6CcLQa+F1o6Xdw0mRr8AreSZNxHULHnkOidmRJiaxF
 Ltb6yzD4k/aELBQCEjyGeHzi3p0unAVdwheEOCINtzrbajg3DNLewL2O2SQGt9nLu+8Q
 G6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076717; x=1795681517;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XOHVnaPKkMDqdaS1cO+52v94uYEDVhjrO809duKaYuA=;
 b=esNNiO1Kt0pUPnwtZLfdRUp2F0zu0NAOzBD9iLndlHRI53C8RdkgHGm62Y7y29E5sZ
 IgUsaQc8tNvRQ0tQp2uCQQclT+KeK4XJ29+Hz3ugE7gG6UYReLuESdh0A73jZCxF5MLg
 7tJkO+lmB0765pb3/xBbovKDyeZOSrKcokuYH5wqI2l6elNP5TIJQu2Sp3x2JwkZ2h/d
 mWaZa7iS+5vGaYS63hKUDIKne8AshckB3lNyeDD7xCzsE9e1S65jv8VJZ6t/KvOeYpBE
 pVbYT/tgPXzbNpAtJ20N9rZbmjovyNYNvvtm1ZzBlUPXX057K/8enMjokFZ6pIco8rPL
 VuRw==
X-Forwarded-Encrypted: i=1;
 AL+hErE3s15T0gUX/g7oSVBXlemkIY/RRfBCtG+gZvk4d2C3szcWNgR1NLDwvS5pTfUymtvCQqWYt8yu678=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z99w4Vqo6fM/X8s/oEvIseNiDxl3R5pdEWTruSURrTlrd0viJYN
 DyVn4bttOXZWdEjsig4mCxP+eMMwexthZkhROWwRpyZKkI/RxyJK+aZ1uo3PGbryy6k1CQD/GUJ
 D4dJ2n6xLUsRhPwvDrgujNmMCxnzGt4KrwiYqCwWfBP1+XOpNkd0FWEzIwVZsjHRvEP/WjBY=
X-Gm-Gg: AYBFou1nDr6uyE9bHNDSul/gS6nbUkKzVKqYqLetda7D/I92pegvEzMWHpe5tZvwfd0
 ivvhRypX55kBCsXcFFlyY1Z5mRSQS9V3mVGA9EY4nj5vp7v7RJzK6tmXNN5vAofZc0S9eOX0ITI
 4HcZ9q/Mb9bUXaSOS8NYM165CzkxYxv/loF4YfTlx1Yq7ETQX3+W8WwANSE6ezJsjJLh8UNmr1Z
 tZrEyloptokJGMbxtryXYuD96Cy8ZDFgdlKhGtu9/YUjAnuoVHdUf09+xhkwMUxa4YdPRfKvIuN
 jMO/Fi3NYx3/IXQHRxcA+uN7tqEdMxH8w30zHYhR6MDqtHI86qHPnfm/wXPJDI4S4EVN1NkMO56
 IAtnoJvuGAXymaROV4tBcAsypsSHWJ9gPE3yfJ3FV3sM+WSLcmrmNmqto3NSe+R0kLMDH8pINFY
 L8disP2SPrYUBdQlxCqqWiE3JpOBiDVMUKbg4d
X-Received: by 2002:a05:620a:46a3:b0:944:192:85ef with SMTP id
 af79cd13be357-9499957e68emr1081065285a.22.1795076717169; 
 Thu, 19 Nov 2026 00:25:17 -0800 (PST)
X-Received: by 2002:a05:620a:46a3:b0:944:192:85ef with SMTP id
 af79cd13be357-9499957e68emr1081062285a.22.1795076716456; 
 Thu, 19 Nov 2026 00:25:16 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:25:16 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:11 +0800
Subject: [PATCH v9 09/29] drm/msm/dp: factor out _helper variants of bridge
 ops accepting a panel
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-9-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
In-Reply-To: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=9551;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=zite9a3phlMLvlDTVMJoeGqeBbIHHb3A2QWnia5l2xs=;
 b=f15D9QWIaMfx2neuyMuPeJOHYYB/yYwhsHk4U0cONAAgasKxULVSezhlK6C/xijE5eXvykpBJ
 37yPN9NKmZyDBp/EXHF+eiBSl7V09HONFz5wOxKoBKvL0yvnvq35wG/
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: lbL71Vinu3Jfj6bCOtHq1S_I-oLQH6K4
X-Proofpoint-GUID: lbL71Vinu3Jfj6bCOtHq1S_I-oLQH6K4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX+5PJ/DkEP3fp
 6aNQnLKKtaJzvaRek5sZIHqeQ8bm5msdmgUsi3gyvEyr3ywYJYCBJIP8rlTb/59WgZO64vBS0RF
 tD24NGZkanQhx5vsoiAIj8RX0daSsKo=
X-Authority-Analysis: v=2.4 cv=dZQVTnXe c=1 sm=1 tr=0 ts=6afeb26d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=10mNmtCk2Ocqn4x3vjYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX5WVjrP8hXtrO
 uSJiKx77j04+1ZT5Xes7W1cM9gZ2pTQ8dP9dgDwGbKQpE3R+aGeHr16kr2DP5MfiM+wsKcMI2BE
 5JsebjwIFjKLAJ8CLeuNFb2BHw6F7cZQBSdoYDzZ95bCAkWq3L6XJOOgiMzUKKAXSGZ+0IMCO/2
 XKr9dSBA4IhPEzHISI4cejp1UgbganCdtzBgf1/p5PRn0A41psqqqiAJH3NDp2tveKsjMGDJ+VR
 3xf95G5bmkB+umP+u5p1onmPBQ5UwvHn+38c3lK7z2Go3J3/ATqp99F77lPo328ME9Qh7Xs5maI
 Oxj3FU9hUiu64MQIeLFhiwZzcFDqiqOQUkmGgm67op6/R4k7KhTGrt/mKzHgWv97onX0t5jWcDy
 unWYe3X9QdMMEe1RjzfAMBEexVSOcMTsK8S/FFMre1YHtHBHPIhys+MBSNWUTJeudpgYQEGNgHP
 ncL2Mm1Hvse3CzMN8Sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190033
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

The atomic bridge callbacks (set_mode / enable / disable /
post_disable) on dp_display currently hard-code dp->panel. For
DP MST every stream has its own msm_dp_panel that the MST
encoder owns, so the same enable/disable sequence needs to be
invokable against an arbitrary panel.

Introduce *_helper variants that take struct msm_dp_panel * and
reduce the existing atomic_* callbacks to thin wrappers that
pass dp->panel. No SST-path behaviour change.

Also drop the static qualifier from msm_dp_display_prepare_link()
and msm_dp_display_unprepare() and change them to take
struct msm_dp * so the upcoming MST encoder code can drive
link-level prepare/unprepare uniformly through the public API.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 111 +++++++++++++++++++++++++-----------
 drivers/gpu/drm/msm/dp/dp_display.h |  14 +++++
 2 files changed, 91 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 169990c10b36..471085744c7c 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -632,12 +632,14 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 	return 0;
 }
 
-static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
+int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display)
 {
-	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
+	struct msm_dp_display_private *dp;
 	int rc = 0;
 	bool force_link_train = false;
 
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
 	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
 
 	if (msm_dp_display->is_edp)
@@ -1457,60 +1459,81 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 	return 0;
 }
 
-void msm_dp_display_atomic_pre_enable(struct msm_dp *msm_dp_display,
-				      struct drm_atomic_commit *state)
+int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
+				   struct drm_atomic_commit *state,
+				   struct drm_encoder *drm_encoder,
+				   struct msm_dp_panel *msm_dp_panel)
 {
-	struct msm_dp_display_private *dp;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
 
-	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
-
-	crtc = drm_atomic_get_new_crtc_for_encoder(state, msm_dp_display->bridge->encoder);
+	crtc = drm_atomic_get_new_crtc_for_encoder(state, drm_encoder);
 	if (!crtc)
-		return;
+		return 0;
 	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 
-	/*
-	 * The DPU encoder's .atomic_enable() reads the mode's YUV420 / wide bus
-	 * state and runs before the bridge's .atomic_enable(), so the mode must
-	 * be programmed here, in .atomic_pre_enable().
-	 */
-	msm_dp_display_set_mode(msm_dp_display, &crtc_state->adjusted_mode, dp->panel);
+	return msm_dp_display_set_mode(msm_dp_display, &crtc_state->adjusted_mode, msm_dp_panel);
 }
 
-void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
-				  struct drm_atomic_commit *state)
+void msm_dp_display_atomic_pre_enable(struct msm_dp *msm_dp_display,
+				      struct drm_atomic_commit *state)
 {
 	int rc = 0;
 	struct msm_dp_display_private *dp;
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	rc = msm_dp_display_prepare_link(dp);
+	rc = msm_dp_display_set_mode_helper(msm_dp_display, state,
+					    msm_dp_display->bridge->encoder, dp->panel);
 	if (rc) {
-		DRM_ERROR("DP display prepare failed, rc=%d\n", rc);
+		DRM_ERROR("Failed to perform a mode set, rc=%d\n", rc);
 		return;
 	}
 
-	rc = msm_dp_display_enable(dp, dp->panel, NULL);
+	rc = msm_dp_display_prepare_link(msm_dp_display);
+	if (rc)
+		DRM_ERROR("DP display prepare failed, rc=%d\n", rc);
+}
+
+void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display,
+				  struct msm_dp_panel *msm_dp_panel,
+				  const struct msm_dp_mst_slot_info *slots)
+{
+	int rc = 0;
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	rc = msm_dp_display_enable(dp, msm_dp_panel, slots);
 	if (rc)
 		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
 
 	rc = msm_dp_display_post_enable(msm_dp_display);
 	if (rc) {
 		DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
-		msm_dp_display_disable(dp, dp->panel);
+		msm_dp_display_disable(dp, msm_dp_panel);
 	}
 
 	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
 }
 
-void msm_dp_display_atomic_disable(struct msm_dp *dp)
+void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
+				  struct drm_atomic_commit *state)
 {
-	struct msm_dp_display_private *msm_dp_display;
+	struct msm_dp_display_private *dp;
 
-	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	msm_dp_display_enable_helper(msm_dp_display, dp->panel, NULL);
+}
+
+void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
+				   struct msm_dp_panel *msm_dp_panel,
+				   const struct msm_dp_mst_slot_info *slots)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
 	/*
 	 * If .atomic_enable() bailed out - link training failure is the common
@@ -1524,17 +1547,28 @@ void msm_dp_display_atomic_disable(struct msm_dp *dp)
 	 * TrustZone-level SOCCP/ADSP force-stop and a silent SoC reset.
 	 * There is nothing to push idle, so leave it alone.
 	 */
-	if (!dp->active_stream_mask)
+	if (!(msm_dp_display->active_stream_mask & BIT(msm_dp_panel->stream_id)))
 		return;
 
-	msm_dp_ctrl_push_vcpf(msm_dp_display->ctrl, msm_dp_display->panel);
-	msm_dp_ctrl_mst_timeslot_setup(msm_dp_display->ctrl, NULL);
-	msm_dp_ctrl_mst_send_act(msm_dp_display->ctrl, msm_dp_display->panel);
+	msm_dp_ctrl_push_vcpf(dp->ctrl, msm_dp_panel);
+	msm_dp_ctrl_mst_timeslot_setup(dp->ctrl, slots);
+	msm_dp_ctrl_mst_send_act(dp->ctrl, msm_dp_panel);
 }
 
-static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
+void msm_dp_display_atomic_disable(struct msm_dp *dp)
 {
-	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
+	struct msm_dp_display_private *msm_dp_display;
+
+	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
+
+	msm_dp_display_disable_helper(dp, msm_dp_display->panel, NULL);
+}
+
+void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
 	if (msm_dp_display->active_stream_mask) {
 		drm_dbg_dp(dp->drm_dev, "stream still active, return\n");
@@ -1554,11 +1588,9 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
 		msm_dp_display_host_phy_exit(dp);
 
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
-
-	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
 }
 
-void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
+void msm_dp_display_atomic_post_disable_helper(struct msm_dp *dp, struct msm_dp_panel *msm_dp_panel)
 {
 	struct msm_dp_display_private *msm_dp_display;
 
@@ -1569,7 +1601,18 @@ void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
 
 	msm_dp_display_audio_notify_disable(msm_dp_display);
 
-	msm_dp_display_disable(msm_dp_display, msm_dp_display->panel);
+	msm_dp_display_disable(msm_dp_display, msm_dp_panel);
+
+	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", dp->connector_type);
+}
+
+void msm_dp_display_atomic_post_disable(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	msm_dp_display_atomic_post_disable_helper(msm_dp_display, dp->panel);
 
 	msm_dp_display_unprepare(msm_dp_display);
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index b163954deafc..f6ebb3d409cf 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -43,5 +43,19 @@ void msm_dp_display_atomic_enable(struct msm_dp *dp_display,
 enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
 					       const struct drm_display_info *info,
 					       const struct drm_display_mode *mode);
+void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display,
+				  struct msm_dp_panel *msm_dp_panel,
+				  const struct msm_dp_mst_slot_info *slots);
+void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
+				   struct msm_dp_panel *msm_dp_panel,
+				   const struct msm_dp_mst_slot_info *slots);
+void msm_dp_display_atomic_post_disable_helper(struct msm_dp *msm_dp_display,
+					       struct msm_dp_panel *msm_dp_panel);
+int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
+				   struct drm_atomic_commit *state,
+				   struct drm_encoder *drm_encoder,
+				   struct msm_dp_panel *msm_dp_panel);
+int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display);
+void msm_dp_display_unprepare(struct msm_dp *dp);
 
 #endif /* _DP_DISPLAY_H_ */

-- 
2.43.0

