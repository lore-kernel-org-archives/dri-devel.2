Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13345C624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56AFE10E743;
	Mon, 31 Aug 2026 08:20:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iqHW096j";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="idsZCEeB";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F63110E741
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:20:05 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xBUm3664487
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JMJxYVwjgN4k+mFm4VS/dxq4WKhyHKBwLuJ9pdotNNg=; b=iqHW096jC8G2TY7F
 A/sCxxKlh2JlDNudHSy7rX4iUJnbcNoU0kknjyszC7uNWIO8gDLZlrw690NJIRaN
 uJJ4OBQmcQ1/qxY5r89xhMPWattX+VZsR4rlGVR80eZ7NJS9iCNoxEogOzXWcp3J
 2fhgiRtnEuEc1RN7LZbdqiB7P0vpMpwCLR0r7tYiV0fYX9y963rsxnWiuuVuB5Up
 3bG9Zt8qbeYt4IOhJJaDm7ZyEDijM6f2ThK/W+ok8YNdrTaIzYin8rVo723GeMQE
 dMXZQZTAxtPce56VnJkmxWtjNwNWqCK4Sx7HTN9TNASTRZcI49taH8V86RN1NPPj
 f73Hxw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd4x089sp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:20:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9382f9430deso504847485a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 01:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788164404; x=1788769204;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JMJxYVwjgN4k+mFm4VS/dxq4WKhyHKBwLuJ9pdotNNg=;
 b=idsZCEeBolI6Yo04+UmYiVSnPScmaVmhtwL7ubQzbU3rxtrq76Hd/intVK0z3dVmDh
 YfiwNWwWcINMSpVQqOaRGLux/N3xsI/SfCnbNaAJnVHDf6iKGlV8o8baq1HORDeHshBe
 r4MVOvSVapFkYU1hEKVJ50s5nXJCz/SpuHoqplKUC5UY7Ax4pIUZJCG979CNxu02jcWq
 SYdZGYJ6rYiuBO18kJJVQXkTv3c889wTMa24/L67zpnNnk4xnr1t2kjFt3q01Q/QAeoK
 LIp/Zx0C7eLOju/kj64aRdu9eJw3V5WtSeOfSIqRO0tz4pjCss11sTqanq9zh97KZ+rN
 tqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164404; x=1788769204;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JMJxYVwjgN4k+mFm4VS/dxq4WKhyHKBwLuJ9pdotNNg=;
 b=qGLttKPhlHLwYHNWKF2uJVSCFnUhiFtsfST/2mEVEG7hw87J0mV8hoCEh8sjE7LbDl
 +nrGVfKiplV1gPcEAqlum3vB2twyMJFOaOFt9AeYt3xCtAL+9bxAlZ0L6qRykrGU+HSv
 04lxOvQsK8s2407O3rqGT3VclxRb+/0C88haWL1RBhJRHtVBwPh+gL2M6mXviKHNp1KZ
 9rkl3G0UVLFCPRB+c6fV1Gqx2FkC9ko304igzY8Or1hCSIA+UTYPpYXaFo5mF0xcsEvl
 E60pENAd09zgt6jJEmP+9nl6QEnqF4e4pwtiWJ9BuyfZAKtlAm1D6vX7v769842qwKIt
 d2rQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXJpuQ563axOES2lRyJGOBluclKUIrSv5kIA7xTIhXmPmmvhXWJEnJ+1QgAql4JvOyetrUhy0Y0Ms=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mF8F9VTnuuuA3gyWA1KNLbjapk5BoaVO5y5khJfZ/ZQtbIrYfJ
 j7w4esA1S4JSJ/BIhYI1Z/MNY+azGU+xJBDZpNTXpyVnKnst1b/Inh5L1615Vjfn82N8Gwv2Zr3
 en0UodtMFJqjgfUqq68IdZT5V46r04hDkpQpC6b+EMMryUOrUZUczCqL8pGhmerxZRVlT5zs=
