Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4045BC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 17:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91BE310E40B;
	Wed,  8 Jul 2026 17:34:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o5nTaVNM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RRWc5BDv";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66C6010E117
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 17:34:33 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668GLJDW3330123
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Jul 2026 17:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=1rGgtM6FUa0v9t2Aypzhl2gBrk+6B3pV8ze
 imKlx9fg=; b=o5nTaVNMyXVvtbjvN8QXkf5x3nHWl3wU7kPWITeRW8MYTP5bHnS
 gxJzP4y44c8ilWFZF1lX5ipOapLujj4zIWtTvCQyMGN1KpKHVHzQXn7vbyTGMBwL
 NpMQ/Vs5CThwP94Z8qMTAXsXWpiaMzBFE5jm5M4BOKEFRb4QaDHRFOLczOHYM1gh
 r2HQT+l+ZL+emtJGWKTlh2VWeukZIk+YqWWc0e75dzCiH7hd6ywFTrMkzU2IkUl4
 Af+6FqHOXMEdbg2tZh9fbKrFt7PSQKo2UJmuzTLPIJTRZht4e7TP0MRMQ9tfvFAe
 lsrMC3Qemo5LsTBnhskUmAXnI7NZygWjyOQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9hnv2qnp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 17:34:32 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8484b57b98bso901241b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 10:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783532072; x=1784136872;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1rGgtM6FUa0v9t2Aypzhl2gBrk+6B3pV8zeimKlx9fg=;
 b=RRWc5BDvJn6AF+BsmW/K2hCFOjjpvsMVkUpZE5MP3/k9o5RTlFTSJbjGayHYWfH1il
 zS3t7MvixrC6y+8gB0xAZo+hvAdf7T5HA9338l6DuUPPTu39nClbAnmZfTfrJ5KjX2XU
 R/SOdZy70uoWehUnG9NRzeoGp6CoacIMOsXH1emRJ0N1NOb1aj0ruDnZWaPuhc9/agNS
 v5n91224G7o4Ou1qOkXzHMEHYfr97587ddDLgjtPY1CfgQrwNog6xtKiEP/DZpnjmM0K
 Kl2R096sjKpt3aNYKRs9um14NbyYb7O7eWAD8PsM295XaLNy6rv85b/Twf9qAhqegl7m
 ImHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783532072; x=1784136872;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1rGgtM6FUa0v9t2Aypzhl2gBrk+6B3pV8zeimKlx9fg=;
 b=MOt23bHMJlbBgpzDfByq1attvbi9brRXEw3CoLjUx27HZddJXgPD2OZI2dpQ33K8wW
 XlZCAC5uCY5lh77ZEN+JMyIte/cMfvSUSDxbKpy+H9+d78iD9ZriWzIoF3X0e+CO2YSr
 m/sY+MVXv4fQcz2wIArwlgDq0VoAdBX52yRmOu17C12cE2s/oDfDZ4n2EwfNgcRwD2Sv
 cJc78UpPUH/Fn7IHrxUlBdLyjVwm/nv8VjnoaYU9NCNwGq4biTPx125glrXPfnIekmTV
 9OGkSBVB24XZf0cviQZF25XZgxiBhDbMoS2j56WGA6X4nsI8YoISDnXgqbHQUZQa7Tdh
 En5A==
X-Gm-Message-State: AOJu0Yz3umvpLcLuD8daQlAQmPBywN+i11lNk8E/T5GRNlzCzT09jw/N
 4bruGwvFCwVZ6ThOPLKTlJa/lm71dJCmf3QrloFrutib39Py7HBILoCxe3mz2Sfu2AAHzj+1t7C
 Ldsyv2vNruUVREdUaM+N2sNg2R6MxQjXQwa4k87O5/tbkRv/QrFNA3ETQEAgMGCvHBb56ENe4vj
 sjSc0=
