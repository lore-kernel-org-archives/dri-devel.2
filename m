Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BA2C43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70E0610E8CE;
	Mon, 29 Jun 2026 13:18:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kiNKbYht";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W5JkMJLE";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DF3310E8C3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:18:17 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT3422604343
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q9GXCpGI2FZ2U+GAfjzoSbly46KsmEpGgfcu9nwsblA=; b=kiNKbYhtGhxBSb+a
 LyAK0D8gjvIY1E9oEIWWvLrib9LyR25oRZbjc75VGbGOQ4UnYmz7rc0H4BYgKbhg
 zKN0bnwA1Jy2rSzU6e9rneYE4c+INsZ9NrYsVJC+7NjqHhztO0xPKsjled6Wu/7Z
 fMNOrs+gz1C7Chcg3bW/QvoiGlHtkx9DYnOR87M3zcDL4s9hWAprP1dV0VnZeZWL
 sNeciUvmrrR2Vk8bPpbrI58Kkqbggc+6l/igOhZrK2icS0OLPWxYDLZM5D689tXm
 X2UocKFjVIt8w4HtZU2yLQstFXx38tMSDbPyAKqfWkz56tgxylXQBvRYOZGzXB1F
 M3Fo9g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nq88y4m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:18:16 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ea75996387so52448436d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782739096; x=1783343896;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q9GXCpGI2FZ2U+GAfjzoSbly46KsmEpGgfcu9nwsblA=;
 b=W5JkMJLEEbjaQQZcKs6PlePvBedeJycoa4TjLY5Zcpa7DkPReOELvZqTw83UQuCKFn
 GgNrzGQMvcR+FB7N1Q49oo3WrBlmIfd6Fkt4aHEX0AgSiL/ts7u2H47woBsuEDC5f7ry
 vIfB0xIPWTsGXq24r0SkV2rNQ4y37NIymuqqiA70/fAMkqn9x44ZQwN6pQul9T0Hs49P
 RU9/M1sq85K9Aj9Anq7tY4jBSEQiiLwXd1aeVpgT5bjTx4BTor1/VumPlCQYOeNVjfl7
 Y/h4/Rvl6IplPofe4vK+57BVWkrZQVwwRJIwBuVU2SO5IXcqQJg+6GCI8FsFcE4RMVtx
 VkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782739096; x=1783343896;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q9GXCpGI2FZ2U+GAfjzoSbly46KsmEpGgfcu9nwsblA=;
 b=bnxqxr3iAgI1McxLLw0rTfvG9omyDTHlzzrJLAno249KjA0CIorZFCqAtmXPaviZ9t
 L2cJhCS12JkwJdgXC2/Jwg8BGwvh8QicgXQQd+uY5zG9OohGwVyoJ3EIM5R7nl0zC4dE
 ZbCecBZKOrMb93LTeWUsu7xGcHTVLJc+eXsineZqiXmR9ERhrXVrTDBxDQJz2vtE1WNo
 9KKRhyZMzhwiS5qfQ1lnasYmfc9WzP2XRW3R7NB4XKCtXgrbgnmuv557W6WKyk0KyhIZ
 6Nb2elfj/E3qvATc0Z4BFf3wP3XO76Uld1zEdp3kTMHWgU1rwBQhUAUQJxGjuaykxC91
 sswg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/QS0F0tFefgRScYc0V5DOt3AVFgXFY50dVgecOCBlkc40gfH5aGI5cbnTaHY0Wo3UF2OtmIj6NH4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzxTiiZYGrgP36LKi9APJ4ZCPjQT74yHeR7nSUf1sVYpBi42x4P
 857ws86l2W4pTphKYgQFznmGB7t6+6qWc/P0g9ir8idPAqLEZqcMUnKhozlGcqjWW3WMlSpINFb
 JfhbLQRKzb+DCZcgJ+5wgp91rdUJDyJ8tGMPYzrZP/hQr3CUUgr8KNi768rq5uhYmQJTYZEM=
