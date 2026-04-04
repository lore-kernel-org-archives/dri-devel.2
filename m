Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DF1E63FF9
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 22:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F070F10E15F;
	Sat,  4 Apr 2026 22:04:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fQc6ojR0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FFLmc1Wj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A722810E160
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 22:04:10 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 634LI81W789250
 for <dri-devel@lists.freedesktop.org>; Sat, 4 Apr 2026 22:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fMtC8gnkL45PHMz0CqL4xQiV
 V4b9ZWUXoORtR6sfzss=; b=fQc6ojR05j7kLyT6jQFtg3gnsfHZ+OVDYLfC41gi
 ssCRtdAN2E1lIAL/tmjxFgu7qT+7npY3OQouTMOwGEhFvdZPOKqg0Qvw7HPtPZy6
 g0sX9LG15RxbB7bMLr7K2HnfmJPoDcaGWPuc1AwnoGvJWEAHlM3OjPEyI7CKKlxM
 GsnH7zI7hvz6stn9W0utDfRbUDpY/2VN3ffeiKpbqftcS9Nkv0rt0PQmTiEf2hq4
 J6J1iDe9xHqRImb5Ikm7vtPHq55Zs/HkOMoMx5MgMu4GvNxDw+VwnyzFel6S+EJj
 tm4uVzv7HyacCNlj5VcKytFq+FW6Tij2iUy7KkSoTODxYA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dauth9fc2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 22:04:10 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89fa878662bso140415906d6.2
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 15:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775340249; x=1775945049;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fMtC8gnkL45PHMz0CqL4xQiVV4b9ZWUXoORtR6sfzss=;
 b=FFLmc1WjFScD/TSDU7m0VkH64BMscL0L8RYUh9JZAtpjb2VVt1LEOQSOSZ/B8f4Bg9
 Tp1jFcE1++Mket0LmpNBWuvvXB0Xi3/GYIRTmmEuUfWSoTCob+QDTfv/DkHszxsE9XfV
 4mLeaoAcGh2XlC9kv/rG1Eey2186iDfenj1nu1dMfvV1Art7m71uXVnGHYc85+JtYhxi
 MhfpjWtF2ApSVTiO+cR95dp3xe5BQtE3mfcY+DvnaUShO7VVMJSjb6BUi6B3EgQ+HiVh
 /DvArP9M9mwYFYD+qODMjvXSnZXpJdyM6V0HIW0Ax/zCxqc7U1lOjboQWTKCU2QNk+Ww
 ViVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775340249; x=1775945049;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fMtC8gnkL45PHMz0CqL4xQiVV4b9ZWUXoORtR6sfzss=;
 b=Yf/pI8lvUnd+dE9hoTwSrKS2QQojZLV7DU9SVuXRHuv8FgD60hHxq32ovSymUm0bzJ
 i23+YKPNpdx0tCUtIoDfCqzPgyi9ezgsMoTuDZTw91m01/YXqirKspFqMg/rqMi9qGB/
 nY4w1SZd7pe+g2uvDVEMSOo9d6toH9t8qYtfwE0evV5fRQMZa2ANHHE1wYsj8hsgtM88
 HivpWeW3tN+tU1ry9n6ll87zr0rYERtcx5RCGKHuUuw8iKZ/Qtp5JiwWePHmHUWx34el
 2pkW8UzNvUHbvb+hC/NY0Zn1owa+XYRP40lKxaIPs+Nl+GvvKgQKPpYgYegDPPmJhL+J
 qGMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyFPNUGr46rAMOEcEdg7g5MqZ2hLBv6INEqLxjyUycRi6a84MbtXhZsVxpL4EEjh3ON0m23sZ5WSM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAQRP0a29OshsyWNAiWl1P295PMkRSe8iWpaxf1sp622l+QO5c
 zCUzfzqZNCxCjAN42aPGn69xlVzyEX3HwNAmaICXm9ZL4/mdIppXgnQLun1OG73tWI60H+PbdZy
 O5dSKyxZQog5MmYAcV3A6zo38qwXxrFLOLsD9RdnhT5f2mIOhkJR7chyFIXbHWuykyk3swtY=
