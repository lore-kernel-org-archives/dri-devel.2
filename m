Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E16C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 11:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D70E10F7B4;
	Fri,  3 Jul 2026 11:18:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mGfQ5ZjU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A207D10F7C9
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 11:18:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E14B96001A;
 Fri,  3 Jul 2026 11:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905191F000E9;
 Fri,  3 Jul 2026 11:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783077487;
 bh=jBXujYiah0WFXjqCSb0QoHYjXF1ucesux4IjvTi8SDE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mGfQ5ZjU2R3MTrqtdqmUxN6YkIz2SBGsy2hVkrCTzk17zE3FTrLva12V3atkAwX4a
 Og7Zls0uQgPw/vg60f9hI58BqMX3vss8vGYVjyKOysWp0KOpV8qaVHNz3KTw0b+tjj
 54+EZkxNRr/0h3IW0TaedL4u9Ye6yGJSaHCR+xycTjhRh5WD85qSZR2ReDISt8b+/0
 iZ3cIr/rtvYIdoI8mneUxpf1VcB+hu1d4wkApVf/etVercq9gscaxHSVte8wEgKlps
 kvR19qi0f71L9DRCal2xVNBN2L7FeCLMrDlt/iU+1XkNW1XcNDgQYgGlKdtMCKTKZ2
 cUuT/MRqDnGzw==
Received: from johan by xi.lan with local (Exim 4.99.3)
 (envelope-from <johan@kernel.org>) id 1wfbuH-00000000jKL-17lX;
 Fri, 03 Jul 2026 13:18:05 +0200
Date: Fri, 3 Jul 2026 13:18:05 +0200
From: Johan Hovold <johan@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 10/14] mfd: lm3533: Set DMA mask
Message-ID: <akeabcriU7VBZCrp@hovoldconsulting.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-11-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617080031.99156-11-clamor95@gmail.com>
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

On Wed, Jun 17, 2026 at 11:00:27AM +0300, Svyatoslav Ryhel wrote:
> Missing coherent_dma_mask assigning triggers the following warning in
> dmesg:
> 
> [    3.287872] platform lm3533-backlight.0: DMA mask not set
> 
> Since this warning might be elevated to an error in the future, set
> coherent_dma_mask to zero because both the core and cells do not utilize
> DMA.

IIUC this warning is introduced by the OF conversion and should
therefore be moved before it as a preparatory patch.

But you need to describe the problem in more detail here as this looks
fishy.

Johan
