Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14D8108B8F5
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 11:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C918A10EA6E;
	Fri, 20 Mar 2026 11:11:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KW4w0e1V";
	dkim-atps=neutral
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52EA110E28C
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 11:11:30 +0000 (UTC)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-5637886c92aso230115e0c.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 04:11:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774005089; cv=none;
 d=google.com; s=arc-20240605;
 b=cC4b6ptM28WRk5alxa7JljWh/NjyVIthez+uW0YO3bk4STdLt0NP2TCiGAc6Tvudb6
 kpv+2HcBY6Vk7njdD6+JxLo6CGxCDpzT4Ml1DbzCEbxt6zjY7nqo/AFfPbyVWGjCuL0T
 5VOyPg3wzfv4PYcs+EyO9muOt4P7YHgTHmgVFAA0mVl6PK0Fd/Jn/Y90li9L/tqdZeIE
 3vnCFyvcRLdXMT77xQDJ5t924W8D61NzoE637ChHUSMigp+BO5dGRX0H+uD/KirWk7Ez
 y4hStmEH7rLOtomKxnJ4bncnjV2Ubz5n8jtZPdLYv09Uct5F3ZlG0AjJkHJENut0aDp2
 eR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9te/j8HOzFHtjUgjcdp2trlsf+HhnDZ+SK/gHrL1Pnw=;
 fh=NjbVhdkg/7jWF3/ukk3OtfLDZdLIWmb019oOTGfT9C0=;
 b=LR+u+j5UhrvAZWoRt7ivAnu8YdbC2QbbcqyTQGqzc4AhqVLOuoUgdPTuHvjkoXjzhe
 /o87rHvdjr0qg2haZEK/gXZKljIqgaZqnJM5r+MA4rDqMLbBdRa4rseNTvTLLbarXv3T
 9pk70iYK0n6dmoeJe7nsra18Hbsd3ufBSnLRm+zsZT1U4NW0t+7mfcmAKEY9JYOfJ5cm
 sL1aGzZ79WPzMigIUcttScnT7Mxx/bmVUxCnTv6y26tjJew3/BrHA+8e0SrzEpcVbWCZ
 SXM1Wwd59spoI+PPN/ylJHuAaiaX0d2v7EzsejnNxiEUAios/x1LrhUN5vliXwab47rZ
 uFXw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774005089; x=1774609889; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9te/j8HOzFHtjUgjcdp2trlsf+HhnDZ+SK/gHrL1Pnw=;
 b=KW4w0e1VGKyTclY+9yBIxY8x9UjnuUEnT0vmcVScJ/llLPPLR1mhSEVJlLumb1KsMS
 OJECNglr/h6JJYSJ/WWyAUfN9AF5ZkZZaLl3N+DUL6eokcdloEx2Ps+eIi5/dom2ao3y
 /sAXYcqX8awhi4P8JSEMVOnJ+H0tj02bJAbhjrKUQREkGeGjANrfjzRcjv/TOTLeAQE0
 pu/4LaYmYeCfQHEG6cXhbKNnESCGtJhK1ifSrec0xsDkvEONV0K2H0XywPqaUWj/nigM
 0b/GZsSeqnNIR/jFMb6g2ZAbMGDUi6MIGVGs9UdSlVd6GPCfi653bhbFfLyvugAgKUD/
 Q1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774005089; x=1774609889;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9te/j8HOzFHtjUgjcdp2trlsf+HhnDZ+SK/gHrL1Pnw=;
 b=sZCDNSOi/Ycdsouu+NRJZHqN5/TjwX8mthd/7xcGbpw0m4GmZ/YYnu8z4gku3Pq8nT
 DvdNFEWGMyAIsDfaeH+6lfxK75e1awC+6cWNuLIuqqWJxEQMwnZYenKSYS7p2R6fElFb
 EhXWA6wiFudgrjqjD7BvieF40I8iDTOMKXeoRjkZafru4VTVRQpFSCNN/jqeDYYwwOmn
 onRQaNsFlXAoyB+g2oWbN1QOYv6YzKDqEPrlzbGwfJyejpV31FasXXIzqcX3pQmT3YPG
 U+0uRctY3lN2TcK0lh3feNljfCzM3JN7+yKQF4CKDUlIiVHTV5l7qvZiAmoU8a7GrrD9
 tn5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS7WGztOtxhHE7qzF2+z+SbDDEMTs9p19a5qfKWR1t3FchDmLe0zSXzX4m2E4whVQ9G/kMO4pOXAg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0G1Gwf51hPb8gJbhx/hMrZPZrmUjlGp1NQvYb9JhVXGah9eHb
 sXVtenOsHR0BKNE/ImrHiM5FfHR5s0wVXj5ZpHPRLu2vBLmBX3MwCdy+bijUQaUh4IIeD/t3q+I
 4uBrFRNRSUb9VCdg1b982ZyEa9Ntllcc=
