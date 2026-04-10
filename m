Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490CAE99062
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 770BC10E8FF;
	Fri, 10 Apr 2026 09:34:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Stg8oHdj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GrBP68jh";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC14F10E90A
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:19 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A87E6s3935012
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F2gVsfBAP/XpmUtHNNyA77JIrx7z8UN1Bp+hGLyI0/U=; b=Stg8oHdjET5MPOkU
 4gWNncsfQLtc1OrCvgJKfKLEo5Gwf+HIrJgDrhIgi9aY1bHbYYUfexGSKr4+zS64
 KZ+GRPJG9fXTptpOEhaNtLvH4ruy02MouSziu02NRmZsfGmhYvQPvgwcU0//PWzW
 /SvQJAps5u+jhZToWzCIrQr1JT2CxPt/KCg5ahsXN2BqiSRsZ6Sj1TMmcbiNtTH9
 m3uJeHyE5j4kuJDNSbNjl6NcsnotftraUVfl9uDnEWUbyUp+W5z0xYAiQswfgmLN
 QrtQOvouN25rYUXQ8lLJ3AlNb5GDCnf/KIAunsM4L8mO33fvigOXEeLT04zV6fnJ
 vOx7Gw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ded5sbfjx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:18 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89ffce20deaso43739286d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813658; x=1776418458;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F2gVsfBAP/XpmUtHNNyA77JIrx7z8UN1Bp+hGLyI0/U=;
 b=GrBP68jhlpXCyNh+XuKVljyu8t62pJtg8uOm1T6d0vEq7E+kaA0BuFSj15XFpRCNbH
 pjnJmIb7ecm1SE4YZwqEiFLLzVhgBloOkbp5JEXz7LiGMaECrbk5/5SblriCA41UN/Ui
 mQrAPAVfUpZ5Ep3P/41vBLFwiM68iXFw+42zo63Dtb5W+X+AMehjQpiArm51hYgXBcn4
 iGhq2sxw0hiaomuAhHONeYcFIt3RaQLpUaGaeLdoSIV9Bb4txBB35AgOfltKjUsuK/4l
 mH08vsJ2RT8vKoB7Hpa1rEGiMtoSgdV4Sp5/ZM4t6tUYUEJ2RcXNfzo4hTuS4mgnvwmV
 LpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813658; x=1776418458;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F2gVsfBAP/XpmUtHNNyA77JIrx7z8UN1Bp+hGLyI0/U=;
 b=HXoMTHqG4BgdL+qnMhMCjWxdFSlf9M8xTmcPCEXDeSp7t2Ae9gi01zl8bOgUmz8/BE
 j1dTo2yY71TXmCWTI6mLRMAyritUPU4yrAt6JMRiFUtvv70OfvlKmK0P/cXLNqMwLFP4
 ZGXtEh2AuwUIMHva5ETCMAYY7aa+LihkAcmYRPHi1ZE0L/IBKLIzKcLrNXDKYUENMNAo
 Wv1+i+MobFKo29hc/mTp003WctYRgHu/f709IwnU287xXbAfrZKSk9s3l+9vu01XMRBl
 8kVe+PSYeIHbs9MPfwlvskBC6h6gz//zpJs88Dlc5hzSPsktW2qQ71pS6XU+LdH1QUme
 eymg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4XulUOau74Aau3MCrg0F1plaDpIYOX4sOYcNc9yI3qDMQquzWJV69Ks506o3fwVLiIFTfeaZA62s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhgbN1gPqRe3JEgYMCwzNr2pJS+TR29loCvJg2h6Nc32fBME6r
 XnPGZPhc62PSN3Zyg/7OXbrojPYC2LfUgtxh4ThFaJPK4NA8xOua/soQmaz1KQjdUIk/9JSwbay
 89df05oBNzLfFR5gfMXSCylj3ooMxmc8QpSrwzfZhMu6H8A8Fq2v588Q6RzN3t9qpAojSf10=
X-Gm-Gg: AeBDieulBVuqheezVrWbg4pRjR8Z1EaTt9/XRilfXdIUQ6eS47jHIdSWeREL3Pvnnve
 vVzZn02weCazpfWVaZtPKCkXoW/vTjEVcvp6G8zaJEFZESbNZN4R+WkiV44LiapEi3zoFdjbnbi
 dbvDBdk3uyQQR1r8BFc5AG9E60e2XbJG2X2PpnfCgk8/X3U//328dKGtSULNAbTYBY/URMporkn
 7Yd45sACsr+Eglr7ipHE1UxjgVmNcfliMFnILc2QLRPIHNug9Wqq2atNCMTc3mHHt6MYYmWsKSr
 FAwYOeP/EbETHLZEf8bU0/l/MVTSxLSrDApUUli3n4dlRCdynx1utGmSmdu32bnSGvrLhy3q7xy
 FW8AeSRUN8+iw6YSzV+gxY9usEfge26b88N8z/g6agkaZpiqTRE9QcYJj69Oy6MrsdMleh1bpFQ
 CCs0eJZHk=
X-Received: by 2002:a05:6214:524a:b0:89f:c414:8d1e with SMTP id
 6a1803df08f44-8ac8630980fmr34280166d6.52.1775813658385; 
 Fri, 10 Apr 2026 02:34:18 -0700 (PDT)
X-Received: by 2002:a05:6214:524a:b0:89f:c414:8d1e with SMTP id
 6a1803df08f44-8ac8630980fmr34279876d6.52.1775813657980; 
 Fri, 10 Apr 2026 02:34:17 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:34:17 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:33:40 +0800
