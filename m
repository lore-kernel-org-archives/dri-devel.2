Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0DEF8E4A4
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCBE710E199;
	Fri, 17 Apr 2026 03:22:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c/Wa0LqQ";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD6D510E199
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 03:22:17 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-672dad7f332so47188a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 20:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776396135; x=1777000935;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lhpCOevGTbKwi82urJDIx7YanRlxhUP38qs/Mq2E9Xk=;
 b=c/Wa0LqQIfQZl1sC+PtmQhsvLMEaBfwbk2BE3mI7A6EkrnlL53gzzWIntP9rmAX2Cw
 k2I6sgNp0H4hGVzjwRkLdIgixGIhwtlvDHQRtBdpo2m7qkFx9KzQkeRswaCXiCWjUrM8
 xg1a5uWP+5+xWY3Pc3g1UXOJc29L+Qa4hAt6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776396135; x=1777000935;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lhpCOevGTbKwi82urJDIx7YanRlxhUP38qs/Mq2E9Xk=;
 b=ZXIsAMFj6qP/j9cwhOXC1kiP+8lQ7eLyhr8mHHcHBhchIhx+JBTCPjNlTvyQAoGPd5
 KTcwdF35GbSIbj7+gUBJ1RdazWWNwWRx91qzBT1hDWfO4CVmfQ26WfWKbYhDf8j250lN
 PsMwiHM9/t3bBoAdYhSV+MTdS15Bsv3OQV+5fkWKM/ucndl5sbmGdg/W7xOzRDn30u2w
 oKByOvu+Bcq3iHGmpbGjRWUeaZDgRqwYQ8+ZAFWKFb2ZBTnyMRYb9bLPgOy9CsOsXPob
 C2Od/XeBILqVNwzU/NeGWJyDK5qW+WZrMxA7ZPcyQDIaxGRwFBe7AvIABe5qtc8UUOYM
 xSgg==
X-Gm-Message-State: AOJu0Ywoxphqb4EhLuMygUAFcmbO5QG2d2P+PPpBUEI2EAClrQ+WpBc6
 rNERZIVCLuMM1BCTt3rBPZqMnk0HLfLw/S5tvgA+kIRT0ijbfFC3yL7NPyqSuUMibUzUnI/sYX0
 Q0MhJzQ==
X-Gm-Gg: AeBDieuYKmZrjAA4pwncxM5dOVQhI2f71LF+sFbt3CXsXQtJYqi8O3l9SfGYxoKxkQ3
 TMroijU+V/EGFG2hxXInno8zhlcXbq/xSIVqQFvQJgMTOXBE8Q2PpBLKHHWb3xz1ffrRECFoL7i
 OsI9YdyrxoXEjBQImi+cavc8Di5hVTVRUmJRAPwGyQW+B5lIW//DbY7HKRnINkONVI8spuUkT7B
 iH/sLaxhkLEySPk+dzjj/gm4PTqdHvNOestS2rik7x5I9iGjkoFGo7P5wySuJ6+wnk8tZVghj3H
 P1f3CrPoWYksR97aeZcstjPwWpFbARI2jQCR4/A/LDmgrl17vAWdqJ2kbkg4KrIdvy0ROBM11iC
 br7bUpyS51VXe2+86uW23JbkimdaEHMrgZ7aL2xL9Cnvu/EOdxI8vxzRz3LoI60FOK1UT0WqnZ5
 lZwXgpURhuFgfuiNMmpxSwYXmojCgdCaCSpBBF7s+yNnPrZbT82ROVB/WDsPj+9ho6XdwfV6yK
X-Received: by 2002:a05:6402:1ec9:b0:670:2ca5:bcde with SMTP id
 4fb4d7f45d1cf-672bfdc9789mr517311a12.15.1776396134671; 
 Thu, 16 Apr 2026 20:22:14 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com.
 [209.85.221.54]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-672c4d455e9sm42064a12.14.2026.04.16.20.22.10
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 20:22:10 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so94658f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 20:22:10 -0700 (PDT)
X-Received: by 2002:a05:6000:288b:b0:43d:613:4036 with SMTP id
 ffacd0b85a97d-43fe3e0a9ecmr1357783f8f.37.1776396129632; Thu, 16 Apr 2026
 20:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260416073722.719036-1-avinal.xlvii@gmail.com>
 <20260416073722.719036-3-avinal.xlvii@gmail.com>
 <CAD=FV=Xu0YY8Aof2XPp2eAe+hSd7P4UaPCqVZkkox4gYNW_pTQ@mail.gmail.com>
In-Reply-To: <CAD=FV=Xu0YY8Aof2XPp2eAe+hSd7P4UaPCqVZkkox4gYNW_pTQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 16 Apr 2026 20:21:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XZweDFm7tKrEsXC4W87PRFAC_8YNBhGtG6v0vq60-FDw@mail.gmail.com>
X-Gm-Features: AQROBzB_AabLyBIBOhxRXqibCoabQ37VlllLSFRHhfuCUFiwIOIkU--o6IUiJ84
Message-ID: <CAD=FV=XZweDFm7tKrEsXC4W87PRFAC_8YNBhGtG6v0vq60-FDw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/panel: panasonic-vvx10f034n00: transition to
 mipi_dsi wrapped functions
To: Avinal Kumar <avinal.xlvii@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 neil.armstrong@linaro.org, lumag@kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch
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

Hi,

On Thu, Apr 16, 2026 at 7:51=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Thu, Apr 16, 2026 at 12:39=E2=80=AFAM Avinal Kumar <avinal.xlvii@gmail=
.com> wrote:
> >
> > Changes the panasonic-vvx10f034n00 panel to multi
> > style functions for improved error handling and
> > removes redundant error printout.
>
> nit: Linux folks generally like the "imperative" statements. So the
> above would be better as:
>
> Change the panasonic-vvx10f034n00 panel to multi style functions for
> improved error handling and remove redundant error printout.
>
> In other words, use "change" not "changes" and "remove" not "removes".
>
>
> > @@ -95,7 +104,6 @@ static int wuxga_nt_panel_prepare(struct drm_panel *=
panel)
> >
> >         ret =3D wuxga_nt_panel_on(wuxga_nt);
> >         if (ret < 0) {
> > -               dev_err(panel->dev, "failed to set panel on: %d\n", ret=
);
> >                 goto poweroff;
> >         }
>
> Now that you've removed the error printout (and thus it's a one-liner
> inside the "if" test), you need to remove the braces. Linux style
> guidelines are pretty strict about this. Hopefully it's pretty easy to
> spin a v5 with that? Otherwise, this looks fine to me.

Actually, looking at it one more time, the code should probably just look l=
ike:

ret =3D wuxga_nt_panel_on(wuxga_nt);
if (ret < 0)
  regulator_disable(wuxga_nt->supply);

return ret;

The "goto" is pretty overkill here.
