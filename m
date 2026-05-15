Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EDDCD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 20:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5407410E24B;
	Fri, 15 May 2026 20:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OjLHYoFN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O6LPU6WO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 527C510E432
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 20:08:27 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FJepub2565168
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 20:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /ZITHqhZFxZjfKPaS9OhfJTadzsMGDsCFdEuZ6sFvCs=; b=OjLHYoFN4D7BnvyA
 3HWPlUl2PHxuafhc4hKhMwoiSDg8dW1FuYMTWdnPn5ZjwTUTkQQxErg6zRqpezNS
 NbMkX97ipHDwF3pLmNnQjOCnt7zMScoNlTMCBM/xQEPQpyZkzYMRjCqWFnmsDniA
 3IVXuBxrQHAcbD24ZLghIIUsxsoUObX+oGcQIdIFHbnStjnFmD5LwBLvRWKH4awc
 0SazFktPRU0e2kqi5TXYS6HCWepDSPieksuOgcKYNrjrTjwAVd90PXpuTl/z2zjG
 O0ZuQ11S314lz2uHa1/G32punFNlYcWftjK1zkXYRUHCyN2u2rE5wvKHVpO2pb2Z
 KaKNaA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1vcsf9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 20:08:26 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-367bb9caa54so107417a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 13:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778875705; x=1779480505;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/ZITHqhZFxZjfKPaS9OhfJTadzsMGDsCFdEuZ6sFvCs=;
 b=O6LPU6WOO9cIgEKSjJ7NLy3DlaSPBsQUF984j4HDkemXd7YHAKDUS+sOEbhB0A/2Oi
 T+81N+dHOMavQOcrstFpaMemt7qESLZL4g/KKstxFbr0x1xA/gIgtn88tjwugjjH8oWo
 T+3guyt4l06GMgk75xkfz3UAQw077TSXoo9j9CIRvoDwUvkNxFQ/fon80KERA/a1dsmD
 GMoBgTiwMwTOfZb+3xgqduoQRy1uugzhgx/Aq8W8FaP2QJeggM/giwpTyv7NuX6BK4Vt
 dgskcJWaUP4yyEb2QhOEvwTGZfHS+2VKD5TOpYAE2z0+PqlIVIrRX6W59Nmd7O/QQplB
 sz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778875705; x=1779480505;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/ZITHqhZFxZjfKPaS9OhfJTadzsMGDsCFdEuZ6sFvCs=;
 b=dQDUUyYOPqHO1vdmg/+OtUW+m7ZvVAonFNnLw1ALdx9Xr+C0D/3+SI157AWCbOZr1E
 dbVVNk9LxhJcUcIC2mgqx0bSofSuU5TPCRtCcD0OEBecm2S3KAqOHEL6x0NtEm6fgeRg
 QvSfnTQKjE404dZaNbvyj7XsSc+U6zl36+y7WWITE2XDoatHP1zSEhW/Md/ddq2wIXx9
 LhS37sbxblc0TjfujAKrHY709RzkZ1qQknHi9GQeLD4saQYOSwIiyUwslQOZQFJtIqNq
 YKrc651cuBY1hwIlwl7f1sAZ5Wt6luQGN4/ATRsOlM0mq3ElTB1Kq8H3hdcIB98C0Xdw
 fnGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+aSYz/S/LM4BbaWTSbOrhFKtqTI9uV7ViFQt9Z/wSVsBqTtF5YJ/+wYZsgMrb4uZG4/FssDhDmDY0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMh5WMxkz7RR2LB/341mI/2CKZVB5q4tmRNBjLBaajH+VXoXTe
 aa4oP9LXqH3xOsf5RwSVFO9M2NAnR5Qp+b1seZGqeRxswPje6reJlytHug9nPYDDUtMUfzGat2D
 QRWQpmsiMiAfXis0ULzQiGbQK7N9W4sf0rEY7q3bIQbkKXYuWeRH7BpiAli/YqloNTFh8zL0=
X-Gm-Gg: Acq92OH2Xd0z5Vw+k5A81XhUsQFcCwzRn/4w69GNtXBS5mEVASozg8drzG2SNLnTd06
 Ghh0nC3pf1IdMvANhBLAPJxhx32rzdhjlB+MHFQ4NOAxbWwcns3Sb8KZtpyMX2JogomD/lpDRh7
 Hohcq2CV/w/z/q12jokiYqfB51vCRqjYd5RuiU62ZGPhCH4SmOlcRW3HCfUJf8eBhrMRQCQP7KO
 jciDsrVSMWVta07ojVABWhAQgwOaVV57V3Sdw28HAQxZUG/6581ZFeG/M/F6FIBgy7+mzruqeZK
 uUyNv+LQze0+5pCz9w04rUUqu1iFEE5wunPfMGcRu7s4Nk7EpoOqELHt3n3pFWYnHdmJV3vWcLa
 svygB9XHakeDgd9z2bjnZTNYGbwQy09q7ge8yKnVZkzSQFA==
X-Received: by 2002:a17:90b:2d08:b0:362:e826:cefe with SMTP id
 98e67ed59e1d1-36951ca6064mr5359111a91.23.1778875705369; 
 Fri, 15 May 2026 13:08:25 -0700 (PDT)
