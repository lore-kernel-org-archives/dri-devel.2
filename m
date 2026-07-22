Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCBFC4451C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 122E310EC68;
	Wed, 22 Jul 2026 06:37:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pj/GOYzf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M7OSsGoS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0B5110EC64
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:58 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53pae3787372
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rGpNlcLNCKBAGjCH7PVJuWAxbvSjcIcNj9l3odZvHF8=; b=pj/GOYzft/MdCvdr
 BOLWknwlOUzEccWqhoYuIovEbcRZvpCX4hA/rrZGdWNi5FsMeu3kaOaxeo60Sncn
 4jdXAbxOve1z0u5hsWe8uyy5GqZWQSIGXzqvgnjMt9+6FQKj/BMvnPZTs6nmeO3e
 fwOvdbJ/0+nk+ZNhdHgsNRg3zx8HLgYhjdQjisAboGUWXeimu4uz3V5IT33cQo6b
 8AIsz3nnQoyahEorwVPUoeAh0ZgLpR5o73fQ5yUm5jJZpZAZktgz+Ss4jPEfve8X
 tNjYRJtRrTNpjONuIuIovg7o+cp8IC406G1wbKIb1J+xsWJz0WYyDLuXz6Za/F7G
 fo2nmQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9aec0c1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1a97644aso34077801cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702217; x=1785307017;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rGpNlcLNCKBAGjCH7PVJuWAxbvSjcIcNj9l3odZvHF8=;
 b=M7OSsGoSpErftgBZp8mJvSv20XwGv5Y4Y5wBYvMug5QM8VNgfcv9wkToZZ4x6L6X1G
 wUwW2CRc91ycY/qmmOW3A4Wc4B+Ygd76jHd/ArnA9JuXUA+uOCD3V6c19gaZsmNP+SWt
 5S01sPG3XVa8JJUsEMzYjsxnwEW+qELDghqyKbRtO+JCcuECEKjaMhOPHBMjGGJ78cJw
 WXAvzk/RP36wlVtt2LcSomIJzUrkvhLfsMwmwuV4wqDjAz+R4g51/yGbwKOGP+Fv62bs
 Xz4B5MOwWwnuj0kxU0NlX+jVpCmAOlg/9/ntMYXeUvZISJh5bjy+Gb6Zp20cIZEyYzu7
 o60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702217; x=1785307017;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rGpNlcLNCKBAGjCH7PVJuWAxbvSjcIcNj9l3odZvHF8=;
 b=a48/kTjRG/tipJlPsUz5ckhI+EOpi66IzV8/en6pkhwpQ43f3Pm/5hSJYtPmIlpeHk
 NKl2psWEiQAI2PvdrMZt2oYFnOjrKzCpuub/aoR0jUiSt7gdg+iiJwPRpNWF5ywv1juA
 3VbzXczg8uNmYPmVKXAVz6lAiC0FUjBL3Op2oSWO4/fPqOZ6s3pcy9mqi3JcCsryZ87f
 6nSBS1WVYPU7+CF3dYr9WeOtNa2vmgLNlVvO9KwAxLadGb1ptDT3h4ecmPLKv/exbC3m
 0hScT0vvJFgotK0LeSK2uzxWdfWPv8hqH8MFsH7e76pSsurVrsR7UP1pwXIcQsmepv2E
 k7Ag==
X-Forwarded-Encrypted: i=1;
 AHgh+RpcKE0nL5E+cOUu/UDK8QaGm4VCM+HwF32ZvrtEFupAmPaBmrMl6EwAI6czQoyTsiF6UOkqc5WGk2Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyek/yiyuA0EUnynMQB0NcZ03sK+Pn9sSVBrQR4x7FLVuwuGFZv
 INEEpbBYaU9keYx2XUHoXCVwDPw5gPf/S5uqTTeOZ718DePEVD/rrInmFS/kz0R9qA88NFXf69P
 Du+OMiMr2/jJmEHcicyujOdsgR6bgE7Hxs6mitQeHUMcbFGlCBwkmuIy0/aeMhhGLaNj7oeE=
