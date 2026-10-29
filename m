Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8309606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=dl/cpo8a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36347112106;
	Thu, 29 Oct 2026 09:27:06 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F11E10E7DA
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 09:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793266017; x=1793870817; i=deller@gmx.de;
 bh=yARdWLlMp7ZM+u59k5EdJxvAzcZKSN+O9OmNKSrISPg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dl/cpo8ayEd05GCZ7e7x2Os6Ffgo1AGPJ61nouE+cw1LkZ82W66Qz19uF9J4+TLX
 woQJ0j7zNjsiBe1pfGr8Wd/0mugQxFyZiMblh4OZFmb99s5rriMqvCzp28FfgmSly
 n0CNx2LyrxfX7f5Vpp6sj2gHIq9NNW6DdDdasiRlDD1ZrG9ZTPuIas4ClicmGuIxN
 hxqGdyBfS9r+0J9VCJK5U+chOlVMXg/CDYgFXVqX+p8r52apvcPGfgG2W+ioFRpSp
 xTKWC5fpUXnOcDlwvDqiqF76HG+cgPsvc5T7qfsTyeu9dMskvVes2DNshvXtqB3Io
 8VjAyKce9IfeWxUasw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mxm3K-1wcuu32hcE-015sHb; Thu, 29
 Oct 2026 10:21:33 +0100
Message-ID: <1261fa6c-b724-46c1-a2a3-82826df1fdb3@gmx.de>
Date: Thu, 29 Oct 2026 10:21:32 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fbdev: vfb: Validate framebuffer geometry and memory
 size
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Weiming Shi <bestswngs@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, co+b0df61d49532b2ee@bugs.sh,
 Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
References: <20261027160914.3787276-1-bestswngs@gmail.com>
 <CAMuHMdUBAFGH-YoF5iTSXuX=tFjXXQhXYyxnT=-XJ6qEGym7PQ@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAMuHMdUBAFGH-YoF5iTSXuX=tFjXXQhXYyxnT=-XJ6qEGym7PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X4IQzqdBb2RAGG/Pm64X0L0nJvQhTx1L+yIctWx1t+dkafn4gg7
 hM6rnAXJWiTqcciErZnOOKIq8GjX8wrCl9jiX285UkZsbSGVlfu1wGriBjZCJM1YgD3DrAP
 3iELOJ5jZVhMBar5SxrGwrnnmcls8HVikhIKIQKc7aqJwFZWSUVuhSHfcO0kmErtHL4o7H0
 1bxId9GgItXgdDSaREtDw==
