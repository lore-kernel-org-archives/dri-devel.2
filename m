Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A7AC43638
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD46010E8D4;
	Mon, 29 Jun 2026 13:18:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cM9JEiz7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gP8/9GUA";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C9B10E8CD
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:18:35 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATKi62656125
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MLEmu0SuSJObPGT52LcwIf7D9jxRGU4XmXyxCd29wxY=; b=cM9JEiz7izEnDBbl
 3cmaLmy8AiQ6KxFh/oYOwHRkcUJuSgIWcw40f+GDqHbTqr5L1cHwY6p30nOnhPCm
 AHymRAI0yx975hSedEnMujgeQX3c2zu6W8KHECpX/SOmvVLcBQuEFmhw41TBh5oO
 LUJf8HWGhcEmtZvmS+aQJ/n3T8EHZE4L2mNrfO19OXEvFs/3oMkYRm2xURKht8F5
 loVJBc9Yi8njcC6IM48duxZQF1L9rvj2IbAKRgCBb3rRk6L18xythRGZdNSzgrTm
 sD6Jx4M2yLEBKbU+5QpIdL5FCoI29gklEVrIq0otLZ0Nux6U77ASu95BLzxUf7Xv
 J2WmTA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3np7gyky-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:18:34 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8f08560ea44so14363086d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782739114; x=1783343914;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MLEmu0SuSJObPGT52LcwIf7D9jxRGU4XmXyxCd29wxY=;
 b=gP8/9GUAelHFT4NOX9I6fKtTEo5nhUovcsrK1C4ZVNmN7e8TITTPIEgq0Vbdmofh4p
 s1xiLJNkbOp8HTO+I9P2eS+C+3YTcXpXUHBEEcB5yzkpuQ/32sslFmurytmRKLLc+mLi
 EvgzouYRe+lLX5M4MYOqwrgwgKlTLIQUkC6B4NCIn+KA291FQbXxuvJWe5S2N/Esutqx
 Z/MdkjmjqXg1/RhApQvLBrdZUpW1nsrQovR9XXYryW0JjmgmirgQGmvWAGVaboCxg4k5
 PYlSrSc4WQRxUNywPvrNSw2Q12nE5aBjI5CTxji8grFfbTopN/CccB4/GfBGzkc2pD9y
 OOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782739114; x=1783343914;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MLEmu0SuSJObPGT52LcwIf7D9jxRGU4XmXyxCd29wxY=;
 b=SgGVtRuw2KFe7WhJ4abMC551pj5vaipLx7TILiZuvAvaicNQA+sBCOWa6+pRHhHFia
 gnoz6hCUpbZ4Y9IrfUwXSVg23jVGMxwa/hmKpRsw/T2LTE4pnEMZ42nHnvWOEkmlDzKp
 hwNgFe+bW886RngrZ1OISytjB1Rivc2BHfo1RA1rSo6NpFIEQBw+zrw/SoSFCkCfioJE
 NKbpSHlu6h6SwfhLRG6lkwZP2nF1bZwmkdGYdoMpreKeK7M5j1JglqMawiGfxY2nklLH
 IONsCWXBH0R9Rs7hMPRsxPgOT/ebssLFK+/1nKEEbb3Te2BoVCPWhBiTXjBl5jT8a25/
 4Crg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXz+UCROQkMg3AlHwHJHcQnWFseNyDFB3WZ5fFnmNcFq+cg0mnEGxmzVTENoDYznVXvF1YlQOGF4M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwOoByAAgxMd7QjAYb00o47mBMyx68FBK3H0+01cTiRG9iyqvvI
 xhz6IJ0+QBaD73ul1hNzoJF7ugqowOmKkY+j0sIHD7sO1RNr6EUBj3zp9wBNO3ZHBKUtADyot65
 qIDedY3VV3QLwCeCrKb2US95cuHBoeOtDYMH0cl7taSMAb+oDDpB3MxXEcqG3rlQ/b43Tolo=
X-Gm-Gg: AfdE7clk796czAcaDim61GyBTkBMxUjX/C5lQaAAV8A+W64b0JijBdI/3PvRWWqbm8+
 Bc16Jx1TqJTMZsKdZryJMC7NE7TWRM8brgt94ex8CaHtmkN6t1pxL8AzaGWYEmv3ijb+CKLiQVf
 FwyZE4NEsjCGb7XNmoncmWlRyVMQVNOiOrhjh5u/9Mf1ssEHurH3RlI1BWLIxdGPuCVkjme++fY
 wN0/Ia0LEHSiJFw2IJ6wTEaNQNp203DGzngMX39thSQ/+BFo9BGhzhk4Xk6l2LwaQS3zNXwQf/2
 +9N82UecO/dXuhZJeUFD7ZjvmzRKrt0CQ+AwTyFmbh35R1isMHj0sffdsWAT7NcRoWR89itRDud
 K4ZmX94PyNrQeJkr7b6zw3q7SFjafvlpt6tKG1Jtg6iOUpqW/wRjP5hIr+7GlRqGEX5Ex6b0WKA
 ==
