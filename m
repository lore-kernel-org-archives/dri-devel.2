Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD5F606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EfweNC6o;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SiBeXK1/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46DDC11216B;
	Thu, 19 Nov 2026 08:26:50 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9087F112164
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:34 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6vZAb330777
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n34FtriDPHYhRtxzNpwH6VAgPvi6RZa1jFcD39Mu3wA=; b=EfweNC6oJZAaaHpz
 0VCmHLel0dY2fa5kB7bjUKnnz8WAd1qMaxGoFM83BdKHxjnx+BGfDKNts/oI0Pvh
 lfcoapfHf+71cPdDCSo7MKO5ugJadRN4zXdlW5ZmUiXQej3r3d4Nch5SslOHkNo2
 91qyCHpGyMz/n+ELzSmQE+UwHiXV/ad9AOmYlQkDPKvxuOLCL8tk6TdLocimzrH7
 9+dK7HnHpDNu7DNyGlxUgadQWkkaOSauMfwvFGecYh9cqIkF0zksgyhiZ6Hw/zaQ
 +xFd1g1/tykEFQuKFC/V4VjZt9AjKWzLQuOxC2O0ynpwwyVm1dSW5pk6KdNbfhFc
 REc47Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1fpnkgm7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f26dd2165so525212185a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076793; x=1795681593;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n34FtriDPHYhRtxzNpwH6VAgPvi6RZa1jFcD39Mu3wA=;
 b=SiBeXK1/8/bl9HXJQk3xDVkFzMo/pynWvaWG4pQPW+6xHG0IPjJ+Yr0xpnwW4xIfIh
 ObXxPv6YYdzU0CeI5V+/eyuLa9Z8LdTPw32XF0JwFBcIMDzhEpMsHh4Iu4ZDpH5zuvcR
 mmnPuZL5JuAxWmVxxlmXRkIJVM2MMAfs2UB4GUdnKJBTS7Ns3SOBCLmaTZ6MIgmE6rRR
 6wAFGvmvc5hXxRomSDCqVv4dGd1OYmSJJsfAmhiQE9Td9fqe8zu5t0ZiopTOdhJCk7NS
 dirbDR+oeckzG8QAWf8N51wDvLaQ77en+KNB2hYWzrHluIimz7QQjOVMCIv+JlJM1v39
 /lrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076793; x=1795681593;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n34FtriDPHYhRtxzNpwH6VAgPvi6RZa1jFcD39Mu3wA=;
 b=UgYe3VVzxtWuPBXuvJBknAftLl5A82CbfY1ka6FvznFkw6f87OJZ/bUA0PjG/fyq8c
 ovcP0uadUKE2QB2aRGEq6GfqDlBjJMWAUKcQpzKFbds8rYnyB98XzSpJSP6QXoKJY4qm
 CiyKTdU/tNC0k4Hk4MmPQ0dfViA7YhDJbxGVAzQqq9E3bBDKTZS55YG3d9D/HdGdsOJK
 DnbxeFzJuBP8XWc7FbsyS1g5BUbkd1zYr5zF7xWqL+1ZngEOUwBnVOzVPUVXPZ0dgaB5
 2krwGu3ywln0ik+0htKSUM65D3d3mu3Nn8PR+9GBithL6gddRnwRKwNyeQJ0vuV4G5XI
 7aFQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHxFN7Etv9tKhyXyefBf2qkpn4uNUw6cjXjR2Fsa8pnTpCgZNUtEDOACZ1oELLVWEhpIuL3DQToBfs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z++98ETYV8v8hHFrG4rWot1LOW0KZubdxRl6THl7BIKXcoCwZzP
 Z+Ld8J4tAUNaWSQKpCdVbUM8yX54KXnHtqsNcsKdamhAwAWKWHQVaLn1gx/4+b8VuMvqFZBOSap
 K+qOHSl1uYY+xhfaUM8aRrQIovBd4eclFn6iHi3t4GWVM95r/YbmzuswGIiYSsehtvHogF0A=
X-Gm-Gg: AYBFou1GJaG5+ZmuS2P0Xsa+0ejBo5hR+4cZkhtdkeehouY1TZjdtMA3/5bv98JeYVa
 twZ7iLG4BzHAeR5T74Gct3RBNvV/4OCqVnNd+8TOnpQ0KOQOjWpU+goLLYNhPTNbFJKVAYyVCQy
 rUjFrIwK+I69Z9lb+QvNkVXx2BpOD/GPe4CPKin/e6yA5tOFFXOCn8rLQv7RjIMCeagI7ZDsUQ8
 Iy+GN0MRbMo3quwP8fcpzRemM6bb/67KSjkIID7HLZDH335ZCGxel06tXj5raxaXMGlXZZt+nUw
 waOLhRp6Uw0uHjcCmrFdHJiGBls/01DVjnfB8SY5dTMBgoGJuUwnzhFyqjabfA7zI9lXyiizCLh
 etUCiz9uFIKDpS40BnC51FMN6BKZxjdiEXxeqZrq6uOOHcyXXFjdD7pWDnrTKn0wV8x2yhJzQKe
 MvBgUfZBuQ53F+VBrq3TUe3eSjgbZm3YTe6bES
