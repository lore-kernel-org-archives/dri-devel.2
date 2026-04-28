Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CE6FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 12:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2984710EB79;
	Tue, 28 Apr 2026 12:43:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GPyslWW9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OrLEPfic";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4990410EB72
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:43:52 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SCUGcS441000
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g1bOohnbPKotWjRJvNuEVMjCfJZe6MhtrFtnqyLmN8c=; b=GPyslWW92QAGYl6P
 DobdNVPhimyrGOa13al5Ly40MBcExRRA7YuH2wxE/Jj/1K7ftL/NdMiHX2zXMe8S
 rJyQeZytisfd+oF45HEjMEWirnMwu/T1BXz4KhVRnsfNC4S3gG0dXN6DGnaz3ur6
 vRk4Ts6+nXld9EhfONxmcOXhDIWRmsvvD/otvokIIt+rMGXHoFnW1BgAdEMgKDSD
 XIRUx8ogLC71ulpamly2TujwDoDKWz2rAh2Sj9gJ5PDes2NCrad0QUQDVP8k1Laj
 8QiTwP1Y4HjG7ooqm2MXaecS16X8PQRlR5mdzsG4lkXsYk6aHd93bpUkdEKZXZx/
 Dbstuw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtac44f0y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:43:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d5d076d88so21311241cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 05:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777380231; x=1777985031;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g1bOohnbPKotWjRJvNuEVMjCfJZe6MhtrFtnqyLmN8c=;
 b=OrLEPficLDkcsiXxXSoeNG8n8OoAjXeUKDKzoYsgxWhVkfhZM+p7umBKS441cMy5YB
 KJemieDkifrdgRDXcJLdq7XBod86WbBqi4NCW/f7amlEpeb1AX53AWTWQvinQBkQFI0n
 uvL6B5gXnsrfFCniNRNTcxTmc5b3akceaIFGnXfqET240a62jY1DS/6P3r1tSOrcAZWS
 l8OmmD1SwEqOAB+U77y4nOgPecd0/aG3a4oZl6XVw5vrAnaMK0bvFuCmeh/EWV9miq10
 guj9vyRDJWJH19C1I1IQ7ybb3ky7suD8Wkg6/cuwY0uwQdznryJx7sLi6G2aC0qwNi00
 hMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777380231; x=1777985031;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g1bOohnbPKotWjRJvNuEVMjCfJZe6MhtrFtnqyLmN8c=;
 b=K9q+HnK9nY4eRcW/LPyZg5iDetsEC6uraqW3zQeIszOTS/49Cp3HAz8CUqfJj8M01O
 LalqZiPpA7Ti3C/zq7RzlSQQqgvHrfKrMYEpPb3yGNgcVTixZ/Ps2WZgAqJw3V5mqpuj
 rWHcaCGu+C7myvSB0wx0N1LQlD7bpz2t1N1QIy6JQo2DFegGlgZxSrQCboTzNmWi1nYP
 VnVUbmpmrz4vUp3SxPXlL7uH6zFpOKKW8uGfZ7SXAp1YIKuCJg+s63hBb04bNuL2Hiwn
 NATurHKnA00YMul4pXkNJfcfop3GVGR2uBMDFeuYyIAV5n6xMThSd5wdGgCk5noicdta
 OtRQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/15BhTOQaFkotYaPhxlr2c9clt+qAEtoAEhDqGWt1DQT7eLsyCUFCLPJsQThH7xwFmwkIHBq2sfvU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzWlRc0KD/7UAK7ExKdOlUuVqMX+8tbEPYNznh4pOnUfIJCmZz4
 4U9h2gT5ngNri2KVow9atISfJ07p94P62jlBHeljtd0Gelweq4vvUTs0EvADzoeUYltX20XGXZz
 /TOeCInuhIWm+RR1NnEyZutmBQe27eyqzgeVu7j3Z52gGWUNkS4q7LBC9PMEXizqyAoP8DPw=