X-Gm-Gg: AR+sD113lx4ySgLKs3hedySmaK25c//jy0Hv+u5HSXhO/T2uRc/Rro01phex/jZhHme
 dU5j/APyDgdFB7uYthGIuTAfR0eHrmMovRKfRcuugncjFRdv6xrOU4u582B69dVsMZvQtLwGv99
 4z6qhT2eQFY0/XNyyCnWcWjWnnSF94o3Lgl11P8P1qTpheOgUHO7KTmBHTTuCbc5QQTXGQkU6Ka
 +SWaqI1ert3Ddw9OKQ3E3fcLw3JJivXMUjfrVbw6NYNApNT+82qTiJI3Si89KdNyrOHM/bOz2JL
 bIFvfM8li1URbLJsWiyDPSQNNVF7zrt0gyFHHIbArrqx4keX/j2Azjzy/lkQO56ZRFooFa6HBBI
 aH5Nm1EelclcDsJDHYpWV8LMvJyAl1J5QDgf0bXuwOC8abHYOJ36xHdtFTGRIFKSS2P4h8sISPw
 PoUkZzM3rnwkzt3Q==
X-Received: by 2002:a05:622a:4d44:b0:51c:7b11:41b5 with SMTP id
 d75a77b69052e-5213f374d31mr206859771cf.81.1784702216754; 
 Tue, 21 Jul 2026 23:36:56 -0700 (PDT)
X-Received: by 2002:a05:622a:4d44:b0:51c:7b11:41b5 with SMTP id
 d75a77b69052e-5213f374d31mr206859571cf.81.1784702216299; 
 Tue, 21 Jul 2026 23:36:56 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c6f6sm309696e87.4.2026.07.21.23.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:36:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:36:24 +0300
Subject: [PATCH 09/24] drm/msm: add the is_cmd_mode callback to msm_display
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-drm-msm-display-interface-v1-9-368c10fe62fd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6968;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=pBWRP7CW7402hSiIR+bCI9JjVAYLuwniHNi90OzwRGE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqYGTnExifL7rU2hhr3InCOFU2scDV4u7idMuBy
 gAPLvZgO8qJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamBk5wAKCRCLPIo+Aiko
 1Tt2B/9WUmKit0v/CTdVHUMLqa2W5b9YySHhAfqcTt9d6EIvnFcjzrSHuxEqKWWc4GETLCDUbOC
 hRjV6n7PajHSCAwahTPrEWDyYOvoaRoL3nRxTP7EA0M/P28kklYPxNhRkRQnngCS54uFgJlzl3p
 xNO25vvxiNviXQLn8Sd82kGxxP2OJmYZuYMTH0CwH7xuXYhQzKbMNEqfiZBvLvxRyDuxxwsoX6A
 5ZnNpy4KzIpv3zAnJs3w6XM+qdwanvOFVBT/3rnw0kM4oVung5NxWj6NOlFLnVU/OQklsfzjz+Q
 zTfobVeiiyj7RLIuBNXv8SU4ukNe4SXKVpg6Hb5YhURQUesn
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 8RqlqHTaHURkt7kT11-HL1ES-BGLPgiZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfXzkY4KICK8uvb
 AAeAFZdHduF2j1p9EkksGbdvTaSQI3kOqRMVfl4rgiP2JbiaLA/ky8yPAbVO2yy3MttDetrL+N3
 XrIYykhxRva9zQHBytyICT0b/HsaVkE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfXwP2x42PCnAoR
 pN9GyyDo2r7xvbiPyXBrGqB0HkkuwKbD75OGhlBuFlNQrQD5aABsPI9s0IBi0BKAfzdmxmqP9kx
 zwGIZsdTEQB4FltODOHQrcursjSDkvf1TN+FkaXsqnaSqkguPlbHAAZ2fhY7dSpYO6pWRETljhk
 RAVQQXwtpCKsp8NGVJ4YvSlH2rVEMKJrJeqJv5aK5hPBMDdSjAts0T5AII8yjBmqHBVYhSB39mJ
 72oJtlOaLFXkK5pcxwUssmo+IGP4a+Za9Y4rxGyPwfWDV7f5PogFqkAlqLDBNHxQajLCUWZvuT6
 9BWTVP0YSUOXKgQXeNTPfSO5Nusz1mx4UHCc2F1m0F0TsviL/z3HQmLRKYhF//2N4q+ZGsAIsPs
 Lcp4hiUpRICIO2qj2oOY6r7Hmxj7GAcDPA2u0x3++43TS3tdpLPSStJ2Vj3t8/1oyKLW3OfefpM
 ka1B3xWngqDTJDGLiiw==