X-Gm-Gg: ATEYQzyHtADTCNpe9GrXNcy07yoE8YwogjjcqrlxtDe5vv5h0qgSUrsMOyfLrIb5uFk
 dDq6VRDl34g9yBJQElcp1dAlFuk2jz9P3FAlD/MaFOSoxo63rDbN9PI9ZVkgdp/vlBZMCeNL07I
 mUgUzAiYFcNASLKu+01k4tjfvNYcWhlxwv3+ou7KjWrdNwCzJx6a22TGHSdd9nTb0Pftqvhpz6h
 2reOfa0BXG7U22X0qvpqsgbJcArAzjGgTgFyIyfWFkU0PpRePNVLqFoYt0EdCbc4RIJx0iorcBz
 r8c3cbqL
X-Received: by 2002:a05:6122:d1c:b0:56a:f576:cfca with SMTP id
 71dfb90a1353d-56cde3237a8mr1152700e0c.2.1774005089107; Fri, 20 Mar 2026
 04:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260307111250.105772-1-mitltlatltl@gmail.com>
 <dggubmwmcgepioyev4jfibntdgmmiiomahnrvodewcw6ktplo3@bngbsgvzuzoa>
In-Reply-To: <dggubmwmcgepioyev4jfibntdgmmiiomahnrvodewcw6ktplo3@bngbsgvzuzoa>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Fri, 20 Mar 2026 19:11:02 +0800
X-Gm-Features: AaiRm53l5G2RJnBS28ANAAiFgm5ukjN8S-QGG4QvRtKJpZSwLznLfIzx_bEm3mo
Message-ID: <CAH2e8h4pn+xRcpEEO6CjbM3=WO+2C4HfyH6quhh0opoDFmaEFA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/msm/dsi: fix bits_per_pclk
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Mar 20, 2026 at 9:48=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Sat, Mar 07, 2026 at 07:12:48PM +0800, Pengyu Luo wrote:
> > mipi_dsi_pixel_format_to_bpp return dst bpp not src bpp, dst bpp may
> > not be the uncompressed data size. use src bpc * 3 to get src bpp,
> > this aligns with pclk rate calculation.
> >
> > Fixes: ac47870fd795 ("drm/msm/dsi: fix hdisplay calculation when progra=
mming dsi registers")
> > Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> > ---
> >  drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Pengyu, what is your target platform?
>

SM8750, my device is lenovo legion y700 gen4, the display is a native
10-bit video mode panel.
Recently, in 10-bit input bpc/30-bit src bpp with 8-bit output
bpc/24-bit dst bpp mode, works well
on this device with some hacks to intf block. full 10-bit input and
output won't work for now.

Once I added this comment in ac47870fd795 ("drm/msm/dsi: fix hdisplay
calculation when programming dsi registers")
> DSI consumes an amount of compressed data equivalent to the uncompressed =
pixel depth per pclk.
This explanation is picked up from the downstream msm kernel, since
there is no public datasheet for the hardware.
And this should be the video mode case, cmd mode should consume 6
bytes. (It seems no explanation)

If we follow the downstream, then the uncompressed pixel depth per
pclk should be 3 * bits_per_component.
This is what this patch fixed.

About the test, I did it on the video mode panel, I have no cmd panel
device with dsc/widen bus enabled. And I overlooked something, I
thought
cmd panel didn't use hdisplay, then I removed the right value for the
cmd panel case, I fixed it in patch 2/2.

Best wishes,
Pengyu


> >
> > diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/d=
si/dsi_host.c
> > index e8e83ee61e..7c16216e8b 100644
> > --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> > +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> > @@ -1030,7 +1030,7 @@ static void dsi_timing_setup(struct msm_dsi_host =
*msm_host, bool is_bonded_dsi)
> >                */
> >               h_total -=3D hdisplay;
> >               if (wide_bus_enabled)
> > -                     bits_per_pclk =3D mipi_dsi_pixel_format_to_bpp(ms=
m_host->format);
> > +                     bits_per_pclk =3D dsc->bits_per_component * 3;
> >               else
> >                       bits_per_pclk =3D 24;
> >
> > --
> > 2.53.0
> >
>
> --
> With best wishes
> Dmitry
