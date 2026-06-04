Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D12CD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EF2810E3C1;
	Thu,  4 Jun 2026 20:10:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ku6mCb1F";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AvFA0VqQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1534C10E3C1
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:10:23 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654HPiLA011796
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 20:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tEzM6aI+gFSdEXjQV7bYfKRnP6YjGvJAld8/hhWOkMA=; b=ku6mCb1FuOl28hAl
 gXZA/z+m6ewRQE8YxjrQFrxWVvGYyhBLov7sH1v8wyA7yO11mUd+pzM1/cPgzlL7
 JvgfoVImsBioqXt1KDbJCHPWFAYYzB4Uruxcfkz0YbN4dmoUtCDspdOv3kaL5NEm
 uowT0PnP+OY49rCiLI08Y3MeSxes1iTWuD5AMEI8Ww26nuZpGV908O6F9FBECMU5
 944aslBMxtvQb2QJzaMA03pb3clb5b+UOP9Zco+Ksy8E+IIG4qW4te3AWN66g0Ud
 yztDXLtMql79wBej+tDCAxC8932UPKYjcxY3F3xv4E82h7is8Eg16pzYELn1opRk
 lZ6cow==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek8dc2ed6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 20:10:22 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c85a2cde332so625644a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 13:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780603822; x=1781208622;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tEzM6aI+gFSdEXjQV7bYfKRnP6YjGvJAld8/hhWOkMA=;
 b=AvFA0VqQGqrOi4M2SJgT4FbzuUoUrIk63jJSjMVcIEqFWtR4wMuDf056bKo6TmbFyX
 zkRcHVR2cyhf6BkYpl0vbOzvG210/gpr4gKaGQvplDRsc7HQE55ldaNwo8hXca2rq9WA
 4ODbCtAD4uk/iUPMx2cpc+G2XyGcOgRAexGkP4pmqgOpHfUmwFn/E+7EoUXlhvtvHQua
 adLkkyhp6e1OSTUHOUziZEc2tFTpM6Qly8wDn5s3ZbrVB6/wf2fCIH55pfC3xkO3Rt9N
 ublN8p/GoE5yhyxu18txVkVMT/9zsAwvI+UDHW+h82Uml9Ihbr60pJa299m3yH6vW6wq
 4eAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780603822; x=1781208622;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tEzM6aI+gFSdEXjQV7bYfKRnP6YjGvJAld8/hhWOkMA=;
 b=qrr6K+L9mmSJ3jStG7piZcP+kR5eR+I9dyv604m7ax8xTlPodhE8VsYcxx0sEEWVFD
 oGCKrs09N7/bHQkV+3BHaHCpEMQxUpusL5VsTd/i2jN+zinZFABV/Iucmbg39Rb9JLEc
 UCUb28VftU6J8X1pRzPiOTDaIYhqfTwQaFLH00UBZ2YvRdYxSFGlcGXjNGHm+PUwR/FB
 vux8HWKSow67DJLlbAnwZEYZH0mSEU8xttZumkkHP9MdpM4bIYZcKNzWkEj8KlsEfTM8
 iHnkzWEGsKUydZVrX8uRI2uS15kXg0crGtpqsS5yOdyuNVqPQ6wONrwnf95Fo5JNBOAc
 o7YA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+OdMoSnYp0bkAhMQ6DMTYn82QXC/95OQR8GKSLP4/tE9oZftclRfK7Q/gjdcJ5rD4Y6hoIPVKzsUE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRQW4RKbml2KDHesYekKLgCiVW5mitEb/q4ighUp1t2vqVfYBZ
 VAKdmw4ZdllFSBVZh/2TP5oZqzIZ4ylAbWEio+Uk4UtHEpOrhMMwh20HxDADDEkQFk181hYFUZL
 wm05hrV4Rxpp88ejQTN4MITELcmQGnQOvDUT36DbTMAXmqCtLA6mK4o8IlyVUhgXPBvMPxIg=
X-Gm-Gg: Acq92OFJIXFMEEBx5tMqKyCnwRBjPHFx7t7go9AzQGlKUU7jl8tn2zH5RP+MWq44ALH
 NcaRf/Cbjo7PVhDFPFdoM7xIWhdfdkPEkc57m8zqw8klzDkpYZH1PQowRoMl2G/ktlUPX3817zR
 heCWR44KJD4HWtiFDActdYOLCnLAZXI1qpn7tp3X4uAYRpqWzqIY8nhHBoNIuh7raxxYcC1WYyj
 CJfBa4c8wBkG52VqckaDcbjjSTSAZ9HSNvEXp398vQTqPFVhHXUnQxAiEAxN7jM0mnDj1irQosb
 bhVv5JaTuo2AEOl/3h4HFz9W24vOD7AR52fmGQ1X6kLBp4veKx8/IiwyEfWIDh4YlMNm8pDTeAw
 NGe8ZQCJcs0/mew2JMDJ9d5wW4uhVDQzPRsE42OcNpLlMgAnFbK+K2+Wu
