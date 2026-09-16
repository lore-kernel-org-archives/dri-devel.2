Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FFAC88E75
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 02:37:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AA8F10E093;
	Wed, 16 Sep 2026 02:37:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="J5cLV8lW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mt+98cCg";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A562110E093
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 02:37:52 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FLYYbh050486
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 02:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5Ot2irSkqtbh6OTjcjGmne0Mptvsr1+OiCwl1QsDtCg=; b=J5cLV8lWWy3Gu9xN
 DJGvI/tafSMffYE0TwJ3QJmo/LQubDlWYkF+OiNTTSJoJm38WRIRWVqMRwjLGv2y
 fsd3PFW3MNcCL1vJN0yA7sOi3XHEEiuRkuNKce6O/fvNm0Fmw1AI+sVIcABoHQGd
 AUKs7olhKw/7EI0MWUTVZ5QanTEmeD8TCQrTsx0QR7cS5odGS4fnSCeToB34jPfC
 Vo4AwuyKjRtAZMuPo0CiIZB7XrcdDD5nWeg6coB0NqhqNEBmFFcc/if/ZN3V7pS4
 wvNz+cz9cXV/36jAtV+UHDxc48mftmiuxlLQYdQqxAKEdCIOqR798bi403lDF4sz
 PybGdg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq9n629e9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 02:37:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39e087a18deso2288334a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 19:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789526271; x=1790131071;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5Ot2irSkqtbh6OTjcjGmne0Mptvsr1+OiCwl1QsDtCg=;
 b=Mt+98cCgI634qeXAjip0u2qY0oBlCfNesuw/U9boUhcLIYLVv0kR7E4TIVNpspWzi+
 N2ubVMuw56SseJhZWHgzpPOwvEcJJOMy/ttZP1rT72Z1dMrFh9CS1+piFVqmbm9EdpKW
 sGRf3OlfHXa13MxGC0jNUJnz7UC97xiK3/Lw7QGnAMo5wHTEAl+teT39OhoLo4jILkL7
 LfDCg/2ycYhcpxwCNTb4oCt5ZPrUgX9qqFRM44euxNR6HhJTYhm3MSDf0rU7CoJdukqe
 174RMon6zYmJTGPX+B6j9ihv4BTap0s7c5NyxSbJW7XNRq4iMyZ3E7n93Sw2QbE2HR7I
 6sfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789526271; x=1790131071;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Ot2irSkqtbh6OTjcjGmne0Mptvsr1+OiCwl1QsDtCg=;
 b=U+o8z5HsauCy1GKFv0ziCQQlRH92T2wR0EgNx8x1cB43HairKQI2wMycTNeygPRvbe
 bUlbE14CvDDp9vM5Q8wYFRqN+EXW2jmVWc7OWLVJQoluJXAl8RDAa9IGu4/G8JhBD2l4
 WSpF3cIxMK6k/MFz/YELcoV+6cCykITgeT/gIum18/sz626kgomNOJW14cxf5PgoKcxR
 extYkTU80PZ3cugKPoAuT2HQeVSdDTCdGb6yk5pGbJvRyYnmh22DtPTgIFqZUzaaA5v1
 tJEYAmjSk5CRLLeuBDv/Xm6l7pX4ePC/R5sN/s0Qgo85AfKYp/RTHtasoGCe5iWEGUs2
 bl2A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwzK00qOOXm9U4h180dGO2p3HqHTvY434k2H0vVK/8k9YQ2EUMJfXCEAwbEqW6WC62VwzEtxbylGhg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m49ztllz4txcJSd+fCooAbqMQj7WyXnecF/mKhp/FsHxzGzh0v
 GWn2EiW1ZpXeiTXJrXO+nwou7oiF0XoNmW9N96BNpVqB6n2SrhHR3dUAcNaVNowmEYpcQja4zMM
 RRFFa1HJaC4Ps+/pRLfAB0RExzV0EHvqotC0DIbNBhNP2aW/sBPoyudc0HB9Ts+dk2AosXFI=
X-Gm-Gg: AYBFou3iiUeaQYZp9N9wNOeLtxWR4cpgRYnZt79/QL5fjdz4QtMzslsJhU8qmBSopk3
 HV0iKWEw1F0ZcOZQS9AlmjjQIwUqrFXFH663pH9v9lHDxCkskGpbelRyxB0ScUgY4XT3nCF8VQ5
 CjM9P+m2HYCUfzf/vWG/GAMbQZKcAVLJzxPYQGNRYuIvlsiU1Sw34GgUbkfOUJBRInvrNH4v2Dj
 48KPUeRSNBQP1LptOyDEddPK53NCzZ0YkG+MnrPYmiHNQxnPH91DMPgfOXPQgrErMRttacOCHP8
 z/RP+ogp2Te92VzCPruQ5L8fq0fQYr6F3nIX7iF1B+UZBh3LS4YINZXRmKyOCQoMJotgV9CHed8
 A8Iqd8UMLomwjnjZdqXKahwQpFas=
X-Received: by 2002:a17:90b:4b83:b0:398:9bd5:490b with SMTP id
 98e67ed59e1d1-39e1e4c4687mr2128071a91.18.1789526271233; 
 Tue, 15 Sep 2026 19:37:51 -0700 (PDT)
X-Received: by 2002:a17:90b:4b83:b0:398:9bd5:490b with SMTP id
 98e67ed59e1d1-39e1e4c4687mr2128005a91.18.1789526270731; 
 Tue, 15 Sep 2026 19:37:50 -0700 (PDT)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e19d2c925sm649854a91.1.2026.09.15.19.37.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 19:37:50 -0700 (PDT)
