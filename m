Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48069F9D0D1
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 14:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A78F810E278;
	Tue, 14 Apr 2026 14:23:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cuNWqQaZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OCdIVo9b";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0980510E5AF
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 14:23:26 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63EBt18F3505295
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 14:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sLvdqakjvhjZspo80osPg3QWx7e/vaJVprphVoJc/zc=; b=cuNWqQaZ/3VSN4zt
 w5CqmpH93jbEC2l9n3Ca5OLx82e/EuAxShtJ1HU5/0kbccas2rSgAlQa6a2Vx8V4
 stn57V8bC23VudyMs2cuM/5dDq3eF+DpiD38gggqI2W3qT4ASQw1WY1lQUnG+7dT
 tIbGapBdjOBArcXki865hsmXyRc6uu4d8GW4rAd46yRqMVYKJDOHqLlvBMowuI4I
 /OGqO7VZi+rJm2aIE4eM9VwhhdGAMwfrHN4GHf3Y9tfgeLxJ8mUI/Y9duOkBggAy
 cwADcq9M1s6L0LBDzzH7HBjc8ukxYu80HnmrwfsdQ4l4DEM6oQz1Pfq3dFEJrrFw
 5CI0yw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh870k3e9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 14:23:25 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-56f71af9dddso142722e0c.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 07:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776176604; x=1776781404;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sLvdqakjvhjZspo80osPg3QWx7e/vaJVprphVoJc/zc=;
 b=OCdIVo9bhnlS+7Hmels5MSDCeyVGvwF46KAQk0KVsq60svleZd/TxF+dzZR/fUXJJu
 NoWFk8wqHSfNTCeRXZu084nzXi/u37t7mlWGN5xlinBH+B+overvE3yqdzymatLCDiXb
 VuzRZ2bD6HcsitvqeNLdLhB/2nKqb/LEI1bLZXXfmgW8A2N8rD3jXfcuvvTlh0cKwVH5
 AAdTeTd7hTOa+JNBU3fvcGzH1+zAAFsacwmzWk5yMqcYbuWcwZNYbqPGWk39etkhLVod
 GvX6Lhqb64WIHlLOtkylIH2h6xNufWxl7O5QbOW1fd6H72pc3PRNW6BJFL+NvFWwwnEi
 +QBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776176604; x=1776781404;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sLvdqakjvhjZspo80osPg3QWx7e/vaJVprphVoJc/zc=;
 b=IBMJzcGRgjgqbp58j6DoIb0w+yS5Z5mIvygPMkPce4zfxa+t2utIvRz9vPES2XNmAu
 aEsP0zARv9SkOzhPOVpLFXGxq6uKqFBFAic3odLNkW6Fp33XKHqKHmXrzNPzgZZ/V8/v
 lHVYLpdCJlulyNXUYSL540pkoG8tOL3ZJSkr/u5XnPBCPCChf/md7XoVzf3VfSd/a8B2
 9y4vWvGcNdMQNJgNfKApp9Hdqtr1sq5sSbNsRkGFw773719XE5uqIugVRwlS6Kjj5kpp
 7eI5J3m/i75PjmUEvghG9hM97B+ZnPvfUXzc/hHbZRsH3kp0Bb+NCoPCM8vkI4hFD7Nj
 Mhww==
X-Forwarded-Encrypted: i=1;
 AFNElJ8e3OwRX8giE8YEWIssMng3zDbg6RUTLlcHN6RUOPnWTUEzilPHKe5LsEbxBlZW4adVMW3Q18qYAu8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZYl9vPTgp/5jB7aWNdFUSjmGPRNaQ7yqHlpBA1/ICl9+gwDcU
 Bqx0UievcQTGgu2AGBNljwfuTSDTosGhi4mqMyDBX/IXNj9LZik+K8o/ihd6TKj5rO0BvremoC1
 Su+cIobruvWVCRqtulLBLDHWqkDNC7kOccUy3T3vclQD5aZI6Badxli7NcoXNsDtScRJHXFk=
X-Gm-Gg: AeBDietGD0vK/JVCx7QPSmCV39zIXK7mkRTsvviYQOMIWt0VMGfFfx3adwbs5xLOsez
 wVuKv6/NeqnUP4mUOAr/NLkFjE7vfnjA2j38POz6ztXKoIPlEysIMGXAGC0XD9jsZUqCBqGjDuL
 +JziESuBYDem452M59IZBjI4gxi4Qe15s2d9F/jy8POc5ApDvmH3O0DFdIOXX0hNzdN8fq65sRZ
 hFc/v7OLGX7a790w/R0lH85E4tDXZAFJ4xlGhLXRvq3KsB/se7PiW3HwdAwmszXESktNiBYaM02
 Sfa3eybg/LkFK1Xw7B1l6EYJqaPdsgfCqfhkS8WHXrRdeN1U0DMlY2ekshOlb57RtE/3cD5vzXz
 AcvFk0K2BA4TZ9rB/9gyya+9XgwGqWkVnKO2clQ5Xp1OyAVsP1wFej4Mj0v3fEGO3ykdsJ9wZ9b
 grzzTyv31hHxBq/Q==
