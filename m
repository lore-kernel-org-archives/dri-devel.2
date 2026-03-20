Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B3D1099B28
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 17:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCC7F10E1E7;
	Fri, 20 Mar 2026 17:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nKjWhvAP";
	dkim-atps=neutral
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com
 [74.125.224.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDAAE10E1E7
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 17:36:34 +0000 (UTC)
Received: by mail-yx1-f45.google.com with SMTP id
 956f58d0204a3-64ad9238d8fso3188583d50.3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 10:36:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774028194; cv=none;
 d=google.com; s=arc-20240605;
 b=NwK1hlEUpMu7KBkRm6PXNxCBAwQNTMHriwTA4z7ci5xlOi+Sr7OG8bEkA/NCbB3oT8
 Vz92NKHgAtcT5onz5Lvtaz9V7roADLWM405famYjLv0wn0g0SEGIdUQH9lQ2g1xHS5uv
 DckefLbGmR69orFfDFexLr8IelVKCtnp/lgjb6lsZ/ghv2ENFJvVTl8J77gT4FEi/nVY
 KhesqmRx80FXkkejfb9zJdOGS27DK2D+Suk+xNc4D1Ys7tsnHFVSZUXafkUiN/8dFCoR
 w7XhZtXEpqaGun/XNm+W8m+tPcFwy2pOh/E16TJcAbXRhsSyQT/OYRwOd3AHCWppE3Se
 BnQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BgGZTOzZCC8ovn7k66XyuhZliqBNi9YYaqpJPuy2zpc=;
 fh=KzWueEaHrroHBh3J8RSifCChfpnaMxYXtl/bkhz4ysE=;
 b=OXQNw7frsWGF6wIWOwQFB+bV+w+wEjIjxDLQ0f3FUH3z4ansybW5PkIwx7MOrD68va
 nU5tpNgqCrMwyLC9fx6XwePzZ4khQdHoSi81rcmIEDTBKHoY5BxYj70SIYGIva6e86Zk
 DeARCbtQ0gzsYaXJqjBda+fbrsHiaWyfo0W1jTjRH2SbmlML7+zl0B8jrakvHY6Vzqxh
 afB1/k2uijlPO/0f/XDJBxtfhhit3vpi4sfhln+ekVqoxGOkc0AnCO16Jbk9XI9U8Z5M
 PPcktYoWxnx/w5b/utblM5zNDBcs1g5slKdgN52W7/ZXJNQH62SMtfbxgsAoB/9q2+zW
 q6AA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774028194; x=1774632994; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BgGZTOzZCC8ovn7k66XyuhZliqBNi9YYaqpJPuy2zpc=;
 b=nKjWhvAPSaT3zuQMVGrpua3VamU6vnb1satxxSu70jcVV6JAEq8VyCoH0OH6IyPOuh
 A5n2nSbKsLv5wtlcw9A44XJ+jDLbDAB49M28EFttNNiAyLLgRwtLOhtnaMIxPJcsqJI7
 wSPvIGCpEfQgjVIWllXn2fSiOt+OyayVHu4VK+wCERcQh4gkBvXkj2ouu0KnwjgVuujI
 5tFujABDlFp2qWRqPa52VVIFDz+yhfZmjw6175rpyGB2M9OaoO938gxal6XRKiR5efkb
 VZ+P5RmoQBXO8w2Bii1mQZyIwWLkSZhg7o2Ih2xg43LpwtIEm7cPpFRS28J5L1GQEgQr
 Q34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774028194; x=1774632994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BgGZTOzZCC8ovn7k66XyuhZliqBNi9YYaqpJPuy2zpc=;
 b=lYNmfgnKciTzxB0TEmI32D3abPJh5zjFscadw/sgiP5zP9oL8h9d1NXurkBJxbDICt
 WmhxtDJRh1pTmdH/Xs0ZC1xZyILaXNLYkPJeA6p25Zkb1Bt25c9Ydm7bVQ4VcG+Z5bkS
 K1Xk0XNbl5r7JlZwMadM4SxZ+6nxjG2+G/6qtpZZPPPszSbU1UDLlLC1xSkKxI+jaGZT
 qb/3utYh5S2mRu2m6R1LNrTVRAgaY6LsrVMNyCHGFyjYDrgsu79f6bIzVJ5NrBRpOUKW
 AfB+OwSA0gQ/cP6F5WzfAQILQcahKBRddWJgGOngFg3HjApuCRqoeeDYQE7VB5rUKpVw
 Mbng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN4Zd4KMwuJ68GddNu68ycE2DiboyIYsWCOBEKn/qV9zFEQXtHXkUCob1zgC0kwqLMjXUxwsfwm1c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLOey75jyzQpiAePftclQhp9B/NbIPnY3069h2YpAgH9/Yw6ox
 FZ/at5IiXeUlEBpSvZ0La1+rGm4Ik4bzF+fRH+slC8YFx8dz43JkjY/MF4S1zjs01b2LNiiuos0
 3WtNg8hYo0lIKui78XK7sPD47StxJ1sw=
X-Gm-Gg: ATEYQzy1lgzo2ITAu2IZdusdDT/q08ODvflslH9KO7QIhgOrYoWdIYds/dxEhChBnay
 sFRxhEtKnDUrAqhtG71SHwMbd4arP6iGq9SL92vvk0dg8RlAIwibCYy3Y5P6j4WG7OlDukegs9I
 CMF/hEmS7QcN2aio+rk2VR0/wHKhKeIjT7S1NovkX49rxM0ObjVc24zr1aVONd2J78oVUfc6wAn
 fhekevVnlepKdIpHL0xOda9VOYH5UV2DNiLgIxN0yzK9i3pTD40DDBZd8M97bDZVEQrxlfMrtfw
 bw/O
X-Received: by 2002:a53:bb08:0:b0:64c:9c10:c09 with SMTP id
 956f58d0204a3-64eaa7b37demr3014158d50.51.1774028193589; Fri, 20 Mar 2026
 10:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-17-jim.cromie@gmail.com>
 <177402491432.6181.1032037030316089534.b4-review@b4>
In-Reply-To: <177402491432.6181.1032037030316089534.b4-review@b4>
From: jim.cromie@gmail.com
Date: Fri, 20 Mar 2026 11:36:07 -0600
X-Gm-Features: AaiRm523rwSycvdGB1zaTykXeTcT9kD3zP9a6PiLV5_LFsq_fGCRDaXzKyLP7BM
Message-ID: <CAJfuBxy4Tqg5nsgLHgYFEX0F=3h_XkSD5skmy+GypoTBwB+a1w@mail.gmail.com>
Subject: Re: [PATCH v11 16/65] dyndbg,
 module: make proper substructs in _ddebug_info
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com, 
 gregkh@linuxfoundation.org, mripard@kernel.org, tzimmermann@suse.de, 
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com, 
 ville.syrjala@linux.intel.com, christian.koenig@amd.com, 
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com, 
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
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

On Fri, Mar 20, 2026 at 10:41=E2=80=AFAM Louis Chauvet
<louis.chauvet@bootlin.com> wrote:
>
> On Fri, 13 Mar 2026 07:19:41 -0600, Jim Cromie <jim.cromie@gmail.com> wro=
te:
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debu=
g.h
> > index 9fd36339db52..b84518b70a6e 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -83,30 +83,42 @@ enum class_map_type {
> > [ ... skip 3 lines ... ]
> > -struct ddebug_class_map {
> > -     struct module *mod;
> > -     const char *mod_name;   /* needed for builtins */
> > +struct _ddebug_class_map {
> > +     struct module *mod;     /* NULL for builtins */
> > +     const char *mod_name;
>
> mod_name is not needed for builtins anymore?

it is needed still for builtins, because the mod ptr is null,
which can supply mod_name for loadable modules.
I can restore the comment if you think its still helpful / not redundant.

>
> > @@ -125,8 +137,8 @@ struct ddebug_class_param {
> >   */
> >  #define DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, ...)          \
> >       static const char *_var##_classnames[] =3D { __VA_ARGS__ };      =
 \
> > -     static struct ddebug_class_map __aligned(8) __used              \
> > -             __section("__dyndbg_classes") _var =3D {                 =
 \
> > +     static struct _ddebug_class_map __aligned(8) __used             \
>
> Maybe a dumb question: in a previous patch you added ALIGN(8) for the sam=
e
> __section, both are really needed?

its a different macro, so I think it is needed.
Note that the macro is deprecated, and will be removed
as soon as DRM uses are dropped.

>
> >
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index cb7bfe8729a7..f47fdb769d7a 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -1254,18 +1255,18 @@ static void ddebug_attach_module_classes(struct=
 ddebug_table *dt, struct _ddebug
> > [ ... skip 13 lines ... ]
> >               }
> >       }
> >       if (nc) {
> > -             dt->num_classes =3D nc;
> > +             dt->info.maps.len =3D nc;
> >               vpr_info("module:%s attached %d classes\n", dt->mod_name,=
 nc);
>
> IIUC, maps and classes are the same thing, can you do a s/classes/maps/ i=
n
> the vpr_*?

yes - class_maps is probably clearest - closest match to code too.

>
> --
> Louis Chauvet <louis.chauvet@bootlin.com>
