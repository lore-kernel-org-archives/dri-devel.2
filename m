Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C2EE9905D
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D6A110E92A;
	Fri, 10 Apr 2026 09:36:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y/h0MwBY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iJdX1KNj";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B3D610E92A
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:54 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A8b3Uk115449
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1R6enKwcmUC8y8abux5tSNxu61FuxKm7MbCospVBVrs=; b=Y/h0MwBYYHcNxWrK
 /Qc8tpcSNyeU4eWpYziFc/imAst2mKisIYTcHNrvHw89SYowjGHvpyR3n9eZHzjO
 ZUHX2OyVYNBBQBF2gyy6VcT7+r2FiUMm3wwkKKED23VPQ2clV9rjti0XaOoHsSE9
 Mb33AsBquyWxyGQZKYXVDHzo4OJr505ax+xijy0D2CkIsYNp/t40uYeRAjNmHqDk
 TzxLEcNgjs6wlow8FEKKSVwi9EsKdwzOLt1tv2AG0vREiAIzEKamYX8lQwp1nwWH
 UZR+ISwZoaeVXJfJGzqndyr+bkUnzbHWSl+Vye8BjfeX1aujoNinv0qB4qWoOLNA
 dKtXNw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dee8xb95w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:53 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b4ca7e7c2so36748411cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813813; x=1776418613;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1R6enKwcmUC8y8abux5tSNxu61FuxKm7MbCospVBVrs=;
 b=iJdX1KNjsxHZ5CDq7s1rlJ+TGBMjbAIzMC3o24BqDJ81KvFs0IjoKsyATLX3SBGrxq
 EJ+bcpzdNnzhbAWmkO1gD62faKGvciWQ+OjJKCJp152gKrnD+kaO9vCfcJdsoYxDGTjS
 2ow5ZfsW1SyaNNOVScODDF9gu/liUX/1SR+cJmbknRlgxA02kOATmlgZiqIVpP0eVHFH
 XGljS2mE8tTeKM/xwinuJ5KXt9NllO6+G1gXdDY6Vwaaccy2ZvHXv0gMDuxLOGVNHIRH
 3Q8mT+Bjtt8w8jmOB+HpRZrWOJqnz/ZrxEUqC826vb/ub6+Aa2MWAFOdt90dLvTLc2WI
 kCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813813; x=1776418613;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1R6enKwcmUC8y8abux5tSNxu61FuxKm7MbCospVBVrs=;
 b=FNRrr6ysw6Xeq085Ht1F0CtejvH91PeErdxa/6Guh+D03eFEwrEp7Drw4qrjXPhbNa
 aEzGqxDLUsq8Lvzinu6h5JzyOZwXVaV3o0aht2owP7o9Zeh0qjEaarpRcQYhwMpBL0LQ
 NjgcUdcnglMdjsVI3X3zoCvMFIhyLvk2ZYI8OtnYXxUqs6UCpA/wyeC+mzJ32ytsZ5Dr
 xLXDE1iAZ0eP00GMUGvoY+4vZPnsHnyi1BrCFw5qbf+nCbbCI6Ekes35nCGEe8EBAEu9
 8FclBVcjnKKk7gkRwqZ/ze+zE/HlyQhMxnnNA5N6DzFy47sxc8vhWyLoDq/pVoUBYXqc
 84mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmTgSkNmaA5U0jDgclcaoqfGsZ2rdxfydIAF8fs5BwR9Mbh5hAWvRa2vz37eK810DDILA1aSLxgDY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdoPn6pLicAJ1/JK6zBXQ42htQoJIE64HLM6/NwAvetENsgFSx
 cyCbj7gT88W/XwMDYqAF2voXzn4B/u62JnbyMuCOXZjGvWChFG+0Xcn3jMr9a+Ko/mqMyf6UzpR
 6dinmJ8shnvNiboB2Gk49ELI7b51zBvZw2Y/HP64TsUDe6WBaTE+qN41DXctVgWmEP0NKJRU=
X-Gm-Gg: AeBDieuitZb51pQgs9r0S+GCfOyiyAUo570MwA4/p+KZFjDQykJHY8/O1xmh3ptMuAe
 Zs1t7PLYAPVBK2uWeThjlLEfJwfOuAJ4SeXV2aVGfZq9YqJki+h1PzTwa3wejGgNVfUOJ6CADUU
 eLosggLTtILUNs9nY9fEd/JI2TUIr2eH8thOPTBuFWQg59cjugdS/uzN3tRBtR2dU8gpkflVUFH
 aK1zWUVglv03/M4j8Om6EV33QcIQld/1vohJJA0G7PBCfoc7FdmSza8dJcKevs7RcoYFon7snBB
 OnW1sA79MRttBx7kEFzeWmw237APUvXftgaH0tBz3p6qwxw8wEUaS0D0nddXJICq9azib3hF0zQ
 b7gg6Zie3kV/pluQmvDmazhfaxATjVNv76DGeNypO5xyNlxju94FNluRLH0+mBJDfbp1CZAudwb
 MhDSybQdY=
