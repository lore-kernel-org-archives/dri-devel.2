Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0154FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:16:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C89D10E748;
	Mon, 27 Apr 2026 13:16:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f0kfKrKi";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172EF10E748
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 13:16:48 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-672c12e95e9so14401707a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777295806; cv=none;
 d=google.com; s=arc-20240605;
 b=RcYByyavMaN3uiKOUZ7SfV0gH7Fe+vUgyVrtZfjpym+YxQp2z0q0h5x4SOqMeMpURQ
 3JfoOHjayk+o7ZhTKyv8DLx8UZBMfAg+SDW/2Ie22qLXTYMH55Dg8OymRGWCH1ChXJbN
 iMhcQizMogX66Rx2Xht7DVB5izKsqQyHz5toPx4bk0b19zAgO7Obw6pSCly/SMvJ/2BI
 otbodE50dfqrjbwob3y+aLhjrHe1FMvhcIXl/Axb+z4kN9VBMFtXZufbVtMB/poRS5JR
 3EGJpwJMQa0dnt8TTgrV0dMHkYfkLtNpLAFzN/D8GJ4HN0KjEUCMfSHtfHQY9+GLU2t4
 t9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6Ez+m/Pp3FoKDsSjZqsPsJp65wBlWOPg9kLMbj+KHSE=;
 fh=04/vsFp6qyOvMwCspTMawmwXAkiZyZTOWybwi5XW8TQ=;
 b=RVzkP9EXHnnbkaLj3q2Pb7tC53SbC94A9sDw0hsfThory9Ywxh5DEHuWFUnts1r+0j
 jE+AFxRLGFf16tqhQSH2FUvS0LLluzCqS8z+wSAsjdSLK/w3lwpyni9CSpyWZ6paisdN
 hcOgxI8fubLv/kmJzk7iqudbLhEv/RjiaoWC0YbIc+k7+zoWXtUvkEzwYIr1XYFd6mbi
 EtgTwMZtvLG3dkrCHS76ABNtJHVG9x7g2SrM2H35e7hJ0NP3w371wf7rspkcwFlHcJ8F
 p/4vtZ3y9JyGI4wzDXmg9mWHXio1iiti1uZJ1x7O8gUuKRFZScOrQsLqKfJu3CEQxvMK
 Y50A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777295806; x=1777900606; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6Ez+m/Pp3FoKDsSjZqsPsJp65wBlWOPg9kLMbj+KHSE=;
 b=f0kfKrKi3klVyIGTv1ncDbDnlTLy9W273D1YfGHJ7s4AsqY5j+F+opdboPHQ6Sh77w
 u8ozWKeGRVZEPXRgQUy0us+zHDdR4OmcVGSRDTlKxYOf/Mp6bPcxI8RQFXNgfsn6ETHg
 r1Vmq9YkXryPJn0SqN/SddQIEMFzA+QOcUzzXrzMlHQCwlxiVTWkTrNx/DY6Wh6OZ6Tk
 MBUxPdhC8xShOAOVLj/qjI8wgqyGJp8f/8SyJgMywK0D6Y1rCJqJS1BWW/cL9YkQi016
 tHTX4EpzgG4s3ZHIETUCWmaWmB/np4U5GMnA/JqzDcb9EE5B5am8YTOMSv/QrMRPqKRw
 +FSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777295806; x=1777900606;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Ez+m/Pp3FoKDsSjZqsPsJp65wBlWOPg9kLMbj+KHSE=;
 b=ZpdJzUQdHvizhZa0W7a8T94+UN6IxknuvcEQnC8jPKnYzzhVKsfGL4milEOvRCs5vE
 0Ny7vJWqVCPVS59MnCqC1RRvDyzsSOw4QUoqxoHZuhK+c4qOhJXCX2xqqsWPhpdQbifQ
 FrVFTsbkAf6l8IUUtwx/ofBtwhlyHJNhs/e50Eq0Rhc76AUS9ZcEV4vaAYo112y/wL1m
 4e5N1eXD6VEHB0Nzp46l+zO5alL4DHbydqRiMPnZrsiyUJ4YiLPA6nRkmphZLhnxljKp
 t6czXYRXIvnV+h+9J32oEyY8qoxN44RJ23GjU1UOfchRkiS/tgD3ToN58BJTdVei/bng
 8b+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ823hL5qJRrHCkKZIqL2+xW8mA+77KLTeZbs9KIB3xD35JljDTCxp75x0zDtp4Io0GTsMe04bLsMms=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzVM3bhytUzFpPevYsENM2gFVZat1ClHPVWjvBjULtSspdXO67a
 Aez3IfBWEQ27w9FoA0ippnt9/m+x/+o/0dTe51XHsb0yuutsznjKJZIpOugRHz/s22Va/IB2bu3
 Uu49xfasJ72uO2MfkpMnxNUvjfg3TEQ==
