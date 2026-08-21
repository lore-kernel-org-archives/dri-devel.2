Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D57EC5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 22:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BB1110F3D5;
	Fri, 21 Aug 2026 22:16:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ImkV0cQj";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE5210F3D5
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 22:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787350567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zA1LeFPAQat9KKPEkh1443J5kCMSRDAY5hs4TF16uEk=;
 b=ImkV0cQjW14BDf+Up9L6mcYNOnXr01LUr2/eVgTKD78NBfCw9d3QcT9JcgX4lt+gZrw1g9
 bbjeOWnt+k9X3O7E/0kW07BAj+wlLe6rR54+80MuoNYRRhaXFZYHExgviugHDXKMx9xPXf
 zLwg/SZBlWj3MfI2GtGxqrLU4M2/l50=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-G8uOFvUoPquV1t22KgC7cw-1; Fri, 21 Aug 2026 18:16:06 -0400
X-MC-Unique: G8uOFvUoPquV1t22KgC7cw-1
X-Mimecast-MFC-AGG-ID: G8uOFvUoPquV1t22KgC7cw_1787350566
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90c4da3d504so9956426d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787350566; x=1787955366;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ezCmUh0WjbjOP5OmNgWXgB839nnjB9OIOQSsdtH9W/0=;
 b=UUDIfo9b7TPiN/iTFRE5EqVpqiu8YgBtP1O2vfwcaiwm6yxb+YomV50FHoCv5JMqZA
 2WGK0/PzRgPiwy9YQYd7/ypJRD2oMMPJige7DwV7mh9B3lmIO6VXHu+IndCCn4aQxjrv
 dPuPsweNu2mLjw00xIN4REkBUFKqpdcvZwR5s8lGpuSVFBF9Tl7jQYXHcJubx2NfZWP7
 6CKeiXmEPQQtTXm3cmLLEtTXrvp8hd9GdFT+da+LUvYp1gi5ejWGACVobxM0dKhyvPLC
 uGqEf4qLdmpKsP40oIwEUjOZKN40KdBQi37pX/bbimGN8qPRDtWmBuH8MTvpursyYtZ5
 XbIg==
X-Gm-Message-State: AFuF++mrW7w897xToKZjaPsESZ2I5gE6p4q63FFRQ7FYfp+A+h9Yt78J
 j56elL5Dw2qwSbmEa0OXINvfUSkQMsAX90OcdM3XUzZAg0wjp1hTqxy3plTjDW+6XTL5yb2+76T
 sab44sjp/2QXe5iyZ0cbC/9QamD9mrgp7YMIX5ueBEteQyOeXVqzhFrmkNW6wiSUKDKem+g==
X-Gm-Gg: AR+sD12NMexFJqJVqZkletUJO9sdFmEAWK5GIO025c2+ixIBzNwtmpSM1pFJbhsTJZF
 6WLWaKyyu1yHHMXxr80+q+cJtEkmGpnqKjQzpFJlqWLveuTIRNWF4b2zn4lQ3PuZiCeBlUstmsc
 V1H4d5W8EtyP0rhdnB6XjnS1003FO8m7ZLGoeRLNYqBKjoDe1jkkt7Bb+sSCtthq4UEBiOcusE+
 vrSozo+KKnQboT5X5KRGsEccpIgw6xKwxYj4S3PrhuBGs35OAnPL17lHMaXAhQG9sIxrLfFurbA
 Y5pznpJ9a5niZlSNsxOXQWhbWZG9pN1RnrIIubJFrlWf882BP+WBgD6H6TQe3LGx/snHrxIW
X-Received: by 2002:a05:6214:4a8b:b0:8f2:fbb1:cec4 with SMTP id
 6a1803df08f44-90c80c5fdf2mr88542916d6.19.1787350565825; 
 Fri, 21 Aug 2026 15:16:05 -0700 (PDT)
X-Received: by 2002:a05:6214:4a8b:b0:8f2:fbb1:cec4 with SMTP id
 6a1803df08f44-90c80c5fdf2mr88542406d6.19.1787350565414; 
 Fri, 21 Aug 2026 15:16:05 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5edb5097sm73053326d6.9.2026.08.21.15.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 15:16:04 -0700 (PDT)
Message-ID: <734e126e531e320e281361579ba8fb190bff032f.camel@redhat.com>
Subject: Re: [PATCH v2 09/10] drm/nouveau/dispnv50: program pixel clocks
 above 2.147GHz on GB20x
From: lyude@redhat.com
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Mary
 Guillemard <mary@mary.zone>, 	nouveau@lists.freedesktop.org
Date: Fri, 21 Aug 2026 18:16:03 -0400
In-Reply-To: <20260820164929.17117-10-mohamedahmedegypt2001@gmail.com>
References: <20260820164929.17117-1-mohamedahmedegypt2001@gmail.com>
 <20260820164929.17117-10-mohamedahmedegypt2001@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MkWHHFeluisPMvpdBPOl3RmMzmDNRWAB5tyvbbhU4dk_1787350566
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

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Thu, 2026-08-20 at 20:49 +0400, Mohamed Ahmed wrote:
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
> index eeaeb15aa664..678cbc78ca9f 100644
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
> +=09ret =3D PUSH_WAIT(push, 14);
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
> +=09 * (EvoSetRasterParams9()). Truncating would scan out at
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
> +=09=09=09(u32)(hz >> 31)),
> +
> +=09=09=09=09HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI_MA
> X(i),
> +=09=09=C2=A0 NVVAL(NVCA7D,
> HEAD_SET_PIXEL_CLOCK_FREQUENCY_HI_MAX, HERTZ,
> +=09=09=09(u32)(hz >> 31)));
> =C2=A0
> =C2=A0=09return 0;
> =C2=A0}
> diff --git a/drivers/gpu/drm/nouveau/include/nvhw/class/clca7d.h
> b/drivers/gpu/drm/nouveau/include/nvhw/class/clca7d.h
> index 0fec6fc21d44..5754878ddc69 100644
> --- a/drivers/gpu/drm/nouveau/include/nvhw/class/clca7d.h
> +++ b/drivers/gpu/drm/nouveau/include/nvhw/class/clca7d.h
> @@ -734,6 +734,10 @@
> =C2=A0#define
> NVCA7D_HEAD_SET_CONTROL_CURSOR_COMPOSITION_BYPASS=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0 20:20
> =C2=A0#define
> NVCA7D_HEAD_SET_CONTROL_CURSOR_COMPOSITION_BYPASS_DISABLE=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0 (0x00000000)
> =C2=A0#define
> NVCA7D_HEAD_SET_CONTROL_CURSOR_COMPOSITION_BYPASS_ENABLE=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
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
> NVCA7D_HEAD_SET_SURFACE_ADDRESS_HI_CRC(a)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0 (0x00002150 + (a)*0x00000800)
> =C2=A0#define
> NVCA7D_HEAD_SET_SURFACE_ADDRESS_HI_CRC_ADDRESS_HI=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0 31:0
> =C2=A0#define
> NVCA7D_HEAD_SET_SURFACE_ADDRESS_LO_CRC(a)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0 (0x00002154 + (a)*0x00000800)

