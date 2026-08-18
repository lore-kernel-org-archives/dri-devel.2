Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6325DC5DF70
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A7F110E4E8;
	Tue, 18 Aug 2026 08:53:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="MTPtUmWM";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6B0C10E4E8
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1787043217; x=1787648017; i=deller@gmx.de;
 bh=+ny0jzfx9IHfHBFixW1zioinnmV5fnO6gJd6nwTBX7g=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=MTPtUmWMtWATeKbZnasHc+s7Bph/IihhMRq7O/n54tsUOXvmdiZP6aQWyPE61jWV
 DEzrZHODScQtB4vOrUTPrXTHMgcQsfnDfhYVhhUfBTYHXqrB53uaCJI0F9yGaFXw/
 iFgseMXcBUxHQP//zStk26TJ57tIUDoH694Bt4WNhB81Vfm3PiPWlGRYZtf2Wl6cs
 0bOTcXyViX+zwrBxTXnGZ2txsUh89tFgR+jc2cCjhP2B5d+dcpNqLIWgX2OGu+N8Z
 6TESId+q2cAkQMeSffiSxgwMUGP9yEFv3qJYJK4SGKIxblM3F2aTI0sE6GZjXK9ur
 W47EwHPyr4b/weBVCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRmjw-1xPUmR3AHy-00VAZc; Tue, 18
 Aug 2026 10:53:37 +0200
Message-ID: <40410af6-5fbc-4b7e-826a-24d93e8e65c5@gmx.de>
Date: Tue, 18 Aug 2026 10:53:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] video: fbdev: via: refactor strcpy and viafb_name
To: Ajith P V <ajithpv.linux@gmail.com>, FlorianSchandinat@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260814074435.277441-1-ajithpv.linux@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260814074435.277441-1-ajithpv.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eZ3v6JMV0vmMrmJw54BroutUFyW7f4nbtqZEsSBq0nGoA9TDAQN
 IpMRuTq0q0mUwa09CQjOMHJia21usW9XnKEb9LLIvc4WpzI9TeaRvi/9ispyts+CRmvMjgE
 0eecoqu3nkrQJj9FSAqkQto35/CQmBQYpKyVvAQeZUProXZXAesusgg0SsD6fo+cRVZ3m/R
 fvoX2EaWab4Tg/wIaitUQ==
UI-OutboundReport: notjunk:1;M01:P0:9MvLFBY4f24=;ydoPV8fgqqRmr3L4rL6SIVIO8Qp
 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
 aNlGRfQ==
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

On 8/14/26 09:44, Ajith P V wrote:
> Replace the deprecated and unbounded strcpy() function with the safer
> strscpy() alternative when setting up the framebuffer fixed screen
> information [1][2].
>=20
> It aligns this driver with the ongoing kernel-wide security initiative
> to eliminate unbounded string copies, hardening the code against future
> modifications.
>=20
> Additionally, convert the file-scope `viafb_name` pointer into a
> `static const char[]` array while preserving its original value "Via".
> This allows the compiler to execute compile-time bounds checking and
> optimize the string copy operation without breaking userspace ABI
> backward compatibility.
>=20
> This is a proactive API cleanup and there is no functional
> performance or truncation risk.
>=20
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#str=
cpy [1]
> Link: https://github.com/KSPP/linux/issues/88 [2]
>=20
> Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
> ---
> v3:
>    - Restore the original "Via" string value to prevent userspace ABI
>      regressions, while keeping the 'static const char[]' optimization a=
s
>      suggested by Sashiko AI.
> v2:
>    - Keep variable static but change it to a const array
>      'static const char viafb_name[] =3D "viafb"' as suggested by Helge =
Deller
>      to let the compiler leverage compile-time checks.
>=20
>   drivers/video/fbdev/via/viafbdev.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/vi=
a/viafbdev.c
> index 80f95dac32c8..f6823beb4d7e 100644
> --- a/drivers/video/fbdev/via/viafbdev.c
> +++ b/drivers/video/fbdev/via/viafbdev.c
> @@ -16,7 +16,7 @@
>   #define _MASTER_FILE
>   #include "global.h"
>  =20
> -static char *viafb_name =3D "Via";
> +static const char viafb_name[] =3D "Via";
>   static u32 pseudo_pal[17];
>  =20
>   /* video mode */
> @@ -144,7 +144,7 @@ static void viafb_setup_fixinfo(struct fb_fix_screen=
info *fix,
>   	struct viafb_par *viaparinfo)
>   {
>   	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
> -	strcpy(fix->id, viafb_name);
> +	strscpy(fix->id, viafb_name, sizeof(fix->id));
Please make it simple:

	strcpy(fix->id, "Via");

Helge
