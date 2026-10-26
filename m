Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C577606A31F
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SDx4gB1K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E68510F31C;
	Tue, 27 Oct 2026 09:32:00 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA2510E2DC
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 16:26:45 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa4d71e7so3459075a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793032004; cv=none;
 d=google.com; s=arc-20260327;
 b=BJfu9ZwvaDtyDXCd2tEESHvLZMNxpShJeDb6mBWyICGwuBmS29D+mD74a5OUmifCb2
 TaoCVnwCv7yLpAszvNoA5CEcf7kVqW7LzSZo4gIP4ttsRdr3LE8+V/6AX+SPrJM5+fPq
 9MewUwxBB3dnytLrv5xdsYnpY1+D+hIDOFcFFwArsPqYvyZAlgenMaUegLnePAx+qcPK
 9aj6RM0te5KSdDcIl/L0DmpRyOXUdVNVuEcC/a4T8H4KaZN2eq+O60uoKSDsh6krZap9
 BvJgMBC3/GeFsKuUYCOJD8ghZL50AJTD1zYA+/tYumPjZGtvgFBNgj7Nq3sKe6YhXawi
 1eDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lW187BX7pvnv89/fgKm/N1OWRtkvU+9tvFLWWwcKajk=;
 fh=fljnco4nmjaCVyVYYvtUopw8abcD5Wkdj3MYlWyXODQ=;
 b=MdVIjQlAxe6Nh7IgpLJgSMsnfS1tpmcmadzdPtXCqNkQJDUkvv45tMql2ISPCQKXg4
 SaOsRZvTlgHNs+TFHSxKoi06s+ADZCijXHU9jHrOWugFpZUzeCKNeGzyFk1u7vVlQEsi
 bL8S9Va4OB89HAWJohkkR9u0sG7k1vYtJHpD5UICYW8/pgfsHVrFE007Hp9qnaGWeWGT
 ftOB7zWkQ3+ksNZQM3PUJclh3PGTriqoQgOIg3ZYBUQvt9Qrcrowpm1Dzx/v4FAW2rdz
 K1YR4FUQMCVadSoXLilw70sE70XSWlgou8D+866CDDTRAoat1rlosJM/bJEbkf6ux3SO
 e+oA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793032004; x=1793636804; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lW187BX7pvnv89/fgKm/N1OWRtkvU+9tvFLWWwcKajk=;
 b=SDx4gB1KY5M16qUcrk+jG6hDgVJcxuAztD5xxUOgJBEXJ/kkqU/Qm0MrVrD1uAyI85
 z+6Vz4f5j/WsXDEESpvi/alM1jrbFQ2AmV1OLB/NKP/OJYCO2TXCdQfyAP/BkqW7Hvug
 j2AOsGBBY3A5apaWG4ix3iXcsxmIPWhLT9H/Q7BGE3Cg5Obv0+Mo7h3+zoAEsnxXQA+9
 7q8b9fT77rFkHbu9LIKlnGn+yjrajJYa/AdBTtljJ9y9CyzgeYFa8z8EjI9yruNQg8+D
 Ith/FAKT4ktSTwC2/DhVWkGL3XrAeDO0vOgqLVvCg27q4mkhWHW9ygCPXBkCP1oeQuti
 uNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793032004; x=1793636804;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lW187BX7pvnv89/fgKm/N1OWRtkvU+9tvFLWWwcKajk=;
 b=2QD7vnzd0PX4wJGPjlLHX6kgTLIn3nIfjEFwd55n2Y9sGnGn9qPRjCpgk7iN1slGFG
 3Dc4DofeiuLnrFlwhg801iRpvFTd2Tyvvas4jBDkmASxgzWePQYZBjiv070nGp7Hebc3
 O9SeN2RUTsnX/UCHjbzB2ivnLJmfL7c0e0MlckhRZeLGfp3srR7cWQuYWO1NecWvmLfr
 YVYcuTWLAY9pVWm2P6lk82x4Gns13PFdGccHhA9c2zPSMuvCppvFH3PS/6lResLcmu3J
 WI14wSvenp8m87UZ8Mfa4KX3UXnou26gwUqLLmm8vvAPOLmvXtkX0Bf1BCtwjK4KXvb8
 bI1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhjVCfSfGy0wV7GA/SApJmrObRc7us9+pvwysjx9Z32QY6OWMgc53ZMAbh8KVo0FF+srj2NPxIHsk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIqLXlCOKBMIW5Eb8hgtbgXBGyCooed8d0vjYDhwFFz96SscdtB
 rZ0Q8wURAOWUAfK689z9fVIWoHvmUeRp5elxY6XrWfdAl/vrKnVXxpRgPppFobH8Yl0i4/93r6g
 WJ8cwXN0xWlGA+SsGAvtVpleCuZ/vEC4=
X-Gm-Gg: AYBFou0TGGqwot3RaHfMtWb/QZJ55AqRmKzjeD6IwCKbFpiHgI4bCNuKU9YqQ9Qgfnr
 Yv1eYx+mWarUFas1O9K/Ug8PlqSdZ+NNb6M08SE8R6r9gM/kazBjvUtNHnb5F3+NPx1kcMSK52r
 aqa1E3RQmftEOCoWUREsM20H9h1qakfg04MZzivCCvh+OpDaI/o8q5WQrZAR09VSoPBz31dvOV6
 2aKIR0jn9sSF94K/rInIBYlyvecI97U7Dr8Bqg0P8IBBRIwW5wa3Lyi7uJum3V1K0ZfVF3gua56
 Z4rHARKcT8IkvetN5TGM73IUpSjOtIyvuHWwSHtVEuJoMUxxDQUWf1r7aAkPfjG/pGm2o/gpfAV
 LqjU0ylykVugMN5LcxJhL8puSAWvOTB+w3qFacxO9ugg2KMukVI5/TAmruvPLtcE/Exmv1g==
