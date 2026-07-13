Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B969EC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D1C810E370;
	Mon, 13 Jul 2026 12:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="MRr5xfs8";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22DC410E370
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783947052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5514gjBH+tEva2wlfuCJ1QoRwC/nd/W+ENw0Fx/t/Q=;
 b=MRr5xfs8JbqwBwQmA80k4+B7fecNNVx5NmxK9rkN43kYbgm+g10RCrS5h6tlI6S8sTGZ4x
 HQnBHx5mCdPmHIs8TJoz+X/FeIf3SKFA/kzYbPdLY4Fh9rSMMbjYjEQel2h9w9hBqJqPvG
 MfApWoFQCOB1Odt7M5BO2YQw7b/q0IA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-6pJnExEyPOu4Qi-MI7ni0w-1; Mon, 13 Jul 2026 08:50:49 -0400
X-MC-Unique: 6pJnExEyPOu4Qi-MI7ni0w-1
X-Mimecast-MFC-AGG-ID: 6pJnExEyPOu4Qi-MI7ni0w_1783947048
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-80ee3cb097eso93278817b3.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783947048; x=1784551848;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y5514gjBH+tEva2wlfuCJ1QoRwC/nd/W+ENw0Fx/t/Q=;
 b=EEYJzspBv+dqJ915c6r8KosgLRsZ2x4C23WcCcUKSIFRGYKPVPege9+wY+cFroQuax
 0zjEoJnBP4x7QL9BOJOuO/4kYLJvrsSdy5cDW6np6Sdz7A+dgVxa6jtMkTEm6OAJhZOs
 6fkl8fzibTSy92yoxS4ls2GZCljcrOutPB03Oyl7Xo0JfM6yYjv9CSXA5dP4+4XKfHG+
 mQzJNVpqtJDqty4hCO3JLUeiQ43BAhcMcEiEPCJT0X4VqcIx76yeS7EvOThQKyMWPstl
 4B8tBbK/oFu8ldx/KXQfp5Lcbyur+N5V4xQW9zyTqZ1d73rNGjXRGOr1iFX7OvEfx+0u
 t0DA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGvMu5IGu1mkAKwy++92J6fqH3uOfaVyV4eodniOlHLq3MQILICFctD8cV0BfB/SSJjadJybp1Ok8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzm748zGWGBH5uMH1WJ9DK5vlSv58j/NQGExiT8fGbQLSBPzsCG
 g40wT0qLpSXzrvwEGoRDM99zRbiELkhtXmjA1tbMGA+FS9q4t3W++KxGh7EGbiYEA9cpbdy1akH
 pe3xYjgy/IAsg4q1HmvHaVZIYEGCGelhxCvssFzLLKJBlrfH5ePNEnbLKG47b0Npq2Vt0X9QZQb
 WSkseYHqXkcTqCm2jVxtFqQTKAhEeTCpFy71tU/86cWHd+
X-Gm-Gg: AfdE7cm152+VgdiXNqCQ2IQpPea2uzBYHwjUp8YXX6ioMtc67ALtnzVmYMIYPhvMEgl
 5GvgSoYINbtA/akkFsGJWSi6czxINTL7ufZLKeL5TrJXbm350A0cVzDByLOdGdazyI/4Z7zlhc/
 oDNRRRkFC40T1YIheNTFar12Dar4HF63UuMuo82tJhVx/AWkL5r1j/3Mwl1bMl6vvYSkU=
X-Received: by 2002:a05:690c:688a:b0:81e:8988:a76e with SMTP id
 00721157ae682-81e9013f452mr69897657b3.50.1783947048367; 
 Mon, 13 Jul 2026 05:50:48 -0700 (PDT)
X-Received: by 2002:a05:690c:688a:b0:81e:8988:a76e with SMTP id
 00721157ae682-81e9013f452mr69897527b3.50.1783947047964; Mon, 13 Jul 2026
 05:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-drm_refcount_wiring-v2-0-d3bb61f4bd4d@redhat.com>
 <20260713-drm_refcount_wiring-v2-4-d3bb61f4bd4d@redhat.com>
 <20260713120850.50A971F000E9@smtp.kernel.org>
In-Reply-To: <20260713120850.50A971F000E9@smtp.kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 13 Jul 2026 14:50:36 +0200
X-Gm-Features: AUfX_mxIjyD9JT7DCnH8TLnCNyM1WFtSvLQWD-3yymdZrL3l4dLm3EqYUh3A3BM
Message-ID: <CADSE00KCw_dA89NcKg-9zLf-HLhy=ASZyDrAk+15ko_eyowOUg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] drm/panel: find_panel_by_fwnode() return a counted
 reference
To: sashiko-reviews@lists.linux.dev
Cc: linux-sunxi@lists.linux.dev, Frank.Li@kernel.org, imx@lists.linux.dev, 
 wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sWiIy7K7v_H4nww5OLInYGQBYLmmkwrAENliQw5fKj4_1783947048
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

