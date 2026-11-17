Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87578606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=MQI8/J6Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E51A210F6CC;
	Tue, 17 Nov 2026 12:53:20 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB08210F6CC
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794919993;
 bh=b//NguUji4jyiZfZWVRqjJq3eBMUzebVwK8kbx1zR8I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MQI8/J6QJ1PfMD3BA98v0q5scoDQZBigWJSvetgvtc2F8nyb2tb3BGrK2fGRvq+gO
 dg1QXOEnIidiM+rfRbIyl2aTCrPLF/g6Pe+DriRDrL+bDHofYD5p7kgvvPcQ6cybwD
 aS2hX+rvQhJxyW2IijFfK6S/HlJ3dVqhbMzlxqwSsUi5e9jhGGsfbhn0IqeVHXfpM3
 zT0wWWi1uRFe0cASUEhQjVGdyuZu/po9hMOWDF9lNdid03kERVE0gwK9ZpP5heVmSp
 UDGID3LALNasPD0W0MFTTDpx2nL7hTp+8BVtkZ0Kj4ZXCGYRodse0tvMdYg21FT5yh
 S6LUwNyXUHXfg==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9F90817E0311;
 Tue, 17 Nov 2026 13:53:12 +0100 (CET)
Message-ID: <200ef6c1-eced-4c36-832d-3fb409aac866@collabora.com>
Date: Tue, 17 Nov 2026 13:53:12 +0100
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <bbefcf0b-b31e-4f74-bf79-b0ccc983f62b@kernel.org>
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

On 11/17/26 13:35, Krzysztof Kozlowski wrote:
> On 21/09/2026 13:38, Luca Leonardo Scorcia wrote:
>> Add all the DRM nodes required to get DSI and DPI to work on MT8167 SoC.
>>
>> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8167.dtsi | 369 +++++++++++++++++++++++
>>   1 file changed, 369 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
>> index 27cf32d7ae35..a50bae4307c1 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
>> @@ -16,6 +16,22 @@
>>   / {
>>   	compatible = "mediatek,mt8167";
>>   
>> +	aliases {
>> +		aal0 = &aal;
>> +		ccorr0 = &ccorr;
>> +		color0 = &color;
>> +		dither0 = &dither;
>> +		dpi0 = &dpi0;
>> +		dpi1 = &dpi1;
>> +		dsi0 = &dsi;
>> +		gamma0 = &gamma;
>> +		ovl0 = &ovl0;
>> +		pwm0 = &disp_pwm;
>> +		rdma0 = &rdma0;
>> +		rdma1 = &rdma1;
>> +		wdma0 = &wdma;
> 
> Folks, what is happening here? Why Mediatek is adding bunch of
> undocumented aliases? This should have never been accepted to Mediatek SoC.
> 

It's always been like this on MediaTek from day 1, what's up with that!?

Btw, in this case the aliases are useless.

Cheers,
Angelo

