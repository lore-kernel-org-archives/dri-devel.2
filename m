Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA59606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LhLz8bQm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jKyuC3GO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC8AE11214A;
	Thu, 19 Nov 2026 08:25:48 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1083A11213C
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:28 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6vSEa2671967
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o7qUy0HvlvFPx895X7DXakonDGCAik9Q8QwzBTv5YkI=; b=LhLz8bQmSBppmM2B
 A5X1ak2qE7N7akZeCFoKRbbOQj7EuR2/uMqO98rp0clczIUEE+89XZenbHdGkXlJ
 nfLev7K7C9PFGBAUi2AnXZINQ6A2JDGMps/9x3OT/NG1f82Kl3exscmhfd+ZAl6W
 46HfkMqtSeBS4s97UeLPuMbmRQzHa+wCKEEFvPrkdxbxFa4IdsyZ1zrd1Er3FqTi
 QegFPZwDWfk9ufUdLOJqAIs/pTCgeQZu9g7tw1Tn5R+Vn33rlpRJb1WU7RvVYWwr
 dZ/swSlL001N0kQasiYk7yS3JGD1XIrRe7hKzm06gal3tmYa2bpWvXitqsbYccEP
 lbnz0g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1g9p3fs4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f20addba1so359884585a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076727; x=1795681527;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o7qUy0HvlvFPx895X7DXakonDGCAik9Q8QwzBTv5YkI=;
 b=jKyuC3GOLHHIXqg/cetOicLtP2KcMmJnxeYrmCvt3VQKpeuEfuXJejZhQR/MtoFj4i
 i8HY3go9sP8lXEh2dBYqfiKpmFEw2GTJ99KM+dUF4D9TtIT8EIrn45TYDVlG5afEQWuC
 Xb6VJnFxFZRuEvs0cbHbse1U5M0/LwyAutSAYEPlqSAHdkf/UF7qt+7rLQyn5V2FdNoy
 gghN6mw4hdis6GHZB4EZuR0lEfdV9Dx+U8f66ccVo2iJmcoFCN0/UG75PJoXt663/j+9
 UMk9uWjokawQxo02gV6iDMnmVMZf3fkDI0GCIKlPMvfZUF06NQRaRm2aMhODhpydR8TB
 0esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076727; x=1795681527;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o7qUy0HvlvFPx895X7DXakonDGCAik9Q8QwzBTv5YkI=;
 b=PdZWz34T5Zwui69xLTLfZ14NmgeJ0r1BmyQHe2Y7VFoWm0UJXw2szBUZOWK153nQiy
 B2bTVaMb9esZtAfxE6QuMuvemWCrI+DEFmiJCYtlQfXqohnIbRA7SdCHgdFMZC9a8wBZ
 wUQKShWg/XC7zWMct3qOqSJRBbCRDYt7hfwmIM9Ak0PAAGkz2aPRZFysVMnhKazbhsQ9
 dmymyVOz9QfsWI1/FQrkOQyxaDz2LAsR+k3CrGCfIY3QiqJFBl4Fp0iXLgPcuK/f0vgK
 tEwi8rKVSobfpsLMlh+D3qwm9X927P2zyV4iKWOZWJXP/DhkTilhRDoGL5yjJULK78Av
 NAdA==
X-Forwarded-Encrypted: i=1;
 AL+hErExDNwrgQNS25drpvThA0GNVyN024fufwTDwdi0zw7U5LK4Ej1nV4/KDi4PUr9uewef5ItSgSy2gLs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9+hT4vTOsXFEociCUSc/pWY7AdECqU/sgBWeB3DB2uCSyK5Acw
 O3SBt5GeNEw1wxQkvpH8yptKjvaUUIN0RiPSeH/gT9WwPdUcWBg+3pOttS1kA1uUdhPHEkp0/bY
 C14NjplezW8uAahYAXAlsedSbJFMspRI96YruHQvhUlAhY0LQ3iDJFsZRJm7caClO18RWKg8=
X-Gm-Gg: AYBFou0HSSzHUHoSiY4HqbEas5bIlJP8y2mlk/saytq2OjbVe8VSZIkx6A4EXiiie1Z
 PKwOYK5XcJI6ttyPk+BXhq3DzQMj6hQCYUM2mkCgUcuZd+uOXPSvIGDzvobNzH/kZS+q2Udfz/S
 OOyAuF1xahqbbWsmq5+74XWnRft6WJMU7Eq8AEGsVef9pnEqpRzpLD+FJLL62yyBXN6fEltyeUW
 4d2bWJz/wrJ8GbFMbrkKHkDFdZzOLRW7dQtA6oD51dNzSMFtUjI0ymEgzfac8HZID1mLo7rV0j0
 XNBKjNLQ79OgE5QwdQ4oi8MXF/nCXKp6JZtADfF6L+/ulTJPARAM0WeQ5NVUvQygLmsLZv/61yE
 rYY2QsqSzth5vK0HeLMGbfR1YPVkMJZCyxtWd4fW6emgE5r+es9RWLZR0oGwbY8cEzkfHiBUxO6
 2sru1CaYrBkxBMrgDwhrgvJQstCWnv26eRA6JH
X-Received: by 2002:a05:620a:28d6:b0:949:664e:e3e8 with SMTP id
 af79cd13be357-949997274acmr1001046385a.34.1795076727268; 
 Thu, 19 Nov 2026 00:25:27 -0800 (PST)
X-Received: by 2002:a05:620a:28d6:b0:949:664e:e3e8 with SMTP id
 af79cd13be357-949997274acmr1001043185a.34.1795076726825; 
 Thu, 19 Nov 2026 00:25:26 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:25:26 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:13 +0800
