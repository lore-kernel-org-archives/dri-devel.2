Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C21C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:56:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C60D410EBF0;
	Wed, 29 Jul 2026 15:56:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q33vLtqg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f0rO8GVH";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E87E10ECC1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:56:53 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TF3N1C2397924
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=9d9AqXXZx92sskE8A2y6Kf2T/twB3A5A+kR
 XspgQuiA=; b=Q33vLtqgW62ye58kCFqHgchOpUOydmYOk9Y8asMMQOSzMYblMx2
 v1ENwO/kBr8YCHIU2WA3qFIYpzJCDCp1NE3nr/k2UX0CH5j6G0uLiZ+jX//IgHxG
 sJqcAx+6G60Wt0qepkvUuFcObydVrJVZ9Foi6oMMBJE4zdCEq5OYfqtNAblFxFgP
 XdiYJbAeOz8X1/vCIAr51M/mxNuRBniDto69BY8HW002sTsGeIQPlL3HF3G3KlX0
 1anqVVQ4wIaMDkv9OxRyJQGnTCJ80iLgupFhfPuQzBAbNXQ+cIOieI8CrIVZUwJs
 CweAhKUOz8FR67jfQ96BXL1Pt5lIFWSItDA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgr69akq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:56:51 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e2237bc43so1819859a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785340611; x=1785945411;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9d9AqXXZx92sskE8A2y6Kf2T/twB3A5A+kRXspgQuiA=;
 b=f0rO8GVHVXUtN7OaBJhcophtAqyvcgnzMYapxLjKxVMfwd94MRTx4parcdECUVuMZc
 FACtxB3UEEqPbMpeKy/fAUgT+i8N06H/wy3ztx1M/62AVdeet+o0T7zzCwFdRw7KDMdO
 Td9jxjKs846xU1/GijDrBPlvqniTWzi0QLjURQPjUGy3+ihh7uo+U4uhHvArR3cZSfvj
 azhMBU+l6VzXfGo/c3rbjvZ12AFmKGEC79/j1/Cwc37Y9y2ycvtSxS8msOa6UcMlXs6M
 6ZUW6MjhjpjZONr111QScMA2WDSxeCpq3hJTeDJrW+PinT56KnhmQSKrj7pDEvB0b3+E
 oegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340611; x=1785945411;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9d9AqXXZx92sskE8A2y6Kf2T/twB3A5A+kRXspgQuiA=;
 b=icyAQ1U9LS34LTli+rHce08VnYNUIcZznrLkmOlyi9nBouEBeMWlmEFMA+19o8vyEp
 q8JZepPvLR65RfDjIDTvvHlxtNaUyijZ/KkZdKgnDcwI0Krw60jPuCAR0MgpBiVykC1o
 ezxRaRI+B+u9TDyeF1boxiJbmzhRNXPVHlsG37YC3rKvvhvTJXHDRk0G7PTNdIBhm1xK
 c/q7ww2U3+G5R9l8PmMLSBTGfhh9/8qtjTd+XyvY5IjvTW7gg6yPCdJ+uqP2T/Lexto/
 BW0BD2M6Ln6feBfLehyfLZJEnY/Zqr++DXIC5iZ8mH9L9JRdlE9CGcwN0dnv8oqvWkbI
 TYKQ==
X-Gm-Message-State: AOJu0YxlwGpUVZGbqcKP95m84bCBc9xo+TreeBbJDE8UAYjPfoS5IsiA
 cudbjA0al3ndmyQMAVRJPQaOPq2CNSy59S+LM0cBhXPd2E1rOXWjXzCUcxFAujy9cwjIrYoSYIc
 DbD2LiwXCGydDXwBQF4MM6OGdajdaxZzu0TaX8A2FJKjjjG/+eSNMK1/TVhMNWKvZJyVvQP4TIO
 a2QSU=
X-Gm-Gg: AR+sD10DEhlu8bC+nevwWgYHzY/9JfJsXVExif0nUZ2oSL/tyABjFDAcjvQ26VjsDT9
 aOlz1RkzrnN/mb5FOxRSFgE8qEdDDLcgP2/XDFmcof3l82h34Jj5YT0JbjmLIothWhq7Fb/aJf3
 tZfA05NLfQiXKTLaYP0pV3Iybnr6WoaGnY1hptmgCpwrh4D4rRlYK7a+lPfvUxRurPM2c1Idzuk
 3Sc8eTSRjM9/zJeVbHO3rSDSXxJUTdGGlZ+Sk/vgsGoasN2S+rUXzDXVWWgXXlJvdSguPZobeLF
 l4YSwnSRhwWWYvFgbr2I2XHZpvHz8eWQa4ON9tXMsmdal9TO8Ib+tZ1+m/9V5JutLl+YieVEKrG
 I4xetkgau14Y67hgY9Tex9yq5Cs3cQYZMtrOZjmhwaYprpIw=
