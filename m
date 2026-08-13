Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3EBC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:45:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C482D10F1D1;
	Thu, 13 Aug 2026 07:45:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mPY7uKtA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WzCFwQGv";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 586F510F1D1
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:45:27 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D5g8Yp1072487
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mqfMyeLa/enZs1Q/aT9heNul0cQ6BjO2BGjlXPqgzCg=; b=mPY7uKtAsPiUK2LD
 xFJBQsGTDdscZ7jwDMzGPj9JcznqlTdZHjjrdCCoKB+TIVvg5PCbYU/V1YUFpMf/
 zoZNv+3/gP16bK3VSzZY9oyTKVl4GUqqv4AF261DsgzvdepWIvdFMQ8AmR//4sIf
 /xGjOb6l31s24Zq2TZKcJvcXaXhjA9Z9T2heLn4iUNpiMGU8aGeExy13ak6L8wPy
 IrmAy+LuHJSU3+jpqvygZUMJhohes6VF8Aaw+Tjdxn/1L30LUCpOVjhy4JQgr7DD
 HJc157pZ/zs8Odn/9NDyB2IUA8AvGO7xstP4rLUX5cv+peYunxOj4OBMj72wh7DG
 Qa7+kg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g14syh6nu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:45:26 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52827090cc5so10330371cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 00:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786607121; x=1787211921;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mqfMyeLa/enZs1Q/aT9heNul0cQ6BjO2BGjlXPqgzCg=;
 b=WzCFwQGvvTthKwvogpSBZcyfOKgQ/5Xu1rQkoeC1tInj4BV1z60bOyZIw1s6x3SYok
 LEgQZ4jtFFAQWPZMI08gAj24u9fQ97q3by5jkblZjDwyteoq/4Ox4voC46LqlBduT8/c
 iLXsJwRbCscQsTnFQIrF/U2eTtsHzGlovTk1t1eLYNy93ZIK+nVBit4R2oxYXPo1M7XB
 y+Y0jJ5cR6ltzaeP4NvtR8AQqIZ0xSuZkxx6I6MHzJSf3UvWocv0fpa2ATEKeS96mlxj
 BhNFxVy6ACEBmzVR5V0wxOVMjo/kjGsRqFx7hlUArG21PetJqceorqx4w2TbjfFOWT4s
 vsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786607121; x=1787211921;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mqfMyeLa/enZs1Q/aT9heNul0cQ6BjO2BGjlXPqgzCg=;
 b=kRD4wKuISh2TDPPyb8X+1aef3VdzvpKath0wHyw+Ey3qTAVFBoi/AKTydzipNUGODt
 dE3p6pyOPz3Mnl/Uds0II5QyIcTtNOO9U24RlkKSZXUjw30lnx5aPSUdLTVYKwF7SSyt
 bZs9iOwhEbh6DO7j/594FWf6JcF1IYpeRQGIlMUNp94KbkgGOK0gDn3xK+6ODBg7dvPp
 0GTFdcOu07/HVN+GUCqZYKHIZahtSpMSlIHHMo2QpgJOIwz1gWpF0njHVL1Z35xflz+P
 wDT1/qWC0YjS/NIFdqCteS6W6JjUmzN9vD4EIbZTo7Ig42irCPCJwySn2BeqMoXb1mTo
 6KNw==
X-Forwarded-Encrypted: i=1;
 AHgh+RroabneZmVu3RcK+lLzfK8wDIxEPw5mOnJ4Az55ZB3wLPFFjO92UgkXL7tGYcAIQFGbYa8Ow/0xNko=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywt6uQTSsGQT+q3/n3TPVci93OL8YqHDM/2cKyQAjXpBDHhpOcN
 FsG4YTRmdy0sABtePgTWAH2NChWPjCp1Oahkk6KqecnqF6WHuvA6Ko5EWooBjnEQltmq9ww9n2m
 mSnIgUeyF+vtyUX9+HvOh0TT9kmPhGYD0lIu9gUcJZpTentDTYgBnl3TKVBTXEwq4b0wNSGo=
X-Gm-Gg: AR+sD12Onqcy9X4sOUk8kgyAkYO78fjEHy5xhwz9/+AKs9qrEtY49CyEXCdOGABeQYT
 T1lvbiSePCMadgUbaNpAKMkFJpmcIW8lhFVGg8k7w+mg8I0YylDa0Tow3BCZVtg+/bU5NrCKa64
 034FYjp3/0JN4/YXvTNenL/oHLd4MHYWl/wyrgBUGfkTy9r0kknkvciuZkyDmHOWmzrTMPjClxX
 a2KClRh9X50dEdBUN4xZ01oWuBHoJe6lIfRJwZ9Vt5nFYCRhMcxBSz1cmK6opCe3Z0jzEODtAh7
 H2Dj0OIcSprc6x7e9hAgHtliG+Y+LR7JVCZoKkT2blwzaF4ddGl55izeE2DFk7l3EGqErW4wJ0F
 Km9kIQuWg2hZfHWt7hPEWJ4a3OZmQh8uwnqQ44KOWZ4ZobKe/CcyAdhP3k9Z5tzo6
X-Received: by 2002:a05:622a:148b:b0:51b:f992:9e18 with SMTP id
 d75a77b69052e-52d74a35488mr27934201cf.2.1786607121556; 
 Thu, 13 Aug 2026 00:45:21 -0700 (PDT)
