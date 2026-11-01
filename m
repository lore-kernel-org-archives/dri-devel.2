Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91280606A329
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SgdbfRuQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JjwJPgap
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2B5410E129;
	Sun,  1 Nov 2026 17:47:04 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF20310E129
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 17:46:53 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1HPs841451132
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 17:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=sNt1SEURO6Fp2bP+i5dHn8qQfR3UbcdxoVQ
 anIQ8xmM=; b=SgdbfRuQ7cehi3Gl4/8xYqMO3//7VC0XGpnfIv+d3BWvGvT8+of
 erljRqDDDXQuzBAdMV3yMlH62Vq34jM5SuPiQB0WBZHwbPMu03tBM0UAGSEWeaHa
 WlfX7HJlHUNaFEyL4Jkq0+vWGf1JcxLfAcWIEe0KJkN6R3XZkgg0wH4Fk1SAepo1
 53atyLDOp5qISRYJYxqfPtPdi7KdjyYhHR/IuLXitjLtn5H9r7yZ66tnwfXW2lCr
 1x7SCw5Y4RjUtsgp/JWVAJCr6l+mr/CBqMsSYPNNsc84lK982rwtSnIkqonquclQ
 CTp1DFBmlpKucCQSC+UmBHFaCFCKcm46BGw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn5pkm8b1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 17:46:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2eb00825063so22382635ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 09:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793555211; x=1794160011;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sNt1SEURO6Fp2bP+i5dHn8qQfR3UbcdxoVQanIQ8xmM=;
 b=JjwJPgapHTkGZhRcUb/clk6wZE+f5pZS4x++g94OBN/PAf4R2LsdXMyAayZxquqh8m
 Rp4E+zdSVFRtpKR+ml1BxO7xzF8IC6DQN9EYU1504hR845tl626nmG/zIOyK2nywi6Q6
 8HLmwRI6BJHjAICwHkb3Q6mN7wv++a83Z/a4qenhb/eD4QBw7/rZqDsXQ+TSyrmHxrxG
 AzoaH7XZ1C1xBPzKztm6/QALpgaxOkOgwP9DCShqOgAXIVPzqgvSAb8loB3zeeCy1fKf
 Dv5thKtXIaPnX1xzIQfSFFa6vAaW0fNZKu7shmonMjaQnjxp73GIy+WKLaWO16StAEgw
 HYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793555211; x=1794160011;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sNt1SEURO6Fp2bP+i5dHn8qQfR3UbcdxoVQanIQ8xmM=;
 b=fvhCcnzDJJjF4y2hEVRExX9y/EIYP2xz1Z+3AzQ12xOiSpGebYcmFKNtHi51CayrAV
 uBkBH1e732FoonpnDiM5jPPpSqIL6Hk4/jlcuCncuGulcoSx/Zj8dWPoIAR2s/t+sGn+
 CFvwkFzD7P2tadsMuYxHUW4yzgHiooja+Br5DT1leG36FC9oj4l4kGjsRtIPdzZHB5qB
 9ylT7QlN4Hu7JG92Okcpme8HVqjekeqddU9Z9VqY/mZbfZyPlSxFs0Phw8XubebNPZLk
 WnwB9gBP1zWhC9gP2TCgErkyapKmvghDpVMyi0MYThAUvFCluHDE75HRNRe+1W+T1QsQ
 i1RQ==
X-Gm-Message-State: APuU4Z/WmytEhdRNgvFCEkOw0aba/8zH/H3m0YtL4mX+5Qy++gD39on6
 yveEjyIQySBG2Sy1M9vTKBoqePuVLIEcAha0vAGHlCMAEg3ahse1CrFdVqkYGySMtyhY7deiyqL
 Kg7fqvD/zfTHxa33F+Sjjd0c2JfwegYgoghsFyyK2J5+QAbvx1LSM7vcqDPhTnjIEvmRNe3+KVf
 Vhr2xyUA==
X-Gm-Gg: AYBFou24KW3zvPOFfJYN3p/b3gEGM5XmlRRjBQFVnd4kgHSLfbgqfj1Y7IFjUC8qe+2
 SXOJnMlQUa8XViuWXn1mBl6hwNBLx6E9l6qL/XeVp1wlXX/8kqRLqgkFy5Wn6sJPwH5BKkx84VI
 hTtjOFgpNBaavigge1XSqtvTA+TzC2YM9ZxqPvzO23yw0M/01sV1bpLmy+jTe54argkkkoZqLll
 b90bVumVPTYsaBwMXemhFfm4gFW4KF2kmaByOFV9yMBB1v6lASvEy8ATrKygXQvVuUDrIWc/I8b
 b0P00QySL146+Zfxd4lCcWghl2NPApJ/11wIuzrhx6+ewoX2RpR4mDC+WsVOKiJ7ZAjwBoEFw6N
 6F/8Z9PFajsO0hU1tm6vEmYN7XKlSfukM4YjuMUjsC7PJsehtuTAeFRC0TePiIbdms+oUdnqwn/
 RbQvbEXHIDhzY+pNjTqKNf9Q==
