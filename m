Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7788B606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iWmW4Vqc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xbwkrlnd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0F1610F961;
	Tue, 17 Nov 2026 22:14:23 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E5C510EAD9
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 22:14:12 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHKfY1A1627511
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 22:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5Sx6E2eGRV5SxQp5i7sVIsOeukXm/V4zepzrSLP5HDw=; b=iWmW4VqczE3QyEmb
 Swbt8vC3VUy+iyYxwzkQml92CjoJCXL0YeWGLkWxyro296gRj7V9rvvdRkurgB1P
 yUcEbN1auMsw1st8lbi8CoNldZy3Jk6JxdT1pS630Ji6dFjleNFQYFkyuSKouRvp
 0KGv5u0emOa0MY0DiNgZ4L77UQTkYBxabwuyWlrDoyQSVx4uT8LKSpfB7+dEO+8M
 Lw2UDd/pA9vF6xSU7pmYyTSlJK8tfe2xnsKhrwT4zkwbPUZhbQINvbXHwhjyg0u6
 phN5s5aryd91ARI4g/hk97PaCFJjUM4EV7OrbiPVQTTREgOHO3wKcY8HaAUO1KpL
 qEa/9Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0qms2abn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 22:14:11 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-37549877380so344657eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 14:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794953651; x=1795558451;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5Sx6E2eGRV5SxQp5i7sVIsOeukXm/V4zepzrSLP5HDw=;
 b=XbwkrlndIwmHpvap8XVDNrOSYXOrMf8yXIp1FpM21LyzIASZWgBXqfYofhmQGsFbP0
 QPenOSqE23cqPoozTttrw91sModgLDDBY1b3sDnrkTgdo6obqRRzvHgthCGSl/vSKHfp
 zQ/9fziCG6CpB5z5E95655h488qh3g1IHnIUJhA+RtaNas0YYuIpr4clk1uThzK5GMGe
 EW4iNMt9JMQHTQ3S3dw2Rhw8H2c3IyExQGLsO+R0HwRAQMub6060FVQEERE7Nu6TBSdc
 BbqfGSLMC6xQ7932tQi2DKnElX7KYbFuV64iKatDiM2xkBuJ2NU03xg3FwNqxJzq4kmC
 h0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794953651; x=1795558451;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Sx6E2eGRV5SxQp5i7sVIsOeukXm/V4zepzrSLP5HDw=;
 b=QKvv5AVLtK6yENk36AKY2k0N+LPfwb6vYp6pMO9vGZeCtPB3GGHthnGqpRtIum1FiP
 aS/fC94VS1Mwmcy6hWKzQwsfsm09CA+sCgzXPKhTJvkVxxbTsDk++/AjkfH3wScSmwcy
 0i73l57AAJ8sltHJ7Umhifr/xqn5tJgNfzNt4fPgfhNpw50V4+1KUoCFd4oaP51yrr6l
 9u3Nh58us/P/SJmmvl1gwwNerkBc7BCptdjwseCrZ8kuNM0uLWi5t26AjkGGf864/7UM
 3ZnTgaIvzDGia/WFqkeaL00wOT/h5+/K05IN3zwn1AKr8s8aoFayXazXAvWshmg7XFHS
 W7QA==
X-Forwarded-Encrypted: i=1;
 AL+hErFnb+UWvSBbUA8peg/QNQ/s+LC1LhmThLfi3zM0kbzJT00RR4uVOy63Q25TZ+/eyUmXl8z292y+WWI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8JpX3gShMt5De/LZBZ8Updfw/uRhTdAeOQbx7YJCbQlCpp9kJy
 ZqvM00MhRa5hYzQnEG+bNFl2AJ6S/yuvSk8N2T9Da+DSZd5XKzBOivzZ1Wk0UjUnbVjZS9c3RC/
 jfesL3HGvxen7FbVUKkUp2IbmRfGBoARhsz0bOxMWyhUCq2fnAUirlx2tLSHnSzbVq01fJr0=
X-Gm-Gg: AZFdTZd9PBYirfAWOZSec1cRekLuhc/18kPDbT0VzS7EJDbXjTk0kGvQSXUDC2q2lR1
 uX0DwwXTCirCoKLnmzrFYX0p0famO1iZK6NdUAIMnMwamEERoUPxIQFg38B/MtHlJtpACHMXIsQ
 MjnIbCf+rTvKcjSi6d3RvLP4mAV31zG6gMiMoISS25ZheqEbSMTvLy2bqEjdpXp+HEttEiJlwaY
 XNd1g6lxXyFpgGnpcXcGJ8V1DTdJlYS5TQzbyANrs9d5FGrLl0fIDFC0fa/oWr8t629O/Pe9Ym6
 jblPDUepknnkIprWzfGAUGGZA38tVSFMbKsZkXcdTBfGPZVJqaShc2zsiCgHGjTG/kZd8Ggn7hf
 CDbNUXzJBeQutRx0IDZldNLTz6UesBvNOj7zw69yQWR666V8GPU5apYVgYzyOSR45nCflzRXKRg
 ==
