Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E159CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:18:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5FA410E424;
	Wed,  7 Oct 2026 10:18:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bz/a26ko";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D1nMvAu5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3059410E424
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 10:18:41 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jgB03334712
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 10:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MdDgnRU3NVC8pLT6LKmoyDAgBsbTkHtw5cLkuU4+x+s=; b=bz/a26kogg7pvygk
 JMGOJzgFcCT2PlTAwrtLobdJz1k0whyTRQn1Nd4/kumzpbaGbGV5Q4SQGRdZ/jLY
 XHgAofQXYAOfBKaqwHE/y+C5yNpGm/3l8yIby+LWcjkAPqK1mIWb9qbtdeZam1kM
 0gWoL83AAjOFtssperng+tMhF8bemEUXwyF4XwsL/k24lR0IEhFgCRcXYsqH1J3Q
 JoDhlSlaSdpPies/ALeZxdvjTo9rZmFna+tz4HyNYcorXa5v8JGAQ0xiWzNtqC7r
 mcAynbm9fyfTFrt2a6DE2fR2fzdZbbQs/VGG4bcI7RkqQE5G3oBCloWgL4RQ8Z5r
 7Y2vSQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h54623k52-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 10:18:40 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cec4226c70so37805655ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791368320; x=1791973120;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MdDgnRU3NVC8pLT6LKmoyDAgBsbTkHtw5cLkuU4+x+s=;
 b=D1nMvAu5lqONXB7ievIL8mLd0x18D0PmI4vLgmmf2cHUOZqdOwQPKmPJH8ODoB+kBS
 dqSRu0+8LX2odJeOCamJRIWNRbIiaMdryVB28T1JQH/n6Hqgzdf+w/tDKU33EjXen00i
 jhjad/d4CYXMNZmYmi15kXc4ZFZ4qhUBV9GT5xNb21A7+WueekoCVQaeZpTfK+EtkKge
 e+ToDXPDuQgva38bo+9D7Co70J911JjnLZ7XkLB2OnQwUxxGh+pb6HeruoFp1wt1LM5a
 EF+7Ma1R5R4SerdafO4Ub0rndM8MkE6ryIu5nUCgFVFG1svNz4yzWKm18yLeZglWxKOW
 N9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791368320; x=1791973120;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MdDgnRU3NVC8pLT6LKmoyDAgBsbTkHtw5cLkuU4+x+s=;
 b=DPiFxOgYJ1XZDyBa6W0JQc50/rvRTNVuZFvZ9x4U3zSVmgaLwZBb1T2xhYe6K5bVnx
 6EBGJp9fcZoavCTwCYT9mo3K0f+3YsMDQ8NuwlcvAo+v0kLD7yu8tR6lkyYeje6NJIIG
 u4nzXdK0mnj8X/JWOVr5pXdS20IZdKcKoi3NHWC1Jw+y4WdDvMud8DiCmXR1oRBFEbPR
 lu4loCLVIViE27OifGA5+2Rv+imbDE1EVTh90A1is7vHtjydWoO+mtcfS6eZid3kCGdX
 JCYz40YMG5EIRw/MMJCNw8U21eEiOdhiXMI3a9NtVKih1/9V1l4Ex/WFp8BlTLms+NU3
 f4hg==
X-Forwarded-Encrypted: i=1;
 AKwUvByowjSYv+6aq01dXSWJo5hwNu86FfwHf+02Yo4wK/QqeAEzLMOQflzfABmff7KkyMK8mIvCo4o3BAY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL5PaXmMo3+FOsEaXWqEY8/qySJTYhRlOu9GPIGEo+0F5/cGWV9
 Yy8h4gIP4IWEJx5vsdry34iIX47h6IA9TJOulc0coVxP/sT80SeyBrQBJWaZ+u+OfyIURwlTk+E
 9ULQ/FtGnOyvv+LQEbIyz2HKTJBiyl8i18zLZfrird/nAEv1fyl27GWwJOMI7VXlcwzaaJx4=
X-Gm-Gg: AYBFou2ZPZxLEkzAbjU8fWCCmCGyE3/dm5sh5S7UCcb1ujGpDXqpI3Xdd9L8VWqp+eC
 KouWQszfyLMiII0p9iWUm0hI1JY7fmQiz+rnp/rVRiqZmdvMq2ATLoV5M+FrU+r/FN47nxpopyq
 eyOqnXyQYrjrNYEEpo+0TEhgPymCncVnDeqJ7lAAcxr7CTpuT6qbXht9Skywf4gh9IF7sp/7V0i
 sDA3J/yCMz7ti7JFMGa9hYG2KaVDTxITkm3tksO90XX4jm16AaKWeKrnUi4jkcmiW0xiaEpBh80
 HvzD6NNk/vei2p3N+M/o/NYqlxnk2sQvb65sCLf5GaKyuXqiK8sBrjLSfih1BO6e5fK5eUubmN0
 OeXB5sonGIF02iedDR0hA6/1i2Qkw
