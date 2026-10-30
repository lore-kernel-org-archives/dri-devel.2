Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD38A606A9B4
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gUSrY7Xv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YN4PBBEk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D22B5112A07;
	Fri, 30 Oct 2026 21:21:16 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABFDC112A0D
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:20:27 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULHG6R838483
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ovlz4gF7UuK
 dsBKx18X3wSAO5fthlyr8X5UKTNFLFCc=; b=gUSrY7XvWsquyvuwzRGEhI1d2jD
 TVOvm/CpWxuaThqBCwwQzeBHn1f7KK7eUD6sIo+eHalNa4jvdtb+HtlkIhHGCtzN
 5nC/4Ikcuj3F4okrui0JIX9pHy5Al9iUR5rwkhChXwLOccCLHrZQ1WBRPUZGuGVk
 UKaBaMLyCO4BMSa8DiA5x+m9DcN/mJhhDT5qXS9UuscxH4udVriOO5pyM1SKj7pw
 x/eMla6GHqSApI+7IpA1lT6ZsxE5dGg9zgaD51Dz7viBe8syGLJGzBGCawDexFZ1
 VrL5DntdDpsTWB+SfgGkCQXwZumsb3OfWJHsEN+4Yo61/5GcjmPcbq8p/gg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x081nw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:20:26 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ab7f1efe5dso1989429a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395226; x=1794000026;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ovlz4gF7UuKdsBKx18X3wSAO5fthlyr8X5UKTNFLFCc=;
 b=YN4PBBEk55HRfNuwO6kptSJBkGfToO7/an7jD+9U+Cnp9XwFDd5v4pvJN1Je5dProS
 bEXuCJmZtPrLMbeSTlsm5A7Glm7V1bZ3DzRdasZP0HB3eeJMzzk+Ubxe7UH5JUnfPDVp
 uXt9so+Rp3HyyThSvd22+mU+ZHCwOdj/mNvuPTOcyoUZq3NdfB9B54nzIa/X324ORalu
 yqt/zYbnNZwMIODqFi9Xsaihp0dxNY6ZCcXzVnHCFOk23lDZ+3xjVO2urnG5JkBo6KZI
 W2RSoKAyJodpjCpFfwx9kFBUXHNWVZ+78YatQsGk9hy2IaOjgv71V3QSOm8iiFvRCH/z
 foRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395226; x=1794000026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ovlz4gF7UuKdsBKx18X3wSAO5fthlyr8X5UKTNFLFCc=;
 b=IV5dpyiIL2uk4wrEpF5SDbkKv+8UH/m+kY8svWSuvzCKZDHoDRQT8pKd3YzMBMTsQX
 Myd3VF44urjRI0OfWoq5HxMdeQ9/DcgVd00r/ZG6et3JOgmWu7L9UzB4zjvqm03pbbSN
 5wuRSZmAD4iYVzt27lw5t0ulsqU93f8JpvJ6IIBRwUsY7DDW61B48yjoPvQd9/ZCs36Z
 YHyapbuisWh1+8MolOc7iijTm+tVyHiI+amk0Y8SZrPBUl0vPXwjR3rvvXW/aD86UXE3
 mQtucWabb22SGjDfvLq1OFMaAYL1H7oTjsXQeg1xL8WURNpHNginyns9cejXwIlUHbqs
 H6Kw==
X-Gm-Message-State: AFq9FYKic+/9w7vuSHN8xaRzlI4W5J7m7VhhmlT0MJEnm+11BV3aF/WP
 s3CMJOhc3hSUwwGyypEF9hjGph3WzmrzGIrHLHm6p8QBR8yl8Uy/rgbdGViOrDugWFNxV6P+Ccy
 1gxbAv6voV6t9Dgv4knWw1miP8F5ToA0CF5dQPvNwBmEnwWib7nBrXpneBrGWN83oYwzgbaz0jS
 LN088=
X-Gm-Gg: AYBFou26CHftSjw56Bv+r0O1+s239M3VKTywYAF97XrebbG38fQixXFrkhh5aX3TdnY
 fKaf0yjDDdY/rTVSK0Fe73dH1zhaPWEbQ0/dKFVtoK6TvEp2rem9zC5pV+WnjdastcL1To8KYec
 JaERwiqiUUevCFmJ2eThtcTSy8NVDCLHdlQj2Zel7xf/yl7eiAiSAxgUjIxy9zCOvkTKpTyCu76
 oKa8w45iiQF2kugkgJooUqriUJ3C6IZv3Shz1ooA6vAQdZilIgzAKmIfu1cCUjRXXDYUPzNHCt9
 NTeXrnHBwyjw3swNWk5FOzU6sqQr4pvfkg1B7T1vN4QYEzfgNPDuFNsW26G+fgTQJJhFNDI3YmV
 y3LYwVAmPiXMIVqoXDkTKz1LU0egfsMl8Bx02lbA/ZY3W08bsWu+J2l8z6cVe9fdI4Ie0g43y3F
 BZC20oXSV0ECGGiEipEIIsoQ==
X-Received: by 2002:a17:90b:4cd0:b0:3a4:f8da:2478 with SMTP id
 98e67ed59e1d1-3ae8974b76dmr2867395a91.29.1793395225549; 
 Fri, 30 Oct 2026 14:20:25 -0700 (PDT)
X-Received: by 2002:a17:90b:4cd0:b0:3a4:f8da:2478 with SMTP id
 98e67ed59e1d1-3ae8974b76dmr2867363a91.29.1793395224908; 
 Fri, 30 Oct 2026 14:20:24 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb3927e856sm11374025ad.50.2026.10.30.14.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:20:24 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 18/19] drm/msm/a8xx: Switch to generated protect regs
