Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FB3C79FB5
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F158C10EF06;
	Wed,  9 Sep 2026 06:54:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AgycdMsX";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70D1A10E161
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 19:22:40 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49cd77e0f95so40582555e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 12:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788895358; x=1789500158; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GVs4+8gm56Wnu6exUObCNgkOQEYDE8t6OW3Oqkq6qd8=;
 b=AgycdMsXnbClDuXIlzCE/Cqc+K+JT9f8PAlPmRtjvUlS8TvxCoyQcCOGkK6PHnSUl8
 MuqZp/KCydvU/OXMZ1d6nOOlV+12SSZR6+d0Xm7kRfgfIL6qwHc/a3DyZLBhLKCazuf5
 ujHIWMygfCsmM24t4W7OyAyIQMcvzx1iQetIZrO7ZPQQm8y+uh2EG1W4A5NARSGi3ZdY
 n/bbFHS89IVDrECXBEuKgERpHa6wB7XyXduaa80J/Tik3sp5Lggh+0kJBHj6NH4Vf8kp
 nwSUMsX+E0DCp3uTmZk8FKPfaIRIkQEfC9XxZUi+kyII8hOERreIFZ/AbYAAzHsMKUsQ
 fuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788895358; x=1789500158;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GVs4+8gm56Wnu6exUObCNgkOQEYDE8t6OW3Oqkq6qd8=;
 b=IUUh/yCVWskuUTEztcUsPZJPHqnUBk6Sq89uKWK+dsc6dP4Z/c6M4HpWyD4C/kHCDe
 t64Vm7bkCoUnEaQXG7t6APhJL2Gllpw/NqzP0bPAlSjiMOAx40U4yzccAxgOpexr48Ep
 J/Ac1ZfskOeSMI7wk4w8mt0oAdTp+K9knciJ+SXGuwMft5F/y05ZtA3o/gRlCceHmq7j
 MWZCelYgtx53Fopunof9C6BDAkBOW8PFx14+kpDEtitUBeGGLVpzzQOB5aWHqRUUH5kG
 OHZg58hiBDVru+qZx39Dy8jwY7gJGhpx8Qs30eDhCLMU1dexVJR0v8Rc41Jq1fY8QHfz
 S2qA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIEiY67jvbjBX7PMAwmvYRwN3dFf4IsxIwZ7CUqefwCIZQ+73ebb7s1uCMACVyyRZVtBC5tpafTag=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kKlvRmLIhpxgEUXQR67k5BtoFNAvhVNADLR5fHksA+hMrlFD2V
 f99O/GKk5b0eLtwvxldYMNz/aQqLiK1T9uEdZ0OkJMixltK9zyv13Sme
X-Gm-Gg: AYBFou1NgAF0K0a8km9kpXcxup1IeKoMH6F31PX2NE5NDGAvBddLLpd8hLzAE79Sgot
 s+StIqAVCSrNCanSrWeIEgwnPZCA/fiyR46sg6CSL/svGYRl8O/Ug013GJobVJNNDRZcvcfhyFE
 pChqdeQz0UyiM5M74OmcPVG8sLRy5T19xTOOiiLtxbEmkfMslrnrD1pH0nUo/2gSU0N78fSSb7z
 a0aMY/fe0HU6VfmFAMdMxSIRRxso5T+Gb2yXeHF8/rzwqHr4i48Ojq4j5J6EmqVppiAYLvs5aSy
 fVYVWRabNygplUZMTcV6rm9sPTEV/m3xK3/Fj408DQkbydVftFXFGbiznVuS0RpzWcPP7r5lDzn
 rL0q1GjvzJnZF2oHJ7/EKku/JwHzzAf17qq+EPSpFeQ4AdcH5OgITtzlKERcf+6ne5uIKW8e1gt
 Sk4bbKW94uGVfzW+u1FVjRVulVtoPPUzLxGsdRXw2Vw14BLmuu4X2g6xV6kCpzMDWlFwbEHpr6s
 bEtnHYQM7T5q1Aam3jV6REIr3nackKOrKcUCRydZur/nu/Nb+4eji9dHGjkuzedWGDc4cBFfApS
 Nr3xF6KsuAoX3HMKzsujZDYJJ/I5rw==
X-Received: by 2002:a05:600c:3ba3:b0:49d:e79:612f with SMTP id
 5b1f17b1804b1-49d0e79635amr157041045e9.26.1788895358151; 
 Tue, 08 Sep 2026 12:22:38 -0700 (PDT)
Received: from MacBook-Pro-von-Karl
 (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485881353e8sm38080321f8f.1.2026.09.08.12.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 12:22:37 -0700 (PDT)
Date: Tue, 8 Sep 2026 21:21:22 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linus Walleij <linusw@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, Drew Fustini <fustini@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, 
 Stefan Agner <stefan@agner.ch>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Gregory Clement <gregory.clement@bootlin.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Kristoffer Ericson <kristoffer.ericson@gmail.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Shawn Guo <shawnguo@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>, 
 Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, 
 linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org,
 Paul Walmsley <paul@pwsan.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Helge Deller <deller@gmx.de>, Tero Kristo <kristo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, linux-media@vger.kernel.org,
 linux-mtd@lists.infradead.org, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org
Subject: Re: [PATCH 06/13] ARM: omap2: remove omap24xx support
Message-ID: <aqBXOemS4boakDGt@gmail.com>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-7-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908152808.3928630-7-arnd@kernel.org>
X-Mailman-Approved-At: Wed, 09 Sep 2026 06:54:46 +0000
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

On Tue, Sep 08, 2026 at 05:27:56PM +0100, Arnd Bergmann wrote:
>  86 files changed, 60 insertions(+), 10696 deletions(-)

Note that Sashiko skipped reviewing this patch, because it exceeded
its current 10000 line limit.

> -CONFIG_ARCH_MULTI_V6=y
>  CONFIG_OMAP_RESET_CLOCKS=y
> -CONFIG_ARCH_OMAP2=y

With CONFIG_ARCH_MULTI_V6 gone, CONFIG_ARM_ERRATA_411920=y a few lines
down can be deleted (savedefconfig drops it)

> diff --git a/arch/arm/mach-omap2/gpmc.h b/arch/arm/mach-omap2/gpmc.h
> deleted file mode 100644

perl scripts/get_maintainer.pl --self-test=patterns now warns:
  ./MAINTAINERS:19896: warning: no file matches	F:	arch/arm/mach-omap2/*gpmc*

> @@ -560,13 +533,11 @@ void __init pdata_quirks_init(const struct of_device_id *omap_dt_match_table)
>  	 * We still need this for omap2420 and omap3 PM to work, others are

Stale comment about omap2420

> diff --git a/arch/arm/mach-omap2/voltagedomains2xxx_data.c b/arch/arm/mach-omap2/voltagedomains2xxx_data.c
> deleted file mode 100644
> [...]
> -void __init omap2xxx_voltagedomains_init(void)

The declaration for this is still in voltage.h.

Thanks,
Karl
