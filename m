Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CCCF589D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E9CC10F12F;
	Thu, 23 Apr 2026 13:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gg7QXMgw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LBM2TuZd";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 392DD10F133
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:31:40 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NBxBSh010547
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 m8HVxJ0pTOUMaGM5sF22jVvxmxUgeEH0LTk097GA07s=; b=gg7QXMgwOV1shweU
 RcerV4o2vU+G0PAZKT37xgsx1XatL3FYPGu/gX41xZUkofpC9P0GYLlein6D+KDw
 uEghegjDPPw9vINbXnFQeKoT9F17MvLu2/PkYcA71HBO2y/0GGBcZ6tgAn3dSLru
 dKlItWKwsvh3dGq3UtzPScZw3oVG9MgF6ri4t+TmdbArx7Qv9sCzkAaB359X6DEq
 wcDHWDhKNehWssmONfMoxmcFpB5Xcym2LPhv0DUfTnDBaeEmZ2bV8MmubF6AyKdg
 +qvh5YssFPbg0mGgpQ0d+dbA2NB26kTqNX5ib9SLZLE05tZ6nnh2tUvgXvkA4tU5
 AbV+UA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqk178af7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:31:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b4530a90fdso132370225ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 06:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776951098; x=1777555898;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m8HVxJ0pTOUMaGM5sF22jVvxmxUgeEH0LTk097GA07s=;
 b=LBM2TuZdeOGY0MtufBbBWK3SrrMpGz8iby/6q546jAsVdKwvODOxzmoCasKcdc4FFo
 3ghznClzukIC1hCW/rAU+nrKaOcWCk9Tvm1HQzNyqdQaKMGNbMwOocLMIAE68LL7+Ow7
 lcYFwC77Mbc2TxRdgG74kBEihxUK1Vw/1/fzlgJ1zXta0uFrOUe1jLjSnB04I886dwzw
 yAZOnrAz99EOx6cynsEcEoZ6KkxpmcOhmHpUND72mBLh5tU89+yPXumwol9CU8zWNabj
 EwvZuXDtWAzvlKR/OM4EWV0ukLNjGppDHCJ301uoK8ZigEkaeDtVBRqxaV0gYwZ3MXW7
 6BsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776951098; x=1777555898;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m8HVxJ0pTOUMaGM5sF22jVvxmxUgeEH0LTk097GA07s=;
 b=JOFQIHEvP+uNKTEVp9ukqeG3/YWx4943fENLMjUIYjZfY67EvF0ZlUu4jwdbXkPexq
 lXGAiaub8sH2t91IQoMP8v5GYeTpNqIo6wkknsRqtZlQDeYTb96N10zVHGccyJjxPBGz
 Z50pHZQNGwTzs7zH/Gdfb7LtUA7a20Zezz8CZefuEaATFejvuP7IYw8ZamZwLZYJFKvc
 0SX7rsJ6U/QeWuU8seeqva8yKaCk5SncAezXCptA3cXzrTHn6Tx6SweygWAy0/94UpnZ
 Oqk/MaYvKjAAuBicilpK8QA2MP+coTSQnx96MQUkL+znFWaqZ3bu/wBt1OHVm364VwIE
 TrFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ91+HdUkk+lss3cWOdTdLW7xUFQzhkgMUzH57vhF029hwaqW0q6TeXc+We0f71nmzrvK0KAuATrC7c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdMWN5jjNUDfX1S+a2TGG0tbN7Hpa4drg8uRAcT8Rp+HS51xaY
 igPuTAAV9VsCWvLihPFHFhLqhUd0hY/LrGqxz2lkRwwPG0vtwg+QIqef0nd44iQkTIA2wCUCblv
 uZDE2lMJYHLd0O2zt49zDx7H6ehLwV5Jy4NjVBz0O3yF7MmmGgjB0Le5LqkhPcvfaaoec/lE=
X-Gm-Gg: AeBDiesxU61+9Vud8IAH/mdjPK0G/9GB77Oignm9fwPgjD01kE5p+Zsi/zXcyt9PWtm
 TtMY5T2D27HY3N3h5u1/fZCKg9p1cmwkoRvlGwidKDjXyxAoHQIFtThIVrKvB/G9TOaTIFFqp60
 9pO8O7fKNO+4iFNDL3bQlS/J3wXbY8uLBaaw88ZAGbUGYNS+pih+HTqmLfjFjfc6uoFcS2Ltygx
 TlgoR4E1Svmd8WWwlz/5wZpW7qbeqtkTNDwLJzwyP+Rc1xlKM7Gc0B7x8qX7tMmQHP7EAcQR1UB
 WwcXhZ1uAcrhwPLDEey/a6DxP5pcUluVHeu9syzzeY8rg8hWFH6EP/uE7F7ydjLghahaVyy/Fpx
 hm5lnZdyhFUmycAmZ9tmz2Q/Jo0Ak6bZDET8P6dPQkU9bIuYPKtzrrNPyaBfKoXbp9Q==
