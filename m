Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB21C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE6F210E93D;
	Mon, 29 Jun 2026 14:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ub3JQ1NA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z8l4WrMD";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1978010E93C
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:17:16 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TASwax2603482
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MLEmu0SuSJObPGT52LcwIf7D9jxRGU4XmXyxCd29wxY=; b=Ub3JQ1NAynwckSJ3
 kCao9b7INLCOzZW3Ya8TBT4iwAO9ZobK9+mMU8hzgkYvejyGzNqi0WKMGRPAS9Fw
 u3CMbaxv/q+JpBHdREU6MLn35+PNAVG7OHiwpc/fbePuTc+YZzHiLC9iTy5QffGc
 KScBNlSsw9Y6eW/nHOx9S9+WsxTX7o4cy5/fXta2pGlqjLyhPgQY9vkyPBMHCA7T
 ILbvIA4/ljTwTJl27h9WqP+qlhylIznbEzm+wUrjt2gu6Nn7zj55fo87Pk/i8rs4
 dxmLVwmcooU7boRV/y5okv7xMampBbTxvU5oZW+v9SblR+yYTLOl8JMfDcS74KZX
 z2DNqA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nq89782-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:17:15 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8dbdf24d47bso67882796d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782742634; x=1783347434;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MLEmu0SuSJObPGT52LcwIf7D9jxRGU4XmXyxCd29wxY=;
 b=Z8l4WrMDsBpy/I8WWqbab0VCoOLsHf2O0zYdo1LZEtMKW2mPsHch6+uDRKkEYz+ciK
 Wu+M4VjZrKGDWildUxtRNoC+qKPl7E2GGME9KNNsJUhobBRP+RC+m1yfmXs9njwuubgE
 8lpQuq9jzUD+V59LKl9FMc4pG+4xZ8dfzwn8sQW9uFbWIEColIWOMRLzuj5MGoJibDoA
 aDPGR5LBcUBxscG+ywyAfnxbzAe3P5vyLoUKCE9pWwbkcxLVShSTVawL8PBUbVtrlD/B
 WgWZJPdJiWDTzw/nWli/JZX6OVoUnyW7sbw1VKNOoqHK97gcHZYGzOWUT5W7jdccMj4W
 elVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742634; x=1783347434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MLEmu0SuSJObPGT52LcwIf7D9jxRGU4XmXyxCd29wxY=;
 b=P1qRCLRtqR6qKNC23ERSs+qrkYIvgM6SRwvjUq89/dloTdcQqRH4iIbMjTvTqcJ9JK
 HNw7q+SXrCviQgXUsWVZNSF6AcE/eYv57i83wUi7jpTa3wjB5SErF+q4aImJu8YZX3XM
 +XkA+Ni/aC2kQDns1bcz1Dhl/vims5MYmpziNutYw9jKP8cgdt8iCf4PP7O6RCBrpuUw
 Pa2/Nhj4zJutRNkIt8HMJRib5kv7j94C3/lertH4v4Z+3JFOJyFwQsLHf6N/7YrOsihP
 WXjrl94knTU8w3DvY/14v5URCCSA5GyW1bAhsqI69M/2yZgpfNkg7PPr2dxvUG38DVzb
 b1lA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Cd44W5Yhb1EwpGPp14wmApBuCmy74KvzW39LS+jiIX6bkuvLc4CAmNQbwc1uO8v4NfqneEzjud0E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1Bs2SKxXUCxaQUTngBZSiXJF9nD7XDEzhkTDhYUdEh3bK2qIu
 sHPKninkQTni/MiE84nKf0Ww4mdTbiDcX3ZrKIRHfdMP91IrONZfCTreu1BtQ5/fFRtDFLdFfk+
 TD9mGvUusnIgn8dhGL5/+juBJSjoYcmcy7LTi8fedl7IUeJ5QiLt1Lzlc9HP96/8pSU2Ui7k=
