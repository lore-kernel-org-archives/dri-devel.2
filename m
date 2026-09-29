Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3746CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A5B610ECA3;
	Tue, 29 Sep 2026 04:27:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AEmq3QI5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SF73uHef";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81E4410EC98
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:12 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47jqx3644764
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TOMG3yp218IRb7X4mHLShdrli/+A+w+d0UixRrJLDGE=; b=AEmq3QI59mjTs70Z
 S0jBZqzcYfntt/6AeeI/VAVRkU+jJmR/pk0s5bWeHk79vid9bmppPUcBfCu+07jO
 k0kOXE5yTo1s+TefUVE6qYsAfWpCcud0fejiqjDaOU5REYNFPXVFCusvretoKq8P
 Kxx3iA+tenki7u0UhCEMjYhmzEDBQUSmMXUBxZJbYB/uWdKcZOyM3tqyWTckFsqS
 wES9q22RgUoo5s4qUVcgXHeqFNDzauwZmWtBqO4p1++bpxvDzPF8l2PDU2SDag43
 A2prYRWkoQlUWI+NgTbMzBxBdknKyEA7UdSPkcO1ogaQV56gxrlYELow5HUiPwlQ
 gEHS1g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h00s4s4a7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:11 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9143cb073b9so68829306d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656031; x=1791260831;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TOMG3yp218IRb7X4mHLShdrli/+A+w+d0UixRrJLDGE=;
 b=SF73uHefTedhg8GIUYrxSy7yLwh3SUZLdFdlI2HGYeSdnvhI5mvNVkM0BtvmnpE2Al
 B6RwaHxCwcml9+2cfQ5d2ki/AqDh6+JVdBUrtLEidVDAb4dLO08jbePVORV+TorgKLp3
 b8hy+Yurl6EctvazoehwRQM4bexXuwcq+FdChfQp8FvNIV7FQRoY64zFhE+xndKZ99FA
 9AB9oUraChDUy27BRtMHqx2Hmj4IOKnXbcO6rZYytcK0welY4IoM04AOmSgcKfX+GMT3
 lcEEuxUIr1poPLUs3PqZ9bw8jqQRJvVcjsBhETlAdl1kytWglnZQciE1OSTcyD5ysHzm
 04Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656031; x=1791260831;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TOMG3yp218IRb7X4mHLShdrli/+A+w+d0UixRrJLDGE=;
 b=iLQE1tDjbrcUgqq+o1ajNMGvvoNVPgk2YeuUhxi6NXUBn/94zs6q4YicP/JicAt8NP
 kz3fl8F4Ggy+V8I44FBfbHSLSUe8gcbqns23TuqPt7PYBL24B9JfqxDhJl9t+S7VhqH8
 Hi+QgcSy5NndzU+2pO6WBNlvscReOIw3ufyiPeQswSJpu8OA0wImM4dnnLVF86/EbTaC
 41rmRKo1v7PHafGLEJPiUe/XZckVTfaz1Z2UOMUMaweS9YmtufKgGkOmv3iHj4Dz59iT
 d1fiVJmydgY3ooMqm9d5qST6Wz67/bVMbYf6GKnadKqfSUAqhxYXo2Zu3aCxNKbaXgnJ
 efYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwi8+aaKQXhcpYthQRwqdE52S+2meZvGlsURmdfv45gdKhCIj3v5uvJrlJKbm2DxkBtHQ4fk4/q/vo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLVUs+7IUn6NQ/sgSwvncYF3FjR7YxyeFsjl6zLeI1gImyyL1gD
 1TlLd5KW6BOx+FXPKDjsxKXCCm56woLbRuwctzJv6/ovtOsrXxHNgirZlOIfnWqVQSLglrLdYv6
 RhVCnCmaDtXyQC1Ys68jgmx78zaOPPohqyig71gY2HdkuocNbMU4X7xczPvp1G66NDAtwUXc=
X-Gm-Gg: AYBFou01O7iEo4S9YYtT17wzkOOmGMKT/9kv5CxCRRzIn4Ia3VI3gQtvEGlKjPWBEL9
 U9rMEjpEdWWZJeKqwtwAi/XazeHLiVqxr9pQQ7V/4Qj3x3f05lxdp6pNdsNn3jnSY1Z2dHbeyOV
 7jl9lBBUG5CJ+8kiV45FBVfYs2xbb8dTpFsOg3Gfcms098ruOK3ObxZ1TAofROl9aHBomPMzMYi
 AMWEJEJvMp13FuJoILVqx5+pQ+n4JiBp+Al5catgm6G6FpwyR22GUeMz9mFAgeL8d3MCyhlY7hn
 +ZKPZjEaS7koMsLxkHbJwb3RAVH+pfFcWR0fPMNrIhkMOPgSLeHXQ6bOR4ddVR7Zf1+V7WVnGJI
 jncRAPbcmEZGElZVG7Uh7lnA0gEG4lxv4Z7LfEYF1XLnWDWAuDlTvkC5T+Inx1f0=
