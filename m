Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED49C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:00:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C173E10E89A;
	Fri, 18 Sep 2026 10:00:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="mFkJfKuv";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9EE210E882
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 10:00:12 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f63546c3so399804f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 03:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1789725611; x=1790330411; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pRqYG/Al7PnVmwpoxNcDNWD2piCTZsGxHrlmiBtExAI=;
 b=mFkJfKuv0zwx92PbsPbcrrUhmQovRzUaJXm71ApPw7kaQMcjax09ZZitKOaA+Cqws7
 w2ucRtGdi4WnBEjilxzu6WC4cNGsW5c0JlnxdN9eDwzw9WYEDjJyJcQ+FTh4DBlFJ1Qn
 v9pyBe3haWIEbJFXWbis0SjkmGwDcrpuCYTOZaDPeN777ss6ZKF8eiu0jY3xDpbTlubD
 b9tLAJYjlyr6fAUsSQyaPmMEWockV7Ghz12TmoVvESP9quH0B/iA5TcTwX2J7DnnR/jk
 mzx+P5A5ajgrn1yH12hAMmj3o00aEAxvA16mxKK8TBEA5UW/EDpDEcfSLu2C8TtTpiuI
 lAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789725611; x=1790330411;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pRqYG/Al7PnVmwpoxNcDNWD2piCTZsGxHrlmiBtExAI=;
 b=rF5a9WijYG/tDtycLCu/SICm4X5j0WA1JnecOa1ZjWwkgsvuGP2k5515smBVKjTs/Z
 4BezjBcxbSNyfXvRIo/mGvUD5DzaodovmZ70FjUnBWh12NRzK+lb9xU99NB57Ersj033
 +1Q7Zaz/L/dDwYO34PApwCjkLvOrfV2qcEtgXW7eSQx8JPshb0WlQMHme3gSDpyMMTnY
 QJgXo0IIPzliIKZziGx2qb8Syz9EoizISusQifZcWsMj9r3WE3sohk+hCFWdlWyBXVYd
 bciczSi+2tISgKuXsw2QOyP+/KCJGn9llbZQGQ8HpNyt651SWyBKDyo8Br2AB6nVffyv
 m13Q==
X-Gm-Message-State: AFuF++n8TRfknSWfrE1UhyardgBaQIYaJYEG7kZgOen1KI5auS+32EPr
 BEBM76po4G1jy7pwB4lB9tYjxIeRDIyaorq+Nv2pMayMw0DWHdwt3AXef7MgMQqal+Q=
X-Gm-Gg: AYBFou36NkM/ByFU7izIs1v+M1Gj/gMkiA5ccXEAPdD+4tQEKKNR1jsKzgGpEPnXsor
 3MO9ex8zTuRWWTEKQTPcDtLV3zIzHFQavAwR32QLP+VU/zSHue8iLJHumyRq3HM2FuyIbZVaAej
 9atBKVLXg4AYmBxQuIoDzaV9t4sfvGXimvmqNjw02GHQh68c91hydzU7ExQFtMDB7pjQJ7k7HHN
 2tzUqVQqY9TR9P13CaKszK3NyOpVMyMbNUP4F2Da0Semh3BgfoBogBQs9FzkAwRt2kkY4nSLV+P
 2ZQfGZcpeq/tngqAAY/cT68FV7aedsyryR3qfDWlB6DdTmu2z+gN3kkNS4lwWkyd0XcrElH3xJm
 8hz2U19MpO1MCMx4Z7gJREz2rEOeCB9dsTEX4Oy9T9bMNYmYd4+CJay/ZOg93jlHgasrxw7aoM4
 j3deK+x6uywCD3M7EuSRgj7WPoA944nrsiTCuZ3djOrRSB5j9CwS1UHS/fBGpUF9iaiZc5EIdb4
 /TwvvKRTSKBWB4=
X-Received: by 2002:a05:6000:38a:b0:487:144:ee60 with SMTP id
 ffacd0b85a97d-4871e21fd4emr2172267f8f.19.1789725610656; 
 Fri, 18 Sep 2026 03:00:10 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-487200829e1sm3145290f8f.34.2026.09.18.03.00.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 03:00:09 -0700 (PDT)
Message-ID: <a2f5019e-34bf-440f-aa42-facea35a2a41@ursulin.net>
Date: Fri, 18 Sep 2026 11:00:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] drm/i915: Use sleeping selftests for igt_atomic on
 PREEMPT_RT
To: Maarten Lankhorst <dev@lankhorst.se>, intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706114823.752313-7-dev@lankhorst.se>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260706114823.752313-7-dev@lankhorst.se>
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


On 06/07/2026 12:48, Maarten Lankhorst wrote:
> This makes the i915 selftests slightly happier, especially
> related to GPU reset.
> 
> I believe this may be a better approach than trying to convert
> uncore->lock to raw_spinlock

The commit message is a bit lacking because it is easy to make selftests 
happier if you remove most of the coverage. :(

Regards,

Tvrtko

> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
> ---
>   drivers/gpu/drm/i915/selftests/igt_atomic.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/selftests/igt_atomic.c b/drivers/gpu/drm/i915/selftests/igt_atomic.c
> index fb506b6990956..8ae39cf570b76 100644
> --- a/drivers/gpu/drm/i915/selftests/igt_atomic.c
> +++ b/drivers/gpu/drm/i915/selftests/igt_atomic.c
> @@ -39,7 +39,14 @@ static void __hardirq_end(void)
>   	local_irq_enable();
>   }
>   
> +static void __maybe_unused __nop(void)
> +{}
> +
>   const struct igt_atomic_section igt_atomic_phases[] = {
> +#if IS_ENABLED(CONFIG_PREEMPT_RT)
> +	{ "sleeping", __nop, __nop },
> +	{ },
> +#endif
>   	{ "preempt", __preempt_begin, __preempt_end },
>   	{ "softirq", __softirq_begin, __softirq_end },
>   	{ "hardirq", __hardirq_begin, __hardirq_end },

