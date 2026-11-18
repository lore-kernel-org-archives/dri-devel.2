Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC51606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=eQcHDgw3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B823911202F;
	Wed, 18 Nov 2026 21:33:54 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE82511202F
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:33:47 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795037626; mf=PGRlbGxlckBnbXguZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:FzIG/lGM4lukLLOv/zxY3b+WDZtg
 d21lAJIxTm3GWS6mysJXaikIphQfFaFdvovezQjT2KgbIG0IA+Mfb6bZYXS9XXz5cXXzqWXYFSy
 aVkrJgqNkbKT3fKpV9zJ6guEPon3dd+GpoVwHx+GinP9aYAbhlt8JLQeB7Xoqjgl46fWdqAUZg8
 hTcsCH4BBQwR3uWINI40FiktPaAzBvXlM7c6NDB3ZFdCbOY5nBMmBj4eMe4DD4vzqKqrysvxY58
 9JzaV4OJZlaoxhT7+5H13mvRNNagIu8InaWtO13tto6yKOEwcYwtYwj0/WFDP64LCPvMyIQ7Uua
 iHEesd5vesLV2g==;
Message-Instance: m=1; h=sha256: Efj6N/Cboy2ybqOsARL43kWvM+nbvLNL36TDGMRfaig=:
 +ivYGckGg3xVKmPt6M5dWGaL9OaUISxk1i5X931lThY=, sha512:
 pSe1uao8SctsuljL9P+s2rU7uQPkIEi6Iy9h0060/EjJ/Rlrj/wY2B1YOA9Gumi8Ix+Qq42GArOfzQu+bKisyw==:
 LDz1H0PsfjTeMd2+zPWhrCEQJkhc321q1K1MnftVDnlT8jcADLQDeTULvHt698pG8Tw2xQSiLaAyv9ZDYYQRTw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795037626; x=1795642426; i=deller@gmx.de;
 bh=Ndz/MqUeRnkBtpSEma+nSStHIPkLucazThSPOENQPXw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=eQcHDgw34JF1K+6AdLi7fTpYOxWvMbQFxx2OM8r+/2sixrr0Nklb9zRuLyAURszE
 n/3zFB430PmFR/TAj6C/DCSWSg1t+7/7Bev5C+qcwEAMqpdzSqEgum3467TSaC2O2
 z6DLy5IRK/3bxm8Yu+1jpYkmrN2cesYPtiB0p8ju6JbCaU3RIDMQqTjdEvkCOlTJb
 UNr9q3bDYSGT3JTiTu0ax5Ayo9lFo1a+ilYcZtwL7xTPo+AJJ6R73QKbgUBDgvt8T
 AXHRgVE8kHO5qVT+Q+VnCGVIMj8Ve1BSGQbD726D5SQKq5TAU7ZGC8nyE67Z4/7tm
 XWYDt0/UvsUAgPY45Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZCb5-1wzM7c3oRt-00U4ah; Wed, 18
 Nov 2026 22:33:46 +0100
Message-ID: <ed40f891-5fc9-4f97-b380-e2ca92856fa1@gmx.de>
Date: Wed, 18 Nov 2026 22:33:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: fbcon: Fix KASAN slab-out-of-bounds read in
 rotated font buffer
To: Syed Tayyab Farooq <syedtayyabfarooq08@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Andrew Morton <akpm@osdl.org>, Antonino Daplas <adaplas@pol.net>,
 "open list:FRAMEBUFFER CONSOLE" <dri-devel@lists.freedesktop.org>,
 "open list:FRAMEBUFFER CONSOLE" <linux-fbdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: syzbot+bf4020519fbd94b2355d@syzkaller.appspotmail.com
