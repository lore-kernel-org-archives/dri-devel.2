Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F578CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FC5910ECC2;
	Tue, 29 Sep 2026 04:28:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MbaXQNuK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZNbdyzzb";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36F3A10ECC1
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:50 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T479il3643011
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +ENKG4ciOBR4DhpOu/7pksSLF2ffxLUwnpK+XxHaCBA=; b=MbaXQNuKniADOB6I
 wvOXDw71XgLGu1eIVnAjx2cIibO+IzpwAsTmNpzoZ3QE3hl8AAA/3NVGmoPGy4Iu
 IdgDySYNyMVYKsVoIsO3XGiTNTtPeEjz4cAju82qmRX3o6bJ+MHq38+rYbMsFskm
 w3rG+dW1eN1DURSHH8RWaY+OUsHjKaikQd8Skrptzc/NhA+vq2HNSU6DzOXvsGlk
 D6Jk3Z7o/GwMqaCTRKw7VCuS7RN2GgTb2Pt5qelVvAY12K3OokYi+1KlgvatrJes
 eUjRiE9Xgs+uedZ51xCuyt5OVypCgvc/EVsGf5Vp4SnLDbaRe4c6hmG3ZEkfRcWZ
 6PoZew==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h00s4s4hn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:49 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5333a1b634bso47306981cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656129; x=1791260929;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+ENKG4ciOBR4DhpOu/7pksSLF2ffxLUwnpK+XxHaCBA=;
 b=ZNbdyzzbcajWkgq7oCaZT8JnsS37WUda3xkvAstxZFwfoh1dDbICQtbBkRPMkHEeVF
 TQ449rh6T1m8GiLdyYijoxNWcd4ZZu2+WrUu/fFrod3FNFMXmQCNIp5Qzr7QzkUPS14B
 aTHEl0YcBebWx8O/B/PaAxvd/F7M4MvTQE9IZmpuwGRqKIWcdoV9cPnODRMtbMRlnmDr
 4FERDuverHK/yLmr6fs3zWkSRoOCZUEPbHg1Fh4CTTkOA+ZGvbD4OSuczRA6PBXdgaNI
 gmo9hA5kvtpmO635asSC28bwqh+3zqcIPl43iBX0xn2GbL5T2RWE2OU3JqG0wLS4g/nZ
 zL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656129; x=1791260929;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+ENKG4ciOBR4DhpOu/7pksSLF2ffxLUwnpK+XxHaCBA=;
 b=2rxuv+hBQk/zWHAzFQLDRRWj8Gt7mz+kZ0kvL4uKQ+o1yfqpkPvuwEUf+rqbTRUDmc
 jkIzYJC/yWpKh13SJB4vKYLj9eJEJF4Ohv7Gzrq9x4sOZ4fdm4usD8QeWXyIeKKUo9s8
 HXcbOSsXN7ngRk8lXcdSsFJrWiNsCdcTAAUUS+yVCriJlDXzmK2IiH341mcABCV1vKEf
 UMOHD19bxng13/+fEWlzhl3gTsa8XpQYzLD/uKCmYbLCkya7vXpwHIvE/78yfZWyjQPH
 0dmUU0Ua1uf/ZYm6yIIYbniQrniDMUPkEbG7gmgGHE9n23yew+Aco6aexHupEiIuCchf
 arww==
X-Forwarded-Encrypted: i=1;
 AKwUvBwX8sdzXnVxsoFH+jHQKfJzr40ijK8G0UnA0oHDK5MTTyjJj9V3T0mhJOX+CLsB0qIb8hVMgzHKsoM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIC/sGMzzeZS7he1nIU1J/v2vyisrkrOowgbg3X6u50uYzkls7Z
 CtBqvIY2aVwk9xJSO88tHfPPRAtgIX0Y4S4kfrCYRYD/CovJOGNtYKjAf4FhzI1cmWddNU22uay
 h+D2Kh3sUiWHogfm0WMZi/DoyqhrBB0uREA3rqVWrsUvs++Iwx9EyrSzhTFSGWVH+l17LvDM=
X-Gm-Gg: AYBFou3JUpI2f/jf55bBz8wbNUObFx0F2tZBSsHLMQVvU3NtBhiTFaNy2gB8Xwgxgt5
 NaqZG21n2oifS6yMyq9WU3TY7aMDqFNTWiFLGPsZ77pZuq5mWSkLKyx7K5o3BJCgCgWWU/pey+P
 oIqNCn15DLg2cBPwVFX+kZac3ZkWCy2BkuZtW/mWlLxRv0gASO9EDBJNb4Rqa4qavnmEDYKRNmq
 ogZjt4hOONpfPx11/SSEPqXnvLbF9eS91geQdZevF/P9qL7R4dXmsobwwU7OShaRkxo+QUO0eGI
 bKRwjNIALh38+MSTeoNp0xIIOS+JfUngcYk/1WD747cun3xcuy/r6ChmOnB7CKPV+nuMr9VVwui
 Nb2hvQ5NHOeyLD79E321S3U5blN/9kXvv9Mh8k3z2ZHWgpL2VDH82pHTGvLLG/8w=
X-Received: by 2002:a05:6214:aca:b0:914:53ca:99e0 with SMTP id
 6a1803df08f44-91453ca9a0emr151400946d6.11.1790656128577; 
 Mon, 28 Sep 2026 21:28:48 -0700 (PDT)
X-Received: by 2002:a05:6214:aca:b0:914:53ca:99e0 with SMTP id
 6a1803df08f44-91453ca9a0emr151400746d6.11.1790656128067; 
 Mon, 28 Sep 2026 21:28:48 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:28:47 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:54 +0800
