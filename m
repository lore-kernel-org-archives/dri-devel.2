Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CACEFE51F7
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67CC910F465;
	Fri, 24 Apr 2026 09:43:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z0kWWs0H";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RmC2sGw1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C194910F465
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:43:05 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O9EiVh1532382
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l3Xl9azwQ71YTf5iuXr2g/rv15sTTWVZVILP1WiTlxs=; b=Z0kWWs0HRRHhUCDh
 Bj6R0qs+G7JWX8+lBRaEq+R9aXQLYHqrINVCvQRw336uX+FhlREq2010BSNcPqOm
 j7ZQ2LygmT6ON8+r2IROtmo2LViFdmASZsEVwN3P7ZSsN/lo+d/CC9rV46X0NUrh
 +81SU5dsinCXFbzAKMXwSYeyc0z2E5H7f86O938PbuqKhI2lwKS2TePmw6sPS7uQ
 o4+Cqsi2yBQkv32EpFVb6qBwxMARcV/+Tzj88v+uuvznTz3fWrMImRHq9cYhNboY
 yMiYLPkTsLtPcVXej6Z+KSBYuhdtITJs5tmmikoQvv9+qs7EsFZ0XFS/Bnb8tC5k
 XfcqlA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqr26kedv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:43:04 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50e5c781193so11272201cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 02:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777023784; x=1777628584;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l3Xl9azwQ71YTf5iuXr2g/rv15sTTWVZVILP1WiTlxs=;
 b=RmC2sGw1Jr+F6AFRLwpTeumi+YtyRz+p6XxgM1jLqcCJGU1oYAr+/O38Q2tDBf8Glw
 D18xbNC7qjUmtSMD15lbRT0SJwzPkA3+j/ETnosknKqTAQLU2mwPOgOk5ItadV6LhJAE
 szpSXEJgCySYKCz/B9H3p6zZJgloLxjq10Dmjt6ga71Q1z+ebTq+cnWGvoq9akOUyMhh
 1NkZIJdvFE7SX9bijrsv1R7XDIRX7TypSQ2ggp5qCX6TeWNoyph5nlqeEZ4iexSpNfDt
 nuj5BsjdswQNEmFTNgM+2Wn523CspH8LqnpC6KqtN07OgEw1zIpBb1exYJjwsLfM7u25
 PLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777023784; x=1777628584;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l3Xl9azwQ71YTf5iuXr2g/rv15sTTWVZVILP1WiTlxs=;
 b=Q9u6udZRJnzlHcs5CyBW01qBXPTACLlkkXnE+NSIflwoxviWVXegd5Yhk153si4gtt
 MJgzXQg3eu3lAv0fMEHfBkePJ2xhL1IbvyJ4MqYwHw8A2CW+R7/RiYW6v2dSiTiMRdKG
 130AnWHy6rsSzIN0PUvZi8bhovq0CAJDBnKL4QrRBeJVa5y+bXLRFIMIjWhrkcDU5nzu
 P8anThDCBDoMRUqQEtQn/6/yDa3ucC44RKVTuCBvAqgGQcwQR6c41EKw3iIb1CCN3I8V
 SqRfEOmqEjy0B17PMK++2vfR6nWiW/GS9mTJKgFx4KCbmeABNw2Ia1Vow1m0Te5+mNHS
 l9gg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qoyvHhZNh9vKImYSNhjHYOOWZtZiqxo00HcoAEC+FTRuNJMht3KMHnMs0ghCNnjSI6GbdJYkTOCA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyPk4qdhjO/PDjo8kL3LlvvRR1fuezFBHYhVtxg117bXsNI//Lo
 NPpgatUVlbBpfQ4DS7as9ZMhdnfGQFAaEsNT9CFtMOM5CpC5FX4X0QCjWjgrvOD4ad1pyqlUo22
 Vk+F62yF9c313mvZjsqnPB6k2rgcPyOj4/0fw1j2ybpGTvHRibR9GBAiZJF5RX7qyoey2dz8=
X-Gm-Gg: AeBDietH7MkFjdOJWM+LX4EEqV582KKjVYjzi7pYXP6Vpy8SNnu5TxhnPUVWKspSFiM
 bS7B+kuKYCdWtMqKWoqWnBlF+t7c+cHpsRmLPS3VLaLzvMi8/SzdurDWNxdiFiOcJKd/TqO1wmC
 s5k4NdEBIPxgl1+1+8rgAJr42cva0ph7gScstPB5072l/KJUQ1HKQaMUGLudJlWxYF24D/Bc6d2
 NPsFxQse+ylAxJ5mSNpPKW9Kga4XorJF/q4dyjCV8mI9xbU8aR1dkAPriz4AaJgzbm1YTqLwmom
 QoZr3rMTRsZPut02RloYDKIlMWf2XegboZdawhl0Bj1haomALMTbOfoiP+xK7z4KigUkU0bSKXo
 Mza3iG9dIHvLTGVhAaOjrlDWAd9/0Ak1FF/BS6SbAJnKQVwTSZ/PmPsjFLdY8CmgEvunaRRxj2m
 vyqkJuIIsVk4oFEw==
X-Received: by 2002:ac8:5f0c:0:b0:50e:5e6a:c7d5 with SMTP id
 d75a77b69052e-50e5e6ace9dmr207534291cf.1.1777023784277; 
 Fri, 24 Apr 2026 02:43:04 -0700 (PDT)
X-Received: by 2002:ac8:5f0c:0:b0:50e:5e6a:c7d5 with SMTP id
 d75a77b69052e-50e5e6ace9dmr207534041cf.1.1777023783763; 
 Fri, 24 Apr 2026 02:43:03 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ba4516f7b11sm754655766b.14.2026.04.24.02.43.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 02:43:02 -0700 (PDT)
