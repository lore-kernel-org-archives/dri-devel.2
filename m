Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3172C44512
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0831510EC6D;
	Wed, 22 Jul 2026 06:37:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RcW4rOuK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jYU9jgyq";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C641E10EC61
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:52 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M54J4C3769548
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YWr9wwuoYNg3NTbM6h8++bi9NeLoqHztxgk7/YWPoxM=; b=RcW4rOuK2fwD+LzM
 N13XfMOdyCqjokMjHcDrkyMb389lIWNH2UbJGpmcluaqtE+HStWcpY8ihhFdyt4z
 1+gFGH/DIVNE6Y1OnmoeEYWJc1IGNZO9eYkf1dmff6FMgrxr+J2rLOGSKADH1XwP
 tLh2O7wTNMPOMmM4HGL+EEJC3SajW+AH2SpKlen1EelVecK0FHf1LNKoXgs3bVJw
 jGk0pT7VivPGPurJ06WwlKBhNdmLvuLniaen2vBrCRdYNQnr3FpVpfQPoZtL5Ebg
 +obvv3lk7Mg2ZbAbpyOgCK03KfcssuUK4UjdU2FAarjfgo90gFCbHnASzz/hH0cj
 AX/H/Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjnu4rn6r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:52 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-522de3c645dso104714661cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702211; x=1785307011;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YWr9wwuoYNg3NTbM6h8++bi9NeLoqHztxgk7/YWPoxM=;
 b=jYU9jgyqrPqW76RAHG8fmYPJta/UNgoN6eHRo1EhRDWgvQB8YvMnbcXhJq72iZhZzn
 Pwwje1VEHLf457hNxBkVc5mDdYqqV8xVEyaP05gq3iKUtt+DFCEHSgIdZJz7VztI72nQ
 bRFBPwQ6m9tbDYySjQe16it0yo7P2HZXh5bAOwHjbN613IedKOl83Q/2xDlXh8jGPp0L
 riP55WB9jtVIsjqneePrsItq3/1DPHVLuIWamUJM6UMUJbVevvma0sxKDAhIuOYXrye4
 8nVnaa7WZU3+5NnBAalbw4LaXMhBm+xAGiV9Kl5jSjjE8iJfEn1ihFfdTCsCbx0igT4b
 6FfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702211; x=1785307011;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YWr9wwuoYNg3NTbM6h8++bi9NeLoqHztxgk7/YWPoxM=;
 b=ruraXs3mKLb7h8MgqYyAXS3jU67l3DWRH4bQnKPBrDhHxfjvgxlJ/kpAkZ/cl2XlUq
 biaFs397LVggndoYvVi9W/CqBzycnhizlKnxvBCfhvYIwRi2wLCSpHyfiO1N28qEWUK7
 iJgP2IY/zeJ9/GP+tKD0ZW9jkLTcQgxnx6dBTtAYhv5Cupb0ArYcvRsbEyrqKdI0zQPU
 56bHjE3mf8x3icE1HusYrGwBX6YvV49Ivd7/zOSxsFaYzUEUldTAUCrpWsaR36+oAMWj
 febqrn0Bw5xDpSadjgQDJoeFhmiG3V1QZ3zweYIKzZyZXfzKabn3v5YHP4IdY4PbPTOo
 c2jA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqQefzxT9QihTNqc/dtOR3tmdrr0khsa661SMiGkUmHE7jMZv4DZ9ft0Y4TTvrl6limU54YI2F3p7w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxc9hPBtKjDnrFor0NcVliBGU3DQ6DF/9fezFcXy6kJniJfsGhH
 zyuoQQqY1Y4PY5Iml6iG0ptMmZR0WoxkQn/YeXZqfgkqnSmUjOV1Yyf6gw4gYs2tLWTw8vA0lCE
 sz+sFZkiOt9zLURmRIVCp9mQ5IZk4JFDSxAdMN3F/YrMGxd08u3JHKYDB0ObWUkBq5a0CqFA=
