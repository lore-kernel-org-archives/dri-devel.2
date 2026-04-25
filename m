Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCC8FF885D
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 08:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5AD110E0D6;
	Sat, 25 Apr 2026 08:09:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="s+Ew48MY";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5FE010E0D6
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 08:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1777104496; x=1777709296; i=deller@gmx.de;
 bh=vT6Teb+ASL+1GBiJZvIY7+1CNDHTj39LDZzxjAYW3j8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=s+Ew48MYYcHO9N2nk2SmlH1dZ51iAE1n1YjuxeyiNmK5gil86oqj7B1QfUyN8rAx
 iDlBgPzliNfYbh4ZqzDmgdwaqfZuaJ5hA7343guE8nPqIUq5LFo8vuuWdzbvvgVtE
 f3wPwjr9mgWZ+hbMoG5VCYbSKuUK5bj0Y+WZzZIQstXAE7HXFs/gEZgAHDjuosEDG
 dSwYq4FR4MBug/nRswAP2fzirGKkdZORp3oQp+EvopiAlafJjTF5F+/I1d9WEYHzN
 m7QoeSdZswx4YIay/8Vb7cKMWuyngBh9isysklGS4uukWGGN73dbl9fUeZbsCw15i
 Xir/EfhbWk9HIjd0AQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHAB-1vkVIJ0h7z-00i59p; Sat, 25
 Apr 2026 10:08:16 +0200
Message-ID: <ccd01f97-d4b7-4bd0-92c1-adc3b1136cbc@gmx.de>
Date: Sat, 25 Apr 2026 10:08:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/35] fbdev: sisfb: Use safer strscpy() instead of
 strcpy()
To: Ai Chao <aichao@kylinos.cn>, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 linux@armlinux.org.uk, dilinger@queued.net, adaplas@gmail.com,
 James.Bottomley@HansenPartnership.com, FlorianSchandinat@gmx.de,
 alchark@gmail.com, krzk@kernel.org, kees@kernel.org, rene@exactco.de,
 tzimmermann@suse.de, rongqianfeng@vivo.com, thorsten.blum@linux.dev,
 chelsyratnawat2001@gmail.com, soci@c64.rulez.org,
 gregkh@linuxfoundation.org, daniel@thingy.jp, linmq006@gmail.com,
 fourier.thomas@gmail.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-geode@lists.infradead.org, linux-parisc@vger.kernel.org
References: <20260425065926.1091168-1-aichao@kylinos.cn>
 <20260425065926.1091168-4-aichao@kylinos.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260425065926.1091168-4-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Aif+/53ov6KCti++kXRxG73XClrNoNo5bylJbNAgD6WUrReYCdy
 jRidHYzfOkBCqtk0ptP1hIgM6uNKXc8x6M/RsoxltGrCIGJU24wtrIjku148i5Y2yk71bi0
 8FjNuElk79RJsiVS+3hTZBwa7Z48i2y0dHbwSyDZETh6WD2VuW38qHyP4B9Bsb2rz3LaYmw
 9yzDp2gdJrgFZ+6i9SXrA==
UI-OutboundReport: notjunk:1;M01:P0:k0zm8/hG+ms=;RPO6RGuU3q8Cs8eOkd0YrzJbo81
 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
 fv3gPA+HA7DB0SQ==
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

Hello Ai,

Thanks that you want to contribute!

But your series isn't beneficial in most areas.
Some examples:

On 4/25/26 08:58, Ai Chao wrote:
> Use a safer function strscpy() instead of strcpy() for copying to arrays=
.
>=20
> Only idiomatic code replacement, and no functional changes.
>=20
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
>   drivers/video/fbdev/sis/sis_main.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/si=
s/sis_main.c
> index 84567d67f71d..e87fa261f76c 100644
> --- a/drivers/video/fbdev/sis/sis_main.c
> +++ b/drivers/video/fbdev/sis/sis_main.c
> @@ -205,7 +205,7 @@ static void sisfb_search_mode(char *name, bool quiet=
)
>   	}
>  =20
>   	if(strlen(name) <=3D 19) {
> -		strcpy(strbuf1, name);
> +		strscpy(strbuf1, name);

We have strbuf1[20] above, and the length is checked.
There is no benefit of using strscpy() here.
(The code could be cleaned up in other ways though).

>   		for(i =3D 0; i < strlen(strbuf1); i++) {
>   			if(strbuf1[i] < '0' || strbuf1[i] > '9') strbuf1[i] =3D ' ';
>   		}
> @@ -5947,33 +5947,33 @@ static int sisfb_probe(struct pci_dev *pdev, con=
st struct pci_device_id *ent)
>   #ifdef CONFIG_FB_SIS_300
>   		case PCI_DEVICE_ID_SI_730:
>   			ivideo->chip =3D SIS_730;
> -			strcpy(ivideo->myid, "SiS 730");
> +			strscpy(ivideo->myid, "SiS 730");

The compiler knows at build time the length of myid, and the "SIS 730" str=
ing.
Using strscpy() has no benefit here either. Contrary, the code generated
because of using strscpy() is probably even larger.
Don't replace such code with strscpy().


=2D-- a/drivers/video/fbdev/i810/i810-i2c.c
+++ b/drivers/video/fbdev/i810/i810-i2c.c
@@ -91,7 +91,7 @@ static int i810_setup_i2c_bus(struct i810fb_i2c_chan *ch=
an, const char *name)
  {
          int rc;
 =20
-        strcpy(chan->adapter.name, name);
+	strscpy(chan->adapter.name, name);

Here it might make sense to use strscpy(), but it should be checked manual=
ly
and not using scripts to simply replace code.

That said: Thanks for your patches, but as-is I won't take them.

Helge
