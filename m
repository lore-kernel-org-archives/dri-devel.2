Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BAAC79FBB
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28B1D10E1DE;
	Thu, 10 Sep 2026 20:02:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="UDngg2zR";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0302210E1DE
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 20:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789070568; x=1789675368; i=deller@gmx.de;
 bh=tAm5057CHlLPrvYsjn+vbColzV5+gZV73fwSOuyscv0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=UDngg2zRhXNQXDDKdSMZJfXJa8ky9IL9ckky788Ahw/9jVk8s50lzRo/An0tWs5k
 pr7CEwXuTv+8m1iwqLSYZRMHd4YyJDfjg1bDWxjNjShZeNbnxFIx/5zGQRZuZtwAG
 N5o8oKGV748xEg9gtIDZqpfc8EPtw6sYpErHSXmGvKC0LABqEvkkSULWkdzUVoREx
 +7FmbeKvL0+rDwl4cnzJrKusZnPZmlLLXYI0lqKNt57cz+8jGkldJ2kIcfUx0c3HM
 BflNduyeZ/TDttZCkLxeRVMP+3jwfu7zNRMM+l+iiYEgCIrGbItQtxhstabsiih75
 DkEXuAsOp9kIqxV5lw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXXuH-1xKXbj1ITv-00WlkN; Thu, 10
 Sep 2026 22:02:48 +0200
Message-ID: <39c574c0-7890-4a91-bbcb-c5038a758514@gmx.de>
Date: Thu, 10 Sep 2026 22:02:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: ssd1307fb: fix NULL pointer dereference on missing
 match data
To: Yang Zi <2959243019@qq.com>, linux-fbdev@vger.kernel.org
Cc: sh_def@163.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <tencent_93CDCEC8A5EA657378E58B59854679079C0A@qq.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <tencent_93CDCEC8A5EA657378E58B59854679079C0A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fm24Q0q53iY+REkPe41eOsnkd+5QbKNql6KuOU0sSjAQzoC+jDG
 SVdJbyMHq8Xx7uOTgSnOwFSAHNsN6QKegznjQR/QYEJ4MI+kwUDhKQCj+zA1VV8yhZRZQ2b
 uraA4U4Cd31rPgJn4P9PDj3ctjGZ4/4XyLDRUnJMiD/xL/8h0cWY7GactGEVcpA+7sAnN3H
 YYifzExRIAqD2UNznTtrw==
UI-OutboundReport: notjunk:1;M01:P0:dpjq3m9C+mA=;xOwyRgK1GLnE91i/1Wktjhno+OE
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

On 8/25/26 10:58, Yang Zi wrote:
> device_get_match_data() can return NULL, e.g. when the device is matched
> through the I2C device ID table rather than the OF match table. The
> returned value is stored in par->device_info and later dereferenced when
> initializing par->vcomh, causing a NULL pointer dereference.
>=20
> Check the return value right after the assignment and bail out with
> -ENODEV (releasing the already allocated framebuffer) before any
> dereference.
>=20
> Signed-off-by: Yang Zi <2959243019@qq.com>

The patch did not apply cleanly. I fixed it up manually and applied it.

Thanks!
Helge

> ---
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd13=
07fb.c
> index c4fdecafd856..4d185c754284 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -665,6 +665,10 @@ static int ssd1307fb_probe(struct i2c_client *clien=
t)
>  =C2=A0 =C2=A0 =C2=A0spin_lock_init(&par->damage_lock);
>  =20
>  =C2=A0 =C2=A0 =C2=A0par->device_info =3D device_get_match_data(dev);
> +=C2=A0 =C2=A0 if (!par->device_info) {
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENODEV;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fb_alloc_error;
> +=C2=A0 =C2=A0 }
>  =20
>  =C2=A0 =C2=A0 =C2=A0par->reset =3D devm_gpiod_get_optional(dev, "reset"=
, GPIOD_OUT_LOW);
>  =C2=A0 =C2=A0 =C2=A0if (IS_ERR(par->reset)) {
>=20