Subject: [PATCH v9 11/29] drm/msm/dp: add msm_dp_display_get_panel() to
 initialize DP panel
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-11-ca61be4edfc3@oss.qualcomm.com>
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
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=3825;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=8dXh7kevZYuIf/EU/BTs/0N8fVWktZ9YOwTAYB0jJQM=;
 b=Qnzn/Crmjsg37VxiYwfrU/Elr3oFWpLhpq3Pbi5cz8hI/ttX4qzrstwHcMSUZhj2bcKkei9fn
 f2trFg2VFfTChoEu2WETS1ZTB/cjJC8j8WlIAtDEC4GurgXO8n1rX/T
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: O5Dy6qOoMiMi0t0TQCbDfeILjbwaZiVI
X-Authority-Analysis: v=2.4 cv=LooHWXdc c=1 sm=1 tr=0 ts=6afeb277 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=kCKOgzAXqFYlHSlaV6AA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX+8v/pUCbq4Zz
 ih/PdXBF29iQrDpUQZ498IMM///WR8mFmczyuvG1ZfYm4eJZhU0074tbu2PkOUJ+m3GX1TC1pn/
 XGQXdaQ9ihzkxLtahnSSCELp75c2kwPctholPDSPF68zsP4FAYlQC9alU5TwvU+edsqqfjS5HJw
 o8LS608aWLCpxSg5DkVkPxOO6KIv4x5zQGP6oD/ywSh6Re1BhnmuFFDB5ibwOSkiCiOXULgFXOf
 ihMM3r8fZDQwfgtgIQ3ladMnKBXD1KL9ucSCKmt7IHCaYkYd1HQr1Fqy0JS1yQYIw0xSjsIWNG1
 qqObu3W4IYVxLNcZbD3uHHE6nKnXLzzA3zPyr2Z+qBhzm37bcrBYFaEPMDU6DOAsNG7YFyGtvFu
 qxiLmevsiyM4J1/+ufEQO8Chz8sV5vo0tbTh2OrPZKcte1RKpbrBt9cGOyDlh+2aCa/mPcEXEr/
 c5eBBCimkrMcLSsw4dQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX6brscBVs0owN
 0IO28uIEUTKM6GY07Uehlv5vrQfR2+zvcxPfAVNrLXSaLZ0JMYArhNr73DHe/iPRmfkNVKmlGlD
 hduHsfYFOVfrAw+T0FAUjOMvYkcSg+0=
X-Proofpoint-GUID: O5Dy6qOoMiMi0t0TQCbDfeILjbwaZiVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
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

Add an API msm_dp_display_get_panel() to initialize and return a DP
panel to be used by DP MST module. Since some of the fields of
DP panel are private, dp_display module needs to initialize these
parts and return the panel back.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    |  9 +++++++++
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  1 +
 drivers/gpu/drm/msm/dp/dp_display.c | 27 +++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
 4 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index a9d0956a9751..e3ca0dfcfe9a 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -3129,6 +3129,15 @@ bool msm_dp_ctrl_stream_clks_on(struct msm_dp_ctrl *msm_dp_ctrl,
 	return ctrl->stream_clks_on[stream_id];
 }
 
+int msm_dp_ctrl_get_stream_cnt(struct msm_dp_ctrl *msm_dp_ctrl)
+{
+	struct msm_dp_ctrl_private *ctrl;
+
+	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
+
+	return ctrl->num_pixel_clks;
+}
+
 struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link,
 			struct drm_dp_aux *aux,
 			struct phy *phy,
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 9478f127c6d3..8db5f714519d 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -61,6 +61,7 @@ void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl);
 bool msm_dp_ctrl_stream_clks_on(struct msm_dp_ctrl *dp_ctrl,
 				enum msm_dp_stream_id stream_id);
+int msm_dp_ctrl_get_stream_cnt(struct msm_dp_ctrl *dp_ctrl);
 int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl,
 			     struct msm_dp_panel *panel);
 void msm_dp_ctrl_mst_timeslot_setup(struct msm_dp_ctrl *msm_dp_ctrl,
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 544b76e2c6f6..d3d798a1da1a 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -536,6 +536,33 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
 	return rc;
 }
 
+struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
+					      enum msm_dp_stream_id stream_id)
+{
+	struct msm_dp_display_private *dp;
+	struct msm_dp_panel *dp_panel;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	if (stream_id >= msm_dp_ctrl_get_stream_cnt(dp->ctrl)) {
+		DRM_ERROR("invalid stream_id %d\n", stream_id);
+		return NULL;
+	}
+
+	dp_panel = msm_dp_panel_get(&dp->msm_dp_display.pdev->dev, dp->aux, dp->link,
+				    dp->link_base, dp->mst2link_base, dp->mst3link_base,
+				    dp->pixel_base[stream_id]);
+
+	if (IS_ERR(dp_panel)) {
+		DRM_ERROR("failed to initialize panel\n");
+		return NULL;
+	}
+
+	dp_panel->stream_id = stream_id;
+
+	return dp_panel;
+}
+
 static void msm_dp_display_deinit_sub_modules(struct msm_dp_display_private *dp)
 {
 	msm_dp_audio_put(dp->audio);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index b0b7570cb16c..96be45c3dc92 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -59,4 +59,6 @@ int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
 int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display);
 void msm_dp_display_unprepare(struct msm_dp *dp);
 
+struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
+					      enum msm_dp_stream_id stream_id);
 #endif /* _DP_DISPLAY_H_ */

-- 
2.43.0

