Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D7F606A33F
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 20:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oh5UQABZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f2Of6r+G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC48610E39C;
	Wed, 21 Oct 2026 20:53:12 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C271112214
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:53 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKeJuY642397
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KmJhK2itx3o
 q5CFXOLUBAEnzm33IyEvfIC8LefReZ0o=; b=oh5UQABZn8+7mi62HCOeGELqaz6
 w2COYGLt2+i+GbxbPH1GzIbU8Mt8889f2oGZ3xnYmsuLXIuGmsebzEUuUtA3M0q6
 jsR+MRZ3h7R37k1hp5/WklkHqtPTtwdfPzisJPUzfxPycX84f2SMNL0emUm8/Vx4
 JOkOrpgEJPAX1ntlfmhwjh+9ldytBN/JxmrYG0bGSXYAGEPa+RRpeEWRGj2Zwaty
 ZSGmSnS95QQgEy4z0yMECVhYmfy6PQgr2faIYqfF/gze+k37VzEE7ZkxogtHIRyk
 MvDb6db3BIrMOHnRabKXdUk2LoobnaTHQZZNq8vM3gI/4Vf1Gs390y0UbJw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex5q9tva-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ad3fc547bfso1035032a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 13:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792615971; x=1793220771;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KmJhK2itx3oq5CFXOLUBAEnzm33IyEvfIC8LefReZ0o=;
 b=f2Of6r+Gk4f6AJ15QVuU+M5TUbMa9v9Z93sX/QGOZt35Lwpv6vcyLEfyWniY+Gm5TG
 jf1eKJzLRuMqb+eU9VGdi8L/RJXSTLgFFPzMw/NglszWSAzEGuo95y3aYQr0K8jl93yL
 BJxxSO+QKcdh9rhaS5ItRhtsNCTnpoqeb0xZ/0E0w/JLNRQBjuJFo3xamj25cAriShX4
 8GqgQsM8ODRaW4Dq71xe2nXB7NkHLwaDEnyXw8pbjRJhpU4XLTrir5GtZzO5qC3Vp1Cm
 intAWC6OhxzG1Fqav+7rEDi27JUr+aNh43jS1N0Bbw9KycQPqvqV3J2c6Xh2yTY/spSI
 Z4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792615971; x=1793220771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KmJhK2itx3oq5CFXOLUBAEnzm33IyEvfIC8LefReZ0o=;
 b=kZhl0F1MERj6bS9z4hCspkRm/INKbxz1v0CZCx9PdZH2pu56XFv8wq9QYy5M2Ln4s8
 Nw0ZYWkA2x5g0KvkkLwFPi+WICoJj2gQgIKmMdFjSQyB0YUjPRc+MIENPag4hboZ4/d2
 G0PbNF3rLG9KwtPdWT1U1KmC555LG2gzelXxRubcgvrVK3IM4FVhSfck+LJltpT4M3VV
 ixTfx+NcAOMAd1mhElUG6RPoHCw2i+Lx8UB4tsr3GQBrYTScHsVvXIhLnFym2GcH0wAm
 JI8diuXf9RPdb8pF1lMf7zDrViApI1vHN0qg0yk/p6U6vJQUfgjGpzEXKvSqr6JX3OCa
 15FQ==
X-Gm-Message-State: AFq9FYJTRqmJHS5nNlVN1ivDRxpCgc4bdB2l+ug5vTklKgYP6bWXgK22
 Hm9rsBMJlsDCGpiSaTL7VK9d77TICbxu5ZbwDK0n9gzTlqgEIwCl2Yf2nI1w8X+NswXlpel2ACi
 2pQhrp1QQmWFMsKXKVgTK85w/Bu0i1eM+vyDFcRBeAZbB60yiMrhmbLO204jDsB/oOHO+uU0/nQ
 Yl/yY=
X-Gm-Gg: AYBFou0DzeA761JA50iF+XcQP7UCUcpduP2+l0pFP4K250iv3aJX/lSyN0CvwrXrAwe
 WcFkRHN/2WP4CTOuo8ZAFNmMfv+ytUuZp13zD36QgT31W9fW3vvLYwmiquuTRpst5KLhXX0uPXc
 iKt0zhehsIhJwO5gEzQmx3Z7Y+9uT6AHiXe5olr+Su6tnhRX3l27cgtIGibYzYjiW31BpD06wRp
 MlLCQtuZqdAJznRN2GH/uwAJ2+fKY7CzY8+XUtikHGppHv2TShExYROCt6IcDzPL8i0F30y57hx
 QwqYp5ON5WmpeFGP/vhqLcVAE71q4WwX2SRZrixg2Z2lFf190X4Mu+SOumq+zkNUECyF3WzeYLu
 zzFvPBEdsgGMHbHHiwjYbeF9EmduLS+2gZaB8gjYEFNJLNVql
X-Received: by 2002:a17:90b:390c:b0:3ab:1b19:78ed with SMTP id
 98e67ed59e1d1-3ad86c792aemr2590082a91.21.1792615971328; 
 Wed, 21 Oct 2026 13:52:51 -0700 (PDT)
X-Received: by 2002:a17:90b:390c:b0:3ab:1b19:78ed with SMTP id
 98e67ed59e1d1-3ad86c792aemr2590049a91.21.1792615970792; 
 Wed, 21 Oct 2026 13:52:50 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad83482f35sm2965909a91.1.2026.10.21.13.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 13:52:48 -0700 (PDT)
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
Subject: [PATCH v2 08/14] drm/msm/adreno: Fix PROTECT span length
Date: Wed, 21 Oct 2026 13:41:33 -0700
Message-ID: <20261021204244.67160-9-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
References: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA4MyBTYWx0ZWRfXytzKMVDBAttL
 l9E9xhC0Z7aXhrXPkAkwTdQAcBeSpFr9FFrL143NgfiRXs14FsBsZKR7F8T0kIc+cqCTWV48znl
 dA92aeOtMtLF9KWAVlgbY8JN4tXfIps=
X-Authority-Analysis: v=2.4 cv=eJaGH3p1 c=1 sm=1 tr=0 ts=6ad92624 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=MJDCpJTP__1aPQla-tsA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: z4aIhi6L6CldPwy5IWzujVNY7dAaEUfv
X-Proofpoint-ORIG-GUID: z4aIhi6L6CldPwy5IWzujVNY7dAaEUfv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA4MyBTYWx0ZWRfX/Q+DvNA9XyH9
 03Rc+elEsxFnYrhQ8MgrM8/NxwpokIZBC9qs5KVWVXX7dg79kFLmWhaoKbjFAQaI+2HNEnbcRZA
 J8lTmGRgl3eUCkqJWX7K50ogwMr3gfqUokjysm3o1kHtc750BUQInOqTmldG4fqnRYub5eqJtYO
 VGLS4DSGq3p9mlRJD3BM88vWB7ggAhBhpp59c1dbCL9lyJd0EGMtRs5Bnox3yYjEhmFKMK+m2a9
 XOUrtK3E15Ywg2Bea9VxYCQj4TjLglzO3LCs6Cf5tMoMME48xkroqrC0kZsd6OmyM+DubH1k0PN
 HrrYUBpxnYHixTnAeQ2Ez+vUZ/5/qCX4lDcqS0m0yTMu/LeCMcThc6mH0h/PBYGAzkHd78xXaAq
 NfWJpArAa1DjGbWcjOPrqvp5/APqyk1Smwf4R0LrzIMPB7V1kZ/t8dnj85lxnKwY2ERi1nSvXS6
 sCfBtJR04PwTmR8YjQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210083
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

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 6b23d301c144..c49301be504b 100644
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

