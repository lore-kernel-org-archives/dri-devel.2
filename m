Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256CBCD5BAC
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 09:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E69F10F525;
	Fri, 22 May 2026 09:41:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fqNOn+Cm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T2WInLzv";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9AF210E1B5
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:41:45 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M9C5hG3005097
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hDDtStgxWdmz+zI9FXNsfPajHB/12rCB2dYam0qgxvg=; b=fqNOn+CmNoDa+x2M
 I53BbEVkXSowPjPeKLza+XS1rrR7A8Y0xop0aACjwzh3hWAd0qsh2YwRhlygKkuA
 E8qSFKxtOSCtNsKyvVRPC9CUmf2HCDlGMbEAYXAiOD6EUDznPUPP1M/LAksPoc5q
 tXbq1D5xEnXBmaiyTB5erNc5QBqx7oF7ilbL7CxOcg++qNpVTnrGYJl3AZh7QnOp
 JPPU2v75WJOzAIWF8ljFhKeEyMnS+sunR55hPxpMxGdjoaE9Be9lJhngRbhmXR8/
 o7D4w5PSxZemSL3iKQyLP18Mi1ev1CSHtJhUCNQJ1p49N1JURuSKCtJoOO1iEcft
 ubtEHA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eafrt9cfy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:41:45 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-516d1b82fd1so1789161cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 02:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779442904; x=1780047704;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hDDtStgxWdmz+zI9FXNsfPajHB/12rCB2dYam0qgxvg=;
 b=T2WInLzvL3HO1jfR6wNBesyWyeEl0tScMfptp3J+XnK+UYQHpYYuiqoytNawaCnnET
 +TIukyoOewNczks/1Pt/P1OhVsIo+lu06ryvfWjFhVEtITapJF5f5vnMYpANogdCh4oP
 xTEu9jKD5H29gvEN8Lr/eAghPsdhLxBduhKZEtbatFCj7jpEmdYLno5fTNJ5kEwqkfGF
 bo0tS1aOy5cUeoQJhcOGcl1wKRB6u6mwGJLT7v9jiQOG2HfoYexWA0AjepDQHIvZJc71
 Q4VPAiAI8iG/ybW5ozQdkZdry7Lihdr21RB+GJG9KH+94ormgqKHKUy0a+jX79fuMysT
 j41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779442904; x=1780047704;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hDDtStgxWdmz+zI9FXNsfPajHB/12rCB2dYam0qgxvg=;
 b=ZkyJm3b89WGE4wfDASGklVGs83bnvRP8gbOaFCN0gMBfLCf5X8JPTckYFfBc0vGKeI
 25uX9HKfhPSmrhzSOzuT8ypBFYAqmbbW5Y/FBbo+8BcUg7jnAv1vNqp1hnQqaoFehdcM
 ZL2pSAZwpjuPDyJWw2V+OUfgAYozf0LTQGutDB2CM1EUcitlkguVwiroUc+66X0veJ23
 Zrm8P4JdtcaWF+bgdqMTsCNxWsnwcaAJvdAWVjExumNvlKcO+Ea6zGVs34zFFUETywhE
 LtCMqUr2JzSShaxmDW7uTTO63DFo26/mNzf7CqEzEN5Xy4VljYYL4oeZUBHAdQXtGesb
 Ywyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+RpYrUzhkyTFA5GEWbwFr7aeq1gC0CtbQeqK/7wfZEehh/iH1Dcm7EnaTHZm5FxfsjYMkrPjzJmhI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPGfrGT8NRbQ1f3MaUmS2IbixlCWE5WxSpSuTQRD0HexSCUvPk
 L6jsogf1Z8ccDVNqp6q3ySJnHZnXdxy+VMW/6VCBppufxHyKBibJYzCCFJI8xEVwokHeOVezywe
 ZVnr27YsMVlrG6+qrIeCzabBfu26TmJCz2ci9bUb438raPK0sEbE2Sn3hxXwz6ZeHr0ynDhQ=
X-Gm-Gg: Acq92OGtXXoA82D5ZJxk9M9yNQdXlsb/JhDlcBbWL3lz0vqMmCMJEY4l1muu6E/iizY
 y8ih9qfZtFcs/DXEw3O7MjhfNlLe/gZhnK5nV86UGizO5BM5ax/aR1fxWMh/pGjGPY5bkE0s8Qf
 ngXQ4HuKooM9Ufcc+rVdyl1o9huaPbG0Mx6ahaZWYMBrCrcV5vo3WfrSaAjTAbkOYSDhLWlbyqM
 ktT/aqciJjD2yHJT/wd/KjwRDEzPYXUpLBLTM5mJrmsMFfDqDA9kBEBgRqxNVwyEeJHZ9xiBy3m
 bcJrA4zru2oF9imom0WH1WjziMros9xoZhBLS8OiAIHTEHohFvPCROYuiLaeSCBRWmcwkK9MngG
 xtlj+weE2q57e5ripelbFzzTlnOrj5GRY0xgXmFb0+UtzFQ==
X-Received: by 2002:a05:622a:a6cd:b0:50f:a53b:9cf with SMTP id
 d75a77b69052e-516d429c741mr22271071cf.1.1779442904099; 
 Fri, 22 May 2026 02:41:44 -0700 (PDT)
