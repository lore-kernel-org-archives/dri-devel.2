Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A659A606D827
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=olHCr/66;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gM5CZtHs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 076FB10F92B;
	Tue,  3 Nov 2026 23:19:09 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EC5210F922
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 23:18:57 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3LKcC4854644
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 23:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=4ZZP969Qa0dVMO0pKpNSkAF+fJQV8oUTt4d
 8+dXPutk=; b=olHCr/66IZCC+qkXrqdBMMyHNtXAfgoDUbnApVOlUdMkYMuw56w
 /bfgzdBXW/CVS2eu3nKrplMwD0CsZFosPuyUXu4rS8fgebdH2xznb615jXiElwZW
 ZBW0aknArj7jBXtwum40l4v4t45SYnZKXQLEHZT5H+oHLw2ifLl++kU9r96BSl+t
 DKq5bBCAqY3mm62jh+6DJifkWkB1ht7o6Kewndo6rOWBQdp9kPYQjEno2vZqiAo1
 sHsUesJbA46R/FwsVFkhAwwXMvihCImYmXF/DGA3pTabFdFoNATbvMYQkW0cos2t
 RLaeb/yqgQ8RMKKggly9BAh1iu/c78WVtCQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqpuv8ffd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 23:18:56 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8a01ea9e318so263668b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 15:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793747936; x=1794352736;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4ZZP969Qa0dVMO0pKpNSkAF+fJQV8oUTt4d8+dXPutk=;
 b=gM5CZtHscMDbTrXNbPPakf5XuwsVwQZ31wbFFYq0BcD6KVj7CHCPDmjLy4aBqbwbdW
 OvYFXOXFVv+eHzDFqVNGchAqvDhvp2HNFNWYlCXWfiPCQq3OmE+6C27tWdD2Vc5U0t5+
 xO8/JhA0B0jZX01iUNf7/b21hjF8LNPYRjZdzzgbxMgPdywVNeD2EDYVC9uk8IL9SOVG
 mC+n8IhincaMCZ9MqYAtlHgiwiEE+EPcdtTF2GfYG43OwrXYjscDB+D7NuNDiwpbC9yv
 bhWXZ3WqXXnIRkhRGsByClKBs2GFj70jt/NyQIU7uQS1YbMwPzhtPNxolLS0oGC4b6t1
 7sGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793747936; x=1794352736;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4ZZP969Qa0dVMO0pKpNSkAF+fJQV8oUTt4d8+dXPutk=;
 b=B8D+1ocureTUzkHDJ1EKXmMcUvpQ6FA6+B1e16hBUIQwdDsiyyoE3Fbd95DyeYxJQI
 7LEYN/F7mK8qMCpoaJwNGxSyhAMt8dUqPEJBz+tKw3v857SfclfgMqWhPKajw7LGnHww
 8YVBDOVtquEG6J/uPmAKYgpmaQ5bDZtGxbu+a7lMEo8uCXRQaP0lE8HMVTXKoGiEs8wT
 kOX8xACLZZlBu8tQ80jBU2o9xh18H6tFN5H0fG2scivC2JsbtGU/Ly550ghY/LmaV0oE
 5/3kUcRKY/0bQaw9CvmYz+07p4ulOWMVKZ1u8RshEj5VJZe0WNeWcAIIGgsHGRnj2ZnD
 Lstg==
X-Gm-Message-State: APuU4Z+UtlpyQJB43dSjxJQodAe6X0H9UM189QkoZ4dJXtRgtTlyLVVk
 kbe2pLkOlEILSQOWKf8H+UndcuF0DCRC3BR3IMgR0eqlYwMnrFJDqdPaJzPDQKXbdXEAtX3ZZ0X
 mdv/JuZA1wNuu96RpORfON0tKYySw0Z+ad7hofhCyQnBe4XHdewMHtWxkQVvYnAYRI9yi3WmBR1
 DjIoAZOw==
X-Gm-Gg: AYBFou3DO2IC8VXrY5Td2YCxjOorunbIfzmxYvZvTYKR7LGFmyxUouCML9Ju0ZKKjxw
 T3XrSmIYrq1pLzyWSJ2nSy3oI6mOo23b8EQ4ZGRayI7e/3Jv+Cv2Xgg0xtIrrDTs/g24MktEHdE
 kN+P/IFiYKXVy203/CRt89IBVKMqLiQG0GZefbBIxis90HHn+yp90QWzs27GrgbL5BXyElZgiXc
 keqm7kBQ7/Vfbxx4SjJupd2M8t81nDGcnlzj7oVTB5P2Z2Q4nKdhPEhaWamEc5J7Yt1Xkb4zytk
 X0xFDQgqeS0uz8qL0iHf0Ce0p5lAlW57nVI319eDCmQpPO2QODr22E63hrK/4/Q8jS9s1WEqt2v
 E7ER2DIycS4Q2vbbkBzwc/hbdd+GbQllGF7eXqXN2BeY4I2BNElld7HCnSdO1g619/AN5wsc6PB
 evm5q/6B/ScZYOiCjIDV9wNFWtjjQPjvUUnB79C6BAXWK/hKXgjKWcdFoKJsY=
