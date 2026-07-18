Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572C6C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 18:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47BD710E5E2;
	Sat, 18 Jul 2026 18:26:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="cxJ3VkvS";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C603010E5E2
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 18:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1784399172; x=1785003972; i=deller@gmx.de;
 bh=d/3SGhTjSYU9tk1WGvfuJwokBsHRkWnu7IMZprK80EQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=cxJ3VkvScnOXXayBX0wkCq5Ccalba5Fh8A3kTjTQYCV+KnQTy7wpd/XWVPlJvwzP
 IP9pfKK8vW73MpifTHfykEM5U1uivB/htkQ05oRLQshpjUUuSy+EfwYtqmNcKpmyo
 kjcSRk+kY7aOUUHa4S/Uc6VEKpasZGHl3Y9H8Rztb5Kqtlbnju+jscyr8tET12HI/
 WDAmEGU7AtOipAMpH4yIgL0M1n5SGuN+0zCQc2sKlovbsAtcFgfUlr+B6YGiXTOQ1
 hmfHs6xygE8MhQEnSf5eOuNE5yDiBj7qVNsCiSejw5ieAgqlkoh8bZC97cUMUhD0w
 FbLSdVeWR3SMVvgz8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHXFx-1wpKc90DGT-00Gp6k; Sat, 18
 Jul 2026 20:26:12 +0200
Message-ID: <db0698e3-9f45-4123-8b6d-ff59bcdcf25f@gmx.de>
Date: Sat, 18 Jul 2026 20:26:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: udlfb: validate vendor descriptor items
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Bernie Thompson <bernie@plugable.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260706093038.80131-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260706093038.80131-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yjifpOCBQEiPYa75as7Gdx+Zr9zp0Xe+Qx+wGb6k8lV3p6zUM/8
 ufLm3eHXXM9DZeEJ7yPMflbTjooyWL1RUtXOfpXMlKhu2RGCFoYG1K4EBytGTAfNp/C2vW2
 hky5BDVyp2OmJxdjuoXPyGc5ML7z5BnGEECS95shtkUxlCsJ7N0ya6n7UX9YE0oQtP1mkDe
 cFl0dUGN2VE/9mNaxfkFA==
UI-OutboundReport: notjunk:1;M01:P0:geUXMzuEfXQ=;QXodSzrWu5z9WoYHEdDVAsTSYPa
 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
 hhJHQqbOlgpilAWsiuIuo
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

On 7/6/26 11:30, Pengpeng Hou wrote:
> dlfb_parse_vendor_descriptor() walks key-length-value items inside the
> DisplayLink vendor descriptor.
>=20
> Require each item to contain its key, length and declared value bytes
> before reading item-specific fields such as max_area.
>=20
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   drivers/video/fbdev/udlfb.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
> index fdbb8671a810..e78d6f95c9c5 100644
> --- a/drivers/video/fbdev/udlfb.c
> +++ b/drivers/video/fbdev/udlfb.c
> @@ -1586,19 +1586,29 @@ static int dlfb_parse_vendor_descriptor(struct d=
lfb_data *dlfb,
>   		desc +=3D 5; /* the fixed header we've already parsed */
>  =20
>   		while (desc < desc_end) {
> +			char *value;
>   			u8 length;
>   			u16 key;
>  =20
> -			key =3D *desc++;
> -			key |=3D (u16)*desc++ << 8;
> +			if (desc_end - desc < sizeof(key) + sizeof(length))
> +				goto unrecognized;
> +
> +			key =3D get_unaligned_le16(desc);

Is there a reason why you switch to unconditional little-endian reads?
Is this "vendor descriptor" always little-endian?
If yes, then your patch is probably correct.
If not, I think your patch will most likely break big-endian machines.

Helge

> +			desc +=3D sizeof(key);
>   			length =3D *desc++;
>  =20
> +			if (length > desc_end - desc)
> +				goto unrecognized;
> +
> +			value =3D desc;
>   			switch (key) {
>   			case 0x0200: { /* max_area */
> -				u32 max_area =3D *desc++;
> -				max_area |=3D (u32)*desc++ << 8;
> -				max_area |=3D (u32)*desc++ << 16;
> -				max_area |=3D (u32)*desc++ << 24;
> +				u32 max_area;
> +
> +				if (length < sizeof(max_area))
> +					goto unrecognized;
> +
> +				max_area =3D get_unaligned_le32(value);
>   				dev_warn(&intf->dev,
>   					 "DL chip limited to %d pixel modes\n",
>   					 max_area);

