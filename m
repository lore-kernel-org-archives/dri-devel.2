Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF15EC9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E24910ECA6;
	Tue, 29 Sep 2026 04:27:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="k+Ol3Su6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M+P/6Vbv";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 565F910ECA7
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:32 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T48P9M2688343
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iODT69tvM61W5g/ZKYOEcz7N0HUYWVFLT6a+9WXXuFo=; b=k+Ol3Su69O7rSheM
 In0z1X6I0NFY3QVoceDbomq+dOJIz0xvmaGsIJWGE8hdAoor4/kOoI0Asp7aFxz5
 O3gEf/aR9zueAD/59ojbneZNPX5ZOApwRwQjQTTp3r6nuE5xpHZ+PcRfp8cwPK3U
 WAoejnWJoGmXKlX9P3X4bZ622Iu7fOW9q5GKNcT5SzMC5yubPTE9ZewtJddViu/p
 HMiaIOFbLaMPLPM9Iwuugu4zndxOjAuntlT1H12gWoQhz0NdoRCnTxh9N/NEpw4h
 EshXZXGBrPYnOc8QB1PvJCIBkLtBiYGIzPjm8aNIMUjBd5I2wq4zYw9VR6DCz6lr
 rMTkkw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h02mjgr1q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5328827bb8dso98327901cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656051; x=1791260851;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iODT69tvM61W5g/ZKYOEcz7N0HUYWVFLT6a+9WXXuFo=;
 b=M+P/6VbvI7vJ/B6IMXUr2aHtlwOlYqJzl2IwVTZ3hCLb9I0lR380wW/297upGZuK/g
 TwB8JlrbarhoD0LR6SPwfj42F77qaKqrhL88ZKaFYJeqNf6VSnSCPfaRSWg16y9B/fYj
 k0J92U2sMLS7AZImcGeO4BwDAXT4MYZQ3EYw96qZ97MwO4nbSRmBERKBijJT5fG4wcyB
 T0uXYbx2GK94D+uGMkhyZ9fi0LgJbwWb4I5xhkEYQyjhdzRA7DPK7c1kUHIbBlEaEASe
 3CMYJWJP8uOSdhn9xsJaw/fOwkFDgA14ds/nYnWJbelYK3t+kGfndep9PuuPC7CZL98m
 pHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656051; x=1791260851;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iODT69tvM61W5g/ZKYOEcz7N0HUYWVFLT6a+9WXXuFo=;
 b=eVL+kwlUftGXVVQR6bBUOwZ+b1JKwzxCs8VRJhyojWYclJoz53fsuChNyOI5jfAccB
 eySQrkLsSJ1gyEGIQGYGOoqd1A4Wr0iGkWTaTBdmSmig71KBpUC48qxN3xRsROqxBoMl
 U7uDMRbpppRF7/axHGoLKB6n+bfM5kyk3JcmnrmPP4/fLsr3g/kY7bwXWzcOaurF8/cf
 tykmGo9ArlnS/6VcpyQEA/xGplKck6UE46PujRlDixfciou9bd//JkbMuGrdyYXpKmrJ
 hJZRKXTTHnHmBLzCPQWWfIKXDKei1VHU3ArbDUB3DCdjIv34/6/iK3t4weyDRYVy3WAo
 D8tA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQev2NzLT3OI11By9wXxaV7+id6nKrfA5VvxLf5XdwfiDVrkAI3YdjHer27IwDTEnCoqX1SsksktE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIXwXBXDKM1j3WzFBVZC9Vg73275hmmTiFVC6z4dSSXaLMLpcI/
 fAcaA+IBKic2UrgNzuAKBBYV1HM6ID6xMDTpKit1XYFHeBxg1i6Hkaz52GXDymvcWv0bjA0160c
 3bjyeWBP9uVsL79pSrcXy9WESqGhIVUoFKk43oNLo/t4SlVb0Av3xLNKTljChv/0dZogqb2o=