X-Received: by 2002:ac8:5a88:0:b0:50d:6ab3:1acb with SMTP id
 d75a77b69052e-50dd5c3d98emr35009211cf.41.1775813812782; 
 Fri, 10 Apr 2026 02:36:52 -0700 (PDT)
X-Received: by 2002:ac8:5a88:0:b0:50d:6ab3:1acb with SMTP id
 d75a77b69052e-50dd5c3d98emr35008931cf.41.1775813812264; 
 Fri, 10 Apr 2026 02:36:52 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:36:52 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:34:11 +0800
Subject: [PATCH v4 36/39] drm/msm/dp: add connector abstraction for DP MST
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-36-b20518dea8de@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=8841;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=GA/AMqPL0koimahEeSAV8q/L+lqTP+GhAjTWb43a69s=;
 b=qzFexBGjAGZrbtPmbmXcDvS06ZyD4s4ja3ywxVZ69KNtGkh3bLrxlf13Wsc1tL4aZN5tD19Zu
 2LgiEmDHXmBD5xGpL0oJWdpd+/tjQmVAUzs7fFGzCD2hsFm3mUQ4/E1
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OSBTYWx0ZWRfX49iQvsfkN468
 UPe/VE4uhe7oXw6d9bgly33SoZULC+0rrp8K7mNzvgaaCqNjhjqj9qTBZT9U7nQLdzT0nDU9OUT
 lpb3mHMSHg27UatlCRJJzM11kB9HAuq6TNP3l21fZ8df6S6HVCjcSkB6ELUQRYfmalJ55rRqdtZ
 a7UBBm+W7+P7xtloGvH1WXfuT3bc1KSAFnfChWYYIsXwXn1Ac7yAMh0dQDRDlozjEu09/P+Ingt
 Jul/ugVzQ18ROlQDSIxYKHXs9jbJeKRNvW3laAPEtT9ANK206CvSyxTcpec2FuMsjH5xpCSSng2
 eqOUTafVMy+NnkFXR/EFsb/ddj6OMrL7f+dw0e1muFh408712YCUq/5l2c8WAwae6UH38floBON
 BphUcGTvXInh5y/14VHbkWpXB3MicWTv9vyKOwHnX97VyWXYn1qmxDjpsZPKN30rCjbwrZ3h4Aj
 gY8D56SLf+05ewn6MIA==
X-Proofpoint-GUID: fLD6TYF4TIYJVrow7Hk4_9vHYxoNzm0K
X-Proofpoint-ORIG-GUID: fLD6TYF4TIYJVrow7Hk4_9vHYxoNzm0K
X-Authority-Analysis: v=2.4 cv=O7YJeh9W c=1 sm=1 tr=0 ts=69d8c4b5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=mVHCav_IkjWnAo0-rBcA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
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

Introduce an MST connector abstraction for DP MST, with each MST
connector associated with a DP panel and connected through a DRM bridge
to an MST encoder.

The connector is only used for MST helper callbacks, such as detect,
get_modes, and get_encoder. Display enable/disable, hotplug handling,
and modeset sequencing continue to be handled by the bridge path.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_mst_drm.c | 231 ++++++++++++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
index 4df3ea5e36d0..bb3898b1f6b1 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -7,6 +7,7 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_bridge.h>
 #include <drm/display/drm_dp_mst_helper.h>
+#include <linux/pm_runtime.h>
 
 #include "dp_mst_drm.h"
 #include "dp_panel.h"
