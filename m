Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8ACFEDB7D4
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 09:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F4710E3A3;
	Tue,  7 Apr 2026 09:45:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GHXcsII5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eSHjRtp3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6654410E3A1
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 09:45:50 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376Ru292550324
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 09:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cfskHRxWs4Q5ZjCixV6bAcEHRAVNhSSPy9XEfrsCxLc=; b=GHXcsII54awwJtTj
 vlbtWSyiu1jswi3cOAxhKlnjUbzxDKCh2Je2iKAxisMM/VaUTHMheBRX5hC08aLN
 /riaLY980pg/7sVXdjm+ZnSO2jjnAcCraJVzR75R5tTWV2wbR5r/86ySuj0tUr69
 o8aP0M1LNuXzcL82lAwdOS7qyO/gqrppr3Ov6ZMdGiuknSJoNyqwdw0dAe4F7YlL
 qlrpx/bNXb/JChWcTo58eyeUwDfsMqTyl5uXHc06Zko9cNaXl09JrVFU2iTD6ROu
 92YJ8Pa9qf9f8RPwyIcZLe2jS+/mr+bpQoNU0MQqfl8bl6ytsZ9Zi1PY3dswfc41
 uT9CpQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrea4fw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 09:45:49 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89cd0f68ed4so19971926d6.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775555149; x=1776159949;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cfskHRxWs4Q5ZjCixV6bAcEHRAVNhSSPy9XEfrsCxLc=;
 b=eSHjRtp38ITOGW1PguM+RdNIkGwE16IYY3iy/V33MS8PYcn/cQUIxPBl2Je3Z2VRZe
 +M1OPt4wUpTOdWzRQdxTpM7RYlMst7whuDOOXPdxEW325WzN3iEA0i4pv3la9RHuKWti
 AYFNYmimd5DOi7mkopsWpcyWTWp3XtYg/qwNZlrXAdm3iCp7mc6ldIyuzzQg6RASKYxl
 OrnSVBv54KAdCupkI/h2huz0u8nBgksHI1eJnw2R3OOw8BaNexMQ/v3z9qgic+GVKnVQ
 Hffg9T8eWj3efBxARtVsXXuhn5ypWzoyzXuQjFrE48c6ryZ+KbfyHwT1m9CsgmIq+aXl
 MbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775555149; x=1776159949;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cfskHRxWs4Q5ZjCixV6bAcEHRAVNhSSPy9XEfrsCxLc=;
 b=NysUYn9Bj/Q7jG0KhH0FKgQ3bZTpLSCwjwOutXWhYlqUu/0nQYdZvyQ1Q+oDzDIZkO
 5YuDr3lI1+CLnPZJovGQ+OFVz8Yqm5EKtOD+Bhj2KjKiF2CjfAaLGC9qngLJQSfI61m+
 p+1gAqBXSvjGCscyoPKbiqQox/YL+uYppnsaMzH1fFR13epRTVioQujJ5Bd2Z1bnnpKh
 SGvkimBEgGPJZmG/AqXTZsDKUCNfVDD3wQ2ji1E0SO/NycHV3Cs/kFRzEBPRNFTWPJ8A
 Aj0vpQ+9Yl7zbNSkVH9senWu+HoEMjdp6hoRg6b0mG+kM93P5T1WRV6w5hUq9rmjcFRG
 veFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMaWmEekL2gPNKJejL8dB73zA4LsgeArC0mcSx+oycr0F6NGZsX+Tftbk2iohyiGuHY875HSEYCcQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMOudZhjvhgrhhy5dPWpSy5Ai2wENDGDesmQJit1F2/eTZoueY
 nZzQzR9K0y5ufBk+z3dWRPHalGID/2jU6kH2P5r7882g9aUyL3RtnVxrp9WvR3hTEgWfg0MZKBE
 +6d59/HDrYiD5/MbEmxLDQwuI79yb4vO9FI7qXIdZLXx6gGsqi9cHLa3talq0vEX6+qvuoHc=
