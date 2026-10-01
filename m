Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCA8CA5FD4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 15:40:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A060510E107;
	Thu,  1 Oct 2026 15:40:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=murena.io header.i=@murena.io header.b="TCEoFDBb";
	dkim-atps=neutral
Received: from mail2.ecloud.global (mail2.ecloud.global [135.181.6.248])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1833010E107
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 15:40:12 +0000 (UTC)
Received: from authenticated-user (mail2.ecloud.global [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail2.ecloud.global (Postfix) with ESMTPSA id F0DEB720BA3;
 Thu, 01 Oct 2026 15:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io; s=mail2;
 t=1790869209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKDPtfxAhV/dREsJEcSyq7SoOHuO3ciIber1G1Mlbkk=;
 b=TCEoFDBbjYRUo3c3fevSgQ02QIdoN8xUTOuZX4DnbNjkrxZf3NsSMJCDP/MJ2ahHmsp/ob
 CZm9EzW0JqyQepC+Mnx/wD6iInO/gE6qqTN6uPkLE2YHijtYT2D6xeDv6kzMtQ2zw9Yp6m
 oqIa9aQsK+srkNwKqeXCFbnHDAubzL8=
ARC-Seal: i=1; a=rsa-sha256; d=murena.io; s=mail2; cv=none; t=1790869209;
 b=VNETGM+K8h+iqT1UgCB1Tyj/1jgj3s+OJmVqwrK8EC6gaoplSJXbAgezfVTDHlQqR7w31Y
 pJJjeVIznq7magjlH4S0Y4KzwY/p8b8liSEVRALNAhMz6cVOJT5tnFoOv1mhJrF2LsWiVD
 RwXYI5A6T6b7Ep9svcPR2Rxzh01/mPM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=murena.io;
 s=mail2; t=1790869209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKDPtfxAhV/dREsJEcSyq7SoOHuO3ciIber1G1Mlbkk=;
 b=ZNq50gAmDVE09SbtqXvrb4VyxebLiZgRYzrViBFsX459PliBv+F2kxIilSuf95+w28YMvk
 pKYEUbbhSKrCyLVj+Klf7A5Rg3h61gXuL5gSAokYwrBVKrb0/Rr3OS4KugTIbU9NALael8
 V9nPlJRRQHNAr/SJI/WBGam7iDaXO7w=
ARC-Authentication-Results: i=1; mail2.ecloud.global;
 auth=pass smtp.mailfrom=maud_spierings@murena.io
Message-ID: <6462d084-5861-4df6-94ca-dbd23e619a61@murena.io>
Date: Thu, 1 Oct 2026 17:40:06 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v5 01/21] drm/bridge: inno-hdmi: fix swapped HSYNC and
 VSYNC polarity
To: Michal Wilczynski <m.wilczynski@samsung.com>,
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Andy Yan <andy.yan@rock-chips.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Emil Renner Berthing <kernel@esmil.dk>, Hal Feng
 <hal.feng@starfivetech.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Dominique Belhachemi <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Graham Markall <hello@big-grey.co.uk>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Joshua Peisach <jpeisach@ubuntu.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Byron Stanoszek <gandalf@winds.org>
References: <20260929-jh7110-clean-send-v5-0-82b4d8e3c6c7@samsung.com>
 <CGME20260929103203eucas1p14cb6262ba2c7bbaf36856f24f7bdc9e7@eucas1p1.samsung.com>
 <20260929-jh7110-clean-send-v5-1-82b4d8e3c6c7@samsung.com>
Content-Language: en-US
From: Maud Spierings <maud_spierings@murena.io>
In-Reply-To: <20260929-jh7110-clean-send-v5-1-82b4d8e3c6c7@samsung.com>
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

Hi Michal,

Fixed! Thanks!

Tested-by: Maud Spierings <maud_spierings@murena.io>

Kind regards,
Maud

On 9/29/26 12:30, Michal Wilczynski wrote:
> v_HSYNC_POLARITY() and v_VSYNC_POLARITY() write the wrong bits: the
> hardware puts HSYNC in bit 2 and VSYNC in bit 3, the macros do the
> opposite. Most CEA modes drive both syncs with the same polarity so it
> goes unnoticed; it only shows up on modes where the two differ.
> 
> Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI support")
> Reported-by: Maud Spierings <maud_spierings@murena.io>
> Closes: https://lore.kernel.org/all/e780ecb8-918f-4816-99c8-b69b10b25a18@murena.io/
> Reported-by: Byron Stanoszek <gandalf@winds.org>
> Closes: https://lore.kernel.org/all/b8b046ee-c574-3e16-6079-2fc415633dae@winds.org/
> Suggested-by: Dominique Belhachemi <db@domibel.de>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>   drivers/gpu/drm/bridge/inno-hdmi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
> index dd35f5a875d3d842fee6d2ead0de88503f9914e1..d7c33b92e2ddf4ced84d17304463f44be52270b8 100644
> --- a/drivers/gpu/drm/bridge/inno-hdmi.c
> +++ b/drivers/gpu/drm/bridge/inno-hdmi.c
> @@ -122,8 +122,8 @@ enum {
>   #define v_VIDEO_MUTE(n)			((n) << 0)
>   
>   #define HDMI_VIDEO_TIMING_CTL		0x08
> -#define v_HSYNC_POLARITY(n)		((n) << 3)
> -#define v_VSYNC_POLARITY(n)		((n) << 2)
> +#define v_VSYNC_POLARITY(n)		((n) << 3)
> +#define v_HSYNC_POLARITY(n)		((n) << 2)
>   #define v_INETLACE(n)			((n) << 1)
>   #define v_EXTERANL_VIDEO(n)		((n) << 0)
>   
> 

