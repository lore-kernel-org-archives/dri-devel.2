Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2D1C5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8E3910E1F0;
	Mon, 10 Aug 2026 14:33:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q6eYx7au";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04B4510E1F0
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:33:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6886E40BB0;
 Mon, 10 Aug 2026 14:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241771F000E9;
 Mon, 10 Aug 2026 14:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786372421;
 bh=hvqH9zZ0i4FPAUMO7qs3uRLITXvW0VP0smlftrvm8ng=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Q6eYx7auuQQBo0fTkxCZn47vcAUPbK53UbhiJTjVpgzAx4C7ES7Rh0RjFCmScVITv
 pbSMZEkDr8HpmGzsnfXBW8kVdwTK2gUrTAUfoVfn/fJRK9ffbR5MWlQoeL/WIne6lv
 CVSRnkHCT5k1Twnr66dVu6EM87yr2aPRvPXN1Bb6EmA2x6qDpur79/bDfieq5s83My
 NiA3UwYj+eH9mfWgHJ9Kmy5HF4Lj0aj9Mod6WzEvBG5eJQPXO6KSAe1tMY2EV03Jk/
 HeC+gL4wEh4XJ6CIxKsQeJd1nj6khJfip6BIq64yBLNSrKjYtpl9EjJQbYyFt5TU0s
 VN4+deX82Opmw==
Date: Mon, 10 Aug 2026 09:33:40 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cody Kang <codykang.hk@gmail.com>
Cc: linux-clk@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
 Haylen Chu <heylenay@4d2.org>, spacemit@lists.linux.dev,
 Michael Turquette <mturquette@baylibre.com>,
 Yixun Lan <dlan@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 dri-devel@lists.freedesktop.org, Conor Dooley <conor+dt@kernel.org>,
 linux-phy@lists.infradead.org, Simona Vetter <simona@ffwll.ch>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Yao Zi <me@ziyao.cc>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Guodong Xu <docular.xu@gmail.com>, linux-riscv@lists.infradead.org,
 Paul Walmsley <pjw@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Brian Masney <bmasney@redhat.com>, David Airlie <airlied@gmail.com>,
 Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v2 04/17] dt-bindings: soc: spacemit: allow eDP/DP PHY
 PLL pixel clocks on K3 APMU
Message-ID: <178637241975.1573687.15895967704569553501.robh@kernel.org>
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
 <20260809-k3-display-v2-4-327d7910bf71@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809-k3-display-v2-4-327d7910bf71@gmail.com>
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


On Sun, 09 Aug 2026 21:14:13 +0800, Cody Kang wrote:
> The APMU's eDP pixel-clock muxes select the DP PHY PLLs as parents, so the
> K3 syscon takes two clock inputs the other variants do not have.
> 
> Gate them behind the K3 compatible instead of widening the shared clock
> list, so a non-K3 syscon cannot silently accept clocks it has no mux for.
> 
> Signed-off-by: Cody Kang <codykang.hk@gmail.com>
> 
> ---
> v2:
> - drop the redundant minItems: 4; four is already the minimum
>   (Rob Herring)
> ---
>  .../bindings/soc/spacemit/spacemit,k1-syscon.yaml   | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

