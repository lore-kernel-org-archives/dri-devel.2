Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69926C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAF0A10E931;
	Mon, 29 Jun 2026 14:17:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SXU7iMmc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gtj54/KN";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7B3310E937
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:59 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT4xI2627854
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q9GXCpGI2FZ2U+GAfjzoSbly46KsmEpGgfcu9nwsblA=; b=SXU7iMmcDyIcFmyT
 +a8iAuG7FzqVJ6eamj1jWYKeFTCIJ1KaX7bGjcCyrGKACNeU6FDEVCpkO8ApBMQE
 DMMKhAQQk5oJIZFhTf0kMAnoYscAnPxsR7sVBcfQDL5nSEtBX7G93vLIPJ3shTE2
 /lHvAbziPbWAcOGcx4GKXaTyyqXj0H9NTaCXzlENw/ZUMK4Q9rpqfz4QXLIbFCXW
 Tbv8CSGVOGVdiDBfV2DSXecsOlYty/NJdXQSyR2x6Gh2RvZq94lsoWAR8xD6k633
 qQ8Bt/IHb05d8mum156JZnqTj8oaVUR0CzPQNYCgNBli0m8/6DpRwxJ0EutuH/xP
 Xb5MUg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nbgs947-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:58 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8dbdf24d47bso67877306d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782742618; x=1783347418;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9GXCpGI2FZ2U+GAfjzoSbly46KsmEpGgfcu9nwsblA=;
 b=Gtj54/KNuYNBSuXvePNsh3VVLKwxzk0NwmVKFw0jVglAa17/pqiTYgFG85I8Cu68B8
 4j+kXHYgVJQrn+uBIm0I0ttC5D1FfmypHRWbSy5U4CWMexJF8GfSMkqedDmDeRmqbwit
 1ZsXqIsdLfv7Tv/S0Yb1/vR9W+IuDaxxk8NniCIqpyJYng70dyz5KHztQM82qHZkHTxQ
 bvk6LpWXicc7iqAvD3sD8gY1sZmj0l+Yr75K1VSKQszhBzaCYKTyHd+el3jtoYz47w3k
 EvZZH115RkzrWvdBrgsiYlRsi5Epeok33EJCT+kX73wBYkePENCLVFQGVibMo8kQsnHU
 vhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742618; x=1783347418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q9GXCpGI2FZ2U+GAfjzoSbly46KsmEpGgfcu9nwsblA=;
 b=tWq6eMINRJ8ZshpsSycnKNQSEyK+4xVzHLmLy6juyb5yW2FeHvgCDdDgxNsSEnKnHn
 FHHVKadWl4vXnzBkGFCIs4AHyE1KKvTB2bSxUDdAIbLlJKzrbUsUQkz0w4MVSeftJVzS
 l77oBd5C1MpWtIXHi4NrrraiSrpXvd3CZ2IGhhNp/Kw9Cfd4+FU1ZN4xF2nEIjdA6qLs
 /7dKXBpjp7++IoskfgK+PPPo5cdIw5N03CctZgJtI+PH7fjAhp4g7kxRud28PxU9588K
 Nx+KoOwaXwcz8qOVyHcDKikKax2Tf82S99ijoBfejR9XAGDsgRXdrRzDT+31wB6n0159
 bcgw==
X-Forwarded-Encrypted: i=1;
 AFNElJ82Sq6PjQz4w8xUGY7g0hAydpIKTWSA8TZ3DIq8Q74plDHeU9JCu6QBX4kixLNamCbMYZUIObGDVoM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwfmbAov4sJCn7z5rPiUDRkeU86vIUhy5mt7Thkndgm1QRpIQSe
 jcgUpA1dmCSwnbrUfvbH50E3EWVaFjSKuGl77OqbnmQnFUD5u+QuMB2v8XKRfCKzerTnCCiC/49
 Gx+0UHwnqYGzZfBYyuT+wR4PLuE7HSRGAkszrPy7ybJEvXwFt3ZzoLKjZmedMyPdzQFBjgaM=