X-Gm-Gg: AR+sD12Wupfc5me7JkFTAmveP7d1ha5V1UhhEPGa9qd/5xHin/fpOnWugPUkhZGBRRf
 h3kpYmt5gi0zYwdOEmuFsZR4uBz3uWAjs8+5Ynu2DrILxhpK5+u/9VpZfmRGO/TlhAvdB47bHlQ
 gnRTQLsmzgOBcd1sw6H2H2kOI8+2LsC8/V+tavdiT/iIa+HYAyg1IUG7UBuohjZnt8QJBQavFqV
 kIRHDN/UpNxgGyEHm2K7T5mCIebSriBxHEpj0fJ2QZEl2Lk8y2Ks4FiKadFahi7+dU17r3G528z
 7rGyJAenmbwNzZLN0cNUfn4Ys9crwP9BOmKfji9K8NfE/VXMMUQtgKZ7HloaFL1SRN/brKMtp/x
 IFBIi+z8uo1gXMVWklpJYoXBErD/WKo76B4sbSB/l/zxPHq2PZY3O8O/nhjM4YVQ=
X-Received: by 2002:a05:620a:2b48:b0:936:ce17:dac3 with SMTP id
 af79cd13be357-939139aef87mr2862035485a.40.1788164403924; 
 Mon, 31 Aug 2026 01:20:03 -0700 (PDT)
X-Received: by 2002:a05:620a:2b48:b0:936:ce17:dac3 with SMTP id
 af79cd13be357-939139aef87mr2862030485a.40.1788164403453; 
 Mon, 31 Aug 2026 01:20:03 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917236b86sm735974285a.13.2026.08.31.01.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:20:03 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:17:44 +0800
Subject: [PATCH v6 27/29] drm/msm/dp: enable MST on capable sinks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-msm-dp-mst-v6-27-c91d35d6fb9e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788164246; l=6893;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=mcUALd6iaRGlrPJ5zk1Qq/kc9K8hnA46zdrjtFBolVA=;
 b=iH4w4T7aWISCno+nXOlT4cFopuM323XTtUezd1kX0b9gpLZLGstz3sFM85Ugw9lx2wEWOsCYs
 6MxN7IGAVLDBCCpyECzyy1SW/XLRO2bRiLh82qMuwL/1LZKwT0wik5+
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX+/w+eJiq5EEL
 nVug1ZeDBDNgYcoJi3gIheHetHub0vL97Iqel1IQgyJ2hoCjWYzIHCpb2+dfzPnk6N9NBEFop6r
 ylAuvbu+jwbyIYk+x6rR9Wnz9o/Np3g=
X-Proofpoint-ORIG-GUID: Q31S_tD4KMXC-5-zwfbw6TAKSB1YGhBE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfXxPSQEqw3az//
 ZAq7CMn7TTgiALk4g7S2v/QC/OKikxwK+7NfL7BVpMzCFuR0juaFHcm67VBWmwXu0/ZGRl/bf2C
 X4cFm7xYyzqAL+xJopE6IURY4b9bZrlOkIO+ZBd6nLx3A0/7snCp+c13xK3vEDkXWQEdJwgG+Br
 py31OsLkcVssAhFFh/DGC8haBWItKpn2C3Bmc51y00ej7A3/pveyoza1PK/jIbij+6aFp4+6hV/
 G6RY5EbosdmGbIgyh+w+qmudDtvtNuCWVsyKz5yZg54hTFs+I0BsHks7M2h2Dq/3+3xKu6jXk4H
 VPN/E81cZB2tW712nvtWBSmbhTQGzRHzUsowleX9vDtIE1M0a5TBB/uUzxo9MhNC8x5iYmjSrmJ
 z+XalH0wJJGZjnXmv3cPSkO2r53XKABedD6KDiLuBVjMtkBFoVmhxptkYKvcQOu4cNjdAOQO21M
 XyijuT9epFY+8+YqzdA==
X-Authority-Analysis: v=2.4 cv=Iqsutr/g c=1 sm=1 tr=0 ts=6a953934 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=7j1SYuFnmNb8ZMggdUIA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Q31S_tD4KMXC-5-zwfbw6TAKSB1YGhBE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

MST topology discovery requires the sink to operate in MST mode.
Enable MST on sinks that advertise MST capability and are connected
to a multi-stream capable DP controller.

Once MST is enabled, downstream sink discovery and EDID retrieval are
handled through the MST topology rather than the primary DP connector.
Activate the MST topology manager on connect and disable it on
disconnect to track the sink topology lifecycle.

Snapshot the negotiated link parameters when MST is enabled so
subsequent MST payload allocation can derive bandwidth information
from a stable link configuration.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 59 ++++++++++++++++++++++++++++++++-----
 drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
 drivers/gpu/drm/msm/dp/dp_mst_drm.c | 18 +++++++++++
 drivers/gpu/drm/msm/dp/dp_mst_drm.h |  1 +
 4 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index f350c1d03b06..dbc0e82d333a 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -14,6 +14,7 @@
 #include <linux/string_choices.h>
 #include <drm/display/drm_dp_aux_bus.h>
 #include <drm/display/drm_hdmi_audio_helper.h>
