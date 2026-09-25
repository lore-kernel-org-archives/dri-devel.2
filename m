Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F5EC9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 10:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 306AE10F9C0;
	Fri, 25 Sep 2026 10:19:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PY6bP1Zz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eR4sgudE";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3EB010F9C2
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 10:19:51 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P5JXk73628372
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 10:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xf2vfOTw6OghVgtOTKpyAIz/SPmCktUBeB9H5JkyO5o=; b=PY6bP1Zzy2OI54b0
 eWYPEApLj86npiYiybzhCFTCpCb9qWv9ruDWWfe1R1XKtQ7Mb9VfsN+xNrDPEy56
 IpcSD7+WfwSBKyFCDFTfASl6nmJ2o9TBj2wNqSvyamFgiKaIicX1qxZqbG43QlBd
 8azz0qVVLYKgXKkeED6fiV9lnaxyxqAhCgVZFvamdU1EEfgwlFslctY4Vo09gN2z
 YSMxo2KMMS42jmOLP/C3E1gPzciBCELZitxg5/3V0ZT9Iob0ScCtPsuZz3oMgHhQ
 iE4UYlZ7shWxLlLkXs7J9e81MCLuSPlTwuLB6tbJoRKbA3Y3oZUEM2ZHEEpKndiD
 UGHcdg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq38wr9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 10:19:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-938fd633df7so15478385a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 03:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790331590; x=1790936390;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Xf2vfOTw6OghVgtOTKpyAIz/SPmCktUBeB9H5JkyO5o=;
 b=eR4sgudEm7yB+5vDvlAJZHHYXE+cDyIyvka7nauuV/h88ny2TCm1Xf5hitUAb45Tto
 vRsw9iNL2blg1yYY7tHavJXQNJK3zV8EIN+FV/UkAx9KV/EtOGbWWK4WanGmCvzGcBj3
 /h0YrJLx2l7Ovm4Eg8sYznI1l9GDHcirtjF81v6IAKSj7ZrIgua08sjlOs6BtvbIUEiY
 6TSZGj02JkTFlmoS9uUYjVo2zh0TQKGhC8fePLWMaJZAKAU2P1PJKW0wNdoHetcZ9AGy
 I8g9aMvg32/6CD2Dq5kSeScGnWD5kiJvJ+XxOq5wCtLrTJTjgF4mLgSwPeaWMHvdczX8
 rXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790331590; x=1790936390;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xf2vfOTw6OghVgtOTKpyAIz/SPmCktUBeB9H5JkyO5o=;
 b=F3bTqEgmqS0xMBHnAgiz2DO/Y4Y/q/iU+w4cF+jxJgx0X7fqrC13rOxUuTTyePKJ5i
 UM/WDscfKoGallrkSB1GYGn58qlazyljOnNIoAFP+JdV9dHeLvb0osg4n37PQdKSJXVc
 FHSQs2WrV/RvaULKdI8WxQjIfy2ZbQqF2G1U3THS1LqDQGhFFZNeM8KndyCQ+8JQcBy/
 0jl3T/kzSdGDVIhQIn+MD+ECjZo9IYAK/cA0wcBvQC0zPplTXW/ZH+jlpHOoClGa6IbP
 gGj7S9Ii8PLa9u39CPFI6j1KJzJWIWnpZpO+Hwh7wS/OgF2QWIoA7J7t23/Sr2FAUVFy
 qoQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/+Gg8GBAxEAKFmTmLSpEGt/A6PEb4HHIJUmOx9wfOB5RVe5g67SuzyJPjRE/9bKj0b5DNIBbhRrE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lUEZR13IJMGfALDJEyR+jRJXmKkE1+vv6F7/EGLbKX3vbQ59oQ
 dkLlXTOOJ/6jnkQC4ZOX2ai0pY1HyHFQ2mcqptiIw3kM8CIm+DRVdRoXFZiWpabel9m+6TJ41N2
 ngO5YKQ1UwT7Gw3RffiRyGakQw8xsiRn1Wjkf1miku4rUa+9ygTvv2H2e/1FWzrWR4WK8TG0=
