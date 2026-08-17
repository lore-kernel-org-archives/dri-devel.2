Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBACDC5DF7D
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 22:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4427610E97D;
	Mon, 17 Aug 2026 22:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="HunY6l9R";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB7ED10E97D
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 22:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787006630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ATd3N86kFiVuE8vda+2rIGOUQB1M9XIX53mjLf5o6e4=;
 b=HunY6l9RcqxjMa6cQvvQqhnXy0piaHiqLY9Ly3azPxwCy5i1XFb/6zbjbXLvscGodjHgK3
 2lzTt2ljBiAAZoYSQvC4mvfFcESXtpeiqonOWChVOZhIcFkDpRDtl+oJadiwnJVzHnaHpk
 5cVCruvFZV5zQke4H2xabJCWbRmd1UA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-aeq9AQF0Mmq9p15-CHJ0hA-1; Mon, 17 Aug 2026 18:43:38 -0400
X-MC-Unique: aeq9AQF0Mmq9p15-CHJ0hA-1
X-Mimecast-MFC-AGG-ID: aeq9AQF0Mmq9p15-CHJ0hA_1787006618
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c26012cd0so37580301cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787006618; x=1787611418;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iBb4GI1JETzGycaeth8GVu7eys17B4CdM2QImPbvCqs=;
 b=bE5RV0z/rUo49yITL42vx0Jlh+gKWCG03a1qWuL6fOcmTiIchFPQoVxphswccxhfzI
 at77zYy8q53uWJZ9ajUJDUZItb/mpLFN9ZVsAGZ45tgsHHjfWbyylMe1xJuyLIO8qTg4
 ISfJXq5XsMF4s0wyc8Ju46B6fQ8WmyVvTOaLuP5WmHxy3W4kDy2+ge9m7QY7nur7Dob+
 ezzumbIg2AHO5uDeI06tSJm5823I6rBzitcCBKQYuiXBA24skJsexOApQ4vk630A0nVb
 jHNu9GWhmv2+MMWnAS4keAj9EeZfXQZtKbua7AG7TBcAP4FC+QpcCPmlb/ZPyyPGkobS
 0RWQ==
X-Gm-Message-State: AOJu0YxWoQdIy7TrwtGo14F4J66Ak8+LxvJ7DVjJc6OhNW24Q+MNzvQg
 kXmVh/DvorkY0X84pI1s7akBy+pmhR+r2BY7vKcG8s186zvqdoXbKT6QsvVmSrbWc173RcKo9FV
 svZU+sIRyO6rqkvlbDtqkt+0LL6URj+FwArsJ5IyoSg7/kIqIISGuwhjYL9iFe8/YjZ2gTg==
X-Gm-Gg: AR+sD12mSVhbJ9YQPP6stmWFHfjT2BuCinejzwWoFIvmmXn6cvcsNZaQ2S2B1LY8KqQ
 eUOMSvurgNdkJMeSZ36XCNinm4wEcgLoJ6jqlmSSzcwlwSCe5MZU9uqzuqGI3PHbv5+RNdj7TKa
 voERE1D6GYwgGf9Dk52ndYjy84bx4BeXkwik6mgP4OOIwDht+P1cC9F2SDC0vL61ae522XS5C8w
 uYeK6ivrYremuf/na8koWNzViw4fkB4z69I5dVYY8ULh2jtlEIinLr/6DSDkF6VkF77MrnmY0k7
 ZDvNPk+0P4IvLC5FKMpBAY3d7EHux/hW1TmduLxqYfcnzxu+l7Z/IuTb90Au8fFyoHN35p6f
X-Received: by 2002:a05:622a:1aa1:b0:51c:1117:c7c with SMTP id
 d75a77b69052e-52d85439e1cmr283996081cf.25.1787006618166; 
 Mon, 17 Aug 2026 15:43:38 -0700 (PDT)
X-Received: by 2002:a05:622a:1aa1:b0:51c:1117:c7c with SMTP id
 d75a77b69052e-52d85439e1cmr283995771cf.25.1787006617649; 
 Mon, 17 Aug 2026 15:43:37 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c4593369csm18934786d6.29.2026.08.17.15.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 15:43:36 -0700 (PDT)