Subject: [PATCH v4 05/39] drm/msm/dp: splite msm_dp_ctrl_config_ctrl() into
 link parts and stream parts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-5-b20518dea8de@oss.qualcomm.com>
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
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=3675;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=DmfXjCm5CMc9QUMbnkHNM0IxZcwbFs2CBGArGw/Idno=;
 b=7G5maolJyW03eOOrJe143+E2cKWyrZ1ycbAl/ZXheE5fZZAsi3OHRYzrm1PHPPDxJTT+h0RKX
 uFRXrK3cxSYADbg4RG8qLETRnSktXeuwyLymw6DeUzJft5BtRV/zQ90
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: wW11ezNoOJr-Qaqlr4GT87PfF7DGTwu9
X-Proofpoint-GUID: wW11ezNoOJr-Qaqlr4GT87PfF7DGTwu9
X-Authority-Analysis: v=2.4 cv=Ko59H2WN c=1 sm=1 tr=0 ts=69d8c41b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=N4WGanfLxQUAwF0MUGsA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OCBTYWx0ZWRfX7/tN+BmGqxtV
 HxbT/Tx9RVwcdgb8TBqhsUZqgkMNSDnMazm945cJSLEzkpMs8E8hUrb8IOqdnOAed4JvERJfGAE
 bGSgbot53bkrRxBTZh9GLSd+kSbwyX59BcLvOkpojmTLwK26INA2EZ9+BNjQ88HiB0TMPNzBPZF
 L5jpQXcxCxfMel3Bn4ipUy9LermuTZBX99lrFSneM+EfI/Wu0KCQNnvaSjFA1zvnct0KIU6yn1y
 eop2PtA7ysioRf7M8Yfy1mdAvP8K3KnW5cvrxgvzHXdWs2H84M72qf8e3CVzLMRhcduGFuPJy4u
 d1tuXXwYv1D+BBR6/nCdKeiYq6pZpybGKo+1HZlbM/K/4akaRVgtrE6VidfNMEZLlJkrqDUsvNf
 H35FR7xCMHIjmjSBic2d6OBfjGbM/Q6Kgo7Kuph9y97+fR+o8Y4biPdQi7+pDcQLiInEiJsQyYm
 x3nu2Jrm50LimYPGFVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100088
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

The DP_CONFIGURATION_CTRL register contains both link-level and
stream-specific fields. Currently, msm_dp_ctrl_config_ctrl() configures
all of them together. Separates the configuration into link parts and
streams part for support MST.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 43 ++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 476346e3ac19..85315467b5d0 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -388,26 +388,41 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
 	drm_dbg_dp(ctrl->drm_dev, "mainlink off\n");
 }
 
-static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
+static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
+					    struct msm_dp_panel *msm_dp_panel)
 {
 	u32 config = 0, tbd;
+
+	config = msm_dp_read_link(ctrl, REG_DP_CONFIGURATION_CTRL);
+
+	if (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
+		config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
+
+	tbd = msm_dp_link_get_test_bits_depth(ctrl->link,
+					      msm_dp_panel->msm_dp_mode.bpp);
+
+	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
+
+	if (msm_dp_panel->psr_cap.version)
+		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
+
+	drm_dbg_dp(ctrl->drm_dev, "stream DP_CONFIGURATION_CTRL=0x%x\n", config);
+
+	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
+}
+
+static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctrl)
+{
+	u32 config = 0;
 	const u8 *dpcd = ctrl->panel->dpcd;
 
 	/* Default-> LSCLK DIV: 1/4 LCLK  */
 	config |= (2 << DP_CONFIGURATION_CTRL_LSCLK_DIV_SHIFT);
 
-	if (ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420)
-		config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
-
 	/* Scrambler reset enable */
 	if (drm_dp_alternate_scrambler_reset_cap(dpcd))
 		config |= DP_CONFIGURATION_CTRL_ASSR;
 
-	tbd = msm_dp_link_get_test_bits_depth(ctrl->link,
-			ctrl->panel->msm_dp_mode.bpp);
-
-	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
-
 	/* Num of Lanes */
 	config |= ((ctrl->link->link_params.num_lanes - 1)
 			<< DP_CONFIGURATION_CTRL_NUM_OF_LANES_SHIFT);
@@ -421,10 +436,7 @@ static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
 	config |= DP_CONFIGURATION_CTRL_STATIC_DYNAMIC_CN;
 	config |= DP_CONFIGURATION_CTRL_SYNC_ASYNC_CLK;
 
-	if (ctrl->panel->psr_cap.version)
-		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
-
-	drm_dbg_dp(ctrl->drm_dev, "DP_CONFIGURATION_CTRL=0x%x\n", config);
+	drm_dbg_dp(ctrl->drm_dev, "link DP_CONFIGURATION_CTRL=0x%x\n", config);
 
 	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
 }
@@ -450,7 +462,8 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
 	msm_dp_ctrl_lane_mapping(ctrl);
 	msm_dp_setup_peripheral_flush(ctrl);
 
-	msm_dp_ctrl_config_ctrl(ctrl);
+	msm_dp_ctrl_config_ctrl_link(ctrl);
+	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
 
 	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link, ctrl->panel->msm_dp_mode.bpp);
 	colorimetry_cfg = msm_dp_link_get_colorimetry_config(ctrl->link);
@@ -1628,7 +1641,7 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
 	u8 assr;
 	struct msm_dp_link_info link_info = {0};
 
-	msm_dp_ctrl_config_ctrl(ctrl);
+	msm_dp_ctrl_config_ctrl_link(ctrl);
 
 	link_info.num_lanes = ctrl->link->link_params.num_lanes;
 	link_info.rate = ctrl->link->link_params.rate;

-- 
2.43.0