X-Received: by 2002:a17:90b:2d08:b0:362:e826:cefe with SMTP id
 98e67ed59e1d1-36951ca6064mr5359078a91.23.1778875704877; 
 Fri, 15 May 2026 13:08:24 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-369517a820fsm3518309a91.10.2026.05.15.13.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 13:08:24 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 16 May 2026 01:37:51 +0530
Subject: [PATCH 3/3] drm/msm/a8xx: Enable CLX feature on Adreno X2-85
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-a8xx-clx-support-v1-3-62508bf651ac@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778875686; l=2751;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=31IdYVd1Gff0fxdHBLohNr7vJBxGvvWroZqIO5O9rUU=;
 b=AJnEXF/U995HyUYgMJS19nV4lnFMVTz9ihR5V6NcllhBeZgoZfu+zPLWzUg24n8QNsuMFzuuU
 41x2G6QUkGwBcEbCHWBrlYP2bxd+t9pwwdPfRosK02g9OS9ITnwquWp
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDIwMyBTYWx0ZWRfX5NS2lJjQObsj
 EcJNc2SCOZTphF1z3Ht6IzFEhIhO0YHR/JqJ6HJGrjlbM+EfPvdkydAJOxH63oWfCdiO+IJWct0
 TIAavZTlw++j2LP+EqhwIkrqBBx0WwgJ6mLgEhXzoYZ9W64h0t1VpFrST32V7e/H6Bb/OKZmVpm
 xZkMOBsWUHxBdW2Yl1/M52GtX51/3GsIeR+Gw4mlCb/Q1PtTXu+EQnebZXsij4tJGFgUkwhNUeZ
 8fxIZ7kxV1+ETOcU3KaJEhV8iqdyqnEtFfBV1FBXaf4rt9QttmSWpCKLlsnXpdGcW9r9pwFoA0I
 4x9c2UwDrn70msuz2pt50FWgst/SDFVuzB6pzPbULuZd9QqFsATNIO3UmoPQat4hGysdAxA/zdO
 ER5Z2kHevqI1KHNquJ4if+qmnUngLBP/a7FuD5xwnDNn9MmmUHFGVGiAisdQbIvhsCe0OaA/kR5
 wkPTXuIFUCcOoabQ1ag==
X-Proofpoint-GUID: nOq0rLvZCL55FQljca8r09LEItvf4JnE
X-Proofpoint-ORIG-GUID: nOq0rLvZCL55FQljca8r09LEItvf4JnE
X-Authority-Analysis: v=2.4 cv=BvqtB4X5 c=1 sm=1 tr=0 ts=6a077d3a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=IqWTuNIaVRhLIjk9fdwA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
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

Add the CLX domain table and the IFF/PCLX limits tables to the catalog to
enable CLX feature support on Adreno X2-85 GPU present in the Glymur
chipset.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 86 +++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index c503912a61c7..9ad13eb173de 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1799,6 +1799,90 @@ static const struct adreno_reglist_pipe x285_dyn_pwrup_reglist_regs[] = {
 };
 DECLARE_ADRENO_REGLIST_PIPE_LIST(x285_dyn_pwrup_reglist);
 
+static const struct a6xx_hfi_clx_table_v2_cmd x285_clx_tbl = {
+	.version = (2 << 16) | 1,
+	.domain = {
+		/* GX DOMAIN */
+		{
+			.data = CLX_DATA(60, 11, 0, 1),
+			.clxt = 0,
+			.clxh = 0,
+			.urg_mode = 1,
+			.lkg_en = 0,
+			.curr_budget = 100,
+		},
+		/* MXG DOMAIN */
+		{
+			.data = CLX_DATA(60, 3, 1, 1),
+			.clxt = 0,
+			.clxh = 0,
+			.urg_mode = 1,
+			.lkg_en = 0,
+			.curr_budget = 100,
+		},
+	},
+};
+
+struct a6xx_hfi_limits_tbl x285_limits_tbl[] = {
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
+			.curr_limit = 18000,
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
+			.sid = 18,
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
+			.sid = 6,
+			.mit_time = 3,
+			.curr_limit = 66000,
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
+			.sid = 6,
+			.mit_time = 3,
+			.curr_limit = 18000,
+		},
+	},
+};
+DECLARE_ADRENO_LIMITS_TABLE(x285_limits);
+
 static const struct adreno_reglist_pipe a840_nonctxt_regs[] = {
 	{ REG_A8XX_CP_SMMU_STREAM_ID_LPAC, 0x00000101, BIT(PIPE_NONE) },
 	{ REG_A8XX_GRAS_DBG_ECO_CNTL, 0x00000800, BIT(PIPE_BV) | BIT(PIPE_BR) },
@@ -2227,6 +2311,8 @@ static const struct adreno_info a8xx_gpus[] = {
 				},
 				{ /* sentinel */ },
 			},
+			.clx_tbl = &x285_clx_tbl,
+			.limits_tbl = &x285_limits,
 		},
 		.speedbins = ADRENO_SPEEDBINS(
 			{ 0,   0 },

-- 
2.51.0