X-Gm-Gg: AYBFou2Eq5brOqJ+HInKCkffsuAmw+jVQ0EUzXTZNjIZRshGs0qMaVuNW3O3ColFO9m
 9mCC43hqFaL9X7MwVqFzu4ds5p+lUstWn1E00tX/dE6IdtfAwWXiIETaCA9OY/gyV1feQD5MiX7
 tx2kyKnkle9cfgAIhZDhQM/ptnvexzEfvaSzqOOBvMyikAGsQSGcCt6UDJJJbKL8nQTrQX+wSSM
 WV1A7mhB+DrNmlqZd2Q+5aZSWr4bQQAYHP73f2N7sIdQK09U2yjFGiBkyCZ09buTWDX2YtBe7uZ
 kkq9l8dkOOo+Fwj0hOw57Dc/7YAWIziLa0QIzOUDNv/WRvvMs4ocWx17AJzllipASTy93porvjc
 HHVeAI5ZGJichGfaryEEV8+UOliCfQ0Lzijls24nkXsHe97lpzEf2EnOc5v9bbSM=
X-Received: by 2002:a05:6214:2a46:b0:914:4464:41a9 with SMTP id
 6a1803df08f44-91444646d98mr179643286d6.29.1790656050455; 
 Mon, 28 Sep 2026 21:27:30 -0700 (PDT)
X-Received: by 2002:a05:6214:2a46:b0:914:4464:41a9 with SMTP id
 6a1803df08f44-91444646d98mr179642936d6.29.1790656049917; 
 Mon, 28 Sep 2026 21:27:29 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:27:29 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:37 +0800
Subject: [PATCH v7 13/35] drm/msm/dp: add support for MST channel slot
 allocation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-13-4b81473185e7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=11194;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=CS9qE5ViaqnMWyqgOSlTHPb1Exjcyq6ufT0l14Mqjoc=;
 b=GUELsnaL8BhoNqhjPAKAdqfvuzUkoUDHVtbfpAS3AvOPEjWvSPXU09puxtmasylqH6epOVjJy
 KrI7sL1GEAMA5+6bfP6TaVVwMtseBoslr6TvRLQp2zkoMgcoXBYZPGD
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfXwh2X6HrarkcL
 LQK5jVVwgkn38i97R8YtsS+4I9zKtqPno362DEGzPeZOvP8Toh867/VwiRVpCIFYjheEYSJ+bmC
 DSHMESOaEagjraK4pRf76A9DAt0GaQGxHL1q7GGa+YheQDfTn0jfTfNPWkG1EIUIoFHmfD99P0N
 FqLwlyPZbp3gKnmYVqVcN7VjsNCwuXAWFPvK3eKuMh9CMbqsOYVmoUKMSomCdXYn/tXSGqM6K1T
 +4LsnRfJRhrbq069j3BsRZaT6QTEiTqXzd4kCAm+9pABaN8aXjlZpFFbj0/xnoHWLqyaIXwjRtO
 6CBvvVoNyOKFYsTlrunaiAB/F+iyuYy/bF1pKra1+l9fAXVrmzuOIr0nzzGe4pVlsjrggyjJWqT
 cFiVjfAKjCf4UqSLqS8t8Eur1g4KQZWeuTcsU75Rcac9/czyzjKahnR1GoIWT7ThNBl+FhLQ395
 serfn41OCqcNNOd441Q==
X-Authority-Analysis: v=2.4 cv=OdgNnRTY c=1 sm=1 tr=0 ts=6abb3e33 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=zsL6UFdzHj2bk97dXAQA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX4AWOXi1bslFz
 zfW7JSEIIiyYeiruWR7mS1hAj2E2raC/2Xd5jelPNi8b0BYg4/U3qaA7c2pw1lxWCywP3cALx23
 6tIdOuMX2/JtAiq3SbKoZ+TM1Lg1W5U=
X-Proofpoint-ORIG-GUID: 6BNzQsxHFnMA6eDhUttBXNK2uJfXhLjG
X-Proofpoint-GUID: 6BNzQsxHFnMA6eDhUttBXNK2uJfXhLjG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290017
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

DP MST streams share 64 MTP slots in a time-multiplexed manner. Add
support for calculating the rate governor, slot allocation, and slot
reservation in the DP controller.

Each MST stream can reserve its slots by calling
msm_dp_display_set_stream_info() from its bridge callbacks.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 187 ++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |   4 +
 drivers/gpu/drm/msm/dp/dp_display.c |  13 +++
 drivers/gpu/drm/msm/dp/dp_display.h |   2 +
 4 files changed, 206 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 929e0f94f8dd..02732bd4efa1 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -83,6 +83,7 @@
 #define MR_LINK_PRBS7 0x100
 #define MR_LINK_CUSTOM80 0x200
 #define MR_LINK_TRAINING4  0x40
