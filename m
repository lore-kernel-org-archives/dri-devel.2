Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0A1F483F3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A09710E3D6;
	Mon, 23 Mar 2026 20:13:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="X4M7XseU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RMcbAVxD";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E1610E3EA
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:25 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHr67i618859
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +O6SQ5BKjVQu9nVs+GvS1a/KUjJBIyvuJGjIVMri3qY=; b=X4M7XseULhnwbuVK
 tMsA7hhB/c/oandTBDGtY7D0nVUGmhDQbcy2nuTmQ8Oj6Ti8dNyFsj3DWUh/Clzg
 UCvw+Rogu5C0wDr6gyMXao5zOe2Kv3kkvO5zct9gRH5CNxzna7xHIlpGi1XoHMDz
 JEwmQEgTRua7oqlsRxF/BlNcFwhTpOKHegolCHL87RhTr8KdGf/IaEg14Nutds4K
 qYQ+GKEiYD8AOl5fa2SGkmxnGB7zmllsjGfmI2KcyCx4rH4m8cKUNNv7N5zNrqaC
 7BUY47NZZje+GmHU8P99M9IO5VIPQ8kpdL/jPyGuS3GK9ZH+oXlsHoW4TE8WIA9V
 tOV8Dw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31jgjkgd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:25 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82a68acce26so355807b3a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 13:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774296804; x=1774901604;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+O6SQ5BKjVQu9nVs+GvS1a/KUjJBIyvuJGjIVMri3qY=;
 b=RMcbAVxDEuOVT3PlkYEw1RmfK/wpB+4z/0xlm2lAXFEGBDg3m6W6u5LPrqm/QfwavR
 64U0sPJ+yoyN8lxdEVD9ruwGalc/HUfGJZCh3lArwsMSRa48FPbTprhkSYajPQVy1Uwo
 1S3ENFH3Lu3GBqAvjVy6/N51tndP/K0cKcOWOZ4vkN0pgQDHn7p68xdfyFZtKWBJ7ipL
 VP7a4X1DTv7YMFmMMl0XQQUxNH3oa8tWJUCi4sru5am3PUaMDoKBPAlZlX3aqmR7to6x
 48mrTE1oO5JqbgnCRVVBzpmI01Y1scU/wSJ0tyG4pcuOYLozl1fxkGug/shHbAFQytx1
 jY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774296804; x=1774901604;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+O6SQ5BKjVQu9nVs+GvS1a/KUjJBIyvuJGjIVMri3qY=;
 b=M6fBk411Byp+vPjt+WTiHp1hp/F6jI/KIfSeqUSqg/eaNAB9lSVAM5bSfnS6crEnj/
 JMHFUZOlupGPgCy8lIfa1Jxn6j40mzzb6TuBkNBDLr3Z9BJzPTp4km8iF9Y0bFis40Aa
 X4V5//Uzy9XZOiqWFO/2YTrLwws6CymQacP8WpMZMCQKz8KJ7Ye3OvgHzKrxfXYa+yGc
 NwqiudyB1euSmVecsXjBxF1hzq75kLZyVoNIr56g7HTYdKKBKeEwvdX6QDsj9Ro+Qo8Z
 aoM3k/FC/MGKzALg7tHm4UIA1E9vobrigwdhH/YqUtubTwe/nZWWGcfGMRgEcno0eB92
 5ddQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGyRU8u1nKdJ9MkltGuFztNGkMfQAB4tuEdKmM6VhEC7CRDI1JQPjCTn6gDG4IrBDy2oScXgQ9oLM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+bBm2TQtirSY08y3jDM8tN5n0CGdHU8c4aO0+W1viepMhvwgr
 FWX39ecPTr4d8MjUoy7FBnmPO5j/qVMBsPSDjIiaGAAz0LdMc7vgDlXiPnYgFKhr93FgwNInlIB
 w69giNhvnpDqK5YMixQdEnN2N8uCAO8101o5BV9/9Uq8rkGnEUxZaPL+/5hfqNyn7c9GO9lA=