X-Gm-Gg: AeBDietbMHmlGlKRMDVaCwcyKdiTJpP487LkJtYzZXr+TsPgmjgJGN/5OGGfW9qEvJb
 tLNuf/AW3cyCjOmfX1TZKEz9xVgMaoVGPNiZl/FCkuXVdAUfJfZvbVxZhDj20a3zK2zj+FRf6ua
 Vs3R89Wjbq6I4NjQlQKZ+jitg/UReSbR9Bwuxxcy9tyikf1wlxHizmwHkzecGvbywQRibv0I2jp
 PikF3OIaucU9BlktAp36M5nGmJsOHfzYdoHcuPg0caQTEYx6cMhgJ/pXzYd8gHs1X63kktQhSOo
 vvuwePPzRJ9/2/fUe2VBbjCeZOH/FsvEoFNoHipOpUluAI09okMgfipzlw==
X-Received: by 2002:a05:6402:c4f:b0:670:ef2a:217e with SMTP id
 4fb4d7f45d1cf-672bfbff5f4mr18786057a12.0.1777295805962; Mon, 27 Apr 2026
 06:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260424121206.14558-1-mhun512@gmail.com>
 <DI3YHHC57ZD8.4FCLYJZ8YU19@bootlin.com>
In-Reply-To: <DI3YHHC57ZD8.4FCLYJZ8YU19@bootlin.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 27 Apr 2026 22:16:29 +0900
X-Gm-Features: AVHnY4K-7aIoLTtljVW2w-j64x6ZOS7Ncpg-tfBrYJvWYyALgDBAnVTrISmkJLc
Message-ID: <CAGEsz8E1679jzn7MhLKsQKzUZXAVxrDfQqaBDMB53fHTy1OY-Q@mail.gmail.com>
Subject: Re: [PATCH] drm/sti: hda: Fix bridge leak on component_add() failure
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Alain Volmat <alain.volmat@foss.st.com>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000002cdfcd065070ed67"
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

--0000000000002cdfcd065070ed67
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Luca,

Yes, this is a duplicate. I missed Osama's patch when preparing mine.

Please ignore/drop my patch, and sorry for the noise.

Thanks,
Myeonghun

2026=EB=85=84 4=EC=9B=94 27=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 10:02, =
Luca Ceresoli <luca.ceresoli@bootlin.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:

> Hello Myeonghun,
>
> On Fri Apr 24, 2026 at 2:11 PM CEST, Myeonghun Pak wrote:
> > sti_hda_probe() registers its bridge before adding the component. If
> > component_add() fails, probe returns the error directly and leaves the
> > bridge registered.
> >
> > The remove callback unregisters the bridge, but remove is only called
> > after a successful probe. Remove the bridge locally when component_add(=
)
> > fails so the probe error path matches the successful-probe remove path.
> >
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
>
> Duplicate of [0]?
>
> [0]
> https://lore.kernel.org/all/20260423200622.325076-1-osama.abdelkader@gmai=
l.com/
>
> Luca
>
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

--0000000000002cdfcd065070ed67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Luca,<br><br>Yes, this is a duplicate. I missed Osam=
a&#39;s patch when preparing mine.<br><br>Please ignore/drop my patch, and =
sorry for the noise.<br><br>Thanks,<br>Myeonghun<br></div><br><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">2=
026=EB=85=84 4=EC=9B=94 27=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 10:02, L=
uca Ceresoli &lt;<a href=3D"mailto:luca.ceresoli@bootlin.com">luca.ceresoli=
@bootlin.com</a>&gt;=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">Hello Myeonghun,<br>
<br>
On Fri Apr 24, 2026 at 2:11 PM CEST, Myeonghun Pak wrote:<br>
&gt; sti_hda_probe() registers its bridge before adding the component. If<b=
r>
&gt; component_add() fails, probe returns the error directly and leaves the=
<br>
&gt; bridge registered.<br>
&gt;<br>
&gt; The remove callback unregisters the bridge, but remove is only called<=
br>
&gt; after a successful probe. Remove the bridge locally when component_add=
()<br>
&gt; fails so the probe error path matches the successful-probe remove path=
.<br>
&gt;<br>
&gt; Signed-off-by: Myeonghun Pak &lt;<a href=3D"mailto:mhun512@gmail.com" =
target=3D"_blank">mhun512@gmail.com</a>&gt;<br>
<br>
Duplicate of [0]?<br>
<br>
[0] <a href=3D"https://lore.kernel.org/all/20260423200622.325076-1-osama.ab=
delkader@gmail.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kern=
el.org/all/20260423200622.325076-1-osama.abdelkader@gmail.com/</a><br>
<br>
Luca<br>
<br>
--<br>
Luca Ceresoli, Bootlin<br>
Embedded Linux and Kernel engineering<br>
<a href=3D"https://bootlin.com" rel=3D"noreferrer" target=3D"_blank">https:=
//bootlin.com</a><br>
</blockquote></div>

--0000000000002cdfcd065070ed67--
