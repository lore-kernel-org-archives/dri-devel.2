Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF0BC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF8B110F4DA;
	Thu, 13 Aug 2026 18:14:18 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
 by gabe.freedesktop.org (Postfix) with ESMTP id CB06B10F4DA
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 18:14:17 +0000 (UTC)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
 id 1FD6A92009D; Thu, 13 Aug 2026 20:14:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by angie.orcam.me.uk (Postfix) with ESMTP id 1AE0892009C;
 Thu, 13 Aug 2026 19:14:17 +0100 (BST)
Date: Thu, 13 Aug 2026 19:14:17 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Randy Dunlap <rdunlap@infradead.org>
cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-mips@vger.kernel.org
Subject: Re: [RFC PATCH] fbdev: maxinefb: fix build issues
In-Reply-To: <7282ae0f-3bf5-4eb8-9585-04635de0084a@infradead.org>
Message-ID: <alpine.DEB.2.21.2608131908450.48788@angie.orcam.me.uk>
References: <20260809234810.982500-1-rdunlap@infradead.org>
 <8ce99afa-1162-4910-92a4-6cb2973ea977@oss.qualcomm.com>
 <7282ae0f-3bf5-4eb8-9585-04635de0084a@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
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

On Sun, 9 Aug 2026, Randy Dunlap wrote:

> >> --- linux-next-20260807.orig/include/video/maxinefb.h
> >> +++ linux-next-20260807/include/video/maxinefb.h
> >> @@ -13,13 +13,13 @@
> >>   /*
> >>    * IMS332 video controller register base address
> >>    */
> >> -#define MAXINEFB_IMS332_ADDRESS        KSEG1ADDR(0x1c140000)
> >> +#define MAXINEFB_IMS332_ADDRESS        CKSEG1ADDR(0x1c140000)
> >>     /*
> >>    * Begin of DECstation 5000/xx onboard framebuffer memory, default resolution
> >>    * is 1024x768x8
> >>    */
> >> -#define DS5000_xx_ONBOARD_FBMEM_START    KSEG1ADDR(0x0a000000)
> >> +#define DS5000_xx_ONBOARD_FBMEM_START    CKSEG1ADDR(0x0a000000)
> > 
> > The change looks correct, but clearly this has never been tested
> > on a 64-bit DECstation, so I'm not sure having this code being
> > now built is an improvement.

 I don't expect any issues and FWIW the Maxine does support a 64-bit CPU 
module.

> > diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> > index ac9ac4287c6a..ff17afe6b8b3 100644
> > --- a/drivers/video/fbdev/Kconfig
> > +++ b/drivers/video/fbdev/Kconfig
> > @@ -1436,7 +1436,7 @@ config FB_PMAGB_B
> > 
> >  config FB_MAXINE
> >         bool "Maxine (Personal DECstation) onboard framebuffer support"
> > -       depends on (FB = y) && MACH_DECSTATION
> > +       depends on (FB = y) && MACH_DECSTATION && 32BIT
> >         select FB_IOMEM_HELPERS
> >         help
> >           Support for the onboard framebuffer (1024x768x8) in the Personal
> > ---
> > 
> > ?
> 
> I guess I'm OK with that. I'm even OK with removing the driver completely.

 No need to limit the driver to 32BIT and as I suggest in the other reply 
fixing 64BIT will best be a separate change.

> Maciej did say in https://lore.kernel.org/all/alpine.DEB.2.21.2308152255080.8596@angie.orcam.me.uk/
> that: "the proper way would be by using `ioremap' really.  I'll make a patch."
> [That was 15.Aug.2023.]

 Even more properly this will best be converted to a platform device and 
then resource handling will DTRT.  I do hope to get a specimen eventually, 
so I think there's no need to rush making changes on paper.

  Maciej
