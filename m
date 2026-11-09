Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7EC6083621
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GxlfGPQ/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bm2VBdji
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F38810F383;
	Mon,  9 Nov 2026 14:21:56 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04FEB10F35E
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 14:21:33 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DFBtT359256
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 14:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lfoXwA9UTdo
 ZzNFdOqsicYhSJ5ry/Efkki2NBM8m1i8=; b=GxlfGPQ/B0QTgJj+VxKJcPcr+GV
 ruR9j7k+NIZsuS3xdRIU3n+/H9EMBDzt33oxJkVADO7KBEkvm0LS8Xpa6WTrYdWD
 A17luVLRTqgTGeSUiVuO/Whtnub7FZsFIuCDfL4Zoc01Ln9MND75uZ7iut8IQnm2
 ZJFj1us+OUNAjDUjskVU+u2AJZLemvDaGN7u135dUcymBLa3VBquGhLfa0J+Iv9J
 X2qRpHf7f1wzkV/tKl/9wbF9tAw7VdgwFjMG+cDi0tZ+w1FIpZNSRwBzEC67bpbU
 nI20nFw4YrjUwCxzNt9NrShg55EAnvwp2d3Wuh4Kzo5jbyEyxXnUfkZIf7w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2j1be-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 14:21:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e9995cea88so9155945ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 06:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794234092; x=1794838892;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lfoXwA9UTdoZzNFdOqsicYhSJ5ry/Efkki2NBM8m1i8=;
 b=Bm2VBdji0+cPLxY2XlM3gv4MD6RiyATh8q+7C6sH6sq8Zoq7qXmi/l26gFDcnB6Ogc
 2DT32jAFmFosDuQIC/6sKZIAJiErGGTUmt1Ya7v6VTFs3OEZ9U+d8P/aJ9tCgSZfZoEJ
 uIuXTSyuxXHjwLXIDdnWbOal70Mb75QRbI/Y14CaDr7CAK81RQPGQVK8n4MIlnMSePSx
 2djI5lZJF1qhH2y5C++u8ILWKG7D3k/IFCYmKn0O+JWfAioDX2cNPsm2FTUM+4cpWLb6
 tk2DHFSTPnc/KdIyjNUrwShU33FJ9JwtqFYqiSo/K6e/AeGW50MGASC4oG60uFYDeh+b
 xI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794234092; x=1794838892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lfoXwA9UTdoZzNFdOqsicYhSJ5ry/Efkki2NBM8m1i8=;
 b=m67ld5UPBt73+gMfyHJ4kV1T1BDGAMNJuCSfOwXmcfO8wTw/Z1H1wtvVGc7QkCvHZD
 GErJ7hE0p02ySnCbYJV6XmDkPf2GTDAgR2tFXp01hKl9G5fRk4ZUC2J+rLZftevZSW4F
 +t3U7IuE0CJ0XJOMTBMpxf5ghs/DB8gd4DMX1O8Lj/lo0nrvtsuLjZx/ZRn7GuEty/CG
 F5lwmUAwy8qJ2D4DH22hJ6B0yC2A42O1g5A0u9XBpmVWJFjMFGa5BF0fboTy5Iih20tm
 zWVe+85fp49MCBIe2EKeHQhtbalSRmcBHMv3QmUG4m251BX33aQpN7ZuoJwd8eKhbUu7
 mtHg==
X-Gm-Message-State: APuU4Z9yfcr3mxPwgLHYJDDvpspTiaIPjuVgR4VMaLVvpMVk9+zzRbwz
 mVsAeZkIa68+Jl2LtDrqtyFSTYT7wYUi1kulxT0Ypf7gt10ZB5XulF9U5u4KWi5k62IbEmIFUzh
 WHiOBgNLFfybrqnpLFQqnVFJWoKxh6XpjCbKtVgHso5Soe10is4teqRSnyb1qwGHjVj65flwpUT
 2JRCXaaQ==
