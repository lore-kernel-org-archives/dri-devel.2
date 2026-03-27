Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32B610AB82F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 00:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20D5D10EB6F;
	Fri, 27 Mar 2026 00:15:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ccs3gzHv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SuPnbi5k";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2669110EC1D
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:33 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QNb5Wr334208
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YUhadNcE6d+rm8/73vxtaIMsY1zh3Qjnoy8Bpem4KcU=; b=ccs3gzHv8EVZASao
 xURN9WiI+9xTCT+fNNvWRzXcv0Ra4gLEIsPUYTCOF0I4MbWYxR2Lxc4kIBj/T38C
 T9JPhNOa0cGkRQ0+69TcPTWSa5hXqqPgXDSVTQ4EdyjVOOVrL3mCN9TbnouQ7cGT
 Mqg4eyKzhzy/+xPDsXNeqW+/mxru+W/zGl5wrI91FxVr9z+RNsSLUrbNJOCwlgs9
 49SbEJSzSfmuTXVZVDI7fWKh/PvPLoieHHszYiyzYG4IuWzGGclhvB0DYBm+1LCl
 ZqKJaIsFaJYeZOvOkXpmJ5X/RpCLGqCHmL9uigN/u4qqKeeD+Xyg4kNMUx98kRVB
 2TnpKA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d527ytuwy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b06b68783dso18466375ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774570531; x=1775175331;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YUhadNcE6d+rm8/73vxtaIMsY1zh3Qjnoy8Bpem4KcU=;
 b=SuPnbi5k89ZV6AUSHGEx3CnP1QrqIS1IF6+TIl3iNI4z8QTX/JTU9BwRciNLRKAF7G
 k7irGi4zOZZJrW5B/wDlwd2jquddwHjfKauBLUcqGAql8azd7wwu/t7r55t163NDoAvt
 3kPOJhkIwJduWES4V/Co4zbH4B3DTRVNkzOGizg3+vzVccoFlc8GR6Ix15FjgdMLjrKy
 eixtXT2qNJM2TweUqzRwxDcCJRoizz7x7btBWYtxeoGeDVDYwoEOcP1SCxOaHzgcwn1d
 XDbrXUgOeUIuDhTzteQlnxNi1VlVQ2NMIhtDYBHvSLZm4vq1SveNcr/OovxqMiq2j1uB
 DYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774570531; x=1775175331;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YUhadNcE6d+rm8/73vxtaIMsY1zh3Qjnoy8Bpem4KcU=;
 b=XwRByjoVKbHofIANKO9BMgiqp3zhgjD8YvaZolXgKaUn3kHmLhsxALuzjosZga++Lm
 BJTDgWmz/RmgW6Ow3M4OYku49WgnrNYHV4GYTBE/+GbcKy2MHT4ofdhiE0KgCc3D6EEo
 snzVF7KGL6ym00J/K54p0iKBjPR0r55CQvrvkroYuwoOuQ9+cLhr5gR91wNvDd0ethAw
 TUHiEKVK0TL30NrUzdqM1Vng4SUkNV7cF7N+1QqCgT/JWzO6+4e3ia/BA8Gnq1guXc1F
 sxh09qxFLY9L/eayiLUAd8XupLZuir/BFBJZH8SDEpH1Ga01zwUIetq6DbFpZ6ArVxep
 oUUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv/UBFrfwIYt2E2FCPSVqXuCeSTV/kQDRrwYeBo0Q5TeujP0W5Ga8ZCft/0hy82wyEYkeKGfrkAUo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygbaJeVI5+50z+AlExwZ/svKZiDF3dRQWAu6qHs13Wfy7KVpaW
 6/4xXaOCfOI+Z2nYLej34fX/YOYu2LBkGfUV76tEGzgovKZdSn+ZxCxI8Bj975m2bfRZ82465aB
 /mNgPao7PUSzdrhyZBYBf4qN5XgcYik8KyL2NEMpWUbtXDHQpLzY3+NMRXYZZ5vT4X97QOXo=
X-Gm-Gg: ATEYQzynL6G4r+3akAsSCrN8yB1g+n2UaqYlSLKq8dozkENv5CpdOWAcPz4UWe43Oce
 5zzkIXevwAjnfBAsXVf+iyzXtd2CsIwWZO4cI9V6aDaLGLH5zUeHNeVe2eFbYMwx6n7LjxN7YCv
 aBcd0fPzmKI1F/DeArQc9XXjAcSxzHqWdJDCik1wOd8dAApVQgnQ/uYaNUv+nl0ZNXai8Cs5zr2
 /mAWiT+1jWqH4Yz2ktxq+6Xt0n3f7VEoRGey6DyYpQfrI1uXICYic8SxEAQUhGqH64I/UwQxpnf
 X1gVkx0ltrtvtEipyatjEYmewEVR5k+CnPd6j85k13sWJyU/NLjityvVH9CspqkQl9O4jPhBKcd
 VDt4ENR1+aJJWaJc7Kp9iohl09JNhywtl6dQ/bo7wF/5zOg==
