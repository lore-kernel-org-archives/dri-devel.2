Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10889606A320
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pHtX//R2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZhsExZLe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78FF3112530;
	Thu, 29 Oct 2026 20:18:32 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3271F112509
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:18:02 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJjaOs2138838
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ocDu9x7a94S
 WPcpzxK16LgiMD4smeVd0t/ViadjFsRc=; b=pHtX//R2xJT+i18ENl/QKNWY0vJ
 7r8uCHQI5u4k3CnifuU/x69t5GE+18sF28UXcBBa9Sd8qrfkkJMvuwmLaFVvAKzX
 YgJCtb5mXCrUes321Wv0qPfLRqKQj8G2cK9w2en33zUlBXOZJfyhsV0//8hQ6bxf
 wyr9h5gFFtaOmGXmBAKOJ0SyOPxwgyqfU/0+ObDusaBsAFWgecTD5UEGjlEPuB0e
 Ex35pcN4axvuLC1w6RzIFSZpVc/ccSrdh1a6vaAsxANHwbwWd+S2+8asrz8kaXL0
 UVgKCULA2b/8wqT9V1G7uQZ/NEXxDHWHa3e2Io5lM5uzebHj4+Cvty9heZA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm4a22kxw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:18:01 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1cdfb337eso1641757a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793305081; x=1793909881;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ocDu9x7a94SWPcpzxK16LgiMD4smeVd0t/ViadjFsRc=;
 b=ZhsExZLeUb9JvkJqrE36w8CjCU5oeQBQ4L8NGKXZYNzWXGMslzna+klLpqnhvKwXcc
 A2SfdinC4MxTT1LLicaZIeeFVV0bbQwvcIFdCJ2/pRkL3bNT69w7i39rBjxG65PYOTFR
 YIo+jVI3vrvQzhVZRKCemyXBktDk3M/6EoNujaSqlbZenU9F4a353OcJ6mLfeaVxgdcz
 +FYo9UqxJFkeYcTqANCaE7tZgqDb4+fVU6JCMVAKR3Grx3fSMFhiAKGZowA7OxHmPT79
 TU19wruqe/E65S9LkyIVbIMdnpb0prH9/IKkCqv06ag+m+7cJtB9TpR4aqUXyMIrY4TY
 CB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793305081; x=1793909881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ocDu9x7a94SWPcpzxK16LgiMD4smeVd0t/ViadjFsRc=;
 b=2nJQCUW7SHrKQTR2UPUF4nCoFSkexKQXZ2LAEM9Ug+A0OzSZ8vtN/+fp8BkelZpVHs
 T53UFbwNKm9fY8dy+U/WMDRfhY8vhSDsIH4n3kNu+UtxpEu8NtzL8cQBmmd5rN594QGK
 rCsG5ACJ1tU0iB7BQkNMJE/sxIq0Bsj9+BxekPlEDA/O0JAKIjyhLKpm2R8Mx9TgiD2W
 FwksN8XyBesGmm+8S0OqPhm4DZAV3Ya5iK8SpZ19E048/Vy+pdXltBjR9drqPQxSOOB/
 CcBIcp8kMCuv3bqTnqqeR5oB6VGhqDWmMgas4ziuMo24lMwwdUkrm6dBKoPVQKmsFc7Q
 A4hw==
X-Gm-Message-State: AFq9FYKgteevbWLHEOZrH9E6UxIwnj3nHAHZTXAfMJ2n7L5KrlJEecZp
 x4iRDcXmJX91ifaEjZARDT6Y0HItcPmOp2a1XoankFwOUHGmGfp0sC2BSCMrQIjUnfxc7YzUrEg
 hbVXZLJAhPwG0DR2+6OzE4Nz3Lgze8TpDUn8p8AzOUreQx0Zs9rSEMEoXKAdrlLOTUe51GgAPxy
 y2czI=
