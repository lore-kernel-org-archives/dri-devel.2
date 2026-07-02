Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFE3C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45C6410E58F;
	Fri,  3 Jul 2026 07:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XR5hJwoN";
	dkim-atps=neutral
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com
 [209.85.222.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 550C310E16C
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 17:11:33 +0000 (UTC)
Received: by mail-ua1-f49.google.com with SMTP id
 a1e0cc1a2514c-966d70b9e1cso1218858241.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 10:11:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783012292; cv=none;
 d=google.com; s=arc-20260327;
 b=BWxzzdYyzEX1gZzQfQIdqMx/O4WRyyxBrBWglJSoma+dTkzYKeEQPAXN0W4Iu0UzHB
 iSnFl2OdW0VroPyu4mLY/2iMGPlHTQ28LxeSxFO0Mfld6M4rz5kHZbgaIkUqfNxiOfZu
 EgCKafsOxSkkgKNRytqjeCUOMAKm22Ja2EDPXHVeya6Hs812z3WdwBNEt+t2DZWC+X1t
 MVzDFd8tlJBOn2Kna/h+TAGMujzdBI86REZQTFr9xwQ+I36JlagArVCgx4q1wD+O2sLX
 YHSGfHwn4vYzNG7sMpSmoYAveg0H2WOIK4DozTnilgnXQYnTXPW2uR5ioldphI5x08j8
 DOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xT24BOKILPClevCNHWgQxdCLW2n9JQ1bqT7flNRwYzc=;
 fh=SI74a/gGeUQBCRe1p4PRWixmH9HF2wbFBNTUg/t3vDw=;
 b=Cgxk5+X6Lm+dwTKk8YF10FncYMpIoJP10jdziR5ZMH37e+Kj+B18+PBH0ixrsak1kx
 ozpbCqDBgWRZ3htfISdU78pNc7fnfIs8fYbS7O9Em1ZYdILXk181ep160cLcIdJB9iCt
 7mTtAXx2fXXmA7bVI6WiVUE0uwG4CXGJb2XIxAN2CVtHs07GnSXtgJtT0fEGIRZ+zkVB
 WO5qXRnOrXcUaVfKk0WEleM6pR3zs0QvvorXPmouIAVE0g39VyZ+wz7aNNnzyhxfbAPb
 3LCyYQMMCrQPhXyO0VduM+579Be5EaCghhMYvx0podEKuOC4qNB85+Ts9lQoepRUqMJj
 UTrg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783012292; x=1783617092; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xT24BOKILPClevCNHWgQxdCLW2n9JQ1bqT7flNRwYzc=;
 b=XR5hJwoNlnYbUUSUedzj58D7Gkwxq/SB2CMP8B9CMjr69V8qwLEeQ4N+CbpbZgi/Lp
 nef9RfjrqBCytR4IKBF0XTiHbBVv4/p0oNQtmdvA1Ky9dG94wd5HZ8XTPqINgDbhHZaV
 0aXmjANnZTu4PB/4Flo3vJpFqcVVK/5uS0iMJhVA6ndOqAIz1GPut6Dh7a1mh86zi5pC
 pOWpBoqCizBopEcuMUXD0gykgegzWxfnFy7amabnEF8UodqxJLo7DBsqRxBrPaGCJZMw
 MqRve2X1WA3rTp9AsSzZsn/u+qb8Z4nTK6yEugjARdCAfYYW2Q4Aa+Z5rrP5vtRwGXpB
 EtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783012292; x=1783617092;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xT24BOKILPClevCNHWgQxdCLW2n9JQ1bqT7flNRwYzc=;
 b=oRDKmECSjFW8kjo5Q/amjaEaG43Qsldc93mT5sd5KbrBmF3HR6i161pjYmSUWu+XvC
 Bc/qhzb+RpQd+yHi4hiXj+Ifg4lkIm+jRBeNFJ0Jlj3OZBXzcWqT6MWl0ikaq5ikS+dt
 +0b/YCpL7R8vuW9SP9YbtWT49DUWyKEK6nSRc7ZLcX3G/S+dNza0A28pqQOuWQOw3BZn
 IE4acYIUqoQguYOSirnK5zNuSWfU5CpYZQ7uU8QPHRnGws8evn4QKp147lKgH+PyxQ7g
 f4pNZgxyt0kD6suGR/556ZtXtFaXspqUnOeLzAyZrkMnwZVlAWOPZA1OVGVKxsDvbbZK
 MPgQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RryumrACPakIkAVM7tFirVO0lFEsQ3QX9XKg7OPifHvY+v9Ym4hk1gdhWeGlO3O9n2np0Dqb193ubU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKSgBucx3I98rGyw5vdAfZMEVmWigz2OA+cNTvBeVGfOX3AFyg
 UAKpS+yRozKx8OzQbLdarwmziGXoC5eAsKDg4YkrGhUzGjMyPULZrb1RZLtTOMpIXZq75SxNGZb
 5fp/9T3kUBqtBGy/UtKhe/VtpGzbzJDk=
X-Gm-Gg: AfdE7ckF3T7luPtkAWFwUVT3lJvYmTCtao1ZYo7trj44Qla/hCwieIgUngQj8zKX4M/
 Trmi6uDa4N1xhr3vQ6bkAsHsBFFiUdybBYMlcXxRTaHXuRRGzY583ggXUcl2VqyaRwkKtDjK0Ga
 foY5eN6RT9UG1lUFc5PmFCx95kXp/jHlfOWyvGlA9WsbF5ck1kUKPn8WsZqoHJVAFDn7ZV0m8jb
 6NIHAS/qgCPfkbOFZp3HSepAt5IcV/ukmLSolWXgc8KQt5B+QuC1mVj1HBHRzAjeRLf1t0=
X-Received: by 2002:a05:6102:7009:b0:73e:9fae:5845 with SMTP id
 ada2fe7eead31-73e9fae5bd4mr915588137.0.1783012291847; Thu, 02 Jul 2026
 10:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAMyXUJmSvWv0WoBqvBScEXHnz70Nn_WUcu371s64j6HrB-6c9A@mail.gmail.com>
In-Reply-To: <CAMyXUJmSvWv0WoBqvBScEXHnz70Nn_WUcu371s64j6HrB-6c9A@mail.gmail.com>
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Date: Thu, 2 Jul 2026 22:56:20 +0545
X-Gm-Features: AVVi8CdQTMC6trh0hJiTLYEEJYF_ziqLGjvSWiszf25Z51ZAMNy13LDBOyKEVlw
Message-ID: <CAMyXUJnMCW4uha1g9fhYupf+sWUiZBcpmm=xOB5ECwWLAPCNOw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: samsung-s6d16d0: Power off on prepare failure
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: inus Walleij <linusw@kernel.org>, dri-devel@lists.freedesktop.org, 
 inux-kernel@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Content-Type: multipart/alternative; boundary="000000000000492b630655a3e6c5"
X-Mailman-Approved-At: Fri, 03 Jul 2026 07:04:17 +0000
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

--000000000000492b630655a3e6c5
Content-Type: text/plain; charset="UTF-8"

Apologies, I mistyped the LKML address. I have resent the patch to the
correct address.

On Thu, 2 Jul 2026 at 22:32, Laxman Acharya Padhya <
acharyalaxman8848@gmail.com> wrote:

> If enabling tearing mode or exiting sleep mode fails after the
> regulator is enabled, s6d16d0_prepare() returns without asserting
> reset or disabling the supply. Since the DRM panel core leaves the
> panel unprepared, a later unprepare call skips the driver callback
> and the supply remains enabled.
>
> Assert reset and disable the supply before returning the DSI command error.
>
> Fixes: ac1d6d74884e ("drm/panel: Add driver for Samsung S6D16D0 panel")
> Assisted-by: Codex:gpt-5
> Signed-off-by:acharyalaxman8848@gmail.com
> ---
>  drivers/gpu/drm/panel/panel-samsung-s6d16d0.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
> b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
> index ba1a02000..04e19b5f2 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
> @@ -89,16 +89,22 @@ static int s6d16d0_prepare(struct drm_panel *panel)
>         MIPI_DSI_DCS_TEAR_MODE_VBLANK);
>   if (ret) {
>   dev_err(s6->dev, "failed to enable vblank TE (%d)\n", ret);
> - return ret;
> + goto err_power_off;
>   }
>   /* Exit sleep mode and power on */
>   ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
>   if (ret) {
>   dev_err(s6->dev, "failed to exit sleep mode (%d)\n", ret);
> - return ret;
> + goto err_power_off;
>   }
>
>   return 0;
> +
> +err_power_off:
> + gpiod_set_value_cansleep(s6->reset_gpio, 1);
> + regulator_disable(s6->supply);
> +
> + return ret;
>  }
>
>  static int s6d16d0_enable(struct drm_panel *panel)
> --
> 2.51.2
>
>