X-Received: by 2002:a17:90b:4b0e:b0:359:8e5e:43de with SMTP id
 98e67ed59e1d1-35c300c19d2mr460802a91.22.1774570531265; 
 Thu, 26 Mar 2026 17:15:31 -0700 (PDT)
X-Received: by 2002:a17:90b:4b0e:b0:359:8e5e:43de with SMTP id
 98e67ed59e1d1-35c300c19d2mr460749a91.22.1774570530658; 
 Thu, 26 Mar 2026 17:15:30 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c2ec799eesm163155a91.10.2026.03.26.17.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 17:15:30 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 05:43:59 +0530
Subject: [PATCH v2 10/17] drm/msm/a6xx: Update HFI definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-a8xx-gpu-batch2-v2-10-2b53c38d2101@oss.qualcomm.com>
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
In-Reply-To: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774570466; l=5196;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=JC2wxvFzu+YVvl5T0xRJcUHR8veH92d6X32XhMscyIE=;
 b=JfyoEHjVEiM+OKcG5KAOjJ4wfNMvZWfIxYdQ7OxK+rhR+1eRE5YmYHC5XBPjYD+JE1TwA4s3i
 4MuSQKKzNf+AnA4raB8hBXYwkHth996CsBQKczTafOu5xvOePEC8Ytc
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=dLurWeZb c=1 sm=1 tr=0 ts=69c5cc24 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=wp9Eiz2YcQHRIHTaYAUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: Key9BPkRxOa3Qoigp51AhV0iqwpbE8Di
X-Proofpoint-GUID: Key9BPkRxOa3Qoigp51AhV0iqwpbE8Di
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAwMCBTYWx0ZWRfXzWUR/KhYlUAI
 778FXIAO9WMHAj0SP7AGC/zy+00JsDLqrLq52vZxSjcNTQIxRkBIVpHNFX5EJtrQ22iOw42HFle
 Hxiu1CETTm0XV4nTmbgK/mcFagwL6ncN/6s2U14V9G1iVYO4MGMFAnaDW//dkV2fl1VoUihOuxq
 piAsiIVm+ASclM/KcUAKvaAPKv2LmttNCTj8mFzyE2d07zOuf1xHul7/JaKWM+kkfYMgwFLJ9yL
 GgmQZn/7fpqBb/gwL4fGc3rOVc1gKy0rh89g0gZxAeMGmLV6LMMcmIUnyYrLWmEqJE+gD2lz03d
 GBNjT2mWXC1A+wzekNuwlYWGZa6mWIDP+hYKtO8X99FXdMSmlBPusDeJXPiQuqzfBBcE6JZs8sN
 ifePqg7ewfbFGV02jrkp+SXxRKbT3h9tbJ3EhXLJhEy8Ycx/wI2Gz1GcBQiAlkeOpJjprfpXP2W
 BYvtxL3RHQDzUNRjYYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270000
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

Update the HFI definitions to support additional GMU based power
features.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c |   3 -
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h | 113 +++++++++++++++++++++++++++++++++-
 2 files changed, 111 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index 09b6bc464b47..487c2736f2b3 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -851,7 +851,6 @@ static int a6xx_hfi_feature_ctrl_msg(struct a6xx_gmu *gmu, u32 feature, u32 enab
 	return a6xx_hfi_send_msg(gmu, HFI_H2F_FEATURE_CTRL, &msg, sizeof(msg), NULL, 0);
 }
 
-#define HFI_FEATURE_IFPC 9
 #define IFPC_LONG_HYST 0x1680
 
 static int a6xx_hfi_enable_ifpc(struct a6xx_gmu *gmu)
@@ -862,8 +861,6 @@ static int a6xx_hfi_enable_ifpc(struct a6xx_gmu *gmu)
 	return a6xx_hfi_feature_ctrl_msg(gmu, HFI_FEATURE_IFPC, 1, IFPC_LONG_HYST);
 }
 
