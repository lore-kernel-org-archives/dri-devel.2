Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E29C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 03:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD4D010E13D;
	Mon, 10 Aug 2026 03:29:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="yZsLOpa/";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1705D10E13D
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 03:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=2mXr+36gQcVouoMzQ7KrVvAve6jSBWSK45dYP1ruE3s=; b=yZsLOpa/KvV6fqnglFbg4wE62d
 JivkRFHRaWx4c8tMMJP9+EJGS7ZBhgc4s68xyOZUThN5X5gJ4qNaW0PZ5okCAd6VnnP7THswjZbqG
 kJvQQMfFlQFZ8T08UiWTIHLqWu6lJn6MZGq6EbvXQWoU5CDoKRNmmBGWD1g3lMyxCUB40SFgANEIY
 Qxg6YVY/lG40FtEb1EdTT1eXTLL48T4bShBrSXWe6/cRzm+tttAJBFtS7g804bPCBDV+7S+OxaLDP
 bOdOPURaUXpW8DtrqW8w0D1QhUuP9Dwobnedbz8zQARptC3PG2GZXv0s8m3AuSEdhyDH5GCQpkxG1
 IK3h95Yw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wtGhf-0000000AxV3-3S7w; Mon, 10 Aug 2026 03:29:31 +0000
Message-ID: <7282ae0f-3bf5-4eb8-9585-04635de0084a@infradead.org>
Date: Sun, 9 Aug 2026 20:29:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fbdev: maxinefb: fix build issues
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org
References: <20260809234810.982500-1-rdunlap@infradead.org>
 <8ce99afa-1162-4910-92a4-6cb2973ea977@oss.qualcomm.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <8ce99afa-1162-4910-92a4-6cb2973ea977@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 8/9/26 8:24 PM, Philippe Mathieu-Daudé wrote:
