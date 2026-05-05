Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A21BCD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 19:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D97C210E165;
	Tue,  5 May 2026 19:35:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NbvT44tr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC5310E165
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 19:35:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 896C360181;
 Tue,  5 May 2026 19:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077F6C2BCB4;
 Tue,  5 May 2026 19:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778009741;
 bh=P0xQWvqkG5HbL2Qs5vliqZ7IJtLJCrMcA9mw0zBM5bA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NbvT44trIrer+CaoL7bvNBTBzqPm5Vaiz8uaxZcm5uCkC0DRfQfQDMyParpd4jEkI
 iCe86Pw9imHp9AEsjHpZ20qApsvep2onxMYVvWM9MFFPMPqQzNTY4gY3Wk05GcDMH3
 PyO0u/GAON11E60giGNjCVlJRLkmXdaXiDZWxkUBEAHjG8v3+MhqDWSJsEcfxPGdZ0
 8+l2xxLD5oB3JzVlMdAdYJrT3l0KCNNXnK0Y1tcRZSVyjUlS8Pn+lICjX4S5dzqjdm
 i+nCBD1h5G9Riilw9nUDz7rp7/ZyJeBD3IGZ1/sHvGM50Gzbm0ENBcVEKn/OzLXLtW
 kaShwQeg0zLkw==
Date: Tue, 5 May 2026 14:35:38 -0500
From: Rob Herring <robh@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Aradhya Bhatia <aradhya.bhatia@linux.dev>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Swamil Jain <s-jain1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/15] dt-bindings: mfd: syscon: Add
 ti,am625-dss-dpi0-clk-ctrl compatible
Message-ID: <20260505193538.GA3785056-robh@kernel.org>
References: <20260420-beagley-ai-display-v1-0-f628543dfd14@ideasonboard.com>
 <20260420-beagley-ai-display-v1-3-f628543dfd14@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-beagley-ai-display-v1-3-f628543dfd14@ideasonboard.com>
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

On Mon, Apr 20, 2026 at 03:54:10PM +0300, Tomi Valkeinen wrote:
> The DPI output pipeline in K3 SoCs contains the display subsystem (DSS)
> which produces the in-SoC parallel video signal, and a DPI block which
> adjusts the signal to the external MIPI DPI output.
> 
> The DSS IP has registers to configure whether the data and sync signals
> are driven on rising or falling clock edge, and on some SoCs these are
> automatically conveyed to the DPI block which needs that configuration
> to properly output the MIPI DPI signal.
> 
> However, on some SoCs the DPI block configuration has to be done
> manually, using an extra register outside the DSS, DPI0_CLK_CTRL in
> MAIN_CTRL_MMR_CFG0 block, which controls the DPI block's behavior. Note
> that while the register is named "CLK_CTRL", it's not really related to
> clocks, but the sync and data signals.
> 
> Currently the DPI0_CLK_CTRL is never written, so it's always 0, meaning
> the data and sync are always driven on a rising clock edge regardless of
> the DSS configuration.
> 
> DPI0_CLK_CTRL register seems to be an independent "quirk" register,
> inside MAIN_CTRL_MMR_CFG0 block, which contains general purpose system
> registers. The registers surrounding DPI0_CLK_CTRL seem to be controlled
> by the system firmware or linux clock drivers. So, it is just this
> single register we can map, and we can't create a syscon node for the
> whole (or big parts of) MAIN_CTRL_MMR_CFG0.
> 
> I see two options to handle the register:
> 
> 1) We could add that single register to the DSS binding as a new reg
>    block. That feels wrong, as it's not a DSS register.
> 2) Add it as a syscon node, which can then be used by tidss driver.
>    It is a bit silly to create a syscon node for a single 32-bit
>    register, though.

Is it really 1 register and nothing else in that h/w block? That's quite 
unusual.

Rob
