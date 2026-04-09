Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E820E98FC2
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 06:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E09FE10E718;
	Thu,  9 Apr 2026 06:21:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tecTUyot";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C7AE10E718
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 06:21:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DD5E7600AD;
 Thu,  9 Apr 2026 06:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB46C4CEF7;
 Thu,  9 Apr 2026 06:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775715707;
 bh=Qn4JZaehpW1D4FzWvGTsbu71VymBqoJqc9XDf7PqQm4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tecTUyots3nMLbmUJFf8QGczqvb8m49GlohSdWpE6TQVqQBaKhF+LsrxTM4w4hlrT
 x2jzV+6L6pV1L+La6z4Ol34UMLrqGcnWPjyufepfm7SP7pKlyHFPJJatEjEDS/3Pz7
 ARypbiyDyCPoY0EVN0gTlgdy1Nb/HyIyNf6PPfR/W5usmZ4GO2QWxcWfjz8K8u7aRU
 gc/rjBgmykAR1JJ6Z7bmNnGiuOOqnNHu71T8f09cRG1bjAB5MDsfXZzNBOgepTIqmN
 SCsgzvt+uDGzWCLe9l8TVM95rEH4EAepBuZrVQqIZHJQZ2focPUyH0fXqRXhEQzKhd
 HdGBHZD58PJEg==
Date: Thu, 9 Apr 2026 08:21:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, geert@linux-m68k.org, 
 laurent.pinchart@ideasonboard.com, linux-renesas-soc@vger.kernel.org,
 biju.das.jz@bp.renesas.com, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6 09/21] dt-bindings: display: renesas,rzg2l-du: Refuse
 port@1 for RZ/G2UL
Message-ID: <20260409-stoic-accelerated-stingray-fbe025@quoll>
References: <cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
 <8a3dd4df30a6d950e5f38d46f4d9f396da67aa71.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8a3dd4df30a6d950e5f38d46f4d9f396da67aa71.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
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

On Wed, Apr 08, 2026 at 12:36:54PM +0200, Tommaso Merciai wrote:
> The RZ/G2UL DU supports only a single port@0 DPI. Explicitly refuse
> port@1 in the ports node.
> 
> Fixes: 2ef7cb1cea7d ("dt-bindings: display: renesas,rzg2l-du: Document RZ/G2UL DU bindings")
> Cc: stable@vger.kernel.org

Please describe bug being fixed here in such case.

Commit msg so far explains none.

Best regards,
Krzysztof

