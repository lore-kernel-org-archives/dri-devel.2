Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E36CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 10:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E0C310E1A0;
	Fri,  2 Oct 2026 10:31:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lCoAw7aH";
	dkim-atps=neutral
Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com
 [74.125.228.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 407F310E1A0
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 10:31:51 +0000 (UTC)
Received: by mail-ed2-f34.google.com with SMTP id
 4fb4d7f45d1cf-6aae1f2cedfso10019704a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 03:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790937109; cv=none;
 d=google.com; s=arc-20260327;
 b=Tlzhq77gD9PZtoPk/zkNh9Wae7J6VnfRY4GCkOChGadNVZviGIx+BzhvFncMK8wdD7
 CdMbm0n1+KdPoMNHwgtgpCvFueUdspueWMZVZIGr+81cDRuzZxrr4tf8Dv3Iz1qtIs4O
 Mjywba7/s45DkB/5hDW85F0X94XIvpEr2RKJgP/WQXQ5aG0dNteZFuSLSEtEbEzNycTW
 TMDpZNrGG5QqO42FwSmYUs8yAe+/InuOecBpi8iTIhYl95XlGFYQbY8L5WxCUFktL+K0
 I0O13fju5Xi9MNT1jRb27766KLQBEZW9nXM5Z0AWUbgvOEkcfTQnrA81pQpXsFideL0S
 P3WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=64r7ulkEn38K4zwS5C600ZIxGpt8NqYtlKiQJ/l1vMU=;
 fh=3HAXi0k7bgefj0yxtf+4VzI5R+70ZEBjBb1NTg2PPVo=;
 b=s3iuLaIe9euoHWeYbjzHqIHzEgmRTGyudZP3v022JncPylIKVOlGXgtoWxEkeXvkJy
 Nb1DL/2d/Nexl1xU/7KIpEa0k9LRhLapGkH93MjgIfee15LUiNuMfG6X4YbVOP2IXd+0
 9Tb75S3FO/foq6+++9fNhC3cTE2BhwcGR9yHMGcIVfiQNJzUU96YhUwramV7ySuF3JOo
 2ziM8spNJD1Df0ad/TIbntB0K7XsadqPrv28plC+od2kqc8hto68nDNC9JBLDIyT9kBp
 /aIONrGcSqdDbHJgE3JHb10ZxmbSbl6gM3phIHDQJO1xJ95wbLki5BvnYZdYEcUS4piR
 cPrw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790937109; x=1791541909; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=64r7ulkEn38K4zwS5C600ZIxGpt8NqYtlKiQJ/l1vMU=;
 b=lCoAw7aH5Lyf2XtTrEY92x8kxDaUc17GIkcLE2GlT/gNdRtMCH3sAsB8qK04Vw7I0e
 eT1A9O20D5CZY0pW6G7fLdX6mZUQMXHT+esHHBzoYb6aRRzoghfNtZeTKZRHbqo1JIT4
 U4PX3g0oHHwbilI+sVBCSoNZuU2nh1pVxgEpEtXC913WGl4xdGttDhenRQ3zWKmVoo7q
 7AKlWdvN6xqmjIPougmRjr0Iu+CSQhrbDZO/k34sde4ILwypJjrpe/33dhY7hHP+dwaa
 yr2TdoUNzFoxdpfX/PHUmzBYAcNd2r/wtwHrupaKfJfNjjCvYT+xFO30xni+U6gF0Try
 /AfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790937109; x=1791541909;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=64r7ulkEn38K4zwS5C600ZIxGpt8NqYtlKiQJ/l1vMU=;
 b=lKPLaddAXqdiDo4YThsinASkacuX1HxO3ETS8fMC2z6cApplb9fnj5bc2Ie4JT6G6J
 DC5LytLLPYFvzRyMQ4uP4P1oP2jELoaUh+MxF0jJHSwPlBqOiH7JGSPYNdXv/dVFRf4O
 R/DgGcmPlEXxSzEIrF5l0kp4gOMgvgFUpPBkBZviZ0plI8iD4O4XE8ID26bFribO78Jx
 fmpXWOIQwZdfLjQVxqzdMeeZSrwAc6srHCuidZBADAq8UftDpQQgclfExRMnwPKkVZm4
 AX1hiZOLVAI1XFRjCz+84sEhlEtViF1l4cI7btnCFTNagds8cJmv7AbcXuVMYMTlYvhK
 zhZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByr4EgOXiU7SgaOu7TfUNUmz09T42E/ztoDz5lt8s8W/qAQc0o1kLvvzKxP/Ff1p3ORqqVcqUkHhls=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLutjSCAzrOd/dnO5GAcuZFeCrfpuw67JJfA9gYvjf8yOgooDeh
 nc+o+dyRyYFapgEa//eBNn0yOz45PmNOMEaKVWdgVDGV2BDH14NjaeASGLSJOO5D5jeqRuVfymj
 5QVbf9cc02IhUU8TOLbJql3A4lI6EoGw=
X-Gm-Gg: AYBFou02ijVxAXevBGnsekWSC7epVycNW7LFDgzgEUrUso4KxvKI3QQlebhTj3N8I1s
 D8Z4EgOPrJlQL9+dwR21aMh1V9T6JqFJJANm0dYGRJGeSWayhDp0hR0TRJhgT5idDofpny7s6ti
 ImJ2QaWlNTufy+Ch9lhk58o0YjQi5f41zAMrm+4nb1drlrIk33IL1u+rum0rr6019KAcdq6yXqy
 dlJ4qJ6MwhARZJ0BViVCGPjtrKsTWh62DsJMlLrLXPFsqq1bzGz4WhqYkaE3AaIcsNQ8ps7DlhY
 0uK6FI1zsJmcKKN6YYkyU9jtWlBs950p9dUK3LspWOZ872rUcb3xcGI=
X-Received: by 2002:a05:6402:350c:b0:6aa:9f93:e991 with SMTP id
 4fb4d7f45d1cf-6af9e04df50mr1455052a12.3.1790937109250; Fri, 02 Oct 2026
 03:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20261001195847.141192-1-maximpedraza@gmail.com>
 <20261001195847.141192-3-maximpedraza@gmail.com>
 <5c92c6f27b0778124d2365603374f70bd9b69b8d@intel.com>
In-Reply-To: <5c92c6f27b0778124d2365603374f70bd9b69b8d@intel.com>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Fri, 2 Oct 2026 12:31:37 +0200
X-Gm-Features: AclHuK-AO31UUSmBIVotodEDTlpk8vgR8uy4aHoyOWv0oRmO6rDUZemULA1RRgQ
Message-ID: <CAEUXW=GKRstrsZniQSU0un6r--a2VrRjpZCe5meUyyxunJ-E7w@mail.gmail.com>
Subject: Re: [PATCH RFC v4 02/13] efi: bgrt: export the BGRT table and image
 size
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Ard Biesheuvel <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Francesco Valla <francesco@valla.it>, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org, 
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

Hi Jani,

On Fri, 02 Oct 2026, Jani Nikula wrote:
> Data is not an interface.
>
> If these will be used more, perhaps it would be better to wrap access to
> them in functions? I think most of the time it will help with
> maintenance.
>
> And you can add stubs for CONFIG_ACPI_BGRT=3Dn where they belong,
> i.e. include/linux/efi-bgrt.h instead of drm_splash.c like in patch 11
> of this series.

Agreed, and the same goes for your comment on patch 3. For v5 I would
replace the export with accessors in efi-bgrt.c, stubbed in
efi-bgrt.h for CONFIG_ACPI_BGRT=3Dn:

      bool efi_bgrt_has_image(void);
      phys_addr_t efi_bgrt_image_address(void);
      size_t efi_bgrt_image_size(void);
      u8 efi_bgrt_status(void);
      u32 efi_bgrt_image_offset_x(void);
      u32 efi_bgrt_image_offset_y(void);

The splash client then drops its own wrappers and stubs, and the
"static inline" in drm_splash.c go as well.

drivers/acpi/bgrt.c is the only other user of bgrt_tab and
bgrt_image_size. I can move it to the accessors too, so that both
variables become static, if that is wanted; otherwise they stay
global for it and are no longer exported.

Ard, this changes the patch you acked, so I will not carry your
Acked-by unless the above works for you. Both variables become
__ro_after_init either way, as you asked.

Thanks,
M=C3=A0xim

El vie, 2 oct 2026 a las 11:37, Jani Nikula
(<jani.nikula@linux.intel.com>) escribi=C3=B3:
>
> On Thu, 01 Oct 2026, M=C3=A0xim Pedraza Padilla <maximpedraza@gmail.com> =
wrote:
> > The DRM splash client reads the boot graphics the firmware left behind
> > through bgrt_tab and bgrt_image_size. Built as part of drm_client_lib,
> > which can be a module, it then fails to link:
> >
> >   ERROR: modpost: drivers/gpu/drm/clients/drm_client_lib.ko: symbol 'bg=
rt_tab' undefined!
> >   ERROR: modpost: drivers/gpu/drm/clients/drm_client_lib.ko: symbol 'bg=
rt_image_size' undefined!
> >
> > Export both. They are filled in once, early in boot, and only read
> > after that.
> >
> > Reported-by: Mario Limonciello <mario.limonciello@amd.com>
> > Closes: https://lore.kernel.org/dri-devel/5d7067de-97b7-4232-9cf6-e4b97=
8696482@amd.com/
> > Assisted-by: Claude:claude-opus-5-5
> > Signed-off-by: M=C3=A0xim Pedraza Padilla <maximpedraza@gmail.com>
> > ---
> >  drivers/firmware/efi/efi-bgrt.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/firmware/efi/efi-bgrt.c b/drivers/firmware/efi/efi=
-bgrt.c
> > index 1da451582812..746a8fb3a337 100644
> > --- a/drivers/firmware/efi/efi-bgrt.c
> > +++ b/drivers/firmware/efi/efi-bgrt.c
> > @@ -17,7 +17,10 @@
> >  #include <linux/efi-bgrt.h>
> >
> >  struct acpi_table_bgrt bgrt_tab;
> > +EXPORT_SYMBOL_GPL(bgrt_tab);
> > +
> >  size_t bgrt_image_size;
> > +EXPORT_SYMBOL_GPL(bgrt_image_size);
>
> Data is not an interface.
>
> If these will be used more, perhaps it would be better to wrap access to
> them in functions? I think most of the time it will help with
> maintenance.
>
> And you can add stubs for CONFIG_ACPI_BGRT=3Dn where they belong,
> i.e. include/linux/efi-bgrt.h instead of drm_splash.c like in patch 11
> of this series.
>
>
> BR,
> Jani.
>
>
> >
> >  struct bmp_header {
> >       u16 id;
>
> --
> Jani Nikula, Intel
