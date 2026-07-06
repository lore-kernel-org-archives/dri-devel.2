Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25A4C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2247210E174;
	Mon,  6 Jul 2026 22:13:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WaSo/jqh";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D809910E174
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 22:13:44 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-476a130c138so3658859f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 15:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783376023; x=1783980823; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3VUxjcvyG7o7DixEmYl5pZcfD8TvxQHqFhtXA36U/44=;
 b=WaSo/jqh4r/zA+nz2I+QvZop9UbiefqBpFo/tRCPe3mnkTWEdzfHCxHu8BFfAHb/v8
 rIQqy275pfjmKC7u8EH3nKgnGv5fqOANaJhpbCc4YSJm1jPQWLgci7lyeNjqiZlcElV+
 mPRZZRxK8tw+R2uEyt108jki6JG/WRmuod9jRYbNLVPpU/JSehwNBTdR97iYPPC3fteS
 3n7+6sNPbV/LTCp9q7uGxhJOrpn5nH7iUhledGJxbLMqcIFUb6KaEZ42wI8mvhKxHyZk
 XacwaLDaniCx1uLTXKTXs1dmFxU2miP3LmpTcCk/15DumydQsbB7iOgZkCrK2pAMg+8K
 eiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783376023; x=1783980823;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3VUxjcvyG7o7DixEmYl5pZcfD8TvxQHqFhtXA36U/44=;
 b=VVCdXY6B0RONQL46d7k3DFgntZ3kL4UxcN72Ra0BmHh2xXPXHICcUIo8+uri9TTQvD
 VVHX/166eFCUaiwArycbe1yeLXiL7Y20ujXqhs1k5MhQxAXcvhoDxhrf7eCXt3gNSvdX
 TM90nxF5rmJeOqKxSQ1KwPZ0rMIO13nIYVnUdUTHn/ZyiTyrFUridRPpZ2p8qT2TDHNR
 LOG5Ku829353WlRluHQ02DmQ1N8QWJ0dyQS0L5UXRtTJQxbIBrj2l/sIcCgyJiTumjJ7
 +OBgaCZNX/gLJWxpRQdThN89RsDgPgjp8/b38H7DBmn2nLbol6i3RosL7pGs++zMH6JJ
 HLfQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHwqkVY0r6CVRLIKwsOSEtIdasLlaL3epRCAin1dZLezFGcFszWSVGkH9mx8dcdHZVPhtehdGX2iU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAIwqxdKLItltuw8s8Ylw9l7kUD5+cQb0R1Fc3yS/4uKLjkFwu
 qapoa58Jf8rJ5fSaw8n0PeZBTu9U5OWM37QclJ6PNYnmYKV0H/68V7g=
X-Gm-Gg: AfdE7cmLJBggMrGF20kvmAXYzG/UFXI1WAkjst5C/fZ0RzEZe1ELHxnaq2vqyysYu89
 Re/XlycbAVc3RnaQWoiUS3HSmB2nTKrscM+NjDQ8odkuadkzFwSMAHwgA4W9spDPOLer1gg1MsW
 W4Paqc5QNhZvQ1x06DggHN2DHwNcqrkFZZhD4yZdcX/qpM5oHbEy8xjbyfCLxWJMlb1m0upQyX6
 79e+c6xuqbKryqXJkZjp0bvCPQfQLNaCWeTD6MqWii3nGeBuT4ohyApXdb/46ihGEy7RgDAvcDn
 sbnI8NJHevWG5O63h+Owyap2eLsi6k2W2nxwGVyhjJFeYNaRxHeilEJnhGfgetdrMz9eg5VYbpT
 7HYSX6/4prlOVpfKvPN3ASDgiip4ImLinsvDknqXkte75KpbEn3JnApf+qWF1+x5im4teq0hHec
 wHo2Ns9H3CRwoKY/U3TvOzRuuuAgRvCcvWSbg07UhP61CwpVZEQ0MDZ9no1L9SCwVeaKiDTg==
X-Received: by 2002:a5d:45ce:0:b0:476:c622:d41f with SMTP id
 ffacd0b85a97d-47de66dd5e9mr1597139f8f.47.1783376022918; 
 Mon, 06 Jul 2026 15:13:42 -0700 (PDT)
Received: from ?IPV6:2001:b07:2ec:601d:4b26:1672:75c7:805a?
 ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039afacsm26722332f8f.19.2026.07.06.15.13.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 15:13:42 -0700 (PDT)
Message-ID: <ad91c7ec-83db-402b-bec3-3821dbc607f8@gmail.com>
Date: Tue, 7 Jul 2026 00:13:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/13] drm/msm: initialize LPAC ring
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-10-01d50c3e0c99@gmail.com>
 <93b78299-866f-4a3c-9423-a990d9a7d4cd@oss.qualcomm.com>
 <64a919ab-8b36-45fe-8da8-5eaaf4d55359@gmail.com>
 <2a556ca0-d276-4c56-a44e-9d8b92a3af6b@oss.qualcomm.com>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <2a556ca0-d276-4c56-a44e-9d8b92a3af6b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 7/6/26 11:56 PM, Akhil P Oommen wrote:
> On 7/6/2026 4:37 PM, Anna Maniscalco wrote:
>> On 7/6/26 10:44 AM, Konrad Dybcio wrote:
>>> On 7/5/26 9:13 PM, Anna Maniscalco wrote:
>>>> Program all the register needed to start up LPAC and send initialization
>>>> sequence.
>>>>
>>>> Additionally, now that the LPAC ring is live, make the code aware of it.
>>>>
>>>> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
>>>> ---
>>> I believe some/all of these writes need to be guarded by if (has_lpac),
>>> as many GPUs lack these registers and there may be side effects on
>>> others
>> That's correct yeah. I'm not sure what has_lpac should be though.
>>
>> Something we add to catalog? Or checking if it is a gen that has LPAC?
> We can introduce a new QUIRK (ADRENO_QUIRK_LPAC?).
>
>>>
>>> [...]
>>>
>>>>            a6xx_gpu->shadow = msm_gem_kernel_new(gpu->dev,
>>>> -                              sizeof(u32) * gpu->nr_rings,
>>>> +                              sizeof(u32) * (gpu->nr_rings + !!gpu-
>>>>> lpac_rb),
>>> Should we rename nr_rings to something like nr_XXX_rings
>>> where XXX is some uarch-generic (i.e. not SQE because we also
>>> support pre-a6xx) name for the main number cruncher?
>> Qualcom calls it GC so nr_gc_rings perhaps?
> How about nr_gfx_rings as those rings can handle graphics workload?
That could be more intuitive yeah
>
> -Akhil.
>
>>> Konrad
>>
>> Best regards,


Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

