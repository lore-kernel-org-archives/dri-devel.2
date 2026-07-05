Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A58BC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 20:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E56FC10E1BD;
	Sun,  5 Jul 2026 20:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="lL230xXc";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEB8B10E1BD
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 20:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783284368;
 bh=OaQusKv3rXYsBNCL7bbmIiPHTJUbxK+t+RRHDhKEW9Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lL230xXckdYvbMdcv6VvPfggSMJt4NKuO+UichDEAFAiEOXbiKsWUP7Cq4EuSPr+n
 zt6n2WmBg+/z95DyxHqpc0Cm7kZqJEPz1bQSlMPCPbdFIZJVKypLfV5g1m0yeOvK74
 mYZaKU5LaRRtbJyIt8ONOpFk4LV7eiywCjFQC4TGYKHUV+SY+wlDd7YwzL9ODHKjQL
 DzJF68rnwWrFaDw8YkIGRnmzzhOwyRjoW0EEyQDEgmbUt+q8lA8XQpcie0x8XinT1X
 kkzZTDknZ2VF9gFMDb150EY1SbsJq8gYG0zQC+5+tVLfpQPymDbv89e8NVfyRMDHzq
 IqMTxsmxqsxUA==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 28E3917E0177;
 Sun, 05 Jul 2026 22:46:07 +0200 (CEST)
Message-ID: <c8242f5c-ec74-489e-b378-f225ec3a0135@collabora.com>
Date: Sun, 5 Jul 2026 23:46:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] drm/rockchip: vop2: Reset AXI and DCLK to improve
 robustness
To: Diederik de Haas <diederik@cknow-tech.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: kernel@collabora.com, Andy Yan <andyshrk@163.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260617-dw-hdmi-qp-yuv-v1-0-a665cfd06d7d@collabora.com>
 <20260617-dw-hdmi-qp-yuv-v1-2-a665cfd06d7d@collabora.com>
 <DJQO8Q4J2LDP.1G8I4FVF6J7TK@cknow-tech.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <DJQO8Q4J2LDP.1G8I4FVF6J7TK@cknow-tech.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Diederik,

On 7/5/26 4:28 PM, Diederik de Haas wrote:
> Hi Cristian,
> 
> On Wed Jun 17, 2026 at 8:52 PM CEST, Cristian Ciocaltea wrote:
>> Assert the AXI reset in the CRTC disable path, and the VP DCLK reset in
>> the enable path.
>>
>> These resets are intended to leave the hardware in a clean state for the
>> next use, helping recover from exceptions such as IOMMU page faults, as
>> well as to prevent random display output glitches, such as a blank
>> image, observed when switching modes that also change the color format,
>> e.g. from RGB to YUV420 and vice versa.
>>
>> For now this seems to affect only the RK3588, hence the resets are
>> optional and will be provided in the device tree for this SoC only.
> 
> Why do you think it only effect RK3588? 

My findings are exclusively in the context of validating YUV support for DW HDMI
QP, hence targeting RK3588 and RK3576.  Since RK3576 didn't exhibit any
anomalies, I concluded the resets are needed just for RK3588.

> I reported about my RK3568 test here:
> https://lore.kernel.org/linux-rockchip/DFRU6ODDM71P.3NQGLRK8IVDUY@cknow-tech.com/
> "I then went on to try LibreELEC's builds. The artifacts I (sometimes)
> saw, were gone :-D OTOH, I did get several major issues 'in return',
> like rk_iommu Page fault resulting in a black screen and the only way to
> 'recover' from it, was a reboot."
> 
> And I reported some more test results here:
> https://forum.libreelec.tv/thread/29953-le13-testing-for-rk3288-rk3328-rk3399-rk3566-rk3568-rk3576-rk3588/?postID=204691#post204691
> 
> That seems to me a (strong) indication it also affects RK3566/RK3568?

If coincidentally this helps improve the reliability of some of the older SoCs
as well, the resets can easily be added to the corresponding DTs and submitted
as a follow-up series.

Cristian
