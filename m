Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3840CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0946B10E9B4;
	Tue, 23 Jun 2026 07:57:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="AMGOGFw6";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3F2B10E9B4
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 07:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782201465; x=1782806265; i=deller@gmx.de;
 bh=vX+n1HuIvQeayxTpfdi0oQyxZ+JxhtPTNJJ887iqH3o=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=AMGOGFw6ggvtL5Hy6FknGD/S4NyHhReGY2n91oF7jZIvrzwxp2AZlsIpBcfs6fYP
 Aro12lj/b85IW160bLslQ3n97L+cAksP2ITLFjbpHiXmk7ZKGH7MbCZT7XZTx82KF
 7RsKrsigSoHrG9ov2d2/UPgofVcjxCIA60pIIHs2ZgzcS2zCUX4ym3f+Gp7myV1PI
 utxgNx7ygMQSZVSpfhzVQQHl73GXXfXhAiw7UyI7nMOFenWDticOxWYpm0mjKzHxM
 ZlHXvTrCCBVavcTHDQzLzy+r167ivXFh/9gAapLH1bCTm00r7J6cettjtrValaB4m
 YjNgYOKtOc6HhyLmKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4JqV-1wcD842n9V-003mMD; Tue, 23
 Jun 2026 09:57:45 +0200
Message-ID: <5879368e-1a91-4d4d-9243-dd9de9d06962@gmx.de>
Date: Tue, 23 Jun 2026 09:57:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fbdev: claim Cyber2000 SPARC I/O aperture before
 ioremap
To: Chintan Patel <chintanlike@gmail.com>, linux@armlinux.org.uk
Cc: tzimmermann@suse.de, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260616043035.11952-1-chintanlike@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260616043035.11952-1-chintanlike@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9NCW7r7fJNPMlgx1c0j6kAcD2OXci90sKQ5tmHr9HS6kFX9C9mi
 7ToLhM5Ht6tc7HHfP9RGpewdo/RbVA2awFwbYrJ/B1COY54X+OaJqJ+jNO4Bd7YqCqNUqfV
 BuCmwqxrGWQUw1DdK+bE4U2aTdVZahvDnd9LN7WsRhuaSiS0CyhuvH8P2WH5lViIhjelhFJ
 llDtYBgts9YY1WhGYc+tw==
UI-OutboundReport: notjunk:1;M01:P0:L4zBCYsMCYU=;jMj8tAawqjROXC3TyOfZWyEmk4y
 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
 hWrNTips2mzNLK692E=
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

On 6/16/26 06:30, Chintan Patel wrote:
> Claim the memory resource associated with the Cyber2000 SPARC MMIO
> aperture before accessing it.
>=20
> This is part of the effort to request memory regions in fbdev drivers.

IMHO this patch doesn't make much sense.
The PCI regions (e.g. for x86) are already requested one level higher and =
are being kept reserved.
This patch here only touches the SPARC code inside a path which is e.g. be=
ing used everytime the machine wakes up from sleep (does sparc even suspen=
ds?). So, instead here, I think (if you want to make this robust) the regi=
on should be reserved e.g. in cyberpro_common_probe(), but I'm not sure if=
 this is even worth the effort....?

Helge

>=20
> Signed-off-by: Chintan Patel <chintanlike@gmail.com>
> ---
> v3:
>   - Use pr_err() instead of pci_err()
> v2:
> - Use pci_err() for error reporting instead of printk().
>=20
>   drivers/video/fbdev/cyber2000fb.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyb=
er2000fb.c
> index 2d12f8e96c7e..9fced6bf6ffd 100644
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
> +		pr_err("iga5000: cannot reserve I/O area 0x3000000\n");
> +		return -EBUSY;
> +	}
>   	iop =3D ioremap(0x3000000, 0x5000);
>   	if (iop =3D=3D NULL) {
> -		printk(KERN_ERR "iga5000: cannot map I/O\n");
> +		pr_err("iga5000: cannot map I/O area\n");
> +		release_mem_region(0x3000000, 0x5000);
>   		return -ENOMEM;
>   	}
>  =20
> @@ -1633,6 +1639,7 @@ static int cyberpro_pci_enable_mmio(struct cfb_inf=
o *cfb)
>   	writeb(EXT_BIU_MISC_LIN_ENABLE, iop + 0x3cf);
>  =20
>   	iounmap(iop);
> +	release_mem_region(0x3000000, 0x5000);
>   #else
>   	/*
>   	 * Most other machine types are "normal", so

