Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A126C44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A80E610E185;
	Fri, 17 Jul 2026 20:48:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MZ3dny3g";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NvJUULun";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5FBF10E185
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:48:50 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJtQ7Z2990425
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=mLxHuejfrhgCMW6u/ETcstVIOqaiD87qppN
 P8Q3+2oI=; b=MZ3dny3gRGUt0GMCkKwlZxJ24ZgKjWKB98Nu00j44aFiHbGHaS8
 2Y4JDXLnfUmb+cCWc5RjSmmXa5YFsFwPrDxzzpaxugMwZiHBcn50BhtuVi6n7F6V
 WDNJ/AYwuq/Tyt5HBmubdUZiEIln1QHD3Bmok9XU4qgirMU3l0/KcmOiG8qyEBay
 quwBLUkmVHjWOf7IXsUckNEHraU1mvcx88Xsrzu3wNEuA74HsDu8B62PuVT1paLg
 aQ9599Zvv01VFGsaLoGHt1rvin53mpuCoC5X15gNK9wJmT92nxUGPpxV288Odjuc
 O6Yqf2WC/nZxarUZAKtwoWX5q6fvoOFlZlg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffd3aus65-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:48:50 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-848544a8496so5726373b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784321329; x=1784926129;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mLxHuejfrhgCMW6u/ETcstVIOqaiD87qppNP8Q3+2oI=;
 b=NvJUULunR/IWj4bHox4vhfDAV97xT89nQIjThrQczrdovTg4ezCWOxnjyPLDx+ZwG9
 /Up0b8RTXU1TPOZSh/VlVLim4iVYLD1xT+afx3ttxfgcJ0jYvyCO0sZovXr3l0MVNNDB
 cwhbMvv8zMLcqABCsILijySFF53/WFujlFY1i3KMfk3twcNQ+I/pRwzLPSPnbqrakjPn
 H54G/G3dNwqvpgQLqjYzwVyO6Q6P/anEk+aYv6QdHQookabG/l24Y1G4m7FsrwO4eOu9
 Y59B6Ua4hcTnts67tlJWif/QO23dv27X2ERKpoVx3NOV48cuSmstfiacdflpIcQYHS2E
 sJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784321329; x=1784926129;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mLxHuejfrhgCMW6u/ETcstVIOqaiD87qppNP8Q3+2oI=;
 b=ZJaysag+aRpLC5/lFIHRu40vYVflrLsSylrOgZWX7m9/yuGMXB7FbVETX7muSWhn9d
 lemlIpN1GgS7uR46WM0iX54sKlz1lWIrNV9YfwDX7CdkrFxj0WZ7R8nMh8b2PJBn+DqE
 dedjis/5p4dUMbhP1IXzGBXTtTJdSWBKky++KHD4bjSvYurL9ra+ODbcakNrcqKie+rl
 WOB3w20nJuHzgMsjogcstbwhSSN3ludikFQyufhecnwYTZPKJ2mVw+j/G5xUbh+/kvb/
 WatBP5tU7bk8drb5Q8xllPmr7+n629RNPw/XMAauWd81HVZuZgLgvIvxi2No0g0djg/c
 S8og==
X-Gm-Message-State: AOJu0YwH2/v8zDCgY9ekTrTXn5qr0rQOtuykdapD+zKLziFMbVptu2eg
 hr3PI+zQgJTG2tr7gysK3qhSJOKEkoaXztMuyNV5++fxgkd2S8Gofe2SA6cNfrzoncOFsNhRpvc
 tDwwKUW8NpqR5OB/an1PrxgpHPDrCgMBmtBSbNI9kAR/zA8s5J5qE1mlGI2vQGllXnX4SuwN6d1
 602FA=
X-Gm-Gg: AfdE7cmC/zRnjS7+VecKDO6DZw+gy6uyszuGJekJNqyEYxHmZEtxTsRcit2vsOQ1P1i
 3LC9E1AAQYGdX87fkDJEdGf7g8AiVJ4lxaIp/lNCjOPP0Pp4h66QmDmzd3xJvz6++sOt7OFo0OL
 co16ZTnc6tkf6Hm45B9g556CK3BLCeh+rEchF9O8BJDWVZUDoatK3tp3TykiBfkf8T7alYDPZK8
 nzRW0BfeQpr4iy1knWwTGhNhZWzYwIZtKPaBS/ufBCfOqeJUyKomp61pJKwrH3JzQsfmZXEHDrX
 opCukcxjg5nT7JBtPzeMJTMqsa79HjVL11RgPjDzIGTLg8SsmrFLeeRA/1Ggk8lwetcEIqryk8s
 ecWIMJFdvIuf2kNNLjlQx+2CJE3WEz5QhuT6VgxO081ybKcE=
