Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DF010854DB
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBF0010E732;
	Wed, 18 Mar 2026 09:29:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="U14DPW38";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CK4s8/LZ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9761910E732
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:29:39 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62I8JPQn2789430
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qcq6dUgwIcdFxzE+BZSA4BFJfvtn0+PADSHAnzt+B+w=; b=U14DPW38SQkZw5r1
 oiWV6NcclsHyV8iJc3eLguzUZYJSz+btkeelcvUfGFzsfwimNZ39D8nIuSX5aFtC
 VCVYgaGjP+C9y8AJlp4oevQR+HcEe8/LS4gsSXeMHDepnUlgGzaUqtoOX0YcE/by
 hy/DzT8eziRcrSPnoP4kngyyTZw53SxuK4SiyCB3fi4uGUXdXMOm/wG/muHz/UZj
 KgvjCGDRKn9QSdELPmBxwq5O6i6m+ZIG8NKdEyjqkuhClmmLUmPmg1Qp9c7I/qXR
 p0XfYbOzjFsY+LcQFg/gcTTb269VnHEwWiRnEFBWzvbOMpedbnA/xG5DO56c9feB
 xKXZ8g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyj4g1w61-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:29:39 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-89a01982dc5so60773026d6.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 02:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773826178; x=1774430978;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qcq6dUgwIcdFxzE+BZSA4BFJfvtn0+PADSHAnzt+B+w=;
 b=CK4s8/LZYSBNJ4b5ftbQPjx/2r2tbBKpx476KJAjZUqJplyiiDvPDXIqWjorIXKcl+
 MuEDYZziHO1+X7eg66mdndGC3SVGlMvZeRTmz1k0WmqmtF3ok0tdXYooSU/k+qC8PzJa
 DtwZeMpkAAiqvVBw8koSn9dZuIvqePnFMIaWA3K/WuPYYvKlpseK7bqArmKgiAkf3vH1
 P7RNODdQUB1O1HmE6txrJpPgC8z/kjsG6GmPKyhOm2smwF8jVHKQaEgw6SG275ZqOOiC
 rJOi1ySxQnjyI3cxbRpue61nKTjkAkXqI4yRreqHMxPecylOAUfS7/Z2/SURo8n7TLYl
 ofhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773826178; x=1774430978;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qcq6dUgwIcdFxzE+BZSA4BFJfvtn0+PADSHAnzt+B+w=;
 b=U08gPcTDSFON4D6myf/ehF814VzLP6Gb9lyRFb0x0A6eBOewiFzA8bnhONHjLViEE8
 FJ83NbnEalXcd7j0vgumuuQGx+t+8EeY8fKuvdZ0Yw1aWaIP474U4YxcgiXo1NRn8j9w
 74+M+JHASmng+IM8msPX87ARTXnHr5F/qkRGOr4d43/Pt1ZkB2cWkBKl1LUI2LUGpNeM
 j9bprhgTNrX2kSH76j4i9YKYXJy8t1d2ccjLNSLuUmFNV1OqyTdK+O5JlAjNEsZ+VaSa
 4jmI3H982dLQlcm+5Oasy9o07YK7oT9MyJg5I9zut03+O+ysg7r6xLecTASWDZrEHhDF
 oABA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfDH2H0cA8YGwPV+PTcg9lj6m6ZUYuAQ49kRD15eGiMO3y21c/cdS7AqVMYWsSgOHBvl7n63E8X+0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGVOVrURvKEpPGJ2JIGV4nADSvK8djaW3lYQFp56pqMBWVtlPL
 pAZt5OEvpjSVQ/cViPL1eFu5wMPXefQw02oe6ndL4zYn+yW3YTkXcK9BIOObJgBbaWDsqEzttMn
 cmK6fMgNIyAYEkMCqhtSPyccuYtmTRTzC1kpuzEXXk58gAn8vDDSeuFrodY786NC7hGMMA/0=
X-Gm-Gg: ATEYQzxXYajaQQ/Uou+eAQBaC3ELcRmaSSDdwajWwxSubkweBnVdhTy61ATT+AM4bh/
 5+eZApbmNWWQiX2BnN4IymjA8jVSmoMS8S1+s4VRXgZgYPIOE0jUXrbWhHO9N99Vp4DZnhCaJF1
 mgImXbdbvnKnzD8H6tMwSugyLC//x4ruwL05gtSr+bOl0cLzlSHnGxFsS1MN8aKiTFmqWYUqDZw
 LOKv79ISkZGMCpuPDen08Wlz3DSZUuZDiosqzl6r0rh/hd4qJqO8Y1jRpmEXBi2occb4NM/5HgY
 mzOfhP9x3tSJYnAC9b5VnccFy8DuqiM5ODpFjpXgWzgD+Ro/jriQB6bdV1/aihGN2yfiXt5U4Sl
 ZPWYd0MX3IXGIM76XChMfb249HvwQSfOfwb7y62HF+CDOFap/BQJ49M6oiMS8eZso+j2NnyEsPH
 Lmq8o=
X-Received: by 2002:ad4:5bc8:0:b0:89a:7d14:66d4 with SMTP id
 6a1803df08f44-89c6b721eaamr28689606d6.7.1773826177945; 
 Wed, 18 Mar 2026 02:29:37 -0700 (PDT)
X-Received: by 2002:ad4:5bc8:0:b0:89a:7d14:66d4 with SMTP id
 6a1803df08f44-89c6b721eaamr28689306d6.7.1773826177439; 
 Wed, 18 Mar 2026 02:29:37 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97f13ed066sm168825366b.4.2026.03.18.02.29.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 02:29:36 -0700 (PDT)
