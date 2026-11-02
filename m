Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D61606D808
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GM5u7uVC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C/5cHDdt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23AAD10F174;
	Mon,  2 Nov 2026 19:00:28 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EF3210F174
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 19:00:16 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2HOxLM964724
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 19:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=+/cvMVzpCOPhWRaXnpWsNQICJTP7fTN5nft
 AenQ++hk=; b=GM5u7uVCwYXNE+NH0yxrLu6LAfSBQylgvZLBgSN1Byt3D2gkflL
 J2J9FJik0nRbwirrMRA/uBpLy/X8RtQ/iqnagYpZi882K1apvtqhtMEQYT0VEqLI
 dDnJGHod6IQmlH+iB/AfLC61lgpti5jXFFYeQ1WBhPQGuMl67PrN3bnsbep2hea/
 dEqzZ2vMAM5qwcYAnY+/irAMzxoVu30mU6jPsvZdJl8XN2gDANColHYkmTZl+6So
 cnWDzKlligIUbRbwE1b1oqH2CmtnBbiuXlI2oo89DOdy3BZEuD5rLAjBAhff0OFZ
 50I5LB1U7NZ0HjGScdgvJYEhUgeJYzgwY8w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpph1arpg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 19:00:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ad3fc547bfso4151020a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 11:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793646014; x=1794250814;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+/cvMVzpCOPhWRaXnpWsNQICJTP7fTN5nftAenQ++hk=;
 b=C/5cHDdtGYH3CHuovURWZuW4GiYBv6n/GcV4VSFUjYTB4j6iKVIwXHGQtmNOHpUuBs
 eXePcdBs++likRMu6Q47H1DPO+iS5kjMXI5OymDdiZ6cgO7Tb7AvBnK3Hu1KyOeSd0vj
 BWxfM1u3rATiv15CRns06ZffxQNiO75L3MGlwNHAiZj+Gf5TxYomh5tIy+BzwEhiW6cE
 dbhrNVjGcn0W9rBWIrsTwzRVSCn1BkFtYnkcjaP/7LrpOdT7j6PYT7oEwf/AfgWReHkh
 WuJ2ya5A8Ir4Kez9Bo8QCvHtJ42AqVU3vzsbw2sg9AZoQT/+i10dUJMGgtGhvSSjT9j5
 twBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793646014; x=1794250814;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+/cvMVzpCOPhWRaXnpWsNQICJTP7fTN5nftAenQ++hk=;
 b=nGqrizTniIjOJ4EPP/3HzkE5F4XsBybePADOwfri6b9yXzHJPnzyOtdZKI8w/MW42j
 jzETKAnwitLf3/gQIa1904VttPGJEz3/ahNZxYKyMwS3B474BPL5zZh0YeYhZdYDlP59
 Ngba8pyNo51/tQM/A1v40BoBjRfRzAbMARDsxzmHX+GJAbLd5gV8xFhhz/LpVJArLpw/
 wVxeWU2Ifex1UifuM2TRBzwFzMqCg3hziOTzVmZK+RlmUY0TNmRJr0vu8lcNJtBOoNfd
 ZUjhRVwwMyYdVTTTjG7oZJVy+vmY3brgLo4fn358sH5/AOxKvYu+SZONx/OnMJ8OKo/O
 +ZGQ==
X-Gm-Message-State: APuU4Z8QB42fVogUTaFdZ+bV/xJ83rojd498ep7rg4l51oYVBMYH5dPH
 KC6iDU7hKnlAlzncOK8gnfEPVTDKPSMrxShL9N4sL5xCt0bkglo0xsMITSVWqDXMeelEI5IUr6b
 PPIBlmaDRaSP6ocSpnSZ90dWqjWihV2gq4xNMkHWH6wow3GjAesgmTpSDbdXuho627dHn7AY8sS
 CPx045WQ==
X-Gm-Gg: AYBFou0ZMYESlmtiQtUrYDV2zworYMseSg/YlTQmbjdG/DT7AOZMxYM6SAxSzyBdzst
 mBGTGSRldJ4wafbY46EAzuLgP6Ogjt0wdaAunSzKzDHbFxzLrAMjG2Z9H+Jr7l6ns4PGB4KdgIM
 A9xynCM92xh5B1QgfPl+V9v7M2VB8vuCUv4hCJ4F7bW/CJvJbiXkcBup61fyaCNW+Nto57sZC5Y
 vTbT965hAMWH+wPwikBw3rvWH7ErFJCyQcU3olErK4qJvORVAGQfBe0yKMffkLULOLyRJC09SRt
 ip1RhAUyC0sLGTFKETpi++LP9xCBiOFB81WWAAkfiDmL8yomqgZ6GDAUoF3PQGcjNao6jjRvCD5
 Es7BLT7x38xUCzn1qEMXMf2L/iJj7IYLsfodF5AA1KvusVWwBaPwEt949CCabXvtK8eskfth/mT
 WdAL6LvQkfWTzYdu1EV1L6AQ==