X-Proofpoint-GUID: 8RqlqHTaHURkt7kT11-HL1ES-BGLPgiZ
X-Authority-Analysis: v=2.4 cv=Cr6PtH4D c=1 sm=1 tr=0 ts=6a606509 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=U3fWpF8k-n0SBARnw3cA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220060
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

The DPU and MDP5 backends query whether a DSI link runs in command mode by
calling msm_dsi_is_cmd_mode() directly on the concrete sub-block while
building their encoders.

Add a mandatory is_cmd_mode() callback to struct msm_display_funcs; DSI
implements it, DP and HDMI (always video) return false. The backends
dispatch through the callback.

No functional change intended.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c  | 4 +++-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 4 +++-
 drivers/gpu/drm/msm/dp/dp_display.c      | 6 ++++++
 drivers/gpu/drm/msm/dsi/dsi.c            | 4 +++-
 drivers/gpu/drm/msm/hdmi/hdmi.c          | 6 ++++++
 drivers/gpu/drm/msm/msm_drv.h            | 7 ++-----
 6 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 42dff1a98292..7928bc1a73f3 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -583,6 +583,7 @@ static int _dpu_kms_initialize_dsi(struct drm_device *dev,
 {
 	struct drm_encoder *encoder = NULL;
 	struct msm_display_info info;
+	struct msm_display *display;
 	int i, rc = 0;
 
 	if (!(priv->kms->dsi[0] || priv->kms->dsi[1]))
@@ -613,7 +614,8 @@ static int _dpu_kms_initialize_dsi(struct drm_device *dev,
 		if (msm_dsi_is_bonded_dsi(priv->kms->dsi[i]))
 			info.h_tile_instance[info.num_of_h_tiles++] = other;
 
-		info.is_cmd_mode = msm_dsi_is_cmd_mode(priv->kms->dsi[i]);
+		display = msm_dsi_get_display(priv->kms->dsi[i]);
+		info.is_cmd_mode = display->funcs->is_cmd_mode(display);
 
 		rc = dpu_kms_dsi_set_te_source(&info, priv->kms->dsi[i]);
 		if (rc) {
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 68b71a7c6666..e372d295b80f 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -337,6 +337,7 @@ static int modeset_init_intf(struct mdp5_kms *mdp5_kms,
 		const struct mdp5_cfg_hw *hw_cfg =
 					mdp5_cfg_get_hw_config(mdp5_kms->cfg);
 		int dsi_id = get_dsi_id_from_intf(hw_cfg, intf->num);
+		struct msm_display *display;
 
 		if ((dsi_id >= ARRAY_SIZE(priv->kms->dsi)) || (dsi_id < 0)) {
 			DRM_DEV_ERROR(dev->dev, "failed to find dsi from intf %d\n",
@@ -360,9 +361,10 @@ static int modeset_init_intf(struct mdp5_kms *mdp5_kms,
 			break;
 		}
 
+		display = msm_dsi_get_display(priv->kms->dsi[dsi_id]);
 		priv->kms->dsi_encoder[dsi_id] = encoder;
 		mdp5_encoder_set_intf_mode(encoder,
-					   msm_dsi_is_cmd_mode(priv->kms->dsi[dsi_id]));
+					   display->funcs->is_cmd_mode(display));
 
 		break;
 	}
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 773dee9d0be4..425526db7ef9 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1369,11 +1369,17 @@ static bool msm_dp_display_needs_periph_flush(struct msm_display *display,
 	return msm_dp_needs_periph_flush(dp, mode);
 }
 
+static bool msm_dp_display_is_cmd_mode(struct msm_display *display)
+{
+	return false;
+}
+
 static const struct msm_display_funcs msm_dp_display_funcs = {
 	.modeset_init = msm_dp_modeset_init,
 	.snapshot = msm_dp_snapshot,
 	.wide_bus_enabled = msm_dp_display_wide_bus_enabled,
 	.needs_periph_flush = msm_dp_display_needs_periph_flush,
+	.is_cmd_mode = msm_dp_display_is_cmd_mode,
 };
 
 struct msm_display *msm_dp_get_display(struct msm_dp *msm_dp_display)
diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index 085e202bf7e6..bda778dbcc5b 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -5,8 +5,9 @@
 
 #include "dsi.h"
 
-bool msm_dsi_is_cmd_mode(struct msm_dsi *msm_dsi)
+static bool msm_dsi_is_cmd_mode(struct msm_display *display)
 {
+	struct msm_dsi *msm_dsi = container_of(display, struct msm_dsi, display);
 	unsigned long host_flags = msm_dsi_host_get_mode_flags(msm_dsi->host);
 
 	return !(host_flags & MIPI_DSI_MODE_VIDEO);
@@ -289,6 +290,7 @@ static const struct msm_display_funcs msm_dsi_display_funcs = {
 	.snapshot = msm_dsi_snapshot,
 	.wide_bus_enabled = msm_dsi_wide_bus_enabled,
 	.needs_periph_flush = msm_dsi_needs_periph_flush,
+	.is_cmd_mode = msm_dsi_is_cmd_mode,
 };
 
 struct msm_display *msm_dsi_get_display(struct msm_dsi *msm_dsi)
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 72f7403265f9..828cb89ebf9a 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -239,11 +239,17 @@ static bool msm_hdmi_needs_periph_flush(struct msm_display *display,
 	return false;
 }
 
+static bool msm_hdmi_is_cmd_mode(struct msm_display *display)
+{
+	return false;
+}
+
 static const struct msm_display_funcs msm_hdmi_display_funcs = {
 	.modeset_init = msm_hdmi_modeset_init,
 	.snapshot = msm_hdmi_snapshot,
 	.wide_bus_enabled = msm_hdmi_wide_bus_enabled,
 	.needs_periph_flush = msm_hdmi_needs_periph_flush,
+	.is_cmd_mode = msm_hdmi_is_cmd_mode,
 };
 
 struct msm_display *msm_hdmi_get_display(struct hdmi *hdmi)
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 806d72ed393b..5320e4977af9 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -286,6 +286,7 @@ struct msm_disp_state;
  * @wide_bus_enabled: whether the sub-block drives a wide (2 pixel/clock) bus;
  *                    mandatory.
  * @needs_periph_flush: whether @mode requires a peripheral flush; mandatory.
+ * @is_cmd_mode:  whether the sub-block runs in command mode; mandatory.
  */
 struct msm_display_funcs {
 	int (*modeset_init)(struct msm_display *display, struct drm_device *dev,
@@ -295,6 +296,7 @@ struct msm_display_funcs {
 	bool (*wide_bus_enabled)(struct msm_display *display);
 	bool (*needs_periph_flush)(struct msm_display *display,
 				   const struct drm_display_mode *mode);
+	bool (*is_cmd_mode)(struct msm_display *display);
 };
 
 /**
@@ -330,7 +332,6 @@ void dsi_dev_detach(struct platform_device *pdev);
 void __init msm_dsi_register(void);
 void __exit msm_dsi_unregister(void);
 struct msm_display *msm_dsi_get_display(struct msm_dsi *msm_dsi);
-bool msm_dsi_is_cmd_mode(struct msm_dsi *msm_dsi);
 bool msm_dsi_is_bonded_dsi(struct msm_dsi *msm_dsi);
 bool msm_dsi_is_master_dsi(struct msm_dsi *msm_dsi);
 struct drm_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi);
@@ -346,10 +347,6 @@ static inline struct msm_display *msm_dsi_get_display(struct msm_dsi *msm_dsi)
 {
 	return NULL;
 }
-static inline bool msm_dsi_is_cmd_mode(struct msm_dsi *msm_dsi)
-{
-	return false;
-}
 static inline bool msm_dsi_is_bonded_dsi(struct msm_dsi *msm_dsi)
 {
 	return false;

-- 
2.47.3

