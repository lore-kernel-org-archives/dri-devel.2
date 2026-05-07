Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CF4CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B865910F0BF;
	Thu,  7 May 2026 13:03:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CNB1LCzS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OBgEJ07B";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55A4710F0B6
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:03:14 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647BxZRE2734080
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DhLMvVZQbF3J03WMc2id/1RoXxcDZvjE9wQx5sGd7p4=; b=CNB1LCzSwOaKUMqW
 NuVAsiSTWgDFOpjphs/iTMewl09ugzqTVyUcWEnw7xBvF1z+mCuCXYX40KQ4DLJI
 U7KCVEFc3yCffY5gXGRyqiJDo03XnO7660Gqn8PfKg32pLDMX7OFlbm5p5qtgpCN
 hEFDk68rkp0JV4hYj4dhFKugs21hqHoOEXtTW/WvCqrR4evS7jB1z9uJuG0JPb4g
 lMunFZWShQAZQt2sXoAorcr5mz5Y/IevtZ2SFueTKuKfBPBW1PgP2UQCvkgmNf+R
 Ry7evAlORgU06+mnrHa+YL3Hg11RL0uKXENcBpJDF1dhlLGpkmHGuHdLpbCNn0aX
 JdtbXg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0tbqr6x6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:03:13 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ba86e35aa1so12835065ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778158993; x=1778763793;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DhLMvVZQbF3J03WMc2id/1RoXxcDZvjE9wQx5sGd7p4=;
 b=OBgEJ07BzA6z8/IgbZAKf0UJ+YrHfCgDkcESU4y0VK4he4QlEm8FqL37NsNXR7a0db
 TuI5nzI+mQTCS9l4Wfv34CmBqjDCmizWmuTt2zKiA3JCA74p9VDizfliz2c4gZBqptRh
 5NMbcNnhn3E/8ob9RyLcL5ajvPqfpR8DJZOyvXFJmGjXAi1q/3baq5sTeLLaGqBDvYyZ
 gLZRULTd3Bwsi77TLJRwmnMyrGbowB7fhbK6fLTWo6hydckzPobHrPcRoZW8V2r6FSM9
 u+730VbegkPwmjfgNRqAaybgJaiwzxulHY2NhwG/icnLRe8FGyEiHCezK6101Ckyk+bZ
 pFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778158993; x=1778763793;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DhLMvVZQbF3J03WMc2id/1RoXxcDZvjE9wQx5sGd7p4=;
 b=UMfGC5JLHN29CTqVDetcQbqYNOComUDpsA8K671fa3vJKAU0uFoknlpreVQIQC/7LM
 ceS1cG/x9BRnpQdgvh1Ln1h5veHgCD++tFrmaVPbGfOSyKb/qpxC6Wj9/LO0655SrMfi
 e2vzwT5aGCepcCXOBdJVEG6dA6/6QtDFY7xb4a/0XxNiSxjzoJQ4RppQm9hmcgfOh/Up
 yYEQG1jj8tR+/rXppb55dyMlSzZlXSGiEwvk8gnN8d2LpN/mscOU6fMIG7hA5Ba4vvNt
 U88xu9XBInWpRzTS4EzCebUbi/gjwv6dqmXCi6dCQKJaZSWOQ/vAlOyTpbPqBE0r9hUG
 12yQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Do2xNOavx0yEF8VloTtafUCdCyOwscM8tvlaoHayVas+vhuy/BPezGHFGls91QqL2KrusIEJI+IE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcE6PEHrXDjJmmgrigODgEQO5VFiCrDVjHX6Jsz9StS2Zjs5Tk
 xUrbnK+jwpof7T/X7YBHc2KdNl4ptyrqXGxceTi4FOSSzibn4c4Toubh28aHKERradCov77vAlq
 HFZ8SqRSFlez9hq+5lsUg495aMldEF5nPaxlX9IIQeMkzF/O5tOJ+5FvJvwhFArcdqcV67RM=
X-Gm-Gg: AeBDietg+eustSIDGltV4N7ttVepToHXZ3FlviifTg2kxPt1ifo/yrfe+tRmTUmT/+8
 shhaHdRrKvMno1crkzsw8h4l2DZiQIZPSSOwjBFKJzdLlMdGtvq25XyuPJkTyG+qBWVYtwKl/qx
 u6mnoPqHhy61iFStc1PyCI0eax+Svpl7B0tEw7FIuIz/AeNTRaXD0J0QeXBuazBWrqDBkaYxLFE
 WXP9vA8RboD+9mKB/q11tV3S0F6w+TUmJ/HDHQWve/+RY4gdBvbe0SbbXYbvz5wEhS9XitP6dpl
 vyjyZNHe+XzBHyfx1CGuPCGBivj/4knXBOGsAas2Xmj3ZS8UJ7F2q8dO2dCPWN6pRvEQoWXBHZc
 U9Rtly7Z9AjQPBr8TvA1flof0kppV3ZwEUJIUAJdHO8KUCDBRdlkaDheBD0yny3EB2Z6LcxEA8k
 D8b/Tow+VGVs1RSIgxiKBxVIoLNTMdkwEJKYH83OIJ4RU26w==
