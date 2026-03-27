Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093F410F2865
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C262110EEB8;
	Fri, 27 Mar 2026 19:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dS7likSL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WAq1kOiC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ED0310EEA2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:00 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI2bY43137130
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YdVOzkr0t7g78/Qkg/ZSkv1ZfQiCPqhiBwUFUrk6+V8=; b=dS7likSLevTMhGp6
 CzMztV9oBUz+LzzZrNqBTMsxua0encGfm8onpKd3ntEWsDHToinPWKQKe8r6S3v/
 cMX2afBkllO8v0dDJJR2M/vXY/W5YQRtcOmwBUwJSpgSff56arqGs5/sMQr6yvr8
 cmUWDA+ccGnalbu6jp3/rb+KwNlI6/pWT5L7HTAGKe+55ClBvsZLL66Oc2mNTVtQ
 /JaBrjKycwTmVt0kw/3o3SoRVKbUM5zEQMbG+1/ZHsZzBJUNyZbXkRwTk7856k3v
 8Z5O+rbXTO0zxubw1Yl7tReFW64Ku60AKZaxfIxsAK7L27yIxDpPnhScQA9LKs2/
 qFdPHw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d59r1d03d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:47:59 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5093025ffecso73582631cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774640878; x=1775245678;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YdVOzkr0t7g78/Qkg/ZSkv1ZfQiCPqhiBwUFUrk6+V8=;
 b=WAq1kOiCNK4uTWHkDMP5D9o+vyK6KIcIN509RTAjCNd8r5OwEuMMirkiYYF6Xsdy42
 H5rxqvfrBHej4VHEVwGGA5QiOup7tZcPY2k03DoVs01jhC7ANrBIxCvCWSIOKZC/8Xk0
 6UgR+8OAmfs+kBh0hV6qPRY4ZEh6sV/LA2XQKP/3Jr/dz/s8JEwSKItbUs1X4X1C6Cvd
 UGQ1l65x05zZOfyeqmYQRak0Alkyj0mr9UrtOmTDCAcq9xbDwMyRuj0MQv17M+h4ZxbE
 gBhuzpQzSg4Nv3G+cFWWbH3nBFIrb325+Lzho/xaAU3Ba/5m9mFxiIoLhWkWqv0xklhJ
 7+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640878; x=1775245678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YdVOzkr0t7g78/Qkg/ZSkv1ZfQiCPqhiBwUFUrk6+V8=;
 b=lF8krPlXBfxumhv+0QUDje3+fKmXU87mBTN0uEMIp0WTvc4TePGImW4i075ffBY+B0
 XSXFCgtyb6XPjAGppQNVWB7S991rzfuw8cyjy2wpA/lR+ELTBi5oHesVucJBRqOrK7rP
 8eTJOE5oAsLVTwGSjXP3HkRceUgIxAdhNHF0PEhEQvtxZ1pLxEzoLp8KguH/FLLUYV4R
 Jfuk4VffBib+ZBJleMTXY1IAnjRzxIGZWmdCY31CuxYneUvwzxVBUFN8qbUhYx6wceXS
 HIVwV0qeObdQx7V/SkhID+MKIY1aXcW+gE3fM+REp/fjDehf6duhVOfBQD8P/5Ihb3+k
 fT4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkSax/6iY3hFP1T9B2x4dBsfmr7XPAwQ1zTUxWMSILaI5Xjgd7gIoym9P3pfQzW+zZucSInrUp+os=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyD55jn4GkWfciOXySdp/qKs3Few7J8GC9y5vhW68FDN7Hif8PA
 Qvkz6X6oZR9MXq3ZXl9Xk+btaydW9e6ZnyTr9ha9oI8uDwwpmIzAzjUd2d7TG7xN/dBj2gvSez5
 NbzweAQLp6rJa4KwHp80aRVtHgAU4ZNg04RFxwob/i4Ie8epOdsmSh6vEMRD8zPkJDFJxa9DDDi
 PRXZc=