X-Received: by 2002:a17:90b:3f8b:b0:3ab:e588:c278 with SMTP id
 98e67ed59e1d1-3ae89715664mr8609656a91.17.1793646013842; 
 Mon, 02 Nov 2026 11:00:13 -0800 (PST)
X-Received: by 2002:a17:90b:3f8b:b0:3ab:e588:c278 with SMTP id
 98e67ed59e1d1-3ae89715664mr8609625a91.17.1793646013247; 
 Mon, 02 Nov 2026 11:00:13 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b07c5844acsm462228a91.4.2026.11.02.11.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:00:12 -0800 (PST)
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
Subject: [PATCH v2 0/4] drm/msm: Decouple IFPC disable and sysprof
Date: Mon,  2 Nov 2026 11:00:03 -0800
Message-ID: <20261102190010.720443-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: X4NBw-ak0WJzb9mBdGgcpcBFyrj1UEeA
X-Authority-Analysis: v=2.4 cv=IruL47/g c=1 sm=1 tr=0 ts=6ae8ddbf cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=WAnUiRRfp7J0bigzDMEA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: X4NBw-ak0WJzb9mBdGgcpcBFyrj1UEeA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA3NSBTYWx0ZWRfXz+aqVZdOllh+
 VRfvxcyuSrZm0bTsO+UAmXtG/bIIW0C/M1Sal95+yIwEMxqH0vlBgFOhOXg9Z4xeX3e1rN++LOI
 RfEH0nVvCyL3Zy25OkJeLVbrkL4SW729VOd9IeC1aC316ZOZXlnzBNBKRcS0mZPOB9ZGHFX8ScR
 /JM9nw+IxXcdG7kJjJfA86jp7BrJlb2SnvJWK1HIa/aRAhvC36AHYd0opfxCx6vj/3zR8ERoH8Z
 TgJaYNCSlZL4UD5FqJ4bqfRzaiTV0R8+lCNsTW0dyb7Xd3EPCfrCayfoP7v6UqnqONLJm73llY8
 aQQyVNqup2Cb3l66lT6I6H1NzchyukMNm+oiusd978tYvb/jAeHfJ4GXwZohHTFkpgWlgwI/tAW
 c21eoNjkat2ofxcqxNPxpqr1jIdlI51ZLDB1940K31Mer1rUcei1jMrDGyFxFh95MivukhqxWsc
 tR/nCLG6PpaHatjpPpQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA3NSBTYWx0ZWRfX+w84OVxHVqz9
 /v/9iW3i4gu85EJ51nTuLZ3dZA3iSisFWdLHC0ghr57yihfVVlyyQU2pBaKI6UKUm/4VlN4rU02
 z3XO9dFkW2isCPlTPb8b2be4iyQSano=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_05,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020075
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Convert IFPC-disable into it's own refcnt so that multiple threads can
request IFPC to be disabled without stomping on each other.

Extracted out of gen8 GPU state capture series[1], as other than fixing
a missing IFPC disable in debugfs state capture path, it is unrelated.

[1] https://patchwork.freedesktop.org/series/176505/

v2:
- Fix double acquire of gmu->lock
- Fix missing a8xx hw_init() path
- Link to v1: https://lore.kernel.org/all/20261101174631.23637-1-robin.clark@oss.qualcomm.com/

Rob Clark (4):
  drm/msm: Rework IFPC disable
  drm/msm: Add cleanup help for disabling IFPC
  drm/msm/debugfs: Use cleanup.h for gpu state dump
  drm/msm: Inhibit IFPC for state snapshot

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 32 +++++++++++++++------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 12 ++++------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  3 ++-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c |  6 +----
 drivers/gpu/drm/msm/msm_debugfs.c     | 31 +++++++++++---------------
 drivers/gpu/drm/msm/msm_gpu.c         |  1 +
 drivers/gpu/drm/msm/msm_gpu.h         | 30 +++++++++++++++++++++----
 drivers/gpu/drm/msm/msm_perfcntr.c    |  7 +-----
 drivers/gpu/drm/msm/msm_submitqueue.c | 10 +++++----
 9 files changed, 72 insertions(+), 60 deletions(-)

-- 
2.56.0

