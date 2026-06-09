Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507B1CD8CAA
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2AFC10E537;
	Tue,  9 Jun 2026 14:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZhkhebgR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MRXHZaix";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5B3910E537
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 14:54:20 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659ClPog2249705
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 14:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aI77O8CJQYdLvJeOk6wk0XdV8aL27Vmep/f1OBCKYOw=; b=ZhkhebgR2zoqYeo/
 2xws2T09pgVBRSGN6bcoL8wMfMzP0WwjZfjzzjkSaAh/Go0QcwZJYrSn8tpBs1co
 NU70HdWw67A6X7XdoE/5DPUzbs2lEO/5k3Wy3tdvdZIY8RBSHxDd3uFAkBd1eCzV
 tL4E03OFGYuYgR4RBWv9aAGN0OPWZ6tQKKyXcUudwySqx2LuKyR0suWkw6RKRFlc
 xgzkwNBz3+JS3okCWhxNVkXB1PexbSCnycKu0WvHKkPcKpi1hyxt1IxA84dsYxJa
 4CzQ3HAqXsewSED+7RjoaqM3czPIC6TvUNn0ej5wXdT7ZriCSOQtQFSK3fYuG6lA
 KymTlA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3whj13-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 14:54:20 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5178a632a12so15409821cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 07:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781016859; x=1781621659;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aI77O8CJQYdLvJeOk6wk0XdV8aL27Vmep/f1OBCKYOw=;
 b=MRXHZaixpXf4EY3Sr0Mq0gpz1tgpWi+VOFFhInmfxbSIGd1MX6KbP6kKWYPjmPVR3B
 Fj/kTPyqxohTcLgWJVsjEKSsHs9/cFju3DVeIIYSJyA4Rb/73BAceseqGEHTGaPT+kA/
 Ml6b2lYi8C5KXG/S8h8SsWmfEx+pM39aOQQmLKal2xXPLMOTrPVMhX8GTk3wkwZ/Hl7X
 b8Xf88N0r78EB1Qd4cUB+QePjgPwO8terzb1EKsJHnyR16AKRZFVyRRQLkpeLYxAoWfO
 QqEtsyxjuR9WZZ+NI72osLY6l51BU+HVZ5ING0MAIANSaHrCXPT5Ai3GqMkGKQeYbyOv
 oxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781016859; x=1781621659;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aI77O8CJQYdLvJeOk6wk0XdV8aL27Vmep/f1OBCKYOw=;
 b=Vo2dHRZrqIj5unv4r4gE6Z8LyUxfHgRKu/Dn5kRd1dD5oPqdU3BrSFL0f2881tS0ih
 bs9mjpdZDbeU3b+IS5xNc+7xniOllBAV0+baJqCCxbGCK6uD/hrhAaiaHr94dsA2lbjH
 WOW1G+B27gDm71R4Gh+zKYEsFnN7op1IomybPx8A8FjLSt2SNv/BIH28W+OZJalMi5Iy
 5UBdTDXz0c8U8J5vxeG6FKlM+XKJLDrUG7Z2pyQ9yyiKDKwPetW5vmH5/ZGCtu+EWhG4
 qT5yL7ZhrUOkqqjRQILIDC0D3zsX6d2GeIbwZ/omGvNwidkvf+1nRrBMkBnTHQwwAP9z
 kQZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zQZztfYg3k4XJSQzvvMaJQTupw5PwqrfA6AUamqhlh8iOxQmenO7Z35tZ/FXi4wGGia5REJGOOc4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCF0oSJVyH4TNzEyPpuuCQDdCGKpLiQ+t7jXFFtuedUthabLqn
 GvYnVDj+EUEF2TmirJIr9KkMyNi2O4ceauJ5+DubcggSfKjeZSTYLk5qU6S3BZtxsR+6GrNHZ20
 tPcoNvfKVgj2kDeKJDOYuf6TGv4Tz2kGte5e/taoeZN9aXRhGQiIPs/DipL7AVgKb+uONFc4=