X-Received: by 2002:a05:622a:a6cd:b0:50f:a53b:9cf with SMTP id
 d75a77b69052e-516d429c741mr22270971cf.1.1779442903741; 
 Fri, 22 May 2026 02:41:43 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-688baf1e20asm456782a12.15.2026.05.22.02.41.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 02:41:42 -0700 (PDT)
Message-ID: <9a999b51-8131-4032-82c3-72d7eccbd222@oss.qualcomm.com>
Date: Fri, 22 May 2026 11:41:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v6 0/7] Add support for Adreno 810 GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Alexander Koskovich <akoskovich@pm.me>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Luca Weiss
 <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260515-adreno-810-v6-0-fbe04c7203e1@pm.me>
 <3dc009dc-8f36-4735-b849-d952fb626cf4@oss.qualcomm.com>
 <3vzdlxnee4w6mur5qiyk2rhewlugswxarhevv7l4zo47qnnqah@45oxl7rjqawv>
 <01b424f6-6617-442a-a77f-9b7a8472c447@oss.qualcomm.com>
 <191d66ef-7d36-41e0-b29f-1ddd47812b75@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <191d66ef-7d36-41e0-b29f-1ddd47812b75@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JN0LdcKb c=1 sm=1 tr=0 ts=6a1024d9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=6H0WHjuAAAAA:8 a=umUCZPTDblNGZq28zJcA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5NiBTYWx0ZWRfXyqks6B6y6YU9
 Y9DZh5CqPLrU2g4ZRT8SsZiTRcAnkwAdhir0yFw0WoD58XwoFaawda2StH8es+F7uqPZLo4sjnH
 AaruOmS5LE9VIGofoDYws+rVF3++DNYCx4nVuik8TVP8lWgqcUHmw79wtpiu51bIk35Tdkf7/TH
 eac3A+8iU+CyoDuMS2/vT0tYU5OmHKUazNTJTpTdgRSWPFy37bGxWX6wjlJ76T50YKoycsvFfDy
 6bP4iqts5gPmYj3vrOmmNkHtdORGD5U1Pv9qcJfNYnmnxrfj9eSp7YymiYzTWe8r6vXKqierH8k
 TdmRInyAbPuJIG/3/4D6fRyMDhU7JwRTnptu1ohPy/JCHlPoiNdN8FzYQnqSZLiBA5vNieP4/et
 Y47dU+Qjk3Bgja98qEVaaBHd9YDen3w6G7mW6dXq64i/TAdzARNZ9mx0DevrSGXLgxjxWkPPy6I
 FchCGuQ3EIgq4lCcIKA==
X-Proofpoint-GUID: iq3FYRv5GHtodNwTCIhQ_T5aGsD4IQ2h
X-Proofpoint-ORIG-GUID: iq3FYRv5GHtodNwTCIhQ_T5aGsD4IQ2h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220096
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

On 5/22/26 11:39 AM, Konrad Dybcio wrote:
> On 5/20/26 9:38 PM, Akhil P Oommen wrote:
>> On 5/17/2026 11:54 PM, Dmitry Baryshkov wrote:
>>> On Sat, May 16, 2026 at 03:52:08AM +0530, Akhil P Oommen wrote:
>>>> On 5/15/2026 10:38 AM, Alexander Koskovich wrote:
>>>>> Adreno 810 is present in the Milos SoC and is the first GPU to be released in
>>>>> the A8x family.
>>>>>
>>>>> This series is marked as RFC because it depends on a few other in review
>>>>> series, GPU GX GDSC handling [1], QFPROM efuse for Milos [2], and devicetree
>>>>> support for Glymur [3] (for a8xx RSCC offset fix and X2-185 bindings change).
>>>>>
>>>>> Also depends on the GXCLKCTL block for Milos [4], but this is no longer in
>>>>> review and has been applied.
>>>>>
>>>>> [1]: https://lore.kernel.org/linux-arm-msm/20260427-gfx-clk-fixes-v2-0-797e54b3d464@oss.qualcomm.com
>>>>> [2]: https://lore.kernel.org/linux-arm-msm/20260331-milos-qfprom-v1-0-36017cc642db@pm.me
>>>>> [3]: https://lore.kernel.org/linux-arm-msm/20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com
>>>>> [4]: https://lore.kernel.org/linux-arm-msm/20260417-milos-gxclkctl-v3-0-08f5988c43a2@fairphone.com
>>>>>
>>>>> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
>>>>
>>>> Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>>
>>>> For the rest of the patches that doesn't have my R-b tag in this series.
>>>
>>> Unfortunately patchwork doesn't capture tags from the responses to the
>>> cover letter. I'd kindly ask to spam the list with individual r-b's.
>>>
>>>
>>
>> There will be another rev to remove the RFC tag which will hopefully
>> have my R-b tag. ;)
> 
> Do we have a resolution on whether the proposed fuse values
> are OK for this platform?

Ref:

https://lore.kernel.org/all/oka0Q911ixJLZzAbfWBx54dOmxbQAre36QqHUX4iDZoH3TE5jD-IqTAHspti6B8kfpLQ-OTnuWjFdXtsqJM-CUC8G9R3x_9vFI--LnpppiA=@pm.me/

Konrad