X-Gm-Gg: AYBFou0q0KkMFCZydCA01NJ5fA61H+7hZP/wrbyk3FWCvzH1QvDUhkwcdpg/PPj91bz
 F15isBSpoccGQAuEvuE2BcMftCij4fW7ySSq337bb+y5MpDd/X4c1XfRLH7YK/TUKjEq75TBpdW
 GL6r+KTumuKA271bi6oAstaGyaAY+Ihrr8aW5tN3+fkA1V2jY21T+HecQ2nEXpQ19a76kz61+A+
 VHYCaUviEkBTAbKtM0/g6hGacBFL9/g2r2FKw72x8ZIFFHqD65VonjEjlDyNSIZCm7/nnNBeiWH
 HFhAw9yVVV85ntSlppr1ppKICQkIQu4DSYoUDboFybHjCnFhIjYnxTGapPpyHVDGbUyHecd2+Zq
 w11X6Xx1OH0eRjhqNlHr5oV/Ruj9Z178YwNaZN3OGfAU2e6QPLIsgkyhMXCBrDt30++5fTzYzMI
 ZPquQF6mkbT+knuX33Kv32sg==
X-Received: by 2002:a05:6a20:6a2a:b0:3e2:1f0b:5987 with SMTP id
 adf61e73a8af0-3e92903d098mr262440637.86.1793305081024; 
 Thu, 29 Oct 2026 13:18:01 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a2a:b0:3e2:1f0b:5987 with SMTP id
 adf61e73a8af0-3e92903d098mr262432637.86.1793305080584; 
 Thu, 29 Oct 2026 13:18:00 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb0549921csm190361a12.14.2026.10.29.13.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 13:18:00 -0700 (PDT)
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
Subject: [PATCH v3 09/16] drm/msm/adreno: add temporary __maybe_unused
Date: Thu, 29 Oct 2026 13:16:19 -0700
Message-ID: <20261029201730.151754-10-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
References: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfX6vTRUh+oLayC
 npUQ1Rqja1BjKx8Y8QcNBKKnpIxRSnaQSpeYJlqywAq6mSk2n+vKp3oLEYy1hBWOz2Qk5SenOHz
 TuP6XWW2bSla3++PEXfty45K7R3EzgEMWHQM7MErJ6ROJP8AYlAyCkFzDLDfXx3OCjVPjvaJULR
 oIH3301bCZnEMO97fdOLpdYJ7/3fwqwnIXaa6nup4w46I2QN9E95+I/4+Zd/XzhRyOmQuiXYSqK
 ngXpwV2BQV4o/F4ZbZvrdm96ACbmJw4bm8EKpwEqiTpkM4S3FuQL4dtxqgmJMfj3wC1YdxIt+d0
 u698HSvnk6iJaILqo0zo+1GapKbrGbDUn9JAikCFOtE/bYWetGLzjs7NGOH7pzMxJa6me35pQfv
 GPkRCycsy9uF9HGVGedl62mcXe+KnYAnqZLoyRCsH8tPhhoqAwBVtFe7Jc662Lh5Vo5+yBIqm2+
 oCoFPKZwkOE7iN35heA==
X-Authority-Analysis: v=2.4 cv=E8tYNqdl c=1 sm=1 tr=0 ts=6ae3a9f9 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=SI4bJWXHUBEfUJKjJlYA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfX4JuXSKvq0eUL
 Np1cI+gTDMmi3XyFscvimm4NDIJbV7XxfgOpFSoWE2TxnhcJXwKzk6onaiGZPCX+L+ULCtlOT6J
 l9+J60XYwYfY6L5j2cW4IDA4ALMsbuk=
X-Proofpoint-ORIG-GUID: 0tNKb3ODStZRHa5GGbp0EFEhCLl4mmns
X-Proofpoint-GUID: 0tNKb3ODStZRHa5GGbp0EFEhCLl4mmns
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290079
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

To keep this series bisectable.  This will be removed once there maybe-
unused protect tables are gone.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 6d6e4c7cf919..c43efb85fde7 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -168,7 +168,7 @@ struct adreno_protect {
 };
 
 #define DECLARE_ADRENO_PROTECT(name, __count_max)	\
-static const struct adreno_protect name = {		\
+static const struct adreno_protect name __maybe_unused = {		\
 	.regs = name ## _regs,				\
 	.count = ARRAY_SIZE(name ## _regs),		\
 	.count_max = __count_max,			\
-- 
2.56.0

