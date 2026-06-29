Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE410C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C0EF10E8C4;
	Mon, 29 Jun 2026 13:17:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bC/qF17P";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IzpZiQwL";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 953BE10E8C4
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:49 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATEBc2579144
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wMuCUkGM/5ZuNYaTfCD+8LGq0IU6gFC3uoV0LKcWT8I=; b=bC/qF17PTw/XzT+W
 EZ7+JqzDsgwoMCLJNYTKKov8r5pSbDmFGWiZZD3gQWyirznuZLowhp3dLjpaCo4A
 UPTr5Ouv+qjBal2wFK+B0xExMWaptuIF/d0KrAOxYH2dvwhyZZ3mlNz/1zhKmhqQ
 rDMYAwmst6fxskwtaN0GfXcVasP6rKY90ud/zgoRAnFtgA0/a8w6LjsYTct2xMxJ
 PDNSxpnvP+u7GxKs+vLhLbMYu75WvFa7+neyhpSXT/qF6M0A5hfqJMKfn6UByXSA
 YaijTS1hjaE9dEe/tlm8MisAMJ1tZTeUDwdmsVV6U+1gg6QnxozitlqVR+vFxJMx
 oVADxg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7hgab-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:49 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8eeba1d9e47so36459086d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782739068; x=1783343868;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wMuCUkGM/5ZuNYaTfCD+8LGq0IU6gFC3uoV0LKcWT8I=;
 b=IzpZiQwL5qpr4IgfcvFDmPAPhE8txfsLJ4p7DCyU5JIl4GSdffyPBMsJcXa1MGbyBH
 GNLNdkKNgZwYPCGZ7bHqVXy0dY8dBCh7/+lgv1RnjCId0aaLN/8qDOcwtcgzn+vrGx8h
 /65mIQF5btZTe0Psoon3ua2BV2TVZxR59byONmITEfLFpYWQ0baAGTz0hGMC0z/q5OPG
 hLX931btD6Pa3g3wRF2LdIgfbWyWArjEUub4QKyfmdVi4+kL/bG0fB/AawEpiCOoDSti
 l/z+IZ2JJ4fksAG1n16ubO4uDen+sbqKevCuYC9ZfiTNgkmrkgckbfO1phMI8RNp+v2c
 rtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782739068; x=1783343868;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wMuCUkGM/5ZuNYaTfCD+8LGq0IU6gFC3uoV0LKcWT8I=;
 b=qQfYP38PjDQa+D7DhfCpq2SihVN7ppFFcvqf96QHJoGTWDNwl6lmed8iPaJY/sQDya
 CptDlaV8amVo+XO82xsnNrAHq9SP+kqvsiD887LSHXcjakyS3ez2exZyhcuOnsv9Q7y+
 SqK/DjbIbDHNgrgmce2s0wVzppRDWjAjzVGZZ5hDyc0B1W6SIznsUDIy4W5Pak8WQGbY
 6VPyr8gcLOoC14keQiRnbJa4qodGQnc3Ib4DZqENua0OHj/GrZunhPJPYRRxyB2NeJv6
 mun+xt1pewbUY0nL9APwfEtZkSlxQLgVsM2vJ56H4TXgev9vAe92kaXToz+MJGfNjWMF
 gBKg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCWDzLJwIw8BnVAFTjGCuWcGUav0fjMg1sqEk6Cqu9NkLIF+FwXSScQvutXwO7d87i52rsV/G3HXo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwN9IgFMePoW5O1LqB0xlJ5wYoCzntrnsS9mMEJYgwd+ZzHes+v
 pjkJFjWH6ksV2hRXgkekhPkimlxzbZdqUQzSA7FTN2Rf5t/YqRz9WPaVZtj45U03U8ZdKSOAKBJ
 65fP2vBxPMWnLDm+SM4fwJsBx7lDqJSBPjryRyDhVtZQ/O9tD9rGHkrlfOWuCDIGdytxnF0w=
X-Gm-Gg: AfdE7clxgUqgjH45ZPwSXlhCIRw/heBBRniwmRq8baO8rBcEduajgRPVDZdZG2Wad+a
 D9NDUailBgUVk/kK9Xdx7U/WMKj7zzl44ikx7DnH/OfXtxgvwCEFBQULjHnwNTkCwwXsAJFPc4Q
 J7VIaFLJQf+73tY+hXyXkGTGtqZ0PH/7yGOlqH4c6nBPs9IpF+iwuRIw8HB5IIzK3amy7ZDogAl
 isRdvIhhMj8TCRYVGT15HDjj4FM9QhgT4v5HQmCv0ygUQ9/4b5olHAO3u7wOE+JeccejsAvDhAg
 eAqcKwOUdsyI7b5vTPhiT3GQdhcFMztI6X9n4mh1rTFHSw4fPAj0u2180mwuLQfluJUnddBg5EC
 uLUF0I2OQHTJQMS5aPcwJOLywqmqPfXNEzNM5wbcFeQDhbKXFUmgRd85QO/7iaJfQjSDFil0Nig
 ==
X-Received: by 2002:a05:6214:19eb:b0:8f1:440c:7f81 with SMTP id
 6a1803df08f44-8f156ef576amr13537196d6.4.1782739067873; 
 Mon, 29 Jun 2026 06:17:47 -0700 (PDT)
X-Received: by 2002:a05:6214:19eb:b0:8f1:440c:7f81 with SMTP id
 6a1803df08f44-8f156ef576amr13536466d6.4.1782739067159; 
 Mon, 29 Jun 2026 06:17:47 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ef0f2b9df0sm56744616d6.13.2026.06.29.06.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:17:46 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 21:16:33 +0800