+#define DP_MAX_TIME_SLOTS 64
 
 enum {
 	DP_TRAINING_NONE,
@@ -119,6 +120,12 @@ struct msm_dp_vc_tu_mapping_table {
 	u8 tu_size_minus1;
 };
 
+struct msm_dp_mst_ch_slot_info {
+	u32 start_slot;
+	u32 tot_slots;
+	u32 pbn;
+};
+
 struct msm_dp_ctrl_private {
 	struct msm_dp_ctrl msm_dp_ctrl;
 	struct drm_device *drm_dev;
@@ -153,6 +160,8 @@ struct msm_dp_ctrl_private {
 	bool link_clks_on;
 	bool stream_clks_on[DP_STREAM_MAX];
 	bool mst_active;
+
+	struct msm_dp_mst_ch_slot_info mst_ch_info[DP_STREAM_MAX];
 };
 
 static inline u32 msm_dp_read_ahb(const struct msm_dp_ctrl_private *ctrl, u32 offset)
@@ -299,6 +308,37 @@ static void msm_dp_ctrl_mst_config(struct msm_dp_ctrl_private *ctrl, bool enable
 	msm_dp_write_link(ctrl, REG_DP_MAINLINK_CTRL, mainlink_ctrl);
 }
 
+static void msm_dp_ctrl_mst_update_timeslot(struct msm_dp_ctrl_private *ctrl,
+					  enum msm_dp_stream_id stream_id, u32 ch_start_slot,
+					  u32 tot_slot_cnt)
+{
+	u32 slot_reg_1 = 0, slot_reg_2 = 0;
+
+	drm_dbg_dp(ctrl->drm_dev, "stream_id %d, start_slot %d, tot_slot %d\n",
+		   stream_id, ch_start_slot, tot_slot_cnt);
+
+	if (ch_start_slot && tot_slot_cnt) {
+		u64 mask = GENMASK_ULL(ch_start_slot + tot_slot_cnt - 2, ch_start_slot - 1);
+
+		slot_reg_1 = mask & 0xFFFFFFFF;
+		slot_reg_2 = (mask >> 32) & 0xFFFFFFFF;
+	}
+
+	msm_dp_write_stream_link(ctrl, stream_id, REG_DP_DP0_TIMESLOT_1_32, slot_reg_1);
+	msm_dp_write_stream_link(ctrl, stream_id, REG_DP_DP0_TIMESLOT_33_63, slot_reg_2);
+}
+
+static void msm_dp_ctrl_update_rg(struct msm_dp_ctrl_private *ctrl,
+				  enum msm_dp_stream_id stream_id, u32 x_int, u32 y_frac_enum)
+{
+	u32 rg = y_frac_enum | (x_int << 16);
+
+	drm_dbg_dp(ctrl->drm_dev, "stream_id: %d x_int:%d y_frac_enum:%d rg:%d\n",
+		   stream_id, x_int, y_frac_enum, rg);
+
+	msm_dp_write_stream_link(ctrl, stream_id, REG_DP_DP0_RG, rg);
+}
+
 /*
  * NOTE: resetting DP controller will also clear any pending HPD related interrupts
  */
@@ -2701,6 +2741,117 @@ static void msm_dp_ctrl_config_msa(struct msm_dp_ctrl_private *ctrl,
 	msm_dp_write_stream_link(ctrl, panel->stream_id, REG_DP_SOFTWARE_NVID, nvid);
 }
 
+/*
+ * Calculate MST Rate Governor parameters x_int and y_frac_enum.
+ *
+ * The RG paces symbol delivery per MTP via: M = x_int + y_frac_enum/256
+ * where M is the target symbol count per MTP across all lanes.
+ *
+ * min_slot_cnt = (pclk * bpp/8) / (lclk * lanes) * 64   -- slots at 1.0x BW
+ * max_slot_cnt = pbn * 54 / (lclk * lanes)               -- slots at PBN limit
+ * raw_target_sc = (min + max) / 2                        -- midpoint (~1.003x)
+ *
+ * Quantize raw_target_sc to 1/(256*lanes) steps, then:
+ *   M           = Chosen_TARGET_Slot_Count * lanes
+ *   x_int       = INT(M)
+ *   y_frac_enum = CEIL(256 * MOD(M, 1))
+ */
+static void msm_dp_ctrl_mst_calculate_rg(struct msm_dp_ctrl_private *ctrl,
+					 struct msm_dp_panel *panel,
+					 u32 *p_x_int, u32 *p_y_frac_enum)
+{
+	u64 min_slot_cnt, max_slot_cnt;
+	u64 raw_target_sc, target_sc_fixp;
+	u64 ts_denom, ts_enum, ts_int;
+	u64 pclk = panel->msm_dp_mode.drm_mode.clock;
+	u64 lclk = 0;
+	u64 lanes = ctrl->link->link_params.num_lanes;
+	u64 bpp = panel->msm_dp_mode.bpp;
+	u64 pbn = ctrl->mst_ch_info[panel->stream_id].pbn;
+	u64 numerator, denominator, temp, temp1, temp2;
+	u32 x_int = 0, y_frac_enum = 0;
+	u64 target_strm_sym, ts_int_fixp, ts_frac_fixp, y_frac_enum_fixp;
+
+	lclk = ctrl->link->link_params.rate;
+
+	/* min_slot_cnt */
+	numerator = pclk * bpp * 64 * 1000;
+	denominator = lclk * lanes * 8 * 1000;
+	min_slot_cnt = drm_fixp_from_fraction(numerator, denominator);
+
+	/* max_slot_cnt */
+	numerator = pbn * 54 * 1000;
+	denominator = lclk * lanes;
+	max_slot_cnt = drm_fixp_from_fraction(numerator, denominator);
+
+	/* raw_target_sc */
+	numerator = max_slot_cnt + min_slot_cnt;
+	denominator = drm_fixp_from_fraction(2, 1);
+	raw_target_sc = drm_fixp_div(numerator, denominator);
+
+	/* target_sc */
+	temp = drm_fixp_from_fraction(256 * lanes, 1);
+	numerator = drm_fixp_mul(raw_target_sc, temp);
+	denominator = drm_fixp_from_fraction(256 * lanes, 1);
+	target_sc_fixp = drm_fixp_div(numerator, denominator);
+
+	ts_enum = 256 * lanes;
+	ts_denom = drm_fixp_from_fraction(256 * lanes, 1);
+	ts_int = drm_fixp2int(target_sc_fixp);
+
+	temp = drm_fixp2int_ceil(raw_target_sc);
+	if (temp != ts_int) {
+		temp = drm_fixp_from_fraction(ts_int, 1);
+		temp1 = raw_target_sc - temp;
+		temp2 = drm_fixp_mul(temp1, ts_denom);
+		ts_enum = drm_fixp2int(temp2);
+	}
+
+	/* target_strm_sym */
+	ts_int_fixp = drm_fixp_from_fraction(ts_int, 1);
+	ts_frac_fixp = drm_fixp_from_fraction(ts_enum, drm_fixp2int(ts_denom));
+	temp = ts_int_fixp + ts_frac_fixp;
+	temp1 = drm_fixp_from_fraction(lanes, 1);
+	target_strm_sym = drm_fixp_mul(temp, temp1);
+
+	/* x_int */
+	x_int = drm_fixp2int(target_strm_sym);
+
+	/* y_enum_frac */
+	temp = drm_fixp_from_fraction(x_int, 1);
+	temp1 = target_strm_sym - temp;
+	temp2 = drm_fixp_from_fraction(256, 1);
+	y_frac_enum_fixp = drm_fixp_mul(temp1, temp2);
+
+	temp1 = drm_fixp2int(y_frac_enum_fixp);
+	temp2 = drm_fixp2int_ceil(y_frac_enum_fixp);
+
+	y_frac_enum = (u32)((temp1 == temp2) ? temp1 : temp1 + 1);
+
+	*p_x_int = x_int;
+	*p_y_frac_enum = y_frac_enum;
+
+	drm_dbg_dp(ctrl->drm_dev, "MST lane_cnt:%llu, rate:%llu x_int:%d, y_frac:%d\n",
+		   lanes, lclk, x_int, y_frac_enum);
+}
+
+static void msm_dp_ctrl_mst_stream_setup(struct msm_dp_ctrl_private *ctrl,
+					 struct msm_dp_panel *panel)
+{
+	u32 x_int, y_frac_enum;
+
+	if (!ctrl->mst_active)
+		return;
+
+	drm_dbg_dp(ctrl->drm_dev, "MST stream channel allocation\n");
+
+	msm_dp_ctrl_mst_timeslot_setup(&ctrl->msm_dp_ctrl);
+
+	msm_dp_ctrl_mst_calculate_rg(ctrl, panel, &x_int, &y_frac_enum);
+
+	msm_dp_ctrl_update_rg(ctrl, panel->stream_id, x_int, y_frac_enum);
+}
+
 int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
 				  struct msm_dp_panel *panel,
 				  bool force_link_train)
@@ -2784,6 +2935,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 	if (!ctrl->mst_active)
 		msm_dp_ctrl_setup_tr_unit(ctrl, panel);
 
+	msm_dp_ctrl_mst_stream_setup(ctrl, panel);
+
 	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
 
 	ret = msm_dp_ctrl_mst_send_act(msm_dp_ctrl, panel);
@@ -2835,6 +2988,40 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
 	phy_power_off(phy);
 }
 
