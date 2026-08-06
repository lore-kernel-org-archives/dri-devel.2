Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DE7C5AC7C
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E326810F271;
	Thu,  6 Aug 2026 17:33:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SRfF5P1Y";
	dkim-atps=neutral
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com
 [209.85.221.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 896B810F271
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:33:38 +0000 (UTC)
Received: by mail-vk1-f177.google.com with SMTP id
 71dfb90a1353d-5c2c46a428eso1729090e0c.2
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786037617; x=1786642417;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L3hOBtdzHRpZ6fPHLdtPlTyiqQUdzJ0UMEjS17aB5OQ=;
 b=SRfF5P1YBvMODY0++sEcT+chZjFIflV+2rrYMcNFDrWuAsj6wSfdbCCz3fsi1+kB5Z
 Irok3ReNEm0xT3xW2dNxpho7idBpiaIzAmhSBTTZBAqQVP1H/XBj7TgiVMFkom+AoRwv
 +O7+HYWpe8yBkbkZo9NfEWDK8JhNDxSPYoQbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786037617; x=1786642417;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L3hOBtdzHRpZ6fPHLdtPlTyiqQUdzJ0UMEjS17aB5OQ=;
 b=slMaCrd3ROisr4nxfZsJbryS+5wz/ZGtkRQdvAb2ZZ6ywBrdeUTSixwtAtfvPaaanL
 +ccgvNPFSj9SN/oBnlWM+iihaZTJaiDFkY68AhoP2nqxwTJbkv65eKAGTKhtPxPAts2K
 FcySYDH1CHZ0CNJKoEnAKgSvqiYzRtOg4PFW9nAw1EY+1v/fZts1vPIyTdWFD7sKQm+e
 ELBe+5ztCKg4y1VFQoVgLErvKEd+r/NEhUYRfMgltNeDFkL5uS0ElQ47Cso24rE2iXjo
 ujZ1CbnLK55ULTB35vjd+J6cYYcLjHBBAGkGcDNQC8AyTMyOhhsaXA8TIM5ztqRd2koo
 /Glg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpDk/xSqpDh0kcl1hobZMDGWa4HYXttFGE4/WIduHnwBfAsZyYmZn4/hN1zl9+psYa/DBpfJG/L9QM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcBCESdkNNmz5dZp9nriUTmCUjWs+mBmIN4g5Y8G+KT/v8t3N8
 VTilGQD1iY3B+0QnDuGJVrlYKjyB6a7GJxhLGDth53gF6wPg/h4wny4lyp2Kyb4aAXrS/DSLgvQ
 wPEc=
X-Gm-Gg: AR+sD11UEdFAvJhd3G3NzfHfGLCkXE5BvQgJxpSTTzb6JQ/wsxq27P7M53oWoCIxs1z
 D5NVwbl4vzG4D482DW7qdtVqpga1r/IHFbgK5NwDnO7srlssrrwc1Dob1mbZ+Hm/qGcoVQnBmht
 6Zq2mrLgnmcTr7nq3gXFox2OvtrIOi2YMJ0RFiVAL+WJiSCHtNVxCSuZMcC8B8K8Pe8ip79byZ7
 WYVfRAgJx20jE0ExuLgVOR9or5nDkS1yK/zqNPdy2OyMgtZM7mWk6805D3TDS8bqt7Ad6NcFLxd
 UIiCiBXrG2Vau27RSvG/F5mI5gh62TP3A9df8sKbCV4M1ZHjsDz14pQQs/Cx7IclFTiGfxTHegN
 pbkEC61RKZ8ErO8wL4nWNtTvFVZDq1TCYc4lWS5tNiDwSKuuhgg16qzFRfulNDE9ZLnxTy77yB2
 iWd9r2P0w7MgdkuoAZ5K/FIFA/LVQ24c7rE5DDrvHqpAZY879erV/VpjzVr14Zhy7zc20d/KQEC
 La/RYUy93dtelfMJ8p3zT4XJRA=
X-Received: by 2002:a05:6122:1310:b0:5c2:cffc:2c55 with SMTP id
 71dfb90a1353d-5c3d8d4f5b8mr2836036e0c.0.1786037617121; 
 Thu, 06 Aug 2026 10:33:37 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com.
 [209.85.217.41]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c3d0942436sm3752151e0c.18.2026.08.06.10.33.34
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 10:33:36 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-73a442f7cd3so1510958137.3
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 10:33:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5A7/5OXrq+8khh2gt6Ebtn8OkbLsLnzETN6dS+IRwQDQROx5svMlWeyiaWBmdFS8SyV6fxyQ5gtk=@lists.freedesktop.org
X-Received: by 2002:a05:6102:2b95:b0:739:15ef:cdfb with SMTP id
 ada2fe7eead31-760e71d3d87mr5383902137.5.1786037613644; Thu, 06 Aug 2026
 10:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260730-mipi-dsi-tl070wsh30-multi-v3-1-60592caef4f4@gmail.com>
 <CAD=FV=U-qLBzkPDGPQ6N1ADbnNSM=tDx9ktt2bxmmreZ12228w@mail.gmail.com>
In-Reply-To: <CAD=FV=U-qLBzkPDGPQ6N1ADbnNSM=tDx9ktt2bxmmreZ12228w@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 6 Aug 2026 10:33:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WKkbLX-J9wncxQgNTxxBEFezNKE+EFb-MgLY-APJfMpw@mail.gmail.com>
X-Gm-Features: AUfX_mwqyIQ91aGDNNX6xpfgICcpkMfZJfCD62SsvvuYXEneTDKT6jBUCXpru7o
Message-ID: <CAD=FV=WKkbLX-J9wncxQgNTxxBEFezNKE+EFb-MgLY-APJfMpw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/panel: tdo-tl070wsh30: Use mipi_dsi_*_multi(); fix
 minor bugs
To: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Fri, Jul 31, 2026 at 11:05=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Hi,
>
> On Thu, Jul 30, 2026 at 5:11=E2=80=AFPM Akash Sukhavasi
> <akash.sukhavasi@gmail.com> wrote:
> >
> > The mipi_dsi_dcs_*() functions used by this driver are deprecated in
> > favor of their _multi() counterparts, as noted in
> > Documentation/gpu/todo.rst. The _multi() variants record the first
> > error in a context structure and skip every later call once an error
> > is set, so the return value no longer has to be checked after each
> > command. They also log their own failures, which makes the per-call
> > dev_err() calls redundant.
> >
> > Convert prepare() and unprepare(). prepare() uses mipi_dsi_msleep()
> > for the delays between DSI commands. unprepare() uses plain
> > usleep_range() so the delays run unconditionally after the
> > accumulated error is cleared. The delays in the GPIO reset sequence
> > stay as plain msleep() and usleep_range(), since they run before any
> > DSI transaction.
> >
> > unprepare() now disables the regulator unconditionally and returns 0.
> > Previously a failure of set_display_off() was logged and the sequence
> > continued, while a failure of enter_sleep_mode() returned early,
> > leaving the regulator enabled and the panel unable to be brought back
> > up, since drm_panel_unprepare() skips panel->prepared =3D false on
> > error. The accumulated error from set_display_off() is cleared so
> > that the delay and enter_sleep_mode() are still attempted, preserving
> > the original fall-through behavior. Both drm_panel_prepare() and
> > drm_panel_unprepare() return void, so the error was never propagated
> > to a caller in any case.
> >
> > Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
> > ---
> > Changes in v3:
> > - Update subject line to reflect the minor bugfixes, per Doug's review.
> > - Pack blank lines in both functions per Doug's review.
> > - Preserve the original fall-through behavior in unprepare(): clear
> >   accum_err after set_display_off() so the delay and enter_sleep_mode()
> >   are still attempted even if display off fails.
> > - Link to v2: https://lore.kernel.org/r/20260727-mipi-dsi-tl070wsh30-mu=
lti-v2-1-f47b937631d3@gmail.com
> >
> > Compile tested only, no hardware available. checkpatch and a W=3D1 buil=
d
> > are clean.
> >
> > Changes in v2:
> > - unprepare() disables the regulator unconditionally and returns 0,
> >   per Sashiko's review on v1. Returning an error left panel->prepared
> >   set, so the panel could not be prepared again.
> > - Link to v1: https://lore.kernel.org/r/20260725-mipi-dsi-tl070wsh30-mu=
lti-v1-1-69160b83982e@gmail.com
> > ---
> >  drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 40 +++++++++-----------=
--------
> >  1 file changed, 12 insertions(+), 28 deletions(-)
>
> Looks good to me.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> Even though it has some minor fixes, I'll still probably put it in
> "drm-misc-next" rather than "drm-misc-fixes". That gives us extra bake
> time, which is especially good since the fixes are all based on code
> inspection.
>
> I'll plan to apply in ~1 week unless something comes up.

Pushed to drm-misc-next:

[1/1] drm/panel: tdo-tl070wsh30: Use mipi_dsi_*_multi(); fix minor bugs
      commit: 263728b4c4d03dbed2e6106cccd24626d682b6cb
