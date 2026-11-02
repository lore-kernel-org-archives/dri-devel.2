Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E926606D809
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LCVkhmNj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ljkm8pgh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0C3F10F25F;
	Mon,  2 Nov 2026 22:04:42 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 285C510F25F
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 22:04:31 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2K69RO3292637
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 22:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=en+kx17O9Hv
 lGJdYkQ6xEsXJtVuKpJWhTDhQIUh13CE=; b=LCVkhmNj7EOpMCgvx7D/X0eBjq3
 yfbkY2qbTlsMy5Gz56dOrdeW9SyZ5MUE7IELjLMlLk1INQdZJcfH7UtRxPftcU4p
 PaSXp6i5KsKm9MdvHsyk9Z9blpEeQk6iCUeHfTDTQYr9nASDdqYcgYphE7a+BO3d
 mwAMfrKrr0hG5QitarJwLh4yJXNDtPQ+r07s4q8OLr1JPW3t/PZzAA0a16LxZZa1
 gKYTNS38qylBPaSlTVIZesjOjU54pZc1CAzX45FlvJYIXlpRvHvMoSmInG815W/j
 I/EwsaysM9iD8QZsDCWPb1eqgokXunYdvB7ZaeVqezItFCdzETKeLNb3Ysg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq07egp64-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 22:04:30 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e8ad8c5f80so57634405ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 14:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793657070; x=1794261870;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=en+kx17O9HvlGJdYkQ6xEsXJtVuKpJWhTDhQIUh13CE=;
 b=Ljkm8pghgWfZcGU2AcRfGAtjAQ7jTaI+GesjYZt1XLiKsvEXEe/4eOSMK2ZuYiz1tc
 9qr7rRBuDtIez6xqElmQ4zSielSyuzcd1XgUkXsIXrMZE+VkwE9B1VVKeUnEa5CJdyye
 tH5Hvh+xDRNj1yKcVVPvH3oCN989mPsBqWR3ECeMgd4Y5qb1SuZ4N3GqRdtQeXRCVevt
 hPFRPLdV2DaC7MpSay3pOq7tvKzJYch9x+GeYN1h2CAR7dziXeW8XtdYB6RmsnS6Zgua
 CVt2GXXKAu4SuFTWY750Y3IltyO1mLwICC9rGfyFnHyjWzK5eblJ1FPaj+9B2vmM7d2v
 AALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793657070; x=1794261870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=en+kx17O9HvlGJdYkQ6xEsXJtVuKpJWhTDhQIUh13CE=;
 b=s3F8u3xVs80DoQUSz5M1xIs5+plJmuLbsrgbGm8a7/QcwCXAv4Ayg3BIN1qIUSzaKb
 HWgSljH3+pF5vYEPOL4uZ9LLNG4wT4MKececB8QOIH5jFBVfgD9CdAIzjOq+LEePgg+M
 31ntyjjiIARonSWg+1cNet8sYbMTtJTQOh2jRuKvYAcEUTCyHQWiK5QhCX06aWlkm/zy
 PAqhyCUJVIME/ch5/vcsSPOwBqXip04P8l0MMY5hm0Fa0fIs2tIg+9VuescesDqZswsZ
 cP5qXxiz0OXYVbETsYaiDasSDBNb/xQHzEeQS+QVCfbc9PMDG4Vhkaagss/IoAXk7Wil
 lWFw==
X-Gm-Message-State: APuU4Z9wvamWxqryyDER10FZeVsLSnaJPOi4fzHBj9BGR386wGD2oD+O
 4bfaqSXZS1Hs5NfUZ5Nyd4KMj9K/uOobGuBd5TSP1s3lOq5ere4kpIYOh44/VGpF6MAy2fPFdez
 CWKL2IFI9ARC0GD176WM2pHGo4y8kfAmEnzE0miX7D+XUOimWnynu6jFrQGkEQeAIpRjV+J2sqV
 ldDTZDlg==