X-Gm-Gg: AeBDievRyVw94zqFQDKG6qdfsd1aGyR9VU/6g8/quC3ERqtaKEFBswGPBsxSHrikrPX
 2yehFn3BKaTQLO5avOT9jieRZt+e6I0qSPWpf8D2jxmFmepgm7HptEFrllHizS0P0ysIDIqvICl
 CdpEwi35306yrIysycqcrUeiqSOLAW9wSsr4bVCbvmpZT7/1fLv53h1BObPQ1FGdzQIhTjsPJyw
 4UnSljeUpELF1Mb7ZKQ7bwEIgoQOgpWHr8Pu5TSsLlBv80hRsA9G14BVVMh1HVGgCcVrdibRx2u
 yuG9gDHFMLQIFI7fmlmkq3hWZJ1WfI8Kzq5AbzA0LmSTlDv7G95qiKpreTzqbWRwstMcA5MO6iS
 h3hS+4QzHmKejTFP3uhY0b41RVPRQZRwhXX9JE/APOszCVttSLnQmOSt9KC8qgBFtqof+CBSknv
 5zzcPLvZOfq8ISX4N9uwjeSXktZDBf2YMcbMM=
X-Received: by 2002:a05:6214:f2f:b0:899:fab4:730f with SMTP id
 6a1803df08f44-8a704bb7389mr131489236d6.49.1775340249067; 
 Sat, 04 Apr 2026 15:04:09 -0700 (PDT)
X-Received: by 2002:a05:6214:f2f:b0:899:fab4:730f with SMTP id
 6a1803df08f44-8a704bb7389mr131488686d6.49.1775340248618; 
 Sat, 04 Apr 2026 15:04:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cd1fdd208sm23015631fa.12.2026.04.04.15.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 15:04:06 -0700 (PDT)
Date: Sun, 5 Apr 2026 01:04:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/7] dt-bindings: display/msm: dp-controller: Allow DAI
 on SM8650
Message-ID: <ozofiq5dwk7luisfa6a4e4wbqw4vuvcs2h463hqxt7uee4aod3@j7aslgp4hkn3>
References: <20260402-dts-qcom-display-regs-v1-0-daa54ab448a3@oss.qualcomm.com>
 <20260402-dts-qcom-display-regs-v1-2-daa54ab448a3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-dts-qcom-display-regs-v1-2-daa54ab448a3@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDIxMCBTYWx0ZWRfX7yE9CTw4pdH/
 LmwxpDk+QbK2JqkrHkcH0n6ErH8KVZ4Ic5CINKawOQB9n7zPvU8AQRjOCcnoRh6pFiiSEI5ddmM
 HF9+61Gz0uiBSbiE4fhlvQ7ydmMbAyq7449+R8QOQ3TbZL+RcWUFCUTuYpt88/z93fto3uCi5+j
 oCuki9cgt5GSx5Mesn3pgt0IUJuE4B5PN0nXkBTZnpUffeoItOzZbPOiQIaFKtc5igdHHwVuQUm
 u8hSlh541woQ0DSX6MhKTL3ZetzbU56LJwkLPmTvxw0b4k0hXe8nmWgb+OSclHuN4Uo6n1qcxLR
 zPhCUjFRZR+UuGMDXFlOIB4kV/9jAOH+/GljwZ9EepIIWZCnzEWLJ+diZfhyNT2WmW+GkPIDYs/
 Oh4ByFCraliUi2Czbd5vckytPFgAD8qHEKEs8IB4xeC82pQgQyJHxrC4bjJg8Z6KzsDF5NCZp72
 tRLzUpn9a1gDm3e953A==
X-Proofpoint-GUID: cgyWZx2Kkrl6Jfroab4ZD-xf3o_oM-Yq
X-Authority-Analysis: v=2.4 cv=MIptWcZl c=1 sm=1 tr=0 ts=69d18ada cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=RWX2ZFlerEUOqWKuYikA:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: cgyWZx2Kkrl6Jfroab4ZD-xf3o_oM-Yq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604040210
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

On Thu, Apr 02, 2026 at 01:45:13PM +0200, Krzysztof Kozlowski wrote:
> DisplayPort on Qualcomm SM8650 (and compatible SM8750) supports audio
> and there is DTS already having cells and sound-name-prefix.  Add SM8650
> to the list of SoCs referencing the dai-common.yaml schema to solve
> dtbs_check warnings like:
> 
>   sm8650-hdk-display-card-rear-camera-card.dtb:
>     displayport-controller@af54000 (qcom,sm8650-dp): Unevaluated properties are not allowed ('sound-name-prefix' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index e4f17d29343b..f8daaee8d065 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -210,6 +210,7 @@ allOf:
>                enum:
>                  - qcom,glymur-dp
>                  - qcom,sa8775p-dp
> +                - qcom,sm8650-dp
>                  - qcom,x1e80100-dp
>        then:
>          $ref: /schemas/sound/dai-common.yaml#

This clause is for the platforms which can work either with the eDP
(aux-bus) or DP (sound-dai-cells) setup. Instead please extend the else
clause to $ref dai-common.yaml.

> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry
