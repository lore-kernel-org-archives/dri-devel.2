Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4186606B0AE
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O/dpN8H0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jI4RvbRI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCA4710FDD3;
	Wed,  4 Nov 2026 17:59:47 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8942210FDBD
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 17:59:36 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4GUeRe763954
 for <dri-devel@lists.freedesktop.org>; Wed, 4 Nov 2026 17:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=5+3sqVVx174xGzueQiCtrshPuIkjtTQfb0D
 eYdn+Lz4=; b=O/dpN8H0mOaJJ89JyMkyasvH1NlbmWSGJAmQDqv7lxJtVs+9cAA
 ZiwoYESzNAWct31WZ24pRpLsMDtZ0aMOHx6ewaetEO3OHZIN/FQOIwEcfTRlrzy5
 6yC68MIstdSXTfeexIHSKXIsgXf60snG9gt/nwEzuga7PE+APECG1pyf8gAMzCdb
 iNxvjmJS0EfCvZWEqSX5mFVdiymmjYCc4DV/wDThEoMn/YEwa94BVy1XGZACHDue
 8n64dnPgHc2JL+g5rhF1kIYZQkpJ2LtFtN08PAAd6lthKQgQ/sPFgCXoIzQADPa0
 Y5CllG+qvNmzR3v9edHZF/6t0G3GUK/etwQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr89srd4n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 17:59:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e954d87b48so13323995ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 09:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793815175; x=1794419975;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5+3sqVVx174xGzueQiCtrshPuIkjtTQfb0DeYdn+Lz4=;
 b=jI4RvbRIvAX5TQF2KqTjRyjAd1iFLBOn9mLt09RxkjVpcCOFmbP0BxqWD2bcFGG6KO
 /pNM+5oUbpXfHRVjIxFP/1ZsUIQErIxaMfg4ordAVCB6hLcvzpA6uxPjstwYJqzy1Xkb
 /HK6U/9KPQzH4101hlcOgTH91gj95gT27Z1us7c+RpqVfURcO0v+LGjv+JhF7n/1mZgj
 Be1yYfj/cdhdVl0ng2t2Ku51hnBscRnkV60FQIeGM1gHdJ34rZ6E4HP7x/QVNrB6UkRb
 abqmJ8lHFQTGG+XKBiF1B3e1cmcg8aJGE7bfvJGPpiMvSuzEP1e1K04/+v/rIKlTNy/Q
 iVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793815175; x=1794419975;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5+3sqVVx174xGzueQiCtrshPuIkjtTQfb0DeYdn+Lz4=;
 b=ahXzquZuv8GFNJanMwkEB+qtUShLgWBvxfgCNbAIMWBbhAEIXIqUkBQWs+8JlWArnV
 FHEtDHBHlsFUy5rydYTV59h/JPsGKYwKdFDvz5e94RsZXtn9zBmjXhfl1lnzNByxjWfe
 xaxf96ZJaOmN8fPZ4YMdpJLDb25OGEY7ZI26tKKKIpoj17QgdMmvF1fFCfjCYLMMGOTf
 Z5DdCayp2xCRHi5O4n08BEpV4coqlpyta3T7JuSfqbHRZ7IFnGQhfuso6HKfY65YM4A1
 DqAv8ZMxMevQm+yh/xvHpbaauNn+NDcaXfSQWgyBLpjv5uO6VOZ3aetR38TiwcgkgDtt
 mnlw==
X-Gm-Message-State: APuU4Z/+UnT4CTTql7UYuf4vBu1yf3zTEfmlkXO5yDoZmZP7v4Yt5xOy
 Bk138jrw5UwPIEqBv+yU6wAP88CdO4GC87uk9sSnUjiyqD5ihm2vCkzRs7H2x13V5p0zcx/FiWB
 X4nVuFuUruyS05SwaYdXO0jwIU2I3A81/+b2hfM1yEJI5Cb2GWigcOCpoHTZ1SzsGtdR01G4C/H
 VX3HEMtg==
