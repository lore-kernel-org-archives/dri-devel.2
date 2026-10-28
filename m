Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18ED606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=UVZQanLF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16E9D10E5C5;
	Wed, 28 Oct 2026 19:38:12 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B8510E5C5
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 19:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=RKeXRhrML1PnlJAJrOBPCA9w4pXg5kd97C5IqSm6NYg=; t=1793216285; x=1794425885; 
 b=UVZQanLFV2LCBdycUHopm/dUtJYtaaMDWBgQoC6OufJiASqnF/+RwGMgyyR505hivvsuS5xPzk4
 lP88aIMUsLHfmUp6oUbJvjuUvlJa9gethp+PE9z1ip/HpntagIoeXue0B+xAoZLGLDyT+geQ/TbkF
 xP3Oj97zTWZCpF1+82cIQ07KSYthXM8VdqNLvd//qjlDTosFWo7ZB1Zrem5kAEBzUMaZFgTrqjFJQ
 7hATA3X+N3hTHtrRNdfiktNuxX1IJ5sSs5vlA51/0LliXLbQBKMxBUGzBsL5Y9P2Q9AGA05KKAKcG
 O4gkGEdUd+6HUc3PhXbFeSw7t7lNd2Pegx1w==;
Date: Wed, 28 Oct 2026 20:37:51 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Andrew Davis <afd@ti.com>
Cc: Frank Binns <frank.binns@imgtec.com>, Matt Coster
 <matt.coster@imgtec.com>, "H . Nikolaus Schaller" <hns@goldelico.com>, Adam
 Ford <aford173@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, =?UTF-8?B?QmVub8OudA==?= Cousson
 <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo
 <kristo@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 03/11] ARM: dts: omap3: Add device tree entry for SGX GPU
Message-ID: <20261028203751.73100e37@kemnade.info>
In-Reply-To: <20240109171950.31010-4-afd@ti.com>
References: <20240109171950.31010-1-afd@ti.com>
 <20240109171950.31010-4-afd@ti.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 9 Jan 2024 11:19:42 -0600
Andrew Davis <afd@ti.com> wrote:

[...]
> diff --git a/arch/arm/boot/dts/ti/omap/omap36xx.dtsi b/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
> index e6d8070c1bf88..c3d79ecd56e39 100644
> --- a/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
> @@ -211,10 +211,11 @@ sgx_module: target-module@50000000 {
>  			#size-cells = <1>;
>  			ranges = <0 0x50000000 0x2000000>;
>  
For quite some time. I see
sgx_pwrdm (INA),OFF:0,RET:0,INA:1,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
in /sys/kernel/debug/pm_debug/count

with a status = "disabled" here (so practically reverting the patch it is:

sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0

All without pvrsgx driver installed. 

What is going on here? OFF is more power-saving than INA I think?!
> -			/*
> -			 * Closed source PowerVR driver, no child device
> -			 * binding or driver in mainline
> -			 */
> +			gpu@0 {
> +				compatible = "ti,omap3630-gpu", "img,powervr-sgx530";
> +				reg = <0x0 0x2000000>; /* 32MB */
> +				interrupts = <21>;
> +			};
>  		};
>  	};
>  

Regards,
Andreas
