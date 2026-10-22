Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC76606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S1tB+EmQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FA581125FB;
	Thu, 22 Oct 2026 12:55:06 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFC711125E8
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:54:59 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so3824255e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 05:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792673698; x=1793278498; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jYF7S1s7Ov9hCjAhKpbMqkQvqhCJSe4k6JebACUrQ0U=;
 b=S1tB+EmQj1T1oZkKP9OoO/Ita1xWPrpjAvVFzI4aKF/Kfby/SfKNT9i+I0lmQMdM+q
 RHO9E8qmIHhq96JtwoELIOqFYrk+InVCTLCkOnkI7xxWwAEdb+y+3ya53Yve0GmrPfOj
 fAf4W2AK9y9VkOhNyuf7WXx7iPlfEbMLmUno7fcHoOWkF2suRi/3nZJFdEEWtd3cplAf
 AabUqCsWETvEAxciR9ibzK31mpfcx/itCBQb39HxI+vnFGxRjf9okwcS1W6vqJH1ghGN
 eWlrKM/yJwhJP7Vk7UyI8LhPnEH1Lzu8QcqxvpWP0hhBC5wDcj75T78sj+lXMZTjAbt8
 MXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792673698; x=1793278498;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jYF7S1s7Ov9hCjAhKpbMqkQvqhCJSe4k6JebACUrQ0U=;
 b=tiSsH2pf9MzC23sIx8uQpX0zGo6fvuciaHExp3jJN8WQN0xcq72eGcCvihkE/05tN9
 HgGDo+xrvMARIyw6uiDLfgrJdP/Wsf5y4/f8uncUz9VLLJYDv4YfSPNQU22xPS0AmNoJ
 KBIcD9Xhe/wxj9ETWZ2wa8qOmS/G0rkZlTnpyixnTIiolZR2KXsy+QFdof3sSh31HC7/
 QQB3T/p4ZZrurDFqNO6mL4F77y57SxSrwCkRRCzkcRSX5fsv6ImwG+U8p5RvaBoVhJ+G
 cnAPHryIuE6sgW1W/719ZT9Bp/8C/OFAJrkGbDGzdJmjG/98IPEUDGLBtxkFWjlwC23q
 fhQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZpNLinI1FWCojfDSK0Eo0r0hvDtrjHsYdbjyPR+a2GxChWv3ty+dBxFUPMXNE1SUsSdJ7n89FT+k=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIuT2kBqYq1QF7zyJtZNLEVYrpf+4UuczV8u/O1q/L4LTi4Fatt
 LIP+6yiXezrx53LsWK+PWS9RcOwUGrCI7seeU2lGApnAiahZiUYiZlM=
X-Gm-Gg: AYBFou1yqIAf1N+4sA86S6I45ilVoN4gdFleRj5emIE+lNX+yuanpJY7WdQignxe+g1
 U35UCSljTCQ9KIr61YMm+3lt8GPLHG70ODbXLgVajsV4u6ArpgyXGM5UcuBSMste8UiApbzucX4
 Uq9+Tnr6n7lQhyZ26pkSipMO53YW/G5bxRQPkt87l3FlVISsHDYikVt8PBXFTKDnldOz55Top+Y
 atE/ehPGtGdYvwBKiYQDTycuth5U++IAy7Y/8xsG08JwCFdX7ZZoWP3fvQWx8qEtVXFiNCFoDap
 dbl3SVyxfqBWJ+gUVLpf06H+50OagoBlegBfUkLMynbbIcRgrVcQGGsipIjvRbwRYwhpODa5DJT
 pA4Dv7CFm1cf3VJt1EvsEYypsIKJPtyRIIRNX5f4UsoHqbHFXZ9j7W+wAW8Gf6vbYDmuxtj/Mte
 5gU9JpQbwcK/ZHMZvLy0zA7He3KvfAgSoqiGVYwjq8ojXBm1JqDpI6qTfSQxuTtwcE62/ZLDN6I
 Hu3uUA0q6uxtu7YWo0JPmJZjHKLxZ0W7VtjP7Ot7jWU8xafioGlMjIj8zkq3pZ+81FXvjp2k/BO
 C86n1IuLvesGHy0eIr0Agjkq4CLnbdNYVBA5
X-Received: by 2002:a05:600c:1c2a:b0:4a1:e57b:667c with SMTP id
 5b1f17b1804b1-4a1fdd4fe80mr121774905e9.26.1792673697832; 
 Thu, 22 Oct 2026 05:54:57 -0700 (PDT)
Received: from ?IPV6:2001:b07:2ec:601d:4b26:1672:75c7:805a?
 ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a203a447c8sm68550055e9.12.2026.10.22.05.54.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 05:54:57 -0700 (PDT)
Message-ID: <1f6db59c-b7a9-41a1-8022-6713365fa09e@gmail.com>
Date: Thu, 22 Oct 2026 14:54:53 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/13] drm/msm: look for lpac from dts
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
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <wtun2cfukyzxlsfiz2izsejd33k4jpapwqa3uqih5drcsrkff5@e6llkke5dayw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/9/26 9:39 PM, Dmitry Baryshkov wrote:
> On Thu, Jul 09, 2026 at 05:54:23PM +0300, Dmitry Baryshkov wrote:
>> On Thu, Jul 09, 2026 at 07:12:39PM +0530, Akhil P Oommen wrote:
>>> On 7/7/2026 10:09 PM, Dmitry Baryshkov wrote:
>>>> On Tue, Jul 07, 2026 at 05:02:43PM +0200, Anna Maniscalco wrote:
>>>>> On 7/6/26 5:04 PM, Dmitry Baryshkov wrote:
>>>>>> On Sun, Jul 05, 2026 at 09:13:37PM +0200, Anna Maniscalco wrote:
>>>>>>> In order to associate the SID used by LPAC to it's own domain and
>>>>>>> context bank we need a separate node on the DTS.
>>>>>> Can we use iommu-map instead of adding a new device using the same
>>>>>> addresses? You provide zero explanations, but it seems like you are
>>>>>> trying to separate a part of the GPU into a separate device, but it's
>>>>>> unnecessary.
>>>>> What I was trying to say is that we need to map sid0 and sid1 to different
>>>>> context banks.
>>>>>
>>>>>  From what I recall, so long as we use the same dt node, the iommu drivert
>>>>> provides no way of doing this.
>>>>>
>>>>> What kgsl does is having a node for the iommu and then subnodes for gfx lpac
>>>>> and secure.
>>>>>
>>>>> The address on the lpac device doesn't really matter. I have very limted
>>>>> knowledge of DTSs but I think we could just leave it out altogether?
>>>> I think, you were poined to the Glymur Iris patches. Another option is
>>>> the QDA driver being submitted too. Both ot them use iommu-map to
>>>> describe the same usecase - a set of SIDs which are used by the device
>>>> but which should not be a part of the defaut set. With it in place you
>>>> don't need to have separate qcom,lpac devices, no additional properties,
>>>> etc.
>>>>
>>>> I'd recommend following the same approach.
>>> iiuc, the conclusion in this recent thread is to use child nodes for a
>>> similar case:
>>> https://lore.kernel.org/all/20260618151745.GD231643@ziepe.ca/
>> Let me check internally.
> After a brief discussion: it can be either, depending on what suites
> better (and if you can persuade DMA / IOMMU maintainers to let one extra
> bus or not).
>
One thing sashiko is pointing out is that new dt should work with hold 
kernel so, in general moving sid1 from there would break it since old 
kernels don't know how to handle them separately.

Not sure how to address this.

Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

