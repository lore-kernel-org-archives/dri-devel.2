Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFE9EDB7D4
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 09:31:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F156310E398;
	Tue,  7 Apr 2026 09:31:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LFmStf6X";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QVMD3knE";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CF7210E397
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 09:31:45 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376ZGA72009903
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 09:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kHzEQ6XM/z3+Muw5eGpH96zPSOY5H6p0mASC+IuWNqw=; b=LFmStf6Xj/w6kh5a
 sT5wy7fhiCd15n1fgtreWReNFUSvJAybcIKoPAgjYEXOtWhrwouAt34lOkhsP0Yl
 d0eqmBqkqMBj6mWEEcim3KdtdW0+olwsuD32t2StYYFxlua3wGMTYUle5D0OmYUQ
 40r2kMSO38eOHFsFAgbUvqox2khUuoqcJRRhYk5TIeX+wmVuIk0ExiP/usmXXF13
 v1TCVBbU1dLzsj9TtbYEV7P3vi7LLkFYE55yfhgvM53gNGDK6o6MshERILbi0Vtc
 lBJt/gSi4wWS/pUMCsTLMC3/FzHOx4X/Y3Ca5kg5CyYUHgelGF8Zbzxb73GPWStj
 vokGuQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrrt2dk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 09:31:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b258636d16so50799985ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775554303; x=1776159103;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kHzEQ6XM/z3+Muw5eGpH96zPSOY5H6p0mASC+IuWNqw=;
 b=QVMD3knE6ue0UHYbplPCTipI0sP3QpsbphNVNsgfXEiYOfR6ZKDoOffI/d0u3fkQYh
 qTI0HpYjsTis3+WD0/17UhkJKsfBXGIMlv7MnB55Rp+5DZyPRcD7R/vZYo23N0rAW1oR
 hrqPI+5yzpcGhFsXBDd6RXjGkxtPd/LQOurbxCOuO3kCS/UkpvwhgHTs7+tAGY6scU76
 0RP6QrRHUoV3YsJCnRFBVFHlIsA/BhYJo7dpF3DU4OYUlFYAVi6qp8SwXCouP56816Rk
 LUogeT9I58DmT5XYIe+r76Ed5Y3mirsCkcfKlVaI/OppctOTpFOTqRWPypc1g7dvOwyX
 rTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775554303; x=1776159103;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kHzEQ6XM/z3+Muw5eGpH96zPSOY5H6p0mASC+IuWNqw=;
 b=iWRaBsuOmZ0EIy8GPvohJ55+HZB63i5a8tBvf9H6OCX5Z2u4ecLDyqXAkdGj46RvkT
 GT/Ko/pHGtOJdTLARTBb09FG5vWpytNzU2KNBAgRwQs1EcaCQS6ooOSTshZeWbSvdpb4
 QWVS2rSAsb1SmBfnuw2mxfwVv1FRiBg2IHSP2mOSf6qVOBFoJj5E4yLgPxV3Uf+grxS/
 KYvykiO3aRgLxFE19odaDeat5P6VKUHgxYanEm1LdlOt8NJJtmTrxAjqjd4hjNME95aB
 Hyb0JfcveXQvMAW+mnX/4zwwstaROJDa6wdITJlKZOBcRJ9tNlK/RZI6yvJEDNo8m29A
 kvUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXypFLYHNKkEY0T5QNmirPr6VQnFSeLnlaq+mRyJ+dJbqMmy91FIxsBroIHmriRYKRD7DhqvuHFrfk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwIeQDEnMTQ8NVtjKw1WqaJkVeSLB3SuwPb+4UiJ65E9G4Z8OCC
 0nZyp8PZk93iLo9CSnJkTsyIzyqxpSr1KFqqTJ9lfnYDOmQPUIWA3PeM2pzQfqGPHDmhZe03OZg
 L256taGARY63UqJG/L6UOu3x7LxZkwTH9vUDqS6uTf/y4oe8ikzPb8r5lirsgAJvj5k0K/4jBHj
 RTIgM=