X-Gm-Gg: AYBFou2kEhwgGt/APdbepc3UG8d77niN1B0BuLWGchGAkoedPoDveOCIDljjAAoFxou
 O4W1v0rCUzq1hbaZzJdOEV+ccFa3YD2/Dt/Qikz7a7oQ9v6bfGmHqXNcghLzUqXU4x5sZr6O5gj
 vEQXwdebHkMBl6ImWak5+pbKlDu6JCD+S9DMKscQ24nnSo6Jz/7BLPFP+9DKrsD280K3q1hUNzH
 bq3vZ1IATWYkGuUuwaaxtD75A/yc2MHXBnnOLOZRGAfUQHOSB4k1p8OnPAxIrxCJ4eqw9m2PlnN
 2vK34jD3LmfOGfM6H/tQnIG4lZWB1wEBwhJ+ElBAtKFKGg7bfusE7zxcsRjBQlBIJ2kFcXV5weS
 svmlyVG1qkMcQksOXDs2w4wdPP2ob/yc4UKI6H+1PUgKhTGG/wssO2nrCyCXVKq8wZFpfTfd2b3
 rlD+e2tozjRilm6VrH+lndGWFMvhZ6+nALo7UPEKL5UjQ18QfdkKVTla7vKNJn5w==
X-Received: by 2002:a17:902:e810:b0:2db:733c:fd1f with SMTP id
 d9443c01a7336-2ed833c44dfmr41960925ad.8.1794234091961; 
 Mon, 09 Nov 2026 06:21:31 -0800 (PST)
X-Received: by 2002:a17:902:e810:b0:2db:733c:fd1f with SMTP id
 d9443c01a7336-2ed833c44dfmr41960585ad.8.1794234091496; 
 Mon, 09 Nov 2026 06:21:31 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed81600ac0sm12128725ad.32.2026.11.09.06.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:21:31 -0800 (PST)
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
Subject: [PATCH v8 09/15] drm/msm/adreno: add temporary __maybe_unused
Date: Mon,  9 Nov 2026 06:19:55 -0800
Message-ID: <20261109142111.256630-10-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
References: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af1d6ec cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=5VHPQfPT90DSkkNPp7MA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX1k96dHxYLgmZ
 ePAnqxqjWCkIJtCw2YtVurWRPh2vw/BYUJMP6+ek9xPsJHzuepjgoNvN6+YgzLXvEGakQpBt+8i
 xaaH27swkBMO0BVchjLDop9peTVjwV1tCcmFWrGxtI21R6oTkJId9KIgBTEz/T4GsRqLiZCDRhg
 bwyZlii50ZPBAHv0MpmTxu9X05HigdBGMo5r82IGhhi7lz8G9RbTNYSC6vlMsV8zcUsf9esj7Bd
 8FGNvlHE9XCJonm2EpYCqQDDe3GVnxJHDyllk+RjYdH1RqDJyya2WiVi+oAR6NxMbqbm4eS4Gmq
 z/mX6do8QhJtdXJkjUG+hBBzRm/Xcr6mPFXYEqpMHd6YKBK7iYaT30ACyZjkbVNgDAs3kbGQqw0
 8ncJ/vKTjlk6HmBgkike5Rmg3Z5Ks9/8/aa1ww+vjXeqDf6f5u80xewTR6ppyM0a3f/2FaC9SK4
 bn43rl+dsxaDiVx/U2A==
X-Proofpoint-GUID: qR-qrP06Wx5Al_NHVprda6mHAWET7hfz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX7vWbuqwgRUku
 TnERmv5BsaBEC50223/J8pNieuefDS1WvuG4nxgulZXjY+80gpQQwfl9Q/ISj4qcYP46AVaFASd
 w7Wx/ge7b5oLYSmUPPq+xTeZXi2q7dU=
X-Proofpoint-ORIG-GUID: qR-qrP06Wx5Al_NHVprda6mHAWET7hfz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090057
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

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 9e0d37ec9c15..2408adfeeb23 100644
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

