Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B20C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 991F610E1D6;
	Wed, 14 Oct 2026 19:58:29 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BD2610E1D6
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 19:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792007891; x=1792612691; i=deller@gmx.de;
 bh=Yl7JqLTaI04NIle4YxtSuidm484vog6XzRS8D10VVIM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DQ/tf0kwepa7XuYxNIYvRiaHG/CaGVaPNmTtKi6XeYByBUq0F076dEYvJkRI+g9c
 KIsPCpe7kRqxFJVVdeMWE6OSA+06gTRpQvBuyp0MBSwYXHq49DQ/xLsdXTSidKZIB
 tu3w6T55w6gsIF+JcNrGKfVMiOcaaCIjy2hp/BwMAckhiKpfae3gI9G6haKZn0UK0
 LdPjbrqJSQgOFJPLGNc6LfCLQclZvtM17k3TjL8JvcXwOv04QLb4ZAZW+e2fZG743
 o/A7SUBlBsfI8vyBC31EiuyNUAk6uNm067I2wPy+aPKkifVZ9hkH09yLszjZ7KQJz
 SCfgD4GzUZPYZQSniw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDXp-1wMUWN40vV-00sAd0; Wed, 14
 Oct 2026 21:58:11 +0200
Message-ID: <116870de-c54d-4de5-afad-11f9f6cfdd7c@gmx.de>
Date: Wed, 14 Oct 2026 21:58:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fbcon: Rebuild rotated font buffer on font change
To: Yao Yiqi <yaoyiqi3@huawei.com>, tzimmermann@suse.de, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261014085102.497789-1-yaoyiqi3@huawei.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261014085102.497789-1-yaoyiqi3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1DPg+3xDaSgwWwXCcXCwVe+32KnMiW79ZXgS9UPQ5LaBtdcYhs3
 RJITOOWQVIzZDEVc7PljCU06wMpr/rO1V+74qiaJZwtiswDxanxl5LsIGkx8m7GA9M2gyfJ
 HykUiDIHSfJJZVtYZyAkrR3zhB+4a0+ARxldxFIuKUzfTwSJPnAbPoykZIhiqXWRZu5SPPJ
 h2dBeyiA1V9Go1JK2IHTg==
UI-OutboundReport: notjunk:1;M01:P0:LS/o1SwxBSY=;oyITkgtRczn+tEu17ovdibligT6
 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
 uZrRE17A==
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

On 10/14/26 10:51, Yao Yiqi wrote:
> fbcon_rotate_font() caches a rotated copy of the console font in
> par->rotated.buf. The buffer is sized from the font's width, height and
> charcount, and is rebuilt in fbcon_init(), fbcon_switch() and
> fbcon_modechanged(), but not in fbcon_do_set_font().
>=20
> When the console font is changed through KDFONTOP/KD_FONT_OP_SET, the ne=
w
> font data and geometry are installed and vc_resize() is called. The
> resulting redraw reaches the rotated bitops before the buffer is rebuilt=
:
> hide_cursor() drives both con_cursor() -> soft_cursor() and fbcon_putc()
> -> *_putcs(), and they index par->rotated.buf with the new cell size and
> character codes. A stale, too-small buffer is read out of bounds.
>=20
> KASAN reports, for example:
>=20
>    BUG: KASAN: slab-out-of-bounds in soft_cursor
>    Read of size 64 at addr ...
>     memcpy
>     soft_cursor
>     cw_cursor
>     fbcon_cursor
>     hide_cursor
>     redraw_screen
>     vc_do_resize
>     fbcon_do_set_font
>     fbcon_set_font
>     con_font_op
>     vt_ioctl
>=20
> Rebuild the buffer for the visible console right after the new font
> geometry has been installed and before any redraw, as fbcon_switch() and
> fbcon_modechanged() already do.
>=20
> Unlike those callers, this one does not fall back to unrotated rendering
> on failure. The "par->rotate =3D FB_ROTATE_UR; set_blitting_type(vc, inf=
o);"
> fallback they use does not actually switch to unrotated rendering:
> set_blitting_type() calls fbcon_set_rotation(), which immediately
> re-derives par->rotate from par->p->con_rotate. Replicating that pattern
> here would not change the outcome; a failed rebuild leaves
> par->rotated.buf NULL, so the rotated ops skip drawing, and the followin=
g
> patch retries the allocation on the next call.
>=20
> Fixes: 6cc50e1c5b57 ("[PATCH] fbcon: Console Rotation - Add support to r=
otate font bitmap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
> ---
>   drivers/video/fbdev/core/fbcon.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
series applied for further testing to fbdev/for-next.

Thanks!
Helge
