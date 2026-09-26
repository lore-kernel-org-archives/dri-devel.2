Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF83C9832A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 18:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60D0E10E0DD;
	Sat, 26 Sep 2026 18:31:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eOYiwH9/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MH2/PNEw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BCFF10E0DD
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:31:47 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxQkR1449967
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=JdPUDZZT+WDdxEtZZi5YPAJFXhlxmleL6Az
 h39mMkvM=; b=eOYiwH9/nH5zEcu5AbSDDatmiUr7DM0jTc/7EkEJNb5TIl/U0Dr
 s80SOJGcovzGB4yz2VymtbjxC14QJ/58dAb4+kUQXhUUiebYAz277Nkx4BjlTlGX
 o09YKucrnSQ1nLB7XwI4XyU8U2XS/kv/88tSWgvmhkHX5mTMD4RJ8K6ltHhZzk01
 QQK38mqxGrSIhaOCI+99pL7pfiEaezV0UdIMd1PKIekUOiVYEAT2Pze5re/nlKcn
 g25ON3hnOT30fQT6OGnjBtkD10KUdYpl9CP5mWOTVii74Hhcb3VHxs5usyjuGVMz
 O0ri7I9IzGA567m007xDePtqrOyS5oYxiCg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3rfsstw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:31:46 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1b8088202so1253979a12.3
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 11:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790447506; x=1791052306;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JdPUDZZT+WDdxEtZZi5YPAJFXhlxmleL6Azh39mMkvM=;
 b=MH2/PNEwhIm63WFPA+Wy6jAmW1C7k72djRdOrx6vsVsiv30nrvGpymeXHjHvoQTCoQ
 6EHbYPKtHPY5e6093o9sdE2BpQKQ9JKkdo69lVB+mATxBFHNWSxF5nk22kDXd2mz/SYk
 REMnxdVZ+BTTw0FR4HBGb/MHatAVXXd+XHauzkUELTwOXu7HYEHHvBkpxugKSvtCpM94
 8O+RD3GZ2cfjFx3WdvnRmJatroI2QsjEjchD1b/e29/bz2T2LeQ14M1kYeZLlt1Y7E98
 sYXn7M0yytC7K8AopF1QoKbH9bV6U9xYJa6j7TTDKlvkYWQ5I8WW4n6ISjNPHxDp+Nu1
 l0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790447506; x=1791052306;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JdPUDZZT+WDdxEtZZi5YPAJFXhlxmleL6Azh39mMkvM=;
 b=eCfdefcoGQVhewr7Z2g35+ecRiDNAxI0bAjl/8qPu9RSuoQ7sSyZrOftE8IiOIFlBe
 BMTD7JoGXtoiqZslZ9Vx17DWgZgwsS3eYk5cjUTAZ7KZobn+2uGYQLISyJ0TVwBd0Vyf
 7iJw5lwUN4MNiqYHT6nl1eqmrMw7SrnWHTtuzpie3cMKzfsl4hlJ2sTbRXT/ib0B0t9A
 CDo1PCLMcK6rvYQi7UT2TO/FGcg3zH+o5M04ryy/H05bXRC4uE7KAIc+AMVWw15CJXgP
 /26zweibHRDZsPCRlI1kMmADtOi0EWE6iSulgki/u6nOzupJa1IvoIbX0fz20sS9y8Kx
 9Ofw==
X-Gm-Message-State: AFuF++l81rQqjQXU4bKYSwCwwtXhlNIY7Zawgj01SvrkP1Z5ccxGGuwu
 N6PD/+ynM2AYu55F0OawxZFzYJeM3Sf+s+V/GDzB+fvfg4qNvOpwGcIpaoNra1hGIp3vCwwvy4D
 OH5P1QLFjbnyKw1LqRi0DoJfg+kzslLKv0aDZs85SaSC+FrWg6ytEFJa22kXnfWWiZxL2pvinn0
 TKZsE=
X-Gm-Gg: AYBFou3G+yM+TXSM0Yb4YuitnEEMV8DoGmLYrpt4pcA0TnCkmi+c3uKJzoHM4GkDhm7
 BhMAEYswyAfAONM3OyeIOkumxrARG1+QdEORTRoG1YRTn1pBQ35NSWic47lVibwH0NJSc9F57EP
 ULEcbbIqNoX+v4TgU+HAYxGwXdLkau2XAmPBswPaLTQdH7QdNZd054qIBrLuaCvoM3Cr9qud/oM
 A9Ct0ZIGZSFS2yleB7ZVbpyFvmsaJ27/pQtZsIg2K4PYEB2TzCAdkhlE3CUrXHlgqLYM9ky0zNV
 K+1UoD+MdwOXRafKDBNd4L3z1tU31jWsZmJewLm+S6l8nqQ+kGjxnAajuMojnYPvfyw/unSfL1k
 eV4OnvXcxEGjiDKNHuu8bhm82hIdgtTyvC6Vp4ihULvPTp0M=
