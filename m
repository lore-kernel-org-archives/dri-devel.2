Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15810E99062
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52EE910E915;
	Fri, 10 Apr 2026 09:35:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ofcCEtIX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bJXFd0Ge";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5224410E91A
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:30 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A8S0WB115013
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oNG/v6dVL5jML4JAEeiW236k13VW8/n1TXxW/iqzj/U=; b=ofcCEtIXB9teZ3dc
 btOhT7qF9HU8FcD4WQQFq7AtTDfXoXM2GypCrvk1bDdv1k6JmBhY77eEtr9sICEq
 QenfmR64HmXkpGtFwRzO17+So8PGPSGIPxcDgeFvzwmMwNfQ5dtll0XL1IqeS9Tf
 L0OygAfb2VJVmNAeeb8kNvxMsEfEIW9Kwii4bQDOmqBgT8AHstSfVfZpW4eLGphu
 hC9eOd9xECiz+zEf+ko70fTDE28Tqqkve6RsJBJn6v0qu8nh3/fpUvfKyCEkdDFy
 +Gu30fzlb6oQ6lmA3gm1G74KggA3er4X19ZhrC8tajgYsBHrZiVcM0Wb1nYjkRsl
 YJ356A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dee8xb905-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:29 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89cd03be011so41271326d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813729; x=1776418529;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oNG/v6dVL5jML4JAEeiW236k13VW8/n1TXxW/iqzj/U=;
 b=bJXFd0GehayyBzvATboZywlJayzdxTEXjoVrbdwy8WGykCVmL3LfNYA1tDDCamKgol
 87Pf55ro/QbnJltVkF2z1Uu1iWTH/nteS2E2WgRx8vkqIFEJI35PxYxZIntUP+3vUPG2
 e2nHZgIuDylaMuhoJ5eLdUYtgyxXbij+5Bx3za29yuxOMZD4ezmZ0sVGakI2NhCPcg+z
 Y/NSGSfJTWYz3FUUS6BN5AqIYjzigx3O8ty9jYS1ZPK+jOnfiRu0LucqUMLmGmqqycxN
 WA4pJEb/Gd+d/ZAt5+VN0Sgs3l75LgCvA2D5qJV4oH97gVj/0nYyY5f3htp3GU6KmYRw
 Cw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813729; x=1776418529;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oNG/v6dVL5jML4JAEeiW236k13VW8/n1TXxW/iqzj/U=;
 b=h8s2lewc+hqIneJoac2hL/oU0oEiH/fVgmEw0aXh6xzXESwch3bKtI+35TDSHUJM+R
 yWtntYJswpng79Q/hrq9ptdfxOuATlcJbgMSTS7x4ojQE4UeTpE9OT2Nrs9+IqmlH/td
 4AqNLK0Z7OsW3mmDdtecc9/iz5/cncrN87UP2jS2sZmlBN+o2BhfEaYk1R+GHkksDsf/
 2iQgXXzNksicmZYD/Cc02JGIb/rJytZ4uESfuLe3epp6jnBGRX7ftXi05zqDpjqNXQaJ
 hPTW+pft1VOq7lDVwSVl3/vVY5Q5tXKuw5y1bhLVXBJHeGwnqUztOs2Yq+h4uZrC0yVj
 znxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDAypYMJlXEpZVBzbP6TlCH3gvs00AteC8ujk2WmA756rgpj5UhMpBnbDq/4qivOM+shUPXJFsGmQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyuLKNvP210BcsF5pi0cKOJfhPg/kNkuqn2wj93PMPT7M/5u9OS
 HGdrVeUv/zJfGOe+us3wHEOU6Ou6BoPa1eJ7nWpF9XrRHHoU2xAE1x6tARc1u6VifnEt0WV4NEY
 t05FUf6B/fk6p8Gug8c9S+NR3njA++rcVLXo98cSe6u622rZtmMaFbOJ9cVc7gFswT4XoXmw=
X-Gm-Gg: AeBDietq/SaJU7OLFCMLzWkN2mL97/A3PIm31iYUsaeAgqmJgDUA43Gw/D/rgNjylOD
 Owytvg90nTTya96C9Non8t3zJojnVFK7RI8XAd6mQf5VoGxWa3q5ps59hGe5KCywsXAcqkL8e8H
 iMuN01EOyUbb/BtR0b6AcG5GhlMELn/PTuW23g8iqZAHE5RI0ztpgIgn6v711s+5uzos3/n93iQ
 FoC2itCmS5N1vT1bw/VON+Dx5cQMwJEu2LMgPh/lBnNeBVDIfcWRF5Ae2te+7g6XSNMJjkIaV/E
 fWGBJHq9iuq+pWcUjHALUIY8w8SwNlapFnNy35FAe6FuYzAevGvtM0aVa2piH1Wg3xUssJxF+5g
 eO+3Wrob3cl+Sunu6r6hUanSswnlfn88BKQgyfVSRZJ/YLzMvh6n0jafQi3IVmaW/XKb8XO5txX
 EA+Rv5Vko=
X-Received: by 2002:a05:6214:3a89:b0:899:ea4f:12f6 with SMTP id
 6a1803df08f44-8ac86285cfdmr31534256d6.35.1775813728701; 
 Fri, 10 Apr 2026 02:35:28 -0700 (PDT)