X-Received: by 2002:a05:620a:8386:b0:949:733e:dde5 with SMTP id
 af79cd13be357-9499962325emr939524985a.66.1795076792909; 
 Thu, 19 Nov 2026 00:26:32 -0800 (PST)
X-Received: by 2002:a05:620a:8386:b0:949:733e:dde5 with SMTP id
 af79cd13be357-9499962325emr939521785a.66.1795076792363; 
 Thu, 19 Nov 2026 00:26:32 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:26:32 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:26 +0800
Subject: [PATCH v9 24/29] drm/msm/dp: enable MST on capable sinks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-24-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
In-Reply-To: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=5632;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=UT83fDXKlWwm08ocOdb7kKRx0cJWpAsCm5S/klxYgoY=;
 b=NSehnPPBju7XZ1sx/gMv8QWcAwSI9xaBAhcvHRHDG82cIRQdRNgsCp7u3a5ZcJiJHTsjpmAW2
 HB5xIqw53JXA1VaY0/kbMV2B5ooSV5yIjmVIPDYb9WN3bPsS73x2/SA
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: 9dDcqZ9d8gFRGOijcKJpzMIj_S_pQxNS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfXxl8tSmOuRj2t
 dW1F9t+P1bUbLQmExFGgsfSfOS9iFGX+QxJ2vhFiqHqmE2UiSmsSZ5hAictYkKjtqJA1t+rq4vT
 Ia2NGs+HjwQJoQlqdwfYNwf3O3XOtAsaZ+CCeUkzToewoZTrUtY6jTgPIIAbFmQRXPiAgxn7dtF
 WKqWHBlKex/XjkNVpwlFBzxeBJWjLAz5sopT7U6Dcm0/w7pj4DdNqAyJc6NcUyvJhsb/i7CMws+
 cjieVSu91rrcaxRfCArOfIJJj+BiUBknmQDcJRTfjsBvnfrsSxWVO2TSqGMJLcjpAbJ/nO6P8Au
 eces9vUnq0x8ov8SAAWGXXADR/xIuw0e+xOkqEYlz3/bY5iAF3puftL2oO7fsvBuh1ZoPJHl1kg
 Jkcj7VezWy8M0OUI8fF0sY/mx7raGjRciJjrxnMQ5OoQ4l1HPoYFdnZ9o21CbFETP86bZh8Ze29
 OLdCEC3QOVQzZdipZjg==
X-Proofpoint-ORIG-GUID: 9dDcqZ9d8gFRGOijcKJpzMIj_S_pQxNS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfXyGSAvb/QdQmJ
 LzkWsGOd9AjX7LIU1J9nmc8iqcNCF3QiGfsRhQHeyo7CyFUrA4y8WTuinOKA6LKxJ2EPgbNrQC8
 sPJALosMtTmtHAnjL2ZI6CuZQa4kryA=
X-Authority-Analysis: v=2.4 cv=PJ6aavqC c=1 sm=1 tr=0 ts=6afeb2b9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=-w6CXN-5EBmt9i3D_LUA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190033
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 17487a7900d0..7f5247cbae03 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -14,6 +14,7 @@
 #include <linux/string_choices.h>
 #include <drm/display/drm_dp_aux_bus.h>
 #include <drm/display/drm_hdmi_audio_helper.h>
+#include <drm/display/drm_dp_mst_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_panel.h>
 
@@ -270,10 +271,34 @@ static int msm_dp_display_lttpr_init(struct msm_dp_display_private *dp, u8 *dpcd
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
@@ -288,14 +313,19 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	if (rc)
 		goto end;
 
-	drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
-	drm_edid_connector_update(connector, drm_edid);
+	if (msm_dp_ctrl_get_stream_cnt(dp->ctrl) > 1)
+		mst_mode = drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd);
 
-	if (!drm_edid) {
-		DRM_ERROR("panel edid read failed\n");
-		/* check edid read fail is due to unplug */
-		if (!msm_dp_aux_is_link_connected(dp->aux))
-			return -ETIMEDOUT;
+	if (mst_mode != DRM_DP_MST) {
+		drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
+		drm_edid_connector_update(connector, drm_edid);
+
+		if (!drm_edid) {
+			DRM_ERROR("panel edid read failed\n");
+			/* check edid read fail is due to unplug */
+			if (!msm_dp_aux_is_link_connected(dp->aux))
+				return -ETIMEDOUT;
+		}
 	}
 
 	msm_dp_link_process_request(dp->link);
@@ -317,6 +347,9 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	 */
 	msm_dp_link_psm_config(dp->link, &dp->link->link_caps, false);
 
+	if (mst_mode == DRM_DP_MST)
+		msm_dp_display_mst_enable(dp);
+
 	msm_dp_link_reset_phy_params_vx_px(dp->link);
 
 end:
@@ -502,6 +535,11 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
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
index 15405080107f..2b96e003225d 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -362,6 +362,21 @@ int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, unsigned int stream_id,
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

