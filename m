Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C0AC44514
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB5A910E3C3;
	Thu, 16 Jul 2026 20:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jutbsKJl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HuO9sqKF";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A298110E3C3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:15:48 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJoBOf3576339
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=bX9ML7xsTYJIJbZogiyf1wo1N9fpaq2+vmP
 82mHL44U=; b=jutbsKJlJS/HTdXgLIwyzvuumFTLFd41ACqIKk1tLBgqP+QUxcZ
 3xO7DT8HzQRv9gZ5B3jT7/+vSx3oXDOfZMA0qRCvW/+XPrapH6PlQxUR+G3jGjiK
 B6kJBfHP6mxMsMSoxjP6e/rKVOmQlVbC33ytwPna4tJ8gljARnjmdHD1u7cMxNJg
 qVe7gMQZSXEiH14hYnW12rCRHDml+BZR2IhrBeD6BCaOgUnWrYy+6yqWgTLkjc/w
 K3+7GhB0vRUZYE7Tbak5WyUXfOTE7HvzWjPTek26nXBVIwoxInVTeHeTBj565w60
 J+En+/Zzi22A/i+cE7lBfKeizY9vMiIgaig==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u8gkqb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:15:47 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84857446424so13385484b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784232947; x=1784837747;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bX9ML7xsTYJIJbZogiyf1wo1N9fpaq2+vmP82mHL44U=;
 b=HuO9sqKF841luu8Ni1AJ4YYsSEuZIUFvM4MXbnW5NrIICYidKBelxMPXVpTenjiV8D
 qWxDANiVCCcZDn6YDS2f6/zMYJW8aUtdG8aMYBoZ8VZqvFWVXMOcP9tIzCyvmL0J4gdI
 aSLbsXMRnAd6LqHw10uL4/E2iF92UNX5ECPkhyy29ockKP4NIeATptVP55pxAWAB6Bmq
 wjiyyflIOd854vv16v+jFtoMhBx0kUeNLlu4Ar2DoQfAiU6UwPArlnaIe4q7Bkp/YWbr
 sYVZXsomn1MYuIffgPfIi3uON/zNXJ5MIWnxbd4ARzp05sSsRBYjDaf/soiPAYm7GY9W
 QMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784232947; x=1784837747;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bX9ML7xsTYJIJbZogiyf1wo1N9fpaq2+vmP82mHL44U=;
 b=FMrWbjBu+d8ncGC+5JOqhBMAqp/cpB9vRMhgghfbf8TGnGR8FOLEA0u0U7+PpxuSk7
 +uwok1pRXjpDA+ypYedJzNcAk+aAKji3g1B+NJ8vyzZaQnT9L2ibu7wuKnscq6ANxEZ6
 S6fiDRcrui0CrIV3PIMn7ssVDqNGNFa7bN9Q3VpEJ60/gtVysAsc9JuJdE8pI3zLZVli
 /FaTXxpDQUxs/IfUbHgl8Kz9hQsxuGlUGsoh25YS06OmFu/e/2N+eu9/M4JqkeK78RwY
 8GcuE1pQC2EOAlgFEH7tntm5t6FSr3KT2dn++tTTSxBgN95Wm6ulBUHhGq3nm+HW+EUn
 eTBw==
X-Gm-Message-State: AOJu0Ywp3WIaO7dh2/ls9yYxY4/lE+aPHoGCiepAwLe0c1ybtFrT0XNu
 7gQxC1qmslVZbhdFM01UCvnYGbywawF6DNeLqUm38VlEOQWcoN2TvKbPx1uTk34Z/fWyGeNHxgM
 XPXSKwpIqacwCy7nRWu3icDbQ+LL7RkV+4JNpmPfNCM5sdCZanP5yoOFX5+rg4NB53dQhAKdV92
 b+j1A=
X-Gm-Gg: AfdE7cnyTGanfLeXmr6L8NsfWMZ2EYwsH8ZGoZHyfdFk/TNfD+pKzH2PItJ2UQgS//9
 ycIjkYbEreWo4mN1mM0o3EwgDVhIUmM2ZEFW4768DFQYChRIx/yALshvAewrX7dGf6qcIJyh400
 jPoE8yS8+KsmiB2Sl+p4UrqZgrl58ZYDIbTcp+dALMi9fIe8bxGQkUZ5ak44+clPAb5AcyNOkec
 Pkxn/SzkM6+JyUObbMjWDa66sx+4N6Dy3EFBGH9qtSQsxYsGejRB0hfF9S4MyGZ2IWAa8FAPjqj
 jnD0siV6KEPi51/u0lJd2yql8Yz+DiqfNSsrI1BbMQba/WbTzNKqiyUgp8R0GqLKgGK/ULPRdbB
 uofcbDFONLhrD6RlCsITGM7N31FGN5+cNaAygr61X1Ut3Zig=
