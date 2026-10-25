Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0F2606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 19:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=mkE/kEOH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B77DB10E215;
	Sun, 25 Oct 2026 19:43:34 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A2BA10E215
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 19:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792957406; x=1793562206; i=deller@gmx.de;
 bh=Qx0XNMDJKOmw5j//coeVgL5VSOXtSCf5PwOpyQrmoyI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=mkE/kEOHGPLtZJStqXfs/0pQurA+aaKo7nEvqjhf9VNnluRcTqUeP7H1qugoynce
 UmBM6SQTqNAaGIiMhBkkMfT9W3EnDnpPi07XOKsPBZh5dGG4V62QpEfqCAfHH5+BJ
 D3t2c6tKjEb2Q+wRWp2iC1K1gZEDMivs+Gd7oM7mnO/oCS0rFqfqWgcC3Sxf7a81M
 L3rVXs7J+sCHd8YESKf32yuDRpcv46O6I/hd2g91e1Kt3AK411NtlzArMs3w5htsN
 kanC+BXx5ooWlp44e4TTTEf7nlMiTIlPjCACBmAzN3rcNta4/tSdwb763eBaWscXH
 KOiq0E9YvuuaXGUZ2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUGiJ-1xBxFo2j7D-00PcZV; Sun, 25
 Oct 2026 20:38:03 +0100
Message-ID: <f5a860e9-7b8f-400c-8d30-44f62e5129b8@gmx.de>
Date: Sun, 25 Oct 2026 20:38:00 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: vfb: Validate framebuffer geometry and memory size
To: Weiming Shi <bestswngs@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, co+b0df61d49532b2ee@bugs.sh,
 Xiang Mei <xmei5@asu.edu>
References: <20261023175128.4127122-2-bestswngs@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261023175128.4127122-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZpvnxpYgYxTsCsIaU8oBBpTKNdKPqaLP+hWsu87qPYs/ZOoQhbx
 sruM/rKXV2nuQO55eWY7OgoWAbgTLpHqmMB6mOv7UzUOvpIj1NBXCmEnkqxvvo+U7UJA5Ec
 VnOD/gVHZs/VSLLmJ2egPSyr2p7gcpQq0mZvpgr4yE+ZLA0dZro2v7wIvzrG6q0Eo+q2JgE
 q7xDoxG7mVg3FyadQvDNw==
UI-OutboundReport: notjunk:1;M01:P0:s/qIAT87osE=;wTH8CjrIoV5fDrJG2c3jkMN9J/f
 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
 j2DeZQOt3zF4=
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 19:51, Weiming Shi wrote:
> get_line_length() multiplies two int operands before assigning the
> result to u_long. Setting xres_virtual to 0x8000000 at 32 bpp therefore

A xres_virtual value of 134217728 seems quite unrealistic IMHO...

