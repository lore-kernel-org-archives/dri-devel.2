Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D9A606EE8A
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iw5gepsJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UGamJRU4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51A6010FFAB;
	Thu,  5 Nov 2026 20:41:38 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF9FC10FF81
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:41:26 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5JL5oN751618
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 20:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=9lVQAxF8J8x
 pT0AO6KyTpWaXmqKQST6hyioFUounuDE=; b=iw5gepsJ0gRDsLPJNFI7DXh9IGx
 GwuqRkojOlZ3r971T6GFIcQ6+HwH0Us/7K0+Giu5Z+USmZNG70mkQJrJplzsphtb
 K4GtoXrhSYDHAT5mS6h21ahJUUW1Wn2MQZIzTX5PywM5r5wVLrSz55uLQYR0x8PW
 iPNlF4l0qMkt6gk7ws0DzNQkc50wz9Qnb999yhGY21oMCtNPzk2CRtzo1oOZYeB4
 yRa0FEw5EBlEWIhHXK/rDDV0eb+CqJmBFaHHuBh1EStsq1qqvRsBxbQ15pbsVq5h
 2Jtb+5fZwKQXam/43OFmVJ29uqa20Y/QoNEXic2niUmK5grVbDxC9OrIrDw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hryvp8ace-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 20:41:26 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3aed1b64104so3212256a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 12:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793911285; x=1794516085;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9lVQAxF8J8xpT0AO6KyTpWaXmqKQST6hyioFUounuDE=;
 b=UGamJRU4JiRMyDUDfOqqWir2QR6s+f/v7zqkE5Yeeu0baN8FvvymkatPE0Tn/q/q6l
 WvRsrzmMW+oDHaq6tvlSCif9SdBaAypHRzaUGeAqXiECObwSSAvCqDpARAMDWnX3Qf5Z
 GIdzGAQLaRGUNwc16MbJRZsBfVWww4ClWKRNReM9Uk39FpJ8HH9Zf2PWlUDi9+XhjcTF
 XiJoMIg6amoyAwEXiqLqBwc4suUZdMe2gEyo4z4XAbiNsouHQx9b8e2/h5Y59HWCnFOp
 5b4uYAltH9vpfS3uJV7HEopl9F59WAQCyGfSh6y3Gx5BIaAfuAG2OtVPf6m6Zf2s1v8W
 JfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793911285; x=1794516085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9lVQAxF8J8xpT0AO6KyTpWaXmqKQST6hyioFUounuDE=;
 b=YEjQweXW0B1NhWyvFv0l1E8yCyZLUK91yfwY8la+deeXMIryCATpclm3AMSSjzjG+2
 3/J5r8ShCINXPeaIFhWVVw7MNYvtueU4EZErMeuG8qDc6Ar8EbFh3yZDKua5xt8ntA70
 o0jGQGV3JEPEFiQbY67+pR9irlncqNr3dDu/R8FzFNGHRyfNh9pVsce95vScdpCHCHNZ
 TVN5ckJ14ywq3d2C95kOMJIUgtpWAvI3IxBN7dBNS1dkdwpDYBAXvsMDrZFbtorljBSu
 +mIRUWikobsDl2RixONmIIvOniVs/LYidOERfrNSuOAhtvl9DeHs8C2LCcVY3uIv2aIX
 FkLw==
X-Gm-Message-State: APuU4Z83jTiv+1s1ErS3DtGteATCx3ckqXyIQWrFvEwk6hf3xGcc/nKR
 naI6b1WzUJ+B/G2b1G4fK4cnJ3EaDMLZ2IhxSwEWL81cLEx9Mg9INx7IqlYGO/VyzG0uXTSkCIg
 TpP0yquUyKqAVJ/WFIzja2RN8kxTsrAH2cq5wtbi8NgcJ7Lb4+Sdz3THKIJJlC/8PfUvzEIWWEh
 LuVcc=
