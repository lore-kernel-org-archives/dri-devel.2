Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699411094465
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 09:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA25010E2AA;
	Sat, 21 Mar 2026 09:46:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="K1Az0G+I";
	dkim-atps=neutral
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93E2510E20F
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 02:20:33 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=G1QUG9uubtkZKNrUSnV+qD2JajwUNppKtuRnRb8xPNk=;
 b=K1Az0G+IgOYrtU30nfOTWUkGDWXkpj9pDzK4YhV3vJuHVCUyldqiUVgWIb5tlqvpWs8PRxvV9
 M8GsIlbYTDNAO2XhEpyCXEwKxR8krFwI6C2q72udF1VSOErZvxN/HmRwodkDIRyhSQhdlkEWXfE
 csez44twmzDIrzSWnFKruTQ=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fd30M1db2zRhQf;
 Sat, 21 Mar 2026 10:14:27 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
 by mail.maildlp.com (Postfix) with ESMTPS id 35EA240569;
 Sat, 21 Mar 2026 10:20:30 +0800 (CST)
Received: from [10.174.179.11] (10.174.179.11) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 21 Mar 2026 10:20:29 +0800
Message-ID: <530b1334-302d-44fb-b180-ddb52cd52115@huawei.com>
Date: Sat, 21 Mar 2026 10:20:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] video: fbdev: matroxfb: Mark variable with
 __maybe_unused to avoid W=1 build break
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, <linux-fbdev@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <llvm@lists.linux.dev>
CC: Helge Deller <deller@gmx.de>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
References: <20260320143646.3218199-1-andriy.shevchenko@linux.intel.com>
From: Jason Yan <yanaijie@huawei.com>
In-Reply-To: <20260320143646.3218199-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.11]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500002.china.huawei.com (7.185.36.57)
X-Mailman-Approved-At: Sat, 21 Mar 2026 09:46:58 +0000
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

在 2026/3/20 22:36, Andy Shevchenko 写道:
> Clang is not happy about set but unused variable:
> 
> drivers/video/fbdev/matrox/g450_pll.c:412:18: error: variable 'mnp' set but not used [-Werror,-Wunused-but-set-variable]
>     412 |                                 unsigned int mnp;
>         |                                              ^
> 1 error generated.
> 
> Since the commit 7b987887f97b ("video: fbdev: matroxfb: remove dead code
> and set but not used variable") the 'mnp' became unused, but eliminating
> that code might have side-effects. The question here is what should we do
> with 'mnp'? The easiest way out is just mark it with __maybe_unused which
> will shut the compiler up and won't change any possible IO flow. So does
> this change.
> 
> Fixes: 7b987887f97b ("video: fbdev: matroxfb: remove dead code and set but not used variable")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> ---
> Cc: Jason Yan <yanaijie@huawei.com>
> ---
> 
> Below is a dive into the history of the driver.
> 
> The problem was revealed when the #if 0 guarded code along with unused
> pixel_vco variable was removed. That code was introduced in the original
> commit 213d22146d1f ("[PATCH] (1/3) matroxfb for 2.5.3"). And then guarded
> in the commit 705e41f82988 ("matroxfb DVI updates: Handle DVI output on
> G450/G550. Powerdown unused portions of G450/G550 DAC. Split G450/G550 DAC
> from older DAC1064 handling. Modify PLL setting when both CRTCs use same
> pixel clocks.").
> 
> NOTE: The two commits mentioned above pre-date Git era and available in
> history.git repository for archaeological purposes.
> 
> Even without that guard the modern compilers may see that the pixel_vco
> wasn't ever used and seems a leftover after some debug or review made
> 25 years ago.
> 
> The g450_mnp2vco() doesn't have any IO and as Jason said doesn't seem
> to have any side effects either than some unneeded CPU processing during
> runtime. I agree that's unlikely that timeout (or heating up the CPU) has
> any effect on the HW (GPU/display) functionality.
> ---
>   drivers/video/fbdev/matrox/g450_pll.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/matrox/g450_pll.c b/drivers/video/fbdev/matrox/g450_pll.c
> index e2c1478aa47f..6a08f78cd1ac 100644
> --- a/drivers/video/fbdev/matrox/g450_pll.c
> +++ b/drivers/video/fbdev/matrox/g450_pll.c
> @@ -409,7 +409,7 @@ static int __g450_setclk(struct matrox_fb_info *minfo, unsigned int fout,
>   		case M_VIDEO_PLL:
>   			{
>   				u_int8_t tmp;
> -				unsigned int mnp;
> +				unsigned int mnp __maybe_unused;
>   				unsigned long flags;
>   
>   				matroxfb_DAC_lock_irqsave(flags);

Reviewed-by: Jason Yan <yanaijie@huawei.com>
