Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55420CDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 14:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB2E310E4D9;
	Tue, 23 Jun 2026 14:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="mJwAvi7w";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 647D310E4D9
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 14:00:31 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6976b0c5adbso7637878a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 07:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1782223230; x=1782828030; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pW2T0l7vNC7YUbJOOE1maSFRjhJC2eie7o0FsVV1LoQ=;
 b=mJwAvi7wgmSDX6izEEIUw6JJjoyASz9fLJsO/cEp22dNVSx3do9NpLq536R/8fXT2X
 JBTvsVCudcj5ycgLbumsGc+D2sFqbUizA8cRNnPbmz5obOZn8P8kbo1IYOwUl1j5WFHb
 WEHO0Bj2639H6L3F45dUW9XQlkxj/2948yef8GheybuPfN2p9+U6m2ixV9G+YpLdJzqz
 sQn0sk4BlwZ/9d2XHRSwu6u1dKr/a37ARZScmhqfwz0d/kEp/Y76qLMoHyyZhjY6hbR2
 7f3ScZmRwNPgNqGgbwp6S4u8mI8ZE4AKZ0vF2fiZGdNxHYvBzFeVQ+yyvOyH7MZMoFLu
 Rlog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782223230; x=1782828030;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pW2T0l7vNC7YUbJOOE1maSFRjhJC2eie7o0FsVV1LoQ=;
 b=B6HjcwplLc/Ab3Pj1EaSHqSsFqRarDxA0keQvQuYULhw5jUVjp+RGzPrW51Mpd/7Pe
 xcQKrCMz+K6HENQdecjUXS71G6QHJcdMwqE2lcYrJxFI4m80hjzum74Dwq2HzydlZWy6
 cWA2jHCkN+xaEUaNC2e8rs3nE223LzDf6paXQGHrkEcSXJAbPBf2zVKfJ9uwf9rUm1Ja
 poxmopQWtTucnbG/dYvIKQ2eX/HG0mEjGsEAqRe3OhyVB9mujDK4/vv6U/huwmWFmZGP
 UAhOlfhUe9FfISJLMKm3RcV7JDz1OgEAuaoFwAUAtagSo8A/dhOa6WJs8+Ah4b47f6G7
 qB4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WoHxCq/jGpUM34rq7mNEgPw+Gm+gn1L1o97iVr8ztNWHXmaD/HfTGNi/Dt6qKJbntTLae4mWpvAk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdYOFWaToXI5ZCyVWYd8VZ0e79zBHGLOkgkWRwbaXySgI0Vk6d
 jGufbUG5wYojZQPBpvdBEwUpobn/zMx3f35JXUfu1zZoNvQre/n2may/JLcR9FTysbQ=
X-Gm-Gg: AfdE7cmIMe6RXy9lMxI0Iy4YL3+34fypVr94R5XjGcE/B/HpZ3bTyXt6D+1s0z3ZNM2
 7bZJdnmkwnNFyNTa9d20uD3q7KZLfyafEZDX4/d41IwBOgNPGQ+ABLnyKRob0Og0+Schb2LVKEc
 jDC+E/8731biyFWBuKmOolje9CcLrEcETzwhedqmXgNM0a0AJgPz06y5PUfZ8iQOV8LfGQFPSaX
 rMNe/WE5Xnz3r9zAbk641uKBD1wOqVIcoz8y4mKmu7ldB2Oo5RVfFRuwFYeHLoDReouj8MgSokN
 ItLCJJkeVmchKkKp3FE6ANDNWk59weHUZirxB5r3L7su2cYMQL2dEHuk09SSFE6QA8FAMczIICi
 bhgMKMEHZsVfNzEQfq7e9j/BtDb7b6zIp1TqTiqySPi4BlB1WjZ4aglQRs9LYc0yBs92ATwleeg
 h0G+VkNkEle2Z4RWM3BdBwEJtAvBLl8cwxvA==
X-Received: by 2002:a05:6402:3218:b0:697:b10a:35ce with SMTP id
 4fb4d7f45d1cf-697dba620e2mr1527552a12.1.1782223229172; 
 Tue, 23 Jun 2026 07:00:29 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-697d3c7dc3fsm1544454a12.13.2026.06.23.07.00.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 07:00:28 -0700 (PDT)
Message-ID: <5a0d7111-c765-43c7-9bf1-6eb055b6784c@ursulin.net>
Date: Tue, 23 Jun 2026 15:00:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf/dma-fence: Set better string for
 dma_fence_driver_name()
To: Philipp Stanner <phasta@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@igallia.net>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20260623133457.1029880-2-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260623133457.1029880-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 23/06/2026 14:34, Philipp Stanner wrote:
> dma_fence_driver_name() reports that a driver whose fence is already
> signaled is a "detached-driver". This is incorrect, the driver might
> still be loaded and running.
> 
> Rename that string to something more descriptive.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> Just compile-tested.
> ---
>   drivers/dma-buf/dma-fence.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index c7ea1e75d38a..9c3dfa7b0066 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -1173,7 +1173,7 @@ const char __rcu *dma_fence_driver_name(struct dma_fence *fence)
>   	if (!dma_fence_test_signaled_flag(fence))
>   		return (const char __rcu *)ops->get_driver_name(fence);
>   	else
> -		return (const char __rcu *)"detached-driver";
> +		return (const char __rcu *)"driver-whose-fence-is-signaled";

My logic was "driver detached from the fence". :)

Anyway, no strong opinion apart to be mindful on whether some output 
becomes overly verbose.

Regards,

Tvrtko

>   }
>   EXPORT_SYMBOL(dma_fence_driver_name);
>   

