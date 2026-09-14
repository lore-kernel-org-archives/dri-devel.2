Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A215BC88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:18:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCAA010EBFD;
	Mon, 14 Sep 2026 08:18:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="I25XpAC0";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4833C10EBFD
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789373902;
 bh=DWggKVY8dMTtllAFA52TbFspZ6he1PLAFTJ0dJKkSDk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=I25XpAC06/I3GfHLgZt/v9IewDM52y/atTzc4iP6NsBkhEcubS81cw/KOMU9IzYZD
 TdzCWfEYrcLUNsM9x0IMC3EvudaVv9uQ7SsvVtaE+Bi1H8Xg+jCkuzV6bpb3G6M3PA
 cC5+Wr3zzOixAPGFCzH50qNxdIsS7uUxGVvm/BSN8fF/VesB3rD39ERE/YexmxsfIC
 MEby6kGFk+MdwrsaJ4PDtqqGYd4fMT88WQLGkozyvX9/CUnVmH6XdM9iP4Nd7or5h6
 0rUaA3jwfphEhZxr3gbtDE09jzGxMmO1+ZunKkHYyABuLAJTnq7PY5khliM1lo6IRD
 0Yvv0wu3jhV+g==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id F311717E020C;
 Mon, 14 Sep 2026 10:18:21 +0200 (CEST)
Message-ID: <e28acd6b-aac6-4e2e-8d0b-b9ed22820d73@collabora.com>
Date: Mon, 14 Sep 2026 10:18:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: phy-mtk-dp: Fix pdata array members initialized as
 pointers
To: Sasha Levin <sashal@kernel.org>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20260913172930.1150324-1-sashal@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260913172930.1150324-1-sashal@kernel.org>
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

On 9/13/26 19:29, Sasha Levin wrote:
> Building arm/arm64/i386 allmodconfig with clang fails:
> 
>    drivers/phy/mediatek/phy-mtk-dp.c:761:18: error: incompatible pointer
>    to integer conversion initializing 'u16' (aka 'unsigned short') with
>    an expression of type 'const u16[4]' [-Wint-conversion]
>    drivers/phy/mediatek/phy-mtk-dp.c:761:18: error: initializer element
>    is not a compile-time constant
>    drivers/phy/mediatek/phy-mtk-dp.c:761:18: error: suggest braces around
>    initialization of subobject [-Werror,-Wmissing-braces]
> 
> 14 errors in total, one set per offending member.
> 
> off_ana_lane, off_dig_lane and driving_params are declared as arrays in
> struct mtk_dp_phy_pdata:
> 
> 	u16 off_ana_lane[MTK_DP_PHY_MAX_LANES];
> 	u16 off_dig_lane[MTK_DP_PHY_MAX_LANES];
> 	u32 driving_params[PHYD_DIG_NUM_DRV_PARA_REGS];
> 
> but the SoC data instances initialize them with compound literals. A
> compound literal is an object, not an initializer list, so this is not
> an array initializer: the member is initialized element-wise from a
> scalar, the first element gets the address of the literal truncated to
> u16/u32, and the remaining elements are zeroed. Hence the three
> diagnostics above - the pointer-to-integer conversion, the address not
> being a compile-time constant, and the missing braces.
> 
> Arrays are the right type here, since both members are indexed per lane
> and driving_params is sized with ARRAY_SIZE(), so drop the casts and use
> plain braced initializers.
> 
> Found by KernelCI builds of the linus-next tree.
> 
> Fixes: ae859204b519 ("phy: phy-mtk-dp: Migrate register offsets to SoC specific pdata")
> Fixes: 7cf38eb0ab59 ("phy: phy-mtk-dp: Add support for digital and analog calibration")
> Fixes: 6fe4d5beac72 ("phy: phy-mtk-dp: Add support for MT8196 eDP PHY")
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Whoops, sorry.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