X-Gm-Gg: AYBFou1CTOiXwgAhbtCIZE9Cd1UIeP2SYe2VXd1jN33QXUHWN5LlMt4pvChudZrykWA
 6TTi/8m1jd0rwX4aXZpw9ztz6m/XU6yewN/6y6FGDz+ZdTow+R2jj578/XlR9Txvdz1jU3jMKaq
 nDorZ37AggmnSVb7DQZhQG98wEcUaLI9guuxmeugJ/jQfFS/KWg6ES2uBO9hGjsvRjF3nJLQgEP
 AtvchGQwfb1wYeFk/nJI6D3Z1YVL1GbxoK/Ae9ojDo290tFrfaujD+ia5ZPYlfjA77tG69tLxUg
 EJ0Jj1xS2J/nhgguJhP+CBVGUFEudS7/i9W4HmFij1YYhzcYBCGPseKIVHZlfvndQbMKtrj17tu
 6C1xhAZWtGsRVcpE4WAyiq4aUOL5rGh7b1SilBWNBgo3g7lRbxmmWS6LER5yb0NHKTm/GkpVue9
 CICoXOFV7mVQVuwWWo+E42Zg==
X-Received: by 2002:a17:902:cec9:b0:2e8:5202:aa8c with SMTP id
 d9443c01a7336-2eb364f0a21mr107112905ad.48.1793657069850; 
 Mon, 02 Nov 2026 14:04:29 -0800 (PST)
X-Received: by 2002:a17:902:cec9:b0:2e8:5202:aa8c with SMTP id
 d9443c01a7336-2eb364f0a21mr107112705ad.48.1793657069391; 
 Mon, 02 Nov 2026 14:04:29 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb39248621sm31871825ad.28.2026.11.02.14.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 14:04:28 -0800 (PST)
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
Subject: [PATCH v5 05/15] drm/msm/a8xx: Add missing a850 ifpc reglist entries
Date: Mon,  2 Nov 2026 14:02:49 -0800
Message-ID: <20261102220405.30730-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
References: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfX0W+mNQn67wM7
 rkmUhjKq9u9or/o8ARWrO4+/yAq0Da+qqOypVO9UOyMb/htcVi27EmnsJNfFned58ER+wjRljcR
 MVe4LWpw8S2k7+dLdeYmBw5Y2wK9YmIZUMeVDNSQlLk7dgsXYiSY0Yat04+CVAgFhwafRcRCHOC
 jqJFPiukLRFDF6HuNui+icuOYZK3lT4isVeP+BerQkaX115Omcg/xS0DP6JxSNtQ0Laq1ojKejM
 pIixuz5AYJAHB5Q67heM+FeRZ3PGQi0kDsm89pdwfm/JFO7S88eNgwYAmRRQ8TGPcxBBGgV/im0
 ujO35SkTozR3UihQYHxIVJfp0zA+B/miVGnbIS4Cm7Q9y0sl0jXEilhnqmjnjsdf2QMDniLj92Q
 Syya5nTiXtYmGdoCF9aZhQq1PizVjqfEg6QaZ/qXUeQr32tOivmkSvEhdXqwaRf/EljZnIhpsu8
 k+jY/VtQOIaDz8VDofQ==
X-Proofpoint-ORIG-GUID: nrXvI-YSes83S4cVtgjgBkJ6UWDK9wIZ
X-Proofpoint-GUID: nrXvI-YSes83S4cVtgjgBkJ6UWDK9wIZ
X-Authority-Analysis: v=2.4 cv=B/wsQ+tM c=1 sm=1 tr=0 ts=6ae908ee cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=vdKEjRuvQ9rlgTdWijoA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfX6xRxFRVISvhC
 svTbYuBkbFKDte1C6ZupE0+mL4FDjZAj5wvYEYfLE2G0dMvcn8DQvR2QXPEDARbJPFyhBYiLdYa
 +FMMjdfvu6w8U6Q7wp/xez3jDY3qaRE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_06,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020087
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
index 55a805ab438c..45cd986ad4b5 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
@@ -1477,6 +1477,13 @@ static const u32 a850_ifpc_reglist_regs[] = {
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

