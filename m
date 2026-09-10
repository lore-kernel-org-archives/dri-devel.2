Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902D1C88E41
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD82310E2E3;
	Thu, 10 Sep 2026 20:39:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="QIeRQfLh";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A21810E2E3
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 20:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789072760; x=1789677560; i=deller@gmx.de;
 bh=g3qfImC2h01KshJfrIk7NdD5XezlhQP1j+AVRMUy4XA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=QIeRQfLhojnKorSQliIn+PTcUqwOlvEG8c+g460eDkWgej7Oyn7MPlWRyxlq/fms
 kj3D6uunWVLUUdUTDa3E9VXkDm6RD8uV1n9CbHau8gtEMOncDVoj4MkRhHoCZSscJ
 2J8LhtluYRFHqYp/cnc9TbSeeVvCaeWT1DFa0akn+rG1zCoQF+7o/82VZQXBsaeWz
 MXPIERkreX70ACoMzRAIXoR+VZZWyc/EiUS64Ax5vpsvwaqUnaF6EST4ps0sA4MWD
 vN6CXYhLUKoiXwoJHoLnB7M2xlw1KUtyrPhxO1TTk+KmGTd72kAIT944bD7b2d17U
 8asJOJd0AZgtEQl1BA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxDkw-1wtxrM0vjE-00yzkv; Thu, 10
 Sep 2026 22:39:20 +0200
Message-ID: <a8cb0e4f-a2fd-4478-99d6-fdb043a9d15c@gmx.de>
Date: Thu, 10 Sep 2026 22:39:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: atafb: Restrict SuperBlitter to supported formats
To: Michael Schmitz <schmitzmic@gmail.com>,
 =?UTF-8?B?TWlybyBLcm9ww6HEjWVr?= <miro.kropacek@gmail.com>
Cc: Linmao Li <lilinmao@kylinos.cn>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20260827093948.2825531-1-lilinmao@kylinos.cn>
 <e4a2ba2e-c533-04d8-0795-e3d43caf47b9@gmail.com>
 <CAN5rfbSh9ZoUkReAqv9rHYowqKcZFa-Svy6LP-MHvqfBVhjdBQ@mail.gmail.com>
 <4f3c7184-1b5c-4074-b8a1-49261833df8f@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <4f3c7184-1b5c-4074-b8a1-49261833df8f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UCX50ZVdrjHwz3CDgvpmsdIHQgqeN6o5bv/KOFkGJaElwjwoeR3
 FxfTjSWG42PhNUY1mVlXTZ1G+v4maE4BIsQdHnhKj7st8Rwa2k5rRyp5Mtw1DpUz+bYsr/F
 wxDJagGew+JayxC0q0L+th6ZMNA8HFyt9Nd29/NG/bg1mVVwJDVjNUtKKXCW1L42YZO5Uji
 h1vvN2xRenVRkwMCZIAUg==
UI-OutboundReport: notjunk:1;M01:P0:pFZam9D5Weg=;/vQO37QL9GlPPTYv6vPKtU6QI8y
 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
 VcwU7FyLDsp1L9dEmlu46jd6BAVyINzyLxQ==
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

On 9/7/26 22:14, Michael Schmitz wrote:
> Hi Miro,
>=20
> On 7/09/26 23:14, Miro Krop=C3=A1=C4=8Dek wrote:
>> Hi Linmao, hi Michael,
>>
>> On Sun, 6 Sept 2026 at 11:49, Michael Schmitz <schmitzmic@gmail.com> wr=
ote:
>>> Hi Linmao,
>>>
>>> thanks for your patch!
>>>
>>> Am 27.08.2026 um 21:39 schrieb Linmao Li:
>>>> The SuperBlitter operations derive an integer byte count per pixel.=
=C2=A0 The
>>>> accelerated fill path handles only one-, two- and four-byte pixels.
>>>> However, the operations are currently installed for every external
>>>> framebuffer in SuperVidel RAM, including planar 1/2/4/8-bpp and 24-bp=
p
>>>> truecolor modes accepted by the external video parser.
>>>>
>>>> For 1/2/4-bpp modes, the byte count becomes zero, so accelerated copi=
es do
>>>> nothing and fills fall through to 32-bit stores.=C2=A0 Planar 8-bpp u=
ses an
>>>> incompatible memory layout.=C2=A0 For 24-bpp modes, fills also use 32=
-bit stores
>>>> despite advancing addresses by three bytes per pixel.=C2=A0 These cas=
es can
>>>> corrupt the framebuffer beyond the requested rectangle.
>>> I believe 24 bpp mode can be rescued using something like this (entire=
ly
>>> untested):
>>>
>>> --- a/drivers/video/fbdev/atafb.c
>>> +++ b/drivers/video/fbdev/atafb.c
>>> @@ -2463,6 +2463,11 @@ static void svblit_fillrect(struct fb_info *inf=
o,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 2:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset16((u16 *)line, pix, rect->width);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 3:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 memset(line, pix, ((rect->width * bytespp) % 4));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 line +=3D ((rect->width * bytespp) % 4);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 memset32((u32 *)line, pix, (rect->width * bytespp) / 4);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset32((u32 *)line, pix, rect->width);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>
>>> Can't test this on hardware, and would need Miro to confirm it works a=
s
>>> intended.
>> Linmao's patch: I ran it on a Falcon with SuperVidel at
>> 1920x1080x32bpp, all good.
>>
>> Michael's 24bpp fill: I cannot test it because the SuperVidel has no
>> 24bpp video mode. It was planned but never implemented. Its mode
>> register offers 1/2/4/8-bit bitplane, 8-bit chunky, 16-bit highcolor
>> and 32-bit truecolor (24-bit RGB plus an alpha byte), with the
>> remaining code reserved - and TOS offers no 24bpp mode to set.
> Without a 24 bpp mode, the 24 bpp fill is pointless, so no point trying =
to keep that mode alive.
>> Unless I overlooked something, the fill also looks wrong on paper: the
>> first line is filled with a repeated byte and then with repeated
>> 32-bit words of the same value, which cannot reproduce a 3-byte pixel
>> pattern unless all three bytes are equal.
>=20
> You're correct - we'd need a memset24() to account for that. Without har=
dware support this is an academic exercise that I don't have time for :-)
>=20
>> On the fbset question: no, the pixel format, depth and geometry of an
>> external framebuffer cannot be changed at runtime here. fbset -depth
>> 16 and fbset -xres 1024 -yres 768 both return success and change
>> nothing, because ext_decode_var() only validates against the values
>> from the boot argument, ext_encode_var() re-derives every field from
>> the external_* globals and ext_set_par() is empty. Only a reboot with
>> a different atafb:external: argument changes the mode.
>=20
> All good then - do you need my Acked-by for Linmao's patch, Helge?

No, I think your Reviewed-by is sufficient.

But I added a
Tested-by: Miro Krop=C3=A1=C4=8Dek <miro.kropacek@gmail.com>
tag, if that's Ok for you, Miro?
It's always good to know if a patch has been tested.

With that, I just added the patch to the fbdev git tree.

Thanks!
Helge