X-Gm-Gg: AeBDieuW+BVhy3NUi4Zaz6NNQjZzgeubX3QGR5k56IK+WOweLlSrG0wM7nrCzLizGqA
 IPFL/nItwNPYa+UfglQirFQUhs5iA1T46FKIuCq1QTSXvLFZF30onClnn/wP9kPrtjNk4pQFEYK
 LF0cqqPK/BlN92vdxW9mS2r1NgP6kZDCzmcPyhyt2E6Bp1EcWdkKoqrEVZWJ6YYBmEzD9Wq1cIr
 J7HLaFKfL1a9cZ0K3Yl5D1D4e9VfKTPkQoK0nEVMLksRWAculnkTkUdsM12REO9zCnjbDbPQ3n9
 oWXW/uq653aLUj43+LqiJLBUNRDOGzhVZoY/6j3gzNrUP/7S6FFpO52WS1m/fxwY36dqk596Vus
 oEd4aiN+S4dE+d4sH0JPQiuZzBTcTw8i1oQtz1rYDFIhEfQEnGphYkKwih9ddTCwveKus00rcxH
 JS91AtC19ShRlMYw==
X-Received: by 2002:ac8:5887:0:b0:509:2a92:8088 with SMTP id
 d75a77b69052e-5100c8399afmr33634391cf.1.1777380230663; 
 Tue, 28 Apr 2026 05:43:50 -0700 (PDT)
X-Received: by 2002:ac8:5887:0:b0:509:2a92:8088 with SMTP id
 d75a77b69052e-5100c8399afmr33634101cf.1.1777380230167; 
 Tue, 28 Apr 2026 05:43:50 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bb80853b479sm98446566b.6.2026.04.28.05.43.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 05:43:49 -0700 (PDT)
Message-ID: <6230dec6-f328-46da-96a3-aebda5c15815@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 14:43:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dpu: Fix Kaanapali CWB register configuration
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260428-kaanapali_cwb-v1-1-51fdb2c65498@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260428-kaanapali_cwb-v1-1-51fdb2c65498@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QG3M9vVlekJUQ2cx47Xk8eCgKxZ_yFAO
X-Authority-Analysis: v=2.4 cv=D7J37PRj c=1 sm=1 tr=0 ts=69f0ab87 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=g7eih2tgvwwgKFoWVAgA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: QG3M9vVlekJUQ2cx47Xk8eCgKxZ_yFAO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDExNyBTYWx0ZWRfXwNIWO3yUB2+4
 r1HTvSauayjj6X4/QbDwSokMwHRE9rYDctBC7y3DJlfQEUMeQYyKthlJBaj4fVje15tubg4vCjH
 WL8iNBHe/csl+NduEbR9vgPVllHa7lyohE0YBBV51aljp91VFVndvT83cQpwBZFPMynitbuNX6q
 MoYUDT/qJ1ZtJ2mYz2WXYRLeRQIi+wTyiujC61/cycGHrlexvGN25Ni9X02PDuUZItJjQY7IX+P
 K3w3PwdrG8bCGvT8mtoYJ/6MDew+xm/1CCF6+7h9T0fiCln2oO9xWILwBHhDSeGPTRuCDKDo4xP
 r6Xrpiph7w+tMf8buwBZVpSveyPiva30hl66wM80HsR80pA8mge2g5fdIfpb6dCuWYU3o7RSkuh
 fsbR809AgCEew8LCTUctkJNoJA4JlzOWNrMIF1lGWkZbkmOUhnlMDpYYGarfbCT4CQ3mICZANU6
 MctNbWO1ULCdtm8bTrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280117
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

On 4/28/26 1:44 PM, Mahadevan P wrote:
> The Kaanapali DPU catalog defines kaanapali_cwb[] with the correct
> CWB base addresses for this platform (0x169200, 0x169600, 0x16a200,
> 0x16a600), but the dpu_kaanapali_cfg struct was mistakenly pointing
> to sm8650_cwb instead. The SM8650 CWB blocks sit at completely
> different offsets (0x66200, 0x66600, 0x7E200, 0x7E600), so using
> them on Kaanapali would program CWB registers at wrong addresses,
> corrupting unrelated hardware blocks and breaking writeback capture.
> 
> Fix this by pointing .cwb to the correct kaanapali_cwb array.
> 
> Fixes: 83fe2cd56b1d ("drm/msm/dpu: Add support for Kaanapali DPU")
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
