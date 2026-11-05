Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0BD606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SYsWmakc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jtEbEfSX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75B4D10FEF6;
	Thu,  5 Nov 2026 20:40:53 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 120B110FD92
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:40:41 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeFaX1474637
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 20:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7RcgiEmf6cf
 8SNXnvgtdIUceJiAojVx8uS+VJgMrRdk=; b=SYsWmakcMBqJ2Yq6o2TkJobXwru
 cS6BQoDWyENFxrkTY6vaW32mosgwu7PPUXjV/FHgF4wCo4zN8zT/92KU5PcG689l
 JTs5EHo21iNu3P5EM/n5xE0M0kHTeI4S8Uh1ZzjbJ0J5KyJz7OH2N6vXPSREpx88
 DovaX1c5ILDoVoRThSFMe9bJSSP56VDS7owrWwzR+VC8CwZyQa+XOqAWHkf1tAAU
 BHWwjMqaixg6W1Zlx91XG1B1b+7ptj2WcgPmCsuSGt8SP8b5rXOkAFXppI8n1FDX
 1XIYx+8O1amZIAR+WBgjsmIoK8imzTOH6zhSfP2vRH5o0/GpEwl51XfMbCw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrmcdbq5x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 20:40:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e942b1cc86so25505815ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 12:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793911239; x=1794516039;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7RcgiEmf6cf8SNXnvgtdIUceJiAojVx8uS+VJgMrRdk=;
 b=jtEbEfSXNXIkpZIF/Wjtt0G5JSJlFu81ep1YPOBavm5lj9sgWP23BDrlYNcxJXIlUY
 IuZhpjrhMju33zMooTHgdfJIHmnSMWhDmKHU5joCxYkUReyeSD0/Z8Bi2/RjAUOkwTNI
 vbcQFV8kMkdE7Lc8tsyVjfJ1EKpTaOo5HGCNTnUb3cVzDykJre3k9IFnhFIVQQNkY4p9
 Pse6RR6c6ZF/o0m/4c6LWVP++PKD+4VBxFwKjTzJ0Kqc27pfeoM26b4E4/PrxJeZIAiT
 XsHSWiOaUCRIVJeYShP/J5SBh+k57qGFRMH9RgdlTBKPFwfXrInNO9TlgK9LbxwUBxM3
 ddGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793911239; x=1794516039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7RcgiEmf6cf8SNXnvgtdIUceJiAojVx8uS+VJgMrRdk=;
 b=AIi0/7RPp1gyUt/+kFQ8l1wVLmI34LNIkFrjFqyZBsfdo6aX5lLCEvts8mqVPD+4t/
 8CXyfR9zIx74AHtL/b+rj78tojIBVzTpG5SvTkS+ofBN9Fam/hJ7VqWFawI9bt8QkYFv
 CZ/uBab05ZR22f46pKXRnnwFcs88ygDx39lmtDcpxJPJEY7zKcLZtB1EAcv7C5TfmoBU
 nebbrytTcaNa8K7Chh3RIO2YfB74rWuDV+AInJqV+TrsmgTCxNDsejVnfUtYQQumCBvU
 Cpxreq4lEbNqkybXsR2VEgmoWgMTt15+2tQ/m2huux/+XCQ+9m7K1aeuCyg4m3g8nfBE
 e0Cg==
X-Gm-Message-State: APuU4Z/5qPgcEfcSbirCG8SC15gtA4GogQ2CLs9O+FySiH3y9OZokPnA
 J0zlaY3VYsoWxcffNEyWffld0K/x8eEtQ47XTdmHf7wEIwb5SJ9xjaymQc27/Tpd93ZsSJGPqpV
 LEV5CXmuGgeCBJDplv0xpMmj2FK0fX7aF1pyW6w77TXaHkbviWVmcdHIkHVdi4Fl51TkuaZoZHd
 LhR45uUg==
