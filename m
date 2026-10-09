Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86597CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 13:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF7E0112146;
	Fri,  9 Oct 2026 13:19:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q2I0w3MU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kb8t8tK+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06AF210E189
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 13:19:37 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699A4fpb1336285
 for <dri-devel@lists.freedesktop.org>; Fri, 9 Oct 2026 13:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=W4UJ+4ics4oOYunJeOoO5yAh6ndPjCZP8h7
 AuddGqC4=; b=Q2I0w3MUoI1F/rcbahHtwVXf54sFuoZfhSgIlfEm78sLKRnrFHO
 IKDDGaJuMerPRnVVD0Q0Y4lw8qsnAYY/YWiQhu40AZLJ0CPoqjXF+DWZNeletpBM
 htDDiyvAsNaHfJC+9C1chg9XzcWd7hF7AAGFXvpuTisC6Eo4wlIw7d34pNiHjBZP
 12Lli7FsZLbHuMWzcRKmXca2ogfpH9RtbWyAifel2GaGlG1V9UOgu0fvkt2eyGM+
 3wHbnpIcNwc1wS/aB8nG01iEsRaauhipc2O0Nl1NKfUdHW76JABR6jRVZBVb7fCl
 m8MJvSbPjj/DuaZCzknOdmSS3hI9bIRy6ZQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6x6wgmn4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 13:19:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2dc7337e2a7so61725215ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 06:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791551976; x=1792156776;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=W4UJ+4ics4oOYunJeOoO5yAh6ndPjCZP8h7AuddGqC4=;
 b=kb8t8tK+WDC39AN3XxAUpPR0c7Cadoy6HaIsKw8HE3Qm3M3Ltas3eX4GZsjahEvXy+
 kplxiBSTqgPb2XWHVNr38ynnDAEQ2uQHvLuRZFdKPdy+baUJDJc5ZcgAgGFdQLSXv8ew
 Rn5xFOvFs5mDWWP5F++AJvelNmUcnryxhjWaOvUWUOWZTcQP/bZhWthC/Tbvt4SV37aK
 ckDU6O/utFeCbdGKeTuhiOH51SyI7otyiQSp7J5vjja0KWeld91A12wTlNiLIceBgoR3
 tNTdh3XoFzWcNRXaVESVQJuJpC9WETHdIIRWJQIrNjoeIgCqMnp7Mk1f2IFLIYMOIWsv
 HiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791551976; x=1792156776;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W4UJ+4ics4oOYunJeOoO5yAh6ndPjCZP8h7AuddGqC4=;
 b=FRZCcGazeJbL26WMCwNZZPHftnSMLujtQAhloKs1ANFJR+pcG4QSSYLdqZCz69kFHS
 dNIGbE27fY4HqyR8jFT3R1I/+91Yoq6l8AXd/fSiCmprqmjoJaszFU/5BDy4JxdZ7kp9
 tcz4af/rpoK+SIhcuWhL9H8/hLLQGNbScRwWXwbYCi9VjBb0X5vvTZNxHg1l2TgV6Zmm
 djF1BZfV7hXnfMWjDDIHTn9TX/GpfWvMPmJyltafSiOOtHU7aPgmVJWdIV0hRtLLSi2j
 lmhKGveldnPOlo3fbSiS5CG7Gf1hRboXrdZ4z7JEbPEBrHjK2jhLDILGfZRfxXymnowZ
 ILpg==
X-Gm-Message-State: AFq9FYKZIGDoE0DapajE7XntqlkP32wiPCBs0KtMlHoBajagwQ0yGk9s
 1zTLvh3oMlN57SJpBVq7gkcaoxRElNFAu0qr4LY+HU0WaWrrYH2MuBpTvR5x4IDOxUh74m4tdRn
 lzvwBzv/cB0P3xdTquv6xQsSHtDuDmr8hbhamqPxHH9i/bD1ZcCgYNZqUsuXFu1eOKU68KkfDf7
 EKX+8=
