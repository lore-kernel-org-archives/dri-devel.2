Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84663606A32C
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Fy4TrY6T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7F5F10EB78;
	Mon, 23 Nov 2026 10:05:33 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2A4E10EB78
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 10:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795428326;
 bh=a1/XioPUQOk/Y+CGy7Ob4OJm/x2Pd/UgMyEWsylmoiU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Fy4TrY6TmXh/ljo+lsHC4WaWEu3NPgVkyxOLpm54IQha82S/0hNWaowDfWqbOZ9Q9
 7c5OKwrgrF9RTFGykd3PuoR0dW/b/oI2aG0DtAEUJF63bU9wpv52bLBXd3/rGicn0O
 FQHJVomaKIwGtUsxz83Kjhy4HYSMH+R3eCWU7TnpgKtkjnjYILzWyPnwh+g7+mkM5L
 G+/HPAoTC+Rq3S31aumUL7381kXn3vNC7FnA9A4cbjMc1Ie9KfUdRLwedlyG5Ur1KD
 xGqgkRIL3FlM+yXwz62bKtI566fz7CR5vWDQ1/VMFNvXud8H7pzlF/u5yTK7b5NPyV
 J29BH1iSf8yFQ==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E9C5517E007F;
 Mon, 23 Nov 2026 11:05:25 +0100 (CET)
Message-ID: <33cf13e4-6df0-45f8-b621-ffe3f43419c9@collabora.com>
Date: Mon, 23 Nov 2026 11:05:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/46] dt-bindings: display: mediatek: Introduce
 Digital Video Output HW
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc: "robh@kernel.org" <robh@kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
 <mripard@kernel.org>, "kernel@collabora.com" <kernel@collabora.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "airlied@gmail.com" <airlied@gmail.com>,
 =?UTF-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?= <Justin.Yeh@mediatek.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-28-angelogioacchino.delregno@collabora.com>
 <98cde7319f539cab9f72ec370d309b26569889c9.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <98cde7319f539cab9f72ec370d309b26569889c9.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 11/20/26 03:17, CK Hu (胡俊光) wrote:
> On Tue, 2026-07-14 at 13:43 +0200, AngeloGioacchino Del Regno wrote:
>> Add documentation for the Digital Video Output (DVO) IP found in
>> the newer generation SoCs MT8196, MT8189 and their variants.
>>
>> This is effectively a more capable block replacing the DisplayPort
>> Interface (DPI/DP_INTF) one found in older SoCs.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../display/mediatek/mediatek,mt8196-dvo.yaml | 143 ++++++++++++++++++
>>   1 file changed, 143 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml
>> new file mode 100644
>> index 000000000000..b38960327ca1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml
> 
> This file would include multiple SoC dvo, so it's better to use mediatek,dvo.yaml.

Devicetree bindings maintainers will disagree with this statement ;-)

> 
>> @@ -0,0 +1,143 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: https://urldefense.com/v3/__http://devicetree.org/schemas/display/mediatek/mediatek,mt8196-dvo.yaml*__;Iw!!CTRNKA9wMg0ARbw!n3pk94kKoN-7zfem5SHfJn_ixDmAleFOW2dJwmZ8W5gJz-iEQGAN6yOkpupaMXAvAlr3KfAndB5Fjy57tNXsxA_uvNy3$
>> +$schema: https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!n3pk94kKoN-7zfem5SHfJn_ixDmAleFOW2dJwmZ8W5gJz-iEQGAN6yOkpupaMXAvAlr3KfAndB5Fjy57tNXsxNztWOiH$
>> +
>> +title: MediaTek Digital Video Output (DVO) Controller
>> +
>> +maintainers:
>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> +
>> +description:
>> +  The MediaTek Digital Video Output (DVO) hardware provides 120-bits (4P) data,
>> +  video timing and info data for the Embedded DisplayPort, hardware-abstracting
> 
>  From the compatible listed below, DVO not only for eDP, but also DP, right?
> 

Yeah, on MT8189 it's also for DP.

>> +  the previous generation Display Port Interface (DPI/DP_INTF) blocks, other
>> +  than providing new capabilities.
> 
> No new capability? But what you list below is new capability or the same as DPI/DP_INTF?
> 

The new capabilities include PSR and MSO, other than the 4T1R in output (as DP_INTF
did support that but only for very specific configurations).

>> +  This hardware block supports 1/2/4 pixels per iteration in both its input and
>> +  output and provides 8/10-bit RGB, YUV422 and YUV444 data formats in output,
>> +  other than supporting input/output video window cropping and padding.
>> +  Digital Video Output also provides Panel Self Refresh (PSR) and Multi-SST
>> +  Operation (MSO) features for eDP 1.3/1.4.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - mediatek,mt8189-dp-dvo
>> +      - mediatek,mt8189-edp-dvo
> 
> This series is so large, so it's better to drop any thing that is not related to mt8196 and you could add them back later.

Are you sure you want me to drop that?

It's just 10 lines of code and some platform data really, I don't think it's all
that much to justify dropping it?

Cheers,
Angelo

> 
> Regards,
> CK
> 
>> +      - mediatek,mt8196-edp-dvo
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>>
> 