X-Received: by 2002:a05:7300:d117:b0:36d:394d:e690 with SMTP id
 5a478bee46e88-38282cb705amr578479eec.40.1794953650652; 
 Tue, 17 Nov 2026 14:14:10 -0800 (PST)
X-Received: by 2002:a05:7300:d117:b0:36d:394d:e690 with SMTP id
 5a478bee46e88-38282cb705amr578453eec.40.1794953649982; 
 Tue, 17 Nov 2026 14:14:09 -0800 (PST)
Received: from [192.168.1.12] ([106.222.233.152])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a72eb2f3sm1066399eec.18.2026.11.17.14.14.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 14:14:09 -0800 (PST)
Message-ID: <079a8518-bca9-4f2a-89b5-eb2d17a910a8@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 03:44:01 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: qcom: nord: Add GPU cooling
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Aastha Pandey <aastha.pandey@oss.qualcomm.com>
References: <20261009-nord-gpu1-v1-0-a06a6c57bde7@oss.qualcomm.com>
 <20261009-nord-gpu1-v1-4-a06a6c57bde7@oss.qualcomm.com>
 <assC2v74wpr3AzI6@QCOM-aGQu4IUr3Y>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <assC2v74wpr3AzI6@QCOM-aGQu4IUr3Y>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA4OCBTYWx0ZWRfX4q8t5frGyxhE
 0KiRrw4joP0DgEMFnucYLZ8TZiLDeYgRZVoVTAgzATCQUxLx88yvts75a/qJEV01DDPXXM24KnB
 uyMwfdY+Oe8owyN/3hx/VI6aQ3jzi/Q=
X-Proofpoint-ORIG-GUID: Mo2j1Pajb2pTjNpy2jr_S9Lyy9JzK9JS
X-Proofpoint-GUID: Mo2j1Pajb2pTjNpy2jr_S9Lyy9JzK9JS
X-Authority-Analysis: v=2.4 cv=BIEmP1QG c=1 sm=1 tr=0 ts=6afcd1b3 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Q9FbUFTPKQUszr4Og8UIjA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=CYWSrXY8TNIhK36ftfwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA4OCBTYWx0ZWRfXzgu8t9Ekq9Zc
 YsZzXQeYKxuAUJjQISUxbuyewX4mC4B5mbJ5rlSXdTwX2H+t1/PTs/7Y5MT/QHXPlC50nH7hYcm
 ZSYiUvxyljTLUOuHFwuQ0tL/6gpU/epUocMGNtL9sZC1kT5OGmEatyjjH32xEzZDMiAj92R2R/Y
 CUVmNNL1Lstq8MsKi3nMwbO9LsOtjULOM6iPsZOtbwpbpUJEUM+1cNa0oQK5yUJ91SNSo1CR/7i
 kjBDQTuh5wNQLwcvwpL9c/fzvocyZco2ZWD5IaxE46JcwV1NB/jKl/M0I67xI3YnqyCrK5hcvkY
 zMc/fu1k85DWIEt25R5XPb3o/ge0+f1lGHeUebOLk1GWpdpOt3HEKJ0f36/PoRKcfMM5pwSYz2F
 6YbmHJ0TX82t1ST7YfghgIxbQUbEeOxLNdliVJJDStXiloCIS0XAqjGlDFd7LhYaEfjEEaxRS/J
 knei9A/5HjF95CfdNvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170088
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/11/2026 9:00 AM, Shawn Guo wrote:
> On Fri, Oct 09, 2026 at 02:36:38AM +0530, Akhil P Oommen wrote:
>> From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
>>
>> Unlike the CPU, the GPU does not throttle its speed automatically when
>> it reaches high temperatures.
>>
>> Set up GPU cooling on Nord by throttling the Adreno 753 GPU when it
>> reaches 105°C. Label the GPU thermal zones and their passive trip
>> points, map them to the GPU as a cooling device, and add a passive
>> polling delay so the thermal framework can monitor the zones while
>> throttling.
>>
>> Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/nord-embedded.dtsi | 177 ++++++++++++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/nord.dtsi          |  80 ++++++-------
>>  2 files changed, 217 insertions(+), 40 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi b/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
>> index 4379092b7bf8..23370007c974 100644
>> --- a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
>> @@ -17,6 +17,7 @@
>>  #include <dt-bindings/interconnect/qcom,nord-rpmh.h>
>>  #include <dt-bindings/power/qcom,rpmhpd.h>
>>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> +#include <dt-bindings/thermal/thermal.h>
>>  
>>  #include "nord.dtsi"
>>  
>> @@ -2042,3 +2043,179 @@ opp-403000000 {
>>  		};
>>  	};
>>  };
>> +
>> +&gpu_0_0_0_thermal {
>> +	polling-delay-passive = <10>;
>> +
>> +	cooling-maps {
>> +		map0 {
>> +			trip = <&gpu_0_0_0_alert0>;
>> +			cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +		};
>> +	};
>> +};
> 
> I'm not sure why this is Embedded variant specific. Can we not just
> update nord.dtsi as needed? Would that break GearVM variant in any way?

Only Embedded variant support dvfs scaling. So passive thermal mitigations
should be limited to that?

-Akhil.

> 
> Shawn