--000000000000492b630655a3e6c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Apologies, I mistyped the LKML address. I have resent the =
patch to the correct address.<br></div><br><div class=3D"gmail_quote gmail_=
quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 2 Jul 2026 a=
t 22:32, Laxman Acharya Padhya &lt;<a href=3D"mailto:acharyalaxman8848@gmai=
l.com">acharyalaxman8848@gmail.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><div dir=3D"ltr">If enabling tearing mode=
 or exiting sleep mode fails after the<br>regulator is enabled, s6d16d0_pre=
pare() returns without asserting<br>reset or disabling the supply. Since th=
e DRM panel core leaves the<br>panel unprepared, a later unprepare call ski=
ps the driver callback<br>and the supply remains enabled.<br><br>Assert res=
et and disable the supply before returning the DSI command error.<br><br>Fi=
xes: ac1d6d74884e (&quot;drm/panel: Add driver for Samsung S6D16D0 panel&qu=
ot;)<br>Assisted-by: Codex:gpt-5<div><a href=3D"mailto:Signed-off-by%3Aacha=
ryalaxman8848@gmail.com" target=3D"_blank">Signed-off-by:acharyalaxman8848@=
gmail.com</a><br>---<br>=C2=A0drivers/gpu/drm/panel/panel-samsung-s6d16d0.c=
 | 10 ++++++++--<br>=C2=A01 file changed, 8 insertions(+), 2 deletions(-)<b=
