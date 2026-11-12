Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63767606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 03:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IE8NhPF1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N1Cp77rK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FC5310E0BD;
	Thu, 12 Nov 2026 03:02:00 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB19E10E0BD
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 03:01:49 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC2ZTbs3158619
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 03:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GFlYTaZ/DTPqn5NM9gQvna8OY4eihfNgKjvdWrnQAxY=; b=IE8NhPF1wvBH1YRx
 1pJlvxUr4JzEIlPPTB8C4I28YPgzngJ4p2wa1tWyJY3ei+yzY6lgeLuKHu/kY+Hy
 /0+w3EoW+sBxOIpFHQFWl5jDdOOTebm+2xHegXiBsbLtTTIOcIoJBeSqU3ekm6UU
 cSAtVDK/jKmD2OdxW6zpP3j68K7AggCMsOWNvoaH2D+h5VnIcuUW5EPYXkS2RLaY
 nk0xUrzS3ynz0q7OqBJa1u8Zp2v4AngESTB4U87pJRgHBZBv+/9l3VVs0vkvpSbJ
 uaFuCkQRmmXzcBzdEvTgRtZ8EECBcr1QkANBXK2D1I3K3pLm07RZtBf5i07URELA
 trhFxg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvk7pv7wy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 03:01:49 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-536720195ebso76021701cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 19:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794452508; x=1795057308;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GFlYTaZ/DTPqn5NM9gQvna8OY4eihfNgKjvdWrnQAxY=;
 b=N1Cp77rKx6CTFms20lwUp7Rvx3+OJhlu8mwc8MauwBEjQkGBOLc7mH3uHXyos8LN6+
 L5Nl/Lra+wMI+GaqAoJHyVeUh3VYgLLDEZudtSW31u9S57+uhQBa1OjIUCBpk5pYLFbJ
 F6n4FdAPtiALrxHKGzpnxkawuILma0Kuf8Y50hwERYv9T3S40YeoKPEffp57Yd55sn7d
 o25T2wer6N0UTijMDDveUID8ALMqyUCGz9ashp1sulvmzI4sT1o3wcQ43zif/2JkVgG3
 r4RwOMXEhDBVh5+5A8tvVc3NInocKN1PglEkDGL7i8Fy5HogO5sRGtXiYSqCw1FaB2Iv
 209Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794452508; x=1795057308;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GFlYTaZ/DTPqn5NM9gQvna8OY4eihfNgKjvdWrnQAxY=;
 b=Q9zvT6/8FCRs+yEhgBqRr/IjDE6EYS9j7b8Jy364DXBYe2T3TJUC9VMng+cV7CWdr6
 gDvVVHhuyyJCKFDIj/8BE7Cn2HTB217B3OdwrnoMu5kyLHgxVZdTHQ3zWT0kmUaLuCvt
 n/ba8f6lqlKj2yvfuEy5CzvdgdeUNxrxILjRlL5V1a8rh7vi9EdJiTd2WhEJwFT+Knkm
 VfITktRDA7clVZPVYLuAUwPpWfYzJzzCBW3axvAu9p9KY6K+eoWvBwh9kDgVnHPQVQtC
 d34TnxqaXoVh7lOr5eKGrjEJmt0uoFn1tCE3HqoPsM6q1sFVlHX9huQ0ufcGAE31COeC
 u5Cg==
X-Forwarded-Encrypted: i=1;
 AL+hErGSa9Lz1GTIVZrIlu/X/nFeV0NkTZVwI/hZcZq0dMkmhpQc5a2gUMOKFfugf9lVZVeZR7kxTRTsAak=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8/Yiqqpu7QyJ5PXJOsj73WjohFO/e5Bjb7dI2k+7/PHsgQqcJj
 pv1sVDmaqGX39YARqKM6ucxAO0jmK1PhPRe0f8Zp/Sbd3pJIKzsdCJjEIwcZotBAu+9GqvkMvnz
 bRGbCjNDJJNEWzskEECgrpl9Tpvn6HO0GjvJWAwrom6T5SPVX3KLjBBjZDLFFxRldsB3lwo0=