X-Received: by 2002:a05:6214:3a89:b0:899:ea4f:12f6 with SMTP id
 6a1803df08f44-8ac86285cfdmr31533936d6.35.1775813728267; 
 Fri, 10 Apr 2026 02:35:28 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:35:27 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:33:54 +0800
Subject: [PATCH v4 19/39] drm/msm/dp: Add support to enable MST in mainlink
 control
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-19-b20518dea8de@oss.qualcomm.com>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
In-Reply-To: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=2524;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=K5vgfTfdCI4P5kMd92t6oN5BdOo9qMx4WD+42FN4rPU=;
 b=xE4kYondk9JUlsE03aUn3L62AYCt/ATKX+EV9mZLBM27CYYnwrk0Lz+9gycIw3ZKS57a1vCiB
 gLO/pK1Aci0C6N/rTE00I9+m1K0+R+25JzjUUbpF7eGq5Yua5Gw8bKq
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OSBTYWx0ZWRfX/RIDZLDwuMOf
 vf+ecA/zOnzLiEF2cUoI1FA8lb4FhXM2jRYe8hI1Bzy0Fgga0mPDmqUsJlnhOjydWCqmA5GMRtl
 N1mqa3hhwJL6sXjewbn/jGUKeGFg+BwO1PmqGXVev/QwDqpYWiqymC16t9JPnHNZpmgr7E4Kflq
 oGtR5lHsBXbmexUfoCY3BOcX1fbi6rF4AEOXlqQYUig7eDFiVWyHrg6oqE6ntLJ1yK9P4Ha4BVy
 j76jUnt3290gXM/+d6KGlLnthFzUazvzeuwAR2l0AO6anat2h5UucDS5m2MMbw9PNMTbJ64M4ha
 FMrxH/XCseehOCYCYhn0loPCoz942slYXJRg6YJYQ7VtZF69HRPNo6u2cu1TMEa0iTeeiwCGEDi
 U61tK26Bm82V6JGS/SRxEDY3cupp1Ba6FIYpQykrRvYb4XadeASuO0EFW2srjsufRGTJ79TTFug
 0jPOb+k7NgzE3FzDcjA==
X-Proofpoint-GUID: OINhmbF_u0OhsQzRajYGXI_TSvDtTF7M
X-Proofpoint-ORIG-GUID: OINhmbF_u0OhsQzRajYGXI_TSvDtTF7M
X-Authority-Analysis: v=2.4 cv=O7YJeh9W c=1 sm=1 tr=0 ts=69d8c461 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=GJT6Fafo9oTAj6z5dyEA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100089
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

Add support to program the MST enable bit in the mainlink control
register when an MST session is active or being disabled.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 17 +++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_reg.h  |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 6f25145ef214..9513de81abc4 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -255,6 +255,19 @@ int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl)
 	return 0;
 }
 
+static void msm_dp_ctrl_mst_config(struct msm_dp_ctrl_private *ctrl, bool enable)
+{
+	u32 mainlink_ctrl;
+
+	mainlink_ctrl = msm_dp_read_link(ctrl, 0, REG_DP_MAINLINK_CTRL);
+	if (enable)
+		mainlink_ctrl |= DP_MAINLINK_CTRL_MST_EN;
+	else
+		mainlink_ctrl &= ~DP_MAINLINK_CTRL_MST_EN;
+
+	msm_dp_write_link(ctrl, 0, REG_DP_MAINLINK_CTRL, mainlink_ctrl);
+}
+
 /*
  * NOTE: resetting DP controller will also clear any pending HPD related interrupts
  */
@@ -2669,6 +2682,9 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_ctrl_lane_mapping(ctrl);
 	msm_dp_setup_peripheral_flush(ctrl);
+	if (ctrl->mst_active)
+		msm_dp_ctrl_mst_config(ctrl, true);
+
 	if (msm_dp_panel->stream_id == DP_STREAM_0)
 		msm_dp_ctrl_config_ctrl_link(ctrl);
 
@@ -2726,6 +2742,7 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl)
 	phy = ctrl->phy;
 
 	msm_dp_ctrl_mainlink_disable(ctrl);
+	msm_dp_ctrl_mst_config(ctrl, false);
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
index 237325d52dbd..87eaaefa014d 100644
--- a/drivers/gpu/drm/msm/dp/dp_reg.h
+++ b/drivers/gpu/drm/msm/dp/dp_reg.h
@@ -128,6 +128,10 @@
 #define DP_MAINLINK_FLUSH_MODE_UPDATE_SDP	FIELD_PREP(DP_MAINLINK_CTRL_FLUSH_MODE_MASK, 1)
 #define DP_MAINLINK_FLUSH_MODE_SDE_PERIPH_UPDATE	FIELD_PREP(DP_MAINLINK_CTRL_FLUSH_MODE_MASK, 3)
 #define DP_MAINLINK_FB_BOUNDARY_SEL		(0x02000000)
+#define DP_MAINLINK_CTRL_ECF_MODE		BIT(26)
+#define DP_MAINLINK_CTRL_MST_ACTIVE		BIT(8)
+#define DP_MAINLINK_CTRL_MST_EN			(DP_MAINLINK_CTRL_ECF_MODE | \
+						DP_MAINLINK_CTRL_MST_ACTIVE)
 
 #define REG_DP_STATE_CTRL			(0x00000004)
 #define DP_STATE_CTRL_LINK_TRAINING_PATTERN1	(0x00000001)

-- 
2.43.0

