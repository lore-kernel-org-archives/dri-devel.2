Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8AAFF5136
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 392B910E49E;
	Tue,  7 Apr 2026 19:21:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="h0eF0jTx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RDM93ViX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48EA010E49E
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 19:21:11 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637Co9Kh1405862
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 19:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6rgwYZsPuPyDgp1OqiObHlQX0/OsVr8paljJSmYmSXI=; b=h0eF0jTxs3PI5xqj
 fnZdekjuFEQfWxAgBpmNQxZCqu8FuBdQ/aqG37GHH/aEQlsPwBwftvJtEWK+WfQE
 pCpMgx59njRDqQvF7+xROM+pK6Ru6M6U4ebWVXneU+vcKc1Sa6hSckzpUwWkyr6g
 WVcG+T8CHh2h39yYu8TgI+14Gt7HkotYnq8KvGAqYUEdcxwePGc5vbALZnquH6A3
 7NIKHhmetX7IuKEOhCr93cphA20SWeGLMR3RzfuUHuJ9xbNKJ5ajYPgEIsShE+Oy
 5rdfbvEBJm6KCBsECuoC7VGzCoEMbdgSa6ISZOpZHA8dFgKsCIz+wZwjjckYWpQG
 3owGCw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrav9xp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 19:21:10 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b0c30b51bfso117788355ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 12:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775589670; x=1776194470;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6rgwYZsPuPyDgp1OqiObHlQX0/OsVr8paljJSmYmSXI=;
 b=RDM93ViXdUY66+ufs9PA8dvTzk8t0iZ/SisLYanGOIJtEFss3pXbBSinccFpOT86jC
 zsT42VVGGPs3gIXSJ669N4+azlbwsQ1Z0gGh6fcBJNot0y6GKj3iHEN1DmhhLzQoBVig
 N4OnwTEsiXZUnaIMLMYS6FXkUPyp9bQ7PIxC3w36VQ0Xzl3H9awiV2gaf9kh9vNS0BRu
 j0DEmsbS03K6WHRcCZZRY0VZACTzQLWUhFQBVQTwWMUbDuf60LxhJphHshvIioTA8YzW
 BrcSyw1ZVoBNEwOdO+cAPlFaAWbLWo+EitxPsJlENHzO0+H7CbSBaXMjS6CC4NOAjwns
 gAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775589670; x=1776194470;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6rgwYZsPuPyDgp1OqiObHlQX0/OsVr8paljJSmYmSXI=;
 b=Wz3VqqXR9aLrPRqDO9hxBH5+8pVm2++BpUf9oKXEPZvSNh0TjlEl4GD7iXnD0VyWgm
 fjji+bSaIMwRVcsri2UH8bGMgT8KB7UjKvXNv/EfQb2TMrR2ZIstfE+nsddH9LB10M9V
 XmutHUETdXjWaztWYVhHgsdkO8937vtbI4zolzy2xt6Fzsdns18nYDEqCklITIGik93J
 XpWUuiOJ7gEdAvZ0SIySoi1teKfaKXb1iHScEG2k3RFyvCq2jF14C/Aa+71p3mVeRjwF
 7BcTm+Z3xCT0CNkQGZk/t5n9XeKCl8zK6GSzYaUcqDM5rDjJMz19cUo+1ReAZ08NO4SV
 VVaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJFH1socbghum19hi+gIVCvkO0BEzGp6GVC3wVhVyFNxVVqeEx9loFmz2joZkW/7yNbjmFViSqRmQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXwAiThyzx+9taf3qp8LyV1NdCyL+8vBShX//vdRVYzLRjtXaJ
 BbcD0H2uT8dX5g4cdqCmD5shCzUNfaMBZr3u1AOvNrqzzqa+v9P+kTWfwlaBiAlo4jHwLpQLYut
 7VhgXX6mfd0DmvCGURPbQI236nju57Y1Z3A9LhQ52FetSRCRlOauXSoYOIUbfju5lmsY4D1gOoe
 nm0Ew=
X-Gm-Gg: AeBDiesC89kotq61WzrK3BBYOkT1CDwHdOcfhT3I9SBnNrOsnygX7OJRGg31Tk9ylJy
 LA+qF32eLpwMJqmMbt3GKzuZCkx8PRQ+ISzoA8wCKIBdVN4PoVJy6aKiFl38kcMPVMBIcO4JJm1
 3+tSFf4b+lMoOkgGD7aOqCh8wc7ZqcyWQBIXRfPITBHY5Slk0THPwRsMWEiUma2a4MILwuZgjq+
 s9e6M0ylXp1F3qoHSipBxYII8qB/dKHXMoGZ5Wgfc8XYqxaK20CVPDbZ/k47MsU5J6LxmYbMAS0
 XrlWK+5I7q8nhbFut3bHgShbhBWv0YX31GYksXPyuGchFKCE7ZW509TesKwZJiZcwrmecT0NxkN
 wvrqz6oXKDFNEGKrwl8qOoZflHChhLgh1MwSvgIsaJGUXKA==
