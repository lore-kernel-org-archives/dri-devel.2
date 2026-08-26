Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A348C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BA1910E289;
	Wed, 26 Aug 2026 13:07:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cVbTFTRA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I0sUs0yl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E20B10E284
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:07:12 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCBfoE1461480
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z8ZCL6UB+xi0N5gctLw16/d9ULv3ZvLsxlJFre/dyo4=; b=cVbTFTRA/0lJJsRz
 1IV7KZRvSOcP707QMxiFBDWZD+bzVxbypuiePC1uTTRkmKqETUDEwn9XxGilb6pY
 nRuU9fKpMbKGrcjVsVzzh643jTiVHuUF16XEVgFG4M94fzO4W6GBwUnRmEhruP0w
 PZtGHsyaaFb15Pd8eG1wAoQa8Mj162q4fAXkPWdGWNIbNJXYfT7HDSkKPq5REeDD
 yhFKk8BUoueF/HzJ9yKMbqs+3FAjLLq8jJMx5yqfj7auX0FamTYxWUHuusLNwd4+
 b3b7eFpusiLHNVzlA6RQFl3DBqwbkLpvjIhmoDRvwt5aEX6drirvxoQp6ujPpWhC
 EHsyFQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9fgxm1u6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:07:11 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-848568a6f62so1032407b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 06:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787749631; x=1788354431;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=z8ZCL6UB+xi0N5gctLw16/d9ULv3ZvLsxlJFre/dyo4=;
 b=I0sUs0yl05RbrjJoG+iWwDxzP3QW0w5les8TmLcrwNsfleUW963qE/ndJFRx60QYYH
 HauSYjEcAl/vYkjsND6KMqkWjOLVksmdTHDBrxWbj5UGmFtAkQjsYEHt/igLYZb6HO3T
 Z//PNMWDB9J9Cpdh8u0Satq+TDPUkLO25pDDvqntCltjJ1WX6E3nOfn/L+Kt7Id/AVA9
 T1NUbXofXOzj/HI4kf32M24I96O1MYD8PNBvD/NyKG0yGLNlcFedHPjXPObNP9P/hKi5
 j778So0iuLUbGT77Q5nLU/fV6DjBacWIPNh9yD+XnWlwJP/T6E/MJqFbqmCe6yq3u7Vt
 mWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749631; x=1788354431;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z8ZCL6UB+xi0N5gctLw16/d9ULv3ZvLsxlJFre/dyo4=;
 b=Cxv0JxfkYiLrYLDvCLWrC8agnraL4bQuGnNpAEROdK5hEDW8sn3JN22E1imSYxSLqs
 aQJ4GnmZHxvq4rWPkZGD0GAA73kyPZuvmbftae0zS1ihEJg6KR9ZD6okmWZg2zdjYNh1
 fRkVQapyIIYzvpd2EhHIPODvgIexjj/4vgYCW7ejh176aXa5LCTugIV2Cw3SNHyv0f9f
 Gzr1PMS5TfVHzdGK9YeJ4RCRA/GLQkzIFPfTmPLAIQT4bchdr8x5C4NO3Injz1OW3TcQ
 kSlLEWHSSZB3xdADMdpQA2vRscaSd0wwsOS06LU9NKStdOmwua9HrDsdMyphIRcZaIBI
 fzZw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpGiE1ykfXx0hR1Dp1c9lF4zyIrpcKof/pSxyaDhKaUUh8GAFbSU4YGmSZtAYSwIXvdIWSfkSwSafQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nA4+PkSs1eBjxKpbk9+KFqOfflCZ+5W0mGDHMFSD89hdFSeaBP
 gkSJAQ7szLIrViCP32zaq2hQcY7MFhlJj5cGDMnvQmtoARWjmLJ+Y8Xp6WNH4J9DiUeILDcmnf5
 +g8pxLhfDA6FxLDlpYVf84OWZDBehgW7BAyxDE4mBQZ77hp3i8Rr+heOSKo9KCkLS/UUTLoU=