X-Received: by 2002:a05:6a00:28c5:b0:848:2f74:1d5b with SMTP id
 d2e1a72fcca58-84c2954b45bmr4560148b3a.65.1784321329436; 
 Fri, 17 Jul 2026 13:48:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:28c5:b0:848:2f74:1d5b with SMTP id
 d2e1a72fcca58-84c2954b45bmr4560116b3a.65.1784321328898; 
 Fri, 17 Jul 2026 13:48:48 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84c2adc3571sm1727254b3a.14.2026.07.17.13.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:48:47 -0700 (PDT)
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
Subject: [PATCH v6 00/16] drm/msm: A couple lazy-vm fixes
Date: Fri, 17 Jul 2026 13:48:16 -0700
Message-ID: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX1xJOADQXSwFL
 PbzctHpc4NjMK67eigp9/YmkbprLYWdXpg+qlZInvfxh0hyQA9xF48zerV3JCfsXwFQg1kA2qXA
 EvIJZDwEfEbUeBxHqhSKjwyP19xuwU4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX409XJl50/wWD
 Pqu00S8Ry5nMedfJulNxxQxBNtntQ+Fgl8e1LL9c1DnrbubxxLSYZ3LYTFoZpHiiAMmCIuX9Ye8
 Xa/mKlYwoESKZ3pu1vyxeFaGKZS4V+aqkwOhjd2EDMte75tr7Nw6owXvP40mo9aNbaAupwc72f5
 YJ6KwY27v5Ze7h0paaHCnWS5X0TUAQF+Wq9PC9HHbBk/715TB2zc34k8gQHW8AZyGC7hzktBL4N
 lWkOFSaC8AhbTxN/gcm0e89HUqKjhQSdP4dgSDZk+vGaIXCmMwt0NgYpWbTwxozHYWfT7VWmmdl
 SWmeRuVjzEz/IwXpzNfw8BTX+6QnqESck3BXj1GQBbNBL+zAYZkTLWAUk8za7VHFMr0KE5w89G7
 zUZR6SEPG3sb58HNfaaJ2kHjjwShoFwWNHklLjoiKBAVhaYTMI0dAmlBvNK+CiiBi8ne58wLBN+
 ofZYl85eoIjAzk9OrLQ==
X-Proofpoint-GUID: bw5_4CKltqL9Wehqc005l3ZBuLkbEckj
X-Proofpoint-ORIG-GUID: bw5_4CKltqL9Wehqc005l3ZBuLkbEckj
X-Authority-Analysis: v=2.4 cv=e/M2j6p/ c=1 sm=1 tr=0 ts=6a5a9532 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=bzYy7Z1X7KArDtV8Qg8A:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170214
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
this properly.  Or at least that is how this series started out.

Rob Clark (16):
  drm/msm: Fix barriers accessing ctx vm
  drm/msm: Rework queuelock
  drm/msm: Synchronize VM creation on ctxlock
  drm/msm: Synchronize set_sysprof on ctxlock
  drm/msm: Move nr_cmds initialization
  drm/msm: Remove redundant SIZE_MAX check
  drm/msm/a6xx: Access VM directly in submit path
  drm/msm: Add helper to check for per-process pgtables VM
  drm/msm/gem: Remove useless locking in GEM import
  drm/msm/gem: Extract bookkeeping init helper
  drm/msm/gem: Set resv before exposing obj
  drm/msm/gem: Validate lazy VM in GEM_NEW
  drm/msm: Allow lazy VM creation to fail
  drm/msm: Don't fallback to shared VM for VM_BIND
  drm/msm: Fix per-process-pgtables check
  drm/msm: Fixup invalid overflow check

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c   |  2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 17 ++++--
 drivers/gpu/drm/msm/msm_drv.c           | 26 ++++++---
 drivers/gpu/drm/msm/msm_fb.c            |  4 +-
 drivers/gpu/drm/msm/msm_gem.c           | 73 +++++++++++++------------
 drivers/gpu/drm/msm/msm_gem.h           |  2 +-
 drivers/gpu/drm/msm/msm_gem_submit.c    | 31 +++++------
 drivers/gpu/drm/msm/msm_gem_vma.c       | 12 ++--
 drivers/gpu/drm/msm/msm_gpu.c           |  2 +-
 drivers/gpu/drm/msm/msm_gpu.h           |  4 +-
 drivers/gpu/drm/msm/msm_submitqueue.c   | 24 ++++----
 12 files changed, 109 insertions(+), 90 deletions(-)

-- 
2.55.0

