Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE77D35172
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 10:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29FDB10E9E0;
	Wed,  1 Apr 2026 10:29:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kEJtIjtq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AOzNvfMQ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 671ED10EC5E
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 10:29:40 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631A9b9a1579382
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 10:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R6tUO4DuL1FdYQWwrhJaLcFQpQwrGG+29UsWyf8+zZ4=; b=kEJtIjtqVco+hFML
 /MusHuGQjDKQSc7u6luYLlPT92LcAHcy/8YHNA6b37q4c2xrhni34ket9uQi+bQ8
 Lx62UyeH2uo80OXzv7N4CXX7HBxWbTnWE/jKXYDLNTD5TW6dWmDVXFQtbNQzcKoG
 wqQ1RB5qLBl7ROp26nqNvE2AU8zjAtQEOD3+YlbmXGHWTCs5KqZIRF239+ytaHLy
 sIHtIjqNwAMqpY3ZZCot9YynOyXvdAPKWUUFkEXSsPnXcG+/4ZYTB63LtCbNbQal
 X8HAcwDD9YND/RVGhpxa0eN9Q8E5ATb0pdjDxpt/svHUcSzAY58MW+SQHrPDcrpv
 WzNo/Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8mr2u1vj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 10:29:39 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8a016b99579so11963126d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 03:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775039379; x=1775644179;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R6tUO4DuL1FdYQWwrhJaLcFQpQwrGG+29UsWyf8+zZ4=;
 b=AOzNvfMQthglPYypgJajbwKHdsRwI4Wt9tF+3rwFfO2MVSvHIi5MDq7J6z4OoaKHFD
 yaB4AvNJEDATPMg2aAz0UZB/6lszVnA8dt27cQx+0pptEJOL3/fewJv86eE76IYeWL2F
 UyYSLNOrVYzzXfqhY1fjM7yVxVCA0OEiEHf17mao8xCy9BQIb9JZDpVxeHa8FszZmvub
 L5UR8sD1faJlcJ94xJdtexp59VGPGJBvOOkRz/GqCI+L4ULurdND5kESQ7AeRWI14a0Z
 vxButL1joxPQQj3/sW3aTISmB2A7VMm1s2oo9VTHcCFhWLwcZ0jURJOnL0E/je3SHnta
 4H4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775039379; x=1775644179;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R6tUO4DuL1FdYQWwrhJaLcFQpQwrGG+29UsWyf8+zZ4=;
 b=V6mQ5L3NASTl6yFFvJ1seYCWGzswbz20FMQJuMugcGdEFjeSF7s9ryimIUYSGN/Vjq
 f/5/p7ts1yQUTOl8R3z7w5FE+r2JPPdkaQofuf9NEak+8Zgn6DF/yz987GJz4gRN7fSt
 jtP7qfUXS6JlYQxF2Twm+eHoGEJ+KeIUSxINKzM3tkYhCNySxZvjRxWtU+1X+0Y4zhPJ
 e4NyeyVM8LI6HaKQjFhDlLQtZT3qhRyaztNFY990W7oxjOm6O3k4w6WpB8ZpkvhPeLrp
 pIWoLPJuEWIn0x4zY6qTzid4cifGc+fxAEnwWDxHIDKzVVa3uzQ7k2zlxsVEg95X4L9Z
 nxSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEIpMT5F2d5RZCPAddsgJqXEPnOyzVA3ABw1cY0O/1Uwb6yLzcR7ZBcyUN7eidOBFVwuhrx0CVlD4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzE0soOadVLTBdchqb924UIQjDB/feST16xUr1f9bDRhK1nr5/Z
 h1K1Bl/Qxoe/3wbyuqy5TSAMh59s5fEHBDANOjW2YB78p2U5sBEzfe++9e3E8vJ1vL+38CouwRp
 /W/ujg5YL9lVy9/YMZWlEZAKt/6RTr9QRwTvwFXjuTfBWYfBxDpr1s1IvGujJ9ysdyJ1dAy0=
