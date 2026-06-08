Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24431CD8CA7
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 23:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51CC710FA0B;
	Mon,  8 Jun 2026 23:37:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OcxQcO1U";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OZ9wokP0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09A6910FA0F
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 23:37:06 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658NDcWH331563
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 23:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bVpi8do7RhaAMGVQUssy+84jr7LhWyRN9eNu+bS8Oao=; b=OcxQcO1Uuw4e3swz
 NlY3JZyXbDrM1/mfggOBHj3FDiN4DMkx4A+mtKP98hJneL2LOy09+wTlHkmPo1Uz
 QV1Cv+Cc1TQFBDUckHFg2teMioa/Xx4N6P/2fXtBRaFIuFVVkvbN7Y9ORR1NSyW4
 rh3fBPIszwHyLr2ss/49nhIuBwhRkqp8m7rm3rmmsZkov2JBUQgug/YKkyZAYcL3
 Y56MwwAclPQe8X51tMAwfRZgLXg6u20iKFUy4TRMzMn1SmBdhF3iXtpBk7Qu6FB1
 m8xXXKw7Je4fhYGTa5eTKuTwmbhXXJfaG/1nAoFwlRHeTVLCXVtFVJT6Xr234itB
 gEwPsw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enxx42fdq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 23:37:05 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2bf1845bddfso58473145ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 16:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780961825; x=1781566625;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bVpi8do7RhaAMGVQUssy+84jr7LhWyRN9eNu+bS8Oao=;
 b=OZ9wokP0EsEkCNV2Lrwmi8yyudVnkkWpbwTdJMQ83CFDWMhXIgY0LqyPOejRSgQ+EG
 4TgP141fmN4cyJCvMgNV+n0YBtMtT3qUWhevw588dk07eZbgsWTs0JbLSgu5tHEBzY0D
 VDAZDnJGNkCGuzpaYDJBammGOzz/5+yABC19zXWFd+8G3HAlC4eg0FfqmoHV/D9uNUdo
 Y01MThL/a1t2Y+nbO1te+Jib5/UtlMuBj8qOYZ1AUlQxjwmd49sxRbPKC19SiHFFYPgZ
 WlylLRGYM5xOx96sSDa2jnr6tRGbsrx/Zgae+ajWAJM3IEwKIEdPhCBanYDUvLl0kKqH
 DsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780961825; x=1781566625;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bVpi8do7RhaAMGVQUssy+84jr7LhWyRN9eNu+bS8Oao=;
 b=SErFpyWYRMMVyj0iGo0bxyUOMM0YM4parhtdgVo6MQW+hT3h9YuHD4dsvqpPVW38Ck
 PGbTTkvDsggQHX7dvVceUuryAIKzUtgfQ5TWKgS0wlHUgHMNCNylf1WGzMXQJVGmUmN5
 E6j17BpU6DibtC8IlNtj8r36ec5ycGIH6+6q7xCEB1YEKVm/+xZH88DLdnWqBsMlQeoE
 yf1AT+29VTE0wF4BITuyjQLLsbEQ/lR1GVcE2q9TINBABCnVGV3kg2fvN1axHPdmuT57
 IRinOBHmkX2YmDtNGEcZ7jN0pOveEsqjI8nuXz9Z1fwAZZphQcCaigZhTxk0B3rhBcnz
 fORA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GlOipXWPgvTvzBvUIk/fx+QYG6JIjAas+rp5EJBSotCkvL5oUJ+7fv5UMxZEaSvoy6IbzpvcuQfI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxK4hvRKDEWCG1wri2vOBk8drizrQx9H60L80K8NHiDhMr+J27B
 QWv+0MO7T86hELDovHAv62m4JCG26QOqnkipzrwxKkJ+bWBK9t+VLacZ0BtUS1GbukYXfYb58HG
 +7C54SiaHWZC9xBeodjufAv0DALDDkvabasmbyFQzjD7kzpwq0/uE3BuTMS0c59Q9fYdaJPQ=
X-Gm-Gg: Acq92OFdM8QOlUTRUEXLG4tJ79gKQc++wFS/HPENey3JX3kretmJw/Ni2BFZLEUJIPw
 ixCHVt9ImCaf99UG3y5xvMj5vtbGiAbx0GdSUx7Ogk1eZMzW10oVMNU0i4peo0oV1RPWLqxU/FK
 ctcSN9HrF7ufLcKGrcyguEuLzdZE+oIh7Od5MQlyV9VqBv5ekcAhxftA5luzBAB+iyiVTquelaI
 imUmM14S7RYlZh4J/bEIlxAqf6sQlvDhBgjPu+HI7wQmIdxVIx/n6LmCLcX9iqJXbX53l06Xnd3
 XDbyBei/WVwski5DlI718bxPQ0BC3Xoa/iqxKSKxD2omR2Qqu4urn3qGvYolnWGt77vA4SCXq97
 M032eOQXt/Xryus917deHhKntF24M8PTXxoeaVA66toVNhwIiBIcWBcHg