X-Gm-Gg: AYBFou0PZW6d7yYbZtIHwV3EgQ6Ds/B0eKsQip5qmrs09fSuA7BVcj04hhpQTPThpuO
 BsT9VLZaBbc5/RcHzY35ztYRinrHR7bGZY732W9z+hGMU52ALEBDJtjWrZEwZdvx2oCNSaq4/BL
 gpP7G9vCU9TxcbGcKkKhnkiPBVegoVSnrk6G9g+1iIaCAi8rscHaXlIdz6FJWk0yv2oSuTtaQXQ
 jnURAHq4scFo24D6Q7CCHltndDKEcCxWvilpMOhYg+aumsos3wPyKuUbBMKkS9g1ABx6TP0JVw/
 0UnoAaU7VZJj5jIsaj1XLkX739WCdJ85f4B5JDBicd+aDca4IOJrH57LT/deBRv6DdVyjOBViGc
 yfeDXXDFuMmrnWIjS1FMWsISJsB1c4JesNa8yGkv6H4QBzoLW7LVg3DhMkllA5rX69yiww1pcSd
 OCWzqJBluuiLdkxusGmnRIWZVCpTuoWBmLgNpZJ7Z+UFy5F/nt1w8kzjZy6eoI/w==
X-Received: by 2002:a17:903:185:b0:2e9:8794:8ce7 with SMTP id
 d9443c01a7336-2ed40c5165bmr7832955ad.43.1793911239017; 
 Thu, 05 Nov 2026 12:40:39 -0800 (PST)
X-Received: by 2002:a17:903:185:b0:2e9:8794:8ce7 with SMTP id
 d9443c01a7336-2ed40c5165bmr7832475ad.43.1793911238375; 
 Thu, 05 Nov 2026 12:40:38 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed0906c514sm21008975ad.29.2026.11.05.12.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:40:36 -0800 (PST)
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
Subject: [PATCH v6 08/15] drm/msm/adreno: Fix PROTECT span length
Date: Thu,  5 Nov 2026 12:29:34 -0800
Message-ID: <20261105203057.66520-9-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
References: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EOGTQFZC c=1 sm=1 tr=0 ts=6aece9c7 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=MJDCpJTP__1aPQla-tsA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: WXrrZScc7SFpzBpxwT8mfUwxeb2dlM65
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX1wqAByumLlom
 QbbucAyH+lwpuycDVKOEAdx4sEShHo05yUi4HqpQqlkZG45rU2WB3iG8fplNlL8KAJBsjJecqlf
 LsPZQP+1OC3Eoq9s29S04uymNl8ic0A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX9ZTLhm2SN/rI
 9/OcWVclEPKijEw/RY882tBgkKlUtncgLL8GkA+P2dQtCYsVmgcNcppJrBjAjWIchcKYpRk4UMz
 m2NwgQgMGYlrhVZEcAEbvvs42gvbH4eZYsj45QRZGfi3QqdrHioLUxMrrBP920A793Kq3Lv0eYh
 7jN48spmoYFdtWQyNg7P2C0497Vo3TRWz3S76c8moccrawOr7aglIPiw5kTIKpq0/wX47mzVsEq
 sGT/yngvoQ16xrm1RTWfsPSkQL2qfLBc9iVsRXNkUmfVlZg26F+WiJBkodRaiLd4RDiLkQ/HeJ1
 4fAjCL959OhoSkoFtWNkQh6nL6ZNic9C8lZvd4SaBEDmIuUh2ksTex/OvogMZAlNUMzzcyxCc2x
 3WTiOLysZwN+uthYUI+UjCiapAEEXpBkrdhauHCqbb7LMedKlsLIwL/DKHC/EvAyg1IYzY5mnPS
 KAymrc6PhfqyI0N3vIQ==
X-Proofpoint-ORIG-GUID: WXrrZScc7SFpzBpxwT8mfUwxeb2dlM65
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
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

Don't let the length bleed into b31.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 4a3898e58aee..cfe7a3ed44c4 100644
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

