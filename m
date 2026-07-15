Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8229DC44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 12:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC4C710E196;
	Wed, 15 Jul 2026 12:20:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="J5/9iFtZ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3D3B10E196
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 12:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784117969;
 bh=GwgR0uDlU7raDjnYwmqupcREvOTo+vbqF9PgmiaMa0o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=J5/9iFtZJFrG3V6FNALKifW13kVwgqclKBNmX1t3GsIbmfnf4tadH2GNOt38hBP++
 SVA2LV1DwhZM0d3Mf/gnl0XOwXO4UeaqmCHHySMvG7EuMt7e45/Xd5uS1vluFs2XJQ
 uYIsbJ5py8A8kvuQ/YZOVTIRA2UsBy/TyDCm7ysPU7BjatVL6fTmjAgnH5gYxcPSDE
 IBTYsCG/nqFfqJKTlPKGGH/nxJ4VT2YlLTE76+l7oLJ3vawQow8OCpX2haxavPFBIq
 XERR7+Ea1BOWxJMtECpaYieIQUFP5SlUETB2EFt+8te570G9gjObgsOm9thOrSni/D
 LhZ0gxIfVIeZA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2EC5517E07AA;
 Wed, 15 Jul 2026 14:19:29 +0200 (CEST)
Message-ID: <ab158fcd-5d6b-4b9f-9eb0-6b135ea7b1eb@collabora.com>
Date: Wed, 15 Jul 2026 14:19:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] dt-bindings: display: mediatek: wdma: Add
 compatibles for more SoCs
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
References: <20260715114916.19690-1-angelogioacchino.delregno@collabora.com>
 <20260715114916.19690-11-angelogioacchino.delregno@collabora.com>
 <20260715121553.103AE1F000E9@smtp.kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260715121553.103AE1F000E9@smtp.kernel.org>
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

On 7/15/26 14:15, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Inconsistent compatibility fallback for 64-bit SoCs (MT8192/MT8195) violating hardware constraints described in the commit.
> --
> 
> --- Patch [10]: [PATCH v5 10/11] dt-bindings: display: mediatek: wdma: Add compatibles for more SoCs ---
> commit ffb6d1b73de2ee2d9fba381dca064a6d8fef7acf
> Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> dt-bindings: display: mediatek: wdma: Add compatibles for more SoCs
> 
> This commit adds missing compatibles for the Write DMA hardware in the
> Display Controller for Dimensity 1200 (MT6893) and Kompanio
> 500/520/820/1200 (MT8183/MT8186/MT8192/MT8195).
> 
>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
>> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
>> @@ -22,11 +22,16 @@ properties:
>>     compatible:
>>       oneOf:
>>         - enum:
>> +          - mediatek,mt6893-disp-wdma
>>             - mediatek,mt8173-disp-wdma
>>         - items:
>>             - enum:
>>                 - mediatek,mt6795-disp-wdma
>>                 - mediatek,mt8167-disp-wdma
>> +              - mediatek,mt8183-disp-wdma
>> +              - mediatek,mt8186-disp-wdma
>> +              - mediatek,mt8192-disp-wdma
>> +              - mediatek,mt8195-disp-wdma
>>             - const: mediatek,mt8173-disp-wdma
> 
> [Severity: Medium]
> The commit message explicitly excludes MT6893 from falling back to
> MT8173 because it introduces support for destination addresses larger
> than 32 bits. Should this same rule apply to MT8192 and MT8195?
> 
> Since MT8195 (Kompanio 1200) and MT6893 (Dimensity 1200) are the same
> generation of SoCs sharing the same IP, grouping MT8192 and MT8195 here
> implies they can safely fall back to the legacy 32-bit driver.

What?! No!! They're not the same SoC generation, and THAT is also why they
are not compatible with each other?!?!?!?!?!?! :-)))))

Cheers!

> 
> If an OS binds a legacy 32-bit driver to the MT8195 WDMA using this
> fallback, won't it misprogram the DMA addresses by truncating them to 32
> bits when attempting a DMA operation above 4GB?
> 
