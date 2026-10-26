Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD5A606A320
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Pphu3xbK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E74D410F340;
	Tue, 27 Oct 2026 09:32:19 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E48C710EFE0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 15:49:48 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c37b612635bso406327166b.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 08:49:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793029787; cv=none;
 d=google.com; s=arc-20260327;
 b=RCF+6IvrQ8OWF/Nq4j2nHijIojk46WQoV1KyB6+euHSsrabs5u5PwqulsKoB3OleiR
 qMcNSA875FkIYbZ/z/RR5bJiYs/Y/88b0vmTAP5jCwnUX/nt2oo4BiyBqtlbxsx9WEI4
 AFbB5ny17u3P0rcTZqp204Rh36k0ommz7wGObypvv9nM8pKym9eadbme6rqjjQPrR78x
 GqZkiz1qgYAcUTlXqufYUq7hJr20LoUyPoDPk7Ibcz9pEgZo0NUJBQ4ZOGvieBNYtoXH
 KJfnJMzcUjHRwYT1TIdjATrL2wD1MI9mf1eZBmWcSX9y8zYMeo9MOKzgWUx5oyOcge/y
 3Osw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LuKCUhjbeOX3G6yTs4pSwfb4wNEV8f8KmzUas8xg7eY=;
 fh=QQVP9h0sAh5KwlVokMYDCbE+RtRq1Q4qMo5Jh3t/XHk=;
 b=q3UwlrB5jUcg5F+0cYCa+qqGt37iuzhlEH6fe/zruwhpTO8OFY16g95bpws20KL9dm
 Fr19WFAMh9Hk082Wo59l6dd0WPFGH5QqGwMNFQ/n6cjMAn2DHlRu1iNmQxfGJAIe/rtC
 o2I7dgoBvUBCJJaoFlbbFSpyOArkMH2wIHJghBXYoYV1/CIRMqKaZqOABXFBi1d4FI+L
 LLOAUa995SRLhSjHhAzdWCRjehq+233UHXG7V54C1B5AcLEEwnjyPV6ue8r2f8iXNJJK
 xh0HR9MPEvMdjbhBk52EfzwSy08oBETqES1BhclqG7LbUjDAVDZDkh+E4xpxGymTQ7H9
 MJCw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793029787; x=1793634587; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LuKCUhjbeOX3G6yTs4pSwfb4wNEV8f8KmzUas8xg7eY=;
 b=Pphu3xbKDLWrg6j1GSoCa6tw5HBLxmW1txUtARepy1/86VJ4shEp2P2tVzaTV3+s8u
 GmDSEI73n2rewNRuSexel+Dq6p3F4hLHZb44hxumVf39QFSuDqlk8E0fo0BeiC3oQHkf
 E25rcG7Me6j8sPq6BJvLgetCf8gaJy9lmf7teFU+qO9wvZEjJRKbtoz+l8Io1bhdcAU7
 Kn3nvuVzkpem4VuaXgv6c/UrwG4Dswxqo6SxEL1I01IkAZ9sdGB4f0O2jybb9wHXElrD
 NhptH0jTQhZn7KqJRFpu64DU3OqsOUcclWNn2YOfK5z/uyDrKWOydMIsvaw1SMpI94+1
 FVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793029787; x=1793634587;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LuKCUhjbeOX3G6yTs4pSwfb4wNEV8f8KmzUas8xg7eY=;
 b=uXQM/pn8c0hxIPHIxtGC658plumIRxJgCXU2Ql0jQ8m3f/IgS3t4nXla3AWqcSGqA0
 BOG9JJrZpfnXwnjpxCB5L3Hl9TSjtCOuLiCK71csp7ml8VoPfAPr6272CTTnnkpSrPDc
 AyNtOZHGEMjVZFj3k9+zWJJmk1WLvgR+DqEQtqRVTesDuCTN36hg67pdWP5sob9uAz47
 pq/C+a7Ja8vOhxZ6XUdVoyT6ktFTMGS/DBm3PXqGVYxFxvc48a7Il1BzVKrqqWKZnQq9
 UsgkLIQXh8y0DS9/nfYoNCuL7jyXwAQRBHD7xOqv9RGLfxQjArcsSrYVDVeSlPiRCmPw
 u78Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEmszzGQX07oEN24LZnTE3LDUmstMWK3tXIDzYP/nMkdfxirva5zXrG4ehLMItoPN2cPaqJ1U7Ugk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIMG2vARo1SLvD+pf4TtisuxlpuvSM5bTDr6apSmusV0ZU0VhbL
 4ddERkR1OFWEfy2eN/7HRNAaSmbVvDD3dpIZ2m82FhvPysWP2SV9pj2IJNsqRo96MzmjtTcAZ86
 dBankqTDO+Nwj4xD6gHCNq/RganDb0GE=
