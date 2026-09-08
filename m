Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A4AC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 17:28:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9CD710E442;
	Tue,  8 Sep 2026 17:28:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="RuEeEMW/";
	dkim-atps=neutral
X-Greylist: delayed 572 seconds by postgrey-1.36 at gabe;
 Tue, 08 Sep 2026 17:28:27 UTC
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A87CF10E442
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 17:28:27 +0000 (UTC)
Received: from darkstar.musicnaut.iki.fi (85-76-138-200-nat.elisa-mobile.fi
 [85.76.138.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: aaro.koskinen)
 by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hfVyj3s1Sz49Q5S;
 Tue, 08 Sep 2026 20:18:37 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu; 
 t=1788887928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PO/N7p293WhZWOnEDuSy9gtwR4Cj1KkgRIMnOyAdkIo=;
 b=RuEeEMW/lTLQi0I0YRvcxTIwqjW3vNe/zSCBmL/PGJcJBZCIMJydTjFu34u3aTjpaeBQp/
 qlxsWAySlfMOjDBRxCvil5yr9Go9xiMyb3yHsgrHzpvjURsZDuC2J0VNoTCAzH9d50ohZ9
 SZt4pd7ThrbA6qTlPwQRFXl85Go9ymb2mUnYH8zcdlBH8xKgdDG/aUdijBE6B91mHYsf/3
 jHGxS5ZdtOAqcHIzQf8RLPi05/UAICgWjCa4RVxqPJrKEa4fpqAwol5EP2Mr/pyCO5XkJf
 TvQHKUsuqJlrBKO1872gFYm514Sf7gAjW1wQgR4YUn/6wUUZCkdvej9fYv4iag==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1788887928;
 b=SbNwL400m2OjexdcOokzSVLBXJYp5eFG2UrettS0xu6rLtPQAw0BoPf/Rha3nNm32X4n6N
 pZhnu1IOhmA42K4eSL3KfjRee1wbSyxocwUHfDcWMWOHXj4ILLfIYj0jWl0C3v0shda8Cs
 YtShuPaJjzTUQuyHUm+jWn6ClSqpo3i6e8bdD1Sy6wO5h9/gMFr72HuFxxQuuwAWWrwBjJ
 Bvhd7kAL7qs2ZH5rUYZr3YJgdQLEkmeHK6NniKr8EnUhnI15MVz9pr297APC9kWFLR28Nd
 gJE3miv9HUpHfPcdmHHFoGcNaVcJ+kap7WMST5SiQb1OOG5go9hAWHx3O2mZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=lahtoruutu; t=1788887928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PO/N7p293WhZWOnEDuSy9gtwR4Cj1KkgRIMnOyAdkIo=;
 b=PKxyd3l3jvpv/hX9vp8woYeZp39vkZDVbD7MEec2pYDL0IMXGYLnkm9tAwprnb+m4HisQ2
 CW5kybZg+P7otj2oJtrIFVpdmVNtKUmS31fGV6YnREg1F9XRdbVjOZCdwPkB+jNi1dUtUI
 7yL74o8J8adJHO9mTvoZjYN74doQp6+pmwVJQy8Vv4FXx5KqxhCn4/JS5JJmDwh/x0KBFz
 RKjUDwmtYkvNckHVaeu/b+tTcKJKCccwev1BtIq7RW5wBTe5/NKaKTS+d0hIbqi3vontaO
 eaNQzuBeoWECcyoUJmaDmeTAaq1rBu7nKsbJHhov2Dyhro3U1y7boF5omjgoAA==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
Date: Tue, 8 Sep 2026 20:18:35 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linus Walleij <linusw@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Drew Fustini <fustini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Stefan Agner <stefan@agner.ch>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andreas Kemnade <andreas@kemnade.info>,
 Kevin Hilman <khilman@baylibre.com>,
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
 Shawn Guo <shawnguo@kernel.org>, Karl Mehltretter <kmehltretter@gmail.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Helge Deller <deller@gmx.de>, Tero Kristo <kristo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org
Subject: Re: [PATCH 06/13] ARM: omap2: remove omap24xx support
Message-ID: <aqBDa2f__ZE5BQao@darkstar.musicnaut.iki.fi>
References: <20260908152808.3928630-1-arnd@kernel.org>
 <20260908152808.3928630-7-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908152808.3928630-7-arnd@kernel.org>
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

Hi,

On Tue, Sep 08, 2026 at 05:27:56PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The omap24xx SoC platform was used in the Nokia N800 and N810 tablets
> released on 2007 and was among the first ARMv6 CPUs in products that
> made it into products.
> 
> Unfortunately the early ARM1136r0 CPU cores had a number of quirks that
> caused a disproportionate amount of work to keep them compatible with
> later ARMv6K/v7/v8 implementations.
> 
> Drop the support for this SoC in order to allow removing ARM1136r0.
> 
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
