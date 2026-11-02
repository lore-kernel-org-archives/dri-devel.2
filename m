Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A282D60A0FFF
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YM1fIXsQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iYF/4VEB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 070DA10E6C4;
	Mon,  2 Nov 2026 17:20:19 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E4310F0C7
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 17:20:07 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2GZ5GN1222984
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 17:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=wbhUry8uTNTmLHMoCjcua8VR18xywygNgfA
 BJXvuDxM=; b=YM1fIXsQXx82XBg2AG+dABRQhyW/baFIWRBVH7e33pslxCDlcuW
 LYx02RknLm2L2PPMYjc4RCsGyvFLAAUGnmrJEunmOVFcCpAiLQKHVnOsJJYZBVQx
 Nj1uIdNC/HS20LrTmGXstZXGVIFPbmkOC8o6NzUnphE4vB6gyyIIt/rIc1avhtyB
 F8V8VlvKA5JAuMrKInpR6eiRKmCUv/1FpBF+QMmkjMrRv8A7PCmtbjadzmSNQn3T
 T6heZBzihkBwklXC26QU8fvbgn/pT/BVPZZpmAYOh4nitbCKIJJmzgzQJIe+NC3A
 DKtxe7loiY8QBVs+7MAuRB7qsA9GGQ6wSBg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpmf1tvy0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 17:20:06 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8a086ed8980so2354003b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 09:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793640006; x=1794244806;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wbhUry8uTNTmLHMoCjcua8VR18xywygNgfABJXvuDxM=;
 b=iYF/4VEBdobTWi8vZ7FDnphPv5NalKhbsYOeZhbWoigYOrmvYfzHnTD9Nwe6xzJCwH
 GZAMGQTnCSEoJgSKNELi0ZXVK1CPbhJqvKbo/mzYMZAWldf6RTIKlo6U8MRXlbSjvBWY
 baEBfhTLaL1hWWQzzrCF4NODSrkp3DJ/RKuf3gA2h78ksvNTh261sJ/bdNbvVedgAHgG
 J1xU6LRbLHmkd9xU/xYyMaiI7HhM605aStnIDH1DSQCi6xoavzldXaXXMXycPeGsLWJy
 tiEMvPX+vDeUoQL7FQhz/7+A09QzpAtN2aX1DuS2AtV9Opb0tlH24peXwCOjPrY6lsd+
 M1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793640006; x=1794244806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wbhUry8uTNTmLHMoCjcua8VR18xywygNgfABJXvuDxM=;
 b=KnuWf0U83JALChoXMzSnjDfdQ7WJuUSanmkvVKXlec8EBrG2H09+AmecGFqrnyxQHC
 dnJtUzPkGEQ5YWF0k5EcPdnpibsy7Rz849+msVftK+EoN5GmZr23Rnn0LG2tXIkLZY/o
 1IhZQLx33k7kv40njkqWTXbu2ebR0nPlxLBpJX6BYOMtZClVGqHI1ref6kEN05YyktqP
 H1eP4zYMQ/ObQDZhN2SY1YdnRVtBmMAaYQntA/vWa9KvYPM7SzO0daRMVt+JX74ldnUT
 RzW1RR025uP+eyyCk5tkXaGSt7ikTU7m5b6f6HlXHBDagcK3FZzbEndidWUyKFAZXSn2
 5wag==
X-Gm-Message-State: APuU4Z9pmBq4i/NQLfJ4hEtb6Dyq4jy5jr+hZV9wp6EG3HsNy6DJYGM+
 xFHICH5Mkpa2Wyh7OW1sFGw86hN9VepyJ4lBa6qMNvQZnx3s523dHeC6BbC+2jY1KfNLP5SxiGk
 p9kk7FKXcUjcsi8dPucXGpMj0tmAbeTaZQGFE+OICHlw0IGxd+2GRUQo4l7dEHJoZfuE2gKdcnD
 7BCMonlA==
X-Gm-Gg: AYBFou3bR+bLXZT3fXSwdJHZS9330U+yL/REOWf/azXMqRdVZzTmGdXeswIS4B/BYf5
 K/ElganghmTglBnC/flvEpxzMNQXiG+y/e7K+DHgUE2ZR/mJVrvnnCxvV7w9muF46M1aJiC5Uwp
 BEDi9EYnfoxiWN5tk+Gv4tNimySjmsTR2jpSvz+NuTmpw0ks0rGlETULrSOg1hspf6KkbYQzp9i
 IMFkceHn22cH1y6b55N0W/Ju/Bw12DYqkgWVkmbXXLFdWPpP862KDVE4oC/TTwyuEBf8yxwM9qf
 mfqr6iKJuCllHrmrrC1FxCBKm8v39MZwGdmmElKolQ6PKllLTWCvO6Oe/50WxrWU+IxzHU5sVWQ
 y/CIY5LyHsPX4U2gmyVVsaSxohRm3uX5fLyqypHS+xw7V8YoaV3THQAFANfiAbZiW4F45+Ny1cu
 9e5kE86zf/W2qqyLjm12o/6Q==
