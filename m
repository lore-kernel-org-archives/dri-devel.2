Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EEECDE00C
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 339F810F3A2;
	Thu, 25 Jun 2026 22:27:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dZ/saoJn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P5Gu2kKx";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A865A10E2C0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 22:27:52 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PFdx4A2160342
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 22:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=YYGFMedjww5Nh57ZSCLwGdlM9va0wcgYMnw
 d+ig3sKI=; b=dZ/saoJnsKGsEg8awLUUmeiDrK73Q+XUm7lyBCluzNb/iO5zuZ7
 HWCjRKwI5xAAmVPyERR5itnvN88e5Lrt5RKwV4IQylqfbZC2A0SzZvp16/G/rmou
 HOEiolE1Ps9y11QnND8PB60QbnQx628DrOHNAU6ATqd7r/ztatiwIC4ULOpFXEKL
 KTJ8pjB42RyldK2i3wGPKwBkQ1nT3Ux4Tuygp2+zF7UPLE0MBGDuKbKTQAuDRhYi
 YJAw2kHVX0hn4kgQebn524UPZmpObpk6K8s6Qgbqt+rEcvQ1ezNCqdKsp2QxdsGp
 qdW3IHjoPMM7U3FaElXEk3e5mIw9zNfjxYg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ymv3fu1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 22:27:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c809cc9d7dso2568355ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 15:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782426471; x=1783031271;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YYGFMedjww5Nh57ZSCLwGdlM9va0wcgYMnwd+ig3sKI=;
 b=P5Gu2kKxcOKlvQ9El/M/0xLmwnVEUOAI9TnULryHP/69RVcu2ptmH9Ip7KZDPaD7kN
 461DxiO0RS0yUCBrQuoWPm6bRKZt6zKg1SICXeCO5ljbe49Po3VNxzNpCLVz6JleGjrm
 hAr/hYf5lQBBHahcpHh9ZMXvnEpqN4/8aFWjSvRgLOeMsF/z2rsSpKsYN/YfXA08NOoR
 nd1eZ6xfhEhknWZn52IsU5aP31vfVQT7OHt8kbPlHPECcLlC3DGm0lK12xfvPIlGjw1f
 ylzDFnnOhpyMHZIChhLP+y2cUcXNmQVlgo/MGVibs6iz6L0iTwqsIM6p/XdFBTVe4/DQ
 vlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782426471; x=1783031271;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YYGFMedjww5Nh57ZSCLwGdlM9va0wcgYMnwd+ig3sKI=;
 b=HxZt+M4PuxPQ84hecybAqQqFWQl+uQpdaTEYZC9cIiWv9cYO5W23Fe10w5G3s1sfDF
 UbnaVOKrXxI3V2AF5wPEWAuZjy9hBLkJuQYa4G5I3HoRdAdot2P91XnCHP8htc47bVmR
 +d8WEkImHQgdQ2xaNKeU8J+2oNPZTb9bkpgS2oByCt4gTvjTnSrvFzSZTyqyUxk6e7lL
 C5NOIB3UBzVNgV9zEQHIUg8S5+LHWjI5CiVRyIGM1fIJBQmb4zSiKvoOfYY6i16ejPLO
 AU5oVEeKPlSTy8/XXiM460BxqBmznxoeyluzLEozirUMRKTCJOCSAi11rPhfDj1ug+eZ
 AJ3A==
X-Gm-Message-State: AOJu0YyIs3ipMxUZ8QG+SwhB89+p3kVolbqOzE40XY2676vo7xkm+jmN
 p6O/Jh3HS0qN2NK92BGLRSFnyGHvT4RF3elfE+3MxNiku+8kBALXYfv7alq03aAPYi/zKnnTWAd
 YTiuBZPi0LjPowXzCFm9yFIQlLZG84psaLD/fC3WuOpeNyPe4EbsW/vchUi4r0g652gEMM6tFcJ
 Kn114=
