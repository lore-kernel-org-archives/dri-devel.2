Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D396C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:15:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DB2410E91D;
	Mon, 29 Jun 2026 14:15:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ax4D5Bf2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PY1rWNz3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED2410E920
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:15:35 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TASrSJ2601136
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 G/poH3AEjItoo7L5qbK6e3dZL/yIyyfNWIp0WMuk8fQ=; b=ax4D5Bf2/vxx3eIm
 6bBczGq0HB5eg1UImixPzrNcR5vczs0kiHokl3duyHpYZxsFz2kyZbvfQsgFZfYL
 gRooDriO7rBmCicKoqTKSHIMpFb3Ct7br/Oq8tauSCbqIW3WomXFLEpSdpoZD/xO
 O0de+F3fs1Otkebfu9Kni98f4drypikYaFNjCFjdL9An2uGHkqvDnCjFpQsFPwSH
 zfFpWwAE5AwZgE7av4R0BUIY1PtV2g6PBPvlMsLVA4Vs18MChPZpQrw5fbAbIAYI
 djY1cBPo5LdLJPH455+NbRXJjsl1uJllR6qbAK+a45Gmg16RKSYSlHDWd8ttJqo/
 K/f71w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw97m0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:15:35 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92ac0a54110so553568785a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782742534; x=1783347334;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/poH3AEjItoo7L5qbK6e3dZL/yIyyfNWIp0WMuk8fQ=;
 b=PY1rWNz3pV+pos/Elp8jNzRawNTmGF+gnUmHio2bPR7XLdBgAc81mFsqIypisV19lL
 jn8qs9fKOLdkRegpQw40SU226KKaXnybS2DqbnMm80L7f16TcXEwdKYJd4RPicFUgjvX
 gjbNXr4NYrOZJWlPgo5Hwey2NGBMhBvTXlkzOMaqsor9ct/DVNXPEOC5JIhabVj+xKEg
 IV1VpdRaIbgXat1+/94tvIEu6mhPImJ61Lypo+bzbVUGUmpTBYStL1h+r5ShiWPw5pZb
 zjR+Mdj+5Mb0el3bVtqgaCErLGXcO/XVV9ikSH54u1DXteJKOy8Rjdz+J2j28NHP1dX9
 Wmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742534; x=1783347334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G/poH3AEjItoo7L5qbK6e3dZL/yIyyfNWIp0WMuk8fQ=;
 b=DqdmA9XvScUvY6Sir/DQUQv1r87uMJe/jJhiaLH2HbVREDO33Drt1SkyErVR/DuuC4
 7/4B1euMUFuNL9M3yKDBUp/+gmJ64chRzO5c+ztRccH4O83uOfJfC0pWQnrOOvOlr8/G
 wM3zbEgRN9rb7P9eEPZ1rkWWMUxsjGi1ntc7KEyX87mHUza9KCsMgpqQId9/CAGbvmrn
 qej40O2X3CttoPlXZsjxHirC8QsrJzaDW8ldluoSWRadNwRx478/xoJ4l00pac3OtWKZ
 vuA0Atgm96ZrmSVGHdd84EnAVYsMNoYiCe3lBF4JfC+Xv/kroji3vSq1+vMaxu8QgoAj
 AAxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Hi1BTVgmqgq1apkMiSLFl7xEhZ/UR2XwvUS8MzC2LN+csLuzDFaSgsxjBRIGaRMnZbbe6NM8TpPc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwDBrnm/SKH+/h3eMN7qM0DqvBLXx83LFnJGXYAXKXhvfgfq5qt
 KA0OIhRe0hSqHibIkfcPdgW5n17l+K/gphMRJzbtFezjp3WFJmrCSHUlFhA7CUbcwAFgIrjGjsJ
 TYl9+IHRGl2FbwoM0UiSWpaeKTsiPj5nMSpHlreMLEoq6GZHZUN+lO2imDBfANTKm2QAvaFw=
X-Gm-Gg: AfdE7cnG2tIKi1PzDhfmF7Ie8M9zRajE7lYXwaWia0xtKj9Gcqd4SV6cfmlaVu4+F/L
 akOp9r96AIQwMqw48F/pI8/QqxcWlb9+qIdgPDXsML5oQVssczmBnZGy9UXoDMH2iOmbeIN2U4V
 +X1RpQPSiZlA+uJ4wJJdlBuYpIGfxCSYctqUQO3OCBZD4thipjTZHYERHringLcFrpKneUsoWM7
 iELAqzClBK3X8+sWg5fuV07ZKEHMTGc/DviOFD/BV74qA9YqpGxbtOQRGCOkOcGT3LiOC2cghVT
 HFuVqcmcWgEgGiggB4fbWLxYS6QoQmmszdCP8L3pdnSHYScj4qvBmVBGuTzHPx60iiqYBAvHqhY
 3/kSWkIFLUzrCZCfg+toW2Q7JLA2IIGUrsJBIbSNbC/qD7JXekMhqOnhq3jeqgYyOGHwOQg==
