Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90F1F483F3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 166CE10E421;
	Mon, 23 Mar 2026 20:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GWO6czEO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QoN2wiaw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11D0910E3EB
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:20 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NIZ1sA1909349
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s55BbPd47G4U0MWootUpuQFOjqvge2EChb3luzG9YmY=; b=GWO6czEOxZHUTfuP
 izJhaXgEvot5as2nB1ugMTX7VRUAaZ0xW15h4Q1YgYjKdPr5SDmz99OD6XY7fR+L
 XaSmUX9gynnYxEWCKh6q0O8DdgW2BwAi5hBRbYEeyv9VveKBpvK1slDOIqqra14m
 GkqqDDATh8nFpUOI9Ioz5qBZrVZFiSE/IIs9OLpVYcIzDCaFUY29XxxHudg7EkJs
 GE6z4xnk+cAE2VIf1eD5f7V/L6rhsimeqyeVr2GBnpRAqzzso+41Tfd/S9axdsLH
 67RWgW/paAgsjl2P+4RZ+jy4WW5v/kInVwQxEkD4bBSaavnxOuoXYW7+Kl6JUsam
 j4vbBA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3awyr9t7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:19 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82a106b687cso325370b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 13:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774296799; x=1774901599;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s55BbPd47G4U0MWootUpuQFOjqvge2EChb3luzG9YmY=;
 b=QoN2wiawlVOWgtGzC9GWLvl/b4YIS9SiAqSjkBzkEabn/n9qyntJcxsX7lHDvv2aXB
 nOsnpZsLKHfAgUI8Bd8Wk9K7FnuDbb9rlCneYHCi569qsFnhGMWGpo71hFPgYVsOgADI
 zWU3sxIF/gn5KiVere0Faj+mI9G2TVKy5n/LB/7rhSGxsIR9V5M/IP/vmjjKK51Qmzz1
 YPYpQEpJZW4/DYcU7+HT3U14sDgY3v+Dar69J1RWOhWTI2EA5orbns4YHY8w7e5uNJNr
 Z3V20EFhaIBo2JdivpX3xJws4gZ/Bov41LYY8ByyzDn2F7iRHPzMGqbtxm2Fl+lQGRb3
 81EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774296799; x=1774901599;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s55BbPd47G4U0MWootUpuQFOjqvge2EChb3luzG9YmY=;
 b=euEr5x3l3ZW8JbcYXj8o8JvYfYyiLmYOFSSh7a6jpHNn7j4/vaKtuObZ5aeVG7+HGi
 JsLAgtgfiPfxgBP4I7X8ijcuNFfi2+lBKDNMClywH3NuxAAr0hxcFqPJfbSTVLwXPWrc
 SulVm9aN9XbDUV0xeJlDBe1sf1AXAAFdqM8lsbfRdywJ76FvD9BlQ4pbgtqin6kHEOdd
 PqA1IionamhJ8UMQhWrtNjw8rlN8cG94Xpy9AO+AQhQ+778zfmFf7Oubnz4wfkLsj2US
 SCHBVchmlXWigrnk7JvOGgomNowW+5YeaPzfw06pXaUIrgMS5hupjvLv5luUm35u+4GZ
 FnjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8BwCF1MAB8ChHoCwZZG1RSG/6PQyfZw3ToUh0J29Bs5YufB9pvX6P7bfGpKSR6zxmWwjLXy/lOEU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6tFDQYBpvcTI2f17VyQfv9mAeFP3836pSdIjIKEo7tGddjuRL
 DFhdw2SwB7ZryFmtpoCmjNXTWaB2m2ITKJovEOh9gMduyX8yxT9BPCxQWuD0aXM/o5dErlyvy5c
 ONEOMXEX3NaGTvtfjWi8L29Mr+BkzCUEnIpymCdRwtLvCGikstl33fMg3KOakQA5ty5TLoJQ=