X-Gm-Gg: AfdE7cknDmE+i2EJ3fr2HEdWpciH116KPzJC+B03kI08CYL8TswBS18XYuGFnp58ryC
 ePnMxqDTaskeASpLheNAAomV8feYQAWrdxAt3xi+rkqn2HhrVzmAX/y2X0yLXRWL7srzL/pReN8
 Mx41F7QXFol+os4/6LM5/nbCu9EQSQ5jCBZuufvq5rQo4yGoiXtRhaTD/r/COz4Kimre7r+lTRu
 aT/oEWclJBqKBGr/1fQWhPhT3DDDws70btuRpcwFcB/6xWPIq/hOm2hqtLSfjYGS26LVJmy07h4
 K/FnomtfPMv//NesT6rVgx2CXdFWgV8fbXiPJAk43AcxWrwKy6/BbqAJjfCt+tkRlH79IW26FNY
 rgpWSM5+sSQvANLOZH6dy9jErdFk6gS3NG8QJogIUlYkpSaLbGFAMy4G/XA==
X-Received: by 2002:a17:903:946:b0:2c7:ef3b:e17f with SMTP id
 d9443c01a7336-2c7fc791633mr43939405ad.36.1782426471169; 
 Thu, 25 Jun 2026 15:27:51 -0700 (PDT)
X-Received: by 2002:a17:903:946:b0:2c7:ef3b:e17f with SMTP id
 d9443c01a7336-2c7fc791633mr43939125ad.36.1782426470713; 
 Thu, 25 Jun 2026 15:27:50 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f64dc322sm27290185ad.64.2026.06.25.15.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:27:50 -0700 (PDT)
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
Subject: [PATCH v3 0/4] drm/msm: A couple lazy-vm fixes
Date: Thu, 25 Jun 2026 15:27:39 -0700
Message-ID: <20260625222744.22254-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DqBmPm/+ c=1 sm=1 tr=0 ts=6a3dab67 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=384pi0yy4wJ6F0PkkBwA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfX9tdCcoKsNZiY
 EFAwMToaHYM/pEHBhdtmMwm61kOd0PUk9PwTr96NQQH8Nt0bsqBZDoq1Jo53m8JVChE98bxYvS0
 DnAJ6SacbJnnxlG9hLWzULMElgeecww=
X-Proofpoint-ORIG-GUID: YCgWRZ1bV78CbO-kI3N2BUxYYa-rZrLL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfX5AdYFL0kwmKp
 4rOKblGj9FH5tJmfcFeKgWt27EjRMLSNePUYUcosvTZihNbnnyjPU1prfDauoOGCqtfeNHTx6u9
 bzvoTGz+98J2BrYb9rkEnISWsc7lLVEYoLwkrH6OUEYkq+HeXJvOeLOE0yeImeXuWNcv5uVbQX8
 HEShpbl8gBCPFbrrKVC0Ecpgd7Mw5/6uvUoaRMUfXk6UHdZcDfzaGhYJ6CBOfu1m3Q8NcJol7Fh
 6ujuERe90BFu6ErBYJY1C5XbmHJ9oVqTGSeVUe3l7UtOpIxY9BPBRPb+gOhzNAZAF7jzY8iOW9u
 V4gCzOi1/nkCnlcLgkcdnp4Gba0LO1w/7BNfwo6EK4FkXR70sndeIUVEtRK26QGxZoRU0Yz09T5
 nEaHeOS46BbkBkXfAs97kM3W+8/NISLsQWjKFYgMHA2CpN3Um21TLRJIC6up02GQR7uWjOGlJcA
 Ba2BR7TG4+sXbUn6Xxg==
X-Proofpoint-GUID: YCgWRZ1bV78CbO-kI3N2BUxYYa-rZrLL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250193
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

Rob Clark (4):
  drm/msm: Fix barriers accessing ctx vm
  drm/msm: Validate lazy VM is created in GEM_SUBMIT
  drm/msm: Validate lazy VM in GEM_NEW
  drm/msm: Fix per-process-pgtables check

 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  2 +-
 drivers/gpu/drm/msm/msm_drv.c           | 13 +++++++------
 drivers/gpu/drm/msm/msm_gem.c           | 10 +++++++++-
 drivers/gpu/drm/msm/msm_gem_submit.c    |  9 +++++----
 4 files changed, 22 insertions(+), 12 deletions(-)

-- 
2.54.0