X-Gm-Gg: AYBFou2AhMeS1p77tB2ymf2Cx8oSJIL9ZzDpr4f6U9aC4/vVJPOkdYyYD4KR62v5QgJ
 oeSH27ZlDcMBuOT98bPWb+7QWRrLqoSOodCIiy7pfpa8t00YUqaI+nLbWlEVNZ22cp/PqUh8Osm
 nEE0Q+7p9Cur11+BnlOKohiaHfOtFkUXBUp0ZP3BeqN3deMwN1L6NTVFJZP9OO9vq+FmOEj232g
 XOCPtDtiv1+nJBvE52b2cgeFbxzB9xLX59ssfqE6bTXrmkI1jMI6pljh/aiphonO5IAvENWY9sR
 0FY/kEy3O2l3bnvXV6igDpbRvYuStGCgyMdpoMSjLUyMqRqnDh+PTFfDobMBXmqC44wAkiAEWwU
 7Y+bMwwi904FJMC0VnS/JrsF65pUpDtzJFPhMDFy221Iis5UnsxbUT8Kkpm9WnVpnTn8j+Tz6kC
 TJ7mmHtEfwO/YslJFk4tHeaz67/dWN1BiLZ/rFTw==
X-Received: by 2002:a05:622a:1f8e:b0:535:1fe4:64df with SMTP id
 d75a77b69052e-556bf740b76mr71292611cf.12.1794452508090; 
 Wed, 11 Nov 2026 19:01:48 -0800 (PST)
X-Received: by 2002:a05:622a:1f8e:b0:535:1fe4:64df with SMTP id
 d75a77b69052e-556bf740b76mr71292031cf.12.1794452507574; 
 Wed, 11 Nov 2026 19:01:47 -0800 (PST)
Received: from [10.111.167.254] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5550b451570sm65260281cf.13.2026.11.11.19.01.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 19:01:47 -0800 (PST)
Message-ID: <c7d46cf6-04d3-4c77-b628-046693004891@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 11:01:37 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings: display: msm: Add INT2 GDSC to
 Kaanapali DPU
To: Krzysztof Kozlowski <krzk@kernel.org>
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Joonhoe Kim <26rote@gmail.com>
References: <20261109-msm_gdsc2-v5-0-4a3159b5e4b8@oss.qualcomm.com>
 <20261109-msm_gdsc2-v5-1-4a3159b5e4b8@oss.qualcomm.com>
 <20261109-mammoth-of-delightful-potency-b1ede2@quoll>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <20261109-mammoth-of-delightful-potency-b1ede2@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAxMSBTYWx0ZWRfXwxAbUcH4Haig
 3+y4QxyJ+N6SdBVYei+aq7xvVrQcyHFpi1sl/nVyF+1hEkudnoxKvgw48ASjkPRYT4nX6qYtEwI
 RRTLLOZPKCofI4CU0TDOUuBjhr/bR3s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAxMSBTYWx0ZWRfX2IldUBAtBNOT
 m6exQUW+CNDUOgpfLXwEcWrOMAOj6oDZMhVdwYGJ6/gQj3t0Dds0bVvQg9zxzr6QF4dTzd8OLKI
 CzLuCOGCwp2XhTyXoKpzJdYZowrtC3h865+6S+xq3Llt4pBH2NcbkugefKvTi/GE3pwdhJNcb4L
 tSumUu+vVJv4w1qcDELDto08ArcFLpLRO24WD6ENhzH2cmjU1M1S1YgE06Th9srcpN1lbp7rIa7
 YuyqOD3cw2/DfAgrNqp5vkNi4SiHa/wUJZ+LY9dwOWf8e/ZO8RdG1vr11xUObTeQOqBvlrAss+q
 SrTBe+SN1WiU1nyK6SZIWZG4Zq5F+uZTxDpMMgHAZXIhYALoIZ7xCVb+BfnZt1W7EWb5574nVty
 akujhUdpRM9o48Y7vtYjPWjLIXAKz5BX89zVG65a5d13gXUSA52FFS9kxOCs7adq3FFIMNXmgn/
 bE+xKsIbbKb2RF1gOzQ==
X-Proofpoint-GUID: VJyTGZaepaW-eYgUIfO1CUcg8sFAe8W2
X-Proofpoint-ORIG-GUID: VJyTGZaepaW-eYgUIfO1CUcg8sFAe8W2
X-Authority-Analysis: v=2.4 cv=BpcIUoX5 c=1 sm=1 tr=0 ts=6af52c1d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=pxrNA04Hk7ndIpWV2-sA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120011
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



