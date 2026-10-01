Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F404CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7B8010E2EE;
	Thu,  1 Oct 2026 08:29:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R4tHI92J";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6104810E31E
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 08:29:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A4EA06022B;
 Thu,  1 Oct 2026 08:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5BA1F000FF;
 Thu,  1 Oct 2026 08:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790843348;
 bh=yS9qbaAkLlPU9Fc9KuYA84WC0RRI4KwBqAJVX7ftcuQ=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=R4tHI92JvKEw/vHIct1JvsK2mQ54ppWRhnTscr6hbAmLUHyF+NWc298/5Ex/4Ilp9
 B1wMpNd06/ARRd7DMcAP7LxxNppYh6hpfeirvmxEctAUOBkyIkYLi2qgXWYkMOs2cE
 GFl8zgvc4d9nBOg8wNp5nUTaOLU6lCl0mtm2h7FWgcbHvd5RxYaNSvBXHYJZoAGIie
 T0CtcFb5kXdwn73f2b72kP/hpBr/LVj+JiT1Z1W5tjG4WLh/Xau8n//UMJHpRJLQi0
 gkWkvXseL3PK7a4nN1eyKVBYF9Jxs/QEkWBIQxKcvTBZchecE6ewL1wAB+TidYfcMl
 fiUyg0AP8VNEw==
Message-ID: <8f9d3c610b98db28ca77b2b57175845a@kernel.org>
Date: Thu, 01 Oct 2026 08:29:05 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 2/2] drm/bridge: lontium-lt8713sx: Drop redundant bridge
 funcs assignment
In-Reply-To: <20261001-bridge-alloc-conv-v1-2-f0a1fe040a86@collabora.com>
References: <20261001-bridge-alloc-conv-v1-2-f0a1fe040a86@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "Andy Yan" <andy.yan@rock-chips.com>, "David
 Airlie" <airlied@gmail.com>, =?utf-8?b?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>,
 "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>,
 "Sandy
 Huang" <hjc@rock-chips.com>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
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

On Thu, 1 Oct 2026 11:25:12 +0300, Cristian Ciocaltea wrote:
> The driver already allocates its private data via
> devm_drm_bridge_alloc(), which initializes the bridge funcs pointer.
> Remove the leftover manual assignment in the probe function.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