X-Received: by 2002:a05:6214:5095:b0:8eb:24e8:8d28 with SMTP id
 6a1803df08f44-8eb24e88fb7mr124546936d6.46.1782739110475; 
 Mon, 29 Jun 2026 06:18:30 -0700 (PDT)
X-Received: by 2002:a05:6214:5095:b0:8eb:24e8:8d28 with SMTP id
 6a1803df08f44-8eb24e88fb7mr124546216d6.46.1782739109973; 
 Mon, 29 Jun 2026 06:18:29 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ef0f2b9df0sm56744616d6.13.2026.06.29.06.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:18:29 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 21:16:42 +0800
Subject: [PATCH v5 24/25] drm/msm/dp: add connector abstraction for DP MST
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-msm-dp-mst-v5-24-1d882d9012f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782738985; l=9169;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=YsuaK/0OYI79/l+b6bHLlwEgQ38BKEFF+/BvXN79st4=;
 b=dpsT3F7m4xWYxbXhi4HoV+G45lZK1FZygEXqP8Mzq0qZQsAO6XgUXP4VRiwayWl7co9eAm8ri
 vvzI3QF9IAFDpSolJqOZnw2V2JnYztqxfW+FprW2/hjSKrlru8gj4fA
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX6MvQwAMB463s
 CgKvVBfE2fvrOeCb/To+0IGDae1+DdEyvHN0v2Fiikl02l8tbYL4df+WAVPRDwrQB3WKw1bI90b
 rv0AqcO++pN8J1X84DD6duKaQYk27EaYIMLlh5UbFnfRklcCC5duGPlK5PwRVgXm4YVTvCfQKl9
 iVROvDBN2lp3HqCyZ/oL1v9CxXEqUq6ngyLltCDaP9imTHgEqM6OYVzmSCuY7lHcT2pCfC4k9Bp
 b/qgs6QWYlv4CVyb3RzPH93uBRI9nJUs4x12nZNhc6lSiQYc22E9eSWsNuoDj77yhHOT/gobe2J
 T2n08RY1Ls+u37w2LXaBf63bmFM3BJCJvTRe1k+7C75hhBSRZX/vCPRCXM+4Vah9OdOYi+vRkB3
 2uu6QcPTvSL3w+QUj1QmJK/D164RqiSZJJQ3FvM2QRIiMuOlF8JrCbJcPhLBMpYdcnNM7I2UFsS
 Zr15rnyAeGY9PjfemzQ==
X-Proofpoint-GUID: n1GjRGph1pIcyGBwWPpZWmtXE5opbAnZ
X-Proofpoint-ORIG-GUID: n1GjRGph1pIcyGBwWPpZWmtXE5opbAnZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX1svPJj9HA42j
 VPs617CFsJrcpLh+216PC7igkYPkIeUQrAx5iTxTFdqV8MeTfzWU9LmUuIC6udzYAc1EFzcT5Gr
 hAmxumJ6N9lk6Wn48JyzRmiqPlSrDH8=
X-Authority-Analysis: v=2.4 cv=OcWoyBTY c=1 sm=1 tr=0 ts=6a4270aa cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=mVHCav_IkjWnAo0-rBcA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
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

Introduce an MST connector abstraction for DP MST, with each MST
connector associated with a DP panel and connected through a DRM bridge
to an MST encoder.

The connector is only used for MST helper callbacks, such as detect,
get_modes, and get_encoder. Display enable/disable, hotplug handling,
and modeset sequencing continue to be handled by the bridge path.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_mst_drm.c | 232 ++++++++++++++++++++++++++++++++++++
 1 file changed, 232 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
index 6a77fdef85e9..12b47a413793 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -7,6 +7,7 @@
 #include <drm/drm_fixed.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/display/drm_dp_mst_helper.h>
+#include <linux/pm_runtime.h>
 
 #include "dp_mst_drm.h"
 #include "dp_panel.h"
@@ -50,6 +51,18 @@ static struct msm_dp_panel *msm_dp_mst_panel_from_encoder(struct msm_dp_mst *mst
 	return NULL;
 }
 