X-Gm-Gg: Acq92OFBo4B+SDVD2uq6AITmHySlRdAO6sUb0wv+u0KAzCGXnUzoaUGQssPQwRHvBrG
 1/pi9uqytRKEbG0IerExE97Ytml+VL4prCJo9Q7QRgzbEu4DypzKJBvx6+efHm0G2rQlLpgfyGH
 WdCSaTqWOAngaickM/IYY7XewY+K1V6JPJjry4IYo1iK7ZBzjZH6VkuVXDwiBIeQ8Xd2c5JP+lz
 sC1+xebXG61zeRowF3k74cp2EcLbrFKiIZSX2f4lI5NMm9zYs2Z3HIVjpbeU3hBwt3sC4EfYbfG
 3DM/A+O8cMv7xAQMoWflbc4jFuKIvOnhFAKGfj0/0oIIpOZzeXAEGBI9GgGNWqF3lcax1OP9U7e
 VaClYwEGuqQzd+fnK+kjHNgVer6QM9RJfTKZZwPUuADfYEiIebQ2iGVR+
X-Received: by 2002:ac8:59cf:0:b0:50d:9138:3322 with SMTP id
 d75a77b69052e-517ca478a9cmr25292261cf.7.1781016859336; 
 Tue, 09 Jun 2026 07:54:19 -0700 (PDT)
X-Received: by 2002:ac8:59cf:0:b0:50d:9138:3322 with SMTP id
 d75a77b69052e-517ca478a9cmr25291561cf.7.1781016858752; 
 Tue, 09 Jun 2026 07:54:18 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf055307a35sm1053926366b.52.2026.06.09.07.54.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 07:54:17 -0700 (PDT)
Message-ID: <604e0428-61b5-42a2-b6ce-a2b071378cbb@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 16:54:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] arm64: dts: qcom: glymur: Add GPU cooling
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev,
 Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
References: <20260522-glymur-gpu-dt-v5-0-562c406b210c@oss.qualcomm.com>
 <20260522-glymur-gpu-dt-v5-5-562c406b210c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260522-glymur-gpu-dt-v5-5-562c406b210c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0MiBTYWx0ZWRfX3vs2ToLxfocP
 pBOu+HhozMjdAN8kqQdBxJSgyUft3j6UzybvU1UF9NvZYSE+zWrBdQHJkogJ4u/cVAt79C9DvpE
 U3yCbidL6VfRm/dqOYW+9cIuRJgeKOh2KemFXMv51ezZ/hNfRIm5A69zRdVDsoWQYgwlsvzaV8V
 XES3XW0kUJ3rLUE4tLXXpdwJdm0r3pF35+CkPCT8Ybl37+syYFpM420eh21A59WDPHvyE4HGx8H
 vL1PLiRZJhUCNc6KoOPmB1khsHKNmP7+M0K+/z8pynHiE515hn7snEHQNTOGGFqVdYpG1DOsfwT
 7FvK34zSNdYv4noTWDGATZXH5jay/Xu6FexqTRXOWnhcrg4X2fGQFRnEWURwkCenszbLc7Yeklp
 Geyf4cyUrgABpxjncNX4do8439qt/LI5NGRjyRzv2HS5postKZg74aF7C/oX+xC45cgoG2N3Kxj
 HbO2Zdhk6eSXFna65EQ==
X-Authority-Analysis: v=2.4 cv=csWrVV4i c=1 sm=1 tr=0 ts=6a28291c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=GwzMoqaa5OBlIbEppCgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: SXdUJw7iKz3KZmynBmL9abanOVeKGhT8
X-Proofpoint-ORIG-GUID: SXdUJw7iKz3KZmynBmL9abanOVeKGhT8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090142
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

On 5/22/26 12:12 PM, Akhil P Oommen wrote:
> From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
> 
> The GPU does not throttle its speed automatically when it
> reaches high temperatures. Set up GPU cooling by throttling
> the GPU speed when it reaches 95°C.
> 
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