On 11/9/2026 8:25 PM, Krzysztof Kozlowski wrote:
> On Mon, Nov 09, 2026 at 04:36:35PM +0800, Yongxing Mou wrote:
>> Kaanapali (SM8850) has two display GDSCs. CORE_GDSC supplies shared
>> MDSS hardware and most of the DPU, while INT2 GDSC supplies the
>> VIG2/VIG3/DMA5 source pipes. Without INT2 GDSC, these source pipes
>> remain inaccessible.
>>
>> Describe CORE and INT2 as power domains of the DPU device, matching
>> the hardware partitioning. INT2 only supplies DPU-local source pipes,
>> while CORE also remains attached to the parent MDSS device because it
>> supplies shared MDSS hardware. DPU performance-state votes on CORE are
>> propagated through the genpd hierarchy to its parent MMCX domain.
>>
>> Keep the widest valid power-domain constraint in dpu-common.yaml and
>> narrow it in each platform-specific binding. Require two domains and
>> their names for Kaanapali, while retaining the existing single-domain
>> constraint for all other DPU platforms.
>>
>> Repeat power-domains in qcom,sm8650-dpu.yaml because dtschema requires
>> power-domain-names to have a power-domains sibling in the same file.
>>
>> Tested-by: Joonhoe Kim <26rote@gmail.com>
> 
> Drop
> 
> Anyway, where did it happen? Nothing in v4, nothing in v3.
> 
Sorry for this mistake, will drop it next version.
> 
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   .../bindings/display/msm/dpu-common.yaml           |  3 +-
>>   .../bindings/display/msm/qcom,kaanapali-mdss.yaml  |  4 ++-
>>   .../bindings/display/msm/qcom,msm8998-dpu.yaml     |  3 ++
>>   .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  3 ++
>>   .../bindings/display/msm/qcom,sc7180-dpu.yaml      |  3 ++
>>   .../bindings/display/msm/qcom,sc7280-dpu.yaml      |  3 ++
>>   .../bindings/display/msm/qcom,sc8180x-dpu.yaml     |  3 ++
>>   .../bindings/display/msm/qcom,sdm845-dpu.yaml      |  3 ++
>>   .../bindings/display/msm/qcom,sm6115-dpu.yaml      |  3 ++
>>   .../bindings/display/msm/qcom,sm6150-dpu.yaml      |  3 ++
>>   .../bindings/display/msm/qcom,sm7150-dpu.yaml      |  3 ++
>>   .../bindings/display/msm/qcom,sm8150-dpu.yaml      |  3 ++
>>   .../bindings/display/msm/qcom,sm8650-dpu.yaml      | 34 ++++++++++++++++++++++
>>   13 files changed, 69 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/dpu-common.yaml b/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
>> index 3f953aa5e6949..c67199011f263 100644
>> --- a/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
>> @@ -26,7 +26,8 @@ properties:
>>       maxItems: 1
>>   
>>     power-domains:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 2
>>   
>>     operating-points-v2: true
>>     opp-table:
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
>> index 9f935defd6b12..6d6391970d6b6 100644
>> --- a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
>> @@ -125,7 +125,9 @@ examples:
>>   
>>               operating-points-v2 = <&mdp_opp_table>;
>>   
>> -            power-domains = <&rpmhpd RPMHPD_MMCX>;
>> +            power-domains = <&mdss_gdsc>,
>> +                            <&mdss_int2_gdsc>;
>> +            power-domain-names = "core", "int2";
>>   
>>               ports {
>>                   #address-cells = <1>;
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml
>> index d5a64c8a921f1..bded43a34b87d 100644
>> --- a/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml
>> @@ -15,6 +15,9 @@ properties:
>>     compatible:
>>       const: qcom,msm8998-dpu
>>   
>> +  power-domains:
>> +    maxItems: 1
>> +
>>     reg:
>>       items:
>>         - description: Address offset and size for mdp register set
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
>> index 034d3df8d2470..6c1476a0faaf5 100644
>> --- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
>> @@ -19,6 +19,9 @@ properties:
>>             - const: qcom,shikra-dpu
>>             - const: qcom,qcm2290-dpu
>>   
>> +  power-domains:
>> +    maxItems: 1
>> +
>>     reg:
>>       items:
>>         - description: Address offset and size for mdp register set
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
>> index 8137618237ce7..3fa0f02f44892 100644
>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
>> @@ -19,6 +19,9 @@ properties:
>>         - qcom,sm6350-dpu
>>         - qcom,sm6375-dpu
>>   
>> +  power-domains:
>> +    maxItems: 1
>> +
>>     reg:
>>       items:
>>         - description: Address offset and size for mdp register set
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
>> index df9ec15ad6c3c..7703d9b017cfc 100644
>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
>> @@ -24,6 +24,9 @@ properties:
>>         - qcom,sm8450-dpu
>>         - qcom,sm8550-dpu
>>   
>> +  power-domains:
>> +    maxItems: 1
>> +
>>     reg:
>>       items:
>>         - description: Address offset and size for mdp register set
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc8180x-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc8180x-dpu.yaml
>> index a411126708b80..8e10f9e0d1769 100644
>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sc8180x-dpu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sc8180x-dpu.yaml
>> @@ -15,6 +15,9 @@ properties:
>>     compatible:
>>       const: qcom,sc8180x-dpu
>>   
>> +  power-domains:
>> +    maxItems: 1
>> +
>>     reg:
>>       items:
>>         - description: Address offset and size for mdp register set
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml
>> index dc11fd421a27f..9dafe1d827e13 100644
>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml
>> @@ -17,6 +17,9 @@ properties:
>>         - qcom,sdm670-dpu
>>         - qcom,sdm845-dpu
>>   
>> +  power-domains:
>> +    maxItems: 1
>> +
>>     reg:
>>       items:
>>         - description: Address offset and size for mdp register set
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
>> index 510eb6c193649..173c2f034241c 100644
>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
>> @@ -15,6 +15,9 @@ properties:
>>     compatible:
>>       const: qcom,sm6115-dpu
>>   
>> +  power-domains:
>> +    maxItems: 1
>> +
>>     reg:
>>       items:
>>         - description: MDP register set
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-dpu.yaml
>> index 8cbf99f9fcba5..b8344ff8895ac 100644
>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-dpu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-dpu.yaml
>> @@ -16,6 +16,9 @@ properties:
>>     compatible:
>>       const: qcom,sm6150-dpu
>>   
>> +  power-domains:
>> +    maxItems: 1
>> +
>>     reg:
>>       items:
>>         - description: Address offset and size for mdp register set
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml
>> index c79b2d4428003..8e50942f3e1f2 100644
>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml
>> @@ -15,6 +15,9 @@ properties:
>>     compatible:
>>       const: qcom,sm7150-dpu
>>   
>> +  power-domains:
>> +    maxItems: 1
>> +
>>     reg:
>>       items:
>>         - description: Address offset and size for mdp register set
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml
>> index a88d22f30a602..b407bc3994620 100644
>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml
>> @@ -17,6 +17,9 @@ properties:
>>         - qcom,sm8150-dpu
>>         - qcom,sm8250-dpu
>>   
>> +  power-domains:
>> +    maxItems: 1
>> +
>>     reg:
>>       items:
>>         - description: Address offset and size for mdp register set
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
>> index aa0cf0ec5b93f..c3bf4e7ca1ffe 100644
>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
>> @@ -54,6 +54,15 @@ properties:
>>         - const: core
>>         - const: vsync
>>   
>> +  power-domains:
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  power-domain-names:
>> +    items:
>> +      - const: core
>> +      - const: int2
>> +
>>   required:
>>     - compatible
>>     - reg
>> @@ -61,6 +70,31 @@ required:
>>     - clocks
>>     - clock-names
>>   
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: qcom,kaanapali-dpu
>> +      required:
>> +        - compatible
> 
> Droo required
> 
>> +    then:
>> +      properties:
>> +        power-domains:
>> +          minItems: 2
>> +
>> +        power-domain-names:
>> +          minItems: 2
> 
> How did you resolve my previous comment?
> 
>> +
>> +      required:
>> +        - power-domain-names
> 
> Why adding this?
> 
> Best regards,
> Krzysztof
> 

