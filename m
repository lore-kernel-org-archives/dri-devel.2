Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84762C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 22:50:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87D7210E3FA;
	Sun, 28 Jun 2026 22:50:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TNgb6CGJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iE4MUCZf";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CF6710E3FA
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 22:50:01 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65SMAOOh957846
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 22:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=JYOeB9wXREvb/kPXlH/uSBNj
 P/9Wet3bk3Yudk2xHjY=; b=TNgb6CGJ1Q0zM/RkqqlO050O65PgXwERKDt8KdQH
 HG2zEfeMv9xdcLl4NAknubrRRPHSLUzNmEP9U6pqJ95hCaHPyjibqiXsSKOo5sbL
 cGdaN+Z4bq+WYnT/zT3immPtN4qTYkqW/luUFJJQ3kBb3rSfgGL9X8uEtX7UaNJF
 zAzt4+8XMg/2tFwVnZaqyq6WgnbNRvf928hV1p0g45fP/Xaf9+nty0xC0UdVtEQP
 xi2MX8a+zibiz7K82RGUnvX/LoVPSeQFvhzoQExiVTCFc5uI1Yq8c9luG6lcyqFa
 QbmXJCb8wV+D400Pli12Cku4keg5bts2SAbjDXLjqJFQZA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f2734bsmu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 22:49:59 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8eec6acbe21so33508796d6.3
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 15:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782686999; x=1783291799;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JYOeB9wXREvb/kPXlH/uSBNjP/9Wet3bk3Yudk2xHjY=;
 b=iE4MUCZfDp1pdVt5SUVg2F1d6c71MXkLZOZeueyVXw1jsGNCTgzvvQZGEyq25MaFK6
 fKRsMb+R3ACk9nK94IJiDlwno48yoT3S8fK7ccDcFl2QLJJpJuocb9OeMaS6AJ+U8oNy
 ZBy2RM8vvthijrH8gweffeHYGoCeyOCKGMb8atHPUezZavxt7JqqxejcPL36jVB2/IWf
 gjXlcmHGS+Ki0zD0ozaRE3cnNDwEaU6Kd50YPtr4wcIommd9KmFO+hPA7v7aDHBuhoNi
 exoo2qiMuy1wnxOJB134ttLs/xQwVldNHj9PdKBN+sbMlETNBhVl9bSl8ySYdnjRCxhg
 8lag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782686999; x=1783291799;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JYOeB9wXREvb/kPXlH/uSBNjP/9Wet3bk3Yudk2xHjY=;
 b=GsDSAms+VycmFGQYA0vyC53eN1cFru2oPMM4DTzccq9XDtULkqNMOJ95VPd16vrVe0
 A82BOY+w/t7onSqYVu9c8mv+1fZnOEevDzD4X8zSaccWKNKPRR8UAY/adxQ8jv4tVS92
 JR4z96ASHR4/Kk2ovP/xtIdY8HlGL1u9t1NfN0wJu7BqOyDjvKfhfpjecDgO3CL06bFC
 8ltsqSLr4dCsWe0HJDTR/UPnS+ymk3fzmiRMtap8e3D6u0CXpezD+z08TtQciU0BTS1s
 Wyuv6JLpfpuC4fvg+/3TYFZkkYYRqoHO2XBy02A+y/aM6lWpBZpOXy2i2vThO2AGnw6q
 bcaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/F86UVOcT9zmbvqt8j3E69bkq5y054F1PS57iz8ox8ZZDqoUHVWeBwUbFhAtr+Gqd8MLuZnzcnvro=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyiI5rZM9HUTE/GDrlNZodvHSsp3OlHJMEjnVgKHJOH7nRj+Sfy
 g4nGNcqxOTQihsFwU648G+pO6y59pztLwuBp6/PJTrI/hTk9oRIXklO8A0gftG1bBMvUvHGFUsH
 O8ELlUMseUpCkPDsT5AQongki+YQExLOJoRdclNZFbCI6tIGanOMFMeMT6Ok3j7oKuXHau3k=