X-Received: by 2002:a05:6214:19c3:b0:914:5028:ab76 with SMTP id
 6a1803df08f44-9145028ad09mr160456446d6.39.1790656030914; 
 Mon, 28 Sep 2026 21:27:10 -0700 (PDT)
X-Received: by 2002:a05:6214:19c3:b0:914:5028:ab76 with SMTP id
 6a1803df08f44-9145028ad09mr160456286d6.39.1790656030480; 
 Mon, 28 Sep 2026 21:27:10 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:27:10 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:33 +0800
Subject: [PATCH v7 09/35] drm/msm/dp: add support to enable MST in mainlink
 control
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-9-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
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
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=2557;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=8IxMe+vOOiLPxKEsXO6U2qctxURhGCfNOY0j4XpqOyE=;
 b=/Til5sl5abipB/ZBrB06zibhqaVCbrF/t2LOhTaX3qu2Yrd6xfA+pWIvKvCU6Ez5DlNrmeVYZ
 QVccIt3bM1MAO0YQf0bdVEkIM59qfy8MFC7fQt4hwcxRs1S7CDPVgdw
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX6dPpu5nr1t/u
 W3KuF5dMa6E5CEG7pTWVgDh/DPZyggXSU4tItY0Qfi63skZ2G3OAx9bKKXWwwDt0mCsCsHnY2ge
 n871UEMF5+h/dB+gO8Bj8nDLOyDQw0k=
X-Authority-Analysis: v=2.4 cv=ALbfqNVA c=1 sm=1 tr=0 ts=6abb3e20 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=GJT6Fafo9oTAj6z5dyEA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX8wb7R91O8LIl
 0F3SX3kwpZTOVEw4hXd2qnkAhNIrsI+mtMWGVEvw/xVV4kma3QIPaSvPCA/G8NK/jCKAPLdTxqg
 p43ZIp0KaVjpKEj3hfkhqXKmdaVIBUMAsPmBGP01RoCmnMNoOulDczMEWQ6RjxABiwGuyxisHaM
 7aehlq7EBHZV+BMVvrECSmSFkzPN50+8uipLxTxGeWtYvF0WJaEyu0gb2Wj9IAAM8MqP3AbsD0X
 P3cDze9hk5UxDU/MZ0+VVlZkaDTTznWSjnHtCWXcAIJ7xUPgrVsRYRqtK5PUbCH5napGdpvIF/Y
 RsSQIPxH1ZVxPIoNF2Dd2bGwCiUltTOIwBKqL3iKPrbeSpRlfgDNpR1iTphfGOJZ7vUVoQLILHR
 dK1UU5Ub1YSMCfDvSWngHkAnczY2PWv8/n5qpvUrjSIIPglEMMCP5fW4AyZ1w+PWWIR9jgAb+Ez
 rTdvXxLTxx7ib0esJwg==
X-Proofpoint-GUID: FHLCeOTEi6gRxsE3WaZhvv7qyyNVVnZc
X-Proofpoint-ORIG-GUID: FHLCeOTEi6gRxsE3WaZhvv7qyyNVVnZc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290017
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 16 ++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_reg.h  |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 65d22505c2b6..cd6ae0d5372c 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -276,6 +276,19 @@ int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl,
 	return 0;
 }
 
+static void msm_dp_ctrl_mst_config(struct msm_dp_ctrl_private *ctrl, bool enable)
+{
+	u32 mainlink_ctrl;
+
+	mainlink_ctrl = msm_dp_read_link(ctrl, REG_DP_MAINLINK_CTRL);
+	if (enable)
+		mainlink_ctrl |= DP_MAINLINK_CTRL_MST_EN;
+	else
+		mainlink_ctrl &= ~DP_MAINLINK_CTRL_MST_EN;
+
+	msm_dp_write_link(ctrl, REG_DP_MAINLINK_CTRL, mainlink_ctrl);
+}
+
 /*
  * NOTE: resetting DP controller will also clear any pending HPD related interrupts
  */
@@ -2680,6 +2693,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_ctrl_lane_mapping(ctrl);
 	msm_dp_setup_peripheral_flush(ctrl);
+	if (ctrl->mst_active)
+		msm_dp_ctrl_mst_config(ctrl, true);
 
 	msm_dp_ctrl_configure_source_params(ctrl, panel);
 
@@ -2730,6 +2745,7 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
 	phy = ctrl->phy;
 
 	msm_dp_ctrl_mainlink_disable(ctrl);
+	msm_dp_ctrl_mst_config(ctrl, false);
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl, panel);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
index 9263e61c794c..cc74b1ed628e 100644
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

