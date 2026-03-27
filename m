Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E2C10AB82F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 00:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AEDD10EB0D;
	Fri, 27 Mar 2026 00:15:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="I1iQnVTu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aGUaDn/m";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F01F10EB0D
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:28 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QIenTs3341871
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 saJ7Utd8t6mFeiP8csyuhBkVXNGBrgBMuOZHTEwxtIg=; b=I1iQnVTuAgVNNIs8
 psTxdsIaYIkohScy1kIdhDVaNiEmUDrvdBU07G48U1DVC+doyZRasM8OUumr6RWM
 VeLoKJPbXhtZ6IYXtUfhMeCid7E66ovovRpWYL5cm4qlonRyUknXAxvdj7U+xjW7
 hMUELGDjX6zOoF4bvzfRfyfrGzv+iYzGraFnHpJmDOJImGbZg4nh9d3JaJi2YQhv
 4T/FUVbsdlMrKo5lDAQoHvHEgjlcT3hjQ9log31zDVQSpM8CD5afp1n1xCiXS+fK
 MlYzumUhG4aZQgcfNsnGBBsy/ua1gF80Ml4cifa4cPMb0t77l/WlSfHsQ4D1dceK
 +Up8iw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5a9q0vxk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35845fcf0f5so2065040a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774570527; x=1775175327;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=saJ7Utd8t6mFeiP8csyuhBkVXNGBrgBMuOZHTEwxtIg=;
 b=aGUaDn/mTMZ80vPCBFcUstMIIyVDlBVhnLIKWLa+u/jR63tMSHrYrFeNkRxnrQhNrZ
 Tzg1n3SXv3N3DuMhabPGzqQHYFmwDdF/8alDEc003LmPdL/2rd2q16IHQjo/tZFRh/0F
 b7UZHOlM2wG7W/GpZ20hWRSOHGfby3eCZYT1smCpr9YhCoXFKTCOuzYUaD5WowhCt7jc
 zaw8RZtCDXWSqskalcP0HNYuwziV0R2hgg/HnBj090lCpxkHoZP7h+PDoiguEX0RNSyW
 S0OoNNdtilgqDzkXr3e5yvlaBsAP/0n9E7uK6sYmdX3DF/dr/20Wari61Nc0C3eYPeGI
 T7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774570527; x=1775175327;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=saJ7Utd8t6mFeiP8csyuhBkVXNGBrgBMuOZHTEwxtIg=;
 b=X5u6LJHPwudusimKkv6LMK1+XiHwXA0blDe5UbxumnicMmOEFVDjqpzLKDlAmEaWlJ
 bgIm4GSyoD6hKBtxJnd/R1zvFgsWDQ/HOvFeTaVjl3rtAukf//7UHcY68fnVw+YMDfeT
 2RMJ6d98i2GP1Ctey6tuIDTABfRu0VbIvBvb6ebW/oHM5BnhpIpCaFhY41jImjOXumMo
 Y8Ps6O3FT6qS7Suz3unhcc1AaPZQ5IxQHTMWBjbdkKqR+TSlmJn9GTtSpVnnQo39FT21
 M5Q2Escb5WxPzFfyWSjSZDP1iFwTTcY8E4D24Oo7XOqif3VHBDhN0XKNuO0EsKrbrXJZ
 EOig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAZ64Trpu5rOuwGDQZ2sclsQmJ3XZV9Gq8IPIUW6OUvzdT0p8XU0RQUQDUaJtIBUiEVblAudg5bx8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQYffTApV3pYKuyhbbK/699G0pK9Agu0Xsq5ujBNonj5fIrSty
 2VBXVw4bmpjqPkeb+aaOzFfSyaCASeeI0hmDR+fNGDR/99ktEC9FhdNYgJvf6wnwLdp5F2m11a2
 NYtYEXlo+eK3xs5d+UJY/dJvzMVRb3qdqL2coRBwE4rxTC4s5J3uuVahT6UHUd3qtYtrtj3A=
