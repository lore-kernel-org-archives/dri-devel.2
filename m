Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B6660A3811
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Bmy36vgv;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PI7CGxKH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92F4810E91F;
	Tue, 10 Nov 2026 04:55:28 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E6B810E91F
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:17 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4A4Vg679538
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E+qyh0jetayrxs5tFWgrW+8697V0epCTw7HkDfY3pGk=; b=Bmy36vgvIu1nzbVC
 VZ4l79wCFXD11e99RKFk8xFo4Sv5Ez+ZRCxthfiB9jeOzKPJN5XbN9oQccTBqEos
 PVOj9O7OP/9/9tuP3yuzu517aiWFUQOufpKeZpzXzXt6l6rnH6bZ0iJlwZkVFNqT
 8EibzyJ6eE9jTlMS1uCyESC350/09N2ILeiTJ46ERsBwIm+cqYBgR3oL6QcgtSYu
 kfBYU0onVObV77WPZrjfz+2S+IxYkCajm8mlD55KMiCvZy3nMH+GdHWNJmocmavh
 Tjiq7cXHmMCm+C2Zyee8FpwuZh0blUjFwzMYhX3VDfdbGJtWdy57adDXf4WdqNG3
 vVgrcQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hutv48d2m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93e92aad34aso425867685a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286516; x=1794891316;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E+qyh0jetayrxs5tFWgrW+8697V0epCTw7HkDfY3pGk=;
 b=PI7CGxKHP17yTutdvgnJo9YSdmRlgZiLoKZywkMJubUddfxtyJzhdHcDSd8iLk3lwp
 BofSWtiiaYT5O4yPTO2V0Rpcfgxn9/CybYfyWYzMVViUCFWGF+3Arteyt1256NDGURMi
 PyBpGWImsKOeliRtVekaIYJsvUFGo2vD5zywFGqsVYCyFyNPKkpa+8ecAENkSFZQ7S/i
 VM0mN2suVz/eLnEPbCyu96+rcHqzg/od4KpLEyqI4Pcpr4XvIyjqL5dhL43S3tk+YvNs
 GN8Q7nMsepYukg9lrMhwTdPkXxVqQV/ciw3L8hpMl0vHchMCGgW3RYeMHlwygV/XZN22
 EOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286516; x=1794891316;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E+qyh0jetayrxs5tFWgrW+8697V0epCTw7HkDfY3pGk=;
 b=j0jJv52ESSzsKobadLn+laT5miQC3FbihRz0PdOaJ9tbSNzGFNnlEKxakK/xBQ0+Ra
 PbWwJiRP/D0b3xYd5dh/LT1y8wUffMIDldD7+c8A7rUN4CRd34/IgRycYTwFA6b+anph
 vUOJyZTr5h3jC/+9Rd3H64G/AlGC48QH0xdQ+9bA6QUIvQ/NmHoiq6H6O0EPRK8HsF95
 hM0MVmY/ayHm8nkU8YJn9CjVEGnQOyH4hd0FFZHvTIIqvo8Yy1BFJALU/RKzOOnWW86v
 csFxZl1sYbdhyYOv644RarhVj6UNR8p9yUx97v8t938iEvh+d3GXXAXP+kXcoVSh+2PY
 w+XA==
X-Forwarded-Encrypted: i=1;
 AL+hErFQy4zR3kCSsMLe9L8/ML/sb9so6jE9UeHJC87gwVRokaoAgCc1TzdesrvOEitSYo4dFAHrGCNx3JM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8UmwwkhNGI/hvSEJWWPDNH0n1ZIXvbb5mzKhyuSKHRyXsJsbB2
 iMFUNIMEBSApjLM0Fmfofx0nNkAjI7Mpv/K7e7wqZPom4/H/p2YbWRWujhS+oV7yOhiqwDFOPnY
 loHPbRgs4IAeFagROgk/Mk8W3PG4JL8HxcEKMRMwkPhIdM9IdgJRhLIhgcvO/RuNCvt3EIgA=
X-Gm-Gg: AYBFou2IPj8x0MMT+V/mQdyckVrNsPB2n9Af9f2NCGZwO3iomRBUklyk9udaeVLZoCu
 jkflHUfsMrp4nMKXKVc1XCioVhrkyiZrjE7qqwvF9pRvoVkZv39y7Daucy07CtwOVgGel+hVXKw
 kFBUsqBDPpMbfZqTteWplA9HezLFh7jvusSQvKfPoXMadlGEAP5DOZwCMtbyQBqLVMNdEuKDHzD
 UUulP3GMHfIXJos7sV6CRJroOdt0NI8zYE23qjbFqYtOprZcBI2bTXDEMjgKnNlWBT94IKrJwZ0
 p66iptAM2bXWQirarizEIQFEPsUDehD7ypzFEhM2ab0pZyUb4yBeGy1ORKvIT0oceR4Z4/SHVam
 yWuEwa5nsa1IohhmfEYhz2YZHRZsT+sZFO3nurQXvVqsoDw8Ra3pY2ZSWST6cQjXSI3ioKmQiFm
 HWCpiCJ73tk+g54wpSbFKN6BxFdx1dNhD7xYCY
