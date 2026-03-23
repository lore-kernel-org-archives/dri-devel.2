Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2988EC01B1
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E8A310E4BB;
	Mon, 23 Mar 2026 10:05:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Fko7vEm8";
	dkim-atps=neutral
Received: from mail-m19731105.qiye.163.com (mail-m19731105.qiye.163.com
 [220.197.31.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B436110E4BB
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 10:05:57 +0000 (UTC)
Received: from [172.16.12.43] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 37f14d637;
 Mon, 23 Mar 2026 18:05:53 +0800 (GMT+08:00)
Message-ID: <170a22d3-f1d6-4f71-97ca-db3edf689d93@rock-chips.com>
Date: Mon, 23 Mar 2026 18:05:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: display: rockchip: analogix-dp:
 Expand clock-names "hclk" for the third clock
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, nicolas.frattaroli@collabora.com,
 alchark@gmail.com, cristian.ciocaltea@collabora.com,
 sebastian.reichel@collabora.com, kever.yang@rock-chips.com,
 heiko.stuebner@cherry.de, tomeu@tomeuvizoso.net, amadeus@jmu.edu.cn,
 michael.riesch@collabora.com, didi.debian@cknow.org,
 dmitry.baryshkov@oss.qualcomm.com, luca.ceresoli@bootlin.com,
 dianders@chromium.org, m.szyprowski@samsung.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260319104031.1986946-1-damon.ding@rock-chips.com>
 <20260319104031.1986946-2-damon.ding@rock-chips.com>
 <20260320-amusing-magnetic-harrier-20cc40@quoll>
 <311d143b-cc78-465e-9be2-0a9a0a33ea0b@kernel.org>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <311d143b-cc78-465e-9be2-0a9a0a33ea0b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d1a28788303a3kunmafb06323593c9f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh5CSVZIHU0ZQxpKH0wdSkhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
 1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=Fko7vEm8qr/yM2Scx5aIktLIO/rsbKX9HQLG3hxzupnw8xra/FYMjlKPI2owJHEspyFJD+ms/U9DaO5WfmxhCm2w1GQVeKDGIM+SQNwMZMvzBNT1QbEO9S3xjsmMIMpH/LWoSgi9tGb7pVcciBKkTO5ljMPe4juXCYwDkDNEcL8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=qCbZ2f0Kcl+hC4CPhtXEDMfwP+rqGeU660PawdGL7lw=;
 h=date:mime-version:subject:message-id:from;
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

Hi Krzysztof,

On 3/20/2026 5:41 PM, Krzysztof Kozlowski wrote:
> On 20/03/2026 10:19, Krzysztof Kozlowski wrote:
>> On Thu, Mar 19, 2026 at 06:40:23PM +0800, Damon Ding wrote:
>>> The RK3588 eDP controller needs the video datapath clock "hclk" to work
>>> well. Previously, it works without explicitly adding this clock because
>>> the 'rockchip,vo-grf = <&vo1_grf>' property implicitly enables HCLK_VO1.
>>>
>>> Fixes: f855146263b1 ("dt-bindings: display: rockchip: analogix-dp: Add support for RK3588")
>>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>>> ---
> 
> BTW, all your patches (this and previous set... actually, everything you
> ever sent IIRC) end up marked as spam. I don't see anything in the
> headers pointing to the issue. There is no score assigned and
> DMARC+SPF+DKIM pass.
> 
> However it seems you are using @rock-chips.com and SMTP server 163.com,
> so maybe that difference. Or maybe it is rock-chips lack of DMARC policy
> (p=none dis=none)?
> 
> Regardless of the reason, if you do not ever receive answers from
> people, it is likely that is the reason.
> 
> 

Thank you for the kind heads-up! And I’m sorry for the extra work you 
have to go through checking the spam folder.

It looks like I really need to have a good talk with our IT team about this.

Thanks again for letting me know — much appreciated!

Best regards,
Damon

