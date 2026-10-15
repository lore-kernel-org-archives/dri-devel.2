Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A15CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4407B10EBF1;
	Thu, 15 Oct 2026 13:32:25 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC5D410EBEA
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 13:32:14 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9jW0O2416945
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 13:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rdX3QCLTENQF6a7iOoH7LlhHEJoWPHuhiEjvLDq2Jqc=; b=K3EH3fVrt6zpt/ia
 QI5oUNZmUKUO+aT6h5z4UgtvU3WpGypovVVxPUzvwY5IXB3hMZS/vr1WmQ/81456
 3oD0AgqVqRx3P+OeKrNVcnjzWXE4fusAuaFgpTMQTQa+rkIV+hc41y/v2axMua0g
 6vF0+4lCQjo88A3Pqjq6EITsRr6yN/Tx6/v7TnXBPK0/3R9ZFI/8FFrBs5scWShI
 hc9+7Nd/olymOyKpWisS+hRqbThjdIZYEx2uWX3IJzG0Qy36++TdYXWBh5lxsx76
 9o3IQqxAuCFCJ8rd8bOqS/vj07tZQujr/mATkQ7xHIbQ6+v0e5l7xveezN3Ntt/B
 vmTyDA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdhja7t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 13:32:14 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5e915fd8a61so128041e0c.3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 06:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792071133; x=1792675933;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rdX3QCLTENQF6a7iOoH7LlhHEJoWPHuhiEjvLDq2Jqc=;
 b=E9VROTD5+hAQavL1a7fIx0Np35A2/9GwQe9CcsMzAkMk6h22fAA3awftKPSl9F4me0
 ozh+4/eYbP48Y/uWYL32UpsLR1QpYPSXcSIDRkJT7eyMzWfLVfcnKigqt+zkGeWmIQ6T
 sYjes0S54k9AtB25QPjzwZtQj1ImhuTiuwZk7OsKpwLoxS5Ek41m4paWFVOwRVE60Cez
 K8uO5z0aVbgqVe4C4cR38aapN3IpBBu+WwyXw3NRMaYF8l3xaRftJVUyFr2XZwE+hCSF
 zwLf0p6B50Y5E+GkgvndfIKOaUPa3DtZ8W5dNOukuFFnGffjCIujAROS8v/dj5tkDigO
 ZarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792071133; x=1792675933;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rdX3QCLTENQF6a7iOoH7LlhHEJoWPHuhiEjvLDq2Jqc=;
 b=nZViDRO1gK8tWZF12aAwyG9X3qVP9bzMRiEdLqNJklLEYDAcx2161vYQsZJ8R/ihue
 Ma1SmN69zqs3QPMoGISRcI7Kn4FnFYgn4iN4QcF3mEt7G8Ign4JUUsRSTVS8EfAzeB3e
 GsgUJYXMEBbIrMN0zjPESYYDD4xoB0Qkp9TGkJmBHJ5ophqX7vldAKR3D4ZStEGK7XZG
 P3oY7ELukJF322utDuyBBNW9Nej2ocqWNPcQf3FZMS85m6/d3U/D2ov5mepptb88a2LV
 lXmq7AGMFBK32yBtigJQqQam3khX7SELEsXhH2QD4BUxYCyP+rMqZTqnREBFQGzjIvHE
 ZQVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlPoYlcGXdX99BCV06pJ73NJWOCsdTLDjugtrS140P4P/iFlxtfr+mkKY5z5Unfu+2MOeAkM+shjw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKEoDzbd/iSrw+gCX9ph3PaWRbweavQGXzrQiUdoeL6PaUvaInT
 z+IxQpbUZPAIqXkTtir9CGRpRNGUgx+1rAppz+upMo0KUc3iUbdTf57ZcUFdZKwvWDYw5er5+Nl
 OoK2hlOPpCsO0h7nbz7pvMvDKdmA1MxpoA7ZhG5jVkWSIEYPQ/ki31WsUAKcE457NjoX3UtY=
X-Gm-Gg: AYBFou2nK2egx7+iAuB9jglBHd4fj6KmcsldMaCP+s3sWVfWvIGBBCwTqWTcACYJkJN
 f0fHeLxZ9SADL/NLYip1MALLt91N5GcWb4wENK/NjOcwQiKergKYAk2ZIuG60gDrt0zjUHVj5jK
 Z56j0nnCr325FDFCWWX+0pG3O1mb/EP9v2rm+38JUOMkPuvN/5ZbCnwOm6O6l/YMTSjUiglgMwD
 KK+49MsQ0K28U3OMFfWcnuVySBvYvYsy18dkxpXIRSlXQp7vWIyHqnTgN786jE6pcJDap07p6wz
 y/MR8t6P9H8JZJ45xty7x0vNuHEUNYBaKNw3ewgRI/ek9uXwA/bYXY+CulKcbOgQFAIbJX4xef1
 tPsXfLzOO0948nDVz9iuyaw==
