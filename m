Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1A0F506E0
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 14:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5293410E3A1;
	Mon, 16 Mar 2026 14:35:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fqBcGXJ9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qm5oFlWb";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 186B310E10E
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 14:35:05 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GE812B2375045
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 14:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XBIUg40/M7vmcxFLi5vD+zxo1ud6+bCfvOq5RZgwjA4=; b=fqBcGXJ9G8NakXev
 3B/lHvsfDxv2HxZP/QCxDBAixJsPxLBqEsVOQfVRxas+Fy053n0T1i6F+y47xVrC
 P1mefjk+BuLBtKYWC5Ynq24xxqe1H+ewGtfE2qjv0Ee33KvgmLwoscJrDRkvVyG6
 1ysGs/b+YOm0WtsDT76fladma5rdPhHcGS8sQ7N3496H2kFr68+jgyemxONPekox
 4YHEDXrxjpESlrCdEC6eBQYpKMiBB7E0DEmh7Kz0pPOGHvZJ55tYvHQ6T4nfpcpI
 3PXIc76yBW0yVR0wUvk7bmK1zqA+nfp5KuRwZcl88wPmGxqW7OB1k2gVoxm8ZjyZ
 lWAbIA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxkby03aw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 14:35:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cb485c686cso292386585a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 07:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773671703; x=1774276503;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XBIUg40/M7vmcxFLi5vD+zxo1ud6+bCfvOq5RZgwjA4=;
 b=Qm5oFlWboCQoPgh4cIJqxhyRitzeBvXwnqDRDs2irlXlmcLuPR4Apwl8i08cdAtCgS
 0ZmUDOPtyO02b/YhhKXetHvXj4csJ/GAHP3YiIEJTUu7wZMVTsxy3ARj3vyhfC+P5/CT
 XbItIM/DbwJ8hDpz8R6l4bu00S4OyNkjY4rT9aeQJtv/weysw22zZoKRPU43/CEyTi93
 cwsJkRD61UNCP05JOTJpYo63+PIXtb9i6BVBV559t0ootnESRGqDnCTEh3FFyxVaaArv
 DM0yM8VDFfD+VJCImRxn1UVhbQI7lhH8lhGO153sxxHDbavFGcAJBh+6YMVN561xOQ60
 HSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773671703; x=1774276503;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XBIUg40/M7vmcxFLi5vD+zxo1ud6+bCfvOq5RZgwjA4=;
 b=ggBYkEtsDFYZ/IsiGHQ3PUk93BK7pwsCwa8yKNrU7u18H9IYpIjC2irjSjmYjvfjH+
 NlmPk2CtsXxKOhqhfMnwu6F8z4OdaZLR8QBUvRWKf1nopm5QhQT+Q4eobRaNVaUE0l5D
 vcAC7nXQmvr/JbLEu4tWgcyX0sZ2CFRYZCf8hJ6QgL3XhevM8+i/l4iWrS3tdaAcMMEi
 fS8yDpsMrg0w1rlYbn35MrzIHUxy43jjaIQNu5LxUtMI8KMzLmZpxANJdaWGa8wk+zGh
 Ft3wmBfBnQeJgvyYcNAnUcB9RsJzPXSLf2bK/O210JLLkrUC4ZOO8vwdY+5/k8013Nft
 XL8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX77IoXjlqKHmNDmMFbtpK8WgeHuiX38mnzpOi9s/BqaOVDJTHlX40+RIloqyn/+7hkDzE3cGsCty8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyIoig/oDN7W7avZBO7ahWxAmdrbKQ3URuHQKXXxy680Zby+UN
 9BkmIF2uIUZ/ZvUimKaRkRYoRYxMMQvjTa25JQSbF3Xk4NIHSIw04SkyzVspPg9/wIcf+cl8J70
 /WdvQMxr8znlqLJYJqBtlw4vaR4KBvDNKkxldzCDaZfu69R+9L1Ka9rtKhL29b05MiFKLIeA=
X-Gm-Gg: ATEYQzzJDQGP3UyuzAOc6oVuG0wgzM+zMtrLXO3yuus5lHrDyBLBjl1/0afHj8lsng5
 TXm5dDCJm3UiMuYyTlB7TBujyj+1CoWQ59WipB/Ylr8jGMADMcu+/b2LYfvlukAbdHKN1os6n44
 +Dlf+xpobuAfjS4XIw1SGY3jI2NfIo+7xFievspPQcLI6eCEmsE3R0ScG16vBmNQZ9s8bS2j6ZG
 obYintwGjvTnoxH1A75JoZE10/uXCcGNG9jktYFwOONDK/XPU1J5qZOwcKGQ/sb5yt399zuIINk
 YmgW+OQAOgWTQoz4uvUmSnz21rPpUXBwBWg2scTi7cREdleAS/ZPHJdlg2DjH9JRk7TihQMZ5Qe
 2+him2DGoqi5BlP0K314fSJglf77eGJmghRUnzpjMtjJo3qyAyVG3yS/41zW9g2fTW19q2hkaC9
 uX6qU=