X-Gm-Gg: AfdE7ck3IV3onR1DzgLPdc/o6Jr2kjB3MkScxlFaHZJZl9Q5sOsGjLXEYaNX6DyFEc2
 sgNyp992mvq/ZMKqyWwDMJ3sCm0H1Lu1e8kfKCbpyKNUKMjOVWMrvYzY51MDlOmNueqClS83xp2
 dPfCt97S+ZrPfyuE5F6DMhG+EmWadZqToGh2Xf6oZhAr5si4IaSO1031eYao2GEhnBtM2/nzPAh
 9Vjkv3hSc3RDzFFuBDs2Cq7Ie7XVaB45nyb5Gm180vBsIdw1SAm6iUHjpsUfG6OHRAXtTxF2U5L
 CyeOOtmIMqfJZNWtZSla7XK2HAB9js48zVTXlrTAv9wn37KJVzJrXID+dMTVW6MgzEt/5+8B1Mw
 5IQWiP3UMeBE11iJEmGw0F8lieevzJjP2n6MDSv+bcnoPghvdkRtjHfsFWN0u3Ar6tC22uhWZ9Q
 ==
X-Received: by 2002:a05:6214:5785:b0:8f0:2c80:caa5 with SMTP id
 6a1803df08f44-8f02c80ccb3mr56994186d6.23.1782739095977; 
 Mon, 29 Jun 2026 06:18:15 -0700 (PDT)
X-Received: by 2002:a05:6214:5785:b0:8f0:2c80:caa5 with SMTP id
 6a1803df08f44-8f02c80ccb3mr56993276d6.23.1782739095378; 
 Mon, 29 Jun 2026 06:18:15 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ef0f2b9df0sm56744616d6.13.2026.06.29.06.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:18:15 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 21:16:39 +0800
Subject: [PATCH v5 21/25] drm/msm/dpu: use msm_dp_get_mst_intf_id() to get
 the intf id
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-msm-dp-mst-v5-21-1d882d9012f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782738985; l=4713;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=Nu7YW4TXEkufL2/VUa/aa1d9ExabRLDcY0ZzM8BCDDg=;
 b=ohb3WtX07SqjYmO20l2UfR1xpcCRG0WO+ep7uEdGa4OsS3EK1uZpJZEbExSPOXNC4QLvR5bVf
 QNiRP7IYn6PASfe2bJwNAhfwRmRX+nld/WsdOPCaT69gM62o66KpnCx
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: DjKq-4IA63_5N1QpaHXDFGPytdGPXwUj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExMCBTYWx0ZWRfX/15wbz9TgBe9
 t6Zmj0qxkaxPBwmLljK8ViiKx3K2W99xcMxZFeDttZxGLf0SNmIyHzw4CAWtanL9zhY0wDOCdlm
 WHMxUxb4feg1dnTpuzmTXeFVa/3CMwo=
X-Proofpoint-ORIG-GUID: DjKq-4IA63_5N1QpaHXDFGPytdGPXwUj
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a427098 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=xL80pz1hMqKSlDDrj7YA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExMCBTYWx0ZWRfX9tMj4/R30J1j
 9ZoAq1r+imdrTHNnYjW3bjtpRd9CjC2jbq45KvSi2081t4lkfW6rOzGdvvQfEJv3ul74EBU4D3e
 kdAQLdwOg1occ5z08EkbZS62O4QZrpztowHojDDwOQjP0782xfz/qOLghAAOaS/JhZl1Vxpzi3n
 AzC6H46ulZW4isLH6Oi1R4oE0CY45JMfKmHD4uf9KC4r5FzHvyRQx2kAhRQxNz2QtAjoI9r3TP1
 jo0uyGbR4hJHwaEvcYft9K6TEC6XP4R7QgrI5QptNR1unLcugML7lpYow3aJ3/KtD9f/zkmM2IX
 egdMzI12VZNYgv8cGBd9dnkoz+jHmX4Kbsz6TN3VPvN9CkdcIQLXKEhvSvvXZgGzKGKdH5+kRpN
 znzydX7fuYAdUCh2H5NnPFcnIP/uFJO+TSgoTp4SkLOiaQusfLPH1c/Bj9VaXzTLajA0yRaVtE0
 S2+RWVsBEWyokfbssNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290110
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