X-Gm-Gg: AYBFou3BzB1Okg4DNwnYd3gfT1oOlK/KMDb0zefd9KNjqLcvhrnKrd6G/WnUlQ8MSNz
 G8T5R2TjV9VHwNTKisBR20NsrG0cvswOejSYqP01f2+FCTnt6c/FQ+5wocRiW4SwmZchoNF4qfw
 ImDYY+5P5az9c37wk3MneKv/RxpUn7tCjxGgMAJqHR3O+WvbqNfPybLFl/QFE/wg3Jd/vjArEjP
 1hHQFiP//0sMdeoZ3eQ1UwX4P1of76VohWSJHs59Aof6uxroR0pbR73DDFTsas0NBMsysKHCti5
 OPbVQ75hXnwioziG+IIOYNParg6pTNjHbw+V/Paz/F6pMU2zzqb/P1bj7Fk9hTVYOpksBZbLBrA
 BdrKtP0JGhPOUxEqrJI/TqENrcoung3rwM6FI+0UlhtKCUA==
X-Received: by 2002:a17:903:41c1:b0:2e5:33a5:36ec with SMTP id
 d9443c01a7336-2e84280af99mr16694775ad.4.1791551975765; 
 Fri, 09 Oct 2026 06:19:35 -0700 (PDT)
X-Received: by 2002:a17:903:41c1:b0:2e5:33a5:36ec with SMTP id
 d9443c01a7336-2e84280af99mr16693755ad.4.1791551975238; 
 Fri, 09 Oct 2026 06:19:35 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e841a0002csm9095705ad.3.2026.10.09.06.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 06:19:34 -0700 (PDT)
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
Subject: [PATCH 0/2] drm/msm: Split a6xx/a7xx/a8xx device tables
Date: Fri,  9 Oct 2026 06:19:20 -0700
Message-ID: <20261009131927.551319-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1MiBTYWx0ZWRfX0i42jkTmh6S6
 FHcJXWjI1MicpQIDszUgEUyO9MFxXMLOubPeu1Vr/7lr1mNANP00XF0kAQzTutHS7zl5WRXhrfI
 xHwzlAmUQp0ScC2SEihT/WIXQQu/5pQ=
X-Proofpoint-ORIG-GUID: zF4MV_TwrXEXtuM4u8_k8IasMVdD8VDg
X-Proofpoint-GUID: zF4MV_TwrXEXtuM4u8_k8IasMVdD8VDg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1MiBTYWx0ZWRfX3XRwrC7n+H+3
 4z65dXBhSyrNnMwRNOwHxTUB2kXo9L5DgrCttyL4JSC9oxMouXwjWBTVco7UzDjLTsJOYOoziiI
 gcsF340+S5HQ2fY2t4qQiLLfH0ZREOSnekdZ2Euo08luRzPmvy9VHkrWFIfGJLEhdLrRYvP4ZXK
 tuM0KQK6ixmSftMAgylHD9i6OPLE/awMLgX08ZEZK185GUFVbZtlQEv1WRrZKBi6o0UmPIDKhl/
 cGMNiSjQBGjDumylqk7nB8g5+nRA70d1K3t60iQZICH+CDdIjdKsh8+B14OsEt/C70r9o4VQDQJ
 bNOMYIw/PYgg9Od3Lir713dF4zZ2lsM/OQLppeJCiLKKi3Nc7anIlf66PWGsQATMOZw105R5L8a
 1M3kw+z4pRauYURGGgVmZ2JpWjcPi0Y3sUaj12wE5xCXNxvw2oGX/jFpo7FO1fD87qoOxcnPSfY
 ICp4hX5tJud2QL3Bz8Q==
X-Authority-Analysis: v=2.4 cv=ad30Dhot c=1 sm=1 tr=0 ts=6ac8e9e8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=jbNVri9b6eyAa_OJQsMA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090052
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

Prep work for a8xx GPU snapshot and related changes.

Rob Clark (2):
  drm/msm/a6xx: Move a702/a704 to a6xx list
  drm/msm/a6xx: Split out a7xx/a8xx device tables

 drivers/gpu/drm/msm/Makefile              |    2 +
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 2433 +--------------------
 drivers/gpu/drm/msm/adreno/a7xx_catalog.c |  496 +++++
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 1847 ++++++++++++++++
 4 files changed, 2407 insertions(+), 2371 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/adreno/a7xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a8xx_catalog.c

-- 
2.55.0