+void msm_dp_ctrl_set_mst_channel_info(struct msm_dp_ctrl *msm_dp_ctrl,
+				      enum msm_dp_stream_id stream_id,
+				      u32 start_slot, u32 tot_slots, u32 pbn)
+{
+	struct msm_dp_ctrl_private *ctrl;
+
+	if (!msm_dp_ctrl || stream_id >= DP_STREAM_MAX) {
+		DRM_ERROR("invalid input\n");
+		return;
+	}
+
+	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
+
+	ctrl->mst_ch_info[stream_id].start_slot = start_slot;
+	ctrl->mst_ch_info[stream_id].tot_slots = tot_slots;
+	ctrl->mst_ch_info[stream_id].pbn = pbn;
+}
+
+void msm_dp_ctrl_mst_timeslot_setup(struct msm_dp_ctrl *msm_dp_ctrl)
+{
+	struct msm_dp_ctrl_private *ctrl;
+	int i;
+
+	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
+
+	if (!ctrl->mst_active)
+		return;
+
+	for (i = DP_STREAM_0; i < ctrl->num_pixel_clks; i++) {
+		msm_dp_ctrl_mst_update_timeslot(ctrl, i, ctrl->mst_ch_info[i].start_slot,
+					      ctrl->mst_ch_info[i].tot_slots);
+	}
+}
+
 irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
 			    struct msm_dp_panel *panel)
 {
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 84ea37d8db2e..e8b445c552f7 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -63,4 +63,8 @@ bool msm_dp_ctrl_stream_clks_on(struct msm_dp_ctrl *dp_ctrl,
 				enum msm_dp_stream_id stream_id);
 int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl,
 			     struct msm_dp_panel *panel);
