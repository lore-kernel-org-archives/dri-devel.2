Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C19610987A5
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A67510EA4B;
	Fri, 20 Mar 2026 16:33:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="nAUPjFQn";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09EE310EA4B
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 16:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1774024365; x=1774629165; i=deller@gmx.de;
 bh=9fG9TFK5YBYiwlIO4JNLa3f0OU3eRcodXPXEP1JnLCk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=nAUPjFQnZqNSk6pfCncsfwtoET2l6BpyXs6XJX2Z2gCTKmf47+oRQjVHft7cqA1f
 SFB1zB2VXsCFuVES0/zi3eQY/aRZZGXtd87ucfuFdvOBj4w+F3ncLQE0sx3sAu2b/
 l9TIMzJqOtSsAGgvm7kFCRxhoZNUHgcgtJHnEEQeoDytxtFlI2I7hBc7OnjvVugF1
 tayj1440pFOqnWn7AV1bflWKp1f97ni1DvEOwzupjhe809cMXPvZoe9rY0DKa7HTM
 Ce9zPJEYia8Q3WShvuo3Lbw/bRqMKU8+gftqpvt7FhCFBgNsii2iLbjKHWEb8EkJH
 Zz2KlD9ZWroUiRbfZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnpnm-1vFfZ10dCs-00c4XU; Fri, 20
 Mar 2026 17:32:45 +0100
Message-ID: <fa586aeb-a15b-4615-b399-e327dea6cc17@gmx.de>
Date: Fri, 20 Mar 2026 17:32:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] video: fbdev: matroxfb: Mark variable with
 __maybe_unused to avoid W=1 build break
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Cc: Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Jason Yan <yanaijie@huawei.com>
References: <20260320143646.3218199-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260320143646.3218199-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3gzxMWiLSVfO+TBsML0zfYMcIjl4yjZPuz23OCsXImcMtBmQsOC
 Vsi3lmSRQPslP9dPq/THnRvy8W9FW3K0i3OFa9T+NSgmYx6MMrcBo0Mv21uzIuNvtZHxIE4
 zQTXD9zy3Z/CSl0X0aydESy9og8NyJkq10pEqVY38QOLZIU5qYIdduoPFCx2ne4kTDlYF3y
 ZRThL/sp17wGq7roc+6Tg==
UI-OutboundReport: notjunk:1;M01:P0:LGW3KeTOgF4=;wXp7ze3YMtf0NmJbvB7t/uAfun1
 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
 P9qTPT919Rh
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

On 3/20/26 15:36, Andy Shevchenko wrote:
> Clang is not happy about set but unused variable:
>=20
> drivers/video/fbdev/matrox/g450_pll.c:412:18: error: variable 'mnp' set =
but not used [-Werror,-Wunused-but-set-variable]
>     412 |                                 unsigned int mnp;
>         |                                              ^
> 1 error generated.
>=20
> Since the commit 7b987887f97b ("video: fbdev: matroxfb: remove dead code
> and set but not used variable") the 'mnp' became unused, but eliminating
> that code might have side-effects. The question here is what should we d=
o
> with 'mnp'? The easiest way out is just mark it with __maybe_unused whic=
h
> will shut the compiler up and won't change any possible IO flow. So does
> this change.
>=20
> Fixes: 7b987887f97b ("video: fbdev: matroxfb: remove dead code and set b=
ut not used variable")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Helge Deller <deller@gmx.de>

Thanks!
Helge

>=20
> ---
> Cc: Jason Yan <yanaijie@huawei.com>
> ---
>=20
> Below is a dive into the history of the driver.
>=20
> The problem was revealed when the #if 0 guarded code along with unused
> pixel_vco variable was removed. That code was introduced in the original
> commit 213d22146d1f ("[PATCH] (1/3) matroxfb for 2.5.3"). And then guard=
ed
> in the commit 705e41f82988 ("matroxfb DVI updates: Handle DVI output on
> G450/G550. Powerdown unused portions of G450/G550 DAC. Split G450/G550 D=
AC
> from older DAC1064 handling. Modify PLL setting when both CRTCs use same
> pixel clocks.").
>=20
> NOTE: The two commits mentioned above pre-date Git era and available in
> history.git repository for archaeological purposes.
>=20
> Even without that guard the modern compilers may see that the pixel_vco
> wasn't ever used and seems a leftover after some debug or review made
> 25 years ago.
>=20
> The g450_mnp2vco() doesn't have any IO and as Jason said doesn't seem
> to have any side effects either than some unneeded CPU processing during
> runtime. I agree that's unlikely that timeout (or heating up the CPU) ha=
s
> any effect on the HW (GPU/display) functionality.
> ---
>   drivers/video/fbdev/matrox/g450_pll.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/matrox/g450_pll.c b/drivers/video/fbdev=
/matrox/g450_pll.c
> index e2c1478aa47f..6a08f78cd1ac 100644
> --- a/drivers/video/fbdev/matrox/g450_pll.c
> +++ b/drivers/video/fbdev/matrox/g450_pll.c
> @@ -409,7 +409,7 @@ static int __g450_setclk(struct matrox_fb_info *minf=
o, unsigned int fout,
>   		case M_VIDEO_PLL:
>   			{
>   				u_int8_t tmp;
> -				unsigned int mnp;
> +				unsigned int mnp __maybe_unused;
>   				unsigned long flags;
>  =20
>   				matroxfb_DAC_lock_irqsave(flags);