Message-ID: <71b8aaed1153fe1b5562db4dd395bb205f04d0ec.camel@redhat.com>
Subject: Re: [PATCH 6/7] nouveau/dispnv50: program pixel clocks above
 2.147GHz on GB20x
From: lyude@redhat.com
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Mary
 Guillemard <mary@mary.zone>, 	nouveau@lists.freedesktop.org
Date: Mon, 17 Aug 2026 18:43:35 -0400
In-Reply-To: <20260814235705.59132-7-mohamedahmedegypt2001@gmail.com>
References: <20260814235705.59132-1-mohamedahmedegypt2001@gmail.com>
 <20260814235705.59132-7-mohamedahmedegypt2001@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EL1JmUl2tuwLJJaeg7x_DO7HTxtmyqrBW6569Cb0qY8_1787006618
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

On Sat, 2026-08-15 at 03:57 +0400, Mohamed Ahmed wrote:
> The HEAD_SET_PIXEL_CLOCK_FREQUENCY(_MAX) methods carry only 31 HERTZ
> bits. Starting with C97D the upper bits live in separate
> HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI(_MAX) methods, which nouveau never
> programmed and headca7d_mode() computed m->clock * 1000 into the 31-
> bit
> field. NVVAL's mask then silently truncates anything past 2^31 Hz,
> which
> means that every mode scanned out at pclk modulo 2^31.
>=20
> No mode nouveau can currently commit crosses the boundary (an
> uncompressed HDMI FRL mode tops out around 1.78GHz at 8bpc), but this
> is
> a prerequisite for the upcoming DSC work, which makes 2.147GHz+ modes
> reachable.
>=20
> Program the full value split across the low and HI methods, exactly
> as OpenRM's EvoSetRasterParams9() does (nvkms-evo4.c, 31-bit low word
> plus the 4 HI HERTZ bits, giving 35 bits of range).
>=20
> Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/headca7d.c=C2=A0=C2=A0 | 21 ++++++=
++++++++++-
> --
> =C2=A0.../drm/nouveau/include/nvhw/class/clca7d.h=C2=A0=C2=A0 |=C2=A0 4 +=
+++
> =C2=A02 files changed, 22 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/headca7d.c
> b/drivers/gpu/drm/nouveau/dispnv50/headca7d.c
> index eeaeb15aa664..2046e38a4d79 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/headca7d.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/headca7d.c
> @@ -219,10 +219,11 @@ headca7d_mode(struct nv50_head *head, struct
> nv50_head_atom *asyh)
> =C2=A0{
> =C2=A0=09struct nvif_push *push =3D &head->disp->core->chan.push;
> =C2=A0=09struct nv50_head_mode *m =3D &asyh->mode;
> +=09const u64 hz =3D (u64)m->clock * 1000;
> =C2=A0=09const int i =3D head->base.index;
> =C2=A0=09int ret;
> =C2=A0
> -=09ret =3D PUSH_WAIT(push, 11);
> +=09ret =3D PUSH_WAIT(push, 15);

This can be 14, see below

> =C2=A0=09if (ret)
> =C2=A0=09=09return ret;
> =C2=A0
> @@ -245,11 +246,25 @@ headca7d_mode(struct nv50_head *head, struct
> nv50_head_atom *asyh)
> =C2=A0=09PUSH_MTHD(push, NVCA7D, HEAD_SET_CONTROL(i),
> =C2=A0=09=09=C2=A0 NVDEF(NVCA7D, HEAD_SET_CONTROL, STRUCTURE,
> PROGRESSIVE));
> =C2=A0
> +=09/* The FREQUENCY methods carry only 31 HERTZ bits; the upper
> bits
> +=09 * of anything past 2.147GHz live in the HI methods
> +=09 * (EvoSetRasterParams9()). Truncation here scans out at
> pclk modulo 2^31.
> +=09 */
> =C2=A0=09PUSH_MTHD(push, NVCA7D, HEAD_SET_PIXEL_CLOCK_FREQUENCY(i),
> -=09=09=C2=A0 NVVAL(NVCA7D, HEAD_SET_PIXEL_CLOCK_FREQUENCY,
> HERTZ, m->clock * 1000));
> +=09=09=C2=A0 NVVAL(NVCA7D, HEAD_SET_PIXEL_CLOCK_FREQUENCY,
> HERTZ,
> +=09=09=09(u32)(hz & 0x7fffffff)));
> =C2=A0
> =C2=A0=09PUSH_MTHD(push, NVCA7D,
> HEAD_SET_PIXEL_CLOCK_FREQUENCY_MAX(i),
> -=09=09=C2=A0 NVVAL(NVCA7D, HEAD_SET_PIXEL_CLOCK_FREQUENCY_MAX,
> HERTZ, m->clock * 1000));
> +=09=09=C2=A0 NVVAL(NVCA7D, HEAD_SET_PIXEL_CLOCK_FREQUENCY_MAX,
> HERTZ,
> +=09=09=09(u32)(hz & 0x7fffffff)));
> +
> +=09PUSH_MTHD(push, NVCA7D,
> HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI(i),
> +=09=09=C2=A0 NVVAL(NVCA7D, HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI,
> HERTZ,
> +=09=09=09(u32)(hz >> 31)));
> +
> +=09PUSH_MTHD(push, NVCA7D,
> HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI_MAX(i),
> +=09=09=C2=A0 NVVAL(NVCA7D,
> HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI_MAX, HERTZ,
> +=09=09=09(u32)(hz >> 31)));

