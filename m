Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41851C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A89A10E6B2;
	Thu,  9 Jul 2026 11:48:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="mwAafzon";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F4510E6B2
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783597725;
 bh=ZHdYtULAHilEW7xPUMMiGj88dz/NRrO/fa+X2KxsnaA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mwAafzonvtw8QRaqoEh1DXFgkwvz05LiCUyG6TDqLgT4YMqb9T/XmgEItN5FPv4sf
 Gkr/RnWFtgII6U9ZmZWgu+y8Q7bKEyiKV5//R4Gz4T8XLFGcU7GjlsccweZfY3MM45
 bw6HS9Tg3NEpzu9DmMUxKVM3Fu+6cYvT8b6zMMTlIRP4EM/6flnMFLzhpY+TUlQj/A
 /amzCl4mqOwp2x+D1CgILdpWw+PK5StZJaT8ug1B18nAuT871+7tFC4+qDU/C3kvpV
 IHrzrN//LBQwYBfSjxMYyYJiKS4MBkDRc9FXdDEwGaUZhsCW+QvBbhIo70rfIfIac3
 f/o4+g21Q1gTA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5BEB717E003B;
 Thu, 09 Jul 2026 13:48:44 +0200 (CEST)
Message-ID: <d35e3376-b2d1-45c2-b1d5-96057cecf1d1@collabora.com>
Date: Thu, 9 Jul 2026 13:48:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: mediatek: cec: Correct the compatibles
 for mt7623-mt8167
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
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
References: <20260624173627.19785-1-l.scorcia@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260624173627.19785-1-l.scorcia@gmail.com>
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

On 6/24/26 19:36, Luca Leonardo Scorcia wrote:
> The HDMI CEC driver for both mt7623 and mt8167 is actually the same as
> mt8173-cec and the mt7623n.dtsi board include file already uses mt8173-cec
> compatible as a fallback, but the documentation lists them as separate
> entries. Correct the binding by adding the correct fallback.
> 
> This change fixes the following dtbs_check errors:
> 
> DTC [C] arch/arm/boot/dts/mediatek/mt7623n-rfb-emmc.dtb
> cec@10012000 (mediatek,mt7623-cec): compatible: ['mediatek,mt7623-cec',
>    'mediatek,mt8173-cec'] is too long
> DTC [C] arch/arm/boot/dts/mediatek/mt7623n-bananapi-bpi-r2.dtb
> cec@10012000 (mediatek,mt7623-cec): compatible: ['mediatek,mt7623-cec',
>    'mediatek,mt8173-cec'] is too long
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