X-Gm-Gg: AfdE7cnskY8M5rfgvO9l/hsL8Fu7CRDtYVGpx5feAWoeyWQjGJX7Le11dL09u+ZRs24
 K650q+a3K4pVJSi9ULWk6s2qCGIi6ogm6KZ0nQbGikwDM+BLBtdEaAm6en97tZoSoUvAdxmNXpm
 J5mJKwYit1vzw4jmHnQa7lM8xq0dUE4OnPA/iFu7itpxAopVxrKlro41V5Or4ahp3FiG1O2srqy
 BrhbAgDow33/dqlPJF8szDNsBVs3sVxDXF2DbtAW1UYTBJnDIbv1FbYYOoxsGiujPN7tpicq33a
 mADn0RTnnPwvB8J4uSSOaOG+8l6zblJoDLrRa/5RFptWd0h5ZGBG2h9ekfxL4SRvnCD3Rl4QHq5
 ZZvBCVpESw9zxNTRqwwtxFejVmz2v8NV6/mCxZ6Ksbd/SSj1PucaG1enzPX32tFpKUdYGMA1Kt1
 blG4kp0Rpp2yomyVCd9QkmBbh3
X-Received: by 2002:a05:620a:19a8:b0:92b:641f:ea64 with SMTP id
 af79cd13be357-92b641ff8f9mr1205794785a.35.1782686999087; 
 Sun, 28 Jun 2026 15:49:59 -0700 (PDT)
X-Received: by 2002:a05:620a:19a8:b0:92b:641f:ea64 with SMTP id
 af79cd13be357-92b641ff8f9mr1205791185a.35.1782686998633; 
 Sun, 28 Jun 2026 15:49:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999afc749csm74899421fa.12.2026.06.28.15.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 15:49:56 -0700 (PDT)
Date: Mon, 29 Jun 2026 01:49:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Subject: Re: [PATCH v3 4/8] arm64: dts: qcom: shikra: Add Adreno SMMU node
Message-ID: <ilwsmzpebxsobixd6xwgkr2dajsza3dr2ghcxfig2m6vhcamj4@but7o2rxmmrr>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
 <20260628-shikra-gpu-v3-4-9b28a3b167e1@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628-shikra-gpu-v3-4-9b28a3b167e1@oss.qualcomm.com>
X-Proofpoint-GUID: 7wUjhHXi8Gqq7oeRxcJAl50DX53wz3Th
X-Proofpoint-ORIG-GUID: 7wUjhHXi8Gqq7oeRxcJAl50DX53wz3Th
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDIwNiBTYWx0ZWRfX+NPyLTMNXMgY
 jV72cmFtueXa7ILe9eXcCAu53kuHzvstqKKj3YJlgboXydtEuBRq3j02OX9w11kFPyyG7JnpdBs
 ihXOPKVqPb10h2120aMGpdc0wggGC38=
X-Authority-Analysis: v=2.4 cv=HYokiCE8 c=1 sm=1 tr=0 ts=6a41a517 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=CtAqrJV6yErwifH23rQA:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDIwNiBTYWx0ZWRfX8nvDlu5U/Uv4
 xSBTQrjJ/BKl4yuL89y+9a7amaaolR1TRfEI5G01SwBelAQj7wKFfk/JerkbLEoZq2N18kbOmzk
 EDyuBQBM5FTugIwGdHs/Blomnil0+mI5HR5U7prP75gitqkIOVukkhAITKXxPNYb6n68O0c0sV/
 2Yxcd+UuO803FjDiUNucnNwVdkeYljZilMVdWi9ExTRRx16AJdcMI4V+xwbNPBWd6x8lVMIEVLO
 sJ16iQCAuG7P1f17Rr1x74Jcag12AgcY4QVhelIyUZTF955kepUcZ8+yZlLhaWzZxXpnDKVrnic
 HlB9NlEsJhYxn/XFDg/CDJbP4VXBxf6EaHKrIJyIjA33PKXtFlN+4R92L45Zl5qVj1HIyHJKG73
 eo57OspyTer+kFT/0AjP353jj2nFXjSKIF5zOXMvyE2mL+UctS2gWQ927iUBNm6z5kHsL1r3UPX
 63apUYYV16xPa4pQFkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606280206
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

On Sun, Jun 28, 2026 at 11:53:57PM +0530, Akhil P Oommen wrote:
> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> 
> Add the Adreno GPU IOMMU (adreno_smmu) node for the Shikra SoC.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
