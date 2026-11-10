Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633C860A2613
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E7wosx5r;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RbjWdMiZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E381710EDC7;
	Tue, 10 Nov 2026 04:56:48 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9294A10EDC8
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:32 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4Aj461958917
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pHoKtlWw4MdcYFAmqyM5G73oF+4uGH19uwdrJT6LYX4=; b=E7wosx5rAIy/sM+8
 3qCz8bXrtb6w+UuK1nBMioV2FuH+Ik67j5I27SPtC87BSE7nW/hS3WATJMf6vfh7
 tBxkv7NOpNDU/+O+H4iyS9fGK1oe6e2nmdvyKKKSi8eXhcfb0eudDvDnD4vj4Fi9
 9YVGew1FGUtJphXIi9Ip47CsKsLl/1Y4wchXRR6FYLVzcuvidh3ISwfKs3sLBecG
 xvQwCklWl4FDGO0R7UfZfzOowYsFf0B6jp2SSdHK0gvaGqZEALEamB1PBA1A32FQ
 2fW41nLO4/Cxr8+rRp8+E853n6MBu1QCh0IGqWm/Zs4kHhyceUMEiVqY2YNV8SNl
 2J7z8A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucydknm9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:31 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93e49a1d3b1so402527985a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286591; x=1794891391;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pHoKtlWw4MdcYFAmqyM5G73oF+4uGH19uwdrJT6LYX4=;
 b=RbjWdMiZJY/tbnkmyhzqJ2gArDgF2q62AgrUe+mrn9VeRxqTC3YSS6oSeig5IHG2X0
 DlL15niw49W0qgFnYfFXhbySO+qTo/fETgFtmEmdk5mp/smopuDe0gqzXt53pTEYctKJ
 z3Spmiuvirxv6VTIcwr4bNUWKCHZ6VZKJCauGEwVedcaLLm7Nv+WIbiQY2Qf6CEgs/JD
 UEOmFlKdUSJLzOfq2pyg4laZJOSs3glOvn83Vg+d3YYv31k3gEMbL5GBPj8fXIm5dNF3
 okLw+Fbe+v8MT83uGWURpk565arCEIP1qFHOyEVhJvExgW/X3SjB06TUcFmafey5krXX
 PIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286591; x=1794891391;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pHoKtlWw4MdcYFAmqyM5G73oF+4uGH19uwdrJT6LYX4=;
 b=kBnuA15pILOqyODzG+yrd5ZGopmjs4Nu9c/aUOr0O2JOcYfAl0DCyDx9cxwk4QaQux
 zxPXM6FU8pMttooVTmfHqdUTlyxqrFzDwtCJZz+h/HWZmWc0Sn9CbZi3i8i5PdECMFj+
 3a6/zWu7Dd10NaQEih5W4sW3Jt5jfzsd8qUP1s492xRBHzz7ir2SxIZRlUdqNhS8nXGQ
 H0X52WaSWQfLtKfZiNp5OVE5V3aqxIdlXVJIOOI+dp+cIvsW0wdcMbzW3gSjSEVgscyC
 bKbEuwKqoIWxvpOqAAI0iyBGCDKpfOAr3xXQgb5NXV/Nr+w3QwQc27GDEcrp4w+enzhd
 ezUw==
X-Forwarded-Encrypted: i=1;
 AL+hErHDweLwNYOVsZwGQFDqsMonnnw0wKTqtvwso+O2IS7ZgHtQXrF+XNvUfxmZrp62oO6/fvKnkAXu/uo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9KFgspT5O6mL7KGchv73WGj/6BPgOICb2UeiKcJh5uVXvHtCj4
 E+ZwabNJPZZYNYQCX44/t6z01dLsYPdDLWctzfzD5Fhl0LgjN5AWsGp4mtFJMVfIgGGM6niTrs8
 OfpCM5hIKVZNCBC09DRdzaClao6iv8KMOXwt9n5bqyxeJod3UITPXwt7Uc37Aky+5Bmu2OIs=