X-Received: by 2002:a05:6a00:3a21:b0:881:8784:95ca with SMTP id
 d2e1a72fcca58-8a9bf04dfc6mr12252536b3a.33.1793747935929; 
 Tue, 03 Nov 2026 15:18:55 -0800 (PST)
X-Received: by 2002:a05:6a00:3a21:b0:881:8784:95ca with SMTP id
 d2e1a72fcca58-8a9bf04dfc6mr12252498b3a.33.1793747935377; 
 Tue, 03 Nov 2026 15:18:55 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b09b667995sm142420b3a.40.2026.11.03.15.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 15:18:54 -0800 (PST)
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
Subject: [PATCH v4 0/6] drm/msm: Decouple IFPC disable and sysprof
Date: Tue,  3 Nov 2026 15:18:39 -0800
Message-ID: <20261103231850.17493-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O6SsLx9W c=1 sm=1 tr=0 ts=6aea6be0 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pAKKPEBcNh-_eZAUbWwA:9
 a=OpyuDcXvxspvyRM73sMx:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: RQCGq8fEqB90QnWit5m6GDZcFnCgkgcy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA5MiBTYWx0ZWRfX9RY2hwnYVTDs
 LZ7qYIFaNp1GVFlsPQz7ySEPYTA3K8Wb1lrovDKZi45Em6TiLyhbw1JM/Gr4X7hRKSLjsNb0fxF
 K/nNAfu38f6U2UzDfp6DuOgnAk/+bN0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA5MiBTYWx0ZWRfXwOBpKzCAFrr8
 ioRvJWmG7zws8VnJG0hF5+JhLUjk72skhfVuBvZlCMCpdgJLNyxinNdtFyvXcF5EH1fJk5O6UV5
 5sW0ugXAzpQUi3eY9y0sfklGen56D4GvOn9zOeDhBVbLctTX0GmRohpgD1Oe5l2n4Ku2m9xvrOK
 nWXKu+FmmVA0UhmKoCYuI/MNqchL/Q/eCVJWFZo6OTkSSI0hImzxP+FQRVYBZi/S5U9Hm0xYPM1
 a+zbWgMwav71Sm9T2xDYbaiPP1uym6V2sxvRJA7vNy+/z/v5vy27uS1yVRdZmzAzxd7ct1Q8BK7
 fvZtwez1r1nx1TFmwQCrSxr5oFnNlCQDn9x1JKoGsEjReMvkMLnqIYgwVqAW3UEHucJ35dkQHwe
 7ApBgJt3UBK96EC/wzDxJxvMItUPLgh6DajjH1b2cGOcIhpqNdS243DozY70ekPd2/nHcF32AFq
 3OWhtcEl/karLu3/ebQ==
X-Proofpoint-GUID: RQCGq8fEqB90QnWit5m6GDZcFnCgkgcy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_05,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030092
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

v4:
- Don't clear GMU_STATUS_OOB_PERF_SET in suspend path.  Restore it in
  hw_init()
- Don't require gpu->lock in a6xx_gmu_ifpc_update(), but instead warn
  if needs_hw_init
- Move perfcntr resume to after hw_init()
- Link to v3: https://lore.kernel.org/all/20261103184713.29664-1-robin.clark@oss.qualcomm.com

v3:
- Rework IFPC disable harder to play nicer with hw_init().  If we
  need_hw_init, simply update gmu->status mask and let hw_init()
  restore the OOB request in a sequence that won't anger the fw.
- Link to v2: https://lore.kernel.org/all/20261102190010.720443-1-robin.clark@oss.qualcomm.com/

v2:
- Fix double acquire of gmu->lock
- Fix missing a8xx hw_init() path
- Link to v1: https://lore.kernel.org/all/20261101174631.23637-1-robin.clark@oss.qualcomm.com/

Rob Clark (6):
  drm/msm: Hold runpm ref in set_sysprof()
  drm/msm: Resume perfcntrs after hw_init
  drm/msm: Rework IFPC disable
  drm/msm: Add cleanup help for disabling IFPC
  drm/msm/debugfs: Use cleanup.h for gpu state dump
  drm/msm: Inhibit IFPC for state snapshot

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 28 ++++++++-----------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 11 ++++----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h      |  2 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c      |  5 ++--
 drivers/gpu/drm/msm/adreno/adreno_device.c |  5 +---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    |  1 -
 drivers/gpu/drm/msm/msm_debugfs.c          | 32 +++++++++-------------
 drivers/gpu/drm/msm/msm_gpu.c              |  5 +++-
 drivers/gpu/drm/msm/msm_gpu.h              | 30 +++++++++++++++++---
 drivers/gpu/drm/msm/msm_perfcntr.c         |  7 +----
 drivers/gpu/drm/msm/msm_submitqueue.c      | 19 +++++++++----
 11 files changed, 78 insertions(+), 67 deletions(-)

-- 
2.56.0