Subject: [PATCH v7 30/35] drm/msm/dp: enable MST on capable sinks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-30-4b81473185e7@oss.qualcomm.com>
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
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=5626;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=muilqxsIon54At01bJOHUzArib8qjlI/9ldYi+c8yck=;
 b=uBsFGayk7ULb5FBxF1nJhbNrgsid+4gzwtzpx4+ROUpDq6R3a7Y/oZA0xnGtIhhq9zXNu1Wf1
 SDKjnlhaXZ3A1xlUdjHeY3hjk4KazDa+vGOtMH46tDUi58/CZb9qc64
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfXzNQE6P9PjTuG
 EPWWAf2lSSucJi2aW0CQpxwsZ+T4lAerNFTRHkpulq7xbVLegtyIm/sTU5zZQFFMzBKEdVC6Sq0
 0WaaWk0PrOQxf/jmXGSTENPIYpvTbt4=
X-Authority-Analysis: v=2.4 cv=ALbfqNVA c=1 sm=1 tr=0 ts=6abb3e81 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=-w6CXN-5EBmt9i3D_LUA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX70MOsCW2PzyH
 n9hUISMLwvIypMMFI+EDHP7wr8qMvf/cy34opgGaf+nAyskPO+KQAjGMNPgkCKy/nptMA3FqswQ
 8oi9esXQ0MlWVgcsYvgO9hXysXJAiC2WpgSoRf9vFzM/xWzF1hu/Cmp4Ii1VAUxcaZk2CqhtEjD
 nZgmpJe3g/sBdI2VUGlak+0MTfuaT7bV2EZvOVqW8RDQilSZBGEo5IAaEMI2Q5kcon2Vp1pwTLZ
 KCoTZJBwRG7WO39LL5NtXJwXdICeC4VFsxb618Al1/DtCyWZe2oFtLU6e2UQfNAwaz5Gz0aH7Sy
 yYwMLRjEXX0RyJSx1Lo3UjClmouSEL3wPXXAO+M3jTDTVKPYT2lzRPtsJPIRqH8TJ8+KOo5yHlP
 Ue6J3Zo33+mREc3iRnFNyQESfnpMVBeKqBbnGdOB3sDvlhZe9GKaPjNJlU6Cei9W21n0GypknNt
 eo6gmuFNitMLz15bouA==
X-Proofpoint-GUID: xUyrvlj4U6XH7KwprJNrxvZqlwErb6ij
X-Proofpoint-ORIG-GUID: xUyrvlj4U6XH7KwprJNrxvZqlwErb6ij
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

MST topology discovery requires the sink to operate in MST mode.
Enable MST on sinks that advertise MST capability and are connected
to a multi-stream capable DP controller.

Once MST is enabled, downstream sink discovery and EDID retrieval are
handled through the MST topology rather than the primary DP connector.
Activate the MST topology manager on connect and disable it on
disconnect to track the sink topology lifecycle.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 52 ++++++++++++++++++++++++++++++++-----
 drivers/gpu/drm/msm/dp/dp_mst_drm.c | 15 +++++++++++
 drivers/gpu/drm/msm/dp/dp_mst_drm.h |  1 +
 3 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 21dadc2e6cdc..e913ed91bbfd 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -14,6 +14,7 @@
 #include <linux/string_choices.h>
 #include <drm/display/drm_dp_aux_bus.h>
 #include <drm/display/drm_hdmi_audio_helper.h>
+#include <drm/display/drm_dp_mst_helper.h>
 #include <drm/drm_edid.h>
 
 #include "msm_drv.h"
@@ -269,10 +270,34 @@ static int msm_dp_display_lttpr_init(struct msm_dp_display_private *dp, u8 *dpcd
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
 	const struct drm_display_info *info = &connector->display_info;
+	enum drm_dp_mst_mode mst_mode = DRM_DP_SST;
 	int rc = 0;
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
 	const struct drm_edid *drm_edid = NULL;
@@ -287,14 +312,19 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	if (rc)
 		goto end;
 
-	drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
-	drm_edid_connector_update(connector, drm_edid);
+	if (msm_dp_ctrl_get_stream_cnt(dp->ctrl) > 1)
+		mst_mode = drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd);
+
+	if (mst_mode != DRM_DP_MST) {
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
@@ -316,6 +346,9 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	 */
 	msm_dp_link_psm_config(dp->link, &dp->link->link_caps, false);
 
+	if (mst_mode == DRM_DP_MST)
+		msm_dp_display_mst_enable(dp);
+
 	msm_dp_link_reset_phy_params_vx_px(dp->link);
 
 end:
@@ -499,6 +532,11 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 						 dp->panel->dpcd,
 						 dp->panel->downstream_ports);
 
+	if (dp->msm_dp_display.mst_active) {
+		msm_dp_mst_display_set_mgr_state(&dp->msm_dp_display, false);
+		dp->msm_dp_display.mst_active = false;
+	}
+
 	/* signal the disconnect event early to ensure proper teardown */
 	msm_dp_display_handle_plugged_change(&dp->msm_dp_display, false);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
index 4c0ad3dc5793..35193cf45a6f 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -361,6 +361,21 @@ int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, unsigned int stream_id,
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
+	drm_dbg_kms(dp_display->drm_dev, "[MST] set_mgr_state state:%d\n", state);
+	return rc;
+}
+
 void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display)
 {
 	int rc;
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
index 3bd3e66b4eac..84de7ca0c689 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
@@ -12,6 +12,7 @@ int msm_dp_mst_mgr_init(struct msm_dp *dp_display, struct msm_dp_link *link,
 void msm_dp_mst_mgr_destroy(struct msm_dp *dp_display);
 int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, unsigned int stream_id,
 			      struct drm_encoder *encoder);
+int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state);
 void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display);
 
 #endif /* _DP_MST_DRM_H_ */

-- 
2.43.0