X-Received: by 2002:a05:6122:25db:b0:56a:9e65:3e30 with SMTP id
 71dfb90a1353d-56f3bd2bb38mr2929641e0c.3.1776176604299; 
 Tue, 14 Apr 2026 07:23:24 -0700 (PDT)
X-Received: by 2002:a05:6122:25db:b0:56a:9e65:3e30 with SMTP id
 71dfb90a1353d-56f3bd2bb38mr2929614e0c.3.1776176603819; 
 Tue, 14 Apr 2026 07:23:23 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-670703f1340sm3272004a12.10.2026.04.14.07.23.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 07:23:22 -0700 (PDT)
Message-ID: <4f335d60-1cae-4027-9e87-b1212e01772e@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 16:23:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] clk: qcom: gdsc: Add custom disable callback for GX
 GDSC
To: Taniya Das <taniya.das@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com>
 <20260407-gfx-clk-fixes-v1-1-4bb5583a5054@oss.qualcomm.com>
 <6149513e-2c0f-4f01-a467-b4a213d65609@oss.qualcomm.com>
 <404ca234-1bab-4094-b7dc-c4d0b072d929@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <404ca234-1bab-4094-b7dc-c4d0b072d929@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDEzNSBTYWx0ZWRfX0syDc2tlSYYt
 TL4BpX1Jqq/y1uh/zgxZ77SJG0awCDIQ2rUDoc/ILOzLbvfsehHkDfNeueiYfrgea9Fw5xmFCu4
 IIfT5ZwQXqnBipoiKVa+OgOUEpm3+xjPQvERlIvsw0NJzCvuAEQrKGcMfbJHbzs3D0kbYGt1RrI
 9zKwSQe5AdcBmwW6Fb9hJaMYSECp+Eag83c9t+TDyJ7Gr4DleHSQsUW+sYsJ/Vu4aa0PnVG6PvS
 J/smI0VjKE1qYvYWhfsdHnnKmlo1CwM99E18fl5MUwF0yxVSKHyr9IkGi/dnP4zzAZ44o9Qk4Et
 H63kY6w/emjhWNBe5ddONoYZvE0oyzGwUbYH0tgVOafR8bf4Iskf6sgVOyvAM7c8eTPkb2jmgq+
 I7odG1wyZvowrgUiJ6tauA2G63sCUrt3oUrp6CUadXfdF36kmJn05dCx6L4iWjN0Z6324c7DHlw
 yvhYoN2LICyDCIgwHaQ==
X-Proofpoint-ORIG-GUID: LFqtwWg9-nNxxpRTpRkH_q3uwzhmivKF
X-Proofpoint-GUID: LFqtwWg9-nNxxpRTpRkH_q3uwzhmivKF
X-Authority-Analysis: v=2.4 cv=btZ8wkai c=1 sm=1 tr=0 ts=69de4ddd cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=LiNkUCdodsQKAq62uNgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140135
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

On 4/8/26 9:26 AM, Taniya Das wrote:
> 
> 
> On 4/7/2026 4:26 PM, Konrad Dybcio wrote:
>>> @@ -675,3 +675,25 @@ int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain)
>>>  	return ret;
>>>  }
>>>  EXPORT_SYMBOL_GPL(gdsc_gx_do_nothing_enable);
>>> +
>>> +/*
>>> + * GX GDSC is a special power domain. Normally, its disable sequence
>>> + * is managed by the GMU firmware, and high level OS must not attempt
>> nit: "and high level OS must not attempt" -> "and the OS must not attempt"
>>
> 
> Sure, will update in the next patch.
> 
>>
>>> + * to disable it. The only exception is during GMU recovery, where the
>>> + * GMU driver can set GenPD’s synced_poweroff flag to allow explicitly
>>> + * disable GX GDSC in hardware.
>>> + */
>>> +int gdsc_gx_disable(struct generic_pm_domain *domain)
>>> +{
>>> +	struct gdsc *sc = domain_to_gdsc(domain);
>>> +
>>> +	if (domain->synced_poweroff)
>>> +		return gdsc_disable(domain);
>> Can we use this version to replace gdsc_gx_do_nothing_enable() too?
> 
> No, Konrad, the enable should be always a no-op in every scenario.
> synced_poweroff can't be used to handle enable of GDSC.

You're right, I completely glanced over the fact that one is an enable
function and the other's a disable..

Konrad
