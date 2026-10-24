Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23982606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=POaySfmr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ikIsjM62
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76DA310E7EF;
	Sat, 24 Oct 2026 10:31:29 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F8E410E7F7
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:31:18 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O8oDXk1707947
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yVmbznb/9DErXq4djUHi/SV9iaCO3GJadLn0oXVswrI=; b=POaySfmr2zWvxh07
 3S0ZVpsfY7f8Y4FE06+L/2UfpZ+i8jSmmb49bIUm3JyBejnwgh2UXSHHzLITyyTN
 mgaa8TsVm77gV7XEcNCWJHYCsLqz3GQYjUteq7i4/aza/DgaIBbB3psihXKmKaEQ
 LxVJkp5Y4NXEBLlN27nfx6suryimr4Woma7c8NU6Mz3jkTa2LjDNEyECTTt022D6
 mQnUZgGS4wLJvtHJswPt4D0wV3P/xxNVwtRxr4QgDlaNyHNy5nfqy8Oq2j6lHmwn
 0b5ICZ0CbLmpjxpfCHbkEWwMBBijMoUM7QWCFYf0vCYzgClugx6+ahtaygWR4hIm
 rHU88A==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xgstq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:31:17 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-156b5338d4bso298696c88.1
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 03:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792837876; x=1793442676;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yVmbznb/9DErXq4djUHi/SV9iaCO3GJadLn0oXVswrI=;
 b=ikIsjM62Tw4sJQWQ79yxA5OzF81x5gwuTJGKIWRn8rqWq5iDwbBU2mQfgb96U+hh7G
 W+f02sBsjhRx8LZv6uDot2hguSfFSinRtP3FyK5mEjsQljgW8D+CekCS9zXuRJON63VH
 usTAF9+ZHAg3Ne6EdDQkSNGGHu4O1pzh+NgFN4ettFkaIoD/gHmpLbOKpJB6+nvxaith
 38vEEcYJIcKGuUnEutb9yly7iZS83oUQPV4+RK2sKDcIob/BLCamAzbXOcQgk9hu59j+
 CVKhch84E2AL1JtchSLTKvAZ1nDEbs6n5ZiVD9POrnk/skAD4lWDjGcT96hC6UX3+0qj
 Hg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792837876; x=1793442676;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yVmbznb/9DErXq4djUHi/SV9iaCO3GJadLn0oXVswrI=;
 b=HbUdNrrKPqrb+j9yD3/iLo8OYUyHpHFsB4pW2td5bdh6paSf/pKEC9WzJ2eFMVzIxQ
 M9T1X+wrM51PGT/XBa+ZBv0Gy/G+y76/sCXFCpcWNyz/U/NRjsyIKSqSI96gWiYEXxfI
 9TTECBCRj4FBywJY+/sPxSe+DTjkcM7opYWWHL+F8TOcwpePyquPz0orJsGp+JJFuWlx
 JkSug5n36uz9LFHQD+l+MMHz4FiL0gn1nVU9DfehG+2HflPVsBUBqYKyN/zp+CIQlH1i
 AO496SSxKlr8id2SX2Ljpeb++nwoJadcvRcDF4rxv8OMdqulE05D8brL9MquIrx5mmWR
 DOLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzmUzKmGcJS6/jcEyeCLBm4ocFkyaKFASdOixbgyJzzOCQqYjuspu0C6w+wN9DANmKvh8IRvolJrdU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK/AfDVAxZC9+lJ/CXaJVqQe3Emb+rcne0m2dOnw6C2WGPy/bHx
 efQBe8kT4GGqljOi5IWkWfh4nzhdaQmN2VPYAclsiYpIwuiCPwRumLgvOQBcZLcmWtw0MbGxs6O
 X4qgmTJnBjuaU2aAJ3hRUqd6hD9pGynkHTIQM2xX0Pp6PNpL8X2lkSQoLR0+FE4dEhIa5bfo=
