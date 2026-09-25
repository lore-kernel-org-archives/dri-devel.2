Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F69DC98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 18:38:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C60E10E284;
	Fri, 25 Sep 2026 18:38:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="l1xVYDny";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dhKaw7nc";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 797AE10E284
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 18:38:55 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG1KIQ796571
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 18:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2cIaDPB2jrjmKp92BAerGSKxYnwWAOS+LZ4WV2GDak8=; b=l1xVYDnyYU4ON9kA
 6cX5tmolXrT3tPqzN91+rAuZjGTEapyzC0KeqDv6M+eI9fTOYXheLGfFudbJosS7
 CCqumcJ6J3FTRwRwzAbIaYy+Q9UqNmwunFlU98p+31OCgj5G6yl/VpW6Y3MfmzXl
 vknHzRit1CHEGEJ480Cfsyihj9ybc3icO0xOmUwIUajKR627Io7faKQjttOSejhm
 tmeKcvqO7ARHtqK20IX7upWV/I9HPQkeQIrne9K5rZlc9cHmuhypgflXS7zS98eO
 WVDnqB/9hcV0YajMNGSk+3yzxc6I+OEz8urtbL0uok6PlUU4Sv5lJ9uU0H/7cz92
 33+L0w==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq3asd7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 18:38:54 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1416f32fe11so310390c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 11:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790361533; x=1790966333;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2cIaDPB2jrjmKp92BAerGSKxYnwWAOS+LZ4WV2GDak8=;
 b=dhKaw7ncLLovIHcVMVhj0giiO+n5bbtaQzFGxcu6+kBDSZMy37oA9Jb8AJLD56wx2O
 ZQeegSvGJVsX8mjRwKP+xAcSM0lv75lxe9mHIXiCzrVTPPPUpagI6Q5YtWyb3hNDDtiI
 vkRtnK3Uo5JTNsEhEidw4F9hpxLbhhCPucfbgGqYZ8RNSEvYjGDDYJdb+uUyEH/YzIeI
 Reub89a9K+F6vEIJRVB9XWDDEuncjkMxDXk3Rn8UhFB7UJW191r1biFzZntT9RHuhTSj
 qVB5wZrOH9WstlQQ5LnFU93KnRctpeEaJKPddi9Hbw0Z3JZdq5aMjZULRMXoOzo0FlpD
 IkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790361533; x=1790966333;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2cIaDPB2jrjmKp92BAerGSKxYnwWAOS+LZ4WV2GDak8=;
 b=snT/xKQ5SgJ/cCTsY/fhfZqACEYs/QwccvdX2DY92w7XFJg128qqrEwneq2JVFOgMF
 y7BQYQ5U4XgXNzfsLr1RhO9KZZmT4EU9Z6TJ1iUiviYo4wWOJbNlGH7hjJlfSAjw/PC+
 LzKelEJEMgnNWmGaACw68YdQu8IZz7RXK5IFifTqEt0WR2LCalocKXNQJjRCfuWe+qI6
 2qoQOhBX9PW3zNT/J1qQspbrgdPYGg013CM40HsjSpX9SGu+cnQBRwQwnB+J4F712ttb
 Cr9qpxVCoBvGl6oSr4N1vjUyPWnD3rX96zNXJfRPVC7YnS+B5WvFhA5Wb61G4QnyZnAb
 zQww==
X-Gm-Message-State: AFuF++lVe7dDAFOrOvfE4dswbFwuGbm6mlWGP45i5+UBxFWNlM8pE3gz
 QtrhwO6mRJd7LF6eQLlNxQerTOyPmlE/3rpu75Ra1CLj6QIppf5QOETinxkehlzJbEMVnFjegZw
 p2lF5TTZUVdkGUCHiybcLUDYxM9nA1fd0Hp7HTnvOlAx2bsN8HfEZU9k6kd0zgU2QZhu0Fqc=
X-Gm-Gg: AYBFou1zCRNnnBpXW17M1C2Em0JVd3XCBfq2rSBXPxeOZ59Rh22TywGlqPbFBiEeAH7
 wRX9XgHWD4ffCwSVrEJpv8H5H+FGarllLkh3yqWX7sQjGXtCxEfzRrALajdWd9lX5ECapvQetn+
 XR5TMW9kpm9bWudoXwN8Ru11aKVGOH90RkHoF4pE8gxq9HSSJ0JW6d3J3qCIzXD/oLkNIWG/WYd
 pxP2HtJo6pCBEiDw2ig42Ra/Q0AV2Yv5KzY16pRZdndv/zFDr7zXOZa1PCb++AvORrMMbd5kJxH
 areHhAGG3tpHRj4SE+QMFBlWfKBTEcXQlLmu33pBgFGU1h7PlN5E71UnXZrUtlxTvn8wKcXIsZE
 Ath/ZfF7kcyXWMO/2I8NHUoVz