References: <20260923060924.45742-1-syedtayyabfarooq08@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260923060924.45742-1-syedtayyabfarooq08@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tt4kIMayHyHfK//pvqRQHgn58BjdKkJNFpsZ571pUXX4QdKlNzV
 MpGHm7JQkBolpz25pZ10OzlhZxLvIyNms74LuDaF8XnkL4JrFVxZj6k0mFgwWZA4ORw2Evv
 pydGoy3hNbuXO4ejBgwiMpyuSyF8J5MF9VnYfSdgU43XHgPxqTkmnqkcMp5jHmNJ1ExMzsD
 kVo8fD8mN/lAt8+ENeOVg==
UI-OutboundReport: notjunk:1;M01:P0:X/rBejrV6G4=;CwpqwHWcjjvTIG0jIj7fYvOgHOV
 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
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 9/23/26 08:08, Syed Tayyab Farooq wrote:
> The root cause of this KASAN slab-out-of-bounds read is that fbcon fails=
 to
> reallocate the rotated font buffer (par->rotated.buf) when the font
> character count changes but the font dimensions (width and height) remai=
n
> the same.
>=20
> When a user changes the font via ioctl(KDFONTOP), fbcon_do_set_font() is
> called. If the user first sets a 256-character font, enables rotation, a=
nd
> then sets a 512-character font with the exact same width and height, res=
ize
> evaluates to false. The function then directly calls update_screen(vc).
> Notice that fbcon_do_set_font() never calls par->bitops->rotate_font() t=
o
> update the rotated font buffer for the new font. As a result,
> par->rotated.buf remains sized for the old 256-character font.
>=20
> When update_screen(vc) is called, it eventually reaches cw_putcs_aligned=
(),
> which attempts to read the glyphs from the rotated buffer. Since
> vc->vc_font.charcount is now 512, vc->vc_hi_font_mask is set, making
> charmask equal to 0x1ff (511). If the text buffer contains a character w=
ith
> an index >=3D 256, src will point out of bounds of the old par->rotated.=
buf
> (which only holds 256 glyphs). The subsequent read in
> __fb_pad_aligned_buffer() triggers the KASAN slab-out-of-bounds crash.
>=20
> To fix this, fbcon_do_set_font() must call par->bitops->rotate_font() to
> update the rotated font buffer before calling vc_resize() or
> update_screen(). If vc_resize() fails and the old font is restored in th=
e
> error path, rotate_font() must be called again to restore the rotated
> buffer.
>=20
> This pattern of updating the rotated font buffer was previously establis=
hed
> in fbcon_modechanged() by commit ef7656e85f1a ("fbdev: Fix out-of-bounds
> access when rotating console after font resize"). The fix applies this
> exact idiom to fbcon_do_set_font(). By placing it before vc_resize() and
> update_screen(), we ensure the buffer is correctly sized before any
> rendering occurs. Checking con_is_visible(vc) is also correct here, as
> hidden consoles will have their rotation state updated later via
> fbcon_switch() when they become visible.
>=20
> Furthermore, by calling rotate_font() again in the err_out path, we ensu=
re
> that if vc_resize() fails, the rotated buffer is restored to match the o=
ld
> vc->vc_font. Without this, restoring a 512-character font to a
> 256-character font on failure would leave the rotated buffer sized for 5=
12
> characters, which wastes memory; or worse, restoring a 256-character fon=
t
> to a 512-character font would leave the buffer too small, causing an
> out-of-bounds read later.
>=20
> Fixes: e4fc27618b75 ("[PATCH] fbcon: Console Rotation - Prepare fbcon fo=
r console rotation")
> Assisted-by: Gemini:gemini-3.6-flash Gemini:gemini-3.1-pro-preview syzbo=
t
> Reported-by: syzbot+bf4020519fbd94b2355d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dbf4020519fbd94b2355d
> Link: https://syzkaller.appspot.com/ai_job?id=3D59f0d7d9-607c-4497-b2e2-=
0b16693f9502
> Signed-off-by: Syed Tayyab Farooq <syedtayyabfarooq08@gmail.com>
> ---
>   drivers/video/fbdev/core/fbcon.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
applied to fbdev for further testing.

Thanks!
Helge