X-Received: by 2002:a17:903:3688:b0:2b2:501c:ba8 with SMTP id
 d9443c01a7336-2b5f9f7d700mr214914215ad.26.1776951098370; 
 Thu, 23 Apr 2026 06:31:38 -0700 (PDT)
X-Received: by 2002:a17:903:3688:b0:2b2:501c:ba8 with SMTP id
 d9443c01a7336-2b5f9f7d700mr214913615ad.26.1776951097773; 
 Thu, 23 Apr 2026 06:31:37 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cbaasm198795635ad.54.2026.04.23.06.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:31:37 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 18:59:40 +0530
Subject: [PATCH v2 11/13] media: iris: Select DMA_CONTEXT_BUS to create
 firmware device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-glymur-v2-11-0296bccb9f4e@oss.qualcomm.com>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
In-Reply-To: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776950985; l=1132;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=ebFEmvXGGkqJKD9mFiIVA1LtU6HQ5Bywf5jEMGrP3G0=;
 b=bQ2hOZeQXviL9nyF3kRsnvZT4zluN72vayk4KkSLYRcfIp5ZJavRUHXeaeh7XDtSU5FxhOQqO
 0m/xHMr57rABgvyiSf0X1xDEkWlvlf58cukHzX9Ec8r7jTMd6Tw/pND
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: PbAqjZclrCGLSYYljzMuZ6GWRYOY4MNh
X-Authority-Analysis: v=2.4 cv=R98z39RX c=1 sm=1 tr=0 ts=69ea1f3b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=LyCF3VY0PmB3I9bQj-wA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEzNCBTYWx0ZWRfX19BAPWEBKXFh
 56lzksVHZLxX0d8tc1+KBHDry3EL3rVihbUsHNhyj4QRrh0bY/VyzJMx/jPiMFC6w5+qYbRPKTh
 NvJhkYALmoEwIE1LnTWz6s9TY20Hz3oeLr0Jgd0eMaz96kBOGjAv0zSS0b7Hr2GKiPakrYuyO8f
 OHIHbJDjFdfmy/5m+g0NuxDFvS74QpwWHe9OGAa+IGkdQD5xLcVxZOJxw/rAOsIRLXTqxzr5P07
 o9YOT5KGijlAH9gxtIpixQVY6D5fjtDhQ3GxOeiuDavMAyM+W/2BDJeAly6ZoABNL2nM0alqghk
 zt5Hw9zwWuGYMz7OhtTotBUrKZoymFSllLvP8iop8i0lLU+8qFFphfjJivRK0hiIvMz9rspDuIK
 QxNaaFdJPl/Yp60m2pie5vlVNOL2RBMCZk1/TjTn2ifDYZGWhcsxQ2fuhUZNM4Ep45v9C4qbcmt
 HW2ZM8apVEVCo18Y1PA==
X-Proofpoint-ORIG-GUID: PbAqjZclrCGLSYYljzMuZ6GWRYOY4MNh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230134
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

Iris need a firmware device to enable secure PAS (peripheral
authentication service) support in case of non-Gunyah. This device
requires its own IOMMU context for memory isolation. The generic
dma-context-bus provides the infrastructure to create the device and
configure its firmware stream ID.

Select DMA_CONTEXT_BUS to ensure this bus is available when
VIDEO_QCOM_IRIS is enabled.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/iris/Kconfig b/drivers/media/platform/qcom/iris/Kconfig
index 3c803a05305a..de1fc4b07ff8 100644
--- a/drivers/media/platform/qcom/iris/Kconfig
+++ b/drivers/media/platform/qcom/iris/Kconfig
@@ -6,6 +6,7 @@ config VIDEO_QCOM_IRIS
         select QCOM_MDT_LOADER if ARCH_QCOM
         select QCOM_SCM
         select VIDEOBUF2_DMA_CONTIG
+        select DMA_CONTEXT_BUS
         help
           This is a V4L2 driver for Qualcomm iris video accelerator
           hardware. It accelerates decoding operations on various

-- 
2.34.1