+static int msm_dp_mst_encoder_stream_id(struct msm_dp_mst *mst,
+					struct drm_encoder *enc)
+{
+	int i;
+
+	for (i = 0; i < mst->max_streams; i++) {
+		if (mst->mst_encoders[i].enc == enc)
+			return mst->mst_encoders[i].stream_id;
+	}
+	return -1;
+}
+
 static void msm_dp_mst_update_timeslots(struct msm_dp_mst *mst,
 					struct msm_dp_panel *panel,
 					struct drm_dp_mst_atomic_payload *payload)
@@ -275,6 +288,224 @@ int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
 	return rc;
 }
 
+/* DP MST Connector OPs */
+static int
+msm_dp_mst_connector_detect(struct drm_connector *connector,
+			    struct drm_modeset_acquire_ctx *ctx,
+			    bool force)
+{
+	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
+	struct msm_dp_mst *mst = mst_conn->dp_mst;
+	struct msm_dp *dp_display = mst->msm_dp;
+	struct device *dev = dp_display->drm_dev->dev;
+	enum drm_connector_status status = connector_status_disconnected;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return status;
+
+	if (dp_display->mst_active)
+		status = drm_dp_mst_detect_port(connector,
+						ctx, &mst->mst_mgr, mst_conn->mst_port);
+
+	pm_runtime_put_autosuspend(dev);
+
+	return status;
+}
+
+static int msm_dp_mst_connector_get_modes(struct drm_connector *connector)
+{
+	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
+	struct msm_dp_mst *mst = mst_conn->dp_mst;
+	const struct drm_edid *drm_edid;
+	int rc;
+
+	drm_edid = drm_dp_mst_edid_read(connector, &mst->mst_mgr, mst_conn->mst_port);
+	drm_edid_connector_update(connector, drm_edid);
+
+	rc = drm_edid_connector_add_modes(connector);
+
+	drm_edid_free(drm_edid);
+
+	return rc;
+}
+
+static enum drm_mode_status msm_dp_mst_connector_mode_valid(struct drm_connector *connector,
+							    const struct drm_display_mode *mode)
+{
+	struct msm_dp_mst_connector *mst_conn;
+	struct drm_dp_mst_port *mst_port;
+	struct msm_dp *dp_display;
+	int required_pbn;
+
+	if (drm_connector_is_unregistered(connector))
+		return 0;
+
+	mst_conn = to_dp_mst_connector(connector);
+	mst_port = mst_conn->mst_port;
+	dp_display = mst_conn->dp_mst->msm_dp;
+
+	/* FIXME: use negotiated bpp (DSC, YUV 4:2:0, etc.); for now use
+	 * 18bpp (6bpc) as a conservative lower bound like i915/nouveau.
+	 */
+	required_pbn = drm_dp_calc_pbn_mode(mode->clock, (6 * 3) << 4);
+
+	if (required_pbn > mst_port->full_pbn) {
+		drm_dbg_dp(dp_display->drm_dev, "mode:%s not supported.\n", mode->name);
+		return MODE_CLOCK_HIGH;
+	}
+
+	return msm_dp_display_mode_valid(dp_display, &connector->display_info, mode);
+}
+
+static const struct drm_connector_funcs msm_dp_drm_mst_connector_funcs;
+
+static struct drm_encoder *
+msm_dp_mst_atomic_best_encoder(struct drm_connector *connector, struct drm_atomic_commit *state)
+{
+	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
+	struct msm_dp_mst *mst = mst_conn->dp_mst;
+	struct drm_connector_state *conn_state;
+	struct drm_connector *iter;
+	struct drm_connector_list_iter conn_iter;
+	u32 stream_mask = 0;
+	u32 i;
+
+	conn_state = drm_atomic_get_new_connector_state(state, connector);
+	if (!conn_state)
+		return NULL;
+
+	if (conn_state->best_encoder)
+		return conn_state->best_encoder;
+
+	drm_connector_list_iter_begin(connector->dev, &conn_iter);
+	drm_for_each_connector_iter(iter, &conn_iter) {
+		struct drm_connector_state *peer_state;
+		int stream_id;
+
+		if (iter == connector ||
+		    iter->funcs != &msm_dp_drm_mst_connector_funcs ||
+		    to_dp_mst_connector(iter)->dp_mst != mst)
+			continue;
+
+		peer_state = drm_atomic_get_new_connector_state(state, iter) ?: iter->state;
+		if (!peer_state || !peer_state->crtc || !peer_state->best_encoder)
+			continue;
+
+		stream_id = msm_dp_mst_encoder_stream_id(mst, peer_state->best_encoder);
+		if (stream_id >= 0 && stream_id < mst->max_streams)
+			stream_mask |= BIT(stream_id);
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+	for (i = 0; i < mst->max_streams; i++) {
+		if (!(stream_mask & BIT(i))) {
+			conn_state->best_encoder = mst->mst_encoders[i].enc;
+			return mst->mst_encoders[i].enc;
+		}
+	}
+
+	return NULL;
+}
+
+static int msm_dp_mst_connector_atomic_check(struct drm_connector *connector,
+					     struct drm_atomic_commit *state)
+{
+	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
+	struct msm_dp_mst *mst = mst_conn->dp_mst;
+
+	return drm_dp_atomic_release_time_slots(state, &mst->mst_mgr, mst_conn->mst_port);
+}
+
+static void dp_mst_connector_destroy(struct drm_connector *connector)
+{
+	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
+
+	drm_connector_cleanup(connector);
+	drm_dp_mst_put_port_malloc(mst_conn->mst_port);
+	kfree(mst_conn);
+}
+
+/* DRM MST callbacks */
+static const struct drm_connector_helper_funcs msm_dp_drm_mst_connector_helper_funcs = {
+	.get_modes =    msm_dp_mst_connector_get_modes,
+	.detect_ctx =   msm_dp_mst_connector_detect,
+	.mode_valid =   msm_dp_mst_connector_mode_valid,
+	.atomic_best_encoder = msm_dp_mst_atomic_best_encoder,
+	.atomic_check = msm_dp_mst_connector_atomic_check,
+};
+
+static const struct drm_connector_funcs msm_dp_drm_mst_connector_funcs = {
+	.reset = drm_atomic_helper_connector_reset,
+	.destroy = dp_mst_connector_destroy,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static struct drm_connector *
+msm_dp_mst_add_connector(struct drm_dp_mst_topology_mgr *mgr,
+			 struct drm_dp_mst_port *port, const char *pathprop)
+{
+	struct msm_dp_mst *mst = container_of(mgr, struct msm_dp_mst, mst_mgr);
+	struct drm_device *dev = mst->msm_dp->drm_dev;
+	struct msm_dp_mst_connector *mst_conn;
+	struct drm_connector *connector;
+	int rc, i;
+
+	mst_conn = kzalloc_obj(*mst_conn);
+	if (!mst_conn)
+		return NULL;
+
+	connector = &mst_conn->connector;
+	rc = drm_connector_dynamic_init(dev, connector,
+					&msm_dp_drm_mst_connector_funcs,
+					DRM_MODE_CONNECTOR_DisplayPort, NULL);
+	if (rc)
+		goto err_free;
+
+	mst_conn->dp_mst = mst;
+
+	drm_connector_helper_add(connector, &msm_dp_drm_mst_connector_helper_funcs);
+	connector->funcs->reset(connector);
+
+	/* add all encoders as possible encoders */
+	for (i = 0; i < mst->max_streams; i++) {
+		rc = drm_connector_attach_encoder(connector, mst->mst_encoders[i].enc);
+		if (rc) {
+			drm_err(dev, "[MST] failed to attach encoder:%u to conn:%d rc:%d\n",
+				mst->mst_encoders[i].enc->base.id,
+				connector->base.id, rc);
+			goto err_connector;
+		}
+	}
+
+	mst_conn->mst_port = port;
+	drm_dp_mst_get_port_malloc(port);
+
+	drm_object_attach_property(&connector->base,
+				   dev->mode_config.path_property, 0);
+	drm_object_attach_property(&connector->base,
+				   dev->mode_config.tile_property, 0);
+	drm_connector_set_path_property(connector, pathprop);
+
+	drm_dbg_kms(dev, "[MST] add_connector done conn:%d max_streams:%u\n",
+		    connector->base.id, mst->max_streams);
+
+	return connector;
+
+err_connector:
+	drm_connector_cleanup(connector);
+err_free:
+	kfree(mst_conn);
+	return NULL;
+}
+
+static const struct drm_dp_mst_topology_cbs msm_dp_mst_drm_cbs = {
+	.add_connector = msm_dp_mst_add_connector,
+};
+
 int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux)
 {
 	struct drm_device *dev = dp_display->drm_dev;
@@ -285,6 +516,7 @@ int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_au
 	if (!mst)
 		return -ENOMEM;
 
+	mst->mst_mgr.cbs = &msm_dp_mst_drm_cbs;
 	mst->msm_dp = dp_display;
 	mst->max_streams = max_streams;
 	mst->dp_aux = drm_aux;

-- 
2.43.0