X-Gm-Gg: ATEYQzyotyocABrlNZkpJJjtpG+y7hy7bnyhApOC4YmFIJ2b59lHAotb361TpZDMHVr
 DUIHSE/OMfoZnRW8MjEaCmi77X0tQoa5UhEnjKCrOKk+fL0Vy/5qEL3qBN24PYtAqCjk7Sesj9w
 1EjixrfGI2pqMHzxAUDvcYaXqZSL/PC+c3vySihUjgTgri6kc2RlmT1E6Qk/p1HTx9JGvR5KlTh
 O+gMW6nrLM6hJLEBb+HVgGsKiEu8g6mj3yoH4uO0+aM7PE2N1hZBUKCgyCH4PgBOSKT8MU/Y8jp
 UVwPrabInP5SFlKycEs+cCqwzLqLQNQkay18AcabplcMEhi+Mi3BlOCcngxUxh3K5BlNkTW5mr5
 74/btrbIbQzAGz8Zq1W6EKk+dzYOVkCPpE8iY3XfnAyVbNA==
X-Received: by 2002:a17:90b:3c0c:b0:359:85b0:4023 with SMTP id
 98e67ed59e1d1-35c30e090b0mr195797a91.16.1774570525404; 
 Thu, 26 Mar 2026 17:15:25 -0700 (PDT)
X-Received: by 2002:a17:90b:3c0c:b0:359:85b0:4023 with SMTP id
 98e67ed59e1d1-35c30e090b0mr195773a91.16.1774570524866; 
 Thu, 26 Mar 2026 17:15:24 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c2ec799eesm163155a91.10.2026.03.26.17.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 17:15:24 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 05:43:58 +0530
Subject: [PATCH v2 09/17] drm/msm/a6xx: Use packed structs for HFI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-a8xx-gpu-batch2-v2-9-2b53c38d2101@oss.qualcomm.com>
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
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774570466; l=3961;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=N4kCetZH2HDTf/FdvbViMjUNsCitiWXOOSAJsJSRvT0=;
 b=PkRqHaDv/tazcfoBKv78PInYJbYNQ1ikGld9XVE1uh7mnf8ElZ8qG6+tWTgA8FYz3/lBI09PO
 QLiacQkGVLeA9cOPvyL0yM+mu8fIlD6dTJyKQl32YPmfZkC/37wExdZ
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: d_2GVryeTx9kTqEvaUXPA3SQ-nLkp3AY
X-Proofpoint-ORIG-GUID: d_2GVryeTx9kTqEvaUXPA3SQ-nLkp3AY
X-Authority-Analysis: v=2.4 cv=J4GnLQnS c=1 sm=1 tr=0 ts=69c5cc1f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ArFqxpKCfli7nxZMP-sA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAwMCBTYWx0ZWRfXw9alE++ay6V+
 8vbV7quE2EQB8nuHzdvr29YTPX8ttBMPm1+0+OK9VWID6HO6abMmi7bl5NU5aGb9EplaxHdqsVZ
 fQNsbRCZZQNXcIoPx1yMyyH99b5a34pql2L9FgkocRhoz9yFv3QG+1umihC9cdclRmS/M5txLSP
 ZbX1VwdjjljNi48pLfaKqkmKl2bCUE2E5oPfbF6KHgtObXsNzo/nXuWGIQm8zqBITdufK1OSuOK
 dmU2qN8X5RAb5EtI0XmXAdtIzvNYVp2sdlsP7jhu3qS78lQEiXZQqEl7SqThj/g2Ztezy/eca39
 vmaZmoO3gsSjD5SKsVC8ac22KkFX1uKG6fhPID0VsAYo1NSafUBa6XItaJlccH5z0hYjEK1EQ6b
 PlbJtCRxaKqj9p989tsctBOekeBixrOJZKyKUOp0LMBiCN5gC2Z+9v1tM6aoHDflYUOCsgQATF8
 EjQi7tPRCFTx8E3lTSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270000
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

HFI related structs define the ABI between the KMD and the GMU firmware.
So, use packed structures to avoid unintended compiler inserted padding.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h | 40 +++++++++++++++++------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
index 19f6eca2c8c9..217708b03f6f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
@@ -13,7 +13,7 @@ struct a6xx_hfi_queue_table_header {
 	u32 qhdr_size;		/* Size of the queue headers */
 	u32 num_queues;		/* Number of total queues */
 	u32 active_queues;	/* Number of active queues */
-};
+} __packed;
 
 struct a6xx_hfi_queue_header {
 	u32 status;
@@ -28,7 +28,7 @@ struct a6xx_hfi_queue_header {
 	u32 tx_request;
 	u32 read_index;
 	u32 write_index;
-};
+} __packed;
 
 struct a6xx_hfi_queue {
 	struct a6xx_hfi_queue_header *header;
@@ -74,7 +74,7 @@ struct a6xx_hfi_msg_response {
 	u32 ret_header;
 	u32 error;
 	u32 payload[HFI_RESPONSE_PAYLOAD_SIZE];
-};
+} __packed;
 
 #define HFI_F2H_MSG_ERROR 100
 