X-Received: by 2002:a17:903:22c6:b0:2b2:4310:8d1a with SMTP id
 d9443c01a7336-2b28188a1cfmr192326745ad.38.1775589669814; 
 Tue, 07 Apr 2026 12:21:09 -0700 (PDT)
X-Received: by 2002:a17:903:22c6:b0:2b2:4310:8d1a with SMTP id
 d9443c01a7336-2b28188a1cfmr192326385ad.38.1775589669313; 
 Tue, 07 Apr 2026 12:21:09 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.229.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749ce29esm193875385ad.81.2026.04.07.12.21.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 12:21:08 -0700 (PDT)
Message-ID: <ade66e71-d24d-4b19-8a1e-951fa95159db@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 00:51:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/4] arm64: dts: qcom: Enable GPU & GMU on Glymur CRD
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
 Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
References: <20260405-glymur-gpu-dt-v1-0-2135eb11c562@oss.qualcomm.com>
 <20260405-glymur-gpu-dt-v1-4-2135eb11c562@oss.qualcomm.com>
 <ui4r3krzvd3i6kjdozhmmueejdqpbnbo5wfa6pwzjolcse3eeg@3u7bdphqv4iz>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ui4r3krzvd3i6kjdozhmmueejdqpbnbo5wfa6pwzjolcse3eeg@3u7bdphqv4iz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RTDNQXFezLnI419JonoFSAkfxSLRQ-Gc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE3NiBTYWx0ZWRfX6XlESOZPkQL5
 koLMHZ9QB91J4JO7GLu8If5xrevJsuhkZNS79ktLc1dkwYAUg488wWd48zYd2dOo4i1I5Q8I6fF
 hPlio5QU+hdAy2p+gIfYWfgvkO9FFUwBfJuC+K48KsSE1HLsXHjb+YTEhsMvrE37m8FfHrtX4NW
 NahDli1X1PTP7RsD+NCEK5c1nJCjf92NyhXuHwC/Hv5TUcKDfALkfH774ItkffSEhXfUi/dcWxg
 KA4t7mTO4gRO3VX1gooDMAr1aksT1Iu0+MMSW/PN4R5BvD+PEFpaLpD5hL/zhcGp88Um3Mw9CL6
 hoUSA3Iz+B1IZM42jAlrVX3yUSLg5vKK7YH8kyV32UGsYOVrF3/GRXQRMuD+XzRcttL35kso3Wd
 R2PURnvZxJqszNtkEWyZghGF8ydy9jMYA1N47oxqNN2YWbB03DfGIVgr5TcPMZh+BMsA+x4HfAB
 XrbcY3uOcGdYY+FQgog==
X-Proofpoint-GUID: RTDNQXFezLnI419JonoFSAkfxSLRQ-Gc
X-Authority-Analysis: v=2.4 cv=D/d37PRj c=1 sm=1 tr=0 ts=69d55926 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=oIjhDLspr5RTlLLUpj0f1A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=8uCpHmCzy03A3Vi_SyMA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070176
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

On 4/5/2026 3:14 AM, Dmitry Baryshkov wrote:
> On Sun, Apr 05, 2026 at 02:33:17AM +0530, Akhil P Oommen wrote:
>> Enable the necessary DT nodes to add support for GPU on the Glymur CRD.
>> The Glymur CRD boots Linux at EL2, which means it doesn't require the
>> secure GPU firmware (zap fw).
> 
> Is this going to be a default mode for other laptops too? Otherwise it
> might be better to keep ZAP node enabled by default and disable it here.

I believe so. Anyway the laptops are hitting the market right now. If
anyone reports that the EL2 is locked down, we can revisit this.

-Akhil.

> 
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/glymur-crd.dts | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
>> index 51ea23a49b9e..a579df902323 100644
>> --- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
>> +++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
>> @@ -110,6 +110,14 @@ vreg_misc_3p3: regulator-misc-3p3 {
>>  	};
>>  };
>>  
>> +&gpu {
>> +	status = "okay";
>> +};
>> +
>> +&gmu {
>> +	status = "okay";
>> +};
>> +
>>  &i2c0 {
>>  	clock-frequency = <400000>;
>>  
>>
>> -- 
>> 2.51.0
>>
> 

