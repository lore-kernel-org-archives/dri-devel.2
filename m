Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F57E9905B
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:08:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 474B710E8F8;
	Fri, 10 Apr 2026 09:08:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fzHgRldb";
	dkim-atps=neutral
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C563310E8F8
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:08:13 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5a1307438ddso1851779e87.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:08:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775812092; cv=none;
 d=google.com; s=arc-20240605;
 b=CAYwv99OtVDMTdfLy4IzOPiLzyXHUfxEimIp8uJEhm+rJCWL4oq1JzppT4xQkRlgVh
 W9TJ1hNXYMEecQ5+99gH3sdTT1qQoORPLHmJFFJDRlyBGGPWYDAX/0iiKDog0+utCRca
 x7VhftVXSafsKhhnCR+TNWUFqujYXEjP+Td5hRbdn9CdvScGY1eCttIxS1NgC5HPRzPe
 T6UN9UjWqHcZxBnYfSVlBA/7gd5/81E+wcQNdqKFG6ocn+DLPEqf3E8fwNT+vEa1T0de
 Qtw+3WgoBJG0r6EJIOsoqJ6nbt0gB7n3vSwh6HeXek+JHyNg9OABw9djI3NQ2YRABEoP
 +NWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4mpr+O877RyDaAEHH++T90brhjPNCoL8JH7g4a94jH8=;
 fh=fuclAB2XFHyJyNgKEWPRyvucLjXB0jwrkdRQqZsNxRA=;
 b=PxgcpMNUVozWPo8EsfFl7uY+27MQBnr+kWtZTmNnPBtChSqL1e2gjaXtC1gi8gqWk3
 gGRWYpMhjYkiBcNcWovIkq2tTFOr1yG+YF9NJpKPsYkhsgF3f0GQ7fpJ8s+Z78iiTqqV
 NqU5aQUQkYklLUQF2mL+nOmBpPxvOILqtNBgvUs+FCrULjsouV6VSxEd3PkxJYIfobCt
 Om/Gn+71EJhjjjkjROD9dMR2k8VEO6wyLpvVgnX9RlGkSybD3vqDichPmGI9w0CQTqh/
 zjm+6/uVfmeTXJzaAHvcRjCfmeUZiOc20VmiXZRQRrXTo/leWrg0qL79W6qkzwgLwYtf
 6AMg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775812092; x=1776416892;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4mpr+O877RyDaAEHH++T90brhjPNCoL8JH7g4a94jH8=;
 b=fzHgRldbwGBqmFLHltb0EgFRHXSRjXro7Tk1lhPtDw8OK9AU5DlZVTFFpvsYwNLF2R
 9mxE6UJC6CXh2W2m7slvXT4SugAW39oqXqrr3vwqDhuX4Re3zueNqXPGjE6yyrcM/rS4
 fnZVdutUMZybF/wM72pgaxeUW5QeORX+qvCgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775812092; x=1776416892;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4mpr+O877RyDaAEHH++T90brhjPNCoL8JH7g4a94jH8=;
 b=XQfBmoAd6A/bWtLz25ZYAKjwvQLmRpnPYpcK8ZI1aaQVP3mqSwuyNGFoZs6VrBWHuw
 6hIZrvBoOFaJ5DHpxLlJXmYwvbuU5bd4ar0r9ZTkQKDNB0Yt6f25ntj2a+0aZvAmpHUa
 d4sXSR4pTg4T4JL7KlwHAMOMJfFqlVdjYKOllDe2NvbzDx6LdDlcVgxM7T9grFy03S75
 BHCYiJmFkcVeSCzN9oS43BsbHLKLNGeNBQNCbOL50zJKnn2cC6EMLsbmTjGxAanZHesZ
 +BBDFZ/JXqk9tC8lKYLLoueR3TGQWLCaJS0BiUocOjbiB5rCp7lQN9ptAu6lM76hCl7b
 +4xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA2Vbd8oMqDL/DiOrBu786/M6uv7z0N0viHQ7+yNUoWjo/jjqz5drfxU+uHwHcpko9U8iN6E5qx58=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVwSWvpt+/kiw95KFZkrhWCpfEgTxt4rNCCEI2+LIJ0vv0OhVo
 WeJZih1dg0J38uqH9Z9SAH6sfMnoBdhq9NxLkMMmJQeHG3GiPXtm9S0QEoeNInzNsflpP1+g6ZR
 d1XsV/yyNnMTkIH0my44bp/M95QPeoOzE6JtHkHbl
