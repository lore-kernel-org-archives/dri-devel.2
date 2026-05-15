Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF43CD4F3C
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 20:08:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4847110E39A;
	Fri, 15 May 2026 20:08:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oeluWDBf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="THsxQfdr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF52E10E3B2
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 20:08:22 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FJeanL903679
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 20:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VA4LbLc1gRQK/iiTsw45jkz2snEolhw5UxPAmzMtPSk=; b=oeluWDBfHCnuQGFR
 8ClgEW7D4lx+OiZRVrTiBmG3RCojTEPPxBUgYWd938IJRclrwDnrmedDiWGAhbQO
 +lVlsguxhPbjYLMY8+XIlWcHii2UYlTBDwOB2mtlN27BiGsrFzUWMq6NWM1R1Rmc
 +CJ0ruATpgRqk5yAhj04cHmELWQuGqVLu+EgXUSLdT/oQJYdzttHmInenpxjGFC0
 q3K/JZyeRrYq8CAqzb4xLb5NjSTTT4NbLOtQnEEGWPE0GFkc1lBc05SsGTRzOla2
 RARofUgz8SQ47dpSAG5An8UwLxTw3UZl9OKqIvVEklYS+4J53+q/JZebzqCXctV8
 4fOyVw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e670u8pbq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 20:08:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-368b0dc7731so68007a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 13:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778875701; x=1779480501;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VA4LbLc1gRQK/iiTsw45jkz2snEolhw5UxPAmzMtPSk=;
 b=THsxQfdrOrXFUsT4sx8PlbkLeie+cydKjzva0Jnh+lXG9wzp3M4paP+fVsViW8g3ya
 nbfce+0xOih9R4CsWWshQcxEYv9A5yecwqJWT1dcWk/V8T54RZZLe16xxQ5Pa6OBCSQE
 FAx+shllMxXxEKQwv0I90QO5Yfo+f+A22pUV4gNV5C6/+MXYRlr2cUsOBDYgMmQg8G6r
 IACkZWcEIyEq8Ba94fr4KtMC24ppW9H8Rb8CSsJKpt5tsaaO5ZzawHwyhREGSUkvntvl
 rv558bUSCaD05aEJHmAvuqmoADoZVTE/drarEfst8HXH+kHRtH0E78g2COciB1ZCa/MG
 SvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778875701; x=1779480501;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VA4LbLc1gRQK/iiTsw45jkz2snEolhw5UxPAmzMtPSk=;
 b=I1DmtYEPsRqjDzxfzdLZE0vJn5t7mzye8fOZd5wh87NPBu4qSdJphD51ZuJSJdvn2r
 S74jfqWNaug3JruMtvnyxI1t9PlFQJR/z+RaOrcBMu6cdwHNeJPECLh7rjW3ladywOdD
 W9FPb7alUJJ3wcPJrPmPjqgKghOTS70wyz8kEBcbFv12es1f9/tAPz/N8lbwkaZx5w4c
 O1b4WToGr0vyamL2+xMz0x5r8J1hebK1ZIEUeQsgPxghJSwJ0ofNOtmqZi2GmGsoGT0S
 Nou7P1Ymb1/f6XEdgtE/siCH2s26s7s5lE79x4rR2wm2J77fyhxURI7S5hQSAinQmf8x
 W7ow==
X-Forwarded-Encrypted: i=1;
 AFNElJ8yHjN8YtAyBVzWspEOVKwf54LZYlMgBO8iZnX0FSC5P8sxpKBaVUujI/dX4Ik/m8UAbgfwrmmCWJA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzhmnoJpKywztZ0N0YE6vkC3IV3KbjS+B5MFfUWL1MbqVOrwAeo
 /qXjJ9exbiQnVKq2vUTFmR/9MvYlj95S954Hn4e5oaquihezLSAXS30G2QxgMevpMpxqOLNpHgs
 v2zXpLOtn7tekB17AucaHdhMBpyDt6gpyV1/IpahBgHPlMQJVPKYm7jFrBOtoqIYsyULeg2M=
