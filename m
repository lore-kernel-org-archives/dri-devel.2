Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58234CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 21:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59ED410EB86;
	Fri, 12 Jun 2026 21:33:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="BiGgYEAD";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D6210EB78
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 21:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781300026; x=1781904826; i=deller@gmx.de;
 bh=j3TiMY4DGke4mkQII88ZAQk912LMh+Ix9Xf+VDWYDzw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=BiGgYEADqNFd2sanJHWUg9qYjHh2NQaS20lLZPlHibOezvEoFcHTTYF12ZfINIto
 /2YoyOjVx9PXgPBIvs/8inxhJArdwCC+1O0m67Us9IisA0Ijd+b4AO8HFUwsmclg+
 FP5xRcs8Pn+nPmRbM8eVBE5OGDm4n5MEAxqFQ+Q3VlATJTA72llEIfu81LEU9+r6Y
 o2cWO9BxIXGMy/9FP+CD/25CuMLDUGYHjBmBD1FX3HLpnMkGIqwAcnhUZIYLYfkWI
 HndUH36RQTHdRmoM0p9iTx1eQ4GTgyTTpwxTuVf9n3LIEMoBKhJ86bejhPfwO7PF2
 UF6ESYkWD0sGqWQgtQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3lYB-1wYySH0YQl-00BWQI; Fri, 12
 Jun 2026 23:33:46 +0200
Message-ID: <9df39aa0-4bac-4479-87d3-667c8dd8000a@gmx.de>
Date: Fri, 12 Jun 2026 23:33:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: claim Cyber2000 SPARC I/O aperture before ioremap
To: Chintan Patel <chintanlike@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux@armlinux.org.uk
References: <20260611035243.16192-1-chintanlike@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260611035243.16192-1-chintanlike@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ixCzwIyoHb4dnz7XIIfSUaFbvDpOR0lU5iC5L8Ma6fhpQ0tEhLN
 fZZTbCshdJ7FKAuzFtjLEoKZopJTnUMuXog8jzq7pzkhDNELFrRHL0JAeovBDQorq99A20C
 GJTTbu93pPaneTQUcf8uLD5uGQT3yDiQ9b/HiYUO62KXomPja2M2JHqF/u9iEdDeU4CG74W
 RzDwMnRPrQGoIzTJumduA==
UI-OutboundReport: notjunk:1;M01:P0:wSNy+LpMrTc=;y30O3vYAb3XunOhXn6CyxZUFpiS
 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
 tT6IXCbmCzJG1mWctS6X1/Epyck=
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

On 6/11/26 05:52, Chintan Patel wrote:
> Claim the memory resource associated with the Cyber2000 SPARC MMIO
> aperture before accessing it.
>=20
> This is part of the effort to request memory regions in fbdev drivers.
>=20
> Signed-off-by: Chintan Patel <chintanlike@gmail.com>
> ---
>   drivers/video/fbdev/cyber2000fb.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyb=
er2000fb.c
> index 2d12f8e96c7e..16ed56180ce2 100644
> --- a/drivers/video/fbdev/cyber2000fb.c
> +++ b/drivers/video/fbdev/cyber2000fb.c
> @@ -47,6 +47,7 @@
>   #include <linux/io.h>
>   #include <linux/i2c.h>
>   #include <linux/i2c-algo-bit.h>
> +#include <linux/ioport.h>
>  =20
>   #ifdef __arm__
>   #include <asm/mach-types.h>
> @@ -1620,9 +1621,14 @@ static int cyberpro_pci_enable_mmio(struct cfb_in=
fo *cfb)
>   	 */
>   	unsigned char __iomem *iop;
>  =20
> +	if (!request_mem_region(0x3000000, 0x5000, "cyber2000fb iop")) {
> +		printk(KERN_ERR "iga5000: cannot reserve I/O area 0x3000000\n");

pci_err() or pr_err() please.

> +		return -EBUSY;
> +	}
>   	iop =3D ioremap(0x3000000, 0x5000);
>   	if (iop =3D=3D NULL) {
>   		printk(KERN_ERR "iga5000: cannot map I/O\n");

while at it, use pci_err() here too then.

Helge
