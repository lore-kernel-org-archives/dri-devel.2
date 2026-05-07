Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FA5CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 15:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3979E10E599;
	Thu,  7 May 2026 15:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Ct+6HzBj";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C94510E599
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 15:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778166689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jg2qgfD0OqkXFXgYbKBXkeRs+ZtWNb2X0OhEpORYsP8=;
 b=Ct+6HzBjlGDDj4cOqd5bVyoKFq3zYVZ8s1TBMr79Hcvps/eeZ/B3/z5iv4HmKsqaajN1ot
 Y5czZA3O3Lys9rUc+Xj27XSybVR4PV8+8oL2HnFslf6AUOOYWuQbkX0mNaORCdqkmKNf2Z
 pi9c2SxO/YiE6eIM0XKV9XG4QlN7BOQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-KEzgOp4tMeeMuZRNhcStKQ-1; Thu, 07 May 2026 11:11:27 -0400
X-MC-Unique: KEzgOp4tMeeMuZRNhcStKQ-1
X-Mimecast-MFC-AGG-ID: KEzgOp4tMeeMuZRNhcStKQ_1778166687
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-7bd6f72e5aeso19064367b3.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 08:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778166687; x=1778771487;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jg2qgfD0OqkXFXgYbKBXkeRs+ZtWNb2X0OhEpORYsP8=;
 b=H3llE5eo5JJeas1WcM9c4bWsC142U3ZrlzvmTvY9jCGlLu8ml3/YkfwE64Jyw4ktdY
 EI4BbC6SBCIS9Top6ksz7qoN4vUPksYbmpfIE43aNjAa1j7CnpOt5C/E/6xePqATXE3V
 TpZvBw7DjmEcAtsVh2vsMOln0A86aIv3HE4rayTZMMSa8ZdjCqPmeOVFcMAGN98ruswN
 bJKLuJr3fb6THP27WsADLtgN6bC6YZePg3LunYhuEsIGshtv+PNAnr93t7GUGmGZsnSY
 twPcuqdZFTcDdSxS4Gq8/7QcSswaq9pS1R58tVx4pyPqgRXI78L6e7i4MiZmSZm7TprF
 SjFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7e3XTB5Jn2xj4FJQyLnZPBd8i6Br5yaOXo1zVro7ox7gCkv3J3ELyebUx0bD1bGoT4guCoKnccf0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxagINX63wBhmlQXI+fTBOXhenId8iKwXhx0LZ+Hi7SRAUT/XN9
 nu2Tppkj47DvRNG7xVQvBCiNbqn/wNOBqz4bTpvm1nsa+U5DKRrLz0/4fO8VqlCTlGdxvXmQZjq
 OGSBXfGU6pu46+clfHgsEdmF1OdZttPVA3Kf2r33ddPTA3PDo9d317CZnLIznazMk6nQTJ7e0oD
 PebIwAN0YjLSRMbVnRuyUkGbQ7bUMQVEpFc9FFkiXIsiH2
X-Gm-Gg: Acq92OEprtxAyq1rz4prBqUAP/oQQrO6SiS4j9t98PuE8/1g4byr1QZictNl199ThRC
 hZz5fT8oHBmoGdUXanyWez5f3YDWwVLQF9txAnXJLcEbeF3hzjkdS/NIqvA4pfIovFrvaoa12oV
 GrjRGYaQA01WWEv6QwoIJyJbDbGVnR0ZIzbpjg5QDWdMg1BjwBDT0gQ5bMabrptxOIbv+xzd/mw
 /8kiVmYM3RH4JxX
X-Received: by 2002:a05:690c:c96:b0:7bf:373:1701 with SMTP id
 00721157ae682-7bf03732287mr39410057b3.21.1778166687067; 
 Thu, 07 May 2026 08:11:27 -0700 (PDT)
X-Received: by 2002:a05:690c:c96:b0:7bf:373:1701 with SMTP id
 00721157ae682-7bf03732287mr39409217b3.21.1778166686433; Thu, 07 May 2026
 08:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260507-drm_panel_init_rm-v1-0-51f448c7c291@redhat.com>
 <20260507-drm_panel_init_rm-v1-10-51f448c7c291@redhat.com>
 <20260507-premium-curious-macaw-d43cbe@houat>
