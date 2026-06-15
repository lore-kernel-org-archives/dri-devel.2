Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA08CD98CE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 04:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B90FA10E184;
	Mon, 15 Jun 2026 04:29:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gIBjQVoV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42A4110E184
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 04:29:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 10A5A4097D;
 Mon, 15 Jun 2026 04:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50261F000E9;
 Mon, 15 Jun 2026 04:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781497742;
 bh=4zOF8ACcQnGINtLJ1j5EoUWcnRZyFCDbQM5I2mI8cJI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=gIBjQVoVnGaNXBlOLr/2kvjLqa0XSsytCf8icoDPAioCUFGNWQnfNXRXxu4NikDqv
 D0oOU+SqepW8a21COfHEblvn+oLteTPOrSQ0Drb8i+VwxagY1aFakmjhNDYf6qqpcs
 lmTDU1wkB1A9YSjy9fJcbbQw7HnkdfNSLjsZ4rPi3++mWCYn314MRTNMAFGdnpeZHg
 2r+tIu+CPbyOVJUrJuNQK5I/HYxYSuGqaapRKH6Vnb5ubmupjB6SSGzWDa3hF2aML0
 BkAm7uMysMiPkdAw09NttKj5XwD+g7ToWZixfZf0mMiL5934O0kX6b4Uvs1Sv1fefv
 WMXzXpB8kFWSQ==
Message-ID: <86943057-f5b4-4fae-9172-45f13814494f@kernel.org>
Date: Mon, 15 Jun 2026 06:28:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] dt-bindings: display: allwinner: Split H616 DE33
 layer reg space
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>, wens@kernel.org
Cc: samuel@sholland.org, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20260509190015.79086-1-jernej.skrabec@siol.net>
 <ahNuuaVlDl0KvOSj@home.wens.tw>
 <032c1099-40ab-470e-8cc3-af6d3cad22d4@kernel.org>
 <nIKN_benRn2Bk8SDZrkMCA@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <nIKN_benRn2Bk8SDZrkMCA@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 14/06/2026 16:08, Jernej Škrabec wrote:
> Dne ponedeljek, 25. maj 2026 ob 14:10:38 Srednjeevropski poletni čas je Krzysztof Kozlowski napisal(a):
>> On 24/05/2026 23:33, Chen-Yu Tsai wrote:
>>> Hi,
>>>
>>> (resent from new email)
>>>
>>> On Thu, May 14, 2026 at 2:04 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>
>>>> On Sat, May 09, 2026 at 09:00:14PM +0200, Jernej Skrabec wrote:
>>>>> From: Jernej Skrabec <jernej.skrabec@gmail.com>
>>>>>
>>>>> As it turns out, current H616 DE33 binding was written based on
>>>>> incomplete understanding of DE33 design. Namely, planes are shared
>>>>> resource and not tied to specific mixer, which was the case for previous
>>>>> generations of Display Engine (DE3 and earlier).
>>>>>
>>>>> This means that current DE33 binding doesn't properly reflect HW and
>>>>> using it would mean that second mixer (used for second display output)
>>>>> can't be supported.
>>>>>
>>>>> Remove layer register space, which will be represented with additional
>>>>> node, and replace it with phandle, which will point to that new, shared
>>>>> node. That way, all mixers can share same layers.
>>>>>
>>>>> There is no user of this binding yet, so changes can be made safely,
>>>>> without breaking any backward compatibility.
>>>>
>>>> There is user. git grep gives me:
>>>> drivers/gpu/drm/sun4i/sun8i_mixer.c
>>>>
>>>> which means this is a released ABI. As I understood, the old code was
>>>
>>> We held off on merging the DT changes so that we could rework this.
>>> I can't find the actual request though. It was probably over IRC.
>>>
>>>> working fine but just did not support all use cases. Why this cannot be
>>>> kept backwards compatible?
>>>
>>> AFAIK the "planes" block is shared between two display mixers. As the
>>> commit message explains, this prevents using the second mixer, since
>>> only one of them can claim and map the register space. And on the H700
>>> (which is the same die as the H616 discussed here but with more exposed
>>> interfaces), there could actually be a use case for the second mixer.
>>
>> It explains why you want to make the changes but not why you cannot keep
>> it backwards compatible.
> 
> I guess it can be backward compatible, but I don't think it makes sense.
> Yes, original driver implemented original DT bindings, but there is no node
> which uses that binding. If there is no user of that, why would driver

Did you check all out of tree users of the ABI? All vendor kernels,
forks and all of them for which the ABI was made for?

If there is no single downstream/out of tree kernel using this ABI, then
of course you do not need to consider it. I don't know how would you
prove that but I am open for suggestions.

> need to support it nevertheless? Supporting only actually used DT binding
> allows for better code architecture, as there is no need to support second,
> unused path. It also simplifies testing, since developer doesn't need to
> test both paths if code is changed in that area.
> 
Best regards,
Krzysztof