X-Received: by 2002:a05:622a:148b:b0:51b:f992:9e18 with SMTP id
 d75a77b69052e-52d74a35488mr27933901cf.2.1786607121072; 
 Thu, 13 Aug 2026 00:45:21 -0700 (PDT)
Received: from [10.111.164.29] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a8179e4fasm9733956d6.2.2026.08.13.00.45.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 00:45:20 -0700 (PDT)
Message-ID: <b360c4a0-72ec-4121-b16d-b7aa94e1a1f1@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 15:45:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/msm/mdss: Enable INT2_GDSC alongside CORE_GDSC
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>, Yuanjie Yang
 <yuanjie.yang@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
 <20260720-msm_gdsc2-v1-2-4687866d6cb0@oss.qualcomm.com>
 <nwz6ail4qwkmsejow6757nxkutojc2q76tw7lt6oj3h4pncp5f@w6xkgj3bnlmh>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <nwz6ail4qwkmsejow6757nxkutojc2q76tw7lt6oj3h4pncp5f@w6xkgj3bnlmh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZcQt8MVA c=1 sm=1 tr=0 ts=6a7d7616 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=YZRirGJidSSDptMLQzoA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1MiBTYWx0ZWRfX4QICIuA5uBrU
 67+wZ9aKbbrVuMCDYLUdIl0xYCna5IAA6kqa988+JyBHmx6hBqueFUWNmEkSRFvA+L2q8EoVwwx
 wkXw7MTemQBI32fnlBvM6LL3ZVehmR0S656CJ1/4V8DHWb8xkXR5qvmitEYpFLZ1TIJe3rO+gYA
 9FR+tl1BMKCdur53mB9+b1EDdvSnT2IEA3h2tWsuSbWbp7zZZ2FKfX9+gi5CyaGQ2A3JJnkFnta
 7N7qKqnOMW+RFVXsQ3bX1yv6UR7l1o7vgy5Atw0S7fhe3iiEFJuLsdQTwAuo5g+r/b8R+5qqXXO
 S0UhqxVeSUuDTQ6Ru9boNTMP1AB1RFiar5I8csRHoz7jhzSVFTEdnMRPiuYva1IJamgBDly8EYR
 k/E/NCBKy2l/3xjPnl4fHycEK/4Tq7D0Cbm8iCQ/oXCzm8mQTjfM8FBoyGC6f+AdysbD4su+ASI
 ZtZSsi0zUYvq/+gH3Eg==
X-Proofpoint-ORIG-GUID: djLaGrFvX3jr_UCFSKVEbeeqx9AKcQV6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1MiBTYWx0ZWRfX5hobc1wfGsv6
 qw5u3qMjMIFOeqsddG0BKRJB9h8dt4RabTAsUrv/tNldcUq8HTBk/pnOWMGMR+6zeEkCzxPOqIi
 7CnjwaFlAozvMvbHYSn3mImH9ftJGrI=
X-Proofpoint-GUID: djLaGrFvX3jr_UCFSKVEbeeqx9AKcQV6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130052
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



On 7/22/2026 2:40 AM, Dmitry Baryshkov wrote:
> On Mon, Jul 20, 2026 at 04:43:54PM +0800, Yongxing Mou wrote:
>> Kaanapali (SM8750) and Glymur use two display power domains.
>> CORE_GDSC powers the main display hardware while INT2_GDSC powers
>> a subset of SSPP blocks (VIG2/VIG3/DMA5/DMA6).
>>
>> The MDSS driver currently relies on the default runtime PM handling
>> and does not enable the secondary INT2_GDSC. As a result, display
>> pipes backed by INT2_GDSC remain inaccessible.
>>
>> Attach and manage both power domains explicitly and enable them
>> during MDSS runtime PM activation.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/msm_mdss.c | 53 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 52 insertions(+), 1 deletion(-)
> 
> Why is it being handled in the MDSS rather than DPU?
> 
Will move it next patchset.
>> @@ -421,6 +451,27 @@ static struct msm_mdss *msm_mdss_init(struct platform_device *pdev, bool is_mdp5
>>   	irq_set_chained_handler_and_data(irq, msm_mdss_irq,
>>   					 msm_mdss);
>>   
>> +	/*
>> +	 * When two power domains are listed in DT, the core framework does not
>> +	 * auto-attach either of them.  Attach and manage both explicitly so
>> +	 * that INT2_GDSC (needed for VIG2/VIG3) is enabled alongside the main
>> +	 * CORE_GDSC.  Single-domain platforms are unaffected.
>> +	 */
>> +	if (of_count_phandle_with_args(pdev->dev.of_node, "power-domains",
>> +				       "#power-domain-cells") > 1) {
>> +		static const char * const mdss_pd_names[] = { "core", "int2" };
>> +		static const struct dev_pm_domain_attach_data pd_data = {
>> +			.pd_names = mdss_pd_names,
>> +			.num_pd_names = ARRAY_SIZE(mdss_pd_names),
>> +			.pd_flags = PD_FLAG_NO_DEV_LINK,
> 
> Can't you use DL_FLAG_PM_RUNTIME here?
> 
Got it.Will ust it next patch.
>> +		};
>> +
>> +		ret = devm_pm_domain_attach_list(&pdev->dev, &pd_data,
>> +						 &msm_mdss->pd_list);
>> +		if (ret < 0)
>> +			return ERR_PTR(ret);
>> +	}
>> +
>>   	pm_runtime_enable(&pdev->dev);
>>   
>>   	return msm_mdss;
>>
>> -- 
>> 2.43.0
>>
> 