Message-ID: <6fa41a5d-ae11-471c-bc7b-3fd445a01b03@oss.qualcomm.com>
Date: Wed, 18 Mar 2026 10:29:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/27] drm/msm/mdss: use new helper to set amsbc
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260312-ubwc-rework-v3-0-b7e8f800176a@oss.qualcomm.com>
 <20260312-ubwc-rework-v3-17-b7e8f800176a@oss.qualcomm.com>
 <19b36a86-12c7-4710-8f80-5e27c9c00e3c@oss.qualcomm.com>
 <uahvm7kvu2vi6o6mwznn5eqzqqscxmfetl4c3q3xa2eryg6ode@ltxfpjmqbrrt>
 <fe151ffe-aea2-429d-a725-4697381c4a93@oss.qualcomm.com>
 <hmamyk4lzo6ekswqvjlen6hc5stny2ucj5fxy5g2tvl3fqpbq2@ux7l4j4drm6z>
 <igwmdjbd43xdhab7vgqn2oaxh6yddbp5qe4zmh3xjyq7ix6hlo@itpftzhxkxtm>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <igwmdjbd43xdhab7vgqn2oaxh6yddbp5qe4zmh3xjyq7ix6hlo@itpftzhxkxtm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TPhIilla c=1 sm=1 tr=0 ts=69ba7083 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=li3VWkI-OtAmqmHzrUUA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: Sx5EqngXQmZcdOa22aahh_XZHNAnAOid
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA3OSBTYWx0ZWRfX1c4nzCpheYfq
 x7Kq1m7pQxyGYC6XVPym4lRX6gITu2ac8Q0W+P4xuameebRESkRSzpej33o+M3C1O7ONktHF0H6
 YACqUM6LmMpkThC1cK7hKer0UtHjpZLIx4knb932hf8lRCeSB2GDE1q/GY6L8ZbWk6cSNprFmgk
 i6hT0PcypZqg5J1vBYMaeRbQiE9YYWznTs4WhE4RwVvLNuDE5UObb66hCeVViTuy4wBklI+Z3u1
 ecAiTmv+3/PlFzgKnwz99u7tyPuWqhFppxz/IECJKbzz4KF8bcKs4PcW5jGbBiYHY5u8bs7wh/g
 D6UIZV7jH6686+iXKVBR4TFnaTqxrN7ZeJawifrKaYbiWh7f1oG+zejl8WmC/y0Uk0AYGDz8eI9
 Q68SSDjzqZmKEchWhLbu7bpydEtazEKfZj4go9/ZNGmt6fq8usSLZrurUbGwtU3GlKXHRmqQDFs
 J4tDE0rMg438f2kD2hw==
X-Proofpoint-GUID: Sx5EqngXQmZcdOa22aahh_XZHNAnAOid
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 spamscore=0 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180079
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

On 3/16/26 3:20 PM, Dmitry Baryshkov wrote:
> On Mon, Mar 16, 2026 at 04:04:46PM +0200, Dmitry Baryshkov wrote:
>> On Mon, Mar 16, 2026 at 11:08:00AM +0100, Konrad Dybcio wrote:
>>> On 3/13/26 3:26 PM, Dmitry Baryshkov wrote:
>>>> On Fri, Mar 13, 2026 at 11:19:59AM +0100, Konrad Dybcio wrote:
>>>>> On 3/12/26 2:29 PM, Dmitry Baryshkov wrote:
>>>>>> Use freshly defined helper instead of checking the UBWC version
>>>>>> directly.
>>>>>>
>>>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>>>> ---
>>>>>>  drivers/gpu/drm/msm/msm_mdss.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
>>>>>> index ca59bcdde7b2..04efc29f38cd 100644
>>>>>> --- a/drivers/gpu/drm/msm/msm_mdss.c
>>>>>> +++ b/drivers/gpu/drm/msm/msm_mdss.c
>>>>>> @@ -188,7 +188,7 @@ static void msm_mdss_5x_setup_ubwc(struct msm_mdss *msm_mdss)
>>>>>>  	if (qcom_ubwc_macrotile_mode(data))
>>>>>>  		value |= MDSS_UBWC_STATIC_MACROTILE_MODE;
>>>>>>  
>>>>>> -	if (data->ubwc_enc_version == UBWC_3_0)
>>>>>> +	if (qcom_ubwc_enable_amsbc(data))
>>>>>>  		value |= MDSS_UBWC_STATIC_UBWC_AMSBC;
>>>>>
>>>>> I know it's already there, but fwiw downstream doesn't seem to be
>>>>> concerned with toggling AMSBC in MDSS (perhaps incorrectly?)
>>>>
>>>> Downstream enables it only for the cases where encoder and decoder
>>>> use exactly UBWC 3.0. This is not completely correct as the bit doesn't
>>>> exist for MDSS 6.x+. For 5.x this is equivalent to the code from the
>>>> patch: enable AMSBC if targeting UBWC >= 3.0 (because MDSS 5.x don't
>>>> support UBWC 4.0 or higher).
>>>
>>> Right, this seems to indeed be the case
>>>
>>> While trying to confirm that, I noticed that some lower-end MDSS 5.x
>>> chips (like Talos) report UBWC3 in the register, but the MDSS docs say
>>> they're UBWC2 - any idea?
>>
>> I don't see a complete pixel format document for Talos, but my guess is
>> that one of the blocks (GPU, Venus or Camera) doesn't support UBWC 3.0
>> pixel formats. MDSS is just one piece of picture and unfortunately we
>> need to use format which is supported by all the blocks.
> 
> And after cross-checking the docs, it is really interesting. It really
> looks like for those chips we have used the older core for UBWC, but the
> registeres were not updated. One more reason not to trust those and to
> use the database instead.

Yeah, downstream seems to have passed:

qcom,sde-ubwc-version = <0x200>;

as well

Konrad