UI-OutboundReport: notjunk:1;M01:P0:CwYOU7S60o0=;7lmB0S7//UedtkPFNVX6m17yr8n
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 09:09, Geert Uytterhoeven wrote:
> Hi Weiming,
>=20
> On Tue, 27 Oct 2026 at 17:16, Weiming Shi <bestswngs@gmail.com> wrote:
>> FBIOPUT_VSCREENINFO can supply a virtual width large enough to
>> overflow get_line_length()'s int multiplication and bypass the
>> video-memory limit, allowing fbcon to write past the framebuffer. The
>> offset additions can also wrap, while an excessive videomemorysize
>> module parameter can be truncated when PAGE_ALIGN() is assigned to
>> unsigned int.
>>
>> Cap framebuffer geometry at 8192 x 8192 and video memory at 512 MiB,
>> keeping the stride, framebuffer-size, and generic fbdev drawing
>> calculations within their destination types.
>>
>> KASAN reports:
>>
>>    BUG: KASAN: vmalloc-out-of-bounds in sys_fillrect
>>      drivers/video/fbdev/core/sysfillrect.c:24
>>    Write of size 8 at addr ffa0000001671000 by task poc/198
>>    sys_fillrect
>>      drivers/video/fbdev/core/sysfillrect.c:24
>>    bit_clear_margins
>>      drivers/video/fbdev/core/bitblit.c:247
>>    fbcon_clear_margins.constprop.0
>>      drivers/video/fbdev/core/fbcon.c:1410
>>    fbcon_switch
>>      drivers/video/fbdev/core/fbcon.c:2261
>>    redraw_screen
>>      drivers/tty/vt/vt.c:994
>>    fbcon_modechanged
>>      drivers/video/fbdev/core/fbcon.c:2693
>>    fbcon_update_vcs
>>      drivers/video/fbdev/core/fbcon.c:2732
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Reported-by: <co+b0df61d49532b2ee@bugs.sh>
>> Suggested-by: Helge Deller <deller@gmx.de>
>> Assisted-by: LLM
>> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>=20
> Thanks for your patch, which is now commit f93dd31db3e23e61 ("fbdev:
> vfb: Validate framebuffer geometry and memory size") in fbdev/for-next.
>=20
>> --- a/drivers/video/fbdev/vfb.c
>> +++ b/drivers/video/fbdev/vfb.c
>> @@ -31,6 +31,9 @@
>>        */
>>
>>   #define VIDEOMEMSIZE   (1*1024*1024)   /* 1 MB */
>> +#define MAX_VIDEOMEMSIZE       (512UL * 1024 * 1024)
>=20
> Is there any point in having a larger limit than 256 MiB
> (i.e. MAX_XRES * MAX_YRES * 32 bpp)?
>=20
>> +#define MAX_XRES               8192U
>> +#define MAX_YRES               8192U
>>
>>   static void *videomemory;
>>   static u_long videomemorysize =3D VIDEOMEMSIZE;
>> @@ -142,6 +145,10 @@ static int vfb_check_var(struct fb_var_screeninfo =
*var,
>>                  var->xres =3D 1;
>>          if (!var->yres)
>>                  var->yres =3D 1;
>> +       var->xres =3D min(var->xres, MAX_XRES);
>> +       var->yres =3D min(var->yres, MAX_YRES);
>> +       var->xres_virtual =3D min(var->xres_virtual, MAX_XRES);
>> +       var->yres_virtual =3D min(var->yres_virtual, MAX_YRES);
>=20
> This violates fbdev API rounding rules:
>    1. If a value doesn't fit, it must be rounded up by the driver,
>    2. If a value is too large, -EINVAL must be returned.

Thanks for your review, Geert!
You are right. It's still documented like that in skeletonfb.c
Weiming changed it based on my feedback.
Weiming, no need to resend the patch.
I'll pick up one of your former patches.

Thanks!
Helge

>=20
>>          if (var->xres > var->xres_virtual)
>>                  var->xres_virtual =3D var->xres;
>>          if (var->yres > var->yres_virtual)
>> @@ -159,6 +166,9 @@ static int vfb_check_var(struct fb_var_screeninfo *=
var,
>>          else
>>                  return -EINVAL;
>>
>> +       var->xoffset =3D min(var->xoffset, MAX_XRES - var->xres);
>> +       var->yoffset =3D min(var->yoffset, MAX_YRES - var->yres);
>=20
> Likewise.
>=20
>> +
>>          if (var->xres_virtual < var->xoffset + var->xres)
>>                  var->xres_virtual =3D var->xoffset + var->xres;
>>          if (var->yres_virtual < var->yoffset + var->yres)
>> @@ -434,9 +444,12 @@ static int __init vfb_setup(char *options)
>>   static int vfb_probe(struct platform_device *dev)
>>   {
>>          struct fb_info *info;
>> -       unsigned int size =3D PAGE_ALIGN(videomemorysize);
>> +       unsigned int size;
>>          int retval =3D -ENOMEM;
>>
>> +       videomemorysize =3D min(videomemorysize, MAX_VIDEOMEMSIZE);
>> +       size =3D PAGE_ALIGN(videomemorysize);
>=20
> Perhaps return -EINVAL, too?
>=20
>> +
>>          /*
>>           * For real video cards we use ioremap.
>>           */
>=20
> Gr{oetje,eeting}s,
>=20
>                          Geert
>=20
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m=
68k.org
>=20
> In personal conversations with technical people, I call myself a hacker.=
 But
> when I'm talking to journalists I just say "programmer" or something lik=
e that.
>                                  -- Linus Torvalds