X-Gm-Gg: AR+sD13KQuON42/08oWAo96T/lmtcR+BQ00WDZll1Ou3h8mMt5crIsmZ2Y/EAlXUW8r
 ugVFLkMH3q6ecFuYTyR1vps+TXGbgnRexDfJ55uF1SRkIdywssUaY0HP6e0y1K/RcqI5moabQpp
 W3aFeGlO3HMZeSIu5JI0RDiIpLU1jtV9eP1ADLQVN7V/jzNBdhZ3BExDA2YRfKADJDnftH8KoKF
 x4HPkRxWfVpmZpA/0Iw0b3p3Cr6NKtaxSI8pcUesqUXHWVOZOHHge1srPRPyFn53eZJoWUNG5r0
 zc38pT8wEKnABfk2NuHnSz2DkEXkTzKBNzH3z+r80mcWSfBPlQqMzPmKBNOpMF+jmBrBEcpBvVT
 WGI1S9wNjio+ouNNMVYgf7iP/zUgJ7fHP9UL5CKrrjMQKwFj2eQFIqJOIyo2TDj8RUg04Nnug+T
 MetGzabJBUd1u6aQ==
X-Received: by 2002:a05:622a:118c:b0:51c:8571:1ccc with SMTP id
 d75a77b69052e-5213c7e67acmr203287271cf.41.1784702211164; 
 Tue, 21 Jul 2026 23:36:51 -0700 (PDT)
X-Received: by 2002:a05:622a:118c:b0:51c:8571:1ccc with SMTP id
 d75a77b69052e-5213c7e67acmr203287141cf.41.1784702210731; 
 Tue, 21 Jul 2026 23:36:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c6f6sm309696e87.4.2026.07.21.23.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:36:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:36:22 +0300
Subject: [PATCH 07/24] drm/msm: add the wide_bus_enabled callback to
 msm_display
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-drm-msm-display-interface-v1-7-368c10fe62fd@oss.qualcomm.com>
References: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
In-Reply-To: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8943;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=+OUGc5FgVaREgTIXpTKbHBCCj4cUh+urB6VbsBn5Osk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqYGTnQ1UXylmG+15DdhP4e9ml2vmSj7jklAamp
 ggsil/0I/WJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamBk5wAKCRCLPIo+Aiko
 1V6qB/9WyRNAfBFo35hPzLIXNxJaPSTXCFo5MdVTLj/MZzFIixos99vQgv1VDVt5nayNyjSHzdG
 F7bzWkzNqVLs6fo3ewHfJFx0d8rRoNMhw9LmG5Ruwy3EDVlsm2dfCMeQIjZq9S9RSiAM3/xUAxd
 y4jkLJG7TbL/G+dbyt0md1kbg9ZuszRYd73LAfteM1dvtSbZXhx69xIF/maWWvCHutu0zr6XgHo
 fWyrVTNnX6PQBkPHuP64K1Pyb/m2DfloFhS+/5FySCEDHFEL6Yirn/s25exAaHqN1vsBnRVMmiG
 j++SL3Q6Fc8xHwECqLYW3vQkzZuFltepPqE3SR6p9kTKplBH
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: lJt3xtYVobAo8Kf3zMUT2NzuXELQBofB
X-Authority-Analysis: v=2.4 cv=KLhqylFo c=1 sm=1 tr=0 ts=6a606504 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=EXGRFEm-sg837V2a6F4A:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfXzsPkXE0+Qdj5
 iQuYhbgtQDFd662ZF6WwDDYVHix8t/esqopXkNVN+95BRuXn1ScD84nix+BMnEds5rZTP0UxoB5
 EI0xjq1T7qnLHc67spNxzKKByghz7FM6TxQ6yA+rFLXqmVcjJQJ2Au3wXzKkdwKGq50aVHdc2x2
 wkqsBHiVA1oXPCO7ubC+DH9jwU0HP443Q43NTpuCEglGgrC1vF4SwJcQ2UBGouTnV7H5CBUfNze
 X4vCroK4x7r4I3a4hk6raGjOKVV93cgdE3ppoSwU9GWqD6gOE4vKK3e1G14o8zJpcOkfT1005wE
 VhYWzRSdg7Dr9MEtqAsHo8YMn5H+nFGF0lW5uGiaWfn7KObqZ1TNtqkKE436MhqZiqSVjeeR4rw
 qgp2BVpyEfhLWqgPuXpyUIQyoYYMzbpdgxGe3NcOOaH9/dROdq6K41UT2xmISoBsbXIKfBKLp73
 vcgsCXn9Kj7CCDL/OTw==
X-Proofpoint-ORIG-GUID: lJt3xtYVobAo8Kf3zMUT2NzuXELQBofB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX8bfRdzNHMluo
 9yPtpySS6M6iBhSg79EOKjlSsD6T+TUzU7wELIoOLoRjMEid3TQIwHjv7uwoqPPG52zQ95Cr7MK
 odUZbIwFgzpqk1QBwYB2MgCPX6u6yWk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220060
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

