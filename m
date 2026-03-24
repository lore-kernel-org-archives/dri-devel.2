Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6F1E9A75C
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 825A810E5D3;
	Tue, 24 Mar 2026 10:03:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OE+Autr9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vq3wvG3o";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D4C410E5CA
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:03:54 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O6XZIN409104
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y8EZiHIjdanBhV8KTPPr7I3cX1eSVsJPrp525ZWH7N0=; b=OE+Autr9v7guW8zl
 VLY9gXRRjWOMSINfds3CEYmeOzsXFjz20hHJSmbOX2FqrXorJnsyGK8wYrSSzE27
 qoRhWFcF8Z5fw8XTwBDhNBx/0mFrWEJfnU4l7++S9T6sQK+3XF2Y/sWuMJ/k/1hW
 uk7eoV1F7v2Ygye55/AeTsnuIlg7yjTJfguDAh87LM4FNVoBldO9mFcXIeLbwssH
 fCPIU/4+zGFP845+XLyTBXUrncRL5gS0GtQ0n/tFTDbUQGowIrzo+tK5Njk5ugH8
 I6nKiDDSW96ES7rfNMFkORel+aOCZyJ1P8O1X2MpUOP/3mFLCm9M+/xzQ5sH1Y5/
 D/DioA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3nexrrj1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:03:53 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89c867b7d6fso31973636d6.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 03:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774346633; x=1774951433;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y8EZiHIjdanBhV8KTPPr7I3cX1eSVsJPrp525ZWH7N0=;
 b=Vq3wvG3oV+jTNq9ghUkPsZQFS9Yg03RyO1wSg1UjuZCTPFJuhgxkjDxihdj0i9812n
 1y47S3M+/QbMT809Gs2Y2Zi+2leflrzRxSBYTuZKKp+STVjSu5sgxW08tlXdSLsYdRKv
 a21Ke5YZgW1bQlbZlCdHAi0j2J2dRr6Qry4Pd6Yv0CV+6QPCkJQDfvo3coHh5C/cSg41
 oIzqZG65YKg8OXdFsry4ZXsAB0jGyrQT4tSt6/BFQ6R68yToIs/0tJ0R0Ht4oICi+oQ/
 bP2wkBJPN2jPP2F/Wiwt2HSxe/jwYGCXcAZ3TdX7hjB2Qjs747qmXfmofl6m4mwZWKOn
 pEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774346633; x=1774951433;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y8EZiHIjdanBhV8KTPPr7I3cX1eSVsJPrp525ZWH7N0=;
 b=tHFl19EAslhmXdPYCZzH19KZ5t9NQZxxzQXVi3IsmZROHQXSdxZEFNsxgtozDPjWSc
 qXZaOCHeHXFd9e7mnGOiSnHnpGglcJohTvWJFue/g+6ztBdGzqt8hRdRVQGixUmTqMu3
 55ihhq2c8DUo+lUqbqmqD0iQ0A3N7+h3p3Yu+cq8EPc2Sg/G7C94KIBoVnCmkdKgCbO2
 5RFvYWxCMMbZ89Z91ZCxXsnaqVcA74Jh9W4pXu9dS7fFC52Kr5xhC+e58MJIzVX576kh
 ncxGNt425jKDp/b9dSV2NJHYRtjrn4fTmLWnsvFVVS0TnJ3YuuCmGe7bd4KTl23d4O1y
 YpAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV03oIr0ZYIvmU3PgJbHZNy7SCFEHB77a/u/QXBdOyynoyMhr8WhR6FOoS/jSUZ5O00IlEylKwBMYU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQvyFCZRsSRuOmB5Fhw8JK74n1011+aC9vH26NFHUytjJCTvyg
 YQ4ABeLbQJuxJkh7biTUfl7OpfBcqXtig0USxx3+3GH4L+zXCmLMi1P+mtUqx3bjxri550SLN6g
 69/nrWZOyIsNxicm/CJCKHDpt+GxlLMw8MxQnseAUUbqCq82vUsNVXD5eNd/tsbIhO0nfzOU=
