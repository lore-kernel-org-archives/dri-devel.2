Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C357C4451B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 05:51:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77C7410E09E;
	Mon, 20 Jul 2026 05:51:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cA8IB6uF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE34A10E09E
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 05:51:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7472644096;
 Mon, 20 Jul 2026 05:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F471F000E9;
 Mon, 20 Jul 2026 05:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784526674;
 bh=oS/ZDamywEZJL7jLgwRBPyvqXU2kgIQiPO75+B0LuSI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cA8IB6uF36/vlwqE9GST1M/EZllVJOwnHx5773LTF8s791b/9AeGgn6EJAOizbyHf
 jCZuzeehA79A0bX+EzDKyrupMV9E1eZuOnAatqhnwpVysIJ9wOzq4YobHHRbYZu8AB
 ou3NYLrvlHxdJnbtVxgH48ay5b0PR8Pzs6/PSvjlzMuY/U/+0t/lHK3j/Df+Ow2fEg
 WTuRumpp3jhHs1Y4UGa9o6wxaB56O9zyjEvell6aGJmrefNk29p5xBuzfGZnyz4OFH
 j1egSp3duztHApRYipoFD/igbe9L2QoJp8sRks+ETAFtIjFy2wZp+MF83verfX4HYF
 c04Dw462ZQ4Ww==
Date: Mon, 20 Jul 2026 07:51:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wojciech Dubowik <wojciech.dubowik@mt.com>
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Marek Vasut <marex@denx.de>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: display: sn65dsi83: Add output
 data-lanes property
Message-ID: <20260720-international-industrious-hippogriff-dd24ee@quoll>
References: <20260717115002.308035-1-wojciech.dubowik@mt.com>
 <20260717115002.308035-3-wojciech.dubowik@mt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717115002.308035-3-wojciech.dubowik@mt.com>
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

On Fri, Jul 17, 2026 at 01:50:00PM +0200, Wojciech Dubowik wrote:
> From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> 
> Add an optional output lvds data lanes property with two allowed values.
> The array <1 2 3 4> for standard layout and <4 3 2 1> for reversed lvds
> output lanes. The latter informs the driver that reverse lvds config
> option has to be set in config register for the respective output channel.
> 
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>

Well, I am not doing the work twice (nothing in cover letter explains
why I should, IOW, why you decided to drop my review).

Dropping this patch from Patchwork.

Best regards,
Krzysztof