r><br>diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c b/drivers/=
gpu/drm/panel/panel-samsung-s6d16d0.c<br>index ba1a02000..04e19b5f2 100644<=
br>--- a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c<br>+++ b/drivers/gpu=
/drm/panel/panel-samsung-s6d16d0.c<br>@@ -89,16 +89,22 @@ static int s6d16d=
0_prepare(struct drm_panel *panel)<br>=C2=A0				 =C2=A0 =C2=A0 =C2=A0 MIPI_=
DSI_DCS_TEAR_MODE_VBLANK);<br>=C2=A0	if (ret) {<br>=C2=A0		dev_err(s6-&gt;d=
ev, &quot;failed to enable vblank TE (%d)\n&quot;, ret);<br>-		return ret;<=
br>+		goto err_power_off;<br>=C2=A0	}<br>=C2=A0	/* Exit sleep mode and powe=
r on */<br>=C2=A0	ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);<br>=C2=A0	if (=
ret) {<br>=C2=A0		dev_err(s6-&gt;dev, &quot;failed to exit sleep mode (%d)\=
n&quot;, ret);<br>-		return ret;<br>+		goto err_power_off;<br>=C2=A0	}<br>=
=C2=A0<br>=C2=A0	return 0;<br>+<br>+err_power_off:<br>+	gpiod_set_value_can=
sleep(s6-&gt;reset_gpio, 1);<br>+	regulator_disable(s6-&gt;supply);<br>+<br=
>+	return ret;<br>=C2=A0}<br>=C2=A0<br>=C2=A0static int s6d16d0_enable(stru=
ct drm_panel *panel)<br>-- <br>2.51.2<br><div><br></div></div></div>
</blockquote></div>

--000000000000492b630655a3e6c5--
