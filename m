Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D13606A329
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T4c7eFfD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6530610F719;
	Tue, 17 Nov 2026 13:12:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21B5B10F700
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:12:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 17F2C634CC;
 Tue, 17 Nov 2026 13:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A9E1F000C4;
 Tue, 17 Nov 2026 13:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794921132;
 bh=NaocV5i0wmjEhtCT2sDj6B3rEgWHxQJ1puADK2Yh36I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=T4c7eFfDB54djRWp25C7fnistvTCVMopMDAasuZ9Ig6g3pVVz00LGG1p6tuz+h/Ez
 TVNz8dQvLpaNZycq4+DfKd9+W0ljOcv8BNCtgFHuWf8nXidoz8qwY/9Cterv2sWBz+
 xHpjx029/DrkrmV7FJo3qfPal25pRc/A1YqKuW+J9OLKn6VGFRU6n3Qdyb6Zm66EZX
 DPZ1v8bO3g2hw3twqO/wdLGNvghb6MuCvChNH8DWXgnhllRMrxQayKO7EdazZlSrRo
 8+NWmamh8ccOKmevgtl5UQJ/7uKWyc29gcqVuyuxveUQ413lYvabEtcWqfsyPiYaam
 baj8LKdf4gDxQ==
Message-ID: <600165c4-eaa7-4b1e-806c-63d3b97d5064@kernel.org>
Date: Tue, 17 Nov 2026 14:12:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: mediatek: mt8167: Add DRM nodes
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <911e4163-8a2c-4ca2-8903-8d3ddb7266e8@collabora.com>
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 17/11/2026 14:00, AngeloGioacchino Del Regno wrote:
> On 11/17/26 13:55, Krzysztof Kozlowski wrote:
>> On 17/11/2026 13:53, AngeloGioacchino Del Regno wrote:
>>> On 11/17/26 13:35, Krzysztof Kozlowski wrote:
>>>> On 21/09/2026 13:38, Luca Leonardo Scorcia wrote:
>>>>> Add all the DRM nodes required to get DSI and DPI to work on MT8167 SoC.
>>>>>
>>>>> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
>>>>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>>> ---
>>>>>    arch/arm64/boot/dts/mediatek/mt8167.dtsi | 369 +++++++++++++++++++++++
>>>>>    1 file changed, 369 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
>>>>> index 27cf32d7ae35..a50bae4307c1 100644
>>>>> --- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
>>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
>>>>> @@ -16,6 +16,22 @@
>>>>>    / {
>>>>>    	compatible = "mediatek,mt8167";
>>>>>    
>>>>> +	aliases {
>>>>> +		aal0 = &aal;
>>>>> +		ccorr0 = &ccorr;
>>>>> +		color0 = &color;
>>>>> +		dither0 = &dither;
>>>>> +		dpi0 = &dpi0;
>>>>> +		dpi1 = &dpi1;
>>>>> +		dsi0 = &dsi;
>>>>> +		gamma0 = &gamma;
>>>>> +		ovl0 = &ovl0;
>>>>> +		pwm0 = &disp_pwm;
>>>>> +		rdma0 = &rdma0;
>>>>> +		rdma1 = &rdma1;
>>>>> +		wdma0 = &wdma;
>>>>
>>>> Folks, what is happening here? Why Mediatek is adding bunch of
>>>> undocumented aliases? This should have never been accepted to Mediatek SoC.
>>>>
>>>
>>> It's always been like this on MediaTek from day 1, what's up with that!?
>>
>> I wrote what is wrong - they are undocumented. You were never allowed to
>> add undocumented ABI, never. Even 10 years ago.
>>
> 
> Well, that's right.
> 
>> I don't know what is day 1 in this context, but for a few (5-8 years?)
>> we do not allow more custom aliases. Neither new DTS users of these.
>>
> 
> That actually poses a severe issue, as mediatek-drm relies on aliases to find out
> the instance number of the display controller components, on all SoCs.

If someone sent these for DT maintainers review, we would provide review
telling they are not allowed and you need to use other methods. The
problem is that someone sneaked undocumented ABI.

Instance IDs are not allowed in DT - neither as aliases nor as properties.

If the graph topology or phandles do not point to proper relation
between components, then the recommended way I know (happy to learn more
myself) is to map instances to IDs in the drivers. For example
Qualcomm/MSM is doing that.

> 
> Any advice on how to possibly resolve this without rewriting the entire thing?
> 
> Mapping that by mmio address in the driver seems too stupid/dirty/bad/etc.

Driver needs that, so why exactly stupid? You do not represent any
actual hardware information in DT with these aliases. You want to tell
drivers how drivers should behave - that's not a job for DT, that's job
for driver data. Of course if there is smarter way than MMIO->ID, I am
all in.

Best regards,
Krzysztof