X-Gm-Gg: Acq92OGSq/+6SGBWO/7H8oVEzthPKtni6EnI3n8zAXcjRuyzHnDMpL8prQVHYbATZzI
 2llo96xIXM7pp5rzpBIbkSqrryW6eQPz/G+miI12tU4u9fZqbn8ZxC+a6Gqoo+ImwUnWv0c/s2D
 xu9rqAHLqELd8sZj56dMJr7LqcT97HqgTZIwsmWrG6CgXB76UQIhMASkV0iV0eEMjQYAOjFFoTP
 f03H2EPVHKV2K5nUqydDSNlnE7IB34SkrhOw3mSo5RF5EuejblfX8V+5fEmfKTa84gCyFajl3di
 naZ5rhGY2jE1AyMWHuNvPqUgYV6ifKaeclkiM6w9AVwcr/94qN1VvKOTt6Srp899GQuN0dq43V/
 ZzH4FfEEXQgZIVj5bKa27qXGxx029MmTaZkHQCYEx7Xxk+w==
X-Received: by 2002:a17:90b:2e0b:b0:35f:c46f:2b0 with SMTP id
 98e67ed59e1d1-36951a6ce4emr5501309a91.14.1778875700809; 
 Fri, 15 May 2026 13:08:20 -0700 (PDT)
X-Received: by 2002:a17:90b:2e0b:b0:35f:c46f:2b0 with SMTP id
 98e67ed59e1d1-36951a6ce4emr5501275a91.14.1778875700295; 
 Fri, 15 May 2026 13:08:20 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-369517a820fsm3518309a91.10.2026.05.15.13.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 13:08:20 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 16 May 2026 01:37:50 +0530
Subject: [PATCH 2/3] drm/msm/a6xx: Enable CLX feature on A840
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-a8xx-clx-support-v1-2-62508bf651ac@oss.qualcomm.com>
References: <20260516-a8xx-clx-support-v1-0-62508bf651ac@oss.qualcomm.com>
In-Reply-To: <20260516-a8xx-clx-support-v1-0-62508bf651ac@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778875686; l=2687;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=wHx7sphxQ2G3JogFllYloGnDGRdPJph8jXQ/6CvvKKo=;
 b=G3Ivq08TbSQqYvhvie7EaREILmo2Z2YVDDneKJIA6TpI3C5YP8FMzLtex71VuZqvWq3jWJFg5
 dLCfGEWIp5gAtxe5uLuqRJzJ20yNY8yd11JQjSW9fjtChvNx/qyO1Hi
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: fgvTg-c4civ3JoxAtnYZCRUHi1hdg58I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDIwMyBTYWx0ZWRfXyflL35mmq9Zr
 af7zKgsnYX210Bs6mH4vxyIZ8VUoHk7AMqdvMqhOk1IrQE8eLlmPo71ThBP8IxkdhQ11m6ckdRZ
 pI5QeDPAgzS+QeZPEtyGFb3CxsVYD4t2MFlhHXRq6LaxoarIRlyyTMcfSE0wHrYeLUmf/R1t8GZ
 piqOijnKiu1cwV438xv3s/FHKHljj+LofohTgPNusleixeZzGDLebb/zna96zdcm9mbOi9jqFTP
 2bUMa5BOA+JsNXxA+CxFHLnAUJxtm1Cv9qB3PDLYjjTxSsIkxPC+wAwqrForzabap0dn3STNcpm
 HzUxDvp/wFQ5WptJb9pgUPH4uYXkAbmDwSRr4EWMicAnpsQ2UyeCVfzJ/fHDn43UcM//0x7BZAp
 U/38y2tzxgWVTqBCl6w72GpImvNTOoYTiF1gzjRWuqEZvUmIdW7yW9zfxgNu2k6GlNGrDtjr+vE
 Iwwbb3ZCw4VeXBu57VQ==
