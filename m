Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E63C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94EBA10F48E;
	Thu, 13 Aug 2026 17:37:34 +0000 (UTC)
X-Greylist: delayed 338 seconds by postgrey-1.36 at gabe;
 Thu, 13 Aug 2026 17:37:32 UTC
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
 by gabe.freedesktop.org (Postfix) with ESMTP id B63CD10F48F
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 17:37:32 +0000 (UTC)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
 id 1026692009C; Thu, 13 Aug 2026 19:31:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by angie.orcam.me.uk (Postfix) with ESMTP id 0B8BE92009B;
 Thu, 13 Aug 2026 18:31:51 +0100 (BST)
Date: Thu, 13 Aug 2026 18:31:50 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Randy Dunlap <rdunlap@infradead.org>
cc: linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-mips@vger.kernel.org
Subject: Re: [RFC PATCH] fbdev: maxinefb: fix build issues
In-Reply-To: <20260809234810.982500-1-rdunlap@infradead.org>
Message-ID: <alpine.DEB.2.21.2608131801340.48788@angie.orcam.me.uk>
References: <20260809234810.982500-1-rdunlap@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

> This is all ancient source code from the beginning of git time.

 I can dig out any further details you may need from the old LMO git tree.  
Eventually it's planned to be put back online, but resources.

> Now builds cleanly on 32-bit and 64-bit MACH_DECSTATION.

 Thanks for doing this work.

> Suggested-by: "Maciej W. Rozycki" <macro@orcam.me.uk> # for s/KSEG1ADDR/CKSEG1ADDR/

 Eventually this code should be converted to a platform device, so such 
hacks won't be necessary.  Sadly I declined an offer back in 2009 and I 
have been chasing a specimen for a while now.  And since it's an onboard 
device unlike all the TURBOchannel framebuffers, there's no alternative.

> --- linux-next-20260807.orig/drivers/video/fbdev/maxinefb.c
> +++ linux-next-20260807/drivers/video/fbdev/maxinefb.c
> @@ -71,19 +71,6 @@ void maxinefb_ims332_write_register(int
>  	*((volatile unsigned short *) (wptr)) = val;
>  }
>  
> -unsigned int maxinefb_ims332_read_register(int regno)
> -{
> -	register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;
> -	unsigned char *rptr;
> -	register unsigned int j, k;
> -
> -	rptr = regs + 0x80000 + (regno << 4);
> -	j = *((volatile unsigned short *) rptr);
> -	k = *((volatile unsigned short *) regs);
> -
> -	return (j & 0xffff) | ((k & 0xff00) << 8);
> -}
> -
>  /* Set the palette */
>  static int maxinefb_setcolreg(unsigned regno, unsigned red, unsigned green,
>  			      unsigned blue, unsigned transp, struct fb_info *info)

 It might be worth mentioning in the change description that this is dead 
code (and overall provide a summary as to making functions static, etc.).  
Though I'm not entirely convinced as to the removal since this function 
documents the hardware interface, which must have been the intent to put 
it there.  Perhaps #if 0?

> --- linux-next-20260807.orig/include/video/maxinefb.h
> +++ linux-next-20260807/include/video/maxinefb.h
> @@ -13,13 +13,13 @@
>  /*
>   * IMS332 video controller register base address
>   */
> -#define MAXINEFB_IMS332_ADDRESS		KSEG1ADDR(0x1c140000)
> +#define MAXINEFB_IMS332_ADDRESS		CKSEG1ADDR(0x1c140000)
>  
>  /*
>   * Begin of DECstation 5000/xx onboard framebuffer memory, default resolution
>   * is 1024x768x8
>   */
> -#define DS5000_xx_ONBOARD_FBMEM_START	KSEG1ADDR(0x0a000000)
> +#define DS5000_xx_ONBOARD_FBMEM_START	CKSEG1ADDR(0x0a000000)
>  
>  /*
>   *      The IMS 332 video controller used in the DECstation 5000/xx series

 This would probably best be a separate change, especially as it's not 
needed for 32BIT.

 I'm not sure how the actual maintainers see it (I should probably list 
myself for all the scattered DECstation stuff), but I think this would 
best be a patch series of 3 for each of the individual classes of fixes.  
And since this borders on the obvious I wouldn't be too concerned as to 
the change descriptions; just one sentence plus the relevant error message 
quoted will do.  And your introduction should suffice as the cover letter.

 Let me know if this works for you and if you post such a series, I'll ack 
it right away.

  Maciej