X-Gm-Gg: AYBFou0rmV40FdVrgh9N7OBMI+ZdAvN4VG3Ozrg8FH4oMaUfuGyEiPuWkwo3riYjNUY
 Ok2+I80jLYQ2KbGRyQkBiREXQl/+ot0R7SJ2NnMb93Q53E8j/p+ffJZrLiFLHyrnXxMARCw7JMc
 c4/WMCj8zapZCC3P7gGQdOperu1D6kUxdw2CdCvTHW85+oONoq4GYKaWYkIRSSUSonKtS3gojUK
 0C1oEhNelWT0vhn91JBmBxQwj/YpdR2682esHS7oNH80lFnw3Te/ZbGQDoIIG5Be5t9oEjjd9Tc
 Kr/RWe/BoNJTaf403frqd1PWZXG/BSxE3fd6a+tweP2Ww/aip8d/AJegdmiBqQWRvmfSCUuJEyr
 5ixSupyeIkk9HMX2vidRBhf5zOTW+fo51GYHh9rGvyN3W9N1U6uUukp5BxUNIofYp77f6gg==
X-Received: by 2002:a05:6938:e081:20b0:c45:b99:f282 with SMTP id
 a640c23a62f3a-c46c19961d9mr554911866b.7.1793029787038; Mon, 26 Oct 2026
 08:49:47 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261023175128.4127122-2-bestswngs@gmail.com>
 <f5a860e9-7b8f-400c-8d30-44f62e5129b8@gmx.de>
In-Reply-To: <f5a860e9-7b8f-400c-8d30-44f62e5129b8@gmx.de>
From: Weiming Shi <bestswngs@gmail.com>
Date: Mon, 26 Oct 2026 08:49:10 -0700
X-Gm-Features: AclHuK87d0T070FMTlQKiyTb8NOFRveqVBojRHsTQZkg5N_7T-c0np5SCvqWpSI
Message-ID: <CANgPUi3MF6j-K+51MVFtZ39Ve9sUT801Jyewqn8i0hKDSEw86A@mail.gmail.com>
Subject: Re: [PATCH] fbdev: vfb: Validate framebuffer geometry and memory size
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, co+b0df61d49532b2ee@bugs.sh, 
 Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Helge Deller <deller@gmx.de> =E4=BA=8E2026=E5=B9=B410=E6=9C=8825=E6=97=A5=
