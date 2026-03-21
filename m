Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774D31094463
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 10:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6ECF10E37C;
	Sat, 21 Mar 2026 10:08:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CpWrLTVb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6701410E37C
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 10:08:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D71A843A8D;
 Sat, 21 Mar 2026 10:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED44C19421;
 Sat, 21 Mar 2026 10:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774087730;
 bh=2fWlNaWdZ/tdjFqi2lRKYZQDaf5ms4z4Yeuk+Z1lf8U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CpWrLTVbn+M8bb0HpAqUVUSsepxwCTkgW79n/eZ6KN12+NK+1EA7llo8GOHO70oDG
 6j9L3XwxpULRguxcFK4reT/p/eTFtDrpTkZkUkCL4knBhB5i7AiiItb66tWeQRqJvi
 HvapDFML696kTrCBGeSuEKN8jtf8bGvcLzCjaFxWJGk/BFLjFig2iC/2Dx5+z68rEE
 Zpe/TDGCrKA61wLBtvEejuGIIYwqjAbBFRJXyavrOzneF5xGVdXn8cNiIcl/UUk8ou
 8w8qHzB52Z7BntjrNoptEzF5naInpfCGIitJd42ZfJCeDjzyu0+opICpy4mhN3/FJ1
 PxZNyq08xMIvw==
Date: Sat, 21 Mar 2026 11:08:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pet Weng <pet.weng@ite.com.tw>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 Hermes Wu <hermes.Wu@ite.com.tw>, Kenneth Hung <kenneth.Hung@ite.com.tw>, 
 Jau-chih Tseng <jau-chih.tseng@ite.com.tw>, Pin-yen Lin <treapking@google.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v8 0/2] Add ITE IT61620 MIPI DSI to HDMI bridge driver
Message-ID: <20260321-albatross-of-terrific-prestige-95cdbc@quoll>
References: <20260320-it61620-0714-v8-0-0e70271cf5a9@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320-it61620-0714-v8-0-0e70271cf5a9@ite.com.tw>
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

On Fri, Mar 20, 2026 at 03:50:40PM +0800, Pet Weng wrote:
> This patch series adds support for the ITE IT61620 MIPI DSI to HDMI 
> bridge chip.
> 
> The IT61620 is an I2C-controlled bridge that receives MIPI DSI input 
> and outputs HDMI signals. A single-port MIPI DSI input is converted to 
> an HDMI 1.4 output. This series introduces:
> - A device tree binding YAML file describing the hardware
> - A new DRM bridge driver implementing the basic functionality
> 
> Signed-off-by: Pet Weng <pet.weng@ite.com.tw>
> ---
> Changes in v8:
> - dt-binding:
>  1. Clarify the hardware differences between IT6162 and IT61620 in the
>     description (IT61620 is single-port and lacks an internal MCU). 	[Krzysztof]
>  2. Dropped Reviewed-by from Krzysztof due to description changes.

Description? Like text? That is the reason to drop someone's review?

You ask us to perform the work twice, just because irrelevant thing
changed. Read carefulyl the docs.

Please read:
https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof

