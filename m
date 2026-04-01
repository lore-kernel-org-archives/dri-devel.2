Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651E2D35151
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 08:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE3CC10E39B;
	Wed,  1 Apr 2026 08:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="U7XzKVrV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RSAk5xqv";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 867A410E39B
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 08:46:10 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6318C37m718617
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 08:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UeYW5+xptUXLWkRdr2dqPLrdEHJM3AnZno/OO5vRIhI=; b=U7XzKVrV7+G8PHim
 83Gx5V9Xs9mUF5cjPSxKt3HKoWJfPBYkKzGJ4McgqJVysnRS75COA9Zq3fxd47P+
 LR85+YQRc207++p9uYmvveSY8qNDCe00ehB3MtsUdtg+boOr0eQJVEATm1YcksSR
 277QtaooaTs1XE0XuudKBioeS32RqwwVXnUW0nH1T7KjkYmqmr9QMHtjey4882hw
 gVt9UMhZiYzEEblwFAoJ1HCBdDrYsVzn9Uj006nk2IK/3vfogV/Sor1bi28d2+dv
 sQTZy9zCclYuHbj3vqRHVQun0MQfAycmnSwfphFuO23RHzCyDTARZ/pctCbpVSHC
 3FJOQw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8kcsu49e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 08:46:09 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8a016b99579so11728506d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 01:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775033169; x=1775637969;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UeYW5+xptUXLWkRdr2dqPLrdEHJM3AnZno/OO5vRIhI=;
 b=RSAk5xqv3YIdVnoY4UZfX1se+IM3kSmUIwOGBj5WlPrOCXI2m1WgG5FD+56IOSptjJ
 5OuwmA7pw+fXL9Rc+ghu/4c0qh1Yw3SmR6HWR8u3kBjPhaLudvlVmZzj73Uz4ZCPJcxl
 YDqqAf5k8QvMw5yIJT715tMVb26imWqvpN1qBSMgBjOKKo5Ed0fbF4k6x2B+8uwfbQwE
 gALLhfNQVUtYXynfkh6tJz91kWE+8Q8/3CEKtb3eb03e2euVMU7TGoFK2Aao7kt0bjAj
 6q19uKKdbqbhUekdwNxeF6JxEAganSzJ+R4riWGkRwBVQauY41TS0+DbHa1yEczjMA5A
 xeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775033169; x=1775637969;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UeYW5+xptUXLWkRdr2dqPLrdEHJM3AnZno/OO5vRIhI=;
 b=albFOHfms3z1zQlPOAcQWajAyfOloxF3Ux82v9Uo+jhyOFusmRv6x02oal8NEFF21W
 Cn8oJqyRm9eA4TJGXo6BGPvyVCxnBlX7jXQ/ziR3EYbhuZ/PDRv6oUyK/DXNhG90S+9G
 p/pH6BoBURdJ+R2CmE2eTPCce6ay2JOAWQqltXwpVShmUxJ7PuJuWvQnUWTfniskytx9
 4HkSNcQ8CXACww5vjYZ+Fiu+Trbxelmk64CMQbUy4MCwxJWqzJqA+bS6fRWrZ0UQ0BNJ
 CAtcEpfZec/D/++SKCXnR+g2/AZlCS0XdJLFlGntgb9SvAhWDmU7pI0dtw7jsGBgj8AG
 skkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/Gt/zrMWkLxJhSsxdoNbhEzOB+ttAZpPltODhIzs2IeWkT4wWx9Dvw+pxWzC6R/byU15SEHpyclk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4hx1bCVC3wIv9Vj+6nhNaxNr0QCRCxrwei7b6xNM7V5jmInai
 5xwBfLl4HZqZOCGcca8XCwIRyOu90CFn2memSHyPlTYA8B4yi0QNsxBUAxS9s1mMyLkxPPHkVky
 Lq0Yo+b3KwKG3AE+xSXmxuSMzwFquDnITHxIU3l9ff4MwdMaVwbexfgN+aFGRWqMNWNOJ+GE=
