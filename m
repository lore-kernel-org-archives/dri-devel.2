Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F58C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45FCB897FB;
	Wed, 15 Jul 2026 13:40:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="h6HIF+R9";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35AF8897FB
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 13:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784122838;
 bh=o/mx+IN6C01zZLNimc1fWVcEnAB8uqWOfSp7yzRlGTQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=h6HIF+R9TYxE7aHeLmINbKqn5m4qofb1wYuAazpsR/fFZMfuod1n3QUNAp4zRG3Og
 SpkfqjciJ7Ku39dxKB1e5YbnT2jE+WAIKpFG41SUFb7sUoHSKNYI5ajah2DUYVtilB
 VYLbpqnuT6mawGrcQYTM3o1vqh+sMNbssoJfU+qP5Fd38fpv0ySDNBnPnCo0vLtkfD
 ToRQYRq6w0aLRrsMZKkiAQOJLtaOVRCkVHXGhgjWDzJTZYaIbewu6o3PxLgq5nn2BS
 /jiqkwMRd+xSbJ8e7Jy7cOT/zQ72nrX5+811Fl6OkHXzXHInnN5bNC8H6+jzMuyo3S
 +nsCNakXsDIAg==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3504517E0018;
 Wed, 15 Jul 2026 15:40:38 +0200 (CEST)
Message-ID: <65558ccc-4f2c-492d-8c74-627d27dce864@collabora.com>
Date: Wed, 15 Jul 2026 15:40:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mediatek: mtk_dsi: enable hs clock during pre-enable
To: Gary Bisson <bisson.gary@gmail.com>
Cc: Esben Haabendal <esben@geanix.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Adam Thiede <me@adamthiede.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>
References: <20260120-mtkdsi-v1-1-b0f4094f3ac3@gmail.com>
 <8733xko1ms.fsf@geanix.com>
 <0f719c00-3cf5-4403-afbf-713b07255981@collabora.com> <aleM9Wy9otpd6Je3@owl5>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <aleM9Wy9otpd6Je3@owl5>
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

On 7/15/26 15:36, Gary Bisson wrote:
> Hi,
> 
> On Wed, Jul 15, 2026 at 03:25:11PM +0200, AngeloGioacchino Del Regno wrote:
>> On 7/15/26 14:53, Esben Haabendal wrote:
>>> Gary Bisson <bisson.gary@gmail.com> writes:
>>>
>>>> Some bridges, such as the TI SN65DSI83, require the HS clock to be
>>>> running in order to lock its PLL during its own pre-enable function.
>>>>
>>>> Without this change, the bridge gives the following error:
>>>> sn65dsi83 14-002c: failed to lock PLL, ret=-110
>>>> sn65dsi83 14-002c: Unexpected link status 0x01
>>>> sn65dsi83 14-002c: reset the pipe
>>>>
>>>> Move the necessary functions from enable to pre-enable.
>>>>
>>>> Signed-off-by: Gary Bisson <bisson.gary@gmail.com>
>>>
>>> Hi
>>>
>>> I have run into the same problem, but in combination with another
>>> pipeline. I am seeing same problem with an i.MX8 using the nwl-dsi
>>> bridge and the dcss driver.
>>>
>>> I have submitted a fix that adresses the problem in the ti-sn65dsi83
>>> driver instead. With a bit of luck, it can replace the fix proposed in
>>> this thread.
>>>
>>> See https://lore.kernel.org/all/20260711-ti-sn65dsi83-fixes-v1-2-d85eb5342b98@geanix.com/
> 
> Thanks, just tried it on 7.2-rc3 with my patch reverted and confirm that
> it works too. My assumption was that the SN65DSI83 was locking the PLL
> earlier for some specific reason and therefore was reluctant to change
> it.
> 
>>> /Esben
>>
>> That clarifies a lot of things.
>>
>> The patch on mtk_dsi shall be reverted then.
> 
> Angelo, do you want me to offer the revert patch? Should I wait to see
> how the other thread goes?
> 

Gary, yes please, send a revert and make sure to explain the reason why
we're reverting this in the commit description :-)

Cheers,
Angelo
