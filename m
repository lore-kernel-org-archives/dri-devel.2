Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421E6606A32C
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JR4Hm3zr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Aowho4+X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96FA910E4CB;
	Sat, 24 Oct 2026 10:30:36 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B78C10E570
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:30:25 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O8o2VM253268
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=/wVlxKd4PkmwhXBNUJ7fMa
 3qr0NTWTnVoH3SdzxVHFs=; b=JR4Hm3zrxlzl2KROHpnuo/Y+G+xQY+Rh91SDxh
 ON4UdTwTEdaqJo9iJhSEbsGUlpGIbY4BuOplsSdlaKfUjrBRDh/MsilEspyGibnn
 mxm/tnTSi9buCG6ZktCy/Bovfn6T69LLChKI/WW0N4xZSoVs4fsrvQGscgr7O4wC
 hz+Xz9p7GHUdM7xI/Dzyb4MKTPYdOwEdD9GrSF6y3vG9NUHCrF8meBfKP7g2m2uU
 4X5u41o4jum14bv0E5/llNPLeTVVoKPsdgWMGLSC0XO1YZqi2x433tWiTAgeyQRI
 xTsMeiItdEBRC1FOz9ru9KgfikouDDoiEV6FNMkAUCpqu/ww==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgny9rjtq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:30:24 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-18b5ee75447so6376310c88.1
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 03:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792837824; x=1793442624;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/wVlxKd4PkmwhXBNUJ7fMa3qr0NTWTnVoH3SdzxVHFs=;
 b=Aowho4+XXfsIucdMJBn+b60LmgcxqogcFgMLFv9GwPD/C6HrTEy/YSn8mRTr8H6UN+
 leKy7uFR3z4fATYa8US6ZrY3ZBILucDDZAZSDKF4XMyMjID9+0N9mfgpRYD4QF98DwCb
 z3kSiA6cmqfyQqyx+0yLypLW5sZr7qguecg8IAbL1DyCQMVwQNgY21KSqvbiz6cWCGUm
 yGIeCl1Q0P4yMgzQCKERaAypujOy9yr8wdJf6Em6EqZmFTs1K7Cr0LYEqCrwYgEZSaRa
 mrevp6IW07+Ed9QlJBJAAzOHB558ioRtqKo4BSIwSBr3pBa6WOlxblHJ3Mc3dTDeyjq5
 hjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792837824; x=1793442624;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/wVlxKd4PkmwhXBNUJ7fMa3qr0NTWTnVoH3SdzxVHFs=;
 b=tqCdVe7cMPdLurZGmnMjHjUjyXSwsyFgsKV3M/+Gw5zVKC0sWqT9HVVyMKzwYeravw
 UcUijQJYfiHuLE/GWBOXdcGWJ4kBQxbtzEt43LPUlpO042hHl4ox91w91dlQTo9iv52c
 szkPp5mbDbBfmPPpwTstbijMzpViAuv/+FbtPEhGget5a1TF3jqsLU+2YNYc1NocFkmO
 pCPNnfg/9Ajzjizc9nNIcQyyNdR6pyFgG8sFAHPTUYHG/HUvWaH03YxqHk+EPcUKkrJ+
 itxSf8qdwNZ0ED8k8fb43BTdBqpOSBP+daclNrJ2ihzL3JZ/yX7ExEpDb2OZtQYpB2iV
 6Ziw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5QzfBxZhT1+RSKUVRq0Hpf05zIv5B+RTX17MNSelOG2VB5deG+yBXtfwVCo7TUjXlXk8gPJ1nlAg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIk1bPnwuUYUNpuvHr9sjjgNhoaAK9XRRpRqQ+BnzuLLUoZAkJ/
 A5YBm3GZWyyYefNO/BaFJIYgqkjv1iPLaOSByedX+aYrH9DxmQs692qq12VwML6btxvZErbiql6
 xjNlSg5bVUtv38PzY9WH2dNjQHW6mp0RjumoJmnnwa6qB/UzdaFWRSyGUfg+Bwk1r5DBjtkk=
X-Gm-Gg: AYBFou3YY2msQbXTxQZhDB7MJkWtHan9AeeOdu9xqeUwkmxvi1nSYPqOFeyVUeOf5N8
 EmUq7xnRZT0ljEJDFxTp7/1lSUAixfqjH92PjDklWOGXhlq4wgPsM/p0nPoz9dRn/2EuqytLb17
 AN7KcFGEVCgR1LimnQXWhyRD/iRWYOnnSXlemetZaMPquJ4JqSc8Q+uP1m5ujVIgp8QL88Stmy8
 s02Qb7LqG7HSoQDECsb1Gg7QW2kNdjNguRwub9+cpmKZl9M404a+JDqWxIXplp6nNgfXsvWM8RR
 kHr9o4qM5+32lZftNdNZh5pPNy30p444pYoba2Yvp/0a05CnZuG3NnJS5TU7z4rF6n9KcMuhhnU
 4jdssXGRcIor6vjCnKag6t0w=