X-Gm-Gg: AeBDievXIEIMSOsUUqYpjHqS5SShYK59VaG+mXEbcLC3fFya2yDJ/E8ofC6dkGzz2gC
 3F+ovl9jb91/WWQXrwSgk0nsDhcwhAKIqqYk5R48IUcKlzfsFvFDP15WHALwEei7iOOx/Qc5d7E
 j1gif56/9hr55J3P666KDcH3PugSzxVYjWr7dhr+DzyQ9jRsrrxlk7fwLr6hmw88mIjQGkdrsSN
 YObP9Yrr5zWmC76zu1PcdHwdBnS2uOlecyk9ASS5mdxF3UuyAqkA6pmawgZ5zyFpsHiYHyYz3yz
 7h4kCRuNnDkBcVFYzwF53BYhqMr9kcjW5lv0gvZ2lpCEgYr5bmtJmOmACsiQo0A56JTqnTz20IT
 uQkHjmgrlSOTz1JDssmyRvRpBeGsKSaxDHI7CeSBH43Q1VA==
X-Received: by 2002:a17:902:f78f:b0:2b2:4d78:eec2 with SMTP id
 d9443c01a7336-2b281821ca2mr174235145ad.18.1775554303470; 
 Tue, 07 Apr 2026 02:31:43 -0700 (PDT)
X-Received: by 2002:a17:902:f78f:b0:2b2:4d78:eec2 with SMTP id
 d9443c01a7336-2b281821ca2mr174234775ad.18.1775554303001; 
 Tue, 07 Apr 2026 02:31:43 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478bc96sm172888365ad.33.2026.04.07.02.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 02:31:42 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 15:00:53 +0530
Subject: [PATCH 3/6] clk: qcom: common: ensure runtime PM suspend completes
 on probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260407-gfx-clk-fixes-v1-3-4bb5583a5054@oss.qualcomm.com>
References: <20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com>
In-Reply-To: <20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA4NyBTYWx0ZWRfX2f79U0soErKP
 AJqFturOTCD1piXVm4FiL2D4FRp0zG2n5WhC8OIlvnnKY0DhaH8mAAbOE7mCn/Lp7VT2GFjqxnu
 HBcN/+1AfaiFliahGQ8mT0EqnwTfATPSiZQUqTKtZIOpjIhyH/pfG8ieXSGbtssZDpcrSyBKjWP
 YG0R1mCq8ZzhJjlMjbB5+RVCjfSn654+DR7spJ2Lus67f3ssftEtuWbrx91SpUoA1NkutMZwHgY
 FiXvj+Z1if+ZfBa0Jt5wWgNkDUXjfzdK/m16IVxQU5IIdiUtM6JwVerUpTosqkHUozRNKxjc4DU
 r1lRMBHgg7bFnd49bmJjJvph2RPw7koMtVK/Q/FndigBd6w8mVPQ4p6d63psLdNTwkdlbZ+3QBk
 Tof303+1BQPXGUAcoJwlbcDUbta4vh70IGdcCr7AyJN6UciH0CgpJg2xYaoq85l2Y8qPmR9ZVlF
 tPr4tr6iK8IOujkeHwg==
X-Proofpoint-GUID: 4wruTiFO0ASjSnvxpj5VtD2FvVCSEtpf
X-Proofpoint-ORIG-GUID: 4wruTiFO0ASjSnvxpj5VtD2FvVCSEtpf
X-Authority-Analysis: v=2.4 cv=LquiDHdc c=1 sm=1 tr=0 ts=69d4cf00 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=b5psBqh-k-Y8K5vD8YMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070087
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

When the clock controller is probed with 'use_rpm' enabled, the
runtime PM reference is currently released using pm_runtime_put(),
which may return before the runtime suspend has completed. This
can leave the power domain transition in progress while the probe
path continues or returns.

Use pm_runtime_put_sync() instead to ensure the runtime PM “put”
completes synchronously during probe, guaranteeing the device is
fully runtime‑suspended before returning.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/clk/qcom/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index eec369d2173b5ce24bc1ca860d2ac1bbdce04524..2c09abaf1d2a15b7fbbbfeb67c03075381185a00 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -428,7 +428,7 @@ int qcom_cc_really_probe(struct device *dev,
 
 put_rpm:
 	if (desc->use_rpm)
-		pm_runtime_put(dev);
+		pm_runtime_put_sync(dev);
 
 	return ret;
 }

-- 
2.34.1