X-Received: by 2002:a05:701b:2701:b0:144:ed03:7bfb with SMTP id
 a92af1059eb24-146ce58aa89mr963737c88.12.1790361531323; 
 Fri, 25 Sep 2026 11:38:51 -0700 (PDT)
X-Received: by 2002:a05:701b:2701:b0:144:ed03:7bfb with SMTP id
 a92af1059eb24-146ce58aa89mr963587c88.12.1790361525878; 
 Fri, 25 Sep 2026 11:38:45 -0700 (PDT)
Received: from [10.204.104.211] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145ad8e43d2sm7915199c88.12.2026.09.25.11.38.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 11:38:45 -0700 (PDT)
Message-ID: <f14d9570-33ee-47f8-b0aa-baedba99e74e@oss.qualcomm.com>
Date: Sat, 26 Sep 2026 00:08:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] dt-bindings: display/msm: gpu: Document Mahua GPU/GMU
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>
References: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
 <20260925-mahua-gpu-v1-4-0fa0bfd8d315@oss.qualcomm.com>
 <20260924212222.76B251F000FF@smtp.kernel.org>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20260924212222.76B251F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX4QSxd3oonR41
 v+RG9x6yuXoRZg2tvmRJSA5Um9QhOX3ZNu/XGcYqIp8rs1GdB9c9DxW4hx7fliOZ/j2skc+b4Sf
 lEZwA4pxrKQH+R1Htu7DGDoSjoRlF9U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX/jO1aiUrIZBK
 QG8SDHf+iGZCXUKOMsU6+ARiqnh5Lag8qiQpnRTXLgPqIxxA2DJt8R+cFq6HAmksmSI5kmCUOQe
 YH6zaaRRkgdUeiIGaujwVpITsXdC6DB5qufwwuYTMO3bZ64SeVbJDRmwW+ao1Wv8O/M8yWquZS8
 ptwCzWDWIPf9E8yyfg3UigeGIMJIEZ5yL3ONJj91RHgjLiomYdD54pDxyrkMr73fDmr6pZpJuhn
 Q6NObOiVnazJlsDKPNCAIciuKZw7Ibz4n5/fvxKfhnD1CQLicrv/Vha7+COFWcf4FbE3WOu5HEZ
 9SgNe5jVkHvKndmll8X99MrLWZeX4k5ClQQ48xWDVj0+rN2Y9PriLjqH68lsn1j8vO9a3uPDbgn
 Tsb6e/EsbaGlOqt+LIPQRZgL5VW0NcEi9+tW4Nyt8k8WNksE9lTpeyekSdCqOHlTjie4QHs7Yc+
 oDUJeL3KoHP4ai1BfNA==
X-Authority-Analysis: v=2.4 cv=VuO2kO2n c=1 sm=1 tr=0 ts=6ab6bfbe cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bUMPAlxNVlhmAh4efsYA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: YVJUjBT82aHnKu3aOyFoz-XoZxF75K6g
X-Proofpoint-ORIG-GUID: YVJUjBT82aHnKu3aOyFoz-XoZxF75K6g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250074
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



On 9/25/2026 2:52 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] dt-bindings: display/msm/gpu: missing compatible string in reg constraints block
> --
> 
> commit 31fba47631141728d25d3c820a8da841bf562a70
> Author: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> dt-bindings: display/msm: gpu: Document Mahua GPU/GMU
> 
> Adreno X2-85 GPU found in mahua SoC belongs to the A8x family and
> is a smaller variant of X2-90 with fewer slices and smaller internal
> memories. Update the dt bindings documentation to describe this GPU
> along with it's GMU.
> 
>> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
>> index e5efe2d35ddcc..8a103f998dd87 100644
>> --- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
>> @@ -452,6 +452,7 @@ allOf:
>>                - qcom,adreno-43051401
>>                - qcom,adreno-44010000
>>                - qcom,adreno-44050a01
>> +              - qcom,adreno-44060000
> 
> [Severity: Medium]
> Does the new compatible string qcom,adreno-44060000 also need to be added
> to the earlier conditional block for the A8x GPU family?
> 
> Documentation/devicetree/bindings/display/msm/gpu.yaml:allOf.if
>   - if:
>       properties:
>         compatible:
>           contains:
>             enum:
>               - qcom,adreno-44010000
>               - qcom,adreno-44050a01
>               - qcom,adreno-44070001
>     then:
>       properties:
>         reg:
>           minItems: 2
>           maxItems: 2
> 
> Without it, the device tree schema will fail to enforce the correct register
> count of exactly 2 regions for the new Adreno X2-85 GPU variant when a device
> tree node is added with an incorrect number of reg regions. This allows
> invalid nodes to silently pass validation.

Ah! Missed this. Will fix it in the next rev.

-Akhil.
> 
>>                - qcom,adreno-44070001
>>  
>>      then: # Starting with A6xx, the clocks are usually defined in the GMU node
> 

