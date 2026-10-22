Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE8F606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 18:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Cpdv97o4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 834BA10E47C;
	Thu, 22 Oct 2026 18:05:49 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B46D10E494
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 18:05:43 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a1698ea378so745245e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 11:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792692341; x=1793297141; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JY/kgswJkw3rC1uB03Rt3fXoWelWaBya4FySXulL7N8=;
 b=Cpdv97o4/sL0SvQopr4pyZiqaRc4Zc+pUUXcRVvsFlD6YNUjYsZ2a8kzFaW9G4Pm44
 z596DZ01YAsGYe4H+79hLDmFMrq3YI+C3BhjpTKJCQB0DnPrTgWlWm99MPsYaog6bFqq
 pQg66kSpIcKoqlouVJTH31tt+47c2AILDyygvZQcSnJxohQtpllmRWnVpOX+CueyyD4Y
 pGTuEBgoKDeKOafQ/sc8rSlWY2k/REy0teDzHTuDLwdYMGuFU3H9fxiap7WObonK4kOd
 hfA13aokia6I6ecvsFzagjr9L0lLJJ/6AUIDIAAtKo3yYQDZSSm7GrCszS0N0/tSlwMK
 mbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792692341; x=1793297141;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JY/kgswJkw3rC1uB03Rt3fXoWelWaBya4FySXulL7N8=;
 b=Hw51iMUTw08WTF7jVuXua2maPG4fKLkGCeaSHniWkGufpwY/RwOqDO7ZLKVJ5LLrBi
 ROW1ULfT9bV1b8rc4qX5TnSHhgEs1qJMMyfVLG2bmR9NeN6Z+d3Q8k8haVNwKYwKLgA7
 O1FJ+mQmvXqTVD1zRnjEi2n5dxgLgFU+nzCTBa0Cw0MfhD0nlKXL7P/6iHe9DW3D/n/a
 +7jzFbGWR84xdW0AepbVpvQ2k6AqkFRDq7Bi6jEFuQG+SiKb8r+w3iyYSWU2lnFIoblB
 lYM8NB+SqtULfl8vF0Hi8g8bHyaac7D+b0Gz3n39cENVLqfaQMqORuQtQMmD8v+jHV81
 qIAw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOmO00AjEWD0lLffyhYHfgnR/pZFCdXIIjl0e09NgzrpaCFuUUfCXQfLc0F7qEeR7sxDCJBt5YY80=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKzichoKpany4OunWVxv1ZkHU+8j5kXyVe/9aRDRL/ec92rSU9Z
 loxV/cNs4nkYRLHCR2S8+S35Pkj8UXHhdPkSdDywrVv7gyEP6Q/oVhM=
X-Gm-Gg: AYBFou0S9+tRJnU2chhEeiKBxfDZ/+vqr2QrTBmxyMVpaktiqSJYDvZCmY16BKkghMq
 JHRXvLMX7wCr6iAp+iG0/bRkxgWQIrPJPx6hIWyV1fLBNhIvxS6jrgLcjTTkq2KpWYqT1riYFc7
 6/7EdtwuadGj4Sq62yivUDYbOmrm8dFVTqigwJDfH3V4KDN1TGmzS8mbrrFpxzCJG7wlATSSGTt
 XZI1uY8djw1tBjXYXw2riL6MRcuUPwovAV7Doblg+kr0pV2EkHwHZK+ZFKqbjCj2x5mj7080YJ8
 fACQ1vYpIKcAumHcGT/P7GRTLPUHieHmBqzTAzyvfmkT5HB5PKyj9VB9BmxLhlkJUzF54d8qiRo
 4fAoEK40NyJbIpZVemR5MunrDalApop3HngyihwBu2qIQ4uHyze+fXrtxs1kpTEiSWZdCWGDEfY
 Us+hnJ/xSMWzbKrC0XlSE0X1qhMPbJB04BxjI0OhNzaRTtZpbzk1hzDmoZziNYzNdlRsvNUSFbc
 Y1RT8+ObjoUgc9p2DlxBlYphoj5IR1MkIaIkZi2aKhgbDjYwr0lW+pQ0AVSfhl99PJGB3MdAzch
 IVT6bD6UgJsGPphVtxM0H1GBtpBqifPeoi8Q
X-Received: by 2002:a05:600c:46d3:b0:4a1:acaa:c355 with SMTP id
 5b1f17b1804b1-4a1fdd0b191mr127111405e9.10.1792692340943; 
 Thu, 22 Oct 2026 11:05:40 -0700 (PDT)