+void msm_dp_ctrl_mst_timeslot_setup(struct msm_dp_ctrl *msm_dp_ctrl);
+void msm_dp_ctrl_set_mst_channel_info(struct msm_dp_ctrl *msm_dp_ctrl,
+				      enum msm_dp_stream_id stream_id,
+				      u32 start_slot, u32 tot_slots, u32 pbn);
 #endif /* _DP_CTRL_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 0fc2cdcd896e..471803457b14 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -734,6 +734,18 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp,
 	return 0;
 }
 
+int msm_dp_display_set_stream_info(struct msm_dp *msm_dp_display, struct msm_dp_panel *panel,
+				   u32 start_slot, u32 num_slots, u32 pbn)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	msm_dp_ctrl_set_mst_channel_info(dp->ctrl, panel->stream_id, start_slot, num_slots, pbn);
+
+	return 0;
+}
+
 /**
  * msm_dp_display_mode_valid - callback to determine if specified mode is valid
  * @dp: Pointer to dp display structure
@@ -1518,6 +1530,7 @@ void msm_dp_display_atomic_disable(struct msm_dp *dp)
 		return;
 
 	msm_dp_ctrl_push_vcpf(msm_dp_display->ctrl, msm_dp_display->panel);
+	msm_dp_ctrl_mst_timeslot_setup(msm_dp_display->ctrl);
 	msm_dp_ctrl_mst_send_act(msm_dp_display->ctrl, msm_dp_display->panel);
 }
 
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 472429d09200..317c19b809ec 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -43,5 +43,7 @@ void msm_dp_display_atomic_enable(struct msm_dp *dp_display,
 enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
 					       const struct drm_display_info *info,
 					       const struct drm_display_mode *mode);
+int msm_dp_display_set_stream_info(struct msm_dp *msm_dp_display, struct msm_dp_panel *panel,
+				   u32 start_slot, u32 num_slots, u32 pbn);
 
 #endif /* _DP_DISPLAY_H_ */

-- 
2.43.0

