Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACF8606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Al1zAIWD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MMpM2nsy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 891BD10FF60;
	Thu,  5 Nov 2026 20:40:53 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5193310FE0A
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:40:33 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5KV0EZ1504675
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 20:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/5KWrOEwbVH
 X8LUqdgrY5bn+suQmLbg/Bjoecm/F41g=; b=Al1zAIWD+6wlTpykJoNw8YHTXIO
 yf7ZobYTscQsX/LDSc/+Lzv/zx91o9rCg2sFYHl0BMWAGydpDYcLrEwwnZ7tkEjs
 45PSbo4MXs4wGPXZIDPnEN87QqpxuLYEnBVbcDLWhqvn99vS601wH0rX1kZLPry/
 3vNL2NPAcDNbhUSVe6XCVSMMEVfgdH3ssC40S29Eu/y6/l1uSvDIXCQogjuqO0dg
 +828aoeWyy/vscCTzX8J1iOVkLZ8hAFqk/4zaUkuOcVq0cTGTiZ5h06d5YoZWjsX
 H4H9WbtOrIlKiNnGbbME16cA8l9Kb/z4FK3a4GaXAlvd1/R/DLc7Y/RXHLQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs0wg8159-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 20:40:32 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2eaf3f829b3so20199545ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 12:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793911231; x=1794516031;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/5KWrOEwbVHX8LUqdgrY5bn+suQmLbg/Bjoecm/F41g=;
 b=MMpM2nsyz2JV2JxoaVpFr9OnpAm3IbUQI4Ft9rh+kreO8chtFoP/M6xDHgeiVDgopb
 Jkv34WcO6zkuS6HDh+eBkD75/5soxyFjK7L/E4Zdrdi1BQUWLv05cYPYOGEcFNyW7GsT
 NAyIosKU/DSFO8YjJYqxt9thxTFAhQRILCXbbFURa0wMbgXwB2j+uaUhybxVp1lFI9KH
 V4y/7VA9NPk5jjIG40CAVZ345tIPaDHEKXhbIA8gPOCjMKRTdyUpx3Ple62/gSoHgRTp
 KKntR4jmCvVO9lPbLdLdA+r1o0vIu6avZgg5ok0rW6Tm1Tt+8wfLDTQQ1hJ2M7nRw/Mh
 d5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793911231; x=1794516031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/5KWrOEwbVHX8LUqdgrY5bn+suQmLbg/Bjoecm/F41g=;
 b=gJjScpSnIAnOIt2nSKo+HQO3tWU4JzU3jDIdDdEgNDcS/H+BgX9RAxa6kb0pqcUN/z
 hXP7CRpBUNm9MPbNFjy8rBqoxasvP4hXyUvlFjjUipnMeOyos17PvCMV+YuRi0S5M0FF
 4M47R43djl36s0+EWcsgyMM0k3MpndTNalxLoCAYbg6iLXNxvuRr37nJzPNRxOljzJW+
 HpsYC8oiQMNt8CX+Pa5sHlti6bfwDYRdg76zb5cfDEfxywVyRdFYWt640IzBSlJH6JqF
 tqnouKJXJaxbNPHg8zjNZcZjuhhC0dXEPVkdA5rHoxvRpi/F+tDT8o6KU5DXQoxwjowP
 GOdA==
X-Gm-Message-State: APuU4Z/eZIaY4UJ3HEjMvlio2Mk2JrzkrlOurks9J8qvr+s/vtSeYxf/
 V8bCm492etl34qh8uic8PbaUmIbB2Cmj9fH5Q5b0ms7Ed+Q/T8pMpLrUudzAG3adHFyGp21LSAM
 OyeeIjaRI2xMWNTjp6qOWrLGZcx3Xs7gCJErznt4h9pdJC8E6Xe2y6fGuxNWdaWoRIqjKLhCYPg
 Tb3Z4=