X-Gm-Gg: AR+sD11r2GXIjX7g1iI9SYWNg5VSBC8uyWxkIF5cTNRu2YaU/YnLzG+8ZIPLpAxuWMn
 E7n43reQplGtEc7OsMocZ3767KoqAugV/1S95HxUveArKHUM4g0deq595mD3nAq5Cwwu7j9U/f+
 bzlNS2ZhGTW+xuUM6OJcn3DhGDgJEaCdZDyCwV245cl8HPRIX5IaA/Ss8VnFDvcgJQC8c7ppOUr
 xdCFa8KpDco9Yk8qAOa8MXalHmr1N4Bp2bamuxSbmuUf32IVTPAd2UlXQ+uHWsgkmWNQ0BH9tx5
 UKyWV2sv6zw3DE3uqaG3BZojanzX9TSymeUkbPztGh4SRWfc0Smc+2eZjOZl2B4RuuIb3oqmhxz
 /ROBTupVgRWXnMzy70YKiDt0sMdTR1w==
X-Received: by 2002:a05:6a00:c96:b0:845:ce5f:c926 with SMTP id
 d2e1a72fcca58-85372ea6666mr12573090b3a.1.1787749630922; 
 Wed, 26 Aug 2026 06:07:10 -0700 (PDT)
X-Received: by 2002:a05:6a00:c96:b0:845:ce5f:c926 with SMTP id
 d2e1a72fcca58-85372ea6666mr12572918b3a.1.1787749630363; 
 Wed, 26 Aug 2026 06:07:10 -0700 (PDT)
Received: from [10.219.57.226] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85359cdfeebsm917003b3a.4.2026.08.26.06.07.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 06:07:09 -0700 (PDT)
Message-ID: <23e31249-cce2-421e-88f7-1a2af66e34b6@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 18:37:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] accel/qda: Qualcomm DSP Accelerator driver
To: rob.clark@oss.qualcomm.com, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com,
 dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 Anandu Krishnan E <anandu.e@oss.qualcomm.com>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <3322b42b-3755-45ec-ad55-345125f0d488@kernel.org>
 <10349e29-b583-403f-a89a-9a00c73666bc@oss.qualcomm.com>
 <87dca76c-851e-4cc3-ab91-68949d283b79@kernel.org>
 <CACSVV01eYr6FyA6XBG0xw0yv2dydvTEhcY-WUy07mxM8WwkZcg@mail.gmail.com>
 <318f14c2-0e87-4e07-8173-1511dca67d78@kernel.org>
 <CACSVV01T=ytVJKM7NRoBTAJm7vH+JPJNT9Tftu5X9YskGXerwg@mail.gmail.com>
 <e7b4eceb-cb3a-49ea-bed9-728c958594b0@kernel.org>
 <CACSVV03ypjBYkhRpt=TyDwOKhejKKke3x=Fi_TvxXN-5U_rCsw@mail.gmail.com>
 <fb834ae5-7113-4a86-bb84-ca5115c8d7ff@kernel.org>
 <CACSVV018jB4WRRJ_CUHQmkHXZcqauWJXWGgrzY_HA6cFQ+Q3Xw@mail.gmail.com>
 <dd3da35b-1db6-43a4-ae1f-35620692f51f@kernel.org>
 <CACSVV01o_XYuSzaYGbo9pY=459qiA_fgL_KRHVJH+LH4RYcMzQ@mail.gmail.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <CACSVV01o_XYuSzaYGbo9pY=459qiA_fgL_KRHVJH+LH4RYcMzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=MqZiLWae c=1 sm=1 tr=0 ts=6a8ee4ff cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=HVFQHpX-XFYh-alqn_4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: z3KbWQOL9QTTNMC-WOp5cPerGkL6QUoe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwOCBTYWx0ZWRfX7s9mvDehhePP
 iRkxxnuPeuRmszqC8V/FO7H8JzhKEZZuFoItQQDI9Qhymx7Vupv71/HShkHrdyf8jUyhd8nCJuw
 Qp8TYVKHojHQWlTFRN9t3nEFcM8xIzu+lm79c28mrJd34DiormPG2mZsiCbWlUs5ff5v/XIrpwC
 8KIpn+yVfO55SGjmphMTa4BhggzG8kjv07sFJEuRUxKGoZSkjwRxXp6F3xU4wE1HoJl8tJy26RG
 d6H0Fjk8lH3c4cZDegR+ksO8txIhatyeSrmc2zkAzlVlR9PmqdDu/0P5Uhx7xeyQTO+YHROZqPz
 4CcQsU3GTHjc5ZD7o4PSTS55BHnF0C6DpZQY+4AO6JQaoNYvAZ0mQ/JB97eDqbwr+p7JrBz3t+/
 vUAsr0wN6FAADzf5DFJRAeHhK9da8cRsT8wWL3xePpePaKJnURh3hJSa2DbB80c7iR8E9fdaoPi
 unO73P3ZLlydm/n8pNQ==
