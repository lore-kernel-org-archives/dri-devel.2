Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4E0C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 11:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 536D210ED95;
	Mon, 14 Sep 2026 11:26:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="cGGB0QNM";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC79310ED95
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 11:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789385173;
 bh=lXVPwq7s2VUOFgW7l33ir3TRXWPIYSzWJPDJTQ63R+U=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cGGB0QNMA3UGaFW+2zS9yJ2f0H9CIkbzniMnzaf5CY35eK4B6hGXWbzssm1GNP0XA
 kLXyg/waZcQo6l7/lZGAV6gRv/HHyDq4BIxldXCaL8BFmyRdoH4TwIz3vEuvOdg9Jf
 E+dx868sHUpJfNl5Gi7YIOfkrYwliAvLDiRcoU8+0WffH0urqgo0B8lwnK0av25B8n
 PNUDXcX67mvM+ZVVesjNycvTIHj5EmTQmyz5HcyLnqPCfcY9wP8TYdxRG0O0sCKXeQ
 IImkggd+Z3tGxYzxuts56gFpuORikG2V8XMgdKOFsqlv9BfvyrAIFuYUC24rg6GTW4
 v10dtaDm5DakA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D193C17E0894;
 Mon, 14 Sep 2026 13:26:12 +0200 (CEST)
Message-ID: <69562510-23f3-4993-b740-60ba83979237@collabora.com>
Date: Mon, 14 Sep 2026 13:26:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/11] drm/mediatek: Add Write DMA (WDMA) Engine for
 Writeback support
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc: "kernel@collabora.com" <kernel@collabora.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
 <mripard@kernel.org>, =?UTF-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
 <jitao.shi@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?UTF-8?B?SnVzdGluIFllaCAo6JGJ6Iux6IyCKQ==?= <Justin.Yeh@mediatek.com>,
 =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
References: <20260715135703.46540-1-angelogioacchino.delregno@collabora.com>
 <20260715135703.46540-12-angelogioacchino.delregno@collabora.com>
 <232cbc7ff5f2c50230eddf4db1f8eb7145a41d23.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <232cbc7ff5f2c50230eddf4db1f8eb7145a41d23.camel@mediatek.com>
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

On 8/27/26 07:33, CK Hu (胡俊光) wrote:
> On Wed, 2026-07-15 at 15:57 +0200, AngeloGioacchino Del Regno wrote:
>> Add a basic driver for the Write DMA Engine and initial compatible
>> for the MediaTek MT8173 and MediaTek Dimensity 1200 MT6893, and
>> hook it up to the mtk_ddp_comp and mtk_drm_drv in order for it to
>> probe.
>>
>> This display controller component is used to enable the writeback
>> engine that can be used for faster display image capturing in the
>> userspace (for example, screenshots and screen recording).
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   
>> +static const struct mtk_ddp_comp_funcs ddp_wdma = {
>> +	.clk_enable = mtk_wdma_clk_enable,
>> +	.clk_disable = mtk_wdma_clk_disable,
>> +	.config = mtk_wdma_config,
>> +	.start = mtk_wdma_start,
>> +	.stop = mtk_wdma_stop,
>> +	.register_vblank_cb = mtk_wdma_register_vblank_cb,
>> +	.unregister_vblank_cb = mtk_wdma_unregister_vblank_cb,
>> +	.enable_vblank = mtk_wdma_enable_vblank,
>> +	.disable_vblank = mtk_wdma_disable_vblank,
>> +	.layer_nr = mtk_wdma_layer_nr,
>> +	.layer_config = mtk_wdma_layer_config,
>> +	.get_formats = mtk_wdma_get_formats,
>> +	.get_num_formats = mtk_wdma_get_num_formats,
> 
> I does not see you modify mtk crtc.
> mtk crtc would use some interface only on 'first' ddp component of a pipeline.
> WDMA would not be the first component,
> so register_vblank_cb, unregister_vblank_cb, enable_vblank, disable_vblank, layer_nr, layer_config, get_formats, and get_num_formats are useless.

It's true in this specific case, but this was done while performing the big
mediatek-drm restructuring.

I decided to split the full changes in two separate series, because the one
restructuring mediatek-drm is literally huge... and this series is adding
only things that can be applied before the full restructuring takes place.

That was done in order to speed up the upstreaming and nothing else - so you
can safely ignore the fact that there is extra functionality in this driver,
because those extras will be used once the other big series is merged.

It's a lot of code, please-please-please don't make me split things up even
more, because then the commit log becomes messy :-)

As for the comments on 8189/8196 (link rate and qos), you're right in that it
makes sense to split the algo additions from the soc addition: I've done that
already and will come in v7.

Cheers,
Angelo