X-Gm-Gg: AYBFou3B1loxK6XIOaI18W3AX2c2KikeesUZDUEHuZkg2o9J9OrGvsfr8eOrdeB9s7K
 f/o1pTtQzx7vJL3Wb/4MT3iZjNbxOazsIIE3TYhcSeldG7f/y11LwRDg6PkZGNw8PVFyZU/+pKw
 Ya+3/zVRlozrvc9FEfL8MKELjMiEXFHKH6zLk2tpRqB4yOBQFSWGCJSS2kNO9645qsV0hhgr6fG
 Tg/YaSyMhT5PYOwWq9rwvXyWXbrKFDD5zUWdGsQHfMFqKSbScVTiY7a8yQ2zPQzmHjL6KwirPly
 acw8mZzWNm4vaXUw1/ttRu9nGC43ig82mUDbuW8KQNsqYrKTXzOcvuHxzA0PZRQdqkCA//+XfdH
 3fewyWgNlMRj6Vi0M5AgNUWs1WfMjVRSJIOVtbV3TKtAtitobfaIjV4L1Wb6i0wU2G5YPcP7jJR
 lrAkBoc9qJaYV6M/MVCYo8JBKxQuPZmAmMUwb0
X-Received: by 2002:a05:620a:28c7:b0:93f:6f8:9d74 with SMTP id
 af79cd13be357-9479f42f4cdmr235197085a.77.1794286590938; 
 Mon, 09 Nov 2026 20:56:30 -0800 (PST)
X-Received: by 2002:a05:620a:28c7:b0:93f:6f8:9d74 with SMTP id
 af79cd13be357-9479f42f4cdmr235194485a.77.1794286590434; 
 Mon, 09 Nov 2026 20:56:30 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:56:30 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:45 +0800
Subject: [PATCH v8 24/29] drm/msm/dp: enable MST on capable sinks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-24-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
In-Reply-To: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=5632;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=MQxn5IlgLyQD5lvs7GYrzOJlBKGomT/Bam5EUTVFUfc=;
 b=pqZSBqM/KXCOlw4EjXksUQ8SdzCIZAWlXsfM3ImxYIWXm1ATC+5t66RSCeWSpx6vnuvWSxaH/
 QfCGsnw83EjAGn6V54d2TbYTDqyKSseO5tNPNy7IYCSXN2wLr/pN24U
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX9EbzJRW5RLDA
 JTR74y3e4ZGCiPgu4JYuJlorwOsAMg2mNxl0UVijt260cWVWY4mfjnqu+FHKNKXozg3VCIlnead
 XZM2n45dLcfmveFLrJTkELH1eXKPWME=
X-Proofpoint-GUID: Hwjdrg09D3XQmcwStUpsXLIsvNNHHyzh
X-Proofpoint-ORIG-GUID: Hwjdrg09D3XQmcwStUpsXLIsvNNHHyzh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX4BzhP9/p7hmB
 hOGqJaQOOXMnhswR4I4WFjYW2jHY8T6K/dNxdTedTJ91latm/lcycVOeI9BkbUAJIrweMG2RJHm
 ThGO8lo5Cipph1tNcRXuNQbP7ZulEwWjG4BL/Fo54DwaCnMI+uDW4uVemQnWDFANFI4W+1sEt5P
 QuSTGuabOYx7Frx/UQVB349I9jAZYYkEqb+vSKLQ0R5mntYUGMTB8IDhfk9z2hNHpJ74h+mzruo
 xjnChFMd963BzUVqP+yfDuNekfjnwCPgBkj0d8xuNpMPqvwKrlXR5K6X8ELOxRW6g/SoHfhu2vE
 qFqA7jV9vhXnI3OLieCOA/A9IYloXS3qghY5u4Crgbhd6O+SK9BKuvKSvmP5Vc13obrhgkHLeZo
 glPt0ixMV41FMHAoa0SOK3PWCRKC2QKWoxa3XWNaQoOJQqRuNvvrD3GyAZuKv/xFHOXGRyeDgVk
 AsKQdK51FTmdzxqPIUQ==
X-Authority-Analysis: v=2.4 cv=XuRvqlF9 c=1 sm=1 tr=0 ts=6af2a3ff cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=-w6CXN-5EBmt9i3D_LUA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100019
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
index f87eea19c4f5..eeb0e0494900 100644
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