@@ -82,7 +82,7 @@ struct a6xx_hfi_msg_error {
 	u32 header;
 	u32 code;
 	u32 payload[2];
-};
+} __packed;
 
 #define HFI_H2F_MSG_INIT 0
 
@@ -92,27 +92,27 @@ struct a6xx_hfi_msg_gmu_init_cmd {
 	u32 dbg_buffer_addr;
 	u32 dbg_buffer_size;
 	u32 boot_state;
-};
+} __packed;
 
 #define HFI_H2F_MSG_FW_VERSION 1
 
 struct a6xx_hfi_msg_fw_version {
 	u32 header;
 	u32 supported_version;
-};
+} __packed;
 
 #define HFI_H2F_MSG_PERF_TABLE 4
 
 struct perf_level {
 	u32 vote;
 	u32 freq;
-};
+} __packed;
 
 struct perf_gx_level {
 	u32 vote;
 	u32 acd;
 	u32 freq;
-};
+} __packed;
 
 struct a6xx_hfi_msg_perf_table_v1 {
 	u32 header;
@@ -121,7 +121,7 @@ struct a6xx_hfi_msg_perf_table_v1 {
 
 	struct perf_level gx_votes[16];
 	struct perf_level cx_votes[4];
-};
+} __packed;
 
 struct a6xx_hfi_msg_perf_table {
 	u32 header;
@@ -130,7 +130,7 @@ struct a6xx_hfi_msg_perf_table {
 
 	struct perf_gx_level gx_votes[16];
 	struct perf_level cx_votes[4];
-};
+} __packed;
 
 #define HFI_H2F_MSG_BW_TABLE 3
 
@@ -145,13 +145,13 @@ struct a6xx_hfi_msg_bw_table {
 	u32 cnoc_cmds_data[2][6];
 	u32 ddr_cmds_addrs[8];
 	u32 ddr_cmds_data[16][8];
-};
+} __packed;
 
 #define HFI_H2F_MSG_TEST 5
 
 struct a6xx_hfi_msg_test {
 	u32 header;
-};
+} __packed;
 
 #define HFI_H2F_MSG_ACD 7
 #define MAX_ACD_STRIDE 2
@@ -163,13 +163,13 @@ struct a6xx_hfi_acd_table {
 	u32 stride;
 	u32 num_levels;
 	u32 data[16 * MAX_ACD_STRIDE];
-};
+} __packed;
 
 #define HFI_H2F_MSG_START 10
 
 struct a6xx_hfi_msg_start {
 	u32 header;
-};
+} __packed;
 
 #define HFI_H2F_FEATURE_CTRL 11
 
@@ -178,14 +178,14 @@ struct a6xx_hfi_msg_feature_ctrl {
 	u32 feature;
 	u32 enable;
 	u32 data;
-};
+} __packed;
 
 #define HFI_H2F_MSG_CORE_FW_START 14
 
 struct a6xx_hfi_msg_core_fw_start {
 	u32 header;
 	u32 handle;
-};
+} __packed;
 
 #define HFI_H2F_MSG_TABLE 15
 
@@ -193,7 +193,7 @@ struct a6xx_hfi_table_entry {
 	u32 count;
 	u32 stride;
 	u32 data[];
-};
+} __packed;
 
 struct a6xx_hfi_table {
 	u32 header;
@@ -202,7 +202,7 @@ struct a6xx_hfi_table {
 #define HFI_TABLE_BW_VOTE 0
 #define HFI_TABLE_GPU_PERF 1
 	struct a6xx_hfi_table_entry entry[];
-};
+} __packed;
 
 #define HFI_H2F_MSG_GX_BW_PERF_VOTE 30
 
@@ -211,7 +211,7 @@ struct a6xx_hfi_gx_bw_perf_vote_cmd {
 	u32 ack_type;
 	u32 freq;
 	u32 bw;
-};
+} __packed;
 
 #define AB_VOTE_MASK		GENMASK(31, 16)
 #define MAX_AB_VOTE		(FIELD_MAX(AB_VOTE_MASK) - 1)
@@ -224,6 +224,6 @@ struct a6xx_hfi_prep_slumber_cmd {
 	u32 header;
 	u32 bw;
 	u32 freq;
-};
+} __packed;
 
 #endif

-- 
2.51.0