@@ -489,6 +490,235 @@ int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
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
+
+	drm_edid = drm_dp_mst_edid_read(connector, &mst->mst_mgr, mst_conn->mst_port);
+	drm_edid_connector_update(connector, drm_edid);
+
+	return drm_edid_connector_add_modes(connector);
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
+	if (!mst_port)
+		return MODE_ERROR;
+
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
+static struct drm_encoder *
+msm_dp_mst_atomic_best_encoder(struct drm_connector *connector, struct drm_atomic_state *state)
+{
+	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
+	struct msm_dp_mst *mst = mst_conn->dp_mst;
+	struct msm_dp *dp_display = mst->msm_dp;
+	struct drm_encoder *enc = NULL;
+	struct msm_dp_mst_bridge_state *mst_bridge_state;
+	u32 i;
+	struct drm_connector_state *conn_state = drm_atomic_get_new_connector_state(state,
+										    connector);
+
+	if (conn_state && conn_state->best_encoder)
+		return conn_state->best_encoder;
+
+	for (i = 0; i < mst->max_streams; i++) {
+		mst_bridge_state = msm_dp_mst_br_priv_state(state, mst->mst_bridge[i]);
+		if (IS_ERR(mst_bridge_state))
+			goto end;
+
+		if (mst_bridge_state->connector == connector) {
+			enc = mst->mst_bridge[i]->encoder;
+			goto end;
+		}
+	}
+
+	for (i = 0; i < mst->max_streams; i++) {
+		mst_bridge_state = msm_dp_mst_br_priv_state(state, mst->mst_bridge[i]);
+
+		if (!mst_bridge_state->connector) {
+			mst_bridge_state->connector = connector;
+			mst_bridge_state->msm_dp_panel = mst_conn->dp_panel;
+			enc = mst->mst_bridge[i]->encoder;
+			break;
+		}
+	}
+
+end:
+	if (enc)
+		drm_dbg_dp(dp_display->drm_dev, "MST connector:%d atomic best encoder:%d\n",
+			   connector->base.id, i);
+	else
+		drm_dbg_dp(dp_display->drm_dev, "MST connector:%d atomic best encoder failed\n",
+			   connector->base.id);
+
+	return enc;
+}
+
+static int msm_dp_mst_connector_atomic_check(struct drm_connector *connector,
+					     struct drm_atomic_state *state)
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
+	struct msm_dp_mst *dp_mst;
+	struct drm_device *dev;
+	struct msm_dp *dp_display;
+	struct msm_dp_mst_connector *mst_conn;
+	struct drm_connector *connector;
+	int rc, i;
+
+	dp_mst = container_of(mgr, struct msm_dp_mst, mst_mgr);
+
+	dp_display = dp_mst->msm_dp;
+	dev = dp_display->drm_dev;
+
+	mst_conn = kzalloc_obj(*mst_conn);
+
+	if (!mst_conn)
+		return NULL;
+
+	drm_modeset_lock_all(dev);
+
+	connector = &mst_conn->connector;
+	rc = drm_connector_dynamic_init(dev, connector,
+					&msm_dp_drm_mst_connector_funcs,
+					DRM_MODE_CONNECTOR_DisplayPort, NULL);
+	if (rc) {
+		kfree(mst_conn);
+		drm_modeset_unlock_all(dev);
+		return NULL;
+	}
+
+	mst_conn->dp_panel = msm_dp_display_get_panel(dp_display);
+	if (!mst_conn->dp_panel) {
+		DRM_ERROR("failed to get dp_panel for connector\n");
+		kfree(mst_conn);
+		drm_modeset_unlock_all(dev);
+		return NULL;
+	}
+
+	mst_conn->dp_panel->connector = connector;
+	mst_conn->dp_mst = dp_mst;
+
+	drm_connector_helper_add(connector, &msm_dp_drm_mst_connector_helper_funcs);
+
+	if (connector->funcs->reset)
+		connector->funcs->reset(connector);
+
+	/* add all encoders as possible encoders */
+	for (i = 0; i < dp_mst->max_streams; i++) {
+		rc = drm_connector_attach_encoder(connector, dp_mst->mst_bridge[i]->encoder);
+
+		if (rc) {
+			DRM_ERROR("failed to attach encoder to connector, %d\n", rc);
+			kfree(mst_conn);
+			drm_modeset_unlock_all(dev);
+			return NULL;
+		}
+	}
+
+	mst_conn->mst_port = port;
+	drm_dp_mst_get_port_malloc(mst_conn->mst_port);
+
+	drm_object_attach_property(&connector->base,
+				   dev->mode_config.path_property, 0);
+	drm_object_attach_property(&connector->base,
+				   dev->mode_config.tile_property, 0);
+	drm_connector_set_path_property(connector, pathprop);
+	drm_modeset_unlock_all(dev);
+
+	drm_dbg_dp(dp_display->drm_dev, "add MST connector id:%d\n", connector->base.id);
+
+	return connector;
+}
+
+static const struct drm_dp_mst_topology_cbs msm_dp_mst_drm_cbs = {
+	.add_connector = msm_dp_mst_add_connector,
+};
+
 int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux)
 {
 	struct drm_device *dev = dp_display->drm_dev;
@@ -501,6 +731,7 @@ int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_au
 		return -ENOMEM;
 
 	memset(&msm_dp_mst->mst_mgr, 0, sizeof(msm_dp_mst->mst_mgr));
+	msm_dp_mst->mst_mgr.cbs = &msm_dp_mst_drm_cbs;
 	conn_base_id = dp_display->connector->base.id;
 	msm_dp_mst->msm_dp = dp_display;
 	msm_dp_mst->max_streams = max_streams;

-- 
2.43.0