X-Received: by 2002:a05:6a00:2d07:b0:842:4387:34c2 with SMTP id
 d2e1a72fcca58-842b0f1eb81mr219333b3a.10.1780603821702; 
 Thu, 04 Jun 2026 13:10:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d07:b0:842:4387:34c2 with SMTP id
 d2e1a72fcca58-842b0f1eb81mr219304b3a.10.1780603821243; 
 Thu, 04 Jun 2026 13:10:21 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428290067dsm6721425b3a.53.2026.06.04.13.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 13:10:20 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 05 Jun 2026 01:38:19 +0530
Subject: [PATCH 3/6] drm/msm/a6xx: Fix A663 GPUCC register list for state
 capture
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-assorted-fixes-june-v1-3-2caa04f7287c@oss.qualcomm.com>
References: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
In-Reply-To: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
 Jie Zhang <quic_jiezh@quicinc.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780603799; l=1196;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=KD6o6YqvRymUJjmyXkRq8JL7HBh95pEmuexIqWDOoFY=;
 b=Rf+OoZSBSB83ESsduxAX+IGD/p3hwH9STY3omijSLj0gNynys7t/XryrP6/hBWdeyjo5+Id8o
 kUaTfr/Oh7ZA3kAaz3Sk7IqLthdGnFo8kzXzEXLXyyOOIpn/NAFc86+
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: 46U2aSz5HDIFpfYnhFzhHnLaAp7JKY1T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE5NyBTYWx0ZWRfX6JkxrBe2Nmsy
 m07uI5px8JcnEtMoTulG/RffwfnQGTao97TjL+PBUK/msdaSKESO0PFD/o6LX43C912alpuOpl2
 dwl0yM7IYCbMT0oXiP8e1DiiCXqIwNMSA9nSYPnsIe0a+GWY91bi8TPSqLsZs56XnxQJufE47If
 g+j1QVpPjJri1XwiDiYkikYy1ghHauw1YbMytIYrsuXpWtVGQnLmjdqeU5nsP3ZsQ1NZCGOOHmI
 bFZkpngWiLRBY7uO7BtGgYPA9dY2MQQZdIEeofIBeoT+Y/ZMYew/dS3glxmynGaktcFNTS1V2PU
 Fy/HK6kWtjP4cGCobtZE45wPV0xLd6Z7VYv4yumnvsScwxZszraXz++oCOkhkhur937xN3l06Va
 ri2vN+5WussviK7a2oYBmuwqeyABuL5d0rj5vOZw5ozczp1hwBuysJt8FjT+5JM/yu2Q9eMVvNR
 eBG4HIx37RwolLPLAWw==
X-Authority-Analysis: v=2.4 cv=eJwjSnp1 c=1 sm=1 tr=0 ts=6a21dbae cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=oU5QhpEZILUeHJGd72wA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 46U2aSz5HDIFpfYnhFzhHnLaAp7JKY1T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040197
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

From: Jie Zhang <jie.zhang@oss.qualcomm.com>

The GPUCC register list for A663 is incorrect, which can cause
out-of-bounds register access during GPU state capture.

Update it to use the correct register ranges.

Fixes: 5773cce8615c ("drm/msm/a6xx: Add support for A663")
Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 166365359fa6..2a62a22077f9 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -1244,7 +1244,9 @@ static void a6xx_get_gmu_registers(struct msm_gpu *gpu,
 	_a6xx_get_gmu_registers(gpu, a6xx_state, &a6xx_gmu_reglist[1],
 		&a6xx_state->gmu_registers[1], true);
 
-	if (adreno_is_a621(adreno_gpu) || adreno_is_a623(adreno_gpu))
+	if (adreno_is_a621(adreno_gpu) ||
+	    adreno_is_a623(adreno_gpu) ||
+	    adreno_is_a663(adreno_gpu))
 		_a6xx_get_gmu_registers(gpu, a6xx_state, &a621_gpucc_reg,
 			&a6xx_state->gmu_registers[2], false);
 	else

-- 
2.51.0

