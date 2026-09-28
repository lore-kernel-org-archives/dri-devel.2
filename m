Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB84CA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 19:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34C2B10EB8E;
	Mon, 28 Sep 2026 19:05:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CTksQLh9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cWSah7hl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6B1410EB8E
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 19:05:22 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SHvvcJ3197223
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 19:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aUQXcc91Nms0mMqzegCYthYDa1bP/Fd/lJEybhf1XvQ=; b=CTksQLh9GRSRU5aC
 RkNBkiHcJRI7vkuzbXUnrgkGoX8I7HlKIE+HdNX9yhy8EwaM+Q6JN5vqkdKpcHEP
 mEI7zCQ16KNdzkfpOsPNQfq6FywVtWukivJn18kHmEi0YBB/4+sQA0vXQf4HVz+u
 y4IDpGwo2IhC3f7svhevQUVXTZI7MXu3j4dxNaW/9WRmgBsSZlaOQEOLMNfs2PyB
 ViyMR9jDPVjhPONgnLMD2DyYyD2K1KhelVxixgEm5+wDvG1jDdoZ9NlGkQoPVXyE
 IbpR9pNPWNunK9qS7qVg8rs7hPnLTz+ax30kmT9hgqBt2HkoCcebmSSoe8G5kYNh
 vJMD5w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyw03gbuf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 19:05:22 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso5721315eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 12:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790622321; x=1791227121;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aUQXcc91Nms0mMqzegCYthYDa1bP/Fd/lJEybhf1XvQ=;
 b=cWSah7hl5phU7vRb/hUhVurQPVTUcfnxBrJDVkhemBMvUbu+dACa6htNlOUwfdvZDn
 hfs6ltsHs0FE5rJ4+a3tl/hpbqeogJwW1kGxMegu4bnCdxaMquw6IopgvuoK3DibXO8t
 GKN0YatQM6BXc9G8xMF08C+WbZHXF9arCM3Hq0Fh5anuStA0iszopqDVZpPpVZB5zwGs
 aICh06gGsPXhHmxUjkB9kvE+1gGKMhaSBLspE9YRdVr0+lSzIX+EPyuXCnRDKc8wtBZz
 tQW8I0wW2b0uScr/VL2RXRzN/eNTjrNBoKi6RrQY2B2WEqfmTltWELe94Cfj8afJRw29
 ji0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790622321; x=1791227121;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aUQXcc91Nms0mMqzegCYthYDa1bP/Fd/lJEybhf1XvQ=;
 b=iFx3ZGdeXakZNNWPYu9GJa5LtEQZRyESOh3Cmw+LFMgfe4eeDd7cdCbGNAhpMchAZ0
 Ubj1ucS4z8dawjxVc6DfWHPBnpXigzCNah5CoqtyagG/ikExu+ILaAklCjCBdH3P96nF
 MUcNJMlrw+PY3v5FmTByDAsd24tp/MjeAK0Miq0BMuQfYJuu4h2J2uZv6Vxefvtpodxt
 0h6K1g3DxN+UrCHp78yLgVeKBVsvaP4kJejFjbeeSDJPnJ2mS5PDSBVqTHebkc5xneS8
 3PXUVZXqo9ZPg7qS2WJgntokphXXbBriDsQe1G2XtwsdwWR+RRbIF7HoueQB0obwrfnY
 HNSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqqnaY+x45HZTjeDGRxYTKiiBYI2ANifdAea5jvpPUiOTZwyXfJicKGTFI0P49jWdlnTpfsC5vUnA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL5zhOk9/DR9u5++jYtIVMG9VQMBWtSPn9o5XdeUUKwnj+xpimg
 cfBXi7USpY+4QWfJJQ62JdohNHgegT+d+/MpUuQCLZ/WBLY2UHr9sNRM3bwG3s6blJ77+w1b5U2
 R7u5CrKZ3/UgyzUuZsdbQHLUxJsIdQuF7h6ycqMjNE2WNj/4b8V5bhWClIjwcq+4OtMPH6z0=
X-Gm-Gg: AYBFou2r4AVdFn8z19khu/6PLUdhBzylBzyh9gs7vLcCaQ8Lr7N0jc5NWRkSwtA83FJ
 IQS2eadQE9RI6hKfw/9ErJQZ3gXIdlLyNBBrTuqAowfbCjSq82Is+74K0vb15ybZ2m5TGsRtK45
 6NhRkc6+6YxCUCF7AapzdAag6blR9btTtPeL+KZHqQAY7NYtEsaj8qYersdhq/7cwasT/gBLgNw
 qyouHgNCfp/lK7l2hdU67f3PC+7VF86ahmQO6h0AJm3VrBiOw1GtboOYYmb6TrpHSoFygXds1pG
 4B3uaPHUOczf9Cz7+b6Y9oz62JrJ46eK1bF/GtWYpXr9TKauZkigaNhzjvk6voZmqt1ToddWW6y
 9opoRIOZ4yAbMRbTeL/LUTOje
