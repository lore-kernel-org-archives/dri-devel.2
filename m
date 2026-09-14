Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1F0C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:06:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2436210EBE1;
	Mon, 14 Sep 2026 08:06:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SAqur3NJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JwVJdgBu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2877910EBF2
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:06:07 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E5j0bx3369463
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W0XjNnKxrhdkJEO1lOyERnjUwOJSfzdDQ+y6uKaxrfQ=; b=SAqur3NJjAHajSPz
 p71yL37AMtj7uRBHbsiM4yYkQgW26WJdrDHYpDLv/j7qZ20ul5WIE3ANCKxg5bl2
 pPSN0Bqdgo8Kyrk8uMEFIhqdPgAIT4uIYBLgnrvmo9cjmjO0fgR68gEj9d6IxRHj
 LH1AkNcOH3X3UygpIymjPAbl1DbsW2GwepQFj5hWY00HOIJCa1d3imAPPt5VnfHC
 c3JDmJE18TwZkMlPeXpmxHE/wZxsfSQzXbR1OMlitglBKBvW3of1qeGqjbHgYWlr
 wLHsPLoEJlUSMtu7AFwX9pYgF/gI78hLk9lpUxGfvDOYZ6BVn4Ig5CKrA6fHmQsa
 liGQEQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmygd5nt0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:06:06 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-53103416ef6so2580791cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 01:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789373165; x=1789977965;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=W0XjNnKxrhdkJEO1lOyERnjUwOJSfzdDQ+y6uKaxrfQ=;
 b=JwVJdgBuzmZoMA+FCYTydeFOuUi1hXqhYaPC20dA4SUIOdV4Pblp7AuMPK1NteUbv6
 j3BNr27fic0OMeTJ9elqS03F3PCHogIOM3hX/zXl7HvIjNb2TZq+L7m7xh5bWMYO/CVw
 DkKo8ngBTGcrrFSXK5YhqCWDf9vEIO0bAt6bDKzMwSgqpuU3CKwZJWzUt0owRkW4z8AC
 BCLftk+t0lhI5LCGW+gUhYxmrtFmlgu5ZRSRxnvaSEAMBH4qWEqh2v4BSxhs2lYdmoAC
 maI0DaLO9sQt6z04at2Jo1Id/lF80RriBrTg0OH8XmEISSaUTybwm1lMiEjaLk2Odqy8
 MGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789373165; x=1789977965;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W0XjNnKxrhdkJEO1lOyERnjUwOJSfzdDQ+y6uKaxrfQ=;
 b=jLta0/IK3aXLXJGUxZKWsvJguIzh7elYF5gHGqshS+v3kV7UpJ5cYepoQ+sWU4L+JE
 m92ydbvl4m+7rKWDLNQ2GvdeIfBr2Lq/Rd+/Dice7xUCsR9Lr5OVNmepgnGJaMZFcMXj
 XJ3IBAUmM9+/yq3vhaOxSGqeIsKxhw+2MX/j5MDebtQBd2yBgP0OV5fcNeXt3AcPyCLe
 Bop91ci4TLbTapiZe5NK6zMqEBytFVJXIGuHfpMdgAxXXATDvnWn8chkglCBk+xJ6MYn
 SHpwx6UHa6Knq2m6uZiyWf5rtmRX4fcN9pZPEG7diCeP90CAQWCfNGf1Dj1/LSwXgaMg
 ErnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxy+RQ0MKNso7jUM51o67MGYODrCXUSUOhIlBptVA4C1r28Hoe4OxKE1SMcXHvRTusq0yo+bb+Y74Q=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kUsWMDosVtBYozSVcaHtay+NKTU8GhTafPYdby8yYyXzAqAelz
 PT1BvwkonaBo+R8DbI0uY0fBTDneJVwVD2IJQkRYCz55KwSXXu5/mbXLBWLjynngDWOeVXghz7N
 mOhk+MiJdXSW0NzIztY3gEpTdZ+zUA+ydZHMkoHzO5YtNlei2SiZTlKRnq6gLxeHPjBMhX0w=
