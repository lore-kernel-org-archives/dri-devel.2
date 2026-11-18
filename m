Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5ED606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=ltrRdYch
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D86CF10FF09;
	Wed, 18 Nov 2026 18:04:42 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53E0210FF09
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:04:36 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795025074; mf=PGRlbGxlckBnbXguZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:A26pJmN/MZMJbS3ltfxDCocAzO6K
 9ja9SQp4//MQT3Y1Aaz5lGq7BViuqi12lp26Vg4S6i55drud5N6mZNC+K4nE42YReHOBY428PUK
 ym89j1bMx+4/JWs5ohw+9kAaiywJrGY1m1EADFeeeFh5KznQ9EguDMi8ccRUZ1dkSoUNyo/Dwn6
 Rcsydk/fJqmXmWm7VtIUFUCxaj/G4pZo/bCYzEZo40MHL3eDXvBTfaMSujf0yjKRXOCE3KuBNgv
 co1NuXVyIb8GShL9SYAPa9PjY+zovDO7Q2/0J5lp2R+SdcwdW9GLYBf22oNAmJiBiAMrL+SQHD9
 bEKiqEcDfPM9dA==;
Message-Instance: m=1; h=sha256: WfmSE8pKLYUAh43jIiAz2SMqraq0Z/4XQFA6zXufBE4=:
 41ZnElYY6+AL90fW1aKCjH6xMdxxY/zNy1GjqbP7c8A=, sha512:
 jX5Pt70erHTnjTES5vytxgCI+8qIaJlkkbH0uRbUwHm3Hwlxwq/Os74Ohom2XLd4fwUpNFvVLzREaTdhuwTSFA==:
 hWxMDdlD7HDkF5Scf9keq+16QOYciEg+pu2GSdD+EkRoC28YdiJJl5IYixJcHYNUQmZ9GcDdE0vqLJTyLf2fHA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795025074; x=1795629874; i=deller@gmx.de;
 bh=K4MPQbQ3rG+e04E19pMqg3pAzGOtyLyFvk9MoET+sJY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ltrRdYchbU/EyqZiS4wE6+wB/SKqRvqRl2UHxxX335wXMbzz77DLtowl5zAAF2CG
 z2OwK55zYdrwe+4lghra7aWcjkCsCvyTU8JUWOGBaopi8L59k5k4lbGJ5JBNXrR18
 yM9KvJXZWj+/PiczHAz48HpKClHe7dv7Xgaiudp2knirCURr17LbQUYPhq9Krgg25
 qMFMZYW+F32+3vuL9bVKCZhEdRsyG8TIvKVEqKMhGPp37r0smGNFQUOiCz/CntmQ+
 LzuwV0XOL/XRQ5AvzVF10+d5miKE8Ubyuu5MnNWLm4IUdJUT5Vq12TTh8YRZnfDO3
 x/y7SfTzRddeyE2igw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UUy-1xUIFc2hIA-006xZ5; Wed, 18
 Nov 2026 19:04:34 +0100
Message-ID: <d734924c-6083-405d-8ef8-d0d522d6a187@gmx.de>
Date: Wed, 18 Nov 2026 19:04:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: Linux kernel regression: full screen logo
To: Roosen Henri <Henri.Roosen@ginzinger.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <074e66817a069dca965d9c258606f23fbcb2e1a3.camel@ginzinger.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <074e66817a069dca965d9c258606f23fbcb2e1a3.camel@ginzinger.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CdAZtFkCS++dIujgYOfPc33FibQbsEDg80UH/oR95NvncVw+YCR
 lTHNqM3TtLKNt94MjEH8VVsPlWd1e/wV3NU54vqf95+Fog3zDJ5GQOoC9qPIRHozer1Sccv
 NxyyheR4PLxZHO+mg28oUE5A1KSkh3niA02Q4UgTAE3un5wMfcGSMafYLH0WkITAOgwo5Be
 TJuimkouB5GwpB0mmzA9Q==
UI-OutboundReport: notjunk:1;M01:P0:1I0kyM8uXWA=;PJXg0XPMZfz2gdHb3P+7hLfZooY
 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
 rQo=
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 15:23, Roosen Henri wrote:
> Hello Helge, hello Sasha,
>=20
> I have been bisecting the linux kernel for a regression, were a white
> stripe occurs at the bottom of the display, when showing the bootlogo.
>=20
> The bisect ended up at commit-582a89109ad9 ("fbcon: Fix KASAN slab-out-
> of-bounds Read in fbcon_prepare_logo") on a v6.18.x kernel, [ Upstream
> commit 94e6a058b16820e02f25e1221a4c4e713ba23550 ].
>=20
> We use a custom bootlogo exactly full-screen. With your commit we get a
> white bar at the bottom, which i think is about the size of the font-
> height.
>=20
> Our logo file has 800x480:
>=20
>    file logo_clut224.ppm
>    logo_clut224.ppm: Netpbm image data, size =3D 800 x 480, pixmap, ASCI=
I
> text
>=20
> And the target framebuffer has the same 800x480 size:
>=20
>    # cat /sys/class/graphics/fb0/virtual_size
>    800,480
>=20
> The logo does not exceed the screen size, still your patch introduces
> this regression.
>=20
> I'm happy to test a possible solution.

can you test this (completely untested!) patch:

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/f=
bcon.c
index d7890e119dc7..2809c7a6893f 100644
=2D-- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -666,7 +666,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, str=
uct fb_info *info,
         logo_height =3D fb_prepare_logo(info, par->rotate);
         logo_lines =3D DIV_ROUND_UP(logo_height, vc->vc_font.height);
         logo_lines =3D min(logo_lines, rows);
-       logo_lines =3D min(logo_lines, new_rows - 1);
+       logo_lines =3D min(logo_lines, new_rows);
         if (logo_lines <=3D 0) {
                 logo_lines =3D 0;
                 logo_shown =3D FBCON_LOGO_DONTSHOW;

Helge