X-Received: by 2002:a05:6a00:3ccd:b0:847:982e:cca0 with SMTP id
 d2e1a72fcca58-84a671faca2mr7986186b3a.19.1784232947294; 
 Thu, 16 Jul 2026 13:15:47 -0700 (PDT)
X-Received: by 2002:a05:6a00:3ccd:b0:847:982e:cca0 with SMTP id
 d2e1a72fcca58-84a671faca2mr7986150b3a.19.1784232946883; 
 Thu, 16 Jul 2026 13:15:46 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84a4f2739a4sm5377121b3a.19.2026.07.16.13.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 13:15:46 -0700 (PDT)
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
Subject: [PATCH v5 00/10] drm/msm: A couple lazy-vm fixes
Date: Thu, 16 Jul 2026 13:15:23 -0700
Message-ID: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vPpSWjPUp_TteZAgh33-yUvXChzYDoAx
X-Proofpoint-ORIG-GUID: vPpSWjPUp_TteZAgh33-yUvXChzYDoAx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX6o6SSiaBhfJd
 RX0Er6+6FmiPBc0UC10hj59lddWzlu8czTbuBw1jDj/3b9zJ+tpaJMbxrXWkO/AB+jWM1GhRyxx
 Dso4lgszKDEDvHRRUVohWF8OhUGEei4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfXwvBaxV93KK29
 NHmlcgjGDhLoXDTpXSaklLZmB5zCykTHRp1qP+Zk62es59XOpxUy523N4kI/rL3E/RnrIwXk1fZ
 DND7NkVnr5FxZdivGT3Kib9XTu+qsz/gHzAu2gQEiavkMpW2263OCS9JGEE0ioiXpjsSG4vwcbd
 5tf3wIba2/wxJciK0Fw0mhmfP6Z+/7fGyP2DeTzzGMxzSaHz1kK91eScyvfe6iveKJ6U3h6Ldqd
 mRmYr2FQ+D6iy8/6O+pIvuu65kkNwsWduRt/e1vP8F2D5Z+zk0YcpgELr2gVnQl+9E84HwF5ggk
 AUnm28L8cdNDCo/emT2fqCZCWywfTZ5vZ7Q1IWc1FeHF0JlSg44P2FmY4lvrUFmEEPXAoch8P0Z
 5qfYe21+/5fSme1yqj7u7beXPR3fD/xUnLCoTikZ7v6MB+eQCJ0tELCPtZis/Xz+Karl3bXbDCR
 pd2wojAbhNIMUwPAIbQ==
X-Authority-Analysis: v=2.4 cv=TL11jVla c=1 sm=1 tr=0 ts=6a593bf3 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=bzYy7Z1X7KArDtV8Qg8A:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160206
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

Rob Clark (10):
  drm/msm: Fix barriers accessing ctx vm
  drm/msm: Rework queuelock
  drm/msm: Synchronize VM creation on ctxlock
  drm/msm/a6xx: Access VM directly in submit path
  drm/msm: Add helper to check for per-process pgtables VM
  drm/msm: Allow lazy VM creation to fail
  drm/msm: Don't fallback to shared VM for VM_BIND
  drm/msm: Validate lazy VM in GEM_NEW
  drm/msm: Fix per-process-pgtables check
  drm/msm: Remove invalid overflow check

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 17 ++++++++++++----
 drivers/gpu/drm/msm/msm_drv.c           | 26 ++++++++++++++++---------
 drivers/gpu/drm/msm/msm_gem.c           | 11 ++++++++++-
 drivers/gpu/drm/msm/msm_gem_submit.c    | 18 ++++++++---------
 drivers/gpu/drm/msm/msm_gem_vma.c       | 12 ++++++++----
 drivers/gpu/drm/msm/msm_gpu.c           |  2 +-
 drivers/gpu/drm/msm/msm_gpu.h           |  4 ++--
 drivers/gpu/drm/msm/msm_submitqueue.c   | 22 ++++++++++-----------
 9 files changed, 71 insertions(+), 43 deletions(-)

-- 
2.55.0

