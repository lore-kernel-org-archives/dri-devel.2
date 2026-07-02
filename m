Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF308C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 06:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AA8110E484;
	Thu,  2 Jul 2026 06:46:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RJ3h/KPe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70DA910E484
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 06:46:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A601C601EF;
 Thu,  2 Jul 2026 06:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856DE1F000E9;
 Thu,  2 Jul 2026 06:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782974782;
 bh=AD8tasXyN/lhxwoWmvOAqfCV0TTermi5k/ZYYd4C0Og=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=RJ3h/KPe9Ckf3zjaojadowu7ZZWn7KYNjLvHZePNlZZxzQdxndvZJLHX7PcH6vK9D
 k5mL8KaqFhKqGxlzUMbmqj1fELpv3HAiUoVShP5BubHrtyLGYd2HI7CrQJgz1Vz7Y0
 SSxrBaBFrhdrno6avLqnaUOPSieiFaUl1oAVdoF6FRT4q3bCZSYpUQzuUJt7PaYRGT
 JkxlFXAOco5A6ahqlUVC0ZmzbgqAHm5ldIaP//sUjxzepiKKhI7BgvCj8ItO/m60xj
 JoYLPA74Ne4aBudLHUwp7qbQ4EeEApqi45kcYmysn3d+km9NpiIq8FiOSwjFiV+MCZ
 hO+Zlgs5TrqUg==
Message-ID: <51bad771-aa21-4394-8243-2fa7f275cb36@kernel.org>
Date: Thu, 2 Jul 2026 07:46:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/4] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Jianping Li <jianping.li@oss.qualcomm.com>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
References: <20260609025938.457-1-jianping.li@oss.qualcomm.com>
 <20260609025938.457-4-jianping.li@oss.qualcomm.com>
 <cca276af-3e6a-44d3-a1b6-c2bc401a28cc@kernel.org>
 <a79182b2-2582-4c77-a859-b4d013b700f3@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <a79182b2-2582-4c77-a859-b4d013b700f3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 7/2/26 5:02 AM, Ekansh Gupta wrote:
>>> @@ -1409,8 +1395,17 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>>  	args[1].length = inbuf.namelen;
>>>  	args[1].fd = -1;
>>>  
>>> -	pages[0].addr = fl->cctx->remote_heap->dma_addr;
>>> -	pages[0].size = fl->cctx->remote_heap->size;
>>> +	spin_lock_irqsave(&cctx->lock, flags);
>>> +	if (!cctx->audio_init_mem) {
>>> +		pages[0].addr = cctx->remote_heap->dma_addr;
>>> +		pages[0].size = cctx->remote_heap->size;
>>> +		cctx->audio_init_mem = true;
>>> +		inbuf.pageslen = 1;
>>> +	} else {
>>> +		pages[0].addr = 0;
>>> +		pages[0].size = 0;
>> What is the expected behavoiur in this case?
> Audio daemon is expected to take the memory information to DSP audio PD
> only the first time it goes and attaches there.
> 
> This is the case where daemon was killed but audio PD session is still
> running. In such cases, daemon is not expected to take any memory
> information to audio PD as the earlier shared information is already
> there with audio PD which it is using irrespective of daemon state.>
Wow, this behavior is not documented or pl consider adding a comment
here, Can we not query the dsp before creating new audiopd service?


Does it make sense to attach instead of creating?

--srini

>>> +	}
>>> +	spin_unlock_irqrestore(&cctx->lock, flags);
>>>  
>>>  	args[2].ptr = (u64)(uintptr_t) pages;
>>>  	args[2].length = sizeof(*pages);