-#define HFI_FEATURE_ACD 12
-
 static int a6xx_hfi_enable_acd(struct a6xx_gmu *gmu)
 {
 	struct a6xx_hfi_acd_table *acd_table = &gmu->acd_table;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
index 217708b03f6f..e10d32ce93e0 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
@@ -165,6 +165,42 @@ struct a6xx_hfi_acd_table {
 	u32 data[16 * MAX_ACD_STRIDE];
 } __packed;
 
+#define CLX_DATA(irated, num_phases, clx_path, extd_intf) \
+	((extd_intf << 29) |				  \
+	 (clx_path << 28) |				  \
+	 (num_phases << 22) |				  \
+	 (irated << 16))
+
+struct a6xx_hfi_clx_domain_v2 {
+	/**
+	 * @data: BITS[0:15]  Migration time
+	 *        BITS[16:21] Current rating
+	 *        BITS[22:27] Phases for domain
+	 *        BITS[28:28] Path notification
+	 *        BITS[29:31] Extra features
+	 */
+	u32 data;
+	/** @clxt: CLX time in microseconds */
+	u32 clxt;
+	/** @clxh: CLH time in microseconds */
+	u32 clxh;
+	/** @urg_mode: Urgent HW throttle mode of operation */
+	u32 urg_mode;
+	/** @lkg_en: Enable leakage current estimate */
+	u32 lkg_en;
+	/** curr_budget: Current Budget */
+	u32 curr_budget;
+} __packed;
+
+#define HFI_H2F_MSG_CLX_TBL 8
+
+#define MAX_CLX_DOMAINS 2
+struct a6xx_hfi_clx_table_v2_cmd {
+	u32 hdr;
+	u32 version;
+	struct a6xx_hfi_clx_domain_v2 domain[MAX_CLX_DOMAINS];
+} __packed;
+
 #define HFI_H2F_MSG_START 10
 
 struct a6xx_hfi_msg_start {
@@ -176,6 +212,41 @@ struct a6xx_hfi_msg_start {
 struct a6xx_hfi_msg_feature_ctrl {
 	u32 header;
 	u32 feature;
+#define HFI_FEATURE_DCVS		0
+#define HFI_FEATURE_HWSCHED		1
+#define HFI_FEATURE_PREEMPTION		2
+#define HFI_FEATURE_CLOCKS_ON		3
+#define HFI_FEATURE_BUS_ON		4
+#define HFI_FEATURE_RAIL_ON		5
+#define HFI_FEATURE_HWCG		6
+#define HFI_FEATURE_LM			7
+#define HFI_FEATURE_THROTTLE		8
+#define HFI_FEATURE_IFPC		9
+#define HFI_FEATURE_NAP			10
+#define HFI_FEATURE_BCL			11
+#define HFI_FEATURE_ACD			12
+#define HFI_FEATURE_DIDT		13
+#define HFI_FEATURE_DEPRECATED		14
+#define HFI_FEATURE_CB			15
+#define HFI_FEATURE_KPROF		16
+#define HFI_FEATURE_BAIL_OUT_TIMER	17
+#define HFI_FEATURE_GMU_STATS		18
+#define HFI_FEATURE_DBQ			19
+#define HFI_FEATURE_MINBW		20
+#define HFI_FEATURE_CLX			21
+#define HFI_FEATURE_LSR			23
+#define HFI_FEATURE_LPAC		24
+#define HFI_FEATURE_HW_FENCE		25
+#define HFI_FEATURE_PERF_NORETAIN	26
+#define HFI_FEATURE_DMS			27
+#define HFI_FEATURE_THERMAL		28
+#define HFI_FEATURE_AQE			29
+#define HFI_FEATURE_TDCVS		30
+#define HFI_FEATURE_DCE			31
+#define HFI_FEATURE_IFF_PCLX		32
+#define HFI_FEATURE_SOFT_RESET		0x10000001
+#define HFI_FEATURE_DCVS_PROFILE	0x10000002
+#define HFI_FEATURE_FAST_CTX_DESTROY	0x10000003
 	u32 enable;
 	u32 data;
 } __packed;
@@ -199,8 +270,17 @@ struct a6xx_hfi_table {
 	u32 header;
 	u32 version;
 	u32 type;
-#define HFI_TABLE_BW_VOTE 0
-#define HFI_TABLE_GPU_PERF 1
+#define HFI_TABLE_BW_VOTE	0
+#define HFI_TABLE_GPU_PERF	1
+#define HFI_TABLE_DIDT		2
+#define HFI_TABLE_ACD		3
+#define HFI_TABLE_CLX_V1	4 /* Unused */
+#define HFI_TABLE_CLX_V2	5
+#define HFI_TABLE_THERM		6
+#define HFI_TABLE_DCVS		7
+#define HFI_TABLE_SYS_TIME	8
+#define HFI_TABLE_GMU_DCVS	9
+#define HFI_TABLE_LIMITS_MIT	10
 	struct a6xx_hfi_table_entry entry[];
 } __packed;
 
@@ -226,4 +306,33 @@ struct a6xx_hfi_prep_slumber_cmd {
 	u32 freq;
 } __packed;
 
+struct a6xx_hfi_limits_cfg {
+	u32 enable;
+	u32 msg_path;
+	u32 lkg_en;
+	/*
+	 * BIT[0]: 0 = (static) throttle to fixed sid level
+	 *         1 = (dynamic) throttle to sid level calculated by HW
+	 * BIT[1]: 0 = Mx
+	 *         1 = Bx
+	 */
+	u32 mode;
+	u32 sid;
+	/* Mitigation time in microseconds */
+	u32 mit_time;
+	/* Max current in mA during mitigation */
+	u32 curr_limit;
+} __packed;
+
+struct a6xx_hfi_limits_tbl {
+	u8 feature_id;
+#define GMU_MIT_IFF  0
+#define GMU_MIT_PCLX 1
+	u8 domain;
+#define GMU_GX_DOMAIN 0
+#define GMU_MX_DOMAIN 1
+	u16 feature_rev;
+	struct a6xx_hfi_limits_cfg cfg;
+} __packed;
+
 #endif

-- 
2.51.0