X-Received: by 2002:a05:6a20:3d09:b0:3da:bea4:6219 with SMTP id
 adf61e73a8af0-3de0e75e925mr7709836637.20.1790447505800; 
 Sat, 26 Sep 2026 11:31:45 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d09:b0:3da:bea4:6219 with SMTP id
 adf61e73a8af0-3de0e75e925mr7709807637.20.1790447505363; 
 Sat, 26 Sep 2026 11:31:45 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc78791c680sm2539983a12.16.2026.09.26.11.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 11:31:44 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Abel Vesa <abelvesa@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Andrei Kuchynski <akuchynski@chromium.org>,
 Benson Leung <bleung@chromium.org>,
 "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Hsin-Te Yuan <yuanhsinte@chromium.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Johan Hovold <johan@kernel.org>,
 linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
 FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b), 
 linux-kernel@vger.kernel.org (open list),
 linux-media@vger.kernel.org (open list:DMA BUFFER SHARING
 FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b), 
 linux-usb@vger.kernel.org (open list:USB TYPEC CLASS),
 Marijn Suijten <marijn.suijten@somainline.org>,
 Pooja Katiyar <pooja.katiyar@intel.com>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH 0/6] drm/msm/gem: Drop use of pages for imported dma-bufs
Date: Sat, 26 Sep 2026 11:30:40 -0700
Message-ID: <20260926183051.25754-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA3MyBTYWx0ZWRfX4uwfGdWs/oxu
 ZS9ZF/LUPSbPl5ywQkfXmBYZGRqjmHqPAUEVlBHIOC5zTWxvDd2kv6V2M0gkE2XsxuUPsTZweRb
 /7/KMPhFH5g6Zxccie4nuLguuoIg9Sk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA3MyBTYWx0ZWRfX/EPfBNBo/RYn
 r0ShKEZI2XbzKQO4Avc4g5sxYPMrnl6FE6WpaD2jA2NiRjNd8g7c9j/vxN0bnMaAQmQn1x/drU1
 iPo8+I3BPoi7nNm3ZrQE7hz0O7iEfBaF7fwqfU/bd9GBrC5b0XIB/HrnuI/6hqQ0Sa6R6JaHSEg
 MBqIzgmH0jmAnk2dDSg6lsW6x9DdKSQj2OPMRNd054sWvzl29OQqmMLNby3NIV5SRPSdFF/+kP/
 WUYMq9VpMu2iG5BMvL4pPmpEJRggeNDGRrA2E8CnYWfCCCViDx4Yn/5NVqhnjy/C1t8ViXp0kyY
 7lnrIR+1vZ6NHbxUe6cuMlzfri6sLMdyrQ4Ib/zzeinzGCxSxFBTSAjLa8MVjQlT8NqwZOQ1LyT
 WhaIrP2BCqHQJT1Apqig3dx8CX7jzyAsNJFJrFeKa/+8XP3EGkCWaLUO+LCohCk8U5eFwoSA1TX
 J6oqse7w5agB1APSBIA==
X-Proofpoint-GUID: UkukF5oSoNCMd_NJ4AivOFwWCBy7WDvt
X-Proofpoint-ORIG-GUID: UkukF5oSoNCMd_NJ4AivOFwWCBy7WDvt
X-Authority-Analysis: v=2.4 cv=K6G3jCWI c=1 sm=1 tr=0 ts=6ab80f92 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=tIciJ6vaqEqC_qAMQbIA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260073
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

The use of msm_obj->pages _mostly_ served to mark that the obj is
resident in memory.  Mapping to the GPU, etc, all works in terms of
the sgt.

The exception was the fault path.  Resolve this by using dma_buf_mmap()
for mmap'ing imported buffers, like we are supposed to.  With that and
a bit more cleanup we can drop the use of drm_prime_sg_to_page_array().

This doesn't solve the issues with DMABUF_DEBUG, mapping to the GPU,
either via iommu_map_sgtable() (display, and TTBR1 for GPU, aka the
kernel managed mappings), or msm_iommu_pagetable_map() (userspace
managed mappings), still requires pages under the hood.  That will
be harder to solve.  But this is a step along the way.

Lightly tested.. in that I don't actually have a good way to test
importing buffers that weren't first exported by drm/msm.  And I'm
headed to XDC soon.

Rob Clark (6):
  drm/msm/gem: Add helper to check if resident
  drm/msm/gem: Mmap imported dma-bufs via the exporter
  drm/msm/gem: Use get_pages() directly in vmap path
  drm/msm/gem: Stop exposing a page array
  drm/msm/gem: Stop calling get_pages() for imported dma-bufs
  drm/msm/gem: Drop use of drm_prime_sg_to_page_array()

 drivers/gpu/drm/msm/msm_gem.c       | 107 +++++++++++++++++-----------
 drivers/gpu/drm/msm/msm_gem.h       |  10 ++-
 drivers/gpu/drm/msm/msm_gem_prime.c |   5 +-
 drivers/gpu/drm/msm/msm_gem_vma.c   |   8 +--
 4 files changed, 78 insertions(+), 52 deletions(-)

-- 
2.55.0

