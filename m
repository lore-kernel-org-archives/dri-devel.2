Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A144A606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=ajYCL367
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 182C310F795;
	Tue, 17 Nov 2026 14:21:44 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB62F10F77B
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 14:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794925296;
 bh=eTx+m5M3eFCbXDGOYEw1mPbbOX2QC6ej+9qJUtLPPPA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ajYCL367ISKImGmT25/L/sEItav5F0loEo2zyWlbjMcNCm8/aFlaOJtx6jqxsOVYu
 QSufOBlmADseEIEA/29cEP+xsToNNMpfcp6vKJyDNxi4Vt7is00vCP7ABY7HDPBMZ3
 MoJMUoisEmhnxCs/ibMCfZfMXllR0Z7TJ/eC180yjahuFUqQQrwZDUWL0iFXL32O3D
 j5QZi3w4vL3s9hVJS+D0O5gKAvGjsU4bedEcCxzHk4ImnU7UDN+eAjitlObb6+QTma
 gHRGYxCzx6Q5FZ6qTVB9jp3sxTyMmu+xSTtY7+PnIpnlSS7pLI7+ozXD2rFkal2dR4
 o7EOcHtoGf8EQ==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 6C0BF17E0069;
 Tue, 17 Nov 2026 15:21:35 +0100 (CET)
Message-ID: <63da5790-984b-4760-8e92-85b5d2269b30@collabora.com>
Date: Tue, 17 Nov 2026 15:21:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: mediatek: mt8167: Add DRM nodes
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 linux-mediatek@lists.infradead.org
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, CK Hu <ck.hu@mediatek.com>,
 Jitao shi <jitao.shi@mediatek.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260921113914.779393-1-l.scorcia@gmail.com>
 <20260921113914.779393-5-l.scorcia@gmail.com>
 <bbefcf0b-b31e-4f74-bf79-b0ccc983f62b@kernel.org>
 <200ef6c1-eced-4c36-832d-3fb409aac866@collabora.com>
 <5715e9e5-857d-4104-aedd-9662da0fc0ab@kernel.org>
 <911e4163-8a2c-4ca2-8903-8d3ddb7266e8@collabora.com>
 <600165c4-eaa7-4b1e-806c-63d3b97d5064@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <600165c4-eaa7-4b1e-806c-63d3b97d5064@kernel.org>
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/17/26 14:12, Krzysztof Kozlowski wrote:
> On 17/11/2026 14:00, AngeloGioacchino Del Regno wrote:
>> On 11/17/26 13:55, Krzysztof Kozlowski wrote:
>>> On 17/11/2026 13:53, AngeloGioacchino Del Regno wrote:
>>>> On 11/17/26 13:35, Krzysztof Kozlowski wrote:
>>>>> On 21/09/2026 13:38, Luca Leonardo Scorcia wrote:
>>>>>> Add all the DRM nodes required to get DSI and DPI to work on MT8167 SoC.
>>>>>>
>>>>>> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
>>>>>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>>>> ---
>>>>>>     arch/arm64/boot/dts/mediatek/mt8167.dtsi | 369 +++++++++++++++++++++++
>>>>>>     1 file changed, 369 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
>>>>>> index 27cf32d7ae35..a50bae4307c1 100644
>>>>>> --- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
>>>>>> @@ -16,6 +16,22 @@
>>>>>>     / {
>>>>>>     	compatible = "mediatek,mt8167";
>>>>>>     
>>>>>> +	aliases {
>>>>>> +		aal0 = &aal;
>>>>>> +		ccorr0 = &ccorr;
>>>>>> +		color0 = &color;
>>>>>> +		dither0 = &dither;
>>>>>> +		dpi0 = &dpi0;
>>>>>> +		dpi1 = &dpi1;
>>>>>> +		dsi0 = &dsi;
>>>>>> +		gamma0 = &gamma;
>>>>>> +		ovl0 = &ovl0;
>>>>>> +		pwm0 = &disp_pwm;
>>>>>> +		rdma0 = &rdma0;
>>>>>> +		rdma1 = &rdma1;
>>>>>> +		wdma0 = &wdma;
>>>>>
>>>>> Folks, what is happening here? Why Mediatek is adding bunch of
>>>>> undocumented aliases? This should have never been accepted to Mediatek SoC.
>>>>>
>>>>
>>>> It's always been like this on MediaTek from day 1, what's up with that!?
>>>
>>> I wrote what is wrong - they are undocumented. You were never allowed to
>>> add undocumented ABI, never. Even 10 years ago.
>>>
>>
>> Well, that's right.
>>
>>> I don't know what is day 1 in this context, but for a few (5-8 years?)
>>> we do not allow more custom aliases. Neither new DTS users of these.
>>>
>>
>> That actually poses a severe issue, as mediatek-drm relies on aliases to find out
>> the instance number of the display controller components, on all SoCs.
> 
> If someone sent these for DT maintainers review, we would provide review
> telling they are not allowed and you need to use other methods. The
> problem is that someone sneaked undocumented ABI.
> 
> Instance IDs are not allowed in DT - neither as aliases nor as properties.
> 

Okay.

> If the graph topology or phandles do not point to proper relation
> between components, then the recommended way I know (happy to learn more
> myself) is to map instances to IDs in the drivers. For example
> Qualcomm/MSM is doing that.
> 

They do point to proper relation between components, but connecting one IP to
another is one thing, knowing the fixed hardware instance number (so how many of
those hardware IPs are there, and which one is that exact one) is another.

>>
>> Any advice on how to possibly resolve this without rewriting the entire thing?
>>
>> Mapping that by mmio address in the driver seems too stupid/dirty/bad/etc.
> 
> Driver needs that, so why exactly stupid?

Really feels like going back to the days when devicetree was not a thing and all of
the MMIOs (on ARM at least) were added into a mach file.

 >
> You do not represent any
> actual hardware information in DT with these aliases.

That depends on how you see it (as in, on the point of view), really, because well
technically the second ReadDMA IP is ... not the ... primary, as it's the secondary
one - as much as the third DPI is not the primary one (even though DRM can make it
so that it can be used as a primary output, but that's a software thing, not HW).

So... well, with that point of view... those aliases *are* representing information
about the hardware.

But I know that you're not complaining just about this, and this reply is not a way
to argue all that much, just a bit of thinking out loud.

 >
> You want to tell
> drivers how drivers should behave - that's not a job for DT,

I want to tell drivers what is the first or the second or the third hardware
instance of the same IP, I don't want to tell drivers how drivers should behave
from devicetree.
The drivers are behaving differently with different hardware (read as: hardware
that is *physically* located in front of something else, or somewhere else anyway)
as in with different hardware instances.

> that's job
> for driver data. Of course if there is smarter way than MMIO->ID, I am
> all in.

You can't imagine how much I was hoping for you to say something about an
alternative solution to that.

As I said, it feels a bit like pre-DT times, but what I get from you is that this
is cleaner than just adding information about the real hardware instance number in
devicetree (no that's not just MediaTek, qcom also had similar issues as you said).

Cheers,
Angelo