X-Gm-Gg: AYBFou30E88/mvA7quSmr+sq63XODEtwWLKn7ltUUEAe+Zq5qD8i0SgXZn2yF8jVsm0
 PTFCvqslNy+FVG38nI+Oj9aY6ZIiWsR8zucgttz5tsUyrtqb5pZtYi7aw4uH+OnFoIiXCQHfKHO
 M9MJOL1JDXFP7AEiXU5nF5VZ0Yaw43xIwklTQTAF4dbuEfMEwE0jb7nSHSixo+YX4jN4CT1KEOW
 ZVM8B3AKUGVKEJccaIBrr52sUcg1QrtSoLSHZitTNq+kfd3P+rY89EwoZLLWJgga3TSDwXhwQqZ
 Po3ck6b2KzmFLdtl4h/+FHg5AbEMWZEA5rcgxru5vIm4wON/Q7QMxMQM+AFleTh38O6ha0IGac4
 1tR1HQoDPaYmdUvpzK0TtSQ==
X-Received: by 2002:a05:6214:4307:b0:912:1333:e04f with SMTP id
 6a1803df08f44-9122e149532mr19325946d6.0.1789373165622; 
 Mon, 14 Sep 2026 01:06:05 -0700 (PDT)
X-Received: by 2002:a05:6214:4307:b0:912:1333:e04f with SMTP id
 6a1803df08f44-9122e149532mr19325476d6.0.1789373165021; 
 Mon, 14 Sep 2026 01:06:05 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a9b5831187sm3844483a12.1.2026.09.14.01.06.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 01:06:04 -0700 (PDT)
Message-ID: <126833f7-236a-4338-ba24-e4c56155c71d@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 10:06:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] drm/msm/dpu: Add support for DPU 12.1 on Nord
To: Nabige Aala <nabige.aala@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-4-e25c073cf1b6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260911-nord-drv-dt-v1-4-e25c073cf1b6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RY0FmFtv c=1 sm=1 tr=0 ts=6aa7aaee cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=tJERSlHITJMJguJ_9RQA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDExNCBTYWx0ZWRfX0CnoULrZnR/v
 bJLW84trsbqeLIfZWUTWWN18NQVglJ1YoA6oA2Km9FY7Oo6VrQLEnJT1IBVEB6EVAqf5pIuGIfm
 rY0z2biuyg9JYe0TN7t8lqpntRJEoYlibAKGZV5Ls7ASQ/H12odumeq9sQ61m7FUSvCMhK8evMR
 uapQ00Ze8R4lIsXOgoqfi8hQvuh07M/YK1d8afoDR6uvLZYhsPBPkYWe42M/Lk0tHKZ59pH1dJe
 NG9gsVJ0LaRtg0kxJfHIS0WmcsZNyjvJebgh1m5DVCGQ/rXuBeTBjhd0O0tKFpT+2jQicCRg1yJ
 1/lqSg2l/7OHberqOvQYkWwO4grkOU1pOJR9qYcZNQi6rHO5gyb8jIuJIj+gmFxSLZZFlXjoZFD
 g395pTkgZmcm1o5K3q8c2h96YWAIGnnDc0UDxt7CfCPKd6l83FJEVyah6XxJA1JGtcqt95fuTVL
 +AhC6mIQLN0bRIk4vxA==
X-Proofpoint-ORIG-GUID: wWnXjTIgxI3PRgxQozxDYA8R8NV1e5o-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDExNCBTYWx0ZWRfX7jBJMUoifpQR
 dB/6tC1L8ePHcKhvtqm2Wld8CUevyrp9ncBcYG73esc+hmjbA1YNqS0sDP4TNvES5YPbiw7K4bK
 neUGL+Utq46ZAW7anayo6j+Ag7AnWEY=
X-Proofpoint-GUID: wWnXjTIgxI3PRgxQozxDYA8R8NV1e5o-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140114
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

On 9/11/26 5:36 PM, Nabige Aala wrote:
> From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> 
> Add the DPU catalog entry for the Qualcomm Nord SoC (MDSS 12.1, DPU
> 1499A). Nord is DP-only with no DSI, and provides 8 DSPP blocks, 2
> writeback blocks, 8 interfaces and 2 DP controllers.
> 
> Extend enum dpu_intf with INTF_9 and INTF_10, which Nord is the first
> platform to use.
> 
> Note: register addresses and xin_id values in the catalog are borrowed
> from sm8750 and precedent platforms and are marked with FIXME(REG_ADDR)
> and FIXME(XIU_MAP); they need verification against a real Nord register
> map before production use.
> 
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---

Please remember to mark AI-assisted contributions as such, if
that was the case..

Documentation/process/coding-assistants.rst
Documentation/process/submitting-patches.rst

Konrad
