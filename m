Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C3BC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B2DE10E719;
	Mon,  7 Sep 2026 09:17:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="koyoCVgu";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06E8510E719
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 09:17:21 +0000 (UTC)
Received: from francesco-nb (xcpe-178-82-167-143.dyn.res.sunrise.net
 [178.82.167.143])
 by mail11.truemail.it (Postfix) with ESMTPA id B2421228C8;
 Mon,  7 Sep 2026 11:17:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1788772639;
 bh=f4nIviLIi+x+ZOAJdYEY6Kz7sJRjdSIayZvWCzHqoF0=; h=From:To:Subject;
 b=koyoCVgu+7gk0m1m3rmW2fZEILPAJxzn3jERphEvkW6eJCq9FiwqMC/hXtrEqBU9r
 1aMP37vQEX/pzlLm9aeG9YdcIzZLlwd/3TKlIoHaHFIK5iWEkbOyARfzdcbzP1/Zjh
 U4pRyvnizWV6dx6EnCYRf8EzwEqJ/jiNmtITRDS9V/XlgLNFDPHGKkz+3tN2HU2LK1
 5QxjoH6lAsG/avZjVEv/FKB4KZUfuhpimYkAgZtobxJ4Wrv289PVsAIBUzK0y6XDMw
 RUjaG9t+UEAqyZy/FvmZgSCzzfFHpHbtDFXKZ4BlTLEUDTJiJq9QT65DmdSEw1oVlR
 fKGkkwIZW5jWg==
Date: Mon, 7 Sep 2026 11:17:15 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Leonardo Costa <leoreis.costa@gmail.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 tomi.valkeinen@ideasonboard.com, francesco@dolcini.it,
 leonardo.costa@toradex.com, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] drm/bridge: tc358768: Enforce input bus flags via
 atomic_check
Message-ID: <20260907091715.GA48864@francesco-nb>
References: <20260706132440.1594239-1-leoreis.costa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706132440.1594239-1-leoreis.costa@gmail.com>
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

Hello DRM bridge maintainers,

On Mon, Jul 06, 2026 at 10:24:17AM -0300, Leonardo Costa wrote:
> From: Leonardo Costa <leonardo.costa@toradex.com>
> 
> The tc358768 declares static bridge timings requiring pixel data to be
> sampled on the positive clock edge.
> 
> However, the DRM core default propagation simply copies the output-side
> bus flags, coming from the next bridge, connector or panel, to the
> input side. If the propagated flags are incompatible with the bridge
> ones, the data is wrongly sampled, typically resulting in visual
> artifacts on the panel.
> 
> Implement the atomic_check hook, replacing the mutually exclusive
> mode_fixup, and set the bridge state input bus flags to the ones
> required by the tc358768. The sync polarity defaulting previously done
> in mode_fixup is carried over into atomic_check unchanged.
> 
> Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>

Just a gentle ping, can this fix be merged?

Francesco

