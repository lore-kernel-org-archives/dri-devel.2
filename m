Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2D3C982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 11:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A06310E356;
	Wed, 23 Sep 2026 11:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JfwNsnSJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 531FF10E356
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 11:23:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 89040600AA;
 Wed, 23 Sep 2026 11:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247491F000FF;
 Wed, 23 Sep 2026 11:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790162592;
 bh=LQ8zpcYLHlC/xHOUgHpHFt33WgSiUzGFFjBEuuxh4rM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=JfwNsnSJ7b2IUUacwbm8HxGoXi2ST5ryLkbkJoGFyg2NrcZzbBvHu+BOvzzgs2B8q
 Z9ZYRgwUSU/xXKV5mpjdp14Nf3LC9SI4oeo9xRYE9GkTQoEPs+UotwFtXz8jpg9fzE
 fBatJXDhI3YswO2favtKZbaUpakGNE0uWXbZ01m7WsYfnfgvjGEb5X4Do03dz4yrPz
 WiZJPZfKX1vaNoIcrTdE+tSwo7Ulc2pH0MJF02szyzzM8Otxm/Zg+H3sx4eUm3kEww
 IjbDz6RgvIviP+tZCBDTY8mAQJbWafG1OOLbrphrYdXFV32iIDJUuI/DFTu3AwLcpU
 ZNfzcSdhrsdJw==
Message-ID: <385341aa-db86-4f22-851f-85c0e6a0ca89@kernel.org>
Date: Wed, 23 Sep 2026 13:23:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video/logo: Improve logo help texts
To: Geert Uytterhoeven <geert+renesas@glider.be>, Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <024a2d7e9a6b63d261f6ca4afb1a75d4f540defa.1790154481.git.geert+renesas@glider.be>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <024a2d7e9a6b63d261f6ca4afb1a75d4f540defa.1790154481.git.geert+renesas@glider.be>
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

On 23/09/2026 at 11:09, Geert Uytterhoeven wrote:
> Since commit dfa6ce636cb8faea ("video/logo: allow custom logo"), the
> LOGO_LINUX_{MONO,VGA16,CLUT224} configuration options no longer control
> the inclusion of the "standard" Linux logo, but the inclusion of
> (possibly custom) logos specified through the correspondig *_FILE
                                                ^^^^^^^^^^^^
Typo: corresponding (missing 'n')

> options.
> 
> Adjust the one-line prompt to reflect this.
> Add long help texts while at it.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

I added some comments, but notwithstanding of these:

Acked-by: Vincent Mailhol <mailhol@kernel.org>

> ---
>  drivers/video/logo/Kconfig | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
> index cda15b95891ed3a8..3cb66ac88d6be0fe 100644
> --- a/drivers/video/logo/Kconfig
> +++ b/drivers/video/logo/Kconfig
> @@ -19,7 +19,11 @@ config FB_LOGO_EXTRA
>  	default y if SPU_BASE
>  
>  config LOGO_LINUX_MONO
> -	bool "Standard black and white Linux logo"
> +	bool "Black and white Linux logo"
> +	help
> +	  Include a monochrome (black and white) Linux logo.
> +	  This logo can be shown on all kinds of displays.
> +	  Say Y to show a logo on monochrome displays.
>  
>  config LOGO_LINUX_MONO_FILE
>  	string "Monochrome logo .pbm file"
> @@ -36,7 +40,13 @@ config LOGO_LINUX_MONO_FILE
>  	    magick source_image -compress none destination.pbm
>  
>  config LOGO_LINUX_VGA16
> -	bool "Standard 16-color Linux logo"
> +	bool "16-color Linux logo"
> +	help
> +	  Include a 16-color Linux logo.
> +	  This logo can be shown on displays that support showing (at least)
> +	  the standard VGA 16 color palette.
> +	  Say Y to show a logo on color displays that are limited to less than
> +	  256 colors.

Maybe state that if supported, this takes precedence on the monochrome logo.

>  config LOGO_LINUX_VGA16_FILE
>  	string "16-color logo .ppm file"
> @@ -55,8 +65,13 @@ config LOGO_LINUX_VGA16_FILE
>  	      -remap drivers/video/logo/clut_vga16.ppm destination.ppm
>  
>  config LOGO_LINUX_CLUT224
> -	bool "Standard 224-color Linux logo"
> +	bool "224-color Linux logo"
>  	default y
> +	help
> +	  Include a 224-color Linux logo.
> +	  This logo can be shown on displays that support showing a palette of
> +	  256 or more colors.
> +	  Say Y to show a logo on colorful displays.

Same, if supported, it takes precedence on the two other logo types.

>  config LOGO_LINUX_CLUT224_FILE
>  	string "224-color logo .ppm file"


Yours sincerely,
Vincent Mailhol