dpu_encoder_is_widebus_enabled() switches on the interface type to call
either msm_dsi_wide_bus_enabled() or msm_dp_wide_bus_available(), two
differently named sub-block functions.

Replace them with a single mandatory wide_bus_enabled() callback on
struct msm_display_funcs. DSI and DP implement it (DP keeps its internal
msm_dp_wide_bus_available() helper, now declared privately in
dp_display.h); HDMI, which never drives a wide bus, returns false.

Add a dpu_encoder_get_display() helper that maps a struct msm_display_info
to its struct msm_display, so the DPU encoder can look up the sub-block
and call the callback without open-coding the interface-type switch. It is
reused by the following callback conversions.

No functional change intended.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 42 +++++++++++++++++++++--------
 drivers/gpu/drm/msm/dp/dp_display.c         |  8 ++++++
 drivers/gpu/drm/msm/dp/dp_display.h         |  1 +
 drivers/gpu/drm/msm/dsi/dsi.c               |  5 +++-
 drivers/gpu/drm/msm/hdmi/hdmi.c             |  6 +++++
 drivers/gpu/drm/msm/msm_drv.h               | 14 +++-------
 6 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 1f20695f81e3..ce358c1c9757 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -268,25 +268,45 @@ bool dpu_encoder_needs_periph_flush(struct dpu_encoder_phys *phys_enc)
 	       msm_dp_needs_periph_flush(priv->kms->dp[disp_info->h_tile_instance[0]], mode);
 }
 
+/**
+ * dpu_encoder_get_display - find the display sub-block driving an interface
+ * @dev:        the DRM device
+ * @disp_info:  the interface description
+ *
+ * Return: the &struct msm_display (DSI/DP/HDMI) driving the interface, or NULL
+ * for interfaces (e.g. writeback) that have no such sub-block.
+ */
+static struct msm_display *dpu_encoder_get_display(struct drm_device *dev,
+		const struct msm_display_info *disp_info)
+{
+	struct msm_drm_private *priv = dev->dev_private;
+	int index = disp_info->h_tile_instance[0];
+
+	switch (disp_info->intf_type) {
+	case INTF_DP:
+		return msm_dp_get_display(priv->kms->dp[index]);
+	case INTF_DSI:
+		return msm_dsi_get_display(priv->kms->dsi[index]);
+	case INTF_HDMI:
+		return msm_hdmi_get_display(priv->kms->hdmi);
+	default:
+		return NULL;
+	}
+}
+
 /**
  * dpu_encoder_is_widebus_enabled - return bool value if widebus is enabled
  * @drm_enc:    Pointer to previously created drm encoder structure
  */
 bool dpu_encoder_is_widebus_enabled(const struct drm_encoder *drm_enc)
 {
-	const struct dpu_encoder_virt *dpu_enc;
-	struct msm_drm_private *priv = drm_enc->dev->dev_private;
-	const struct msm_display_info *disp_info;
-	int index;
+	const struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
+	struct msm_display *display;
 
-	dpu_enc = to_dpu_encoder_virt(drm_enc);
-	disp_info = &dpu_enc->disp_info;
-	index = disp_info->h_tile_instance[0];
+	display = dpu_encoder_get_display(drm_enc->dev, &dpu_enc->disp_info);
 
-	if (disp_info->intf_type == INTF_DP)
-		return msm_dp_wide_bus_available(priv->kms->dp[index]);
-	else if (disp_info->intf_type == INTF_DSI)
-		return msm_dsi_wide_bus_enabled(priv->kms->dsi[index]);
+	if (display)
+		return display->funcs->wide_bus_enabled(display);
 
 	return false;
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index f4fa86d1b9c7..04d291a93d20 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1354,9 +1354,17 @@ static int msm_dp_modeset_init(struct msm_display *display,
 	return 0;
 }
 
+static bool msm_dp_display_wide_bus_enabled(struct msm_display *display)
+{
+	struct msm_dp *dp = container_of(display, struct msm_dp, display);
+
+	return msm_dp_wide_bus_available(dp);
+}
+
 static const struct msm_display_funcs msm_dp_display_funcs = {
 	.modeset_init = msm_dp_modeset_init,
 	.snapshot = msm_dp_snapshot,
+	.wide_bus_enabled = msm_dp_display_wide_bus_enabled,
 };
 
 struct msm_display *msm_dp_get_display(struct msm_dp *msm_dp_display)
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 20a71afb1f90..8c34a473c7db 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -34,6 +34,7 @@ int msm_dp_display_get_test_bpp(struct msm_dp *msm_dp_display);
 void msm_dp_display_signal_audio_start(struct msm_dp *msm_dp_display);
 void msm_dp_display_signal_audio_complete(struct msm_dp *msm_dp_display);
 void msm_dp_display_set_psr(struct msm_dp *dp, bool enter);
+bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
 void msm_dp_display_debugfs_init(struct msm_dp *msm_dp_display, struct dentry *dentry, bool is_edp);
 
 #endif /* _DP_DISPLAY_H_ */
diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index c86142f66237..ce3b261123ea 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -17,8 +17,10 @@ struct drm_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi)
 	return msm_dsi_host_get_dsc_config(msm_dsi->host);
 }
 