X-Received: by 2002:a05:620a:17a4:b0:93e:c12c:43f9 with SMTP id
 af79cd13be357-9479f36e08fmr267943085a.70.1794286515913; 
 Mon, 09 Nov 2026 20:55:15 -0800 (PST)
X-Received: by 2002:a05:620a:17a4:b0:93e:c12c:43f9 with SMTP id
 af79cd13be357-9479f36e08fmr267940685a.70.1794286515362; 
 Mon, 09 Nov 2026 20:55:15 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:55:14 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:29 +0800
Subject: [PATCH v8 08/29] drm/msm/dp: replace power_on with active_stream_mask
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-8-d040fb33db5f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=6983;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=lf2boYn4jRL809HHeb3AhObsMa4DRl0sadT8kljernk=;
 b=F7VoRy/xhM7IFdtGf//nN2VT9hFh6/qQlUvMODHseq+WOl81W29Y91n5oUKMVs7+1cTvw5dgb
 g99EOLgh7P/Dxrk17fSw1kvVQMzE167zMQfHjT7WsDu3EF7rSk9S2NX
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX2luwdwsRVUhJ
 J50eDc97K/l4XLxziB/GgtGNDVMo/KgUywvIH6TD6D50cwRX+NJXn3J/TZqlpXVxDhKbVXr14eT
 +mnVU4rRicbImMJss5NpQ1ut+nNA5Pg=
X-Proofpoint-ORIG-GUID: _EwnAdFoUlHaDk4i67CFREm2Y3dcS-QR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX3PMtJHFxMOy4
 16jua2A4Ig+Flh6szdeUQGTCkrPHgTH3WnQYn29nzgaXe73/BVeMtZ3a3BXDcCfNTSWPeNc6pwj
 R7sMwgaIYn8CSJyeuDS2NWiLZQKuuktOlyVFk/8G7Ye7jlYYf2l+bjv0jBYUC/rHhCl2wo8Drsx
 kMgGpOjrWgZv6DIg/DjkdBNKqXA8Fh+k7LFcc1pZyQ7dUgzw6p18fp4YRZUir7o3U6dQe3+vnbN
 HqxFllLME087ghtSBfXU0kxpTwhXIXeNIM1DcZt011yYKKzLmOWIRwxGWY1smX00BoxMFgGNzF3
 94F2lR4YRmKegIbrb/fNW8A+MG8mpdf9vseqy4h0PFo64R6/kHhtef+qvHLDwC4VYp3GvEnAnCH
 IG9NMmKuLcA8VnIBI6phX0fb9yuoAULlr7d4hqkr8+LGrPwiuirPB/OC30AWkC5+OVJs4ZcGYcS
 uDOa9oubVxghl6zr3Xw==
X-Authority-Analysis: v=2.4 cv=B54sQ+tM c=1 sm=1 tr=0 ts=6af2a3b4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=OPa7gS6xof81t_cfdRgA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: _EwnAdFoUlHaDk4i67CFREm2Y3dcS-QR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100019
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

The power_on boolean cannot represent DP MST, where multiple streams
share a single link and its associated resources.

Replace power_on with active_stream_mask, a bitmask of the streams that
have been successfully enabled, and use it to track the lifetime of the
shared link. Link initialization is performed when enabling the first
stream, while link teardown is deferred until the last stream is
disabled.

A per-stream bit rather than a count is needed because two callers ask
whether one specific stream is up: msm_dp_display_disable() uses it to
stay idempotent, and msm_dp_display_disable_helper() uses it to tell
whether that stream ever made it through .atomic_enable().

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_audio.c   |  2 +-
 drivers/gpu/drm/msm/dp/dp_display.c | 56 ++++++++++++++++++++-----------------
 drivers/gpu/drm/msm/dp/dp_display.h |  2 +-
 3 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