X-Gm-Gg: ATEYQzyX3/ySx8RaE4XI2kna4l+nduWEJ8YgLx8HDkjQjVJGzYP+Y6/XTprjcZLsEjP
 VoxbRjn32V0JKbvVFSaQXhTLgDxsr6km9NYCaJtZuT4397uekQF+jy2F8///4rE1khAxOQr3T/c
 KGsO2IbDbB+1ESeETQ/OCv2n0fev4mVAe+OBXuQdMndf/D+a5PLrd4VXe2HHEQW+agUiYs+px5d
 TzsgXVfO1rYlIq2wQTddI6fyMj4wjsHyej8AnFOr9hv+WJ3dmig4mFJo8N2Wo7smcjeUYexDn87
 zA/Bpd5WuXjEa13HJ57onJTrvMf0WGMOIg5yb2CrctNWDD/NU+5R/TnLrhsxFUEcV32KUB1AeIz
 wB/mX8MONxo0x43qp4BHPdug1K0C5sOvbhbaCG8nTidBoHPK4+9V8UdfCVwmp0tP4g8ZDkQqBfp
 6z8ilUgQfuSpRIGGohQFJRbhvkp2JWik/z
X-Received: by 2002:ac8:5744:0:b0:509:35d1:ca37 with SMTP id
 d75a77b69052e-50ba3839cd8mr53078211cf.16.1774640878304; 
 Fri, 27 Mar 2026 12:47:58 -0700 (PDT)
X-Received: by 2002:ac8:5744:0:b0:509:35d1:ca37 with SMTP id
 d75a77b69052e-50ba3839cd8mr53077851cf.16.1774640877857; 
 Fri, 27 Mar 2026 12:47:57 -0700 (PDT)
Received: from umbar..
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c837130basm275211fa.12.2026.03.27.12.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:47:56 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT v2] drm/msm/dpu: enable virtual planes by default
Date: Fri, 27 Mar 2026 21:47:42 +0200
Message-ID: <177463970853.3488980.13500610408173936059.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226-dpu-enable-virt-planes-v2-1-87971236fe86@oss.qualcomm.com>
References: <20260226-dpu-enable-virt-planes-v2-1-87971236fe86@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfX1pWOWsh3WDjc
 Q4IJeLoqTmMi1K5/9AlqFH9kLcxQ37OUPulOXaMXn37ILhvddtoMtWuhbOdtQG5Lw+oYw85HR7+
 07fMILpF2YxekK1LKLs+dd1Gkparxcbvw77QSFF6LiskWtnqEiQQY3B0hyMgq0q5vyQCyTLvoHC
 n3SKidZ3j7TJ2psg4hG4ThGZgd+/tiMDXOFaEwJcaIauSnr/Mtdg2Rk4DBI3w1C5HRt6qU0V6WW
 L0mMthYjcsClMirsSNJzhrWQ2Gidhwzj5mMzW+K/kIDRkX2Y9GkZPyfWbmZ0x9f2ScpZOGJpt/J
 2fsYwVfdUgb2hpTEIiU8GXUtQAwULIeVhfk3utseflzX7Ndf3jdFTUNgu45VnStwsqtfZgCvCIL
 q9eoVELCNzub4bPr22GSBPkwkj0dtwLAosNrPgDJPq0YQYA+eVT+HyOrgTEPKz64Wh/8nEjwZ5S
 ymjMYCMhOk7QNrs9oXA==
X-Proofpoint-GUID: K92fjvucflmbogRztaHFD45l7VdLqILc
X-Proofpoint-ORIG-GUID: K92fjvucflmbogRztaHFD45l7VdLqILc
X-Authority-Analysis: v=2.4 cv=JaCxbEKV c=1 sm=1 tr=0 ts=69c6deef cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=e5mUnYsNAAAA:8
 a=39mIW4_-kSZLcnXInCgA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270138
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

On Thu, 26 Feb 2026 15:49:02 +0200, Dmitry Baryshkov wrote:
> Turn on the switch and use virtual planes by default, enhancing
> utilisation of the display pipelines. It is still possible to use legacy
> implementation by using `msm.dpu_use_virtual_planes=false` kernel boot
> parameter.

Applied to msm-next, thanks!

[1/1] drm/msm/dpu: enable virtual planes by default
      https://gitlab.freedesktop.org/lumag/msm/-/commit/b0907ee59e24

Best regards,
-- 
With best wishes
Dmitry