X-Gm-Gg: AfdE7claCopu37E5UxMKJ+NEoIN0NEXCDlD/p//DxdZl98A9yBVVqDfCaNRizDK7REU
 w2tz5/KfsLB2T8CyUD8/SLeuKeRyP9Vvv6tRD2pOvSq/l2nPhhDyrNQ6+IMlBjuYboxIbaH8mTP
 zzymnP+qa4dxljUNFjTX42E7lHXIcoNQcDysqJ72UG99Nb1aXhl6KIGTJhzfUVrAau3U2h54ZMf
 gUVEdtuNNqme7X8iS2v7uoRKoPGxyGxDVf0JCnwZvVQvQqT8DgjOp5UulvnCw+NUMBe2pTxytCM
 eR2JWsydfrZEuy/2PV845sfDbTNUxeILLs/FHHPaCzKspsOF4XQAT2k2VJdRStp5HrvFGeiYtEE
 PVNeONd9PU9HMwn0cuRXvw8JkZK3EsSC90Z3AOHL67rdNLmovizECBqYALA==
X-Received: by 2002:a05:6a00:3026:b0:848:2e7e:353a with SMTP id
 d2e1a72fcca58-84842e7e06cmr3612066b3a.0.1783532071751; 
 Wed, 08 Jul 2026 10:34:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:3026:b0:848:2e7e:353a with SMTP id
 d2e1a72fcca58-84842e7e06cmr3612048b3a.0.1783532071301; 
 Wed, 08 Jul 2026 10:34:31 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d4edb4sm7399904b3a.33.2026.07.08.10.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 10:34:30 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 linux-kernel@vger.kernel.org (open list),
 Marijn Suijten <marijn.suijten@somainline.org>,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v4 0/6] drm/msm: A couple lazy-vm fixes
Date: Wed,  8 Jul 2026 10:33:48 -0700
Message-ID: <20260708173356.578713-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KNNqylFo c=1 sm=1 tr=0 ts=6a4e8a28 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=384pi0yy4wJ6F0PkkBwA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE3MiBTYWx0ZWRfX9BjHKKRknefr
 jLwuDhoWF3iAkzLet3A+UMr++B0fyQl4WvhhjMmvcdBDM+Qi2orEQ1FjbdK6CBXupZL3Z6qiLQN
 cUQ05nY6IDNImPiwTJ+U1iZ4Munq6wY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE3MiBTYWx0ZWRfX74LUykZS9xJq
 RgVJYaPV4FQtxjXjKH/cG1gFTzhYW8Vj+usryV3WLYxYWZdLmREG1fgl3m0+FPr7PJggSkJ27Oc
 FJr1WIeCWgKarOUHQQVhNAIZ/AxA+yWHCU/JJhpRsS3tszGKKO2am4YUWMdpk/L+JxP+vlc/8VI
 QaK26j7zy2tzaXDb26awTJ7m6rPZUQUnHzzfkymTYoaBcdSRY83J1dWoCS6bFLnoWaa5/C31/us
 qbjuy3l3Sqx23yUFxhiXwEudtsfxJ4zJOptko2DDIA1pJeTUP85FVxY0EVnRbvS6nDWdZq1dFWs
 UvIZeKQ1mQs/EJnAD1MpydQO5m6kEpQLEd1lunwpKW1AKHBRiYkgQ3pdEnjy7mzDzmPqmRTzcil
 4ufdMNiwUW8XlMxLZ0Br2crP5fthKfVwdVzyg3CsENM8Eo1/hofmvwmxsb2p8Y6e4mAJvKn0nN3
 vUdJmwYjKGGrcyBS1Xw==
X-Proofpoint-ORIG-GUID: WnnHeU0uYbp6c_iVpcCUERtUzm-15L5K
X-Proofpoint-GUID: WnnHeU0uYbp6c_iVpcCUERtUzm-15L5K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_03,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080172
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The VM is created lazily to give userspace a chance to opt-in to
VM_BIND.  But Sashiko noticed a couple paths that were not handling
this properly.

Rob Clark (6):
  drm/msm: Fix barriers accessing ctx vm
  drm/msm: Block VM_BIND for shared VMs
  drm/msm: Validate lazy VM is created in GEM_SUBMIT
  drm/msm: Validate lazy VM in GEM_NEW
  drm/msm: Fix per-process-pgtables check
  drm/msm: Remove invalid overflow check

 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  2 +-
 drivers/gpu/drm/msm/msm_drv.c           | 13 +++++++------
 drivers/gpu/drm/msm/msm_gem.c           | 11 ++++++++++-
 drivers/gpu/drm/msm/msm_gem_submit.c    | 15 ++++++---------
 drivers/gpu/drm/msm/msm_gem_vma.c       | 11 ++++++-----
 5 files changed, 30 insertions(+), 22 deletions(-)

-- 
2.55.0