X-Authority-Analysis: v=2.4 cv=E9f9Y6dl c=1 sm=1 tr=0 ts=6a077d35 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=euEflnDZojKr1heemAgA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: fgvTg-c4civ3JoxAtnYZCRUHi1hdg58I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150203
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

Add the A840 CLX domain table and the IFF/PCLX limits table to the
catalog. With the HFI plumbing in place, this enables the Current Limit
Extension (CLX) feature on Adreno 840.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 86 +++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 550ff3a9b82e..c503912a61c7 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -2108,6 +2108,90 @@ static const struct adreno_reglist_pipe a840_dyn_pwrup_reglist_regs[] = {
 };
 DECLARE_ADRENO_REGLIST_PIPE_LIST(a840_dyn_pwrup_reglist);
 
+static const struct a6xx_hfi_clx_table_v2_cmd a840_clx_tbl = {
+	.version = (2 << 16) | 1,
+	.domain = {
+		/* GX DOMAIN */
+		{
+			.data = CLX_DATA(60, 5, 1, 1),
+			.clxt = 0,
+			.clxh = 0,
+			.urg_mode = 1,
+			.lkg_en = 0,
+			.curr_budget = 100,
+		},
+		/* MXG DOMAIN */
+		{
+			.data = CLX_DATA(60, 1, 1, 1),
+			.clxt = 0,
+			.clxh = 0,
+			.urg_mode = 1,
+			.lkg_en = 0,
+			.curr_budget = 50,
+		},
+	},
+};
+
+struct a6xx_hfi_limits_tbl a840_limits_tbl[] = {
+	{
+		.feature_id = GMU_MIT_IFF,
+		.domain = GMU_GX_DOMAIN,
+		.feature_rev = 0,
+		.cfg = {
+			.enable = 1,
+			.msg_path = 0,
+			.lkg_en = 0,
+			.mode = 0,
+			.sid = 12,
+			.mit_time = 5,
+			.curr_limit = 6000,
+		},
+	},
+	{
+		.feature_id = GMU_MIT_IFF,
+		.domain = GMU_MX_DOMAIN,
+		.feature_rev = 0,
+		.cfg = {
+			.enable = 1,
+			.msg_path = 0,
+			.lkg_en = 0,
+			.mode = 0,
+			.sid = 9,
+			.mit_time = 2000,
+			.curr_limit = 6000,
+		},
+	},
+	{
+		.feature_id = GMU_MIT_PCLX,
+		.domain = GMU_GX_DOMAIN,
+		.feature_rev = 0,
+		.cfg = {
+			.enable = 1,
+			.msg_path = 0,
+			.lkg_en = 0,
+			.mode = 0,
+			.sid = 7,
+			.mit_time = 3,
+			.curr_limit = 30000,
+		},
+	},
+	{
+		.feature_id = GMU_MIT_PCLX,
+		.domain = GMU_MX_DOMAIN,
+		.feature_rev = 0,
+		.cfg = {
+			.enable = 0,
+			.msg_path = 0,
+			.lkg_en = 0,
+			.mode = 0,
+			.sid = 7,
+			.mit_time = 3,
+			.curr_limit = 6000,
+		},
+	},
+};
+DECLARE_ADRENO_LIMITS_TABLE(a840_limits);
+
 static const struct adreno_info a8xx_gpus[] = {
 	{
 		.chip_ids = ADRENO_CHIP_IDS(0x44070001),
@@ -2185,6 +2269,8 @@ static const struct adreno_info a8xx_gpus[] = {
 				},
 				{ /* sentinel */ },
 			},
+			.clx_tbl = &a840_clx_tbl,
+			.limits_tbl = &a840_limits,
 		},
 		.preempt_record_size = 19708 * SZ_1K,
 		.speedbins = ADRENO_SPEEDBINS(

-- 
2.51.0