X-Gm-Gg: AYBFou1cqA8BWYm1CxOCe3jToP8B+u0R20OsCDOsE1g6ZPyYbCG8RiPeZIypkag+c29
 V5LuAtdF+e0yJDIKV9f1oUSYMFsUS33Cf1vvP6rljirFxPxJoi6jBHLRnhbuLtbDGrxzEEo5AG9
 rV9vlqKiiI52XIqThXnbYDDahHVQfIaMUf2FDPf6pNU9VVKyeUbrUzNKaqXuyTg3Ws36FQYqb23
 AOZdfXz06KWcqiFKpm1v1cqCOYbz3l6euRXyVfMEuRyhU+J/5QpB60TD2wKEoS4lTjPq2DCRx8F
 nDHhdUebWAXGImw+MbQP9pN93EaQ6oDl/SbI3B8ih2/7ml1+brgKzPokZa3OJaM3ZzUjWAPjgzw
 BK6Z6Cg061Q2wHAVah+sXRbEpFmwJK/RudnaMz4Akk6yL/gYiCHizee0630Nd02LhVu6PAVl4sT
 PBEc4cIfyy2uO4G8DJogABXL7zw6ODWxBObFWztQ9q+4Y8kNGYZI2de90STypE
X-Received: by 2002:a17:90b:58c7:b0:3b0:9ebf:3ef9 with SMTP id
 98e67ed59e1d1-3b0db03619bmr255271a91.0.1793911285263; 
 Thu, 05 Nov 2026 12:41:25 -0800 (PST)
X-Received: by 2002:a17:90b:58c7:b0:3b0:9ebf:3ef9 with SMTP id
 98e67ed59e1d1-3b0db03619bmr255239a91.0.1793911284720; 
 Thu, 05 Nov 2026 12:41:24 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0d7c8ff96sm600069a91.13.2026.11.05.12.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:41:23 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 14/15] drm/msm/a8xx: Switch to generated protect regs
Date: Thu,  5 Nov 2026 12:29:40 -0800
Message-ID: <20261105203057.66520-15-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
References: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ib4Symqa c=1 sm=1 tr=0 ts=6aece9f6 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=JcQOObtfp6PrThPhMQoA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: FZIcldEhgbPi47rxK1_qBCa3QJgKwt80
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX4wAGWMHKuVJS
 ss3Bu/WlEVRBEVPDvBzbR0Izoeccw+5xGZ1shtQTnGQfXiSXiK444XUhbbtUyTBVSz1U+Bb9/ZU
 oseSfCHse0YlnJSivxFcur5Q1zVO/I8MmyFEHsd6Ix4UpHbwj1cECCiIcJ3vnQk/SWkCnC1GaRG
 xdtVd2AAO5aazJS/REqbXOKkhDbVAhv/xJkuOFyZidA2QYyrtJkrabJOfTo8l1TvA76iQAN/Vzt
 VAa3qLDhJXw+p3te6+sV4o8OKGY8+sy10N6b2KbBNBMohOc1hfLuWHBQuGaUcZQIXceyMO5jIhM
 owVlbktQrnWt37eNB/bzqD+txa4M1Wmh3tuxOhZwtfmigsXIWdYFzMOx2Kc3XkdaJYx02IvTkhb
 4ADjsSlOSz9TLVFToatGP25m1MykuRkqfa6PwhxpjFDMljFmMt7RFD5tfpbrzAgTHg0Aa6amOBW
 m21RHV0FAVvmOPlCsYQ==
X-Proofpoint-ORIG-GUID: FZIcldEhgbPi47rxK1_qBCa3QJgKwt80
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX1tIGPpfUqKpj
 W5E4EC1rNU02EF8bUoeewtSA8mpxw+wFT2EdWxn/3UwZq5pOq1qtTOMg5KrSgVzFv4bA3F9H9we
 wivyD1m1igdeslTSLW1I9aGEaC/xOlk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050082
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These also fix some perfcntr SEL regs which were mistakenly blocked
since we previously just copied the protect tables from downstream kgsl
(and only sometimes remembered to fix these).

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 301 +---------------------
 1 file changed, 13 insertions(+), 288 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