-bool msm_dsi_wide_bus_enabled(struct msm_dsi *msm_dsi)
+static bool msm_dsi_wide_bus_enabled(struct msm_display *display)
 {
+	struct msm_dsi *msm_dsi = container_of(display, struct msm_dsi, display);
+
 	return msm_dsi_host_is_wide_bus_enabled(msm_dsi->host);
 }
 
@@ -279,6 +281,7 @@ static void msm_dsi_snapshot(struct msm_display *display,
 static const struct msm_display_funcs msm_dsi_display_funcs = {
 	.modeset_init = msm_dsi_modeset_init,
 	.snapshot = msm_dsi_snapshot,
+	.wide_bus_enabled = msm_dsi_wide_bus_enabled,
 };
 
 struct msm_display *msm_dsi_get_display(struct msm_dsi *msm_dsi)
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 72ab2e92964e..5f24f778c7ef 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -228,9 +228,15 @@ static void msm_hdmi_snapshot(struct msm_display *display,
 				    hdmi->mmio, "hdmi");
 }
 
+static bool msm_hdmi_wide_bus_enabled(struct msm_display *display)
+{
+	return false;
+}
+
 static const struct msm_display_funcs msm_hdmi_display_funcs = {
 	.modeset_init = msm_hdmi_modeset_init,
 	.snapshot = msm_hdmi_snapshot,
+	.wide_bus_enabled = msm_hdmi_wide_bus_enabled,
 };
 
 struct msm_display *msm_hdmi_get_display(struct hdmi *hdmi)
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index d25d783b4f11..519571170207 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -283,12 +283,15 @@ struct msm_disp_state;
  *                to @encoder.
  * @snapshot:     capture the sub-block's state for a display snapshot;
  *                mandatory.
+ * @wide_bus_enabled: whether the sub-block drives a wide (2 pixel/clock) bus;
+ *                    mandatory.
  */
 struct msm_display_funcs {
 	int (*modeset_init)(struct msm_display *display, struct drm_device *dev,
 			    struct drm_encoder *encoder);
 	void (*snapshot)(struct msm_display *display,
 			 struct msm_disp_state *disp_state);
+	bool (*wide_bus_enabled)(struct msm_display *display);
 };
 
 /**
@@ -327,7 +330,6 @@ struct msm_display *msm_dsi_get_display(struct msm_dsi *msm_dsi);
 bool msm_dsi_is_cmd_mode(struct msm_dsi *msm_dsi);
 bool msm_dsi_is_bonded_dsi(struct msm_dsi *msm_dsi);
 bool msm_dsi_is_master_dsi(struct msm_dsi *msm_dsi);
-bool msm_dsi_wide_bus_enabled(struct msm_dsi *msm_dsi);
 struct drm_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi);
 const char *msm_dsi_get_te_source(struct msm_dsi *msm_dsi);
 #else
@@ -353,10 +355,6 @@ static inline bool msm_dsi_is_master_dsi(struct msm_dsi *msm_dsi)
 {
 	return false;
 }
-static inline bool msm_dsi_wide_bus_enabled(struct msm_dsi *msm_dsi)
-{
-	return false;
-}
 
 static inline struct drm_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi)
 {
@@ -376,7 +374,6 @@ void __exit msm_dp_unregister(void);
 struct msm_display *msm_dp_get_display(struct msm_dp *dp_display);
 bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
 			       const struct drm_display_mode *mode);
-bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
 
 #else
 static inline int __init msm_dp_register(void)
@@ -397,11 +394,6 @@ static inline bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
 	return false;
 }
 
-static inline bool msm_dp_wide_bus_available(const struct msm_dp *dp_display)
-{
-	return false;
-}
-
 #endif
 
 #ifdef CONFIG_DRM_MSM_MDP4

-- 
2.47.3