These last two PUSH_MTHDs can be combined since each mthd comes one
after the other:

PUSH_MTHD(push, NVCA7D, HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI(i),
=09  NVVAL(NVCA7D, HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI, HERTZ,
=09=09(u32)(hz >> 31)),

=09  =09=09HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI_MAX(i),
=09  NVVAL(NVCA7D, HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI_MAX(i),
=09=09(u32 hz >> 31)));

That also lets you go from 15 to 14 in the PUSH_WAIT above.

> =C2=A0
> =C2=A0=09return 0;
> =C2=A0}
> diff --git a/drivers/gpu/drm/nouveau/include/nvhw/class/clca7d.h
> b/drivers/gpu/drm/nouveau/include/nvhw/class/clca7d.h
> index 0fec6fc21d44..1ab12d91c9d9 100644
> --- a/drivers/gpu/drm/nouveau/include/nvhw/class/clca7d.h
> +++ b/drivers/gpu/drm/nouveau/include/nvhw/class/clca7d.h
> @@ -653,6 +653,10 @@
> =C2=A0#define
> NVCA7D_HEAD_SET_PIXEL_CLOCK_FREQUENCY_MAX_ADJ1000DIV1001=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0 31:31
> =C2=A0#define
> NVCA7D_HEAD_SET_PIXEL_CLOCK_FREQUENCY_MAX_ADJ1000DIV1001_FALSE=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0 (0x00000000)
> =C2=A0#define
> NVCA7D_HEAD_SET_PIXEL_CLOCK_FREQUENCY_MAX_ADJ1000DIV1001_TRUE=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0 (0x00000001)
> +#define
> NVCA7D_HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI(a)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0 (0x000020C0 + (a)*0x00000800)
> +#define
> NVCA7D_HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI_HERTZ=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0 3:0
> +#define
> NVCA7D_HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI_MAX(a)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0 (0x000020C4 + (a)*0x00000800)
> +#define
> NVCA7D_HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI_MAX_HERTZ=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0 3:0
> =C2=A0#define
> NVCA7D_HEAD_SET_HEAD_USAGE_BOUNDS(a)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
> =C2=A0=C2=A0 (0x00002030 + (a)*0x00000800)
> =C2=A0#define
> NVCA7D_HEAD_SET_HEAD_USAGE_BOUNDS_CURSOR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0 2:0
> =C2=A0#define
> NVCA7D_HEAD_SET_HEAD_USAGE_BOUNDS_CURSOR_USAGE_NONE=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
> =C2=A0=C2=A0 (0x00000000)

