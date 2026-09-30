Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935D1CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C704810E595;
	Wed, 30 Sep 2026 12:40:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nvOII3Cy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 528E110E595
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 12:40:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BD46942A90;
 Wed, 30 Sep 2026 12:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EB31F000FF;
 Wed, 30 Sep 2026 12:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790772030;
 bh=Rr5XxTaxMajYl2p+/oqpRV9/N2vSKguphALuMIRhPjc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nvOII3CyyGuxBQXg4/f08TQEIcxSnuxhlGb9if/4Rvqi/p95diQT0DQ2r4kXK/9oT
 wM3HzhMoHfzzJJvGXa1M5kiDLYuw6Lg/+rNO9ti6uRuqkdH0p4/GySl9ldje6U+JVH
 FdBoBDcdmNoMcZGk0Fv4ufHX4hz+lJDF1mxP2Ua5dcmvYDcIwYK3BYISggsCysT12N
 kmn/ld+nPBE6t1fS+k7GzAAS0W6834ieZwRu5F8+ydos8586llFmM12msSRlrMVbd6
 s9SNsesHPdGR+MruNTV5fFkmf8Jcu7gIO+KjmWJJsqjVWTXy57U2BwnYZBez6s1hDa
 QiEZdwOl1MkJA==
Date: Wed, 30 Sep 2026 20:40:20 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Sean Rhodes <sean@starlabs.systems>
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
 Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Corentin Chary <corentin.chary@gmail.com>,
 "Luke D. Jones" <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>,
 Prasanth Ksr <prasanth.ksr@dell.com>, Jorge Lopez <jorge.lopez2@hp.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Joshua Grisham <josh@joshuagrisham.com>, Will Deacon <will@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com,
 Brian Norris <briannorris@chromium.org>,
 Julius Werner <jwerner@chromium.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Danilo Krummrich <dakr@kernel.org>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, 
 Titouan Ameline de Cadeville <titouan.ameline@gmail.com>,
 Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
 Yidi Lin <yidilin@google.com>, Kees Cook <kees@kernel.org>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 chrome-platform@lists.linux.dev,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Michal Simek <michal.simek@amd.com>, Sven Peter <sven@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev
Subject: Re: (subset) [PATCH v14 0/5] coreboot CFR firmware attributes
Message-ID: <ar0DNFlI7MEA8zp2@tzungbi-laptop>
References: <cover.1788284852.git.sean@starlabs.systems>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1788284852.git.sean@starlabs.systems>
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

On Tue, Sep 01, 2026 at 06:48:01PM +0100, Sean Rhodes wrote:
> Move the firmware attributes class helper out of platform/x86, rename the
> coreboot-table firmware driver directory from google to coreboot, and add a
> coreboot CFR firmware attributes driver.
> 
> Changes in v14:
> - Rebase on current upstream master after Linux 7.3-rc1, preserving the
>   intervening coreboot table bounds and CBMEM no-map changes.
> - Drop the standalone include-order cleanup. Replace the affected relative
>   includes directly in the firmware attributes helper move, as requested by
>   Tzung-Bi.
> - Split the DRM coreboot framebuffer dependency update from the firmware
>   directory and Kconfig rename so it can receive a DRM Acked-by separately.
> - Keep the CFR driver and its runtime behavior unchanged from v13.
> 
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-firmware-next

[1/5] firmware: Move firmware attributes class helper
      commit: 6f3adf358c8808973dc44aa333bdc0b06ae5f0c5
[4/5] firmware: coreboot: Add CFR firmware attributes driver
      commit: f2e05ce9763feb1dd7da15afd2cc61df227ee85a

Thanks!
