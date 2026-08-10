Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B05C5AD5A
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 00:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F6E610E5C0;
	Mon, 10 Aug 2026 00:27:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="o5PTjKFK";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 827C710E5C0
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 00:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=gmPoxasTLea96f4ua9762tSSsel1x7XFrUfRV2Jz9/o=; b=o5PTjKFKU3A2+jZVJbxctqOdHd
 MXyGcg2FNgfbCxYAfo+52FjneAcQq79A1LwfzY5f/p7+f1FqQ4pdh2ZpgP1dA/los/H44VG0jFS9/
 HJo7ACGFz+v5BszorIiEc6Qb5SFM2jrj519DwfeeyM4NsjMc8Fd4dUSRa1scHh5SAVu9WEPyF0UcP
 5SvYl8LmCL7s/gT+NL+B3DWkWHciojhoe7hm7clIqpuaX+0fAqGu4Y11vtz4KVWWSwKH1xd4dp2HR
 tURoNoJp5nZsf2Er5gmZC3hthl5jSYRM7vGLdkU4aLfA1htSpbTF1xnUjZonQNxPyOdUCdceF2nnh
 KekmAD0g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wtDrt-0000000Ar4N-37gI; Mon, 10 Aug 2026 00:27:53 +0000
Message-ID: <e0488e93-eb19-42d4-a7c0-64657141b398@infradead.org>
Date: Sun, 9 Aug 2026 17:27:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fbdev: maxinefb: fix build issues
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
 Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 linux-mips@vger.kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <20260809234810.982500-1-rdunlap@infradead.org>
 <20260810000251.55AD61F000E9@smtp.kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260810000251.55AD61F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

[adding Cc:s]

On 8/9/26 5:02 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Initialization function returns positive value `1` on failure, breaking module load semantics and causing subsequent `registered_fb` array corruption on unload.
> - [High] `maxinefb_fix.smem_start` is initialized with a virtual address (`CKSEG1ADDR`) instead of the hardware physical address, breaking user-space `mmap()`.
> --
> 
> --- Patch [1]: [RFC PATCH] fbdev: maxinefb: fix build issues ---
> commit e391418fa2f21f8c420eccb513c031674ef184c6
> Author: Randy Dunlap <rdunlap@infradead.org>
> 
> fbdev: maxinefb: fix build issues
> 
> This commit fixes build errors and warnings for the maxinefb driver on
> 32-bit and 64-bit MACH_DECSTATION. It updates KSEG1ADDR to CKSEG1ADDR and
> adds the static keyword to missing prototypes.
> 
>> diff --git a/drivers/video/fbdev/maxinefb.c b/drivers/video/fbdev/maxinefb.c
>> index 52528eb4dfb41..8aa1389e2d4c8 100644
>> --- a/drivers/video/fbdev/maxinefb.c
>> +++ b/drivers/video/fbdev/maxinefb.c
> [ ... ]
>> @@ -111,7 +98,7 @@ static const struct fb_ops maxinefb_ops = {
>>  	.fb_setcolreg	= maxinefb_setcolreg,
>>  };
>>  
>> -int __init maxinefb_init(void)
>> +static int __init maxinefb_init(void)
> 
> [Severity: High]
> This is a pre-existing issue, but does returning 1 on failure in this function
> cause issues with module load semantics?
> 
> In maxinefb_init():
> 
>         if (register_framebuffer(&fb_info) < 0)
>                 return 1;
> 
> If register_framebuffer() fails, returning a positive integer causes the kernel
> to treat the module as successfully loaded because the module init framework
> expects negative error codes for failure.

Ack. I'll change that.

> Later, when the module is unloaded, maxinefb_exit() calls
> unregister_framebuffer() on the unregistered fb_info. Since it was never
> successfully registered, its node field is 0.
> 
> Does this cause the generic do_unregister_framebuffer() to blindly execute
> registered_fb[0] = NULL, corrupting the kernel's framebuffer state by deleting
> the reference to whatever valid framebuffer occupied node 0?
> 
>> diff --git a/include/video/maxinefb.h b/include/video/maxinefb.h
>> index 6aeb4acca2bdb..2b66b32f355cf 100644
>> --- a/include/video/maxinefb.h
>> +++ b/include/video/maxinefb.h
> [ ... ]
>> @@ -13,13 +13,13 @@
>>  /*
>>   * IMS332 video controller register base address
>>   */
>> -#define MAXINEFB_IMS332_ADDRESS		KSEG1ADDR(0x1c140000)
>> +#define MAXINEFB_IMS332_ADDRESS		CKSEG1ADDR(0x1c140000)
>>  
>>  /*
>>   * Begin of DECstation 5000/xx onboard framebuffer memory, default resolution
>>   * is 1024x768x8
>>   */
>> -#define DS5000_xx_ONBOARD_FBMEM_START	KSEG1ADDR(0x0a000000)
>> +#define DS5000_xx_ONBOARD_FBMEM_START	CKSEG1ADDR(0x0a000000)

Maciej or anyone:
can you comment of this, please?

> [Severity: High]
> This is a pre-existing issue, but does assigning a virtual address to
> maxinefb_fix.smem_start break user-space mmap()?
> 
> In maxinefb_init():
> 
>         fb_start = DS5000_xx_ONBOARD_FBMEM_START;
>         ...
>         maxinefb_fix.smem_start = fb_start;
> 
> The smem_start field is passed to vm_iomap_memory() by the generic framebuffer
> mmap handler (fb_mmap()). Because vm_iomap_memory() strictly expects a physical
> address, does passing a KSEG1 virtual address set up user-space page tables
> pointing to an invalid physical address?
> 
> This could trigger an invalid physical memory access and a kernel panic when
> user-space accesses the mapped memory.
> 

-- 
~Randy