X-Received: by 2002:a05:7022:e806:b0:145:287:ce91 with SMTP id
 a92af1059eb24-19935625d41mr2734520c88.14.1792837823981; 
 Sat, 24 Oct 2026 03:30:23 -0700 (PDT)
X-Received: by 2002:a05:7022:e806:b0:145:287:ce91 with SMTP id
 a92af1059eb24-19935625d41mr2734484c88.14.1792837823386; 
 Sat, 24 Oct 2026 03:30:23 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19894d5a10csm6009441c88.1.2026.10.24.03.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 03:30:22 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH 0/8] drm/msm: Assorted fixes - October
Date: Sat, 24 Oct 2026 16:00:06 +0530
Message-Id: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK6I3GoC/y2MQQ6CMBREr9L8tT+h1YDlKoZFLYN2Qav9xZAQ7
 m4jLt9M3ttIkAOEerVRxidISLGCPinyTxcf4DBWJtOYVjfmwk4k5YKRp7BCOPnCerJXDWvRdh1
 V8ZXxO6t3Gw7OeC+1XY6R7k7APs1zKL2KWAv/+2ca9v0LYIEbl5UAAAA=
X-Change-ID: 20261024-assorted-fixes-oct-1f981e99e677
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
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, stable@vger.kernel.org,
 kernel test robot <lkp@intel.com>, Jie Zhang <jie.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792837816; l=1607;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=DyAgCOzQ7jVke1cRXj/xTsJaF/hpi2aekJSSNzd4H64=;
 b=eu3K02JLEDdzVu5Op//bUgPkD+OTgh73R+Jfv3KQZyWrr6XdtUexLwemhR2MynagjAeyPluZt
 ymCt0lsJwx2AGx3D4eD5EXwFhu8lHy0I9Lhp7eUEkpOJtwiJhFqc9nI
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: k2Fv5PqiuwQU8A50rrNkCE4SmCumjlmA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX0Q865Dh9qrcm
 Si8RBOyVNq/nShYxngLDHbP8RvxTEEWFYti+yiCquD26sOcnAQJSFTrTBYPIh1vAhdmex81yWCe
 s+C1o/7dgrbpDqxdzOxj31xHlkrqxztLmZRI6hcAz9V2W6fEaciIoD56sN29vAPr6+WUKK4X+Qz
 RO6BwyXhBR+NHQIzsxqXI0IRZaaah5l2Z4AojPKiMGCKssqhTx8wuAY7so2m+O+O3t7eOcQPgTn
 8MQo8MOkm65fxtjta5O/XBUFNMgzT6XwQ4Lf1QU2/c0v+4VySqephVWZud5ceAb9KKyM+g6X+jU
 Y7vspVvexL/+/wsKSzG1ioeubICq8o/0FHmtgoeesnj3tzZEDemPknz+pVT5HePrpvIM9z8roF8
 ufHd5qClLunNo0yCOPlDUFiLINHC77PVKj/kdrv/RAM3ywm3wgAkEFZpmC2Rhc4nBSaTC0m2l2Z
 obeaPNksKu5S6f11+rg==
X-Authority-Analysis: v=2.4 cv=PqcG/AM3 c=1 sm=1 tr=0 ts=6adc88c0 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=HoIANuw4g2egeWD1xvoA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: k2Fv5PqiuwQU8A50rrNkCE4SmCumjlmA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX0k6/kCwgVDY0
 /rYEPAXIbRoHpxfZNLGwfgZz5JDmxAAckMmN1P08muNCB+h2iLJrXL4bEdBY5w83gXFbb/PG5Z8
 j4malUNTsLMEwR+Aw+V/ofkIjeMjKrs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
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

Few assorted fixes for drm-msm driver lying in my stack.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Akhil P Oommen (4):
      drm/msm/a6xx: Check BX dependency vote index
      drm/msm/a6xx: Reset preemption records across suspend
      drm/msm/a6xx: Request CLX enable from secure world
      drm/msm/a8xx: Add AQE firmware to Adreno X2-90 GPU

Jie Zhang (4):
      drm/msm/a6xx: Fix GMU shutdown idle check
      drm/msm/a6xx: Fix stale boot up BW vote
      drm/msm/devfreq: Record idle_time at GPU idle onset
      drm/msm: Fix sched_prio inversion within a ring

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c             | 31 ++++++++++++++-----
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h             |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c             |  2 ++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h             |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c             |  2 +-
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c         | 37 +++++++++++++----------
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c         |  1 +
 drivers/gpu/drm/msm/adreno/a8xx_preempt.c         | 11 +++++--
 drivers/gpu/drm/msm/msm_gpu.h                     | 24 ++++++---------
 drivers/gpu/drm/msm/msm_gpu_devfreq.c             |  3 +-
 drivers/gpu/drm/msm/msm_submitqueue.c             |  2 +-
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml |  1 +
 12 files changed, 73 insertions(+), 43 deletions(-)
---
base-commit: 77cb3534193b758eaecd662a610a3a1bffde43ed
change-id: 20261024-assorted-fixes-oct-1f981e99e677

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

