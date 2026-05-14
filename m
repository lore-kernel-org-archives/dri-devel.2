Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D53DCD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 12:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B144410F1AD;
	Thu, 14 May 2026 12:37:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o6BClnKN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TaEI66MO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1EBA10F1A8
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 12:37:05 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBeqSF2261920
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 12:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 B+8jz1452moL9rt0kxt71VhJYhsqDj3vIbzLL2VrkF8=; b=o6BClnKN8yNiDEuw
 15R/KC3bxZmX/hC1mXf1z8Dh5s6PM4cmyZrMI4iFZdld2n/t/5ip0XnoJe7IK0GX
 /Ped4LO/MlD30gfNsw3sartjimlpcsF4riH0Ci+x5i609eZ2gLU/7gzp6XqdrY12
 OhZcHgp99BhB8V3uf5PZJUXiUzlKJrJocWX6yVIIXBOatCb49LMnlNL76iv/n+WR
 V8URCkO75sWKLzekMwaXkX/zuA62A5SJm+AWg+JvagfgMIfH7xFoyVQ1X2UOw0NT
 gVZ+lm8GbvFZ9q/n31hEYFfyMkV371Op1xqqTgnwDHV7Kt5VMeMAk2fo4zTYT4NH
 zJf+Qw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e563hht8a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 12:37:05 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-63126f42441so548023137.3
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 05:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778762224; x=1779367024;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B+8jz1452moL9rt0kxt71VhJYhsqDj3vIbzLL2VrkF8=;
 b=TaEI66MOxk4wHhtXPHc84roNyBsS54/4qg9gmLtSNfc8hqrwAf04G3EqoSHpxTTMr9
 GvpbcVPol+6XKyKr5weLyohDT9XCF092iUYLxSAHFpIZbUtlN/++hZa9NHtutV32tbUr
 EWohehvRNZ2rh2GndR5N4J8uMEAbBtqn+SGMh39K8krXE9VQxug5zp+Zlt4IpArFHAkX
 DDGkVGbpC9fdkANaaFayQ+v7HnUeBvah0TzOIu6HFaNd1SxrAtwIpzpM6YfkXOCUwT9f
 uXoCpVQjKVj4ynxgP7OZJea07chYOZQlCaLxfkpkXZOkVlF9gjc4B3FhozriIaK92987
 tJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778762224; x=1779367024;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B+8jz1452moL9rt0kxt71VhJYhsqDj3vIbzLL2VrkF8=;
 b=ELsP4+OHme0CTKW0+kdEim5wNuz68Kf2SYdqWoH323hr5PaTdVzv/Nh2XsG3myrECZ
 PmwzW9lH3LtOfkG9IzVHvqUL7TngrsbsNfYmf2H2Ks9H2nUksVMV+JG/5cuXerD4ccU9
 Sw/PIdVtYqDba/M+YlJanyd4U1OYxLoeQTk7iE8rUJhtLKEcVgpRgicbjaXlWQsSoHH6
 i5RmWfqMMttWEksvTDVo2q8mG4pfRhH1vlZbcGDfyVC7PC+N5T4VGTySMRwm/lVERLI3
 yoz3ZyT42ES1rO866fdMEW8nnhQJTSWvICbsvta6YqRYEpXXwWxoGbUpGe4ex4qZQi+/
 m53g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MZG4bBG74tqvv1+JBHnqaCy4gxE6Qd887VJN6J2mgQvSdr68R3OXH3nAriWOxqCPihNyDKGrqPqU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOZrVRZ/X5v+sbV2BjWCA7k+RL3jnMBwng7X7MQkng2FJgtKDp
 1Jd3rP6VEESxmNm8Muy5oW6W3Aw1A7N7DmiMBTtZQ6+/KrPFYk9tWUyywlNoeNHdsxZs38Mq2N9
 9GacBw+eGYhOwZQv+aYHxCE+5geKKwQWOwB4iEfKLTAemSOCY/ovdlcv9azOITmiho8sYsKE=
