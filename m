Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2BCC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C6DB10E85A;
	Tue, 28 Jul 2026 10:22:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hY3Nuz7D";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hf2I8vJl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC16910E868
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:05 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S81w2J2071267
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7uzgE+rC267u8jTFEY8TUSnxJvWKuyiy7mmko8m7xjM=; b=hY3Nuz7DRXx/DQee
 FwOP8TU9mXi5X5rejLbNEb67CNxwYGEMSb2swVafPRpsXmoMNsl+OguvotUnffR1
 OZVWetz8pskjytw7KXsAdJr5AAWR74ljcE8hUmcsLu45RIsaDuoAcRA3DZWrDsVf
 lntPjwYrLAJp4kaDuV5Do1uoC+vWll+LfQmZ0yag2ruYAGveZOX9MXbNljqrSwHz
 gWZcwwbwT/vfnYNicMNpy0olHIQ+NV5uxIDr/HMnrEfsH/voWy34EjUolURXlzaK
 S8FrqNy7rpQGfMIFtJHopf4tiSxeDMmT2l0db3fVTnbYojCPjcdpPhgmWqzjLoJY
 TG28bA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpqxjgqjg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:05 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8fdace20927so39183586d6.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 03:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785234124; x=1785838924;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7uzgE+rC267u8jTFEY8TUSnxJvWKuyiy7mmko8m7xjM=;
 b=hf2I8vJlqSX/HuvneGiCq3IIVJaPgU9mz9kzx1Nkw4OuhEDn1t9ZXovOLqPw9r2BG8
 tAz8+HGDcYW7YlUhz4BXAt+wL1HS6pbijz+v+XIqAigUoMxv9HcBTNa/7vNvC8wuRFto
 3BZPx5FplxgHIUt2nRy9qKcHg9ZcQQFhTYdJxDwLAuKkqCLBxG1a1yaDIlNhy70FENzg
 WQDbxrcD5B18z9MYvfMvpJ24i93VbwIrql7LYYQ/1GZEYSvw4xxKb+sZW0lzf/Pqlqyu
 NdTPicHKNC0a1326TeT1dA/9EKN2QIK7YTZWkLqqd4E3PxbfyeSZz8nrybV5yNHeTo1B
 HTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785234124; x=1785838924;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7uzgE+rC267u8jTFEY8TUSnxJvWKuyiy7mmko8m7xjM=;
 b=Ygc0nZpDMBW9jvQITbxwchUvkhNZf+nONKC4bJLGfDuuIOVvV3ymiEQChz95UE0lww
 nH6EsDRQkttG3UqxCNzZbwgLY+LLjNBZZhnjt8YemGOyGjRtvEELFLVBhXuxAl3bN9mS
 mgZ6H4UVdMJszIb2mvPJotjIZ4ivz1vpdndOTfUHIOzPL1OiAQssrno2WYhPiigiOlis
 plsXVwB5vqTMStBamwp5nWYpse5qi652upjqu+vQdMunI23orFMSGQzooaxF2ZH+ARfp
 b4X66rjdJqbaL+Uy6S+bXjY4ejg9n3IarBsrf5VsoC0CH2x/ecEdKtU3jal0M8RaRI5F
 CXsQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXHrkcTboM5eAayvP01S39QBOCKdluMHzzATPgHigvZQV9lpzp9f2GvkBTiWqkSetVSTs6PIJfJsI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+9kCWEbv5ZgJGdYcE6r9Wa1DqiDC2/WYXJ7i+Hkc9QZgwK2JE
 ZEv01D07+ajp9MMFNppaqCpAe05DYsXml5rvtBk0BiAppb7B/2r5rTSG/62T2CwjDb1BK4NqVch
 UfGZt0Ijv3N6OngI6FTP/tsdKRT6U+S8bzbygb5FAjETZprIfs3EpqF/vYErhsDgKtU6DoKY=
X-Gm-Gg: AR+sD11dttenyO/pWTWVEaPSMGF2FRKfTM35wE/aSFEYheMS1fUfrN5sM948QQhveGG
 dTy7Sz02J2KpQpCZ443jv3Sc42RJT4foL3Of8vkImwYcO6XkmYgsWbg+CHaZtMkxZDq/3vHMBHG
 ZvqyikejKNELPzl3S/WS4jnG42ufkOzw7q4N0u/IvT0U1mSQ1hovuHG0AkSakRd4nG1SXdKY/tM
 5TTw7ui/mAfwQPyqvMXmdWxAIHNOZu+283y7BVZKXFwA0sD83E6u/mSwumvJGZt0YgFZOqsvol7
 OoVelk6Y35LJa8B3JKPUuYXPgAxand5FXO3DRhh6HErAkrvXYtCI+bHDGTk8JXxSi43s3EMT+wy
 OFnTypAB4lfUaCm06aj3oadXOwbbck6rS9PUx52m36m+dMF2TUN29ASwEFv8BCU8=