X-Gm-Gg: ATEYQzyaXm0hYNN2rQiJH+v1Yt5gllukper2tWF+Ho0cSLU4f2+odyjLoujqKzOaWdZ
 w1vYtfMV6ZA5uxnX0TRfvwD2wMWVo2lxypbCyqxKfxvGEQqDwdPgFKfACw8i2l5YkW925d7Hv+L
 7y9R7+V41FDH6jEGAdmT8GzrKRBxv2bLaMN6dYpRqYwTZG2+spmYlo6DrDEmVFAfy81CVJVKp5B
 Dw5EhXFpIoaVGD3C30KcTW29Q1/xGqwpQwiZ7ZhOld/wINKlGO3p0KsnEJ4sxIAf0fjAn/2RWxS
 gePRj0NKX3SrjK/jqVit/pgad5VUYL4HBbl2vrE7Nl7d2z6cVdNtaslj4kbXih8BEnjRuyvUaTM
 fanME3LP3jTV9bfrDi1pAW8Kvu4ULj4mPjH5yTpg80ot25+LYYeZltQIf1SsMY9eIU76Mx5R1DH
 cRyEw=
X-Received: by 2002:a05:6214:1c46:b0:89a:46fd:3001 with SMTP id
 6a1803df08f44-8a43404af75mr34157786d6.0.1775033169085; 
 Wed, 01 Apr 2026 01:46:09 -0700 (PDT)
X-Received: by 2002:a05:6214:1c46:b0:89a:46fd:3001 with SMTP id
 6a1803df08f44-8a43404af75mr34157466d6.0.1775033168669; 
 Wed, 01 Apr 2026 01:46:08 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c2249fcbcsm37375066b.5.2026.04.01.01.46.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 01:46:07 -0700 (PDT)
Message-ID: <c01a99cc-77f4-4dbb-be53-5c0c91622c82@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 10:46:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] drm/msm/adreno: set cx_mmio regardless of if platform
 has LLCC
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
 <20260331-adreno-810-v1-3-725801dbb12b@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260331-adreno-810-v1-3-725801dbb12b@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA3OCBTYWx0ZWRfX2qL3UrkkoVGI
 E1UWyJuGTIfqv6FAgnaL4qpVNkC9V0kIx64rXnE9p910zExggPF6Vt/cKQH4/nb+RpIi+JLpLYM
 FDo8xKF04UqLvZA3ShuEfShl83uqDD5EessdP9Pl9fB8Qhvla+2Ur2y8eAJGJPJ0NwCjMUeqUbF
 xmxUcqYPTPA0XKT5slLwhfEavQ5lUT/IapPZqtF9P/YlXmLExLPoo+UgjUMRzySoonhb1INULxk
 iAxZpPFmIhF/NCXlNKSmnv730eAIxFObRPorrNgGZR3YvMuYJuyM6438pIrMiaN3oT2OmGVCpg4
 Thbv1OSB3SDIaEgWfvs4kc5xvwTjZV57LvxFvdUEKmCtcEADqts0WNgB7u/SPw9Fz0DHrJPzSOZ
 OrKJx7dfleYBlMiJC8HTlCae5Xg4Mo/7lzRcZB4jVFC43wh5YCD1PLnIulWD22/KpEyXAPIu9I2
 SJxoQRGipnn2a8gJKZg==
X-Authority-Analysis: v=2.4 cv=KNlXzVFo c=1 sm=1 tr=0 ts=69ccdb51 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=k3NpOJoY7FANPw3bM2sA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: MnUGR56BXGXRu5I0CYKJ9UabvzltjbNi
X-Proofpoint-GUID: MnUGR56BXGXRu5I0CYKJ9UabvzltjbNi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010078
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
> Platforms without a LLCC (e.g. milos) still need to be able to read and
> write to the cx_mem region. Previously if LLCC slices were unavailable
> the cx_mmio mapping was overwritten with ERR_PTR, causing a crash when
> the GMU later accessed cx_mem.
> 
> Move the cx_mmio mapping out of a6xx_llc_slices_init() into
> a6xx_gpu_init() so that cx_mem mapping is independent of LLCC.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