X-Gm-Gg: ATEYQzzpxsK1+7rn73BXFwJ5NQFValAHHyk9MSPrZclKmF7B3IzJsTeeZAILGflaSre
 +xdMpt8N4iwMmHfGz+VOsEolQ0aolEenpdXbEPU+t/qG/OhEKK5MdDl9F9f04Dshb7yiud3rvFb
 faInjKbmddflaWWNSgFw5siR56vOD+9JFeofl1b6W/jCrArvAcd/09tJp81NbwEGh7mrq2RoT9D
 80MmlwPrvSU0YkapqK7XtoQ+W/6RJonnThaQzk4I5P7g4URlEBamqM83rYQTNVGrDJ8DOnbkTt8
 eDqTMm2LDgRotqnIeRQXC9v9Npw438VlpQRlCDn+361Si1X3PL6IM4U9rbmcJWTG+6itYAHI9MT
 Fs7asnmvGE0M1ZnLatkyt6Cjob4vSTynl0UAbkINrKM/hLQ==
X-Received: by 2002:a05:6a00:1707:b0:82a:6461:6d1e with SMTP id
 d2e1a72fcca58-82a8c392393mr11129951b3a.46.1774296798787; 
 Mon, 23 Mar 2026 13:13:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:1707:b0:82a:6461:6d1e with SMTP id
 d2e1a72fcca58-82a8c392393mr11129922b3a.46.1774296798223; 
 Mon, 23 Mar 2026 13:13:18 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0409d148sm9510738b3a.29.2026.03.23.13.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:13:17 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 01:42:19 +0530
Subject: [PATCH 07/16] drm/msm/a6xx: Use packed structs for HFI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-a8xx-gpu-batch2-v1-7-fc95b8d9c017@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774296753; l=3900;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=nnupNIOeLrMXfkuUyA2tcvNb3mffh+T80cPwHVdQi3c=;
 b=wYEXOm/R6Vsxc4rBfrfyT9WUhx8CW/T2BOGGO+xofnEJDCbPmC1wyW81635C1kRzkWrzKXy7u
 JYNCqh7a/gdBW5mk2jJTJvHPIghQWautFCviH27ZFJuilb3Nhxx5u75
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0OSBTYWx0ZWRfXwRTC5cnKit5/
 b4KaLXXGepwZMw16MVke0zKnQpizV3KZWIRg5yQd++cCisAurrN67/hyaJaPvZlc5MiJVMmDXJN
 cMFaDKFtXdb1go3zNJyXp+Y9/i+7rzuFd5tjnAD5BABb4gBNx+hPRT+Nk2cLjml55MPKRsP3Fnc
 h3BtiMpGosOIYEN97G0Og9JC4JEQFrk4P8nTo8Z/YPYyNALWOgtqmk4eDyMEgV8/Lj4DppcNOVL
 u/QCZ/aZfAslwB/SNIcF8PzUveW9jCmwIyY5+0wtnWT9Gb4OZC/rGimUqZnE6AcT7cXm9XLTv1B
 c+PQIQuehzHiBNYB02YMF2/J7qW6GnDDb0BqUgCn2J8cK1Dd685Dq9X1TE8CQyMDk+pihLQP0IE
 n7p07F3CgOfq2efb9f+3GLftHAKuBHqQzJhb6NutxYjiaiPyG97a2HUG4L4jPtKdW0lC1ld5gtf
 736dRu6O2/G/6Ip6bJg==
X-Proofpoint-ORIG-GUID: 6QHLy7SEr9a-bTml8LyKLfJmvxSn07DE
X-Authority-Analysis: v=2.4 cv=KuhAGGWN c=1 sm=1 tr=0 ts=69c19edf cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ArFqxpKCfli7nxZMP-sA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 6QHLy7SEr9a-bTml8LyKLfJmvxSn07DE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
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

HFI related structs define the ABI between the KMD and the GMU firmware.
So, use packed structures to avoid unintended compiler inserted padding.

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