X-Gm-Gg: AfdE7clbqmIHuu+z+EMx2rL+6pOCk4hi2lmRcXaj/oRsCAXke7oDjHU1TKc/TlO0tHf
 QzGMzxooTU+tiEIrEnSJmMzIgUG6SvaHJAe9pAZnacet6U7L0KaHBmJxL1T/66ofqkkowLcURsA
 w8G3GJ8wJkG84GPh/RbxvU9JxBLpP6SrCm9ndaQulgfZ8AInlelEOx69yr7NawDormQPV04sMDD
 yJC6j6Nm4MJ7Vs8xI5trkBcFRfp4jV8zpTW+ZtTLTYWiZs7h/XuqK4YOSORoBkIhOXQYDz9cRjP
 3zANYaRFVaaUcj24rbjkpXaWYx9Nw+Lzafw5MG25T/1YCol+At6y78jHPE+1rsSjTvngafkDvwg
 mHddU0AMi/VirzJZCRkCQP5+QWBmp6WxbjEE/8vArMB9Rr1s8eQ7HnJhKzBt+shbH+zYhfw==
X-Received: by 2002:a05:620a:2612:b0:920:91a7:1d99 with SMTP id
 af79cd13be357-92e5f04e0c7mr133125785a.7.1782742617523; 
 Mon, 29 Jun 2026 07:16:57 -0700 (PDT)
X-Received: by 2002:a05:620a:2612:b0:920:91a7:1d99 with SMTP id
 af79cd13be357-92e5f04e0c7mr133121185a.7.1782742616923; 
 Mon, 29 Jun 2026 07:16:56 -0700 (PDT)
Received: from yongmou2.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9260079070bsm2143165885a.40.2026.06.29.07.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:16:56 -0700 (PDT)
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
Subject: [PATCH RESEND v5 21/25] drm/msm/dpu: use msm_dp_get_mst_intf_id() to
 get the intf id
Date: Mon, 29 Jun 2026 22:14:42 +0800
Message-ID: <20260629-msm-dp-mst-v5-21-2ed6aee1867a@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782742144; l=4713;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=Nu7YW4TXEkufL2/VUa/aa1d9ExabRLDcY0ZzM8BCDDg=;
 b=sZAUP8eAf/QiLXkrh0A2OThr4b7zwiZA/XoNAllvJ6p9D6zP/Zo1h+f6zdLyUu3JPJ8uv0w/i
 DpuomXbfuVKCN5amWahb6l6lhD4Kc9itatYsCBvtP/mOR2/sOgUtB3a
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Io1Fn-0Kh5uBmbUXO5KfcV-7eHU8j2cL
X-Authority-Analysis: v=2.4 cv=Z4Hc2nRA c=1 sm=1 tr=0 ts=6a427e5a cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=xL80pz1hMqKSlDDrj7YA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX1qH0sNaxzvvN
 A14q6Kye6xSys7oEQE9YvLFbdITBgJ24bxBFxCKfGxJZqRlIVyuzhHVi5kCOcRffuOG0K4mrGFG
 hqjtH/dMAb4kLDQrcEpTKfjgxREbqW4=
X-Proofpoint-GUID: Io1Fn-0Kh5uBmbUXO5KfcV-7eHU8j2cL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX7cvy3va/u9ml
 fY0hU3u67zUtCs0o5V26QHWZ9f0wHmCCWh+0MwLYZGEP/kjCt1yuV2fTQqBRTGod6yRiRcbGkUT
 7lw673xjzsStLN9Et6xu/FV08E7w4RY4Evmdft1AxbjPU5Z98AMlixnj22H7P0jfjUfQQvSQjzI
 3XP+Py6pFzXn+WvsxXxRJn4ljqYUNgldSBihZ3BK07VsL0OUx8Smtj8SafMr7tY9I4p6y34I1jp
 1UB38MO59gEq63/RnIqHMJRXakh9A9OMo8iS+TDomSdrIGujFwxMrLFzkCwCHgizXJhYBpcfIra
 AF/dmjf6MAbwDURWZqCGfvf1gyBTU03ZaIEs9C/0UC0rBuqBBUAvYN7SEorF+5G+1fs7n7T3Wqm
 hmg6YiHlfJcA5soTEzTdoFyFNJHKO2z2XlvJIey/sF634f9LqFaca2WbwfjOvI74co2aIwCadL/
 JDNeFK23KvOcIEfTRbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
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

Use msm_dp_get_mst_intf_id() to get the interface ID for the DP MST
controller as the intf_id is unique for each MST stream of each DP
controller.