Received: from ?IPV6:2001:b07:2ec:601d:4b26:1672:75c7:805a?
 ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2104627e0sm14106125e9.9.2026.10.22.11.05.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 11:05:40 -0700 (PDT)
Message-ID: <31970f28-5415-4e78-aa0f-51f15d779e1b@gmail.com>
Date: Thu, 22 Oct 2026 20:05:38 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/13] drm/msm: look for lpac from dts
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
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
 Thomas Zimmermann <tzimmermann@suse.de>, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
 <rwohvfbsw2brpxrfg26egu5arwe6g7n2etelo33eegmu5cz65k@3syofuxzsjrc>
 <dc5aef2e-600e-4e97-b76b-dcc8bd72c709@gmail.com>
 <m4vwrqt6yyaawpvkyrqfzs3kbipbhygmtrhphuthl2gmjvkgyt@u2d3dnvl2phy>
 <54cb37bb-aaa5-4c5d-a563-acca4822dd35@oss.qualcomm.com>
 <t5gu6ciwmxdb2jghc44gtixdsbedkgy4yzke5sgawjrr2h362u@ahvhh3yfe6lx>
 <wtun2cfukyzxlsfiz2izsejd33k4jpapwqa3uqih5drcsrkff5@e6llkke5dayw>
 <1f6db59c-b7a9-41a1-8022-6713365fa09e@gmail.com>
Content-Language: en-US
In-Reply-To: <1f6db59c-b7a9-41a1-8022-6713365fa09e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 2:54 PM, Anna Maniscalco wrote:
> On 7/9/26 9:39 PM, Dmitry Baryshkov wrote:
>> On Thu, Jul 09, 2026 at 05:54:23PM +0300, Dmitry Baryshkov wrote:
>>> On Thu, Jul 09, 2026 at 07:12:39PM +0530, Akhil P Oommen wrote:
>>>> On 7/7/2026 10:09 PM, Dmitry Baryshkov wrote:
>>>>> On Tue, Jul 07, 2026 at 05:02:43PM +0200, Anna Maniscalco wrote:
>>>>>> On 7/6/26 5:04 PM, Dmitry Baryshkov wrote:
>>>>>>> On Sun, Jul 05, 2026 at 09:13:37PM +0200, Anna Maniscalco wrote:
>>>>>>>> In order to associate the SID used by LPAC to it's own domain and
>>>>>>>> context bank we need a separate node on the DTS.
>>>>>>> Can we use iommu-map instead of adding a new device using the same
>>>>>>> addresses? You provide zero explanations, but it seems like you are
>>>>>>> trying to separate a part of the GPU into a separate device, but 
>>>>>>> it's
>>>>>>> unnecessary.
>>>>>> What I was trying to say is that we need to map sid0 and sid1 to 
>>>>>> different
>>>>>> context banks.
>>>>>>
>>>>>>  From what I recall, so long as we use the same dt node, the 
>>>>>> iommu drivert
>>>>>> provides no way of doing this.
>>>>>>
>>>>>> What kgsl does is having a node for the iommu and then subnodes 
>>>>>> for gfx lpac
>>>>>> and secure.
>>>>>>
>>>>>> The address on the lpac device doesn't really matter. I have very 
>>>>>> limted
>>>>>> knowledge of DTSs but I think we could just leave it out altogether?
>>>>> I think, you were poined to the Glymur Iris patches. Another 
>>>>> option is
>>>>> the QDA driver being submitted too. Both ot them use iommu-map to
>>>>> describe the same usecase - a set of SIDs which are used by the 
>>>>> device
>>>>> but which should not be a part of the defaut set. With it in place 
>>>>> you
>>>>> don't need to have separate qcom,lpac devices, no additional 
>>>>> properties,
>>>>> etc.
>>>>>
>>>>> I'd recommend following the same approach.
>>>> iiuc, the conclusion in this recent thread is to use child nodes for a
>>>> similar case:
>>>> https://lore.kernel.org/all/20260618151745.GD231643@ziepe.ca/
>>> Let me check internally.
>> After a brief discussion: it can be either, depending on what suites
>> better (and if you can persuade DMA / IOMMU maintainers to let one extra
>> bus or not).
>>
> One thing sashiko is pointing out is that new dt should work with hold 
> kernel so, in general moving sid1 from there would break it since old 
> kernels don't know how to handle them separately.
>
> Not sure how to address this.
>
> Best regards,

Also, looking into iommu-map, it seems like I would ultimately still 
need to add a child device.

Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