Message-ID: <4d3ab72a-bdc8-4bbf-9c27-c5bd124f3ba4@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 10:37:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: display: msm: Add INT2 GDSC to
 Kaanapali DPU
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Abel Vesa <abelvesa@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Maxime Ripard
 <mripard@kernel.org>, linux-kernel@vger.kernel.org,
 David Airlie <airlied@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Simona Vetter <simona@ffwll.ch>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Sean Paul <sean@poorly.run>, Jessica Zhang <jesszhan0024@gmail.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Conor Dooley
 <conor+dt@kernel.org>, freedreno@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20260915-msm_gdsc2-v2-0-9157237b8382@oss.qualcomm.com>
 <20260915-msm_gdsc2-v2-1-9157237b8382@oss.qualcomm.com>
 <178947727730.1548829.13172666413996021793.robh@kernel.org>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <178947727730.1548829.13172666413996021793.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BdVNQbt2 c=1 sm=1 tr=0 ts=6aaa0100 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=WLdAmb08tD0yJPlYAzsA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDAzNCBTYWx0ZWRfX41c4ykC9kcL7
 dICB33XzWAKHp72HbzXxCBCo8BPguqeNxcF7YMP6Ci8eSYImHMMoZDfj5dRpQflBfmtBEtY31NF
 ILz9DjiE1powq4Ai7Dlb7/b8S1GnWnUiGH/Vy0sOw53mbHsnqYWaxWLveKEMSnROP5OW8Czf6BT
 p3IyeX9g7chKA62Kq9Z2jMlXNGy8ePw1yDOTzJqEIJbzm68pZsSs+b5aBIfz3Pkf9zDYb6dg4oW
 epoMD0WlHE7q+Kar+Hfrzzsm5PnJCu/1TN8/BLIuTHq+kuF9Q9JeTQ7Hkl1AIhA37Nx2cRfUJh5
 pKi0BpQNsPqGqjrFTfPVvXsRHVrqqD07w2h7vQDLbNegz4iKqjfR/6uw2rur+DZ/FexVq5VmU02
 hLlI2i/2mB1CgXeFCWzzmsbh7uFNyU75bSY7TK5sCj8XXkvOlBK1gkW7D28bPjwavNGCKD/GtKM
 mhY2GvlCnLTTIR7mvzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDAzNCBTYWx0ZWRfX0rjdO3hRTuX+
 x/Az/5p58wnQm0NTEEtoNGiCZC00fYNPB4yYBSV/TciY9MQWDLJ1qGCvcHF3Jdj0bMqzfeDBVyH
 zV0UcF9hIk6bmMAvKioFHyv0z01BFM8=
X-Proofpoint-GUID: OQXpOYxzxyCwYIbq9fezfThOQQbd99sI
X-Proofpoint-ORIG-GUID: OQXpOYxzxyCwYIbq9fezfThOQQbd99sI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160034
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



On 9/16/2026 3:34 AM, Rob Herring (Arm) wrote:
> 
> On Tue, 15 Sep 2026 17:27:48 +0800, Yongxing Mou wrote:
>> Kaanapali (SM8850) has an additional INT2 GDSC that powers a subset
>> of the DPU source pipes (VIG2/VIG3/DMA5), on top of the CORE_GDSC
>> that powers the rest of the MDSS hardware.
>>
>> Describe INT2 GDSC as an additional power domain of the DPU device
>> rather than of the whole MDSS, since it only supplies DPU-local
>> source pipes. Restrict the schema change to the Kaanapali DPU
>> compatible via an if/then, so other platforms sharing
>> qcom,sm8650-dpu.yaml (which don't have an INT2 GDSC) keep the
>> existing single power-domain constraint.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   .../bindings/display/msm/dpu-common.yaml           | 19 ++++++++++++++++--
>>   .../bindings/display/msm/qcom,sm8650-dpu.yaml      | 23 ++++++++++++++++++++++
>>   2 files changed, 40 insertions(+), 2 deletions(-)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml: allOf:0:then:properties:power-domain-names: {'minItems': 2, 'maxItems': 2, 'items': [{'const': 'mmcx'}, {'const': 'int2'}]} should not be valid under {'required': ['maxItems']}
> 	hint: "maxItems" is not needed with an "items" list
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml: allOf:0:then:properties:power-domain-names: 'oneOf' conditional failed, one must be fixed:
> 	False schema does not allow 2
> 	[{'const': 'mmcx'}, {'const': 'int2'}] is too long
> 	[{'const': 'mmcx'}, {'const': 'int2'}] is too short
> 	1 was expected
> 	hint: "minItems" is only needed if less than the "items" list length
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml
> Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.example.dtb: display-controller@9801000 (qcom,kaanapali-dpu): power-domains: [[4294967295, 6]] is too short
> 	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-dpu.yaml
> Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.example.dtb: display-controller@9801000 (qcom,kaanapali-dpu): power-domains: [[4294967295, 6]] is too short
> 	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-dpu.yaml
> Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.example.dtb: display-controller@9801000 (qcom,kaanapali-dpu): 'power-domain-names' is a required property
> 	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-dpu.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.kernel.org/project/devicetree/patch/20260915-msm_gdsc2-v2-1-9157237b8382@oss.qualcomm.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 
You're right, that's a mistake on my side. I'll address it in v3.