X-Received: by 2002:a17:902:d990:b0:2e6:25e3:b363 with SMTP id
 d9443c01a7336-2e625e3bc79mr937115ad.37.1791368319880; 
 Wed, 07 Oct 2026 03:18:39 -0700 (PDT)
X-Received: by 2002:a17:902:d990:b0:2e6:25e3:b363 with SMTP id
 d9443c01a7336-2e625e3bc79mr936765ad.37.1791368319398; 
 Wed, 07 Oct 2026 03:18:39 -0700 (PDT)
Received: from [10.219.57.162] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e604a558c2sm7495745ad.74.2026.10.07.03.18.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 03:18:38 -0700 (PDT)
Message-ID: <a821cc9f-a2ed-4a43-a7d1-1597f50f95f5@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 15:48:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: glymur: Fix fastrpc compute-cb
 reg values for cdsp
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Mahima Bhattaram <mbhattar@qti.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20261006-glymur-dtfix-v3-0-44e2bc5370c2@oss.qualcomm.com>
 <20261006-glymur-dtfix-v3-2-44e2bc5370c2@oss.qualcomm.com>
 <20261007082748.bcdhzhqsrl25nimu@hu-mojha-hyd.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20261007082748.bcdhzhqsrl25nimu@hu-mojha-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wyOFZThLT_A3Xuug165RvytNyTIDZ1ZO
X-Authority-Analysis: v=2.4 cv=ZZiIpcVA c=1 sm=1 tr=0 ts=6ac61c80 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=SYeg_LyZQ0ZiSJgYx_IA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0MCBTYWx0ZWRfX9FX2qPmjIk6f
 4DGn5Y/87TVVwE7pcVU2+sGD1PsQBKqrWpkRz5O6XO+v3nYspS4/7idctmaSE6lJWZO0//REyrM
 Xo4+YUYU5Yc7203yF29QALzJCcr+jKU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0MCBTYWx0ZWRfX4qlt4EGJ2Tvf
 hR6zYoupaBG5iJOhCg1NRPQ2ugwKxWAeZAZIvd3eJVFZckYUU7gfuByXrdIaIN/nHIsBls5u+8M
 4FMeVZlT8Dv6ncK6+upY70menfsKbxmyLVNC3ZD44B+PjLTe530JvyCkZL3HdjqLAXoE2QXZZWG
 ycrs1aiRr1J5wiI1gN9oB3hGV6Cr5LWDk5OtuWg+rgwCD8SdXQep0EVr6VBk6T16dNCd1SDNs+t
 M+N7GhfYm6Mwn0nFQ1WtUGNduN29Mc4jvdbwodLD1UOxnPiu9r23r3g4FNFRd3bF+8rqV/5OXIq
 6EoUPB+9sOT0Ezu7cJhdNBpHJq9imvN7l4b8wcXzfifL44ooC1JdeAKVfKrEmszJA1nuNj8UpB8
 ng6bKPv/iXBvskSMZpCRksJFvVH9C9xNFS3Oz95eTRCCcwkygIKzmC7O2JprVfHlRxjqG5FQuwn
 slMgX9McmoDfhidMoBw==
X-Proofpoint-ORIG-GUID: wyOFZThLT_A3Xuug165RvytNyTIDZ1ZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070040
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

On 07-10-2026 13:57, Mukesh Ojha wrote:
> On Tue, Oct 06, 2026 at 03:56:07PM +0530, Ekansh Gupta wrote:
>> The reg value of a compute-cb node must match the SID (the lower
>> nibble of its IOMMU stream ID) it is associated with. In the cdsp
>> fastrpc node, compute-cb@10, compute-cb@11 and compute-cb@12 were
>> mistakenly given reg values of 10, 11 and 12 instead of 12, 13 and
>> 14, which don't match their SIDs and leads to SMMU translation errors.
>> Fix the reg values, and rename the nodes accordingly.
>>
>> Fixes: cd1d174c75f7 ("arm64: dts: qcom: glymur: Add ADSP and CDSP for Glymur SoC")
>> Co-developed-by: Mahima Bhattaram <mbhattar@qti.qualcomm.com>
>> Signed-off-by: Mahima Bhattaram <mbhattar@qti.qualcomm.com>
>> Reviewed-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> If it is possible to cover all the SoCs like Hawi wherever this issue is
> there ?
ack, I'll send out a separate series fixing for all the other platforms.>

