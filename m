Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FB3C55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 11:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5B3710E13F;
	Thu, 30 Jul 2026 11:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VETCDlPw";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B0E010E13F
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 11:24:54 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4B4FC1E4;
 Thu, 30 Jul 2026 13:23:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1785410627;
 bh=DzHnVwnTc6oGfkh+g4/rk5yYatTVNL0ZjN3aJU+T3g4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VETCDlPwHNMJqXG2NeITlk/mu/auklkTMfYlkwHbuopiSRmhqT49daRCQFyr7Hyrw
 J4VrHiYoXsg/IitpJn2FSjpaPkPdIzvRigiNijNvy6JvwIV0Ksc8f8bgAKEH9gDh4x
 A6oEnIK4dQbcRj0bCjiT9x2OegsAw2tX1SsqPOqs=
Message-ID: <eca9129f-75ab-4513-bff6-08d89ebe4b50@ideasonboard.com>
Date: Thu, 30 Jul 2026 14:24:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/15] dt-bindings: display: ti,am65x-dss: Add
 ti,dpi-io-ctrl
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Louis Chauvet
 <louis.chauvet@bootlin.com>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260529-beagley-ai-display-v3-0-7fefdc5d1adf@ideasonboard.com>
 <20260529-beagley-ai-display-v3-4-7fefdc5d1adf@ideasonboard.com>
 <20260530-slim-private-dachshund-e869cd@quoll>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20260530-slim-private-dachshund-e869cd@quoll>
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

Hi,

On 30/05/2026 11:58, Krzysztof Kozlowski wrote:
> On Fri, May 29, 2026 at 11:45:34AM +0300, Tomi Valkeinen wrote:
>> The DPI output pipeline in K3 SoCs contains the display subsystem (DSS)
>> which produces the in-SoC parallel video signal, and a DPI block which
>> adjusts the signal to the external MIPI DPI output.
>>
>> The DSS IP has registers to configure whether the data and sync signals
>> are driven on rising or falling clock edge, and on some SoCs these are
>> automatically conveyed to the DPI block which needs that configuration
>> to properly output the MIPI DPI signal.
>>
>> However, on some SoCs the DPI block configuration has to be done
>> manually, using an extra register outside the DSS, DPI0_CLK_CTRL in
>> MAIN_CTRL_MMR_CFG0 block, which controls the DPI block's behavior.
> 
> Why don't you constrain this properyy per SoC in such case? Why is it
> applicable to each SoC, even though you said it is done via DSS IP
> registers?

Good point. I'll restrict per SoC.

>> Currently the DPI0_CLK_CTRL is never written, so it's always 0, meaning
>> the data and sync are always driven on a rising clock edge regardless of
>> the DSS configuration.
>>
>> Add 'ti,dpi-io-ctrl' property, which contains phandle to the
>> MAIN_CTRL_MMR_CFG0 block and the offset to the DPI0_CLK_CTRL register,
>> so that the DSS driver can configure the data and sync signals
>> correctly.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>> ---
>>   .../devicetree/bindings/display/ti/ti,am65x-dss.yaml          | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
>> index 588d72d4ec0d..902ae2122d86 100644
>> --- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
>> +++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
>> @@ -113,6 +113,17 @@ properties:
>>         and OLDI_CLK_IO_CTRL registers. This property is needed for OLDI
>>         interface to work.
>>   
>> +  ti,dpi-io-ctrl:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description:
>> +      phandle to a syscon device node containing the DPI0_CLK_CTRL register,
>> +      with the offset to DPI0_CLK_CTRL as an argument.
>> +    maxItems: 1
> 
> Drop
> 
>> +    items:
>> +      items:
> 
> missing '-'. See other examples of phandle-array, for example one of
> the first search results: qcom,ssc-block-bus.yaml
Thanks, I'll use that form.

  Tomi