X-Gm-Gg: AYBFou2Nuoo0dHzNFXunAhlSJVkaNy87z7e5GrIXBzhtm5mvBMPNsO+XnjQRSMD5LGG
 QDQ9HYqgNUuCq8NR6b3E2riZEhrgAsWYVSXaMqVOEUSBie7XRLOajHEg8W+zJLhKyiowpk+vkaD
 KlTVMmpuY2Hh6qvkjHUU8mPQftS/Bzx/D4KgSBrfGEiItmdoVhnZ61sFI6M2g96/LQF40xt9pka
 +38U38pk2/ejRP/RyhNxQ8hk0YO9aImWCc8W7J0LsP9DOFofMOefDGMnMUF13FJHPCN9T7Fdq9x
 +pBF84bL3Lc60KXk1O1emO1Vocg9Y8wDr0J1l8HadhuHK+8lqcKB/zv4jRL8I/q+AuNmhxxcKvc
 nBu0YKeHg1mWtD25HBCZHnMo=
X-Received: by 2002:a05:701b:2311:b0:16a:8ffd:4977 with SMTP id
 a92af1059eb24-199363a356emr2026615c88.17.1792837876139; 
 Sat, 24 Oct 2026 03:31:16 -0700 (PDT)
X-Received: by 2002:a05:701b:2311:b0:16a:8ffd:4977 with SMTP id
 a92af1059eb24-199363a356emr2026570c88.17.1792837875267; 
 Sat, 24 Oct 2026 03:31:15 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19894d5a10csm6009441c88.1.2026.10.24.03.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 03:31:14 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 16:00:14 +0530
Subject: [PATCH 8/8] drm/msm/a8xx: Add AQE firmware to Adreno X2-90 GPU
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-assorted-fixes-oct-v1-8-2977f974ddb7@oss.qualcomm.com>
References: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792837816; l=758;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=6jmsPstXRSfknq1XodxmYZvUhspzwwQE2hSVoneLg8I=;
 b=Hx/1/hc3l+NGbzYOE4B5IZ8a9HEQEd14sU4mikm18b12ltSKrCeyQdGfZiLcmnEkmV9KRmVWZ
 2nhiRi5Ya70DDbbG84Qw3t7aDbYMJye+XM6j65PhrewxK1J542MF3J8
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: EloUyb1lQhL7cpJqsvys6LRqGIegZuTd
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6adc88f5 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Kvm9o7dbxh_Zzo95XxIA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX0XBaRvhBHteB
 tYewLKKCu1e4odDLVbr7biCEI+fVxM0K3/w2elWuCH6f9JNirXDfh1HMoRBr/F6tVIj7GqpR9aY
 Wma16ItCOHIcLg4VQxlAhc56UYvW5kQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX2KgFri00pfJ0
 4xA4tX4ek3g4EO4ltyteFR6ahpxgemgL2/3SHwIy9PWjWmFd4G2eC/oPKBuPPDw7sVv40EJUKcA
 MSAftfoFLNBwRHGx3MFdFbz8WI8VP0EXj0pV9xtMYAyCsNptqMfP5iVYSh6YSpmmqYhzaiS6/AQ
 77deKaCprGV8BpvQWay1aFa5T037f28Exkojt1rFB33lTZ+zpIl28aitRlqc/6MrY+WE/bB4fvm
 XS/CTwATIehKT0uFFkWBH8OEXkXrNHqhFv8I6rMyuSvsGLNJwYI2iprNWDTFtC+AAuYnF6tHoZF
 I9KikO6oEGlCiUafNUEUaQsa+vseM7R4CmaeNxY5F4WkKkOFsBSnbhtJsryosngf1jKWM7gm12R
 jIJGogNhZLV/5JlrIO8KSUN4HVOtDrcdtIDzc61pm5VbfxPUaw4bMdSijhxmhuUSO2Uajwfx7MX
 DVguryWoxSMZhPZ6j6w==
X-Proofpoint-ORIG-GUID: EloUyb1lQhL7cpJqsvys6LRqGIegZuTd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240041
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

Update the catalog to add AQE firmware to the Adreno X2-90 GPU.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
index 55a805ab438c..775aca1964ee 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
@@ -1582,6 +1582,7 @@ static const struct adreno_info a8xx_gpus[] = {
 		.fw = {
 			[ADRENO_FW_SQE] = "gen80100_sqe.fw",
 			[ADRENO_FW_GMU] = "gen80100_gmu.bin",
+			[ADRENO_FW_AQE] = "gen80100_aqe.fw",
 		},
 		.gmem = 21 * SZ_1M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,

-- 
2.55.0