index 113a31158f8f..510c2f6017db 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
@@ -82,58 +82,6 @@ static const struct adreno_reglist_pipe a830_nonctxt_regs[] = {
 	{ },
 };
 
-static const u32 a830_protect_regs[] = {
-	A6XX_PROTECT_RDONLY(0x00000, 0x03a3),
-	A6XX_PROTECT_RDONLY(0x003b4, 0x008b),
-	A6XX_PROTECT_NORDWR(0x00440, 0x001f),
-	A6XX_PROTECT_RDONLY(0x00580, 0x005f),
-	A6XX_PROTECT_NORDWR(0x005e0, 0x011f),
-	A6XX_PROTECT_RDONLY(0x0074a, 0x0005),
-	A6XX_PROTECT_RDONLY(0x00759, 0x0026),
-	A6XX_PROTECT_RDONLY(0x00789, 0x0000),
-	A6XX_PROTECT_RDONLY(0x0078c, 0x0013),
-	A6XX_PROTECT_NORDWR(0x00800, 0x0029),
-	A6XX_PROTECT_NORDWR(0x00837, 0x00af),
-	A6XX_PROTECT_RDONLY(0x008e7, 0x00c9),
-	A6XX_PROTECT_NORDWR(0x008ec, 0x00c3),
-	A6XX_PROTECT_NORDWR(0x009b1, 0x0250),
-	A6XX_PROTECT_RDONLY(0x00ce0, 0x0001),
-	A6XX_PROTECT_RDONLY(0x00df0, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00df1, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00e01, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00e03, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x03c00, 0x00c5),
-	A6XX_PROTECT_RDONLY(0x03cc6, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x08600, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x08e00, 0x00ff),
-	A6XX_PROTECT_RDONLY(0x08f00, 0x0000),
-	A6XX_PROTECT_NORDWR(0x08f01, 0x01be),
-	A6XX_PROTECT_NORDWR(0x09600, 0x01ff),
-	A6XX_PROTECT_RDONLY(0x0981a, 0x02e5),
-	A6XX_PROTECT_NORDWR(0x09e00, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x0a600, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x0ae00, 0x0000),
-	A6XX_PROTECT_NORDWR(0x0ae02, 0x0004),
-	A6XX_PROTECT_NORDWR(0x0ae08, 0x0006),
-	A6XX_PROTECT_NORDWR(0x0ae10, 0x036f),
-	A6XX_PROTECT_NORDWR(0x0b600, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x0dc00, 0x1fff),
-	A6XX_PROTECT_RDONLY(0x0fc00, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x18400, 0x003f),
-	A6XX_PROTECT_RDONLY(0x18440, 0x013f),
-	A6XX_PROTECT_NORDWR(0x18580, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x1b400, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x1f400, 0x0477),
-	A6XX_PROTECT_RDONLY(0x1f878, 0x0787),
-	A6XX_PROTECT_NORDWR(0x1f930, 0x0329),
-	A6XX_PROTECT_NORDWR(0x20000, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x27800, 0x007f),
-	A6XX_PROTECT_RDONLY(0x27880, 0x0381),
-	A6XX_PROTECT_NORDWR(0x27882, 0x0001),
-	A6XX_PROTECT_NORDWR(0x27c02, 0x0000),
-};
-DECLARE_ADRENO_PROTECT(a830_protect, 64);
-
 static const u32 a830_pwrup_reglist_regs[] = {
 	REG_A6XX_UCHE_MODE_CNTL,
 	REG_A8XX_UCHE_VARB_IDLE_TIMEOUT,
@@ -364,63 +312,6 @@ static const struct adreno_reglist_pipe x285_nonctxt_regs[] = {
 	{ },
 };
 
-static const u32 x285_protect_regs[] = {
-	A6XX_PROTECT_RDONLY(0x00008, 0x039b),
-	A6XX_PROTECT_RDONLY(0x003b4, 0x008b),
-	A6XX_PROTECT_NORDWR(0x00440, 0x001f),
-	A6XX_PROTECT_RDONLY(0x00580, 0x005f),
-	A6XX_PROTECT_NORDWR(0x005e0, 0x011f),
-	A6XX_PROTECT_RDONLY(0x0074a, 0x0005),
-	A6XX_PROTECT_RDONLY(0x00759, 0x0026),
-	A6XX_PROTECT_RDONLY(0x00789, 0x0000),
-	A6XX_PROTECT_RDONLY(0x0078c, 0x0013),
-	A6XX_PROTECT_NORDWR(0x00800, 0x0029),
-	A6XX_PROTECT_NORDWR(0x0082c, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00837, 0x00af),
-	A6XX_PROTECT_RDONLY(0x008e7, 0x00c9),
-	A6XX_PROTECT_NORDWR(0x008ec, 0x00c3),
-	A6XX_PROTECT_NORDWR(0x009b1, 0x0250),
-	A6XX_PROTECT_RDONLY(0x00ce0, 0x0001),
-	A6XX_PROTECT_RDONLY(0x00df0, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00df1, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00e01, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00e03, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x03c00, 0x00c5),
-	A6XX_PROTECT_RDONLY(0x03cc6, 0x0039),
-	A6XX_PROTECT_NORDWR(0x03d00, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x08600, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x08e00, 0x00ff),
-	A6XX_PROTECT_RDONLY(0x08f00, 0x0000),
-	A6XX_PROTECT_NORDWR(0x08f01, 0x01be),
-	A6XX_PROTECT_NORDWR(0x09600, 0x01ff),
-	A6XX_PROTECT_RDONLY(0x0981a, 0x02e5),
-	A6XX_PROTECT_NORDWR(0x09e00, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x0a600, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x0a82e, 0x0000),
-	A6XX_PROTECT_NORDWR(0x0ae00, 0x0006),
-	A6XX_PROTECT_NORDWR(0x0ae08, 0x0006),
-	A6XX_PROTECT_NORDWR(0x0ae10, 0x00bf),
-	A6XX_PROTECT_RDONLY(0x0aed0, 0x002f),
-	A6XX_PROTECT_NORDWR(0x0af00, 0x027f),
-	A6XX_PROTECT_NORDWR(0x0b600, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x0dc00, 0x1fff),
-	A6XX_PROTECT_RDONLY(0x0fc00, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x18400, 0x003f),
-	A6XX_PROTECT_RDONLY(0x18440, 0x013f),
-	A6XX_PROTECT_NORDWR(0x18580, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x1b400, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x1f400, 0x0477),
-	A6XX_PROTECT_RDONLY(0x1f878, 0x0507),
-	A6XX_PROTECT_NORDWR(0x1f930, 0x0329),
-	A6XX_PROTECT_NORDWR(0x1fd80, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x27800, 0x007f),
-	A6XX_PROTECT_RDONLY(0x27880, 0x0385),
-	A6XX_PROTECT_NORDWR(0x27882, 0x000a),
-	A6XX_PROTECT_NORDWR(0x27c06, 0x0000),
-};
-
-DECLARE_ADRENO_PROTECT(x285_protect, 15);
-
 static const struct adreno_reglist_pipe x285_dyn_pwrup_reglist_regs[] = {
 	{ REG_A8XX_GRAS_TSEFE_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
 	{ REG_A8XX_GRAS_NC_MODE_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
@@ -522,57 +413,6 @@ static const struct adreno_reglist_pipe a810_nonctxt_regs[] = {
 	{ },
 };
 
-static const u32 a810_protect_regs[] = {
-	A6XX_PROTECT_RDONLY(0x00000, 0x03a3),
-	A6XX_PROTECT_RDONLY(0x003b4, 0x008b),
-	A6XX_PROTECT_NORDWR(0x00440, 0x001f),
-	A6XX_PROTECT_RDONLY(0x00580, 0x005f),
-	A6XX_PROTECT_NORDWR(0x005e0, 0x011f),
-	A6XX_PROTECT_RDONLY(0x0074a, 0x0005),
-	A6XX_PROTECT_RDONLY(0x00759, 0x0026),
-	A6XX_PROTECT_RDONLY(0x00789, 0x0000),
-	A6XX_PROTECT_RDONLY(0x0078c, 0x0013),
-	A6XX_PROTECT_NORDWR(0x00800, 0x0029),
-	A6XX_PROTECT_NORDWR(0x00837, 0x00af),
-	A6XX_PROTECT_RDONLY(0x008e7, 0x00c9),
-	A6XX_PROTECT_NORDWR(0x008ec, 0x00c3),
-	A6XX_PROTECT_NORDWR(0x009b1, 0x0250),
-	A6XX_PROTECT_RDONLY(0x00ce0, 0x0001),
-	A6XX_PROTECT_RDONLY(0x00df0, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00df1, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00e01, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00e03, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x03c00, 0x00c5),
-	A6XX_PROTECT_RDONLY(0x03cc6, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x08600, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x08e00, 0x00ff),
-	A6XX_PROTECT_RDONLY(0x08f00, 0x0000),
-	A6XX_PROTECT_NORDWR(0x08f01, 0x01be),
-	A6XX_PROTECT_NORDWR(0x09600, 0x01ff),
-	A6XX_PROTECT_RDONLY(0x0981a, 0x02e5),
-	A6XX_PROTECT_NORDWR(0x09e00, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x0a600, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x0ae00, 0x0006),
-	A6XX_PROTECT_NORDWR(0x0ae08, 0x0006),
-	A6XX_PROTECT_NORDWR(0x0ae10, 0x036f),
-	A6XX_PROTECT_NORDWR(0x0b600, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x0dc00, 0x1fff),
-	A6XX_PROTECT_RDONLY(0x0fc00, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x18400, 0x003f),
-	A6XX_PROTECT_RDONLY(0x18440, 0x013f),
-	A6XX_PROTECT_NORDWR(0x18580, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x1b400, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x1f400, 0x0477),
-	A6XX_PROTECT_RDONLY(0x1f878, 0x0787),
-	A6XX_PROTECT_NORDWR(0x1f930, 0x0329),
-	A6XX_PROTECT_NORDWR(0x20000, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x27800, 0x007f),
-	A6XX_PROTECT_RDONLY(0x27880, 0x0381),
-	A6XX_PROTECT_NORDWR(0x27882, 0x0001),
-	A6XX_PROTECT_NORDWR(0x27c02, 0x0000),
-};
-DECLARE_ADRENO_PROTECT(a810_protect, 64);
-
 static const uint32_t a810_pwrup_reglist_regs[] = {
 	REG_A6XX_UCHE_MODE_CNTL,
 	REG_A8XX_UCHE_VARB_IDLE_TIMEOUT,
@@ -805,64 +645,6 @@ static const struct adreno_reglist_pipe a840_nonctxt_regs[] = {
 	{ },
 };
 
-static const u32 a840_protect_regs[] = {
-	A6XX_PROTECT_RDONLY(0x00008, 0x039b),
-	A6XX_PROTECT_RDONLY(0x003b4, 0x008b),
-	A6XX_PROTECT_NORDWR(0x00440, 0x001f),
-	A6XX_PROTECT_RDONLY(0x00580, 0x005f),
-	A6XX_PROTECT_NORDWR(0x005e0, 0x011f),
-	A6XX_PROTECT_RDONLY(0x0074a, 0x0005),
-	A6XX_PROTECT_RDONLY(0x00759, 0x001b),
-	A6XX_PROTECT_NORDWR(0x00775, 0x000a),
-	A6XX_PROTECT_RDONLY(0x00789, 0x0000),
-	A6XX_PROTECT_RDONLY(0x0078c, 0x0013),
-	A6XX_PROTECT_NORDWR(0x00800, 0x0029),
-	A6XX_PROTECT_NORDWR(0x00837, 0x00af),
-	A6XX_PROTECT_RDONLY(0x008e7, 0x00c9),
-	A6XX_PROTECT_NORDWR(0x008ec, 0x00c3),
-	A6XX_PROTECT_NORDWR(0x009b1, 0x0250),
-	A6XX_PROTECT_NORDWR(0x00c07, 0x0008),
-	A6XX_PROTECT_RDONLY(0x00ce0, 0x0001),
-	A6XX_PROTECT_RDONLY(0x00df0, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00df1, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00e01, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00e03, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x03c00, 0x00c5),
-	A6XX_PROTECT_RDONLY(0x03cc6, 0x0039),
-	A6XX_PROTECT_NORDWR(0x03d00, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x08600, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x08e00, 0x00ff),
-	A6XX_PROTECT_RDONLY(0x08f00, 0x0000),
-	A6XX_PROTECT_NORDWR(0x08f01, 0x01be),
-	A6XX_PROTECT_NORDWR(0x09600, 0x01ff),
-	A6XX_PROTECT_RDONLY(0x0981a, 0x02e5),
-	A6XX_PROTECT_NORDWR(0x09e00, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x0a600, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x0a82e, 0x0000),
-	A6XX_PROTECT_NORDWR(0x0ae00, 0x0000),
-	A6XX_PROTECT_NORDWR(0x0ae02, 0x0004),
-	A6XX_PROTECT_NORDWR(0x0ae08, 0x0006),
-	A6XX_PROTECT_NORDWR(0x0ae10, 0x00bf),
-	A6XX_PROTECT_RDONLY(0x0aed0, 0x002f),
-	A6XX_PROTECT_NORDWR(0x0af00, 0x027f),
-	A6XX_PROTECT_NORDWR(0x0b600, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x0dc00, 0x1fff),
-	A6XX_PROTECT_RDONLY(0x0fc00, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x18400, 0x003f),
-	A6XX_PROTECT_RDONLY(0x18440, 0x013f),
-	A6XX_PROTECT_NORDWR(0x18580, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x1b400, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x1f400, 0x0477),
-	A6XX_PROTECT_RDONLY(0x1f878, 0x0507),
-	A6XX_PROTECT_NORDWR(0x1f930, 0x0329),
-	A6XX_PROTECT_NORDWR(0x1fd80, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x27800, 0x007f),
-	A6XX_PROTECT_RDONLY(0x27880, 0x0385),
-	A6XX_PROTECT_NORDWR(0x27882, 0x0009),
-	A6XX_PROTECT_NORDWR(0x27c06, 0x0000),
-};
-DECLARE_ADRENO_PROTECT(a840_protect, 15);
-
 static const struct adreno_reglist a840_gbif[] = {
 	{ REG_A6XX_GBIF_QSB_SIDE0, 0x00071e20 },
 	{ REG_A6XX_GBIF_QSB_SIDE1, 0x00071e20 },
@@ -1266,67 +1048,6 @@ static const struct adreno_reglist_pipe a850_nonctxt_regs[] = {
 	{ },
 };
 
-static const u32 a850_protect_regs[] = {
-	A6XX_PROTECT_RDONLY(0x00008, 0x039b),
-	A6XX_PROTECT_RDONLY(0x003b4, 0x008b),
-	A6XX_PROTECT_NORDWR(0x00440, 0x001f),
-	A6XX_PROTECT_RDONLY(0x00580, 0x005f),
-	A6XX_PROTECT_NORDWR(0x005e0, 0x011f),
-	A6XX_PROTECT_RDONLY(0x0074a, 0x0005),
-	A6XX_PROTECT_RDONLY(0x00759, 0x001b),
-	A6XX_PROTECT_NORDWR(0x00775, 0x000a),
-	A6XX_PROTECT_RDONLY(0x00789, 0x0000),
-	A6XX_PROTECT_RDONLY(0x0078c, 0x0013),
-	A6XX_PROTECT_NORDWR(0x00800, 0x0029),
-	A6XX_PROTECT_NORDWR(0x00837, 0x00af),
-	A6XX_PROTECT_RDONLY(0x008e7, 0x00c9),
-	A6XX_PROTECT_NORDWR(0x008ec, 0x00c3),
-	A6XX_PROTECT_NORDWR(0x009b1, 0x0250),
-	A6XX_PROTECT_NORDWR(0x00c07, 0x0008),
-	A6XX_PROTECT_RDONLY(0x00ce0, 0x0001),
-	A6XX_PROTECT_RDONLY(0x00df0, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00df1, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00df5, 0x0003),
-	A6XX_PROTECT_RDONLY(0x00df9, 0x0007),
-	A6XX_PROTECT_NORDWR(0x00e01, 0x0000),
-	A6XX_PROTECT_NORDWR(0x00e03, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x03c00, 0x00c5),
-	A6XX_PROTECT_RDONLY(0x03cc6, 0x0039),
-	A6XX_PROTECT_NORDWR(0x03d00, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x08600, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x08e00, 0x00ff),
-	A6XX_PROTECT_RDONLY(0x08f00, 0x0000),
-	A6XX_PROTECT_NORDWR(0x08f01, 0x01be),
-	A6XX_PROTECT_NORDWR(0x09600, 0x01ff),
-	A6XX_PROTECT_RDONLY(0x0981a, 0x02e5),
-	A6XX_PROTECT_NORDWR(0x09e00, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x0a600, 0x01ff),
-	A6XX_PROTECT_NORDWR(0x0a82e, 0x0000),
-	A6XX_PROTECT_NORDWR(0x0ae00, 0x0000),
-	A6XX_PROTECT_NORDWR(0x0ae02, 0x0004),
-	A6XX_PROTECT_NORDWR(0x0ae08, 0x0006),
-	A6XX_PROTECT_NORDWR(0x0ae10, 0x00bf),
-	A6XX_PROTECT_RDONLY(0x0aed0, 0x002f),
-	A6XX_PROTECT_NORDWR(0x0af00, 0x027f),
-	A6XX_PROTECT_NORDWR(0x0b600, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x0dc00, 0x1fff),
-	A6XX_PROTECT_RDONLY(0x0fc00, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x18400, 0x003f),
-	A6XX_PROTECT_RDONLY(0x18440, 0x013f),
-	A6XX_PROTECT_NORDWR(0x18580, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x1ac00, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x1cc00, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x1f400, 0x0477),
-	A6XX_PROTECT_RDONLY(0x1f878, 0x0507),
-	A6XX_PROTECT_NORDWR(0x1f930, 0x0329),
-	A6XX_PROTECT_NORDWR(0x1fd80, 0x1fff),
-	A6XX_PROTECT_NORDWR(0x27800, 0x007f),
-	A6XX_PROTECT_RDONLY(0x27880, 0x0385),
-	A6XX_PROTECT_NORDWR(0x27882, 0x0035),
-	A6XX_PROTECT_NORDWR(0x27c06, 0x0000),
-};
-DECLARE_ADRENO_PROTECT(a850_protect, 15);
-
 static const u32 a850_pwrup_reglist_regs[] = {
 	REG_A8XX_RB_CMP_NC_MODE_CNTL,
 	REG_A8XX_SP_HLSQ_GC_GMEM_RANGE_MIN,
@@ -1547,7 +1268,7 @@ static const struct adreno_info a8xx_gpus[] = {
 			  ADRENO_QUIRK_IFPC,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
-			.protect = &a830_protect,
+			.protect = &pakala_protect,
 			.nonctxt_reglist = a830_nonctxt_regs,
 			.pwrup_reglist = &a830_pwrup_reglist,
 			.dyn_pwrup_reglist = &a830_dyn_pwrup_reglist,
@@ -1593,7 +1314,7 @@ static const struct adreno_info a8xx_gpus[] = {
 			  ADRENO_QUIRK_SOFTFUSE,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
-			.protect = &x285_protect,
+			.protect = &glymur_protect,
 			.nonctxt_reglist = x285_nonctxt_regs,
 			.pwrup_reglist = &a840_pwrup_reglist,
 			.dyn_pwrup_reglist = &x285_dyn_pwrup_reglist,
@@ -1636,7 +1357,7 @@ static const struct adreno_info a8xx_gpus[] = {
 			  ADRENO_QUIRK_IFPC,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
-			.protect = &a840_protect,
+			.protect = &kaanapali_protect,
 			.nonctxt_reglist = a840_nonctxt_regs,
 			.pwrup_reglist = &a840_pwrup_reglist,
 			.dyn_pwrup_reglist = &a840_dyn_pwrup_reglist,
@@ -1682,7 +1403,7 @@ static const struct adreno_info a8xx_gpus[] = {
 		.funcs = &a8xx_gpu_funcs,
 		.zapfw = "gen80300_zap.mbn",
 		.a6xx = &(const struct a6xx_info) {
-			.protect = &a810_protect,
+			.protect = &milos_protect,
 			.nonctxt_reglist = a810_nonctxt_regs,
 			.pwrup_reglist = &a810_pwrup_reglist,
 			.dyn_pwrup_reglist = &a810_dyn_pwrup_reglist,
@@ -1725,7 +1446,7 @@ static const struct adreno_info a8xx_gpus[] = {
 			  ADRENO_QUIRK_SOFTFUSE,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
-			.protect = &x285_protect,
+			.protect = &glymur_protect,
 			.nonctxt_reglist = x285_nonctxt_regs,
 			.pwrup_reglist = &a840_pwrup_reglist,
 			.dyn_pwrup_reglist = &x285_dyn_pwrup_reglist,
@@ -1768,7 +1489,7 @@ static const struct adreno_info a8xx_gpus[] = {
 			  ADRENO_QUIRK_IFPC,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
-			.protect = &a850_protect,
+			.protect = &maili_protect,
 			.nonctxt_reglist = a845_nonctxt_regs,
 			.pwrup_reglist = &a850_pwrup_reglist,
 			.dyn_pwrup_reglist = &a850_dyn_pwrup_reglist,
@@ -1812,7 +1533,7 @@ static const struct adreno_info a8xx_gpus[] = {
 			  ADRENO_QUIRK_IFPC,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
-			.protect = &a850_protect,
+			.protect = &hawi_protect,
 			.nonctxt_reglist = a850_nonctxt_regs,
 			.pwrup_reglist = &a850_pwrup_reglist,
 			.dyn_pwrup_reglist = &a850_dyn_pwrup_reglist,
@@ -1847,6 +1568,10 @@ DECLARE_ADRENO_GPULIST(a8xx);
 
 static inline __always_unused void __build_asserts(void)
 {
-	BUILD_BUG_ON(a810_protect.count > a810_protect.count_max);
-	BUILD_BUG_ON(a830_protect.count > a830_protect.count_max);
+	BUILD_BUG_ON(glymur_protect.count > glymur_protect.count_max);
+	BUILD_BUG_ON(hawi_protect.count > hawi_protect.count_max);
+	BUILD_BUG_ON(kaanapali_protect.count > kaanapali_protect.count_max);
+	BUILD_BUG_ON(maili_protect.count > maili_protect.count_max);
+	BUILD_BUG_ON(milos_protect.count > milos_protect.count_max);
+	BUILD_BUG_ON(pakala_protect.count > pakala_protect.count_max);
 }
-- 
2.56.0

