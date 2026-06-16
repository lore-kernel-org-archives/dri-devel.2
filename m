Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E78ECD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 13:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76B9E10EADC;
	Tue, 16 Jun 2026 13:39:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="CoUrDeIq";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9747E10EADC
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 13:39:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CFD135BD;
 Tue, 16 Jun 2026 06:38:55 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 E47083F763; Tue, 16 Jun 2026 06:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1781617139; bh=vHgwqjPAnui1vFfI/U4dBN4GhtxUFMHf4/+uBSe6sDM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CoUrDeIq57GBlIaQSiZ6IIZZXYYwvBjf9AtMwGTg8WTSlBAHp1guaKv17UCEaXsDV
 ih/mSnXhuuoKY/hByor37luu/fn8K8ojll/MhfByHhaIIN1aH20ou4PrVANWJJk40y
 3PfyZb/ddxw1qccXThjCpzVoJ83xZm1hA7B5sSdA=
Message-ID: <4709b24a-f421-4c81-a023-c37ea66c88bd@arm.com>
Date: Tue, 16 Jun 2026 15:38:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] dt-bindings: display: allwinner: Split H616 DE33
 layer reg space
To: Krzysztof Kozlowski <krzk@kernel.org>,
 =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>, wens@kernel.org
Cc: samuel@sholland.org, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20260509190015.79086-1-jernej.skrabec@siol.net>
 <nIKN_benRn2Bk8SDZrkMCA@gmail.com>
 <86943057-f5b4-4fae-9172-45f13814494f@kernel.org>
 <0r4us4OeRRWtJhxvps-bZw@gmail.com>
 <b1f03d81-85db-4303-89ff-64440b6e1890@kernel.org>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <b1f03d81-85db-4303-89ff-64440b6e1890@kernel.org>
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

Hi,

On 6/16/26 05:51, Krzysztof Kozlowski wrote:
> On 15/06/2026 17:47, Jernej Škrabec wrote:
>> Dne ponedeljek, 15. junij 2026 ob 06:28:54 Srednjeevropski poletni čas je Krzysztof Kozlowski napisal(a):
>>> On 14/06/2026 16:08, Jernej Škrabec wrote:
>>>> Dne ponedeljek, 25. maj 2026 ob 14:10:38 Srednjeevropski poletni čas je Krzysztof Kozlowski napisal(a):
>>>>> On 24/05/2026 23:33, Chen-Yu Tsai wrote:
>>>>>> Hi,
>>>>>>
>>>>>> (resent from new email)
>>>>>>
>>>>>> On Thu, May 14, 2026 at 2:04 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>>>>
>>>>>>> On Sat, May 09, 2026 at 09:00:14PM +0200, Jernej Skrabec wrote:
>>>>>>>> From: Jernej Skrabec <jernej.skrabec@gmail.com>
>>>>>>>>
>>>>>>>> As it turns out, current H616 DE33 binding was written based on
>>>>>>>> incomplete understanding of DE33 design. Namely, planes are shared
>>>>>>>> resource and not tied to specific mixer, which was the case for previous
>>>>>>>> generations of Display Engine (DE3 and earlier).
>>>>>>>>
>>>>>>>> This means that current DE33 binding doesn't properly reflect HW and
>>>>>>>> using it would mean that second mixer (used for second display output)
>>>>>>>> can't be supported.
>>>>>>>>
>>>>>>>> Remove layer register space, which will be represented with additional
>>>>>>>> node, and replace it with phandle, which will point to that new, shared
>>>>>>>> node. That way, all mixers can share same layers.
>>>>>>>>
>>>>>>>> There is no user of this binding yet, so changes can be made safely,
>>>>>>>> without breaking any backward compatibility.
>>>>>>>
>>>>>>> There is user. git grep gives me:
>>>>>>> drivers/gpu/drm/sun4i/sun8i_mixer.c
>>>>>>>
>>>>>>> which means this is a released ABI. As I understood, the old code was
>>>>>>
>>>>>> We held off on merging the DT changes so that we could rework this.
>>>>>> I can't find the actual request though. It was probably over IRC.
>>>>>>
>>>>>>> working fine but just did not support all use cases. Why this cannot be
>>>>>>> kept backwards compatible?
>>>>>>
>>>>>> AFAIK the "planes" block is shared between two display mixers. As the
>>>>>> commit message explains, this prevents using the second mixer, since
>>>>>> only one of them can claim and map the register space. And on the H700
>>>>>> (which is the same die as the H616 discussed here but with more exposed
>>>>>> interfaces), there could actually be a use case for the second mixer.
>>>>>
>>>>> It explains why you want to make the changes but not why you cannot keep
>>>>> it backwards compatible.
>>>>
>>>> I guess it can be backward compatible, but I don't think it makes sense.
>>>> Yes, original driver implemented original DT bindings, but there is no node
>>>> which uses that binding. If there is no user of that, why would driver
>>>
>>> Did you check all out of tree users of the ABI? All vendor kernels,
>>> forks and all of them for which the ABI was made for?
>>
>> Since when do we care about out of tree users? I understand that drivers
> 
> Since always? That is the meaning of ABI. Otherwise there is no point to
> discuss ABI at all. Why would it exist if you had all DTS inside kernel
> always matching the code?

In general I would agree with Krzysztof, merged binding means we need to 
stick to it, but in this case I think that would be over the top. As 
Jernej said, there are no users, since we didn't commit on the DTs, and 
the DE33 graphics support in the kernel (bindings and code) is 
incomplete: it's really just the mixer, but no other components (TCON or 
output PHYs) required. So it never worked as such.

In hindsight we could say that we should have never merged the bindings 
without having fully working, reviewed and accepted driver code, for the 
whole display chain. Which we need to do because we create those 
bindings based on reverse engineering efforts, not by looking at 
documentation or design documents (which we don't have).

>> must support old device tree files. Once they work, compatibility must
>> be carried forward. But that's not the case here.
>>
>> In any case, vendor kernels have completely different DT structure. This
>> was developed independently from them. Take a look at [1] how BSP DT looks
>> like, specifically Display Engine node.
>>
>> Of course there are some distros which grab WIP patches from mailing lists
>> soon after they are available. For example, I know that Armbian carried old
>> WIP patches which used old ABI. However, such distros generally don't care
>> about exact solution and ditch patches as soon as proper solution is merged
>> upstream or even when better WIP patches come around. DT files in such
>> distros get updated alongside kernel, they are not hidden in firmware.
>>
> 
> I am not talking about BSP. I am talking about out of tree users for
> which we defined the ABI and called it that way.

If you are looking for DT users outside of the Linux kernel, this is the 
result of a quick check (list of users from ChatGPT, checks by myself 
with git clone/git grep):
Zephyr RTOS: no graphics support
FreeBSD: no H616 support
OpenBSD: no H616 graphics support
NetBSD: no H616 support
U-Boot: no H616 graphics support
Barebox: no H616 support
TF-A: no graphics support
OP-TEE: no (Allwinner) graphics support
EDK2: no Allwinner support

Cheers,
Andre