X-Gm-Gg: AfdE7ckxH8KiuS66evV3Tj4L6TgoelCBqghnzTlzty1w4eQteH5oYkwn6EkFros1wcU
 yNULmvaeglstfR3HTvaHyUEMcqSL6tqwpPeD8/N977WhYIx2Tp6MT6m1A8J+vlgSCMe5+3VhsUd
 xEgQjGqMrlbPc+MgGMQDIKxdHa8SkgjdbeMvM7S9vdoy3v27j+rUfB6brR/T6am8TXKAqO8IFhy
 8Jt49vsGWeoXYpo/KGdUS8cCOWyjwKQTGF4mISTlA0Ls4jLUlquSge5H2p4jcCV6eD16MsgmANl
 HTvYWzKzo2TY5n2yXsQD9VThQ1zwQqmkI1ABCaW61GPkEl4wK2l/okRyXVTzo5Q/lnCJM9wi/UX
 y5xtV54SF7Pm32u5demrud/FLkapCx7xJwjxsw9a5OUxZpTzItqwMgTItKj03B2LH23aX1w==
X-Received: by 2002:a05:620a:2916:b0:92b:7420:bd5c with SMTP id
 af79cd13be357-92e5f04de9amr155787685a.5.1782742632944; 
 Mon, 29 Jun 2026 07:17:12 -0700 (PDT)
X-Received: by 2002:a05:620a:2916:b0:92b:7420:bd5c with SMTP id
 af79cd13be357-92e5f04de9amr155781885a.5.1782742632307; 
 Mon, 29 Jun 2026 07:17:12 -0700 (PDT)
Received: from yongmou2.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9260079070bsm2143165885a.40.2026.06.29.07.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:17:11 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: [PATCH RESEND v5 24/25] drm/msm/dp: add connector abstraction for DP
 MST
Date: Mon, 29 Jun 2026 22:14:45 +0800
Message-ID: <20260629-msm-dp-mst-v5-24-2ed6aee1867a@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782742144; l=9169;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=YsuaK/0OYI79/l+b6bHLlwEgQ38BKEFF+/BvXN79st4=;
 b=Ouy/psp6NXOyBjstHOL0Vfwli6PVuRiW+uDxMBE2Dn2Yspy3nf9+f6GCz+pyUBWswwVRe9ufp
 V65OSSsDsVsAth1TS6naZi3RE47vCGrUIGmUQYLNcW2Oh6YIbJroM85
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nrjSgqU5t1aNgn-LBFTKnEcHBEaeNltj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX21CR3doRc7rN
 IMBbEHMS3mAFNXaV0OKN5ixUxHONr2evWAc+kfqJzAKjR4nQU16tTFFjV2rc2MeVHNbADWp9YUd
 Gv+VcpUG8rMSIH2jEazyWzRDtOTpQsQ=
X-Proofpoint-ORIG-GUID: nrjSgqU5t1aNgn-LBFTKnEcHBEaeNltj
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a427e6b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=mVHCav_IkjWnAo0-rBcA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX7nZ11FEwtBAf
 ePRIFC2tJDibLn1kPKRDaP5wVKSPmpJzWVcZDmrMXDhu7FngWO/+Vl6gu+NiLjmoioiCNswlFnX
 iTpfHWlSiff1OTrL70Uj3LTU26nKW3qdud8/vg0S2Al4d56leguQK/IZZYVaCsUHaG6RjhqF49T
 +XQAMF1P/ThdbaFQCRV+n1lX8oDVQnviQAboB2La+iSGc2G7w8TiCHialiRG/KU02BoBlBwJYgB
 DLtH8Lh2P0txSrUpGIhIzXfTTw3LoWihqyIdSE2HglpC3QJGA9TVUHWZCakyBbMU+sSrnpVoL5v
 pU3jq8Sa+AG1pa3HQRo1jC8G21jxPNJUHJA7ySt10WpOqKLPdmPx0WcogmL4pETYD07Q6TsrV3Z
 TPStgQyswctI0EXVfR/SR6R12JpjmOg3U3Dejz5YW52tcRyhWr8/AA3TaeT9qHlNjQyTUA2dwEf
 KkzZhDnd5hf6H9T3YhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290118
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