X-Proofpoint-GUID: z3KbWQOL9QTTNMC-WOp5cPerGkL6QUoe
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwOCBTYWx0ZWRfX8Fy2ZkD+MJ6Y
 VLvcCLLM3xE9xmAKsFDCD/Ya94YfZ/ywXS/z2/nFTmvs1NSSJYksUJ/l7bARoeQlQgkbWSNBkZ4
 CTFEcNZvwQXXh9D20HlIBl01bUIu4ro=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260108
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

On 20-08-2026 20:17, Rob Clark wrote:
> On Wed, Aug 19, 2026 at 11:15 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 19/08/2026 17:48, Rob Clark wrote:
>>> On Wed, Aug 19, 2026 at 8:27 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>> The rule of usptream development is that we do not accept duplicated
>>>> code, just because a vendor wants to write something new. This is
>>>> basically the concept applied all over the drivers tree, where we pushed
>>>> back against all sorts of duplications all over the vendors.
>>>>
>>>> What I miss in this thread is why would there be any exception here. We
>>>> do not grant exceptions from standard practices on "I want" reasons.
>>>
>>> I agree that we should not have duplicated drivers just for vendor
>>> lolz.  But when it comes to adopting common frameworks and integrating
>>> better into the ecosystem, this doesn't seem like something we should
>>> actively discourage.  I don't think this is a case of vendor lolz, but
>>
>> No one discourages it. Following standard Linux kernel practices and
>> requirements is not discouraging, do not twist the narrative here.
>> Again, it is standard upstream review telling that we do not duplicate
>> drivers. Ever, unless there is serious exception needed.
> 
> I wasn't trying to twist the narrative, just trying to come up with a
> path forward that isn't "no" or "improve existing driver", since
> neither of those gets us towards a future using common frameworks.
> 
>> I asked why there should be an exception granted? Is the reason for
>> exception following:
>> "We want to adopt common framework"
>> ?
> 
> Possibly?  But I don't think we want two drivers to be any sort of
> long term solution.  (Ie. as long as venus/iris have co-exist.)
> 
>>
>>> rather reacting to drm/accel emerging as the standard framework for
>>> this sort of driver.
>>>
>>> So how do we get from here to there?
>>
>> What is wrong with my proposal?
> 
> Maybe I missed something, my understanding was your proposal was
> "Grow/replace/improve existing driver instead of coming with a
> duplicate"..  grow or improve doesn't move us toward common
> frameworks.  Maybe "replace" is a valid option.  If there is something
> I missed, then I apologize.
> 
> Options I can think of are:
> 
> 1. Hardware cutoff.. new hw gets new driver, existing hw gets existing
>    driver
> 2. Backwards compat chardev registered by new driver, providing existing
>    UABI.  I'm not 100% sure about the feasibility/drawbacks of this..
>    AFAIU the fastrpc folks where planning a backwards compat layer in
>    userspace, so maybe it is possible.
> 3. exception?
> 
> I'd like to know what the feasibility of #2 is, since at a high level
> that sounds like the best option.  Possibly limit exposure of legacy
> UABI to existing hw so we don't get into a place of needing to extend
> the legacy UABI for new hw?
> 
> But #1 sounds like a non-controversial place to start regardless.
> Possibly with #2 coming as followup and necessary step before eventual
> migration to new driver for existing hw?
> 
> Even if we start with #2, how do we handle first-merge-window
> bugs/regressions without reverting addition of new driver and removal
> of old?  It seems like we'd need a window of a couple release cycles
> where both drivers exist?
> 
> Maybe others have other/better options in mind?
To all, I'm seeking on the approach I should follow to go ahead here. I
can work on implementing #1(as per Rob's list) with hw specific
compatible for v4 if it's acceptable.

#2(compat driver) is something that we are still exploring as we
couldn't find any standard way to achieve it. We might start a separate
discussion for that once we have few possible designs with us.

Happy to take any other suggestion also.>
> BR,
> -R

