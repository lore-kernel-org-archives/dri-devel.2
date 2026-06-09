Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011F3CD8CB9
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:07:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BFC410E4A2;
	Tue,  9 Jun 2026 16:07:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="ryo3FO5c";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62B9810E4A2
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 16:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781021273; x=1781626073; i=deller@gmx.de;
 bh=ftVLuu9d9bBlZMCLhwZXSMNuCcuPEesh0EXH/0cj8dw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ryo3FO5cl4YGAzDmsNyl1i28+lEF+MuhUrmHlP3gznu6D2tswMz6G4QPf6KOFYoq
 N9HJePlqzDLRW7lXvYI0j7ZZHhyEFOJcB4dUl9axSooBJLSHjBNTg8QbFQE10I/c0
 24tvEHKDNHMdflqQdj1L7Rdp0/V9yBLuK2Vt1r0xDyTQ7laO6g63Z+GarGr7Nfhpo
 5vDE3sp6y3JqpByEu9hcoBjcG4gOl0YJAy9oL6QJZNfqaW/crVktQvOEtoR64hegV
 0XbBGeqpg19VAHOkGzWmKGZ1A9kff5Mpov0hWyzmJfaK7uSgl03T+RMd32ndEXvef
 2/0vuj6PWe7VUkiQKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVN6t-1whkDu2Vzr-00PPCl; Tue, 09
 Jun 2026 18:07:53 +0200
Message-ID: <20c805e5-3d31-4691-a691-0e535fc14e56@gmx.de>
Date: Tue, 9 Jun 2026 18:07:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: modedb: keep mode option buffer until parsing
 completes
To: Ruoyu Wang <ruoyuw560@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260609160028.5-1-ruoyuw560@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260609160028.5-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wyWeAV0seBgS4tgYSx073fzTa2D9BpvZLrvSl0OL44wEAmXmMmg
 S3iW0dXUVrMtXL9VRHCQJA9d9p4/5PQKcFvmP+kQQ2uq+9WUSSaRZhvPCrGVYiGiUwlUUkU
 6JXU06DlVxVRwm3nFFiEGtV//DJrZu845fs3T8cXkRkpHnJE/Wrc/gvs5qY7uIvpaVkX8I6
 E8h9bh04Nllt5kGZ0MNaw==
UI-OutboundReport: notjunk:1;M01:P0:ncGYuOlfoPc=;Bwy0M0a56YfWRghUY9WaegMK9dP
 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
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

On 6/9/26 18:00, Ruoyu Wang wrote:
> When fb_find_mode() obtains the mode option from fb_get_options(),
> mode_option_buf owns the returned string and name points into that
> buffer. The done label frees mode_option_buf before the database
> fallback has finished using name in name_matches(), so the fallback can
> read freed memory.
>=20
> Move the free to a common exit path and convert the successful returns
> that can use mode_option_buf into jumps to that exit path.

There was another similiar patch already posted:
https://patchwork.kernel.org/project/linux-fbdev/patch/20260526091507.4217=
30-1-islituo@gmail.com/

Do you want to check if the Scope-based kfree can be used here,
as suggested by me in that thread? It's at least much smaller than your pa=
tch...

Helge


>=20
> Fixes: 089d924d03d5 ("fbdev: Read video=3D option with fb_get_option() i=
n modedb")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>   drivers/video/fbdev/core/modedb.c | 41 ++++++++++++++++++++-----------
>   1 file changed, 26 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/cor=
e/modedb.c
> index 703d0b7aec322..82f6ea38e1fb8 100644
> --- a/drivers/video/fbdev/core/modedb.c
> +++ b/drivers/video/fbdev/core/modedb.c
> @@ -627,7 +627,7 @@ int fb_find_mode(struct fb_var_screeninfo *var,
>   		 unsigned int default_bpp)
>   {
>   	char *mode_option_buf =3D NULL;
> -	int i;
> +	int i, ret;
>  =20
>   	/* Set up defaults */
>   	if (!db) {
> @@ -724,10 +724,9 @@ int fb_find_mode(struct fb_var_screeninfo *var,
>   			res_specified =3D 1;
>   		}
>   done:
> -		kfree(mode_option_buf);
>   		if (cvt) {
>   			struct fb_videomode cvt_mode;
> -			int ret;
> +			int cvt_ret;
>  =20
>   			DPRINTK("CVT mode %dx%d@%dHz%s%s%s\n", xres, yres,
>   				(refresh) ? refresh : 60,
> @@ -745,11 +744,12 @@ int fb_find_mode(struct fb_var_screeninfo *var,
>   			else
>   				cvt_mode.vmode &=3D ~FB_VMODE_INTERLACED;
>  =20
> -			ret =3D fb_find_mode_cvt(&cvt_mode, margins, rb);
> +			cvt_ret =3D fb_find_mode_cvt(&cvt_mode, margins, rb);
>  =20
> -			if (!ret && !fb_try_mode(var, info, &cvt_mode, bpp)) {
> +			if (!cvt_ret && !fb_try_mode(var, info, &cvt_mode, bpp)) {
>   				DPRINTK("modedb CVT: CVT mode ok\n");
> -				return 1;
> +				ret =3D 1;
> +				goto out;
>   			}
>  =20
>   			DPRINTK("CVT mode invalid, getting mode from database\n");
> @@ -793,8 +793,10 @@ int fb_find_mode(struct fb_var_screeninfo *var,
>   				if (!interlace_specified ||
>   				    db_interlace =3D=3D interlace)
>   					if (refresh_specified &&
> -					    db[i].refresh =3D=3D refresh)
> -						return 1;
> +					    db[i].refresh =3D=3D refresh) {
> +						ret =3D 1;
> +						goto out;
> +					}
>  =20
>   				if (score < diff) {
>   					diff =3D score;
> @@ -804,7 +806,8 @@ int fb_find_mode(struct fb_var_screeninfo *var,
>   		}
>   		if (best !=3D -1) {
>   			fb_try_mode(var, info, &db[best], bpp);
> -			return (refresh_specified) ? 2 : 1;
> +			ret =3D (refresh_specified) ? 2 : 1;
> +			goto out;
>   		}
>  =20
>   		diff =3D 2 * (xres + yres);
> @@ -831,21 +834,29 @@ int fb_find_mode(struct fb_var_screeninfo *var,
>   		}
>   		if (best !=3D -1) {
>   			fb_try_mode(var, info, &db[best], bpp);
> -			return 5;
> +			ret =3D 5;
> +			goto out;
>   		}
>   	}
>  =20
>   	DPRINTK("Trying default video mode\n");
> -	if (!fb_try_mode(var, info, default_mode, default_bpp))
> -		return 3;
> +	if (!fb_try_mode(var, info, default_mode, default_bpp)) {
> +		ret =3D 3;
> +		goto out;
> +	}
>  =20
>   	DPRINTK("Trying all modes\n");
>   	for (i =3D 0; i < dbsize; i++)
> -		if (!fb_try_mode(var, info, &db[i], default_bpp))
> -			return 4;
> +		if (!fb_try_mode(var, info, &db[i], default_bpp)) {
> +			ret =3D 4;
> +			goto out;
> +		}
>  =20
>   	DPRINTK("No valid mode found\n");
> -	return 0;
> +	ret =3D 0;
> +out:
> +	kfree(mode_option_buf);
> +	return ret;
>   }
>  =20
>   /**