X-Gm-Gg: ATEYQzzczAhI/eMRm30by/eLudcaRJLupgY+WnbDAVAhfoNLuC10PqmCNU0HZB9AYMA
 tdBTosZEcfXyXoMK3Hl00rh3XUnTTPllIdKX0UMUXE/pFwkTD7I7Cw9YD45oRdzTK/qc8U9JcKZ
 AdpXBSXOgNMOOLUpJUA3SrUnFbXmVY81q6cg8BhaoyPBKVFjT/eo/OkKmvwAHsbc9sPuC6rEf8q
 lGm1enrMSEDtVIhI73eFGTLVZgBAKMw9KYIH5Ao5T2hz0PGflqxR/FLaXb9JEYyMDWskG2zyQId
 Ux4QSqgUENt7qy/6cEPOymGEQ3UWhz3D9af04LMll7tbHpcaRIuGDrRcbAELVAGbzlDs0m+074l
 /2swinbNA/XHk3Sxvv4k1rfxW4FOuBzbOdi4C5D9L96dyHlEehf5Ir6C9XNjWFgwfXklpEgo3Ny
 wACKU=
X-Received: by 2002:ad4:5f0e:0:b0:89c:ec59:87d1 with SMTP id
 6a1803df08f44-8a437212308mr35873076d6.1.1775039378905; 
 Wed, 01 Apr 2026 03:29:38 -0700 (PDT)
X-Received: by 2002:ad4:5f0e:0:b0:89c:ec59:87d1 with SMTP id
 6a1803df08f44-8a437212308mr35872786d6.1.1775039378350; 
 Wed, 01 Apr 2026 03:29:38 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b7b1a5fb3sm514146666b.31.2026.04.01.03.29.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 03:29:37 -0700 (PDT)
Message-ID: <184e73fd-f849-460e-8c9b-e112dba138c2@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 12:29:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm64: dts: qcom: milos: Add Adreno 810 GPU and GMU
 nodes
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
References: <20260331-adreno-810-v1-0-725801dbb12b@pm.me>
 <20260331-adreno-810-v1-6-725801dbb12b@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260331-adreno-810-v1-6-725801dbb12b@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=B+O0EetM c=1 sm=1 tr=0 ts=69ccf393 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=mgqdMpuNiQTOyL4mY6MA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: ovpKF29GPVR8hp6mrdIhMRLwOWGvquvl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA5NSBTYWx0ZWRfX5Hgk76lJZLoD
 SNrbmnWg46DvnfrclKIJrSbowoqlPunpCTZ+xdUq9z/jEzCnLfHz/WAGXq9Y7nc4hwaJns5g65B
 9WVVV7dXSCjEy3vIxydcGIDp9DdzmGQ0g16EtpwwQsWwwLla7zLLtPf15G8JWiIxOtAQcfD2n8p
 TTTBKPM0UlIDP3xkPQL/wvls9pL01FC4r5k81wupeEdOnsm541woxu7aD0Zf3zn44CcfG20csyS
 zD5cxxRZuRUxn13cHcoYiGwi6XgPvl9kc6iURN5fsVBWJUVNgJV1cj8enEvyk+6kYgjhkNYGGDU
 3JhXBb7h6dQoQUGmqgeqbO/9leF+67v3U8Xdrbwd/TRs4msL7FwKcBlD3PiBBMdQyu6yKXsYbqn
 as9J/tp2zhv4pJjBLBbqQncNrVlXHPndiSr+2eHeKO5IqH8+o6EhTU7xBG1eKrkf6EKt1ilE/Er
 uzAQvYy5GGwEZOZdCtg==
X-Proofpoint-GUID: ovpKF29GPVR8hp6mrdIhMRLwOWGvquvl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010095
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

On 4/1/26 4:17 AM, Alexander Koskovich wrote:
> Add GPU and GMU devicetree nodes for the Adreno 810 GPU found on
> Qualcomm SM7635 (Milos) based devices.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
