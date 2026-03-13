Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C2D105F78C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:55:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 686A410EB4E;
	Fri, 13 Mar 2026 08:55:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lAVi6WQa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A2F710EB4E;
 Fri, 13 Mar 2026 08:55:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id ABBF043E4B;
 Fri, 13 Mar 2026 08:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0491AC19421;
 Fri, 13 Mar 2026 08:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773392147;
 bh=ucTTcukYbtNVWOhR2wfdso2m++nGKWhQyMqNtiUzjF8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lAVi6WQa0IJlX9YxNyPpEorbhpqoVb4iCdGPThgB19JTT1BUQcK9w8nH7yCsJ/W/g
 oRzTF/V7K2RrFet8826dyQKg1Ev8dwmFMdOCuoRK1Q+pZ38VQG9VdLPjP8/bChAbxG
 potY4RSegHY53/8g03yWosZAkZSjcnFJxJgeV1K2LHqHGNwIh8MDc8u5tm/ft/qt7f
 65Z5r8qqUXgTEICmu7Z6/5d3RjwntmwAtXcfJprbMtF0HvtcXMTkExbrE2fnlGrKrM
 tMeKdUU/GYaAB1pRVJlBlf6ey4+LtJWplCzNGo3eERDJq8yRh3QiAVKoYV64IhbrdR
 P6l4dJpfGJCDA==
Date: Fri, 13 Mar 2026 09:55:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Sudarshan Shetty <tessolveupstream@gmail.com>, andrzej.hajda@intel.com, 
 neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
 jonas@kwiboo.se, jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, marex@denx.de, 
 valentin@compulab.co.il, philippe.schenker@toradex.com,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: bridge: ti, sn65dsi83: Add
 dual-link video mode property
Message-ID: <20260313-warm-whippet-of-spirit-e7f8f5@quoll>
References: <20260312043743.261475-1-tessolveupstream@gmail.com>
 <20260312043743.261475-2-tessolveupstream@gmail.com>
 <DH0X5VHW15QI.XOHUGC314J1P@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DH0X5VHW15QI.XOHUGC314J1P@bootlin.com>
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

On Thu, Mar 12, 2026 at 04:46:40PM +0100, Luca Ceresoli wrote:
> Hello Sudarshan,
> 
> On Thu Mar 12, 2026 at 5:37 AM CET, Sudarshan Shetty wrote:
> > Add a new optional device tree property `ti,dual-link-video-mode`
> > to indicate that the bridge should configure the device for
> > dual-link LVDS video mode.
> >
> > In dual-link configurations, some panels require the horizontal
> > timing parameters to be adjusted before programming them into
> > the device. In such cases, the horizontal timing values must be
> > divided by two when operating in dual-link mode.
> >
> > Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
> 
> This is not needed. Dual link mode is already implied by the presence of
> port@2 and port@3.

Yep!

Thanks for chiming in.

Best regards,
Krzysztof