X-Received: by 2002:a05:6a21:339f:b0:3c3:6b6e:8ba0 with SMTP id
 adf61e73a8af0-3c8aaf815b1mr8876585637.11.1785340610963; 
 Wed, 29 Jul 2026 08:56:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:339f:b0:3c3:6b6e:8ba0 with SMTP id
 adf61e73a8af0-3c8aaf815b1mr8876539637.11.1785340610566; 
 Wed, 29 Jul 2026 08:56:50 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdba35196esm1174015a12.17.2026.07.29.08.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:56:50 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Abel Vesa <abelvesa@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Hsin-Te Yuan <yuanhsinte@chromium.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Johan Hovold <johan@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
 FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b), 
 linux-kernel@vger.kernel.org (open list),
 linux-media@vger.kernel.org (open list:DMA BUFFER SHARING
 FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b), 
 linux-usb@vger.kernel.org (open list:USB TYPEC CLASS),
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Pooja Katiyar <pooja.katiyar@intel.com>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v7 00/17] drm/msm: A couple lazy-vm fixes
Date: Wed, 29 Jul 2026 08:55:37 -0700
Message-ID: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX4UjOaAca5WHD
 3LTXJRhv5/9npF8xZ0w6e/cgpLqOHQLdIIJnwIxqRpDKViaxc3tM44chW2jApwzaLM9HlvIxRBd
 wnpCZOFMzZWBxeBalfwIJc96YfhhtVEFb254AH252cOs8jzIS9VeoNbOAwSQwul9Dc+RyjlXjv2
 53chF0koHEpDpaqZF5LHoJakfXQ8Q7w682z9Pk26pdzkw4i36W074Gi286RDHgcd0mhit8GlR6D
 LAKEHi4nnGM3tqMb0s4Wt+D/Cimu9+yiT9fODzUb+F6jeh7fkGE6Vk+781HjzPLAUvS1ivvRAo8
 t9s64Ep7kn1evzUPxqbg7g7BhmdImAdTC8kSUK+jWdUf6mU/fYdIGCjrO338Jyic2L2cvdFOVts
 LmEIK2nDVoUkJ9AuUfLGoiikIDY5cDWKfpt61NbC7bzW3ZYcnHmxdvOK7l9M+KIWKfRhiqqZGgh
 e41rCe4v4fJYyg1pMgg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX3ZcRsq01Xw5v
 7KspozbTAL+qHIiC0837jWBwOqESg4RL5R7IEnMDZ7kW509se6iNd+mpKJFrBAQpCmImJ136gm6
 yqZDfFU0gLJNcLraj4lUScRNRBsdTvE=
X-Authority-Analysis: v=2.4 cv=Cv2PtH4D c=1 sm=1 tr=0 ts=6a6a22c3 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=bzYy7Z1X7KArDtV8Qg8A:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: zFUBP4TNW9AUL0SDTyV51F0m2wFzxiee
X-Proofpoint-GUID: zFUBP4TNW9AUL0SDTyV51F0m2wFzxiee
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290127
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

Rob Clark (17):
  drm/msm: Fix barriers accessing ctx vm
  drm/msm: Rework queuelock
  drm/msm: Synchronize VM creation on ctxlock
  drm/msm: Synchronize set_sysprof on ctxlock
  drm/msm: Move nr_cmds initialization
  drm/msm: Remove redundant SIZE_MAX check
  drm/msm/a6xx: Access VM directly in submit path
  drm/msm: Add helper to check for per-process pgtables VM
  drm/msm/gem: Fix dma_buf import error paths
  drm/msm/gem: Remove useless locking in GEM import
  drm/msm/gem: Extract bookkeeping init helper
  drm/msm/gem: Set resv before exposing obj
  drm/msm/gem: Validate lazy VM in GEM_NEW
  drm/msm: Allow lazy VM creation to fail
  drm/msm: Don't fallback to shared VM for VM_BIND
  drm/msm: Fix per-process-pgtables check
  drm/msm: Fixup invalid overflow check

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c    |  2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c    |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c  | 17 ++++-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c |  2 +-
 drivers/gpu/drm/msm/msm_drv.c            | 26 ++++---
 drivers/gpu/drm/msm/msm_fb.c             |  4 +-
 drivers/gpu/drm/msm/msm_gem.c            | 94 ++++++++++++++----------
 drivers/gpu/drm/msm/msm_gem.h            |  5 +-
 drivers/gpu/drm/msm/msm_gem_prime.c      |  2 +-
 drivers/gpu/drm/msm/msm_gem_submit.c     | 31 ++++----
 drivers/gpu/drm/msm/msm_gem_vma.c        | 12 ++-
 drivers/gpu/drm/msm/msm_gpu.c            |  2 +-
 drivers/gpu/drm/msm/msm_gpu.h            |  4 +-
 drivers/gpu/drm/msm/msm_submitqueue.c    | 24 +++---
 14 files changed, 131 insertions(+), 96 deletions(-)

-- 
2.55.0

