Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1665ECD6E6B
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6439211A034;
	Thu,  4 Jun 2026 13:03:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="H8KFaz4v";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IgoCXURg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09B3311A034
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 13:03:06 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654CprP63242117
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 13:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=JfgOto66Y3BLWLac1kUqpihI
 4RTvBJSSkEWoerZ0cj0=; b=H8KFaz4vgr9C3gNzdMlBYO6OFNtIQCeo1LdaNXs/
 YpfqyoP1Aa0ccSgUiwDXvz0HasZVd8x49Hp/pU6gksfHztq/6Wy3SKKixJTHzMtX
 3H6SmVJmEDX/HT4mdzSaj/+GXrz97sV0TjpxBSu1IjBnfEEisk/puCehARlyz8Ii
 tquZx0zMSUtxv1yU6U8NbBjtAPYUH4Zs/xHsTtMR1llEfTTIKRQuayosNPeVyuI+
 cmoNGQr8Kw4RmphkdGO4DLpS3cXrGD4iNN6BxL4TnhLJId7KslM7EV0TSYddCGxi
 pa4BGp9+7X3brrSKDNw7waXFKI4KS5t+xzjkAZnPNif/rw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejvd0b1c4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 13:03:05 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7e6fed63fe5so727533a34.0
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 06:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780578185; x=1781182985;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JfgOto66Y3BLWLac1kUqpihI4RTvBJSSkEWoerZ0cj0=;
 b=IgoCXURgO1U8YYdkaoGVJ3Xw4aX/273MobuoaTo62YoTgfT62PSFra5BA6FmRcuSBI
 FfrUquQXN+1Dh0lmAA+3jN1OTHtwZXDL3T+fmOiFw34iHvXRg2x03FbF8SlX27zx0bs7
 mrSHMACb/E6oq4+h473UONH+z1WJEUjjceHJag+0Mx4dqagPNtBT2HdbQKpCXT0tJiPP
 LEWbtXIs3lkITqqMLnSqyiJ4GzArQv9invK/MbwC4ZyboPQ5dLrQGbsk3QBBTuB+Zx/u
 n+gaQ1gYcHK5U0qsHNlpv9qykPPq+1T3dBo0HY+Nvcr05sQbM/4m6j5pxDcoBY9LQZC+
 Jgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780578185; x=1781182985;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JfgOto66Y3BLWLac1kUqpihI4RTvBJSSkEWoerZ0cj0=;
 b=bUoqqsQUU5mMrvXBNeLS+XtRDrivym3yeRG2oi6E3VVVKLCqpV1OOzmz6wP6dF6y+I
 ehgLpKooK3PMpZXDVyhYOTIZLrIBn5qaBhiGoi+4gAH+mbvqg36cdSTXO1SF9DV6uejX
 b4WLXqSgmckxt82CTLssHUXI7jbFoC1AkKiK4uUJ4LO9GhC3QBjANcUlXpHMWCHMJZYS
 32cj1ONNB9EAn9vp3suPvXBzE9mxx+o84KSxFeZ2GzPVZpecC9U1N/1SZy++H53REcJS
 TQPDFBGhMrBJze2k+CPkWX0N+7EXTxLHVmH728TszVZP10rwjIHgBlfONS4I78Wqb4F5
 xRoQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+X4JwmmRbMV+ZtzS3KXuG8YfmORPseLyNkuxYjT83Uyu2djbrHBbrFczwpukS5fl1HiIfmqxEpm4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJR41bq+GYjTRdcZoXQ8L8Kh9VCOxejjh/kqZMvJ6j7mkzCKhN
 K6T1JOrfi1Kso3+1PV3VTf+o9IXoB56XjlGt5+65rQzlkeYwU1LDyD8zOaE3HsXFZSNtd6Hu1am
 Ki0oTh9FbnqS3TiZbeeiJFkp7jpK4yLNxTewZPMqLsPvTZpXD2OIfWOlkVMMVgo/saV+xKxM=
