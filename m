Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D18C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 07:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2D0910F259;
	Fri, 21 Aug 2026 07:37:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="eEgOCGeo";
	dkim-atps=neutral
Received: from mail-m10313119132.xmail.ntesmail.com
 (mail-m10313119132.xmail.ntesmail.com [103.131.191.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91EDE10F259
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 07:37:23 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4ad31442e;
 Fri, 21 Aug 2026 15:37:19 +0800 (GMT+08:00)
Message-ID: <7087887e-95e9-4253-a86e-c074eef950fd@rock-chips.com>
Date: Fri, 21 Aug 2026 15:37:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] drm/bridge: analogix_dp: Restore mandatory samsung
 DP DT properties
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20260819075238.3007087-1-damon.ding@rock-chips.com>
 <20260819075238.3007087-4-damon.ding@rock-chips.com>
 <178714408666.358642.12912882529209046607.b4-review@b4>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <178714408666.358642.12912882529209046607.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa02340b79c03a8kunm02f452e245569a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTBkYVktCQ08aHU8ZS0NKTVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=eEgOCGeoFhbUNQZl237hGLavdog8J0uivhVhnfoxC+IBAIjK4kKrxBv2c9mlueubt6b+KUIinNK38NkoOooSDGNP9C9T1GpTObhCiuWV0fj0/WtkZYMoYnhPyD74yZunKp71VxN4B/rZiRlKbl49qZxVZi3K+bXOy1Ob0T+dJko=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=vwmRpH1OMYfMW+wdngHC16XU1WHD68RBOexz3bP/ZHc=;
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

Hi Luca,

On 8/19/2026 8:54 PM, Luca Ceresoli wrote:
>> Revert the change that made samsung,link-rate and samsung,lane-count
>> optional for Exynos DP. Add error checking to fail probe early if the
>> required DT properties are missing.
>>
>> If these properties are zero, &link_train.link_rate and
>> &link_train.lane_count used in the subsequent link training flow will
>> also be zero, resulting in link training failure. Although all existing
>> Exynos DP DT nodes already contain these two properties, this potential
>> logic issue still needs to be fixed.
>>
>> Fixes: 0d0abd894ead ("drm: bridge: analogix/dp: add max link rate and lane count limit for RK3288")
> 
> If it's a fix, please add 'Cc: stable' too.
> 
> Also please add to the commit message the detailed analysis you wrote in
> the v6 discussion, so that it will easy to find in the git history, in case
> it's needed in the future.
> 
> With that added you can add: Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> 

Yes, will do in v8.

Best regards,
Damon