X-Received: by 2002:a05:6a00:b50:b0:89f:3447:2dd9 with SMTP id
 d2e1a72fcca58-8a8324b1a38mr8158930b3a.29.1793640006280; 
 Mon, 02 Nov 2026 09:20:06 -0800 (PST)
X-Received: by 2002:a05:6a00:b50:b0:89f:3447:2dd9 with SMTP id
 d2e1a72fcca58-8a8324b1a38mr8158913b3a.29.1793640005686; 
 Mon, 02 Nov 2026 09:20:05 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8aada9aab57sm2209733b3a.46.2026.11.02.09.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 09:20:05 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 linux-kernel@vger.kernel.org (open list),
 Marijn Suijten <marijn.suijten@somainline.org>,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v3 0/4] drm/msm/gem: A couple VM_BIND fixes
Date: Mon,  2 Nov 2026 09:19:56 -0800
Message-ID: <20261102172001.508440-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ql5eTFy8YXoM5DZ6f74NmJJojj1G7hiS
X-Authority-Analysis: v=2.4 cv=bNaDs/+Z c=1 sm=1 tr=0 ts=6ae8c646 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=vDWxNTotJWpNCD247a0A:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2OSBTYWx0ZWRfXwXCfFaA5izjV
 Ew+BPK8UTGrWe/OWYqqA2+E+Hx06CO868CK4SXMiOWoV8rUHLnIlC6v04W9Fd991I8l22uZU3gE
 wlRtp4+1SzZIKP6euY1rV1LLJXrvlhEm6js+6okLPLynqdnpDC4ElJ0rfbg0sjB783bJOvscVkV
 871xwajFLWaanlh6s/9Goxb1N5inoWhkOAnnAdQoHIjgjUoeK+oFtWDuGYyKWsCab8oo1CGLrT3
 fKXcvRnXCy89/YjussHB8aTqtqasdLJN7xMwSxpLQI39JiUPXMvmawRqlzzeNfPokFxZhpQ/TbF
 QT7EwMhFl07Q0zuqYmq924oqFdxxbv4Ay6S9bVfyYignmpYYsRJFz4B5F2aw4BJNe0NwIJOp6jl
 AfYQEtzaSHVSPDJzOhQc+ztHQ30hOxT3GBsJswdjQm9DrrRgxFpPJVkCXzt53ReZIeKQ62K38v3
 EcUKoexcUZT7OINnP7g==
X-Proofpoint-GUID: ql5eTFy8YXoM5DZ6f74NmJJojj1G7hiS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2OSBTYWx0ZWRfXxOUFva7yE7BB
 xmq9OeJ3ThMaq0CRFauxQWIVS1ttRSKx/SBKULHZMe6uwcA2abDgzvxzgcY7A5jMgE/sNUvdJtY
 Q6IrtSUuP9KDswHyr1Oei4cn+pSe6Mo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020069
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

Fix possible overflow in range check, and disallow passing BOs table to
GEM_SUBMIT for VM_BIND contexts.

v3:
- Also disallow range==0
- Add patch to clear stale nr_ops in lookup_ops error path
- Link to v2: https://lore.kernel.org/all/20261102161002.497152-1-robin.clark@oss.qualcomm.com/

v2:
- Also check that range/obj_offset are not greater than SIZE_MAX.  It
  doesn't matter currently, but would if an armv7 system ever added
  support for per-process pgtables and VM_BIND.
- Add patch to fix handle-dereference in idr_find() error path
- Link to v1: https://lore.kernel.org/all/20261101174911.25184-1-robin.clark@oss.qualcomm.com/

Rob Clark (4):
  drm/msm/gem: Fix VM_BIND range check
  drm/msm/gem: Disallow nr_bos for VM_BIND contexts
  drm/msm/gem: Decrement loop idx if handle lookup fails
  drm/msm/gem: Clear nr_ops in lookup_ops() failure path

 drivers/gpu/drm/msm/msm_gem_submit.c |  5 ++++-
 drivers/gpu/drm/msm/msm_gem_vma.c    | 11 +++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.56.0