On Mon, Jul 13, 2026 at 2:08=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [Medium] Drivers calling of_drm_find_panel() directly leak the returned=
 panel reference.
>
> Pre-existing issues:
> - [High] TOCTOU race in drm_panel_add_follower() when acquiring the panel=
's underlying device, leading to a potential Use-After-Free of panel->dev.
> --
>
> --- Patch [4]: [PATCH v2 4/5] drm/panel: find_panel_by_fwnode() return a =
counted reference ---
> commit 5cd4c479944cf29f6f5aa4a3e31207bf48dc0567
> Author: Albert Esteve <aesteve@redhat.com>
>
> drm/panel: find_panel_by_fwnode() return a counted reference
>
> This commit updates find_panel_by_fwnode() to return a refcounted pointer
> to the panel, mirroring a similar fix made to of_drm_find_panel(). It cal=
ls
> drm_panel_get() under the panel_lock before returning, ensuring the memor=
y
> is not freed prematurely. Callers are now responsible for balancing this
> with drm_panel_put(), which is added to drm_panel_remove_follower().
>
> > diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> > index 72cf86253c0cd..a00ae98ed0956 100644
> > --- a/drivers/gpu/drm/drm_panel.c
> > +++ b/drivers/gpu/drm/drm_panel.c
> > @@ -542,7 +542,13 @@ int of_drm_get_panel_orientation(const struct devi=
ce_node *np,
> >  EXPORT_SYMBOL(of_drm_get_panel_orientation);
> >  #endif
> >
> > -/* Find panel by fwnode. This should be identical to of_drm_find_panel=
(). */
> > +/*
> > + * Find panel by fwnode, returning a counted reference.
> > + *
> > + * Behaves identically to of_drm_find_panel(). On success the returned
> > + * pointer has been passed through drm_panel_get(); the caller must ca=
ll
> > + * drm_panel_put() when done with it.
> > + */
>
> [Severity: Medium]
> Since the earlier patch in this series updated of_drm_find_panel() to
> also return a counted reference, do drivers that call it directly need
> to drop their reference to prevent a memory leak?
>
> For example, in bridge drivers like lvds-codec.c:
>
> drivers/gpu/drm/bridge/lvds-codec.c:lvds_codec_probe() {
>     panel =3D of_drm_find_panel(panel_node);
>     of_node_put(panel_node);
>     ...
>     lvds_codec->panel_bridge =3D devm_drm_panel_bridge_add_typed(dev, pan=
el,
>                                                 lvds_codec->connector_typ=
e);
> }
>
> Because devm_drm_panel_bridge_add_typed() takes its own reference to the
> panel via drm_panel_get(), does this code leak the initial reference
> returned by of_drm_find_panel() since drm_panel_put() is never called?
>
> This same leak pattern appears to exist in other callers as well, such as
> samsung-dsim.c:samsung_dsim_host_attach() and
> rcar_du_encoder.c:rcar_du_encoder_init().

Uh this is a real issue that I missed in several callers. I will add
drm_panel_put() after the bridge creation where needed in the next
version.

BR,
Albert.

>
> >  static struct drm_panel *find_panel_by_fwnode(const struct fwnode_hand=
le *fwnode)
> >  {
> >       struct drm_panel *panel;
> > @@ -554,6 +560,7 @@ static struct drm_panel *find_panel_by_fwnode(const=
 struct fwnode_handle *fwnode
> >
> >       list_for_each_entry(panel, &panel_list, list) {
> >               if (dev_fwnode(panel->dev) =3D=3D fwnode) {
> > +                     drm_panel_get(panel);
> >                       mutex_unlock(&panel_lock);
>
> [Severity: High]
> This is a pre-existing issue, but is there a time-of-check to time-of-use
> race condition when callers attempt to pin the underlying device?
>
> When find_panel_by_fwnode() (or find_panel_by_dev()) returns, the panel's
> internal refcount is incremented under panel_lock, but the underlying
> struct device (panel->dev) is not pinned.
>
> If a concurrent unbind occurs before the caller pins the device, the devi=
ce
> memory could be freed. For example, looking at drm_panel_add_follower():
>
> drivers/gpu/drm/drm_panel.c:drm_panel_add_follower() {
>     panel =3D find_panel_by_dev(follower_dev);
>     if (IS_ERR(panel))
>         return PTR_ERR(panel);
>
>     get_device(panel->dev);
> }
>
> If the panel device driver unbinds immediately after panel_lock is droppe=
d,
> could get_device(panel->dev) trigger a use-after-free on the destroyed
> device?
>
> >                       return panel;
> >               }
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-drm_refc=
ount_wiring-v2-0-d3bb61f4bd4d@redhat.com?part=3D4
>

