Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3255CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 18:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FC191136D4;
	Mon,  1 Jun 2026 18:08:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ptSoRfoa";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D5ED1136D4
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 18:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780337330;
 bh=zc9LCVVcm97BP3J6QkyrVJS3s4P86SybatYOdqgAcEU=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=ptSoRfoa2oyn2v1Zeqoh/5J3GWxNhTZ7ofgdohodHHctrhSNcAh+zOURRxs28mlsd
 o7+zLHXBe5LHI+smwgn4R6N1OPVG1KyXQ2poscNxrWpC5q5NXbRVbOaPV5n5VO+cYi
 pCDLejTaIqpNh74HKkFf75lz53yGEdEmXcfX4upUwL/xEK1dqAztFZ5KcHNy9Og+fP
 dVqLxMo4dnzgSyaFq4Z4WIbk+KPl0MyfJ4a2m2dc6s80o3hZeRPIB+4nHOR3BGJ2s0
 yY8WxyxjUbaqvfiFdHGS/SXKoWYpCXzr8r2w0+ZGHszIKOnzIbANpbj79hA3CQG4p7
 YpGytQiAjbr/Q==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 6DDDC17E03A6;
 Mon,  1 Jun 2026 20:08:50 +0200 (CEST)
Message-ID: <b0a60e27-03ec-425e-8ecd-b8f9bdaadf93@collabora.com>
Date: Mon, 1 Jun 2026 21:08:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] YUV support for VOP2 background color
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260601-vop2-bg-yuv-v2-0-e5aef1d16fec@collabora.com>
Content-Language: en-US
In-Reply-To: <20260601-vop2-bg-yuv-v2-0-e5aef1d16fec@collabora.com>
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

Something got messed by while preparing the cover letter.
Fixed manually..

On 6/1/26 9:00 PM, Cristian Ciocaltea wrote:
> Since commit bec7cbfa7d4f ("drm/rockchip: vop2: Support setting custom
> background color") the VOP2 display controller allows configuring the
> background color of each video output port.
> 
> However, this is currently limited to RGB formats.  When operating in
> YUV overlay mode, the color must be programmed using YUV format.
> 
> Add the necessary RGB-to-YCbCr conversion logic, covering all color
> spaces supported by the display controller: BT601L, BT601F, BT709L and
> BT2020L.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
> Changes in v2:
> - Used vop2_convert_csc_mode() helper to address an issue reported by
>   Sashiko: vop2_rgb16_to_yuv16() expects an enum vop_csc_format, but
>   vcstate->color_space holds a V4L2 colorspace enum
> - Rebased onto latest drm-misc-next
> - Link to v1: https://patch.msgid.link/20260524-vop2-bg-yuv-v1-0-dcb6a52923f5@collabora.com
> 
> ---
> Cristian Ciocaltea (2):
>       drm/rockchip: vop2: Rename CSC_BT2020 to CSC_BT2020L
>       drm/rockchip: vop2: Add YUV support to background color
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 155 ++++++++++++++++++++++++---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |   2 +-
>  2 files changed, 140 insertions(+), 17 deletions(-)
> ---
> base-commit: e84b07e0a30b371117f9a1120a4645c213f39cd9
> change-id: 20260524-vop2-bg-yuv-1b0e6a09c579
> 