> Hi Randy,
> 
> On 10/8/26 01:48, Randy Dunlap wrote:
>> This is all ancient source code from the beginning of git time.
>> Now builds cleanly on 32-bit and 64-bit MACH_DECSTATION.
>>
>> Fixes these build errors/warnings:
>>
>> ../drivers/video/fbdev/maxinefb.c:64:6: warning: no previous prototype for 'maxinefb_ims332_write_register' [-Wmissing-prototypes]
>>     64 | void maxinefb_ims332_write_register(int regno, register unsigned int val)
>>        |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> In file included from ../drivers/video/fbdev/maxinefb.c:34:
>> ../drivers/video/fbdev/maxinefb.c: In function 'maxinefb_ims332_write_register':
>> ../include/video/maxinefb.h:16:41: error: implicit declaration of function 'KSEG1ADDR'; did you mean 'CKSEG1ADDR'? [-Wimplicit-function-declaration]
>>     16 | #define MAXINEFB_IMS332_ADDRESS         KSEG1ADDR(0x1c140000)
>>        |                                         ^~~~~~~~~
>> ../drivers/video/fbdev/maxinefb.c:66:49: note: in expansion of macro 'MAXINEFB_IMS332_ADDRESS'
>>     66 |         register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;
>>        |                                                 ^~~~~~~~~~~~~~~~~~~~~~~
>> ../drivers/video/fbdev/maxinefb.c:66:40: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>>     66 |         register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;
>>        |                                        ^
>> ../drivers/video/fbdev/maxinefb.c: At top level:
>> ../drivers/video/fbdev/maxinefb.c:74:14: warning: no previous prototype for 'maxinefb_ims332_read_register' [-Wmissing-prototypes]
>>     74 | unsigned int maxinefb_ims332_read_register(int regno)
>>        |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../drivers/video/fbdev/maxinefb.c: At top level:
>> ../drivers/video/fbdev/maxinefb.c:74:21: warning: 'maxinefb_ims332_read_register' defined but not used [-Wunused-function]
>>     74 | static unsigned int maxinefb_ims332_read_register(int regno)
>>        |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../drivers/video/fbdev/maxinefb.c: In function 'maxinefb_ims332_read_register':
>> ../drivers/video/fbdev/maxinefb.c:76:40: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>>     76 |         register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;
>>        |                                        ^
>> ../drivers/video/fbdev/maxinefb.c: At top level:
>> ../drivers/video/fbdev/maxinefb.c:114:12: warning: no previous prototype for 'maxinefb_init' [-Wmissing-prototypes]
>>    114 | int __init maxinefb_init(void)
>>        |            ^~~~~~~~~~~~~
>> In file included from ../drivers/video/fbdev/maxinefb.c:34:
>> ../drivers/video/fbdev/maxinefb.c: In function 'maxinefb_init':
>> ../include/video/maxinefb.h:22:41: error: implicit declaration of function 'KSEG1ADDR'; did you mean 'CKSEG1ADDR'? [-Wimplicit-function-declaration]
>>     22 | #define DS5000_xx_ONBOARD_FBMEM_START   KSEG1ADDR(0x0a000000)
>>        |                                         ^~~~~~~~~
>> ../drivers/video/fbdev/maxinefb.c:119:20: note: in expansion of macro 'DS5000_xx_ONBOARD_FBMEM_START'
>>    119 |         fb_start = DS5000_xx_ONBOARD_FBMEM_START;
>>        |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Suggested-by: "Maciej W. Rozycki" <macro@orcam.me.uk> # for s/KSEG1ADDR/CKSEG1ADDR/
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>> Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
>> Cc: Helge Deller <deller@gmx.de>
>> Cc: linux-fbdev@vger.kernel.org
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>> Cc: linux-mips@vger.kernel.org
>>
>>   drivers/video/fbdev/maxinefb.c |   17 ++---------------
>>   include/video/maxinefb.h       |    4 ++--
>>   2 files changed, 4 insertions(+), 17 deletions(-)
>>
>> --- linux-next-20260807.orig/drivers/video/fbdev/maxinefb.c
>> +++ linux-next-20260807/drivers/video/fbdev/maxinefb.c
>> @@ -61,7 +61,7 @@ static struct fb_fix_screeninfo maxinefb
>>     /* Handle the funny Inmos RamDAC/video controller ... */
>>   -void maxinefb_ims332_write_register(int regno, register unsigned int val)
>> +static void maxinefb_ims332_write_register(int regno, register unsigned int val)
>>   {
>>       register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;
>>       unsigned char *wptr;
>> @@ -71,19 +71,6 @@ void maxinefb_ims332_write_register(int
>>       *((volatile unsigned short *) (wptr)) = val;
>>   }
>>   -unsigned int maxinefb_ims332_read_register(int regno)
>> -{
>> -    register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;
>> -    unsigned char *rptr;
>> -    register unsigned int j, k;
>> -
>> -    rptr = regs + 0x80000 + (regno << 4);
>> -    j = *((volatile unsigned short *) rptr);
>> -    k = *((volatile unsigned short *) regs);
>> -
>> -    return (j & 0xffff) | ((k & 0xff00) << 8);
>> -}
>> -
>>   /* Set the palette */
>>   static int maxinefb_setcolreg(unsigned regno, unsigned red, unsigned green,
>>                     unsigned blue, unsigned transp, struct fb_info *info)
>> @@ -111,7 +98,7 @@ static const struct fb_ops maxinefb_ops
>>       .fb_setcolreg    = maxinefb_setcolreg,
>>   };
>>   -int __init maxinefb_init(void)
>> +static int __init maxinefb_init(void)
>>   {
>>       unsigned long fboff;
>>       unsigned long fb_start;
>> --- linux-next-20260807.orig/include/video/maxinefb.h
>> +++ linux-next-20260807/include/video/maxinefb.h
>> @@ -13,13 +13,13 @@
>>   /*
>>    * IMS332 video controller register base address
>>    */
>> -#define MAXINEFB_IMS332_ADDRESS        KSEG1ADDR(0x1c140000)
>> +#define MAXINEFB_IMS332_ADDRESS        CKSEG1ADDR(0x1c140000)
>>     /*
>>    * Begin of DECstation 5000/xx onboard framebuffer memory, default resolution
>>    * is 1024x768x8
>>    */
>> -#define DS5000_xx_ONBOARD_FBMEM_START    KSEG1ADDR(0x0a000000)
>> +#define DS5000_xx_ONBOARD_FBMEM_START    CKSEG1ADDR(0x0a000000)
> 
> The change looks correct, but clearly this has never been tested
> on a 64-bit DECstation, so I'm not sure having this code being
> now built is an improvement.
> 
> What about:
> 
> -- >8 --
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index ac9ac4287c6a..ff17afe6b8b3 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1436,7 +1436,7 @@ config FB_PMAGB_B
> 
>  config FB_MAXINE
>         bool "Maxine (Personal DECstation) onboard framebuffer support"
> -       depends on (FB = y) && MACH_DECSTATION
> +       depends on (FB = y) && MACH_DECSTATION && 32BIT
>         select FB_IOMEM_HELPERS
>         help
>           Support for the onboard framebuffer (1024x768x8) in the Personal
> ---
> 
> ?

I guess I'm OK with that. I'm even OK with removing the driver completely.

Maciej did say in https://lore.kernel.org/all/alpine.DEB.2.21.2308152255080.8596@angie.orcam.me.uk/
that: "the proper way would be by using `ioremap' really.  I'll make a patch."
[That was 15.Aug.2023.]


-- 
~Randy