=E5=91=A8=E6=97=A5 12:38=E5=86=99=E9=81=93=EF=BC=9A
>
> On 10/23/26 19:51, Weiming Shi wrote:
> > get_line_length() multiplies two int operands before assigning the
> > result to u_long. Setting xres_virtual to 0x8000000 at 32 bpp therefore
>
> A xres_virtual value of 134217728 seems quite unrealistic IMHO...
>
> > wraps the product to zero and bypasses vfb_check_var()'s video-memory
> > limit. fbcon can then clear margins with a zero line stride and write
> > past the vmalloc'ed framebuffer.
> >
> > The xoffset + xres and yoffset + yres calculations can likewise wrap,
> > leaving an invalid offset in info->var after fb_pan_display() rejects
> > it. Subsequent fbcon drawing can then access far beyond the framebuffer=
.
> >
> > Finally, PAGE_ALIGN(videomemorysize) was narrowed from unsigned long to
> > unsigned int. Values near or above 4 GiB could therefore allocate a muc=
h
> > smaller buffer than the size used for mode validation.
> >
> > KASAN reports:
> >
> >    BUG: KASAN: vmalloc-out-of-bounds in sys_fillrect
> >      drivers/video/fbdev/core/sysfillrect.c:24
> >    Write of size 8 at addr ffa0000001671000 by task poc/198
> >    sys_fillrect
> >      drivers/video/fbdev/core/sysfillrect.c:24
> >    bit_clear_margins
> >      drivers/video/fbdev/core/bitblit.c:247
> >    fbcon_clear_margins.constprop.0
> >      drivers/video/fbdev/core/fbcon.c:1410
> >    fbcon_switch
> >      drivers/video/fbdev/core/fbcon.c:2261
> >    redraw_screen
> >      drivers/tty/vt/vt.c:994
> >    fbcon_modechanged
> >      drivers/video/fbdev/core/fbcon.c:2693
> >    fbcon_update_vcs
> >      drivers/video/fbdev/core/fbcon.c:2732
> >
> > Reject video-memory sizes whose aligned value is not representable by
> > the fbdev metadata. Check the offset additions for overflow. Compute th=
e
> > line length and framebuffer size in u64, reject unrepresentable line
> > lengths, and check the total-size multiplication before comparing it
> > with the allocated video-memory size.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: <co+b0df61d49532b2ee@bugs.sh>
> > Assisted-by: LLM
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> >   drivers/video/fbdev/vfb.c | 31 +++++++++++++++++++++----------
> >   1 file changed, 21 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
> > index de137b2bd..84b0a937c 100644
> > --- a/drivers/video/fbdev/vfb.c
> > +++ b/drivers/video/fbdev/vfb.c
> > @@ -101,11 +101,11 @@ static const struct fb_ops vfb_ops =3D {
> >        *  Internal routines
> >        */
> >
> > -static u_long get_line_length(int xres_virtual, int bpp)
> > +static u64 get_line_length(u32 xres_virtual, u32 bpp)
>
>
> Instead of trying to extend to 64bit, I think we should simply
> limit the maximum allowed screen sizes to e.g. 4096 x 4096
> (or some other realistic values).
>
>
> >   {
> > -     u_long length;
> > +     u64 length;
> >
> > -     length =3D xres_virtual * bpp;
> > +     length =3D (u64)xres_virtual * bpp;
> >       length =3D (length + 31) & ~31;
> >       length >>=3D 3;
> >       return (length);
> > @@ -122,7 +122,8 @@ static u_long get_line_length(int xres_virtual, int=
 bpp)
> >   static int vfb_check_var(struct fb_var_screeninfo *var,
> >                        struct fb_info *info)
> >   {
> > -     u_long line_length;
> > +     u64 line_length, size;
> > +     u32 xres, yres;
> >
> >       /*
> >        *  FB_VMODE_CONUPDATE and FB_VMODE_SMOOTH_XPAN are equal!
> > @@ -159,17 +160,23 @@ static int vfb_check_var(struct fb_var_screeninfo=
 *var,
> >       else
> >               return -EINVAL;
> >
> > -     if (var->xres_virtual < var->xoffset + var->xres)
> > -             var->xres_virtual =3D var->xoffset + var->xres;
> > -     if (var->yres_virtual < var->yoffset + var->yres)
> > -             var->yres_virtual =3D var->yoffset + var->yres;
> > +     if (check_add_overflow(var->xoffset, var->xres, &xres) ||
> > +         check_add_overflow(var->yoffset, var->yres, &yres))
> > +             return -EINVAL;
> > +
> > +     if (var->xres_virtual < xres)
> > +             var->xres_virtual =3D xres;
> > +     if (var->yres_virtual < yres)
> > +             var->yres_virtual =3D yres;
> >
> >       /*
> >        *  Memory limit
> >        */
> >       line_length =3D
> >           get_line_length(var->xres_virtual, var->bits_per_pixel);
> > -     if (line_length * var->yres_virtual > videomemorysize)
> > +     if (line_length > U32_MAX ||
> > +         check_mul_overflow(line_length, (u64)var->yres_virtual, &size=
) ||
> > +         size > videomemorysize)
> >               return -ENOMEM;
> >
> >       /*
> > @@ -434,9 +441,13 @@ static int __init vfb_setup(char *options)
> >   static int vfb_probe(struct platform_device *dev)
> >   {
> >       struct fb_info *info;
> > -     unsigned int size =3D PAGE_ALIGN(videomemorysize);
> > +     unsigned int size;
> >       int retval =3D -ENOMEM;
> >
> > +     if (videomemorysize > U32_MAX - (PAGE_SIZE - 1))
> > +             return -EINVAL;
> > +     size =3D PAGE_ALIGN(videomemorysize);
>
> same here.
> There doesn't seem to be a maximum limit for videomemorysize.
> Maybe adding a check and allow a maximum of e.g. 512MB ?
>
> Will you send a revised patch?
>
> Helge

Thanks for your review. v2 sent.
