Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D426606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NbBleP9n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B36710E645;
	Fri, 23 Oct 2026 15:26:41 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F73910E044
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:26:03 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso6975785e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792769161; x=1793373961; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4a2HGeqSU90/oPjDCBfIOMhTpn84AQ4hBfmcEVcMu7Y=;
 b=NbBleP9nYXKshBBSgchV0xjo622eaDLU3kJjvIY0zVCvSgvEWOifrf2z/hMg5tnWJf
 aXl0CuY5jBZIOg8EEYD8qv6jv75c6RN/LtIY0PTSaTMnbegg7eTv7OaH5GrPchQV+Y7Q
 N+S7k40/h4OHmS5GNSLXul9SXTpW8wZzvY/YY72jXfI4JRfxQQMj/qgmPvqxMFsnds3B
 fLnra1Wew+jFGyMI+9k+neuiRGM3R4FbrusuVDomJ+vMfISDNRHp1VHQPMp98JhUDyaj
 D2cMi/1kVmXHKagrmcHWTtKgy/jErFMLZLXiPjMFa7NUNZZam8XzT/t0QRa9feYcMtlf
 vd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792769161; x=1793373961;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4a2HGeqSU90/oPjDCBfIOMhTpn84AQ4hBfmcEVcMu7Y=;
 b=URzp50lYr8XxdPdOlCcyvOjJIbARaOmiCcptVasvWQZ+DGhhEGUORaIsqLFOJOOweT
 EHJHAlhfFgvh9b0a0H0Qf+uKj794evng4MqdQwp/HqHzHNhnGTkpwLvH4N+89mULNc7+
 R0hJr4pij3+cFhHiIk8+4row4PavG72T+cqVFjcuYmsElCtt1BiPL1AQN/1ZKeTwYndv
 IQ90uh3FsG4Quq3lQD8d14DqcfyTgtHmmn104v/9vPVYZmYeDasKcwIub3RTdkOAv5f5
 G+z/UyDkveMquyygtxOfxaVDgmTR4COR1knDBhtjiA2rAch6t0DkzD9v7kW5OVsBNrB1
 ZfPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6kY+FyTpU23o6pWuYAUuloNDkK7/9FEfarzL01004iNobrVJqErD7Tua/8Tw/smCSK1Uim4tUK9w=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ/ER6YZM+fnBMhqyardy8PmUif6OnhHx1s0xQ6JEznlheXsmnH
 buxIdNoW2pZeLyjz9oZtZI/LV9Ydbn2MslEeD3tmAE4J1xUhOeeOwYU=
X-Gm-Gg: AYBFou3y6mJjcsMiF25YrCQUrrpOYH86g+KRILiTjASTigWSOZEXpClYwv5AZ9xWE+L
 fndwXsLC50bm9X+3gIMVlE38Whr/DsqV7LKZIGt2R0P6dmkg1YLF7hJicO0MaGxWaD3bYN4eTvC
 70UTtaUigzR+1bJGK/iazJQpAn1sS5CbKUSH1ntEPYwaobDZggmeEekl3T3GMnCK/Y/Iuxu6m1W
 SUmgrm8TD2t7b2ccAJGX0TTGlEi+LwERzBzhguclE/pzuIlaf6HE0DCQDStLHRWnEzc8rIjH2YW
 pbMChNbSjLWBVMq/fs3KJLZuzf1ehmt9MBYxAaxQS9G7l/9SabBA9QXbih5HK19wYg+mq+fXrnR
 xXzMiPTKu4noqrIUiCoe8qwkw+RR7XC5wfMDqbxYybJ7zwKJT2pt/Z/pkDtImVCqWRSTJ7xW3OX
 N/nbcRLpmCF73k844XbN7oCD0gmv8rdiEQt5AqgQ2huidzMl+pMDGoun8merCtJMNaEhXr8W/qp
 9uoQyiDUs3bYqNBA4Av30jip9zZRzUw/STVcx93bqrsx+SwuswWnWTGs2ny7KtA/ZrUl9MOPbl9
 W1A7DKjeilq1fiXijn8tYOQBgt3A4y++55jCX+i5HzAnjPz9bYkIBpR7nQ==
X-Received: by 2002:a05:600c:19ca:b0:4a2:397:73f6 with SMTP id
 5b1f17b1804b1-4a211c8fa81mr43106325e9.8.1792769161277; 
 Fri, 23 Oct 2026 08:26:01 -0700 (PDT)
Received: from ?IPV6:2001:b07:2ec:601d:4b26:1672:75c7:805a?
 ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a29cda9686sm11718245e9.6.2026.10.23.08.25.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 08:26:00 -0700 (PDT)