X-Received: by 2002:a05:6122:6990:b0:5e9:2e3c:2f5 with SMTP id
 71dfb90a1353d-5e92e3c09b0mr5140649e0c.2.1792071131532; 
 Thu, 15 Oct 2026 06:32:11 -0700 (PDT)
X-Received: by 2002:a05:6122:6990:b0:5e9:2e3c:2f5 with SMTP id
 71dfb90a1353d-5e92e3c09b0mr5140566e0c.2.1792071130738; 
 Thu, 15 Oct 2026 06:32:10 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c3ed6be6ddasm129094766b.7.2026.10.15.06.32.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 06:32:07 -0700 (PDT)
Message-ID: <65f6883d-8ead-4c6e-80f5-81f6857df0b8@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 15:32:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: arm: qcom: Document Microsoft Surface
 Laptop 8th Edition
To: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Maximilian Luz
 <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
 <20261006-mahua-surface-laptop-v1-1-406fc042162a@oss.qualcomm.com>
 <245e5eef-e18a-4ec5-b57c-65e561101351@oss.qualcomm.com>
 <52adff3a-370c-4445-9797-e0b0dde36fab@oss.qualcomm.com>
 <5568fd0f-e412-4f2a-9f1e-729a469da572@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <5568fd0f-e412-4f2a-9f1e-729a469da572@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MyBTYWx0ZWRfXyKE3A2E8Dvd8
 OxXxefn2yy5LZiwPc38P8pzUbtcbAGsGA3UmjKEqTufhsta7XRBx+W8DSRrNERMClQ+y4bAwqa1
 xfNXY5igoPdQwJ8CTwpy0E32c6JLw22ZQFqqYr15t23UqEIxtSMxKOKCLcamjiXltEtToQBw6j6
 znkDMnV14mzYUtY0TVOOD0Ch+qBMms4+PyMO5fh7ngsb0a01AbRtdgA7ZN8UMkl66LPXdZqsvmQ
 lUXHsEHV0pz/c1aP0Q98jf3nSDU6/BhQ5ToPZdLrEjYo0SNvQ0aulMYeO2ToBRW/tsFe8mXP3Ef
 hsDQyhQu0hAtjIHKItDqeveGl1cCaZ8tDhSXgyDtaRVoa4PNDgDfkN7khvZKiMOdhcF1RUQF+99
 8AF4go6Bj62J8rXEIzq5DopboEReMYqMVJXPdqNZ7xsq89SLel/TzmkBLX5PYLuvUpQPfkR0zfZ
 pe9NCAQR3uwY0Yg6XGw==
X-Proofpoint-GUID: K6WYDeIu51lrVybPwFsmYXCizpaq3zEL
X-Authority-Analysis: v=2.4 cv=DeeCOftW c=1 sm=1 tr=0 ts=6ad0d5de cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=8k6WQxmsAAAA:8 a=4wGxsJ_OTqgDEiZx6fMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MyBTYWx0ZWRfX6YiXuao0JywW
 Mr/wZEvP7CTCsiiqesW0ANiA2P+dMkLoCwvn54alg/HrlioeSqYevcpobJuqjflmskET2E70QT4
 ow+wP+PGOnEBKKNn0hS6kt7N9TyuGU8=
X-Proofpoint-ORIG-GUID: K6WYDeIu51lrVybPwFsmYXCizpaq3zEL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150053
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

On 10/15/26 2:47 PM, Gopikrishna Garmidi wrote:
> Hi Konrad,
> 
> On 10/13/2026 2:09 PM, Konrad Dybcio wrote:
>> On 10/7/26 9:11 AM, Gopikrishna Garmidi wrote:
>>>
>>>
>>> On 10/6/2026 3:20 PM, Gopikrishna Garmidi wrote:
>>>> Document the Mahua-based Microsoft Surface Laptop 13.8" 8th Edition.
>>>>
>>>> Signed-off-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
>>>> ---

[...]


> Thanks for checking. The only matches I see are in the MPTF thermal
> package, which ships"883ROT13Inch.bin" and "883ROT15Inch.bin". Nothing
> else mentions ROT.
> 
> I also checked all the ACPI tables but didn't find a codename there.
> The tables are here:
> 
>   https://github.com/aarch64-laptops/build/pull/176
> 
> Following the Lenovo gen8 naming, would something like
> "microsoft,surface-laptop-gen8-13p8in"
> (mahua-microsoft-surface-laptop-gen8-13p8in.dts) work? I'm open to
> whatever you and Krzysztof prefer.

FWIW the "gen" naming comes directly from Lenovo's product name,
i.e. if you go on lenovo.com it says "ThinkPad T14s Gen 7".

Konrad