> wraps the product to zero and bypasses vfb_check_var()'s video-memory
> limit. fbcon can then clear margins with a zero line stride and write
> past the vmalloc'ed framebuffer.
>=20
> The xoffset + xres and yoffset + yres calculations can likewise wrap,
> leaving an invalid offset in info->var after fb_pan_display() rejects
> it. Subsequent fbcon drawing can then access far beyond the framebuffer.
>=20
> Finally, PAGE_ALIGN(videomemorysize) was narrowed from unsigned long to
> unsigned int. Values near or above 4 GiB could therefore allocate a much
> smaller buffer than the size used for mode validation.
>=20
> KASAN reports:
>=20
>    BUG: KASAN: vmalloc-out-of-bounds in sys_fillrect
>      drivers/video/fbdev/core/sysfillrect.c:24
>    Write of size 8 at addr ffa0000001671000 by task poc/198
>    sys_fillrect
>      drivers/video/fbdev/core/sysfillrect.c:24
>    bit_clear_margins
>      drivers/video/fbdev/core/bitblit.c:247
>    fbcon_clear_margins.constprop.0
>      drivers/video/fbdev/core/fbcon.c:1410
>    fbcon_switch
>      drivers/video/fbdev/core/fbcon.c:2261
>    redraw_screen
>      drivers/tty/vt/vt.c:994
>    fbcon_modechanged
>      drivers/video/fbdev/core/fbcon.c:2693
>    fbcon_update_vcs
>      drivers/video/fbdev/core/fbcon.c:2732
>=20
> Reject video-memory sizes whose aligned value is not representable by
> the fbdev metadata. Check the offset additions for overflow. Compute the
> line length and framebuffer size in u64, reject unrepresentable line
> lengths, and check the total-size multiplication before comparing it
> with the allocated video-memory size.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: <co+b0df61d49532b2ee@bugs.sh>
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>   drivers/video/fbdev/vfb.c | 31 +++++++++++++++++++++----------
>   1 file changed, 21 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
> index de137b2bd..84b0a937c 100644
> --- a/drivers/video/fbdev/vfb.c
> +++ b/drivers/video/fbdev/vfb.c
> @@ -101,11 +101,11 @@ static const struct fb_ops vfb_ops =3D {
>        *  Internal routines
>        */
>  =20
> -static u_long get_line_length(int xres_virtual, int bpp)
> +static u64 get_line_length(u32 xres_virtual, u32 bpp)


Instead of trying to extend to 64bit, I think we should simply
limit the maximum allowed screen sizes to e.g. 4096 x 4096
(or some other realistic values).


>   {
> -	u_long length;
> +	u64 length;
>  =20
> -	length =3D xres_virtual * bpp;
> +	length =3D (u64)xres_virtual * bpp;
>   	length =3D (length + 31) & ~31;
>   	length >>=3D 3;
>   	return (length);
> @@ -122,7 +122,8 @@ static u_long get_line_length(int xres_virtual, int =
bpp)
>   static int vfb_check_var(struct fb_var_screeninfo *var,
>   			 struct fb_info *info)
>   {
> -	u_long line_length;
> +	u64 line_length, size;
> +	u32 xres, yres;
>  =20
>   	/*
>   	 *  FB_VMODE_CONUPDATE and FB_VMODE_SMOOTH_XPAN are equal!
> @@ -159,17 +160,23 @@ static int vfb_check_var(struct fb_var_screeninfo =
*var,
>   	else
>   		return -EINVAL;
>  =20
> -	if (var->xres_virtual < var->xoffset + var->xres)
> -		var->xres_virtual =3D var->xoffset + var->xres;
> -	if (var->yres_virtual < var->yoffset + var->yres)
> -		var->yres_virtual =3D var->yoffset + var->yres;
> +	if (check_add_overflow(var->xoffset, var->xres, &xres) ||
> +	    check_add_overflow(var->yoffset, var->yres, &yres))
> +		return -EINVAL;
> +
> +	if (var->xres_virtual < xres)
> +		var->xres_virtual =3D xres;
> +	if (var->yres_virtual < yres)
> +		var->yres_virtual =3D yres;
>  =20
>   	/*
>   	 *  Memory limit
>   	 */
>   	line_length =3D
>   	    get_line_length(var->xres_virtual, var->bits_per_pixel);
> -	if (line_length * var->yres_virtual > videomemorysize)
> +	if (line_length > U32_MAX ||
> +	    check_mul_overflow(line_length, (u64)var->yres_virtual, &size) ||
> +	    size > videomemorysize)
>   		return -ENOMEM;
>  =20
>   	/*
> @@ -434,9 +441,13 @@ static int __init vfb_setup(char *options)
>   static int vfb_probe(struct platform_device *dev)
>   {
>   	struct fb_info *info;
> -	unsigned int size =3D PAGE_ALIGN(videomemorysize);
> +	unsigned int size;
>   	int retval =3D -ENOMEM;
>  =20
> +	if (videomemorysize > U32_MAX - (PAGE_SIZE - 1))
> +		return -EINVAL;
> +	size =3D PAGE_ALIGN(videomemorysize);

same here.
There doesn't seem to be a maximum limit for videomemorysize.
Maybe adding a check and allow a maximum of e.g. 512MB ?

Will you send a revised patch?

Helge