X-Received: by 2002:a17:903:228b:b0:2c0:d4a8:85d0 with SMTP id
 d9443c01a7336-2c1e85ac3e2mr205207015ad.32.1780961824879; 
 Mon, 08 Jun 2026 16:37:04 -0700 (PDT)
X-Received: by 2002:a17:903:228b:b0:2c0:d4a8:85d0 with SMTP id
 d9443c01a7336-2c1e85ac3e2mr205206635ad.32.1780961824482; 
 Mon, 08 Jun 2026 16:37:04 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c24edc8ad7sm66206975ad.42.2026.06.08.16.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 16:37:04 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 05:06:30 +0530
Subject: [PATCH 2/2] drm/msm/adreno: Add support for A704 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-shikra-gpu-v1-2-9d0e09cab115@oss.qualcomm.com>
References: <20260609-shikra-gpu-v1-0-9d0e09cab115@oss.qualcomm.com>
In-Reply-To: <20260609-shikra-gpu-v1-0-9d0e09cab115@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Aditya Sherawat <asherawa@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780961805; l=1082;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=o+EGLlf37sh89ugeHzfYo4ynac3l8aLtWkmBK6mfyPY=;
 b=WAHARlB/kFp7nJ5bwD9czp03Zj5uOELfpNZuGTQLexVSi0AyrJ8BSNj0HlgSyeHUAjYdqC+yH
 xd/nwL+m396AraiuLibFrrrja0zVM2Gu1nklO/BKVSCdEm7p7eTraOI
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=cverVV4i c=1 sm=1 tr=0 ts=6a275221 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=XFVbiEAxaSnpWCc0n_YA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: ryxHTVt2RKjPH3glj6R6B_FySMeDSXvc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDIxNyBTYWx0ZWRfX67ssfRaTFrcu
 Kw7w2SymHperzEthrrXJ/WIK/h1a30sUXj8JXs4ADeoarQSMRmgY1N3/y5Vbnbh5Yn6/ifqAV5g
 ukdY/DuqWa+5o/bqV66A2EIxVZQ2fWeicxJGvYJUKiWfZgDA1gx2/KQh/8Ot3Jrx4fiE47JEAL1
 NrzIE3ouj6p8+jnHsRjWh9qOppz7szPi9SiPCC3NRsYbllD3PMIv0bVAio07R/KcDN0TdSyeQyF
 3dKbzsfND+NTemgKg/Wp5TUVa4W6Yt2BhGRs5N+ud6v200tZcbqNRsufwmqEqY0bZf1MyTgs9sF
 0WaoUsl7G/Jsyiz9HrGoqJJUKMPom31hloloIEcehiWr3rMKiJuIhxoAw56V6yjN2UqLfrGabeP
 mnsORiQMToioJFJ0YsddX1BWnIIHINNp1e2euNkiSYyAcNN138tklbJPF5+RK9Vt0p69NOwwtT8
 8icqZwX++l/f+zDBifQ==
X-Proofpoint-GUID: ryxHTVt2RKjPH3glj6R6B_FySMeDSXvc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_06,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080217
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

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Adreno A704 GPU found in Shikra is an IP reuse of A702 GPU with very
minimal changes. The only KMD facing difference is the chipid and the
zap firmware which is specified via devicetree.

Just add the new chipid to enable support for A704 GPU in Shikra.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 3e6f409d13a2..2de3ab010135 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1454,7 +1454,7 @@ DECLARE_ADRENO_REGLIST_PIPE_LIST(a7xx_dyn_pwrup_reglist);
 
 static const struct adreno_info a7xx_gpus[] = {
 	{
-		.chip_ids = ADRENO_CHIP_IDS(0x07000200),
+		.chip_ids = ADRENO_CHIP_IDS(0x07000200, 0x07000400),
 		.family = ADRENO_6XX_GEN1, /* NOT a mistake! */
 		.fw = {
 			[ADRENO_FW_SQE] = "a702_sqe.fw",

-- 
2.51.0