X-Received: by 2002:a05:620a:bce:b0:915:9984:5781 with SMTP id
 af79cd13be357-9293ccd3e07mr2348340085a.51.1782742534192; 
 Mon, 29 Jun 2026 07:15:34 -0700 (PDT)
X-Received: by 2002:a05:620a:bce:b0:915:9984:5781 with SMTP id
 af79cd13be357-9293ccd3e07mr2348330685a.51.1782742533511; 
 Mon, 29 Jun 2026 07:15:33 -0700 (PDT)
Received: from yongmou2.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9260079070bsm2143165885a.40.2026.06.29.07.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:15:32 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH RESEND v5 06/25] drm/msm/dp: Add support to enable MST in
 mainlink control
Date: Mon, 29 Jun 2026 22:14:27 +0800
Message-ID: <20260629-msm-dp-mst-v5-6-2ed6aee1867a@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782742144; l=2592;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=Mzn/mLQcqys/EJpBrtkVNH08m5/h5cbmf+/AjWnre0k=;
 b=6Uft3/WkZ+7eSkUNxcdPQhlD809YEyGDQXGU7xNpVLOWWKi/RrU6CCKccWgm0VLKbK47fHEWN
 myz3WxIbHvtAFNTJJLy8nX4oSMTB8YYJSP9KVuTn2fa4zqL/d5K6/8h
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX76zeAnkqMh9/
 aVSZiPSDWvHz55oQfTHfEwQ249Csw4eMnHYJ58elr8Dx1ScVv2hlAxUVtE056nMG1Blj+4TffbZ
 QadqSKHJtLDK6OTttH/a2dfw5mvmGJs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfXzKYWmhVI2YI4
 aZ1AapqOv4rcY8DdFU9Q1wv+jP2Mi2Q89dI79PEsZ8bK2mBZBkLKivI/Umyonbliovdg2YXgiqo
 dhnwpGP+qRXZPOlaiHBBiRldU3/oxyI/m2gu7xWlbmstZhWmchv2CD+RFEYozjRhmkqOs4jjgH/
 NfsEn1j2m42dZMqv4UdG/R+Ftk9polTSXLUF6WFO46mXUavzMxKNYlDq3l0GGyJfINjdMAu7Ie2
 XYKUvwvTarSBaGykJzemwJ2CDqP9ZB+oHgeqxUMeZiLI9W6FAf0feor0gxPxkDX5LKWGjBKzU/2
 m2mz+tUTIOuII4EZLIZQCePzzNw7JnDRqH6yWi/C7mVAvIqWWTRqo6Z2v8Fe2v/g21X5k9CV99n
 TYCO4etQPtI4wNmZK/JH3QJL5Cwj4T/fG5VZmYv3NyRMVygBMVvHHOm5vP5VFRodarlgZKrWvPn
 juQCSE/50RPLw3VrNFw==
X-Proofpoint-GUID: f8tgyJ3KWjUpzKTMPtcQXa1PnQyg7Woo
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a427e07 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=GJT6Fafo9oTAj6z5dyEA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: f8tgyJ3KWjUpzKTMPtcQXa1PnQyg7Woo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290118
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
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 17 +++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_reg.h  |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 6754b10d418c..e9aa0e254234 100644
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
@@ -2678,6 +2691,9 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_ctrl_lane_mapping(ctrl);
 	msm_dp_setup_peripheral_flush(ctrl);
+	if (ctrl->mst_active)
+		msm_dp_ctrl_mst_config(ctrl, true);
+
 	if (panel->stream_id == DP_STREAM_0)
 		msm_dp_ctrl_config_ctrl_link(ctrl, panel);
 
@@ -2731,6 +2747,7 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
 	phy = ctrl->phy;
 
 	msm_dp_ctrl_mainlink_disable(ctrl);
+	msm_dp_ctrl_mst_config(ctrl, false);
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl, panel);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
index 6808965878d4..deb40ed24654 100644
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

