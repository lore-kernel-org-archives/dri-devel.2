Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E047CD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6CA610F959;
	Mon,  8 Jun 2026 19:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="YKCX5A3d";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BD4710F959
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 19:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780948675; x=1781553475; i=deller@gmx.de;
 bh=XyuohNO1tp5iSKnfmtVx4CwcUPJSfg9JtkZd/uHOAfw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=YKCX5A3d3y3BKROTudIU1f7gXcAaDsiguqu5i8N/cfAPngl/OMF8SwKPMMTLOMGw
 rd9q74+BLLauCvfnB8v6wGVn2NzON+jZhBLeANmVGtNlDHGg6MsY5UxOBEt/Mba+k
 fRzm0aOj4rSPTIUOK3I8TKLFzd6irCMOVUmNcC72twTm+9V4rJCSxheeH+J2XYTFc
 IthPu4tx8jMawBJYvQqt1ETlXm9auDuodOSf/tGq7jjF6inYTEKmwVl8AIbLQlaVt
 0AlYJwyzwMoQoQJ54JFRO8aH4utGmVMVLSCYTvS9zNe30J8mPUb14/ZuMxYAteJaG
 Fqg4GR9+81EBfIlbjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIwz4-1wpz6v07HG-00XPxM; Mon, 08
 Jun 2026 21:57:55 +0200
Message-ID: <1492766a-c349-4cca-932e-bf608b922b6b@gmx.de>
Date: Mon, 8 Jun 2026 21:57:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/fonts: Avoid unncessary 64-bit math in font code
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
References: <20260607210203.229613-1-deller@gmx.de>
 <b80a379d-87e4-45c4-a078-09e84a840895@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <b80a379d-87e4-45c4-a078-09e84a840895@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GhNQ/H2lsong4whkjH4sim6klYHchmmW5Sn+jfvN6G5m59b1pHa
 2u2D/pn7NeRUfmzrNUO9KT3jVYGY73xyBxOAuZ0Rm2JoP0kvdMtDiUIGLEbJtgLW0692/wL
 6CQyTKqoqLpYmavERoxYVY+Ej7/GPlYKcZLeHdm0nBTbxFBqeXOUr5redfvvIGp75c77PnG
 No20rJaV+8c9+ggjIe63Q==
UI-OutboundReport: notjunk:1;M01:P0:6ge4vs3je4g=;Y0S1nfpHUHFdAeNN3p+3HKI7dqh
 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
 DE3Bk0XWv0MQS+f/Ik=
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

On 6/8/26 13:25, Thomas Zimmermann wrote:
> Hi
>=20
> Am 07.06.26 um 23:02 schrieb Helge Deller:
>> The text display code used in the Risc PC kernel image decompression
>> code uses arch/arm/boot/compressed/font.c, which includes
>> lib/fonts/font_acorn_8x8.c, which further includes <linux/font.h>.
>>
>> Since commit 97df8960240a ("lib/fonts: Provide helpers for calculating
>> glyph pitch and size") <linux/font.h> contains inline functions that
>> require __do_div64, which is not linked into the ARM kernel
>> decompressor. This makes Risc PC zImages fail to build.
>>
>> There is no need to use 64-bit division code here, so resolve this issu=
e
>> by using plain standard addition and shift maths.
>=20
> Why is there a 64-bit division at all?

Not sure. Might be platform specific.
Maybe, because you add two integers and divide by an integer, that the
compiler then chooses to use 64-bit integer division by 32-bit integer.
 =20
>> Fixes: 97df8960240a ("lib/fonts: Provide helpers for calculating glyph =
pitch and size")
>> Reported-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>> =C2=A0 include/linux/font.h | 3 +--
>> =C2=A0 1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/include/linux/font.h b/include/linux/font.h
>> index 6845f02d739a..67d32268989d 100644
>> --- a/include/linux/font.h
>> +++ b/include/linux/font.h
>> @@ -11,7 +11,6 @@
>> =C2=A0 #ifndef _VIDEO_FONT_H
>> =C2=A0 #define _VIDEO_FONT_H
>> -#include <linux/math.h>
>> =C2=A0 #include <linux/types.h>
>> =C2=A0 struct console_font;
>> @@ -35,7 +34,7 @@ struct console_font;
>> =C2=A0=C2=A0 */
>> =C2=A0 static inline unsigned int font_glyph_pitch(unsigned int width)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 return DIV_ROUND_UP(width, 8);
>> +=C2=A0=C2=A0=C2=A0 return (width + 7) >> 3;
>=20
> Ok by me, if that's what's necessary.
> But can we try to keep a documented macro for the division to make the c=
ode explain itself?

I'd expect everyone who messes with this kind of low-level graphics and bi=
tmaps
to understand this math addition and bit shift, and as such I think it sho=
uld
be self-explained.

> Does it work with DIV_ROUND_UP_POW2() ?
IMHO that's even worse than DIV_ROUND_UP().

Heleg