Subject: [PATCH v5 15/25] drm/msm/dp: add an API to initialize MST on sink side
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-msm-dp-mst-v5-15-1d882d9012f4@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
In-Reply-To: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782738985; l=3085;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=rWGVRQL4yrr/+OcPJZsE2NbhmKlJWDJ86JwhFSr0tHA=;
 b=xCIcIDG7pws1ClQd7PC3CwUlNQhBJI8jVvRfykcS3wrdmsxLhNMkla8CXIHQvrko+Rhx8J7Er
 4Yl+YOgG7DnBOTSoCycNmMHaLw4Rd6b++2BuFujbs/GrYqxTwhTsB3c
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfXzdNclVwlFbyK
 HurJuJu4DNS+zc+xddplrMxYutWrc1EREvBa1rt3dsPu6XbY1KWwJpnw5fKVgS27igBBFtQ4HPJ
 vPY97XH94EJ1GJAC311lOQmqC11NbT0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfXwlTx4+A9cVD4
 O0gP/y51uumg8SRF4eCTafWXGqdzMbUVS0xNwJDAJSBoQ/gztVRznbSPMqY4p/OAkiLr7/J0Lhm
 shsvpLn+a4Mgm0j0aeYTzl3RCNlUklwp3CxqQq12/1OfhnON1EsovVI9zCoU+IYcwyOVRIk0BRg
 NBkoPWfR/wU2dmRxw7cqLjRbgHsjK+WZaxOwgXslYIFEZoYU+vfbUJ2pGQxwncyc/kJ0NB1hZPp
 P6AzaCpbEybh62z6Eeda0vEDqk0zcX4J3laVidgefgV6i0TQm0oy5kPbHvv9YEkPmAgNJ83J/ib
 wO3olxXDu0fl6M1fxSYNnaioQHwj6ZOYJyoyRuhVXAzl9oATy9CMgB1goDmDuEnMbOqDbICJFdU
 SHcETibcuwskN42gCoBEVkyP9dhnM+qgI9fLtDzmEy3qG8XyV/eWSuUARZG8tUSD0bBNJIqBJEc
 RkdwLfeWKhGfjNiTxoQ==
X-Proofpoint-ORIG-GUID: 1hZpk-1iFPSbJowSTRRQNpr85khwOg3N
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a42707d cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=vCCEq3Mv4WXTdc8uXsoA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 1hZpk-1iFPSbJowSTRRQNpr85khwOg3N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
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

If the DP controller is capable of supporting multiple streams
then initialize the DP sink in MST mode by programming the DP_MSTM_CTRL
DPCD register to enable MST mode.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 48 +++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 5786e598a406..c3be656f10ee 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -14,6 +14,7 @@
 #include <linux/string_choices.h>
 #include <drm/display/drm_dp_aux_bus.h>
 #include <drm/display/drm_hdmi_audio_helper.h>
+#include <drm/display/drm_dp_mst_helper.h>
 #include <drm/drm_edid.h>
 
 #include "msm_drv.h"
@@ -270,6 +271,31 @@ static int msm_dp_display_lttpr_init(struct msm_dp_display_private *dp, u8 *dpcd
 	return lttpr_count;
 }
 
+static void msm_dp_display_mst_init(struct msm_dp_display_private *dp)
+{
+	u8 old_mstm_ctrl;
+	struct msm_dp *msm_dp = &dp->msm_dp_display;
+	int ret;
+
+	/* clear sink MST state */
+	drm_dp_dpcd_read_byte(dp->aux, DP_MSTM_CTRL, &old_mstm_ctrl);
+
+	ret = drm_dp_dpcd_write_byte(dp->aux, DP_MSTM_CTRL, 0);
+	if (ret < 0) {
+		DRM_ERROR("failed to clear DP_MSTM_CTRL, ret=%d\n", ret);
+		return;
+	}
+
+	ret = drm_dp_dpcd_write_byte(dp->aux, DP_MSTM_CTRL,
+				     DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC);
+	if (ret < 0) {
+		DRM_ERROR("sink MST enablement failed\n");
+		return;
+	}
+
+	msm_dp->mst_active = true;
+}
+
 static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 {
 	struct drm_connector *connector = dp->msm_dp_display.connector;
@@ -288,14 +314,19 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	if (rc)
 		goto end;
 
-	drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
-	drm_edid_connector_update(connector, drm_edid);
+	if (!(dp->max_stream > 1) || !drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd)) {
+		drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
+		drm_edid_connector_update(connector, drm_edid);
 
-	if (!drm_edid) {
-		DRM_ERROR("panel edid read failed\n");
-		/* check edid read fail is due to unplug */
-		if (!msm_dp_aux_is_link_connected(dp->aux))
-			return -ETIMEDOUT;
+		if (!drm_edid) {
+			DRM_ERROR("panel edid read failed\n");
+			/* check edid read fail is due to unplug */
+			if (!msm_dp_aux_is_link_connected(dp->aux))
+				return -ETIMEDOUT;
+		}
+
+		if (rc)
+			goto end;
 	}
 
 	msm_dp_link_process_request(dp->link);
@@ -317,6 +348,9 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	 */
 	msm_dp_link_psm_config(dp->link, &dp->panel->link_info, false);
 
+	if (dp->max_stream > 1 && drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd))
+		msm_dp_display_mst_init(dp);
+
 	msm_dp_link_reset_phy_params_vx_px(dp->link);
 
 end:

-- 
2.43.0