X-Received: by 2002:a17:902:b585:b0:2b9:fb0b:b727 with SMTP id
 d9443c01a7336-2ba7a323e95mr58398715ad.39.1778158992685; 
 Thu, 07 May 2026 06:03:12 -0700 (PDT)
X-Received: by 2002:a17:902:b585:b0:2b9:fb0b:b727 with SMTP id
 d9443c01a7336-2ba7a323e95mr58398055ad.39.1778158992064; 
 Thu, 07 May 2026 06:03:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:03:10 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:02:58 +0300
Subject: [PATCH v4 02/29] soc: qcom: ubwc: define UBWC 3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-2-c19593d20c1d@oss.qualcomm.com>
References: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
In-Reply-To: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=914;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=0jnnTKmBVzx8ajx5YR0+k88TfAux9nzkeECglU8qUoc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2EYco2h9cEnAxnfbeYL8OmlrpKoaezSZZYQ
 M1+0MKnP8OJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNhAAKCRCLPIo+Aiko
 1cGOB/0a01YO+OhyeKDba/Mk5dawJ0/xsqEaxlKqEVt7oSTAVlAyxCd1r4SS/Ho2BPiOU/dvZs9
 6CkDY4NRK6YNqsShekmPuNnzcBpyA1zGh9pNq/cTnOyu8oQDEExBEuBqaCpqQ8M2qlUjvw019hy
 YiuGs0SLGhYwMKoF4tsHYNP8kpfDpfOwjEPJ+CSVwfBFIx7KM2hwfQjKb4t0CPCZPJy0wab3cLb
 6571OMLfaI5iOI34b6rglUpLOmEygigjKCAXgDh+Q1o3a9u9IfIZxK/ek4Hj9CTU5HO6Zau6tC+
 5X2jDy7+Ln38yc6lmkcL4EC4P8F31swGe1MNTKRqTNmR3D6T
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: pa_sOnLkSiixYNmjuQFSOBZmfmSnTufD
X-Authority-Analysis: v=2.4 cv=SJVykuvH c=1 sm=1 tr=0 ts=69fc8d91 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=o8D1m1ilSIXDguKSM1sA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: pa_sOnLkSiixYNmjuQFSOBZmfmSnTufD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfX/yIHEwETrmA0
 sFN2mqgMRrepD3VwANIJy2o6Pd+IJQKJME7XA7TkhXrPSMVQ8cEY372Bt+PEMZKYzT7/4ur7buq
 xPVOMGZdCwfNqb6ydBEOJukoagDWMZqEwvW16/tWzMdoQf3B39u9CPX15t9WshEPd/QcKZCIeSq
 pKFbAG3j92qRn6e7FpYBEB4rZSAWDkasM6ajIDPEt4I8b0vcbojYRYJe3oxkh0Q3ir40z+5pRlm
 I6egSE903cpVVXiif95BFt7oS6IHuT0ec7AcQBSsAIEJMV4BfKtb8EUXP12YhCYC8uMKVu6BX0J
 uft/p6Ovdtk4v13ukfVDqqB7gmIiembQj4XDWqxSg3zus5IUYzJTMIlxfYNOT5CSLPe3j7JFQ5z
 yW5KC3drMHWCIY2CXcUkstpuXwGf3EsK2uTcLe5g9W7FcUinJ9MMFc0JG1rb5XIWs7xoRkexsJV
 vGGOl+iYD6ZT3ASTpWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070130
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

Follow the comment for the macrotile_mode and introduce separate
revision for UBWC 3.0 + 8-channel macrotiling mode. It is not used by
the database (since the drivers are not yet changed to handle it yet).

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/linux/soc/qcom/ubwc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/soc/qcom/ubwc.h b/include/linux/soc/qcom/ubwc.h
index f5d0e2341261..319caed88775 100644
--- a/include/linux/soc/qcom/ubwc.h
+++ b/include/linux/soc/qcom/ubwc.h
@@ -50,6 +50,7 @@ struct qcom_ubwc_cfg_data {
 #define UBWC_1_0 0x10000000
 #define UBWC_2_0 0x20000000
 #define UBWC_3_0 0x30000000
+#define UBWC_3_1 0x30010000 /* UBWC 3.0 + Macrotile mode */
 #define UBWC_4_0 0x40000000
 #define UBWC_4_3 0x40030000
 #define UBWC_5_0 0x50000000

-- 
2.47.3