Message-ID: <af06c4b0-55a6-45e2-b2d0-81d64fcc845d@gmail.com>
Date: Fri, 23 Oct 2026 17:25:58 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/13] drm/msm: look for lpac from dts
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
 <rwohvfbsw2brpxrfg26egu5arwe6g7n2etelo33eegmu5cz65k@3syofuxzsjrc>
 <dc5aef2e-600e-4e97-b76b-dcc8bd72c709@gmail.com>
 <m4vwrqt6yyaawpvkyrqfzs3kbipbhygmtrhphuthl2gmjvkgyt@u2d3dnvl2phy>
 <54cb37bb-aaa5-4c5d-a563-acca4822dd35@oss.qualcomm.com>
 <t5gu6ciwmxdb2jghc44gtixdsbedkgy4yzke5sgawjrr2h362u@ahvhh3yfe6lx>
 <wtun2cfukyzxlsfiz2izsejd33k4jpapwqa3uqih5drcsrkff5@e6llkke5dayw>
 <1f6db59c-b7a9-41a1-8022-6713365fa09e@gmail.com>
 <fcb86c33-1893-47bb-80eb-20acd65f3805@oss.qualcomm.com>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <fcb86c33-1893-47bb-80eb-20acd65f3805@oss.qualcomm.com>
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

On 10/22/26 11:46 PM, Akhil P Oommen wrote:
>
> On 10/22/2026 6:24 PM, Anna Maniscalco wrote:
>> On 7/9/26 9:39 PM, Dmitry Baryshkov wrote:
>>> On Thu, Jul 09, 2026 at 05:54:23PM +0300, Dmitry Baryshkov wrote:
>>>> On Thu, Jul 09, 2026 at 07:12:39PM +0530, Akhil P Oommen wrote:
>>>>> On 7/7/2026 10:09 PM, Dmitry Baryshkov wrote:
>>>>>> On Tue, Jul 07, 2026 at 05:02:43PM +0200, Anna Maniscalco wrote:
>>>>>>> On 7/6/26 5:04 PM, Dmitry Baryshkov wrote:
>>>>>>>> On Sun, Jul 05, 2026 at 09:13:37PM +0200, Anna Maniscalco wrote:
>>>>>>>>> In order to associate the SID used by LPAC to it's own domain and
>>>>>>>>> context bank we need a separate node on the DTS.
>>>>>>>> Can we use iommu-map instead of adding a new device using the same
>>>>>>>> addresses? You provide zero explanations, but it seems like you are
>>>>>>>> trying to separate a part of the GPU into a separate device, but it's
>>>>>>>> unnecessary.
>>>>>>> What I was trying to say is that we need to map sid0 and sid1 to different
>>>>>>> context banks.
>>>>>>>
>>>>>>>   From what I recall, so long as we use the same dt node, the iommu drivert
>>>>>>> provides no way of doing this.
>>>>>>>
>>>>>>> What kgsl does is having a node for the iommu and then subnodes for gfx lpac
>>>>>>> and secure.
>>>>>>>
>>>>>>> The address on the lpac device doesn't really matter. I have very limted
>>>>>>> knowledge of DTSs but I think we could just leave it out altogether?
>>>>>> I think, you were poined to the Glymur Iris patches. Another option is
>>>>>> the QDA driver being submitted too. Both ot them use iommu-map to
>>>>>> describe the same usecase - a set of SIDs which are used by the device
>>>>>> but which should not be a part of the defaut set. With it in place you
>>>>>> don't need to have separate qcom,lpac devices, no additional properties,
>>>>>> etc.
>>>>>>
>>>>>> I'd recommend following the same approach.
>>>>> iiuc, the conclusion in this recent thread is to use child nodes for a
>>>>> similar case:
>>>>> https://lore.kernel.org/all/20260618151745.GD231643@ziepe.ca/
>>>> Let me check internally.
>>> After a brief discussion: it can be either, depending on what suites
>>> better (and if you can persuade DMA / IOMMU maintainers to let one extra
>>> bus or not).
>>>
>> One thing sashiko is pointing out is that new dt should work with hold kernel so, in general moving sid1 from there would break it since old kernels don't know how to handle them separately.
>>
> + Bjorn/Konrad
>
> Not sure how strict is the requirement for compatibility with older kernel version. An
> option in your case could be just do an override in the board dts file of the
> Steam Frame.'
In other words that would mean not upstreaming the DTS change? Although 
we plan
on keeping LPAC off by default upstream it feels like that would be 
quite a big
barrier to enabling it for people that want it.

Also yeah not sure where sashiko got that requirement, maybe it's not a 
real problem?
>
> -Akhil.
>
>> Not sure how to address this.
>>
>> Best regards,


Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