Message-ID: <1706c9ff-8c05-4855-be1a-1ff4c6792996@oss.qualcomm.com>
Date: Fri, 24 Apr 2026 11:42:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 6/7] drm/msm/adreno: add Adreno 810 GPU support
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>, Luca Weiss
 <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260416-adreno-810-v4-0-61676e073f8a@pm.me>
 <20260416-adreno-810-v4-6-61676e073f8a@pm.me>
 <eccce3f2-01a8-4454-87d2-3a599a15b34f@oss.qualcomm.com>
 <RxsrYj7kE1fS38uw9Frlum-uhzNhpKl4jkrZhaTmBCLLg5ZXTIG-2qdD8HTAyeyHfGMxjV8BAtwwsJJx28J6XApr3P2cFFmNMux3uKTUKgo=@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <RxsrYj7kE1fS38uw9Frlum-uhzNhpKl4jkrZhaTmBCLLg5ZXTIG-2qdD8HTAyeyHfGMxjV8BAtwwsJJx28J6XApr3P2cFFmNMux3uKTUKgo=@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: AkpOhJ0IfCthSbOf480Ec2XO9eBT20Iq
X-Authority-Analysis: v=2.4 cv=QLhYgALL c=1 sm=1 tr=0 ts=69eb3b28 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=mNBZ_Hp9KTgF1tjAaBMA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: AkpOhJ0IfCthSbOf480Ec2XO9eBT20Iq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA5MCBTYWx0ZWRfX56FbU2Y617ZG
 DpHXvz02e+1GAOkR4xEPuxIElVNGL1tHTPUPBKRztMCFhb9QtI5fWXuGx5kb5y6unkX5Tvjy5le
 JZpmAKaPQxbCR4Yk4+dFvyMLpdstfBASw8KoY62fZa2sO/tGnRLsPGXse+8iDIzKjQ99jKX3XoM
 FS30MRdAGMeG6QoaFJlAd1iqMii78IqFvcTGWXQH/DwUjEv1c7mpOf12r7XM0JBx7ETUP4nlZv4
 gbdwW4gnXgNQ/tDJB8ZubTtG8EWpvwfL5F/GtSsk7nAGPLg3QJ6F6PxHUSq92Kx/nABdc/BX7hQ
 lyBnty7eoS7qYoAIMTxGK86JRQKjnB49W8l4y7cyXvwt+TB6ENblShXspffeERDrEm7ytN28cf3
 +9etZHP5xASoXIF+wzJE8V9lms5FTntJ6RbvNWwOYQAvTs2UQRvNrwtmkeKkJVipBWkrTRaAifz
 iunPOuJx3k+cmZnX5qA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240090
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

On 4/23/26 10:27 PM, Alexander Koskovich wrote:
> On Wednesday, April 22nd, 2026 at 9:04 AM, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
> 
>>
>>
>> On 16-Apr-26 13:05, Alexander Koskovich wrote:
>>> Add catalog entry and register configuration for the Adreno 810
>>> found in Qualcomm SM7635 (Milos) based devices.
>>>
>>> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
>>> ---
>>>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 296 ++++++++++++++++++++++++++++++
>>>  drivers/gpu/drm/msm/adreno/adreno_gpu.h   |   5 +
>>>  2 files changed, 301 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>> index 550ff3a9b82e..1190804632d6 100644
>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>> @@ -1799,6 +1799,259 @@ static const struct adreno_reglist_pipe x285_dyn_pwrup_reglist_regs[] = {
>>>  };
>>>  DECLARE_ADRENO_REGLIST_PIPE_LIST(x285_dyn_pwrup_reglist);
>>>
>>> +static const struct adreno_reglist_pipe a810_nonctxt_regs[] = {
>>
>> To align with the latest kgsl which includes all the latest
>> recommendations, remove:
>>
>> { REG_A8XX_SP_READ_SEL, 0x0001ff00, BIT(PIPE_NONE) },
>>
>> { REG_A8XX_TPL1_DBG_ECO_CNTL, 0x10000000, BIT(PIPE_NONE) },
>> { REG_A8XX_TPL1_DBG_ECO_CNTL1, 0x00000724, BIT(PIPE_NONE) },
>>
>> { REG_A8XX_UCHE_CACHE_WAYS, 0x00080000, BIT(PIPE_NONE) },
>>
>> { REG_A8XX_VSC_BIN_SIZE, 0x00010001, BIT(PIPE_NONE) },
>>
>> and add:
>>
>> (below RB_CCU_CNTL)
>> { REG_A8XX_RB_CCU_DBG_ECO_CNTL, 0x00002200, BIT(PIPE_BR) },
>>
>> (swap in place)
>> { REG_A8XX_TPL1_DBG_ECO_CNTL, 0x10100000, BIT(PIPE_NONE) },
>> { REG_A8XX_TPL1_DBG_ECO_CNTL1, 0x04000724, BIT(PIPE_NONE) },
>>
>> (below UCHE_CCHE_CACHE_WAYS)
>> { REG_A8XX_UCHE_HW_DBG_CNTL, BIT(8), BIT(PIPE_NONE) },
>>
>> (below RB_GC_GMEM_PROTECT)
>> { REG_A8XX_RB_CCU_DBG_ECO_CNTL, 0x00002200, BIT(PIPE_BR) },
> 
> Just wanted to clarify if this was a typo, since you also asked for RB_CCU_DBG_ECO_CNTL below RB_CCU_CNTL as well.

Looks like kgsl has a duplicate entry here. Just one is enough!

Konrad