X-Gm-Gg: AYBFou3kcx+bGr6jopYjwRX73DMNMEh4kFkAjTNJ64Mkxnvt0lFv7yo2bafbQvr1jCU
 a11g+ogrj7KUZOENTteWhq1JGcuUG3YvVUhU+akANjulUS9nh8tEh8TDTQOX2/qPgDyT638FBqs
 7VkkumepdN8fhTCEH6yQuQ33+1H1Iz7Hwx/yNrVA/OvdjwOtCMKZ09O2GHghhyCNP4jQZK8bgiQ
 FrixliRcQ5Ta/3ms7KG8cwT5t36XWr6+i6imvxpieoEHqi6KE+t8r3WPiY93bvmqpuyA93spW15
 hLh5obgWp+FQDY6aEoRDUyYrl4EVXlLL/l8narhCbc2NzrkvpzJ+ueQxQQmxn2b+dW62/q3YXMK
 Ixy2B607O04r374Rt3jSsl3GGgEXBDXKL+MGjReocfWBNYzbumV9nrgNWmPIjkX7g/hfqoxLc+i
 ZoJywNk3EVSAz+HW+85a2IvKDSb3NB37fTtDmqtgbF4hxam5So1SasbOfxLL8=
X-Received: by 2002:a17:90a:e7d2:b0:3ac:4e18:2390 with SMTP id
 98e67ed59e1d1-3ae895743d0mr15100132a91.7.1793815175161; 
 Wed, 04 Nov 2026 09:59:35 -0800 (PST)
X-Received: by 2002:a17:90a:e7d2:b0:3ac:4e18:2390 with SMTP id
 98e67ed59e1d1-3ae895743d0mr15100096a91.7.1793815174616; 
 Wed, 04 Nov 2026 09:59:34 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b31cd6c0sm35077a91.13.2026.11.04.09.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 09:59:34 -0800 (PST)
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
Subject: [PATCH v5 0/6] drm/msm: Decouple IFPC disable and sysprof
Date: Wed,  4 Nov 2026 09:59:20 -0800
Message-ID: <20261104175931.28475-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jq9YWfWY689BYYREjloXkKl7UmqOQoRV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3MSBTYWx0ZWRfX/UqkHOxSe2QA
 axk23WwdAsQ5SJMIlq4AQ0G6uTpGzPnIZlMQP2Y+u69Bmoo/j9DG0RkGFxhN6nmVToexixO4RmY
 PYTDiFMrgtocWD0QBSjC5L4iZPxaY1FSSDmQK68PE24nL9pvJLw8ocLen5T++ciizDMoge8nyhg
 +uLQV/pc3vzolbk0QBmzlxFbLCV/7eWLG9WEs7/VOjSKz5Th+z5XT1VWU9UP/rg8eDltePctOAS
 moWvxvA2JADEPSDV9M9YFGQdZcOkva3+U9hYOi66/mDugC25TKzNN0kPVDeXFsVaQpcXkSYZskQ
 tArp1QrQgfk7yGIV7c6+vxQabTXXp2WbepTzq/L96IF1AkEpIUCPY9RcmDmDFwakmm/DnPrDO0V
 Oihqwobt3huy/BQmF+qVtIkMbbFVCY1+CrBNcX0MbA4CEmtHijuHvY7Sr+tzxCT2yfqjQw8Rjvh
 R3OiNaE7zbyrhPYv5ew==
X-Authority-Analysis: v=2.4 cv=N628hG9B c=1 sm=1 tr=0 ts=6aeb7287 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pAKKPEBcNh-_eZAUbWwA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: jq9YWfWY689BYYREjloXkKl7UmqOQoRV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3MSBTYWx0ZWRfX4Ef0malCZlLX
 WYi1nGTMvOdbXpWqG8J5SBr3BFTiHm+sAZ1chJwOow8VwV7Igeq65B3THfeneHhtBoqiWbz5n7k
 QWeb6XsOsApMjXNqgAqL372eq6yumsk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040071
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

v5:
- Skip unneeded msm_context_set_sysprof() call in msm_postclose()
- Fix potential sel_worker deadlock
- Revert back to original gpu-lock/runpm ordering
- Link to v4: https://lore.kernel.org/all/20261103231850.17493-1-robin.clark@oss.qualcomm.com/

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
 drivers/gpu/drm/msm/msm_drv.c              |  2 +-
 drivers/gpu/drm/msm/msm_gpu.c              |  5 +++-
 drivers/gpu/drm/msm/msm_gpu.h              | 30 +++++++++++++++++---
 drivers/gpu/drm/msm/msm_perfcntr.c         | 16 ++++++-----
 drivers/gpu/drm/msm/msm_submitqueue.c      | 19 +++++++++----
 12 files changed, 87 insertions(+), 69 deletions(-)

-- 
2.56.0

