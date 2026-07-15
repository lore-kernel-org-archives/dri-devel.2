Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5251C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C56210E191;
	Wed, 15 Jul 2026 10:29:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="njsWkz2u";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9521010EF91
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 10:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784111366;
 bh=AX9ADKwhGNIejnHdgFTOEpMoelGADDU7g5rb4mpm7eA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=njsWkz2uS1gOp/dA0tZU/1k3/3eRmfVMITIvSDTNlKwG/trgoT5scu1qflAw7kvoN
 DLhKBrLL/DDASRzQQcujS8xAIdPe/bTOqe948ZK3a4b4ZIBfPdlPLobO0Y5Vv/YlG0
 84T3f3W58yN5UM6e73a6TUSbBM4UsUa/OPa/ZDhCPpkz5oRU0RBO7n461JjULsYMQv
 9Q5cKLkxShpIdZk2FpmZzLReCeKSbQRgdZnyUbIQYCCZJcuAwL75EDSRaTMF/SgT9E
 H1xFER++rQ2Mpipx+zcwvxmwmBblBW2s2wAnnxaH9rGfpiVPQTkU/AjQ7QsEmMOfDq
 0xKbLDIWL7Hbg==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B602A17E07AA;
 Wed, 15 Jul 2026 12:29:25 +0200 (CEST)
Message-ID: <e8d3efc2-bc93-438a-a45d-6ae0b303ad02@collabora.com>
Date: Wed, 15 Jul 2026 12:29:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/10] dt-bindings: display: mediatek: wdma: Add
 compatibles for more SoCs
To: Rob Herring <robh@kernel.org>, sashiko-reviews@lists.linux.dev,
 CK Hu <ck.hu@mediatek.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260713142746.40259-1-angelogioacchino.delregno@collabora.com>
 <20260713142746.40259-10-angelogioacchino.delregno@collabora.com>
 <20260713144221.2C4F91F00A3A@smtp.kernel.org>
 <20260714143433.GA1476641-robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260714143433.GA1476641-robh@kernel.org>
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

On 7/14/26 16:34, Rob Herring wrote:
> On Mon, Jul 13, 2026 at 02:42:20PM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Medium] The compatible string `mediatek,mt6893-disp-wdma` is incorrectly added to the standalone enum instead of the fallback items list.
>> --
>>
>> --- Patch [9]: [PATCH v4 09/10] dt-bindings: display: mediatek: wdma: Add compatibles for more SoCs ---
>> commit 8001f83833ae9c684be67bc719c7aaa056f90763
>> Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>> dt-bindings: display: mediatek: wdma: Add compatibles for more SoCs
>>
>> Multiple MediaTek SoCs have the Write DMA hardware in their Display
>> Controller. This commit adds the missing compatibles for Dimensity 1200
>> (MT6893) and for Kompanio 500/520/820/1200.
>>
>>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
>>> index 97d052b0fb614..c3ed867d058d9 100644
>>> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
>>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
>>> @@ -22,11 +22,16 @@ properties:
>>>     compatible:
>>>       oneOf:
>>>         - enum:
>>> +          - mediatek,mt6893-disp-wdma
>>
>> [Severity: Medium]
>> Does this incorrectly place mediatek,mt6893-disp-wdma as a standalone
>> compatible string rather than in the items list requiring a fallback?
>>
>> If a device tree uses compatible = "mediatek,mt6893-disp-wdma" to satisfy
>> this schema, the DRM driver will not probe the device since it only matches
>> mediatek,mt8173-disp-wdma. If the developer instead provides the fallback
>> compatible = "mediatek,mt6893-disp-wdma", "mediatek,mt8173-disp-wdma" so the
>> driver can probe it, won't the device tree fail schema validation here?
> 
> Sashiko fails to look at patch 10. However, the commit message gives no
> clue whether mt6893 is or is not compatible with something else. If not
> compatible, explain why it isn't. What's different?
> 
Eh, MT6893 supports 64-bits image data destination address (has two registers,
lower 32 bits and upper 32 bits), while MT8173 and others supports 32-bits only.

Should I resend with an improved commit message, or would it be fine to change
that while applying?

Multiple MediaTek SoCs have the Write DMA hardware in their Display
Controller. This commit adds the missing compatibles for Dimensity 1200
(MT6893), supporting image destination address of up to 64 bits, and for
Kompanio 500/520/820/1200, fully compatible with MT8173, supporting only
32 bits.

Cheers,
Angelo
