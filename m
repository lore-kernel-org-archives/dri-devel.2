Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4772B606A31D
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cKo3fbec;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IOJMMKQz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99EF410FDB8;
	Wed, 21 Oct 2026 12:00:53 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A64010F9BA
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 12:00:42 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LBgJB8184019
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 12:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7492lyDGCMJVk5RTZk51iOq1Kd3H7jR4clDwOkE2Xww=; b=cKo3fbechJkj0j7V
 /mI6/lX0+qidNJxs+cN+0pFj98rmr64pq4aGnU6tCHb7h3VnwzQ86KmbuH4XCbGQ
 P/W9T4/49uonL0sr3trUtcZRVUPJvU8DNa5RivotrTAdnwuH1n0fEmgC+vi2x5fN
 Rz7RLqiBtdUhnJ4rKS28zPImZf+jI5Q/h8mz2N38Kbbi4Ez1S4SyIWXsY7bFR8at
 Ob1794tBR9wqLjHB3C/HP04bPHHF0WFz1APOcNp+mL+g1FxHQL0wZk+SuEAHiPUF
 FHDFl5HY0AV2w1EEx0Sp43bIFhtMKwe1qNHzJMBItOtOBtvWG9aP68OBD+UZQxar
 /g1OkQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9hur7s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 12:00:40 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cd6532dbd7bso406058a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 05:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792584040; x=1793188840;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7492lyDGCMJVk5RTZk51iOq1Kd3H7jR4clDwOkE2Xww=;
 b=IOJMMKQz3HQbApMwyhHAdurK3EX8K5Y+uQ1cme+imuINfBt/R+Jrez1iJ4xz8CJY9H
 6+xRVs0aTdG5nrQjEfg3/e2AZ/5PH1ZoSsT7hRV3bfWnd7UNFpCj53E018J9PlYs9L/t
 SQwUOfNOR3UMDynJronWzKhaS6BigONdhiaP6qy+3SXDBaZsjH4ZYeauME3IBZgpvCuO
 oDoUKprkcC9DbWr4+QbfEEVt0aHYmzDupj0/IVT3S5Q78hK4NLqN2sEriSc79lGVqug7
 2t+V6S8f+SGH5SWocmi+2gLF6K3dAgXQr259ocYFXx9SD2WLZ9CtdYRKji19H95mfbzb
 Xd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792584040; x=1793188840;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7492lyDGCMJVk5RTZk51iOq1Kd3H7jR4clDwOkE2Xww=;
 b=l3isql+9yLM7HTSLimH/8CXd02gfRuc/BxP9/hE7wTUv5VpGZmfcoeKFWkKnuSVtCX
 GKRU0YUPbSYpiXJUUZJpIrWWtg3Ygvb4gnQazZzgq7Dq/ieLrHMpQAnmYFN/qiJKcngT
 L+TtblrTtllFqUsN0CSWfuevkKfoh5KRA+G+E1amSQRHK/jxZn/QWLRsLJwdtjVXnAN+
 sNRHAk8yaePiRrckARV0pvUnD2YUbw/r6G9esEJK2W6xBvDokKTRhONvOMlCmnfiF43x
 IkyPH44f83yq914ApE8ATVJmwU1pkdbZ5/RAmW50i6s/7xO8f+q6lLWPNntqJ5M9IGLm
 Ualg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwHzR3jVqU88CNRh/MzkFf437VJ80EKeqYJZNaH6rz0ovzuqfdMeOBMKLOqoU65RigcyjB8lK6fjPQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLYqGufujZauRb+TXzZdBj6Mi6Em9wY7eZ4+R6eOlbgJghXF9c4
 scV/is/lp9tgnbrMDErPZelpoLAyn75l86ad+zwV0yMNpxCYOsc7I7TBRi/HSmSy20dWcutwNU0
 9i+sHOdPbG0Q0N4/RlFVDwKeHXLzekJj8XJVqCyp14Un1R1EAawQS6KRviyW7TRs3fmR/Ea4=
X-Gm-Gg: AYBFou0Ih46TsJRvrxecbYL6XBHRvP2X+tpYOqflujeRMIQzRKz922hypTV0oYG/jU1
 BfDS/1hxAlKu/vNoTjggFfkkzy9SnVAIaMDi2oAENjYvJ06wQeQCkwCN8XdxXWsZOSUCvcFr9v0
 +eJxOtCd3zPcOvHwr2TykLx1EUA+4ZnVPvJIyY3EVCJTs+9VwZhPYs+9GLlFOpMiCV07tQqdDuj
 PB/GCIGEqQr3OP3elB/wq6XVxKNbqpVuxRUvweGgBiCh9yuXiQw67mJFWhBR29hQjtkTSvbi22J
 k7Ju6mII3sdvWneP1QSUDDQpOuQHQ5r3TEvvCw8wcv80PqSGfK/VI/l1GOLJ+q8LGQUd5pvREG1
 +1j4kK9eL3R7JPCCCa1YZ9B2FbK8B