X-Gm-Gg: Acq92OHv15Q8+nrWBkVg72geNomcgw78Tzi0xoOnLg3B75MBmQzHRS95w0abp828FpB
 nJaDVVb3nalUZShZflp19Y1pY+qjVKURsJQFS2LEhW96VOCwgDcM29PtHDeAKDNHsTe2T0aZmki
 VW5vxY101uzCbWPVXrcCGKwlBQ0LuBgvjxqHM0yioePzAvor1LREtlyGvg7Iz0yUyRjY9VUS4iO
 gMCDhfFzCGRu09d4IfS5n1jo0MGgRMN3ZVXsssn2K1uqYziVd3JdNq0scsH9mzUPJVa9RgUir8g
 vtbPDO1GO2qMKAoFg+zPdhxgNPAqTHGBGwVd1WXDMuAaQ5MdXyowpKdsX0vDl6l/nvRr/W/eaXk
 wYDsspYdP9Ynk/yXAO2IDSuD5ALjqqTawSK/l4eFTdWYFDOfovAFLnFkrTCmfXnvw9xUy8fqy0l
 YG1uU=
X-Received: by 2002:a05:6102:1150:b0:637:30f8:5cd5 with SMTP id
 ada2fe7eead31-6377667b9efmr1125950137.8.1778762224447; 
 Thu, 14 May 2026 05:37:04 -0700 (PDT)
X-Received: by 2002:a05:6102:1150:b0:637:30f8:5cd5 with SMTP id
 ada2fe7eead31-6377667b9efmr1125947137.8.1778762224031; 
 Thu, 14 May 2026 05:37:04 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bd4f4bd1124sm84302766b.1.2026.05.14.05.37.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 05:37:03 -0700 (PDT)
Message-ID: <6efb980a-1d88-4d22-9ed3-1cb420317b71@oss.qualcomm.com>
Date: Thu, 14 May 2026 14:36:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] arm64: dts: qcom: kaanapali-mtp: Enable GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-7-13e1c07c2050@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260512-kaana-gpu-dt-v1-7-13e1c07c2050@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: WxXt1ijjKpfEyXRJgfwOSrqrH7_haW_D
X-Proofpoint-ORIG-GUID: WxXt1ijjKpfEyXRJgfwOSrqrH7_haW_D
X-Authority-Analysis: v=2.4 cv=DewnbPtW c=1 sm=1 tr=0 ts=6a05c1f1 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=OwxjEWw48HTU6ZCEJDcA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDEyNiBTYWx0ZWRfX+aLmzmX1JuFW
 itkmbLDyy2jpTsNUgVG2C3wcs+2CAci6vBx02onP8PC5b2r7+e5wAlewgBM4uCQLoZ6wonTLYb7
 QaTJ5UdG7mnDk8IdmoBBAaLwfiI/pKBVi3nHcslkPKJTAzgDXDaSTmjNOXTxXExOD1nFVT1snrs
 rUUSw2sZmoXvXc2EtYcfXKHwzigcyW/xWDsGBSK1w3M+0HUg5YhN9isguurlMzG+pZw2v2+xnKS
 cb1+CjofGnGWblSm9hfTxhOm6xi2PxjQwJgXNLFm/joCXyRZN8wYT1t6B2+Pd3UEZ0r6/zdTNBj
 4UQiD8avBxuh5XQnDaI/ZvI9znW29CJTUxg/d0lupBPaaIQGA7aOBevMR354+DkSLOtnHBA6AF6
 u+3WExwVx2Bnw5idLfxpye9izkmFW4I5IzTN3TuZz5juvpug9a13Qc2LDxuWRUpIikPq6rZiqxl
 mvXiObmFIjboLmgT62g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140126
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

On 5/12/26 12:23 AM, Akhil P Oommen wrote:
> Add the secure firmware name property and enable GPU support on
> Kaanapali MTP device.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
