Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA0FCA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6623E10E232;
	Thu,  1 Oct 2026 08:28:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aS3/O4L+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F9E410E232
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 08:28:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 526966022B;
 Thu,  1 Oct 2026 08:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE381F000FF;
 Thu,  1 Oct 2026 08:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790843332;
 bh=jtlnioyZElbz8ugOrc7hlVY7Dm6ti5mP/kZWdCnL0xI=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=aS3/O4L+0prg4o9Ac7Pz8qUr0Hvf6tmu2Hz2EpAjfJEV68bRJHJvHUB+i8jk/XuWY
 p4U1+0dwJqg+Okw0T/5wLUkajLTkA0aKK+971zYluVCI5ISDiV0oDMu7T8SRlTkWsO
 +ZxmCoDEJf1TtpqpBbasTXa7jNTMz4/LtnVUeXBVMv3ZcMR4y5PrJb6/skmOIjNcxK
 N+eTUVDTxzPGeZoQXYma/2QIi7hIJ5VwBF+YF4VlsBDktAy73fjTJ+t8LcA70mPrcg
 39z3KQVbFUPjg1S92GJw7XsyK1KvkAHHjAf2Yi1s9/x6L1iFTxryG61XZUw2IP5D8r
 VZaFd0S9NlROA==
Message-ID: <f90b5b37f0afda1ebf866a16c1502780@kernel.org>
Date: Thu, 01 Oct 2026 08:28:48 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 1/2] drm/rockchip: rk3066_hdmi: Convert to
 devm_drm_bridge_alloc() API
In-Reply-To: <20261001-bridge-alloc-conv-v1-1-f0a1fe040a86@collabora.com>
References: <20261001-bridge-alloc-conv-v1-1-f0a1fe040a86@collabora.com>
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

On Thu, 1 Oct 2026 11:25:11 +0300, Cristian Ciocaltea wrote:
> Bridge drivers are expected to use devm_drm_bridge_alloc() instead of
> devm_kzalloc() for allocating and partially initializing a private
> driver struct embedding a struct drm_bridge.
> 
> Perform the API conversion and drop the now redundant manual
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