X-Gm-Gg: Acq92OGCiFo7pfH+xl+Sp/ev8rev9w8zWnua9ZfrWUzRe4nekdiUeLed9/koOvTMseg
 Cubjnwokb5ZU1m62bKasIFaufSHXTY59FEOlCuLul1i7QMjA3dKL7Fx3EkBUjXGaaynmzrtz8zS
 iq+0pPlfICV+956Zb7qG0PM+jPfDcexm4ZCcOD74g9UQnb20X9fNIkT8rXd32qeKc0DFfK0brCD
 d2ehjre682RWvTEDR7yMWSz8W4BNNdnUxgQ0zW16ghZN3bvq0PP4iMKG02qRnrzNEFztesx/HMZ
 Hz5SJGIB7RfrG08y4YyqjIUN4WD6pM6tUG+b9WM1zHzmy2piJ/9+awTDSPgZo8gQSIBUHxOrg5F
 9/rOCWcRyhGBzjG0M8RZWQtuOmzQyDgPfBCANrQ0Q7q0HVKnacBsGB5AxNvH7+cp/i8vwW1gny+
 HDjAOPgoZQYisJwllsQS4bLzksfu01JxFM5L97sL6LM/8PiA==
X-Received: by 2002:a05:6830:1e3a:b0:7e6:c8e:89f3 with SMTP id
 46e09a7af769-7e6f9244026mr1380378a34.6.1780578185173; 
 Thu, 04 Jun 2026 06:03:05 -0700 (PDT)
X-Received: by 2002:a05:6830:1e3a:b0:7e6:c8e:89f3 with SMTP id
 46e09a7af769-7e6f9244026mr1380291a34.6.1780578184514; 
 Thu, 04 Jun 2026 06:03:04 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-396ac2d5034sm16257901fa.29.2026.06.04.06.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 06:03:03 -0700 (PDT)
Date: Thu, 4 Jun 2026 16:03:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] Subject: [PATCH 0/3] Add Shikra (QCM2390) display
 support
Message-ID: <cvszjw5psd6cenek7ujczjkmcvrzhtckknrifb4pphxotca75k@irvape42pzzn>
References: <20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com>
X-Proofpoint-GUID: KRTH5_Af-Zadmct43X6dGe_Nbb8YJ2Tl
X-Authority-Analysis: v=2.4 cv=M8h97Sws c=1 sm=1 tr=0 ts=6a21778a cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=FTaq_hUnWkcAyd37DvkA:9
 a=CjuIK1q_8ugA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-ORIG-GUID: KRTH5_Af-Zadmct43X6dGe_Nbb8YJ2Tl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEyNyBTYWx0ZWRfX6KOiIGU5rjvR
 4dGNExi8dncr/s4juMi3iNrrsIpjKthPILPwlzfmV6WCXm+4Pc5ePYzJ4NkxQkofsUG3TJsOKc5
 RnnIFBRzzkkJqfSqbcrHO16BX7GgwesI4Fkq5PiwRIw3EskPAbsMxIFEnGeHfnz06CUAocB3xFp
 SPT1sS0b/GL4v1Tysj/gEbeTs+6DznCIaK0ugqIXGBi4RBw1G1EJ29FVy/L/RfOqnD701KOCH9z
 lEi3UnWpEgjbuDJ+60lm1uJmfCcQMAD4HOAofj0HzBbUSkhaY6/FNYvNWZ87GWrt2rVJx46kPSz
 24ReUPcoPMYI7j/Zu6Q9pqZe0fLPXs0K4JDHwSLdagX7nLOI/ghPpGYnfplZ/Nvwqgc7M2DVS/d
 7szT9eh10ECb6efJGjtNLXdSlsoUI9GynPP8/+IRXOEs4xXoUBn92WcfA1PY4fpYKrc9XFZRFbH
 snnpWxk6kImfPx9tzSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040127
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

On Thu, Jun 04, 2026 at 06:00:46PM +0530, Nabige Aala wrote:

[PATCH v2 0/3] Subject: [PATCH 0/3] Add Shikra (QCM2390) display support 

The subject line is wrong. Please use the tools properly (I'd strongly
recommend using the b4 tool).

-- 
With best wishes
Dmitry
