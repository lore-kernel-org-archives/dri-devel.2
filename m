Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FFB606D833
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NR28QxSj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QzRcaeAC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 480DA10F23B;
	Mon,  2 Nov 2026 22:04:48 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 075D810F23B
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 22:04:36 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2K6HBP166146
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 22:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=m6mM3IDpZjo
 328CSxZDXpZGEcjx2e36tzzcU3Aq+/14=; b=NR28QxSjwj2j9QZaPCOLLFBTzPk
 CuizNoLQiTbu+BxXd8M7I6MwsfWY5n7gfoddjLEPkD4J+GQ8813kpleoC89gZJnF
 xoVh9WnAhQzP9x9IZVbGD8riBtDKli6OGgm4v7izL+XMcbe6GN0pEDLPrtey2MLo
 nPLOyE3xjKazNwbVE5OAFxq2kwVDNhz0G4gxhkAjbXaDcpZeQG67rBcOk+uyT1sE
 4Rkd44Nj/ACt/JJjh5WMERXVtgSRhIELweDNzjB6FAbWcXmcGHQd8Rkaq2HrW5Lc
 HY00AgUJSIX4MF+CLpgiaqun/RErZY/c9CfLiORchZkryaG6Su0MBDbh94w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqfrk4hh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 22:04:35 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ada6ccd402so2904575a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 14:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793657075; x=1794261875;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m6mM3IDpZjo328CSxZDXpZGEcjx2e36tzzcU3Aq+/14=;
 b=QzRcaeACKBJu7r60fqZAm+c0Ih6LTIXq2zdWJ2Z6MeYyrapwsKhyTLBg7deJ0ThHnM
 EhKHruUDoGVskK3ZuV0FFb5D8/ydQSc9drHAcqeM8RhzX6Cl/DdNKWSSftjpEiAT/dK1
 AAryigawa2pMU3otAEM55Ip1acFc4/yVyjFv1i0dV7RW/WyTpcF2cGs5STKdnoRNcNgD
 0I3QslJ/asyT7Fxv51zJVHeQqeFT6zDXw6rPZ2G9tz01LgRX3JNX4FhszdwHbUlUndUH
 9JsdvZ1NeSpzxYRRXJ9j5VoDZgZLV5iQi2XhWcSUPAlbOuewYuyTfP8hXN2wDdPsRgCD
 OUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793657075; x=1794261875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m6mM3IDpZjo328CSxZDXpZGEcjx2e36tzzcU3Aq+/14=;
 b=CCn2ZecjUJ5CIpuafPrL2VE/BqaPfabCxQkzSSuUeJfS0fBdzPS1AmVlp7di50PfNp
 /HhsL3Hual+VEv/qdsol0Jvh2JNJI6TFJc02cOMXhEWC6+q4zm0m2Lih0IPBcMAIun6y
 1AljEVj3MiHj6PUk7gdFaQFL+UxPiZM0d+5zbkpQs2Y+1mVdeOMzSFX2azhslFkbEq/m
 z9pNpvxbMx+IR2ejFI5wCGMEP3zoFadjwZZsjCqVVaA1hsqo6+DWTum7Uy6lzmFmLZ8O
 MCUq9JS0+4q5GDlzRmj5vuUa3mm5zItqdthUaaMdELuFjZ64Ixewn0lQgxA4wluq3BmP
 kWKQ==
X-Gm-Message-State: APuU4Z/Cu1yzmWcL1XUUu6yHwTCBC2I3IZGuoX0BPCfTTEy9Vh4kVHmZ
 eIBFnolIWPN0PJ9h29asSf6K1GdWetXW9eVnRYFKPGew2InDk5aGNerUN6CIUgwBpw1DmyI4O4b
 rtHdCIQQyAJneinHD0Hz41dJGE5C3cfQJ/g99tNlGB1PD1huMieDiVZChhjm2N1EJaqrlpDEWMn
 M+RWI=