X-Gm-Gg: ATEYQzyDZ5pSuPwEXNvRidRMe2CHLhUoJTnGFAGNJxp1abPv81RK7eQ5yqnM8DGeqHq
 RPFxdTjxIWhmz5Y3d0FWPTYVCEs7FLCl8UQmD6mQxTXEou/rf2mWYixJM1LRBDHiFR+d0FeAw9o
 McUBS7uli48opMRAe0olorBVI2qsFSqhTudovJ7vz+1+DLYw7ZI/KhSgI8RaP+EGRd+i9eO3e+N
 Z/3GuhXHJcRHX6lJXWBpYCYHM3/KNywO4lcMAwz0nk1WpSvQWdM3eB2Fvze26y/J67xuELoKdwz
 f/60FQWFutih18JzLeWe0N3oJcYOjTdIMvQ0UGhsL3ZT6MiXOWdL2roL+a/wo6eZF2s2OWl74MM
 sUojBE2hGvqZcaIuELe0z33ZjvnFmfdeiZANnGSyb9ChcRtfVmgcC1lyyBD49uGA2d+9kcYNOmy
 Xz6Pw=
X-Received: by 2002:a05:6214:301b:b0:89a:595c:b805 with SMTP id
 6a1803df08f44-89c85a421acmr188082276d6.6.1774346632608; 
 Tue, 24 Mar 2026 03:03:52 -0700 (PDT)
X-Received: by 2002:a05:6214:301b:b0:89a:595c:b805 with SMTP id
 6a1803df08f44-89c85a421acmr188081806d6.6.1774346631903; 
 Tue, 24 Mar 2026 03:03:51 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b98416ac27asm493991066b.59.2026.03.24.03.03.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 03:03:51 -0700 (PDT)
Message-ID: <b64447db-bbb0-4457-b803-ebb3eca26107@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 11:03:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] drm/msm/adreno: Implement gx_is_on() for A8x
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
 <20260324-a8xx-gpu-batch2-v1-9-fc95b8d9c017@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-9-fc95b8d9c017@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA4MCBTYWx0ZWRfX37v9BkdLOM/v
 01tibY2w+q5h7XT8uRWZ25EudThmcpz53Ix4tCsU+q2T6WSti2f5Sg2OZ6fVXaEXAeV9h9Kb5xu
 P9ZcI1KxzUyF6Z5z/ZhUnzpXKV/VbttsjSLMCuM4flh4DDNrbkJYvy0u2ud8BDP+EfFLq8Xgd5Q
 AXxEXzfi5ydvy/6tvZxRnwxMLtCdn8ZI7qnntHPOR1sBQUT18U4rY4mC8hJipKtoATlWbAy1l9/
 h9K8UJe0julX6u6kpHBjlW/DQo0qWI2n0hri4/ZYrvp70dOU8K5/U8MnYl+TX5I5wFXqqsG3A5l
 B+25RZjcV69gxghP7gJhqoBu4F/mcsS/QqggQ2z8MZslY+EbnDGzvSMQMxEKmXBpjvqSD289b8u
 uqJLmO46JO2UWBwByFWEVVjO5iF7Ryfy8kork77v0fAfAKGok7BVH/3GNjZ2fs0qm8VsZq/3Txo
 j4RS3j+tVmkZiUZXHlQ==
X-Proofpoint-GUID: mDBTtmvYwAJUVowFxhuiG-sG6teyrSiC
X-Proofpoint-ORIG-GUID: mDBTtmvYwAJUVowFxhuiG-sG6teyrSiC
X-Authority-Analysis: v=2.4 cv=Bd/VE7t2 c=1 sm=1 tr=0 ts=69c26189 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Kz8JN9e6_yQgur5BIIAA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240080
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

On 3/23/26 9:12 PM, Akhil P Oommen wrote:
> A8x has a diverged enough for a separate implementation of gx_is_on()
> check. Add that and move them to the adreno func table.
> 
> Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Fair, but then it'd also make sense to do so for a7 which also
ignores SPTPRAC and has a different bitfields vs a6

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