X-Gm-Gg: AeBDietPLywP6CojgTmTvLC/Z+m6jbBB4oCXd65pr68cHYMfwRGIqo2QicdSOcl1m/L
 W4ZthhlN9jSQB8OyjbxrLyQEtXueFzcgMFeklSWJ15qyW0yXTmbxzMONwAyNqBzIi3+6QVRFGl6
 0nn/t02U8BDY4Lc9xrvQhBZrIW3jKw1+GDeKFikeFyJ7nb5GcT472E/Rc1wST9b9KsoYW2c4tIF
 bvfXUjY8PzgDq8VWDzNNnOVtzj6Wk3rcIHyGkt5MoLllVEH4/sHCIyD2VlZVF2f1IZNRxt678xq
 c0iMHef9RXKy5udj21NBezw5Yie7LGo9TWQvlmQkjthHApIk9v7FiBGzwoEtNDIR1YKXGirHEXW
 /Qd2N1IAmwlVGRP8jXoYQML0hX6hZYp5XiTmAOSwYJZyZ0DsEasclEMX/SwZU4jWX/YyyXLr8KH
 VeATU=
X-Received: by 2002:a05:6214:5090:b0:8a0:ee7:7abe with SMTP id
 6a1803df08f44-8a7022bbbf4mr191172236d6.1.1775555148571; 
 Tue, 07 Apr 2026 02:45:48 -0700 (PDT)
X-Received: by 2002:a05:6214:5090:b0:8a0:ee7:7abe with SMTP id
 6a1803df08f44-8a7022bbbf4mr191172116d6.1.1775555148162; 
 Tue, 07 Apr 2026 02:45:48 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3cec6c47sm516276866b.41.2026.04.07.02.45.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 02:45:47 -0700 (PDT)
Message-ID: <1b9891d0-39ca-4b31-a21c-32d8954aa7e0@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 11:45:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/6] drm/msm/adreno: rename llc_mmio to cx_misc_mmio
To: Alexander Koskovich <akoskovich@pm.me>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260402-adreno-810-v2-0-ce337ca87a9e@pm.me>
 <20260402-adreno-810-v2-2-ce337ca87a9e@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260402-adreno-810-v2-2-ce337ca87a9e@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OKEXGyaB c=1 sm=1 tr=0 ts=69d4d24d cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=EWmrOR-qnjryNtOcuEoA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: KTgip7caK6wjoo7Z5J_d7jS2ib7e-I7l
X-Proofpoint-ORIG-GUID: KTgip7caK6wjoo7Z5J_d7jS2ib7e-I7l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA4OSBTYWx0ZWRfX62owXx7WG6/K
 4Qqp8lGqUDgcCV2DIPIl1OVRV+l7UHzeeJR9Ps+7eDsAgTWH0gNxn9gWFszZoaKKF4VnOevZgYP
 SRyIYm4ZUuBr3CR1PItOvdwV9D9hLJykBUg4IMN8GjXNLEmG7CpoBErj0ZldCWfTImbTofQVbNc
 /L8fcJnpu7H8xQjTyxw0VD/bSStJkNzRY5UL1mEzs9GIMm/1baFUapkAConG74hN/HFdoo6IRYO
 w9zE+BRHdUpHQm0QfIdDUHwASMmw1SsyQyw7LDq9tcbGPo9oiFKMnMATHM0lY5vUg2C0jReInyP
 IB7fvBoNdekFzEUVm6Z8Y4K6adnmhbeCFj5UaHvAjpl8a47Hx7pFkMLkbsP/LSLIMn6hcGnAp8m
 8KBBZ9lMiAMfeIhsV5cCtqqe2yVdSWi3hSlJEkrGBbl1IawERS9pIogOGaeZ6tdv0dDXBpA/9Sp
 qntIb/JFJIHNfGZBv8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070089
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

On 4/3/26 1:09 AM, Alexander Koskovich wrote:
> This region is used for more than just LLCC, it also provides access to
> software fuse values (raytracing, etc).
> 
> Rename relevant symbols from _llc to _cx_misc for use in a follow up
> change that decouples this from LLCC.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