X-Received: by 2002:a17:903:2309:b0:2e9:4243:431d with SMTP id
 d9443c01a7336-2ea439a650bmr14235765ad.30.1792584039425; 
 Wed, 21 Oct 2026 05:00:39 -0700 (PDT)
X-Received: by 2002:a17:903:2309:b0:2e9:4243:431d with SMTP id
 d9443c01a7336-2ea439a650bmr14234645ad.30.1792584038003; 
 Wed, 21 Oct 2026 05:00:38 -0700 (PDT)
Received: from [10.204.78.119] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea3b486965sm10235045ad.63.2026.10.21.05.00.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 05:00:37 -0700 (PDT)
Message-ID: <dd18e6d5-cb7b-407f-8e7a-2c6fd00359cb@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 17:30:27 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] dt-bindings: display: msm: Document the Nord
 DiplayPort controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
 <20261012-nord-drv-dt-v2-2-a2ab9af954d2@oss.qualcomm.com>
 <20261013-tangible-wakeful-swift-a38f8f@quoll>
 <20261013-honored-bear-of-cleaning-bd8108@quoll>
 <425ddb41-cfd7-4032-8666-0193ab6b5819@oss.qualcomm.com>
 <565fd4c2-2d5a-4c2a-9ed1-c7bcb17efc9d@kernel.org>
Content-Language: en-GB
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
In-Reply-To: <565fd4c2-2d5a-4c2a-9ed1-c7bcb17efc9d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YuKa1IYX c=1 sm=1 tr=0 ts=6ad8a968 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=rLXGX9pe2IGxD4WxI2MA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0NyBTYWx0ZWRfX7Ybkz8LYFEF/
 9EQ4dx8ScgMQzvd6sAhLkTfmT3h6lMeQUrwub0MfP42tKabuVO4gM2IRAOGnsSgKy5K69t7sdT4
 och2zmfBV7iF+Api8/X+Wu9HlzAX9VM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0NyBTYWx0ZWRfX5OlPuUDRqDvs
 xRUKNbM9sV9f9iCFb5CjlvAyW6zvk6UllhqEMKZ/Xmx7mdCNNxGo8pX3oFS+MOi7XAM4c2jktFr
 URa2tuRPrkSUCGBcfw0PD1bGsWfzuzLvuSOT1dfA1TM/bhKymRD/JdqREO24R22XAki+Q4r7hcc
 yh8gjjbYxfnpHbscglMjssOyZz9ofI0T8qhUnzpc/Fk5132i+FqzGyNmrs3Iij3gu9njLEOl51r
 bF/Spq8G65HtEcTTi84ox4K9TCIA8BGUNpy6y09p/btlAAOWrDV4QeEYRvMILNdc7dGq2gd7jBV
 6UDB94aIkBANPxDR4s5HF8yRlbRLK6s9BwKyFob7GWp7/SANv69AMoW61L0RUqRiHKtCsTxSj/V
 hsc568rKZu560vvOtk/zR2JaHLnVGznpxK3w+GVcsnNDf3LRLwZ5T2Ye4uJa2sXSVKQbH2EKzsW
 PjWgZXuwCTqFiC5qITQ==
X-Proofpoint-GUID: EXaQly6ehCI-WmKMrULekEreN17Zh6Nz
X-Proofpoint-ORIG-GUID: EXaQly6ehCI-WmKMrULekEreN17Zh6Nz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210047
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/21/2026 5:23 PM, Krzysztof Kozlowski wrote:
> On 21/10/2026 13:16, Nabige Aala wrote:
>> On 10/13/2026 2:18 PM, Krzysztof Kozlowski wrote:
>>> On Tue, Oct 13, 2026 at 09:44:15AM +0200, Krzysztof Kozlowski wrote:
>>>> On Mon, Oct 12, 2026 at 07:02:12PM +0530, Nabige Aala wrote:
>>>>> From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
>>>>>
>>>>> Nord uses MDSS 12.1 with two independent DP controller instances,
>>>>> each exposing two DP cores at new IO offsets. None of the existing
>>>>> compatibles match this layout, so add qcom,nord-dp.
>>>>>
>>>>> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
>>>>> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
>>>> Do I understand correctly:
>>>> Device is fully compatible with qcom,sa8775p-dp, but a simple to fix
>>>> driver limitation is preventing compatibility?
>>>>
>>>> If so, let's fix the driver - just add more addresses to the
>>>> msm_dp_desc_sa8775p array?
>>> Or it does not matter, because top-level MDSS anyway cannot use
>>> compatibility?
>> For MDSS0, the DP register offsets are same to those used on SA8775P.
>> However, the MDSS1 DP register offsets differ from SA8775P, and Nord
>> also utilizes a different MDSS instance. Because of these differences,
>> we introduced a separate compatible string for Nord.
>>
>> Are you suggesting that Nord should reuse the "msm_dp_desc_sa8775p"?
>> This would also pollute the sa8775p's desc table.
> What are the differences? Only registers, so no pollution. You just need
> them to match IDs.

Yes, only registers are changed.

Okay, I'll update the SA8775P descriptor table to also support Nord and 
drop the "qcom,nord-dp" compatible string change.

>
> Best regards,
> Krzysztof
