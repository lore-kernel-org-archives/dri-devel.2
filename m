Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB205CD4F52
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4429310E379;
	Tue, 19 May 2026 08:10:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="atvl2s+n";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 574A310E379
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779178226; x=1779783026; i=deller@gmx.de;
 bh=/aqylfXQWOQDzMaiKs8cXjp/7rYxdlkRqWIL0qYWgWw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=atvl2s+nf/+l+lkz+hK5YyxERAbKMmEBFAkGzufXBWlW/PLQEiCpGKarh7NI6bjW
 VGDOMaDsrytqVIRuJI+55qq0cetOYtgff/BQu/gwIrr6pr8kMOUoMmOu1wQGo+lwq
 fPmEury1d8H3vnKctpIKLLOZVmqJuPyKAT4u3p0TnnxrZWhgzxcrpNE3VxnZ3zdO+
 tkosRjgfQsi39mUdkc62B0JltaNVPJw0nUGz2fG7onTIKJDDTYEa95y2uyRSmpCDH
 CHnUjBT5mYCDBv3nTd1HT21FzrlR594cjKedfZ2QJHTTAaUS54Sf9ZXir7bHB0DRd
 i10ovqTDeV4ZOpqbMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ma20q-1wt2NZ3Mc0-00MrvW; Tue, 19
 May 2026 10:10:25 +0200
Message-ID: <67a1f756-996c-404b-8eff-f705ff151ed3@gmx.de>
Date: Tue, 19 May 2026 10:10:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbcon: don't suspend/resume when vc is graphics mode
To: yaolu@kylinos.cn, tzimmermann@suse.de, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260430060137.131107-1-yaolu@kylinos.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260430060137.131107-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4d9Z2mf99mzsK3hfy9NRAYV82hurArVDPI4ADmFBoECAFD0mRwL
 BOm5MOvIdDzHSqKffSuqljRxsa8qmUYGlGmIP1dDisjCGl32DHbQujtn7XXBfAPDQ4BIGTx
 eQ7aVrwARZ7OhZ1wswsCj7d+ucd8UUAxh20xEc3h1lILsY1IBTuR/1KmMfQAGlkHRMxavgI
 7tOjBG5D82U06vt7JNxaw==
UI-OutboundReport: notjunk:1;M01:P0:k1chn+WaM1w=;hCztbOnkCNWSPeUS0+tjAaJAfmn
 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
 V3nEJQ==
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

Hello Lu,

On 4/30/26 08:01, yaolu@kylinos.cn wrote:
> From: Lu Yao <yaolu@kylinos.cn>
>=20
> Don't need to do suspend/resume for fbcon in graphic mode.
>=20
> Doing this may cause error, eg:
>    At the beginning, starting the Xorg with single screen and then an
>    external screen was plugged in. After logging out in Xorg, fbdev
>    info may using screen which is connected later on for info always
>    using first connected connector in list in func 'drm_setup_crtcs_fb'.
>    Then, S3 executed, fbcon found that the information did not match
>    and do atomic to switch fb. However, Xorg will not re-bind the crtc
>    fb but continues doing ioctl. At this time, the fb is incorrect.


Do you still have the possibility to test this issue?

 =20
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> ---
>   drivers/video/fbdev/core/fbcon.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core=
/fbcon.c
> index b0e3e765360d..450e690d0bd2 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2602,8 +2602,9 @@ void fbcon_suspended(struct fb_info *info)
>   		return;
>   	vc =3D vc_cons[par->currcon].d;
>  =20
> -	/* Clear cursor, restore saved data */
> -	fbcon_cursor(vc, false);
> +	/* Don't need to clear cursor and restore saved data in graphic mode *=
/
> +	if (vc->vc_mode !=3D KD_GRAPHICS)
> +		fbcon_cursor(vc, false);

I think checking for "=3D=3D KD_TEXT" is probably better.
And, maybe using con_is_visible(vc).
So:

+	if (con_is_visible(vc) && (vc->vc_mode =3D=3D KD_TEXT))
+		fbcon_cursor(vc, false);


>   void fbcon_resumed(struct fb_info *info)
> @@ -2615,7 +2616,9 @@ void fbcon_resumed(struct fb_info *info)
>   		return;
>   	vc =3D vc_cons[par->currcon].d;
>  =20
> -	update_screen(vc);
> +	/* Graphics mode is managed by userspace */
> +	if (vc->vc_mode !=3D KD_GRAPHICS)

here the same check as above... ?

Helge