X-Received: by 2002:a05:6214:3bc5:b0:8f0:47b2:5734 with SMTP id
 6a1803df08f44-90816f63bdemr16685476d6.7.1785234124224; 
 Tue, 28 Jul 2026 03:22:04 -0700 (PDT)
X-Received: by 2002:a05:6214:3bc5:b0:8f0:47b2:5734 with SMTP id
 6a1803df08f44-90816f63bdemr16685216d6.7.1785234123742; 
 Tue, 28 Jul 2026 03:22:03 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907e869ba73sm84791396d6.25.2026.07.28.03.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 03:22:03 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 18:21:34 +0800
Subject: [PATCH v9 05/14] drm/msm/dp: extract MISC1_MISC0 configuration
 into a separate function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-dp_mstclean-v9-5-f7779fce10f4@oss.qualcomm.com>
References: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
In-Reply-To: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785234095; l=2097;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=WPiichk/g/c4Wd3ZWxdK0RvBoQIuZsodOORMITxa0PM=;
 b=NUYtIo561adU4Crsh9D8P1fdJiHYO4kA7cyxobyq6fL61DDl8pAZo8k34UCNHVYQUXVlTZFEF
 Lv4KxKimNNCAM7KNx1RszRos5xW2NGeZVyVN3XdcE+G3HxxHAkIJwYL
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: YFyOmWpSvsLS6zY6OIO30D72WiiXUE5e
X-Authority-Analysis: v=2.4 cv=MORQXsZl c=1 sm=1 tr=0 ts=6a6882cd cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=8CyK55zjPCZzEff5TxcA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5MSBTYWx0ZWRfX/8JCz6Sj13Kv
 EoSD1dvRASeJhteA+UDViJ3n+iMXajHcOM1ivK0c6JgkOOX13vq7bK93KOdJdwNSbXSN8hbFNdc
 aobh9/iDlNr4g6Po5QzeUozCS5Ldc0Y=
X-Proofpoint-ORIG-GUID: YFyOmWpSvsLS6zY6OIO30D72WiiXUE5e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5MSBTYWx0ZWRfX8bgUkYPDTpT+
 +xYj8PEmJrXyv+KAxLLOC5ONAErHbDeTcUmQNhbT2ArZ7+CZxCD3TXNc6EDVQ4TnDnMbyR5sqqJ
 yw9CRAolESyX3wYnBfWUtAEq7CLXuRM1k5z8HfGvw+KK6Z0gksluTPsV10zAvcxLEbUVxa1MuEV
 q2FXyGh+e9a5gfOrRLnTqJArqHEntvuJNDT2TdZW6hVo1m2oYu4SsHFAL1P5WDqtLg/hS0o5mbs
 H7tXu8CA5J1+ipkNMWe0kNDVWANTAy0xw+97izhMgHle2DcCq4iA1z8ICQuG2eNHbimZJ7VAaHV
 j/vWs8Lw0ysdEpKvMDV9UDvAHOWQSGqJp1414oQqw+QtmReEFi5S2BI2t3V1wIZti8gf4O0ydGF
 f763JcgBxXtgU9P5Jb1sr/hQnHESafwG5EkdchewFAPH8mkmxrtXoNh8+5Ov1Bhwd9IJh0WMKJl
 0gFkaEGjN7FDVGEik6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280091
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

Refactor the MISC1_MISC0 register configuration into a standalone helper
function to support MST.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 7c0649d5318f..c557e0f01dc6 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -462,17 +462,13 @@ static void msm_dp_ctrl_lane_mapping(struct msm_dp_ctrl_private *ctrl)
 			ln_mapping);
 }
 
-static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
+static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
+					   struct msm_dp_panel *msm_dp_panel)
 {
 	u32 colorimetry_cfg, test_bits_depth, misc_val;
 
-	msm_dp_ctrl_lane_mapping(ctrl);
-	msm_dp_setup_peripheral_flush(ctrl);
-
-	msm_dp_ctrl_config_ctrl_link(ctrl);
-	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
-
-	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link, ctrl->panel->msm_dp_mode.bpp);
+	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link,
+							  msm_dp_panel->msm_dp_mode.bpp);
 	colorimetry_cfg = msm_dp_link_get_colorimetry_config(ctrl->link);
 
 	misc_val = msm_dp_read_link(ctrl, REG_DP_MISC1_MISC0);
@@ -486,6 +482,17 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
 
 	drm_dbg_dp(ctrl->drm_dev, "misc settings = 0x%x\n", misc_val);
 	msm_dp_write_link(ctrl, REG_DP_MISC1_MISC0, misc_val);
+}
+
+static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
+{
+	msm_dp_ctrl_lane_mapping(ctrl);
+	msm_dp_setup_peripheral_flush(ctrl);
+
+	msm_dp_ctrl_config_ctrl_link(ctrl);
+	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
+
+	msm_dp_ctrl_config_misc1_misc0(ctrl, ctrl->panel);
 
 	msm_dp_panel_timing_cfg(ctrl->panel, ctrl->msm_dp_ctrl.wide_bus_en);
 }

-- 
2.43.0

