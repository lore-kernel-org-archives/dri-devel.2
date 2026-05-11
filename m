Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A79BCD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 13:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A61F710E747;
	Mon, 11 May 2026 13:01:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cruGJbn7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C8VWpoVj";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F76E10E761
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:02 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BBITnu1344461
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QpEOCCW2frO
 5RjDS7yw8Uzvvr6ebtp3PdlAzKWnUJ/s=; b=cruGJbn7sIUATh10M5jsgXz85VI
 ZFQeS/jgS81EAtMJOouCdBmq/AZU/j7r+Dc8Th34AE5K80trOIi02nno8L5DzvPZ
 iTE+e9u4KyiJHkeVQzIFY7bPVu5f07PwUJHUWwU2ruEiW/w/rNcGOFMqenoEvhDy
 /Bvr933ptoBRGor7izAH1WWWpxFsjltZ+jm8Q5g9N6p4ViG8ysCHw419acbnK39n
 xvHm8Bo8GjIDoyOrbgAa+cWXCb/NlZOR6Jvc0Tt/Jtf5ilBFTQ0qHlAu+A5LoF3+
 v+x8IWKwAVNFvDXctuRJdtNi6EfTTeZDX/CFWfwKUVqZM1BkWH8PMFqordA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3e498abb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:01 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c8292e18166so409363a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 06:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778504460; x=1779109260;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QpEOCCW2frO5RjDS7yw8Uzvvr6ebtp3PdlAzKWnUJ/s=;
 b=C8VWpoVjMHnc54EHuAzqof0Tztzuu/3amPLKAH9YuHd/Ay9HT4S9xmy611fQt0fsRa
 hlpZb2vTwGCbx2sZ5nPT592Bb9ao1Fc/7LJGAqQrD2VW7+/fBDg6kQG4RPbAjInq9P8v
 Ljz2k0VGau2+VWOYWjgh/WS1HeE+n0FRF2c2/GcTkQ6okq7iTiqbvAbvC3RbAUqns6Bz
 yJKxbUQn0URrS5IF1LTPhk3bMK3u+UVuwbxim8gnj3W8VoZbz7m+y5Hho4M1OLeF/ACO
 VsMT7l6+R4UNqUHdyTQNo58Sxps8Sfa2iu45zCCv/pCDfn6MROi3cUSv0kC2T68d13WP
 sOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778504460; x=1779109260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QpEOCCW2frO5RjDS7yw8Uzvvr6ebtp3PdlAzKWnUJ/s=;
 b=r9ECB6Kgl2z8WCmT8lHvxe4hD6vDCeXcOFhHk2B/GDgXN+YEtiyoHwT1hWD4z1Zkqs
 xnM8bbBHeT/wYYgVIha57zFbMjtOqTb8V2l8u8ctJ8bppYG1SQCHO9u0uNHA1iYQR74/
 U7Jlcu/l4nyiiBMSjRS5hxuFL+FKjq4KkJtQJdn62NdHp0nI8SaBZbD+kB4Ab25fa0Fn
 KOtgrTdz0JBG5+w4ggous9rkkFnOZZrSOG7SCI+7m1d/GZ7WaFqnmX/ZLA9nDkvktz8b
 VU6D6Stw2eULQa7es/oRmcCdnGuWmSOGF+KBt1KJPVB8vcVd+MEOJ/kdFLCHcpcniv0o
 NXmQ==
X-Gm-Message-State: AOJu0Yxu4IyOLC/TIapvyKnDQgDfEI4sudBlaAZbjK4dCwgN/La8dl+g
 vMp7VYO5dFU/GqPjQVzO4e0Xt0DV540KqVjBozwOhBDQ0YcmXelKCAtkZzswtaj+MXr4WsROMBP
 FkmbaGAnIwEntyCsxwLClnc+5sNV/BWVe4/n9Kmkc5oSMV1Z7u/GbjKxAuu9HHI2lHTQDQnzFzl
 H0AzE=