X-Received: by 2002:a17:907:961a:b0:c44:14d:d95d with SMTP id
 a640c23a62f3a-c46bde35b78mr860710466b.23.1793032003455; Mon, 26 Oct 2026
 09:26:43 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026154604.579823-2-bestswngs@gmail.com>
 <2f8371e4-ea8c-45d4-8a42-e1a616915b61@gmx.de>
In-Reply-To: <2f8371e4-ea8c-45d4-8a42-e1a616915b61@gmx.de>
From: Weiming Shi <bestswngs@gmail.com>
Date: Mon, 26 Oct 2026 09:26:07 -0700
X-Gm-Features: AclHuK8xJMkjzycsM_PGDEWxDNP3nAsGNewoI6y1CFU9ObUj4hzqU8eQ9FVmawY
Message-ID: <CANgPUi1WDS4aK9+7LO+O4D1JDvGd3isWVWps_W-ocD_fT39HAQ@mail.gmail.com>
Subject: Re: [PATCH v2] fbdev: vfb: Validate framebuffer geometry and memory
 size
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, co+b0df61d49532b2ee@bugs.sh, 
 Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
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

Helge Deller <deller@gmx.de> =E4=BA=8E2026=E5=B9=B410=E6=9C=8826=E6=97=A5=
=E5=91=A8=E4=B8=80 09:06=E5=86=99=E9=81=93=EF=BC=9A
>
> On 10/26/26 16:46, Weiming Shi wrote:
> > FBIOPUT_VSCREENINFO can supply a virtual width large enough to
> > overflow get_line_length()'s int multiplication and bypass the
> > video-memory limit, allowing fbcon to write past the framebuffer. The
> > offset additions can also wrap, while an excessive videomemorysize
> > module parameter can be truncated when PAGE_ALIGN() is assigned to
> > unsigned int.
> >
> > Limit virtual geometry and offsets to 8192 x 8192 and cap video
> > memory at 512 MiB, keeping the stride, framebuffer-size, and generic
> > fbdev drawing calculations within their destination types.
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
> > Cc: stable@vger.kernel.org
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: <co+b0df61d49532b2ee@bugs.sh>
> > Suggested-by: Helge Deller <deller@gmx.de>
> > Assisted-by: LLM
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> > Changes in v2:
> > - Limit virtual geometry and offsets to 8192 x 8192. This retains 8K mo=
de
> >    support while bounding all generic fbdev drawing calculations.
> > - Cap videomemorysize at 512 MiB.
> > - Keep the existing arithmetic types now that all inputs are bounded.
> >
> >   drivers/video/fbdev/vfb.c | 17 ++++++++++++++++-
> >   1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
> > index de137b2bd..de40ba8c3 100644
> > --- a/drivers/video/fbdev/vfb.c
> > +++ b/drivers/video/fbdev/vfb.c
> > @@ -31,6 +31,9 @@
> >        */
> >
> >   #define VIDEOMEMSIZE        (1*1024*1024)   /* 1 MB */
> > +#define MAX_VIDEOMEMSIZE     (512 * 1024 * 1024)
> > +#define MAX_XRES             8192
> > +#define MAX_YRES             8192
> >
> >   static void *videomemory;
> >   static u_long videomemorysize =3D VIDEOMEMSIZE;
> > @@ -159,6 +162,14 @@ static int vfb_check_var(struct fb_var_screeninfo =
*var,
> >       else
> >               return -EINVAL;
> >
> > +     if (var->xres_virtual > MAX_XRES ||
> > +         var->yres_virtual > MAX_YRES)
> > +             return -EINVAL;
> > +
> > +     if (var->xoffset > MAX_XRES - var->xres ||
> > +         var->yoffset > MAX_YRES - var->yres)
> > +             return -EINVAL;
>
> Instead of returning EINVAL, I wonder if we could simply
> cap the resolutions at MAX_XRES/MAX_YRES?
>
>
> > +
> >       if (var->xres_virtual < var->xoffset + var->xres)
> >               var->xres_virtual =3D var->xoffset + var->xres;
> >       if (var->yres_virtual < var->yoffset + var->yres)
> > @@ -434,9 +445,13 @@ static int __init vfb_setup(char *options)
> >   static int vfb_probe(struct platform_device *dev)
> >   {
> >       struct fb_info *info;
> > -     unsigned int size =3D PAGE_ALIGN(videomemorysize);
> > +     unsigned int size;
> >       int retval =3D -ENOMEM;
> >
>
> and here maybe
>         videomemorysize =3D min(videomemorysize, MAX_VIDEOMEMSIZE);
>
> that way the driver loads even if the provided too big value?
>
> Helge
> > +     if (videomemorysize > MAX_VIDEOMEMSIZE)
> > +             return -EINVAL;
> > +     size =3D PAGE_ALIGN(videomemorysize);
>
>

Yes, that makes sense. I'll cap the geometry and videomemorysize as
suggested and send a v3.