X-Gm-Gg: AeBDievV/T/t8HhCvOKgc6KL1PZvFmd8+FnjdWaf6wdC0VZSg8nGvsKj5BLAH6dXoa2
 takbHXSYIoYafYUwU9lzO5e+yIZbWhDC8zQp1czfHPxiQZ7+zoHgCk/9pmHRKynQswFR6K7uIgg
 Ay6fCk+FWhpmiRM/Bo8E4lYeKNLrwBRgUCUF604wkMjsNvR0dDVqcGd/0qGKxYo+WxacUfm1ywd
 H+uc6U3CX8BPwx9S6DBDkEAY7985EL/NLY2oWdO0ejYBj7mmxmAN7BDnWFrY9rwt28Xnghhy5KY
 aFQ8KN9cjGGB8f7f4P9Xb+wApbu6G8sNd2V0iA==
X-Received: by 2002:a05:6512:68e:b0:5a2:ae27:c879 with SMTP id
 2adb3069b0e04-5a3efd7f0d8mr813480e87.29.1775812091658; Fri, 10 Apr 2026
 02:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260408081430.1712335-1-wenst@chromium.org>
 <386241e0-3d1b-43cc-8bc0-b6d35a97ba89@ideasonboard.com>
In-Reply-To: <386241e0-3d1b-43cc-8bc0-b6d35a97ba89@ideasonboard.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 10 Apr 2026 17:08:00 +0800
X-Gm-Features: AQROBzDHoryQW57CycqS4Hz44-tts1nMbyk8iKy8CYinfLuJDjMcY65lViFj3Bw
Message-ID: <CAGXv+5HjX3FagZs5K+Z=PYQWt2a92My6wgG+ZXKh140w3Hz-QA@mail.gmail.com>
Subject: Re: [PATCH] drm/xlnx/zynqmp-dpsub: Fix dependencies for COMPILE_TEST
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
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

On Fri, Apr 10, 2026 at 4:49=E2=80=AFPM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> Hi,
>
> On 08/04/2026 11:14, Chen-Yu Tsai wrote:
> > The zynqmp-dpsub driver does not have build time dependencies on the PH=
Y
> > or DMA drivers. These are runtime hardware restrictions.
> >
> > Group the two dependencies with ARCH_ZYNQMP so that the driver can be
> > compile tested without them.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > IMO the two driver dependencies could be removed altogether, but that
> > would be up to the driver and platform maintainers.
> > ---
> >   drivers/gpu/drm/xlnx/Kconfig | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/xlnx/Kconfig b/drivers/gpu/drm/xlnx/Kconfi=
g
> > index cfabf5e2a0bb..4c6729459f40 100644
> > --- a/drivers/gpu/drm/xlnx/Kconfig
> > +++ b/drivers/gpu/drm/xlnx/Kconfig
> > @@ -1,10 +1,8 @@
> >   config DRM_ZYNQMP_DPSUB
> >       tristate "ZynqMP DisplayPort Controller Driver"
> > -     depends on ARCH_ZYNQMP || COMPILE_TEST
> > +     depends on (ARCH_ZYNQMP && PHY_XILINX_ZYNQMP && XILINX_ZYNQMP_DPD=
MA) || COMPILE_TEST
> >       depends on COMMON_CLK && DRM && OF
> >       depends on DMADEVICES
> > -     depends on PHY_XILINX_ZYNQMP
> > -     depends on XILINX_ZYNQMP_DPDMA
> >       select DMA_ENGINE
> >       select DRM_CLIENT_SELECTION
> >       select DRM_DISPLAY_DP_HELPER
>
> I think the above looks more difficult to understand than the current
> version. We should perhaps rather drop the dependencies. But if we go
> that way, then... we can also drop DMADEVICES, DMA_ENGINE, GENERIC_PHY
> at least.

Perhaps. All the APIs for these are properly stubbed, so I guess
they also count as runtime dependencies.

> What problem does this solve? Why are these two dependencies bad for
> compile testing, but the other dependencies/selects are ok?

I was build testing changes across multiple DRM drivers in addition to
the main platform I work on. Having to find and select each dependency
was annoying.

I would say DMADEVICES and GENERIC_PHY are much more common to embedded
devices than SoC specific drivers.

> I personally don't mind hard runtime dependencies expressed in the
> Kconfig, as searching for the correct dependency-drivers when your
> driver doesn't probe is always a PITA.

I don't mind it either. But the way they are described means that compile
testing is overly dependent on having some other platform specific
driver enabled.


I suppose another way to write this would be:

    depends on ARCH_ZYNQMP if !COMPILE_TEST
    depends on PHY_XILINX_ZYNQMP if !COMPILE_TEST
    depends on XILINX_ZYNQMP_DPDMA if !COMPILE_TEST
    ...

Does that work for you?


Thanks
ChenYu