Date: Fri, 30 Oct 2026 14:18:20 -0700
Message-ID: <20261030211928.45761-19-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
References: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -VgO4aFm_D4W_-f9c3iwBw0AL5RCWHpZ
X-Authority-Analysis: v=2.4 cv=Z6N5j3RA c=1 sm=1 tr=0 ts=6ae50a1a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=JcQOObtfp6PrThPhMQoA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX8n4MQVVMeLw4
 qmcpp+RWxkgu75zy6t9ItWRNWeRpSmlRx9BJTJR7VmBzGjXaUlF0gtIGlWRXhGh3GQNpHttrU0w
 b51jfzrnkqp8tFDuh/k/Y4XMMYAErssL9TtIB6SqtxIHyp4UIo2N5EDTmKFcT7XpKg/742HAOoa
 fb7E/uh4TGs7AexCw+yJInhxVR2CoA/EeBrMX2g1QTMeHocXHIZvJ2U1Ld8K01f8TxEmWIAYJHY
 jlwkG4exf1euGCb65K2rmt68j0OpDPcjhlHrdfFpMc/zqPwl7M8g6BK76mjv5Y6l+1TeGL73ExQ
 yiap8460McEMj+r5U/Q8Qq+udsSGugLEqkTQhv68X8igvCSbqvbCsouA9fRlhFFTr8ARbfTvPRM
 PohC9IR24YDT9bs3CWp6LevJHbiy61+9hixbLLW76/DZjkPQDXCT86v/xOb80kjMIhe34CIyVTu
 JFTg6uObLLA/5+sPZlw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX5W6HlUgCn2Lb
 Kqc+j1bCDBnGx++VtZmUMHIfsn9oMSOnIivCubcwP3IuJyaanQ5hxeQoZ+lpvPe5KC1mGe+1J3G
 7cPWuTsj0AkCoEFWDDeRTs/1iHE6hU4=
X-Proofpoint-ORIG-GUID: -VgO4aFm_D4W_-f9c3iwBw0AL5RCWHpZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300085
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
index 6fb35db73db3..dcb61bb09489 100644
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
@@ -889,64 +729,6 @@ static const struct adreno_reglist_pipe a840_nonctxt_regs[] = {
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
@@ -1350,67 +1132,6 @@ static const struct adreno_reglist_pipe a850_nonctxt_regs[] = {
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
@@ -1631,7 +1352,7 @@ static const struct adreno_info a8xx_gpus[] = {
 			  ADRENO_QUIRK_IFPC,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
-			.protect = &a830_protect,
+			.protect = &pakala_protect,
 			.nonctxt_reglist = a830_nonctxt_regs,
 			.pwrup_reglist = &a830_pwrup_reglist,
 			.dyn_pwrup_reglist = &a830_dyn_pwrup_reglist,
@@ -1676,7 +1397,7 @@ static const struct adreno_info a8xx_gpus[] = {
 			  ADRENO_QUIRK_SOFTFUSE,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
-			.protect = &x285_protect,
+			.protect = &glymur_protect,
 			.nonctxt_reglist = x285_nonctxt_regs,
 			.pwrup_reglist = &a840_pwrup_reglist,
 			.dyn_pwrup_reglist = &x285_dyn_pwrup_reglist,
@@ -1721,7 +1442,7 @@ static const struct adreno_info a8xx_gpus[] = {
 			  ADRENO_QUIRK_IFPC,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
-			.protect = &a840_protect,
+			.protect = &kaanapali_protect,
 			.nonctxt_reglist = a840_nonctxt_regs,
 			.pwrup_reglist = &a840_pwrup_reglist,
 			.dyn_pwrup_reglist = &a840_dyn_pwrup_reglist,
@@ -1767,7 +1488,7 @@ static const struct adreno_info a8xx_gpus[] = {
 		.funcs = &a8xx_gpu_funcs,
 		.zapfw = "gen80300_zap.mbn",
 		.a6xx = &(const struct a6xx_info) {
-			.protect = &a810_protect,
+			.protect = &milos_protect,
 			.nonctxt_reglist = a810_nonctxt_regs,
 			.pwrup_reglist = &a810_pwrup_reglist,
 			.dyn_pwrup_reglist = &a810_dyn_pwrup_reglist,
@@ -1810,7 +1531,7 @@ static const struct adreno_info a8xx_gpus[] = {
 			  ADRENO_QUIRK_SOFTFUSE,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
-			.protect = &x285_protect,
+			.protect = &glymur_protect,
 			.nonctxt_reglist = x285_nonctxt_regs,
 			.pwrup_reglist = &a840_pwrup_reglist,
 			.dyn_pwrup_reglist = &x285_dyn_pwrup_reglist,
@@ -1853,7 +1574,7 @@ static const struct adreno_info a8xx_gpus[] = {
 			  ADRENO_QUIRK_IFPC,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
-			.protect = &a850_protect,
+			.protect = &maili_protect,
 			.nonctxt_reglist = a845_nonctxt_regs,
 			.pwrup_reglist = &a850_pwrup_reglist,
 			.dyn_pwrup_reglist = &a850_dyn_pwrup_reglist,
@@ -1897,7 +1618,7 @@ static const struct adreno_info a8xx_gpus[] = {
 			  ADRENO_QUIRK_IFPC,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
-			.protect = &a850_protect,
+			.protect = &hawi_protect,
 			.nonctxt_reglist = a850_nonctxt_regs,
 			.pwrup_reglist = &a850_pwrup_reglist,
 			.dyn_pwrup_reglist = &a850_dyn_pwrup_reglist,
@@ -1932,6 +1653,10 @@ DECLARE_ADRENO_GPULIST(a8xx);
 
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