+#include <drm/display/drm_dp_mst_helper.h>
 #include <drm/drm_edid.h>
 
 #include "msm_drv.h"
@@ -269,6 +270,29 @@ static int msm_dp_display_lttpr_init(struct msm_dp_display_private *dp, u8 *dpcd
 	return lttpr_count;
 }
 
+static void msm_dp_display_mst_enable(struct msm_dp_display_private *dp)
+{
+	struct msm_dp *msm_dp = &dp->msm_dp_display;
+	int ret;
+
+	/* Clear any pre-existing MST state before enabling MST. */
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
+	msm_dp_mst_display_set_mgr_state(msm_dp, true);
+}
+
 static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 {
 	struct drm_connector *connector = dp->msm_dp_display.connector;
@@ -287,14 +311,17 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	if (rc)
 		goto end;
 
-	drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
-	drm_edid_connector_update(connector, drm_edid);
+	if (msm_dp_ctrl_get_stream_cnt(dp->ctrl) <= 1 ||
+	    !drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd)) {
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
 	}
 
 	msm_dp_link_process_request(dp->link);
@@ -316,6 +343,10 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	 */
 	msm_dp_link_psm_config(dp->link, &dp->panel->link_info, false);
 
+	if (msm_dp_ctrl_get_stream_cnt(dp->ctrl) > 1 &&
+	    drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd))
+		msm_dp_display_mst_enable(dp);
+
 	msm_dp_link_reset_phy_params_vx_px(dp->link);
 
 end:
@@ -490,6 +521,11 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 						 dp->panel->dpcd,
 						 dp->panel->downstream_ports);
 
+	if (dp->msm_dp_display.mst_active) {
+		msm_dp_mst_display_set_mgr_state(&dp->msm_dp_display, false);
+		dp->msm_dp_display.mst_active = false;
+	}
+
 	/* signal the disconnect event early to ensure proper teardown */
 	msm_dp_display_handle_plugged_change(&dp->msm_dp_display, false);
 
@@ -566,6 +602,15 @@ struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
 	return dp_panel;
 }
 
+void msm_dp_display_get_link_info(struct msm_dp *msm_dp_display,
+				  struct msm_dp_link_info *link_info)
+{
+	struct msm_dp_display_private *dp =
+		container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	memcpy(link_info, &dp->panel->link_info, sizeof(*link_info));
+}
+
 static void msm_dp_display_deinit_sub_modules(struct msm_dp_display_private *dp)
 {
 	msm_dp_audio_put(dp->audio);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index ca2faf478c95..96b53d5b6090 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -65,4 +65,6 @@ int msm_dp_get_mst_max_stream(struct msm_dp *msm_dp_display);
 int msm_dp_mst_register(struct msm_dp *msm_dp_display);
 struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
 					      enum msm_dp_stream_id stream_id);
+void msm_dp_display_get_link_info(struct msm_dp *msm_dp_display,
+				  struct msm_dp_link_info *link_info);
 #endif /* _DP_DISPLAY_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
index 2e625a7db981..b2905c894ce5 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -328,6 +328,24 @@ int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, unsigned int stream_id,
 	return 0;
 }
 
+int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
+{
+	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
+	int rc;
+
+	rc = drm_dp_mst_topology_mgr_set_mst(&mst->mst_mgr, state);
+	if (rc < 0) {
+		drm_err(dp_display->drm_dev,
+			"[MST] failed to set topology mgr state to %d rc:%d\n", state, rc);
+	}
+
+	if (state)
+		msm_dp_display_get_link_info(dp_display, &mst->link_info);
+
+	drm_dbg_kms(dp_display->drm_dev, "[MST] set_mgr_state state:%d\n", state);
+	return rc;
+}
+
 void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display)
 {
 	int rc;
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
index 8546214cbca1..4a5707dd50a9 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
@@ -10,6 +10,7 @@
 int msm_dp_mst_mgr_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux);
 int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, unsigned int stream_id,
 			      struct drm_encoder *encoder);
+int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state);
 void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display);
 
 #endif /* _DP_MST_DRM_H_ */

-- 
2.43.0