In-Reply-To: <20260507-premium-curious-macaw-d43cbe@houat>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 7 May 2026 17:11:15 +0200
X-Gm-Features: AVHnY4IthqHS32CYQM7xKJoq7ItlTkbdhK_0LmennaRXHl6ofPqtxaj0XPLbuko
Message-ID: <CADSE00+UN3wgsJnfCn3CLB3h-RnR-FLLfAOY3UhDyCOmt5HTKA@mail.gmail.com>
Subject: Re: [PATCH 10/10] drm/panel: Make drm_panel_init() static
To: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Michael Tretter <m.tretter@pengutronix.de>, Michael Walle <mwalle@kernel.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M129QD68nTlRH9PeqTV_wqByqdLnCEgQobk7R6rIj64_1778166687
X-Mimecast-Originator: redhat.com
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

On Thu, May 7, 2026 at 4:57=E2=80=AFPM Maxime Ripard <mripard@kernel.org> w=
rote:
>
> Hi,
>
> On Thu, May 07, 2026 at 01:53:08PM +0200, Albert Esteve wrote:
> > Now that all panel drivers use devm_drm_panel_alloc(),
> > there are no external callers of drm_panel_init().
> > Make it static to prevent new users from bypassing the
> > refcounted allocation path.
> >
> > Remove stale references to drm_panel_init() in kdocs.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  drivers/gpu/drm/display/drm_dp_helper.c | 2 +-
> >  drivers/gpu/drm/drm_panel.c             | 8 ++++----
> >  include/drm/drm_panel.h                 | 4 ----
> >  3 files changed, 5 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/=
display/drm_dp_helper.c
> > index a697cc227e289..380ebf0fad2be 100644
> > --- a/drivers/gpu/drm/display/drm_dp_helper.c
> > +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> > @@ -4626,7 +4626,7 @@ static const struct backlight_ops dp_aux_bl_ops =
=3D {
> >   * Backlight will then be handled transparently without requiring
> >   * any intervention from the driver.
> >   *
> > - * drm_panel_dp_aux_backlight() must be called after the call to drm_p=
anel_init().
> > + * drm_panel_dp_aux_backlight() must be called after devm_drm_panel_al=
loc().
> >   *
> >   * Return: 0 on success or a negative error code on failure.
> >   */
> > diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> > index d1e6598ea3bc0..e3e1c5ceb8ff8 100644
> > --- a/drivers/gpu/drm/drm_panel.c
> > +++ b/drivers/gpu/drm/drm_panel.c
> > @@ -56,8 +56,9 @@ static LIST_HEAD(panel_list);
> >   * Initialize the panel structure for subsequent registration with
> >   * drm_panel_add().
> >   */
> > -void drm_panel_init(struct drm_panel *panel, struct device *dev,
> > -                 const struct drm_panel_funcs *funcs, int connector_ty=
pe)
> > +static void drm_panel_init(struct drm_panel *panel, struct device *dev=
,
> > +                        const struct drm_panel_funcs *funcs,
> > +                        int connector_type)
> >  {
> >       if (connector_type =3D=3D DRM_MODE_CONNECTOR_Unknown)
> >               DRM_WARN("%s: %s: a valid connector type is required!\n",=
 __func__, dev_name(dev));
> > @@ -69,7 +70,6 @@ void drm_panel_init(struct drm_panel *panel, struct d=
evice *dev,
> >       panel->funcs =3D funcs;
> >       panel->connector_type =3D connector_type;
> >  }
> > -EXPORT_SYMBOL(drm_panel_init);
> >
> >  /**
> >   * drm_panel_add - add a panel to the global registry
> > @@ -708,7 +708,7 @@ EXPORT_SYMBOL(devm_drm_panel_add_follower);
> >   * A typical implementation for a panel driver supporting device tree
> >   * will call this function at probe time. Backlight will then be handl=
ed
> >   * transparently without requiring any intervention from the driver.
> > - * drm_panel_of_backlight() must be called after the call to drm_panel=
_init().
> > + * drm_panel_of_backlight() must be called after devm_drm_panel_alloc(=
).
>
> I think we can drop that sentence entirely. Now that we can only get a
> panel structure through devm_drm_panel_alloc, and that it also
> initializes it, we can't call drm_panel_of_backlight before having an
> initialized drm_panel.

Makes sense, I will remove the sentence and send a v2. It probably
follows the same reasoning, but just to ensure you did not miss it:
does that apply to drm_panel_dp_aux_backlight() above too?

>
> Maxime