X-Gm-Gg: Acq92OG2ZO5DwwEVACHKxwqoczZxZT2nKZQFUTn1PB4vmM5+9Qzd+V3BpaoPxqZ29lK
 yO25aDoRqfjEyTxQFt4Ff4V28jzUbdohxzYmwddyooYqFKedRSnzZG8wkRC1RR94IXfJMleVSmk
 QapUHC4Ag6cH4h8maSkmDKCx81YU1gfAmcmDwy8jfcEI4taNp6zwq4EnKXi3Q0noc7Hqa/JfaO9
 F/QDUrGDL9AvYk0Bb30fQSxx8+iepgtyX7HImR/gRkXMwWGqWIjqJOFv76yDrMyjJgNDh87P0wp
 farXoTW5Y4o0TPCT0OjBuprWXWZGSjpUXSsI2aWPVF3o0j6MSmCc0HPt922wO2DwiPotZYo16i7
 KflWSTFDb7W82W4t6k+eHzUQMClzVoOso
X-Received: by 2002:a17:90b:6c6:b0:35f:c729:de9f with SMTP id
 98e67ed59e1d1-3664cd49ad7mr13656723a91.27.1778504459890; 
 Mon, 11 May 2026 06:00:59 -0700 (PDT)
X-Received: by 2002:a17:90b:6c6:b0:35f:c729:de9f with SMTP id
 98e67ed59e1d1-3664cd49ad7mr13656661a91.27.1778504459326; 
 Mon, 11 May 2026 06:00:59 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-367d629f40bsm7782246a91.7.2026.05.11.06.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:00:58 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 02/16] drm/msm: Allow CAP_PERFMON for setting SYSPROF
Date: Mon, 11 May 2026 05:59:15 -0700
Message-ID: <20260511130017.96867-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511130017.96867-1-robin.clark@oss.qualcomm.com>
References: <20260511130017.96867-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ot8F-dfiBCCT3adjPhtReK6luOnjQeg-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0NCBTYWx0ZWRfX8Jw97P0iRY9J
 Mdyw/F7Up8WWmWPBnGKkTQqWraWEzT1xLtikJp8Of4wUGfGj1f+fWX6+9dSNE12eiMxdndChPN1
 52Yf0jTyul1pKmsci9vtqVaXmGym9zDMfTh1SCHULZ3eAraFjxmDJC3wojCBlun0UduJ1dt5e8F
 RBVz4IZgY21XtH0GtPsG+dxl9HUlPjmRcVioPd5u3bCSLnLmkDOUFGQPXnofHDvi+Ec1deGMKOC
 HQyJkD/5evV3ZctzMKsxr9ZNDfsLM6OfVygTqTthNd4nPLkSXEvcG5QFFY4bDCKo7sGaf7C2xH8
 bH32g/Uz4GLEnZpmKnBoCikWDAY7W1kFCCdn0tJ+ihTz/AdOkpOF9HPUbGv59CMFUBr7qDnGAoB
 1XVoK0F3OwViKloK3xXnSql8aDoMdZaUbO4QmjyvQkZcrDeCCKkMqrVv6zezo26cVo6Az87laIT
 XbmGRhjUMZ/LY2pFRBA==
X-Proofpoint-ORIG-GUID: ot8F-dfiBCCT3adjPhtReK6luOnjQeg-
X-Authority-Analysis: v=2.4 cv=Yr0/gYYX c=1 sm=1 tr=0 ts=6a01d30d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=ZRXlmS4ShPoOlOK7p90A:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110144
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

Use perfmon_capable() which checks both CAP_SYS_ADMIN and CAP_PERFMON.
This matches what i915 and xe do, and seems more appropriate.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 66f80f2d12f9..72b71e9e44f0 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -494,7 +494,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		return 0;
 	}
 	case MSM_PARAM_SYSPROF:
-		if (!capable(CAP_SYS_ADMIN))
+		if (!perfmon_capable())
 			return UERR(EPERM, drm, "invalid permissions");
 		return msm_context_set_sysprof(ctx, gpu, value);
 	case MSM_PARAM_EN_VM_BIND:
-- 
2.54.0