X-Gm-Gg: AYBFou3n9StzWcONWKS5x/5okPE5jW4sA9Tjo2TmZDapEfFeubY+OgzT0fj0E6AM8e0
 scNlcjoA9fV6vg9jl3biCt7Byq9wveN59V2HpxXgUg6C4qGcNVHY7IY96cybQYmp7exzqDxBaZ5
 anEjkr/h9y85pSOBC6bzcfpG1tcroS0jAxsif6W3FuWO9kVG778khBvWHT1vg+quzU7jCeKfL6b
 Q4aLytkdBx+2O42WlcUTjf5wZdQc+vWDtMiMiXL/wJlhZvaeqsCE/IhUr6Wjy3PBhAMICpencsM
 PrOLeZaSjYWExOiXSGM15RO1S9MZ4XqTqTthxwJ+q2c6bkkXPH5tADXVeAezB1Gm7dURa5oEzfF
 bzp0jewpHZDCaRC4349T45Q==
X-Received: by 2002:a05:620a:838d:b0:93b:e9b2:3f97 with SMTP id
 af79cd13be357-93c43ebbefbmr309667685a.4.1790331590031; 
 Fri, 25 Sep 2026 03:19:50 -0700 (PDT)
X-Received: by 2002:a05:620a:838d:b0:93b:e9b2:3f97 with SMTP id
 af79cd13be357-93c43ebbefbmr309664785a.4.1790331589559; 
 Fri, 25 Sep 2026 03:19:49 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2ae74815easm93578766b.23.2026.09.25.03.19.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 03:19:48 -0700 (PDT)
Message-ID: <a5c84bc4-8848-44cc-bfbd-97878c3fb088@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 12:19:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/msm/a8xx: Add Mahua GPU support
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
References: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
 <20260925-mahua-gpu-v1-3-0fa0bfd8d315@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260925-mahua-gpu-v1-3-0fa0bfd8d315@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0MSBTYWx0ZWRfX+cCHTe9EhXJs
 2gwtmKgJhJkwQZ7RcsnUbQQbEsAmW30Xdy6ooFX+Zw1Fy9s/1bY/gtgjX4Fafksrav5IIgkzq4h
 ukl8rhCg7ucFIjai8vLqXNo851+ditM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0MSBTYWx0ZWRfX2FZ5TDvXtMy/
 UpunFeMKV/nK+nO5mdDoS6cpWuyBOLKR2kHfY45RI7qjweQYNJk6X6W8i63KrvLxiMl8XSY3z38
 4uNZk2A/3tCf7khPEHEt1/31knWM9HQ5IR3IpbC0v8X7+lhAxjmKClwMKduOHCq7bDZ3kyvWYc4
 wP4xeBRMvE0If9gEmOC2GZmgQORWGBiGd2BjoHiwAo3k5Ue5c+VEN9hrV+vG2E8cnuGIB9CQJak
 luUyizM0MAh37jqZtFkLe2FOpBrjKiHt/Py97N/CUMad1N2Lp9gZhb7Mn+MTlJuXBN+vzB57XnG
 7nZXYV8cGK5A3FdWBdMcUfl+ebos225opGbWTXT0O/yRp6753XLTU5h2g4W1AbFWVSr0pEms3J1
 HNv5sBgtIcrUleQDvUE/59ZMikaCG2hQvF2lnNJ78FrHQHSzkhjtEKdEHiFXnq+MS+oKGzBiYgK
 h3V/tFxomCUhny0iFEg==
X-Authority-Analysis: v=2.4 cv=VuO2kO2n c=1 sm=1 tr=0 ts=6ab64ac6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=QDjCMyA0A8yHJihhU1wA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: NwaBVy4bCdsErMHEeMVQRVmfpOfL2hTv
X-Proofpoint-ORIG-GUID: NwaBVy4bCdsErMHEeMVQRVmfpOfL2hTv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250041
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

On 9/24/26 11:14 PM, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> Add support for Adreno X2-85 GPU present in Mahua SoC. This GPU is a
> smaller version of Glymur GPU with fewer slices and smaller internal
> memories, but shares the same register layout. Also, the GMU chipid is
> different when compared to Glymur's GPU. Add a new catalog entry to
> support this GPU.
> 
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