X-Gm-Gg: AYBFou2PvGYS7fUjxNkkLMo5wug4Khv79f/rLSxD4axgRsZ0zGt1FuiEKXwK10pdfVm
 63dKq7BXORJn9E2XMTBcr6c2mrPwjWvnldcfyaP6EoVomP01Fpm6++XYnu0tlAyT0SjgySkDdGy
 Ll+UP233uBuagipK7rKkcsBpMwhWFq6VB1slWW5lhpF717cPf+dvImN1k/G4Cah/cQQaQftuuVM
 HY2sME63a64Tj2uNgrDrN5/COL2G2rYUstDd47/N8bY3c80IdlOoA3doNRizjUwljBH+6Ug82QL
 W+9HeRzR8F3GIspqqjeA6sa9BkDi1Ef5V55AP/7d1Kc2yzr+Q+f61xQbz9usA3oBtdoUwCWdCn7
 qCN3/WKuZv+fRYwPHAMMmY/xlV6mROdZ/VbBnfuflm2CwAgLEWUq0Dyni68FcaBrqgWp3DRqkip
 AkZogPZSrpQWgZGnpLiMT14w==
X-Received: by 2002:a17:90b:1d44:b0:3ab:c80:936f with SMTP id
 98e67ed59e1d1-3ae896f852cmr8159919a91.16.1793657074697; 
 Mon, 02 Nov 2026 14:04:34 -0800 (PST)
X-Received: by 2002:a17:90b:1d44:b0:3ab:c80:936f with SMTP id
 98e67ed59e1d1-3ae896f852cmr8159901a91.16.1793657074272; 
 Mon, 02 Nov 2026 14:04:34 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae87f5dcc3sm9501074a91.3.2026.11.02.14.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 14:04:33 -0800 (PST)
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
Subject: [PATCH v5 08/15] drm/msm/adreno: Fix PROTECT span length
Date: Mon,  2 Nov 2026 14:02:52 -0800
Message-ID: <20261102220405.30730-9-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
References: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HMJWhYtv c=1 sm=1 tr=0 ts=6ae908f3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=MJDCpJTP__1aPQla-tsA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 1TNqOspZRP_bL5BeikYxw_w4v8hpFCsJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfXzifUUhT8eGdm
 NjK1UFaRKTr/gFuif9A8ioDAyEBTeW4Fw0Yns1AQZRBQeP81LcqIAGpOhO0lVK2jXWZX2zHPKMi
 SPVhX7tgi+ccY7K9swMG+E8jnOfwCn0=
X-Proofpoint-ORIG-GUID: 1TNqOspZRP_bL5BeikYxw_w4v8hpFCsJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfX4xobFuWUOggu
 n3kiFCupiCSBdhvPEEW5OaPDxPL8gqvARj8EbDVtk3F4zD/RrWc8zQMpCWGb18i4JcTLgJajJ2Z
 CuWlzlmDjdlL7QdYrDGHiUMbtpA3EVsWPfseEMISCBxwrxYwoh6kU0QS+SZUwHtzwYo9ePbyG7e
 38iZPdM0Gz9YfcL+t9UggOK1MpFm2SL8wz31KCK0VN+x43c7MUzCjuGgjDCa/rsuuc3xeT3x1nE
 3OJizE+dC3fylIKeXJH6gxUMRjnRfHwgXwh8v5ysfh76Wi3wJ/U/xzE6Rs0Oo3H/nhwsrRHfEuK
 55TftwTEbhf+cyaCq6e26sSt1mhsnICI4tJxyBpdAtoHWBbA8DZO5FOKTLijI7EpboXHhmXTZHI
 9DckrmMzrVqTkQ5JNcOSAuJ9SGjFKYRocdgNzC19mI3saORCDFCJjvGg3SNFvKY8FP+5myAa98f
 5zzn2Bh+7u+Yu7uxpDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_06,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020087
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

Don't let the length bleed into b31.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index f8b9ceb588dd..6c28ba1c011b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -244,7 +244,7 @@ struct a7xx_cp_smmu_info {
  */
 #define A6XX_PROTECT_NORDWR(_reg, _len) \
 	((1 << 31) | \
-	(((_len) & 0x3FFF) << 18) | ((_reg) & 0x3FFFF))
+	(((_len) & 0x1FFF) << 18) | ((_reg) & 0x3FFFF))
 
 /*
  * Same as above, but allow reads over the range. For areas of mixed use (such
@@ -252,7 +252,7 @@ struct a7xx_cp_smmu_info {
  * single register
  */
 #define A6XX_PROTECT_RDONLY(_reg, _len) \
-	((((_len) & 0x3FFF) << 18) | ((_reg) & 0x3FFFF))
+	((((_len) & 0x1FFF) << 18) | ((_reg) & 0x3FFFF))
 
 extern const struct adreno_gpu_funcs a6xx_gpu_funcs;
 extern const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs;
-- 
2.56.0