index df222943ae57f..05972a302e542 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.c
+++ b/drivers/gpu/drm/msm/dp/dp_audio.c
@@ -284,7 +284,7 @@ int msm_dp_audio_prepare(struct drm_bridge *bridge,
 	 * such cases check for connection status and bail out if not
 	 * connected.
 	 */
-	if (!msm_dp_display->power_on)
+	if (!msm_dp_display->active_stream_mask)
 		goto end;
 
 	audio = msm_dp_audio_get_data(msm_dp_display);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index e046184a30f50..169990c10b367 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -652,16 +652,16 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 	if (dp->link->sink_count == 0)
 		return -ENOTCONN;
 
-	if (!msm_dp_display->power_on) {
+	if (!msm_dp_display->active_stream_mask) {
 		msm_dp_display_host_phy_init(dp);
 		force_link_train = true;
-	}
 
-	rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
-	if (rc) {
-		DRM_ERROR("Failed link training (rc=%d)\n", rc);
-		// TODO: schedule drm_connector_set_link_status_property()
-		return rc;
+		rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
+		if (rc) {
+			DRM_ERROR("Failed link training (rc=%d)\n", rc);
+			// TODO: schedule drm_connector_set_link_status_property()
+			return rc;
+		}
 	}
 
 	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
@@ -671,21 +671,19 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp,
 				 struct msm_dp_panel *msm_dp_panel,
 				 const struct msm_dp_mst_slot_info *slots)
 {
-	int rc = 0;
+	int rc;
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
 	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
-	if (msm_dp_display->power_on) {
-		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
-		return 0;
-	}
 
 	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel, msm_dp_display->mst_active,
 				   slots);
-	if (!rc)
-		msm_dp_display->power_on = true;
+	if (rc)
+		return rc;
 
-	return rc;
+	msm_dp_display->active_stream_mask |= BIT(msm_dp_panel->stream_id);
+
+	return 0;
 }
 
 static int msm_dp_display_post_enable(struct msm_dp *msm_dp_display)
@@ -732,9 +730,11 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp,
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
-	if (!msm_dp_display->power_on)
+	if (!(msm_dp_display->active_stream_mask & BIT(msm_dp_panel->stream_id)))
 		return 0;
 
+	msm_dp_display->active_stream_mask &= ~BIT(msm_dp_panel->stream_id);
+
 	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
 
 	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);
@@ -851,10 +851,10 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
 	 * if we are reading registers we need the link clocks to be on
 	 * however till DP cable is connected this will not happen as we
 	 * do not know the resolution to power up with. Hence check the
-	 * power_on status before dumping DP registers to avoid crash due
+	 * active stream state before dumping DP registers to avoid crash due
 	 * to unclocked access
 	 */
-	if (!dp->power_on)
+	if (!dp->active_stream_mask)
 		return;
 
 	msm_disp_snapshot_add_block(disp_state, msm_dp_display->ahb_len,
@@ -1514,16 +1514,17 @@ void msm_dp_display_atomic_disable(struct msm_dp *dp)
 
 	/*
 	 * If .atomic_enable() bailed out - link training failure is the common
-	 * case - the mainlink was never brought up and ->power_on stayed false.
-	 * Driving the PUSH_IDLE pattern into a controller that was never
-	 * enabled times out, and .atomic_post_disable() then drops the
-	 * controller's runtime-PM reference without tearing the PHY back down,
-	 * because msm_dp_display_disable() returns early on !power_on.  On
+	 * case - the mainlink was never brought up and the stream was never
+	 * marked active in ->active_stream_mask.  Driving the PUSH_IDLE pattern
+	 * into a controller that was never enabled times out, and
+	 * .atomic_post_disable() then drops the controller's runtime-PM
+	 * reference without tearing the PHY back down, because
+	 * msm_dp_display_disable() returns early for an inactive stream.  On
 	 * glymur (Snapdragon X2 Elite) that combination is answered by a
 	 * TrustZone-level SOCCP/ADSP force-stop and a silent SoC reset.
 	 * There is nothing to push idle, so leave it alone.
 	 */
-	if (!dp->power_on)
+	if (!dp->active_stream_mask)
 		return;
 
 	msm_dp_ctrl_push_vcpf(msm_dp_display->ctrl, msm_dp_display->panel);
@@ -1535,6 +1536,11 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
+	if (msm_dp_display->active_stream_mask) {
+		drm_dbg_dp(dp->drm_dev, "stream still active, return\n");
+		return;
+	}
+
 	/* dongle is still connected but sinks are disconnected */
 	if (dp->link->sink_count == 0)
 		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
@@ -1547,8 +1553,6 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
 	else
 		msm_dp_display_host_phy_exit(dp);
 
-	msm_dp_display->power_on = false;
-
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
 
 	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 472429d092009..b163954deafcd 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -18,7 +18,7 @@ struct msm_dp {
 	struct drm_bridge *next_bridge;
 	struct drm_bridge *bridge;
 	bool audio_enabled;
-	bool power_on;
+	u32 active_stream_mask;
 	bool mst_active;
 	unsigned int connector_type;
 	bool is_edp;

-- 
2.43.0