For DSI/eDP/DP SST, the stream_id is always 0, so existing behavior
remains unchanged.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 20 +++++++++++---------
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  2 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  4 ++++
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 1c74ff6f0dbd..3adfaeaab71d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1438,18 +1438,21 @@ void dpu_encoder_phys_disable(struct drm_encoder *drm_enc,
 
 static struct dpu_hw_intf *dpu_encoder_get_intf(const struct dpu_mdss_cfg *catalog,
 		struct dpu_rm *dpu_rm,
-		enum dpu_intf_type type, u32 controller_id)
+		struct msm_display_info *disp_info, u32 controller_id)
 {
-	int i = 0;
+	int i = 0, cnt = 0;
+	int stream_id = disp_info->stream_id;
 
-	if (type == INTF_WB)
+	if (disp_info->intf_type == INTF_WB)
 		return NULL;
 
+	DPU_DEBUG("intf_type 0x%x controller_id %d stream_id %d\n",
+		  disp_info->intf_type, controller_id, stream_id);
 	for (i = 0; i < catalog->intf_count; i++) {
-		if (catalog->intf[i].type == type
-		    && catalog->intf[i].controller_id == controller_id) {
-			return dpu_rm_get_intf(dpu_rm, catalog->intf[i].id);
-		}
+		if (catalog->intf[i].type == disp_info->intf_type &&
+		    controller_id == catalog->intf[i].controller_id)
+			if (cnt++ == stream_id)
+				return dpu_rm_get_intf(dpu_rm, catalog->intf[i].id);
 	}
 
 	return NULL;
@@ -2675,8 +2678,7 @@ static int dpu_encoder_setup_display(struct dpu_encoder_virt *dpu_enc,
 				i, controller_id, phys_params.split_role);
 
 		phys_params.hw_intf = dpu_encoder_get_intf(dpu_kms->catalog, &dpu_kms->rm,
-							   disp_info->intf_type,
-							   controller_id);
+							   disp_info, controller_id);
 
 		if (disp_info->intf_type == INTF_WB && controller_id < WB_MAX)
 			phys_params.hw_wb = dpu_rm_get_wb(&dpu_kms->rm, controller_id);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
index 25ade3dbbeda..861d69afbd76 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
@@ -28,6 +28,7 @@
  * @h_tile_instance:    Controller instance used per tile. Number of elements is
  *                      based on num_of_h_tiles
  * @is_cmd_mode		Boolean to indicate if the CMD mode is requested
+ * @stream_id		stream id for which the interface needs to be acquired
  * @vsync_source:	Source of the TE signal for DSI CMD devices
  */
 struct msm_display_info {
@@ -35,6 +36,7 @@ struct msm_display_info {
 	uint32_t num_of_h_tiles;
 	uint32_t h_tile_instance[MAX_H_TILES_PER_DISPLAY];
 	bool is_cmd_mode;
+	int stream_id;
 	enum dpu_vsync_source vsync_source;
 };
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 91d33b432427..b32ecd5b0777 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -614,6 +614,7 @@ static int _dpu_kms_initialize_dsi(struct drm_device *dev,
 			info.h_tile_instance[info.num_of_h_tiles++] = other;
 
 		info.is_cmd_mode = msm_dsi_is_cmd_mode(priv->kms->dsi[i]);
+		info.stream_id = 0;
 
 		rc = dpu_kms_dsi_set_te_source(&info, priv->kms->dsi[i]);
 		if (rc) {
@@ -689,6 +690,7 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
 			}
 
 			for (stream_id = 0; stream_id < stream_cnt; stream_id++) {
+				info.stream_id = stream_id;
 				encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_DPMST, &info);
 				if (IS_ERR(encoder)) {
 					DPU_ERROR("encoder init failed for dp mst display\n");
@@ -716,6 +718,7 @@ static int _dpu_kms_initialize_hdmi(struct drm_device *dev,
 	info.num_of_h_tiles = 1;
 	info.h_tile_instance[0] = 0;
 	info.intf_type = INTF_HDMI;
+	info.stream_id = 0;
 
 	encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_TMDS, &info);
 	if (IS_ERR(encoder)) {
@@ -748,6 +751,7 @@ static int _dpu_kms_initialize_writeback(struct drm_device *dev,
 	/* use only WB idx 2 instance for DPU */
 	info.h_tile_instance[0] = wb_idx;
 	info.intf_type = INTF_WB;
+	info.stream_id = 0;
 
 	maxlinewidth = dpu_rm_get_wb(&dpu_kms->rm, info.h_tile_instance[0])->caps->maxlinewidth;
 

-- 
2.43.0