X-Received: by 2002:a05:620a:29d4:b0:8c6:ca3d:4e0a with SMTP id
 af79cd13be357-8cdb5a7e0f1mr1248987285a.3.1773671703424; 
 Mon, 16 Mar 2026 07:35:03 -0700 (PDT)
X-Received: by 2002:a05:620a:29d4:b0:8c6:ca3d:4e0a with SMTP id
 af79cd13be357-8cdb5a7e0f1mr1248984385a.3.1773671702884; 
 Mon, 16 Mar 2026 07:35:02 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66350d80771sm5027648a12.31.2026.03.16.07.34.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 07:35:02 -0700 (PDT)
Message-ID: <7c862b46-1d8b-4c93-b675-20f735915bb3@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 15:34:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: Fix GMEM_BASE for A650
To: rob.clark@oss.qualcomm.com
Cc: Alexander Koskovich <akoskovich@pm.me>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260314-fix-gmem-base-a650-v1-1-3308f60cf74c@pm.me>
 <2938aa01-cc1b-4dd8-a4af-45ff8354a061@oss.qualcomm.com>
 <CACSVV00HQY6OfWRSWDcv4KnpwhTO+aLpTXLoQuGutvTTmgJFnw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CACSVV00HQY6OfWRSWDcv4KnpwhTO+aLpTXLoQuGutvTTmgJFnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1KicotDpvs95e7Hi0N0rnpdSEmXQILUl
X-Proofpoint-ORIG-GUID: 1KicotDpvs95e7Hi0N0rnpdSEmXQILUl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwOCBTYWx0ZWRfX1NkDyCvO3bq8
 3jpsJitSxpHkwgi78k0aBh+AYFoCZjXi0Y6mCxtEeG9Rru3Xx0UDcJpKRT82prRguCNirXo2AEW
 Ra9ebL5FoO/1Toneb3Dxt+a1twgIXuW9xDd30mapefbKXyfQCn5ZFpocCZ96OtmtTFuuqO6RBL3
 QHqa0GDwQq/9nwBYGa11nHXkRmajBdj1oqn8yZllxmM7v+5hBP2Pjw0yLLfekLrY096W5RgVqST
 rbaNk6ZBApo+w9uCEZA7P/2w8RcgL43bg8g8xzZ/qgdlLERIzebUrEvBqYMC94d3FLW4pzThtFM
 Na77Z6jYgzKqpVvLwvHiecdVXFdUtHvvPdI4bOEJPTkaAWxpGqdiVO6Xc249xmxDNC+jFddlN9V
 WJo+py4G4IsyeaBo+PB8DdLMjON4PZsu6k5f0hNkMnBwrDctiPh4ES219M/B/cgW38mLHabj1Ob
 zanRSiZFLPF87Nl+obw==
X-Authority-Analysis: v=2.4 cv=ZpLg6t7G c=1 sm=1 tr=0 ts=69b81518 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=5SlpSpXkIfRf2ii1CfEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160108
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

On 3/16/26 3:31 PM, Rob Clark wrote:
> On Mon, Mar 16, 2026 at 2:22 AM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 3/14/26 5:14 AM, Alexander Koskovich wrote:
>>> Commit dc220915ddb2 ("drm/msm: Fix GMEM_BASE for gen8") changed the
>>> GMEM_BASE check from adreno_is_a650_family() & adreno_is_a740_family()
>>> to family >= ADRENO_6XX_GEN4.
>>>
>>> This inadvertently excluded A650 (ADRENO_6XX_GEN3), causing it to report
>>> an incorrect GMEM_BASE which results in severe rendering corruption.
>>>
>>> Update check to also include ADRENO_6XX_GEN3 to fix A650.
>>>
>>> Fixes: dc220915ddb2 ("drm/msm: Fix GMEM_BASE for gen8")
>>
>> Hm, that commit also changed the value for A730 - Akhil/Rob, should
>> that be changed back?
> 
> No, it was incorrect before my patch.  The only problem was the change
> happened in a6xx_gen3, not a6xx_gen4.  So this patch is correct.

OK, thanks

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