X-Gm-Gg: ATEYQzzMwPXnEGzJkd8uBPFvNqXA6rMvcqVcadzdaH1ZJMAO7OxbwT+0koVbiDPzZFI
 wxeEwBTgqKO0rKfuGUIFPSyXK8vmdmfs6wPz431i2lO6n9rST08E99u9nSrICL16df25WUl2PgB
 mlGGLzGy4yiZpb5wbiKXaYeJIp2mvemSrPZmy3UhvQrCoYOWYfulcilz65oJ5dTBVWa/wtfrub0
 ACy3Y5diKaAhWA/vpQC/K6WvtMr780KVP+ek2Uq6WmMhtqevluYnPRMkKYK5VKymPjf7S6hRC0I
 rtXLhwKHinL0d3ET/G7BfkaFYIRBM7PCwYlwun8ooLgwUesOJ4JGawfbxAmWfRO5Lc6LgqzBoGL
 alB4I8pKAVvIf7d/ulmIqhuwf+BhfxoKb/su4JUDNKFWtVw==
X-Received: by 2002:a05:6a00:1a89:b0:823:1d10:cf04 with SMTP id
 d2e1a72fcca58-82a8c3b88cbmr10947681b3a.55.1774296804315; 
 Mon, 23 Mar 2026 13:13:24 -0700 (PDT)
X-Received: by 2002:a05:6a00:1a89:b0:823:1d10:cf04 with SMTP id
 d2e1a72fcca58-82a8c3b88cbmr10947651b3a.55.1774296803779; 
 Mon, 23 Mar 2026 13:13:23 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0409d148sm9510738b3a.29.2026.03.23.13.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:13:23 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 01:42:20 +0530
Subject: [PATCH 08/16] drm/msm/a6xx: Update HFI definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-a8xx-gpu-batch2-v1-8-fc95b8d9c017@oss.qualcomm.com>
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774296753; l=5252;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=4zxAWIYbFGPJZdqzNURHE7IGPmYkkyOAYwc4ePuq8iY=;
 b=a2Dz3Y6fr4jNZCH89Aek/iMsncePcji5TDTxjTMHmuU0EsB5iXbHSJaDp22+jrOYoWLH5zUN7
 lj4JNars1x7CwhdiPOLG0SbUDOiZniv4z97wG9eBVf9BNa2LpXmLjVt
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: E0rAqrfwy0CNg9k5hjBt20rGazo4xFO8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0OSBTYWx0ZWRfX8lsq6JIB9fBp
 yE4inRJWSU7D2LT18nj3nS5gn70/2biSLdojo8IOPLbfZrmvbACaevBNWF0TgMJzeZ3xZgBW51B
 MH05FRwMemdWlqEKzEa54gKGpSu9uMiJJsFr/n8ef3S7td9Ks6tY3IVbE7yp/ZGeACgSgwUgI/t
 bEBVF6xdEDNfC+sBxVQs8iS1I2LO9LwTlKFf17UVFs74+ZJ5VPKivYpIsr9TOgOkrloXZO62tDH
 ZpyAWKbX7sbutcAMyc9fU06WQCE5WDlFQrqx6z8a3JWbcYwvg3j3mwTLhAR952XaMipvf2OCyA4
 EWTbfAOIPpHBsWWksfxZKzVls2aP1LzIbjfYlttqgmpm/HPWZwY8WBWzGulUw6lz65sj7FPgqtY
 LZT72OOggTVU1vYbM6qfU6hpoeGkCKlojRvWrPbobWAB5pK5DC+rfckAJJncvGCs0t86Myi8CRX
 fxsYYSL33oFavaow5cA==
X-Authority-Analysis: v=2.4 cv=CMInnBrD c=1 sm=1 tr=0 ts=69c19ee5 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=wp9Eiz2YcQHRIHTaYAUA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: E0rAqrfwy0CNg9k5hjBt20rGazo4xFO8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230149
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
index aef00c2dd137..d613bf00e3f8 100644
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
index 217708b03f6f..917b9c9e9906 100644
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
+	/**
+	 * @mode: BIT[0]: 0 = (static) throttle to fixed sid level
+	 *                1 = (dynamic) throttle to sid lievel calculated by HW
+	 *        BIT[1]: 0 = Mx
+	 *                1 = Bx
+	 */
+	u32 mode;
+	u32 sid;
+	/** @mit_time: mitigation time in microseconds */
+	u32 mit_time;
+	/** @curr_limit: Max current in mA during mitigation */
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