X-Gm-Gg: AYBFou26u241N8tu7I+Ga3QKQ3C845ezVyI83PHxtIA85a2BkB8KBdgm9R4sV0wi1EZ
 KHNLOtM8DMtHvhRgi6D0TaXYk3trMS9GV1ZmOHErf4mtiUleZkBRHQsiFV7PrEdh8jl7o+jlahC
 9VZzVG04XRgP6MgIc0toON20azk3M0EYoNPoKZqTPfOIl1n/8C4xWzMgBjP3yWmCUYXmdMgg15s
 mLjYzasQI2P6Qsa2MIxDBqqE1OuFn9xesN9i3QGaUJYC091fycbTKsolRTAlYu3DHBTRJ7autod
 QnA+YPK1/cSWmao4Gr/mkFPiDkwvDXK+IAY4OmOfFmT21QQ1ZCceoh9vzs61JuWSyN0Nv4Af9Za
 sr2fx39flCUDDKoxbXCa45b07RNi+yPzZgZgtfmkS/TGT4KKajNrBqCTde3D3HzdKHXijQGLViO
 II9qRdWI77x9YGv3UO6NOYrl1lI5Sa0Lkzer8DaqyoezcYjp8M4vBsFkIo9bNRGA==
X-Received: by 2002:a17:90b:3143:b0:3ac:9599:a689 with SMTP id
 98e67ed59e1d1-3b0db70569bmr142753a91.34.1793911231205; 
 Thu, 05 Nov 2026 12:40:31 -0800 (PST)
X-Received: by 2002:a17:90b:3143:b0:3ac:9599:a689 with SMTP id
 98e67ed59e1d1-3b0db70569bmr142726a91.34.1793911230710; 
 Thu, 05 Nov 2026 12:40:30 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b323c18fsm4953165a91.4.2026.11.05.12.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:40:29 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 05/15] drm/msm/a8xx: Add missing a850 ifpc reglist entries
Date: Thu,  5 Nov 2026 12:29:31 -0800
Message-ID: <20261105203057.66520-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
References: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PA6rv6O4sxhEBuCk8iUWweDv9cBerC7P
X-Authority-Analysis: v=2.4 cv=Ka9HIgYD c=1 sm=1 tr=0 ts=6aece9c0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=vdKEjRuvQ9rlgTdWijoA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX2Nijf3z/QIxc
 43tnatcl7GaennabytpgLioaq1uAn7mc6i230mmTkFSIzY69Ks9OQayMOmkKDou/EH/ybEXtg2a
 lvCNiF07FdqeJRCkvTCuOOevETDIA1reqjHhtew8mGAGXILijFDo0la4rzbrMJBaK+5BB24x4rO
 FJFDYg4Sp0+Nj9Nkj98/hg3w96NhkvnakbRAG0VI6+I6u0lEgr59H9I6eZyT41EzELVa7HzX7po
 t4AzWE2nsn1UCrf3cBtNgSO221hHBFbgnjdTpSz4WAJfWlTEoXnzqkPxbUoEQrgXxzWjH8/MoUX
 H3x1PQP2IHAH/9C0vNKxSxP4MZhGMORbJxrp7Ov6NDflWFcQRbdULxiaHmslPqbNYrzA0yoQ/aD
 33syTNQEaIOayehKk39nUEetm2yTtmcqs3M+cvrr8zzSRtLRx0jf5BftGiYRDfeEq04lKmxYxa/
 hLkpoKVhvAjjl8PkAHw==
X-Proofpoint-GUID: PA6rv6O4sxhEBuCk8iUWweDv9cBerC7P
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX8ujHNbcayXT1
 5Cqhu0elVLnX6fbWMH3uN91SsXDdxWQgnbMqFGNFQSDE0ekjs0LPaAwlD9QOdtnIa9HO6iWPEPN
 hvHeC9FFPxhdWoD0SDYbxOj8AjPfURo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050082
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

We want to save/restore all of the CP_PROTECT regs across IFPC.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
index a3eab0307529..dd1a5ca91812 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
@@ -1393,6 +1393,13 @@ static const u32 a850_ifpc_reglist_regs[] = {
 	REG_A8XX_CP_PROTECT_GLOBAL(53),
 	REG_A8XX_CP_PROTECT_GLOBAL(54),
 	REG_A8XX_CP_PROTECT_GLOBAL(55),
+	REG_A8XX_CP_PROTECT_GLOBAL(56),
+	REG_A8XX_CP_PROTECT_GLOBAL(57),
+	REG_A8XX_CP_PROTECT_GLOBAL(58),
+	REG_A8XX_CP_PROTECT_GLOBAL(59),
+	REG_A8XX_CP_PROTECT_GLOBAL(60),
+	REG_A8XX_CP_PROTECT_GLOBAL(61),
+	REG_A8XX_CP_PROTECT_GLOBAL(62),
 	REG_A8XX_CP_PROTECT_GLOBAL(63),
 };
 DECLARE_ADRENO_REGLIST_LIST(a850_ifpc_reglist);
-- 
2.56.0