X-Received: by 2002:a17:90b:1845:b0:3ab:8288:b8ce with SMTP id
 98e67ed59e1d1-3ae8974d028mr3953487a91.24.1793555211541; 
 Sun, 01 Nov 2026 09:46:51 -0800 (PST)
X-Received: by 2002:a17:90b:1845:b0:3ab:8288:b8ce with SMTP id
 98e67ed59e1d1-3ae8974d028mr3953482a91.24.1793555211072; 
 Sun, 01 Nov 2026 09:46:51 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e99b267sm15076953a91.14.2026.11.01.09.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 09:46:50 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 linux-kernel@vger.kernel.org (open list),
 Marijn Suijten <marijn.suijten@somainline.org>,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 0/4] drm/msm: Decouple IFPC disable and sysprof
Date: Sun,  1 Nov 2026 09:46:24 -0800
Message-ID: <20261101174631.23637-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 81Qlo6oHm-6I-dwU4bnU0BHFyyRE-zBT
X-Authority-Analysis: v=2.4 cv=Z4F5j3RA c=1 sm=1 tr=0 ts=6ae77b0c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=e5mUnYsNAAAA:8
 a=WAnUiRRfp7J0bigzDMEA:9 a=GvdueXVYPmCkWapjIL-Q:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA3MCBTYWx0ZWRfX608kLPYmc62T
 DgQAkxNLgEi6ZZFXZYNySUEcDoIucHbRqoQDADB/TUyQgTQA2VQ41AhsKKHf/IHs+Oik5Dzfk/T
 39Vc42Zk0Rbz4gulOOINgDr+X2Oi30U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3MCBTYWx0ZWRfX8Ag6K8CT3Bcc
 OWvPC61PDdS6UnqgXe+0UZPAvWdAvAUOzlgzWaR7zSMj5r3B6titazRDHiyE5X55NxmlPMbzcp3
 xDUjT8HV3mqzsp0nhbm/fakp1qOH5nQwqjP6HYo2d/xMarjL/qylMuPG9lPhmUnd+et6hbWK+B3
 cSkD4iC62ixTp0/dY1s4/4xNOclYQ8oSntZKRoSPqj3pRMyB5NJH/uSW1PeFew1a+3QPowaBOVJ
 IORyhTegg7ijLbVcHeEyJlmYkA7NwJxIVxCr+Mxs2xtLk3GibVI3QSDb9rjVxFT1uMOwpH3Q43O
 PQsSVPZagmedfRmAgj6trFUmnttQZfUzC89wb/6l7KV0xLck5I0qMpJROTGmsWFZxbNecHjLq4a
 elrzCSgEl6uuoQJqt7FbsHyr+metCEIoKsJYcJHAMbcXV44381awN+EgheqGAlSd4ZW9DDShvUv
 H6D2nFiiCRpZamF9y5Q==
X-Proofpoint-ORIG-GUID: 81Qlo6oHm-6I-dwU4bnU0BHFyyRE-zBT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611010070
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Convert IFPC-disable into it's own refcnt so that multiple threads can
request IFPC to be disabled without stomping on each other.

Extracted out of gen8 GPU state capture series[1], as other than fixing
a missing IFPC disable in debugfs state capture path, it is unrelated.

[1] https://patchwork.freedesktop.org/series/176505/

Rob Clark (4):
  drm/msm: Rework IFPC disable
  drm/msm: Add cleanup help for disabling IFPC
  drm/msm/debugfs: Use cleanup.h for gpu state dump
  drm/msm: Inhibit IFPC for state snapshot

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c |  8 +++----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 12 ++++-------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  2 +-
 drivers/gpu/drm/msm/msm_debugfs.c     | 31 +++++++++++----------------
 drivers/gpu/drm/msm/msm_gpu.c         |  1 +
 drivers/gpu/drm/msm/msm_gpu.h         | 30 ++++++++++++++++++++++----
 drivers/gpu/drm/msm/msm_perfcntr.c    |  7 +-----
 drivers/gpu/drm/msm/msm_submitqueue.c | 10 +++++----
 8 files changed, 56 insertions(+), 45 deletions(-)

-- 
2.56.0