X-Received: by 2002:a05:7301:2811:b0:339:7572:7b2b with SMTP id
 5a478bee46e88-34271d8d7edmr12283289eec.24.1790622320463; 
 Mon, 28 Sep 2026 12:05:20 -0700 (PDT)
X-Received: by 2002:a05:7301:2811:b0:339:7572:7b2b with SMTP id
 5a478bee46e88-34271d8d7edmr12283193eec.24.1790622318728; 
 Mon, 28 Sep 2026 12:05:18 -0700 (PDT)
Received: from [10.204.104.211] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3434958c3adsm37771935eec.22.2026.09.28.12.05.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 12:05:17 -0700 (PDT)
Message-ID: <fac7522a-a9c8-497d-8753-e8c397ad581f@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 00:35:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: display/msm/gmu: Fix Glymur's compatible
To: Bjorn Andersson <andersson@kernel.org>
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
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio
 <konrad.dybcio@oss.qualcomm.com>, Jie Zhang <jie.zhang@oss.qualcomm.com>
References: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
 <20260925-mahua-gpu-v1-1-0fa0bfd8d315@oss.qualcomm.com>
 <arnTH0_tjrspIymm@zenbook>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <arnTH0_tjrspIymm@zenbook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA3NiBTYWx0ZWRfX9+FDRRYni4Qa
 L1zZfeZ4ntpwGxynNt5u5k/6npG+jyQBjstoOlFlYX6LPuLCDhVieEUq9Z2DCJnOY1U7rdoIxkc
 wq6nPSc1gh7ci/tRknfGJWIHmEKsKZM=
X-Authority-Analysis: v=2.4 cv=SIbXx+vH c=1 sm=1 tr=0 ts=6ababa72 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=QgEWrOWD1ie02Gccw6EA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA3NiBTYWx0ZWRfX/jpwZ2lJeCK2
 MpA8M0oPPXCZLWsgsk9O8mZvFXPTzIhUCs2A39KQsXYw/3Zo5Gt1IKjBjEnEFsyveC0opRUlSIs
 erCLInC9JxwX6Uv0U+ljFq+85OfO2qFiYb9GKPXODl0otSyc8LHPb9qGRvvBDvDilom8J685nBv
 dKli6d27W7Q57u5jG9tPvcJO4nkfCVKmsElsMBsdT/YUAVcAslSitMk/UxmxHqdOESYJZnUYhmR
 lieSpv2dpkX1y5lIbJgWkv0hoqTiGkZzRswzrDArI14IgNqCfq64aw3WSx2Nzf3WgVeUHiFIfEc
 RgpJ/SYggS4frQVNIMWuqE37ciSinHih32m4EI6x9vjeUA8KRR5uvZYM3m7m7QBfaapBvF9TqA1
 iLWHW3leiX14CjcPd00vjGVQExAniMgJz1VNFerX4Pwhzj0iBar96kZz7AGrBCKn3ikc4hvCGu5
 FepbwV6FzcjlLqa7HBQ==
X-Proofpoint-GUID: -D7ZgKzCQWOVDQdBGWQIVHOw8o7jDwh0
X-Proofpoint-ORIG-GUID: -D7ZgKzCQWOVDQdBGWQIVHOw8o7jDwh0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280076
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



On 9/28/2026 8:10 AM, Bjorn Andersson wrote:
> On Fri, Sep 25, 2026 at 02:44:32AM +0530, Akhil P Oommen wrote:
>> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
>>
>> The Glymur GMU compatible string was incorrectly documented as
>> qcom,adreno-gmu-x285.1. Fix it to use the correct string
>> qcom,adreno-gmu-x290.1.
>>
>> Fixes: 7bc29d5fb6fa ("dt-bindings: display/msm/gmu: Add Adreno X2-85 GMU")
>> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  Documentation/devicetree/bindings/display/msm/gmu.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
>> index 9e459f12ce3f..f22661447e7c 100644
>> --- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
>> @@ -363,7 +363,7 @@ allOf:
>>        properties:
>>          compatible:
>>            contains:
>> -            const: qcom,adreno-gmu-x285.1
>> +            const: qcom,adreno-gmu-x290.1
> 
> It would be preferrable if you add the new compatible and then once the
> dts has moved you remove the old one (i.e. after next -rc1) - that way
> my dtbs_check doesn't light up while we're trying to dance these patches
> into the different branches.

Sure. We can do that. Will drop this patch in the next rev.

-Akhil.
> 
> Regards,
> Bjorn
> 
>>      then:
>>        properties:
>>          reg:
>>
>> -- 
>> 2.55.0
>>

